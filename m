Return-Path: <linux-fsdevel+bounces-61147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46CCB559B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 00:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF34AA29AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F90E264619;
	Fri, 12 Sep 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="low8U2Oz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FCD2DC789
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757717451; cv=none; b=Z+U2yjHgrn/ckZD+mbizSJPyCOuOVJGxFWJMSsoSKiVwP0tK7ciESYYAno7qcrxASmwikYFfE51GoYRDuBfOYyXtdhuSf4eL3uUf0ftxhihN7IeGFDqWNt5N5PwS1hVFKxWYhHwBGieOaIm9/K310mwpfBrKHlktbAGmfaiw0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757717451; c=relaxed/simple;
	bh=c6aDOYNREuzcbzVhzucqMW4kDNmz6f9tlZJN6nNPlfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mRTRINHisNlPsv/SvweJa7QGTowlGL+jUA/0gpQiJmIy8wKDlNmEFApAX2p6yPOYcUUYOmO1a/ai7SJTR8ux0UKrK76HZ5OeJfsrGqPupKPJHCz5ktkNoYXwc92QxIiDVieOGBo3O4jYtKx8v7tp4A+UqhX06r/m5GPG63TQxHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=low8U2Oz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e970acf352fso1767832276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757717448; x=1758322248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEhfWf1On8xREXNNUE0mR4KQhTs+3NHB5rmBVgl39WI=;
        b=low8U2OzIMbxa4TZw+s4X7MrkZv4eUWODtNRueJfoniZ9Qc3YPaqzu6NvhmPKU0Mj0
         XBNioQql18rH/irMfRw1CLyVbNsIhOAP91JTUJnXNc5YBFgxJRIT4kIrNDKDvVETs7Ve
         1Lu29afzoKngRqqIvTcY7+ZAbbQBu/n9gA7ml7EPPmlq0QrtIk16GoC7E+wcTER0JIN0
         SMK9aGnReGXaBE42GIbURJG9EVXSJ0bCn8H/YsuNEQd3Q8tRZ9pPzrYTtPjssfBtr8xD
         56hwvSUGvXDgLkZXsxkYMmVrmn8e5FVpJuWseBRb5zDxgf2/0MW69amrOtedrw27sizR
         4vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757717448; x=1758322248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEhfWf1On8xREXNNUE0mR4KQhTs+3NHB5rmBVgl39WI=;
        b=uTYWBnhGuCPXBKO2JpFxNglh4VPXy3sIcg8MgPCrOPnolRas6qsFy4gT2r5Fkw1RFG
         T5uZpGr3y6t1aXbdmxnQ/9Z86otgkGR7ehxN981n0fMNVD3c9FpNHJY36qM9XByfSYuG
         Roc+q2OF5Uu8kmfodjM/tppLzfSy+Flk5nQP1UcT6PsU7eA4XjTq0qAiMlFIF6lzUgzw
         7oXMkL+5C+ZIRvtD3Q3kD5Vr9AICgIsCl772rd9R0j3hNBYldCo90Ivxcf2QRLzuqWQU
         HaZhmr6nLTbLp7PXLZ6jlgl5LhL70fEyNX23sRhl8t5Ieq7JetoOL+XwStawMVHdnHhF
         bppg==
X-Forwarded-Encrypted: i=1; AJvYcCVrJmXyN8p3xHN2irGPckM+zWUhaO1opUX3jHyo+gv2/Szazjxunl+u5HcxGIIiSmWLgrmvDtmVaqRgDhRw@vger.kernel.org
X-Gm-Message-State: AOJu0YykySlVegpJSDPMtMk2Vvx4+3kbxBgZSqQbhgpdoNjL4Udr0lpq
	0yTDyp2Qb9s5CAIgqLAjWMIVwV7xcgZESYLOCMbuMS+vrIwy/kVZKCSUtKtYX6Moys0=
X-Gm-Gg: ASbGnctfgi3ev3HR3tIFuSmLq5k0NBVrlBWOB10Z8ieROWjknu/flbcdpe1C6MXJJWa
	5L3gwPXaefRC1vVBSyQrJGI3TCQBUitwk2L3Cd0q0K3JRIfgOCxNQHibakMC0e4PRkmw79IEC0I
	kikJkXYQmOO5rBytd/5fP6K04RKhfLEvcTAz+fR1cBQEbgQkhMlHMHVc+lPfsbRU+B1lGQR7CVB
	ZxiKH+w0FGAFz/hNZtIjkySQWaxqCS3lMAC+10h8CbclL4BtCQv1Nsj+Hid3AtgI15Md3ZUuRnT
	ARtaoW7r2SKBk+a+kQR4ilr+CN/bnxbuCiYTwJV9nNgkXHGKw7cj3Y6A2l69mDYZbLSoWZdOQAi
	2/abza1/OVTgSYqy1goRTKRDrxemVw4E/fg==
X-Google-Smtp-Source: AGHT+IEE3F+Ve1MuLlrnk8ayAeEsQNg/WnORgu7peE77TiWJLlLBJwsxWuaM2QkU2mKZdLqVxO/p1Q==
X-Received: by 2002:a05:6902:705:b0:ea3:e84c:f99d with SMTP id 3f1490d57ef6-ea3e84cfcacmr2349774276.1.1757717448024;
        Fri, 12 Sep 2025 15:50:48 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:b6c1:d48b:d9e8:3fbf])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3cf212971sm1731554276.21.2025.09.12.15.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 15:50:47 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	vdubeyko@redhat.com,
	Chen Linxuan <me@black-desk.cn>
Subject: [PATCH v3] hfs: introduce KUnit tests for HFS string operations
Date: Fri, 12 Sep 2025 15:50:23 -0700
Message-Id: <20250912225022.1083313-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

This patch implements the initial Kunit based set of
unit tests for HFS string operations. It checks
functionality of hfs_strcmp(), hfs_hash_dentry(),
and hfs_compare_dentry() methods.

./tools/testing/kunit/kunit.py run --kunitconfig ./fs/hfs/.kunitconfig

[16:04:50] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
[16:04:51] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=22
[16:04:59] Starting KUnit Kernel (1/1)...
[16:04:59] ============================================================
Running tests with:
$ .kunit/linux kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
[16:04:59] ================= hfs_string (3 subtests) ==================
[16:04:59] [PASSED] hfs_strcmp_test
[16:04:59] [PASSED] hfs_hash_dentry_test
[16:04:59] [PASSED] hfs_compare_dentry_test
[16:04:59] =================== [PASSED] hfs_string ====================
[16:04:59] ============================================================
[16:04:59] Testing complete. Ran 3 tests: passed: 3
[16:04:59] Elapsed time: 9.087s total, 1.310s configuring, 7.611s building, 0.125s running

v2
Fix linker error.

v3
Chen Linxuan suggested to use EXPORT_SYMBOL_IF_KUNIT.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
cc: Chen Linxuan <me@black-desk.cn>
---
 fs/hfs/.kunitconfig  |   7 +++
 fs/hfs/Kconfig       |  15 +++++
 fs/hfs/Makefile      |   2 +
 fs/hfs/string.c      |   5 ++
 fs/hfs/string_test.c | 133 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 162 insertions(+)
 create mode 100644 fs/hfs/.kunitconfig
 create mode 100644 fs/hfs/string_test.c

diff --git a/fs/hfs/.kunitconfig b/fs/hfs/.kunitconfig
new file mode 100644
index 000000000000..5caa9af1e3bb
--- /dev/null
+++ b/fs/hfs/.kunitconfig
@@ -0,0 +1,7 @@
+CONFIG_KUNIT=y
+CONFIG_HFS_FS=y
+CONFIG_HFS_KUNIT_TEST=y
+CONFIG_BLOCK=y
+CONFIG_BUFFER_HEAD=y
+CONFIG_NLS=y
+CONFIG_LEGACY_DIRECT_IO=y
diff --git a/fs/hfs/Kconfig b/fs/hfs/Kconfig
index 5ea5cd8ecea9..7f3cbe43b4b7 100644
--- a/fs/hfs/Kconfig
+++ b/fs/hfs/Kconfig
@@ -13,3 +13,18 @@ config HFS_FS
 
 	  To compile this file system support as a module, choose M here: the
 	  module will be called hfs.
+
+config HFS_KUNIT_TEST
+	tristate "KUnit tests for HFS filesystem" if !KUNIT_ALL_TESTS
+	depends on HFS_FS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit tests for the HFS filesystem.
+
+	  KUnit tests run during boot and output the results to the debug
+	  log in TAP format (https://testanything.org/). Only useful for
+	  kernel devs running KUnit test harness and are not for inclusion
+	  into a production build.
+
+	  For more information on KUnit and unit tests in general please
+	  refer to the KUnit documentation in Documentation/dev-tools/kunit/.
diff --git a/fs/hfs/Makefile b/fs/hfs/Makefile
index b65459bf3dc4..a7c9ce6b4609 100644
--- a/fs/hfs/Makefile
+++ b/fs/hfs/Makefile
@@ -9,3 +9,5 @@ hfs-objs := bitmap.o bfind.o bnode.o brec.o btree.o \
 	    catalog.o dir.o extent.o inode.o attr.o mdb.o \
             part_tbl.o string.o super.o sysdep.o trans.o
 
+# KUnit tests
+obj-$(CONFIG_HFS_KUNIT_TEST) += string_test.o
diff --git a/fs/hfs/string.c b/fs/hfs/string.c
index 3912209153a8..0cfa35e82abc 100644
--- a/fs/hfs/string.c
+++ b/fs/hfs/string.c
@@ -16,6 +16,8 @@
 #include "hfs_fs.h"
 #include <linux/dcache.h>
 
+#include <kunit/visibility.h>
+
 /*================ File-local variables ================*/
 
 /*
@@ -65,6 +67,7 @@ int hfs_hash_dentry(const struct dentry *dentry, struct qstr *this)
 	this->hash = end_name_hash(hash);
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(hfs_hash_dentry);
 
 /*
  * Compare two strings in the HFS filename character ordering
@@ -87,6 +90,7 @@ int hfs_strcmp(const unsigned char *s1, unsigned int len1,
 	}
 	return len1 - len2;
 }
+EXPORT_SYMBOL_IF_KUNIT(hfs_strcmp);
 
 /*
  * Test for equality of two strings in the HFS filename character ordering.
@@ -112,3 +116,4 @@ int hfs_compare_dentry(const struct dentry *dentry,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(hfs_compare_dentry);
diff --git a/fs/hfs/string_test.c b/fs/hfs/string_test.c
new file mode 100644
index 000000000000..e1bf6f954312
--- /dev/null
+++ b/fs/hfs/string_test.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for HFS string operations
+ *
+ * Copyright (C) 2025 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/dcache.h>
+#include "hfs_fs.h"
+
+/* Test hfs_strcmp function */
+static void hfs_strcmp_test(struct kunit *test)
+{
+	/* Test equal strings */
+	KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("hello", 5, "hello", 5));
+	KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("test", 4, "test", 4));
+	KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("", 0, "", 0));
+
+	/* Test unequal strings */
+	KUNIT_EXPECT_NE(test, 0, hfs_strcmp("hello", 5, "world", 5));
+	KUNIT_EXPECT_NE(test, 0, hfs_strcmp("test", 4, "testing", 7));
+
+	/* Test different lengths */
+	KUNIT_EXPECT_LT(test, hfs_strcmp("test", 4, "testing", 7), 0);
+	KUNIT_EXPECT_GT(test, hfs_strcmp("testing", 7, "test", 4), 0);
+
+	/* Test case insensitive comparison (HFS should handle case) */
+	KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("Test", 4, "TEST", 4));
+	KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("hello", 5, "HELLO", 5));
+
+	/* Test with special characters */
+	KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("file.txt", 8, "file.txt", 8));
+	KUNIT_EXPECT_NE(test, 0, hfs_strcmp("file.txt", 8, "file.dat", 8));
+
+	/* Test boundary cases */
+	KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("a", 1, "a", 1));
+	KUNIT_EXPECT_NE(test, 0, hfs_strcmp("a", 1, "b", 1));
+}
+
+/* Test hfs_hash_dentry function */
+static void hfs_hash_dentry_test(struct kunit *test)
+{
+	struct qstr test_name1, test_name2, test_name3;
+	struct dentry dentry = {};
+	char name1[] = "testfile";
+	char name2[] = "TestFile";
+	char name3[] = "different";
+
+	/* Initialize test strings */
+	test_name1.name = name1;
+	test_name1.len = strlen(name1);
+	test_name1.hash = 0;
+
+	test_name2.name = name2;
+	test_name2.len = strlen(name2);
+	test_name2.hash = 0;
+
+	test_name3.name = name3;
+	test_name3.len = strlen(name3);
+	test_name3.hash = 0;
+
+	/* Test hashing */
+	KUNIT_EXPECT_EQ(test, 0, hfs_hash_dentry(&dentry, &test_name1));
+	KUNIT_EXPECT_EQ(test, 0, hfs_hash_dentry(&dentry, &test_name2));
+	KUNIT_EXPECT_EQ(test, 0, hfs_hash_dentry(&dentry, &test_name3));
+
+	/* Case insensitive names should hash the same */
+	KUNIT_EXPECT_EQ(test, test_name1.hash, test_name2.hash);
+
+	/* Different names should have different hashes */
+	KUNIT_EXPECT_NE(test, test_name1.hash, test_name3.hash);
+}
+
+/* Test hfs_compare_dentry function */
+static void hfs_compare_dentry_test(struct kunit *test)
+{
+	struct qstr test_name;
+	struct dentry dentry = {};
+	char name[] = "TestFile";
+
+	test_name.name = name;
+	test_name.len = strlen(name);
+
+	/* Test exact match */
+	KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 8,
+						    "TestFile", &test_name));
+
+	/* Test case insensitive match */
+	KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 8,
+						    "testfile", &test_name));
+	KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 8,
+						    "TESTFILE", &test_name));
+
+	/* Test different names */
+	KUNIT_EXPECT_EQ(test, 1, hfs_compare_dentry(&dentry, 8,
+						    "DiffFile", &test_name));
+
+	/* Test different lengths */
+	KUNIT_EXPECT_EQ(test, 1, hfs_compare_dentry(&dentry, 7,
+						    "TestFil", &test_name));
+	KUNIT_EXPECT_EQ(test, 1, hfs_compare_dentry(&dentry, 9,
+						    "TestFiles", &test_name));
+
+	/* Test empty string */
+	test_name.name = "";
+	test_name.len = 0;
+	KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 0, "", &test_name));
+
+	/* Test HFS_NAMELEN boundary */
+	test_name.name = "This_is_a_very_long_filename_that_exceeds_normal_limits";
+	test_name.len = strlen(test_name.name);
+	KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, HFS_NAMELEN,
+			"This_is_a_very_long_filename_th", &test_name));
+}
+
+static struct kunit_case hfs_string_test_cases[] = {
+	KUNIT_CASE(hfs_strcmp_test),
+	KUNIT_CASE(hfs_hash_dentry_test),
+	KUNIT_CASE(hfs_compare_dentry_test),
+	{}
+};
+
+static struct kunit_suite hfs_string_test_suite = {
+	.name = "hfs_string",
+	.test_cases = hfs_string_test_cases,
+};
+
+kunit_test_suite(hfs_string_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for HFS string operations");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
-- 
2.51.0


