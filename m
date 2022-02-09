Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ECF4AFE46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiBIUWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiBIUW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB9E039C4F
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=npAWWYt6zjVgTGI7yQrlYWUqvvMzoQKFjEQR71AnWn4=; b=XysRxllzls3zs90F4+lZswOWqe
        f+4gl7iDI0jhUBUSgmoaA69Bz3vDOwL9OMmLOTMsZ6TpuadW52Zq2er01GlukNt+2QEg9XY+tX3Xb
        Pf7/SITEXrYIp6j4Xz0RNabVIu3cxtk4DLTfdRPpL/uAFPB/tO6FR0z5XWczT4XlreTxqFdZH7TE9
        z+dEbfuwJWpcVt95Sa7RpMTPT70L6N+PhfqhsZYwo7RJ+5K96psEUaI/TpPc/S8Dth5KcVQw8aJVF
        cnnd6RpX35lYja+0duYqG5z22Rc23xv/xjwUOV6DC12ULBc2P7xMfANlorWlYp1LdqQ0SoBSfUcKr
        H5KZHAzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTt-008cqU-3v; Wed, 09 Feb 2022 20:22:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 20/56] btrfs: Convert from invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:39 +0000
Message-Id: <20220209202215.2055748-21-willy@infradead.org>
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

A lot of the underlying infrastructure in btrfs needs to be switched
over to folios, but this at least documents that invalidatepage can't
be passed a tail page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/ctree.h          |  3 ++
 fs/btrfs/disk-io.c        | 22 +++++------
 fs/btrfs/extent-io-tree.h |  4 +-
 fs/btrfs/extent_io.c      | 16 ++++----
 fs/btrfs/inode.c          | 77 ++++++++++++++++++++-------------------
 5 files changed, 63 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8992e0096163..0608d1c6004b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3876,5 +3876,8 @@ static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 #define PageOrdered(page)		PagePrivate2(page)
 #define SetPageOrdered(page)		SetPagePrivate2(page)
 #define ClearPageOrdered(page)		ClearPagePrivate2(page)
+#define folio_test_ordered(folio)	folio_test_private_2(folio)
+#define folio_set_ordered(folio)	folio_set_private_2(folio)
+#define folio_clear_ordered(folio)	folio_clear_private_2(folio)
 
 #endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 87a5addbedf6..7e9d3b9c50e3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -999,18 +999,18 @@ static int btree_releasepage(struct page *page, gfp_t gfp_flags)
 	return try_release_extent_buffer(page);
 }
 
-static void btree_invalidatepage(struct page *page, unsigned int offset,
-				 unsigned int length)
+static void btree_invalidate_folio(struct folio *folio, size_t offset,
+				 size_t length)
 {
 	struct extent_io_tree *tree;
-	tree = &BTRFS_I(page->mapping->host)->io_tree;
-	extent_invalidatepage(tree, page, offset);
-	btree_releasepage(page, GFP_NOFS);
-	if (PagePrivate(page)) {
-		btrfs_warn(BTRFS_I(page->mapping->host)->root->fs_info,
-			   "page private not zero on page %llu",
-			   (unsigned long long)page_offset(page));
-		detach_page_private(page);
+	tree = &BTRFS_I(folio->mapping->host)->io_tree;
+	extent_invalidate_folio(tree, folio, offset);
+	btree_releasepage(&folio->page, GFP_NOFS);
+	if (folio_get_private(folio)) {
+		btrfs_warn(BTRFS_I(folio->mapping->host)->root->fs_info,
+			   "folio private not zero on folio %llu",
+			   (unsigned long long)folio_pos(folio));
+		folio_detach_private(folio);
 	}
 }
 
@@ -1066,7 +1066,7 @@ static int btree_set_page_dirty(struct page *page)
 static const struct address_space_operations btree_aops = {
 	.writepages	= btree_writepages,
 	.releasepage	= btree_releasepage,
-	.invalidatepage = btree_invalidatepage,
+	.invalidate_folio = btree_invalidate_folio,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= btree_migratepage,
 #endif
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 04083ee5ae6e..c3eb52dbe61c 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -244,8 +244,8 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, u32 bits);
 int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 			       u64 *start_ret, u64 *end_ret, u32 bits);
-int extent_invalidatepage(struct extent_io_tree *tree,
-			  struct page *page, unsigned long offset);
+int extent_invalidate_folio(struct extent_io_tree *tree,
+			  struct folio *folio, size_t offset);
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1e6bf7f1639a..9c9952ce33a2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5219,17 +5219,17 @@ void extent_readahead(struct readahead_control *rac)
 }
 
 /*
- * basic invalidatepage code, this waits on any locked or writeback
- * ranges corresponding to the page, and then deletes any extent state
+ * basic invalidate_folio code, this waits on any locked or writeback
+ * ranges corresponding to the folio, and then deletes any extent state
  * records from the tree
  */
-int extent_invalidatepage(struct extent_io_tree *tree,
-			  struct page *page, unsigned long offset)
+int extent_invalidate_folio(struct extent_io_tree *tree,
+			  struct folio *folio, size_t offset)
 {
 	struct extent_state *cached_state = NULL;
-	u64 start = page_offset(page);
-	u64 end = start + PAGE_SIZE - 1;
-	size_t blocksize = page->mapping->host->i_sb->s_blocksize;
+	u64 start = folio_pos(folio);
+	u64 end = start + folio_size(folio) - 1;
+	size_t blocksize = folio->mapping->host->i_sb->s_blocksize;
 
 	/* This function is only called for the btree inode */
 	ASSERT(tree->owner == IO_TREE_BTREE_INODE_IO);
@@ -5239,7 +5239,7 @@ int extent_invalidatepage(struct extent_io_tree *tree,
 		return 0;
 
 	lock_extent_bits(tree, start, end, &cached_state);
-	wait_on_page_writeback(page);
+	folio_wait_writeback(folio);
 
 	/*
 	 * Currently for btree io tree, only EXTENT_LOCKED is utilized,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b2403b6127f..9046c14f76af 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5046,16 +5046,17 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 }
 
 /*
- * While truncating the inode pages during eviction, we get the VFS calling
- * btrfs_invalidatepage() against each page of the inode. This is slow because
- * the calls to btrfs_invalidatepage() result in a huge amount of calls to
- * lock_extent_bits() and clear_extent_bit(), which keep merging and splitting
- * extent_state structures over and over, wasting lots of time.
+ * While truncating the inode pages during eviction, we get the VFS
+ * calling btrfs_invalidate_folio() against each folio of the inode. This
+ * is slow because the calls to btrfs_invalidate_folio() result in a
+ * huge amount of calls to lock_extent_bits() and clear_extent_bit(),
+ * which keep merging and splitting extent_state structures over and over,
+ * wasting lots of time.
  *
- * Therefore if the inode is being evicted, let btrfs_invalidatepage() skip all
- * those expensive operations on a per page basis and do only the ordered io
- * finishing, while we release here the extent_map and extent_state structures,
- * without the excessive merging and splitting.
+ * Therefore if the inode is being evicted, let btrfs_invalidate_folio()
+ * skip all those expensive operations on a per folio basis and do only
+ * the ordered io finishing, while we release here the extent_map and
+ * extent_state structures, without the excessive merging and splitting.
  */
 static void evict_inode_truncate_pages(struct inode *inode)
 {
@@ -5121,7 +5122,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		 * If still has DELALLOC flag, the extent didn't reach disk,
 		 * and its reserved space won't be freed by delayed_ref.
 		 * So we need to free its reserved space here.
-		 * (Refer to comment in btrfs_invalidatepage, case 2)
+		 * (Refer to comment in btrfs_invalidate_folio, case 2)
 		 *
 		 * Note, end is the bytenr of last byte, so we need + 1 here.
 		 */
@@ -8118,8 +8119,8 @@ static void btrfs_readahead(struct readahead_control *rac)
 }
 
 /*
- * For releasepage() and invalidatepage() we have a race window where
- * end_page_writeback() is called but the subpage spinlock is not yet released.
+ * For releasepage() and invalidate_folio() we have a race window where
+ * folio_end_writeback() is called but the subpage spinlock is not yet released.
  * If we continue to release/invalidate the page, we could cause use-after-free
  * for subpage spinlock.  So this function is to spin and wait for subpage
  * spinlock.
@@ -8195,48 +8196,48 @@ static int btrfs_migratepage(struct address_space *mapping,
 }
 #endif
 
-static void btrfs_invalidatepage(struct page *page, unsigned int offset,
-				 unsigned int length)
+static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
+				 size_t length)
 {
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *inode = BTRFS_I(folio->mapping->host);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_io_tree *tree = &inode->io_tree;
 	struct extent_state *cached_state = NULL;
-	u64 page_start = page_offset(page);
-	u64 page_end = page_start + PAGE_SIZE - 1;
+	u64 page_start = folio_pos(folio);
+	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
 	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
 
 	/*
-	 * We have page locked so no new ordered extent can be created on this
-	 * page, nor bio can be submitted for this page.
+	 * We have folio locked so no new ordered extent can be created on this
+	 * page, nor bio can be submitted for this folio.
 	 *
-	 * But already submitted bio can still be finished on this page.
-	 * Furthermore, endio function won't skip page which has Ordered
+	 * But already submitted bio can still be finished on this folio.
+	 * Furthermore, endio function won't skip folio which has Ordered
 	 * (Private2) already cleared, so it's possible for endio and
-	 * invalidatepage to do the same ordered extent accounting twice
-	 * on one page.
+	 * invalidate_folio to do the same ordered extent accounting twice
+	 * on one folio.
 	 *
 	 * So here we wait for any submitted bios to finish, so that we won't
-	 * do double ordered extent accounting on the same page.
+	 * do double ordered extent accounting on the same folio.
 	 */
-	wait_on_page_writeback(page);
-	wait_subpage_spinlock(page);
+	folio_wait_writeback(folio);
+	wait_subpage_spinlock(&folio->page);
 
 	/*
 	 * For subpage case, we have call sites like
 	 * btrfs_punch_hole_lock_range() which passes range not aligned to
 	 * sectorsize.
-	 * If the range doesn't cover the full page, we don't need to and
-	 * shouldn't clear page extent mapped, as page->private can still
+	 * If the range doesn't cover the full folio, we don't need to and
+	 * shouldn't clear page extent mapped, as folio->private can still
 	 * record subpage dirty bits for other part of the range.
 	 *
-	 * For cases that can invalidate the full even the range doesn't
-	 * cover the full page, like invalidating the last page, we're
+	 * For cases that invalidate the full folio even the range doesn't
+	 * cover the full folio, like invalidating the last folio, we're
 	 * still safe to wait for ordered extent to finish.
 	 */
 	if (!(offset == 0 && length == PAGE_SIZE)) {
-		btrfs_releasepage(page, GFP_NOFS);
+		btrfs_releasepage(&folio->page, GFP_NOFS);
 		return;
 	}
 
@@ -8277,7 +8278,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				page_end);
 		ASSERT(range_end + 1 - cur < U32_MAX);
 		range_len = range_end + 1 - cur;
-		if (!btrfs_page_test_ordered(fs_info, page, cur, range_len)) {
+		if (!btrfs_page_test_ordered(fs_info, &folio->page, cur, range_len)) {
 			/*
 			 * If Ordered (Private2) is cleared, it means endio has
 			 * already been executed for the range.
@@ -8287,7 +8288,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 			delete_states = false;
 			goto next;
 		}
-		btrfs_page_clear_ordered(fs_info, page, cur, range_len);
+		btrfs_page_clear_ordered(fs_info, &folio->page, cur, range_len);
 
 		/*
 		 * IO on this page will never be started, so we need to account
@@ -8357,11 +8358,11 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	 * should not have Ordered (Private2) anymore, or the above iteration
 	 * did something wrong.
 	 */
-	ASSERT(!PageOrdered(page));
-	btrfs_page_clear_checked(fs_info, page, page_offset(page), PAGE_SIZE);
+	ASSERT(!folio_test_ordered(folio));
+	btrfs_page_clear_checked(fs_info, &folio->page, folio_pos(folio), folio_size(folio));
 	if (!inode_evicting)
-		__btrfs_releasepage(page, GFP_NOFS);
-	clear_page_extent_mapped(page);
+		__btrfs_releasepage(&folio->page, GFP_NOFS);
+	clear_page_extent_mapped(&folio->page);
 }
 
 /*
@@ -10638,7 +10639,7 @@ static const struct address_space_operations btrfs_aops = {
 	.writepages	= btrfs_writepages,
 	.readahead	= btrfs_readahead,
 	.direct_IO	= noop_direct_IO,
-	.invalidatepage = btrfs_invalidatepage,
+	.invalidate_folio = btrfs_invalidate_folio,
 	.releasepage	= btrfs_releasepage,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= btrfs_migratepage,
-- 
2.34.1

