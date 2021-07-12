Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FB93C429C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhGLEJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhGLEJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:09:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913A8C0613DD;
        Sun, 11 Jul 2021 21:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TAfWZFSMa+r6x6aF07fD4ELFNgDf4ivzI5IhsXweRRg=; b=FhJ3dVxLXGnDDYeuYSgCX/luni
        Yc0Ka112sn8eqIPCyqiquqE9VB6n3JpmqvxtUJvEe7zJxDBna5RasjYwI3d+fKeOuTJMT9vjEYOrZ
        VLHThw68DdGFWRzA0p4e+lkOt2v+sJjiwlJKStYpXYKuOqurXRIi3yg2iMGRH/5bGP35K37WgK6Mk
        IJckhm07H057n6PVzCLlslecyIUgG4f8iXUwwUCYCYCD7WzRtlY+N3P/ylrgn0xsbVyhEv0Nee3ZA
        d8jXi/n8i+NOP6jiBsGG3i3o30daqpdiYDo6XVH51Ds+yg/2eOa6e8mrCgm/fj0SFlyiRPxzj070h
        ghJx6HHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nCQ-00GquD-OC; Mon, 12 Jul 2021 04:05:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 112/137] mm/filemap: Convert find_get_pages_contig to folios
Date:   Mon, 12 Jul 2021 04:06:36 +0100
Message-Id: <20210712030701.4000097-113-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

None of the callers of find_get_pages_contig() want tail pages.  They all
use order-0 pages today, but if they were converted, they'd want folios.
So just remove the call to find_subpage() instead of replacing it with
folio_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3d1a8d5f595b..e9674aabfff9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2141,36 +2141,35 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 			       unsigned int nr_pages, struct page **pages)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
-	struct page *page;
+	struct folio *folio;
 	unsigned int ret = 0;
 
 	if (unlikely(!nr_pages))
 		return 0;
 
 	rcu_read_lock();
-	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
-		if (xas_retry(&xas, page))
+	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
+		if (xas_retry(&xas, folio))
 			continue;
 		/*
 		 * If the entry has been swapped out, we can stop looking.
 		 * No current caller is looking for DAX entries.
 		 */
-		if (xa_is_value(page))
+		if (xa_is_value(folio))
 			break;
 
-		if (!page_cache_get_speculative(page))
+		if (!folio_try_get_rcu(folio))
 			goto retry;
 
-		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(&xas)))
+		if (unlikely(folio != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = find_subpage(page, xas.xa_index);
+		pages[ret] = &folio->page;
 		if (++ret == nr_pages)
 			break;
 		continue;
 put_page:
-		put_page(page);
+		folio_put(folio);
 retry:
 		xas_reset(&xas);
 	}
-- 
2.30.2

