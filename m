Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2D3C42AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhGLENP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhGLENP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:13:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6E7C0613DD;
        Sun, 11 Jul 2021 21:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Q7TwLHeSyF6+eG63lskCvQJuWKct+HxA/LZcak9lgZg=; b=A0vaY9sz3vgitFbK8gjQHlT3oN
        4TBp6QbvotVmN2c5DCSUKaWpEWJ8Twoc0U9tWtBrwUlrDu58NuKlS+GfJ+3fnP5fpc+UrA6QE0nCl
        jjzlcH6oMNDScR9smywesaUig/u0Cvp8wjiQ20aLBEucYUOhHXmKH9QpNgnaKg/tBdHDAxoazZpZU
        t2cUX96/UbJZ0wNWcfdivaSrEeuTOpq/wG2qS+bMnGqO4a4Yy0o+NEqsGWUKJdhej0C0WYHoG9vKr
        daZ+IlxnwkSTIfnewKbuiLy/uvUYzb70MsQ2tGjee15DpskcnlDM3K6UqlGw6MkveIV/m4yzF//Ha
        7m0Pk3vg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nG0-00GrD8-By; Mon, 12 Jul 2021 04:09:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 119/137] mm/filemap: Convert page_cache_delete_batch to folios
Date:   Mon, 12 Jul 2021 04:06:43 +0100
Message-Id: <20210712030701.4000097-120-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Saves one call to compound_head() and reduces text size by 15 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6700fbd9e8f6..9da9bac99ecd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -287,15 +287,15 @@ static void page_cache_delete_batch(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, pvec->pages[0]->index);
 	int total_pages = 0;
 	int i = 0;
-	struct page *page;
+	struct folio *folio;
 
 	mapping_set_update(&xas, mapping);
-	xas_for_each(&xas, page, ULONG_MAX) {
+	xas_for_each(&xas, folio, ULONG_MAX) {
 		if (i >= pagevec_count(pvec))
 			break;
 
 		/* A swap/dax/shadow entry got inserted? Skip it. */
-		if (xa_is_value(page))
+		if (xa_is_value(folio))
 			continue;
 		/*
 		 * A page got inserted in our range? Skip it. We have our
@@ -304,16 +304,16 @@ static void page_cache_delete_batch(struct address_space *mapping,
 		 * means our page has been removed, which shouldn't be
 		 * possible because we're holding the PageLock.
 		 */
-		if (page != pvec->pages[i]) {
-			VM_BUG_ON_PAGE(page->index > pvec->pages[i]->index,
-					page);
+		if (&folio->page != pvec->pages[i]) {
+			VM_BUG_ON_FOLIO(folio->index >
+						pvec->pages[i]->index, folio);
 			continue;
 		}
 
-		WARN_ON_ONCE(!PageLocked(page));
+		WARN_ON_ONCE(!folio_locked(folio));
 
-		if (page->index == xas.xa_index)
-			page->mapping = NULL;
+		if (folio->index == xas.xa_index)
+			folio->mapping = NULL;
 		/* Leave page->index set: truncation lookup relies on it */
 
 		/*
@@ -321,7 +321,8 @@ static void page_cache_delete_batch(struct address_space *mapping,
 		 * page or the index is of the last sub-page of this compound
 		 * page.
 		 */
-		if (page->index + compound_nr(page) - 1 == xas.xa_index)
+		if (folio->index + folio_nr_pages(folio) - 1 ==
+								xas.xa_index)
 			i++;
 		xas_store(&xas, NULL);
 		total_pages++;
-- 
2.30.2

