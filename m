Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718D1296683
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 23:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372279AbgJVVWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897770AbgJVVWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:22:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3C8C0613D4;
        Thu, 22 Oct 2020 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D5/8QIXE3yC+uuHVJiE5vkRHeihDIjcMcZdxL1pBCQ4=; b=wGLZoLn+vxDtBSTplOWB5A+yxY
        4gXlb6xT44IG7AN2PID9b0O8ZGI/rbp3+sCHYy6uRBhaLahRaV5dNK/hhP8+9+QI/rhBySKBSplHH
        clpOGXv/SHxEFmJt4AvzLlupRfl9s4o+r+vS2wZsazdLf6EJOiy1a1Aa86IBFWjFwU7/OoJxMW4ZG
        mK+8YsXEX3KA8WaTJdDzIvdPqRQ8sujmG1KMpsz8x79exG9eET7ZHjZ1LHaKcf62BEf5b2HCLbuM3
        +ziSG12rUJR5NNEIEFWjZEXV3Wi+MEXrqLvL3LOIlWUaqTnOH3Bel/OSG4DfoqZhH1COA4spC+8Mw
        s/hCPUHg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVi2Y-00046R-Np; Thu, 22 Oct 2020 21:22:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/6] fs: Convert block_read_full_page to be synchronous
Date:   Thu, 22 Oct 2020 22:22:25 +0100
Message-Id: <20201022212228.15703-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022212228.15703-1-willy@infradead.org>
References: <20201022212228.15703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new blk_completion infrastructure to wait for multiple I/Os.
Also coalesce adjacent buffer heads into a single BIO instead of
submitting one BIO per buffer head.  This doesn't work for fscrypt yet,
so keep the old code around for now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1b0ba1d59966..ccb90081117c 100644
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
@@ -2258,6 +2339,7 @@ EXPORT_SYMBOL(block_is_partially_uptodate);
  */
 int block_read_full_page(struct page *page, get_block_t *get_block)
 {
+	struct blk_completion *cmpl = kmalloc(sizeof(*cmpl), GFP_NOIO);
 	struct inode *inode = page->mapping->host;
 	sector_t iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
@@ -2265,6 +2347,9 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 	int nr, i, err = 0;
 	int fully_mapped = 1;
 
+	if (!cmpl)
+		return -ENOMEM;
+
 	head = create_page_buffers(page, inode, 0);
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
@@ -2303,6 +2388,7 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
 
 	if (err) {
+		kfree(cmpl);
 		unlock_page(page);
 		return err;
 	}
@@ -2322,6 +2408,10 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 		mark_buffer_async_read(bh);
 	}
 
+	if (!fscrypt_inode_uses_fs_layer_crypto(inode))
+		return readpage_submit_bhs(page, cmpl, nr, arr);
+	kfree(cmpl);
+
 	/*
 	 * Stage 3: start the IO.  Check for uptodateness
 	 * inside the buffer lock in case another process reading
-- 
2.28.0

