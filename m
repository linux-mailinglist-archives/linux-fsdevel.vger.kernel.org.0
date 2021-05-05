Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D748373E83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhEEP34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhEEP3z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:29:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F11C061574;
        Wed,  5 May 2021 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=S4WJ8uNnA/AQRst27SpuJwfGriDZuZcxFQ/AMcsw97w=; b=Imveq+HnEDlHLcGCd6Key8Jnu/
        AGsnxtKucXsPAdKgjb8tfdo5J13JvHTIZfDtb2hmknub9Cw1i8BJE/9VVBUtRiU3yygAnHwHZdvCE
        Va9HCZKzmoK9EVjuaiHpzWb1TjCRUTZ4aohp77Sg7qNjA8jKdEe082lnCGvFVt8MP8CY0c5r7L2gy
        eJOKU3P7JE61R3C9Xxa/3LLIIfaJLb1w6QQ20YxqSJKUQVlIjpihBg+1+moV2/9H0VqwfjUyXy9CP
        jFXk92nBDC2/07ex4SCdS4rPDkK3OqoAP9K9BeAeAKFMMLY6IBouP5zlKNPWbda9qfh6JAL6AYx6H
        8fBVkqLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJQy-000V3h-Mi; Wed, 05 May 2021 15:27:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v9 19/96] mm/filemap: Add folio_index, folio_file_page and folio_contains
Date:   Wed,  5 May 2021 16:05:11 +0100
Message-Id: <20210505150628.111735-20-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index e2a66ada9d69..fdb319928781 100644
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

