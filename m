Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3D3B0506
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhFVMqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhFVMqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:46:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85097C06175F;
        Tue, 22 Jun 2021 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XBbql5AE8eFqw84P22f9OWAThdbyeCvQbLJDoygxmcs=; b=EQ1R/cqBLCYcYlfSWK3Gig5sLh
        CPbS36nwh9yeqACb9FcyqGQynWoyvpfYnBpYqawO5NUDSqJdHhoRnyy0IhDG8WS4v2T50R/11c6Y5
        RorkNW0gMD54Ky5dov1iIGrT+j6ym4UDTlw26ZOgP+8fB16CbrDXRPtQefg70GknkmcTXL9Hjzxeh
        VuXOQg+VxFQWxRmWDjMrPmtJqhaSYY5SCHSutMeuGnCB+fHfbZblul6R/4nvrUzzIucgndsGs8bK7
        KsJ74qxt4aOW3C8a85/LPpWhlzUsl58a6f1Rp9IVxJgX4u6Lo/Ly8ZIn02eHG4mo0UmO5Owydnst9
        ZtOTbpJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfin-00EI76-3l; Tue, 22 Jun 2021 12:41:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/46] mm/writeback: Add folio_clear_dirty_for_io()
Date:   Tue, 22 Jun 2021 13:15:36 +0100
Message-Id: <20210622121551.3398730-32-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Transform clear_page_dirty_for_io() into folio_clear_dirty_for_io()
and add a compatibility wrapper.  Also move the declaration to pagemap.h
as this is page cache functionality that doesn't need to be used by the
rest of the kernel.

Increases the size of the kernel by 79 bytes.  While we remove a few
calls to compound_head(), we add a call to folio_nr_pages() to get the
stats correct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      |  1 -
 include/linux/pagemap.h |  2 ++
 mm/folio-compat.c       |  6 ++++
 mm/page-writeback.c     | 63 +++++++++++++++++++++--------------------
 4 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f0b0779c75cd..dce7593de256 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1988,7 +1988,6 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
 bool folio_mark_dirty(struct folio *folio);
 bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
-int clear_page_dirty_for_io(struct page *page);
 
 int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1dc8ab5651c3..31edfa891987 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -796,6 +796,8 @@ static inline void cancel_dirty_page(struct page *page)
 {
 	folio_cancel_dirty(page_folio(page));
 }
+bool folio_clear_dirty_for_io(struct folio *folio);
+bool clear_page_dirty_for_io(struct page *page);
 
 int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 60780ceca363..bdd2cee01e4c 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -95,3 +95,9 @@ bool set_page_dirty(struct page *page)
 	return folio_mark_dirty(page_folio(page));
 }
 EXPORT_SYMBOL(set_page_dirty);
+
+bool clear_page_dirty_for_io(struct page *page)
+{
+	return folio_clear_dirty_for_io(page_folio(page));
+}
+EXPORT_SYMBOL(clear_page_dirty_for_io);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a508c5629c15..5fc1137d2c86 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2666,25 +2666,25 @@ void __folio_cancel_dirty(struct folio *folio)
 EXPORT_SYMBOL(__folio_cancel_dirty);
 
 /*
- * Clear a page's dirty flag, while caring for dirty memory accounting.
- * Returns true if the page was previously dirty.
- *
- * This is for preparing to put the page under writeout.  We leave the page
- * tagged as dirty in the xarray so that a concurrent write-for-sync
- * can discover it via a PAGECACHE_TAG_DIRTY walk.  The ->writepage
- * implementation will run either set_page_writeback() or set_page_dirty(),
- * at which stage we bring the page's dirty flag and xarray dirty tag
- * back into sync.
- *
- * This incoherency between the page's dirty flag and xarray tag is
- * unfortunate, but it only exists while the page is locked.
+ * Clear a folio's dirty flag, while caring for dirty memory accounting.
+ * Returns true if the folio was previously dirty.
+ *
+ * This is for preparing to put the folio under writeout.  We leave
+ * the folio tagged as dirty in the xarray so that a concurrent
+ * write-for-sync can discover it via a PAGECACHE_TAG_DIRTY walk.
+ * The ->writepage implementation will run either folio_start_writeback()
+ * or folio_mark_dirty(), at which stage we bring the folio's dirty flag
+ * and xarray dirty tag back into sync.
+ *
+ * This incoherency between the folio's dirty flag and xarray tag is
+ * unfortunate, but it only exists while the folio is locked.
  */
-int clear_page_dirty_for_io(struct page *page)
+bool folio_clear_dirty_for_io(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping(page);
-	int ret = 0;
+	struct address_space *mapping = folio_mapping(folio);
+	bool ret = false;
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_FOLIO(!folio_locked(folio), folio);
 
 	if (mapping && mapping_can_writeback(mapping)) {
 		struct inode *inode = mapping->host;
@@ -2697,48 +2697,49 @@ int clear_page_dirty_for_io(struct page *page)
 		 * We use this sequence to make sure that
 		 *  (a) we account for dirty stats properly
 		 *  (b) we tell the low-level filesystem to
-		 *      mark the whole page dirty if it was
+		 *      mark the whole folio dirty if it was
 		 *      dirty in a pagetable. Only to then
-		 *  (c) clean the page again and return 1 to
+		 *  (c) clean the folio again and return 1 to
 		 *      cause the writeback.
 		 *
 		 * This way we avoid all nasty races with the
 		 * dirty bit in multiple places and clearing
 		 * them concurrently from different threads.
 		 *
-		 * Note! Normally the "set_page_dirty(page)"
+		 * Note! Normally the "folio_mark_dirty(folio)"
 		 * has no effect on the actual dirty bit - since
 		 * that will already usually be set. But we
 		 * need the side effects, and it can help us
 		 * avoid races.
 		 *
-		 * We basically use the page "master dirty bit"
+		 * We basically use the folio "master dirty bit"
 		 * as a serialization point for all the different
 		 * threads doing their things.
 		 */
-		if (page_mkclean(page))
-			set_page_dirty(page);
+		if (folio_mkclean(folio))
+			folio_mark_dirty(folio);
 		/*
 		 * We carefully synchronise fault handlers against
-		 * installing a dirty pte and marking the page dirty
+		 * installing a dirty pte and marking the folio dirty
 		 * at this point.  We do this by having them hold the
-		 * page lock while dirtying the page, and pages are
+		 * page lock while dirtying the folio, and folios are
 		 * always locked coming in here, so we get the desired
 		 * exclusion.
 		 */
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
-		if (TestClearPageDirty(page)) {
-			dec_lruvec_page_state(page, NR_FILE_DIRTY);
-			dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-			dec_wb_stat(wb, WB_RECLAIMABLE);
-			ret = 1;
+		if (folio_test_clear_dirty_flag(folio)) {
+			long nr = folio_nr_pages(folio);
+			lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
+			zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
+			wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
+			ret = true;
 		}
 		unlocked_inode_to_wb_end(inode, &cookie);
 		return ret;
 	}
-	return TestClearPageDirty(page);
+	return folio_test_clear_dirty_flag(folio);
 }
-EXPORT_SYMBOL(clear_page_dirty_for_io);
+EXPORT_SYMBOL(folio_clear_dirty_for_io);
 
 bool __folio_end_writeback(struct folio *folio)
 {
-- 
2.30.2

