Return-Path: <linux-fsdevel+bounces-31667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9901B999DFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 09:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B5E2853CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A21F20B1FD;
	Fri, 11 Oct 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptFMuFuP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9104C20ADFC
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631881; cv=none; b=g/grc8xTEDPOQaIknApbTt6FD/FoJ8B3WsiNooU1rEcpI5R4BD84w9DT4tr7iR12TkKN5iDjOazsdmj8i9TGC0g4JPN/kPRLuiuJXkUfGAoihIhjdAPABzhky8twm2QSptmKU9g1XFpnpQ8zGBXtM8RyyUHuN3CkUq2PzVX81Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631881; c=relaxed/simple;
	bh=n7fq3kimOIuPR5kgHeEkIUesgQhbCxpjKXHlj8fkyJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fQb4oKGM3Eidyb5o2lu4KAA4OOQfQacTDwMBRTZsAibq/q6Hoj/RU/RFzOOsGnB4Uvc8+WNp6ndXP3oarP7k2CzOEk0poi1guPXpM6Ap5GLlYvjW9ZQ0bRWmiaD7eOyP/Ybz5AkQJFGgx4gX8TlG2euezEV0LGOgEg4o8n+/jeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptFMuFuP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so2381053276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728631878; x=1729236678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWiZJfTPLapUUxzEa+muD72ENnNjkYol+7nJvT/EgXk=;
        b=ptFMuFuPx0entnLjS80zmgW3elzKEm/Aj4gm5OLBbVUhAVy8vlPByO12bnzUCgvMjl
         8Mvsu7w9Djj9Qa6vrmHvGP0YWZ2YytOpUc59ujeJiW1SYfQcyCAGD30PypCJPDpYN8Zf
         KAEm6tvUy2OAO+zmGz/q7aN4tF14zLr2cWkgX2xr4AQ4LSKxkF5aHJae5x3GbQhSN8sw
         b4rQccJVEWPRILeu/0ELeHd72058ILZRPH6hQqJV0eSuA/ceP13bzB17mY2E/VC9LLs2
         QKSPy9WHOcXLvi/LjAJhAoLOvwoXwKD7hBrf5sf6nuxJvAt3wc12vjjM/Qt+cEFvEDTE
         L+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631878; x=1729236678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWiZJfTPLapUUxzEa+muD72ENnNjkYol+7nJvT/EgXk=;
        b=JPStyQ3A+cXg5+sQNU+8kvN/LD608YHJtC7CTEeVB/+F0rkkJpZAqkaY4cNkwFGy6F
         /c15xi3nMWC8ccQwiY3Js5ZDuSfzYC9Cq47udDr87+q2lTwYEdnMB7WU2seLK1NWR5j9
         Ozko08iv6cEdJnC/j8lKoRepzZ0QN90wHN8QChjYOkw3GGQz66tTI5dp88i9pI03/d2q
         HJxVgI/eXSYA6yWlmMUpFnV57crXWXiSnZGcyuVE4gZECpL+fvyFzyu3ILwTTvOsWVws
         Ljmf3mevVqgQrhVbrio8/hWQdXKTUkjoCncw/OPU28mlvkQwi2SiOPtlIfEe/IfRxgL1
         /44w==
X-Forwarded-Encrypted: i=1; AJvYcCWleW0XMCOWdQvZVdN9ChLURnr/cXTL7CWWwtbe2YS2X/FUPuuseN4ZQ7reDVl1Wp4B+Fd2Edw/8Oq5nhE9@vger.kernel.org
X-Gm-Message-State: AOJu0YwEy5bEAAZdAUJoe6Wkxvd3ibx+K3ygic7I3mjipkTP71CVBryH
	A8pUNwDSuVYm6e8H84UzPqztMKbKbIYEkoLa9w+Ke9CgRSN4p4xAbmACC/YIqknKgj5ykkLt3iC
	OYryeE6sCGA==
X-Google-Smtp-Source: AGHT+IH88HRjWKEFRlFPrvRyWi6CNyAHWoiq3tZI0/D5MKQO6NSt41vdU9SedDRQU8sIxKWgIVCsJXFxbUnIVQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a25:86d0:0:b0:e28:f485:e000 with SMTP id
 3f1490d57ef6-e2919d5faf9mr1106276.1.1728631878484; Fri, 11 Oct 2024 00:31:18
 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:25:09 +0800
In-Reply-To: <20241011072509.3068328-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011072509.3068328-7-davidgow@google.com>
Subject: [PATCH 5/6] unicode: kunit: refactor selftest to kunit tests
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>, linux-fsdevel@vger.kernel.org, 
	~lkcamp/patches@lists.sr.ht, Pedro Orlando <porlando@lkcamp.dev>, 
	Danilo Pereira <dpereira@lkcamp.dev>, Gabriel Krisman Bertazi <gabriel@krisman.be>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

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
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 fs/unicode/.kunitconfig    |   3 +
 fs/unicode/Kconfig         |   5 +-
 fs/unicode/Makefile        |   2 +-
 fs/unicode/utf8-norm.c     |   2 +-
 fs/unicode/utf8-selftest.c | 149 +++++++++++++++++--------------------
 5 files changed, 77 insertions(+), 84 deletions(-)
 create mode 100644 fs/unicode/.kunitconfig

diff --git a/fs/unicode/.kunitconfig b/fs/unicode/.kunitconfig
new file mode 100644
index 000000000000..62dd5c171f9c
--- /dev/null
+++ b/fs/unicode/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_UNICODE=y
+CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST=y
diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
index da786a687fdc..4ad2c36550f1 100644
--- a/fs/unicode/Kconfig
+++ b/fs/unicode/Kconfig
@@ -10,6 +10,7 @@ config UNICODE
 	  be a separate loadable module that gets requested only when a file
 	  system actually use it.
 
-config UNICODE_NORMALIZATION_SELFTEST
+config UNICODE_NORMALIZATION_KUNIT_TEST
 	tristate "Test UTF-8 normalization support"
-	depends on UNICODE
+	depends on UNICODE && KUNIT
+	default KUNIT_ALL_TESTS
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index e309afe2b2bb..37bbcbc628a1 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
 obj-y			+= unicode.o
 endif
 obj-$(CONFIG_UNICODE)	+= utf8data.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
+obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 768f8ab448b8..7b998c99c88d 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -586,7 +586,7 @@ int utf8byte(struct utf8cursor *u8c)
 	}
 }
 
-#ifdef CONFIG_UNICODE_NORMALIZATION_SELFTEST_MODULE
+#if IS_MODULE(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST)
 EXPORT_SYMBOL_GPL(utf8version_is_supported);
 EXPORT_SYMBOL_GPL(utf8nlen);
 EXPORT_SYMBOL_GPL(utf8ncursor);
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
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/printk.h>
 #include <linux/unicode.h>
-#include <linux/dcache.h>
+#include <kunit/test.h>
 
 #include "utf8n.h"
 
-static unsigned int failed_tests;
-static unsigned int total_tests;
-
 /* Tests will be based on this version. */
 #define UTF8_LATEST	UNICODE_AGE(12, 1, 0)
 
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
-
 static const struct {
 	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
 	unsigned char str[10];
@@ -170,69 +150,74 @@ static int utf8cursor(struct utf8cursor *u8c, const struct unicode_map *um,
 	return utf8ncursor(u8c, um, n, s, (unsigned int)-1);
 }
 
-static void check_utf8_nfdi(struct unicode_map *um)
+static void check_utf8_nfdi(struct kunit *test)
 {
 	int i;
 	struct utf8cursor u8c;
+	struct unicode_map *um = test->priv;
 
 	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 		int len = strlen(nfdi_test_data[i].str);
 		int nlen = strlen(nfdi_test_data[i].dec);
 		int j = 0;
 		unsigned char c;
+		int ret;
 
-		test((utf8len(um, UTF8_NFDI, nfdi_test_data[i].str) == nlen));
-		test((utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len) ==
-			nlen));
+		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDI, nfdi_test_data[i].str), nlen);
+		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len),
+				nlen);
 
-		if (utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str) < 0)
-			pr_err("can't create cursor\n");
+
+		ret = utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str);
+		KUNIT_EXPECT_TRUE_MSG(test, ret >= 0, "Can't create cursor\n");
 
 		while ((c = utf8byte(&u8c)) > 0) {
-			test_f((c == nfdi_test_data[i].dec[j]),
-			       "Unexpected byte 0x%x should be 0x%x\n",
-			       c, nfdi_test_data[i].dec[j]);
+			KUNIT_EXPECT_EQ_MSG(test, c, nfdi_test_data[i].dec[j],
+					    "Unexpected byte 0x%x should be 0x%x\n",
+					    c, nfdi_test_data[i].dec[j]);
 			j++;
 		}
 
-		test((j == nlen));
+		KUNIT_EXPECT_EQ(test, j, nlen);
 	}
 }
 
-static void check_utf8_nfdicf(struct unicode_map *um)
+static void check_utf8_nfdicf(struct kunit *test)
 {
 	int i;
 	struct utf8cursor u8c;
+	struct unicode_map *um = test->priv;
 
 	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
 		int len = strlen(nfdicf_test_data[i].str);
 		int nlen = strlen(nfdicf_test_data[i].ncf);
 		int j = 0;
+		int ret;
 		unsigned char c;
 
-		test((utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str) ==
-				nlen));
-		test((utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len) ==
-				nlen));
+		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str),
+				nlen);
+		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len),
+				nlen);
 
-		if (utf8cursor(&u8c, um, UTF8_NFDICF,
-				nfdicf_test_data[i].str) < 0)
-			pr_err("can't create cursor\n");
+		ret = utf8cursor(&u8c, um, UTF8_NFDICF, nfdicf_test_data[i].str);
+		KUNIT_EXPECT_TRUE_MSG(test, ret >= 0, "Can't create cursor\n");
 
 		while ((c = utf8byte(&u8c)) > 0) {
-			test_f((c == nfdicf_test_data[i].ncf[j]),
-			       "Unexpected byte 0x%x should be 0x%x\n",
-			       c, nfdicf_test_data[i].ncf[j]);
+			KUNIT_EXPECT_EQ_MSG(test, c, nfdicf_test_data[i].ncf[j],
+					    "Unexpected byte 0x%x should be 0x%x\n",
+					    c, nfdicf_test_data[i].ncf[j]);
 			j++;
 		}
 
-		test((j == nlen));
+		KUNIT_EXPECT_EQ(test, j, nlen);
 	}
 }
 
-static void check_utf8_comparisons(struct unicode_map *table)
+static void check_utf8_comparisons(struct kunit *test)
 {
 	int i;
+	struct unicode_map *um = test->priv;
 
 	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 		const struct qstr s1 = {.name = nfdi_test_data[i].str,
@@ -240,8 +225,9 @@ static void check_utf8_comparisons(struct unicode_map *table)
 		const struct qstr s2 = {.name = nfdi_test_data[i].dec,
 					.len = sizeof(nfdi_test_data[i].dec)};
 
-		test_f(!utf8_strncmp(table, &s1, &s2),
-		       "%s %s comparison mismatch\n", s1.name, s2.name);
+		/* strncmp returns 0 when strings are equal */
+		KUNIT_EXPECT_TRUE_MSG(test, utf8_strncmp(um, &s1, &s2) == 0,
+				    "%s %s comparison mismatch\n", s1.name, s2.name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
@@ -250,62 +236,65 @@ static void check_utf8_comparisons(struct unicode_map *table)
 		const struct qstr s2 = {.name = nfdicf_test_data[i].ncf,
 					.len = sizeof(nfdicf_test_data[i].ncf)};
 
-		test_f(!utf8_strncasecmp(table, &s1, &s2),
-		       "%s %s comparison mismatch\n", s1.name, s2.name);
+		/* strncasecmp returns 0 when strings are equal */
+		KUNIT_EXPECT_TRUE_MSG(test, utf8_strncasecmp(um, &s1, &s2) == 0,
+				    "%s %s comparison mismatch\n", s1.name, s2.name);
 	}
 }
 
-static void check_supported_versions(struct unicode_map *um)
+static void check_supported_versions(struct kunit *test)
 {
+	struct unicode_map *um = test->priv;
 	/* Unicode 7.0.0 should be supported. */
-	test(utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
 
 	/* Unicode 9.0.0 should be supported. */
-	test(utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
 
 	/* Unicode 1x.0.0 (the latest version) should be supported. */
-	test(utf8version_is_supported(um, UTF8_LATEST));
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UTF8_LATEST));
 
 	/* Next versions don't exist. */
-	test(!utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
-	test(!utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
-	test(!utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
 }
 
-static int __init init_test_ucd(void)
+static struct kunit_case unicode_normalization_test_cases[] = {
+	KUNIT_CASE(check_supported_versions),
+	KUNIT_CASE(check_utf8_comparisons),
+	KUNIT_CASE(check_utf8_nfdicf),
+	KUNIT_CASE(check_utf8_nfdi),
+	{}
+};
+
+static int init_test_ucd(struct kunit *test)
 {
-	struct unicode_map *um;
+	struct unicode_map *um = utf8_load(UTF8_LATEST);
 
-	failed_tests = 0;
-	total_tests = 0;
+	test->priv = um;
 
-	um = utf8_load(UTF8_LATEST);
-	if (IS_ERR(um)) {
-		pr_err("%s: Unable to load utf8 table.\n", __func__);
-		return PTR_ERR(um);
-	}
+	KUNIT_EXPECT_EQ_MSG(test, IS_ERR(um), 0,
+			    "%s: Unable to load utf8 table.\n", __func__);
 
-	check_supported_versions(um);
-	check_utf8_nfdi(um);
-	check_utf8_nfdicf(um);
-	check_utf8_comparisons(um);
-
-	if (!failed_tests)
-		pr_info("All %u tests passed\n", total_tests);
-	else
-		pr_err("%u out of %u tests failed\n", failed_tests,
-		       total_tests);
-	utf8_unload(um);
 	return 0;
 }
 
-static void __exit exit_test_ucd(void)
+static void exit_test_ucd(struct kunit *test)
 {
+	utf8_unload(test->priv);
 }
 
-module_init(init_test_ucd);
-module_exit(exit_test_ucd);
+static struct kunit_suite unicode_normalization_test_suite = {
+	.name = "unicode_normalization",
+	.test_cases = unicode_normalization_test_cases,
+	.init = init_test_ucd,
+	.exit = exit_test_ucd,
+};
+
+kunit_test_suite(unicode_normalization_test_suite);
+
 
 MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
-MODULE_DESCRIPTION("Kernel module for testing utf-8 support");
+MODULE_DESCRIPTION("KUnit tests for utf-8 support.");
 MODULE_LICENSE("GPL");
-- 
2.47.0.rc1.288.g06298d1525-goog


