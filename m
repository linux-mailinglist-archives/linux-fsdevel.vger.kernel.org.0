Return-Path: <linux-fsdevel+bounces-30307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF77989210
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 02:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B777280E05
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24482187FEA;
	Sun, 29 Sep 2024 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="PoMjG5Ns";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XBhuPx8n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7609123A6
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Sep 2024 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727568017; cv=none; b=JXZvjVSpiPITNlye6ggdsxFie1NjMAOoNT0V+pv2clMqhkINp2jckvLbknNxuzCFvYBps7zB7LnXWV5AvhixPC+uqIa4ckA7+YErzMs+zl373I8SRvMTT1xSQR8x4rKNsfzbaSt8FujfVxGojSF3sONUzxpQ1WleyQ7ldnQ808E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727568017; c=relaxed/simple;
	bh=yoYAQ8F9/Prs+UKe3l3c2WUYWsht54dAL9zmxzKj6+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+K32ZyQXuF29ld0h2zlTWpqVccNVCI1ztomUpQKYCKcV9y3/nVb6feB88CPgDsJz8EoD0Kk4I5JWcqIR32QV3oUfsRWmWxvRr2J92R3C5ZmlkxwXttRPjN/V4vUDBEu3qWshDjF444dco3xIhvv8RTp32Sn+TraMsvsh3gFgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=PoMjG5Ns; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XBhuPx8n; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=PoMjG5NsOu2UMAFJi7VuRQOa5OfCES6Qh8jum6HqFYCbK4HCu/DYF6HsnQr94gT7JuJi2VhN3AlRjF76iRN4DgNmEbbTiL7Vbrdy3QiPJx678hsbaJA3UGyknDadc+bvL160WKkBKPHLs1R7Q5YwBKyReqUwtWit7JElzYEuwR7MNXvGw6VaUxo5ZPm2EY9H1DoNKjpK2ap9OIFGK4ATnYVqoyytMmTkUncPwuMS3tz8fehxw37Sb/p9tCnFSEqMRATU4w8wrw8kDjFsLth96qs3cCCWGUbSUJOepzM/ZSWyoeeb6NGdDsu61YQ6j2bOohIjwMHki4/BREy5xTfMiQ==; s=purelymail1; d=lkcamp.dev; v=1; bh=yoYAQ8F9/Prs+UKe3l3c2WUYWsht54dAL9zmxzKj6+A=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=XBhuPx8nUNNRQ8xavf5KiOTwcGVyO1jwAXPmeMIJ0gHc7HqenfWxzmmptOOVsfc6yU7S5xxleV3KWQ31ByYFjrG47GLX6yCWYWc/T4eXHueTV7FW33byjo+w7qeMs7vJ2AJdMRSdV8+JHqn/fMTzshqPHEcQqjOUbluH293Gqh7zR93PW8dWFwSPTOr59OE7XQcOGGItp4JPsNuIPqYg2XZoGD11bT4mtVlVsnqix9da5Is3SVbARVfgtTUw5AYQmPDdDUCUrWmmkGvdXlaMlR2ntHPPWTn6UIWascz7u867O7occjzRb16+9WvtvigUcue8SA42iWPVLSKb505+0Q==; s=purelymail1; d=purelymail.com; v=1; bh=yoYAQ8F9/Prs+UKe3l3c2WUYWsht54dAL9zmxzKj6+A=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 48571:7130:null:purelymail
X-Pm-Original-To: linux-fsdevel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1507990812;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 29 Sep 2024 00:00:07 +0000 (UTC)
From: Pedro Orlando <porlando@lkcamp.dev>
To: Gabriel Krisman Bertazi <krisman@kernel.org>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Pedro Orlando <porlando@lkcamp.dev>,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Danilo Pereira <dpereira@lkcamp.dev>
Subject: [PATCH v2 1/2] unicode: kunit: refactor selftest to kunit tests
Date: Sat, 28 Sep 2024 20:58:26 -0300
Message-Id: <20240928235825.96961-2-porlando@lkcamp.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928235825.96961-1-porlando@lkcamp.dev>
References: <20240928235825.96961-1-porlando@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Refactoring 'test' functions into kunit tests, to test utf-8 support in
unicode subsystem.

This allows the utf8 tests to be run alongside the KUnit test suite
using kunit-tool, quickly compiling and running all desired tests as
part of the KUnit test suite, instead of compiling the selftest module
and loading it.

The refactoring kept the original testing logic intact, while adopting a
testing pattern across different kernel modules and leveraging KUnit's
benefits.

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
---

About the KUNIT readability, there are two ways of obtaing the results:
1- using `_TRUE(test, func =3D=3D ret)` which may make the code more
readable, but the error message less informative. For example:
`false, but expect true`; unless we use _TRUE_MSG(test, cond, msg) to
customize the error message (which is what we've done here).
2- using `_EQ(test, func, ret)` which may be a little less readable, but th=
e
default error message will carry more information. For example:
`64, but expected 0`

---
 fs/unicode/.kunitconfig    |   3 +
 fs/unicode/Kconfig         |   5 +-
 fs/unicode/Makefile        |   2 +-
 fs/unicode/utf8-selftest.c | 149 +++++++++++++++++--------------------
 4 files changed, 76 insertions(+), 83 deletions(-)
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
index 600e15efe9ed..52ab68ef2bbc 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -1,38 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Kernel module for testing utf-8 support.
+ * KUnit tests for utf-8 support.
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
@@ -170,69 +150,74 @@ static int utf8cursor(struct utf8cursor *u8c, const s=
truct unicode_map *um,
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
 =09=09int nlen =3D strlen(nfdi_test_data[i].dec);
 =09=09int j =3D 0;
 =09=09unsigned char c;
+=09=09int ret;
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
+
+=09=09ret =3D utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str);
+=09=09KUNIT_EXPECT_TRUE_MSG(test, ret >=3D 0, "Can't create cursor\n");
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
 =09=09int nlen =3D strlen(nfdicf_test_data[i].ncf);
 =09=09int j =3D 0;
+=09=09int ret;
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
+=09=09ret =3D utf8cursor(&u8c, um, UTF8_NFDICF, nfdicf_test_data[i].str);
+=09=09KUNIT_EXPECT_TRUE_MSG(test, ret >=3D 0, "Can't create cursor\n");
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
@@ -240,8 +225,9 @@ static void check_utf8_comparisons(struct unicode_map *=
table)
 =09=09const struct qstr s2 =3D {.name =3D nfdi_test_data[i].dec,
 =09=09=09=09=09.len =3D sizeof(nfdi_test_data[i].dec)};
=20
-=09=09test_f(!utf8_strncmp(table, &s1, &s2),
-=09=09       "%s %s comparison mismatch\n", s1.name, s2.name);
+=09=09/* strncmp returns 0 when strings are equal */
+=09=09KUNIT_EXPECT_TRUE_MSG(test, utf8_strncmp(um, &s1, &s2) =3D=3D 0,
+=09=09=09=09    "%s %s comparison mismatch\n", s1.name, s2.name);
 =09}
=20
 =09for (i =3D 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
@@ -250,62 +236,65 @@ static void check_utf8_comparisons(struct unicode_map=
 *table)
 =09=09const struct qstr s2 =3D {.name =3D nfdicf_test_data[i].ncf,
 =09=09=09=09=09.len =3D sizeof(nfdicf_test_data[i].ncf)};
=20
-=09=09test_f(!utf8_strncasecmp(table, &s1, &s2),
-=09=09       "%s %s comparison mismatch\n", s1.name, s2.name);
+=09=09/* strncasecmp returns 0 when strings are equal */
+=09=09KUNIT_EXPECT_TRUE_MSG(test, utf8_strncasecmp(um, &s1, &s2) =3D=3D 0,
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
+MODULE_DESCRIPTION("KUnit tests for utf-8 support.");
 MODULE_LICENSE("GPL");
--=20
2.34.1


