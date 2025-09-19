Return-Path: <linux-fsdevel+bounces-62268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49AAB8B969
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 00:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAE53BCC3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 22:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372AE2C3278;
	Fri, 19 Sep 2025 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="HgsBdblI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091927C17C
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322561; cv=none; b=IWRBHPgHjsQ9//ogInjCi4k+sTAiCxlLUpfIiQBkKheOQXcSfue4Xm9NKi1WFNqbCHlaY8v8E/0zGU1o8ClO6o6B7HyThnSptrkysqH0Q7AQLZQNeRjqhokXW16bApdosNzi8X3oXA8Lo29CqkDvl90bpqx8I4ElHPhU51yRGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322561; c=relaxed/simple;
	bh=z7wOd7oheMl0KZ3J171lPfHK+4kyeKRPLn6SJ2ywxKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qmW54aMmF2uoCx7EJoRH+Q68bqNjpSX95EMbfggxyTI9NKb2fEEPZw2W7ggOFJ+N+SW4494Z/gLxzqyCulxZ29ay1Z42wla5SfqwzrvvextPvIfE1XMk7F28NSAqyUsdJx7WKX14K0h50LPCtt5Jht57PzvkJbklQkuXGOGBmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=HgsBdblI; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea3dbcc5410so1940881276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 15:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1758322556; x=1758927356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUFy5Py+d9ZnK15dJ3/Lq63aI/by/GaHqIiafPUmUw8=;
        b=HgsBdblISPN190SrvBX+B88uCeJTzjHtr6/gtKIbkij0CICqBEzuOnU/9SoikC4eH5
         0UR9hSBJ0JrF56c7Wr8jFPFelU+yrRTPNirgFePPAC1uOYHVV26cLJwQtOS12yycO5RE
         c0ithjQFlvQ6D+Kym2OY9/jbw+X2uJi2MfIo0ba9Ov0bg8fcUFG3FaPgHeLXPcLVsM6N
         vFUVBa6cD9EkmDQEW0E3fYpMSNfe892JG/umI9hkqeCzoKRVe5Hy3ZfG4kAgWeQMnoiI
         jYfxUEOnny/gtkdb3OnnIWwkxHziR2FWLa6KEzVFYDady59WEP90d4AMMfwfFmFODctw
         DQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758322556; x=1758927356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUFy5Py+d9ZnK15dJ3/Lq63aI/by/GaHqIiafPUmUw8=;
        b=H6F1YiYqsEHRSE+53Yi3u1AM+izKzDWbJivZ56wnEegl9pbf8FKIE+5crqSm0ABQu+
         RBhc0kjmEE3pFN+5QPM4zLae/MG06vUzhw/TIlL1FvT5verLQ5psOacYQCTDtD0dikcY
         4Gbyv7lNrVjqj861PkVpKrkPM9DcjyyvlWb4KUhyIHEqka3FFwexzHma77zSJlrMHTi3
         xr82NWo1fN+7i8Ni8+8bQVSR1108WAmL79S4fQThlNd8xHYEaGOfooPzl1yzbUNFVdEm
         QXkCPG2ZowScu2h3XXJEuhhgnRJVZ035MTQo1wxIYYDTlvoITxAY9NW8ZSEtBeY9wXGa
         uIrg==
X-Forwarded-Encrypted: i=1; AJvYcCXy6kKrjA4PHq1+iSpg43i5IgZSJQH/8VQdC/JgrTIkLTa2JVg4zdkfsjzXEokdilNHu13nEWej4iSnsJ3/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VIPXm1lNVXAiqEc8V+n1feXIlpbX5zRmRC0LOQ42JKOVFpIt
	beC0A7zH3ed3Ao6RSe1n9weeMobZfSxqj4zRpoNZxamHMg9H8FUv0kPEN1HTM7gQdQE=
X-Gm-Gg: ASbGncuUQJZTTmhtFzYdEElSGKyt9/cXUFbUjMd4x/DyjwYLZW4lTExHWkD7r+mlBD6
	ue5/PXxMRVlDuZbCmeWllBQY/EDWoPdT1iaGSUuyXt9PGMlCtJiYy2ZhMqjoe3uk4MX0yJ9RnLj
	jnTiwK/2LSeWSbZTtEFH5pH9KmuA5SqHJGKX3o9F+OJ1mBWp1BNxmUgnoSbd0XdO8fMhmuEIbGC
	njvHQ/mTznv50X3Q7/HvQl+rX5iKsRf9F5lxDvSm8r0M6s4f4Gfh5/+tzkw8qXHhhUIjGFGsGnU
	tEjpk32JegTWl84WfpbhMAhXaYIyFzhuWU+iBOJ+OwY3A5wy64MZ3PrCRa8Kd/Y9CNeSRC54WeG
	BLIJGjBWdjYPzwe0xt3PMjdYGwEd2f47z
X-Google-Smtp-Source: AGHT+IGQLSKfRliG4pee7RofmLtkPPcyfbvISohTokeKPOcnGO8kq1ZKZAwUH1wDQJWxIYAzs0fvdg==
X-Received: by 2002:a05:690e:2559:b0:633:ba5c:169b with SMTP id 956f58d0204a3-6347f561380mr2908285d50.22.1758322556210;
        Fri, 19 Sep 2025 15:55:56 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:152:c573:a176:c86a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce974212sm2081714276.26.2025.09.19.15.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 15:55:55 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: introduce KUnit tests for HFS+ string operations
Date: Fri, 19 Sep 2025 15:54:38 -0700
Message-Id: <20250919225437.1375789-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch implements the Kunit based set of
unit tests for HFS+ string operations. It checks
functionality of hfsplus_strcasecmp(), hfsplus_strcmp(),
hfsplus_uni2asc(), hfsplus_asc2uni(), hfsplus_hash_dentry(),
and hfsplus_compare_dentry().

./tools/testing/kunit/kunit.py run --kunitconfig ./fs/hfsplus/.kunitconfig
[14:38:05] Configuring KUnit Kernel ...
[14:38:05] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=22
[14:38:09] Starting KUnit Kernel (1/1)...
[14:38:09] ============================================================
Running tests with:
$ .kunit/linux kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
[14:38:09] ============== hfsplus_unicode (27 subtests) ===============
[14:38:09] [PASSED] hfsplus_strcasecmp_test
[14:38:09] [PASSED] hfsplus_strcmp_test
[14:38:09] [PASSED] hfsplus_unicode_edge_cases_test
[14:38:09] [PASSED] hfsplus_unicode_boundary_test
[14:38:09] [PASSED] hfsplus_uni2asc_basic_test
[14:38:09] [PASSED] hfsplus_uni2asc_special_chars_test
[14:38:09] [PASSED] hfsplus_uni2asc_buffer_test
[14:38:09] [PASSED] hfsplus_uni2asc_corrupted_test
[14:38:09] [PASSED] hfsplus_uni2asc_edge_cases_test
[14:38:09] [PASSED] hfsplus_asc2uni_basic_test
[14:38:09] [PASSED] hfsplus_asc2uni_special_chars_test
[14:38:09] [PASSED] hfsplus_asc2uni_buffer_limits_test
[14:38:09] [PASSED] hfsplus_asc2uni_edge_cases_test
[14:38:09] [PASSED] hfsplus_asc2uni_decompose_test
[14:38:09] [PASSED] hfsplus_hash_dentry_basic_test
[14:38:09] [PASSED] hfsplus_hash_dentry_casefold_test
[14:38:09] [PASSED] hfsplus_hash_dentry_special_chars_test
[14:38:09] [PASSED] hfsplus_hash_dentry_decompose_test
[14:38:09] [PASSED] hfsplus_hash_dentry_consistency_test
[14:38:09] [PASSED] hfsplus_hash_dentry_edge_cases_test
[14:38:09] [PASSED] hfsplus_compare_dentry_basic_test
[14:38:09] [PASSED] hfsplus_compare_dentry_casefold_test
[14:38:09] [PASSED] hfsplus_compare_dentry_special_chars_test
[14:38:09] [PASSED] hfsplus_compare_dentry_length_test
[14:38:09] [PASSED] hfsplus_compare_dentry_decompose_test
[14:38:09] [PASSED] hfsplus_compare_dentry_edge_cases_test
[14:38:09] [PASSED] hfsplus_compare_dentry_combined_flags_test
[14:38:09] ================= [PASSED] hfsplus_unicode =================
[14:38:09] ============================================================
[14:38:09] Testing complete. Ran 27 tests: passed: 27
[14:38:09] Elapsed time: 3.875s total, 0.001s configuring, 3.707s building, 0.115s running

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/.kunitconfig   |    8 +
 fs/hfsplus/Kconfig        |   15 +
 fs/hfsplus/Makefile       |    3 +
 fs/hfsplus/unicode.c      |   10 +-
 fs/hfsplus/unicode_test.c | 1291 +++++++++++++++++++++++++++++++++++++
 5 files changed, 1326 insertions(+), 1 deletion(-)
 create mode 100644 fs/hfsplus/.kunitconfig
 create mode 100644 fs/hfsplus/unicode_test.c

diff --git a/fs/hfsplus/.kunitconfig b/fs/hfsplus/.kunitconfig
new file mode 100644
index 000000000000..6c96dc7e872c
--- /dev/null
+++ b/fs/hfsplus/.kunitconfig
@@ -0,0 +1,8 @@
+CONFIG_KUNIT=y
+CONFIG_HFSPLUS_FS=y
+CONFIG_HFSPLUS_KUNIT_TEST=y
+CONFIG_BLOCK=y
+CONFIG_BUFFER_HEAD=y
+CONFIG_NLS=y
+CONFIG_NLS_UTF8=y
+CONFIG_LEGACY_DIRECT_IO=y
diff --git a/fs/hfsplus/Kconfig b/fs/hfsplus/Kconfig
index 8ce4a33a9ac7..ca8401cb6954 100644
--- a/fs/hfsplus/Kconfig
+++ b/fs/hfsplus/Kconfig
@@ -14,3 +14,18 @@ config HFSPLUS_FS
 	  MacOS 8. It includes all Mac specific filesystem data such as
 	  data forks and creator codes, but it also has several UNIX
 	  style features such as file ownership and permissions.
+
+config HFSPLUS_KUNIT_TEST
+	tristate "KUnit tests for HFS+ filesystem" if !KUNIT_ALL_TESTS
+	depends on HFSPLUS_FS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit tests for the HFS+ filesystem.
+
+	  KUnit tests run during boot and output the results to the debug
+	  log in TAP format (https://testanything.org/). Only useful for
+	  kernel devs running KUnit test harness and are not for inclusion
+	  into a production build.
+
+	  For more information on KUnit and unit tests in general please
+	  refer to the KUnit documentation in Documentation/dev-tools/kunit/.
diff --git a/fs/hfsplus/Makefile b/fs/hfsplus/Makefile
index 9ed20e64b983..f2a9ae697e81 100644
--- a/fs/hfsplus/Makefile
+++ b/fs/hfsplus/Makefile
@@ -8,3 +8,6 @@ obj-$(CONFIG_HFSPLUS_FS) += hfsplus.o
 hfsplus-objs := super.o options.o inode.o ioctl.o extents.o catalog.o dir.o btree.o \
 		bnode.o brec.o bfind.o tables.o unicode.o wrapper.o bitmap.o part_tbl.o \
 		attributes.o xattr.o xattr_user.o xattr_security.o xattr_trusted.o
+
+# KUnit tests
+obj-$(CONFIG_HFSPLUS_KUNIT_TEST) += unicode_test.o
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 36b6cf2a3abb..e88b4f8c9b27 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -11,6 +11,9 @@
 
 #include <linux/types.h>
 #include <linux/nls.h>
+
+#include <kunit/visibility.h>
+
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
@@ -60,6 +63,7 @@ int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
 			return 0;
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(hfsplus_strcasecmp);
 
 /* Compare names as a sequence of 16-bit unsigned integers */
 int hfsplus_strcmp(const struct hfsplus_unistr *s1,
@@ -86,7 +90,7 @@ int hfsplus_strcmp(const struct hfsplus_unistr *s1,
 	return len1 < len2 ? -1 :
 	       len1 > len2 ? 1 : 0;
 }
-
+EXPORT_SYMBOL_IF_KUNIT(hfsplus_strcmp);
 
 #define Hangul_SBase	0xac00
 #define Hangul_LBase	0x1100
@@ -255,6 +259,7 @@ int hfsplus_uni2asc(struct super_block *sb,
 	*len_p = (char *)op - astr;
 	return res;
 }
+EXPORT_SYMBOL_IF_KUNIT(hfsplus_uni2asc);
 
 /*
  * Convert one or more ASCII characters into a single unicode character.
@@ -382,6 +387,7 @@ int hfsplus_asc2uni(struct super_block *sb,
 		return -ENAMETOOLONG;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(hfsplus_asc2uni);
 
 /*
  * Hash a string to an integer as appropriate for the HFS+ filesystem.
@@ -434,6 +440,7 @@ int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str)
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(hfsplus_hash_dentry);
 
 /*
  * Compare strings with HFS+ filename ordering.
@@ -525,3 +532,4 @@ int hfsplus_compare_dentry(const struct dentry *dentry,
 		return 1;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(hfsplus_compare_dentry);
diff --git a/fs/hfsplus/unicode_test.c b/fs/hfsplus/unicode_test.c
new file mode 100644
index 000000000000..bee5b77692f4
--- /dev/null
+++ b/fs/hfsplus/unicode_test.c
@@ -0,0 +1,1291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for HFS+ Unicode string operations
+ *
+ * Copyright (C) 2025 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/nls.h>
+#include <linux/dcache.h>
+#include <linux/stringhash.h>
+#include "hfsplus_fs.h"
+
+/* Helper function to create hfsplus_unistr */
+static void create_unistr(struct hfsplus_unistr *ustr, const char *ascii_str)
+{
+	int len = strlen(ascii_str);
+	int i;
+
+	memset(ustr->unicode, 0, sizeof(ustr->unicode));
+
+	ustr->length = cpu_to_be16(len);
+	for (i = 0; i < len && i < HFSPLUS_MAX_STRLEN; i++)
+		ustr->unicode[i] = cpu_to_be16((u16)ascii_str[i]);
+}
+
+static void corrupt_unistr(struct hfsplus_unistr *ustr)
+{
+	ustr->length = cpu_to_be16(U16_MAX);
+}
+
+/* Test hfsplus_strcasecmp function */
+static void hfsplus_strcasecmp_test(struct kunit *test)
+{
+	struct hfsplus_unistr str1, str2;
+	char long_str[HFSPLUS_MAX_STRLEN + 1];
+
+	/* Test identical strings */
+	create_unistr(&str1, "hello");
+	create_unistr(&str2, "hello");
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcasecmp(&str1, &str2));
+
+	/* Test case insensitive comparison */
+	create_unistr(&str1, "Hello");
+	create_unistr(&str2, "hello");
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcasecmp(&str1, &str2));
+
+	create_unistr(&str1, "HELLO");
+	create_unistr(&str2, "hello");
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcasecmp(&str1, &str2));
+
+	/* Test different strings */
+	create_unistr(&str1, "apple");
+	create_unistr(&str2, "banana");
+	KUNIT_EXPECT_LT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+
+	create_unistr(&str1, "zebra");
+	create_unistr(&str2, "apple");
+	KUNIT_EXPECT_GT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+
+	/* Test different lengths */
+	create_unistr(&str1, "test");
+	create_unistr(&str2, "testing");
+	KUNIT_EXPECT_LT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+
+	create_unistr(&str1, "testing");
+	create_unistr(&str2, "test");
+	KUNIT_EXPECT_GT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+
+	/* Test empty strings */
+	create_unistr(&str1, "");
+	create_unistr(&str2, "");
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcasecmp(&str1, &str2));
+
+	create_unistr(&str1, "");
+	create_unistr(&str2, "test");
+	KUNIT_EXPECT_LT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+
+	/* Test single characters */
+	create_unistr(&str1, "A");
+	create_unistr(&str2, "a");
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcasecmp(&str1, &str2));
+
+	create_unistr(&str1, "A");
+	create_unistr(&str2, "B");
+	KUNIT_EXPECT_LT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+
+	/* Test maximum length strings */
+	memset(long_str, 'a', HFSPLUS_MAX_STRLEN);
+	long_str[HFSPLUS_MAX_STRLEN] = '\0';
+	create_unistr(&str1, long_str);
+	create_unistr(&str2, long_str);
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcasecmp(&str1, &str2));
+
+	/* Change one character in the middle */
+	long_str[HFSPLUS_MAX_STRLEN / 2] = 'b';
+	create_unistr(&str2, long_str);
+	KUNIT_EXPECT_LT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+
+	/* Test corrupted strings */
+	create_unistr(&str1, "");
+	corrupt_unistr(&str1);
+	create_unistr(&str2, "");
+	KUNIT_EXPECT_NE(test, 0, hfsplus_strcasecmp(&str1, &str2));
+
+	create_unistr(&str1, "");
+	create_unistr(&str2, "");
+	corrupt_unistr(&str2);
+	KUNIT_EXPECT_NE(test, 0, hfsplus_strcasecmp(&str1, &str2));
+
+	create_unistr(&str1, "test");
+	corrupt_unistr(&str1);
+	create_unistr(&str2, "testing");
+	KUNIT_EXPECT_GT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+
+	create_unistr(&str1, "test");
+	create_unistr(&str2, "testing");
+	corrupt_unistr(&str2);
+	KUNIT_EXPECT_LT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+
+	create_unistr(&str1, "testing");
+	corrupt_unistr(&str1);
+	create_unistr(&str2, "test");
+	KUNIT_EXPECT_GT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+
+	create_unistr(&str1, "testing");
+	create_unistr(&str2, "test");
+	corrupt_unistr(&str2);
+	KUNIT_EXPECT_LT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+}
+
+/* Test hfsplus_strcmp function (case-sensitive) */
+static void hfsplus_strcmp_test(struct kunit *test)
+{
+	struct hfsplus_unistr str1, str2;
+	char long_str[HFSPLUS_MAX_STRLEN + 1];
+
+	/* Test identical strings */
+	create_unistr(&str1, "hello");
+	create_unistr(&str2, "hello");
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcmp(&str1, &str2));
+
+	/* Test case sensitive comparison - should NOT be equal */
+	create_unistr(&str1, "Hello");
+	create_unistr(&str2, "hello");
+	KUNIT_EXPECT_NE(test, 0, hfsplus_strcmp(&str1, &str2));
+	KUNIT_EXPECT_LT(test, hfsplus_strcmp(&str1, &str2), 0); /* 'H' < 'h' in Unicode */
+
+	/* Test lexicographic ordering */
+	create_unistr(&str1, "apple");
+	create_unistr(&str2, "banana");
+	KUNIT_EXPECT_LT(test, hfsplus_strcmp(&str1, &str2), 0);
+
+	create_unistr(&str1, "zebra");
+	create_unistr(&str2, "apple");
+	KUNIT_EXPECT_GT(test, hfsplus_strcmp(&str1, &str2), 0);
+
+	/* Test different lengths with common prefix */
+	create_unistr(&str1, "test");
+	create_unistr(&str2, "testing");
+	KUNIT_EXPECT_LT(test, hfsplus_strcmp(&str1, &str2), 0);
+
+	create_unistr(&str1, "testing");
+	create_unistr(&str2, "test");
+	KUNIT_EXPECT_GT(test, hfsplus_strcmp(&str1, &str2), 0);
+
+	/* Test empty strings */
+	create_unistr(&str1, "");
+	create_unistr(&str2, "");
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcmp(&str1, &str2));
+
+	/* Test maximum length strings */
+	memset(long_str, 'a', HFSPLUS_MAX_STRLEN);
+	long_str[HFSPLUS_MAX_STRLEN] = '\0';
+	create_unistr(&str1, long_str);
+	create_unistr(&str2, long_str);
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcmp(&str1, &str2));
+
+	/* Change one character in the middle */
+	long_str[HFSPLUS_MAX_STRLEN / 2] = 'b';
+	create_unistr(&str2, long_str);
+	KUNIT_EXPECT_LT(test, hfsplus_strcmp(&str1, &str2), 0);
+
+	/* Test corrupted strings */
+	create_unistr(&str1, "");
+	corrupt_unistr(&str1);
+	create_unistr(&str2, "");
+	KUNIT_EXPECT_NE(test, 0, hfsplus_strcmp(&str1, &str2));
+
+	create_unistr(&str1, "");
+	create_unistr(&str2, "");
+	corrupt_unistr(&str2);
+	KUNIT_EXPECT_NE(test, 0, hfsplus_strcmp(&str1, &str2));
+
+	create_unistr(&str1, "test");
+	corrupt_unistr(&str1);
+	create_unistr(&str2, "testing");
+	KUNIT_EXPECT_LT(test, hfsplus_strcmp(&str1, &str2), 0);
+
+	create_unistr(&str1, "test");
+	create_unistr(&str2, "testing");
+	corrupt_unistr(&str2);
+	KUNIT_EXPECT_LT(test, hfsplus_strcmp(&str1, &str2), 0);
+
+	create_unistr(&str1, "testing");
+	corrupt_unistr(&str1);
+	create_unistr(&str2, "test");
+	KUNIT_EXPECT_GT(test, hfsplus_strcmp(&str1, &str2), 0);
+
+	create_unistr(&str1, "testing");
+	create_unistr(&str2, "test");
+	corrupt_unistr(&str2);
+	KUNIT_EXPECT_GT(test, hfsplus_strcmp(&str1, &str2), 0);
+}
+
+/* Test Unicode edge cases */
+static void hfsplus_unicode_edge_cases_test(struct kunit *test)
+{
+	struct hfsplus_unistr str1, str2;
+
+	/* Test with special characters */
+	str1.length = cpu_to_be16(3);
+	str1.unicode[0] = cpu_to_be16(0x00E9); /* é */
+	str1.unicode[1] = cpu_to_be16(0x00F1); /* ñ */
+	str1.unicode[2] = cpu_to_be16(0x00FC); /* ü */
+
+	str2.length = cpu_to_be16(3);
+	str2.unicode[0] = cpu_to_be16(0x00E9); /* é */
+	str2.unicode[1] = cpu_to_be16(0x00F1); /* ñ */
+	str2.unicode[2] = cpu_to_be16(0x00FC); /* ü */
+
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcmp(&str1, &str2));
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcasecmp(&str1, &str2));
+
+	/* Test with different special characters */
+	str2.unicode[1] = cpu_to_be16(0x00F2); /* ò */
+	KUNIT_EXPECT_NE(test, 0, hfsplus_strcmp(&str1, &str2));
+
+	/* Test null characters within string (should be handled correctly) */
+	str1.length = cpu_to_be16(3);
+	str1.unicode[0] = cpu_to_be16('a');
+	str1.unicode[1] = cpu_to_be16(0x0000); /* null */
+	str1.unicode[2] = cpu_to_be16('b');
+
+	str2.length = cpu_to_be16(3);
+	str2.unicode[0] = cpu_to_be16('a');
+	str2.unicode[1] = cpu_to_be16(0x0000); /* null */
+	str2.unicode[2] = cpu_to_be16('b');
+
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcmp(&str1, &str2));
+}
+
+/* Test boundary conditions */
+static void hfsplus_unicode_boundary_test(struct kunit *test)
+{
+	struct hfsplus_unistr str1, str2;
+	int i;
+
+	/* Test maximum length boundary */
+	str1.length = cpu_to_be16(HFSPLUS_MAX_STRLEN);
+	str2.length = cpu_to_be16(HFSPLUS_MAX_STRLEN);
+
+	for (i = 0; i < HFSPLUS_MAX_STRLEN; i++) {
+		str1.unicode[i] = cpu_to_be16('A');
+		str2.unicode[i] = cpu_to_be16('A');
+	}
+
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcmp(&str1, &str2));
+
+	/* Change last character */
+	str2.unicode[HFSPLUS_MAX_STRLEN - 1] = cpu_to_be16('B');
+	KUNIT_EXPECT_LT(test, hfsplus_strcmp(&str1, &str2), 0);
+
+	/* Test zero length strings */
+	str1.length = cpu_to_be16(0);
+	str2.length = cpu_to_be16(0);
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcmp(&str1, &str2));
+	KUNIT_EXPECT_EQ(test, 0, hfsplus_strcasecmp(&str1, &str2));
+
+	/* Test one character vs empty */
+	str1.length = cpu_to_be16(1);
+	str1.unicode[0] = cpu_to_be16('A');
+	str2.length = cpu_to_be16(0);
+	KUNIT_EXPECT_GT(test, hfsplus_strcmp(&str1, &str2), 0);
+	KUNIT_EXPECT_GT(test, hfsplus_strcasecmp(&str1, &str2), 0);
+}
+
+/* Mock superblock and NLS table for testing hfsplus_uni2asc */
+static struct nls_table test_nls;
+static struct hfsplus_sb_info test_sb_info;
+static struct super_block test_sb;
+
+static void setup_mock_sb(void)
+{
+	memset(&test_nls, 0, sizeof(test_nls));
+	memset(&test_sb_info, 0, sizeof(test_sb_info));
+	memset(&test_sb, 0, sizeof(test_sb));
+
+	test_nls.charset = "utf8";
+	test_nls.uni2char = NULL; /* Will use default behavior */
+	test_sb_info.nls = &test_nls;
+	test_sb.s_fs_info = &test_sb_info;
+
+	/* Set default flags - no decomposition, no case folding */
+	clear_bit(HFSPLUS_SB_NODECOMPOSE, &test_sb_info.flags);
+	clear_bit(HFSPLUS_SB_CASEFOLD, &test_sb_info.flags);
+}
+
+/* Simple uni2char implementation for testing */
+static int test_uni2char(wchar_t uni, unsigned char *out, int boundlen)
+{
+	if (boundlen <= 0)
+		return -ENAMETOOLONG;
+
+	if (uni < 0x80) {
+		*out = (unsigned char)uni;
+		return 1;
+	}
+
+	/* For non-ASCII, just use '?' as fallback */
+	*out = '?';
+	return 1;
+}
+
+/* Test hfsplus_uni2asc basic functionality */
+static void hfsplus_uni2asc_basic_test(struct kunit *test)
+{
+	struct hfsplus_unistr ustr;
+	char astr[256];
+	int len, result;
+
+	setup_mock_sb();
+	test_nls.uni2char = test_uni2char;
+
+	/* Test simple ASCII string conversion */
+	create_unistr(&ustr, "hello");
+	len = sizeof(astr);
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 5, len);
+	KUNIT_EXPECT_STREQ(test, "hello", astr);
+
+	/* Test empty string */
+	create_unistr(&ustr, "");
+	len = sizeof(astr);
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 0, len);
+
+	/* Test single character */
+	create_unistr(&ustr, "A");
+	len = sizeof(astr);
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 1, len);
+	KUNIT_EXPECT_EQ(test, 'A', astr[0]);
+}
+
+/* Test special character handling */
+static void hfsplus_uni2asc_special_chars_test(struct kunit *test)
+{
+	struct hfsplus_unistr ustr;
+	char astr[256];
+	int len, result;
+
+	setup_mock_sb();
+	test_nls.uni2char = test_uni2char;
+
+	/* Test null character conversion (should become 0x2400) */
+	ustr.length = cpu_to_be16(1);
+	ustr.unicode[0] = cpu_to_be16(0x0000);
+	len = sizeof(astr);
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 1, len);
+	/* Our test implementation returns '?' for non-ASCII */
+	KUNIT_EXPECT_EQ(test, '?', astr[0]);
+
+	/* Test forward slash conversion (should become colon) */
+	ustr.length = cpu_to_be16(1);
+	ustr.unicode[0] = cpu_to_be16('/');
+	len = sizeof(astr);
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 1, len);
+	KUNIT_EXPECT_EQ(test, ':', astr[0]);
+
+	/* Test string with mixed special characters */
+	ustr.length = cpu_to_be16(3);
+	ustr.unicode[0] = cpu_to_be16('a');
+	ustr.unicode[1] = cpu_to_be16('/');
+	ustr.unicode[2] = cpu_to_be16('b');
+	len = sizeof(astr);
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 3, len);
+	KUNIT_EXPECT_EQ(test, 'a', astr[0]);
+	KUNIT_EXPECT_EQ(test, ':', astr[1]);
+	KUNIT_EXPECT_EQ(test, 'b', astr[2]);
+}
+
+/* Test buffer length handling */
+static void hfsplus_uni2asc_buffer_test(struct kunit *test)
+{
+	struct hfsplus_unistr ustr;
+	char astr[10];
+	int len, result;
+
+	setup_mock_sb();
+	test_nls.uni2char = test_uni2char;
+
+	/* Test insufficient buffer space */
+	create_unistr(&ustr, "toolongstring");
+	len = 5; /* Buffer too small */
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, -ENAMETOOLONG, result);
+	KUNIT_EXPECT_EQ(test, 5, len); /* Should be set to consumed length */
+
+	/* Test exact buffer size */
+	create_unistr(&ustr, "exact");
+	len = 5;
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 5, len);
+
+	/* Test zero length buffer */
+	create_unistr(&ustr, "test");
+	len = 0;
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, -ENAMETOOLONG, result);
+	KUNIT_EXPECT_EQ(test, 0, len);
+}
+
+/* Test corrupted unicode string handling */
+static void hfsplus_uni2asc_corrupted_test(struct kunit *test)
+{
+	struct hfsplus_unistr ustr;
+	char astr[256];
+	int len, result;
+
+	setup_mock_sb();
+	test_nls.uni2char = test_uni2char;
+
+	/* Test corrupted length (too large) */
+	create_unistr(&ustr, "test");
+	corrupt_unistr(&ustr); /* Sets length to U16_MAX */
+	len = sizeof(astr);
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	/* Should still work but with corrected length */
+	KUNIT_EXPECT_EQ(test, 0, result);
+	/*
+	 * Length should be corrected to HFSPLUS_MAX_STRLEN
+	 * and processed accordingly
+	 */
+	KUNIT_EXPECT_GT(test, len, 0);
+}
+
+/* Test edge cases and boundary conditions */
+static void hfsplus_uni2asc_edge_cases_test(struct kunit *test)
+{
+	struct hfsplus_unistr ustr;
+	char astr[HFSPLUS_MAX_STRLEN * 2];
+	int len, result;
+	int i;
+
+	setup_mock_sb();
+	test_nls.uni2char = test_uni2char;
+
+	/* Test maximum length string */
+	ustr.length = cpu_to_be16(HFSPLUS_MAX_STRLEN);
+	for (i = 0; i < HFSPLUS_MAX_STRLEN; i++)
+		ustr.unicode[i] = cpu_to_be16('a');
+
+	len = sizeof(astr);
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, HFSPLUS_MAX_STRLEN, len);
+
+	/* Verify all characters are 'a' */
+	for (i = 0; i < HFSPLUS_MAX_STRLEN; i++)
+		KUNIT_EXPECT_EQ(test, 'a', astr[i]);
+
+	/* Test string with high Unicode values (non-ASCII) */
+	ustr.length = cpu_to_be16(3);
+	ustr.unicode[0] = cpu_to_be16(0x00E9); /* é */
+	ustr.unicode[1] = cpu_to_be16(0x00F1); /* ñ */
+	ustr.unicode[2] = cpu_to_be16(0x00FC); /* ü */
+	len = sizeof(astr);
+	result = hfsplus_uni2asc(&test_sb, &ustr, astr, &len);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 3, len);
+	/* Our test implementation converts non-ASCII to '?' */
+	KUNIT_EXPECT_EQ(test, '?', astr[0]);
+	KUNIT_EXPECT_EQ(test, '?', astr[1]);
+	KUNIT_EXPECT_EQ(test, '?', astr[2]);
+}
+
+/* Simple char2uni implementation for testing */
+static int test_char2uni(const unsigned char *rawstring,
+			 int boundlen, wchar_t *uni)
+{
+	if (boundlen <= 0)
+		return -EINVAL;
+
+	*uni = (wchar_t)*rawstring;
+	return 1;
+}
+
+/* Helper function to check unicode string contents */
+static void check_unistr_content(struct kunit *test,
+				 struct hfsplus_unistr *ustr,
+				 const char *expected_ascii)
+{
+	int expected_len = strlen(expected_ascii);
+	int actual_len = be16_to_cpu(ustr->length);
+	int i;
+
+	KUNIT_EXPECT_EQ(test, expected_len, actual_len);
+
+	for (i = 0; i < expected_len && i < actual_len; i++) {
+		u16 expected_char = (u16)expected_ascii[i];
+		u16 actual_char = be16_to_cpu(ustr->unicode[i]);
+
+		KUNIT_EXPECT_EQ(test, expected_char, actual_char);
+	}
+}
+
+/* Test hfsplus_asc2uni basic functionality */
+static void hfsplus_asc2uni_basic_test(struct kunit *test)
+{
+	struct hfsplus_unistr ustr;
+	int result;
+
+	setup_mock_sb();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test simple ASCII string conversion */
+	result = hfsplus_asc2uni(&test_sb,
+				 &ustr, HFSPLUS_MAX_STRLEN, "hello", 5);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	check_unistr_content(test, &ustr, "hello");
+
+	/* Test empty string */
+	result = hfsplus_asc2uni(&test_sb,
+				 &ustr, HFSPLUS_MAX_STRLEN, "", 0);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 0, be16_to_cpu(ustr.length));
+
+	/* Test single character */
+	result = hfsplus_asc2uni(&test_sb,
+				 &ustr, HFSPLUS_MAX_STRLEN, "A", 1);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	check_unistr_content(test, &ustr, "A");
+
+	/* Test null-terminated string with explicit length */
+	result = hfsplus_asc2uni(&test_sb,
+				 &ustr, HFSPLUS_MAX_STRLEN, "test\0extra", 4);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	check_unistr_content(test, &ustr, "test");
+}
+
+/* Test special character handling in asc2uni */
+static void hfsplus_asc2uni_special_chars_test(struct kunit *test)
+{
+	struct hfsplus_unistr ustr;
+	int result;
+
+	setup_mock_sb();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test colon conversion (should become forward slash) */
+	result = hfsplus_asc2uni(&test_sb, &ustr, HFSPLUS_MAX_STRLEN, ":", 1);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 1, be16_to_cpu(ustr.length));
+	KUNIT_EXPECT_EQ(test, '/', be16_to_cpu(ustr.unicode[0]));
+
+	/* Test string with mixed special characters */
+	result = hfsplus_asc2uni(&test_sb, &ustr, HFSPLUS_MAX_STRLEN, "a:b", 3);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 3, be16_to_cpu(ustr.length));
+	KUNIT_EXPECT_EQ(test, 'a', be16_to_cpu(ustr.unicode[0]));
+	KUNIT_EXPECT_EQ(test, '/', be16_to_cpu(ustr.unicode[1]));
+	KUNIT_EXPECT_EQ(test, 'b', be16_to_cpu(ustr.unicode[2]));
+
+	/* Test multiple special characters */
+	result = hfsplus_asc2uni(&test_sb, &ustr, HFSPLUS_MAX_STRLEN, ":::", 3);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 3, be16_to_cpu(ustr.length));
+	KUNIT_EXPECT_EQ(test, '/', be16_to_cpu(ustr.unicode[0]));
+	KUNIT_EXPECT_EQ(test, '/', be16_to_cpu(ustr.unicode[1]));
+	KUNIT_EXPECT_EQ(test, '/', be16_to_cpu(ustr.unicode[2]));
+}
+
+/* Test buffer length limits */
+static void hfsplus_asc2uni_buffer_limits_test(struct kunit *test)
+{
+	struct hfsplus_unistr ustr;
+	int result;
+	char long_string[HFSPLUS_MAX_STRLEN + 10];
+
+	setup_mock_sb();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test exact maximum length */
+	memset(long_string, 'a', HFSPLUS_MAX_STRLEN);
+	result = hfsplus_asc2uni(&test_sb, &ustr, HFSPLUS_MAX_STRLEN,
+				 long_string, HFSPLUS_MAX_STRLEN);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, HFSPLUS_MAX_STRLEN, be16_to_cpu(ustr.length));
+
+	/* Test exceeding maximum length */
+	memset(long_string, 'a', HFSPLUS_MAX_STRLEN + 5);
+	result = hfsplus_asc2uni(&test_sb, &ustr, HFSPLUS_MAX_STRLEN,
+				 long_string, HFSPLUS_MAX_STRLEN + 5);
+
+	KUNIT_EXPECT_EQ(test, -ENAMETOOLONG, result);
+	KUNIT_EXPECT_EQ(test, HFSPLUS_MAX_STRLEN, be16_to_cpu(ustr.length));
+
+	/* Test with smaller max_unistr_len */
+	result = hfsplus_asc2uni(&test_sb, &ustr, 5, "toolongstring", 13);
+
+	KUNIT_EXPECT_EQ(test, -ENAMETOOLONG, result);
+	KUNIT_EXPECT_EQ(test, 5, be16_to_cpu(ustr.length));
+
+	/* Test zero max length */
+	result = hfsplus_asc2uni(&test_sb, &ustr, 0, "test", 4);
+
+	KUNIT_EXPECT_EQ(test, -ENAMETOOLONG, result);
+	KUNIT_EXPECT_EQ(test, 0, be16_to_cpu(ustr.length));
+}
+
+/* Test error handling and edge cases */
+static void hfsplus_asc2uni_edge_cases_test(struct kunit *test)
+{
+	struct hfsplus_unistr ustr;
+	char test_str[] = {'a', '\0', 'b'};
+	int result;
+
+	setup_mock_sb();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test zero length input */
+	result = hfsplus_asc2uni(&test_sb,
+				 &ustr, HFSPLUS_MAX_STRLEN, "test", 0);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 0, be16_to_cpu(ustr.length));
+
+	/* Test input with length mismatch */
+	result = hfsplus_asc2uni(&test_sb,
+				 &ustr, HFSPLUS_MAX_STRLEN, "hello", 3);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	check_unistr_content(test, &ustr, "hel");
+
+	/* Test with various printable ASCII characters */
+	result = hfsplus_asc2uni(&test_sb,
+				 &ustr, HFSPLUS_MAX_STRLEN, "ABC123!@#", 9);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	check_unistr_content(test, &ustr, "ABC123!@#");
+
+	/* Test null character in the middle */
+	result = hfsplus_asc2uni(&test_sb,
+				 &ustr, HFSPLUS_MAX_STRLEN, test_str, 3);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 3, be16_to_cpu(ustr.length));
+	KUNIT_EXPECT_EQ(test, 'a', be16_to_cpu(ustr.unicode[0]));
+	KUNIT_EXPECT_EQ(test, 0, be16_to_cpu(ustr.unicode[1]));
+	KUNIT_EXPECT_EQ(test, 'b', be16_to_cpu(ustr.unicode[2]));
+}
+
+/* Test decomposition flag behavior */
+static void hfsplus_asc2uni_decompose_test(struct kunit *test)
+{
+	struct hfsplus_unistr ustr1, ustr2;
+	int result;
+
+	setup_mock_sb();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test with decomposition disabled (default) */
+	clear_bit(HFSPLUS_SB_NODECOMPOSE, &test_sb_info.flags);
+	result = hfsplus_asc2uni(&test_sb,
+				 &ustr1, HFSPLUS_MAX_STRLEN, "test", 4);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	check_unistr_content(test, &ustr1, "test");
+
+	/* Test with decomposition enabled */
+	set_bit(HFSPLUS_SB_NODECOMPOSE, &test_sb_info.flags);
+	result = hfsplus_asc2uni(&test_sb,
+				 &ustr2, HFSPLUS_MAX_STRLEN, "test", 4);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	check_unistr_content(test, &ustr2, "test");
+
+	/* For simple ASCII, both should produce the same result */
+	KUNIT_EXPECT_EQ(test,
+			be16_to_cpu(ustr1.length), be16_to_cpu(ustr2.length));
+}
+
+/* Mock dentry for testing hfsplus_hash_dentry */
+static struct dentry test_dentry;
+
+static void setup_mock_dentry(void)
+{
+	memset(&test_dentry, 0, sizeof(test_dentry));
+	test_dentry.d_sb = &test_sb;
+}
+
+/* Helper function to create qstr */
+static void create_qstr(struct qstr *str, const char *name)
+{
+	str->name = name;
+	str->len = strlen(name);
+	str->hash = 0; /* Will be set by hash function */
+}
+
+/* Test hfsplus_hash_dentry basic functionality */
+static void hfsplus_hash_dentry_basic_test(struct kunit *test)
+{
+	struct qstr str1, str2;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test basic string hashing */
+	create_qstr(&str1, "hello");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_NE(test, 0, str1.hash);
+
+	/* Test that identical strings produce identical hashes */
+	create_qstr(&str2, "hello");
+	result = hfsplus_hash_dentry(&test_dentry, &str2);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, str1.hash, str2.hash);
+
+	/* Test empty string */
+	create_qstr(&str1, "");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+
+	/* Empty string should still produce a hash */
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test single character */
+	create_qstr(&str1, "A");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_NE(test, 0, str1.hash);
+}
+
+/* Test case folding behavior in hash */
+static void hfsplus_hash_dentry_casefold_test(struct kunit *test)
+{
+	struct qstr str1, str2;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test with case folding disabled (default) */
+	clear_bit(HFSPLUS_SB_CASEFOLD, &test_sb_info.flags);
+
+	create_qstr(&str1, "Hello");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	create_qstr(&str2, "hello");
+	result = hfsplus_hash_dentry(&test_dentry, &str2);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/*
+	 * Without case folding, different cases
+	 * should produce different hashes
+	 */
+	KUNIT_EXPECT_NE(test, str1.hash, str2.hash);
+
+	/* Test with case folding enabled */
+	set_bit(HFSPLUS_SB_CASEFOLD, &test_sb_info.flags);
+
+	create_qstr(&str1, "Hello");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	create_qstr(&str2, "hello");
+	result = hfsplus_hash_dentry(&test_dentry, &str2);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* With case folding, different cases should produce same hash */
+	KUNIT_EXPECT_EQ(test, str1.hash, str2.hash);
+
+	/* Test mixed case */
+	create_qstr(&str1, "HeLLo");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, str1.hash, str2.hash);
+}
+
+/* Test special character handling in hash */
+static void hfsplus_hash_dentry_special_chars_test(struct kunit *test)
+{
+	struct qstr str1, str2;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test colon conversion (: becomes /) */
+	create_qstr(&str1, "file:name");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	create_qstr(&str2, "file/name");
+	result = hfsplus_hash_dentry(&test_dentry, &str2);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* After conversion, these should produce the same hash */
+	KUNIT_EXPECT_EQ(test, str1.hash, str2.hash);
+
+	/* Test multiple special characters */
+	create_qstr(&str1, ":::");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	create_qstr(&str2, "///");
+	result = hfsplus_hash_dentry(&test_dentry, &str2);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	KUNIT_EXPECT_EQ(test, str1.hash, str2.hash);
+}
+
+/* Test decomposition flag behavior in hash */
+static void hfsplus_hash_dentry_decompose_test(struct kunit *test)
+{
+	struct qstr str1, str2;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test with decomposition disabled (default) */
+	clear_bit(HFSPLUS_SB_NODECOMPOSE, &test_sb_info.flags);
+
+	create_qstr(&str1, "test");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test with decomposition enabled */
+	set_bit(HFSPLUS_SB_NODECOMPOSE, &test_sb_info.flags);
+
+	create_qstr(&str2, "test");
+	result = hfsplus_hash_dentry(&test_dentry, &str2);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/*
+	 * For simple ASCII, decomposition shouldn't change
+	 * the hash much but the function should still work correctly
+	 */
+	KUNIT_EXPECT_NE(test, 0, str2.hash);
+}
+
+/* Test hash consistency and distribution */
+static void hfsplus_hash_dentry_consistency_test(struct kunit *test)
+{
+	struct qstr str1, str2, str3;
+	unsigned long hash1;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test that same string always produces same hash */
+	create_qstr(&str1, "consistent");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+	KUNIT_EXPECT_EQ(test, 0, result);
+	hash1 = str1.hash;
+
+	create_qstr(&str2, "consistent");
+	result = hfsplus_hash_dentry(&test_dentry, &str2);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	KUNIT_EXPECT_EQ(test, hash1, str2.hash);
+
+	/* Test that different strings produce different hashes */
+	create_qstr(&str3, "different");
+	result = hfsplus_hash_dentry(&test_dentry, &str3);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	KUNIT_EXPECT_NE(test, str1.hash, str3.hash);
+
+	/* Test similar strings should have different hashes */
+	create_qstr(&str1, "file1");
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	create_qstr(&str2, "file2");
+	result = hfsplus_hash_dentry(&test_dentry, &str2);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	KUNIT_EXPECT_NE(test, str1.hash, str2.hash);
+}
+
+/* Test edge cases and boundary conditions */
+static void hfsplus_hash_dentry_edge_cases_test(struct kunit *test)
+{
+	struct qstr str;
+	int result;
+	char long_name[256];
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test very long filename */
+	memset(long_name, 'a', sizeof(long_name) - 1);
+	long_name[sizeof(long_name) - 1] = '\0';
+
+	create_qstr(&str, long_name);
+	result = hfsplus_hash_dentry(&test_dentry, &str);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_NE(test, 0, str.hash);
+
+	/* Test filename with all printable ASCII characters */
+	create_qstr(&str, "!@#$%^&*()_+-=[]{}|;':\",./<>?");
+	result = hfsplus_hash_dentry(&test_dentry, &str);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_NE(test, 0, str.hash);
+
+	/* Test with embedded null (though not typical for filenames) */
+	str.name = "file\0hidden";
+	str.len = 11; /* Include the null and text after it */
+	str.hash = 0;
+	result = hfsplus_hash_dentry(&test_dentry, &str);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_NE(test, 0, str.hash);
+}
+
+/* Test hfsplus_compare_dentry basic functionality */
+static void hfsplus_compare_dentry_basic_test(struct kunit *test)
+{
+	struct qstr name;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test identical strings */
+	create_qstr(&name, "hello");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "hello", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test different strings - lexicographic order */
+	create_qstr(&name, "world");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "hello", &name);
+	KUNIT_EXPECT_LT(test, result, 0); /* "hello" < "world" */
+
+	result = hfsplus_compare_dentry(&test_dentry, 5, "world", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	create_qstr(&name, "hello");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "world", &name);
+	KUNIT_EXPECT_GT(test, result, 0); /* "world" > "hello" */
+
+	/* Test empty strings */
+	create_qstr(&name, "");
+	result = hfsplus_compare_dentry(&test_dentry, 0, "", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test one empty, one non-empty */
+	create_qstr(&name, "test");
+	result = hfsplus_compare_dentry(&test_dentry, 0, "", &name);
+	KUNIT_EXPECT_LT(test, result, 0); /* "" < "test" */
+
+	create_qstr(&name, "");
+	result = hfsplus_compare_dentry(&test_dentry, 4, "test", &name);
+	KUNIT_EXPECT_GT(test, result, 0); /* "test" > "" */
+}
+
+/* Test case folding behavior in comparison */
+static void hfsplus_compare_dentry_casefold_test(struct kunit *test)
+{
+	struct qstr name;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test with case folding disabled (default) */
+	clear_bit(HFSPLUS_SB_CASEFOLD, &test_sb_info.flags);
+
+	create_qstr(&name, "hello");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "Hello", &name);
+	/* Case sensitive: "Hello" != "hello" */
+	KUNIT_EXPECT_NE(test, 0, result);
+
+	create_qstr(&name, "Hello");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "hello", &name);
+	/* Case sensitive: "hello" != "Hello" */
+	KUNIT_EXPECT_NE(test, 0, result);
+
+	/* Test with case folding enabled */
+	set_bit(HFSPLUS_SB_CASEFOLD, &test_sb_info.flags);
+
+	create_qstr(&name, "hello");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "Hello", &name);
+	/* Case insensitive: "Hello" == "hello" */
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	create_qstr(&name, "Hello");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "hello", &name);
+	/* Case insensitive: "hello" == "Hello" */
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test mixed case */
+	create_qstr(&name, "TeSt");
+	result = hfsplus_compare_dentry(&test_dentry, 4, "test", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	create_qstr(&name, "test");
+	result = hfsplus_compare_dentry(&test_dentry, 4, "TEST", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+}
+
+/* Test special character handling in comparison */
+static void hfsplus_compare_dentry_special_chars_test(struct kunit *test)
+{
+	struct qstr name;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test colon conversion (: becomes /) */
+	create_qstr(&name, "file/name");
+	result = hfsplus_compare_dentry(&test_dentry, 9, "file:name", &name);
+	/* "file:name" == "file/name" after conversion */
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	create_qstr(&name, "file:name");
+	result = hfsplus_compare_dentry(&test_dentry, 9, "file/name", &name);
+	/* "file/name" == "file:name" after conversion */
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test multiple special characters */
+	create_qstr(&name, "///");
+	result = hfsplus_compare_dentry(&test_dentry, 3, ":::", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test mixed special and regular characters */
+	create_qstr(&name, "a/b:c");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "a:b/c", &name);
+	/* Both become "a/b/c" after conversion */
+	KUNIT_EXPECT_EQ(test, 0, result);
+}
+
+/* Test length differences */
+static void hfsplus_compare_dentry_length_test(struct kunit *test)
+{
+	struct qstr name;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test different lengths with common prefix */
+	create_qstr(&name, "testing");
+	result = hfsplus_compare_dentry(&test_dentry, 4, "test", &name);
+	KUNIT_EXPECT_LT(test, result, 0); /* "test" < "testing" */
+
+	create_qstr(&name, "test");
+	result = hfsplus_compare_dentry(&test_dentry, 7, "testing", &name);
+	KUNIT_EXPECT_GT(test, result, 0); /* "testing" > "test" */
+
+	/* Test exact length match */
+	create_qstr(&name, "exact");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "exact", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test length parameter vs actual string content */
+	create_qstr(&name, "hello");
+	result = hfsplus_compare_dentry(&test_dentry, 3, "hel", &name);
+	KUNIT_EXPECT_LT(test, result, 0); /* "hel" < "hello" */
+
+	/* Test longer first string but shorter length parameter */
+	create_qstr(&name, "hi");
+	result = hfsplus_compare_dentry(&test_dentry, 2, "hello", &name);
+	/* "he" < "hi" (only first 2 chars compared) */
+	KUNIT_EXPECT_LT(test, result, 0);
+}
+
+/* Test decomposition flag behavior */
+static void hfsplus_compare_dentry_decompose_test(struct kunit *test)
+{
+	struct qstr name;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test with decomposition disabled (default) */
+	clear_bit(HFSPLUS_SB_NODECOMPOSE, &test_sb_info.flags);
+
+	create_qstr(&name, "test");
+	result = hfsplus_compare_dentry(&test_dentry, 4, "test", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test with decomposition enabled */
+	set_bit(HFSPLUS_SB_NODECOMPOSE, &test_sb_info.flags);
+
+	create_qstr(&name, "test");
+	result = hfsplus_compare_dentry(&test_dentry, 4, "test", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* For simple ASCII, decomposition shouldn't affect the result */
+	create_qstr(&name, "different");
+	result = hfsplus_compare_dentry(&test_dentry, 4, "test", &name);
+	KUNIT_EXPECT_NE(test, 0, result);
+}
+
+/* Test edge cases and boundary conditions */
+static void hfsplus_compare_dentry_edge_cases_test(struct kunit *test)
+{
+	struct qstr name;
+	int result;
+	char long_str[256];
+	char long_str2[256];
+	struct qstr null_name = {
+		.name = "a\0b",
+		.len = 3,
+		.hash = 0
+	};
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test very long strings */
+	memset(long_str, 'a', sizeof(long_str) - 1);
+	long_str[sizeof(long_str) - 1] = '\0';
+
+	create_qstr(&name, long_str);
+	result = hfsplus_compare_dentry(&test_dentry, sizeof(long_str) - 1,
+					long_str, &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test with difference at the end of long strings */
+	memset(long_str2, 'a', sizeof(long_str2) - 1);
+	long_str2[sizeof(long_str2) - 1] = '\0';
+	long_str2[sizeof(long_str2) - 2] = 'b';
+	create_qstr(&name, long_str2);
+	result = hfsplus_compare_dentry(&test_dentry, sizeof(long_str) - 1,
+					long_str, &name);
+	KUNIT_EXPECT_LT(test, result, 0); /* 'a' < 'b' */
+
+	/* Test single character differences */
+	create_qstr(&name, "b");
+	result = hfsplus_compare_dentry(&test_dentry, 1, "a", &name);
+	KUNIT_EXPECT_LT(test, result, 0); /* 'a' < 'b' */
+
+	create_qstr(&name, "a");
+	result = hfsplus_compare_dentry(&test_dentry, 1, "b", &name);
+	KUNIT_EXPECT_GT(test, result, 0); /* 'b' > 'a' */
+
+	/* Test with null characters in the middle */
+	result = hfsplus_compare_dentry(&test_dentry, 3, "a\0b", &null_name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test all printable ASCII characters */
+	create_qstr(&name, "!@#$%^&*()");
+	result = hfsplus_compare_dentry(&test_dentry, 10, "!@#$%^&*()", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+}
+
+/* Test combined flag behaviors */
+static void hfsplus_compare_dentry_combined_flags_test(struct kunit *test)
+{
+	struct qstr name;
+	int result;
+
+	setup_mock_sb();
+	setup_mock_dentry();
+	test_nls.char2uni = test_char2uni;
+
+	/* Test with both casefold and decompose enabled */
+	set_bit(HFSPLUS_SB_CASEFOLD, &test_sb_info.flags);
+	set_bit(HFSPLUS_SB_NODECOMPOSE, &test_sb_info.flags);
+
+	create_qstr(&name, "hello");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "HELLO", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test special chars with case folding */
+	create_qstr(&name, "File/Name");
+	result = hfsplus_compare_dentry(&test_dentry, 9, "file:name", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	/* Test with both flags disabled */
+	clear_bit(HFSPLUS_SB_CASEFOLD, &test_sb_info.flags);
+	clear_bit(HFSPLUS_SB_NODECOMPOSE, &test_sb_info.flags);
+
+	create_qstr(&name, "hello");
+	result = hfsplus_compare_dentry(&test_dentry, 5, "HELLO", &name);
+	KUNIT_EXPECT_NE(test, 0, result); /* Case sensitive */
+
+	/* But special chars should still be converted */
+	create_qstr(&name, "file/name");
+	result = hfsplus_compare_dentry(&test_dentry, 9, "file:name", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+}
+
+static struct kunit_case hfsplus_unicode_test_cases[] = {
+	KUNIT_CASE(hfsplus_strcasecmp_test),
+	KUNIT_CASE(hfsplus_strcmp_test),
+	KUNIT_CASE(hfsplus_unicode_edge_cases_test),
+	KUNIT_CASE(hfsplus_unicode_boundary_test),
+	KUNIT_CASE(hfsplus_uni2asc_basic_test),
+	KUNIT_CASE(hfsplus_uni2asc_special_chars_test),
+	KUNIT_CASE(hfsplus_uni2asc_buffer_test),
+	KUNIT_CASE(hfsplus_uni2asc_corrupted_test),
+	KUNIT_CASE(hfsplus_uni2asc_edge_cases_test),
+	KUNIT_CASE(hfsplus_asc2uni_basic_test),
+	KUNIT_CASE(hfsplus_asc2uni_special_chars_test),
+	KUNIT_CASE(hfsplus_asc2uni_buffer_limits_test),
+	KUNIT_CASE(hfsplus_asc2uni_edge_cases_test),
+	KUNIT_CASE(hfsplus_asc2uni_decompose_test),
+	KUNIT_CASE(hfsplus_hash_dentry_basic_test),
+	KUNIT_CASE(hfsplus_hash_dentry_casefold_test),
+	KUNIT_CASE(hfsplus_hash_dentry_special_chars_test),
+	KUNIT_CASE(hfsplus_hash_dentry_decompose_test),
+	KUNIT_CASE(hfsplus_hash_dentry_consistency_test),
+	KUNIT_CASE(hfsplus_hash_dentry_edge_cases_test),
+	KUNIT_CASE(hfsplus_compare_dentry_basic_test),
+	KUNIT_CASE(hfsplus_compare_dentry_casefold_test),
+	KUNIT_CASE(hfsplus_compare_dentry_special_chars_test),
+	KUNIT_CASE(hfsplus_compare_dentry_length_test),
+	KUNIT_CASE(hfsplus_compare_dentry_decompose_test),
+	KUNIT_CASE(hfsplus_compare_dentry_edge_cases_test),
+	KUNIT_CASE(hfsplus_compare_dentry_combined_flags_test),
+	{}
+};
+
+static struct kunit_suite hfsplus_unicode_test_suite = {
+	.name = "hfsplus_unicode",
+	.test_cases = hfsplus_unicode_test_cases,
+};
+
+kunit_test_suite(hfsplus_unicode_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for HFS+ Unicode string operations");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
-- 
2.43.0


