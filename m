Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F134B5B8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiBNUyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:54:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiBNUyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:54:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A0C4B66
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qzMc3QSSV5ESROmRFN8IQpYHZFKRe03/W9Iz1/bJKQk=; b=wJ53S14AFxGTS9ic8170NO+Tlc
        IprUAZEXrgDhn+6tpVW9dApTcofV/EHrAtXneJXUERvkhsbjt2VlxbAlaPqFQyzz6tzPTmN0KCwMM
        eq5UPb+Jr7olj8O8PANKDZ2dZD5HfA/x3aMHjKvOV9qWGKoRkOQdAoBOuJLcA0fqD+U63zQlxVdkI
        Rn2HAfjyjlx7yPItPGTBe9kQoxMJBeZ3Fnk2eY5Yt3T7pmdtCw/+vSSiDVIWTm6sXMdyV/1O+HCRW
        qaMFK/8iznLIZ6QzlJ66dui/KG4nDN+lrRWK15YtQpVCGC+mrQcrGheQdAuE39qx4YLysFWZmTJeN
        cqkRe14w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJhWG-00DDdm-4L; Mon, 14 Feb 2022 20:00:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 05/10] mm: Convert remove_mapping() to take a folio
Date:   Mon, 14 Feb 2022 20:00:12 +0000
Message-Id: <20220214200017.3150590-6-willy@infradead.org>
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

Add kernel-doc and return the number of pages removed in order to
get the statistics right in __invalidate_mapping_pages().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/splice.c          |  5 ++---
 include/linux/swap.h |  2 +-
 mm/truncate.c        |  2 +-
 mm/vmscan.c          | 23 ++++++++++++++---------
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 23ff9c303abc..047b79db8eb5 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -46,8 +46,7 @@
 static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
 		struct pipe_buffer *buf)
 {
-	struct page *page = buf->page;
-	struct folio *folio = page_folio(page);
+	struct folio *folio = page_folio(buf->page);
 	struct address_space *mapping;
 
 	folio_lock(folio);
@@ -74,7 +73,7 @@ static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
 		 * If we succeeded in removing the mapping, set LRU flag
 		 * and return good.
 		 */
-		if (remove_mapping(mapping, page)) {
+		if (remove_mapping(mapping, folio)) {
 			buf->flags |= PIPE_BUF_FLAG_LRU;
 			return true;
 		}
diff --git a/include/linux/swap.h b/include/linux/swap.h
index e7cb7a1e6ceb..304f174b4d31 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -395,7 +395,7 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						unsigned long *nr_scanned);
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
-extern int remove_mapping(struct address_space *mapping, struct page *page);
+long remove_mapping(struct address_space *mapping, struct folio *folio);
 
 extern unsigned long reclaim_pages(struct list_head *page_list);
 #ifdef CONFIG_NUMA
diff --git a/mm/truncate.c b/mm/truncate.c
index d67fa8871b75..8aa86e294775 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -292,7 +292,7 @@ int invalidate_inode_page(struct page *page)
 	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
 		return 0;
 
-	return remove_mapping(mapping, page);
+	return remove_mapping(mapping, folio);
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2965be8df713..7959df4d611b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1335,23 +1335,28 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 	return 0;
 }
 
-/*
- * Attempt to detach a locked page from its ->mapping.  If it is dirty or if
- * someone else has a ref on the page, abort and return 0.  If it was
- * successfully detached, return 1.  Assumes the caller has a single ref on
- * this page.
+/**
+ * remove_mapping() - Attempt to remove a folio from its mapping.
+ * @mapping: The address space.
+ * @folio: The folio to remove.
+ *
+ * If the folio is dirty, under writeback or if someone else has a ref
+ * on it, removal will fail.
+ * Return: The number of pages removed from the mapping.  0 if the folio
+ * could not be removed.
+ * Context: The caller should have a single refcount on the folio and
+ * hold its lock.
  */
-int remove_mapping(struct address_space *mapping, struct page *page)
+long remove_mapping(struct address_space *mapping, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	if (__remove_mapping(mapping, folio, false, NULL)) {
 		/*
-		 * Unfreezing the refcount with 1 rather than 2 effectively
+		 * Unfreezing the refcount with 1 effectively
 		 * drops the pagecache ref for us without requiring another
 		 * atomic operation.
 		 */
 		folio_ref_unfreeze(folio, 1);
-		return 1;
+		return folio_nr_pages(folio);
 	}
 	return 0;
 }
-- 
2.34.1

