Return-Path: <linux-fsdevel+bounces-60723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71191B50958
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 01:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80F57AC216
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 23:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353C28C840;
	Tue,  9 Sep 2025 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="PS6F1g8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AC283FE4
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461612; cv=none; b=RLR+xWXi9XRsBoDzEQXqxxedcHN6pRO96QGYxg+x4xDiPk9TRDE6TEbcKBJrPUe7vayhbLljQgKlcshyF0bkec1sGsjgU1uyIVILjcJcyGPFsLQKKvGnRU1fNrco1yrRpou+/d1twSQHa1UMl+oIP3yP9nLjbi+UNTTIYyYw9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461612; c=relaxed/simple;
	bh=xRQYo9n9HNWQ2t3Rsyvd/UCUHmgleDErgEReBn2PwHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J06yvXSocbOnmt2B9XUyr3O1qHyYx0/8aDv7liDq4crlD2/ojfIjhe+S3AmUnrFsJIdzg+bsW7CS9bpiRaQyab27nNfzo/xZmOi45q6+lNJ0L3ydifrJ9jcTzDxw36jKL971+tjaNKpUpGlwgwNTI47lZbZDhqhP8yjRDnF+QCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=PS6F1g8Y; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e931c71a1baso8063340276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757461608; x=1758066408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4O99dLeW5iCbzMHANCstFQV8xVy+8U8+5Mg53NnZz0o=;
        b=PS6F1g8YZNR/skqsv3nAoyM3ddP75h38hg21FSRDYfNrkzv4347VDHBXbnTeePuxVG
         JpQJNP3IxF6ydDyvJ3RZSqrXotvXNuCWf7pn7new2CdCPjOt8iuc12ZK1P00ONBlS6KW
         L5DNXd2JdU5KPrP65QoxF9EzXPslmvlhXwidMjOBY4CwxEXbxjBNlTfsVNtg9wbGmZZZ
         lNISU6kLVbgNXgmiDeZhS6N/sF9gq0PQk/28k7lVBgqG2riGeNuR2jr+uJTnAB5Sspn2
         LPn/S4y2mYH5eqls8Nwjyt1KPikBUAKt03+qwCVqVJ50LDzCXZc57Xxce+DXGOzWxq1o
         FLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757461608; x=1758066408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4O99dLeW5iCbzMHANCstFQV8xVy+8U8+5Mg53NnZz0o=;
        b=wFbk3ZDHyfgcS5inubg4EuuxqQsFp1QIkfxQNL4U1f+4DZOEb1JeG+eqAdp4nUrxww
         4NTti+QWWhMbQpLGTAGwJxCo8igycwwVMnuUr9QkyB0hL2aI1cLqVf6dyQsIT2yi2RLt
         /dy8b8tQJC5bNJM3ovVJRed8C4g95mWZ930SBfc88UiSZB/sKne9JDVZEB+HB3gzNQxv
         gUOwROgSrwaHWeE2XJgz5ge/UihTiQWMxDu8bTv69oayMU/n7hAulQ32P3PTSRdtf2rE
         iCxdjTLcizb0M3C28Q0w3YFY4aAv4P527h/wHOAOyn6NNOAJodPkXSqgr1ImKh5jmKeG
         bKgA==
X-Forwarded-Encrypted: i=1; AJvYcCUDyZq1JKHvPhFDXOGx8gYWwVaSAKSe+Q9xPYGHlnOTGBFeBRCnc25UHWSQmBFzAllS76xf+Dg+ksvCngL/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/XW5K2Apt9uSbUYeMJ5O4eL4LGJcbcwdwuwvvwtPYdbpt84BO
	oMD7fDRjO6UE5rAJE+xJhT2ar+5P1AzpAqmEAYRracLueajTjPG7CIsZZMJoOd06ynU=
X-Gm-Gg: ASbGncukWgM9jL/v+ujgsy0iMtMB8l21XXQ1Rj3GFN9nj2tTt///wf/frFiur2pqVRX
	Ql2n48xhiIBezMnoxKyT9ov8cQfsKWFgTal3DnUf0mzQ7KVQu3xyJ4A0pWWMVhqqopYFG0pJ6ud
	P7JQh4RnSWwyLNHHM6VijfW3a+gaP9nABsEdPzIJuRYR9xiTmSv/mIVE24tiXIkWZHHeNN82wwl
	IKDSNuGCI+Cs+hgV0S3cTDMkee5WtcB30u/XHOfMVMC5xjoSkXlQ6ac8+ivItig55Mp8coZO+/8
	i0PfsQOvdD0nrvX51neSpgX+u+Ru6h6Rf84AXcMggivD3px0pcMoHRSAotxvuqIzoRnAbpbVDe/
	E/zt7duiRVewaYfzz0nMlevOvdROBEmvRhLpHMH/TRFZl
X-Google-Smtp-Source: AGHT+IHa1m5i6NZc5l+X9KaRnJ/mylryw1Fl5QmmvzbIEXh0YhyW017bE5wS/QMknjzHxUBRHZmZeA==
X-Received: by 2002:a05:6902:33c9:b0:ea3:be0a:ccdb with SMTP id 3f1490d57ef6-ea3be0ae9e0mr220845276.49.1757461608288;
        Tue, 09 Sep 2025 16:46:48 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1689:6011:96a1:eafd])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe05d717sm6955938276.22.2025.09.09.16.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 16:46:47 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com
Subject: [PATCH] hfs: introduce KUnit tests for HFS string operations
Date: Tue,  9 Sep 2025 16:46:15 -0700
Message-Id: <20250909234614.880671-1-slava@dubeyko.com>
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

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/.kunitconfig  |   7 +++
 fs/hfs/Kconfig       |  15 +++++
 fs/hfs/Makefile      |   2 +
 fs/hfs/string_test.c | 132 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+)
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
2.51.0


