Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C786479EF7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjIMQ5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjIMQ5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBD701BDA
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iCJtvcwek/PzSsuqar23vXotUlaq5CuwRpVtwMRiY9g=;
        b=KYXYv8knQD6n4EEFWIImB58eX4RyEtEoTjnSBVukJ09JyIDj/1bzYfAAwG6/193moQqU3g
        Kjr9RRr4Xva87bzmE2u7vUx9S5eZ64EffU8FcFcg0lXWQ4q7d+OuPOoCLoD9gjpTSnCI0O
        tVLII1gwga5ezrRqX7Duq42FtBuVgEA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-3UG6PQn5O3qmluWTH-Ob_w-1; Wed, 13 Sep 2023 12:56:56 -0400
X-MC-Unique: 3UG6PQn5O3qmluWTH-Ob_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA3DC185A79B;
        Wed, 13 Sep 2023 16:56:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D05340C6EA8;
        Wed, 13 Sep 2023 16:56:54 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/13] iov_iter: Add a benchmarking kunit test
Date:   Wed, 13 Sep 2023 17:56:36 +0100
Message-ID: <20230913165648.2570623-2-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-1-dhowells@redhat.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---
 lib/kunit_iov_iter.c | 181 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 859b67c4d697..478fea956f58 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -756,6 +756,184 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 	KUNIT_SUCCEED();
 }
 
+static void iov_kunit_free_page(void *data)
+{
+	__free_page(data);
+}
+
+static void __init iov_kunit_benchmark_print_stats(struct kunit *test,
+						   unsigned int *samples)
+{
+	unsigned long total = 0;
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		total += samples[i];
+		kunit_info(test, "run %x: %u uS\n", i, samples[i]);
+	}
+
+	kunit_info(test, "avg %lu uS\n", total / 16);
+}
+
+/*
+ * Time copying 256MiB through an ITER_BVEC.
+ */
+static void __init iov_kunit_benchmark_bvec(struct kunit *test)
+{
+	struct iov_iter iter;
+	struct bio_vec *bvec;
+	struct page *page, **pages;
+	unsigned int samples[16];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size = 256 * 1024 * 1024, npages = size / PAGE_SIZE;
+	void *scratch;
+	int i;
+
+	/* Allocate a page and tile it repeatedly in the buffer. */
+	page = alloc_page(GFP_KERNEL);
+        KUNIT_ASSERT_NOT_NULL(test, page);
+	kunit_add_action_or_reset(test, iov_kunit_free_page, page);
+
+	bvec = kunit_kmalloc_array(test, npages, sizeof(bvec[0]), GFP_KERNEL);
+        KUNIT_ASSERT_NOT_NULL(test, bvec);
+	for (i = 0; i < npages; i++)
+		bvec_set_page(&bvec[i], page, PAGE_SIZE, 0);
+
+	/* Create a single large buffer to copy to/from. */
+	pages = kunit_kmalloc_array(test, npages, sizeof(pages[0]), GFP_KERNEL);
+        KUNIT_ASSERT_NOT_NULL(test, pages);
+	for (i = 0; i < npages; i++)
+		pages[i] = page;
+
+	scratch = vmap(pages, npages, VM_MAP | VM_MAP_PUT_PAGES, PAGE_KERNEL);
+        KUNIT_ASSERT_NOT_NULL(test, scratch);
+	kunit_add_action_or_reset(test, iov_kunit_unmap, scratch);
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over BVEC:\n");
+	for (i = 0; i < 16; i++) {
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
+	struct page *page, **pages;
+	unsigned int samples[16];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size, npages = 64;
+	void *scratch;
+	int i, j;
+
+	/* Allocate a page and tile it repeatedly in the buffer. */
+	page = alloc_page(GFP_KERNEL);
+        KUNIT_ASSERT_NOT_NULL(test, page);
+	kunit_add_action_or_reset(test, iov_kunit_free_page, page);
+
+	/* Create a single large buffer to copy to/from. */
+	pages = kunit_kmalloc_array(test, npages, sizeof(pages[0]), GFP_KERNEL);
+        KUNIT_ASSERT_NOT_NULL(test, pages);
+	for (i = 0; i < npages; i++)
+		pages[i] = page;
+
+	scratch = vmap(pages, npages, VM_MAP | VM_MAP_PUT_PAGES, PAGE_KERNEL);
+        KUNIT_ASSERT_NOT_NULL(test, scratch);
+	kunit_add_action_or_reset(test, iov_kunit_unmap, scratch);
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over BVEC:\n");
+	for (i = 0; i < 16; i++) {
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
+	struct page *page, **pages;
+	unsigned int samples[16];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size = 256 * 1024 * 1024, npages = size / PAGE_SIZE;
+	void *scratch;
+	int i;
+
+	/* Allocate a page and tile it repeatedly in the buffer. */
+	page = alloc_page(GFP_KERNEL);
+        KUNIT_ASSERT_NOT_NULL(test, page);
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
+	pages = kunit_kmalloc_array(test, npages, sizeof(pages[0]), GFP_KERNEL);
+        KUNIT_ASSERT_NOT_NULL(test, pages);
+	for (i = 0; i < npages; i++)
+		pages[i] = page;
+
+	scratch = vmap(pages, npages, VM_MAP | VM_MAP_PUT_PAGES, PAGE_KERNEL);
+        KUNIT_ASSERT_NOT_NULL(test, scratch);
+	kunit_add_action_or_reset(test, iov_kunit_unmap, scratch);
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over XARRAY:\n");
+	for (i = 0; i < 16; i++) {
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
 	KUNIT_CASE(iov_kunit_copy_to_kvec),
 	KUNIT_CASE(iov_kunit_copy_from_kvec),
@@ -766,6 +944,9 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),
+	KUNIT_CASE(iov_kunit_benchmark_bvec),
+	KUNIT_CASE(iov_kunit_benchmark_bvec_split),
+	KUNIT_CASE(iov_kunit_benchmark_xarray),
 	{}
 };
 

