Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3E37A82D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjITNGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 09:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbjITNGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D67ED
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695215119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJCqPShPuxX0OSXQWhEKRturENKmTo+NpvJVS0wCU18=;
        b=crim0Bd7q8XcIih6T6ycIY4Fz2F3YwluOwN0NWyjxSfJLOZjKCCczc/yN+X7IDxaXetyAk
        /TZIuVtQkyLHr4UJNgI16CRYjG70bg2gT/f314SyQxvNrya08PxvW8gCRyf/RQWLNHftal
        OhCNKs9Ee4maBcpEIgptc/BQpAMpVR0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-688-aNGlfMQdOTe2VK1zYWIPzQ-1; Wed, 20 Sep 2023 09:05:14 -0400
X-MC-Unique: aNGlfMQdOTe2VK1zYWIPzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3D67858F19;
        Wed, 20 Sep 2023 13:05:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BAA02156701;
        Wed, 20 Sep 2023 13:05:11 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [RFC PATCH v2 8/9] iov_iter: Add benchmarking kunit tests
Date:   Wed, 20 Sep 2023 14:03:59 +0100
Message-ID: <20230920130400.203330-9-dhowells@redhat.com>
In-Reply-To: <20230920130400.203330-1-dhowells@redhat.com>
References: <20230920130400.203330-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 2994c3f348ab..17f85f24b239 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -1261,6 +1261,253 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
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
+		iov_iter_kvec(&iter, ITER_SOURCE, kvec, ARRAY_SIZE(kvec), size);
+
+		a = ktime_get_real();
+		copied = copy_from_iter(scratch, size, &iter);
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
+		iov_iter_bvec(&iter, ITER_SOURCE, bvec, npages, size);
+		a = ktime_get_real();
+		copied = copy_from_iter(scratch, size, &iter);
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
+			size_t part = min_t(size_t, size, npages * PAGE_SIZE);
+
+			bvec = kunit_kmalloc_array(test, npages, sizeof(bvec[0]), GFP_KERNEL);
+			KUNIT_ASSERT_NOT_NULL(test, bvec);
+			for (j = 0; j < npages; j++)
+				bvec_set_page(&bvec[j], page, PAGE_SIZE, 0);
+
+			iov_iter_bvec(&iter, ITER_SOURCE, bvec, npages, part);
+			copied = copy_from_iter(scratch, part, &iter);
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
+		iov_iter_xarray(&iter, ITER_SOURCE, xarray, 0, size);
+		a = ktime_get_real();
+		copied = copy_from_iter(scratch, size, &iter);
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
@@ -1277,6 +1524,10 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),
+	KUNIT_CASE(iov_kunit_benchmark_kvec),
+	KUNIT_CASE(iov_kunit_benchmark_bvec),
+	KUNIT_CASE(iov_kunit_benchmark_bvec_split),
+	KUNIT_CASE(iov_kunit_benchmark_xarray),
 	{}
 };
 

