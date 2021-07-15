Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9C3C979C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbhGOEom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGOEom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:44:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19DAC06175F;
        Wed, 14 Jul 2021 21:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mOZR97vqhEKo31GvUk0y72ueq9pa4KcTUloIAzr8f6s=; b=vsjO4l71AveQPK3b7poPZDY+0m
        mc6AMqFx5wcad/fdRUbeup8u/oQV529KHDjd+GvuzVkNS6QyDXLH5Vj2KrkN1Zq6jOw3ejAvLgcQD
        BstOrfcoMcpILjKjR+wKjYHIkkquZ53qEiNvVvAG6jx1Ggvd4bqYDaEkpwVpqGIMMyNNaZtn2tjf1
        PI4eOv+x9lu1zn1/Df62VOHlLzRXmwUy9lBQiV05Y60N32TNMJPjYfa7kxynMpKNC5gKr5InHb5Z9
        beUL0wZha8sfgYJA2xhYpLaabVVLAHTnf1iXZxYOkLPCGCunxsqglV1XHs4zkU6zwL28SDFwr+eSp
        ZmQ4rYug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tAo-002yEG-MX; Thu, 15 Jul 2021 04:40:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 079/138] mm/filemap: Add readahead_folio()
Date:   Thu, 15 Jul 2021 04:36:05 +0100
Message-Id: <20210715033704.692967-80-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pointers stored in the page cache are folios, by definition.
This change comes with a behaviour change -- callers of readahead_folio()
are no longer required to put the page reference themselves.  This matches
how readpage works, rather than matching how readpages used to work.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pagemap.h | 53 +++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 18c06c3e42c3..bd4daebaf70e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -988,33 +988,56 @@ void page_cache_async_readahead(struct address_space *mapping,
 	page_cache_async_ra(&ractl, page, req_count);
 }
 
+static inline struct folio *__readahead_folio(struct readahead_control *ractl)
+{
+	struct folio *folio;
+
+	BUG_ON(ractl->_batch_count > ractl->_nr_pages);
+	ractl->_nr_pages -= ractl->_batch_count;
+	ractl->_index += ractl->_batch_count;
+
+	if (!ractl->_nr_pages) {
+		ractl->_batch_count = 0;
+		return NULL;
+	}
+
+	folio = xa_load(&ractl->mapping->i_pages, ractl->_index);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	ractl->_batch_count = folio_nr_pages(folio);
+
+	return folio;
+}
+
 /**
  * readahead_page - Get the next page to read.
- * @rac: The current readahead request.
+ * @ractl: The current readahead request.
  *
  * Context: The page is locked and has an elevated refcount.  The caller
  * should decreases the refcount once the page has been submitted for I/O
  * and unlock the page once all I/O to that page has completed.
  * Return: A pointer to the next page, or %NULL if we are done.
  */
-static inline struct page *readahead_page(struct readahead_control *rac)
+static inline struct page *readahead_page(struct readahead_control *ractl)
 {
-	struct page *page;
+	struct folio *folio = __readahead_folio(ractl);
 
-	BUG_ON(rac->_batch_count > rac->_nr_pages);
-	rac->_nr_pages -= rac->_batch_count;
-	rac->_index += rac->_batch_count;
-
-	if (!rac->_nr_pages) {
-		rac->_batch_count = 0;
-		return NULL;
-	}
+	return &folio->page;
+}
 
-	page = xa_load(&rac->mapping->i_pages, rac->_index);
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	rac->_batch_count = thp_nr_pages(page);
+/**
+ * readahead_folio - Get the next folio to read.
+ * @ractl: The current readahead request.
+ *
+ * Context: The folio is locked.  The caller should unlock the folio once
+ * all I/O to that folio has completed.
+ * Return: A pointer to the next folio, or %NULL if we are done.
+ */
+static inline struct folio *readahead_folio(struct readahead_control *ractl)
+{
+	struct folio *folio = __readahead_folio(ractl);
 
-	return page;
+	folio_put(folio);
+	return folio;
 }
 
 static inline unsigned int __readahead_batch(struct readahead_control *rac,
-- 
2.30.2

