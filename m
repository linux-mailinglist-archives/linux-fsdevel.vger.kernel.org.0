Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAC62A6F0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgKDUmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731475AbgKDUm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:42:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC8C061A4C
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 12:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9CL+S7Fi5xbteEEqYAzcQmFqJbUHwSVAW/7+GqlnElo=; b=C0Z8ozkgSg6mNgnD3anPbyeVoW
        bkLT+SwwEaO2KHeph6uQAn/So2NFZ5XUN/nG4kF+0dn1AfmbjSxl8ZO5QZggf/YeLNHij3viO1HHk
        wMs2vARWeHFz81/RRFtot6jGpwPhHD/FIOnYL0MQwu1uCqK7d4AbtM+4e/azKSVBusyr3BaTB6dPB
        mCYrf/x2xdZB3RG4E73xM8ZkkjMwxwQjtASJZaUc8gfiO7HyOgUSLbWcYa/Yau7KCIxvk4ESGfnsn
        ZCw0zSqtODXjVX4isvGSsszB+5hFAI1pVwkQx2JAS78SJupnswH2v9Db64Iu4JLrUYOIQoR7iUV3y
        WpPvvmEA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaPbt-0006E6-0o; Wed, 04 Nov 2020 20:42:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v2 12/18] mm/filemap: Move the iocb checks into filemap_update_page
Date:   Wed,  4 Nov 2020 20:42:13 +0000
Message-Id: <20201104204219.23810-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201104204219.23810-1-willy@infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
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
index 93c054f51677..9db94876122c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2236,17 +2236,18 @@ static int filemap_update_page(struct kiocb *iocb,
 		struct page *page, loff_t pos, loff_t count)
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
+		if (!(iocb->ki_flags & IOCB_WAITQ)) {
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
+		error = __lock_page_async(page, iocb->ki_waitq);
+		if (error)
+			goto error;
 	}
 
 	if (!page->mapping)
@@ -2368,14 +2369,9 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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
 			if (err)
-- 
2.28.0

