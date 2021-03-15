Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C762533A997
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 03:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhCOCZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Mar 2021 22:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhCOCYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Mar 2021 22:24:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66879C061574;
        Sun, 14 Mar 2021 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ZbagKXY+gGRN4QfZeaJfgicJ/AkLpAyRYqbVKVHiPU=; b=JKWzad7sSLKdeqo6iLiDUB1ccX
        ilSNHANc6eWmSTvIo1X5LXjS1ab5ij5MfAQnSxkEG6i7LohbiaTghRSYL+orthkOuwLcBLfLzumFA
        KjHQ29lHL5DvQc2s/2GJwtJe1qWTiMfCprK0D4XU5gIBVNjJ7TdjiwN5EpomMQa3TkKYSw01hRPY+
        beqpr3uWSo6rX3IqyCck7stLeExvSC9OO3wquWVImXf+5F60ALQRbN/uexJ3nIOthH4lDqbAkjG9N
        CFzG3P+ATKAUMaD3hT8ZprUQu8q0UbAvhBIULuVDJHM3UK1vINZx97D4LQyVss0yeoGuDkxhfxqoj
        RAPkYhMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLcuG-00GzqN-G0; Mon, 15 Mar 2021 02:24:39 +0000
Date:   Mon, 15 Mar 2021 02:24:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 07/25] mm: Create FolioFlags
Message-ID: <20210315022432.GS2577561@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041901.2396498-8-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:18:43AM +0000, Matthew Wilcox (Oracle) wrote:
> These new functions are the folio analogues of the PageFlags functions.
> If CONFIG_DEBUG_VM_PGFLAGS is enabled, we check the folio is not a tail
> page at every invocation.  Note that this will also catch the PagePoisoned
> case as a poisoned page has every bit set, which would include PageTail.
> 
> This saves 1740 bytes of text with the distro-derived config that
> I'm testing due to removing a double call to compound_head() in
> PageSwapCache().

This patch is buggy due to using the wrong page->flags for FolioDoubleMapped.
I'm not totally in love with this fix, but it does work without changing
every PAGEFLAG definition.

(also, I needed FolioTransHuge())

commit fe8ca904171345d113f06f381c255a3c4b20074e
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Sun Mar 14 17:34:48 2021 -0400

    fix FolioFlags

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 01aa4a71bf14..b7fd4c3733ca 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -212,10 +212,13 @@ static inline void page_init_poison(struct page *page, size_t size)
 }
 #endif
 
-static unsigned long *folio_flags(struct folio *folio)
+static unsigned long *folio_flags(struct folio *folio, unsigned n)
 {
-	VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
-	return &folio->page.flags;
+	struct page *page = &folio->page;
+
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags), page);
+	return &page[n].flags;
 }
 
 /*
@@ -262,48 +265,56 @@ static unsigned long *folio_flags(struct folio *folio)
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
 static __always_inline int Folio##uname(struct folio *folio)		\
-	{ return test_bit(PG_##lname, folio_flags(folio)); }		\
+	{ return test_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
 static __always_inline int Page##uname(struct page *page)		\
 	{ return test_bit(PG_##lname, &policy(page, 0)->flags); }
 
 #define SETPAGEFLAG(uname, lname, policy)				\
 static __always_inline void SetFolio##uname(struct folio *folio)	\
-	{ set_bit(PG_##lname, folio_flags(folio)); }			\
+	{ set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
 static __always_inline void SetPage##uname(struct page *page)		\
 	{ set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define CLEARPAGEFLAG(uname, lname, policy)				\
 static __always_inline void ClearFolio##uname(struct folio *folio)	\
-	{ clear_bit(PG_##lname, folio_flags(folio)); }			\
+	{ clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
 static __always_inline void ClearPage##uname(struct page *page)		\
 	{ clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define __SETPAGEFLAG(uname, lname, policy)				\
 static __always_inline void __SetFolio##uname(struct folio *folio)	\
-	{ __set_bit(PG_##lname, folio_flags(folio)); }			\
+	{ __set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
 static __always_inline void __SetPage##uname(struct page *page)		\
 	{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define __CLEARPAGEFLAG(uname, lname, policy)				\
 static __always_inline void __ClearFolio##uname(struct folio *folio)	\
-	{ __clear_bit(PG_##lname, folio_flags(folio)); }		\
+	{ __clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
 static __always_inline void __ClearPage##uname(struct page *page)	\
 	{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTSETFLAG(uname, lname, policy)				\
 static __always_inline int TestSetFolio##uname(struct folio *folio)	\
-	{ return test_and_set_bit(PG_##lname, folio_flags(folio)); }	\
+	{ return test_and_set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
 static __always_inline int TestSetPage##uname(struct page *page)	\
 	{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTCLEARFLAG(uname, lname, policy)				\
 static __always_inline int TestClearFolio##uname(struct folio *folio)	\
-	{ return test_and_clear_bit(PG_##lname, folio_flags(folio)); }	\
+	{ return test_and_clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
 static __always_inline int TestClearPage##uname(struct page *page)	\
 	{ return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
@@ -422,7 +433,7 @@ PAGEFLAG_FALSE(HighMem)
 static __always_inline bool FolioSwapCache(struct folio *folio)
 {
 	return FolioSwapBacked(folio) &&
-			test_bit(PG_swapcache, folio_flags(folio));
+			test_bit(PG_swapcache, folio_flags(folio, 0));
 
 }
 
@@ -545,7 +556,7 @@ u64 stable_page_flags(struct page *page);
 
 static inline int FolioUptodate(struct folio *folio)
 {
-	int ret = test_bit(PG_uptodate, folio_flags(folio));
+	int ret = test_bit(PG_uptodate, folio_flags(folio, 0));
 	/*
 	 * Must ensure that the data we read out of the page is loaded
 	 * _after_ we've loaded page->flags to check for PageUptodate.
@@ -568,7 +579,7 @@ static inline int PageUptodate(struct page *page)
 static __always_inline void __SetFolioUptodate(struct folio *folio)
 {
 	smp_wmb();
-	__set_bit(PG_uptodate, folio_flags(folio));
+	__set_bit(PG_uptodate, folio_flags(folio, 0));
 }
 
 static __always_inline void SetFolioUptodate(struct folio *folio)
@@ -579,7 +590,7 @@ static __always_inline void SetFolioUptodate(struct folio *folio)
 	 * uptodate are actually visible before PageUptodate becomes true.
 	 */
 	smp_wmb();
-	set_bit(PG_uptodate, folio_flags(folio));
+	set_bit(PG_uptodate, folio_flags(folio, 0));
 }
 
 static __always_inline void __SetPageUptodate(struct page *page)
@@ -672,6 +683,11 @@ static inline int PageTransHuge(struct page *page)
 	return PageHead(page);
 }
 
+static inline bool FolioTransHuge(struct folio *folio)
+{
+	return FolioHead(folio);
+}
+
 /*
  * PageTransCompound returns true for both transparent huge pages
  * and hugetlbfs pages, so it should only be called when it's known
