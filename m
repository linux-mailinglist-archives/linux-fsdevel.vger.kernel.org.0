Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E840373F5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhEEQQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhEEQQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:16:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368CBC061761;
        Wed,  5 May 2021 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HCHFPFpMO6w89YeJS3uTHTEqlau1AgGWm5bX1GSva3U=; b=drjG7i/tW72Gvr5/vCzkpwROrt
        7AjsyMLy2oRwNqkHp11x0aYZGWJtrQdfovtfGkxnJSjGWq47q9kFkSgkijLFmJKFCZIbDCuRmW88z
        5KkjczvuxGaTlKi26aCNtTY7+DkTltLrtwTa/Pa+hwOBGwWQCu7OVwBXRt8WkPxkiGz3/g/+MeloW
        AhvGC5APsa4LT3xcNjUm+1QUU4UF3riYJv8KX4ubpoxiBIuAexArvGcl10zj9F6qMK2goEY5zs33e
        BuPilz0WVOAS3T7IMUb+wOeDvwIDsE38s/0DYj0g+5u/uEOFHn9gfDYH+MeCGFdJaLst4fmJSfjcm
        gfXy+sTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKAd-000Zbr-AB; Wed, 05 May 2021 16:15:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 57/96] mm/writeback: Convert test_clear_page_writeback to __folio_end_writeback
Date:   Wed,  5 May 2021 16:05:49 +0100
Message-Id: <20210505150628.111735-58-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index ef8b7c6dc91c..a2e203b9f677 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -645,7 +645,6 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int test_clear_page_writeback(struct page *page);
 int __test_set_page_writeback(struct page *page, bool keep_write);
 
 #define test_set_page_writeback(page)			\
diff --git a/mm/filemap.c b/mm/filemap.c
index c77e0ba9098a..e6aa49e32255 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1531,7 +1531,7 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake().
 	 */
 	folio_get(folio);
-	if (!test_clear_page_writeback(&folio->page))
+	if (!__folio_end_writeback(folio))
 		BUG();
 
 	smp_mb__after_atomic();
diff --git a/mm/internal.h b/mm/internal.h
index 68d363a3a1f3..91c607b5c1af 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -36,6 +36,7 @@ void page_writeback_init(void);
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
+bool __folio_end_writeback(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 98efb3fc6466..9b8f39d124e7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -589,7 +589,7 @@ static void wb_domain_writeout_add(struct wb_domain *dom,
 
 /*
  * Increment @wb's writeout completion count and the global writeout
- * completion count. Called from test_clear_page_writeback().
+ * completion count. Called from __folio_end_writeback().
  */
 static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
 {
@@ -2719,27 +2719,28 @@ int clear_page_dirty_for_io(struct page *page)
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
 
@@ -2749,14 +2750,14 @@ int test_clear_page_writeback(struct page *page)
 
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

