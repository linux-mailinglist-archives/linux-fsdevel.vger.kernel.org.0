Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9D46CC64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbhLHE1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2537C0698CA
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vspXQFsQkYxygqyTSBfIIKIkyYP21RM2Z3OtZtUgtKM=; b=Mf+AtuGjXHj7NKgO8YT6qB47HB
        47WlsT2Vtws44d24pLEmegarURySLywiq+9j2LDZzsZ2BRJyFL79jKRmAzs5Z02guqjY1sbFy0Yj3
        YPjjLBXANKhoJ7qV/a8+lOGw5qUAWMj551aBNnXRuhiMBzSQhvz4xHPxF8ykr8jG3m11d5C4gSeoi
        vPdp9d9BcM9Y0WjnJFZ56dJk79xr9Tm5a4jRXxmh95Sp7fpseiH72UmvST29p6DdnuNIn4TnsuvTb
        whUewrpLIfqx+zKIdf3IosKmbpPpc/0hL8Ub+kXvpuq2672ykfYvUFo08ry7FjCg98gI1RORt1B2V
        CeLXouOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU5-0084ZW-4F; Wed, 08 Dec 2021 04:23:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 28/48] filemap: Use folios in next_uptodate_page
Date:   Wed,  8 Dec 2021 04:22:36 +0000
Message-Id: <20211208042256.1923824-29-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
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
index 3ea81adbabd8..47880ec789f4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3227,43 +3227,43 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
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
2.33.0

