Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800563C4225
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhGLDqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhGLDqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:46:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C6FC0613DD;
        Sun, 11 Jul 2021 20:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=s2GEfzQQTFJrrRxPqCWtq/LUX+dEnveRb0B0egMowy0=; b=FwKfVfIVz5LoSg84pd6z3GKUmD
        5HbQIIEXyyB9l0PPHdYbbxZrhJePsLwv+u/+kQcmmdmsjo/aXrtPqYz/mIbhuL0moer+HmB1LVfEs
        qDU/xQOizTEheA/s8sIW3YUVmCPPM3S1ORSy4aG6dSBUsbCq+WCwhYKkRvo1MB2eMWrZHGsRZ/GwG
        NTuBQu1zdajrBp+PvMZhUzklcJflAD9aW+SXCLBwg60Ser0fKjsuz0/2UUdxIa6Z3VPIRP5oStGXV
        b0IXYVBE+HKtVrYkjvDdSFHvC4lMFp7vkMDlLZB/M93gnlrVefgLodTvMRml4DRYcd4NOm56U9H3T
        9d7+2ZyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mps-00GpG1-BA; Mon, 12 Jul 2021 03:42:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 066/137] mm/writeback: Add __folio_end_writeback()
Date:   Mon, 12 Jul 2021 04:05:50 +0100
Message-Id: <20210712030701.4000097-67-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/page-flags.h |  1 -
 mm/filemap.c               |  2 +-
 mm/internal.h              |  1 +
 mm/page-writeback.c        | 29 +++++++++++++++--------------
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fb914468b302..fb5219ab9eee 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -655,7 +655,6 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int test_clear_page_writeback(struct page *page);
 int __test_set_page_writeback(struct page *page, bool keep_write);
 
 #define test_set_page_writeback(page)			\
diff --git a/mm/filemap.c b/mm/filemap.c
index cc21da4157f1..b04c91ad294c 100644
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
index fa31a7f0ed79..08e8a28994d1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -43,6 +43,7 @@ static inline void *folio_raw_mapping(struct folio *folio)
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
+bool __folio_end_writeback(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 1056ff779bfe..c173fc831d3a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -583,7 +583,7 @@ static void wb_domain_writeout_add(struct wb_domain *dom,
 
 /*
  * Increment @wb's writeout completion count and the global writeout
- * completion count. Called from test_clear_page_writeback().
+ * completion count. Called from __folio_end_writeback().
  */
 static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
 {
@@ -2731,27 +2731,28 @@ int clear_page_dirty_for_io(struct page *page)
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
+	folio_memcg_lock(folio);
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
 
@@ -2761,14 +2762,14 @@ int test_clear_page_writeback(struct page *page)
 
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
+	folio_memcg_unlock(folio);
 	return ret;
 }
 
-- 
2.30.2

