Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C391D4ED0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEONRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgEONRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F490C05BD0A;
        Fri, 15 May 2020 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8tGdVMSWeas8R2bSKE6AqR3+R5LRIfaVDMdjwwPPyK0=; b=WhPmJBJSOgnOF3ooep5OzVpDYF
        POCkNm2xsyLEnK7pW6aZr7fW8VRnyBsNlzuCaulgdtx1bij7wSF0fyiL4lZbF5+7VIYoBpPR7kBmQ
        N4/bFgssgva/U9r3Gt5ncw6Qz6cigrYUtc5HAG7Gh8gppgTxZRaIr/KtTLydtM07h5JT6xu1JYS5I
        axv23xhYPll1i7f/UyAwrzSrFxdiNUW8vEP4anFDJboao5DExIINtcORx9BRaKMpowsW5eMPjar75
        SLygYKWBIj04UrEP4qQ/4i19bkBKRR2bkfQoHvFnrHsOG2B2GITT8w6Ay+F9fsB3TCB2jV3Rrc0YJ
        KKTsXm8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaCy-0005Sp-BI; Fri, 15 May 2020 13:17:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/36] mm: Simplify PageDoubleMap with PF_SECOND policy
Date:   Fri, 15 May 2020 06:16:22 -0700
Message-Id: <20200515131656.12890-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
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

