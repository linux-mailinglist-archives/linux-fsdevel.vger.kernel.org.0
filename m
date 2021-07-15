Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE23C9825
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhGOFSO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhGOFSN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:18:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2DBC06175F;
        Wed, 14 Jul 2021 22:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+QMiuiEpJ0BM6oIxbdBSrEZvo8z90xQHIFFLebxeb98=; b=VeoDl4cEmeagzxODdgRGgKDWqc
        86K+UdNRdGmOgAGLmj2qeVpromVgHSQptZ20Jj24x0LJzlb83WDLEnewwLIUn3RtWuFlknumPdr2D
        dVRo2vOHaVoax7IYGTnZAgX4EZ87vROy3IY5dk6QPOYqMEr30WuuXq0O2pQ8aqbXBX4XsipfMwknn
        YhIDNBI0maKfZbTje0m3LvwCfqxRi6uey1TjTodOdHyaCJRZ94rGktv86h2RgkgB9PscmJVNREN1I
        k/ySskM4X1fcwPMc3vJqaBm/2RATFVz4xQioYPwHgM+qBrakycDrh8nf7+GP474MzsZU43N8hXpBI
        zPcpHjjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tgu-0030Mg-AB; Thu, 15 Jul 2021 05:14:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 120/138] mm/filemap: Convert page_cache_delete_batch to folios
Date:   Thu, 15 Jul 2021 04:36:46 +0100
Message-Id: <20210715033704.692967-121-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 18b21d16c9de..8510f67dc749 100644
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
+		WARN_ON_ONCE(!folio_test_locked(folio));
 
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

