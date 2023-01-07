Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B174660AED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 01:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbjAGAg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 19:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbjAGAfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:35:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D130133D60
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 16:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673051669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhwJrX+/uggIQK7yrDCabQsdugOCpi4Tzwg2wYNTyQg=;
        b=OXFu9mjx1xHODHYu/ldP+eZdRMEfi5/1dbt++hU6cmEa3TszvRwNxbaadEeRtgkOj348kC
        44gYqsu1S+VpDw9kWJPgfNTjErZK+8nV1UDD997wxA4gW3dL//rUBlMjsoAQHpGTluasBo
        evLOnZqWOVePlo6rYHt62PZkK6RLjws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-Cddw6XzOOKa2Yet_lD6Qbw-1; Fri, 06 Jan 2023 19:34:23 -0500
X-MC-Unique: Cddw6XzOOKa2Yet_lD6Qbw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 640A7802D19;
        Sat,  7 Jan 2023 00:34:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17AD1492B07;
        Sat,  7 Jan 2023 00:34:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 7/7] iov_iter,
 block: Make bio structs pin pages rather than ref'ing if appropriate
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 07 Jan 2023 00:34:21 +0000
Message-ID: <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
In-Reply-To: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
References: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the block layer's bio code to use iov_iter_extract_pages() instead
of iov_iter_get_pages().  This will pin pages or leave them unaltered
rather than getting a ref on them as appropriate to the source iterator.

A field, bi_cleanup_mode, is added to the bio struct that gets set by
iov_iter_extract_pages() with FOLL_* flags indicating what cleanup is
necessary.  FOLL_GET -> put_page(), FOLL_PIN -> unpin_user_page().  Other
flags could also be used in future.

Newly allocated bio structs have bi_cleanup_mode set to FOLL_GET to
indicate that attached pages are ref'd by default.  Cloning sets it to 0.
__bio_iov_iter_get_pages() overrides it to what iov_iter_extract_pages()
indicates.

[!] Note that this is tested a bit with ext4, but nothing else.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Logan Gunthorpe <logang@deltatee.com>
---

 block/bio.c               |   47 +++++++++++++++++++++++++++++++++------------
 include/linux/blk_types.h |    1 +
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5f96fcae3f75..eafcbeba0bab 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -243,6 +243,11 @@ static void bio_free(struct bio *bio)
  * Users of this function have their own bio allocation. Subsequently,
  * they must remember to pair any call to bio_init() with bio_uninit()
  * when IO has completed, or when the bio is released.
+ *
+ * We set the initial assumption that pages attached to the bio will be
+ * released with put_page() by setting bi_cleanup_mode to FOLL_GET, but this
+ * should be set to FOLL_PIN if the page should be unpinned instead; if the
+ * pages should not be put or unpinned, this should be set to 0
  */
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	      unsigned short max_vecs, blk_opf_t opf)
@@ -274,6 +279,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	bio->bi_integrity = NULL;
 #endif
+	bio->bi_cleanup_mode = FOLL_GET;
 	bio->bi_vcnt = 0;
 
 	atomic_set(&bio->__bi_remaining, 1);
@@ -302,6 +308,7 @@ void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf)
 {
 	bio_uninit(bio);
 	memset(bio, 0, BIO_RESET_BYTES);
+	bio->bi_cleanup_mode = FOLL_GET;
 	atomic_set(&bio->__bi_remaining, 1);
 	bio->bi_bdev = bdev;
 	if (bio->bi_bdev)
@@ -814,6 +821,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_cleanup_mode = 0;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -1168,6 +1176,18 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 	return bio_add_page(bio, &folio->page, len, off) > 0;
 }
 
+/*
+ * Clean up a page according to the mode indicated by iov_iter_extract_pages(),
+ * where the page is may be pinned or may have a ref taken on it.
+ */
+static void bio_release_page(struct bio *bio, struct page *page)
+{
+	if (bio->bi_cleanup_mode & FOLL_PIN)
+		unpin_user_page(page);
+	if (bio->bi_cleanup_mode & FOLL_GET)
+		put_page(page);
+}
+
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct bvec_iter_all iter_all;
@@ -1176,7 +1196,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		bio_release_page(bio, bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1213,7 +1233,7 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 	}
 
 	if (same_page)
-		put_page(page);
+		bio_release_page(bio, page);
 	return 0;
 }
 
@@ -1227,7 +1247,7 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
 			queue_max_zone_append_sectors(q), &same_page) != len)
 		return -EINVAL;
 	if (same_page)
-		put_page(page);
+		bio_release_page(bio, page);
 	return 0;
 }
 
@@ -1238,10 +1258,10 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be mapped
  *
- * Pins pages from *iter and appends them to @bio's bvec array. The
- * pages will have to be released using put_page() when done.
- * For multi-segment *iter, this function only adds pages from the
- * next non-empty segment of the iov iterator.
+ * Pins pages from *iter and appends them to @bio's bvec array.  The pages will
+ * have to be released using put_page() or unpin_user_page() when done as
+ * according to bi_cleanup_mode.  For multi-segment *iter, this function only
+ * adds pages from the next non-empty segment of the iov iterator.
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1273,9 +1293,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
 	 */
-	size = iov_iter_get_pages(iter, pages,
-				  UINT_MAX - bio->bi_iter.bi_size,
-				  nr_pages, &offset, gup_flags);
+	size = iov_iter_extract_pages(iter, &pages,
+				      UINT_MAX - bio->bi_iter.bi_size,
+				      nr_pages, gup_flags,
+				      &offset, &bio->bi_cleanup_mode);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
@@ -1308,7 +1329,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	iov_iter_revert(iter, left);
 out:
 	while (i < nr_pages)
-		put_page(pages[i++]);
+		bio_release_page(bio, pages[i++]);
 
 	return ret;
 }
@@ -1489,8 +1510,8 @@ void bio_set_pages_dirty(struct bio *bio)
  * the BIO and re-dirty the pages in process context.
  *
  * It is expected that bio_check_pages_dirty() will wholly own the BIO from
- * here on.  It will run one put_page() against each page and will run one
- * bio_put() against the BIO.
+ * here on.  It will run one put_page() or unpin_user_page() against each page
+ * and will run one bio_put() against the BIO.
  */
 
 static void bio_dirty_fn(struct work_struct *work);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..883f873a01ef 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -289,6 +289,7 @@ struct bio {
 #endif
 	};
 
+	unsigned int		bi_cleanup_mode; /* How to clean up pages */
 	unsigned short		bi_vcnt;	/* how many bio_vec's */
 
 	/*


