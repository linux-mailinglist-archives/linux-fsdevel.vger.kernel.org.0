Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C13C969C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhGODud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGODuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:50:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A89DC06175F;
        Wed, 14 Jul 2021 20:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bGkCOHXv7RarMhiG1xggwMwUQkMjVX8vOxD9dW3om4g=; b=R9sWIamfE7zJxunZZ/ydeABDxa
        4yQbv0pue98BvXaZy1eFfy0+XF/976cXOp5E8J3JbMHq82r+9bdf7Oisv8190jm8lcsH6bPzSLIFk
        uxVequUVpgZFtlYNPtuR6z0dYEEERUC9BUYZ2jRtDrefgXx+7N8AZGqDOi3fUzsni8Ze0ycUzSF0f
        Gq5jch0AoPwDQm7X+VpFV/rE08XI1fgnFoUVKl6Pc3cOJS0dUxkceJGNWBGYy7hKKG6Pfshuce6zH
        hdrwPmCFa1X33eJ2m+IpOvPV7ULHf55vBT2oTkyqdx9E5078JoKORXctSnxwZ1rN6Z5T09JG67Sow
        ViqBD/lg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sKN-002unf-AO; Thu, 15 Jul 2021 03:46:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v14 013/138] mm/filemap: Add folio_index(), folio_file_page() and folio_contains()
Date:   Thu, 15 Jul 2021 04:34:59 +0100
Message-Id: <20210715033704.692967-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

folio_index() is the equivalent of page_index() for folios.
folio_file_page() is the equivalent of find_subpage().
folio_contains() is the equivalent of thp_contains().

No changes to generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/pagemap.h | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3279c731ee04..f7c165b5991f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -386,6 +386,62 @@ static inline bool thp_contains(struct page *head, pgoff_t index)
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
+        if (unlikely(folio_test_swapcache(folio)))
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
+	/* HugeTLBfs indexes the page cache in units of hpage_size */
+	if (folio_test_hugetlb(folio))
+		return &folio->page;
+	return folio_page(folio, index & (folio_nr_pages(folio) - 1));
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
+	if (folio_test_hugetlb(folio))
+		return folio->index == index;
+	return index - folio_index(folio) < folio_nr_pages(folio);
+}
+
 /*
  * Given the page we found in the page cache, return the page corresponding
  * to this index in the file
-- 
2.30.2

