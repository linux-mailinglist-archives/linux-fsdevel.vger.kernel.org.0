Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364BE3C980C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhGOFKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGOFKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:10:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B6DC06175F;
        Wed, 14 Jul 2021 22:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rvTEmkdIr5f6LLESFOwDOAEdh30d4SNN6vwFx0IhGis=; b=XuEKhBf3eFELCw4F5wXteSTCxG
        1jIIBkJfEGyJT10SVbrL+vFAi8IOQ91QCCy7bl8OVATIKjHqeiraaWpWdf/aWPpcc1y/KAUDAzl1J
        G2ozbJeZNJWmacacGLMNjtt6nk9MI6fJMae6AOQFY6CKv+BWxwfOomvpTbCaiBNuQ1ci3XMeFWvC9
        VlOwq+sXlnnShFTKPy+tQ6tgBsoP+t3ETx8BtA8NNDYay3I5nrLLqmB9aMS7yElz3op1MUbEv8JbF
        uI8p245a3LXl+OUeLwJg5uslsguNdMwiEsr+DsqJS2BoEUSned4sYVVkXUWuc4xCgKcuxI/cGdG+t
        eeRSdt+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tZE-002zuf-P2; Thu, 15 Jul 2021 05:06:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 109/138] mm/filemap: Convert unaccount_page_cache_page to filemap_unaccount_folio
Date:   Thu, 15 Jul 2021 04:36:35 +0100
Message-Id: <20210715033704.692967-110-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use folios throughout filemap_unaccount_folio(), except for the bug
handling path which would need to use total_mapcount(), which is currently
only defined for builds with THP enabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  5 ---
 mm/filemap.c            | 68 ++++++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 83c1a798265f..f6a2a2589009 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -786,11 +786,6 @@ static inline void __set_page_dirty(struct page *page,
 }
 void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
 			  struct bdi_writeback *wb);
-static inline void account_page_cleaned(struct page *page,
-		struct address_space *mapping, struct bdi_writeback *wb)
-{
-	return folio_account_cleaned(page_folio(page), mapping, wb);
-}
 void __folio_cancel_dirty(struct folio *folio);
 static inline void folio_cancel_dirty(struct folio *folio)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index c96febad32fc..6e8b195edf19 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -144,8 +144,8 @@ static void page_cache_delete(struct address_space *mapping,
 	mapping->nrpages -= nr;
 }
 
-static void unaccount_page_cache_page(struct address_space *mapping,
-				      struct page *page)
+static void filemap_unaccount_folio(struct address_space *mapping,
+		struct folio *folio)
 {
 	int nr;
 
@@ -154,64 +154,64 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 	 * invalidate any existing cleancache entries.  We can't leave
 	 * stale data around in the cleancache once our page is gone
 	 */
-	if (PageUptodate(page) && PageMappedToDisk(page))
-		cleancache_put_page(page);
+	if (folio_test_uptodate(folio) && folio_test_mappedtodisk(folio))
+		cleancache_put_page(&folio->page);
 	else
-		cleancache_invalidate_page(mapping, page);
+		cleancache_invalidate_page(mapping, &folio->page);
 
-	VM_BUG_ON_PAGE(PageTail(page), page);
-	VM_BUG_ON_PAGE(page_mapped(page), page);
-	if (!IS_ENABLED(CONFIG_DEBUG_VM) && unlikely(page_mapped(page))) {
+	VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
+	if (!IS_ENABLED(CONFIG_DEBUG_VM) && unlikely(folio_mapped(folio))) {
 		int mapcount;
 
 		pr_alert("BUG: Bad page cache in process %s  pfn:%05lx\n",
-			 current->comm, page_to_pfn(page));
-		dump_page(page, "still mapped when deleted");
+			 current->comm, folio_pfn(folio));
+		dump_page(&folio->page, "still mapped when deleted");
 		dump_stack();
 		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
-		mapcount = page_mapcount(page);
+		mapcount = page_mapcount(&folio->page);
 		if (mapping_exiting(mapping) &&
-		    page_count(page) >= mapcount + 2) {
+		    folio_ref_count(folio) >= mapcount + 2) {
 			/*
 			 * All vmas have already been torn down, so it's
-			 * a good bet that actually the page is unmapped,
+			 * a good bet that actually the folio is unmapped,
 			 * and we'd prefer not to leak it: if we're wrong,
 			 * some other bad page check should catch it later.
 			 */
-			page_mapcount_reset(page);
-			page_ref_sub(page, mapcount);
+			page_mapcount_reset(&folio->page);
+			folio_ref_sub(folio, mapcount);
 		}
 	}
 
-	/* hugetlb pages do not participate in page cache accounting. */
-	if (PageHuge(page))
+	/* hugetlb folios do not participate in page cache accounting. */
+	if (folio_test_hugetlb(folio))
 		return;
 
-	nr = thp_nr_pages(page);
+	nr = folio_nr_pages(folio);
 
-	__mod_lruvec_page_state(page, NR_FILE_PAGES, -nr);
-	if (PageSwapBacked(page)) {
-		__mod_lruvec_page_state(page, NR_SHMEM, -nr);
-		if (PageTransHuge(page))
-			__mod_lruvec_page_state(page, NR_SHMEM_THPS, -nr);
-	} else if (PageTransHuge(page)) {
-		__mod_lruvec_page_state(page, NR_FILE_THPS, -nr);
+	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
+	if (folio_test_swapbacked(folio)) {
+		__lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
+		if (folio_multi(folio))
+			__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, -nr);
+	} else if (folio_multi(folio)) {
+		__lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
 		filemap_nr_thps_dec(mapping);
 	}
 
 	/*
-	 * At this point page must be either written or cleaned by
-	 * truncate.  Dirty page here signals a bug and loss of
+	 * At this point folio must be either written or cleaned by
+	 * truncate.  Dirty folio here signals a bug and loss of
 	 * unwritten data.
 	 *
-	 * This fixes dirty accounting after removing the page entirely
-	 * but leaves PageDirty set: it has no effect for truncated
-	 * page and anyway will be cleared before returning page into
+	 * This fixes dirty accounting after removing the folio entirely
+	 * but leaves the dirty flag set: it has no effect for truncated
+	 * folio and anyway will be cleared before returning folio to
 	 * buddy allocator.
 	 */
-	if (WARN_ON_ONCE(PageDirty(page)))
-		account_page_cleaned(page, mapping, inode_to_wb(mapping->host));
+	if (WARN_ON_ONCE(folio_test_dirty(folio)))
+		folio_account_cleaned(folio, mapping,
+					inode_to_wb(mapping->host));
 }
 
 /*
@@ -226,7 +226,7 @@ void __delete_from_page_cache(struct page *page, void *shadow)
 
 	trace_mm_filemap_delete_from_page_cache(page);
 
-	unaccount_page_cache_page(mapping, page);
+	filemap_unaccount_folio(mapping, folio);
 	page_cache_delete(mapping, folio, shadow);
 }
 
@@ -344,7 +344,7 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		trace_mm_filemap_delete_from_page_cache(pvec->pages[i]);
 
-		unaccount_page_cache_page(mapping, pvec->pages[i]);
+		filemap_unaccount_folio(mapping, page_folio(pvec->pages[i]));
 	}
 	page_cache_delete_batch(mapping, pvec);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
-- 
2.30.2

