Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF12A2A3334
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgKBSn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgKBSn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE3C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=C03/K9nEYgbV/HZHtBn1uLOW4rAEhplcjX1jRdnEKuo=; b=fVkezwnWaBuKXNmMRZUtxfEoWl
        +WfNm+ZKGxwivLIvpQWZqUqnSZb6avA0hoXOXnr5z2pMgjIQc/GBedx7PCh0UsE1OdA562v7iIfEs
        KmcLfDniuSqLqOKBH+xd1OZtCQdAGNq+GYQtSVQR9V0UCViL+lfRkglaFlhrTdBmykHkZDFgrBcFQ
        F0n5UTwsgzkpC9Wk7LGaR4VxjYyQTi0oRUevScTO5vP9eJVZ0L6Snk0Tp9C/FNrFXT4KO+o03Orkg
        Gb+sCY4N9xDs5ruJ05pgozFhtTQ2yXLXiy60R59hZGnLGhm2cRZllw/fVFq53EfIDJE0WJ+D3/tyt
        YohTeBhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenb-0006nZ-2W; Mon, 02 Nov 2020 18:43:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 10/17] mm/filemap: Move the iocb checks into filemap_update_page
Date:   Mon,  2 Nov 2020 18:43:05 +0000
Message-Id: <20201102184312.25926-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need to give up when a special request sees a !Uptodate page.
We may be able to satisfy the read from a partially-uptodate page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ebb14fdec0cc..41b90243f4ee 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2230,17 +2230,21 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 
 static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, struct iov_iter *iter,
-		struct page *page, loff_t pos, loff_t count)
+		struct page *page, loff_t pos, loff_t count, bool first)
 {
 	struct inode *inode = mapping->host;
-	int error;
+	int error = -EAGAIN;
 
-	if (iocb->ki_flags & IOCB_WAITQ) {
-		error = lock_page_async(page, iocb->ki_waitq);
-		if (error)
+	if (!trylock_page(page)) {
+		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
 			goto error;
-	} else {
-		if (!trylock_page(page)) {
+		if (iocb->ki_flags & IOCB_WAITQ) {
+			if (!first)
+				goto error;
+			error = __lock_page_async(page, iocb->ki_waitq);
+			if (error)
+				goto error;
+		} else {
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
@@ -2359,16 +2363,8 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		if (!PageUptodate(page)) {
-			if ((iocb->ki_flags & IOCB_NOWAIT) ||
-			    ((iocb->ki_flags & IOCB_WAITQ) && nr_got > 1)) {
-				put_page(page);
-				nr_got--;
-				err = -EAGAIN;
-				goto err;
-			}
-
 			err = filemap_update_page(iocb, mapping, iter, page,
-					pg_pos, pg_count);
+					pg_pos, pg_count, nr_got == 1);
 			if (err)
 				nr_got--;
 		}
-- 
2.28.0

