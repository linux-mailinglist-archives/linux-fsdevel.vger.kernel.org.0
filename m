Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444754B5BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiBNUxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:53:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiBNUxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:53:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471669FD1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 12:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QxI49WGD1+5k03XumgfmIKcqu/YQWF1M/vQu+J0txbo=; b=iFGJlTqoYDXrAZaaYvhFab44GL
        PdinQ7AkX2Av9gtg38hUu7uXx80IfhQp+nZFA9ku6MPqcUpzRWxszQ3CmZZ/1Cs0Zm3t6tPD6gqbh
        BI7lZdOGAS/83/NZKWK2MUe2tRMTN0OPfQo2mOof8z5kzacsxOdHXZKtGyBtpv+zxvH63SS3lRSmp
        admHojuRvTfCUw7yNs6bc941TYWTB1s4KAC5FjKWjiR29+teWYRCej0+knR3f0QjYfofpQHSIotg5
        WcRomrn9ojlN7sLuuKPgWAKPgBKDDBrgg+kbFQNO6Sm/eQEGp/6p8/+DW08bknw903FAzvpWHUDcb
        +hOlGfYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJhWG-00DDe4-Ra; Mon, 14 Feb 2022 20:00:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 08/10] mm: Turn deactivate_file_page() into deactivate_file_folio()
Date:   Mon, 14 Feb 2022 20:00:15 +0000
Message-Id: <20220214200017.3150590-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220214200017.3150590-1-willy@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function has one caller which already has a reference to the
page, so we don't need to use get_page_unless_zero().  Also move the
prototype to mm/internal.h.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  1 -
 mm/internal.h        |  1 +
 mm/swap.c            | 33 ++++++++++++++++-----------------
 mm/truncate.c        |  2 +-
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 304f174b4d31..064e60e9f63f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -372,7 +372,6 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void deactivate_file_page(struct page *page);
 extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
diff --git a/mm/internal.h b/mm/internal.h
index 927a17d58b85..d886b87b1294 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -66,6 +66,7 @@ static inline void wake_throttle_isolated(pg_data_t *pgdat)
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
+void deactivate_file_folio(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
diff --git a/mm/swap.c b/mm/swap.c
index bcf3ac288b56..745915127b1f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -639,32 +639,31 @@ void lru_add_drain_cpu(int cpu)
 }
 
 /**
- * deactivate_file_page - forcefully deactivate a file page
- * @page: page to deactivate
+ * deactivate_file_folio() - Forcefully deactivate a file folio.
+ * @folio: Folio to deactivate.
  *
- * This function hints the VM that @page is a good reclaim candidate,
- * for example if its invalidation fails due to the page being dirty
+ * This function hints to the VM that @folio is a good reclaim candidate,
+ * for example if its invalidation fails due to the folio being dirty
  * or under writeback.
  */
-void deactivate_file_page(struct page *page)
+void deactivate_file_folio(struct folio *folio)
 {
+	struct pagevec *pvec;
+
 	/*
-	 * In a workload with many unevictable page such as mprotect,
-	 * unevictable page deactivation for accelerating reclaim is pointless.
+	 * In a workload with many unevictable pages such as mprotect,
+	 * unevictable folio deactivation for accelerating reclaim is pointless.
 	 */
-	if (PageUnevictable(page))
+	if (folio_test_unevictable(folio))
 		return;
 
-	if (likely(get_page_unless_zero(page))) {
-		struct pagevec *pvec;
-
-		local_lock(&lru_pvecs.lock);
-		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
+	folio_get(folio);
+	local_lock(&lru_pvecs.lock);
+	pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
-		if (pagevec_add_and_need_flush(pvec, page))
-			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
-		local_unlock(&lru_pvecs.lock);
-	}
+	if (pagevec_add_and_need_flush(pvec, &folio->page))
+		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
+	local_unlock(&lru_pvecs.lock);
 }
 
 /*
diff --git a/mm/truncate.c b/mm/truncate.c
index 567557c36d45..14486e75ec28 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -525,7 +525,7 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 			 * of interest and try to speed up its reclaim.
 			 */
 			if (!ret) {
-				deactivate_file_page(&folio->page);
+				deactivate_file_folio(folio);
 				/* It is likely on the pagevec of a remote CPU */
 				if (nr_pagevec)
 					(*nr_pagevec)++;
-- 
2.34.1

