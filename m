Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D52A51F181
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiEHUiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiEHUhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E411C3E
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kaoX3/GqpsxJuMhEFBRUZ31Al4ecsai0dchaoELzfbY=; b=hEwc7UR9TuhM/daP8yJfn41uYo
        azOGHYbe9zlHmbmPgkOsuuGyYJVydn4YMVlECplUIPmwjJVB/NyY7+JWcyadxRcD/Se2+etve6zgv
        HfgnMLYiSu8iSm+FedtPx7vCMPgQjauuJIqSreMa77bUf2dPV2R2qQJmmvV8UIV0PxFaVeDLfLFkl
        99uspxVJWhuzycSIaRfBQdpAMO8vHLfUIsy8Wvlm6wSIc/UjWpJJTxVY2mq4FyXygF7nd3q94yvL4
        mcz3ykzYHGSd0tABHo4LsnwD/9gS/hnFU1TXHo48vC8vO136PmMu0fByARdhPEXVcZJVz5/WTmzab
        TEZVecYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaG-002o39-36; Sun, 08 May 2022 20:32:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 25/26] fs: Change try_to_free_buffers() to take a folio
Date:   Sun,  8 May 2022 21:32:46 +0100
Message-Id: <20220508203247.668791-26-willy@infradead.org>
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

All but two of the callers already have a folio; pass a folio into
try_to_free_buffers().  This removes the last user of cancel_dirty_page()
so remove that wrapper function too.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 42 ++++++++++++++++++-------------------
 fs/ext4/inode.c             |  2 +-
 fs/gfs2/aops.c              |  2 +-
 fs/hfs/inode.c              |  2 +-
 fs/hfsplus/inode.c          |  2 +-
 fs/jbd2/commit.c            |  2 +-
 fs/jbd2/transaction.c       |  4 ++--
 fs/mpage.c                  |  2 +-
 fs/ocfs2/aops.c             |  2 +-
 fs/reiserfs/inode.c         |  2 +-
 fs/reiserfs/journal.c       |  2 +-
 include/linux/buffer_head.h |  4 ++--
 include/linux/pagemap.h     |  4 ----
 mm/filemap.c                |  2 +-
 mm/migrate.c                |  2 +-
 mm/vmscan.c                 |  2 +-
 16 files changed, 37 insertions(+), 41 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 786ef5b98c80..701af0035802 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -955,7 +955,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 						size);
 			goto done;
 		}
-		if (!try_to_free_buffers(page))
+		if (!try_to_free_buffers(page_folio(page)))
 			goto failed;
 	}
 
@@ -3155,20 +3155,20 @@ int sync_dirty_buffer(struct buffer_head *bh)
 EXPORT_SYMBOL(sync_dirty_buffer);
 
 /*
- * try_to_free_buffers() checks if all the buffers on this particular page
+ * try_to_free_buffers() checks if all the buffers on this particular folio
  * are unused, and releases them if so.
  *
  * Exclusion against try_to_free_buffers may be obtained by either
- * locking the page or by holding its mapping's private_lock.
+ * locking the folio or by holding its mapping's private_lock.
  *
- * If the page is dirty but all the buffers are clean then we need to
- * be sure to mark the page clean as well.  This is because the page
+ * If the folio is dirty but all the buffers are clean then we need to
+ * be sure to mark the folio clean as well.  This is because the folio
  * may be against a block device, and a later reattachment of buffers
- * to a dirty page will set *all* buffers dirty.  Which would corrupt
+ * to a dirty folio will set *all* buffers dirty.  Which would corrupt
  * filesystem data on the same device.
  *
- * The same applies to regular filesystem pages: if all the buffers are
- * clean then we set the page clean and proceed.  To do that, we require
+ * The same applies to regular filesystem folios: if all the buffers are
+ * clean then we set the folio clean and proceed.  To do that, we require
  * total exclusion from block_dirty_folio().  That is obtained with
  * private_lock.
  *
@@ -3207,40 +3207,40 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 	return 0;
 }
 
-int try_to_free_buffers(struct page *page)
+bool try_to_free_buffers(struct folio *folio)
 {
-	struct address_space * const mapping = page->mapping;
+	struct address_space * const mapping = folio->mapping;
 	struct buffer_head *buffers_to_free = NULL;
-	int ret = 0;
+	bool ret = 0;
 
-	BUG_ON(!PageLocked(page));
-	if (PageWriteback(page))
-		return 0;
+	BUG_ON(!folio_test_locked(folio));
+	if (folio_test_writeback(folio))
+		return false;
 
 	if (mapping == NULL) {		/* can this still happen? */
-		ret = drop_buffers(page, &buffers_to_free);
+		ret = drop_buffers(&folio->page, &buffers_to_free);
 		goto out;
 	}
 
 	spin_lock(&mapping->private_lock);
-	ret = drop_buffers(page, &buffers_to_free);
+	ret = drop_buffers(&folio->page, &buffers_to_free);
 
 	/*
 	 * If the filesystem writes its buffers by hand (eg ext3)
-	 * then we can have clean buffers against a dirty page.  We
-	 * clean the page here; otherwise the VM will never notice
+	 * then we can have clean buffers against a dirty folio.  We
+	 * clean the folio here; otherwise the VM will never notice
 	 * that the filesystem did any IO at all.
 	 *
 	 * Also, during truncate, discard_buffer will have marked all
-	 * the page's buffers clean.  We discover that here and clean
-	 * the page also.
+	 * the folio's buffers clean.  We discover that here and clean
+	 * the folio also.
 	 *
 	 * private_lock must be held over this entire operation in order
 	 * to synchronise against block_dirty_folio and prevent the
 	 * dirty bit from being lost.
 	 */
 	if (ret)
-		cancel_dirty_page(page);
+		folio_cancel_dirty(folio);
 	spin_unlock(&mapping->private_lock);
 out:
 	if (buffers_to_free) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 943937cb5302..987ea77e672d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3255,7 +3255,7 @@ static bool ext4_release_folio(struct folio *folio, gfp_t wait)
 	if (journal)
 		return jbd2_journal_try_to_free_buffers(journal, folio);
 	else
-		return try_to_free_buffers(&folio->page);
+		return try_to_free_buffers(folio);
 }
 
 static bool ext4_inode_datasync_dirty(struct inode *inode)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 95a674d70c04..106e90a36583 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -757,7 +757,7 @@ bool gfs2_release_folio(struct folio *folio, gfp_t gfp_mask)
 	} while (bh != head);
 	gfs2_log_unlock(sdp);
 
-	return try_to_free_buffers(&folio->page);
+	return try_to_free_buffers(folio);
 
 cannot_release:
 	gfs2_log_unlock(sdp);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 86fd50e5fccb..c4526f16355d 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -124,7 +124,7 @@ static bool hfs_release_folio(struct folio *folio, gfp_t mask)
 		} while (--i && nidx < tree->node_count);
 		spin_unlock(&tree->hash_lock);
 	}
-	return res ? try_to_free_buffers(&folio->page) : false;
+	return res ? try_to_free_buffers(folio) : false;
 }
 
 static ssize_t hfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index f723e0e91d51..aeab83ed1c9c 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -121,7 +121,7 @@ static bool hfsplus_release_folio(struct folio *folio, gfp_t mask)
 		} while (--i && nidx < tree->node_count);
 		spin_unlock(&tree->hash_lock);
 	}
-	return res ? try_to_free_buffers(&folio->page) : false;
+	return res ? try_to_free_buffers(folio) : false;
 }
 
 static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 2f37108da0ec..eb315e81f1a6 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -82,7 +82,7 @@ static void release_buffer_page(struct buffer_head *bh)
 
 	folio_get(folio);
 	__brelse(bh);
-	try_to_free_buffers(&folio->page);
+	try_to_free_buffers(folio);
 	folio_unlock(folio);
 	folio_put(folio);
 	return;
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index ee33d277d51e..e49bb0938376 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2175,7 +2175,7 @@ bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio)
 			goto busy;
 	} while ((bh = bh->b_this_page) != head);
 
-	ret = try_to_free_buffers(&folio->page);
+	ret = try_to_free_buffers(folio);
 busy:
 	return ret;
 }
@@ -2482,7 +2482,7 @@ int jbd2_journal_invalidate_folio(journal_t *journal, struct folio *folio,
 	} while (bh != head);
 
 	if (!partial_page) {
-		if (may_free && try_to_free_buffers(&folio->page))
+		if (may_free && try_to_free_buffers(folio))
 			J_ASSERT(!folio_buffers(folio));
 	}
 	return 0;
diff --git a/fs/mpage.c b/fs/mpage.c
index 6df9c3aa5728..0d25f44f5707 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -431,7 +431,7 @@ static void clean_buffers(struct page *page, unsigned first_unmapped)
 	 * disk before we reach the platter.
 	 */
 	if (buffer_heads_over_limit && PageUptodate(page))
-		try_to_free_buffers(page);
+		try_to_free_buffers(page_folio(page));
 }
 
 /*
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 7d7b86ca078f..35d40a67204c 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -502,7 +502,7 @@ static bool ocfs2_release_folio(struct folio *folio, gfp_t wait)
 {
 	if (!folio_buffers(folio))
 		return false;
-	return try_to_free_buffers(&folio->page);
+	return try_to_free_buffers(folio);
 }
 
 static void ocfs2_figure_cluster_boundaries(struct ocfs2_super *osb,
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 9cf2e1420a74..0cffe054b78e 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3234,7 +3234,7 @@ static bool reiserfs_release_folio(struct folio *folio, gfp_t unused_gfp_flags)
 		bh = bh->b_this_page;
 	} while (bh != head);
 	if (ret)
-		ret = try_to_free_buffers(&folio->page);
+		ret = try_to_free_buffers(folio);
 	spin_unlock(&j->j_dirty_buffers_lock);
 	return ret;
 }
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 99ba495b0f28..d8cc9a366124 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -606,7 +606,7 @@ static void release_buffer_page(struct buffer_head *bh)
 		folio_get(folio);
 		put_bh(bh);
 		if (!folio->mapping)
-			try_to_free_buffers(&folio->page);
+			try_to_free_buffers(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 	} else {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 31d82fd9abe8..c9d1463bb20f 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -158,7 +158,7 @@ void mark_buffer_write_io_error(struct buffer_head *bh);
 void touch_buffer(struct buffer_head *bh);
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset);
-int try_to_free_buffers(struct page *);
+bool try_to_free_buffers(struct folio *);
 struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
 void create_empty_buffers(struct page *, unsigned long,
@@ -402,7 +402,7 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio);
 #else /* CONFIG_BLOCK */
 
 static inline void buffer_init(void) {}
-static inline int try_to_free_buffers(struct page *page) { return 1; }
+static inline bool try_to_free_buffers(struct folio *folio) { return true; }
 static inline int inode_has_buffers(struct inode *inode) { return 0; }
 static inline void invalidate_inode_buffers(struct inode *inode) {}
 static inline int remove_inode_buffers(struct inode *inode) { return 1; }
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 831b28dab01a..82dfb279e0c4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1067,10 +1067,6 @@ static inline void folio_cancel_dirty(struct folio *folio)
 	if (folio_test_dirty(folio))
 		__folio_cancel_dirty(folio);
 }
-static inline void cancel_dirty_page(struct page *page)
-{
-	folio_cancel_dirty(page_folio(page));
-}
 bool folio_clear_dirty_for_io(struct folio *folio);
 bool clear_page_dirty_for_io(struct page *page);
 void folio_invalidate(struct folio *folio, size_t offset, size_t length);
diff --git a/mm/filemap.c b/mm/filemap.c
index ee892853a214..d335a154a0d9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3957,6 +3957,6 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 
 	if (mapping && mapping->a_ops->release_folio)
 		return mapping->a_ops->release_folio(folio, gfp);
-	return try_to_free_buffers(&folio->page);
+	return try_to_free_buffers(folio);
 }
 EXPORT_SYMBOL(filemap_release_folio);
diff --git a/mm/migrate.c b/mm/migrate.c
index 6c31ee1e1c9b..21d82636c291 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1013,7 +1013,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	if (!page->mapping) {
 		VM_BUG_ON_PAGE(PageAnon(page), page);
 		if (page_has_private(page)) {
-			try_to_free_buffers(page);
+			try_to_free_buffers(folio);
 			goto out_unlock_both;
 		}
 	} else if (page_mapped(page)) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 27851232e00c..f3f7ce2c4068 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1181,7 +1181,7 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping)
 		 * folio->mapping == NULL while being dirty with clean buffers.
 		 */
 		if (folio_test_private(folio)) {
-			if (try_to_free_buffers(&folio->page)) {
+			if (try_to_free_buffers(folio)) {
 				folio_clear_dirty(folio);
 				pr_info("%s: orphaned folio\n", __func__);
 				return PAGE_CLEAN;
-- 
2.34.1

