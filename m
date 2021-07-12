Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85653C420A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhGLDlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhGLDlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:41:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A46C0613DD;
        Sun, 11 Jul 2021 20:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=07NC3255VH/NlGdDowpnSzvZFseSJjGe0n/+yF1BoH0=; b=Dp4iifR0vpgNb92FbF2CKjDxzx
        DZ59JJQEXUY/yfv0ZMl0jyEIf45lK0IP4sQkBmIPnI/iAYc3tMV1f1pJ/90wkPNxOY00efdxYQFkH
        Cygn86rAdNW84BezlFiKrr1ogNnNHm3LodAOk/KHTWpo//LD+/7+l48d+nyg9PHy0r0nz/T6j5o0r
        LEmKpNTCz2ZR5E6LCaxpL0IAL4+8x5Q0UHESoyAIC+NiN0VY4WWCgyW5mSoIcCVKa4eZWjjWfGGvo
        9A+VtTeAnhvlTZOPrW1MXX0MLL7+ArhcgXY7p7RxYlAgxhwkpE6mcPcAANZC/rYrXfNeFXOpekIhl
        qOklvisw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mky-00GowF-Kx; Mon, 12 Jul 2021 03:37:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 057/137] mm/swap: Add folio_activate()
Date:   Mon, 12 Jul 2021 04:05:41 +0100
Message-Id: <20210712030701.4000097-58-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This replaces activate_page() and eliminates lots of calls to
compound_head().  Saves net 118 bytes of kernel text.  There are still
some redundant calls to page_folio() here which will be removed when
pagevec_lru_move_fn() is converted to use folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/swap.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 5c681c01e3fa..253ac77792dc 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -322,15 +322,15 @@ void lru_note_cost_page(struct page *page)
 		      page_is_file_lru(page), thp_nr_pages(page));
 }
 
-static void __activate_page(struct page *page, struct lruvec *lruvec)
+static void __folio_activate(struct folio *folio, struct lruvec *lruvec)
 {
-	if (!PageActive(page) && !PageUnevictable(page)) {
-		int nr_pages = thp_nr_pages(page);
+	if (!folio_active(folio) && !folio_unevictable(folio)) {
+		int nr_pages = folio_nr_pages(folio);
 
-		del_page_from_lru_list(page, lruvec);
-		SetPageActive(page);
-		add_page_to_lru_list(page, lruvec);
-		trace_mm_lru_activate(page);
+		folio_del_from_lru_list(folio, lruvec);
+		folio_set_active_flag(folio);
+		folio_add_to_lru_list(folio, lruvec);
+		trace_mm_lru_activate(&folio->page);
 
 		__count_vm_events(PGACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE,
@@ -339,6 +339,11 @@ static void __activate_page(struct page *page, struct lruvec *lruvec)
 }
 
 #ifdef CONFIG_SMP
+static void __activate_page(struct page *page, struct lruvec *lruvec)
+{
+	return __folio_activate(page_folio(page), lruvec);
+}
+
 static void activate_page_drain(int cpu)
 {
 	struct pagevec *pvec = &per_cpu(lru_pvecs.activate_page, cpu);
@@ -352,16 +357,16 @@ static bool need_activate_page_drain(int cpu)
 	return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) != 0;
 }
 
-static void activate_page(struct page *page)
+static void folio_activate(struct folio *folio)
 {
-	page = compound_head(page);
-	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
+	if (folio_lru(folio) && !folio_active(folio) &&
+	    !folio_unevictable(folio)) {
 		struct pagevec *pvec;
 
+		folio_get(folio);
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
-		get_page(page);
-		if (pagevec_add_and_need_flush(pvec, page))
+		if (pagevec_add_and_need_flush(pvec, &folio->page))
 			pagevec_lru_move_fn(pvec, __activate_page);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -372,17 +377,15 @@ static inline void activate_page_drain(int cpu)
 {
 }
 
-static void activate_page(struct page *page)
+static void folio_activate(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct lruvec *lruvec;
 
-	page = &folio->page;
-	if (TestClearPageLRU(page)) {
-		lruvec = folio_lruvec_lock_irq(folio);
-		__activate_page(page, lruvec);
+	if (folio_test_clear_lru_flag(folio)) {
+		lruvec = folio_lock_lruvec_irq(folio);
+		__folio_activate(folio, lruvec);
 		unlock_page_lruvec_irq(lruvec);
-		SetPageLRU(page);
+		folio_set_lru_flag(folio);
 	}
 }
 #endif
@@ -447,7 +450,7 @@ void mark_page_accessed(struct page *page)
 		 * LRU on the next drain.
 		 */
 		if (PageLRU(page))
-			activate_page(page);
+			folio_activate(page_folio(page));
 		else
 			__lru_cache_activate_page(page);
 		ClearPageReferenced(page);
-- 
2.30.2

