Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7883CADCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbhGOUYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhGOUYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:24:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E224AC061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=joBUV28Urnk2XnLKXCBtmxg7bVEhi6265j8u9WsSAaA=; b=gbo46LP5lwjcbclDhyLByYlxwI
        LZzMNQfze5mwZuVqgUatjp5+N3DtHgFAAOJJqhD/T0lU5+zAbjyP8V6e9gtfKeAEPAFf7PH9eDddR
        vzzXm4wfm/NxIGpNAbNw6kU2fS4sRimRGDXx2FzyTQYoQQgEQDs4p9LihEKzpQvVgRLVdgQNyvn3s
        Bx0Cvi9jGCPiAEy7MADE0ODV0arXKImTY1gFVCIlKhGyfts5xz2m5vIvLCu6s+4H16SYzOA8sNhXc
        3KvSMD9V3PC53cFgMoqbUVxlGJbVgy/tu+5KrKqa3ZKQ8uWIB/im6BEknmj5JV7G1I/fdu0KUDfNi
        GLuFaHKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47pW-003oaz-Lg; Thu, 15 Jul 2021 20:19:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v14 19/39] mm/writeback: Add __folio_mark_dirty()
Date:   Thu, 15 Jul 2021 21:00:10 +0100
Message-Id: <20210715200030.899216-20-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn __set_page_dirty() into a wrapper around __folio_mark_dirty().
Convert account_page_dirtied() into folio_account_dirtied() and account
the number of pages in the folio to support multi-page folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h |  5 ++---
 include/linux/pagemap.h    |  7 ++++++-
 mm/page-writeback.c        | 41 +++++++++++++++++++-------------------
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2dd660185bb3..c20adc22ea24 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1574,10 +1574,9 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 					     struct bdi_writeback *wb);
 
-static inline void mem_cgroup_track_foreign_dirty(struct page *page,
+static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
 						  struct bdi_writeback *wb)
 {
-	struct folio *folio = page_folio(page);
 	if (mem_cgroup_disabled())
 		return;
 
@@ -1602,7 +1601,7 @@ static inline void mem_cgroup_wb_stats(struct bdi_writeback *wb,
 {
 }
 
-static inline void mem_cgroup_track_foreign_dirty(struct page *page,
+static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
 						  struct bdi_writeback *wb)
 {
 }
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 08f40e004d97..3d88c17fedc9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -773,8 +773,13 @@ void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
 void folio_wait_stable(struct folio *folio);
+void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
+static inline void __set_page_dirty(struct page *page,
+		struct address_space *mapping, int warn)
+{
+	__folio_mark_dirty(page_folio(page), mapping, warn);
+}
 
-void __set_page_dirty(struct page *, struct address_space *, int warn);
 int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d7c0cad6a57f..3e02c86eb445 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2421,29 +2421,30 @@ EXPORT_SYMBOL(__set_page_dirty_no_writeback);
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
-		__this_cpu_inc(bdp_ratelimits);
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
 
@@ -2464,24 +2465,24 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
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
+		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
+		folio_account_dirtied(folio, mapping);
+		__xa_set_mark(&mapping->i_pages, folio_index(folio),
 				PAGECACHE_TAG_DIRTY);
 	}
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
-- 
2.30.2

