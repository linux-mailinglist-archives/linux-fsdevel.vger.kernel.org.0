Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FE1665E14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 15:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjAKOeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 09:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjAKOcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:32:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD471DF10
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 06:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673447321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSfE8pHh61YZwfA9ad1KmVIiwnIwXiK1i+BuDQ7s/wI=;
        b=KA55fUUkHa78sGEfkLy+xNStUJhgurXTTacZ+tZ5ippkKnYbvCpOE0l51I+SkBLgC864zP
        9udOLRT4ONrN4y69vdN4eGq20xluNNFWIxZXOjfsx1GFhobHn6hrT9u0kKM4HU1rOaaNrJ
        NKm2S277ZAAuyZyncU4GNLR+hLRPC2w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-9VOOiX4sNjuudvTbqL1HWA-1; Wed, 11 Jan 2023 09:28:37 -0500
X-MC-Unique: 9VOOiX4sNjuudvTbqL1HWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EC8E3C14867;
        Wed, 11 Jan 2023 14:28:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE9B72026D68;
        Wed, 11 Jan 2023 14:28:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 8/9] iov_iter,
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
Date:   Wed, 11 Jan 2023 14:28:35 +0000
Message-ID: <167344731521.2425628.5403113335062567245.stgit@warthog.procyon.org.uk>
In-Reply-To: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
---

 block/bio.c               |   54 ++++++++++++++++++++++++++++++++-------------
 include/linux/bio.h       |    3 ++-
 include/linux/blk_types.h |    1 +
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0fa140789d16..22900f8e9bfb 100644
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
 
@@ -1175,6 +1177,18 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 	return bio_add_page(bio, &folio->page, len, off) > 0;
 }
 
+/*
+ * Clean up a page appropriately, where the page may be pinned, may have a
+ * ref taken on it or neither.
+ */
+static void bio_release_page(struct bio *bio, struct page *page)
+{
+	if (bio_flagged(bio, BIO_PAGE_PINNED))
+		unpin_user_page(page);
+	if (bio_flagged(bio, BIO_PAGE_REFFED))
+		put_page(page);
+}
+
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct bvec_iter_all iter_all;
@@ -1183,7 +1197,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		bio_release_page(bio, bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1220,7 +1234,7 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 	}
 
 	if (same_page)
-		put_page(page);
+		bio_release_page(bio, page);
 	return 0;
 }
 
@@ -1234,7 +1248,7 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
 			queue_max_zone_append_sectors(q), &same_page) != len)
 		return -EINVAL;
 	if (same_page)
-		put_page(page);
+		bio_release_page(bio, page);
 	return 0;
 }
 
@@ -1245,10 +1259,10 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
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
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1256,7 +1270,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
-	unsigned int gup_flags = 0;
+	unsigned int gup_flags = 0, cleanup_mode;
 	ssize_t size, left;
 	unsigned len, i = 0;
 	size_t offset, trim;
@@ -1280,12 +1294,20 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
 	 */
-	size = iov_iter_get_pages(iter, pages,
-				  UINT_MAX - bio->bi_iter.bi_size,
-				  nr_pages, &offset, gup_flags);
+	size = iov_iter_extract_pages(iter, &pages,
+				      UINT_MAX - bio->bi_iter.bi_size,
+				      nr_pages, gup_flags,
+				      &offset, &cleanup_mode);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
+	bio_clear_flag(bio, BIO_PAGE_REFFED);
+	bio_clear_flag(bio, BIO_PAGE_PINNED);
+	if (cleanup_mode & FOLL_GET)
+		bio_set_flag(bio, BIO_PAGE_REFFED);
+	if (cleanup_mode & FOLL_PIN)
+		bio_set_flag(bio, BIO_PAGE_PINNED);
+
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 
 	trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
@@ -1315,7 +1337,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	iov_iter_revert(iter, left);
 out:
 	while (i < nr_pages)
-		put_page(pages[i++]);
+		bio_release_page(bio, pages[i++]);
 
 	return ret;
 }
@@ -1496,8 +1518,8 @@ void bio_set_pages_dirty(struct bio *bio)
  * the BIO and re-dirty the pages in process context.
  *
  * It is expected that bio_check_pages_dirty() will wholly own the BIO from
- * here on.  It will run one put_page() against each page and will run one
- * bio_put() against the BIO.
+ * here on.  It will run one put_page() or unpin_user_page() against each page
+ * and will run one bio_put() against the BIO.
  */
 
 static void bio_dirty_fn(struct work_struct *work);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 63bfd91793f9..1c6f051f6ff2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -482,7 +482,8 @@ void zero_fill_bio(struct bio *bio);
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	if (bio_flagged(bio, BIO_PAGE_REFFED))
+	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
+	    bio_flagged(bio, BIO_PAGE_PINNED))
 		__bio_release_pages(bio, mark_dirty);
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 2f64b3606397..7a2d2b2cf3a0 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -319,6 +319,7 @@ struct bio {
  */
 enum {
 	BIO_PAGE_REFFED,	/* Pages need refs putting (see FOLL_GET) */
+	BIO_PAGE_PINNED,	/* Pages need pins unpinning (see FOLL_PIN) */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_QUIET,		/* Make BIO Quiet */


