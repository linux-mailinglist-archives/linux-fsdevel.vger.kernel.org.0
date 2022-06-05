Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5104953DE06
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 21:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348582AbiFETjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 15:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351574AbiFETjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:39:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EB34D637;
        Sun,  5 Jun 2022 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7vrbND8cI4Dlq/u8PQe/DoQG1zXQAC8bnQq3oGQZlCM=; b=nyyxz3de/IeOoMboCtVOVL6Bfa
        VfKn+9Zxs/tns4f9iK0uXrzCv3nCmGwggtuSAUAtlPGnuq7icdE5HNPJH04XGNi7c1z8uo9aOBl13
        kJWUC0wwP6r24Wz1QxsuEIRQfaOEnZ3Dg+XUj8w0YlohN8gP7zUJj2pOjg7y43Pr//LpiWEXb5yqJ
        K6B5rwHIPhpnhCcdLsO2JTI3svxYEAP6mohHhTayjo4MzQ4RVRW6FirahM6gza6gHsplOlL7+7AeH
        NGJiKKqHk6YUBLdFV8TQaFaygjaxQdpQwBZOim9CpkDAEyupcW8eJHdlsziy2Jx6OO5JpEWzDeF8Q
        O5jHuBxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxw5R-009wsZ-07; Sun, 05 Jun 2022 19:38:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org
Subject: [PATCH 06/10] hugetlbfs: Convert remove_inode_hugepages() to use filemap_get_folios()
Date:   Sun,  5 Jun 2022 20:38:50 +0100
Message-Id: <20220605193854.2371230-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220605193854.2371230-1-willy@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use folios throughout this function.  That removes the last caller of
huge_pagevec_release(), so delete that too.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hugetlbfs/inode.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ae2524480f23..14d33f725e05 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -108,16 +108,6 @@ static inline void hugetlb_drop_vma_policy(struct vm_area_struct *vma)
 }
 #endif
 
-static void huge_pagevec_release(struct pagevec *pvec)
-{
-	int i;
-
-	for (i = 0; i < pagevec_count(pvec); ++i)
-		put_page(pvec->pages[i]);
-
-	pagevec_reinit(pvec);
-}
-
 /*
  * Mask used when checking the page offset value passed in via system
  * calls.  This value will be converted to a loff_t which is signed.
@@ -480,25 +470,19 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> huge_page_shift(h);
 	const pgoff_t end = lend >> huge_page_shift(h);
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	pgoff_t next, index;
 	int i, freed = 0;
 	bool truncate_op = (lend == LLONG_MAX);
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	next = start;
-	while (next < end) {
-		/*
-		 * When no more pages are found, we are done.
-		 */
-		if (!pagevec_lookup_range(&pvec, mapping, &next, end - 1))
-			break;
-
-		for (i = 0; i < pagevec_count(&pvec); ++i) {
-			struct page *page = pvec.pages[i];
+	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+			struct folio *folio = fbatch.folios[i];
 			u32 hash = 0;
 
-			index = page->index;
+			index = folio->index;
 			if (!truncate_op) {
 				/*
 				 * Only need to hold the fault mutex in the
@@ -511,15 +495,15 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			/*
-			 * If page is mapped, it was faulted in after being
+			 * If folio is mapped, it was faulted in after being
 			 * unmapped in caller.  Unmap (again) now after taking
 			 * the fault mutex.  The mutex will prevent faults
-			 * until we finish removing the page.
+			 * until we finish removing the folio.
 			 *
 			 * This race can only happen in the hole punch case.
 			 * Getting here in a truncate operation is a bug.
 			 */
-			if (unlikely(page_mapped(page))) {
+			if (unlikely(folio_mapped(folio))) {
 				BUG_ON(truncate_op);
 
 				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -532,7 +516,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 				i_mmap_unlock_write(mapping);
 			}
 
-			lock_page(page);
+			folio_lock(folio);
 			/*
 			 * We must free the huge page and remove from page
 			 * cache (remove_huge_page) BEFORE removing the
@@ -542,8 +526,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * the subpool and global reserve usage count can need
 			 * to be adjusted.
 			 */
-			VM_BUG_ON(HPageRestoreReserve(page));
-			remove_huge_page(page);
+			VM_BUG_ON(HPageRestoreReserve(&folio->page));
+			remove_huge_page(&folio->page);
 			freed++;
 			if (!truncate_op) {
 				if (unlikely(hugetlb_unreserve_pages(inode,
@@ -551,11 +535,11 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 					hugetlb_fix_reserve_counts(inode);
 			}
 
-			unlock_page(page);
+			folio_unlock(folio);
 			if (!truncate_op)
 				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
-		huge_pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.35.1

