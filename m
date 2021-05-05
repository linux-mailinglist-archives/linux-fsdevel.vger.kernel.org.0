Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70353741B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhEEQkk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbhEEQiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:38:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFEC06134F;
        Wed,  5 May 2021 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7erbrWi96udzk9FwXiNGJPahIb3q21i3Mxk6+d4+BqU=; b=cHv+FwvwiSiOf/bo48hwA2+V1M
        U8+IPeQZ3qHLzZOPpDbJyyNc+PXjeWZAKmTpm8bP47pbaTuiVOL3SFjH2wHmsI6Pm9xaNXXxYFnu0
        PKVsj4lPLZ+I32wbM7MDQI27M96ZCLnKOqJ85nhDgUu5UTK4YKk110DXUo7cBFiM+QaUFJ3dGZHwJ
        y63LeRjgsl4DlmFHe04jcGtc87nXVeTE1bHD1A4Vzo1XnGGt4WyjPq6vb8Xq7fRHtxkVBIwXe1GDE
        f9n15Whp2BD8K99cMuZDWkOj1flDON0aVRSoytXL0JcTcsW6tlXL8lAIoGPeBRfEsbBLg3V+XwRJd
        zTX2HrRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKPr-000aml-Og; Wed, 05 May 2021 16:31:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 70/96] mm/filemap: Add readahead_folio
Date:   Wed,  5 May 2021 16:06:02 +0100
Message-Id: <20210505150628.111735-71-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
---
 include/linux/pagemap.h | 53 +++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8fd00dc5ebd5..d54772aa7a3a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1062,33 +1062,56 @@ void page_cache_async_readahead(struct address_space *mapping,
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
+	VM_BUG_ON_FOLIO(!folio_locked(folio), folio);
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

