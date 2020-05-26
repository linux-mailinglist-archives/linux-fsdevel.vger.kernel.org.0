Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD61AC86E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbgDPPI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 11:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441812AbgDPPHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:07:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF88C061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 08:07:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 5F2AC2A02D6
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
Subject: [PATCH v2] unicode: implement utf8 unit tests as a KUnit test suite.
Date:   Thu, 16 Apr 2020 17:07:16 +0200
Message-Id: <20200416150716.3561-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This translates the existing utf8 unit test module into a KUnit-compliant
test suite. No functionality has been added or removed.

Some names changed to make the file name, the Kconfig option and test
suite name less specific, since this source file might hold more utf8
tests in the future.

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
Changes in v2:
- Subject line
- Code style fixes
- Kconfig option description and help text
- All kunit references in documentation and Kconfig properly capitalized
- Unicode version string now generated at compile time

Tested with kunit_tool and at boot time on qemu-system-x86_64

 fs/unicode/Kconfig                          |  19 +-
 fs/unicode/Makefile                         |   2 +-
 fs/unicode/{utf8-selftest.c => utf8-test.c} | 199 +++++++++-----------
 3 files changed, 108 insertions(+), 112 deletions(-)
 rename fs/unicode/{utf8-selftest.c => utf8-test.c} (60%)

diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
index 2c27b9a5cd6c..a8865891c3bd 100644
--- a/fs/unicode/Kconfig
+++ b/fs/unicode/Kconfig
@@ -8,7 +8,20 @@ config UNICODE
 	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
 	  support.
 
-config UNICODE_NORMALIZATION_SELFTEST
-	tristate "Test UTF-8 normalization support"
-	depends on UNICODE
+config UNICODE_KUNIT_TESTS
+	bool "KUnit tests for Unicode normalization and casefolding support"
+	depends on UNICODE && KUNIT
 	default n
+	help
+	  This builds the KUnit test suite for Unicode normalization and
+	  casefolding support.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running KUnit test harness and are not for inclusion into a production
+	  build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index b88aecc86550..0e8e2192a715 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_UNICODE) += unicode.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
+obj-$(CONFIG_UNICODE_KUNIT_TESTS) += utf8-test.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-test.c
similarity index 60%
rename from fs/unicode/utf8-selftest.c
rename to fs/unicode/utf8-test.c
index 6fe8af7edccb..4a9856008385 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-test.c
@@ -1,39 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Kernel module for testing utf-8 support.
+ * KUnit tests for utf-8 support.
  *
- * Copyright 2017 Collabora Ltd.
+ * Copyright 2020 Collabora Ltd.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/printk.h>
+#include <kunit/test.h>
 #include <linux/unicode.h>
-#include <linux/dcache.h>
-
 #include "utf8n.h"
 
-unsigned int failed_tests;
-unsigned int total_tests;
-
 /* Tests will be based on this version. */
 #define latest_maj 12
 #define latest_min 1
 #define latest_rev 0
 
-#define _test(cond, func, line, fmt, ...) do {				\
-		total_tests++;						\
-		if (!cond) {						\
-			failed_tests++;					\
-			pr_err("test %s:%d Failed: %s%s",		\
-			       func, line, #cond, (fmt?":":"."));	\
-			if (fmt)					\
-				pr_err(fmt, ##__VA_ARGS__);		\
-		}							\
-	} while (0)
-#define test_f(cond, fmt, ...) _test(cond, __func__, __LINE__, fmt, ##__VA_ARGS__)
-#define test(cond) _test(cond, __func__, __LINE__, "")
+#define str(s) #s
+#define VERSION_STR(maj, min, rev) str(maj) "." str(min) "." str(rev)
+
+/* Test data */
 
 static const struct {
 	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
@@ -160,88 +144,117 @@ static const struct {
 	}
 };
 
-static void check_utf8_nfdi(void)
+
+/* Test cases */
+
+static void utf8_test_supported_versions(struct kunit *test)
+{
+	/* Unicode 7.0.0 should be supported. */
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(7, 0, 0));
+
+	/* Unicode 9.0.0 should be supported. */
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(9, 0, 0));
+
+	/* Unicode 1x.0.0 (the latest version) should be supported. */
+	KUNIT_EXPECT_TRUE(test,
+		utf8version_is_supported(latest_maj, latest_min, latest_rev));
+
+	/* Next versions don't exist. */
+	KUNIT_EXPECT_FALSE(test,
+		utf8version_is_supported(latest_maj + 1 , 0, 0));
+
+	/* Test for invalid version values */
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(0, 0, 0));
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(-1, -1, -1));
+}
+
+static void utf8_test_nfdi(struct kunit *test)
 {
 	int i;
 	struct utf8cursor u8c;
 	const struct utf8data *data;
 
 	data = utf8nfdi(UNICODE_AGE(latest_maj, latest_min, latest_rev));
-	if (!data) {
-		pr_err("%s: Unable to load utf8-%d.%d.%d. Skipping.\n",
-		       __func__, latest_maj, latest_min, latest_rev);
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, data,
+		"Unable to load utf8-%d.%d.%d. Skipping.",
+		latest_maj, latest_min, latest_rev);
 
 	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
-		int len = strlen(nfdi_test_data[i].str);
-		int nlen = strlen(nfdi_test_data[i].dec);
+		size_t len = strlen(nfdi_test_data[i].str);
+		size_t nlen = strlen(nfdi_test_data[i].dec);
 		int j = 0;
 		unsigned char c;
 
-		test((utf8len(data, nfdi_test_data[i].str) == nlen));
-		test((utf8nlen(data, nfdi_test_data[i].str, len) == nlen));
+		KUNIT_EXPECT_EQ(test,
+			utf8len(data, nfdi_test_data[i].str),
+			(ssize_t)nlen);
+		KUNIT_EXPECT_EQ(test,
+			utf8nlen(data, nfdi_test_data[i].str, len),
+			(ssize_t)nlen);
 
-		if (utf8cursor(&u8c, data, nfdi_test_data[i].str) < 0)
-			pr_err("can't create cursor\n");
+		KUNIT_ASSERT_EQ_MSG(test,
+			utf8cursor(&u8c, data, nfdi_test_data[i].str), 0,
+			"Can't create cursor");
 
 		while ((c = utf8byte(&u8c)) > 0) {
-			test_f((c == nfdi_test_data[i].dec[j]),
-			       "Unexpected byte 0x%x should be 0x%x\n",
-			       c, nfdi_test_data[i].dec[j]);
+			KUNIT_EXPECT_EQ_MSG(test, c, nfdi_test_data[i].dec[j],
+				"Unexpected byte 0x%x should be 0x%x",
+				c, nfdi_test_data[i].dec[j]);
 			j++;
 		}
 
-		test((j == nlen));
+		KUNIT_EXPECT_EQ(test, j, (int)nlen);
 	}
 }
 
-static void check_utf8_nfdicf(void)
+static void utf8_test_nfdicf(struct kunit *test)
 {
 	int i;
 	struct utf8cursor u8c;
 	const struct utf8data *data;
 
 	data = utf8nfdicf(UNICODE_AGE(latest_maj, latest_min, latest_rev));
-	if (!data) {
-		pr_err("%s: Unable to load utf8-%d.%d.%d. Skipping.\n",
-		       __func__, latest_maj, latest_min, latest_rev);
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, data,
+		"Unable to load utf8-%d.%d.%d. Skipping.",
+		latest_maj, latest_min, latest_rev);
 
 	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
-		int len = strlen(nfdicf_test_data[i].str);
-		int nlen = strlen(nfdicf_test_data[i].ncf);
+		size_t len = strlen(nfdicf_test_data[i].str);
+		size_t nlen = strlen(nfdicf_test_data[i].ncf);
 		int j = 0;
 		unsigned char c;
 
-		test((utf8len(data, nfdicf_test_data[i].str) == nlen));
-		test((utf8nlen(data, nfdicf_test_data[i].str, len) == nlen));
+		KUNIT_EXPECT_EQ(test,
+			utf8len(data, nfdicf_test_data[i].str),
+			(ssize_t)nlen);
+		KUNIT_EXPECT_EQ(test,
+			utf8nlen(data, nfdicf_test_data[i].str, len),
+			(ssize_t)nlen);
 
-		if (utf8cursor(&u8c, data, nfdicf_test_data[i].str) < 0)
-			pr_err("can't create cursor\n");
+		KUNIT_ASSERT_EQ_MSG(test,
+			utf8cursor(&u8c, data, nfdicf_test_data[i].str), 0,
+			"Can't create cursor");
 
 		while ((c = utf8byte(&u8c)) > 0) {
-			test_f((c == nfdicf_test_data[i].ncf[j]),
-			       "Unexpected byte 0x%x should be 0x%x\n",
-			       c, nfdicf_test_data[i].ncf[j]);
+			KUNIT_EXPECT_EQ_MSG(test, c, nfdicf_test_data[i].ncf[j],
+				"Unexpected byte 0x%x should be 0x%x\n",
+				c, nfdicf_test_data[i].ncf[j]);
 			j++;
 		}
 
-		test((j == nlen));
+		KUNIT_EXPECT_EQ(test, j, (int)nlen);
 	}
 }
 
-static void check_utf8_comparisons(void)
+static void utf8_test_comparisons(struct kunit *test)
 {
 	int i;
-	struct unicode_map *table = utf8_load("12.1.0");
+	struct unicode_map *table;
 
-	if (IS_ERR(table)) {
-		pr_err("%s: Unable to load utf8 %d.%d.%d. Skipping.\n",
-		       __func__, latest_maj, latest_min, latest_rev);
-		return;
-	}
+	table = utf8_load(VERSION_STR(latest_maj, latest_min, latest_rev));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, table,
+		"Unable to load utf8-%d.%d.%d. Skipping.\n",
+		latest_maj, latest_min, latest_rev);
 
 	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 		const struct qstr s1 = {.name = nfdi_test_data[i].str,
@@ -249,8 +262,8 @@ static void check_utf8_comparisons(void)
 		const struct qstr s2 = {.name = nfdi_test_data[i].dec,
 					.len = sizeof(nfdi_test_data[i].dec)};
 
-		test_f(!utf8_strncmp(table, &s1, &s2),
-		       "%s %s comparison mismatch\n", s1.name, s2.name);
+		KUNIT_EXPECT_EQ_MSG(test, utf8_strncmp(table, &s1, &s2), 0,
+			"%s %s comparison mismatch", s1.name, s2.name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
@@ -259,54 +272,24 @@ static void check_utf8_comparisons(void)
 		const struct qstr s2 = {.name = nfdicf_test_data[i].ncf,
 					.len = sizeof(nfdicf_test_data[i].ncf)};
 
-		test_f(!utf8_strncasecmp(table, &s1, &s2),
-		       "%s %s comparison mismatch\n", s1.name, s2.name);
+		KUNIT_EXPECT_EQ_MSG(test, utf8_strncasecmp(table, &s1, &s2), 0,
+			"%s %s comparison mismatch", s1.name, s2.name);
 	}
 
 	utf8_unload(table);
 }
 
-static void check_supported_versions(void)
-{
-	/* Unicode 7.0.0 should be supported. */
-	test(utf8version_is_supported(7, 0, 0));
-
-	/* Unicode 9.0.0 should be supported. */
-	test(utf8version_is_supported(9, 0, 0));
-
-	/* Unicode 1x.0.0 (the latest version) should be supported. */
-	test(utf8version_is_supported(latest_maj, latest_min, latest_rev));
-
-	/* Next versions don't exist. */
-	test(!utf8version_is_supported(13, 0, 0));
-	test(!utf8version_is_supported(0, 0, 0));
-	test(!utf8version_is_supported(-1, -1, -1));
-}
-
-static int __init init_test_ucd(void)
-{
-	failed_tests = 0;
-	total_tests = 0;
-
-	check_supported_versions();
-	check_utf8_nfdi();
-	check_utf8_nfdicf();
-	check_utf8_comparisons();
-
-	if (!failed_tests)
-		pr_info("All %u tests passed\n", total_tests);
-	else
-		pr_err("%u out of %u tests failed\n", failed_tests,
-		       total_tests);
-	return 0;
-}
-
-static void __exit exit_test_ucd(void)
-{
-}
+static struct kunit_case utf8_test_cases[] = {
+	KUNIT_CASE(utf8_test_supported_versions),
+	KUNIT_CASE(utf8_test_nfdi),
+	KUNIT_CASE(utf8_test_nfdicf),
+	KUNIT_CASE(utf8_test_comparisons),
+	{}
+};
 
-module_init(init_test_ucd);
-module_exit(exit_test_ucd);
+static struct kunit_suite utf8_test_suite = {
+	.name = "utf8-unit-test",
+	.test_cases = utf8_test_cases,
+};
 
-MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
-MODULE_LICENSE("GPL");
+kunit_test_suite(utf8_test_suite);
-- 
2.18.0

