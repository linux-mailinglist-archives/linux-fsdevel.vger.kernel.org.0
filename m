Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59F3373F6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhEEQUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhEEQUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:20:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD066C061574;
        Wed,  5 May 2021 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RGV/wQGYZ6z4ckF/9RIk4SOOFmLWiKj+KDjkdL5veZQ=; b=PBisYtI53x52RLtLqHw6+faC52
        cdsc/jBI9B6lGehrLRWrpCG7Tu/bXiouvupOXk1zNCG6ibVAenM5iLwifA5mi97WeXYs7wCwEiOha
        Ui2STGeaq8P86Z5mzEVhkckeVeZCitFQ2Hn8qwjseggPeE4Cg0kICj0YVQY+f9UutLDWjWoL1vowc
        3UujE0gMGWPKT7LD89qrFT519ceb5/PYkKmXN8w7sSt9AfL7YdWZoTJKvYYD1//CPlWqIDSJjTxYy
        kB1TKOrKtISbcqYIKf9+Al7ke46IACaktSCxV/wAOHJpDV3sZtO7I/DsTeqCttt15vV/jvLmVGwv/
        8xQUqX8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKDF-000ZrX-3W; Wed, 05 May 2021 16:17:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 61/96] mm/writeback: Add __folio_mark_dirty
Date:   Wed,  5 May 2021 16:05:53 +0100
Message-Id: <20210505150628.111735-62-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn __set_page_dirty() into a wrapper around __folio_mark_dirty() (which
can directly cast from page to folio because we know that set_page_dirty()
calls filesystems with the head page).  Convert account_page_dirtied()
into folio_account_dirtied() and account the number of pages in the folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h |  5 ++--
 include/linux/mm.h         |  1 -
 include/linux/pagemap.h    |  6 +++++
 mm/page-writeback.c        | 47 +++++++++++++++++++-------------------
 4 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c77561311199..c690a1f19d20 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1625,10 +1625,9 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 					     struct bdi_writeback *wb);
 
-static inline void mem_cgroup_track_foreign_dirty(struct page *page,
+static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
 						  struct bdi_writeback *wb)
 {
-	struct folio *folio = page_folio(page);
 	if (mem_cgroup_disabled())
 		return;
 
@@ -1653,7 +1652,7 @@ static inline void mem_cgroup_wb_stats(struct bdi_writeback *wb,
 {
 }
 
-static inline void mem_cgroup_track_foreign_dirty(struct page *page,
+static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
 						  struct bdi_writeback *wb)
 {
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8970ea86a5e2..59655bde6c32 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1990,7 +1990,6 @@ extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
 extern void do_invalidatepage(struct page *page, unsigned int offset,
 			      unsigned int length);
 
-void __set_page_dirty(struct page *, struct address_space *, int warn);
 int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
 int redirty_page_for_writepage(struct writeback_control *wbc,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f6a03fd68ac8..84f0a823820b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -834,6 +834,12 @@ void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
 void folio_wait_stable(struct folio *folio);
+void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
+static inline void __set_page_dirty(struct page *page,
+		struct address_space *mapping, int warn)
+{
+	__folio_mark_dirty((struct folio *)page, mapping, warn);
+}
 
 void page_endio(struct page *page, bool is_write, int err);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 534b9ef5dcd7..88f6734706c9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2417,29 +2417,30 @@ int __set_page_dirty_no_writeback(struct page *page)
  *
  * NOTE: This relies on being atomic wrt interrupts.
  */
-static void account_page_dirtied(struct page *page,
+static void folio_account_dirtied(struct folio *folio,
 		struct address_space *mapping)
 {
 	struct inode *inode = mapping->host;
 
-	trace_writeback_dirty_page(page, mapping);
+	trace_writeback_dirty_page(&folio->page, mapping);
 
 	if (mapping_can_writeback(mapping)) {
 		struct bdi_writeback *wb;
+		long nr = folio_nr_pages(folio);
 
-		inode_attach_wb(inode, page);
+		inode_attach_wb(inode, &folio->page);
 		wb = inode_to_wb(inode);
 
-		__inc_lruvec_page_state(page, NR_FILE_DIRTY);
-		__inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-		__inc_node_page_state(page, NR_DIRTIED);
-		inc_wb_stat(wb, WB_RECLAIMABLE);
-		inc_wb_stat(wb, WB_DIRTIED);
-		task_io_account_write(PAGE_SIZE);
-		current->nr_dirtied++;
-		this_cpu_inc(bdp_ratelimits);
+		__lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
+		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
+		__node_stat_mod_folio(folio, NR_DIRTIED, nr);
+		wb_stat_mod(wb, WB_RECLAIMABLE, nr);
+		wb_stat_mod(wb, WB_DIRTIED, nr);
+		task_io_account_write(nr * PAGE_SIZE);
+		current->nr_dirtied += nr;
+		this_cpu_add(bdp_ratelimits, nr);
 
-		mem_cgroup_track_foreign_dirty(page, wb);
+		mem_cgroup_track_foreign_dirty(folio, wb);
 	}
 }
 
@@ -2460,33 +2461,33 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
 }
 
 /*
- * Mark the page dirty, and set it dirty in the page cache, and mark the inode
- * dirty.
+ * Mark the folio dirty, and set it dirty in the page cache, and mark
+ * the inode dirty.
  *
- * If warn is true, then emit a warning if the page is not uptodate and has
+ * If warn is true, then emit a warning if the folio is not uptodate and has
  * not been truncated.
  *
- * The caller must hold lock_page_memcg().  Most callers have the page
- * locked.  A few have the page blocked from truncation through other
+ * The caller must hold lock_page_memcg().  Most callers have the folio
+ * locked.  A few have the folio blocked from truncation through other
  * means (eg zap_page_range() has it mapped and is holding the page table
  * lock).  This can also be called from mark_buffer_dirty(), which I
  * cannot prove is always protected against truncate.
  */
-void __set_page_dirty(struct page *page, struct address_space *mapping,
+void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 			     int warn)
 {
 	unsigned long flags;
 
 	xa_lock_irqsave(&mapping->i_pages, flags);
-	if (page->mapping) {	/* Race with truncate? */
-		WARN_ON_ONCE(warn && !PageUptodate(page));
-		account_page_dirtied(page, mapping);
-		__xa_set_mark(&mapping->i_pages, page_index(page),
+	if (folio->mapping) {	/* Race with truncate? */
+		WARN_ON_ONCE(warn && !folio_uptodate(folio));
+		folio_account_dirtied(folio, mapping);
+		__xa_set_mark(&mapping->i_pages, folio_index(folio),
 				PAGECACHE_TAG_DIRTY);
 	}
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
-EXPORT_SYMBOL_GPL(__set_page_dirty);
+EXPORT_SYMBOL_GPL(__folio_mark_dirty);
 
 /*
  * For address_spaces which do not use buffers.  Just tag the page as dirty in
-- 
2.30.2

