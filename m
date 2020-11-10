Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D012ACBEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbgKJDhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbgKJDhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D243EC0617A7
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zLlWyCMf31hyFifs0hzr1y9FHea3KxcZRxU6ykAetmA=; b=Rog97bTF/Qc3jcj36Q4fpocJHb
        LkVRzaE5JlmDBt8zoWpQfJ367lAGIXsOFDR1ygaWS3bmr2PttrkJpFLnVjf31SIaHrG2Wt8fUQpdC
        d1LHT/DnhMs3ogo2VxFxU2epe17U7DrdNTe47IiykSi0TvNgIWhoTCcRC+RqyEJQEps/U3XPHwkzB
        Kbmb6fkASTL9qBnR9KWZSWSdaJxlX4dBuvsQsvdT8ySneRAjhUPAsYshArkaUfV5Ygk3hNJkwL0vf
        b/YgLQbDKNL7yUdYUAzB1xqKzh3QUMn8OhiMTIL7l0rax/QYtnf0rDKAbnq06F6k4xUGDnKz30oDt
        SjQHSNUA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKSz-00065K-Fu; Tue, 10 Nov 2020 03:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 08/18] mm/filemap: Don't call ->readpage if IOCB_WAITQ is set
Date:   Tue, 10 Nov 2020 03:36:53 +0000
Message-Id: <20201110033703.23261-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The readpage operation can block in many (most?) filesystems, so we
should punt to a work queue instead of calling it.  This was the last
caller of lock_page_for_iocb(), so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2d8b31a31a7b..3e2994a84a81 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2152,16 +2152,6 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
 	ra->ra_pages /= 4;
 }
 
-static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
-{
-	if (iocb->ki_flags & IOCB_WAITQ)
-		return lock_page_async(page, iocb->ki_waitq);
-	else if (iocb->ki_flags & IOCB_NOWAIT)
-		return trylock_page(page) ? 0 : -EAGAIN;
-	else
-		return lock_page_killable(page);
-}
-
 /*
  * filemap_get_read_batch - Get a batch of pages for read
  *
@@ -2213,7 +2203,7 @@ static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
 	struct file_ra_state *ra = &filp->f_ra;
 	int error;
 
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT)) {
+	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
 		unlock_page(page);
 		put_page(page);
 		return ERR_PTR(-EAGAIN);
@@ -2234,7 +2224,7 @@ static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
 	}
 
 	if (!PageUptodate(page)) {
-		error = lock_page_for_iocb(iocb, page);
+		error = lock_page_killable(page);
 		if (unlikely(error)) {
 			put_page(page);
 			return ERR_PTR(error);
-- 
2.28.0

