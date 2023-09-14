Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDCA7A10C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 00:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjINWRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjINWRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E4F2733
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694729758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13E9rSgNeaf9HLX+Bou+ex5VndTo0fyGvRBBzgyH0qo=;
        b=ZeWoUdJtN+TvHZekV7iD0tkqGJzH/FLzFBe/2qc63aJf43iasgKgXILYTE4RRNVpdJyrQt
        vZvDKmU2ITVS5SX8oemFJZ2ZDVit4PPAYFKZbYTmdb6DdojwfzXAbM5FflTz4QdhW0Uh12
        N2adkIOb02a65jMnmyamFBgPsbHWblc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-0X13EdfBPZWIibMdnXSzew-1; Thu, 14 Sep 2023 18:15:57 -0400
X-MC-Unique: 0X13EdfBPZWIibMdnXSzew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7A5A816523;
        Thu, 14 Sep 2023 22:15:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8637321B20B1;
        Thu, 14 Sep 2023 22:15:52 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 8/9] iov_iter: Add benchmarking kunit tests
Date:   Thu, 14 Sep 2023 23:15:25 +0100
Message-ID: <20230914221526.3153402-9-dhowells@redhat.com>
In-Reply-To: <20230914221526.3153402-1-dhowells@redhat.com>
References: <20230914221526.3153402-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kunit tests to benchmark 256MiB copies to a KVEC iterator, a BVEC
iterator, an XARRAY iterator and to a loop that allocates 256-page BVECs
and fills them in (similar to a maximal bio struct being set up).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Brendan Higgins <brendanhiggins@google.com>
cc: David Gow <davidgow@google.com>
cc: linux-kselftest@vger.kernel.org
cc: kunit-dev@googlegroups.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 lib/kunit_iov_iter.c | 251 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 0b7961bbab62..f8d0cd6a2923 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -1241,6 +1241,253 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 	KUNIT_SUCCEED();
 }
 
+static void iov_kunit_free_page(void *data)
+{
+	__free_page(data);
+}
+
+#define IOV_KUNIT_NR_SAMPLES 16
+static void __init iov_kunit_benchmark_print_stats(struct kunit *test,
+						   unsigned int *samples)
+{
+	unsigned long long sumsq = 0;
+	unsigned long total = 0, mean, stddev;
+	unsigned int n = IOV_KUNIT_NR_SAMPLES;
+	int i;
+
+	//for (i = 0; i < n; i++)
+	//	kunit_info(test, "run %x: %u uS\n", i, samples[i]);
+
+	/* Ignore the 0th sample as that may include extra overhead such as
+	 * setting up PTEs.
+	 */
+	samples++;
+	n--;
+	for (i = 0; i < n; i++)
+		total += samples[i];
+	mean = total / n;
+
+	for (i = 0; i < n; i++) {
+		long s = samples[i] - mean;
+
+		sumsq += s * s;
+	}
+	stddev = int_sqrt64(sumsq);
+
+	kunit_info(test, "avg %lu uS, stddev %lu uS\n", mean, stddev);
+}
+
+/*
+ * Create a source buffer for benchmarking.
+ */
+static void *__init iov_kunit_create_source(struct kunit *test, size_t npages)
+{
+	struct page *page, **pages;
+	void *scratch;
+	size_t i;
+
+	/* Allocate a page and tile it repeatedly in the buffer. */
+	page = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	kunit_add_action_or_reset(test, iov_kunit_free_page, page);
+
+	pages = kunit_kmalloc_array(test, npages, sizeof(pages[0]), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pages);
+	for (i = 0; i < npages; i++) {
+		pages[i] = page;
+		get_page(page);
+	}
+
+	scratch = vmap(pages, npages, VM_MAP | VM_MAP_PUT_PAGES, PAGE_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, scratch);
+	kunit_add_action_or_reset(test, iov_kunit_unmap, scratch);
+	return scratch;
+}
+
+/*
+ * Time copying 256MiB through an ITER_KVEC.
+ */
+static void __init iov_kunit_benchmark_kvec(struct kunit *test)
+{
+	struct iov_iter iter;
+	struct kvec kvec[8];
+	unsigned int samples[IOV_KUNIT_NR_SAMPLES];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size = 256 * 1024 * 1024, npages = size / PAGE_SIZE, part;
+	void *scratch, *buffer;
+	int i;
+
+	/* Allocate a huge buffer and populate it with pages. */
+	buffer = iov_kunit_create_source(test, npages);
+
+	/* Create a single large buffer to copy to/from. */
+	scratch = iov_kunit_create_source(test, npages);
+
+	/* Split the target over a number of kvecs */
+	copied = 0;
+	for (i = 0; i < ARRAY_SIZE(kvec); i++) {
+		part = size / ARRAY_SIZE(kvec);
+		kvec[i].iov_base = buffer + copied;
+		kvec[i].iov_len = part;
+		copied += part;
+	}
+	kvec[i - 1].iov_len += size - part;
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over KVEC:\n");
+	for (i = 0; i < IOV_KUNIT_NR_SAMPLES; i++) {
+		iov_iter_kvec(&iter, ITER_DEST, kvec, ARRAY_SIZE(kvec), size);
+
+		a = ktime_get_real();
+		copied = copy_to_iter(scratch, size, &iter);
+		b = ktime_get_real();
+		KUNIT_EXPECT_EQ(test, copied, size);
+		samples[i] = ktime_to_us(ktime_sub(b, a));
+	}
+
+	iov_kunit_benchmark_print_stats(test, samples);
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Time copying 256MiB through an ITER_BVEC.
+ */
+static void __init iov_kunit_benchmark_bvec(struct kunit *test)
+{
+	struct iov_iter iter;
+	struct bio_vec *bvec;
+	struct page *page;
+	unsigned int samples[IOV_KUNIT_NR_SAMPLES];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size = 256 * 1024 * 1024, npages = size / PAGE_SIZE;
+	void *scratch;
+	int i;
+
+	/* Allocate a page and tile it repeatedly in the buffer. */
+	page = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	kunit_add_action_or_reset(test, iov_kunit_free_page, page);
+
+	bvec = kunit_kmalloc_array(test, npages, sizeof(bvec[0]), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, bvec);
+	for (i = 0; i < npages; i++)
+		bvec_set_page(&bvec[i], page, PAGE_SIZE, 0);
+
+	/* Create a single large buffer to copy to/from. */
+	scratch = iov_kunit_create_source(test, npages);
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over BVEC:\n");
+	for (i = 0; i < IOV_KUNIT_NR_SAMPLES; i++) {
+		iov_iter_bvec(&iter, ITER_DEST, bvec, npages, size);
+		a = ktime_get_real();
+		copied = copy_to_iter(scratch, size, &iter);
+		b = ktime_get_real();
+		KUNIT_EXPECT_EQ(test, copied, size);
+		samples[i] = ktime_to_us(ktime_sub(b, a));
+	}
+
+	iov_kunit_benchmark_print_stats(test, samples);
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Time copying 256MiB through an ITER_BVEC in 256 page chunks.
+ */
+static void __init iov_kunit_benchmark_bvec_split(struct kunit *test)
+{
+	struct iov_iter iter;
+	struct bio_vec *bvec;
+	struct page *page;
+	unsigned int samples[IOV_KUNIT_NR_SAMPLES];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size, npages = 64;
+	void *scratch;
+	int i, j;
+
+	/* Allocate a page and tile it repeatedly in the buffer. */
+	page = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	kunit_add_action_or_reset(test, iov_kunit_free_page, page);
+
+	/* Create a single large buffer to copy to/from. */
+	scratch = iov_kunit_create_source(test, npages);
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over BVEC:\n");
+	for (i = 0; i < IOV_KUNIT_NR_SAMPLES; i++) {
+		size = 256 * 1024 * 1024;
+		a = ktime_get_real();
+		do {
+			size_t part = min(size, npages * PAGE_SIZE);
+
+			bvec = kunit_kmalloc_array(test, npages, sizeof(bvec[0]), GFP_KERNEL);
+			KUNIT_ASSERT_NOT_NULL(test, bvec);
+			for (j = 0; j < npages; j++)
+				bvec_set_page(&bvec[j], page, PAGE_SIZE, 0);
+
+			iov_iter_bvec(&iter, ITER_DEST, bvec, npages, part);
+			copied = copy_to_iter(scratch, part, &iter);
+			KUNIT_EXPECT_EQ(test, copied, part);
+			size -= part;
+		} while (size > 0);
+		b = ktime_get_real();
+		samples[i] = ktime_to_us(ktime_sub(b, a));
+	}
+
+	iov_kunit_benchmark_print_stats(test, samples);
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Time copying 256MiB through an ITER_XARRAY.
+ */
+static void __init iov_kunit_benchmark_xarray(struct kunit *test)
+{
+	struct iov_iter iter;
+	struct xarray *xarray;
+	struct page *page;
+	unsigned int samples[IOV_KUNIT_NR_SAMPLES];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size = 256 * 1024 * 1024, npages = size / PAGE_SIZE;
+	void *scratch;
+	int i;
+
+	/* Allocate a page and tile it repeatedly in the buffer. */
+	page = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	kunit_add_action_or_reset(test, iov_kunit_free_page, page);
+
+	xarray = iov_kunit_create_xarray(test);
+
+	for (i = 0; i < npages; i++) {
+		void *x = xa_store(xarray, i, page, GFP_KERNEL);
+
+		KUNIT_ASSERT_FALSE(test, xa_is_err(x));
+	}
+
+	/* Create a single large buffer to copy to/from. */
+	scratch = iov_kunit_create_source(test, npages);
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over XARRAY:\n");
+	for (i = 0; i < IOV_KUNIT_NR_SAMPLES; i++) {
+		iov_iter_xarray(&iter, ITER_DEST, xarray, 0, size);
+		a = ktime_get_real();
+		copied = copy_to_iter(scratch, size, &iter);
+		b = ktime_get_real();
+		KUNIT_EXPECT_EQ(test, copied, size);
+		samples[i] = ktime_to_us(ktime_sub(b, a));
+	}
+
+	iov_kunit_benchmark_print_stats(test, samples);
+	KUNIT_SUCCEED();
+}
+
 static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_to_ubuf),
 	KUNIT_CASE(iov_kunit_copy_from_ubuf),
@@ -1257,6 +1504,10 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),
+	KUNIT_CASE(iov_kunit_benchmark_kvec),
+	KUNIT_CASE(iov_kunit_benchmark_bvec),
+	KUNIT_CASE(iov_kunit_benchmark_bvec_split),
+	KUNIT_CASE(iov_kunit_benchmark_xarray),
 	{}
 };
 

