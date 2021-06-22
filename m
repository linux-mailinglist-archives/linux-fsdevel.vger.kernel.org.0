Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8237E3B04B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFVMjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFVMjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:39:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9A5C061574;
        Tue, 22 Jun 2021 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VJ2esG0liuGs8jgyUr68eN07gNoWvxV3G50HQb1sM4g=; b=cOfy19L9cTDCWcJMJNuU5ZEd53
        eJbCtMjBzOyQtj1Ix2bbO7ZUEh8IRfEoPhlHxRgayQiQDPu5ZZxABTmHwP2Zo8ktj2pEN6hfS5U08
        YC8uey9a49caZ6Gi3M5xNpUfkNShCkh2PBooFNb8ILXT1FrASY1M5FQeh9527pmu+Uym1GsGyopEv
        WS1CHLW+h1mVquQKkBcPYL6UKtGqWv1XM48ShUxEh4BLKgmi5ykIgioWJyR41/UVsXbRAcuLoKNil
        b8Zhp0gPF/sVh6lVBk4QaU1mB7f0/N5ZelSH0muB1SY85iiDZI8fRHJJQY/4hSn7dBgdXXBFPNILo
        IgRSH62w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfdI-00EHhE-U3; Tue, 22 Jun 2021 12:36:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/46] mm/writeback: Add __folio_end_writeback()
Date:   Tue, 22 Jun 2021 13:15:29 +0100
Message-Id: <20210622121551.3398730-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

test_clear_page_writeback() is actually an mm-internal function, although
it's named as if it's a pagecache function.  Move it to mm/internal.h,
rename it to __folio_end_writeback() and change the return type to bool.

The conversion from page to folio is mostly about accounting the number
of pages being written back, although it does eliminate a couple of
calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h |  1 -
 mm/filemap.c               |  2 +-
 mm/internal.h              |  1 +
 mm/page-writeback.c        | 29 +++++++++++++++--------------
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 50df34886537..bdf807c98736 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -646,7 +646,6 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int test_clear_page_writeback(struct page *page);
 int __test_set_page_writeback(struct page *page, bool keep_write);
 
 #define test_set_page_writeback(page)			\
diff --git a/mm/filemap.c b/mm/filemap.c
index 4b2698e5e8e2..dd360721c72b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1535,7 +1535,7 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake().
 	 */
 	folio_get(folio);
-	if (!test_clear_page_writeback(&folio->page))
+	if (!__folio_end_writeback(folio))
 		BUG();
 
 	smp_mb__after_atomic();
diff --git a/mm/internal.h b/mm/internal.h
index 3e70121c71c7..d7013df5d1f0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -43,6 +43,7 @@ static inline void *folio_rmapping(struct folio *folio)
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
+bool __folio_end_writeback(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index dc66ff78f033..9213b8b6d50b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -588,7 +588,7 @@ static void wb_domain_writeout_add(struct wb_domain *dom,
 
 /*
  * Increment @wb's writeout completion count and the global writeout
- * completion count. Called from test_clear_page_writeback().
+ * completion count. Called from __folio_end_writeback().
  */
 static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
 {
@@ -2727,27 +2727,28 @@ int clear_page_dirty_for_io(struct page *page)
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
-int test_clear_page_writeback(struct page *page)
+bool __folio_end_writeback(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping(page);
-	int ret;
+	long nr = folio_nr_pages(folio);
+	struct address_space *mapping = folio_mapping(folio);
+	bool ret;
 
-	lock_page_memcg(page);
+	lock_folio_memcg(folio);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 		unsigned long flags;
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
-		ret = TestClearPageWriteback(page);
+		ret = folio_test_clear_writeback_flag(folio);
 		if (ret) {
-			__xa_clear_mark(&mapping->i_pages, page_index(page),
+			__xa_clear_mark(&mapping->i_pages, folio_index(folio),
 						PAGECACHE_TAG_WRITEBACK);
 			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
 				struct bdi_writeback *wb = inode_to_wb(inode);
 
-				dec_wb_stat(wb, WB_WRITEBACK);
-				__wb_writeout_add(wb, 1);
+				wb_stat_mod(wb, WB_WRITEBACK, -nr);
+				__wb_writeout_add(wb, nr);
 			}
 		}
 
@@ -2757,14 +2758,14 @@ int test_clear_page_writeback(struct page *page)
 
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 	} else {
-		ret = TestClearPageWriteback(page);
+		ret = folio_test_clear_writeback_flag(folio);
 	}
 	if (ret) {
-		dec_lruvec_page_state(page, NR_WRITEBACK);
-		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-		inc_node_page_state(page, NR_WRITTEN);
+		lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
+		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
+		node_stat_mod_folio(folio, NR_WRITTEN, nr);
 	}
-	unlock_page_memcg(page);
+	unlock_folio_memcg(folio);
 	return ret;
 }
 
-- 
2.30.2

