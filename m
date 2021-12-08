Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C95046CC86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbhLHE3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240029AbhLHE0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1063BC061B38
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uCaFGZPNrDIvJ/RaktaqTtu3XrQ4Je459+upnkc0xsU=; b=LxpvwjxBZz00iz3SIC9Sr0xVQb
        HWICEjt/jzZFnq4UlSgWK0ni+rgkCEjwXhMPSET7+g9KCSu/VUM6ascOeq+5z8PbVBARezxPFFVSB
        5xyf5RH/2Pkp3A7wsaWnPKeM2tYNOKoRvPijVzxsDMUSRYJt+x3bgYxA/QskF9yZkienHEYq4ROcn
        p8sKN3ImlEHijdffLogipscgB0ZrDeGI6oxtch2JrSxKW1yLB/4HmM0CueApx0uSsAMJQarySKyfu
        FsQ0qL7bdcd90I2zlnAQlTg/Yj53IxMEr5Y6Gv18dAa1mM2ng9iGer7wbnrxOP2S5JqbZSjff079w
        65K3EHJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU3-0084Y0-Cw; Wed, 08 Dec 2021 04:23:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 16/48] filemap: Convert filemap_get_read_batch to use folios
Date:   Wed,  8 Dec 2021 04:22:24 +0000
Message-Id: <20211208042256.1923824-17-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page cache only stores folios, never tail pages.  Saves 29 bytes
due to removing calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2a51ec720e9e..120df74f3c7c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2339,32 +2339,31 @@ static void filemap_get_read_batch(struct address_space *mapping,
 		pgoff_t index, pgoff_t max, struct pagevec *pvec)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
-	struct page *head;
+	struct folio *folio;
 
 	rcu_read_lock();
-	for (head = xas_load(&xas); head; head = xas_next(&xas)) {
-		if (xas_retry(&xas, head))
+	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
+		if (xas_retry(&xas, folio))
 			continue;
-		if (xas.xa_index > max || xa_is_value(head))
+		if (xas.xa_index > max || xa_is_value(folio))
 			break;
-		if (!page_cache_get_speculative(head))
+		if (!folio_try_get_rcu(folio))
 			goto retry;
 
-		/* Has the page moved or been split? */
-		if (unlikely(head != xas_reload(&xas)))
+		if (unlikely(folio != xas_reload(&xas)))
 			goto put_page;
 
-		if (!pagevec_add(pvec, head))
+		if (!pagevec_add(pvec, &folio->page))
 			break;
-		if (!PageUptodate(head))
+		if (!folio_test_uptodate(folio))
 			break;
-		if (PageReadahead(head))
+		if (folio_test_readahead(folio))
 			break;
-		xas.xa_index = head->index + thp_nr_pages(head) - 1;
+		xas.xa_index = folio->index + folio_nr_pages(folio) - 1;
 		xas.xa_offset = (xas.xa_index >> xas.xa_shift) & XA_CHUNK_MASK;
 		continue;
 put_page:
-		put_page(head);
+		folio_put(folio);
 retry:
 		xas_reset(&xas);
 	}
-- 
2.33.0

