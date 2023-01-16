Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD966D2BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjAPXLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjAPXKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F09F2CC66
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMfr1u6zgBhuUVGQJaZ/A8MK9MKewwNzFy741O6RN1U=;
        b=NajNmed+PdUhbCmI+dlIlvADNmUjeHTEvx8jiZNKERyg3puwI2EMxjMAN8TCKUqDf9jozr
        Pt2/lsuRKlGU2RlfOGc7m0bkEw47S5twJfZvWYwl0B6DDufdyrzB7Q3NRzMcP2jWtfU6fO
        RSyfq2MZ2TsmzWYjOltPpyf4wG70cKc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-5Pu3Y-WLN-GMPLkQPXNLGg-1; Mon, 16 Jan 2023 18:09:23 -0500
X-MC-Unique: 5Pu3Y-WLN-GMPLkQPXNLGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 686E9101A521;
        Mon, 16 Jan 2023 23:09:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0775A51FF;
        Mon, 16 Jan 2023 23:09:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 11/34] iov_iter,
 block: Make bio structs pin pages rather than ref'ing if appropriate
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:09:20 +0000
Message-ID: <167391056047.2311931.6772604381276147664.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the block layer's bio code to use iov_iter_extract_pages() instead
of iov_iter_get_pages().  This will pin pages or leave them unaltered
rather than getting a ref on them as appropriate to the source iterator.

The pages need to be pinned for DIO-read rather than having refs taken on
them to prevent VM copy-on-write from malfunctioning during a concurrent
fork() (the result of the I/O would otherwise end up only visible to the
child process and not the parent).

To implement this:

 (1) If the BIO_PAGE_REFFED flag is set, this causes attached pages to be
     passed to put_page() during cleanup.

 (2) A BIO_PAGE_PINNED flag is provided.  If set, this causes attached
     pages to be passed to unpin_user_page() during cleanup.

 (3) BIO_PAGE_REFFED is set by default and BIO_PAGE_PINNED is cleared by
     default when the bio is (re-)initialised.

 (4) If iov_iter_extract_pages() indicates FOLL_GET, this causes
     BIO_PAGE_REFFED to be set and if FOLL_PIN is indicated, this causes
     BIO_PAGE_PINNED to be set.  If it returns neither FOLL_* flag, then
     both BIO_PAGE_* flags will be cleared.

     Mixing sets of pages with different clean up modes is not supported.

 (5) Cloned bio structs have both flags cleared.

 (6) bio_release_pages() will do the release if either BIO_PAGE_* flag is
     set.

[!] Note that this is tested a bit with ext4, but nothing else.

Changes
=======
ver #5)
 - Transcribe the FOLL_* flags returned by iov_iter_extract_pages() to
   BIO_* flags and got rid of bi_cleanup_mode.
 - Replaced BIO_NO_PAGE_REF to BIO_PAGE_REFFED in the preceding patch.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Jan Kara <jack@suse.cz>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: linux-block@vger.kernel.org

Link: https://lore.kernel.org/r/167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/167344731521.2425628.5403113335062567245.stgit@warthog.procyon.org.uk/ # v5
---

 block/bio.c         |   34 +++++++++++++++++++---------------
 block/blk-map.c     |   22 +++++++++++-----------
 block/blk.h         |   25 +++++++++++++++++++++++++
 include/linux/bio.h |    3 ++-
 4 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d8c636cefcdd..f9ee3625d65c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -245,8 +245,9 @@ static void bio_free(struct bio *bio)
  * when IO has completed, or when the bio is released.
  *
  * We set the initial assumption that pages attached to the bio will be
- * released with put_page() by setting BIO_PAGE_REFFED; if the pages
- * should not be put, this flag should be cleared.
+ * released with put_page() by setting BIO_PAGE_REFFED, but this should be set
+ * to BIO_PAGE_PINNED if the page should be unpinned instead; if the pages
+ * should not be put or unpinned, these flags should be cleared.
  */
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	      unsigned short max_vecs, blk_opf_t opf)
@@ -819,6 +820,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 {
 	bio_set_flag(bio, BIO_CLONED);
 	bio_clear_flag(bio, BIO_PAGE_REFFED);
+	bio_clear_flag(bio, BIO_PAGE_PINNED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_iter = bio_src->bi_iter;
 
@@ -1183,7 +1185,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		bio_release_page(bio, bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1220,7 +1222,7 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 	}
 
 	if (same_page)
-		put_page(page);
+		bio_release_page(bio, page);
 	return 0;
 }
 
@@ -1234,7 +1236,7 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
 			queue_max_zone_append_sectors(q), &same_page) != len)
 		return -EINVAL;
 	if (same_page)
-		put_page(page);
+		bio_release_page(bio, page);
 	return 0;
 }
 
@@ -1245,10 +1247,10 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be mapped
  *
- * Pins pages from *iter and appends them to @bio's bvec array. The
- * pages will have to be released using put_page() when done.
- * For multi-segment *iter, this function only adds pages from the
- * next non-empty segment of the iov iterator.
+ * Extracts pages from *iter and appends them to @bio's bvec array.  The pages
+ * will have to be cleaned up in the way indicated by the BIO_PAGE_REFFED and
+ * BIO_PAGE_PINNED flags.  For a multi-segment *iter, this function only adds
+ * pages from the next non-empty segment of the iov iterator.
  *
  * The I/O direction is determined from the bio operation type.
  */
@@ -1284,12 +1286,14 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
 	 */
-	size = iov_iter_get_pages(iter, pages,
-				  UINT_MAX - bio->bi_iter.bi_size,
-				  nr_pages, &offset, gup_flags);
+	size = iov_iter_extract_pages(iter, &pages,
+				      UINT_MAX - bio->bi_iter.bi_size,
+				      nr_pages, gup_flags, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
+	bio_set_cleanup_mode(bio, iter, gup_flags);
+
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 
 	trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
@@ -1319,7 +1323,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	iov_iter_revert(iter, left);
 out:
 	while (i < nr_pages)
-		put_page(pages[i++]);
+		bio_release_page(bio, pages[i++]);
 
 	return ret;
 }
@@ -1502,8 +1506,8 @@ void bio_set_pages_dirty(struct bio *bio)
  * the BIO and re-dirty the pages in process context.
  *
  * It is expected that bio_check_pages_dirty() will wholly own the BIO from
- * here on.  It will run one put_page() against each page and will run one
- * bio_put() against the BIO.
+ * here on.  It will run one put_page() or unpin_user_page() against each page
+ * and will run one bio_put() against the BIO.
  */
 
 static void bio_dirty_fn(struct work_struct *work);
diff --git a/block/blk-map.c b/block/blk-map.c
index c30be529fb55..be769f889eca 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -285,24 +285,24 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		gup_flags |= FOLL_PCI_P2PDMA;
 
 	while (iov_iter_count(iter)) {
-		struct page **pages, *stack_pages[UIO_FASTIOV];
+		struct page *stack_pages[UIO_FASTIOV];
+		struct page **pages = stack_pages;
 		ssize_t bytes;
 		size_t offs;
 		int npages;
 
-		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
-			pages = stack_pages;
-			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
-						   nr_vecs, &offs, gup_flags);
-		} else {
-			bytes = iov_iter_get_pages_alloc(iter, &pages,
-						LONG_MAX, &offs, gup_flags);
-		}
+		if (nr_vecs > ARRAY_SIZE(stack_pages))
+			pages = NULL;
+
+		bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
+					       nr_vecs, gup_flags, &offs);
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
 			goto out_unmap;
 		}
 
+		bio_set_cleanup_mode(bio, iter, gup_flags);
+
 		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
 
 		if (unlikely(offs & queue_dma_alignment(rq->q)))
@@ -319,7 +319,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
 						     max_sectors, &same_page)) {
 					if (same_page)
-						put_page(page);
+						bio_release_page(bio, page);
 					break;
 				}
 
@@ -331,7 +331,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		 * release the pages we didn't map into the bio, if any
 		 */
 		while (j < npages)
-			put_page(pages[j++]);
+			bio_release_page(bio, pages[j++]);
 		if (pages != stack_pages)
 			kvfree(pages);
 		/* couldn't stuff something into bio? */
diff --git a/block/blk.h b/block/blk.h
index 4c3b3325219a..29f12f758915 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -425,6 +425,31 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+/*
+ * Set the cleanup mode for a bio from an iterator and the GUP flags.
+ */
+static inline void bio_set_cleanup_mode(struct bio *bio, struct iov_iter *iter,
+					unsigned int gup_flags)
+{
+	unsigned int cleanup_mode;
+
+	bio_clear_flag(bio, BIO_PAGE_REFFED);
+	cleanup_mode = iov_iter_extract_mode(iter, gup_flags);
+	if (cleanup_mode & FOLL_GET)
+		bio_set_flag(bio, BIO_PAGE_REFFED);
+	if (cleanup_mode & FOLL_PIN)
+		bio_set_flag(bio, BIO_PAGE_PINNED);
+}
+
+/*
+ * Clean up a page appropriately, where the page may be pinned, may have a
+ * ref taken on it or neither.
+ */
+static inline void bio_release_page(struct bio *bio, struct page *page)
+{
+	page_put_unpin(page, bio->bi_flags & (FOLL_GET | FOLL_PIN));
+}
+
 struct request_queue *blk_alloc_queue(int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 69b32c5532f6..856b28e41d24 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -496,7 +496,8 @@ void zero_fill_bio(struct bio *bio);
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	if (bio_flagged(bio, BIO_PAGE_REFFED))
+	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
+	    bio_flagged(bio, BIO_PAGE_PINNED))
 		__bio_release_pages(bio, mark_dirty);
 }
 


