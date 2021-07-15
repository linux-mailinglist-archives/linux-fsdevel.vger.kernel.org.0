Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331123C986B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbhGOFbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGOFbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:31:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD483C06175F;
        Wed, 14 Jul 2021 22:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FD2gG4brhIvOYgZzfQoJ9/1AxwOQYZQ46OyI5tUckCA=; b=SYbu/WSISR0OiMxHwsnROIbwiK
        iPnCtiIVjw9xWzAeqyjgYsDzT0pdoVYcQjCZPdaLdNY2xLSsXW912w0k0UmV3S7nEvYaZs0KxI4Pg
        JCVR79yjk93+6Pla4R4kGKODpfMdz01ENfm6PAbOZnRT+lTNCkhGkan/IdKKGPosUwuqFy6tIIDNT
        /mW2JGq5loV3vAeGEtJcchcnlfc6iv75pkOU2i+WLxJ+xdtQ80ydCJD0DJTTzRZhaoltbsIZDTF0l
        TDCa04GOC61jujcwdwwtNicHtSsijl3NjaS4ZSoj0T6A/fv9gQp+k0ixNUvnGs4K0PvWPkBEe+NjM
        q4FDCKDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tuD-0031Hp-Rs; Thu, 15 Jul 2021 05:27:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 137/138] mm/readahead: Convert page_cache_async_ra() to take a folio
Date:   Thu, 15 Jul 2021 04:37:03 +0100
Message-Id: <20210715033704.692967-138-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This lets us pass the folio in directly from filemap_readahead(), but its
primary reason is to enable us to pass a folio to ondemand_readahead()
in the next patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 4 ++--
 mm/filemap.c            | 5 +++--
 mm/readahead.c          | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 81cccb708df7..d3f0b68ea3b1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -955,7 +955,7 @@ struct readahead_control {
 void page_cache_ra_unbounded(struct readahead_control *,
 		unsigned long nr_to_read, unsigned long lookahead_count);
 void page_cache_sync_ra(struct readahead_control *, unsigned long req_count);
-void page_cache_async_ra(struct readahead_control *, struct page *,
+void page_cache_async_ra(struct readahead_control *, struct folio *,
 		unsigned long req_count);
 void readahead_expand(struct readahead_control *ractl,
 		      loff_t new_start, size_t new_len);
@@ -1002,7 +1002,7 @@ void page_cache_async_readahead(struct address_space *mapping,
 		struct page *page, pgoff_t index, unsigned long req_count)
 {
 	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
-	page_cache_async_ra(&ractl, page, req_count);
+	page_cache_async_ra(&ractl, page_folio(page), req_count);
 }
 
 static inline struct folio *__readahead_folio(struct readahead_control *ractl)
diff --git a/mm/filemap.c b/mm/filemap.c
index 1ff21b3346d3..ee7c72b4edee 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2419,10 +2419,11 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 		struct address_space *mapping, struct folio *folio,
 		pgoff_t last_index)
 {
+	DEFINE_READAHEAD(ractl, file, &file->f_ra, mapping, folio->index);
+
 	if (iocb->ki_flags & IOCB_NOIO)
 		return -EAGAIN;
-	page_cache_async_readahead(mapping, &file->f_ra, file, &folio->page,
-			folio->index, last_index - folio->index);
+	page_cache_async_ra(&ractl, folio, last_index - folio->index);
 	return 0;
 }
 
diff --git a/mm/readahead.c b/mm/readahead.c
index d589f147f4c2..e1df44ad57ed 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -580,7 +580,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 EXPORT_SYMBOL_GPL(page_cache_sync_ra);
 
 void page_cache_async_ra(struct readahead_control *ractl,
-		struct page *page, unsigned long req_count)
+		struct folio *folio, unsigned long req_count)
 {
 	/* no read-ahead */
 	if (!ractl->ra->ra_pages)
@@ -589,10 +589,10 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	/*
 	 * Same bit is used for PG_readahead and PG_reclaim.
 	 */
-	if (PageWriteback(page))
+	if (folio_test_writeback(folio))
 		return;
 
-	ClearPageReadahead(page);
+	folio_clear_readahead(folio);
 
 	/*
 	 * Defer asynchronous read-ahead on IO congestion.
-- 
2.30.2

