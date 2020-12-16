Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471C22DC65B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgLPSZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbgLPSZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C0C0611CE;
        Wed, 16 Dec 2020 10:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=icZhlkCdxBHfuF6U/CHDuOT+WX0HsXPmoyGXch3n3fk=; b=L7D5xcScRonFlDplAiN0ciH5dm
        1Qr2HnfU7NS30is/bBoLn47xVSbNkCjAb63WRE6q3vMLm/i5eslUKEwt/xdPdFgKTs+CcNgp6hkw5
        eOqmAVaS1HMs31maWPxbvqNopRXcQWwrSJASkM0spk8oy8E6kFDS8ls+7a8B5RpnC4drxv9qQAdGp
        5YSf3aMiALjfp6SH/Lz+148vdCts9tXzf/rgQqe+F+pnQSZG3QNNIGoPWdAJW3sZn1C9kSRog+/+M
        KHzIJGNCOeCCwvzEjeGh52AGYvN0mWGu3fRcpKl0iXA8tTDMsMgfsUQddzR0THczqzt90Bp6lQf8R
        lbbz287A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSf-00077h-MZ; Wed, 16 Dec 2020 18:23:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/25] mm/swap: Convert rotate_reclaimable_page to folio
Date:   Wed, 16 Dec 2020 18:23:25 +0000
Message-Id: <20201216182335.27227-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
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
index c097bc9cedd9..02ce65c29569 100644
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
index 6fc896a38ef7..f3722ca8f7d4 100644
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
index c3638a13987f..43e4c507ad0f 100644
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

