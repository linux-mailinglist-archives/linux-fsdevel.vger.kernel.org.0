Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28D13C9814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbhGOFMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGOFMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:12:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D604C06175F;
        Wed, 14 Jul 2021 22:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YqRnP/8a/779PEXECZaJ/RwhwSMj3E4PlE13UIsVZRY=; b=DCrOOoW08pAgZsmPiZpMkbts8P
        kgrCJi35u5FsXVXQauh0DHyp0lN1fxW0PAF52MVLeXfiux3cFFf01ksA+5BRcUwodT23tDcfA9eK8
        OBP3+y6QJ7HpE3vdigyHC3Xa2z7/jdhBaqD/m1QSf++2B2TH9BKVpBBwL7E1yHMUlTiEbH4+Hyn+t
        T35XIkkul1kql/e7o2CRrw+Yu9ja75HGkXFSLNvD/mLeDZYeGsyWLYYkquA/gebxhcZpW/TqmfrJD
        n8pwbiSIvtkIOUfOisIiMKAgdjskcSXHuvZV2eEfJBgBMT9YBxc0m6biY0CZQfWbo4JdGlax39L70
        HGm1Rd8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tbP-00301t-O5; Thu, 15 Jul 2021 05:08:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 112/138] mm/filemap: Convert filemap_get_read_batch to use folios
Date:   Thu, 15 Jul 2021 04:36:38 +0100
Message-Id: <20210715033704.692967-113-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index c4190c0a6d86..04501bf50448 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2272,32 +2272,31 @@ static void filemap_get_read_batch(struct address_space *mapping,
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
2.30.2

