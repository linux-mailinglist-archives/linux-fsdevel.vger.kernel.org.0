Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A763C42B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhGLEOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGLEOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:14:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19957C0613DD;
        Sun, 11 Jul 2021 21:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fZdRn1yhmcLn0lDPJAnyyyx+13CHES3m3rlexw8idpk=; b=TN6wAcfu+tdGtMZBtTHJYdSv+s
        QCfrTrRbeyqgW3aziQfQ19qfFkyjpZUgu4N+z6JIUTzz2YYwbBq7SqB5u62evBGJfP+CF4jsqZBnT
        UKsx0kT4iZoVBGVh5GMfVml+85Bjk905ZeG86TVeMuoVezUrvkaAAOL3aVMx1eHU9AHepsw1cldLn
        YCDJ2NCcnytXP555DCDbE0ESgI8k5nObOhOqhbYm14tOlt2BWhz1KgYvqf+aa56503eqPpgLXhKch
        yUFutu6MwJvITTJsFtexHXgT6Wgi1Y5+RYfWVxt4gVKDACQacr+Vol+/5Gw64ck3lXYlilQMdxcCE
        wcn1p/Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nHB-00GrHu-B7; Mon, 12 Jul 2021 04:10:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 121/137] mm/filemap: Use folios in next_uptodate_page
Date:   Mon, 12 Jul 2021 04:06:45 +0100
Message-Id: <20210712030701.4000097-122-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves 105 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9a6550c8b7c7..37fb333d56ce 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3105,43 +3105,43 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	return false;
 }
 
-static struct page *next_uptodate_page(struct page *page,
+static struct page *next_uptodate_page(struct folio *folio,
 				       struct address_space *mapping,
 				       struct xa_state *xas, pgoff_t end_pgoff)
 {
 	unsigned long max_idx;
 
 	do {
-		if (!page)
+		if (!folio)
 			return NULL;
-		if (xas_retry(xas, page))
+		if (xas_retry(xas, folio))
 			continue;
-		if (xa_is_value(page))
+		if (xa_is_value(folio))
 			continue;
-		if (PageLocked(page))
+		if (folio_locked(folio))
 			continue;
-		if (!page_cache_get_speculative(page))
+		if (!folio_try_get_rcu(folio))
 			continue;
 		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(xas)))
+		if (unlikely(folio != xas_reload(xas)))
 			goto skip;
-		if (!PageUptodate(page) || PageReadahead(page))
+		if (!folio_uptodate(folio) || folio_readahead(folio))
 			goto skip;
-		if (!trylock_page(page))
+		if (!folio_trylock(folio))
 			goto skip;
-		if (page->mapping != mapping)
+		if (folio->mapping != mapping)
 			goto unlock;
-		if (!PageUptodate(page))
+		if (!folio_uptodate(folio))
 			goto unlock;
 		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
 		if (xas->xa_index >= max_idx)
 			goto unlock;
-		return page;
+		return &folio->page;
 unlock:
-		unlock_page(page);
+		folio_unlock(folio);
 skip:
-		put_page(page);
-	} while ((page = xas_next_entry(xas, end_pgoff)) != NULL);
+		folio_put(folio);
+	} while ((folio = xas_next_entry(xas, end_pgoff)) != NULL);
 
 	return NULL;
 }
-- 
2.30.2

