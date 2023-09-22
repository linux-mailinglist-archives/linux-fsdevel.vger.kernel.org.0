Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC87AB0D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 13:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjIVLbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 07:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjIVLbq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315881B1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 04:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695382257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMlwmXq8j0rs4LEdDpXfVHzrC0kRRfOaExs7WZepjuM=;
        b=TB9OuWu0w9d/wl5djx/JGdvfi8IC2wUJBhNsBr59dTNQNVgzdiSibAsDvfKSjuv9Yxhy2q
        0YqKO22zv0uugHHUQIRwQtJssvTLyLnzJz7JcYYV8AXQ7oGN9GAdLXQpYMtZogzGbZyJCj
        /y5RaCj5+hCPxhgqy/xDQCmJmdfoVsw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-sXVlNUA6N6ygXS-_SjqBww-1; Fri, 22 Sep 2023 07:30:54 -0400
X-MC-Unique: sXVlNUA6N6ygXS-_SjqBww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F00B080349C;
        Fri, 22 Sep 2023 11:30:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3DA720268D6;
        Fri, 22 Sep 2023 11:30:50 +0000 (UTC)
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
Subject: [PATCH v3 03/10] iov_iter: Consolidate the test vector struct in the kunit tests
Date:   Fri, 22 Sep 2023 12:30:31 +0100
Message-ID: <20230922113038.1135236-4-dhowells@redhat.com>
In-Reply-To: <20230922113038.1135236-1-dhowells@redhat.com>
References: <20230922113038.1135236-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

