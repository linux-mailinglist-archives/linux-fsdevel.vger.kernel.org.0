Return-Path: <linux-fsdevel+bounces-22445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45C917329
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 23:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69451F22156
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C0117E465;
	Tue, 25 Jun 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eaddj1WG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392B176252;
	Tue, 25 Jun 2024 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350291; cv=none; b=RD71gFf1N35Q0H40B2IEMXgY7cMTvKzip6WlsrlDekS1LeEaltUHdeFIJrlQaPjlKDzrxyzkLPluKwWofPiMFDHEd548qsOTtNVqLW0VXZcZ0okRsOaRfuL86oUk6azTKPLbB7/jzj4eQWNF8huIzgDcKuYqyTiR8Rx57u3c4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350291; c=relaxed/simple;
	bh=k7WG3rwgkOEy8+g7ol3n2RpCqSOWutW6VRpzXP8z8oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1uZO+51CJF8mFk32T6tge2jtUQ9WGu3i3dB7ydeHj+gHM9d43WF2CtF0g/8qwXwckjOFivSa0dB95fbUWK3LYOdK0hN8RCymoqBJ4cZXPJtNdxSIUC5DBJXKqewutAWqXFEYWWJmeeZ+2mcDrcQ/akkRKF+2W8wCJNfvwV2yCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eaddj1WG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=40AQCIbaWR3aQUx2SpMr2/LydQuRZnfIDFJXoDJax6c=; b=eaddj1WGAmbB/NFaLU1SskSYtu
	4zKTkZdka8SGo2Hc9zZFGH7d+R4UZL4kV05r7K/tjWtVmF/HZNUgdLqcQJlxVAmemOlb/D61tqhHU
	ZSlzJqlUvbc1MlPfSlwJc/LL+10+b7myE6sk0t5lQjmslDBOee+04GxqPMhzJkdTEONnMkdV6E7yD
	50s+DaQnXAMfkA8RHXSBhC9gaWiHdd//9hwAyWNAE5ploFwBJqMVk7sz+8qEP7W8FS42ZaNfel0k+
	EPia/5g0DkdcvhC6aj0mJuy3Z2fq0pkReftHDEwJLTPytKWb6RrulY4NFfxqOTK1HZAU2IrHkfgUt
	dBNfbs3w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMDYF-0000000BXYW-2iGQ;
	Tue, 25 Jun 2024 21:18:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: [PATCH v2 3/5] rosebush: Add test suite
Date: Tue, 25 Jun 2024 22:17:58 +0100
Message-ID: <20240625211803.2750563-4-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625211803.2750563-1-willy@infradead.org>
References: <20240625211803.2750563-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is not a very sophisticated test suite yet, but it helped find
a few bugs and provides a framework for adding more tests as more
bugs are found.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/Kconfig.debug   |   3 +
 lib/Makefile        |   1 +
 lib/test_rosebush.c | 140 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 lib/test_rosebush.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 59b6765d86b8..f3cfd79d8dbd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2447,6 +2447,9 @@ config TEST_RHASHTABLE
 
 	  If unsure, say N.
 
+config TEST_ROSEBUSH
+	tristate "Test the Rosebush data structure"
+
 config TEST_IDA
 	tristate "Perform selftest on IDA functions"
 
diff --git a/lib/Makefile b/lib/Makefile
index 723e6c90b58d..de4edefc2c11 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
+obj-$(CONFIG_TEST_ROSEBUSH) += test_rosebush.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
diff --git a/lib/test_rosebush.c b/lib/test_rosebush.c
new file mode 100644
index 000000000000..59c342e7a5b3
--- /dev/null
+++ b/lib/test_rosebush.c
@@ -0,0 +1,140 @@
+#include <linux/rosebush.h>
+#include <kunit/test.h>
+
+static void iter_rbh(struct kunit *test, struct rbh *rbh, u32 hash, void *p)
+{
+	RBH_ITER(iter, rbh, hash);
+	void *q;
+
+	rcu_read_lock();
+	q = rbh_next(&iter);
+	KUNIT_EXPECT_PTR_EQ_MSG(test, p, q,
+		"rbh_next hash:%u returned %px, expected %px", hash, q, p);
+	q = rbh_next(&iter);
+	KUNIT_EXPECT_PTR_EQ_MSG(test, NULL, q,
+		"rbh_next hash:%u returned %px, expected NULL", hash, q);
+	rcu_read_unlock();
+}
+
+static void check_empty_rbh(struct kunit *test, struct rbh *rbh)
+{
+	iter_rbh(test, rbh, 0, NULL);
+	iter_rbh(test, rbh, 1, NULL);
+	iter_rbh(test, rbh, 17, NULL);
+	iter_rbh(test, rbh, 42, NULL);
+}
+
+static void test_insert(struct kunit *test, struct rbh *rbh, u32 hash)
+{
+	void *p = (void *)((hash << 1) | 1UL);
+	int err;
+
+	err = rbh_insert(rbh, hash, p);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	iter_rbh(test, rbh, hash, p);
+}
+
+static void test_reserve(struct kunit *test, struct rbh *rbh, u32 hash)
+{
+	int err;
+
+	err = rbh_reserve(rbh, hash);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	iter_rbh(test, rbh, hash, NULL);
+}
+
+static void test_use(struct kunit *test, struct rbh *rbh, u32 hash)
+{
+	void *p = (void *)((hash << 1) | 1UL);
+	int err;
+
+	err = rbh_use(rbh, hash, p);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	iter_rbh(test, rbh, hash, p);
+}
+
+static void test_remove(struct kunit *test, struct rbh *rbh, u32 hash)
+{
+	void *p = (void *)((hash << 1) | 1UL);
+	int err;
+
+	err = rbh_remove(rbh, hash, p);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	iter_rbh(test, rbh, hash, NULL);
+}
+
+static DEFINE_ROSEBUSH(rosebush);
+
+/*
+ * Conduct a number of tests on a rosebush that has never been used.
+ * They should all return NULL or an errno.  We're looking for crashes
+ * here.
+ */
+static void empty(struct kunit *test)
+{
+	int err;
+
+	check_empty_rbh(test, &rosebush);
+	err = rbh_remove(&rosebush, 0, test);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+	err = rbh_use(&rosebush, 0, test);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+	KUNIT_EXPECT_EQ(test, rosebush.rbh_table, 0);
+}
+
+static void first(struct kunit *test)
+{
+	int err;
+
+	test_insert(test, &rosebush, 5);
+	check_empty_rbh(test, &rosebush);
+	test_remove(test, &rosebush, 5);
+	check_empty_rbh(test, &rosebush);
+
+	err = rbh_remove(&rosebush, 5, NULL);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+	test_reserve(test, &rosebush, 5);
+	err = rbh_remove(&rosebush, 5, test);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+	err = rbh_remove(&rosebush, 5, NULL);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	err = rbh_remove(&rosebush, 5, NULL);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+
+	test_reserve(test, &rosebush, 5);
+	test_use(test, &rosebush, 5);
+	err = rbh_remove(&rosebush, 5, NULL);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+	test_remove(test, &rosebush, 5);
+}
+
+static void grow(struct kunit *test)
+{
+	int i;
+
+	for (i = 3; i < 3333; i += 2)
+		test_insert(test, &rosebush, i);
+
+	rbh_destroy(&rosebush);
+}
+
+static struct kunit_case rosebush_cases[] __refdata = {
+	KUNIT_CASE(empty),
+	KUNIT_CASE(first),
+	KUNIT_CASE(grow),
+	{}
+};
+
+static struct kunit_suite rosebush_suite = {
+	.name = "rosebush",
+	.test_cases = rosebush_cases,
+};
+
+kunit_test_suite(rosebush_suite);
+
+MODULE_AUTHOR("Matthew Wilcox (Oracle) <willy@infradead.org>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


