Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A32A3330
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKBSn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgKBSnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1B9C061A04
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XAUjZnLVwPJBDOtFZ9diYzCnxqB06ylLLNQKCZj7LGU=; b=V+0iGqDSPAjmEncASUjeFL3L2/
        /4ljNA5OjXuJ2R1aYmjW2s3hJkF6vbvH4iPF+fGsceHR8t1TTJBDZZyRyPU44NWMaYbfK3c9+YAh6
        P4PlJn6rC954as35y2dck6LIAB0HVglupPMVGjKBvA3KEeA7x+UJNsnCwPBrk4k2JFqBCBTjmttUn
        W0eWP8QQAen5qkF0Kr9IVjEhr+BV0+u06pIJw8jmdHlmA+kd/NULcS1GbzYg17KiwWy48xilRd12u
        yhi3W6jAmXEVtt/TB51/i0KdX/bx/u7nn6hgzlnf+dI4ThjeSR+Dt6hJlvSxr4uwVxRuGDcwKkyec
        4OGnKsqg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenY-0006mk-LI; Mon, 02 Nov 2020 18:43:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 06/17] mm/filemap: Don't call ->readpage if IOCB_WAITQ is set
Date:   Mon,  2 Nov 2020 18:43:01 +0000
Message-Id: <20201102184312.25926-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The readpage operation can block in many (most?) filesystems, so we
should punt to a work queue instead of calling it.  This was the last
caller of lock_page_async(), so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7a4101ceb106..5bafd2dc830c 100644
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
 static unsigned mapping_get_read_thps(struct address_space *mapping,
 		pgoff_t index, unsigned int nr_pages, struct page **pages)
 {
@@ -2210,7 +2200,7 @@ static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
 	struct file_ra_state *ra = &filp->f_ra;
 	int error;
 
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT)) {
+	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
 		unlock_page(page);
 		put_page(page);
 		return ERR_PTR(-EAGAIN);
@@ -2231,7 +2221,7 @@ static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
 	}
 
 	if (!PageUptodate(page)) {
-		error = lock_page_for_iocb(iocb, page);
+		error = lock_page_killable(page);
 		if (unlikely(error)) {
 			put_page(page);
 			return ERR_PTR(error);
-- 
2.28.0

