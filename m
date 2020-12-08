Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463022D339F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgLHUWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgLHUWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97193C061794;
        Tue,  8 Dec 2020 12:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fP8jJQT1HGdo8Zkh2c3hQpc/AoXf8Q9fIce52qG43XU=; b=EKSV054qSyCQpPUcHf1I5x9stR
        PUx2c4Maov6A929GDJtDnlI1fJkt0whliTlTz2TnBxoyL9VqSW8mU5GpwbxyI4nXvNqU683RmDEvB
        0eC/Wbh6cv/GQSBn2S6V/RK+r5rXYA1HztIkxHXdAeKz411sDQsYEkBQ5EYfOnlV70g0XoZcu08bK
        xkWxyIc63FTGu45bnQ/ZbwY3jXcGOuP8oiZzkrvEvIgumQxu8DUldfYgPWfnIE+xqJl4PHhmIMr1/
        SfXuUoweWJ+RTZ9HlbuO1om9Z/Y672e7+LOHQFjh+zuFlcmfPs2o4jzi6luO2OqQL2iUIb3iT6HgW
        98wWoJRg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmiws-00050W-GL; Tue, 08 Dec 2020 19:46:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/11] mm: Create FolioFlags
Date:   Tue,  8 Dec 2020 19:46:46 +0000
Message-Id: <20201208194653.19180-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201208194653.19180-1-willy@infradead.org>
References: <20201208194653.19180-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These new functions are the folio analogues of the PageFlags functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ec5d0290e0ee..2c51cd4b3630 100644
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
@@ -509,11 +535,10 @@ TESTPAGEFLAG_FALSE(Ksm)
 
 u64 stable_page_flags(struct page *page);
 
-static inline int PageUptodate(struct page *page)
+static inline int FolioUptodate(struct folio *folio)
 {
 	int ret;
-	page = compound_head(page);
-	ret = test_bit(PG_uptodate, &(page)->flags);
+	ret = test_bit(PG_uptodate, folio_flags(folio));
 	/*
 	 * Must ensure that the data we read out of the page is loaded
 	 * _after_ we've loaded page->flags to check for PageUptodate.
@@ -528,6 +553,11 @@ static inline int PageUptodate(struct page *page)
 	return ret;
 }
 
+static inline int PageUptodate(struct page *page)
+{
+	return FolioUptodate(page_folio(page));
+}
+
 static __always_inline void __SetPageUptodate(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-- 
2.29.2

