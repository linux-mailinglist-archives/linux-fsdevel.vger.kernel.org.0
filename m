Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4129668D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 23:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372319AbgJVVWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 17:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372257AbgJVVWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:22:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8637C0613D7;
        Thu, 22 Oct 2020 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XEu2EmGV2J3O+NGwABsLcV4fD3cQ9sI5rt1XPNbqumg=; b=PzyBls8es8bXMK2hYFm3qT6hv3
        fMYeGYuuoZVO8DXIjkDUkZYHLUV93wdu1djgLmokABmSEIffsY4F9oM7jMaCnVzSZXQ518dVnq1zS
        Iq4gSMFV3CykSEt1BAdBEpfIfZARVsma0q05RNNbIS45oJ4perCAzz4sARFopkYMo/kEiuQLr7VKD
        zD6T9NDo/398s026g3B4hUaX96u12XaxuVhrJWCj5uP3oY1bCHXGcLZAZdoLoTU8Xl3UaIC+BUhFe
        7xcJTXHp8G5UFxsFz7iy98ASHRF00xsozx+hfpImkVLIM66wx7Y03NHSRY7nIecytZt1gcrgxFbLf
        z/N3brCw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVi2Z-00046j-Di; Thu, 22 Oct 2020 21:22:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 6/6] fs: Convert block_read_full_page to be synchronous with fscrypt enabled
Date:   Thu, 22 Oct 2020 22:22:28 +0100
Message-Id: <20201022212228.15703-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022212228.15703-1-willy@infradead.org>
References: <20201022212228.15703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new decrypt_end_bio() instead of readpage_end_bio() if
fscrypt needs to be used.  Remove the old end_buffer_async_read()
now that all BHs go through readpage_end_bio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 198 ++++++++++++++++------------------------------------
 1 file changed, 59 insertions(+), 139 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f859e0929b7e..62c74f0102d4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -241,84 +241,6 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	return ret;
 }
 
-/*
- * I/O completion handler for block_read_full_page() - pages
- * which come unlocked at the end of I/O.
- */
-static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
-{
-	unsigned long flags;
-	struct buffer_head *first;
-	struct buffer_head *tmp;
-	struct page *page;
-	int page_uptodate = 1;
-
-	BUG_ON(!buffer_async_read(bh));
-
-	page = bh->b_page;
-	if (uptodate) {
-		set_buffer_uptodate(bh);
-	} else {
-		clear_buffer_uptodate(bh);
-		buffer_io_error(bh, ", async page read");
-		SetPageError(page);
-	}
-
-	/*
-	 * Be _very_ careful from here on. Bad things can happen if
-	 * two buffer heads end IO at almost the same time and both
-	 * decide that the page is now completely done.
-	 */
-	first = page_buffers(page);
-	spin_lock_irqsave(&first->b_uptodate_lock, flags);
-	clear_buffer_async_read(bh);
-	unlock_buffer(bh);
-	tmp = bh;
-	do {
-		if (!buffer_uptodate(tmp))
-			page_uptodate = 0;
-		if (buffer_async_read(tmp)) {
-			BUG_ON(!buffer_locked(tmp));
-			goto still_busy;
-		}
-		tmp = tmp->b_this_page;
-	} while (tmp != bh);
-	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
-
-	/*
-	 * If none of the buffers had errors and they are all
-	 * uptodate then we can set the page uptodate.
-	 */
-	if (page_uptodate && !PageError(page))
-		SetPageUptodate(page);
-	unlock_page(page);
-	return;
-
-still_busy:
-	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
-	return;
-}
-
-struct decrypt_bio_ctx {
-	struct work_struct work;
-	struct bio *bio;
-};
-
-static void decrypt_bio(struct work_struct *work)
-{
-	struct decrypt_bio_ctx *ctx =
-		container_of(work, struct decrypt_bio_ctx, work);
-	struct bio *bio = ctx->bio;
-	struct buffer_head *bh = bio->bi_private;
-	int err;
-
-	err = fscrypt_decrypt_pagecache_blocks(bh->b_page, bh->b_size,
-					       bh_offset(bh));
-	end_buffer_async_read(bh, err == 0);
-	kfree(ctx);
-	bio_put(bio);
-}
-
 /*
  * Completion handler for block_write_full_page() - pages which are unlocked
  * during I/O, and which have PageWriteback cleared upon I/O completion.
@@ -365,33 +287,6 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 }
 EXPORT_SYMBOL(end_buffer_async_write);
 
-/*
- * If a page's buffers are under async readin (end_buffer_async_read
- * completion) then there is a possibility that another thread of
- * control could lock one of the buffers after it has completed
- * but while some of the other buffers have not completed.  This
- * locked buffer would confuse end_buffer_async_read() into not unlocking
- * the page.  So the absence of BH_Async_Read tells end_buffer_async_read()
- * that this buffer is not under async I/O.
- *
- * The page comes unlocked when it has no locked buffer_async buffers
- * left.
- *
- * PageLocked prevents anyone starting new async I/O reads any of
- * the buffers.
- *
- * PageWriteback is used to prevent simultaneous writeout of the same
- * page.
- *
- * PageLocked prevents anyone from starting writeback of a page which is
- * under read I/O (PageWriteback is only ever set against a locked page).
- */
-static void mark_buffer_async_read(struct buffer_head *bh)
-{
-	bh->b_end_io = end_buffer_async_read;
-	set_buffer_async_read(bh);
-}
-
 static void mark_buffer_async_write_endio(struct buffer_head *bh,
 					  bh_end_io_t *handler)
 {
@@ -2268,8 +2163,54 @@ static void readpage_end_bio(struct bio *bio)
 	bio_put(bio);
 }
 
+struct decrypt_bio_ctx {
+	struct work_struct work;
+	struct bio *bio;
+};
+
+static void decrypt_bio(struct work_struct *work)
+{
+	struct decrypt_bio_ctx *ctx =
+		container_of(work, struct decrypt_bio_ctx, work);
+	struct bio *bio = ctx->bio;
+	struct bio_vec *bvec;
+	int i, err = 0;
+
+	kfree(ctx);
+	bio_for_each_bvec_all(bvec, bio, i) {
+		err = fscrypt_decrypt_pagecache_blocks(bvec->bv_page,
+				bvec->bv_len, bvec->bv_offset);
+		if (err)
+			break;
+	}
+
+	/* XXX: Should report a better error here */
+	if (err)
+		bio->bi_status = BLK_STS_IOERR;
+	readpage_end_bio(bio);
+}
+
+static void decrypt_end_bio(struct bio *bio)
+{
+	struct decrypt_bio_ctx *ctx = NULL;
+
+	if (bio->bi_status == BLK_STS_OK) {
+		ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+		if (!ctx)
+			bio->bi_status = BLK_STS_RESOURCE;
+	}
+
+	if (ctx) {
+		INIT_WORK(&ctx->work, decrypt_bio);
+		ctx->bio = bio;
+		fscrypt_enqueue_decrypt_work(&ctx->work);
+	} else {
+		readpage_end_bio(bio);
+	}
+}
+
 static int readpage_submit_bhs(struct page *page, struct blk_completion *cmpl,
-		unsigned int nr, struct buffer_head **bhs)
+		unsigned int nr, struct buffer_head **bhs, bio_end_io_t end_bio)
 {
 	struct bio *bio = NULL;
 	unsigned int i;
@@ -2283,7 +2224,8 @@ static int readpage_submit_bhs(struct page *page, struct blk_completion *cmpl,
 		bool same_page;
 
 		if (buffer_uptodate(bh)) {
-			end_buffer_async_read(bh, 1);
+			clear_buffer_async_read(bh);
+			unlock_buffer(bh);
 			blk_completion_sub(cmpl, BLK_STS_OK, 1);
 			continue;
 		}
@@ -2298,7 +2240,7 @@ static int readpage_submit_bhs(struct page *page, struct blk_completion *cmpl,
 		bio_set_dev(bio, bh->b_bdev);
 		bio->bi_iter.bi_sector = sector;
 		bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
-		bio->bi_end_io = readpage_end_bio;
+		bio->bi_end_io = end_bio;
 		bio->bi_private = cmpl;
 		/* Take care of bh's that straddle the end of the device */
 		guard_bio_eod(bio);
@@ -2314,6 +2256,13 @@ static int readpage_submit_bhs(struct page *page, struct blk_completion *cmpl,
 	return err;
 }
 
+static bio_end_io_t *fscrypt_end_io(struct inode *inode)
+{
+	if (fscrypt_inode_uses_fs_layer_crypto(inode))
+		return decrypt_end_bio;
+	return readpage_end_bio;
+}
+
 /*
  * Generic "read page" function for block devices that have the normal
  * get_block functionality. This is most of the block device filesystems.
@@ -2389,26 +2338,10 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 	for (i = 0; i < nr; i++) {
 		bh = arr[i];
 		lock_buffer(bh);
-		mark_buffer_async_read(bh);
+		set_buffer_async_read(bh);
 	}
 
-	if (!fscrypt_inode_uses_fs_layer_crypto(inode))
-		return readpage_submit_bhs(page, cmpl, nr, arr);
-	kfree(cmpl);
-
-	/*
-	 * Stage 3: start the IO.  Check for uptodateness
-	 * inside the buffer lock in case another process reading
-	 * the underlying blockdev brought it uptodate (the sct fix).
-	 */
-	for (i = 0; i < nr; i++) {
-		bh = arr[i];
-		if (buffer_uptodate(bh))
-			end_buffer_async_read(bh, 1);
-		else
-			submit_bh(REQ_OP_READ, 0, bh);
-	}
-	return 0;
+	return readpage_submit_bhs(page, cmpl, nr, arr, fscrypt_end_io(inode));
 }
 EXPORT_SYMBOL(block_read_full_page);
 
@@ -3092,19 +3025,6 @@ static void end_bio_bh_io_sync(struct bio *bio)
 	if (unlikely(bio_flagged(bio, BIO_QUIET)))
 		set_bit(BH_Quiet, &bh->b_state);
 
-	/* Decrypt if needed */
-	if ((bio_data_dir(bio) == READ) && uptodate &&
-	    fscrypt_inode_uses_fs_layer_crypto(bh->b_page->mapping->host)) {
-		struct decrypt_bio_ctx *ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
-
-		if (ctx) {
-			INIT_WORK(&ctx->work, decrypt_bio);
-			ctx->bio = bio;
-			fscrypt_enqueue_decrypt_work(&ctx->work);
-			return;
-		}
-		uptodate = 0;
-	}
 	bh->b_end_io(bh, uptodate);
 	bio_put(bio);
 }
-- 
2.28.0

