Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7493CADA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhGOUQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhGOUQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:16:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2051C061764
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5PRejQNarH7uVB6Bz7r9PYxLMyaa+/k1QTjWjyoCMHA=; b=uXrcFM/UApyzrxn8T0jb0Qmph/
        u/Ox3meJ2g/yIrOy7/jVCQBuK4PXgKegHLixinJGsAkdg/RMsfHLDF2RQRuDfFoO6jNrfX9zqdWyJ
        ve4lAkn+n3U2MPZ5Ip/KxUFhwpT6RWDaDJf4dvJhl4eoTxVJyZYsRauaxs2f4f9FWLPSVXLhtXycI
        w0f7gTG9e0zhnWi5wdsUeCj9IVr96zJNfC/VmT+JXQ44hrbuJY7u2niGNYzbm4OYVk3MswaMFwWfM
        5oUD6cApRy0hFUultIr4H3zQtsgiXbVRCmAaOP7NGhfzpNLc0RkL7W9El13AbjkeM21IwalO9ACBi
        MLWq0WNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47i4-003ndy-5D; Thu, 15 Jul 2021 20:12:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v14 12/39] mm/migrate: Add folio_migrate_copy()
Date:   Thu, 15 Jul 2021 21:00:03 +0100
Message-Id: <20210715200030.899216-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of migrate_page_copy(), which is retained
as a wrapper for filesystems which are not yet converted to folios.
Also convert copy_huge_page() to folio_copy().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/migrate.h |  1 +
 include/linux/mm.h      |  2 +-
 mm/folio-compat.c       |  6 ++++++
 mm/hugetlb.c            |  2 +-
 mm/migrate.c            | 14 +++++---------
 mm/util.c               |  6 +++---
 6 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index ba0a554b3eae..6a01de9faff5 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -52,6 +52,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
+void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);
 #else
diff --git a/include/linux/mm.h b/include/linux/mm.h
index deb0f5efaa65..23276330ef4f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -911,7 +911,7 @@ void __put_page(struct page *page);
 void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
-void copy_huge_page(struct page *dst, struct page *src);
+void folio_copy(struct folio *dst, struct folio *src);
 
 /*
  * Compound pages have a destructor function.  Provide a
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 3f00ad92d1ff..2ccd8f213fc4 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -64,4 +64,10 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	folio_migrate_flags(page_folio(newpage), page_folio(page));
 }
 EXPORT_SYMBOL(migrate_page_states);
+
+void migrate_page_copy(struct page *newpage, struct page *page)
+{
+	folio_migrate_copy(page_folio(newpage), page_folio(page));
+}
+EXPORT_SYMBOL(migrate_page_copy);
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 924553aa8f78..b46f9d09aa94 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5200,7 +5200,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			*pagep = NULL;
 			goto out;
 		}
-		copy_huge_page(page, *pagep);
+		folio_copy(page_folio(page), page_folio(*pagep));
 		put_page(*pagep);
 		*pagep = NULL;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index a86be2bfc9a1..36cdae0a1235 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -613,16 +613,12 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
-void migrate_page_copy(struct page *newpage, struct page *page)
+void folio_migrate_copy(struct folio *newfolio, struct folio *folio)
 {
-	if (PageHuge(page) || PageTransHuge(page))
-		copy_huge_page(newpage, page);
-	else
-		copy_highpage(newpage, page);
-
-	migrate_page_states(newpage, page);
+	folio_copy(newfolio, folio);
+	folio_migrate_flags(newfolio, folio);
 }
-EXPORT_SYMBOL(migrate_page_copy);
+EXPORT_SYMBOL(folio_migrate_copy);
 
 /************************************************************
  *                    Migration functions
@@ -650,7 +646,7 @@ int migrate_page(struct address_space *mapping,
 		return rc;
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
+		folio_migrate_copy(newfolio, folio);
 	else
 		folio_migrate_flags(newfolio, folio);
 	return MIGRATEPAGE_SUCCESS;
diff --git a/mm/util.c b/mm/util.c
index 149537120a91..904a75612307 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -728,13 +728,13 @@ int __page_mapcount(struct page *page)
 }
 EXPORT_SYMBOL_GPL(__page_mapcount);
 
-void copy_huge_page(struct page *dst, struct page *src)
+void folio_copy(struct folio *dst, struct folio *src)
 {
-	unsigned i, nr = compound_nr(src);
+	unsigned i, nr = folio_nr_pages(src);
 
 	for (i = 0; i < nr; i++) {
 		cond_resched();
-		copy_highpage(nth_page(dst, i), nth_page(src, i));
+		copy_highpage(folio_page(dst, i), folio_page(src, i));
 	}
 }
 
-- 
2.30.2

