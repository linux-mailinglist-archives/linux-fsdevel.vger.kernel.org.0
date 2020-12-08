Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3FE2D33AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgLHUW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbgLHUWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DBC0617A7;
        Tue,  8 Dec 2020 12:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=T2NKufslsV4zHnMND/Rek7wwwX3gR2vSveo5C0g9xCM=; b=N1NRhNaSnVk8G1XUcYN1U+ABvW
        ztPmgw8KbK64ZoLwyIZcu50+YxkTDV2EINrc8kV972LWHAmL6B5TJ5WQWY6lZ4EacCQg8k0v1MV8d
        fey5ruQ58/6rzMsSq6XjNzSJgCfvQ/sMAySZdMAo6D4IWdYR+i80AfGCGlpM1cRAGXE62Spsen4KH
        2N83yIBvl9/X443/Er6X+hlIs7sBqtUtOA5QWHLvMFI/NT3arW/U5mwnHoumbqcFuz0aGF6z9H6Zd
        RDqqlfOmSvrfmslN2HUISUlYfn/1E/UEb4/u+x04b+sPYOYWLsBDdhWz7+TH6mDZNMvvafEsgTDuN
        AefuqMaA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmiwu-00051J-9O; Tue, 08 Dec 2020 19:47:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/11] mm/swap: Convert rotate_reclaimable_page to folio
Date:   Tue,  8 Dec 2020 19:46:53 +0000
Message-Id: <20201208194653.19180-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201208194653.19180-1-willy@infradead.org>
References: <20201208194653.19180-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the declaration into mm/internal.h and rename the function to
rotate_reclaimable_folio().  This eliminates all five of the calls to
compound_head() in this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  1 -
 mm/filemap.c         |  2 +-
 mm/internal.h        |  1 +
 mm/page_io.c         |  4 ++--
 mm/swap.c            | 12 ++++++------
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5bba15ac5a2e..5aaca35ce887 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -343,7 +343,6 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void rotate_reclaimable_page(struct page *page);
 extern void deactivate_file_page(struct page *page);
 extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
diff --git a/mm/filemap.c b/mm/filemap.c
index 297144524f58..93e40e9ac357 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1477,7 +1477,7 @@ void end_page_writeback(struct page *page)
 	 */
 	if (FolioReclaim(folio)) {
 		ClearFolioReclaim(folio);
-		rotate_reclaimable_page(&folio->page);
+		rotate_reclaimable_folio(folio);
 	}
 
 	/*
diff --git a/mm/internal.h b/mm/internal.h
index 8e9c660f33ca..f089535b5d86 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -35,6 +35,7 @@
 void page_writeback_init(void);
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
+void rotate_reclaimable_folio(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
diff --git a/mm/page_io.c b/mm/page_io.c
index 9bca17ecc4df..1fc0a579da58 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -57,7 +57,7 @@ void end_swap_bio_write(struct bio *bio)
 		 * Also print a dire warning that things will go BAD (tm)
 		 * very quickly.
 		 *
-		 * Also clear PG_reclaim to avoid rotate_reclaimable_page()
+		 * Also clear PG_reclaim to avoid rotate_reclaimable_folio()
 		 */
 		set_page_dirty(page);
 		pr_alert("Write-error on swap-device (%u:%u:%llu)\n",
@@ -341,7 +341,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 			 * temporary failure if the system has limited
 			 * memory for allocating transmit buffers.
 			 * Mark the page dirty and avoid
-			 * rotate_reclaimable_page but rate-limit the
+			 * rotate_reclaimable_folio but rate-limit the
 			 * messages but do not flag PageError like
 			 * the normal direct-to-bio case as it could
 			 * be temporary.
diff --git a/mm/swap.c b/mm/swap.c
index 5022dfe388ad..9aadde8aea9b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -241,19 +241,19 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
  * inactive list.
  *
- * rotate_reclaimable_page() must disable IRQs, to prevent nasty races.
+ * rotate_reclaimable_folio() must disable IRQs, to prevent nasty races.
  */
-void rotate_reclaimable_page(struct page *page)
+void rotate_reclaimable_folio(struct folio *folio)
 {
-	if (!PageLocked(page) && !PageDirty(page) &&
-	    !PageUnevictable(page) && PageLRU(page)) {
+	if (!FolioLocked(folio) && !FolioDirty(folio) &&
+	    !FolioUnevictable(folio) && FolioLRU(folio)) {
 		struct pagevec *pvec;
 		unsigned long flags;
 
-		get_page(page);
+		get_folio(folio);
 		local_lock_irqsave(&lru_rotate.lock, flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (!pagevec_add(pvec, &folio->page) || FolioHead(folio))
 			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
-- 
2.29.2

