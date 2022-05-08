Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4111D51F179
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiEHUhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiEHUgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CDD11A1C
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b8Ms2jTD60djrFtK62U4wknJ2hucyHb+oNSlDVGChYs=; b=bowWoLvvRv737IsBpqtqTXReG0
        PZ27UPsAFzKa6WzhiaqOoWHsfyQGWopmaOWo4ZpQssZDzjUGPIiqWilbRuKx+ixMcafkwQ4/0VsyY
        zec2G6xChTjVV+FLUU5YvRw+dxWh15EZVBd4ZABYUJkxlCiq8oYw5cXV5Jqio2A0SGdtzSfPNGoVH
        1CaPhov8Yf/42TQWDbqPzJI045AWVwMWcYihpDDsUi0IBWTrZtIx+nDAFL6xZCGlzgEkAzpJLJOW+
        8TRcF9c+vh0VyOcBoP9n23xirK+/bEpLHwxvKgisTxQ/bfh67DLazFiD54Rx1GTJwqOYN6nLWdgKo
        jM3Alvsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaD-002o16-EV; Sun, 08 May 2022 20:32:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 05/26] btrfs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:26 +0100
Message-Id: <20220508203247.668791-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
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

I've only converted the outer layers of the btrfs release_folio paths
to use folios; the use of folios should be pushed further down into
btrfs from here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/disk-io.c   | 12 ++++++------
 fs/btrfs/extent_io.c | 14 +++++++-------
 fs/btrfs/file.c      |  2 +-
 fs/btrfs/inode.c     | 24 ++++++++++++------------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 31c3f592e587..c281b044a409 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1005,12 +1005,12 @@ static int btree_writepages(struct address_space *mapping,
 	return btree_write_cache_pages(mapping, wbc);
 }
 
-static int btree_releasepage(struct page *page, gfp_t gfp_flags)
+static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
-	if (PageWriteback(page) || PageDirty(page))
-		return 0;
+	if (folio_test_writeback(folio) || folio_test_dirty(folio))
+		return false;
 
-	return try_release_extent_buffer(page);
+	return try_release_extent_buffer(&folio->page);
 }
 
 static void btree_invalidate_folio(struct folio *folio, size_t offset,
@@ -1019,7 +1019,7 @@ static void btree_invalidate_folio(struct folio *folio, size_t offset,
 	struct extent_io_tree *tree;
 	tree = &BTRFS_I(folio->mapping->host)->io_tree;
 	extent_invalidate_folio(tree, folio, offset);
-	btree_releasepage(&folio->page, GFP_NOFS);
+	btree_release_folio(folio, GFP_NOFS);
 	if (folio_get_private(folio)) {
 		btrfs_warn(BTRFS_I(folio->mapping->host)->root->fs_info,
 			   "folio private not zero on folio %llu",
@@ -1080,7 +1080,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
 
 static const struct address_space_operations btree_aops = {
 	.writepages	= btree_writepages,
-	.releasepage	= btree_releasepage,
+	.release_folio	= btree_release_folio,
 	.invalidate_folio = btree_invalidate_folio,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= btree_migratepage,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 33c19f51d79b..e7a6e8757859 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5271,7 +5271,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 }
 
 /*
- * a helper for releasepage, this tests for areas of the page that
+ * a helper for release_folio, this tests for areas of the page that
  * are locked or under IO and drops the related state bits if it is safe
  * to drop the page.
  */
@@ -5307,7 +5307,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 }
 
 /*
- * a helper for releasepage.  As long as there are no locked extents
+ * a helper for release_folio.  As long as there are no locked extents
  * in the range corresponding to the page, both state records and extent
  * map records are removed
  */
@@ -6001,10 +6001,10 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
 	 *
 	 * It is only cleared in two cases: freeing the last non-tree
 	 * reference to the extent_buffer when its STALE bit is set or
-	 * calling releasepage when the tree reference is the only reference.
+	 * calling release_folio when the tree reference is the only reference.
 	 *
 	 * In both cases, care is taken to ensure that the extent_buffer's
-	 * pages are not under io. However, releasepage can be concurrently
+	 * pages are not under io. However, release_folio can be concurrently
 	 * called with creating new references, which is prone to race
 	 * conditions between the calls to check_buffer_tree_ref in those
 	 * codepaths and clearing TREE_REF in try_release_extent_buffer.
@@ -6257,7 +6257,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		/*
 		 * We can't unlock the pages just yet since the extent buffer
 		 * hasn't been properly inserted in the radix tree, this
-		 * opens a race with btree_releasepage which can free a page
+		 * opens a race with btree_release_folio which can free a page
 		 * while we are still filling in all pages for the buffer and
 		 * we could crash.
 		 */
@@ -6289,7 +6289,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	/*
 	 * Now it's safe to unlock the pages because any calls to
-	 * btree_releasepage will correctly detect that a page belongs to a
+	 * btree_release_folio will correctly detect that a page belongs to a
 	 * live buffer and won't free them prematurely.
 	 */
 	for (i = 0; i < num_pages; i++)
@@ -6659,7 +6659,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	eb->read_mirror = 0;
 	atomic_set(&eb->io_pages, num_reads);
 	/*
-	 * It is possible for releasepage to clear the TREE_REF bit before we
+	 * It is possible for release_folio to clear the TREE_REF bit before we
 	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
 	 */
 	check_buffer_tree_ref(eb);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 57fba5abb059..c1eadb3f715c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1323,7 +1323,7 @@ static int prepare_uptodate_page(struct inode *inode,
 
 		/*
 		 * Since btrfs_read_folio() will unlock the folio before it
-		 * returns, there is a window where btrfs_releasepage() can be
+		 * returns, there is a window where btrfs_release_folio() can be
 		 * called to release the page.  Here we check both inode
 		 * mapping and PagePrivate() to make sure the page was not
 		 * released.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9a2530b1695d..1e52710babb4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8172,7 +8172,7 @@ static void btrfs_readahead(struct readahead_control *rac)
 }
 
 /*
- * For releasepage() and invalidate_folio() we have a race window where
+ * For release_folio() and invalidate_folio() we have a race window where
  * folio_end_writeback() is called but the subpage spinlock is not yet released.
  * If we continue to release/invalidate the page, we could cause use-after-free
  * for subpage spinlock.  So this function is to spin and wait for subpage
@@ -8204,22 +8204,22 @@ static void wait_subpage_spinlock(struct page *page)
 	spin_unlock_irq(&subpage->lock);
 }
 
-static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
+static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
-	int ret = try_release_extent_mapping(page, gfp_flags);
+	int ret = try_release_extent_mapping(&folio->page, gfp_flags);
 
 	if (ret == 1) {
-		wait_subpage_spinlock(page);
-		clear_page_extent_mapped(page);
+		wait_subpage_spinlock(&folio->page);
+		clear_page_extent_mapped(&folio->page);
 	}
 	return ret;
 }
 
-static int btrfs_releasepage(struct page *page, gfp_t gfp_flags)
+static bool btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
-	if (PageWriteback(page) || PageDirty(page))
-		return 0;
-	return __btrfs_releasepage(page, gfp_flags);
+	if (folio_test_writeback(folio) || folio_test_dirty(folio))
+		return false;
+	return __btrfs_release_folio(folio, gfp_flags);
 }
 
 #ifdef CONFIG_MIGRATION
@@ -8290,7 +8290,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	 * still safe to wait for ordered extent to finish.
 	 */
 	if (!(offset == 0 && length == folio_size(folio))) {
-		btrfs_releasepage(&folio->page, GFP_NOFS);
+		btrfs_release_folio(folio, GFP_NOFS);
 		return;
 	}
 
@@ -8414,7 +8414,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	ASSERT(!folio_test_ordered(folio));
 	btrfs_page_clear_checked(fs_info, &folio->page, folio_pos(folio), folio_size(folio));
 	if (!inode_evicting)
-		__btrfs_releasepage(&folio->page, GFP_NOFS);
+		__btrfs_release_folio(folio, GFP_NOFS);
 	clear_page_extent_mapped(&folio->page);
 }
 
@@ -11364,7 +11364,7 @@ static const struct address_space_operations btrfs_aops = {
 	.readahead	= btrfs_readahead,
 	.direct_IO	= noop_direct_IO,
 	.invalidate_folio = btrfs_invalidate_folio,
-	.releasepage	= btrfs_releasepage,
+	.release_folio	= btrfs_release_folio,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= btrfs_migratepage,
 #endif
-- 
2.34.1

