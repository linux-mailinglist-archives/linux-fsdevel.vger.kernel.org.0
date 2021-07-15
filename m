Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBF03CAD9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbhGOUN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344830AbhGOUNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:13:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3315C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=27gdq5o/ud7Z3GaZ8fB4o0Zc5uDnZZui0TcU+yq7Hzs=; b=jYly9sFpunupgWo7IxCzMHvRSz
        6db1W0Eq64l8D6w3KE95bV1oXCp1usDXwl/rOq97NRUmC9k5vAl6MS/MIVWSAMsDbSt0tfXO+fLi5
        /C4ensaSs8vJr1MYFXsrTUHYNdeIIelx0/C1pNrMYA8nXqJSXQ06N9Wdw8fnrkBXYxGBHmC5rjy5x
        4V6VKn2VlcGTUiyH/dy88S3yzHv/jQWcUT7HqwS6B4vbq21pw3kIM3sz1ZcX0+1sNimM4lMPnTXcy
        Cx832t1rlLSAZpkPC2h9uh1sPpJ9mfEyTIJsEvdoZ6mkoKuCwyErTl++rXGSFcQD7OaBIEl1lL4Hg
        e4zVys3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47fo-003nJJ-1Q; Thu, 15 Jul 2021 20:09:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 09/39] mm/rmap: Add folio_mkclean()
Date:   Thu, 15 Jul 2021 21:00:00 +0100
Message-Id: <20210715200030.899216-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Transform page_mkclean() into folio_mkclean() and add a page_mkclean()
wrapper around folio_mkclean().

folio_mkclean is 15 bytes smaller than page_mkclean, but the kernel
is enlarged by 33 bytes due to inlining page_folio() into each caller.
This will go away once the callers are converted to use folio_mkclean().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/rmap.h | 10 ++++++----
 mm/rmap.c            | 12 ++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 83fb86133fe1..d45584310cde 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -235,7 +235,7 @@ unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
  *
  * returns the number of cleaned PTEs.
  */
-int page_mkclean(struct page *);
+int folio_mkclean(struct folio *);
 
 /*
  * called in munlock()/munmap() path to check for other vmas holding
@@ -293,12 +293,14 @@ static inline int page_referenced(struct page *page, int is_locked,
 
 #define try_to_unmap(page, refs) false
 
-static inline int page_mkclean(struct page *page)
+static inline int folio_mkclean(struct folio *folio)
 {
 	return 0;
 }
-
-
 #endif	/* CONFIG_MMU */
 
+static inline int page_mkclean(struct page *page)
+{
+	return folio_mkclean(page_folio(page));
+}
 #endif	/* _LINUX_RMAP_H */
diff --git a/mm/rmap.c b/mm/rmap.c
index 1df8683c4c4c..b3aae8eeaeaf 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -980,7 +980,7 @@ static bool invalid_mkclean_vma(struct vm_area_struct *vma, void *arg)
 	return true;
 }
 
-int page_mkclean(struct page *page)
+int folio_mkclean(struct folio *folio)
 {
 	int cleaned = 0;
 	struct address_space *mapping;
@@ -990,20 +990,20 @@ int page_mkclean(struct page *page)
 		.invalid_vma = invalid_mkclean_vma,
 	};
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 
-	if (!page_mapped(page))
+	if (!folio_mapped(folio))
 		return 0;
 
-	mapping = page_mapping(page);
+	mapping = folio_mapping(folio);
 	if (!mapping)
 		return 0;
 
-	rmap_walk(page, &rwc);
+	rmap_walk(&folio->page, &rwc);
 
 	return cleaned;
 }
-EXPORT_SYMBOL_GPL(page_mkclean);
+EXPORT_SYMBOL_GPL(folio_mkclean);
 
 /**
  * page_move_anon_rmap - move a page to our anon_vma
-- 
2.30.2

