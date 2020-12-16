Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5952DC637
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgLPSYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbgLPSYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EBC0617A7;
        Wed, 16 Dec 2020 10:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CYoAM4DvvSHoLtnhY+OYMLaKtsVx5aWcdLxiE6/isOA=; b=BYk+HbzB0eICsa0vMZLP8cNp7T
        9tQ+3//YpOjekHFUb5vmPlJzTkxyhVnJkVj3kBh0jouHGb9GG04G5iAGMC0jtgs+tah8UfxjHuzXt
        85IJxR+AsSgQWe252Z7nNzeX5VFM4T9ICKwh/J0hNzwxE7bjy4LouDfKFWdp6lBbgzzQN/+OqM27A
        IMZvimFxl4sWtxcatTFfCBUCj722BvEmAT5GOZQYcWAco/S3/RCMVSod4cEGtV3FdNbKb+Cx+umAU
        qrY7Ki7GdOFKt8kBaY5treucJt7Vf00oTHPC4iLVAYADWYROwP9B8iPDhwCaj8ye2rNxFBc3OEKwk
        qSEgCgJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSb-00076E-J1; Wed, 16 Dec 2020 18:23:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/25] mm: Create FolioFlags
Date:   Wed, 16 Dec 2020 18:23:14 +0000
Message-Id: <20201216182335.27227-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These new functions are the folio analogues of the PageFlags functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 80 ++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ec5d0290e0ee..446217ce13e9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -212,6 +212,12 @@ static inline void page_init_poison(struct page *page, size_t size)
 }
 #endif
 
+static unsigned long *folio_flags(struct folio *folio)
+{
+	VM_BUG_ON_PGFLAGS(PagePoisoned(&folio->page), &folio->page);
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
+
+}
 
+static __always_inline bool PageSwapCache(struct page *page)
+{
+	return FolioSwapCache(page_folio(page));
 }
+
 SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
 CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
 #else
@@ -509,18 +539,16 @@ TESTPAGEFLAG_FALSE(Ksm)
 
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
@@ -528,23 +556,38 @@ static inline int PageUptodate(struct page *page)
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
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	__SetFolioUptodate((struct folio *)page);
+}
+
+static __always_inline void SetPageUptodate(struct page *page)
+{
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	SetFolioUptodate((struct folio *)page);
 }
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
@@ -593,6 +636,10 @@ static inline void ClearPageCompound(struct page *page)
 int PageHuge(struct page *page);
 int PageHeadHuge(struct page *page);
 bool page_huge_active(struct page *page);
+static inline bool FolioHuge(struct folio *folio)
+{
+	return PageHeadHuge(&folio->page);
+}
 #else
 TESTPAGEFLAG_FALSE(Huge)
 TESTPAGEFLAG_FALSE(HeadHuge)
@@ -603,7 +650,6 @@ static inline bool page_huge_active(struct page *page)
 }
 #endif
 
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for
-- 
2.29.2

