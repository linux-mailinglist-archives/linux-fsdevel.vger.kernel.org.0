Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7536EB3D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 23:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjDUVof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 17:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjDUVoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:44:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E602700;
        Fri, 21 Apr 2023 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TaEL6wJEWmG7v/Kj+xMCxG7l/Tv1LU1WrJwnB3EGy3E=; b=N942EdhFvz8Gq8X0vru14SS2Tz
        NSMMc3ogGzPG2/igUrApVOD7nvcB5K/4UI28nLVYOwAB52r3+fcJXP9APHpwXmOM3q6qrw2BgTt/j
        caFXw1rBuZp75667SgZQedCUy2WjgaS5ME72NMg2F8DmvIV9HV4lZYCengkZYqa2jjMLpEBGuGQm3
        cAzPOhEk2Y75zB3VUvyjKzHud3xR7zENlmf188YTgv99Mkb7ucqaY9iy2HJd2LE35twbd41deBG5N
        HX2mbF5Ndbygf6Towllz/Gv1UT754OGwbCZbye8ao31rI5EjMABW1FJPa80ME9BC2gfYF+I0GujRk
        iyqZUPTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppyY1-00Btom-22;
        Fri, 21 Apr 2023 21:44:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC 3/8] shmem: account for high order folios
Date:   Fri, 21 Apr 2023 14:43:55 -0700
Message-Id: <20230421214400.2836131-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230421214400.2836131-1-mcgrof@kernel.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
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
 mm/shmem.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6f117c3cbe89..d76e86ff356e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -806,15 +806,15 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
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
+			swapped+=(folio_nr_pages(folio));
 
 		if (need_resched()) {
 			xas_pause(&xas);
@@ -941,10 +941,15 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			folio = fbatch.folios[i];
 
 			if (xa_is_value(folio)) {
+				long swaps_freed = 0;
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += !shmem_free_swap(mapping,
-							indices[i], folio);
+				swaps_freed = folio_nr_pages(folio);
+				if (!shmem_free_swap(mapping, indices[i], folio)) {
+					if (swaps_freed > 1)
+						pr_warn("swaps freed > 1 -- %lu\n", swaps_freed);
+					nr_swaps_freed += swaps_freed;
+				}
 				continue;
 			}
 
@@ -1010,14 +1015,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			folio = fbatch.folios[i];
 
 			if (xa_is_value(folio)) {
+				long swaps_freed = 0;
 				if (unfalloc)
 					continue;
+				swaps_freed = folio_nr_pages(folio);
 				if (shmem_free_swap(mapping, indices[i], folio)) {
 					/* Swap was replaced by page: retry */
 					index = indices[i];
 					break;
 				}
-				nr_swaps_freed++;
+				if (swaps_freed > 1)
+					pr_warn("swaps freed > 1 -- %lu\n", swaps_freed);
+				nr_swaps_freed+=swaps_freed;
 				continue;
 			}
 
@@ -1448,7 +1457,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 			NULL) == 0) {
 		spin_lock_irq(&info->lock);
 		shmem_recalc_inode(inode);
-		info->swapped++;
+		info->swapped+=folio_nr_pages(folio);
 		spin_unlock_irq(&info->lock);
 
 		swap_shmem_alloc(swap);
@@ -1723,6 +1732,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	swp_entry_t swapin_error;
 	void *old;
+	long num_swap_pages;
 
 	swapin_error = make_swapin_error_entry();
 	old = xa_cmpxchg_irq(&mapping->i_pages, index,
@@ -1732,6 +1742,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 		return;
 
 	folio_wait_writeback(folio);
+	num_swap_pages = folio_nr_pages(folio);
 	delete_from_swap_cache(folio);
 	spin_lock_irq(&info->lock);
 	/*
@@ -1739,8 +1750,8 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	 * be 0 when inode is released and thus trigger WARN_ON(inode->i_blocks) in
 	 * shmem_evict_inode.
 	 */
-	info->alloced--;
-	info->swapped--;
+	info->alloced-=num_swap_pages;
+	info->swapped-=num_swap_pages;
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 	swap_free(swap);
@@ -1830,7 +1841,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		goto failed;
 
 	spin_lock_irq(&info->lock);
-	info->swapped--;
+	info->swapped-= folio_nr_pages(folio);
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
@@ -2657,8 +2668,8 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
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

