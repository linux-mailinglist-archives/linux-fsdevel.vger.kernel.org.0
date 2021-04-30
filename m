Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3321137007D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhD3Sam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhD3Sak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:30:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D129C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rYXbSSrrZMPfQlxIntEhHkDV8wqaavuUOVFyhK8eblA=; b=qhC5Cyh5qGpDv4krcWWr66y/0m
        DA4lbyiKGM9grRSflAlrOM8OpA7Z6yZWP1CWNwySfZn/rQx7bfhF5yQzoXsGDdJG1y6tFHBe/dQAJ
        zCAk8iPKh7DUi6c+RZlCwtpvBHWlJCX6NXQRBhMYlNgiGa6eVjKiC+YksNRTa90/uYtk3+Einv+hQ
        l6IHl87RF7nAuw6hs4OLQt16/yAiqYbHFt81FR1DKMklInl6/1re2+w5jpHSON/I/96UEQRuyISZn
        AAz7hwgLkIJdiNV6Eq7kwZ6J/Z2ivOV7iolwTQtjZXdHcvOQ9IKJs+Ww3OAUu8O+pu2wixg2uyWcA
        fnknfXRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXsQ-00BNdf-KQ; Fri, 30 Apr 2021 18:28:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v8 23/31] mm/swap: Add folio_rotate_reclaimable
Date:   Fri, 30 Apr 2021 19:07:32 +0100
Message-Id: <20210430180740.2707166-24-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the declaration into mm/internal.h and rename
rotate_reclaimable_page() to folio_rotate_reclaimable().  This eliminates
all five of the calls to compound_head() in this function, saving 75 bytes
at the cost of adding 14 bytes to its one caller, end_page_writeback().
Net 61 bytes savings.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  1 -
 mm/filemap.c         |  2 +-
 mm/internal.h        |  1 +
 mm/page_io.c         |  4 ++--
 mm/swap.c            | 18 +++++++++---------
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 20766342845b..76b2338ef24d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -365,7 +365,6 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void rotate_reclaimable_page(struct page *page);
 extern void deactivate_file_page(struct page *page);
 extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
diff --git a/mm/filemap.c b/mm/filemap.c
index 3eb0447604b4..e15c0a273362 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1528,7 +1528,7 @@ void end_page_writeback(struct page *page)
 	 */
 	if (PageReclaim(page)) {
 		ClearPageReclaim(page);
-		rotate_reclaimable_page(page);
+		folio_rotate_reclaimable(page_folio(page));
 	}
 
 	/*
diff --git a/mm/internal.h b/mm/internal.h
index 46eb82eaa195..68d363a3a1f3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -35,6 +35,7 @@
 void page_writeback_init(void);
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
+void folio_rotate_reclaimable(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
diff --git a/mm/page_io.c b/mm/page_io.c
index c493ce9ebcf5..d597bc6e6e45 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -38,7 +38,7 @@ void end_swap_bio_write(struct bio *bio)
 		 * Also print a dire warning that things will go BAD (tm)
 		 * very quickly.
 		 *
-		 * Also clear PG_reclaim to avoid rotate_reclaimable_page()
+		 * Also clear PG_reclaim to avoid folio_rotate_reclaimable()
 		 */
 		set_page_dirty(page);
 		pr_alert_ratelimited("Write-error on swap-device (%u:%u:%llu)\n",
@@ -317,7 +317,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 			 * temporary failure if the system has limited
 			 * memory for allocating transmit buffers.
 			 * Mark the page dirty and avoid
-			 * rotate_reclaimable_page but rate-limit the
+			 * folio_rotate_reclaimable but rate-limit the
 			 * messages but do not flag PageError like
 			 * the normal direct-to-bio case as it could
 			 * be temporary.
diff --git a/mm/swap.c b/mm/swap.c
index dfb48cf9c2c9..6caca11cd2ec 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -249,23 +249,23 @@ static bool pagevec_add_and_need_flush(struct pagevec *pvec, struct page *page)
 }
 
 /*
- * Writeback is about to end against a page which has been marked for immediate
- * reclaim.  If it still appears to be reclaimable, move it to the tail of the
- * inactive list.
+ * Writeback is about to end against a folio which has been marked for
+ * immediate reclaim.  If it still appears to be reclaimable, move it
+ * to the tail of the inactive list.
  *
- * rotate_reclaimable_page() must disable IRQs, to prevent nasty races.
+ * folio_rotate_reclaimable() must disable IRQs, to prevent nasty races.
  */
-void rotate_reclaimable_page(struct page *page)
+void folio_rotate_reclaimable(struct folio *folio)
 {
-	if (!PageLocked(page) && !PageDirty(page) &&
-	    !PageUnevictable(page) && PageLRU(page)) {
+	if (!folio_locked(folio) && !folio_dirty(folio) &&
+	    !folio_unevictable(folio) && folio_lru(folio)) {
 		struct pagevec *pvec;
 		unsigned long flags;
 
-		get_page(page);
+		folio_get(folio);
 		local_lock_irqsave(&lru_rotate.lock, flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
-		if (pagevec_add_and_need_flush(pvec, page))
+		if (pagevec_add_and_need_flush(pvec, &folio->page))
 			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
-- 
2.30.2

