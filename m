Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F532B22BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKMRoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 12:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKMRoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:44:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0F9C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 09:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zXBXdWGOa8aZq7qZEtDeCI4nUTppjYDTvJAwwuChnu8=; b=Ip9WTFG9vGygS2tMirn7fXTNb+
        Fm4fbPwBShSosRD/PwvnQk/0hhrsu7PHMKu4ycpcJNxzWHWlop5bmetNcVSugJLMDgv0zg6TDT40Q
        tKcww8W7IdlcBsd1ur8U7BVpE8PPqHNF4qrGEVWV3mxkCDKkud5bMao4k+QnDLCW/KqK735xYjaVJ
        01jQfGTqUp+3UQUh5GrkcC8VBYNf/6QI86KFA8RsBe9cLJXqXqXfXV8pZkOheUoxiKP4rtiLKo28z
        awVEX7miGT8OQC8F4D+5cIq4OEnDctKiPoydtilFz7trE8uImEC1JMv7G+xNqaQfnVOhP5hHWaIWw
        8+odvWRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdd7J-0000fP-9k; Fri, 13 Nov 2020 17:44:09 +0000
Date:   Fri, 13 Nov 2020 17:44:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: Are THPs the right model for the pagecache?
Message-ID: <20201113174409.GH17076@casper.infradead.org>
References: <20201113044652.GD17076@casper.infradead.org>
 <1c1fa264-41d8-49a4-e5ff-2a5bf03e711e@nvidia.com>
 <20201113123836.GE17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113123836.GE17076@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:38:36PM +0000, Matthew Wilcox wrote:
> So what if we had:
> 
> /* Cache memory */
> struct cmem {
> 	struct page pages[1];
> };

OK, that's a terrible name.  I went with 'folio' for this demonstration.
Other names suggested include album, sheaf and ream.

I think eventually we might get rid of the term 'compound pages'
altogether.  All compound pages become folios.

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2c775d7d52f8..7d0ec5c1c7ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -707,6 +707,21 @@ static inline void set_compound_order(struct page *page, unsigned int order)
 	page[1].compound_nr = 1U << order;
 }
 
+static inline unsigned int folio_order(struct folio *folio)
+{
+	return compound_order(folio->pages);
+}
+
+static inline unsigned long folio_nr_pages(struct folio *folio)
+{
+	return compound_nr(folio->pages);
+}
+
+static inline size_t folio_size(struct folio *folio)
+{
+	return PAGE_SIZE << folio_order(folio);
+}
+
 #include <linux/huge_mm.h>
 
 /*
@@ -814,9 +829,9 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
 extern void kvfree(const void *addr);
 extern void kvfree_sensitive(const void *addr, size_t len);
 
-static inline int head_compound_mapcount(struct page *head)
+static inline int folio_mapcount(struct folio *folio)
 {
-	return atomic_read(compound_mapcount_ptr(head)) + 1;
+	return atomic_read(folio_mapcount_ptr(folio)) + 1;
 }
 
 /*
@@ -827,8 +842,7 @@ static inline int head_compound_mapcount(struct page *head)
 static inline int compound_mapcount(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
-	page = compound_head(page);
-	return head_compound_mapcount(page);
+	return folio_mapcount(page_folio(page));
 }
 
 /*
@@ -934,16 +948,15 @@ static inline bool hpage_pincount_available(struct page *page)
 	return PageCompound(page) && compound_order(page) > 1;
 }
 
-static inline int head_compound_pincount(struct page *head)
+static inline int folio_pincount(struct folio *folio)
 {
-	return atomic_read(compound_pincount_ptr(head));
+	return atomic_read(folio_pincount_ptr(folio));
 }
 
 static inline int compound_pincount(struct page *page)
 {
 	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
-	page = compound_head(page);
-	return head_compound_pincount(page);
+	return folio_pincount(page_folio(page));
 }
 
 /* Returns the number of bytes in this potentially compound page. */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6681fca5011f..0161d7808d60 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -223,14 +223,35 @@ struct page {
 #endif
 } _struct_page_alignment;
 
-static inline atomic_t *compound_mapcount_ptr(struct page *page)
+/*
+ * A folio is a collection of pages.  There may be only one page in the folio.
+ */
+struct folio {
+	struct page pages[1];
+};
+
+static inline struct page *folio_page(struct folio *folio, pgoff_t index)
+{
+	return &folio->pages[index - folio->pages->index];
+}
+
+static inline struct folio *page_folio(struct page *page)
+{
+	unsigned long head = READ_ONCE(page->compound_head);
+
+	if (unlikely(head & 1))
+		return (struct folio *)(head - 1);
+	return (struct folio *)page;
+}
+
+static inline atomic_t *folio_mapcount_ptr(struct folio *folio)
 {
-	return &page[1].compound_mapcount;
+	return &folio->pages[1].compound_mapcount;
 }
 
-static inline atomic_t *compound_pincount_ptr(struct page *page)
+static inline atomic_t *folio_pincount_ptr(struct folio *folio)
 {
-	return &page[2].hpage_pinned_refcount;
+	return &folio->pages[2].hpage_pinned_refcount;
 }
 
 /*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0f762217a844..d2a259cd3771 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -652,7 +652,7 @@ static inline int PageTransCompound(struct page *page)
  */
 static inline int PageTransCompoundMap(struct page *page)
 {
-	struct page *head;
+	struct folio *folio;
 
 	if (!PageTransCompound(page))
 		return 0;
@@ -660,10 +660,10 @@ static inline int PageTransCompoundMap(struct page *page)
 	if (PageAnon(page))
 		return atomic_read(&page->_mapcount) < 0;
 
-	head = compound_head(page);
+	folio = page_folio(page);
 	/* File THP is PMD mapped and not PTE mapped */
 	return atomic_read(&page->_mapcount) ==
-	       atomic_read(compound_mapcount_ptr(head));
+	       atomic_read(folio_mapcount_ptr(folio));
 }
 
 /*
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 70085ca1a3fc..d4a353f30748 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -185,7 +185,11 @@ void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 
 static inline void page_dup_rmap(struct page *page, bool compound)
 {
-	atomic_inc(compound ? compound_mapcount_ptr(page) : &page->_mapcount);
+	VM_BUG_ON_PAGE(compound && PageTail(page), page);
+	if (compound)
+		atomic_inc(folio_mapcount_ptr(page_folio(page)));
+	else
+		atomic_inc(&page->_mapcount);
 }
 
 /*
diff --git a/mm/debug.c b/mm/debug.c
index 8a40b3fefbeb..ab807dc79c2c 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -44,7 +44,7 @@ const struct trace_print_flags vmaflag_names[] = {
 
 void __dump_page(struct page *page, const char *reason)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
 	struct address_space *mapping;
 	bool page_poisoned = PagePoisoned(page);
 	bool compound = PageCompound(page);
@@ -68,7 +68,8 @@ void __dump_page(struct page *page, const char *reason)
 		goto hex_only;
 	}
 
-	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
+	if (page < folio->pages ||
+	    (page >= folio->pages + MAX_ORDER_NR_PAGES)) {
 		/*
 		 * Corrupt page, so we cannot call page_mapping. Instead, do a
 		 * safe subset of the steps that page_mapping() does. Caution:
@@ -82,7 +83,7 @@ void __dump_page(struct page *page, const char *reason)
 			mapping = NULL;
 		else
 			mapping = (void *)(tmp & ~PAGE_MAPPING_FLAGS);
-		head = page;
+		folio = (struct folio *)page;
 		compound = false;
 	} else {
 		mapping = page_mapping(page);
@@ -93,21 +94,21 @@ void __dump_page(struct page *page, const char *reason)
 	 * page->_mapcount space in struct page is used by sl[aou]b pages to
 	 * encode own info.
 	 */
-	mapcount = PageSlab(head) ? 0 : page_mapcount(page);
+	mapcount = PageSlab(folio->pages) ? 0 : page_mapcount(page);
 
 	pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
-			page, page_ref_count(head), mapcount, mapping,
+			page, page_ref_count(folio->pages), mapcount, mapping,
 			page_to_pgoff(page), page_to_pfn(page));
 	if (compound) {
-		if (hpage_pincount_available(page)) {
-			pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
-					head, compound_order(head),
-					head_compound_mapcount(head),
-					head_compound_pincount(head));
+		if (hpage_pincount_available(folio->pages)) {
+			pr_warn("folio:%p order:%u mapcount:%d pincount:%d\n",
+					folio, folio_order(folio),
+					folio_mapcount(folio),
+					folio_pincount(folio));
 		} else {
-			pr_warn("head:%p order:%u compound_mapcount:%d\n",
-					head, compound_order(head),
-					head_compound_mapcount(head));
+			pr_warn("folio:%p order:%u mapcount:%d\n",
+					folio, folio_order(folio),
+					folio_mapcount(folio));
 		}
 	}
 	if (PageKsm(page))
@@ -166,16 +167,16 @@ void __dump_page(struct page *page, const char *reason)
 out_mapping:
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
-	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
-		page_cma ? " CMA" : "");
+	pr_warn("%sflags: %#lx(%pGp)%s\n", type, folio->pages->flags,
+			&(folio->pages->flags), page_cma ? " CMA" : "");
 
 hex_only:
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
-	if (head != page)
+	if (folio->pages != page)
 		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
-			sizeof(unsigned long), head,
+			sizeof(unsigned long), folio->pages,
 			sizeof(struct page), false);
 
 	if (reason)
diff --git a/mm/gup.c b/mm/gup.c
index 49c4eabca271..fc51c845bc82 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -29,35 +29,31 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
-static void hpage_pincount_add(struct page *page, int refs)
+static void folio_pincount_add(struct folio *folio, int refs)
 {
-	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
-	VM_BUG_ON_PAGE(page != compound_head(page), page);
-
-	atomic_add(refs, compound_pincount_ptr(page));
+	VM_BUG_ON_PAGE(!hpage_pincount_available(folio->pages), folio->pages);
+	atomic_add(refs, folio_pincount_ptr(folio));
 }
 
-static void hpage_pincount_sub(struct page *page, int refs)
+static void folio_pincount_sub(struct folio *folio, int refs)
 {
-	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
-	VM_BUG_ON_PAGE(page != compound_head(page), page);
-
-	atomic_sub(refs, compound_pincount_ptr(page));
+	VM_BUG_ON_PAGE(!hpage_pincount_available(folio->pages), folio->pages);
+	atomic_sub(refs, folio_pincount_ptr(folio));
 }
 
 /*
  * Return the compound head page with ref appropriately incremented,
  * or NULL if that failed.
  */
-static inline struct page *try_get_compound_head(struct page *page, int refs)
+static inline struct folio *try_get_folio(struct page *page, int refs)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
 
-	if (WARN_ON_ONCE(page_ref_count(head) < 0))
+	if (WARN_ON_ONCE(page_ref_count(folio->pages) < 0))
 		return NULL;
-	if (unlikely(!page_cache_add_speculative(head, refs)))
+	if (unlikely(!page_cache_add_speculative(folio->pages, refs)))
 		return NULL;
-	return head;
+	return folio;
 }
 
 /*
@@ -84,8 +80,9 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
 							  unsigned int flags)
 {
 	if (flags & FOLL_GET)
-		return try_get_compound_head(page, refs);
+		return try_get_folio(page, refs)->pages;
 	else if (flags & FOLL_PIN) {
+		struct folio *folio;
 		int orig_refs = refs;
 
 		/*
@@ -99,7 +96,7 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
 		/*
 		 * When pinning a compound page of order > 1 (which is what
 		 * hpage_pincount_available() checks for), use an exact count to
-		 * track it, via hpage_pincount_add/_sub().
+		 * track it, via folio_pincount_add/_sub().
 		 *
 		 * However, be sure to *also* increment the normal page refcount
 		 * field at least once, so that the page really is pinned.
@@ -107,17 +104,17 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
 		if (!hpage_pincount_available(page))
 			refs *= GUP_PIN_COUNTING_BIAS;
 
-		page = try_get_compound_head(page, refs);
-		if (!page)
+		folio = try_get_folio(page, refs);
+		if (!folio)
 			return NULL;
 
-		if (hpage_pincount_available(page))
-			hpage_pincount_add(page, refs);
+		if (hpage_pincount_available(folio->pages))
+			folio_pincount_add(folio, refs);
 
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
-				    orig_refs);
+		mod_node_page_state(page_pgdat(folio->pages),
+					NR_FOLL_PIN_ACQUIRED, orig_refs);
 
-		return page;
+		return folio->pages;
 	}
 
 	WARN_ON_ONCE(1);
@@ -152,62 +149,62 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
 	if (flags & FOLL_GET)
 		return try_get_page(page);
 	else if (flags & FOLL_PIN) {
+		struct folio *folio = page_folio(page);
 		int refs = 1;
 
-		page = compound_head(page);
-
-		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
+		if (WARN_ON_ONCE(page_ref_count(folio->pages) <= 0))
 			return false;
 
-		if (hpage_pincount_available(page))
-			hpage_pincount_add(page, 1);
+		if (hpage_pincount_available(folio->pages))
+			folio_pincount_add(folio, 1);
 		else
 			refs = GUP_PIN_COUNTING_BIAS;
 
 		/*
 		 * Similar to try_grab_compound_head(): even if using the
-		 * hpage_pincount_add/_sub() routines, be sure to
+		 * folio_pincount_add/_sub() routines, be sure to
 		 * *also* increment the normal page refcount field at least
 		 * once, so that the page really is pinned.
 		 */
-		page_ref_add(page, refs);
+		page_ref_add(folio->pages, refs);
 
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
+		mod_node_page_state(page_pgdat(folio->pages),
+				NR_FOLL_PIN_ACQUIRED, 1);
 	}
 
 	return true;
 }
 
 #ifdef CONFIG_DEV_PAGEMAP_OPS
-static bool __unpin_devmap_managed_user_page(struct page *page)
+static bool __unpin_devmap_managed_user_page(struct folio *folio)
 {
 	int count, refs = 1;
 
-	if (!page_is_devmap_managed(page))
+	if (!page_is_devmap_managed(folio->pages))
 		return false;
 
-	if (hpage_pincount_available(page))
-		hpage_pincount_sub(page, 1);
+	if (hpage_pincount_available(folio->pages))
+		folio_pincount_sub(folio, 1);
 	else
 		refs = GUP_PIN_COUNTING_BIAS;
 
-	count = page_ref_sub_return(page, refs);
+	count = page_ref_sub_return(folio->pages, refs);
 
-	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, 1);
+	mod_node_page_state(page_pgdat(folio->pages), NR_FOLL_PIN_RELEASED, 1);
 	/*
 	 * devmap page refcounts are 1-based, rather than 0-based: if
 	 * refcount is 1, then the page is free and the refcount is
 	 * stable because nobody holds a reference on the page.
 	 */
 	if (count == 1)
-		free_devmap_managed_page(page);
+		free_devmap_managed_page(folio->pages);
 	else if (!count)
-		__put_page(page);
+		__put_page(folio->pages);
 
 	return true;
 }
 #else
-static bool __unpin_devmap_managed_user_page(struct page *page)
+static bool __unpin_devmap_managed_user_page(struct folio *folio)
 {
 	return false;
 }
@@ -224,28 +221,27 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
  */
 void unpin_user_page(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	int refs = 1;
 
-	page = compound_head(page);
-
 	/*
 	 * For devmap managed pages we need to catch refcount transition from
 	 * GUP_PIN_COUNTING_BIAS to 1, when refcount reach one it means the
 	 * page is free and we need to inform the device driver through
 	 * callback. See include/linux/memremap.h and HMM for details.
 	 */
-	if (__unpin_devmap_managed_user_page(page))
+	if (__unpin_devmap_managed_user_page(folio))
 		return;
 
-	if (hpage_pincount_available(page))
-		hpage_pincount_sub(page, 1);
+	if (hpage_pincount_available(folio->pages))
+		folio_pincount_sub(folio, 1);
 	else
 		refs = GUP_PIN_COUNTING_BIAS;
 
-	if (page_ref_sub_and_test(page, refs))
-		__put_page(page);
+	if (page_ref_sub_and_test(folio->pages, refs))
+		__put_page(folio->pages);
 
-	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, 1);
+	mod_node_page_state(page_pgdat(folio->pages), NR_FOLL_PIN_RELEASED, 1);
 }
 EXPORT_SYMBOL(unpin_user_page);
 
@@ -2074,24 +2070,26 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
 
 static void put_compound_head(struct page *page, int refs, unsigned int flags)
 {
+	struct folio *folio = (struct folio *)page;
+
 	if (flags & FOLL_PIN) {
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
-				    refs);
+		mod_node_page_state(page_pgdat(folio->pages),
+				NR_FOLL_PIN_RELEASED, refs);
 
-		if (hpage_pincount_available(page))
-			hpage_pincount_sub(page, refs);
+		if (hpage_pincount_available(folio->pages))
+			folio_pincount_sub(folio, refs);
 		else
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
-	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
+	VM_BUG_ON_PAGE(page_ref_count(folio->pages) < refs, page);
 	/*
 	 * Calling put_page() for each ref is unnecessarily slow. Only the last
 	 * ref needs a put_page().
 	 */
 	if (refs > 1)
-		page_ref_sub(page, refs - 1);
-	put_page(page);
+		page_ref_sub(folio->pages, refs - 1);
+	put_page(folio->pages);
 }
 
 #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1bf51d3f2f2d..e145ba69aa81 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2152,6 +2152,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 
 	if (!pmd_migration) {
+		struct folio *folio = (struct folio *)page;
 		/*
 		 * Set PG_double_map before dropping compound_mapcount to avoid
 		 * false-negative page_mapped().
@@ -2163,7 +2164,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		}
 
 		lock_page_memcg(page);
-		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
+		if (atomic_add_negative(-1, folio_mapcount_ptr(folio))) {
 			/* Last compound_mapcount is gone. */
 			__dec_lruvec_page_state(page, NR_ANON_THPS);
 			if (TestClearPageDoubleMap(page)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 16ef3d2346d5..19e3ccc2f5fd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1202,13 +1202,14 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 static void destroy_compound_gigantic_page(struct page *page,
 					unsigned int order)
 {
+	struct folio *folio = (struct folio *)page;
 	int i;
 	int nr_pages = 1 << order;
 	struct page *p = page + 1;
 
-	atomic_set(compound_mapcount_ptr(page), 0);
+	atomic_set(folio_mapcount_ptr(folio), 0);
 	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+		atomic_set(folio_pincount_ptr(folio), 0);
 
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		clear_compound_head(p);
@@ -1509,6 +1510,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 
 static void prep_compound_gigantic_page(struct page *page, unsigned int order)
 {
+	struct folio *folio = (struct folio *)page;
 	int i;
 	int nr_pages = 1 << order;
 	struct page *p = page + 1;
@@ -1534,10 +1536,10 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order)
 		set_page_count(p, 0);
 		set_compound_head(p, page);
 	}
-	atomic_set(compound_mapcount_ptr(page), -1);
+	atomic_set(folio_mapcount_ptr(folio), -1);
 
 	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+		atomic_set(folio_pincount_ptr(folio), 0);
 }
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b7a378197dae..48c8d84828dd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -693,6 +693,7 @@ void free_compound_page(struct page *page)
 
 void prep_compound_page(struct page *page, unsigned int order)
 {
+	struct folio *folio = (struct folio *)page;
 	int i;
 	int nr_pages = 1 << order;
 
@@ -706,9 +707,9 @@ void prep_compound_page(struct page *page, unsigned int order)
 
 	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
 	set_compound_order(page, order);
-	atomic_set(compound_mapcount_ptr(page), -1);
+	atomic_set(folio_mapcount_ptr(folio), -1);
 	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+		atomic_set(folio_pincount_ptr(folio), 0);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/mm/rmap.c b/mm/rmap.c
index 6657000b18d4..e90da98ac2f6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1120,11 +1120,11 @@ void do_page_add_anon_rmap(struct page *page,
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 
 	if (compound) {
-		atomic_t *mapcount;
+		struct folio *folio = page_folio(page);
+
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
-		mapcount = compound_mapcount_ptr(page);
-		first = atomic_inc_and_test(mapcount);
+		first = atomic_inc_and_test(folio_mapcount_ptr(folio));
 	} else {
 		first = atomic_inc_and_test(&page->_mapcount);
 	}
@@ -1174,11 +1174,13 @@ void page_add_new_anon_rmap(struct page *page,
 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
 	__SetPageSwapBacked(page);
 	if (compound) {
+		struct folio *folio = page_folio(page);
+
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		/* increment count (starts at -1) */
-		atomic_set(compound_mapcount_ptr(page), 0);
+		atomic_set(folio_mapcount_ptr(folio), 0);
 		if (hpage_pincount_available(page))
-			atomic_set(compound_pincount_ptr(page), 0);
+			atomic_set(folio_pincount_ptr(folio), 0);
 
 		__inc_lruvec_page_state(page, NR_ANON_THPS);
 	} else {
@@ -1200,6 +1202,7 @@ void page_add_new_anon_rmap(struct page *page,
  */
 void page_add_file_rmap(struct page *page, bool compound)
 {
+	struct folio *folio = page_folio(page);
 	int i, nr = 1;
 
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
@@ -1209,7 +1212,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 			if (atomic_inc_and_test(&page[i]._mapcount))
 				nr++;
 		}
-		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
+		if (!atomic_inc_and_test(folio_mapcount_ptr(folio)))
 			goto out;
 		if (PageSwapBacked(page))
 			__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
@@ -1219,9 +1222,9 @@ void page_add_file_rmap(struct page *page, bool compound)
 		if (PageTransCompound(page) && page_mapping(page)) {
 			VM_WARN_ON_ONCE(!PageLocked(page));
 
-			SetPageDoubleMap(compound_head(page));
+			SetPageDoubleMap(folio->pages);
 			if (PageMlocked(page))
-				clear_page_mlock(compound_head(page));
+				clear_page_mlock(folio->pages);
 		}
 		if (!atomic_inc_and_test(&page->_mapcount))
 			goto out;
@@ -1233,6 +1236,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 
 static void page_remove_file_rmap(struct page *page, bool compound)
 {
+	struct folio *folio = page_folio(page);
 	int i, nr = 1;
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
@@ -1240,7 +1244,7 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 	/* Hugepages are not counted in NR_FILE_MAPPED for now. */
 	if (unlikely(PageHuge(page))) {
 		/* hugetlb pages are always mapped with pmds */
-		atomic_dec(compound_mapcount_ptr(page));
+		atomic_dec(folio_mapcount_ptr(folio));
 		return;
 	}
 
@@ -1250,7 +1254,7 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 			if (atomic_add_negative(-1, &page[i]._mapcount))
 				nr++;
 		}
-		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
+		if (!atomic_add_negative(-1, folio_mapcount_ptr(folio)))
 			return;
 		if (PageSwapBacked(page))
 			__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
@@ -1274,9 +1278,10 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 
 static void page_remove_anon_compound_rmap(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	int i, nr;
 
-	if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
+	if (!atomic_add_negative(-1, folio_mapcount_ptr(folio)))
 		return;
 
 	/* Hugepages are not counted in NR_ANON_PAGES for now. */
@@ -1965,7 +1970,7 @@ void hugepage_add_anon_rmap(struct page *page,
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!anon_vma);
 	/* address might be in next vma when migration races vma_adjust */
-	first = atomic_inc_and_test(compound_mapcount_ptr(page));
+	first = atomic_inc_and_test(folio_mapcount_ptr(page_folio(page)));
 	if (first)
 		__page_set_anon_rmap(page, vma, address, 0);
 }
@@ -1973,10 +1978,12 @@ void hugepage_add_anon_rmap(struct page *page,
 void hugepage_add_new_anon_rmap(struct page *page,
 			struct vm_area_struct *vma, unsigned long address)
 {
+	struct folio *folio = page_folio(page);
+
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
-	atomic_set(compound_mapcount_ptr(page), 0);
+	atomic_set(folio_mapcount_ptr(folio), 0);
 	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+		atomic_set(folio_pincount_ptr(folio), 0);
 
 	__page_set_anon_rmap(page, vma, address, 1);
 }
diff --git a/mm/util.c b/mm/util.c
index 4ddb6e186dd5..a386908a92f1 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -646,17 +646,18 @@ void *page_rmapping(struct page *page)
  */
 bool page_mapped(struct page *page)
 {
+	struct folio *folio;
 	int i;
 
 	if (likely(!PageCompound(page)))
 		return atomic_read(&page->_mapcount) >= 0;
-	page = compound_head(page);
-	if (atomic_read(compound_mapcount_ptr(page)) >= 0)
+	folio = page_folio(page);
+	if (atomic_read(folio_mapcount_ptr(folio)) >= 0)
 		return true;
-	if (PageHuge(page))
+	if (PageHuge(folio->pages))
 		return false;
-	for (i = 0; i < compound_nr(page); i++) {
-		if (atomic_read(&page[i]._mapcount) >= 0)
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		if (atomic_read(&folio->pages[i]._mapcount) >= 0)
 			return true;
 	}
 	return false;
@@ -712,6 +713,7 @@ struct address_space *page_mapping_file(struct page *page)
 /* Slow path of page_mapcount() for compound pages */
 int __page_mapcount(struct page *page)
 {
+	struct folio *folio;
 	int ret;
 
 	ret = atomic_read(&page->_mapcount) + 1;
@@ -721,9 +723,9 @@ int __page_mapcount(struct page *page)
 	 */
 	if (!PageAnon(page) && !PageHuge(page))
 		return ret;
-	page = compound_head(page);
-	ret += atomic_read(compound_mapcount_ptr(page)) + 1;
-	if (PageDoubleMap(page))
+	folio = page_folio(page);
+	ret += atomic_read(folio_mapcount_ptr(folio)) + 1;
+	if (PageDoubleMap(folio->pages))
 		ret--;
 	return ret;
 }
