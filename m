Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3D359C79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 12:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhDIK7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 06:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233583AbhDIK7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617965969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xpa3xywlSojGWcjg87N1j6k+hsyrCGL+djn7gdESXsE=;
        b=dmNy+PZ8qemDf+3tjrJWyQFc3Rh1buLKDsLQKnt75Zooq+xt94ASq7iM8WvtWBhqbaWsDj
        UCHV2Hpd09hEeZUuz+rVdcvlcAVlVXr9tFIH+y9XjoVo7xn4GewO9zublC5lCF3okCKloi
        OiC+513NpLluN88aOpd9t1YLnc2ydTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-xRnX786jOAu1dJsXBocSyA-1; Fri, 09 Apr 2021 06:59:25 -0400
X-MC-Unique: xRnX786jOAu1dJsXBocSyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2E79801814;
        Fri,  9 Apr 2021 10:59:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E85C918AAB;
        Fri,  9 Apr 2021 10:59:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 2/3] mm: Return bool from pagebit test functions
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, willy@infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        jlayton@kernel.org, hch@lst.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 09 Apr 2021 11:59:17 +0100
Message-ID: <161796595714.350846.1547688999823745763.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com>
References: <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make functions that test page bits return a bool, not an int.  This means
that the value is definitely 0 or 1 if they're used in arithmetic, rather
than rely on test_bit() and friends to return this (though they probably
should).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---

 include/linux/page-flags.h |   50 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 04a34c08e0a6..4ff7de61b13d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -188,18 +188,18 @@ static inline struct page *compound_head(struct page *page)
 	return page;
 }
 
-static __always_inline int PageTail(struct page *page)
+static __always_inline bool PageTail(struct page *page)
 {
 	return READ_ONCE(page->compound_head) & 1;
 }
 
-static __always_inline int PageCompound(struct page *page)
+static __always_inline bool PageCompound(struct page *page)
 {
 	return test_bit(PG_head, &page->flags) || PageTail(page);
 }
 
 #define	PAGE_POISON_PATTERN	-1l
-static inline int PagePoisoned(const struct page *page)
+static inline bool PagePoisoned(const struct page *page)
 {
 	return page->flags == PAGE_POISON_PATTERN;
 }
@@ -260,7 +260,7 @@ static inline void page_init_poison(struct page *page, size_t size)
  * Macros to create function definitions for page flags
  */
 #define TESTPAGEFLAG(uname, lname, policy)				\
-static __always_inline int Page##uname(struct page *page)		\
+static __always_inline bool Page##uname(struct page *page)		\
 	{ return test_bit(PG_##lname, &policy(page, 0)->flags); }
 
 #define SETPAGEFLAG(uname, lname, policy)				\
@@ -280,11 +280,11 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
 	{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTSETFLAG(uname, lname, policy)				\
-static __always_inline int TestSetPage##uname(struct page *page)	\
+static __always_inline bool TestSetPage##uname(struct page *page)	\
 	{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define TESTCLEARFLAG(uname, lname, policy)				\
-static __always_inline int TestClearPage##uname(struct page *page)	\
+static __always_inline bool TestClearPage##uname(struct page *page)	\
 	{ return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags); }
 
 #define PAGEFLAG(uname, lname, policy)					\
@@ -302,7 +302,7 @@ static __always_inline int TestClearPage##uname(struct page *page)	\
 	TESTCLEARFLAG(uname, lname, policy)
 
 #define TESTPAGEFLAG_FALSE(uname)					\
-static inline int Page##uname(const struct page *page) { return 0; }
+static inline bool Page##uname(const struct page *page) { return false; }
 
 #define SETPAGEFLAG_NOOP(uname)						\
 static inline void SetPage##uname(struct page *page) {  }
@@ -314,10 +314,10 @@ static inline void ClearPage##uname(struct page *page) {  }
 static inline void __ClearPage##uname(struct page *page) {  }
 
 #define TESTSETFLAG_FALSE(uname)					\
-static inline int TestSetPage##uname(struct page *page) { return 0; }
+static inline bool TestSetPage##uname(struct page *page) { return false; }
 
 #define TESTCLEARFLAG_FALSE(uname)					\
-static inline int TestClearPage##uname(struct page *page) { return 0; }
+static inline bool TestClearPage##uname(struct page *page) { return false; }
 
 #define PAGEFLAG_FALSE(uname) TESTPAGEFLAG_FALSE(uname)			\
 	SETPAGEFLAG_NOOP(uname) CLEARPAGEFLAG_NOOP(uname)
@@ -393,7 +393,7 @@ PAGEFLAG_FALSE(HighMem)
 #endif
 
 #ifdef CONFIG_SWAP
-static __always_inline int PageSwapCache(struct page *page)
+static __always_inline bool PageSwapCache(struct page *page)
 {
 #ifdef CONFIG_THP_SWAP
 	page = compound_head(page);
@@ -473,18 +473,18 @@ __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
 #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 
-static __always_inline int PageMappingFlags(struct page *page)
+static __always_inline bool PageMappingFlags(struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
-static __always_inline int PageAnon(struct page *page)
+static __always_inline bool PageAnon(struct page *page)
 {
 	page = compound_head(page);
 	return ((unsigned long)page->mapping & PAGE_MAPPING_ANON) != 0;
 }
 
-static __always_inline int __PageMovable(struct page *page)
+static __always_inline bool __PageMovable(struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
 				PAGE_MAPPING_MOVABLE;
@@ -497,7 +497,7 @@ static __always_inline int __PageMovable(struct page *page)
  * is found in VM_MERGEABLE vmas.  It's a PageAnon page, pointing not to any
  * anon_vma, but to that page's node of the stable tree.
  */
-static __always_inline int PageKsm(struct page *page)
+static __always_inline bool PageKsm(struct page *page)
 {
 	page = compound_head(page);
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
@@ -509,9 +509,9 @@ TESTPAGEFLAG_FALSE(Ksm)
 
 u64 stable_page_flags(struct page *page);
 
-static inline int PageUptodate(struct page *page)
+static inline bool PageUptodate(struct page *page)
 {
-	int ret;
+	bool ret;
 	page = compound_head(page);
 	ret = test_bit(PG_uptodate, &(page)->flags);
 	/*
@@ -607,7 +607,7 @@ TESTPAGEFLAG_FALSE(HeadHuge)
  * hugetlbfs pages, but not normal pages. PageTransHuge() can only be
  * called only in the core VM paths where hugetlbfs pages can't exist.
  */
-static inline int PageTransHuge(struct page *page)
+static inline bool PageTransHuge(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	return PageHead(page);
@@ -618,7 +618,7 @@ static inline int PageTransHuge(struct page *page)
  * and hugetlbfs pages, so it should only be called when it's known
  * that hugetlbfs pages aren't involved.
  */
-static inline int PageTransCompound(struct page *page)
+static inline bool PageTransCompound(struct page *page)
 {
 	return PageCompound(page);
 }
@@ -644,12 +644,12 @@ static inline int PageTransCompound(struct page *page)
  * mapped in the current process so comparing subpage's _mapcount to
  * compound_mapcount to filter out PTE mapped case.
  */
-static inline int PageTransCompoundMap(struct page *page)
+static inline bool PageTransCompoundMap(struct page *page)
 {
 	struct page *head;
 
 	if (!PageTransCompound(page))
-		return 0;
+		return false;
 
 	if (PageAnon(page))
 		return atomic_read(&page->_mapcount) < 0;
@@ -665,7 +665,7 @@ static inline int PageTransCompoundMap(struct page *page)
  * and hugetlbfs pages, so it should only be called when it's known
  * that hugetlbfs pages aren't involved.
  */
-static inline int PageTransTail(struct page *page)
+static inline bool PageTransTail(struct page *page)
 {
 	return PageTail(page);
 }
@@ -714,13 +714,13 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
-static inline int page_has_type(struct page *page)
+static inline bool page_has_type(struct page *page)
 {
 	return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
 }
 
 #define PAGE_TYPE_OPS(uname, lname)					\
-static __always_inline int Page##uname(struct page *page)		\
+static __always_inline bool Page##uname(struct page *page)		\
 {									\
 	return PageType(page, PG_##lname);				\
 }									\
@@ -778,7 +778,7 @@ __PAGEFLAG(Isolated, isolated, PF_ANY);
  * If network-based swap is enabled, sl*b must keep track of whether pages
  * were allocated from pfmemalloc reserves.
  */
-static inline int PageSlabPfmemalloc(struct page *page)
+static inline bool PageSlabPfmemalloc(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageSlab(page), page);
 	return PageActive(page);
@@ -839,7 +839,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
  * Determine if a page has private stuff, indicating that release routines
  * should be invoked upon it.
  */
-static inline int page_has_private(struct page *page)
+static inline bool page_has_private(struct page *page)
 {
 	return !!(page->flags & PAGE_FLAGS_PRIVATE);
 }


