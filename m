Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89C946CC7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbhLHE27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD04C0698C9
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4GYC4zomnfMK1s3qCzsnkSCKwVtKcv5N2U8Vny3BnNo=; b=bzIJdgUxakOcUFNXYAWZgFkJnD
        Aa+e38cnGy1mKXDnYvsbjXuKGZI1iEb7oQcsyNa8axteOvrA1ar2xwnwN32TbWzb6SblLHuOMCmgv
        mkFDC/4kSsUlyGvTzQAj4mad9HBk66F2ldJ8uVeVwD+SonVClqfNrTvVX8pZge4F13EBy3UqGDp2w
        jrd4/Itk3EjZdx25fvtjfLETynP7hHhszqijFWPjzYIAT1JeK7cPeWdzviKEBQvLAazGWABSSH7Lc
        IVukBizVdatKzsIrZDqTT95EsW6pIWfnMFab+MU0acXYessKF7H7DaJ4hUlWpLn6JTJCRSMHSAl7C
        2H9B+S6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU4-0084ZK-Uy; Wed, 08 Dec 2021 04:23:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 27/48] filemap: Convert page_cache_delete_batch to folios
Date:   Wed,  8 Dec 2021 04:22:35 +0000
Message-Id: <20211208042256.1923824-28-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Saves one call to compound_head() and reduces text size by 15 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d191a4fd758a..3ea81adbabd8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -290,15 +290,15 @@ static void page_cache_delete_batch(struct address_space *mapping,
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
@@ -307,16 +307,16 @@ static void page_cache_delete_batch(struct address_space *mapping,
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
@@ -324,7 +324,7 @@ static void page_cache_delete_batch(struct address_space *mapping,
 		 * page or the index is of the last sub-page of this compound
 		 * page.
 		 */
-		if (page->index + compound_nr(page) - 1 == xas.xa_index)
+		if (folio->index + folio_nr_pages(folio) - 1 == xas.xa_index)
 			i++;
 		xas_store(&xas, NULL);
 		total_pages++;
-- 
2.33.0

