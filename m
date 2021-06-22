Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954A03B053A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhFVMyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFVMyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:54:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A40C061574;
        Tue, 22 Jun 2021 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6W9Yg1LtSN40CnyaShJ6ozyHdeq4XxZPXRaFYoAdf4Y=; b=m6absCgH2vwmLitnd6YuEX8nnD
        XJMHQyYbGqYHacleYQ+mkMcnv9OtxD/KqDT4WvtVC87epFR6pC0W78rm6ySyqja9lxdyFNWx9Uab4
        FuOCFhcr/rQa1ER2MqvjVFLf5d0J08voCfW3tgkIo/ebpjC9Y6DisfUdbR1KYf8COpqA9/hsyFZIg
        yZOF/O69Vt/6oy3wtq61ywIXXTVBWGRt5OLEEXP3L5JYFAOUSO8Nh09gFlxtSXgLuCRb+8fG4q45h
        iYClz/ZAZQyLxskXXEc3cw6Ta+I0vL1QS+ZE07LMYK3WUPLo6DnW0nZQioEyF1gSwhwUoxk4GUF2X
        3oCWnq5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfrY-00EIrY-D4; Tue, 22 Jun 2021 12:50:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/46] mm/lru: Convert __pagevec_lru_add_fn to take a folio
Date:   Tue, 22 Jun 2021 13:15:44 +0100
Message-Id: <20210622121551.3398730-40-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves five calls to compound_head(), totalling 60 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/swap.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 2ed00cfd03ac..f3f1ee9f8616 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -998,17 +998,18 @@ void __pagevec_release(struct pagevec *pvec)
 }
 EXPORT_SYMBOL(__pagevec_release);
 
-static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
+static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
 {
-	int was_unevictable = TestClearPageUnevictable(page);
-	int nr_pages = thp_nr_pages(page);
+	int was_unevictable = folio_test_clear_unevictable_flag(folio);
+	int nr_pages = folio_nr_pages(folio);
 
-	VM_BUG_ON_PAGE(PageLRU(page), page);
+	VM_BUG_ON_FOLIO(folio_lru(folio), folio);
 
 	/*
-	 * Page becomes evictable in two ways:
+	 * Folio becomes evictable in two ways:
 	 * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
-	 * 2) Before acquiring LRU lock to put the page to correct LRU and then
+	 * 2) Before acquiring LRU lock to put the folio on the correct LRU
+	 *    and then
 	 *   a) do PageLRU check with lock [check_move_unevictable_pages]
 	 *   b) do PageLRU check before lock [clear_page_mlock]
 	 *
@@ -1017,10 +1018,10 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 	 *
 	 * #0: __pagevec_lru_add_fn		#1: clear_page_mlock
 	 *
-	 * SetPageLRU()				TestClearPageMlocked()
+	 * folio_set_lru_flag()			folio_test_clear_mlocked_flag()
 	 * smp_mb() // explicit ordering	// above provides strict
 	 *					// ordering
-	 * PageMlocked()			PageLRU()
+	 * folio_mlocked()			folio_lru()
 	 *
 	 *
 	 * if '#1' does not observe setting of PG_lru by '#0' and fails
@@ -1031,21 +1032,21 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 	 * looking at the same page) and the evictable page will be stranded
 	 * in an unevictable LRU.
 	 */
-	SetPageLRU(page);
+	folio_set_lru_flag(folio);
 	smp_mb__after_atomic();
 
-	if (page_evictable(page)) {
+	if (folio_evictable(folio)) {
 		if (was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	} else {
-		ClearPageActive(page);
-		SetPageUnevictable(page);
+		folio_clear_active_flag(folio);
+		folio_set_unevictable_flag(folio);
 		if (!was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
 	}
 
-	add_page_to_lru_list(page, lruvec);
-	trace_mm_lru_insertion(page);
+	folio_add_to_lru_list(folio, lruvec);
+	trace_mm_lru_insertion(&folio->page);
 }
 
 /*
@@ -1059,10 +1060,10 @@ void __pagevec_lru_add(struct pagevec *pvec)
 	unsigned long flags = 0;
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
+		struct folio *folio = page_folio(pvec->pages[i]);
 
-		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
-		__pagevec_lru_add_fn(page, lruvec);
+		lruvec = folio_relock_lruvec_irqsave(folio, lruvec, &flags);
+		__pagevec_lru_add_fn(folio, lruvec);
 	}
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
-- 
2.30.2

