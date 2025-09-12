Return-Path: <linux-fsdevel+bounces-60987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9A4B53FA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 03:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBD17BC3B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 01:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3CB54774;
	Fri, 12 Sep 2025 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="2gKca0sP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5C168BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639430; cv=none; b=SNnXa7QB8Lzx4p7LfxtIMB/CaS5TQPW45TgNo3HaJ1hL5NqjICs32T2hNGEs8UIQizwGUvRhtZZjDrbxJwuKgVcaZ4zJoDC6n7kAUR6UfGbnrLKjE1IGWx7Pt6vFFY78GWUq9Croc9+BtS++ePS9odQWuH9DNLm6LgQmHvVoWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639430; c=relaxed/simple;
	bh=qMJw2VbX+JRYR5GoeXWs/02+M7uuNqGiIqURzaFHDgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJta53b7lLa3TXmN4mvpyZYRjJeyhDfb7yOkqwoifl3sTHdF004qTornO4ud7XIESQipbKHF4cWiU6QN/7f7NLXE4IRhQy+RYnPLp1m4BNoH8KUgXYeW9OUtCrRclCL2BCoVztdS6zX6u1rUijI5ubyozip3hA/OeDKLEfh5cL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=2gKca0sP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60504bf8so12416877b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 18:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757639427; x=1758244227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtxdNSfLKA1ytMbPuF/3fJiuqlGKAP+vZn731TH0b74=;
        b=2gKca0sPNmgkMsU64LgLb22LZjCOLr2gscTNAYMXDkveh6uly8Mf6l2QZPuMEhKIsO
         aY3zUStJpPOuxoL88o056Tyx5Kapwzo4TAlNwJL/YWb4NAgBIY/OwcDNWbmHJ7bDpIa8
         xfHdSwneFRzUYeNkQIPy8EsoRb/UiuH2jIqUUUvfwzzSjfZGidE2ykUzjYTaR3iz2sIX
         P7x4guO6UvP71W6vHDlNcxJ7U90PIvF7zh1dnS7kE9s6mbqp2g653x/n7ZVxhD4OH6/f
         34aqc9zkk49UcZ8Xck5LM2/m0IoJdC8PZD76IwE+KR8pETmFuZaA2WEKpJTViF/S758o
         JHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757639427; x=1758244227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtxdNSfLKA1ytMbPuF/3fJiuqlGKAP+vZn731TH0b74=;
        b=pb3P6u0ythMju6isVNhGDm4L1VCqdE/sbDlZBJEQE7TYBzACAkbOpzR4RfkTA3KOJ5
         /ywaViuTqd44YJLLJvvYMDEhCjYUKeA+7+n8oyvWcKeTAXe5d5wpzaD60/tIRnQsUAzP
         5zY0IzEJZDs0l457yARYME0Uz/2cs9wxV0+8idgPXvsoQSpcaRtxUmgOy1rY62gjRrxJ
         Y+3gHTdbrPUm+w3X243/WrrZ9NQZLuEp3EGZhnp+89nX1aCc06ooEZpZK0+GcoyJyQSg
         XyOZE9axQNV/W41t+su4KEirCMtihc9dlsKqtGEGTMcGsSn2oZwAT+zKqPVgN1Peh27S
         TIlA==
X-Forwarded-Encrypted: i=1; AJvYcCWKR8/dtPnWQ19BG4Xj4LglpDtSmE1dMTXt7+ppJjrQZAFnJgpSC1WuzeUjgM16A47+C2aPhAVBFk0kIBsA@vger.kernel.org
X-Gm-Message-State: AOJu0YyliQ3iWrWnbMjBrkoQKa70CbHRpx9Kd2igpyC81w/zCdeCWRqJ
	Cq7zeRc4Njm3ovLqik/Ga/B64ht2EHi17bYa/OjweXvv1Hc52W4qm5j3hlpU0TF1Awc=
X-Gm-Gg: ASbGnctN0OHguSevl1AZcbmMauGIsZ8Tz5kT96WQY+xDC//yv/AjKJb1ZZ7uFgJkxyL
	ZdxerS476049w0T9AjEMM0nYNjhEYqdJ1vLcJqSHwvvnIVGSJtIByI0fJdm9hLuq6a1OU06qzyJ
	3pw969qYxdz1l2RcmCLGDwQtNzQFmimFZpZ92QIx9jv+P2gzeQWGyt1qHRTbBFF8dRHgmK/T5P6
	gzVKPYwyu0+lQP/CBhSyuiVRW+Fe76rrSR7kPGYmsNni9whK/VM3Qp9xq5loCjcIcM4yA1OXcSe
	JRoWO2yuWg64KU05OZM+OKGEZzlLf8cBve/ij13XeHz/dys/z2mh2uZ/HtJXKKHtXTVs7WaJGDK
	N3ZG76FKTizgPhRSqVcNMz4Wi9kyZcaIB+xSz0pGqIlk=
X-Google-Smtp-Source: AGHT+IFFu8MmNFme8dvLr/JpDrpGaiCsI5flPdp2HrBEKVAWLHpkmgy+yBQzHbYM3jR1PecNFsQiig==
X-Received: by 2002:a05:690c:6813:b0:72e:a82a:ab84 with SMTP id 00721157ae682-7306609b092mr13228007b3.51.1757639426903;
        Thu, 11 Sep 2025 18:10:26 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:7b7c:1d1:81fd:fdbe])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f769292d4sm7723067b3.27.2025.09.11.18.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 18:10:26 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2] hfs: introduce KUnit tests for HFS string operations
Date: Thu, 11 Sep 2025 18:09:57 -0700
Message-Id: <20250912010956.1044233-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/.kunitconfig  |   7 +++
 fs/hfs/Kconfig       |  15 +++++
 fs/hfs/Makefile      |   2 +
 fs/hfs/string.c      |   3 +
 fs/hfs/string_test.c | 132 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 159 insertions(+)
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
index 3912209153a8..b011c1cbdf94 100644
--- a/fs/hfs/string.c
+++ b/fs/hfs/string.c
@@ -65,6 +65,7 @@ int hfs_hash_dentry(const struct dentry *dentry, struct qstr *this)
 	this->hash = end_name_hash(hash);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hfs_hash_dentry);
 
 /*
  * Compare two strings in the HFS filename character ordering
@@ -87,6 +88,7 @@ int hfs_strcmp(const unsigned char *s1, unsigned int len1,
 	}
 	return len1 - len2;
 }
+EXPORT_SYMBOL_GPL(hfs_strcmp);
 
 /*
  * Test for equality of two strings in the HFS filename character ordering.
@@ -112,3 +114,4 @@ int hfs_compare_dentry(const struct dentry *dentry,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hfs_compare_dentry);
diff --git a/fs/hfs/string_test.c b/fs/hfs/string_test.c
new file mode 100644
index 000000000000..de1928dc4ef4
--- /dev/null
+++ b/fs/hfs/string_test.c
@@ -0,0 +1,132 @@
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
-- 
2.43.0


