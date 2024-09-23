Return-Path: <linux-fsdevel+bounces-29885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D6797EFD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D11D1C213BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1E819F13D;
	Mon, 23 Sep 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="sBjdSpHT";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="qbH2UBTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79519B3F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727112676; cv=none; b=XKISqd51koR1HCoUzhnva2tYl1iVCRWFP7tn3ZHQ1nsMfck2jx1G68LEv3Ef0F0D67kz7jrFPm0giq1QiJLV0/d6V46LCtE0KFz4GgfONY4dTwOQvtRdhAx7r3Q5v04skq3PfDUBaKOLUz4xEHnH88EuasvhgN+/OdKUcLf3tIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727112676; c=relaxed/simple;
	bh=inCtHAmTJCP6fyLTthP9KSWimhLxZHn1OlOWVhQLTLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3mg/ac3paHonssxKoUnHBkaUujhZQeioXxhltOaTCRDHj6031OzYJiWGhHCTw+U1xW72/r4NJUHeqISdSt3eEMGzSjMGi29qeGYGz1NYr67fAZZKR3Uo3Ehm4srOlg4xr5yyCJu87Q2+MZjMkuVtzoL/3nhJs6SgQo6/ThwiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=sBjdSpHT; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=qbH2UBTR; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=sBjdSpHTaD1i3gOz6oDKyGFPvB38/6zoKCmN9ezXhE3w26Zc488Tb4+U+0rMtX0cS9H9nHMp/+MeJ6aMcorWKd9VdnqZiexZgIi8KwG2ZKzYui3m65feTKu2Jr3pdpP9hWY6hwo9ORhFKTVQgbWA/x3HeeYpIWq7MYf4u+NUCkhgDw1tnudIpuWWXLKx5rdEulhEpG07cW5OQPL+GVJy/kE9GBF661vhg2eSl0urfNUC3tLWPAKLYc3tFjrMg9pYk6uU9lx3o3ArN3Zs41i8yN2N/YSpklN2aS1rJLnvf14h5YB3n0L5EeceqawvR3YmLDXWxPFJM7+nnyb/pp24HQ==; s=purelymail3; d=lkcamp.dev; v=1; bh=inCtHAmTJCP6fyLTthP9KSWimhLxZHn1OlOWVhQLTLg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=qbH2UBTRn8VMHinIIAr+0w4WEH+qY8cL4sb8WuaBbYSNBG8EhfniXnwNTHawHYlPHpiPmfK8N1FKpDRZRHrShpg4OHWyOGggQrj+WjRWLXJjoL1ttJpDN3LhKt2N15A9UdEEiYnVfI7DnyoN5SYzUBt+wYI6QSq5EPrmsSnKtGBMnCAU+FAx7s176H0a2aUiZMycKaXKy9zMaKXLuip4Fi+rj5kOlD07FwI8RYKOXjcnD1QeEY5AxgWe2s5gFgVVIDCrAJ4EWqbeeo5ZiMsus8hg5dhkCBg1Kplj0g/XChzQ4WEPtqJHexMTLbhHIxtHeQfFpOsFfDFy6tErwQjWeA==; s=purelymail3; d=purelymail.com; v=1; bh=inCtHAmTJCP6fyLTthP9KSWimhLxZHn1OlOWVhQLTLg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 40598:7130:null:purelymail
X-Pm-Original-To: linux-fsdevel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1005398190;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 23 Sep 2024 17:31:06 +0000 (UTC)
From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
To: Gabriel Krisman Bertazi <krisman@kernel.org>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	porlando@lkcamp.dev,
	dpereira@lkcamp.dev,
	gbittencourt@lkcamp.dev
Subject: [PATCH 1/2] unicode: kunit: refactor selftest to kunit tests
Date: Mon, 23 Sep 2024 14:34:53 -0300
Message-ID: <20240923173454.264852-2-gbittencourt@lkcamp.dev>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923173454.264852-1-gbittencourt@lkcamp.dev>
References: <20240923173454.264852-1-gbittencourt@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Instead of creating 'test' functions, use kunit functions to test
utf-8 support in unicode subsystem.

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
---
 fs/unicode/.kunitconfig    |   3 +
 fs/unicode/Kconfig         |   5 +-
 fs/unicode/Makefile        |   2 +-
 fs/unicode/utf8-selftest.c | 152 +++++++++++++++++--------------------
 4 files changed, 76 insertions(+), 86 deletions(-)
 create mode 100644 fs/unicode/.kunitconfig

diff --git a/fs/unicode/.kunitconfig b/fs/unicode/.kunitconfig
new file mode 100644
index 000000000000..62dd5c171f9c
--- /dev/null
+++ b/fs/unicode/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=3Dy
+CONFIG_UNICODE=3Dy
+CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST=3Dy
diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
index da786a687fdc..4ad2c36550f1 100644
--- a/fs/unicode/Kconfig
+++ b/fs/unicode/Kconfig
@@ -10,6 +10,7 @@ config UNICODE
 =09  be a separate loadable module that gets requested only when a file
 =09  system actually use it.
=20
-config UNICODE_NORMALIZATION_SELFTEST
+config UNICODE_NORMALIZATION_KUNIT_TEST
 =09tristate "Test UTF-8 normalization support"
-=09depends on UNICODE
+=09depends on UNICODE && KUNIT
+=09default KUNIT_ALL_TESTS
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index e309afe2b2bb..37bbcbc628a1 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
 obj-y=09=09=09+=3D unicode.o
 endif
 obj-$(CONFIG_UNICODE)=09+=3D utf8data.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) +=3D utf8-selftest.o
+obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) +=3D utf8-selftest.o
=20
 unicode-y :=3D utf8-norm.o utf8-core.o
=20
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 600e15efe9ed..54ded8db6b1c 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -1,38 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Kernel module for testing utf-8 support.
+ * KUnit tests for utf-8 support
  *
  * Copyright 2017 Collabora Ltd.
  */
=20
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/printk.h>
 #include <linux/unicode.h>
-#include <linux/dcache.h>
+#include <kunit/test.h>
=20
 #include "utf8n.h"
=20
-static unsigned int failed_tests;
-static unsigned int total_tests;
-
 /* Tests will be based on this version. */
 #define UTF8_LATEST=09UNICODE_AGE(12, 1, 0)
=20
-#define _test(cond, func, line, fmt, ...) do {=09=09=09=09\
-=09=09total_tests++;=09=09=09=09=09=09\
-=09=09if (!cond) {=09=09=09=09=09=09\
-=09=09=09failed_tests++;=09=09=09=09=09\
-=09=09=09pr_err("test %s:%d Failed: %s%s",=09=09\
-=09=09=09       func, line, #cond, (fmt?":":"."));=09\
-=09=09=09if (fmt)=09=09=09=09=09\
-=09=09=09=09pr_err(fmt, ##__VA_ARGS__);=09=09\
-=09=09}=09=09=09=09=09=09=09\
-=09} while (0)
-#define test_f(cond, fmt, ...) _test(cond, __func__, __LINE__, fmt, ##__VA=
_ARGS__)
-#define test(cond) _test(cond, __func__, __LINE__, "")
-
 static const struct {
 =09/* UTF-8 strings in this vector _must_ be NULL-terminated. */
 =09unsigned char str[10];
@@ -158,22 +138,22 @@ static const struct {
 =09}
 };
=20
-static ssize_t utf8len(const struct unicode_map *um, enum utf8_normalizati=
on n,
-=09=09const char *s)
+static ssize_t utf8len(const struct unicode_map *um, enum utf8_normalizati=
on n, const char *s)
 {
 =09return utf8nlen(um, n, s, (size_t)-1);
 }
=20
 static int utf8cursor(struct utf8cursor *u8c, const struct unicode_map *um=
,
-=09=09enum utf8_normalization n, const char *s)
+=09=09      enum utf8_normalization n, const char *s)
 {
 =09return utf8ncursor(u8c, um, n, s, (unsigned int)-1);
 }
=20
-static void check_utf8_nfdi(struct unicode_map *um)
+static void check_utf8_nfdi(struct kunit *test)
 {
 =09int i;
 =09struct utf8cursor u8c;
+=09struct unicode_map *um =3D test->priv;
=20
 =09for (i =3D 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 =09=09int len =3D strlen(nfdi_test_data[i].str);
@@ -181,28 +161,29 @@ static void check_utf8_nfdi(struct unicode_map *um)
 =09=09int j =3D 0;
 =09=09unsigned char c;
=20
-=09=09test((utf8len(um, UTF8_NFDI, nfdi_test_data[i].str) =3D=3D nlen));
-=09=09test((utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len) =3D=3D
-=09=09=09nlen));
+=09=09KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDI, nfdi_test_data[i].str),=
 nlen);
+=09=09KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str,=
 len),
+=09=09=09=09nlen);
=20
-=09=09if (utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str) < 0)
-=09=09=09pr_err("can't create cursor\n");
+=09=09KUNIT_EXPECT_GE_MSG(test, utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_=
data[i].str),
+=09=09=09=09    0, "Can't create cursor\n");
=20
 =09=09while ((c =3D utf8byte(&u8c)) > 0) {
-=09=09=09test_f((c =3D=3D nfdi_test_data[i].dec[j]),
-=09=09=09       "Unexpected byte 0x%x should be 0x%x\n",
-=09=09=09       c, nfdi_test_data[i].dec[j]);
+=09=09=09KUNIT_EXPECT_EQ_MSG(test, c, nfdi_test_data[i].dec[j],
+=09=09=09=09=09    "Unexpected byte 0x%x should be 0x%x\n",
+=09=09=09=09=09    c, nfdi_test_data[i].dec[j]);
 =09=09=09j++;
 =09=09}
=20
-=09=09test((j =3D=3D nlen));
+=09=09KUNIT_EXPECT_EQ(test, j, nlen);
 =09}
 }
=20
-static void check_utf8_nfdicf(struct unicode_map *um)
+static void check_utf8_nfdicf(struct kunit *test)
 {
 =09int i;
 =09struct utf8cursor u8c;
+=09struct unicode_map *um =3D test->priv;
=20
 =09for (i =3D 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
 =09=09int len =3D strlen(nfdicf_test_data[i].str);
@@ -210,29 +191,30 @@ static void check_utf8_nfdicf(struct unicode_map *um)
 =09=09int j =3D 0;
 =09=09unsigned char c;
=20
-=09=09test((utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str) =3D=3D
-=09=09=09=09nlen));
-=09=09test((utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len) =3D=3D
-=09=09=09=09nlen));
+=09=09KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].s=
tr),
+=09=09=09=09nlen);
+=09=09KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].=
str, len),
+=09=09=09=09nlen);
=20
-=09=09if (utf8cursor(&u8c, um, UTF8_NFDICF,
-=09=09=09=09nfdicf_test_data[i].str) < 0)
-=09=09=09pr_err("can't create cursor\n");
+=09=09KUNIT_EXPECT_GE_MSG(test,
+=09=09=09=09    utf8cursor(&u8c, um, UTF8_NFDICF, nfdicf_test_data[i].str)=
,
+=09=09=09=09    0, "Can't create cursor\n");
=20
 =09=09while ((c =3D utf8byte(&u8c)) > 0) {
-=09=09=09test_f((c =3D=3D nfdicf_test_data[i].ncf[j]),
-=09=09=09       "Unexpected byte 0x%x should be 0x%x\n",
-=09=09=09       c, nfdicf_test_data[i].ncf[j]);
+=09=09=09KUNIT_EXPECT_EQ_MSG(test, c, nfdicf_test_data[i].ncf[j],
+=09=09=09=09=09    "Unexpected byte 0x%x should be 0x%x\n",
+=09=09=09=09=09    c, nfdicf_test_data[i].ncf[j]);
 =09=09=09j++;
 =09=09}
=20
-=09=09test((j =3D=3D nlen));
+=09=09KUNIT_EXPECT_EQ(test, j, nlen);
 =09}
 }
=20
-static void check_utf8_comparisons(struct unicode_map *table)
+static void check_utf8_comparisons(struct kunit *test)
 {
 =09int i;
+=09struct unicode_map *um =3D test->priv;
=20
 =09for (i =3D 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 =09=09const struct qstr s1 =3D {.name =3D nfdi_test_data[i].str,
@@ -240,8 +222,9 @@ static void check_utf8_comparisons(struct unicode_map *=
table)
 =09=09const struct qstr s2 =3D {.name =3D nfdi_test_data[i].dec,
 =09=09=09=09=09.len =3D sizeof(nfdi_test_data[i].dec)};
=20
-=09=09test_f(!utf8_strncmp(table, &s1, &s2),
-=09=09       "%s %s comparison mismatch\n", s1.name, s2.name);
+=09=09// strncmp returns 0 when strings are equal
+=09=09KUNIT_EXPECT_EQ_MSG(test, utf8_strncmp(um, &s1, &s2), 0,
+=09=09=09=09    "%s %s comparison mismatch\n", s1.name, s2.name);
 =09}
=20
 =09for (i =3D 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
@@ -250,62 +233,65 @@ static void check_utf8_comparisons(struct unicode_map=
 *table)
 =09=09const struct qstr s2 =3D {.name =3D nfdicf_test_data[i].ncf,
 =09=09=09=09=09.len =3D sizeof(nfdicf_test_data[i].ncf)};
=20
-=09=09test_f(!utf8_strncasecmp(table, &s1, &s2),
-=09=09       "%s %s comparison mismatch\n", s1.name, s2.name);
+=09=09// strncasecmp returns 0 when strings are equal
+=09=09KUNIT_EXPECT_EQ_MSG(test, utf8_strncasecmp(um, &s1, &s2), 0,
+=09=09=09=09    "%s %s comparison mismatch\n", s1.name, s2.name);
 =09}
 }
=20
-static void check_supported_versions(struct unicode_map *um)
+static void check_supported_versions(struct kunit *test)
 {
+=09struct unicode_map *um =3D test->priv;
 =09/* Unicode 7.0.0 should be supported. */
-=09test(utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
+=09KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(7, 0, =
0)));
=20
 =09/* Unicode 9.0.0 should be supported. */
-=09test(utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
+=09KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(9, 0, =
0)));
=20
 =09/* Unicode 1x.0.0 (the latest version) should be supported. */
-=09test(utf8version_is_supported(um, UTF8_LATEST));
+=09KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UTF8_LATEST));
=20
 =09/* Next versions don't exist. */
-=09test(!utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
-=09test(!utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
-=09test(!utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
+=09KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(13, 0=
, 0)));
+=09KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(0, 0,=
 0)));
+=09KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(-1, -=
1, -1)));
 }
=20
-static int __init init_test_ucd(void)
+static struct kunit_case unicode_normalization_test_cases[] =3D {
+=09KUNIT_CASE(check_supported_versions),
+=09KUNIT_CASE(check_utf8_comparisons),
+=09KUNIT_CASE(check_utf8_nfdicf),
+=09KUNIT_CASE(check_utf8_nfdi),
+=09{}
+};
+
+static int init_test_ucd(struct kunit *test)
 {
-=09struct unicode_map *um;
+=09struct unicode_map *um =3D utf8_load(UTF8_LATEST);
=20
-=09failed_tests =3D 0;
-=09total_tests =3D 0;
+=09test->priv =3D um;
=20
-=09um =3D utf8_load(UTF8_LATEST);
-=09if (IS_ERR(um)) {
-=09=09pr_err("%s: Unable to load utf8 table.\n", __func__);
-=09=09return PTR_ERR(um);
-=09}
+=09KUNIT_EXPECT_EQ_MSG(test, IS_ERR(um), 0,
+=09=09=09    "%s: Unable to load utf8 table.\n", __func__);
=20
-=09check_supported_versions(um);
-=09check_utf8_nfdi(um);
-=09check_utf8_nfdicf(um);
-=09check_utf8_comparisons(um);
-
-=09if (!failed_tests)
-=09=09pr_info("All %u tests passed\n", total_tests);
-=09else
-=09=09pr_err("%u out of %u tests failed\n", failed_tests,
-=09=09       total_tests);
-=09utf8_unload(um);
 =09return 0;
 }
=20
-static void __exit exit_test_ucd(void)
+static void exit_test_ucd(struct kunit *test)
 {
+=09utf8_unload(test->priv);
 }
=20
-module_init(init_test_ucd);
-module_exit(exit_test_ucd);
+static struct kunit_suite unicode_normalization_test_suite =3D {
+=09.name =3D "unicode_normalization",
+=09.test_cases =3D unicode_normalization_test_cases,
+=09.init =3D init_test_ucd,
+=09.exit =3D exit_test_ucd,
+};
+
+kunit_test_suite(unicode_normalization_test_suite);
+
=20
 MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
-MODULE_DESCRIPTION("Kernel module for testing utf-8 support");
+MODULE_DESCRIPTION("KUnit tests for utf-8 support");
 MODULE_LICENSE("GPL");
--=20
2.46.1


