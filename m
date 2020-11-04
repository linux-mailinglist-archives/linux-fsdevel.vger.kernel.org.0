Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3918E2A6F08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbgKDUm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbgKDUmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:42:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F55EC0613D3
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 12:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YNNeXBhVHv699q0LtJ4ucb2dmsW+OxEQo3+eO1Ahvb4=; b=IwcwNlmfy7T+QEBcoL3iK+lN0F
        4R1xJ6qpLTU1QWkf0ZKNCW6u+iOIUwggGmWCSIzXwVEpsKPzO7vXrJDVpWOVyAwWv+YYCcd7sBjve
        rdWMdR0lIZBQ+INl7MHQsI09C0XhTYUmQrJ5L84j3RnwyEa0GPW6G7nqN1wT5VNCp0kd2ONtXO7GR
        nsYEsmw2P/Hs37bX3EgTh6Fy4+WAjrESS0yeHHij4VWW2Bzipe+pdVxwi9TN+vAeomIxFl67xlfOm
        u4C4AaatKA7ROAYpID67JY/Avv+USumnGAMEfCUIxuv+pvvbjWssTjAsDOXKJdhhyPXW22ZvZZWjH
        4JVWtkBw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaPbr-0006Dd-Nd; Wed, 04 Nov 2020 20:42:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v2 08/18] mm/filemap: Don't call ->readpage if IOCB_WAITQ is set
Date:   Wed,  4 Nov 2020 20:42:09 +0000
Message-Id: <20201104204219.23810-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201104204219.23810-1-willy@infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The readpage operation can block in many (most?) filesystems, so we
should punt to a work queue instead of calling it.  This was the last
caller of lock_page_async(), so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6ad067fe5d47..6699581bd4f5 100644
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

