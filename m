Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80C2ACBF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbgKJDhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730857AbgKJDhR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ACAC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lVuZuFVfNijs5cAJJuh1IhLvCBBPHWyHx4iPvOy8Rp0=; b=acOJjM2iGEmrOi2I8aVILPkAPZ
        Etc+Y4Rtb5ZUfgazghWg/RQDyGEtTUMFlk/m6GQZX2Cv9/53dRXrTAEJe/EYOJF6QdtoHSMbx0GYe
        efy9w315TkPikU1yhy7+hRrUWfXCVz/Cqw72RkB6hGBYrUeWGLK9vWHXvs8pXebqwsAsZHYQbIl5g
        p7JSZ659sIF7EI5LvCtfstfChzqYINmJ9a3yM9Mzf7jYC8a95SKkuDuwRj77ypD6a9XvGmh50yD+S
        At9Rczew2mR0JT8Wy5/OMCSdh0ieQQ6+UaKQA1Uf8lPOJ95ktXCH/ChoGZJFVrrX97e6+Xx6DqVwH
        SXNg3mWg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKT3-00066Q-TG; Tue, 10 Nov 2020 03:37:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 12/18] mm/filemap: Move the iocb checks into filemap_update_page
Date:   Tue, 10 Nov 2020 03:36:57 +0000
Message-Id: <20201110033703.23261-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
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
index 60ce7f15cc7e..2218fe610c42 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2238,15 +2238,16 @@ static int filemap_update_page(struct kiocb *iocb,
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
@@ -2364,14 +2365,9 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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
2.28.0

