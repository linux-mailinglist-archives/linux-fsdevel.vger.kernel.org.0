Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AB636FF84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhD3Ral (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3Ral (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:30:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0768C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XT5IkdG4ZUJYdh+DSTva/kc9Wz9L6hC9vpPnBCohInM=; b=jmHQzv+lSaGH8aPEQ2ACltQdcW
        xHhII8R1SYyytyUDB3ajA8W9GmHvNoo7M1a1H+fVGrFT/Jvpi4F1kX+o0NFZ/8FTVK7KWorKbVjWc
        H9GvPF4z1gvYhDi+7GBToTCvl5/akX9igfcII3QT4VM4bODX6duaGMoS2hvtP7sO/kVK0PdsA24RQ
        pM0/8znnrToz3zmqemPNOwQ8kRWPdrMyvn8PapLSWMSATmRReA4SzwAlaDXaAl49hFESj5bgG6sF4
        fsjekIWb18qn49Xx5gaC4ZfS+ue6LZOk+SEiCbAecNuwFnOQYo9TeYmEMn1v3qXByIqipAMdJYUkZ
        oD7DG57A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcWwY-00BJY1-Oz; Fri, 30 Apr 2021 17:28:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 08/27] mm: Add folio flag manipulation functions
Date:   Fri, 30 Apr 2021 18:22:16 +0100
Message-Id: <20210430172235.2695303-9-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430172235.2695303-1-willy@infradead.org>
References: <20210430172235.2695303-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These new functions are the folio analogues of the various PageFlags
functions.  If CONFIG_DEBUG_VM_PGFLAGS is enabled, we check the folio
is not a tail page at every invocation.  This will also catch the
PagePoisoned case as a poisoned page has every bit set, which would
include PageTail.

This saves 1727 bytes of text with the distro-derived config that
I'm testing due to removing a double call to compound_head() in
PageSwapCache().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/page-flags.h | 195 ++++++++++++++++++++++++++-----------
 1 file changed, 140 insertions(+), 55 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e069aa8b11b7..3f721431485e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -140,6 +140,8 @@ enum pageflags {
 #endif
 	__NR_PAGEFLAGS,
 
+	PG_readahead = PG_reclaim,
+
 	/* Filesystems */
 	PG_checked = PG_owner_priv_1,
 
@@ -239,6 +241,15 @@ static inline void page_init_poison(struct page *page, size_t size)
 }
 #endif
 
+static unsigned long *folio_flags(struct folio *folio, unsigned n)
+{
+	struct page *page = &folio->page;
+
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags), page);
+	return &page[n].flags;
+}
+
 /*
  * Page flags policies wrt compound pages
  *
@@ -283,34 +294,56 @@ static inline void page_init_poison(struct page *page, size_t size)
 		VM_BUG_ON_PGFLAGS(!PageHead(page), page);		\
 		PF_POISONED_CHECK(&page[1]); })
 
+/* Which page is the flag stored in */
+#define FOLIO_PF_ANY		0
+#define FOLIO_PF_HEAD		0
+#define FOLIO_PF_ONLY_HEAD	0
+#define FOLIO_PF_NO_TAIL	0
+#define FOLIO_PF_NO_COMPOUND	0
+#define FOLIO_PF_SECOND		1
+
 /*
  * Macros to create function definitions for page flags
  */
 #define TESTPAGEFLAG(uname, lname, policy)				\
+static __always_inline bool folio_##lname(struct folio *folio)		\
+	{ return test_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
 static __always_inline int Page##uname(struct page *page)		\
 	{ return test_bit(PG_##lname, &policy(page, 0)->flags); }
 
 #define SETPAGEFLAG(uname, lname, policy)				\
+static __always_inline void folio_set_##lname(struct folio *folio)	\
+	{ set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
 static __always_inline void SetPage##uname(struct page *page)		\
 	{ set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define CLEARPAGEFLAG(uname, lname, policy)				\
+static __always_inline void folio_clear_##lname(struct folio *folio)	\
+	{ clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
 static __always_inline void ClearPage##uname(struct page *page)		\
 	{ clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define __SETPAGEFLAG(uname, lname, policy)				\
+static __always_inline void __folio_set_##lname(struct folio *folio)	\
+	{ __set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
 static __always_inline void __SetPage##uname(struct page *page)		\
 	{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define __CLEARPAGEFLAG(uname, lname, policy)				\
+static __always_inline void __folio_clear_##lname(struct folio *folio)	\
+	{ __clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
 static __always_inline void __ClearPage##uname(struct page *page)	\
 	{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTSETFLAG(uname, lname, policy)				\
+static __always_inline bool folio_test_set_##lname(struct folio *folio)	\
+	{ return test_and_set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
 static __always_inline int TestSetPage##uname(struct page *page)	\
 	{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTCLEARFLAG(uname, lname, policy)				\
+static __always_inline bool folio_test_clear_##lname(struct folio *folio) \
+{ return test_and_clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
 static __always_inline int TestClearPage##uname(struct page *page)	\
 	{ return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
@@ -328,29 +361,35 @@ static __always_inline int TestClearPage##uname(struct page *page)	\
 	TESTSETFLAG(uname, lname, policy)				\
 	TESTCLEARFLAG(uname, lname, policy)
 
-#define TESTPAGEFLAG_FALSE(uname)					\
+#define TESTPAGEFLAG_FALSE(uname, lname)				\
+static inline bool folio_##lname(const struct folio *folio) { return 0; } \
 static inline int Page##uname(const struct page *page) { return 0; }
 
-#define SETPAGEFLAG_NOOP(uname)						\
+#define SETPAGEFLAG_NOOP(uname, lname)					\
+static inline void folio_set_##lname(struct folio *folio) { }		\
 static inline void SetPage##uname(struct page *page) {  }
 
-#define CLEARPAGEFLAG_NOOP(uname)					\
+#define CLEARPAGEFLAG_NOOP(uname, lname)				\
+static inline void folio_clear_##lname(struct folio *folio) { }		\
 static inline void ClearPage##uname(struct page *page) {  }
 
-#define __CLEARPAGEFLAG_NOOP(uname)					\
+#define __CLEARPAGEFLAG_NOOP(uname, lname)				\
+static inline void __folio_clear_##lname(struct folio *folio) { }	\
 static inline void __ClearPage##uname(struct page *page) {  }
 
-#define TESTSETFLAG_FALSE(uname)					\
+#define TESTSETFLAG_FALSE(uname, lname)					\
+static inline bool folio_test_set_##lname(struct folio *folio) { return 0; } \
 static inline int TestSetPage##uname(struct page *page) { return 0; }
 
-#define TESTCLEARFLAG_FALSE(uname)					\
+#define TESTCLEARFLAG_FALSE(uname, lname)				\
+static inline bool folio_test_clear_##lname(struct folio *folio) { return 0; } \
 static inline int TestClearPage##uname(struct page *page) { return 0; }
 
-#define PAGEFLAG_FALSE(uname) TESTPAGEFLAG_FALSE(uname)			\
-	SETPAGEFLAG_NOOP(uname) CLEARPAGEFLAG_NOOP(uname)
+#define PAGEFLAG_FALSE(uname, lname) TESTPAGEFLAG_FALSE(uname, lname)	\
+	SETPAGEFLAG_NOOP(uname, lname) CLEARPAGEFLAG_NOOP(uname, lname)
 
-#define TESTSCFLAG_FALSE(uname)						\
-	TESTSETFLAG_FALSE(uname) TESTCLEARFLAG_FALSE(uname)
+#define TESTSCFLAG_FALSE(uname, lname)					\
+	TESTSETFLAG_FALSE(uname, lname) TESTCLEARFLAG_FALSE(uname, lname)
 
 __PAGEFLAG(Locked, locked, PF_NO_TAIL)
 PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
@@ -406,8 +445,8 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
 PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
-PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
-	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+PAGEFLAG(Readahead, readahead, PF_NO_COMPOUND)
+	TESTCLEARFLAG(Readahead, readahead, PF_NO_COMPOUND)
 
 #ifdef CONFIG_HIGHMEM
 /*
@@ -416,22 +455,25 @@ PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
  */
 #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
 #else
-PAGEFLAG_FALSE(HighMem)
+PAGEFLAG_FALSE(HighMem, highmem)
 #endif
 
 #ifdef CONFIG_SWAP
-static __always_inline int PageSwapCache(struct page *page)
+static __always_inline bool folio_swapcache(struct folio *folio)
 {
-#ifdef CONFIG_THP_SWAP
-	page = compound_head(page);
-#endif
-	return PageSwapBacked(page) && test_bit(PG_swapcache, &page->flags);
+	return folio_swapbacked(folio) &&
+			test_bit(PG_swapcache, folio_flags(folio, 0));
+}
 
+static __always_inline bool PageSwapCache(struct page *page)
+{
+	return folio_swapcache(page_folio(page));
 }
+
 SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
 CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
 #else
-PAGEFLAG_FALSE(SwapCache)
+PAGEFLAG_FALSE(SwapCache, swapcache)
 #endif
 
 PAGEFLAG(Unevictable, unevictable, PF_HEAD)
@@ -443,14 +485,14 @@ PAGEFLAG(Mlocked, mlocked, PF_NO_TAIL)
 	__CLEARPAGEFLAG(Mlocked, mlocked, PF_NO_TAIL)
 	TESTSCFLAG(Mlocked, mlocked, PF_NO_TAIL)
 #else
-PAGEFLAG_FALSE(Mlocked) __CLEARPAGEFLAG_NOOP(Mlocked)
-	TESTSCFLAG_FALSE(Mlocked)
+PAGEFLAG_FALSE(Mlocked, mlocked) __CLEARPAGEFLAG_NOOP(Mlocked, mlocked)
+	TESTSCFLAG_FALSE(Mlocked, mlocked)
 #endif
 
 #ifdef CONFIG_ARCH_USES_PG_UNCACHED
 PAGEFLAG(Uncached, uncached, PF_NO_COMPOUND)
 #else
-PAGEFLAG_FALSE(Uncached)
+PAGEFLAG_FALSE(Uncached, uncached)
 #endif
 
 #ifdef CONFIG_MEMORY_FAILURE
@@ -459,7 +501,7 @@ TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
 extern bool take_page_off_buddy(struct page *page);
 #else
-PAGEFLAG_FALSE(HWPoison)
+PAGEFLAG_FALSE(HWPoison, hwpoison)
 #define __PG_HWPOISON 0
 #endif
 
@@ -505,10 +547,14 @@ static __always_inline int PageMappingFlags(struct page *page)
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
-static __always_inline int PageAnon(struct page *page)
+static __always_inline bool folio_anon(struct folio *folio)
+{
+	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
+}
+
+static __always_inline bool PageAnon(struct page *page)
 {
-	page = compound_head(page);
-	return ((unsigned long)page->mapping & PAGE_MAPPING_ANON) != 0;
+	return folio_anon(page_folio(page));
 }
 
 static __always_inline int __PageMovable(struct page *page)
@@ -524,30 +570,32 @@ static __always_inline int __PageMovable(struct page *page)
  * is found in VM_MERGEABLE vmas.  It's a PageAnon page, pointing not to any
  * anon_vma, but to that page's node of the stable tree.
  */
-static __always_inline int PageKsm(struct page *page)
+static __always_inline bool folio_ksm(struct folio *folio)
 {
-	page = compound_head(page);
-	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
+	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
 				PAGE_MAPPING_KSM;
 }
+
+static __always_inline bool PageKsm(struct page *page)
+{
+	return folio_ksm(page_folio(page));
+}
 #else
-TESTPAGEFLAG_FALSE(Ksm)
+TESTPAGEFLAG_FALSE(Ksm, ksm)
 #endif
 
 u64 stable_page_flags(struct page *page);
 
-static inline int PageUptodate(struct page *page)
+static inline bool folio_uptodate(struct folio *folio)
 {
-	int ret;
-	page = compound_head(page);
-	ret = test_bit(PG_uptodate, &(page)->flags);
+	bool ret = test_bit(PG_uptodate, folio_flags(folio, 0));
 	/*
-	 * Must ensure that the data we read out of the page is loaded
-	 * _after_ we've loaded page->flags to check for PageUptodate.
-	 * We can skip the barrier if the page is not uptodate, because
+	 * Must ensure that the data we read out of the folio is loaded
+	 * _after_ we've loaded folio->flags to check the uptodate bit.
+	 * We can skip the barrier if the folio is not uptodate, because
 	 * we wouldn't be reading anything from it.
 	 *
-	 * See SetPageUptodate() for the other side of the story.
+	 * See folio_set_uptodate() for the other side of the story.
 	 */
 	if (ret)
 		smp_rmb();
@@ -555,23 +603,36 @@ static inline int PageUptodate(struct page *page)
 	return ret;
 }
 
-static __always_inline void __SetPageUptodate(struct page *page)
+static inline int PageUptodate(struct page *page)
+{
+	return folio_uptodate(page_folio(page));
+}
+
+static __always_inline void __folio_set_uptodate(struct folio *folio)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
 	smp_wmb();
-	__set_bit(PG_uptodate, &page->flags);
+	__set_bit(PG_uptodate, folio_flags(folio, 0));
 }
 
-static __always_inline void SetPageUptodate(struct page *page)
+static __always_inline void folio_set_uptodate(struct folio *folio)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
 	/*
 	 * Memory barrier must be issued before setting the PG_uptodate bit,
-	 * so that all previous stores issued in order to bring the page
-	 * uptodate are actually visible before PageUptodate becomes true.
+	 * so that all previous stores issued in order to bring the folio
+	 * uptodate are actually visible before folio_uptodate becomes true.
 	 */
 	smp_wmb();
-	set_bit(PG_uptodate, &page->flags);
+	set_bit(PG_uptodate, folio_flags(folio, 0));
+}
+
+static __always_inline void __SetPageUptodate(struct page *page)
+{
+	__folio_set_uptodate((struct folio *)page);
+}
+
+static __always_inline void SetPageUptodate(struct page *page)
+{
+	folio_set_uptodate((struct folio *)page);
 }
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
@@ -596,6 +657,17 @@ static inline void set_page_writeback_keepwrite(struct page *page)
 
 __PAGEFLAG(Head, head, PF_ANY) CLEARPAGEFLAG(Head, head, PF_ANY)
 
+/* Whether there are one or multiple pages in a folio */
+static inline bool folio_single(struct folio *folio)
+{
+	return !folio_head(folio);
+}
+
+static inline bool folio_multi(struct folio *folio)
+{
+	return folio_head(folio);
+}
+
 static __always_inline void set_compound_head(struct page *page, struct page *head)
 {
 	WRITE_ONCE(page->compound_head, (unsigned long)head + 1);
@@ -619,12 +691,15 @@ static inline void ClearPageCompound(struct page *page)
 #ifdef CONFIG_HUGETLB_PAGE
 int PageHuge(struct page *page);
 int PageHeadHuge(struct page *page);
+static inline bool folio_hugetlb(struct folio *folio)
+{
+	return PageHeadHuge(&folio->page);
+}
 #else
-TESTPAGEFLAG_FALSE(Huge)
-TESTPAGEFLAG_FALSE(HeadHuge)
+TESTPAGEFLAG_FALSE(Huge, hugetlb)
+TESTPAGEFLAG_FALSE(HeadHuge, headhuge)
 #endif
 
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for
@@ -640,6 +715,11 @@ static inline int PageTransHuge(struct page *page)
 	return PageHead(page);
 }
 
+static inline bool folio_transhuge(struct folio *folio)
+{
+	return folio_head(folio);
+}
+
 /*
  * PageTransCompound returns true for both transparent huge pages
  * and hugetlbfs pages, so it should only be called when it's known
@@ -713,12 +793,12 @@ static inline int PageTransTail(struct page *page)
 PAGEFLAG(DoubleMap, double_map, PF_SECOND)
 	TESTSCFLAG(DoubleMap, double_map, PF_SECOND)
 #else
-TESTPAGEFLAG_FALSE(TransHuge)
-TESTPAGEFLAG_FALSE(TransCompound)
-TESTPAGEFLAG_FALSE(TransCompoundMap)
-TESTPAGEFLAG_FALSE(TransTail)
-PAGEFLAG_FALSE(DoubleMap)
-	TESTSCFLAG_FALSE(DoubleMap)
+TESTPAGEFLAG_FALSE(TransHuge, transhuge)
+TESTPAGEFLAG_FALSE(TransCompound, transcompound)
+TESTPAGEFLAG_FALSE(TransCompoundMap, transcompoundmap)
+TESTPAGEFLAG_FALSE(TransTail, transtail)
+PAGEFLAG_FALSE(DoubleMap, double_map)
+	TESTSCFLAG_FALSE(DoubleMap, double_map)
 #endif
 
 /*
@@ -871,6 +951,11 @@ static inline int page_has_private(struct page *page)
 	return !!(page->flags & PAGE_FLAGS_PRIVATE);
 }
 
+static inline bool folio_has_private(struct folio *folio)
+{
+	return page_has_private(&folio->page);
+}
+
 #undef PF_ANY
 #undef PF_HEAD
 #undef PF_ONLY_HEAD
-- 
2.30.2

