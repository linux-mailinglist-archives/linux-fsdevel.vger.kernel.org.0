Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7BE2FA739
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406940AbhARRPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393250AbhARRDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B695EC0613C1;
        Mon, 18 Jan 2021 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XYfT3Eibv2mij2dwdpauz6iOhPLmXhgJe381ycV9MHM=; b=HTw5XSDxVNLp17ewBpi3x/wlyU
        59OEvE+ztbRz0pz0yEbv3VMWcu289ZuznLzqrszYwY7WYMUDEfOo8lDGbX1ZsGq9ky25QkeXHXcOL
        Zj9gu4RQ+hc7IEFd/7x9YAb2kwO7fGMtvsDPZCUGedlVX6+ywqUIFz06bYjiPWAYG+2s3KnNcQyqz
        BkBDFtDPvInn2XzPVMocXv+fBx6i9a5Aaq230SH/azVRbo3Fa7gaLjJ+WX6DGh3jDL8hNrOLf9gza
        ZHoG/fmajBbAKsE+jxPW4Vu5VwibIGxajOIvlh0OY63rhW7m3CSoPVN64fdljcSrrr5aGnmxoGeVh
        zLK3QAGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1XvL-00D7NY-Fj; Mon, 18 Jan 2021 17:02:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/27] mm/filemap: Convert wait_on_page_locked_async to wait_on_folio_locked_async
Date:   Mon, 18 Jan 2021 17:01:39 +0000
Message-Id: <20210118170148.3126186-19-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 648f78577ab7..e997f4424ed9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1338,22 +1338,22 @@ int wait_on_page_bit_killable(struct page *page, int bit_nr)
 }
 EXPORT_SYMBOL(wait_on_page_bit_killable);
 
-static int __wait_on_page_locked_async(struct page *page,
+static int __wait_on_folio_locked_async(struct folio *folio,
 				       struct wait_page_queue *wait, bool set)
 {
-	struct wait_queue_head *q = page_waitqueue(page);
+	struct wait_queue_head *q = page_waitqueue(&folio->page);
 	int ret = 0;
 
-	wait->page = page;
+	wait->page = &folio->page;
 	wait->bit_nr = PG_locked;
 
 	spin_lock_irq(&q->lock);
 	__add_wait_queue_entry_tail(q, &wait->wait);
-	SetPageWaiters(page);
+	SetFolioWaiters(folio);
 	if (set)
-		ret = !trylock_page(page);
+		ret = !trylock_folio(folio);
 	else
-		ret = PageLocked(page);
+		ret = FolioLocked(folio);
 	/*
 	 * If we were successful now, we know we're still on the
 	 * waitqueue as we're still under the lock. This means it's
@@ -1368,12 +1368,12 @@ static int __wait_on_page_locked_async(struct page *page,
 	return ret;
 }
 
-static int wait_on_page_locked_async(struct page *page,
+static int wait_on_folio_locked_async(struct folio *folio,
 				     struct wait_page_queue *wait)
 {
-	if (!PageLocked(page))
+	if (!FolioLocked(folio))
 		return 0;
-	return __wait_on_page_locked_async(compound_head(page), wait, false);
+	return __wait_on_folio_locked_async(folio, wait, false);
 }
 
 /**
@@ -1539,7 +1539,7 @@ EXPORT_SYMBOL_GPL(__lock_folio_killable);
 
 int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait)
 {
-	return __wait_on_page_locked_async(&folio->page, wait, true);
+	return __wait_on_folio_locked_async(folio, wait, true);
 }
 
 /*
@@ -2256,7 +2256,7 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 	 * serialisations and why it's safe.
 	 */
 	if (iocb->ki_flags & IOCB_WAITQ) {
-		error = wait_on_page_locked_async(page,
+		error = wait_on_folio_locked_async(page_folio(page),
 						iocb->ki_waitq);
 	} else {
 		error = wait_on_page_locked_killable(page);
-- 
2.29.2

