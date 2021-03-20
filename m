Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187B6342B0B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhCTFnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhCTFmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:42:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D601C061762;
        Fri, 19 Mar 2021 22:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+y/5FoFjLrWI2aA5leeXHbMd9T+liO6cqHRjVQ4zX7g=; b=tHN7vv86r++fKO7VbcELKmOtYj
        ytR/rlYj8k7h/P9xrcgHzXnWPUDm5Ur3vjgSlvyZDOIr2QqLcAcphcplksUqNLr+tejLqmVTWUHHn
        OB9xjs9rBnoxFW8V54cvyqv4gsTuHN8nzcdEr23gIdzMr7w7WQsB+R+S0kN5v7qiwI93Y2NONe3Qh
        KuqS/z0C/osOFqLoKYgruZra5PVGK0PwBSJH47wIxx22rGRHJj12r5Kjh/RUKYbtPZimtbzrQKRa+
        Zd+ZyfdkekkpHbQctm466QxQK7znWnYCkV4MwGjUNPZ3dLj4/Sx8hEfH+IitTe+lMv1z6xvFI7ZeN
        JtNleeyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUNW-005SYb-Sg; Sat, 20 Mar 2021 05:42:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 12/27] mm: Add folio_index, folio_file_page and folio_contains
Date:   Sat, 20 Mar 2021 05:40:49 +0000
Message-Id: <20210320054104.1300774-13-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

folio_index() is the equivalent of page_index() for folios.
folio_file_page() is the equivalent of find_subpage().
folio_contains() is the equivalent of thp_contains().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 6676210addf6..f29c96ed3721 100644
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
+        if (unlikely(FolioSwapCache(folio)))
+                return swapcache_index(folio);
+        return folio->page.index;
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
+	return &folio->page + (index & (folio_nr_pages(folio) - 1));
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
+	if (PageHuge(&folio->page))
+		return folio->page.index == index;
+	return index - folio_index(folio) < folio_nr_pages(folio);
+}
+
 /*
  * Given the page we found in the page cache, return the page corresponding
  * to this index in the file
-- 
2.30.2

