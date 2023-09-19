Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507477A58F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjISEwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjISEvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43438181;
        Mon, 18 Sep 2023 21:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dunQUZDS9A3++aenZemM7frH6i7Ee/u7RYRB7yRCOt4=; b=d71ZRUyyLAoDO9bXc8xbMmcFG0
        OgJyC7LV4aLcaNmQojEWB10bGG/0uQAdu9uvqWvTq1cRlE3H9hAXUBLevDTOfQhxtOLZIFqu9Lv6u
        ocXiM4q8JYTnJqtB0xHLz+CLF/KIQPbeUPEI3TuQP6XrTFdjw1tqlcKomnORfusactdwQ/mpq9khq
        iNTQMP/wu6gnMxTKoNvLvhBV8+RqerSwIrVgF+OX6+46kZOD5C11okJY9hegYiQkocmoBN8Zkd5zh
        eU5Ajukci1akGap+FogP0P0zK1bua5P29G/9GW6ZmB5ZG2Ndh+pX0zu3ieAz8otARaPfUbGrcTJrh
        McN2RXDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi5-00FFmm-IN; Tue, 19 Sep 2023 04:51:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 26/26] buffer: Remove folio_create_empty_buffers()
Date:   Tue, 19 Sep 2023 05:51:35 +0100
Message-Id: <20230919045135.3635437-27-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230919045135.3635437-1-willy@infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With all users converted, remove the old create_empty_buffers() and
rename folio_create_empty_buffers() to create_empty_buffers().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 13 +++----------
 fs/ext4/inode.c             |  6 +++---
 fs/ext4/move_extent.c       |  4 ++--
 fs/gfs2/aops.c              |  2 +-
 fs/gfs2/bmap.c              |  2 +-
 fs/gfs2/meta_io.c           |  2 +-
 fs/gfs2/quota.c             |  2 +-
 fs/mpage.c                  |  2 +-
 fs/nilfs2/mdt.c             |  2 +-
 fs/nilfs2/page.c            |  4 ++--
 fs/nilfs2/segment.c         |  2 +-
 fs/ntfs/aops.c              |  4 ++--
 fs/ntfs/file.c              |  2 +-
 fs/ntfs3/file.c             |  2 +-
 fs/ocfs2/aops.c             |  2 +-
 fs/reiserfs/inode.c         |  2 +-
 fs/ufs/util.c               |  2 +-
 include/linux/buffer_head.h |  4 +---
 18 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1b9e691714bd..d483903fa9ff 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1646,7 +1646,7 @@ EXPORT_SYMBOL(block_invalidate_folio);
  * block_dirty_folio() via private_lock.  try_to_free_buffers
  * is already excluded via the folio lock.
  */
-struct buffer_head *folio_create_empty_buffers(struct folio *folio,
+struct buffer_head *create_empty_buffers(struct folio *folio,
 		unsigned long blocksize, unsigned long b_state)
 {
 	struct buffer_head *bh, *head, *tail;
@@ -1677,13 +1677,6 @@ struct buffer_head *folio_create_empty_buffers(struct folio *folio,
 
 	return head;
 }
-EXPORT_SYMBOL(folio_create_empty_buffers);
-
-void create_empty_buffers(struct page *page,
-			unsigned long blocksize, unsigned long b_state)
-{
-	folio_create_empty_buffers(page_folio(page), blocksize, b_state);
-}
 EXPORT_SYMBOL(create_empty_buffers);
 
 /**
@@ -1783,7 +1776,7 @@ static struct buffer_head *folio_create_buffers(struct folio *folio,
 
 	bh = folio_buffers(folio);
 	if (!bh)
-		bh = folio_create_empty_buffers(folio,
+		bh = create_empty_buffers(folio,
 				1 << READ_ONCE(inode->i_blkbits), b_state);
 	return bh;
 }
@@ -2676,7 +2669,7 @@ int block_truncate_page(struct address_space *mapping,
 
 	bh = folio_buffers(folio);
 	if (!bh)
-		bh = folio_create_empty_buffers(folio, blocksize, 0);
+		bh = create_empty_buffers(folio, blocksize, 0);
 
 	/* Find the buffer that contains "offset" */
 	offset = offset_in_folio(folio, from);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8e431ff2fd95..347fc8986e93 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1021,7 +1021,7 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 
 	head = folio_buffers(folio);
 	if (!head)
-		head = folio_create_empty_buffers(folio, blocksize, 0);
+		head = create_empty_buffers(folio, blocksize, 0);
 	bbits = ilog2(blocksize);
 	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
 
@@ -1151,7 +1151,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * starting the handle.
 	 */
 	if (!folio_buffers(folio))
-		folio_create_empty_buffers(folio, inode->i_sb->s_blocksize, 0);
+		create_empty_buffers(folio, inode->i_sb->s_blocksize, 0);
 
 	folio_unlock(folio);
 
@@ -3642,7 +3642,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 
 	bh = folio_buffers(folio);
 	if (!bh)
-		bh = folio_create_empty_buffers(folio, blocksize, 0);
+		bh = create_empty_buffers(folio, blocksize, 0);
 
 	/* Find the buffer that contains "offset" */
 	pos = blocksize;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 7fe448fb948b..3aa57376d9c2 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -184,7 +184,7 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 	blocksize = i_blocksize(inode);
 	head = folio_buffers(folio);
 	if (!head)
-		head = folio_create_empty_buffers(folio, blocksize, 0);
+		head = create_empty_buffers(folio, blocksize, 0);
 
 	block = (sector_t)folio->index << (PAGE_SHIFT - inode->i_blkbits);
 	for (bh = head, block_start = 0; bh != head || !block_start;
@@ -380,7 +380,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	 * but keeping in mind that i_size will not change */
 	bh = folio_buffers(folio[0]);
 	if (!bh)
-		bh = folio_create_empty_buffers(folio[0],
+		bh = create_empty_buffers(folio[0],
 				1 << orig_inode->i_blkbits, 0);
 	for (i = 0; i < data_offset_in_page; i++)
 		bh = bh->b_this_page;
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index c26d48355cc2..6b060fc9e260 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -130,7 +130,7 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 	if (folio_test_checked(folio)) {
 		folio_clear_checked(folio);
 		if (!folio_buffers(folio)) {
-			folio_create_empty_buffers(folio,
+			create_empty_buffers(folio,
 					inode->i_sb->s_blocksize,
 					BIT(BH_Dirty)|BIT(BH_Uptodate));
 		}
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 247d2c16593c..f1eee3f4704b 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -71,7 +71,7 @@ static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
 		struct buffer_head *bh = folio_buffers(folio);
 
 		if (!bh)
-			bh = folio_create_empty_buffers(folio,
+			bh = create_empty_buffers(folio,
 				BIT(inode->i_blkbits), BIT(BH_Uptodate));
 
 		if (!buffer_mapped(bh))
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index b28196015543..681cbf2b4405 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -134,7 +134,7 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 				mapping_gfp_mask(mapping) | __GFP_NOFAIL);
 		bh = folio_buffers(folio);
 		if (!bh)
-			bh = folio_create_empty_buffers(folio,
+			bh = create_empty_buffers(folio,
 				sdp->sd_sb.sb_bsize, 0);
 	} else {
 		folio = __filemap_get_folio(mapping, index,
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 0ee4865ebdca..bf093f195abb 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -750,7 +750,7 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 		return PTR_ERR(folio);
 	bh = folio_buffers(folio);
 	if (!bh)
-		bh = folio_create_empty_buffers(folio, bsize, 0);
+		bh = create_empty_buffers(folio, bsize, 0);
 
 	for (;;) {
 		/* Find the beginning block within the folio */
diff --git a/fs/mpage.c b/fs/mpage.c
index 964a6efe594d..ffb064ed9d04 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -119,7 +119,7 @@ static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
 			folio_mark_uptodate(folio);
 			return;
 		}
-		head = folio_create_empty_buffers(folio, i_blocksize(inode), 0);
+		head = create_empty_buffers(folio, i_blocksize(inode), 0);
 	}
 
 	page_bh = head;
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 7b754e6494d7..c97c77a39668 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -568,7 +568,7 @@ int nilfs_mdt_freeze_buffer(struct inode *inode, struct buffer_head *bh)
 
 	bh_frozen = folio_buffers(folio);
 	if (!bh_frozen)
-		bh_frozen = folio_create_empty_buffers(folio, 1 << blkbits, 0);
+		bh_frozen = create_empty_buffers(folio, 1 << blkbits, 0);
 
 	bh_frozen = get_nth_bh(bh_frozen, bh_offset(bh) >> blkbits);
 
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 696215d899bf..06b04758f289 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -34,7 +34,7 @@ static struct buffer_head *__nilfs_get_folio_block(struct folio *folio,
 	struct buffer_head *bh = folio_buffers(folio);
 
 	if (!bh)
-		bh = folio_create_empty_buffers(folio, 1 << blkbits, b_state);
+		bh = create_empty_buffers(folio, 1 << blkbits, b_state);
 
 	first_block = (unsigned long)index << (PAGE_SHIFT - blkbits);
 	bh = get_nth_bh(bh, block - first_block);
@@ -204,7 +204,7 @@ static void nilfs_copy_folio(struct folio *dst, struct folio *src,
 	sbh = folio_buffers(src);
 	dbh = folio_buffers(dst);
 	if (!dbh)
-		dbh = folio_create_empty_buffers(dst, sbh->b_size, 0);
+		dbh = create_empty_buffers(dst, sbh->b_size, 0);
 
 	if (copy_dirty)
 		mask |= BIT(BH_Dirty);
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 94388fe83cf8..55e31cc903d1 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -732,7 +732,7 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		}
 		head = folio_buffers(folio);
 		if (!head)
-			head = folio_create_empty_buffers(folio,
+			head = create_empty_buffers(folio,
 					i_blocksize(inode), 0);
 		folio_unlock(folio);
 
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index c4426992a2ee..71e31e789b29 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -189,7 +189,7 @@ static int ntfs_read_block(struct folio *folio)
 
 	head = folio_buffers(folio);
 	if (!head)
-		head = folio_create_empty_buffers(folio, blocksize, 0);
+		head = create_empty_buffers(folio, blocksize, 0);
 	bh = head;
 
 	/*
@@ -555,7 +555,7 @@ static int ntfs_write_block(struct folio *folio, struct writeback_control *wbc)
 	head = folio_buffers(folio);
 	if (!head) {
 		BUG_ON(!folio_test_uptodate(folio));
-		head = folio_create_empty_buffers(folio, blocksize,
+		head = create_empty_buffers(folio, blocksize,
 				(1 << BH_Uptodate) | (1 << BH_Dirty));
 	}
 	bh = head;
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 099141d20db6..297c0b9db621 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -625,7 +625,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 		 * create_empty_buffers() will create uptodate/dirty
 		 * buffers if the folio is uptodate/dirty.
 		 */
-		head = folio_create_empty_buffers(folio, blocksize, 0);
+		head = create_empty_buffers(folio, blocksize, 0);
 	bh = head;
 	do {
 		VCN cdelta;
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index a003a69091a2..66fd4ac28395 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -203,7 +203,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 
 		head = folio_buffers(folio);
 		if (!head)
-			head = folio_create_empty_buffers(folio, blocksize, 0);
+			head = create_empty_buffers(folio, blocksize, 0);
 
 		bh = head;
 		bh_off = 0;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 95d1e70b4401..a6405dd5df09 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -601,7 +601,7 @@ int ocfs2_map_page_blocks(struct page *page, u64 *p_blkno,
 
 	head = folio_buffers(folio);
 	if (!head)
-		head = folio_create_empty_buffers(folio, bsize, 0);
+		head = create_empty_buffers(folio, bsize, 0);
 
 	for (bh = head, block_start = 0; bh != head || !block_start;
 	     bh = bh->b_this_page, block_start += bsize) {
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index d9737235b8e0..a9075c4843ed 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2539,7 +2539,7 @@ static int reiserfs_write_full_folio(struct folio *folio,
 	 */
 	head = folio_buffers(folio);
 	if (!head)
-		head = folio_create_empty_buffers(folio, s->s_blocksize,
+		head = create_empty_buffers(folio, s->s_blocksize,
 				     (1 << BH_Dirty) | (1 << BH_Uptodate));
 
 	/*
diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index d32de30009a0..13ba34e6d64f 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -264,6 +264,6 @@ struct folio *ufs_get_locked_folio(struct address_space *mapping,
 		}
 	}
 	if (!folio_buffers(folio))
-		folio_create_empty_buffers(folio, 1 << inode->i_blkbits, 0);
+		create_empty_buffers(folio, 1 << inode->i_blkbits, 0);
 	return folio;
 }
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 9fc615ee17fd..37a69e8828c0 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -201,9 +201,7 @@ struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
 					gfp_t gfp);
 struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
-void create_empty_buffers(struct page *, unsigned long,
-			unsigned long b_state);
-struct buffer_head *folio_create_empty_buffers(struct folio *folio,
+struct buffer_head *create_empty_buffers(struct folio *folio,
 		unsigned long blocksize, unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
-- 
2.40.1

