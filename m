Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4770C4AFE4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiBIUW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiBIUW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C4E040C98
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JdKWt4VepcKxKs9p5x1h3pQRhICRBIwYCPV43fXc8s0=; b=eldvPg8zYb5dlWxnb67hsQOCRW
        Eq2kAhMgYRzhQ/e0U3fuYZUS1rlgM9n0fUj8S2f5RWi7COGtcF9E7EvY/9DHPXJCBo/iBX+wpfOJB
        3NgOdZkRtIJOj9uyqW9FaWMuvBmp0ZkbG7UIB4zG4+OAvaEDtnA0hFsF2bcLndytbuA/v7Yi4+jkD
        9liMJS3/P7DAaNJSotgEW5bpWMs2uBojh429mhdjQGAoQ0zQyRywORxNtChif5cu8tU1Fm8EtE4Hn
        qQRhyKoJlOaLg6lw5+jDVr0240m1bu7Zt3KdsMUllI7lcaeXx979ERklSon4wZt+AzsAuxGp9QcGO
        jGu9M6HQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTs-008cq3-HB; Wed, 09 Feb 2022 20:22:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 15/56] fs: Turn block_invalidatepage into block_invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:34 +0000
Message-Id: <20220209202215.2055748-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove special-casing of a NULL invalidatepage, since there is no
more block_invalidatepage.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/fops.c                |  1 +
 fs/adfs/inode.c             |  1 +
 fs/affs/file.c              |  2 ++
 fs/bfs/file.c               |  1 +
 fs/buffer.c                 | 37 ++++++++++++++++++-------------------
 fs/ecryptfs/mmap.c          |  1 +
 fs/exfat/inode.c            |  1 +
 fs/ext2/inode.c             |  2 ++
 fs/ext4/inode.c             | 32 ++++++++++++++++----------------
 fs/fat/inode.c              |  1 +
 fs/gfs2/meta_io.c           |  2 ++
 fs/hfs/inode.c              |  2 ++
 fs/hfsplus/inode.c          |  2 ++
 fs/hpfs/file.c              |  1 +
 fs/jfs/inode.c              |  1 +
 fs/minix/inode.c            |  1 +
 fs/nilfs2/inode.c           |  2 +-
 fs/nilfs2/mdt.c             |  1 +
 fs/ntfs/aops.c              |  5 +++--
 fs/ocfs2/aops.c             |  2 +-
 fs/omfs/file.c              |  1 +
 fs/sysv/itree.c             |  1 +
 fs/udf/file.c               |  1 +
 fs/udf/inode.c              |  1 +
 fs/ufs/inode.c              |  1 +
 include/linux/buffer_head.h |  3 +--
 mm/truncate.c               |  4 ----
 27 files changed, 65 insertions(+), 45 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 4f59e0f5bf30..8ce1dccd15b9 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -430,6 +430,7 @@ static int blkdev_writepages(struct address_space *mapping,
 
 const struct address_space_operations def_blk_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= blkdev_readpage,
 	.readahead	= blkdev_readahead,
 	.writepage	= blkdev_writepage,
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 5156821bfe6a..5c423254895a 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -74,6 +74,7 @@ static sector_t _adfs_bmap(struct address_space *mapping, sector_t block)
 
 static const struct address_space_operations adfs_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= adfs_readpage,
 	.writepage	= adfs_writepage,
 	.write_begin	= adfs_write_begin,
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 75ebd2b576ca..6d4921f97162 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -454,6 +454,7 @@ static sector_t _affs_bmap(struct address_space *mapping, sector_t block)
 
 const struct address_space_operations affs_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage = affs_readpage,
 	.writepage = affs_writepage,
 	.write_begin = affs_write_begin,
@@ -835,6 +836,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 
 const struct address_space_operations affs_aops_ofs = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage = affs_readpage_ofs,
 	//.writepage = affs_writepage_ofs,
 	.write_begin = affs_write_begin_ofs,
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 7f8544abf636..2e42b82edb58 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -189,6 +189,7 @@ static sector_t bfs_bmap(struct address_space *mapping, sector_t block)
 
 const struct address_space_operations bfs_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= bfs_readpage,
 	.writepage	= bfs_writepage,
 	.write_begin	= bfs_write_begin,
diff --git a/fs/buffer.c b/fs/buffer.c
index 929061995cf8..5fe02e5a9807 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1482,41 +1482,40 @@ static void discard_buffer(struct buffer_head * bh)
 }
 
 /**
- * block_invalidatepage - invalidate part or all of a buffer-backed page
- *
- * @page: the page which is affected
+ * block_invalidate_folio - Invalidate part or all of a buffer-backed folio.
+ * @folio: The folio which is affected.
  * @offset: start of the range to invalidate
  * @length: length of the range to invalidate
  *
- * block_invalidatepage() is called when all or part of the page has become
+ * block_invalidate_folio() is called when all or part of the folio has been
  * invalidated by a truncate operation.
  *
- * block_invalidatepage() does not have to release all buffers, but it must
+ * block_invalidate_folio() does not have to release all buffers, but it must
  * ensure that no dirty buffer is left outside @offset and that no I/O
  * is underway against any of the blocks which are outside the truncation
  * point.  Because the caller is about to free (and possibly reuse) those
  * blocks on-disk.
  */
-void block_invalidatepage(struct page *page, unsigned int offset,
-			  unsigned int length)
+void block_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 {
 	struct buffer_head *head, *bh, *next;
-	unsigned int curr_off = 0;
-	unsigned int stop = length + offset;
+	size_t curr_off = 0;
+	size_t stop = length + offset;
 
-	BUG_ON(!PageLocked(page));
-	if (!page_has_buffers(page))
-		goto out;
+	BUG_ON(!folio_test_locked(folio));
 
 	/*
 	 * Check for overflow
 	 */
-	BUG_ON(stop > PAGE_SIZE || stop < length);
+	BUG_ON(stop > folio_size(folio) || stop < length);
+
+	head = folio_buffers(folio);
+	if (!head)
+		return;
 
-	head = page_buffers(page);
 	bh = head;
 	do {
-		unsigned int next_off = curr_off + bh->b_size;
+		size_t next_off = curr_off + bh->b_size;
 		next = bh->b_this_page;
 
 		/*
@@ -1535,16 +1534,16 @@ void block_invalidatepage(struct page *page, unsigned int offset,
 	} while (bh != head);
 
 	/*
-	 * We release buffers only if the entire page is being invalidated.
+	 * We release buffers only if the entire folio is being invalidated.
 	 * The get_block cached value has been unconditionally invalidated,
 	 * so real IO is not possible anymore.
 	 */
-	if (length == PAGE_SIZE)
-		try_to_release_page(page, 0);
+	if (length == folio_size(folio))
+		filemap_release_folio(folio, 0);
 out:
 	return;
 }
-EXPORT_SYMBOL(block_invalidatepage);
+EXPORT_SYMBOL(block_invalidate_folio);
 
 
 /*
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 7d85e64ea62f..bf7f35b375b7 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -546,6 +546,7 @@ const struct address_space_operations ecryptfs_aops = {
 	 */
 #ifdef CONFIG_BLOCK
 	.set_page_dirty = __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 #endif
 	.writepage = ecryptfs_writepage,
 	.readpage = ecryptfs_readpage,
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index df805bd05508..5ed471eb973b 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -491,6 +491,7 @@ int exfat_block_truncate_page(struct inode *inode, loff_t from)
 
 static const struct address_space_operations exfat_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= exfat_readpage,
 	.readahead	= exfat_readahead,
 	.writepage	= exfat_writepage,
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 602578b72d8c..1e14777c3ca6 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -968,6 +968,7 @@ ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc
 
 const struct address_space_operations ext2_aops = {
 	.set_page_dirty		= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage		= ext2_readpage,
 	.readahead		= ext2_readahead,
 	.writepage		= ext2_writepage,
@@ -983,6 +984,7 @@ const struct address_space_operations ext2_aops = {
 
 const struct address_space_operations ext2_nobh_aops = {
 	.set_page_dirty		= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage		= ext2_readpage,
 	.readahead		= ext2_readahead,
 	.writepage		= ext2_nobh_writepage,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 57800ecbe466..07ef3f84db9e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -137,8 +137,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 						   new_size);
 }
 
-static void ext4_invalidatepage(struct page *page, unsigned int offset,
-				unsigned int length);
 static int __ext4_journalled_writepage(struct page *page, unsigned int len);
 static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
@@ -1571,16 +1569,18 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 			break;
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
+			struct folio *folio = page_folio(page);
 
-			BUG_ON(!PageLocked(page));
-			BUG_ON(PageWriteback(page));
+			BUG_ON(!folio_test_locked(folio));
+			BUG_ON(folio_test_writeback(folio));
 			if (invalidate) {
-				if (page_mapped(page))
-					clear_page_dirty_for_io(page);
-				block_invalidatepage(page, 0, PAGE_SIZE);
-				ClearPageUptodate(page);
+				if (folio_mapped(folio))
+					folio_clear_dirty_for_io(folio);
+				block_invalidate_folio(folio, 0,
+						folio_size(folio));
+				folio_clear_uptodate(folio);
 			}
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 		pagevec_release(&pvec);
 	}
@@ -3183,15 +3183,15 @@ static void ext4_readahead(struct readahead_control *rac)
 	ext4_mpage_readpages(inode, rac, NULL);
 }
 
-static void ext4_invalidatepage(struct page *page, unsigned int offset,
-				unsigned int length)
+static void ext4_invalidate_folio(struct folio *folio, size_t offset,
+				size_t length)
 {
-	trace_ext4_invalidatepage(page, offset, length);
+	trace_ext4_invalidatepage(&folio->page, offset, length);
 
 	/* No journalling happens on data buffers when this function is used */
-	WARN_ON(page_has_buffers(page) && buffer_jbd(page_buffers(page)));
+	WARN_ON(folio_buffers(folio) && buffer_jbd(folio_buffers(folio)));
 
-	block_invalidatepage(page, offset, length);
+	block_invalidate_folio(folio, offset, length);
 }
 
 static int __ext4_journalled_invalidatepage(struct page *page,
@@ -3583,7 +3583,7 @@ static const struct address_space_operations ext4_aops = {
 	.write_end		= ext4_write_end,
 	.set_page_dirty		= ext4_set_page_dirty,
 	.bmap			= ext4_bmap,
-	.invalidatepage		= ext4_invalidatepage,
+	.invalidate_folio	= ext4_invalidate_folio,
 	.releasepage		= ext4_releasepage,
 	.direct_IO		= noop_direct_IO,
 	.migratepage		= buffer_migrate_page,
@@ -3618,7 +3618,7 @@ static const struct address_space_operations ext4_da_aops = {
 	.write_end		= ext4_da_write_end,
 	.set_page_dirty		= ext4_set_page_dirty,
 	.bmap			= ext4_bmap,
-	.invalidatepage		= ext4_invalidatepage,
+	.invalidate_folio	= ext4_invalidate_folio,
 	.releasepage		= ext4_releasepage,
 	.direct_IO		= noop_direct_IO,
 	.migratepage		= buffer_migrate_page,
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a6f1c6d426d1..1e2f1e24a073 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -343,6 +343,7 @@ int fat_block_truncate_page(struct inode *inode, loff_t from)
 
 static const struct address_space_operations fat_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= fat_readpage,
 	.readahead	= fat_readahead,
 	.writepage	= fat_writepage,
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 72d30a682ece..d23c8b035447 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -90,12 +90,14 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 
 const struct address_space_operations gfs2_meta_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.writepage = gfs2_aspace_writepage,
 	.releasepage = gfs2_releasepage,
 };
 
 const struct address_space_operations gfs2_rgrp_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.writepage = gfs2_aspace_writepage,
 	.releasepage = gfs2_releasepage,
 };
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2a5143246282..029d1869a224 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -160,6 +160,7 @@ static int hfs_writepages(struct address_space *mapping,
 
 const struct address_space_operations hfs_btree_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= hfs_readpage,
 	.writepage	= hfs_writepage,
 	.write_begin	= hfs_write_begin,
@@ -170,6 +171,7 @@ const struct address_space_operations hfs_btree_aops = {
 
 const struct address_space_operations hfs_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= hfs_readpage,
 	.writepage	= hfs_writepage,
 	.write_begin	= hfs_write_begin,
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index d08a8d1d40a4..a91b9b5e92a8 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -157,6 +157,7 @@ static int hfsplus_writepages(struct address_space *mapping,
 
 const struct address_space_operations hfsplus_btree_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= hfsplus_readpage,
 	.writepage	= hfsplus_writepage,
 	.write_begin	= hfsplus_write_begin,
@@ -167,6 +168,7 @@ const struct address_space_operations hfsplus_btree_aops = {
 
 const struct address_space_operations hfsplus_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= hfsplus_readpage,
 	.writepage	= hfsplus_writepage,
 	.write_begin	= hfsplus_write_begin,
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index fb37f57130aa..cf68f5e76ddd 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -246,6 +246,7 @@ static int hpfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 const struct address_space_operations hpfs_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage = hpfs_readpage,
 	.writepage = hpfs_writepage,
 	.readahead = hpfs_readahead,
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 57ab424c05ff..3950b3d610a0 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -358,6 +358,7 @@ static ssize_t jfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 const struct address_space_operations jfs_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= jfs_readpage,
 	.readahead	= jfs_readahead,
 	.writepage	= jfs_writepage,
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index a71f1cf894b9..2295804d1893 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -443,6 +443,7 @@ static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 
 static const struct address_space_operations minix_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage = minix_readpage,
 	.writepage = minix_writepage,
 	.write_begin = minix_write_begin,
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index e3d807d5b83a..153f0569dcf2 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -304,7 +304,7 @@ const struct address_space_operations nilfs_aops = {
 	.write_begin		= nilfs_write_begin,
 	.write_end		= nilfs_write_end,
 	/* .releasepage		= nilfs_releasepage, */
-	.invalidatepage		= block_invalidatepage,
+	.invalidate_folio	= block_invalidate_folio,
 	.direct_IO		= nilfs_direct_IO,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 };
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 4b3d33cf0041..72adca629bc9 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -435,6 +435,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 
 static const struct address_space_operations def_mdt_aops = {
 	.set_page_dirty		= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.writepage		= nilfs_mdt_write_page,
 };
 
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index bb0a43860ad2..6858bf6df49a 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1350,12 +1350,13 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 	/* Is the page fully outside i_size? (truncate in progress) */
 	if (unlikely(page->index >= (i_size + PAGE_SIZE - 1) >>
 			PAGE_SHIFT)) {
+		struct folio *folio = page_folio(page);
 		/*
 		 * The page may have dirty, unmapped buffers.  Make them
 		 * freeable here, so the page does not leak.
 		 */
-		block_invalidatepage(page, 0, PAGE_SIZE);
-		unlock_page(page);
+		block_invalidate_folio(folio, 0, folio_size(folio));
+		folio_unlock(folio);
 		ntfs_debug("Write outside i_size - truncated?");
 		return 0;
 	}
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 498da317580a..b274061e22a7 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2461,7 +2461,7 @@ const struct address_space_operations ocfs2_aops = {
 	.write_end		= ocfs2_write_end,
 	.bmap			= ocfs2_bmap,
 	.direct_IO		= ocfs2_direct_IO,
-	.invalidatepage		= block_invalidatepage,
+	.invalidate_folio	= block_invalidate_folio,
 	.releasepage		= ocfs2_releasepage,
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate	= block_is_partially_uptodate,
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 89725b15a64b..139d6a21dca1 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -373,6 +373,7 @@ const struct inode_operations omfs_file_inops = {
 
 const struct address_space_operations omfs_aops = {
 	.set_page_dirty = __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage = omfs_readpage,
 	.readahead = omfs_readahead,
 	.writepage = omfs_writepage,
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 749385015a8d..d39984a1d4d3 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -496,6 +496,7 @@ static sector_t sysv_bmap(struct address_space *mapping, sector_t block)
 
 const struct address_space_operations sysv_aops = {
 	.set_page_dirty = __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage = sysv_readpage,
 	.writepage = sysv_writepage,
 	.write_begin = sysv_write_begin,
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 1baff8ddb754..a91011a7bb88 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -126,6 +126,7 @@ static int udf_adinicb_write_end(struct file *file, struct address_space *mappin
 
 const struct address_space_operations udf_adinicb_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= udf_adinicb_readpage,
 	.writepage	= udf_adinicb_writepage,
 	.write_begin	= udf_adinicb_write_begin,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index ea8f6cd01f50..ab98c7aaf9f9 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -236,6 +236,7 @@ static sector_t udf_bmap(struct address_space *mapping, sector_t block)
 
 const struct address_space_operations udf_aops = {
 	.set_page_dirty	= __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage	= udf_readpage,
 	.readahead	= udf_readahead,
 	.writepage	= udf_writepage,
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index ac628de69601..2d005788c24d 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -527,6 +527,7 @@ static sector_t ufs_bmap(struct address_space *mapping, sector_t block)
 
 const struct address_space_operations ufs_aops = {
 	.set_page_dirty = __set_page_dirty_buffers,
+	.invalidate_folio = block_invalidate_folio,
 	.readpage = ufs_readpage,
 	.writepage = ufs_writepage,
 	.write_begin = ufs_write_begin,
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 79d465057889..9ee9d003d736 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -217,8 +217,7 @@ extern int buffer_heads_over_limit;
  * Generic address_space_operations implementations for buffer_head-backed
  * address_spaces.
  */
-void block_invalidatepage(struct page *page, unsigned int offset,
-			  unsigned int length);
+void block_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 int block_write_full_page(struct page *page, get_block_t *get_block,
 				struct writeback_control *wbc);
 int __block_write_full_page(struct inode *inode, struct page *page,
diff --git a/mm/truncate.c b/mm/truncate.c
index b9ad298e6ce7..28650151091a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -163,10 +163,6 @@ void folio_invalidate(struct folio *folio, size_t offset, size_t length)
 	}
 
 	invalidatepage = aops->invalidatepage;
-#ifdef CONFIG_BLOCK
-	if (!invalidatepage)
-		invalidatepage = block_invalidatepage;
-#endif
 	if (invalidatepage)
 		(*invalidatepage)(&folio->page, offset, length);
 }
-- 
2.34.1

