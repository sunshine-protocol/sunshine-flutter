import 'package:flutter/material.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/sunshine.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375,
      height: 812,
      allowFontScaling: true,
    );
    // Dismis the keyboard
    FocusScope.of(context).unfocus();
    return BaseWidget<HomeViewModel>(
      onModelReady: (model) => model.checkIfHasAccount(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            if (model.isBusy)
              const CircularProgressIndicator()
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 38.w.toDouble()),
                    child: WelcomeText(
                      model: model,
                    ),
                  ),
                  SizedBox(height: 46.h.toDouble()),
                  if (model.hasAccount)
                    ..._showUnlockButton(context, model)
                  else
                    ..._showLoginButtons(context)
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 42.h.toDouble()),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'v0.1.0',
                  style: TextStyle(
                    fontSize: 15.ssp.toDouble(),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _showUnlockButton(BuildContext context, HomeViewModel model) {
    return [
      Button(
        text: 'Unlock your Account',
        variant: ButtonVariant.success,
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.unloackAccount);
        },
      )
    ];
  }

  List<Widget> _showLoginButtons(BuildContext context) {
    return [
      Button(
        text: 'Generate account',
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.generateAccount);
        },
      ),
      SizedBox(height: 16.h.toDouble()),
      Button(
        text: 'Restore from key-phrase',
        variant: ButtonVariant.success,
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.recoverAccount);
        },
      ),
    ];
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({Key key, this.model}) : super(key: key);
  final HomeViewModel model;
  @override
  Widget build(BuildContext context) {
    return Text(
      model.hasAccount
          ? 'Get back to the app !'
          : 'Welcome to the Sunshine Foundation app.',
      style: TextStyle(
        fontSize: 22.ssp.toDouble(),
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }
}
