Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098CF7121A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbjEZH4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242606AbjEZH4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 03:56:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813C1A8;
        Fri, 26 May 2023 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BlnfxGH65lfjvCr0EihUnLvC6Y04PW1nCflzWem/FI0=; b=VIpL8dc4hJnM3liOcBxChkT+dG
        qF/usCC/Wup5mmMJmU1p1ovRc9zKDrFe15DpGpCv7f4i3Mhkrt83uK85qdUAizZUBhBrM5tQg3muw
        w9qV6fP5s+45uiKWkhPQ/0p5NiELflVvmRKmEbG0pYPjuLPUHkYpxlLQuXAICLo5rrMdD6xkn+c+E
        rf9/tWnG/HUnZedSs/UfiehEuj5H7zzw7q2FxO93KyrsNh4jk7WDlLYwOr+uIr2u7nhmEjEfjoA1u
        SDKTfqMfG82ro8eQ/SBy9XVW9hsS7XM0naNEQIHkN+T3/w4EOl/8CsAlecOfKgU/m7H4ZeTp2v+wL
        YZeBlrZw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2SIj-001WZm-2k;
        Fri, 26 May 2023 07:55:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org, hare@suse.de,
        kbusch@kernel.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 3/8] shmem: account for high order folios
Date:   Fri, 26 May 2023 00:55:47 -0700
Message-Id: <20230526075552.363524-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526075552.363524-1-mcgrof@kernel.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

shmem uses the shem_info_inode alloced, swapped to account
for allocated pages and swapped pages. In preparation for high
order folios adjust the accounting to use folio_nr_pages().

This should produce no functional changes yet as higher order
folios are not yet used or supported in shmem.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a947f2678a39..7bea4c5cb83a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -803,15 +803,15 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 						pgoff_t start, pgoff_t end)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
-	struct page *page;
+	struct folio *folio;
 	unsigned long swapped = 0;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, end - 1) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, end - 1) {
+		if (xas_retry(&xas, folio))
 			continue;
-		if (xa_is_value(page))
-			swapped++;
+		if (xa_is_value(folio))
+			swapped += (folio_nr_pages(folio));
 
 		if (need_resched()) {
 			xas_pause(&xas);
@@ -938,10 +938,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			folio = fbatch.folios[i];
 
 			if (xa_is_value(folio)) {
+				long swaps_freed;
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += !shmem_free_swap(mapping,
-							indices[i], folio);
+				swaps_freed = folio_nr_pages(folio);
+				if (!shmem_free_swap(mapping, indices[i], folio))
+					nr_swaps_freed += swaps_freed;
 				continue;
 			}
 
@@ -1007,14 +1009,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			folio = fbatch.folios[i];
 
 			if (xa_is_value(folio)) {
+				long swaps_freed;
 				if (unfalloc)
 					continue;
+				swaps_freed = folio_nr_pages(folio);
 				if (shmem_free_swap(mapping, indices[i], folio)) {
 					/* Swap was replaced by page: retry */
 					index = indices[i];
 					break;
 				}
-				nr_swaps_freed++;
+				nr_swaps_freed += swaps_freed;
 				continue;
 			}
 
@@ -1445,7 +1449,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 			NULL) == 0) {
 		spin_lock_irq(&info->lock);
 		shmem_recalc_inode(inode);
-		info->swapped++;
+		info->swapped += folio_nr_pages(folio);
 		spin_unlock_irq(&info->lock);
 
 		swap_shmem_alloc(swap);
@@ -1720,6 +1724,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	swp_entry_t swapin_error;
 	void *old;
+	long num_swap_pages;
 
 	swapin_error = make_swapin_error_entry();
 	old = xa_cmpxchg_irq(&mapping->i_pages, index,
@@ -1729,6 +1734,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 		return;
 
 	folio_wait_writeback(folio);
+	num_swap_pages = folio_nr_pages(folio);
 	delete_from_swap_cache(folio);
 	spin_lock_irq(&info->lock);
 	/*
@@ -1736,8 +1742,8 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	 * be 0 when inode is released and thus trigger WARN_ON(inode->i_blocks) in
 	 * shmem_evict_inode.
 	 */
-	info->alloced--;
-	info->swapped--;
+	info->alloced -= num_swap_pages;
+	info->swapped -= num_swap_pages;
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 	swap_free(swap);
@@ -1827,7 +1833,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		goto failed;
 
 	spin_lock_irq(&info->lock);
-	info->swapped--;
+	info->swapped -= folio_nr_pages(folio);
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
@@ -2542,8 +2548,8 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 		goto out_delete_from_cache;
 
 	spin_lock_irq(&info->lock);
-	info->alloced++;
-	inode->i_blocks += PAGE_SECTORS;
+	info->alloced += folio_nr_pages(folio);
+	inode->i_blocks += PAGE_SECTORS << folio_order(folio);
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
-- 
2.39.2

