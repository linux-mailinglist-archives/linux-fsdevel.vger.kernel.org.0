Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6B53C633A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhGLTKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbhGLTKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:10:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741FC0613DD;
        Mon, 12 Jul 2021 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SVcfwXQHY1XLeHuK/r4BXcf/1sVfiEIq92ca88Kbpdo=; b=jcITyB9ioQ5FdiMo8SC6pTTI1n
        Qi9uiF2vAXB6Ty/sR0CkkjgYTExbusuSKBJDKFVbwQoQkoLMLv29hVeW/fDXlJ+qE9VT8zXoHiwHg
        kzLJiRT9YTIkny0Zmmzm3t5H5Jt6rfE4L4uXQ3JgPDC1ZMDV/pwSeZJqaTwNATknEetkWYe01COZv
        Dl3n2SaPSe4Fcif6bw+9JesSAEobhJYfQUvcNtvc2JFeX9U9nLcD60c9UnsuIRnrf9z+gvF//n/Wl
        OtKX2zViFfWSHLc6jVOixCMTnbO59CneQI1hSa8vW56r8rlRQZnCkDJEm1ip0JBhVX2eG1GdGas9f
        qf58udMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31GN-000LT4-FX; Mon, 12 Jul 2021 19:06:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 10/32] mm: Add folio flag manipulation functions
Date:   Mon, 12 Jul 2021 20:01:42 +0100
Message-Id: <20210712190204.80979-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712190204.80979-1-willy@infradead.org>
References: <20210712190204.80979-1-willy@infradead.org>
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

This saves 1684 bytes of text with the distro-derived config that
I'm testing due to removing a double call to compound_head() in
PageSwapCache().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/page-flags.h | 219 ++++++++++++++++++++++++++-----------
 1 file changed, 156 insertions(+), 63 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 70ede8345538..fb914468b302 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -143,6 +143,8 @@ enum pageflags {
 #endif
 	__NR_PAGEFLAGS,
 
+	PG_readahead = PG_reclaim,
+
 	/* Filesystems */
 	PG_checked = PG_owner_priv_1,
 
@@ -243,6 +245,15 @@ static inline void page_init_poison(struct page *page, size_t size)
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
@@ -287,36 +298,64 @@ static inline void page_init_poison(struct page *page, size_t size)
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
+{ return test_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
 static __always_inline int Page##uname(struct page *page)		\
-	{ return test_bit(PG_##lname, &policy(page, 0)->flags); }
+{ return test_bit(PG_##lname, &policy(page, 0)->flags); }
 
 #define SETPAGEFLAG(uname, lname, policy)				\
+static __always_inline							\
+void folio_set_##lname##_flag(struct folio *folio)			\
+{ set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }		\
 static __always_inline void SetPage##uname(struct page *page)		\
-	{ set_bit(PG_##lname, &policy(page, 1)->flags); }
+{ set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define CLEARPAGEFLAG(uname, lname, policy)				\
+static __always_inline							\
+void folio_clear_##lname##_flag(struct folio *folio)			\
+{ clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }		\
 static __always_inline void ClearPage##uname(struct page *page)		\
-	{ clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{ clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define __SETPAGEFLAG(uname, lname, policy)				\
+static __always_inline							\
+void __folio_set_##lname##_flag(struct folio *folio)			\
+{ __set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }		\
 static __always_inline void __SetPage##uname(struct page *page)		\
-	{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
+{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define __CLEARPAGEFLAG(uname, lname, policy)				\
+static __always_inline							\
+void __folio_clear_##lname##_flag(struct folio *folio)			\
+{ __clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
 static __always_inline void __ClearPage##uname(struct page *page)	\
-	{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTSETFLAG(uname, lname, policy)				\
+static __always_inline							\
+bool folio_test_set_##lname##_flag(struct folio *folio)			\
+{ return test_and_set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
 static __always_inline int TestSetPage##uname(struct page *page)	\
-	{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
+{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTCLEARFLAG(uname, lname, policy)				\
+static __always_inline							\
+bool folio_test_clear_##lname##_flag(struct folio *folio)		\
+{ return test_and_clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
 static __always_inline int TestClearPage##uname(struct page *page)	\
-	{ return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{ return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define PAGEFLAG(uname, lname, policy)					\
 	TESTPAGEFLAG(uname, lname, policy)				\
@@ -332,29 +371,37 @@ static __always_inline int TestClearPage##uname(struct page *page)	\
 	TESTSETFLAG(uname, lname, policy)				\
 	TESTCLEARFLAG(uname, lname, policy)
 
-#define TESTPAGEFLAG_FALSE(uname)					\
+#define TESTPAGEFLAG_FALSE(uname, lname)				\
+static inline bool folio_##lname(const struct folio *folio) { return 0; } \
 static inline int Page##uname(const struct page *page) { return 0; }
 
-#define SETPAGEFLAG_NOOP(uname)						\
+#define SETPAGEFLAG_NOOP(uname, lname)					\
+static inline void folio_set_##lname##_flag(struct folio *folio) { }	\
 static inline void SetPage##uname(struct page *page) {  }
 
-#define CLEARPAGEFLAG_NOOP(uname)					\
+#define CLEARPAGEFLAG_NOOP(uname, lname)				\
+static inline void folio_clear_##lname##_flag(struct folio *folio) { }	\
 static inline void ClearPage##uname(struct page *page) {  }
 
-#define __CLEARPAGEFLAG_NOOP(uname)					\
+#define __CLEARPAGEFLAG_NOOP(uname, lname)				\
+static inline void __folio_clear_##lname_flags(struct folio *folio) { }	\
 static inline void __ClearPage##uname(struct page *page) {  }
 
-#define TESTSETFLAG_FALSE(uname)					\
+#define TESTSETFLAG_FALSE(uname, lname)					\
+static inline bool folio_test_set_##lname##_flag(struct folio *folio)	\
+{ return 0; }								\
 static inline int TestSetPage##uname(struct page *page) { return 0; }
 
-#define TESTCLEARFLAG_FALSE(uname)					\
+#define TESTCLEARFLAG_FALSE(uname, lname)				\
+static inline bool folio_test_clear_##lname##_flag(struct folio *folio) \
+{ return 0; }								\
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
@@ -410,8 +457,8 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
 PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
-PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
-	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+PAGEFLAG(Readahead, readahead, PF_NO_COMPOUND)
+	TESTCLEARFLAG(Readahead, readahead, PF_NO_COMPOUND)
 
 #ifdef CONFIG_HIGHMEM
 /*
@@ -420,22 +467,25 @@ PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
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
@@ -447,14 +497,14 @@ PAGEFLAG(Mlocked, mlocked, PF_NO_TAIL)
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
@@ -463,7 +513,7 @@ TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
 extern bool take_page_off_buddy(struct page *page);
 #else
-PAGEFLAG_FALSE(HWPoison)
+PAGEFLAG_FALSE(HWPoison, hwpoison)
 #define __PG_HWPOISON 0
 #endif
 
@@ -477,7 +527,7 @@ PAGEFLAG(Idle, idle, PF_ANY)
 #ifdef CONFIG_KASAN_HW_TAGS
 PAGEFLAG(SkipKASanPoison, skip_kasan_poison, PF_HEAD)
 #else
-PAGEFLAG_FALSE(SkipKASanPoison)
+PAGEFLAG_FALSE(SkipKASanPoison, skip_kasan_poison)
 #endif
 
 /*
@@ -515,10 +565,14 @@ static __always_inline int PageMappingFlags(struct page *page)
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
@@ -534,30 +588,32 @@ static __always_inline int __PageMovable(struct page *page)
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
+	 * See folio_mark_uptodate() for the other side of the story.
 	 */
 	if (ret)
 		smp_rmb();
@@ -565,23 +621,36 @@ static inline int PageUptodate(struct page *page)
 	return ret;
 }
 
-static __always_inline void __SetPageUptodate(struct page *page)
+static inline int PageUptodate(struct page *page)
+{
+	return folio_uptodate(page_folio(page));
+}
+
+static __always_inline void __folio_mark_uptodate(struct folio *folio)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
 	smp_wmb();
-	__set_bit(PG_uptodate, &page->flags);
+	__set_bit(PG_uptodate, folio_flags(folio, 0));
 }
 
-static __always_inline void SetPageUptodate(struct page *page)
+static __always_inline void folio_mark_uptodate(struct folio *folio)
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
+	__folio_mark_uptodate((struct folio *)page);
+}
+
+static __always_inline void SetPageUptodate(struct page *page)
+{
+	folio_mark_uptodate((struct folio *)page);
 }
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
@@ -606,6 +675,17 @@ static inline void set_page_writeback_keepwrite(struct page *page)
 
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
@@ -629,12 +709,15 @@ static inline void ClearPageCompound(struct page *page)
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
@@ -650,6 +733,11 @@ static inline int PageTransHuge(struct page *page)
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
@@ -723,12 +811,12 @@ static inline int PageTransTail(struct page *page)
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
@@ -903,6 +991,11 @@ static inline int page_has_private(struct page *page)
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

