Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCDC30706B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhA1H5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhA1HFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:05:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D2C061788;
        Wed, 27 Jan 2021 23:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=so1n5HaGJSwB20TOq/BnhNrYvY4hN+2cCavv3Mvp+Xs=; b=GNGz+3N9c5ydJp7ZF622SY6R8l
        M5O68UiI3sqYxEZLONcx+xc8SThdcSvVxjaYxmJYaFwLrtiSD04YBKCAj/tavxl50UeHuOHo2Txzq
        SNWLTQtgR276GemwtbuATwUT678kRI/bcONpDn8OXOr+moj+ozQlkirSn3joRkuXMXIcIjkmKlFa2
        1h4Et5OOCBNztHD2i3rmU4XP8VbaMu4++UU/pPWloKbacNjpLs4VgsQt5TJKSlFmTlALb9ZhC0p3A
        +B/8Lbt3oXmTVvc/Ery8mAlVdOFQuszn/JCWweNq8kbvB43VC2oKldOOAtJl3mJWytgwe/QVKlzCv
        F4tiJqbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Ll-00847J-0G; Thu, 28 Jan 2021 07:04:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/25] mm: Create FolioFlags
Date:   Thu, 28 Jan 2021 07:03:46 +0000
Message-Id: <20210128070404.1922318-8-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These new functions are the folio analogues of the PageFlags functions.
If CONFIG_DEBUG_VM_PGFLAGS is enabled, we check the folio is not a
tail page at every invocation.  Note that this will also catch the
PagePoisoned case as a poisoned page has every bit set, which would
include PageTail.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/netfs.h      |   5 ++
 include/linux/page-flags.h | 104 ++++++++++++++++++++++++++++++-------
 2 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 2ffdef1ded91..887d259eb384 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -24,6 +24,11 @@
 #define ClearPageFsCache(page)		ClearPagePrivate2((page))
 #define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
 #define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
+#define FolioFsCache(page)		FolioPrivate2((page))
+#define SetFolioFsCache(page)		SetFolioPrivate2((page))
+#define ClearFolioFsCache(page)		ClearFolioPrivate2((page))
+#define TestSetFolioFsCache(page)	TestSetFolioPrivate2((page))
+#define TestClearFolioFsCache(page)	TestClearFolioPrivate2((page))
 
 enum netfs_read_source {
 	NETFS_FILL_WITH_ZEROES,
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 04a34c08e0a6..90381858d901 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -212,6 +212,12 @@ static inline void page_init_poison(struct page *page, size_t size)
 }
 #endif
 
+static unsigned long *folio_flags(struct folio *folio)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
+	return &folio->page.flags;
+}
+
 /*
  * Page flags policies wrt compound pages
  *
@@ -260,30 +266,44 @@ static inline void page_init_poison(struct page *page, size_t size)
  * Macros to create function definitions for page flags
  */
 #define TESTPAGEFLAG(uname, lname, policy)				\
+static __always_inline int Folio##uname(struct folio *folio)		\
+	{ return test_bit(PG_##lname, folio_flags(folio)); }		\
 static __always_inline int Page##uname(struct page *page)		\
 	{ return test_bit(PG_##lname, &policy(page, 0)->flags); }
 
 #define SETPAGEFLAG(uname, lname, policy)				\
+static __always_inline void SetFolio##uname(struct folio *folio)	\
+	{ set_bit(PG_##lname, folio_flags(folio)); }			\
 static __always_inline void SetPage##uname(struct page *page)		\
 	{ set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define CLEARPAGEFLAG(uname, lname, policy)				\
+static __always_inline void ClearFolio##uname(struct folio *folio)	\
+	{ clear_bit(PG_##lname, folio_flags(folio)); }			\
 static __always_inline void ClearPage##uname(struct page *page)		\
 	{ clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define __SETPAGEFLAG(uname, lname, policy)				\
+static __always_inline void __SetFolio##uname(struct folio *folio)	\
+	{ __set_bit(PG_##lname, folio_flags(folio)); }			\
 static __always_inline void __SetPage##uname(struct page *page)		\
 	{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define __CLEARPAGEFLAG(uname, lname, policy)				\
+static __always_inline void __ClearFolio##uname(struct folio *folio)	\
+	{ __clear_bit(PG_##lname, folio_flags(folio)); }		\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 	{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTSETFLAG(uname, lname, policy)				\
+static __always_inline int TestSetFolio##uname(struct folio *folio)	\
+	{ return test_and_set_bit(PG_##lname, folio_flags(folio)); }	\
 static __always_inline int TestSetPage##uname(struct page *page)	\
 	{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTCLEARFLAG(uname, lname, policy)				\
+static __always_inline int TestClearFolio##uname(struct folio *folio)	\
+	{ return test_and_clear_bit(PG_##lname, folio_flags(folio)); }	\
 static __always_inline int TestClearPage##uname(struct page *page)	\
 	{ return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
@@ -302,21 +322,27 @@ static __always_inline int TestClearPage##uname(struct page *page)	\
 	TESTCLEARFLAG(uname, lname, policy)
 
 #define TESTPAGEFLAG_FALSE(uname)					\
+static inline int Folio##uname(const struct folio *folio) { return 0; }	\
 static inline int Page##uname(const struct page *page) { return 0; }
 
 #define SETPAGEFLAG_NOOP(uname)						\
+static inline void SetFolio##uname(struct folio *folio) { }		\
 static inline void SetPage##uname(struct page *page) {  }
 
 #define CLEARPAGEFLAG_NOOP(uname)					\
+static inline void ClearFolio##uname(struct folio *folio) { }		\
 static inline void ClearPage##uname(struct page *page) {  }
 
 #define __CLEARPAGEFLAG_NOOP(uname)					\
+static inline void __ClearFolio##uname(struct folio *folio) { }		\
 static inline void __ClearPage##uname(struct page *page) {  }
 
 #define TESTSETFLAG_FALSE(uname)					\
+static inline int TestSetFolio##uname(struct folio *folio) { return 0; } \
 static inline int TestSetPage##uname(struct page *page) { return 0; }
 
 #define TESTCLEARFLAG_FALSE(uname)					\
+static inline int TestClearFolio##uname(struct folio *folio) { return 0; } \
 static inline int TestClearPage##uname(struct page *page) { return 0; }
 
 #define PAGEFLAG_FALSE(uname) TESTPAGEFLAG_FALSE(uname)			\
@@ -393,14 +419,18 @@ PAGEFLAG_FALSE(HighMem)
 #endif
 
 #ifdef CONFIG_SWAP
-static __always_inline int PageSwapCache(struct page *page)
+static __always_inline bool FolioSwapCache(struct folio *folio)
 {
-#ifdef CONFIG_THP_SWAP
-	page = compound_head(page);
-#endif
-	return PageSwapBacked(page) && test_bit(PG_swapcache, &page->flags);
+	return FolioSwapBacked(folio) &&
+			test_bit(PG_swapcache, folio_flags(folio));
 
 }
+
+static __always_inline bool PageSwapCache(struct page *page)
+{
+	return FolioSwapCache(page_folio(page));
+}
+
 SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
 CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
 #else
@@ -478,10 +508,14 @@ static __always_inline int PageMappingFlags(struct page *page)
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
-static __always_inline int PageAnon(struct page *page)
+static __always_inline bool FolioAnon(struct folio *folio)
 {
-	page = compound_head(page);
-	return ((unsigned long)page->mapping & PAGE_MAPPING_ANON) != 0;
+	return ((unsigned long)folio->page.mapping & PAGE_MAPPING_ANON) != 0;
+}
+
+static __always_inline bool PageAnon(struct page *page)
+{
+	return FolioAnon(page_folio(page));
 }
 
 static __always_inline int __PageMovable(struct page *page)
@@ -509,18 +543,16 @@ TESTPAGEFLAG_FALSE(Ksm)
 
 u64 stable_page_flags(struct page *page);
 
-static inline int PageUptodate(struct page *page)
+static inline int FolioUptodate(struct folio *folio)
 {
-	int ret;
-	page = compound_head(page);
-	ret = test_bit(PG_uptodate, &(page)->flags);
+	int ret = test_bit(PG_uptodate, folio_flags(folio));
 	/*
 	 * Must ensure that the data we read out of the page is loaded
 	 * _after_ we've loaded page->flags to check for PageUptodate.
 	 * We can skip the barrier if the page is not uptodate, because
 	 * we wouldn't be reading anything from it.
 	 *
-	 * See SetPageUptodate() for the other side of the story.
+	 * See SetFolioUptodate() for the other side of the story.
 	 */
 	if (ret)
 		smp_rmb();
@@ -528,23 +560,36 @@ static inline int PageUptodate(struct page *page)
 	return ret;
 }
 
-static __always_inline void __SetPageUptodate(struct page *page)
+static inline int PageUptodate(struct page *page)
+{
+	return FolioUptodate(page_folio(page));
+}
+
+static __always_inline void __SetFolioUptodate(struct folio *folio)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
 	smp_wmb();
-	__set_bit(PG_uptodate, &page->flags);
+	__set_bit(PG_uptodate, folio_flags(folio));
 }
 
-static __always_inline void SetPageUptodate(struct page *page)
+static __always_inline void SetFolioUptodate(struct folio *folio)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
 	/*
 	 * Memory barrier must be issued before setting the PG_uptodate bit,
 	 * so that all previous stores issued in order to bring the page
 	 * uptodate are actually visible before PageUptodate becomes true.
 	 */
 	smp_wmb();
-	set_bit(PG_uptodate, &page->flags);
+	set_bit(PG_uptodate, folio_flags(folio));
+}
+
+static __always_inline void __SetPageUptodate(struct page *page)
+{
+	__SetFolioUptodate((struct folio *)page);
+}
+
+static __always_inline void SetPageUptodate(struct page *page)
+{
+	SetFolioUptodate((struct folio *)page);
 }
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
@@ -569,6 +614,17 @@ static inline void set_page_writeback_keepwrite(struct page *page)
 
 __PAGEFLAG(Head, head, PF_ANY) CLEARPAGEFLAG(Head, head, PF_ANY)
 
+/* Whether there are one or multiple pages in a folio */
+static inline bool FolioSingle(struct folio *folio)
+{
+	return !FolioHead(folio);
+}
+
+static inline bool FolioMulti(struct folio *folio)
+{
+	return FolioHead(folio);
+}
+
 static __always_inline void set_compound_head(struct page *page, struct page *head)
 {
 	WRITE_ONCE(page->compound_head, (unsigned long)head + 1);
@@ -592,12 +648,15 @@ static inline void ClearPageCompound(struct page *page)
 #ifdef CONFIG_HUGETLB_PAGE
 int PageHuge(struct page *page);
 int PageHeadHuge(struct page *page);
+static inline bool FolioHuge(struct folio *folio)
+{
+	return PageHeadHuge(&folio->page);
+}
 #else
 TESTPAGEFLAG_FALSE(Huge)
 TESTPAGEFLAG_FALSE(HeadHuge)
 #endif
 
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for
@@ -844,6 +903,11 @@ static inline int page_has_private(struct page *page)
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
2.29.2

