Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85130085D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbhAVQMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbhAVQMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:12:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195DDC06178B;
        Fri, 22 Jan 2021 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=e1dqgx7QZzF3L8VaYSOlRMVWVBZcwhnmiE8oxge+DEQ=; b=t5K7WMmRr+FAuouatu6/DI/DdL
        iOgTBwpbWzuKJYr5nYFcCK0orqCF84qm96OLA2hhXMbJj2nAdWP1fkxIsKEWC6psFhcU8Pnqb+ihA
        HYWH8j9vaGAnuhMrGM6+YGtfs4ntdsemtIy5fiH1tjoXEuWYnFLFqoPhwA6s2UdV0s0cZYI/3TDQF
        Ut73yAgcU57TYv2tg67aS1ASBCmUlXXMOdYZ5v+gpCO42OCk7xEWrkbwuglriuBY2Atq/AiZcs86Q
        lYQhNbywBzeLvQvTjBqMMRjkyvN+16EsDBrHT6i+tszyv8SWiRyrDwqXzp2vEY4mpUM/KbD4UTAx4
        pemeKiPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2z0m-000waS-3W; Fri, 22 Jan 2021 16:10:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 12/18] mm/filemap: Move the iocb checks into filemap_update_page
Date:   Fri, 22 Jan 2021 16:01:34 +0000
Message-Id: <20210122160140.223228-13-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need to give up when a non-blocking request sees a !Uptodate page.
We may be able to satisfy the read from a partially-uptodate page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 469fc97659cb5..9fbfb27483147 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2253,15 +2253,16 @@ static int filemap_update_page(struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	int error;
 
-	if (iocb->ki_flags & IOCB_WAITQ) {
-		error = lock_page_async(page, iocb->ki_waitq);
-		if (error)
-			return error;
-	} else {
-		if (!trylock_page(page)) {
+	if (!trylock_page(page)) {
+		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
+			return -EAGAIN;
+		if (!(iocb->ki_flags & IOCB_WAITQ)) {
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
+		error = __lock_page_async(page, iocb->ki_waitq);
+		if (error)
+			return error;
 	}
 
 	if (!page->mapping)
@@ -2379,14 +2380,9 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		if (!PageUptodate(page)) {
-			if ((iocb->ki_flags & IOCB_NOWAIT) ||
-			    ((iocb->ki_flags & IOCB_WAITQ) && pvec->nr > 1)) {
-				put_page(page);
-				pvec->nr--;
-				err = -EAGAIN;
-				goto err;
-			}
-
+			if ((iocb->ki_flags & IOCB_WAITQ) &&
+			    pagevec_count(pvec) > 1)
+				iocb->ki_flags |= IOCB_NOWAIT;
 			err = filemap_update_page(iocb, mapping, iter, page,
 					pg_pos, pg_count);
 			if (err) {
-- 
2.29.2

