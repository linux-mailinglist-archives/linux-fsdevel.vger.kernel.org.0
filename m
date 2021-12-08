Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1846CC5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbhLHE0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbhLHE0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66206C061746
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4psUQu6RuoXUhrQ0CbS9UHTUdKcuRu/NAS8iw81NOmc=; b=uvvHK4RKM9GjSjDbGwABrt6EAG
        aO/qS04z5yWmrttjUhTXicFRC3TEHCj0FSTWlvYM+n4LYgJEyvQGOwHCnX2jtcdkCNb8NyqIYD4Fp
        u/2P8DKGgOxtLxlBNZD6gUCkOB1KcVQZEMBjVwqV2uKi1pBmXlcWiMZ5bWErhQVy4aaO7YC8k7SyY
        rXR6GXmAaVkexfRsFb2EX30H3mkiJ6vOb+z4Prazxvla4K13aaJsqAwAahgF7/lNIRw9vHODSOm5i
        m2b9HPv9pn/6dGgnZT02QUlCTvchrKYQTPedFRuhHFUuU2A0DsPjNl7BcfzQ8ZnR1B3RSEaBYS1Zp
        Ke25fDLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU2-0084XW-OH; Wed, 08 Dec 2021 04:23:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 11/48] filemap: Add filemap_unaccount_folio()
Date:   Wed,  8 Dec 2021 04:22:19 +0000
Message-Id: <20211208042256.1923824-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace unaccount_page_cache_page() with filemap_unaccount_folio().
The bug handling path could be a bit more robust (eg taking into account
the mapcounts of tail pages), but it's really never supposed to happen.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  5 ---
 mm/filemap.c            | 70 ++++++++++++++++++++---------------------
 2 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 841f7ba62d7d..077b6f378666 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -884,11 +884,6 @@ static inline void __set_page_dirty(struct page *page,
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
index 38fb26e16b85..600b8c921a67 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -145,74 +145,74 @@ static void page_cache_delete(struct address_space *mapping,
 	mapping->nrpages -= nr;
 }
 
-static void unaccount_page_cache_page(struct address_space *mapping,
-				      struct page *page)
+static void filemap_unaccount_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	int nr;
+	long nr;
 
 	/*
 	 * if we're uptodate, flush out into the cleancache, otherwise
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
+		if (folio_test_pmd_mappable(folio))
+			__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, -nr);
+	} else if (folio_test_pmd_mappable(folio)) {
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
@@ -227,7 +227,7 @@ void __delete_from_page_cache(struct page *page, void *shadow)
 
 	trace_mm_filemap_delete_from_page_cache(page);
 
-	unaccount_page_cache_page(mapping, page);
+	filemap_unaccount_folio(mapping, folio);
 	page_cache_delete(mapping, folio, shadow);
 }
 
@@ -348,7 +348,7 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		trace_mm_filemap_delete_from_page_cache(pvec->pages[i]);
 
-		unaccount_page_cache_page(mapping, pvec->pages[i]);
+		filemap_unaccount_folio(mapping, page_folio(pvec->pages[i]));
 	}
 	page_cache_delete_batch(mapping, pvec);
 	xa_unlock_irq(&mapping->i_pages);
-- 
2.33.0

