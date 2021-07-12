Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27E33C4294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhGLEHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGLEHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:07:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F4C0613DD;
        Sun, 11 Jul 2021 21:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uZsGGWG+rSpbCqXszzdFKuZI71BFM59ASZbL8xCYl1A=; b=M47QOz7kVMOgAl7Cn+M4vBB1cN
        WwXATEOsLSc2SRGOzYkg4KYv3DFwkLaze1VHp9IukmXiBcw4xw3sY+Bnfs6/tUqrRWH+hxiWIQAYS
        1HpK3N2sI3u4qJu2TlxXnFBEcbA/dNMJdVkkWmYOocfHkPN0t1h2gZensqn+vPBka4CIHKLatRybA
        K70oypzyoJor/b1vUQcdUA3vIHtXM+V6ldd1ImcbN32P2C8vS5h+qjG9sbgKSgG9eQxhcGwm5tVhh
        ChQhazI+ofFIvcLmyncRoXOOiM9yfUxOlboQUa8JFwAS9FayuUNGB7vnRD+liAGGNOgfbo1gyI80K
        KVbBcBow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nAb-00GqmE-CU; Mon, 12 Jul 2021 04:04:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 108/137] mm/filemap: Convert unaccount_page_cache_page to filemap_unaccount_folio
Date:   Mon, 12 Jul 2021 04:06:32 +0100
Message-Id: <20210712030701.4000097-109-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index a9243fa697e8..4be3b6242d6b 100644
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
index 5b62e9ee46a2..bede1d754769 100644
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
+	if (folio_uptodate(folio) && folio_mappedtodisk(folio))
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
+	if (folio_hugetlb(folio))
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
+	if (folio_swapbacked(folio)) {
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
+	if (WARN_ON_ONCE(folio_dirty(folio)))
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

