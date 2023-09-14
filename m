Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7237A10B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 00:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjINWQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 18:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjINWQk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 475DE2719
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694729745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMlwmXq8j0rs4LEdDpXfVHzrC0kRRfOaExs7WZepjuM=;
        b=imvRgwR2FGlanT0tKtfn59vtABPBcdpRGK6YDTBZWpvrDfJ1T1TShy2mnS7RJYmx0166tW
        bPYLb0BxXKtPR0eEoxQspPXB3brFgl5TsV5kv/ITCgCYrOOqA5tzt6X8oJEai24RWaVrub
        n9RdulabanC7NxqiuxGDzSWyhR7vu6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-683-hhajP-8pPVuMhR_hSlZ2uQ-1; Thu, 14 Sep 2023 18:15:40 -0400
X-MC-Unique: hhajP-8pPVuMhR_hSlZ2uQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8108F101A550;
        Thu, 14 Sep 2023 22:15:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B0877B62;
        Thu, 14 Sep 2023 22:15:37 +0000 (UTC)
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
Subject: [RFC PATCH 3/9] iov_iter: Consolidate the test vector struct in the kunit tests
Date:   Thu, 14 Sep 2023 23:15:20 +0100
Message-ID: <20230914221526.3153402-4-dhowells@redhat.com>
In-Reply-To: <20230914221526.3153402-1-dhowells@redhat.com>
References: <20230914221526.3153402-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Consolidate the test vector struct in the kunit tests so that the bvec
pattern check helpers can share with the kvec check helpers.

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
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 lib/kunit_iov_iter.c | 90 ++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index ee586eb652b4..4925ca37cde6 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -18,22 +18,46 @@ MODULE_DESCRIPTION("iov_iter testing");
 MODULE_AUTHOR("David Howells <dhowells@redhat.com>");
 MODULE_LICENSE("GPL");
 
-struct kvec_test_range {
+struct iov_kunit_range {
 	int	page, from, to;
 };
 
-static const struct kvec_test_range kvec_test_ranges[] = {
-	{ 0, 0x00002, 0x00002 },
-	{ 0, 0x00027, 0x03000 },
-	{ 0, 0x05193, 0x18794 },
-	{ 0, 0x20000, 0x20000 },
-	{ 0, 0x20000, 0x24000 },
-	{ 0, 0x24000, 0x27001 },
-	{ 0, 0x29000, 0xffffb },
-	{ 0, 0xffffd, 0xffffe },
+/*
+ * Ranges that to use in tests where we have address/offset ranges to play
+ * with (ie. KVEC) or where we have a single blob that we can copy
+ * arbitrary chunks of (ie. XARRAY).
+ */
+static const struct iov_kunit_range kvec_test_ranges[] = {
+	{ 0, 0x00002, 0x00002 }, /* Start with an empty range */
+	{ 0, 0x00027, 0x03000 }, /* Midpage to page end */
+	{ 0, 0x05193, 0x18794 }, /* Midpage to midpage */
+	{ 0, 0x20000, 0x20000 }, /* Empty range in the middle */
+	{ 0, 0x20000, 0x24000 }, /* Page start to page end */
+	{ 0, 0x24000, 0x27001 }, /* Page end to midpage */
+	{ 0, 0x29000, 0xffffb }, /* Page start to midpage */
+	{ 0, 0xffffd, 0xffffe }, /* Almost contig to last, ending in same page */
 	{ -1 }
 };
 
+/*
+ * Ranges that to use in tests where we have a list of partial pages to
+ * play with (ie. BVEC).
+ */
+static const struct iov_kunit_range bvec_test_ranges[] = {
+	{ 0, 0x0002, 0x0002 }, /* Start with an empty range */
+	{ 1, 0x0027, 0x0893 }, /* Random part of page */
+	{ 2, 0x0193, 0x0794 }, /* Random part of page */
+	{ 3, 0x0000, 0x1000 }, /* Full page */
+	{ 4, 0x0000, 0x1000 }, /* Full page logically contig to last */
+	{ 5, 0x0000, 0x1000 }, /* Full page logically contig to last */
+	{ 6, 0x0000, 0x0ffb }, /* Part page logically contig to last */
+	{ 6, 0x0ffd, 0x0ffe }, /* Part of prev page, but not quite contig */
+	{ -1 }
+};
+
+/*
+ * The pattern to fill with.
+ */
 static inline u8 pattern(unsigned long x)
 {
 	return x & 0xff;
@@ -44,6 +68,9 @@ static void iov_kunit_unmap(void *data)
 	vunmap(data);
 }
 
+/*
+ * Create a buffer out of some pages and return a vmap'd pointer to it.
+ */
 static void *__init iov_kunit_create_buffer(struct kunit *test,
 					    struct page ***ppages,
 					    size_t npages)
@@ -75,7 +102,7 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
  */
 static void iov_kunit_build_to_reference_pattern(struct kunit *test, u8 *scratch,
 						 size_t bufsize,
-						 const struct kvec_test_range *pr)
+						 const struct iov_kunit_range *pr)
 {
 	int i, patt = 0;
 
@@ -91,7 +118,7 @@ static void iov_kunit_build_to_reference_pattern(struct kunit *test, u8 *scratch
  */
 static void iov_kunit_build_from_reference_pattern(struct kunit *test, u8 *buffer,
 						   size_t bufsize,
-						   const struct kvec_test_range *pr)
+						   const struct iov_kunit_range *pr)
 {
 	size_t i = 0, j;
 
@@ -124,7 +151,7 @@ static void __init iov_kunit_load_kvec(struct kunit *test,
 				       struct iov_iter *iter, int dir,
 				       struct kvec *kvec, unsigned int kvmax,
 				       void *buffer, size_t bufsize,
-				       const struct kvec_test_range *pr)
+				       const struct iov_kunit_range *pr)
 {
 	size_t size = 0;
 	int i;
@@ -217,28 +244,12 @@ static void __init iov_kunit_copy_from_kvec(struct kunit *test)
 	KUNIT_SUCCEED();
 }
 
-struct bvec_test_range {
-	int	page, from, to;
-};
-
-static const struct bvec_test_range bvec_test_ranges[] = {
-	{ 0, 0x0002, 0x0002 },
-	{ 1, 0x0027, 0x0893 },
-	{ 2, 0x0193, 0x0794 },
-	{ 3, 0x0000, 0x1000 },
-	{ 4, 0x0000, 0x1000 },
-	{ 5, 0x0000, 0x1000 },
-	{ 6, 0x0000, 0x0ffb },
-	{ 6, 0x0ffd, 0x0ffe },
-	{ -1 }
-};
-
 static void __init iov_kunit_load_bvec(struct kunit *test,
 				       struct iov_iter *iter, int dir,
 				       struct bio_vec *bvec, unsigned int bvmax,
 				       struct page **pages, size_t npages,
 				       size_t bufsize,
-				       const struct bvec_test_range *pr)
+				       const struct iov_kunit_range *pr)
 {
 	struct page *can_merge = NULL, *page;
 	size_t size = 0;
@@ -276,13 +287,13 @@ static void __init iov_kunit_load_bvec(struct kunit *test,
  */
 static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 {
-	const struct bvec_test_range *pr;
+	const struct iov_kunit_range *pr;
 	struct iov_iter iter;
 	struct bio_vec bvec[8];
 	struct page **spages, **bpages;
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, b, patt;
+	int i, patt;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -305,10 +316,9 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
 
 	/* Build the expected image in the scratch buffer. */
-	b = 0;
 	patt = 0;
 	memset(scratch, 0, bufsize);
-	for (pr = bvec_test_ranges; pr->page >= 0; pr++, b++) {
+	for (pr = bvec_test_ranges; pr->page >= 0; pr++) {
 		u8 *p = scratch + pr->page * PAGE_SIZE;
 
 		for (i = pr->from; i < pr->to; i++)
@@ -324,7 +334,7 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
  */
 static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 {
-	const struct bvec_test_range *pr;
+	const struct iov_kunit_range *pr;
 	struct iov_iter iter;
 	struct bio_vec bvec[8];
 	struct page **spages, **bpages;
@@ -411,7 +421,7 @@ static struct xarray *iov_kunit_create_xarray(struct kunit *test)
  */
 static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 {
-	const struct kvec_test_range *pr;
+	const struct iov_kunit_range *pr;
 	struct iov_iter iter;
 	struct xarray *xarray;
 	struct page **spages, **bpages;
@@ -457,7 +467,7 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
  */
 static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 {
-	const struct kvec_test_range *pr;
+	const struct iov_kunit_range *pr;
 	struct iov_iter iter;
 	struct xarray *xarray;
 	struct page **spages, **bpages;
@@ -503,7 +513,7 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
  */
 static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
 {
-	const struct kvec_test_range *pr;
+	const struct iov_kunit_range *pr;
 	struct iov_iter iter;
 	struct page **bpages, *pagelist[8], **pages = pagelist;
 	struct kvec kvec[8];
@@ -583,7 +593,7 @@ static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
  */
 static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 {
-	const struct bvec_test_range *pr;
+	const struct iov_kunit_range *pr;
 	struct iov_iter iter;
 	struct page **bpages, *pagelist[8], **pages = pagelist;
 	struct bio_vec bvec[8];
@@ -661,7 +671,7 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
  */
 static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 {
-	const struct kvec_test_range *pr;
+	const struct iov_kunit_range *pr;
 	struct iov_iter iter;
 	struct xarray *xarray;
 	struct page **bpages, *pagelist[8], **pages = pagelist;

