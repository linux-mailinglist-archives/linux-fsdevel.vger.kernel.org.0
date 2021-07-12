Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0443C4246
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhGLDwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhGLDwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:52:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6425C0613DD;
        Sun, 11 Jul 2021 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RznbpItH7Hf5+tg8WiyybH0ySpwIattHKDhAoYM7Hlo=; b=STsJ1wAG6bvlnUTyNT49ILj7Jv
        tOagt2Rlf0x7UrwsNRMRJm7vGf7LtAiZXydgXyWAr5SE8TVWPMTcBJjZjy+gg2Vdx+m67kQN6qLcR
        cXV1xX8IlsHdkiCHUHaZ7VaZh51nJf5DlZyKAGTHa/v9OVO7deFhdEeRs05uM4rQfcd8uzTDbBK5m
        rz7uC4VsoMxblgK/0fqjaozb4MjbzWB/Lz8qIH133c55yl81skcu/Rg8cAi6TejRBCAb31pEhMD+Z
        n+TqipukC8w1i6P2YoVcCbn4QOdAwAenr/INkuAEQu1TgoDgFpTE5SEVPYfXw13lpiAV/7ft9AapX
        gMwX1J/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mwD-00Gpj3-RN; Mon, 12 Jul 2021 03:49:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 078/137] mm/filemap: Add readahead_folio()
Date:   Mon, 12 Jul 2021 04:06:02 +0100
Message-Id: <20210712030701.4000097-79-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index 1aee9f711de8..c0506722d209 100644
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

