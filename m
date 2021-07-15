Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1F93C96C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhGOEAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhGOEAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:00:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F13C06175F;
        Wed, 14 Jul 2021 20:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=P5Zy9I2T86gFM6NThiSEouYBNinlhkbnNiXWyApBcYE=; b=f7dzk7w5iQl1xTSQNOtJShlFzV
        sb2YPs0tfp5x2PEAZtQ07ZnhUihDVuW7hNg5R4VY0llzRdHzBgwfKjRPyY1USGxEqvAqcPU2SGz44
        q/Ykf66Yt5U629E9VhhAvtkRVWw6HGgeVivYEaRwQUHnWi1I/Z9dFs66rJWQpnTIeuifA0tMNL82Q
        zHGr3b7bFeTKsNOA60ef9qC084AxH8aheA+JkGkDfeodXDNUv0u8Ax0f5Ug49UGEBWUD2Jc1B+yKc
        y7YmfOoMxZihki0TxZDtN+QQXblqH1YhNG9VzJA+Y4gcNOjblEsVx3IEmxfN1cu21P4gnH96tjbs+
        amxE8C3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sU5-002vNn-Jg; Thu, 15 Jul 2021 03:56:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v14 023/138] mm/swap: Add folio_rotate_reclaimable()
Date:   Thu, 15 Jul 2021 04:35:09 +0100
Message-Id: <20210715033704.692967-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert rotate_reclaimable_page() to folio_rotate_reclaimable().  This
eliminates all five of the calls to compound_head() in this function,
saving 75 bytes at the cost of adding 15 bytes to its one caller,
end_page_writeback().  We also save 36 bytes from pagevec_move_tail_fn()
due to using folios there.  Net 96 bytes savings.

Also move its declaration to mm/internal.h as it's only used by filemap.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/swap.h |  1 -
 mm/filemap.c         |  3 ++-
 mm/internal.h        |  1 +
 mm/page_io.c         |  4 ++--
 mm/swap.c            | 30 ++++++++++++++++--------------
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3d3d85354026..8394716a002b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -371,7 +371,6 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void rotate_reclaimable_page(struct page *page);
 extern void deactivate_file_page(struct page *page);
 extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
diff --git a/mm/filemap.c b/mm/filemap.c
index fb6398a532e5..4ce2b22b64f8 100644
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
index 31ff935b2547..1a8851b73031 100644
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
index 19600430e536..095a5ec6f986 100644
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
+	if (!folio_test_unevictable(folio)) {
+		lruvec_del_folio(lruvec, folio);
+		folio_clear_active(folio);
+		lruvec_add_folio_tail(lruvec, folio);
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
+	if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
+	    !folio_test_unevictable(folio) && folio_test_lru(folio)) {
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

