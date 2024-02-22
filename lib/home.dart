import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences shared;
  late ValueNotifier<int> counter;
  late SharedPreferences share;
  
  @override
  void initState() {
    super.initState();
    counter = ValueNotifier<int>(0);
    _loadCounter();
  }
  Future<void> _loadCounter() async {
    share = await SharedPreferences.getInstance();
    int storedCounter = share.getInt('counter') ?? 0;
    counter.value = storedCounter;
  }
   Future<void> _incrementCounter() async {
    counter.value++;
    await share.setInt('counter', counter.value);
  }
   Future<void> _deleteCounter() async {
    await share.remove('counter');
    counter.value=0;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[100],
          title: const Text('Counter_App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ValueListenableBuilder<int>(
                valueListenable: counter,
                builder: (context, value, _) {
                  return Text(
                    value.toString(),
                    style: const TextStyle(fontSize: 24),
                  );
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('Increment'),
                  ),
                 
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _deleteCounter,
                    child: const Text('Delete'),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ValueNotifier<int>>('_counterNotifier', counter));
  }
}