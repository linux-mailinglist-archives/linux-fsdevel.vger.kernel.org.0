Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68C8798A5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244879AbjIHQEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 12:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244853AbjIHQEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8E1FEF
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694189021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5fxSxbVLUpbcc4PTXWiXVoOmdxGdublXXMjuvnbuZd0=;
        b=gj7suBq/UMBO9KrrgHLenpXkpKXPsrn5k20oxhsM+S89QgOLZBzBILBGAf8IrnnTl4rDQN
        bcZSTdPg9XqjV0ETwXYI9eXknjLCllujxbz6FRq5dD8/QpRyTo+yvie6DtwzgVLmlLen5B
        8kmJdxr2P1wRuO+a/hLfr5uPrykXnu0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-xhhcDnLGMYCZ_-APKhYyfA-1; Fri, 08 Sep 2023 12:03:35 -0400
X-MC-Unique: xhhcDnLGMYCZ_-APKhYyfA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EB9F281CC20;
        Fri,  8 Sep 2023 16:03:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FCFD140E963;
        Fri,  8 Sep 2023 16:03:32 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iov_iter: Kunit tests for copying to/from an iterator
Date:   Fri,  8 Sep 2023 17:03:21 +0100
Message-ID: <20230908160322.1714302-3-dhowells@redhat.com>
In-Reply-To: <20230908160322.1714302-1-dhowells@redhat.com>
References: <20230908160322.1714302-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some kunit tests for page extraction for ITER_BVEC, ITER_KVEC and
ITER_XARRAY type iterators.  ITER_UBUF and ITER_IOVEC aren't dealt with as
they require userspace VM interaction.  ITER_DISCARD isn't dealt with
either as that does nothing.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 lib/Kconfig.debug    |  11 +
 lib/Makefile         |   1 +
 lib/kunit_iov_iter.c | 537 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 549 insertions(+)
 create mode 100644 lib/kunit_iov_iter.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 319cfbeb0738..fa307f93fa2e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2237,6 +2237,17 @@ config TEST_DIV64
 
 	  If unsure, say N.
 
+config TEST_IOV_ITER
+	tristate "Test iov_iter operation" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this to turn on testing of the operation of the I/O iterator
+	  (iov_iter). This test is executed only once during system boot (so
+	  affects only boot time), or at module load time.
+
+	  If unsure, say N.
+
 config KPROBES_SANITY_TEST
 	tristate "Kprobes sanity tests" if !KUNIT_ALL_TESTS
 	depends on DEBUG_KERNEL
diff --git a/lib/Makefile b/lib/Makefile
index 2e08397f6210..740109b6e2c8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
 CFLAGS_test_bitops.o += -Werror
 obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
+obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
new file mode 100644
index 000000000000..25a910187d17
--- /dev/null
+++ b/lib/kunit_iov_iter.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* I/O iterator tests.  This can only test kernel-backed iterator types.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/uio.h>
+#include <linux/bvec.h>
+#include <kunit/test.h>
+
+MODULE_DESCRIPTION("iov_iter testing");
+MODULE_AUTHOR("David Howells <dhowells@redhat.com>");
+MODULE_LICENSE("GPL");
+
+struct kvec_test_range {
+	int	from, to;
+};
+
+static const struct kvec_test_range kvec_test_ranges[] = {
+	{ 0x00002, 0x00002 },
+	{ 0x00027, 0x03000 },
+	{ 0x05193, 0x18794 },
+	{ 0x20000, 0x20000 },
+	{ 0x20000, 0x24000 },
+	{ 0x24000, 0x27001 },
+	{ 0x29000, 0xffffb },
+	{ 0xffffd, 0xffffe },
+	{ -1 }
+};
+
+static inline u8 pattern(unsigned long x)
+{
+	return x & 0xff;
+}
+
+static void iov_kunit_unmap(void *data)
+{
+	vunmap(data);
+}
+
+static void *__init iov_kunit_create_buffer(struct kunit *test,
+					    struct page ***ppages,
+					    size_t npages)
+{
+	struct page **pages;
+	unsigned long got;
+	void *buffer;
+
+	pages = kunit_kcalloc(test, npages, sizeof(struct page *), GFP_KERNEL);
+        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
+	*ppages = pages;
+
+	got = alloc_pages_bulk_array(GFP_KERNEL, npages, pages);
+	if (got != npages) {
+		release_pages(pages, got);
+		KUNIT_ASSERT_EQ(test, got, npages);
+	}
+
+	buffer = vmap(pages, npages, VM_MAP | VM_MAP_PUT_PAGES, PAGE_KERNEL);
+        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
+
+	kunit_add_action_or_reset(test, iov_kunit_unmap, buffer);
+	return buffer;
+}
+
+static void __init iov_kunit_load_kvec(struct kunit *test,
+				       struct iov_iter *iter, int dir,
+				       struct kvec *kvec, unsigned int kvmax,
+				       void *buffer, size_t bufsize,
+				       const struct kvec_test_range *pr)
+{
+	size_t size = 0;
+	int i;
+
+	for (i = 0; i < kvmax; i++, pr++) {
+		if (pr->from < 0)
+			break;
+		KUNIT_ASSERT_GE(test, pr->to, pr->from);
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+		kvec[i].iov_base = buffer + pr->from;
+		kvec[i].iov_len = pr->to - pr->from;
+		size += pr->to - pr->from;
+	}
+	KUNIT_ASSERT_LE(test, size, bufsize);
+
+	iov_iter_kvec(iter, dir, kvec, i, size);
+}
+
+/*
+ * Test copying to a ITER_KVEC-type iterator.
+ */
+static void __init iov_kunit_copy_to_kvec(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct page **spages, **bpages;
+	struct kvec kvec[8];
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, patt;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	for (i = 0; i < bufsize; i++)
+		scratch[i] = pattern(i);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	memset(buffer, 0, bufsize);
+
+	iov_kunit_load_kvec(test, &iter, READ, kvec, ARRAY_SIZE(kvec),
+			    buffer, bufsize, kvec_test_ranges);
+	size = iter.count;
+
+	copied = copy_to_iter(scratch, size, &iter);
+
+	KUNIT_EXPECT_EQ(test, copied, size);
+	KUNIT_EXPECT_EQ(test, iter.count, 0);
+	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
+
+	/* Build the expected image in the scratch buffer. */
+	patt = 0;
+	memset(scratch, 0, bufsize);
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
+		for (i = pr->from; i < pr->to; i++)
+			scratch[i] = pattern(patt++);
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
+		if (buffer[i] != scratch[i])
+			return;
+	}
+
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Test copying from a ITER_KVEC-type iterator.
+ */
+static void __init iov_kunit_copy_from_kvec(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct page **spages, **bpages;
+	struct kvec kvec[8];
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, j;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	for (i = 0; i < bufsize; i++)
+		buffer[i] = pattern(i);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	memset(scratch, 0, bufsize);
+
+	iov_kunit_load_kvec(test, &iter, WRITE, kvec, ARRAY_SIZE(kvec),
+			    buffer, bufsize, kvec_test_ranges);
+	size = min(iter.count, bufsize);
+
+	copied = copy_from_iter(scratch, size, &iter);
+
+	KUNIT_EXPECT_EQ(test, copied, size);
+	KUNIT_EXPECT_EQ(test, iter.count, 0);
+	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
+
+	/* Build the expected image in the main buffer. */
+	i = 0;
+	memset(buffer, 0, bufsize);
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		for (j = pr->from; j < pr->to; j++) {
+			buffer[i++] = pattern(j);
+			if (i >= bufsize)
+				goto stop;
+		}
+	}
+stop:
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
+		if (scratch[i] != buffer[i])
+			return;
+	}
+
+	KUNIT_SUCCEED();
+}
+
+struct bvec_test_range {
+	int	page, from, to;
+};
+
+static const struct bvec_test_range bvec_test_ranges[] = {
+	{ 0, 0x0002, 0x0002 },
+	{ 1, 0x0027, 0x0893 },
+	{ 2, 0x0193, 0x0794 },
+	{ 3, 0x0000, 0x1000 },
+	{ 4, 0x0000, 0x1000 },
+	{ 5, 0x0000, 0x1000 },
+	{ 6, 0x0000, 0x0ffb },
+	{ 6, 0x0ffd, 0x0ffe },
+	{ -1, -1, -1 }
+};
+
+static void __init iov_kunit_load_bvec(struct kunit *test,
+				       struct iov_iter *iter, int dir,
+				       struct bio_vec *bvec, unsigned int bvmax,
+				       struct page **pages, size_t npages,
+				       size_t bufsize,
+				       const struct bvec_test_range *pr)
+{
+	struct page *can_merge = NULL, *page;
+	size_t size = 0;
+	int i;
+
+	for (i = 0; i < bvmax; i++, pr++) {
+		if (pr->from < 0)
+			break;
+		KUNIT_ASSERT_LT(test, pr->page, npages);
+		KUNIT_ASSERT_LT(test, pr->page * PAGE_SIZE, bufsize);
+		KUNIT_ASSERT_GE(test, pr->from, 0);
+		KUNIT_ASSERT_GE(test, pr->to, pr->from);
+		KUNIT_ASSERT_LE(test, pr->to, PAGE_SIZE);
+
+		page = pages[pr->page];
+		if (pr->from == 0 && pr->from != pr->to && page == can_merge) {
+			i--;
+			bvec[i].bv_len += pr->to;
+		} else {
+			bvec_set_page(&bvec[i], page, pr->to - pr->from, pr->from);
+		}
+
+		size += pr->to - pr->from;
+		if ((pr->to & ~PAGE_MASK) == 0)
+			can_merge = page + pr->to / PAGE_SIZE;
+		else
+			can_merge = NULL;
+	}
+
+	iov_iter_bvec(iter, dir, bvec, i, size);
+}
+
+/*
+ * Test copying to a ITER_BVEC-type iterator.
+ */
+static void __init iov_kunit_copy_to_bvec(struct kunit *test)
+{
+	const struct bvec_test_range *pr;
+	struct iov_iter iter;
+	struct bio_vec bvec[8];
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, b, patt;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	for (i = 0; i < bufsize; i++)
+		scratch[i] = pattern(i);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	memset(buffer, 0, bufsize);
+
+	iov_kunit_load_bvec(test, &iter, READ, bvec, ARRAY_SIZE(bvec),
+			    bpages, npages, bufsize, bvec_test_ranges);
+	size = iter.count;
+
+	copied = copy_to_iter(scratch, size, &iter);
+
+	KUNIT_EXPECT_EQ(test, copied, size);
+	KUNIT_EXPECT_EQ(test, iter.count, 0);
+	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
+
+	/* Build the expected image in the scratch buffer. */
+	b = 0;
+	patt = 0;
+	memset(scratch, 0, bufsize);
+	for (pr = bvec_test_ranges; pr->from >= 0; pr++, b++) {
+		u8 *p = scratch + pr->page * PAGE_SIZE;
+
+		for (i = pr->from; i < pr->to; i++)
+			p[i] = pattern(patt++);
+	}
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
+		if (buffer[i] != scratch[i])
+			return;
+	}
+
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Test copying from a ITER_BVEC-type iterator.
+ */
+static void __init iov_kunit_copy_from_bvec(struct kunit *test)
+{
+	const struct bvec_test_range *pr;
+	struct iov_iter iter;
+	struct bio_vec bvec[8];
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, j;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	for (i = 0; i < bufsize; i++)
+		buffer[i] = pattern(i);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	memset(scratch, 0, bufsize);
+
+	iov_kunit_load_bvec(test, &iter, WRITE, bvec, ARRAY_SIZE(bvec),
+			    bpages, npages, bufsize, bvec_test_ranges);
+	size = iter.count;
+
+	copied = copy_from_iter(scratch, size, &iter);
+
+	KUNIT_EXPECT_EQ(test, copied, size);
+	KUNIT_EXPECT_EQ(test, iter.count, 0);
+	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
+
+	/* Build the expected image in the main buffer. */
+	i = 0;
+	memset(buffer, 0, bufsize);
+	for (pr = bvec_test_ranges; pr->from >= 0; pr++) {
+		size_t patt = pr->page * PAGE_SIZE;
+
+		for (j = pr->from; j < pr->to; j++) {
+			buffer[i++] = pattern(patt + j);
+			if (i >= bufsize)
+				goto stop;
+		}
+	}
+stop:
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
+		if (scratch[i] != buffer[i])
+			return;
+	}
+
+	KUNIT_SUCCEED();
+}
+
+static void iov_kunit_destroy_xarray(void *data)
+{
+	struct xarray *xarray = data;
+
+	xa_destroy(xarray);
+	kfree(xarray);
+}
+
+static void __init iov_kunit_load_xarray(struct kunit *test,
+					 struct iov_iter *iter, int dir,
+					 struct xarray *xarray,
+					 struct page **pages, size_t npages)
+{
+	size_t size = 0;
+	int i;
+
+	for (i = 0; i < npages; i++) {
+		void *x = xa_store(xarray, i, pages[i], GFP_KERNEL);
+
+		KUNIT_ASSERT_FALSE(test, xa_is_err(x));
+		size += PAGE_SIZE;
+	}
+	iov_iter_xarray(iter, dir, xarray, 0, size);
+}
+
+static struct xarray *iov_kunit_create_xarray(struct kunit *test)
+{
+	struct xarray *xarray;
+
+	xarray = kzalloc(sizeof(struct xarray), GFP_KERNEL);
+	xa_init(xarray);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xarray);
+	kunit_add_action_or_reset(test, iov_kunit_destroy_xarray, xarray);
+	return xarray;
+}
+
+/*
+ * Test copying to a ITER_XARRAY-type iterator.
+ */
+static void __init iov_kunit_copy_to_xarray(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct xarray *xarray;
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, patt;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	xarray = iov_kunit_create_xarray(test);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	for (i = 0; i < bufsize; i++)
+		scratch[i] = pattern(i);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	memset(buffer, 0, bufsize);
+
+	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_xarray(&iter, READ, xarray, pr->from, size);
+		copied = copy_to_iter(scratch + i, size, &iter);
+
+		KUNIT_EXPECT_EQ(test, copied, size);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		KUNIT_EXPECT_EQ(test, iter.iov_offset, size);
+		i += size;
+	}
+
+	/* Build the expected image in the scratch buffer. */
+	patt = 0;
+	memset(scratch, 0, bufsize);
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
+		for (i = pr->from; i < pr->to; i++)
+			scratch[i] = pattern(patt++);
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
+		if (buffer[i] != scratch[i])
+			return;
+	}
+
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Test copying from a ITER_XARRAY-type iterator.
+ */
+static void __init iov_kunit_copy_from_xarray(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct xarray *xarray;
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, j;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	xarray = iov_kunit_create_xarray(test);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	for (i = 0; i < bufsize; i++)
+		buffer[i] = pattern(i);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	memset(scratch, 0, bufsize);
+
+	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_xarray(&iter, WRITE, xarray, pr->from, size);
+		copied = copy_from_iter(scratch + i, size, &iter);
+
+		KUNIT_EXPECT_EQ(test, copied, size);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		KUNIT_EXPECT_EQ(test, iter.iov_offset, size);
+		i += size;
+	}
+
+	/* Build the expected image in the main buffer. */
+	i = 0;
+	memset(buffer, 0, bufsize);
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		for (j = pr->from; j < pr->to; j++) {
+			buffer[i++] = pattern(j);
+			if (i >= bufsize)
+				goto stop;
+		}
+	}
+stop:
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
+		if (scratch[i] != buffer[i])
+			return;
+	}
+
+	KUNIT_SUCCEED();
+}
+
+static struct kunit_case __refdata iov_kunit_cases[] = {
+	KUNIT_CASE(iov_kunit_copy_to_kvec),
+	KUNIT_CASE(iov_kunit_copy_from_kvec),
+	KUNIT_CASE(iov_kunit_copy_to_bvec),
+	KUNIT_CASE(iov_kunit_copy_from_bvec),
+	KUNIT_CASE(iov_kunit_copy_to_xarray),
+	KUNIT_CASE(iov_kunit_copy_from_xarray),
+	{}
+};
+
+static struct kunit_suite iov_kunit_suite = {
+	.name = "iov_iter",
+	.test_cases = iov_kunit_cases,
+};
+
+kunit_test_suites(&iov_kunit_suite);

