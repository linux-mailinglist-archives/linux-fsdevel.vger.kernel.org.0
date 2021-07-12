Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F13C42D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhGLEWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhGLEWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:22:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6FBC0613E9;
        Sun, 11 Jul 2021 21:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hXpEnpiS1ePBTEYU3pwBmvZxz5PJcinCq7TWGdPw/Os=; b=mtuy4EfNZowSnAmVeXFnTen8WP
        ZN0mBLm9i5sKYJKKtymijO4ypF7qA9JwSyrG3kUaQdJoNsQQbgEHLQH9WAubS/hCEjWQ7apC9c1Cs
        lP9SoFJ3XneIFSG78I0y184SihwC+dXYySbytuiXH+CdUlDXmk8uOD7NCVyv53XP/oBjDm3fUHWs5
        rRdNYWSHgO1px2YqVDriEiqzT3WQicsC/Lu5UfbmvJHsB3WW3zHSGxenYyS4/vefoUX3e83+HtTQs
        wHPXs8pha2SKkKl70XeNi4jn0bz5nbqhAyQ00PJVOdvl4IZkFAomGj5QTjUxd5g/fDmb5barFSMGn
        6/uCaW/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nPB-00GrrW-CH; Mon, 12 Jul 2021 04:19:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 136/137] mm/readahead: Convert page_cache_async_ra() to take a folio
Date:   Mon, 12 Jul 2021 04:07:00 +0100
Message-Id: <20210712030701.4000097-137-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index 71844b55d0a8..51784f8b9b32 100644
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
index 57dd01c5060c..2fda11f583a5 100644
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
index d589f147f4c2..30115a21e304 100644
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
+	if (folio_writeback(folio))
 		return;
 
-	ClearPageReadahead(page);
+	folio_clear_readahead_flag(folio);
 
 	/*
 	 * Defer asynchronous read-ahead on IO congestion.
-- 
2.30.2

