Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C87A30084A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbhAVQJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbhAVQJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:09:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B949C061786;
        Fri, 22 Jan 2021 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bs18mHWbgxEoTtD6bBUn7VUlixvEct0iYWwE1wWQVR8=; b=dDBSQGUGaQ2h865+PRYt2as8Mw
        6ElxeUl+AyKNn6ie8vU58KGmB8gWPB4cLdstDwKByFwt9jwR+JSb/djeiEP40PB/jJx14CIS4zPzI
        NPoY8fcrorVopBy8aQqWHaEy5CR7o+LnDcWXiD7EOHfm/xVuu35qTvN/rrrPqZDWbcOW6xElYutWs
        ZhLwll2HEQMwWMJ9EMTT4t9xpP3faycE/uIeek0PTv2rp7mLeYiIVQVyjzxr2yt6m2dhAElqatjo/
        lqQ3ZOaZvTiFCXxyq2NX9UYDqY962ChR8iJlvU2uBQ4jFJldX0LxGpdQ+mTAP4o4Usgq4o2aWYBB7
        sNjpgKgw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2yxp-000wPN-4a; Fri, 22 Jan 2021 16:07:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 08/18] mm/filemap: Don't call ->readpage if IOCB_WAITQ is set
Date:   Fri, 22 Jan 2021 16:01:30 +0000
Message-Id: <20210122160140.223228-9-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
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
index abd596931f699..ee1255a88106f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2167,16 +2167,6 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
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
@@ -2228,7 +2218,7 @@ static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
 	struct file_ra_state *ra = &filp->f_ra;
 	int error;
 
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT)) {
+	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
 		unlock_page(page);
 		put_page(page);
 		return ERR_PTR(-EAGAIN);
@@ -2249,7 +2239,7 @@ static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
 	}
 
 	if (!PageUptodate(page)) {
-		error = lock_page_for_iocb(iocb, page);
+		error = lock_page_killable(page);
 		if (unlikely(error)) {
 			put_page(page);
 			return ERR_PTR(error);
-- 
2.29.2

