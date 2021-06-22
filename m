Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168D93B04DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhFVMoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhFVMnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:43:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20FDC0611BD;
        Tue, 22 Jun 2021 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SByzKLCr2HAyIscQwMr6ipDt63UoKindwsMjYOw8DUg=; b=XyPp5zDsBBRoirvaEO5l36WAvv
        2Wwak7yZS/82y0EJEXmhrExylGeWJcUivR5zCRa1lRfS47i0ZSFyJ0GV5QOafZKARE/VToGEShcvR
        iEmeO5zNgj+cOUkkqtVv48Z2dC+y2VkN8SNUdJKIg0MKFSwdzUljeUZtwTrL5ulse4DGlljRNiSXj
        8BS1ZuLdgyEp8aLG4EVcYgs1NdcdKzuCEsMjinXryJUg2+FBTLdfaScQGlVvCwbztmFRU0Qih6BKF
        q4scddPYHU/5FoaZhxqLjm0N0/MShCqUTYFN6O0ilA86KS6lHSbSNpz7CGTke78VVq/0/9AIqXhTh
        Zsg8Z7UA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvffW-00EHqm-M6; Tue, 22 Jun 2021 12:38:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/46] mm/writeback: Add __folio_mark_dirty()
Date:   Tue, 22 Jun 2021 13:15:32 +0100
Message-Id: <20210622121551.3398730-28-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
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
 include/linux/memcontrol.h |  5 ++---
 include/linux/pagemap.h    |  7 ++++++-
 mm/page-writeback.c        | 41 +++++++++++++++++++-------------------
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 00693cb48b5d..f9f05724db3b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1638,10 +1638,9 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 					     struct bdi_writeback *wb);
 
-static inline void mem_cgroup_track_foreign_dirty(struct page *page,
+static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
 						  struct bdi_writeback *wb)
 {
-	struct folio *folio = page_folio(page);
 	if (mem_cgroup_disabled())
 		return;
 
@@ -1666,7 +1665,7 @@ static inline void mem_cgroup_wb_stats(struct bdi_writeback *wb,
 {
 }
 
-static inline void mem_cgroup_track_foreign_dirty(struct page *page,
+static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
 						  struct bdi_writeback *wb)
 {
 }
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 22d756d56404..e6a9756293aa 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -772,8 +772,13 @@ void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
 void folio_wait_stable(struct folio *folio);
+void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
+static inline void __set_page_dirty(struct page *page,
+		struct address_space *mapping, int warn)
+{
+	__folio_mark_dirty((struct folio *)page, mapping, warn);
+}
 
-void __set_page_dirty(struct page *, struct address_space *, int warn);
 int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 73b937955cc1..a7989870b171 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2417,29 +2417,30 @@ EXPORT_SYMBOL(__set_page_dirty_no_writeback);
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
+		__this_cpu_add(bdp_ratelimits, nr);
 
-		mem_cgroup_track_foreign_dirty(page, wb);
+		mem_cgroup_track_foreign_dirty(folio, wb);
 	}
 }
 
@@ -2460,24 +2461,24 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
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
  * The caller must hold lock_page_memcg().
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
-- 
2.30.2

