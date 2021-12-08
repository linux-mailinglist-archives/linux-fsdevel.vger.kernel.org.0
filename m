Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA1846CC7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhLHE24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240261AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E770BC0698D0
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rsEJxdywVEoM0ervtUyhDSP7KMwK7lVPrAeU8/731OE=; b=qz7qSp9TRh7ufJAZHOEWtvrC1s
        +otedc/SjuvSkhoNGBamGLmEk6/Nqh1nBjaa3f4ZIfkFVTGWbrZA4uz+VmGndZ/S1WDXB+Qs7pYqy
        YrOx1isibEPxZqb+X8j1xW74iFmIGSY95jRod+875T3k8ZuiZpsa0H7Us1B7vmtyeSsH/NKl0MOer
        Dv0rPgXENpRCozTrexfXAn+QHK6vE1pZrQ1keQNYqLTv1roMHTVFson/JAASxTQLnkenlldv6ePVh
        MXsyLRBp19oDd7+4MaJdGCl3lBIvmH/5qXM2pPbUs/RAyz8g66JG5gS4qCLXIRfxcosuHedgsB8Xo
        O+p6ERYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU6-0084ax-5i; Wed, 08 Dec 2021 04:23:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 34/48] shmem: Convert part of shmem_undo_range() to use a folio
Date:   Wed,  8 Dec 2021 04:22:42 +0000
Message-Id: <20211208042256.1923824-35-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

find_lock_entries() never returns tail pages.  We cannot use page_folio()
here as the pagevec may also contain swap entries, so simply cast.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/shmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 18f93c2d68f1..40da9075374b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -936,22 +936,22 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end && find_lock_entries(mapping, index, end - 1,
 			&pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+			struct folio *folio = (struct folio *)pvec.pages[i];
 
 			index = indices[i];
 
-			if (xa_is_value(page)) {
+			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
 				nr_swaps_freed += !shmem_free_swap(mapping,
-								index, page);
+								index, folio);
 				continue;
 			}
-			index += thp_nr_pages(page) - 1;
+			index += folio_nr_pages(folio) - 1;
 
-			if (!unfalloc || !PageUptodate(page))
-				truncate_inode_page(mapping, page);
-			unlock_page(page);
+			if (!unfalloc || !folio_test_uptodate(folio))
+				truncate_inode_page(mapping, &folio->page);
+			folio_unlock(folio);
 		}
 		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
-- 
2.33.0

