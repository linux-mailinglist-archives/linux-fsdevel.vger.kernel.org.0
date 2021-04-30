Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDB36FF89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhD3RdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3RdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:33:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65520C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bwDi7si45e3vP6fXPAppIPnDwSPYXP1GNGvDWyvOyM4=; b=lfV7h0V2R5DzvbRmxElQd/XmOK
        O9IQCHmVNDM/dJOKdFnd3hDvLRZ67Ea+MYpCfz7vMtRbQQK9s4s+co5we02mzFvSdV7eVrHB6fuhM
        fipE3vC9VJAKMoDQGp91FaLneFuiRtuZmUHftitI5nml32GhZ1LPHj8oYNrwUOOY2qmOwa1YcJF+j
        8RKGbSjVKpg9rjszCKqGixJv56zamHEQQHLOXDny67cmxvtlaUSN2TQSFfs5+oraq2wIubXRkPKJG
        QAbMOQ+o02lCuqWPIhLeS3EiyVxrBylzx1Vfzf/8jd0oKQFKsvvzCYBaFNGcdsF3HnH2OfTn5zEds
        3C3aCGKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcWyb-00BJj8-L6; Fri, 30 Apr 2021 17:31:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 11/27] mm/filemap: Add folio_index, folio_file_page and folio_contains
Date:   Fri, 30 Apr 2021 18:22:19 +0100
Message-Id: <20210430172235.2695303-12-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430172235.2695303-1-willy@infradead.org>
References: <20210430172235.2695303-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

folio_index() is the equivalent of page_index() for folios.
folio_file_page() is the equivalent of find_subpage().
folio_contains() is the equivalent of thp_contains().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c58587225fe5..58c9b98604d0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -462,6 +462,59 @@ static inline bool thp_contains(struct page *head, pgoff_t index)
 	return page_index(head) == (index & ~(thp_nr_pages(head) - 1UL));
 }
 
+#define swapcache_index(folio)	__page_file_index(&(folio)->page)
+
+/**
+ * folio_index - File index of a folio.
+ * @folio: The folio.
+ *
+ * For a folio which is either in the page cache or the swap cache,
+ * return its index within the address_space it belongs to.  If you know
+ * the page is definitely in the page cache, you can look at the folio's
+ * index directly.
+ *
+ * Return: The index (offset in units of pages) of a folio in its file.
+ */
+static inline pgoff_t folio_index(struct folio *folio)
+{
+        if (unlikely(folio_swapcache(folio)))
+                return swapcache_index(folio);
+        return folio->index;
+}
+
+/**
+ * folio_file_page - The page for a particular index.
+ * @folio: The folio which contains this index.
+ * @index: The index we want to look up.
+ *
+ * Sometimes after looking up a folio in the page cache, we need to
+ * obtain the specific page for an index (eg a page fault).
+ *
+ * Return: The page containing the file data for this index.
+ */
+static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
+{
+	return nth_page(&folio->page, index & (folio_nr_pages(folio) - 1));
+}
+
+/**
+ * folio_contains - Does this folio contain this index?
+ * @folio: The folio.
+ * @index: The page index within the file.
+ *
+ * Context: The caller should have the page locked in order to prevent
+ * (eg) shmem from moving the page between the page cache and swap cache
+ * and changing its index in the middle of the operation.
+ * Return: true or false.
+ */
+static inline bool folio_contains(struct folio *folio, pgoff_t index)
+{
+	/* HugeTLBfs indexes the page cache in units of hpage_size */
+	if (folio_hugetlb(folio))
+		return folio->index == index;
+	return index - folio_index(folio) < folio_nr_pages(folio);
+}
+
 /*
  * Given the page we found in the page cache, return the page corresponding
  * to this index in the file
-- 
2.30.2

