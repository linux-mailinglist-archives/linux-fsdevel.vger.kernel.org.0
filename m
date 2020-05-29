Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2421E7306
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405441AbgE2C6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 22:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391612AbgE2C6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E058C08C5C9;
        Thu, 28 May 2020 19:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8tGdVMSWeas8R2bSKE6AqR3+R5LRIfaVDMdjwwPPyK0=; b=OfEJmiPRSkkzHeVNEG7pB4xfB0
        QVC1uZoDS920kwphA7cYhxJjg/pzaBGhad/7cLBmNIQ4oAZuKMqY17zGFYbkBLDHLghcKKhVaKw3j
        Qa7SqQwR1c3nGiBU9qLCQ1Cnf80NV9iz63iSTrublVL1dunNNltg6hIAlfeMGmxnvZL+r9FNbltN0
        D+qUHP1jAumITUPoGhNsXqDZOSgPZbzdX9fAZ1maHxm1B2b3GcCQYjnMvZGHBTVSCVdv9EIW2g7/e
        s78a9hDabmz+ckD32QiepYrUrXRTczOU1jZNFPvtnj+9QSOHuJ3B1f1uNTghudIFpXyeWsbvTWgee
        pEY6L9DA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008Pm-L6; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/39] mm: Simplify PageDoubleMap with PF_SECOND policy
Date:   Thu, 28 May 2020 19:57:47 -0700
Message-Id: <20200529025824.32296-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Introduce the new page policy of PF_SECOND which lets us use the
normal pageflags generation machinery to create the various DoubleMap
manipulation functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 40 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index de6e0696f55c..979460df4768 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -232,6 +232,9 @@ static inline void page_init_poison(struct page *page, size_t size)
  *
  * PF_NO_COMPOUND:
  *     the page flag is not relevant for compound pages.
+ *
+ * PF_SECOND:
+ *     the page flag is stored in the first tail page.
  */
 #define PF_POISONED_CHECK(page) ({					\
 		VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);		\
@@ -247,6 +250,9 @@ static inline void page_init_poison(struct page *page, size_t size)
 #define PF_NO_COMPOUND(page, enforce) ({				\
 		VM_BUG_ON_PGFLAGS(enforce && PageCompound(page), page);	\
 		PF_POISONED_CHECK(page); })
+#define PF_SECOND(page, enforce) ({					\
+		VM_BUG_ON_PGFLAGS(!PageHead(page), page);		\
+		PF_POISONED_CHECK(&page[1]); })
 
 /*
  * Macros to create function definitions for page flags
@@ -685,42 +691,15 @@ static inline int PageTransTail(struct page *page)
  *
  * See also __split_huge_pmd_locked() and page_remove_anon_compound_rmap().
  */
-static inline int PageDoubleMap(struct page *page)
-{
-	return PageHead(page) && test_bit(PG_double_map, &page[1].flags);
-}
-
-static inline void SetPageDoubleMap(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-	set_bit(PG_double_map, &page[1].flags);
-}
-
-static inline void ClearPageDoubleMap(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-	clear_bit(PG_double_map, &page[1].flags);
-}
-static inline int TestSetPageDoubleMap(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-	return test_and_set_bit(PG_double_map, &page[1].flags);
-}
-
-static inline int TestClearPageDoubleMap(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-	return test_and_clear_bit(PG_double_map, &page[1].flags);
-}
-
+PAGEFLAG(DoubleMap, double_map, PF_SECOND)
+	TESTSCFLAG(DoubleMap, double_map, PF_SECOND)
 #else
 TESTPAGEFLAG_FALSE(TransHuge)
 TESTPAGEFLAG_FALSE(TransCompound)
 TESTPAGEFLAG_FALSE(TransCompoundMap)
 TESTPAGEFLAG_FALSE(TransTail)
 PAGEFLAG_FALSE(DoubleMap)
-	TESTSETFLAG_FALSE(DoubleMap)
-	TESTCLEARFLAG_FALSE(DoubleMap)
+	TESTSCFLAG_FALSE(DoubleMap)
 #endif
 
 /*
@@ -875,6 +854,7 @@ static inline int page_has_private(struct page *page)
 #undef PF_ONLY_HEAD
 #undef PF_NO_TAIL
 #undef PF_NO_COMPOUND
+#undef PF_SECOND
 #endif /* !__GENERATING_BOUNDS_H */
 
 #endif	/* PAGE_FLAGS_H */
-- 
2.26.2

