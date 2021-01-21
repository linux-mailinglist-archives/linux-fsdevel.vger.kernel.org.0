Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CCB2FE08C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbhAUEYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbhAUEYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:24:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881FCC0613C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yXZ/kKk/gEGM9nlIini+x0VIFvPB5gNFFHghyUHU7cQ=; b=J0Mm9O3j015bZrIHzk8rpbfAqs
        D6AVCdJpsIZH4D9AqwqAzpvlYXwzhciMPndqaGjxTXyTTnLVd6dcYTbSbVG2B5xu+HXkqKNEEyawb
        dcYe0hcAVR2LLxSpiZFsdZCcqOYsWJGUuPBrrM2Qw7lXzthw05MJ3kdrDJy0tc8f6XwGr5m/+LyAl
        JKh7chLh1EabZk4+vQciyn+7DVUdNERStc2k3MpmV6D5kMZ5WnQ/7kQp7bz4xqS0a/isVGyyrETYO
        XwenG0K9gzWFTQ/1nnUMnPGDzm8W8Qqfj6Nmxmpf6wNY/0bvboYwqaq9NyqgOuBYD67sBAKdD03JW
        gukR8i4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RTq-00GbPR-QI; Thu, 21 Jan 2021 04:22:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 08/18] mm/filemap: Don't call ->readpage if IOCB_WAITQ is set
Date:   Thu, 21 Jan 2021 04:16:06 +0000
Message-Id: <20210121041616.3955703-9-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
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
index 076a97dcacf1e..e904e53ae90d9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2144,16 +2144,6 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
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
@@ -2205,7 +2195,7 @@ static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
 	struct file_ra_state *ra = &filp->f_ra;
 	int error;
 
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT)) {
+	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
 		unlock_page(page);
 		put_page(page);
 		return ERR_PTR(-EAGAIN);
@@ -2226,7 +2216,7 @@ static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
 	}
 
 	if (!PageUptodate(page)) {
-		error = lock_page_for_iocb(iocb, page);
+		error = lock_page_killable(page);
 		if (unlikely(error)) {
 			put_page(page);
 			return ERR_PTR(error);
-- 
2.29.2

