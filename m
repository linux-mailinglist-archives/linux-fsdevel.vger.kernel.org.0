Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933234B5B9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiBNUyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:54:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBNUyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:54:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51984188DCA
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 12:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qYJB38J6tbocFnfDbwb7L3Oe2UzuJaj6I119gQLGVko=; b=FH+2z54t15upM5tKv+IjJolE93
        RY4KuZBccvi723lXcVr60fXcxQpYGIy9gbzPFH8mQgBGXWODL6QSZGm8bM26WXtVcti0n/CtnehEf
        3OexZ483Wez3fxq5/4hZf+sDPtnJy1YLDrDfFhUC8tkfN4jCEZtdYnxr/hwaTHMEgvctgVd9EDxMS
        F47c5t+L2NgXqQJ6214ssoMC+VXp0z2JcX8t+1LvWXk3lfySzY6V22n139ZgnKbMoZozACOtVwhNU
        LF6+FZAcz/D9S+qORmxOKrUtiwKB+ZFvBOwCFij4HkQygSRj3dOTqdUyjSK4T8dg72uLBIG6KXQq6
        UzLn0LXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJhWG-00DDds-D0; Mon, 14 Feb 2022 20:00:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 06/10] mm/truncate: Split invalidate_inode_page() into mapping_shrink_folio()
Date:   Mon, 14 Feb 2022 20:00:13 +0000
Message-Id: <20220214200017.3150590-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220214200017.3150590-1-willy@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some of the callers already have the address_space and can avoid calling
folio_mapping() and checking if the folio was already truncated.  Also
add kernel-doc and fix the return type (in case we ever support folios
larger than 4TB).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h  |  1 -
 mm/internal.h       |  1 +
 mm/memory-failure.c |  4 ++--
 mm/truncate.c       | 34 +++++++++++++++++++++++-----------
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4637368d9455..53b301dc5c14 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1853,7 +1853,6 @@ extern void truncate_setsize(struct inode *inode, loff_t newsize);
 void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
 void truncate_pagecache_range(struct inode *inode, loff_t offset, loff_t end);
 int generic_error_remove_page(struct address_space *mapping, struct page *page);
-int invalidate_inode_page(struct page *page);
 
 #ifdef CONFIG_MMU
 extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
diff --git a/mm/internal.h b/mm/internal.h
index b7a2195c12b1..927a17d58b85 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -100,6 +100,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
 		loff_t end);
+long invalidate_inode_page(struct page *page);
 
 /**
  * folio_evictable - Test whether a folio is evictable.
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 97a9ed8f87a9..0b72a936b8dd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2139,7 +2139,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
  */
 static int __soft_offline_page(struct page *page)
 {
-	int ret = 0;
+	long ret = 0;
 	unsigned long pfn = page_to_pfn(page);
 	struct page *hpage = compound_head(page);
 	char const *msg_page[] = {"page", "hugepage"};
@@ -2196,7 +2196,7 @@ static int __soft_offline_page(struct page *page)
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
 
-			pr_info("soft offline: %#lx: %s migration failed %d, type %pGp\n",
+			pr_info("soft offline: %#lx: %s migration failed %ld, type %pGp\n",
 				pfn, msg_page[huge], ret, &page->flags);
 			if (ret > 0)
 				ret = -EBUSY;
diff --git a/mm/truncate.c b/mm/truncate.c
index 8aa86e294775..b1bdc61198f6 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -273,18 +273,9 @@ int generic_error_remove_page(struct address_space *mapping, struct page *page)
 }
 EXPORT_SYMBOL(generic_error_remove_page);
 
-/*
- * Safely invalidate one page from its pagecache mapping.
- * It only drops clean, unused pages. The page must be locked.
- *
- * Returns 1 if the page is successfully invalidated, otherwise 0.
- */
-int invalidate_inode_page(struct page *page)
+static long mapping_shrink_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-	struct address_space *mapping = folio_mapping(folio);
-	if (!mapping)
-		return 0;
 	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return 0;
 	if (folio_ref_count(folio) > folio_nr_pages(folio) + 1)
@@ -295,6 +286,27 @@ int invalidate_inode_page(struct page *page)
 	return remove_mapping(mapping, folio);
 }
 
+/**
+ * invalidate_inode_page() - Remove an unused page from the pagecache.
+ * @page: The page to remove.
+ *
+ * Safely invalidate one page from its pagecache mapping.
+ * It only drops clean, unused pages.
+ *
+ * Context: Page must be locked.
+ * Return: The number of pages successfully removed.
+ */
+long invalidate_inode_page(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+	struct address_space *mapping = folio_mapping(folio);
+
+	/* The page may have been truncated before it was locked */
+	if (!mapping)
+		return 0;
+	return mapping_shrink_folio(mapping, folio);
+}
+
 /**
  * truncate_inode_pages_range - truncate range of pages specified by start & end byte offsets
  * @mapping: mapping to truncate
-- 
2.34.1

