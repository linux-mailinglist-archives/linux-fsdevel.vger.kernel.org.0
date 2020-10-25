Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F2029800A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 05:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767056AbgJYEom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Oct 2020 00:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1767051AbgJYEol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Oct 2020 00:44:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7199C0613CE;
        Sat, 24 Oct 2020 21:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DxxJd92FLDAv/H5nin4JPkQwQ23uTochIP++Tt4+efY=; b=UAcieGgnohyfuSIeKBm3Dwy5cP
        zg6CFyhEqrrEV4aAhwoxHt3p8g+4adtsCoJONi9UpeOwCNKGduGpuwMoDyGGFH2ys9uNutDwapoA0
        tbuXlVWBi9lGFkHykj9Kj/yEst6bps7EwzBzfW5dOHNPUbm1VhsFQLp7W/PFfMmWNLglLhKkL2XwZ
        JQoPGva4CnqoIHocphyfzamQOifJvGJFtbM7msBvcVrNHhxrxiZa+Cu8ARd3sCSKpB1b09tuLHtZT
        W+j4y5ZpWhNH25rwdZ5tM+6KaCBXNY20X9kKZr1yBZykLVF9OpEzD9yA1RDpMZHbGrjRoqGTrtEn9
        5IxbOCZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWXtW-0000vf-Uz; Sun, 25 Oct 2020 04:44:39 +0000
Date:   Sun, 25 Oct 2020 04:44:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC] Removing b_end_io
Message-ID: <20201025044438.GI20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On my laptop, I have about 31MB allocated to buffer_heads.

buffer_head       182728 299910    104   39    1 : tunables    0    0    0 : slabdata   7690   7690      0

Reducing the size of the buffer_head by 8 bytes gets us to 96 bytes,
which means we get 42 per page instead of 39 and saves me 2MB of memory.

I think b_end_io() is ripe for removal.  It's only used while the I/O
is in progress, and it's always set to end_bio_bh_io_sync() which
may set the quiet bit, calls ->b_end_io and calls bio_put().

So how about this as an approach?  Only another 40 or so call-sites
to take care of to eliminate b_end_io from the buffer_head.  Yes, this
particular example should be entirely rewritten to do away with buffer
heads, but that's been true since 2006.  I'm looking for an approach
which can be implemented quickly since the buffer_head does not appear
to be going away any time soon.

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index d61b524ae440..7f985b138372 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -314,14 +314,16 @@ static void write_page(struct bitmap *bitmap, struct page *page, int wait)
 		md_bitmap_file_kick(bitmap);
 }
 
-static void end_bitmap_write(struct buffer_head *bh, int uptodate)
+static void end_bitmap_write(struct bio *bio)
 {
+	struct buffer_head *bh = bio->bi_private;
 	struct bitmap *bitmap = bh->b_private;
 
-	if (!uptodate)
+	if (bio->bi_status != BLK_STS_OK)
 		set_bit(BITMAP_WRITE_ERROR, &bitmap->flags);
 	if (atomic_dec_and_test(&bitmap->pending_writes))
 		wake_up(&bitmap->write_wait);
+	bio_put(bio);
 }
 
 static void free_buffers(struct page *page)
@@ -388,12 +390,11 @@ static int read_page(struct file *file, unsigned long index,
 			else
 				count -= (1<<inode->i_blkbits);
 
-			bh->b_end_io = end_bitmap_write;
 			bh->b_private = bitmap;
 			atomic_inc(&bitmap->pending_writes);
 			set_buffer_locked(bh);
 			set_buffer_mapped(bh);
-			submit_bh(REQ_OP_READ, 0, bh);
+			bh_submit(bh, REQ_OP_READ, end_bitmap_write);
 		}
 		blk_cur++;
 		bh = bh->b_this_page;
diff --git a/fs/buffer.c b/fs/buffer.c
index d468ed9981e0..668c586b2ed1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3022,8 +3022,9 @@ static void end_bio_bh_io_sync(struct bio *bio)
 	bio_put(bio);
 }
 
-static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-			 enum rw_hint write_hint, struct writeback_control *wbc)
+static void __bh_submit(struct buffer_head *bh, unsigned req_flags,
+		enum rw_hint write_hint, struct writeback_control *wbc,
+		bio_end_io_t end_bio)
 {
 	struct bio *bio;
 
@@ -3036,7 +3037,7 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	/*
 	 * Only clear out a write error when rewriting
 	 */
-	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
+	if (test_set_buffer_req(bh) && (op_is_write(req_flags)))
 		clear_buffer_write_io_error(bh);
 
 	bio = bio_alloc(GFP_NOIO, 1);
@@ -3050,14 +3051,14 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
 
-	bio->bi_end_io = end_bio_bh_io_sync;
+	bio->bi_end_io = end_bio;
 	bio->bi_private = bh;
 
 	if (buffer_meta(bh))
-		op_flags |= REQ_META;
+		req_flags |= REQ_META;
 	if (buffer_prio(bh))
-		op_flags |= REQ_PRIO;
-	bio_set_op_attrs(bio, op, op_flags);
+		req_flags |= REQ_PRIO;
+	bio->bi_opf = req_flags;
 
 	/* Take care of bh's that straddle the end of the device */
 	guard_bio_eod(bio);
@@ -3068,6 +3069,12 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	}
 
 	submit_bio(bio);
+}
+
+static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
+			 enum rw_hint write_hint, struct writeback_control *wbc)
+{
+	__bh_submit(bh, op | op_flags, write_hint, wbc, end_bio_bh_io_sync);
 	return 0;
 }
 
@@ -3077,6 +3084,11 @@ int submit_bh(int op, int op_flags, struct buffer_head *bh)
 }
 EXPORT_SYMBOL(submit_bh);
 
+void bh_submit(struct buffer_head *bh, unsigned req_flags, bio_end_io_t end_io)
+{
+	__bh_submit(bh, req_flags, 0, NULL, end_io);
+}
+
 /**
  * ll_rw_block: low-level access to block devices (DEPRECATED)
  * @op: whether to %READ or %WRITE
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94378c5..cc9113befe15 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -203,6 +203,7 @@ int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, int op_flags);
 void write_dirty_buffer(struct buffer_head *bh, int op_flags);
 int submit_bh(int, int, struct buffer_head *);
+void bh_submit(struct buffer_head *, unsigned req_flags, bio_end_io_t);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
