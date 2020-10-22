Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E6029619C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 17:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901400AbgJVPW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 11:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901396AbgJVPW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:22:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6A2C0613CF;
        Thu, 22 Oct 2020 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bUAx7q3MEGChaPB6Fuz28QdhBjuD6fSGRVvBjDrDq9I=; b=WqiGuW6kqP9pUbGXhOJAXKMY/h
        0g6C0gom2Vx4taT0p6DEsPMA/e84e7E7aaJligonX8SvRH0QvHKpe+JolfkuY+VmlK303hLxybOFh
        M5Gp5Y33XYKkLIM+S1TCWjjkMpeX4x0BlYXoMu3+SVuneOXpAekSiYqKfI3hlmMU1PMIr4r384YEr
        qAjKlPzNE6oS1Zutov3nYohKEQB1OqWYiuAwBAaSrS9NahEZ/BAuY18v2fjK57tnzBawxX+AnxSLe
        Zy8MaORvupAy1e+rdSFASjGhIEGCh8D3JGkkuYK9gjJFxzjohq8jsxkeujGw00JGDkecZvAwsS5V3
        zxWG15ZA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVcQa-0006eo-AN; Thu, 22 Oct 2020 15:22:56 +0000
Date:   Thu, 22 Oct 2020 16:22:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] synchronous readpage for buffer_heads
Message-ID: <20201022152256.GU20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm working on making readpage synchronous so that it can actually return
errors instead of futilely setting PageError.  Something that's common
between most of the block based filesystems is the need to submit N
I/Os and wait for them to all complete (some filesystems don't support
sub-page block size, so they don't have this problem).

I ended up coming up with a fairly nice data structure which I've called
the blk_completion.  It waits for 'n' events to happen, then wakes the
task that cares, unless the task has got bored and wandered off to do
something else.

block_read_full_page() then uses this data structure to submit 'n' buffer
heads and wait for them to all complete.  The fscrypt code doesn't work
in this scheme, so I bailed on that for now.  I have ideas for fixing it,
but they can wait.

Obviously this all needs documentation, but I'd like feedback on the
idea before I do that.  I have given it some light testing, but there
aren't too many filesystems left that use block_read_full_page() so I
haven't done a proper xfstests run.

diff --git a/include/linux/bio.h b/include/linux/bio.h
index f254bc79bb3a..0bde05f5548c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -814,4 +814,15 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+struct blk_completion {
+	struct task_struct *cmpl_task;
+	spinlock_t cmpl_lock;
+	int cmpl_count;
+	blk_status_t cmpl_status;
+};
+
+void blk_completion_init(struct blk_completion *, int n);
+int blk_completion_sub(struct blk_completion *, blk_status_t status, int n);
+int blk_completion_wait_killable(struct blk_completion *);
+
 #endif /* __LINUX_BIO_H */
diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..2892246f2176 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1900,6 +1900,67 @@ void blk_io_schedule(void)
 }
 EXPORT_SYMBOL_GPL(blk_io_schedule);
 
+void blk_completion_init(struct blk_completion *cmpl, int n)
+{
+	spin_lock_init(&cmpl->cmpl_lock);
+	cmpl->cmpl_count = n;
+	cmpl->cmpl_task = current;
+	cmpl->cmpl_status = BLK_STS_OK;
+}
+
+int blk_completion_sub(struct blk_completion *cmpl, blk_status_t status, int n)
+{
+	int ret = 0;
+
+	spin_lock_bh(&cmpl->cmpl_lock);
+	if (cmpl->cmpl_status == BLK_STS_OK && status != BLK_STS_OK)
+		cmpl->cmpl_status = status;
+	cmpl->cmpl_count -= n;
+	BUG_ON(cmpl->cmpl_count < 0);
+	if (cmpl->cmpl_count == 0) {
+		if (cmpl->cmpl_task)
+			wake_up_process(cmpl->cmpl_task);
+		else
+			ret = -EINTR;
+	}
+	spin_unlock_bh(&cmpl->cmpl_lock);
+	if (ret < 0)
+		kfree(cmpl);
+	return ret;
+}
+
+int blk_completion_wait_killable(struct blk_completion *cmpl)
+{
+	int err = 0;
+
+	for (;;) {
+		set_current_state(TASK_KILLABLE);
+		spin_lock_bh(&cmpl->cmpl_lock);
+		if (cmpl->cmpl_count == 0)
+			break;
+		spin_unlock_bh(&cmpl->cmpl_lock);
+		blk_io_schedule();
+		if (fatal_signal_pending(current)) {
+			spin_lock_bh(&cmpl->cmpl_lock);
+			cmpl->cmpl_task = NULL;
+			if (cmpl->cmpl_count != 0) {
+				spin_unlock_bh(&cmpl->cmpl_lock);
+				cmpl = NULL;
+			}
+			err = -ERESTARTSYS;
+			break;
+		}
+	}
+	set_current_state(TASK_RUNNING);
+	if (cmpl) {
+		spin_unlock_bh(&cmpl->cmpl_lock);
+		err = blk_status_to_errno(cmpl->cmpl_status);
+		kfree(cmpl);
+	}
+
+	return err;
+}
+
 int __init blk_dev_init(void)
 {
 	BUILD_BUG_ON(REQ_OP_LAST >= (1 << REQ_OP_BITS));
diff --git a/fs/buffer.c b/fs/buffer.c
index 1d5337517dcd..ccb90081117c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2249,6 +2249,87 @@ int block_is_partially_uptodate(struct page *page, unsigned long from,
 }
 EXPORT_SYMBOL(block_is_partially_uptodate);
 
+static void readpage_end_bio(struct bio *bio)
+{
+	struct bio_vec *bvec;
+	struct page *page;
+	struct buffer_head *bh;
+	int i, nr = 0;
+
+	bio_for_each_bvec_all(bvec, bio, i) {
+		size_t offset = 0;
+		size_t max = bvec->bv_offset + bvec->bv_len;
+
+		page = bvec->bv_page;
+		bh = page_buffers(page);
+
+		for (offset = 0; offset < max; offset += bh->b_size,
+				bh = bh->b_this_page) {
+			if (offset < bvec->bv_offset)
+				continue;
+			BUG_ON(bh_offset(bh) != offset);
+			nr++;
+			if (unlikely(bio_flagged(bio, BIO_QUIET)))
+				set_bit(BH_Quiet, &bh->b_state);
+			if (bio->bi_status == BLK_STS_OK)
+				set_buffer_uptodate(bh);
+			else
+				buffer_io_error(bh, ", async page read");
+			unlock_buffer(bh);
+		}
+	}
+
+	if (blk_completion_sub(bio->bi_private, bio->bi_status, nr) < 0)
+		unlock_page(page);
+	bio_put(bio);
+}
+
+static int readpage_submit_bhs(struct page *page, struct blk_completion *cmpl,
+		unsigned int nr, struct buffer_head **bhs)
+{
+	struct bio *bio = NULL;
+	unsigned int i;
+	int err;
+
+	blk_completion_init(cmpl, nr);
+
+	for (i = 0; i < nr; i++) {
+		struct buffer_head *bh = bhs[i];
+		sector_t sector = bh->b_blocknr * (bh->b_size >> 9);
+		bool same_page;
+
+		if (buffer_uptodate(bh)) {
+			end_buffer_async_read(bh, 1);
+			blk_completion_sub(cmpl, BLK_STS_OK, 1);
+			continue;
+		}
+		if (bio) {
+			if (bio_end_sector(bio) == sector &&
+			    __bio_try_merge_page(bio, bh->b_page, bh->b_size,
+					bh_offset(bh), &same_page))
+				continue;
+			submit_bio(bio);
+		}
+		bio = bio_alloc(GFP_NOIO, 1);
+		bio_set_dev(bio, bh->b_bdev);
+		bio->bi_iter.bi_sector = sector;
+		bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
+		bio->bi_end_io = readpage_end_bio;
+		bio->bi_private = cmpl;
+		/* Take care of bh's that straddle the end of the device */
+		guard_bio_eod(bio);
+	}
+
+	if (bio)
+		submit_bio(bio);
+
+	err = blk_completion_wait_killable(cmpl);
+	if (!err)
+		return AOP_UPDATED_PAGE;
+	unlock_page(page);
+	return err;
+}
+
 /*
  * Generic "read page" function for block devices that have the normal
  * get_block functionality. This is most of the block device filesystems.
@@ -2258,13 +2339,17 @@ EXPORT_SYMBOL(block_is_partially_uptodate);
  */
 int block_read_full_page(struct page *page, get_block_t *get_block)
 {
+	struct blk_completion *cmpl = kmalloc(sizeof(*cmpl), GFP_NOIO);
 	struct inode *inode = page->mapping->host;
 	sector_t iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	unsigned int blocksize, bbits;
-	int nr, i;
+	int nr, i, err = 0;
 	int fully_mapped = 1;
 
+	if (!cmpl)
+		return -ENOMEM;
+
 	head = create_page_buffers(page, inode, 0);
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
@@ -2280,19 +2365,16 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 			continue;
 
 		if (!buffer_mapped(bh)) {
-			int err = 0;
-
 			fully_mapped = 0;
 			if (iblock < lblock) {
 				WARN_ON(bh->b_size != blocksize);
 				err = get_block(inode, iblock, bh, 0);
 				if (err)
-					SetPageError(page);
+					break;
 			}
 			if (!buffer_mapped(bh)) {
 				zero_user(page, i * blocksize, blocksize);
-				if (!err)
-					set_buffer_uptodate(bh);
+				set_buffer_uptodate(bh);
 				continue;
 			}
 			/*
@@ -2305,18 +2387,18 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 		arr[nr++] = bh;
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
 
+	if (err) {
+		kfree(cmpl);
+		unlock_page(page);
+		return err;
+	}
 	if (fully_mapped)
 		SetPageMappedToDisk(page);
 
 	if (!nr) {
-		/*
-		 * All buffers are uptodate - we can set the page uptodate
-		 * as well. But not if get_block() returned an error.
-		 */
-		if (!PageError(page))
-			SetPageUptodate(page);
-		unlock_page(page);
-		return 0;
+		/* All buffers are uptodate - we can set the page uptodate */
+		SetPageUptodate(page);
+		return AOP_UPDATED_PAGE;
 	}
 
 	/* Stage two: lock the buffers */
@@ -2326,6 +2408,10 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 		mark_buffer_async_read(bh);
 	}
 
+	if (!fscrypt_inode_uses_fs_layer_crypto(inode))
+		return readpage_submit_bhs(page, cmpl, nr, arr);
+	kfree(cmpl);
+
 	/*
 	 * Stage 3: start the IO.  Check for uptodateness
 	 * inside the buffer lock in case another process reading
