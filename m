Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3073C41F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhGLDgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhGLDgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:36:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDEBC0613E5;
        Sun, 11 Jul 2021 20:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/UjTcOa2b9NZ51jRDlbakD/TMtkd1JmIEo2wWKFvoHE=; b=MWRVbEgm8kF2L5w3487EDmjVqI
        VfP3Q7ydhTq3HiOG1sQKt0od1oN6JJC6aVFI9wt+H40rs6fmVMwwJ5YUmYj6K9dtcFu0mO20YqDus
        5M6YQLOW5pXkf74/7zDJTlajcNTtCLISlMUSM8wTqTMdrZhiwnQtja8/CH8/Z6u34fZdeUbOxo6mb
        lTlKKwkHQcPA0XsMWYnv2+DUGr42QUBqORSApCDt78nKZK8oxsEOcFPhS+JoS7rsHHwDDVSJeCNOV
        hRK51jNdmEfW2zANk98GV0lPbq81hMGHOnSPk2mvYjdW916aFCIr7nF+uM0VsZ7hjlL3zc0lWTma+
        Orf4yQow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mgQ-00Goav-Rw; Mon, 12 Jul 2021 03:32:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 048/137] mm/memcg: Add folio_lruvec_lock() and similar functions
Date:   Mon, 12 Jul 2021 04:05:32 +0100
Message-Id: <20210712030701.4000097-49-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are the folio equivalents of lock_page_lruvec() and similar
functions.  Also convert lruvec_memcg_debug() to take a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 29 ++++++++++++-----------
 mm/compaction.c            |  2 +-
 mm/huge_memory.c           |  5 ++--
 mm/memcontrol.c            | 48 ++++++++++++++++----------------------
 mm/rmap.c                  |  2 +-
 mm/swap.c                  |  8 ++++---
 mm/vmscan.c                |  3 ++-
 7 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index da878d24b0e3..fae246c4b5bf 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -768,15 +768,16 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
-struct lruvec *lock_page_lruvec(struct page *page);
-struct lruvec *lock_page_lruvec_irq(struct page *page);
-struct lruvec *lock_page_lruvec_irqsave(struct page *page,
+struct lruvec *folio_lruvec_lock(struct folio *folio);
+struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
+struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 						unsigned long *flags);
 
 #ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page);
+void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio);
 #else
-static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+static inline
+void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
 {
 }
 #endif
@@ -1256,26 +1257,26 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
 
-static inline struct lruvec *lock_page_lruvec(struct page *page)
+static inline struct lruvec *folio_lruvec_lock(struct folio *folio)
 {
-	struct pglist_data *pgdat = page_pgdat(page);
+	struct pglist_data *pgdat = folio_pgdat(folio);
 
 	spin_lock(&pgdat->__lruvec.lru_lock);
 	return &pgdat->__lruvec;
 }
 
-static inline struct lruvec *lock_page_lruvec_irq(struct page *page)
+static inline struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 {
-	struct pglist_data *pgdat = page_pgdat(page);
+	struct pglist_data *pgdat = folio_pgdat(folio);
 
 	spin_lock_irq(&pgdat->__lruvec.lru_lock);
 	return &pgdat->__lruvec;
 }
 
-static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
+static inline struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 		unsigned long *flagsp)
 {
-	struct pglist_data *pgdat = page_pgdat(page);
+	struct pglist_data *pgdat = folio_pgdat(folio);
 
 	spin_lock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp);
 	return &pgdat->__lruvec;
@@ -1532,6 +1533,7 @@ static inline bool page_matches_lruvec(struct page *page, struct lruvec *lruvec)
 static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
 		struct lruvec *locked_lruvec)
 {
+	struct folio *folio = page_folio(page);
 	if (locked_lruvec) {
 		if (page_matches_lruvec(page, locked_lruvec))
 			return locked_lruvec;
@@ -1539,13 +1541,14 @@ static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
 		unlock_page_lruvec_irq(locked_lruvec);
 	}
 
-	return lock_page_lruvec_irq(page);
+	return folio_lruvec_lock_irq(folio);
 }
 
 /* Don't lock again iff page's lruvec locked */
 static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
 		struct lruvec *locked_lruvec, unsigned long *flags)
 {
+	struct folio *folio = page_folio(page);
 	if (locked_lruvec) {
 		if (page_matches_lruvec(page, locked_lruvec))
 			return locked_lruvec;
@@ -1553,7 +1556,7 @@ static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
 		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
 	}
 
-	return lock_page_lruvec_irqsave(page, flags);
+	return folio_lruvec_lock_irqsave(folio, flags);
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/mm/compaction.c b/mm/compaction.c
index a88f7b893f80..6f77577be248 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1038,7 +1038,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 			locked = lruvec;
 
-			lruvec_memcg_debug(lruvec, page);
+			lruvec_memcg_debug(lruvec, page_folio(page));
 
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ecb1fb1f5f3e..763bf687ca92 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2431,7 +2431,8 @@ static void __split_huge_page_tail(struct page *head, int tail,
 static void __split_huge_page(struct page *page, struct list_head *list,
 		pgoff_t end)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
+	struct page *head = &folio->page;
 	struct lruvec *lruvec;
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
@@ -2450,7 +2451,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 
 	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-	lruvec = lock_page_lruvec(head);
+	lruvec = folio_lruvec_lock(folio);
 
 	for (i = nr - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3152a0e1ba6f..08add9e110ee 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1158,67 +1158,59 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 }
 
 #ifdef CONFIG_DEBUG_VM
-void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
 {
 	struct mem_cgroup *memcg;
 
 	if (mem_cgroup_disabled())
 		return;
 
-	memcg = page_memcg(page);
+	memcg = folio_memcg(folio);
 
 	if (!memcg)
-		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != root_mem_cgroup, page);
+		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != root_mem_cgroup, folio);
 	else
-		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != memcg, page);
+		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
 }
 #endif
 
 /**
- * lock_page_lruvec - lock and return lruvec for a given page.
- * @page: the page
+ * folio_lruvec_lock - lock and return lruvec for a given folio.
+ * @folio: Pointer to the folio.
  *
  * These functions are safe to use under any of the following conditions:
- * - page locked
- * - PageLRU cleared
- * - lock_page_memcg()
- * - page->_refcount is zero
+ * - folio locked
+ * - folio_lru cleared
+ * - folio_memcg_lock()
+ * - folio frozen (refcount of 0)
  */
-struct lruvec *lock_page_lruvec(struct page *page)
+struct lruvec *folio_lruvec_lock(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = folio_lruvec(folio);
 
-	lruvec = folio_lruvec(folio);
 	spin_lock(&lruvec->lru_lock);
-
-	lruvec_memcg_debug(lruvec, page);
+	lruvec_memcg_debug(lruvec, folio);
 
 	return lruvec;
 }
 
-struct lruvec *lock_page_lruvec_irq(struct page *page)
+struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = folio_lruvec(folio);
 
-	lruvec = folio_lruvec(folio);
 	spin_lock_irq(&lruvec->lru_lock);
-
-	lruvec_memcg_debug(lruvec, page);
+	lruvec_memcg_debug(lruvec, folio);
 
 	return lruvec;
 }
 
-struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
+struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
+		unsigned long *flags)
 {
-	struct folio *folio = page_folio(page);
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = folio_lruvec(folio);
 
-	lruvec = folio_lruvec(folio);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
-
-	lruvec_memcg_debug(lruvec, page);
+	lruvec_memcg_debug(lruvec, folio);
 
 	return lruvec;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 795f9d5f8386..b416af486812 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -33,7 +33,7 @@
  *                 mapping->private_lock (in __set_page_dirty_buffers)
  *                   lock_page_memcg move_lock (in __set_page_dirty_buffers)
  *                     i_pages lock (widely used)
- *                       lruvec->lru_lock (in lock_page_lruvec_irq)
+ *                       lruvec->lru_lock (in folio_lruvec_lock_irq)
  *                 inode->i_lock (in set_page_dirty's __mark_inode_dirty)
  *                 bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
  *                   sb_lock (within inode_lock in fs/fs-writeback.c)
diff --git a/mm/swap.c b/mm/swap.c
index d5136cac4267..a82812caf409 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -80,10 +80,11 @@ static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
 static void __page_cache_release(struct page *page)
 {
 	if (PageLRU(page)) {
+		struct folio *folio = page_folio(page);
 		struct lruvec *lruvec;
 		unsigned long flags;
 
-		lruvec = lock_page_lruvec_irqsave(page, &flags);
+		lruvec = folio_lruvec_lock_irqsave(folio, &flags);
 		del_page_from_lru_list(page, lruvec);
 		__clear_page_lru_flags(page);
 		unlock_page_lruvec_irqrestore(lruvec, flags);
@@ -372,11 +373,12 @@ static inline void activate_page_drain(int cpu)
 
 static void activate_page(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct lruvec *lruvec;
 
-	page = compound_head(page);
+	page = &folio->page;
 	if (TestClearPageLRU(page)) {
-		lruvec = lock_page_lruvec_irq(page);
+		lruvec = folio_lruvec_lock_irq(folio);
 		__activate_page(page, lruvec);
 		unlock_page_lruvec_irq(lruvec);
 		SetPageLRU(page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4620df62f0ff..0d48306d37dc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1965,6 +1965,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
  */
 int isolate_lru_page(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	int ret = -EBUSY;
 
 	VM_BUG_ON_PAGE(!page_count(page), page);
@@ -1974,7 +1975,7 @@ int isolate_lru_page(struct page *page)
 		struct lruvec *lruvec;
 
 		get_page(page);
-		lruvec = lock_page_lruvec_irq(page);
+		lruvec = folio_lruvec_lock_irq(folio);
 		del_page_from_lru_list(page, lruvec);
 		unlock_page_lruvec_irq(lruvec);
 		ret = 0;
-- 
2.30.2

