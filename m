Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A474AFE63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiBIUXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiBIUWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15814E040CBC
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iFFo/D3ErqW2RtcdcHYEUle+YnaX5kmvCEK96vfwbcE=; b=btisneFmAvzQjwp40Bakn5KDxW
        J1TlUUlKBROco9jlrOu71ckb4ZM0PSLNFBt8x1c4dgezfthiZ8qxqSknY0PV14R2y7dcKplecMO9X
        5SIAywLTBmtO8VHOzFhL52aFcHdec4RaFaZU/NhZujUTEmXtPeiAm/RCHNiLgFx5ZX8ryo8PlqCz2
        R/wV7Nsi4iWr5MbfPlt0mcSZ/ngv1EoHbIZX+nFws/HoalIUT6C7V/HaY6A0qSLbup17+f/Sk8/tV
        GZELpUi9QI4uSiZohy7UZuSlh+i3wWkYfUSIHBEtd6coF/b6PBJ/ulAGEgW9EsBlDfj3W6bd76fr9
        At7i4eqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTx-008cth-Cd; Wed, 09 Feb 2022 20:22:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 53/56] fs: Convert __set_page_dirty_buffers to block_dirty_folio
Date:   Wed,  9 Feb 2022 20:22:12 +0000
Message-Id: <20220209202215.2055748-54-willy@infradead.org>
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

Convert all callers; mostly this is just changing the aops to point
at it, but a few implementations need a little more work.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/fops.c                |  2 +-
 fs/adfs/inode.c             |  2 +-
 fs/affs/file.c              |  4 ++--
 fs/bfs/file.c               |  2 +-
 fs/buffer.c                 | 33 +++++++++++++++------------------
 fs/ecryptfs/mmap.c          |  2 +-
 fs/exfat/inode.c            |  2 +-
 fs/ext2/inode.c             |  8 ++++----
 fs/ext4/inode.c             | 12 ++++++------
 fs/fat/inode.c              |  2 +-
 fs/gfs2/aops.c              | 16 +++++-----------
 fs/gfs2/meta_io.c           |  4 ++--
 fs/hfs/inode.c              |  4 ++--
 fs/hfsplus/inode.c          |  4 ++--
 fs/hpfs/file.c              |  2 +-
 fs/jfs/inode.c              |  2 +-
 fs/minix/inode.c            |  2 +-
 fs/mpage.c                  |  2 +-
 fs/nilfs2/mdt.c             |  4 ++--
 fs/ntfs/aops.c              | 12 ++++++------
 fs/ntfs3/inode.c            |  2 +-
 fs/ocfs2/aops.c             |  2 +-
 fs/omfs/file.c              |  2 +-
 fs/reiserfs/inode.c         | 14 +++++++-------
 fs/sysv/itree.c             |  2 +-
 fs/udf/file.c               |  2 +-
 fs/udf/inode.c              |  2 +-
 fs/ufs/inode.c              |  2 +-
 include/linux/buffer_head.h |  2 +-
 mm/filemap.c                |  4 ++--
 mm/page-writeback.c         |  2 +-
 mm/rmap.c                   |  4 ++--
 32 files changed, 76 insertions(+), 85 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 8ce1dccd15b9..796a78fd1583 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -429,7 +429,7 @@ static int blkdev_writepages(struct address_space *mapping,
 }
 
 const struct address_space_operations def_blk_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= blkdev_readpage,
 	.readahead	= blkdev_readahead,
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 5c423254895a..561bc748c04a 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -73,7 +73,7 @@ static sector_t _adfs_bmap(struct address_space *mapping, sector_t block)
 }
 
 static const struct address_space_operations adfs_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= adfs_readpage,
 	.writepage	= adfs_writepage,
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 6d4921f97162..b3f81d84ff4c 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -453,7 +453,7 @@ static sector_t _affs_bmap(struct address_space *mapping, sector_t block)
 }
 
 const struct address_space_operations affs_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage = affs_readpage,
 	.writepage = affs_writepage,
@@ -835,7 +835,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 }
 
 const struct address_space_operations affs_aops_ofs = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage = affs_readpage_ofs,
 	//.writepage = affs_writepage_ofs,
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 2e42b82edb58..03139344568f 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -188,7 +188,7 @@ static sector_t bfs_bmap(struct address_space *mapping, sector_t block)
 }
 
 const struct address_space_operations bfs_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= bfs_readpage,
 	.writepage	= bfs_writepage,
diff --git a/fs/buffer.c b/fs/buffer.c
index 5fe02e5a9807..28b9739b719b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -613,17 +613,14 @@ EXPORT_SYMBOL(mark_buffer_dirty_inode);
  * FIXME: may need to call ->reservepage here as well.  That's rather up to the
  * address_space though.
  */
-int __set_page_dirty_buffers(struct page *page)
+bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	int newly_dirty;
-	struct address_space *mapping = page_mapping(page);
-
-	if (unlikely(!mapping))
-		return !TestSetPageDirty(page);
+	struct buffer_head *head;
+	bool newly_dirty;
 
 	spin_lock(&mapping->private_lock);
-	if (page_has_buffers(page)) {
-		struct buffer_head *head = page_buffers(page);
+	head = folio_buffers(folio);
+	if (head) {
 		struct buffer_head *bh = head;
 
 		do {
@@ -635,21 +632,21 @@ int __set_page_dirty_buffers(struct page *page)
 	 * Lock out page's memcg migration to keep PageDirty
 	 * synchronized with per-memcg dirty page counters.
 	 */
-	lock_page_memcg(page);
-	newly_dirty = !TestSetPageDirty(page);
+	folio_memcg_lock(folio);
+	newly_dirty = !folio_test_set_dirty(folio);
 	spin_unlock(&mapping->private_lock);
 
 	if (newly_dirty)
-		__set_page_dirty(page, mapping, 1);
+		__folio_mark_dirty(folio, mapping, 1);
 
-	unlock_page_memcg(page);
+	folio_memcg_unlock(folio);
 
 	if (newly_dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 
 	return newly_dirty;
 }
-EXPORT_SYMBOL(__set_page_dirty_buffers);
+EXPORT_SYMBOL(block_dirty_folio);
 
 /*
  * Write out and wait upon a list of buffers.
@@ -1548,7 +1545,7 @@ EXPORT_SYMBOL(block_invalidate_folio);
 
 /*
  * We attach and possibly dirty the buffers atomically wrt
- * __set_page_dirty_buffers() via private_lock.  try_to_free_buffers
+ * block_dirty_folio() via private_lock.  try_to_free_buffers
  * is already excluded via the page lock.
  */
 void create_empty_buffers(struct page *page,
@@ -1723,12 +1720,12 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 					(1 << BH_Dirty)|(1 << BH_Uptodate));
 
 	/*
-	 * Be very careful.  We have no exclusion from __set_page_dirty_buffers
+	 * Be very careful.  We have no exclusion from block_dirty_folio
 	 * here, and the (potentially unmapped) buffers may become dirty at
 	 * any time.  If a buffer becomes dirty here after we've inspected it
 	 * then we just miss that fact, and the page stays dirty.
 	 *
-	 * Buffers outside i_size may be dirtied by __set_page_dirty_buffers;
+	 * Buffers outside i_size may be dirtied by block_dirty_folio;
 	 * handle that here by just cleaning them.
 	 */
 
@@ -3182,7 +3179,7 @@ EXPORT_SYMBOL(sync_dirty_buffer);
  *
  * The same applies to regular filesystem pages: if all the buffers are
  * clean then we set the page clean and proceed.  To do that, we require
- * total exclusion from __set_page_dirty_buffers().  That is obtained with
+ * total exclusion from block_dirty_folio().  That is obtained with
  * private_lock.
  *
  * try_to_free_buffers() is non-blocking.
@@ -3249,7 +3246,7 @@ int try_to_free_buffers(struct page *page)
 	 * the page also.
 	 *
 	 * private_lock must be held over this entire operation in order
-	 * to synchronise against __set_page_dirty_buffers and prevent the
+	 * to synchronise against block_dirty_folio and prevent the
 	 * dirty bit from being lost.
 	 */
 	if (ret)
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index bf7f35b375b7..9aabcb2f52e9 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -545,7 +545,7 @@ const struct address_space_operations ecryptfs_aops = {
 	 * feedback.
 	 */
 #ifdef CONFIG_BLOCK
-	.set_page_dirty = __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 #endif
 	.writepage = ecryptfs_writepage,
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 5ed471eb973b..fc0ea1684880 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -490,7 +490,7 @@ int exfat_block_truncate_page(struct inode *inode, loff_t from)
 }
 
 static const struct address_space_operations exfat_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= exfat_readpage,
 	.readahead	= exfat_readahead,
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 9b579ee56eaf..d9452a051198 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -967,8 +967,8 @@ ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc
 }
 
 const struct address_space_operations ext2_aops = {
-	.set_page_dirty		= __set_page_dirty_buffers,
-	.invalidate_folio = block_invalidate_folio,
+	.dirty_folio		= block_dirty_folio,
+	.invalidate_folio	= block_invalidate_folio,
 	.readpage		= ext2_readpage,
 	.readahead		= ext2_readahead,
 	.writepage		= ext2_writepage,
@@ -983,8 +983,8 @@ const struct address_space_operations ext2_aops = {
 };
 
 const struct address_space_operations ext2_nobh_aops = {
-	.set_page_dirty		= __set_page_dirty_buffers,
-	.invalidate_folio = block_invalidate_folio,
+	.dirty_folio		= block_dirty_folio,
+	.invalidate_folio	= block_invalidate_folio,
 	.readpage		= ext2_readpage,
 	.readahead		= ext2_readahead,
 	.writepage		= ext2_nobh_writepage,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c48dbbf0e9b2..4c34104a94f0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3560,11 +3560,11 @@ static bool ext4_journalled_dirty_folio(struct address_space *mapping,
 	return filemap_dirty_folio(mapping, folio);
 }
 
-static int ext4_set_page_dirty(struct page *page)
+static bool ext4_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	WARN_ON_ONCE(!PageLocked(page) && !PageDirty(page));
-	WARN_ON_ONCE(!page_has_buffers(page));
-	return __set_page_dirty_buffers(page);
+	WARN_ON_ONCE(!folio_test_locked(folio) && !folio_test_dirty(folio));
+	WARN_ON_ONCE(!folio_buffers(folio));
+	return block_dirty_folio(mapping, folio);
 }
 
 static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
@@ -3581,7 +3581,7 @@ static const struct address_space_operations ext4_aops = {
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
 	.write_end		= ext4_write_end,
-	.set_page_dirty		= ext4_set_page_dirty,
+	.dirty_folio		= ext4_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
 	.releasepage		= ext4_releasepage,
@@ -3616,7 +3616,7 @@ static const struct address_space_operations ext4_da_aops = {
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_da_write_begin,
 	.write_end		= ext4_da_write_end,
-	.set_page_dirty		= ext4_set_page_dirty,
+	.dirty_folio		= ext4_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
 	.releasepage		= ext4_releasepage,
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 1e2f1e24a073..86957dd07bda 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -342,7 +342,7 @@ int fat_block_truncate_page(struct inode *inode, loff_t from)
 }
 
 static const struct address_space_operations fat_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= fat_readpage,
 	.readahead	= fat_readahead,
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 7c096a75d703..72c9f31ce724 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -606,18 +606,12 @@ void adjust_fs_space(struct inode *inode)
 	gfs2_trans_end(sdp);
 }
 
-/**
- * jdata_set_page_dirty - Page dirtying function
- * @page: The page to dirty
- *
- * Returns: 1 if it dirtyed the page, or 0 otherwise
- */
- 
-static int jdata_set_page_dirty(struct page *page)
+static bool jdata_dirty_folio(struct address_space *mapping,
+		struct folio *folio)
 {
 	if (current->journal_info)
-		SetPageChecked(page);
-	return __set_page_dirty_buffers(page);
+		folio_set_checked(folio);
+	return block_dirty_folio(mapping, folio);
 }
 
 /**
@@ -795,7 +789,7 @@ static const struct address_space_operations gfs2_jdata_aops = {
 	.writepages = gfs2_jdata_writepages,
 	.readpage = gfs2_readpage,
 	.readahead = gfs2_readahead,
-	.set_page_dirty = jdata_set_page_dirty,
+	.dirty_folio = jdata_dirty_folio,
 	.bmap = gfs2_bmap,
 	.invalidate_folio = gfs2_invalidate_folio,
 	.releasepage = gfs2_releasepage,
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index d23c8b035447..ac4d27ccd87d 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -89,14 +89,14 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 }
 
 const struct address_space_operations gfs2_meta_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.writepage = gfs2_aspace_writepage,
 	.releasepage = gfs2_releasepage,
 };
 
 const struct address_space_operations gfs2_rgrp_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.writepage = gfs2_aspace_writepage,
 	.releasepage = gfs2_releasepage,
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 029d1869a224..55f45e9b4930 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -159,7 +159,7 @@ static int hfs_writepages(struct address_space *mapping,
 }
 
 const struct address_space_operations hfs_btree_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= hfs_readpage,
 	.writepage	= hfs_writepage,
@@ -170,7 +170,7 @@ const struct address_space_operations hfs_btree_aops = {
 };
 
 const struct address_space_operations hfs_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= hfs_readpage,
 	.writepage	= hfs_writepage,
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index a91b9b5e92a8..446a816aa8e1 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -156,7 +156,7 @@ static int hfsplus_writepages(struct address_space *mapping,
 }
 
 const struct address_space_operations hfsplus_btree_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= hfsplus_readpage,
 	.writepage	= hfsplus_writepage,
@@ -167,7 +167,7 @@ const struct address_space_operations hfsplus_btree_aops = {
 };
 
 const struct address_space_operations hfsplus_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= hfsplus_readpage,
 	.writepage	= hfsplus_writepage,
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index cf68f5e76ddd..99493a23c5d0 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -245,7 +245,7 @@ static int hpfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 }
 
 const struct address_space_operations hpfs_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage = hpfs_readpage,
 	.writepage = hpfs_writepage,
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 3950b3d610a0..27be2e8ba237 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -357,7 +357,7 @@ static ssize_t jfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 }
 
 const struct address_space_operations jfs_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= jfs_readpage,
 	.readahead	= jfs_readahead,
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 2295804d1893..1e41fba68dcf 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -442,7 +442,7 @@ static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 }
 
 static const struct address_space_operations minix_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage = minix_readpage,
 	.writepage = minix_writepage,
diff --git a/fs/mpage.c b/fs/mpage.c
index 87f5cfef6caa..571862da9f56 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -504,7 +504,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 			if (!buffer_mapped(bh)) {
 				/*
 				 * unmapped dirty buffers are created by
-				 * __set_page_dirty_buffers -> mmapped data
+				 * block_dirty_folio -> mmapped data
 				 */
 				if (buffer_dirty(bh))
 					goto confused;
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 72adca629bc9..78db33decd72 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -434,8 +434,8 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 
 
 static const struct address_space_operations def_mdt_aops = {
-	.set_page_dirty		= __set_page_dirty_buffers,
-	.invalidate_folio = block_invalidate_folio,
+	.dirty_folio		= block_dirty_folio,
+	.invalidate_folio	= block_invalidate_folio,
 	.writepage		= nilfs_mdt_write_page,
 };
 
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index dd71f6ac0272..d154dcfe06af 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -593,12 +593,12 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 	iblock = initialized_size >> blocksize_bits;
 
 	/*
-	 * Be very careful.  We have no exclusion from __set_page_dirty_buffers
+	 * Be very careful.  We have no exclusion from block_dirty_folio
 	 * here, and the (potentially unmapped) buffers may become dirty at
 	 * any time.  If a buffer becomes dirty here after we've inspected it
 	 * then we just miss that fact, and the page stays dirty.
 	 *
-	 * Buffers outside i_size may be dirtied by __set_page_dirty_buffers;
+	 * Buffers outside i_size may be dirtied by block_dirty_folio;
 	 * handle that here by just cleaning them.
 	 */
 
@@ -653,7 +653,7 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 				// Update initialized size in the attribute and
 				// in the inode.
 				// Again, for each page do:
-				//	__set_page_dirty_buffers();
+				//	block_dirty_folio();
 				// put_page()
 				// We don't need to wait on the writes.
 				// Update iblock.
@@ -1654,7 +1654,7 @@ const struct address_space_operations ntfs_normal_aops = {
 	.readpage	= ntfs_readpage,
 #ifdef NTFS_RW
 	.writepage	= ntfs_writepage,
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 #endif /* NTFS_RW */
 	.bmap		= ntfs_bmap,
 	.migratepage	= buffer_migrate_page,
@@ -1669,7 +1669,7 @@ const struct address_space_operations ntfs_compressed_aops = {
 	.readpage	= ntfs_readpage,
 #ifdef NTFS_RW
 	.writepage	= ntfs_writepage,
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 #endif /* NTFS_RW */
 	.migratepage	= buffer_migrate_page,
 	.is_partially_uptodate = block_is_partially_uptodate,
@@ -1746,7 +1746,7 @@ void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
 		set_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
 	spin_unlock(&mapping->private_lock);
-	__set_page_dirty_nobuffers(page);
+	block_dirty_folio(mapping, page_folio(page));
 	if (unlikely(buffers_to_free)) {
 		do {
 			bh = buffers_to_free->b_this_page;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index a87ab3ad3cd3..9eab11e3b034 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1950,7 +1950,7 @@ const struct address_space_operations ntfs_aops = {
 	.write_end	= ntfs_write_end,
 	.direct_IO	= ntfs_direct_IO,
 	.bmap		= ntfs_bmap,
-	.set_page_dirty = __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 };
 
 const struct address_space_operations ntfs_aops_cmpr = {
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index b274061e22a7..fc890ca2e17e 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2453,7 +2453,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 }
 
 const struct address_space_operations ocfs2_aops = {
-	.set_page_dirty		= __set_page_dirty_buffers,
+	.dirty_folio		= block_dirty_folio,
 	.readpage		= ocfs2_readpage,
 	.readahead		= ocfs2_readahead,
 	.writepage		= ocfs2_writepage,
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 139d6a21dca1..3f297b541713 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -372,7 +372,7 @@ const struct inode_operations omfs_file_inops = {
 };
 
 const struct address_space_operations omfs_aops = {
-	.set_page_dirty = __set_page_dirty_buffers,
+	.dirty_folio = block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage = omfs_readpage,
 	.readahead = omfs_readahead,
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index f7fa70b419d2..e4221fa85ea2 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3201,14 +3201,14 @@ static void reiserfs_invalidate_folio(struct folio *folio, size_t offset,
 	return;
 }
 
-static int reiserfs_set_page_dirty(struct page *page)
+static bool reiserfs_dirty_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
-	if (reiserfs_file_data_log(inode)) {
-		SetPageChecked(page);
-		return __set_page_dirty_nobuffers(page);
+	if (reiserfs_file_data_log(mapping->host)) {
+		folio_set_checked(folio);
+		return filemap_dirty_folio(mapping, folio);
 	}
-	return __set_page_dirty_buffers(page);
+	return block_dirty_folio(mapping, folio);
 }
 
 /*
@@ -3435,5 +3435,5 @@ const struct address_space_operations reiserfs_address_space_operations = {
 	.write_end = reiserfs_write_end,
 	.bmap = reiserfs_aop_bmap,
 	.direct_IO = reiserfs_direct_IO,
-	.set_page_dirty = reiserfs_set_page_dirty,
+	.dirty_folio = reiserfs_dirty_folio,
 };
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index d39984a1d4d3..409ab5e17803 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -495,7 +495,7 @@ static sector_t sysv_bmap(struct address_space *mapping, sector_t block)
 }
 
 const struct address_space_operations sysv_aops = {
-	.set_page_dirty = __set_page_dirty_buffers,
+	.dirty_folio = block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage = sysv_readpage,
 	.writepage = sysv_writepage,
diff --git a/fs/udf/file.c b/fs/udf/file.c
index a91011a7bb88..0f6bf2504437 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -125,7 +125,7 @@ static int udf_adinicb_write_end(struct file *file, struct address_space *mappin
 }
 
 const struct address_space_operations udf_adinicb_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= udf_adinicb_readpage,
 	.writepage	= udf_adinicb_writepage,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index ab98c7aaf9f9..ca4fa710e562 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -235,7 +235,7 @@ static sector_t udf_bmap(struct address_space *mapping, sector_t block)
 }
 
 const struct address_space_operations udf_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
+	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage	= udf_readpage,
 	.readahead	= udf_readahead,
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 2d005788c24d..d0dda01620f0 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -526,7 +526,7 @@ static sector_t ufs_bmap(struct address_space *mapping, sector_t block)
 }
 
 const struct address_space_operations ufs_aops = {
-	.set_page_dirty = __set_page_dirty_buffers,
+	.dirty_folio = block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.readpage = ufs_readpage,
 	.writepage = ufs_writepage,
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 9ee9d003d736..bcb4fe9b8575 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -397,7 +397,7 @@ __bread(struct block_device *bdev, sector_t block, unsigned size)
 	return __bread_gfp(bdev, block, size, __GFP_MOVABLE);
 }
 
-extern int __set_page_dirty_buffers(struct page *page);
+bool block_dirty_folio(struct address_space *mapping, struct folio *folio);
 
 #else /* CONFIG_BLOCK */
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 9639b844dd31..bb4e91bf5492 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -72,7 +72,7 @@
  * Lock ordering:
  *
  *  ->i_mmap_rwsem		(truncate_pagecache)
- *    ->private_lock		(__free_pte->__set_page_dirty_buffers)
+ *    ->private_lock		(__free_pte->block_dirty_folio)
  *      ->swap_lock		(exclusive_swap_page, others)
  *        ->i_pages lock
  *
@@ -115,7 +115,7 @@
  *    ->memcg->move_lock	(page_remove_rmap->lock_page_memcg)
  *    bdi.wb->list_lock		(zap_pte_range->set_page_dirty)
  *    ->inode->i_lock		(zap_pte_range->set_page_dirty)
- *    ->private_lock		(zap_pte_range->__set_page_dirty_buffers)
+ *    ->private_lock		(zap_pte_range->block_dirty_folio)
  *
  * ->i_mmap_rwsem
  *   ->tasklist_lock            (memory_failure, collect_procs_ao)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 27a87ae4502c..e890db239fae 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2530,7 +2530,7 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
  * This is also sometimes used by filesystems which use buffer_heads when
  * a single buffer is being dirtied: we want to set the folio dirty in
  * that case, but not all the buffers.  This is a "bottom-up" dirtying,
- * whereas __set_page_dirty_buffers() is a "top-down" dirtying.
+ * whereas block_dirty_folio() is a "top-down" dirtying.
  *
  * The caller must ensure this doesn't race with truncation.  Most will
  * simply hold the folio lock, but e.g. zap_pte_range() calls with the
diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..4f3391fa4ca9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -31,8 +31,8 @@
  *               mm->page_table_lock or pte_lock
  *                 swap_lock (in swap_duplicate, swap_info_get)
  *                   mmlist_lock (in mmput, drain_mmlist and others)
- *                   mapping->private_lock (in __set_page_dirty_buffers)
- *                     lock_page_memcg move_lock (in __set_page_dirty_buffers)
+ *                   mapping->private_lock (in block_dirty_folio)
+ *                     folio_lock_memcg move_lock (in block_dirty_folio)
  *                       i_pages lock (widely used)
  *                         lruvec->lru_lock (in folio_lruvec_lock_irq)
  *                   inode->i_lock (in set_page_dirty's __mark_inode_dirty)
-- 
2.34.1

