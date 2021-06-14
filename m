Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF63A706E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhFNUc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbhFNUc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:32:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8A9C061574;
        Mon, 14 Jun 2021 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pew7XulEEPrvd2vviQT7v/DJjrtbeXeaLBEsdR6VLOo=; b=UkieBMe4g7qPkrPE3TGLU+PLlz
        0awggBK3YkPf4DOuJaeSvuZsFINZdvtrcay9WmZS7EeiUPNPxoWqAuu6VASZ2obwLMYt41W/ajwLb
        S9P3PiTJh0uyFvULNSLx+QhmwI9h1xeh8/gAphNWxSFO/pV1eslIpvzk3x9gb8+iW8lKRUbNNTvgu
        D5zmGrlRjNpaUN8MNx/uUxechWaQbTTOqhSvVgpHX4tFS2MTC4XCVVRU0DFjkifBVWieD2jRF/KD+
        T9Akfl82qJXGOEaqVUV9RCCQfpR2iwGgVCYfA5+1EV492hIghaxg7p5f/PYNsE3xcCh/sz0D9+n3q
        JGrrazfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lstCx-005o3g-2w; Mon, 14 Jun 2021 20:29:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 24/33] mm/swap: Add folio_rotate_reclaimable()
Date:   Mon, 14 Jun 2021 21:14:26 +0100
Message-Id: <20210614201435.1379188-25-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the declaration into mm/internal.h and rename
rotate_reclaimable_page() to folio_rotate_reclaimable().  This eliminates
all five of the calls to compound_head() in this function, saving 75 bytes
at the cost of adding 15 bytes to its one caller, end_page_writeback().
We also save 36 bytes from pagevec_move_tail_fn() due to using folios
there.  Net 96 bytes savings.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swap.h |  1 -
 mm/filemap.c         |  3 ++-
 mm/internal.h        |  1 +
 mm/page_io.c         |  4 ++--
 mm/swap.c            | 30 ++++++++++++++++--------------
 5 files changed, 21 insertions(+), 18 deletions(-)

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
index dda1374d489e..3688c1f0651a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1529,8 +1529,9 @@ void end_page_writeback(struct page *page)
 	 * ever page writeback.
 	 */
 	if (PageReclaim(page)) {
+		struct folio *folio = page_folio(page);
 		ClearPageReclaim(page);
-		rotate_reclaimable_page(page);
+		folio_rotate_reclaimable(folio);
 	}
 
 	/*
diff --git a/mm/internal.h b/mm/internal.h
index 2f1182948aa6..76ddcf55012c 100644
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
index dfb48cf9c2c9..b01352821583 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -228,11 +228,13 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 
 static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (!PageUnevictable(page)) {
-		del_page_from_lru_list(page, lruvec);
-		ClearPageActive(page);
-		add_page_to_lru_list_tail(page, lruvec);
-		__count_vm_events(PGROTATED, thp_nr_pages(page));
+	struct folio *folio = page_folio(page);
+
+	if (!folio_unevictable(folio)) {
+		folio_del_from_lru_list(folio, lruvec);
+		folio_clear_active_flag(folio);
+		folio_add_to_lru_list_tail(folio, lruvec);
+		__count_vm_events(PGROTATED, folio_nr_pages(folio));
 	}
 }
 
@@ -249,23 +251,23 @@ static bool pagevec_add_and_need_flush(struct pagevec *pvec, struct page *page)
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

