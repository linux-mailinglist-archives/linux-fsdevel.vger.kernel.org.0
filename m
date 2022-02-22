Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA04BFD58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiBVPrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 10:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiBVPrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:47:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458775F4A;
        Tue, 22 Feb 2022 07:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ov2RLCZVRno4Z3mIFajf0hVw7rWbnzE3ynn4FrQrpTw=; b=BSO5HhZLTETcxjl4Ci/A+vbblW
        cYGpSglO78ZmHTNkL/X1cfuAnMqQNknGr+pLZai3hQLSvdNmgoD8CpS1VKlY3PWey0qKM7+0F/RmN
        7QumfXjGZN9/mAuLzLeA3/M0G+oE7XjLfk9MDSD9/bO8d3eAgvJrKX//TwRxWp76Mm3WG0BPEewB5
        sZlhR7hXxpVBux6NzAqwW8mqxPQj6rmZRe0zQyo9jLsko6vqPsIzlVe4+LW9KKZVzvy/jt2SdUyrP
        n0zDvQfLpFPKIkla86nFncfujH6ox9B3wVtwKM1zdXKym+RHBalhwMHg/8VdaXpon8Iqd9rqeLcoM
        dJowoy8Q==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXN9-00ANXx-8F; Tue, 22 Feb 2022 15:46:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 1/3] mpage: pass the operation to bio_alloc
Date:   Tue, 22 Feb 2022 16:46:32 +0100
Message-Id: <20220222154634.597067-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222154634.597067-1-hch@lst.de>
References: <20220222154634.597067-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor the mpage read/write page code to pass the op to bio_alloc
instead of setting it just before the submission.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/mpage.c | 50 +++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index dbfc02e23d97f..6c4b810a21d0a 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -57,10 +57,9 @@ static void mpage_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static struct bio *mpage_bio_submit(int op, int op_flags, struct bio *bio)
+static struct bio *mpage_bio_submit(struct bio *bio)
 {
 	bio->bi_end_io = mpage_end_io;
-	bio_set_op_attrs(bio, op, op_flags);
 	guard_bio_eod(bio);
 	submit_bio(bio);
 	return NULL;
@@ -146,16 +145,15 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	struct block_device *bdev = NULL;
 	int length;
 	int fully_mapped = 1;
-	int op_flags;
+	int op = REQ_OP_READ;
 	unsigned nblocks;
 	unsigned relative_block;
 	gfp_t gfp;
 
 	if (args->is_readahead) {
-		op_flags = REQ_RAHEAD;
+		op |= REQ_RAHEAD;
 		gfp = readahead_gfp_mask(page->mapping);
 	} else {
-		op_flags = 0;
 		gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 	}
 
@@ -264,7 +262,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
 	if (args->bio && (args->last_block_in_bio != blocks[0] - 1))
-		args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
+		args->bio = mpage_bio_submit(args->bio);
 
 alloc_new:
 	if (args->bio == NULL) {
@@ -273,7 +271,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 								page))
 				goto out;
 		}
-		args->bio = bio_alloc(bdev, bio_max_segs(args->nr_pages), 0,
+		args->bio = bio_alloc(bdev, bio_max_segs(args->nr_pages), op,
 				      gfp);
 		if (args->bio == NULL)
 			goto confused;
@@ -282,7 +280,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 	length = first_hole << blkbits;
 	if (bio_add_page(args->bio, page, length, 0) < length) {
-		args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
+		args->bio = mpage_bio_submit(args->bio);
 		goto alloc_new;
 	}
 
@@ -290,7 +288,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	nblocks = map_bh->b_size >> blkbits;
 	if ((buffer_boundary(map_bh) && relative_block == nblocks) ||
 	    (first_hole != blocks_per_page))
-		args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
+		args->bio = mpage_bio_submit(args->bio);
 	else
 		args->last_block_in_bio = blocks[blocks_per_page - 1];
 out:
@@ -298,7 +296,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 confused:
 	if (args->bio)
-		args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
+		args->bio = mpage_bio_submit(args->bio);
 	if (!PageUptodate(page))
 		block_read_full_page(page, args->get_block);
 	else
@@ -361,7 +359,7 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
 		put_page(page);
 	}
 	if (args.bio)
-		mpage_bio_submit(REQ_OP_READ, REQ_RAHEAD, args.bio);
+		mpage_bio_submit(args.bio);
 }
 EXPORT_SYMBOL(mpage_readahead);
 
@@ -378,7 +376,7 @@ int mpage_readpage(struct page *page, get_block_t get_block)
 
 	args.bio = do_mpage_readpage(&args);
 	if (args.bio)
-		mpage_bio_submit(REQ_OP_READ, 0, args.bio);
+		mpage_bio_submit(args.bio);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpage);
@@ -469,7 +467,6 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
 	int ret = 0;
-	int op_flags = wbc_to_write_flags(wbc);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
@@ -577,7 +574,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
 	if (bio && mpd->last_block_in_bio != blocks[0] - 1)
-		bio = mpage_bio_submit(REQ_OP_WRITE, op_flags, bio);
+		bio = mpage_bio_submit(bio);
 
 alloc_new:
 	if (bio == NULL) {
@@ -586,9 +583,10 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 								page, wbc))
 				goto out;
 		}
-		bio = bio_alloc(bdev, BIO_MAX_VECS, 0, GFP_NOFS);
+		bio = bio_alloc(bdev, BIO_MAX_VECS,
+				REQ_OP_WRITE | wbc_to_write_flags(wbc),
+				GFP_NOFS);
 		bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
-
 		wbc_init_bio(wbc, bio);
 		bio->bi_write_hint = inode->i_write_hint;
 	}
@@ -601,7 +599,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	wbc_account_cgroup_owner(wbc, page, PAGE_SIZE);
 	length = first_unmapped << blkbits;
 	if (bio_add_page(bio, page, length, 0) < length) {
-		bio = mpage_bio_submit(REQ_OP_WRITE, op_flags, bio);
+		bio = mpage_bio_submit(bio);
 		goto alloc_new;
 	}
 
@@ -611,7 +609,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	set_page_writeback(page);
 	unlock_page(page);
 	if (boundary || (first_unmapped != blocks_per_page)) {
-		bio = mpage_bio_submit(REQ_OP_WRITE, op_flags, bio);
+		bio = mpage_bio_submit(bio);
 		if (boundary_block) {
 			write_boundary_block(boundary_bdev,
 					boundary_block, 1 << blkbits);
@@ -623,7 +621,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 
 confused:
 	if (bio)
-		bio = mpage_bio_submit(REQ_OP_WRITE, op_flags, bio);
+		bio = mpage_bio_submit(bio);
 
 	if (mpd->use_writepage) {
 		ret = mapping->a_ops->writepage(page, wbc);
@@ -679,11 +677,8 @@ mpage_writepages(struct address_space *mapping,
 		};
 
 		ret = write_cache_pages(mapping, wbc, __mpage_writepage, &mpd);
-		if (mpd.bio) {
-			int op_flags = (wbc->sync_mode == WB_SYNC_ALL ?
-				  REQ_SYNC : 0);
-			mpage_bio_submit(REQ_OP_WRITE, op_flags, mpd.bio);
-		}
+		if (mpd.bio)
+			mpage_bio_submit(mpd.bio);
 	}
 	blk_finish_plug(&plug);
 	return ret;
@@ -700,11 +695,8 @@ int mpage_writepage(struct page *page, get_block_t get_block,
 		.use_writepage = 0,
 	};
 	int ret = __mpage_writepage(page, wbc, &mpd);
-	if (mpd.bio) {
-		int op_flags = (wbc->sync_mode == WB_SYNC_ALL ?
-			  REQ_SYNC : 0);
-		mpage_bio_submit(REQ_OP_WRITE, op_flags, mpd.bio);
-	}
+	if (mpd.bio)
+		mpage_bio_submit(mpd.bio);
 	return ret;
 }
 EXPORT_SYMBOL(mpage_writepage);
-- 
2.30.2

