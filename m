Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC873C982B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbhGOFTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhGOFTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:19:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D288C06175F;
        Wed, 14 Jul 2021 22:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=A3fDsifX2HweSey8qgo1JGC+yGw4pXjaGc1TRorG4VY=; b=Qqtj4BqJne5QKkrZcxxk2BWSJg
        dw4eOLXguP0WMWShLnQeVlZuwwIL0jK5QP1waHM7LYE5qu2M5E0B3EvsG/ZDnhpKHtljn+ZokxEAd
        TWTLls5w96wGkw0XQgI07Ss/ryG4icjyLjYy3lkRuKrk7XlmXmG/Y33V9rpcpGmm/3a3ifXpywStV
        A9l20Jlua7h9Y9ds1AxeOIB7ugMrEBJ1iOgEGidgeQRjES7x93croNfa4y12tCbM1iSEp33BWH6Ym
        Q8p4WQOj3Qb8RpVw8OT4qfCe1fCEkhtieJUbZjrOtRdRjj2MaRWO45PaxL8MPqecU8+zUKWroshBh
        5kP1bctw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tiR-0030St-Tr; Thu, 15 Jul 2021 05:15:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 122/138] mm/filemap: Use folios in next_uptodate_page
Date:   Thu, 15 Jul 2021 04:36:48 +0100
Message-Id: <20210715033704.692967-123-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 717b0d262306..545323a77c1c 100644
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
+		if (folio_test_locked(folio))
 			continue;
-		if (!page_cache_get_speculative(page))
+		if (!folio_try_get_rcu(folio))
 			continue;
 		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(xas)))
+		if (unlikely(folio != xas_reload(xas)))
 			goto skip;
-		if (!PageUptodate(page) || PageReadahead(page))
+		if (!folio_test_uptodate(folio) || folio_test_readahead(folio))
 			goto skip;
-		if (!trylock_page(page))
+		if (!folio_trylock(folio))
 			goto skip;
-		if (page->mapping != mapping)
+		if (folio->mapping != mapping)
 			goto unlock;
-		if (!PageUptodate(page))
+		if (!folio_test_uptodate(folio))
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

