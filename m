Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0B3C4252
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhGLD4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhGLD4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:56:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A15C0613EE;
        Sun, 11 Jul 2021 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+nZEGTcNs+gCbccOaGsuodCnZXSwmevxIJ7b3HXMVLw=; b=GzC0Bsb/2zYi8rrTt+VKl1roU1
        Yehf/vliOYoPUjC0rM6x64h7Aj14CBDeShTBuRxGZ2K6SA0wTHisx2qKWq51ZfM2+Qu6f4L9N387r
        SRoVovKhoxVcH4B0avdeoiFb+7GERUZYJ1Hwx+cyPTFiRM3lbkKN3nVZyzRvcc9vjpGGbsMyhbnnM
        vo1DF8AiAFtjs8O6TbICs7Txm7zJiZod4XTap8zf5/Ln8rW64Z4UFXI701zMPyjAguab6poTd7r8T
        /cJ44uBiei2j7aQbWOs8cLOpymHS0FdkGwpUT1KoVSctSWFA5mDHGmB6DznNUELXhPhbnJrgzDwwr
        hMJCKbCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mzd-00Gpxa-EN; Mon, 12 Jul 2021 03:52:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 085/137] mm/filemap: Add filemap_add_folio()
Date:   Mon, 12 Jul 2021 04:06:09 +0100
Message-Id: <20210712030701.4000097-86-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert __add_to_page_cache_locked() into __filemap_add_folio().
Add an assertion to it that (for !hugetlbfs), the folio is naturally
aligned within the file.  Move the prototype from mm.h to pagemap.h.
Convert add_to_page_cache_lru() into filemap_add_folio().  Add a
compatibility wrapper for unconverted callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h      |  7 -----
 include/linux/pagemap.h | 10 ++++--
 kernel/bpf/verifier.c   |  2 +-
 mm/filemap.c            | 70 ++++++++++++++++++++---------------------
 mm/folio-compat.c       |  7 +++++
 5 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 862b5be4583e..24c2b4b97176 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -213,13 +213,6 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
-/*
- * Any attempt to mark this function as static leads to build failure
- * when CONFIG_DEBUG_INFO_BTF is enabled because __add_to_page_cache_locked()
- * is referred to by BPF code. This must be visible for error injection.
- */
-int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
-		pgoff_t index, gfp_t gfp, void **shadowp);
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5c9d8235fc4e..5a2ac2fc6dfa 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -877,9 +877,11 @@ static inline int fault_in_pages_readable(const char __user *uaddr, int size)
 }
 
 int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
-				pgoff_t index, gfp_t gfp_mask);
+		pgoff_t index, gfp_t gfp);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				pgoff_t index, gfp_t gfp_mask);
+		pgoff_t index, gfp_t gfp);
+int filemap_add_folio(struct address_space *mapping, struct folio *folio,
+		pgoff_t index, gfp_t gfp);
 extern void delete_from_page_cache(struct page *page);
 extern void __delete_from_page_cache(struct page *page, void *shadow);
 void replace_page_cache_page(struct page *old, struct page *new);
@@ -904,6 +906,10 @@ static inline int add_to_page_cache(struct page *page,
 	return error;
 }
 
+/* Must be non-static for BPF error injection */
+int __filemap_add_folio(struct address_space *mapping, struct folio *folio,
+		pgoff_t index, gfp_t gfp, void **shadowp);
+
 /**
  * struct readahead_control - Describes a readahead request.
  *
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index be38bb930bf1..b9af09f86239 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13033,7 +13033,7 @@ BTF_SET_START(btf_non_sleepable_error_inject)
 /* Three functions below can be called from sleepable and non-sleepable context.
  * Assume non-sleepable from bpf safety point of view.
  */
-BTF_ID(func, __add_to_page_cache_locked)
+BTF_ID(func, __filemap_add_folio)
 BTF_ID(func, should_fail_alloc_page)
 BTF_ID(func, should_failslab)
 BTF_SET_END(btf_non_sleepable_error_inject)
diff --git a/mm/filemap.c b/mm/filemap.c
index 6e721b283cb5..8e102505da11 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -855,26 +855,25 @@ void replace_page_cache_page(struct page *old, struct page *new)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_page);
 
-noinline int __add_to_page_cache_locked(struct page *page,
-					struct address_space *mapping,
-					pgoff_t offset, gfp_t gfp,
-					void **shadowp)
+noinline int __filemap_add_folio(struct address_space *mapping,
+		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
-	XA_STATE(xas, &mapping->i_pages, offset);
-	int huge = PageHuge(page);
+	XA_STATE(xas, &mapping->i_pages, index);
+	int huge = folio_hugetlb(folio);
 	int error;
 	bool charged = false;
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
+	VM_BUG_ON_FOLIO(!folio_locked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_swapbacked(folio), folio);
 	mapping_set_update(&xas, mapping);
 
-	get_page(page);
-	page->mapping = mapping;
-	page->index = offset;
+	folio_get(folio);
+	folio->mapping = mapping;
+	folio->index = index;
 
 	if (!huge) {
-		error = mem_cgroup_charge(page_folio(page), NULL, gfp);
+		error = mem_cgroup_charge(folio, NULL, gfp);
+		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
 			goto error;
 		charged = true;
@@ -886,7 +885,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
 		void *entry, *old = NULL;
 
-		if (order > thp_order(page))
+		if (order > folio_order(folio))
 			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
 					order, gfp);
 		xas_lock_irq(&xas);
@@ -903,13 +902,13 @@ noinline int __add_to_page_cache_locked(struct page *page,
 				*shadowp = old;
 			/* entry may have been split before we acquired lock */
 			order = xa_get_order(xas.xa, xas.xa_index);
-			if (order > thp_order(page)) {
+			if (order > folio_order(folio)) {
 				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
 		}
 
-		xas_store(&xas, page);
+		xas_store(&xas, folio);
 		if (xas_error(&xas))
 			goto unlock;
 
@@ -917,7 +916,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 
 		/* hugetlb pages do not participate in page cache accounting */
 		if (!huge)
-			__inc_lruvec_page_state(page, NR_FILE_PAGES);
+			__lruvec_stat_add_folio(folio, NR_FILE_PAGES);
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp));
@@ -925,19 +924,19 @@ noinline int __add_to_page_cache_locked(struct page *page,
 	if (xas_error(&xas)) {
 		error = xas_error(&xas);
 		if (charged)
-			mem_cgroup_uncharge(page_folio(page));
+			mem_cgroup_uncharge(folio);
 		goto error;
 	}
 
-	trace_mm_filemap_add_to_page_cache(page);
+	trace_mm_filemap_add_to_page_cache(&folio->page);
 	return 0;
 error:
-	page->mapping = NULL;
+	folio->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
-	put_page(page);
+	folio_put(folio);
 	return error;
 }
-ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
+ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
 /**
  * add_to_page_cache_locked - add a locked page to the pagecache
@@ -954,39 +953,38 @@ ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
 int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 		pgoff_t offset, gfp_t gfp_mask)
 {
-	return __add_to_page_cache_locked(page, mapping, offset,
+	return __filemap_add_folio(mapping, page_folio(page), offset,
 					  gfp_mask, NULL);
 }
 EXPORT_SYMBOL(add_to_page_cache_locked);
 
-int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				pgoff_t offset, gfp_t gfp_mask)
+int filemap_add_folio(struct address_space *mapping, struct folio *folio,
+				pgoff_t index, gfp_t gfp)
 {
 	void *shadow = NULL;
 	int ret;
 
-	__SetPageLocked(page);
-	ret = __add_to_page_cache_locked(page, mapping, offset,
-					 gfp_mask, &shadow);
+	__folio_set_locked_flag(folio);
+	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
 	if (unlikely(ret))
-		__ClearPageLocked(page);
+		__folio_clear_locked_flag(folio);
 	else {
 		/*
-		 * The page might have been evicted from cache only
+		 * The folio might have been evicted from cache only
 		 * recently, in which case it should be activated like
-		 * any other repeatedly accessed page.
-		 * The exception is pages getting rewritten; evicting other
+		 * any other repeatedly accessed folio.
+		 * The exception is folios getting rewritten; evicting other
 		 * data from the working set, only to cache data that will
 		 * get overwritten with something else, is a waste of memory.
 		 */
-		WARN_ON_ONCE(PageActive(page));
-		if (!(gfp_mask & __GFP_WRITE) && shadow)
-			workingset_refault(page_folio(page), shadow);
-		lru_cache_add(page);
+		WARN_ON_ONCE(folio_active(folio));
+		if (!(gfp & __GFP_WRITE) && shadow)
+			workingset_refault(folio, shadow);
+		folio_add_lru(folio);
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
+EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 6de3cd78a4ae..6b19bc4ed6b0 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -108,3 +108,10 @@ void lru_cache_add(struct page *page)
 	folio_add_lru(page_folio(page));
 }
 EXPORT_SYMBOL(lru_cache_add);
+
+int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
+		pgoff_t index, gfp_t gfp)
+{
+	return filemap_add_folio(mapping, page_folio(page), index, gfp);
+}
+EXPORT_SYMBOL(add_to_page_cache_lru);
-- 
2.30.2

