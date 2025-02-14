import 'package:flutter/material.dart';

enum ColorToken {
  primary,
  primaryVariant,
  secondary,
  secondaryVariant,
  surface,
  background,
  error,
  onPrimary,
  onSecondary,
  onSurface,
  onBackground,
  onError,
}

extension ColorSchemeTokenExtension on ColorToken {
  Color get value {
    final colorIndex = _colorSchemeTranslationValues[index];
    return colorIndex;
  }
}

const _colorSchemeTranslationValues = [
  Color(0xFF000001),
  Color(0xFF000002),
  Color(0xFF000003),
  Color(0xFF000004),
  Color(0xFF000005),
  Color(0xFF000006),
  Color(0xFF000007),
  Color(0xFF000008),
  Color(0xFF000009),
  Color(0xFF00000A),
  Color(0xFF00000B),
  Color(0xFF00000C),
];

extension ColorExtensions on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) => hexToColor(hexString);

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

/// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
