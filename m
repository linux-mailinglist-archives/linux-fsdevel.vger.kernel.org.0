Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157452A14AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgJaJV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJaJV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:21:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE26FC0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=T10jy9Iz/yAzA3CgaR9hbSlNI52YVZfcPdeiTlF9iYY=; b=urH8C7G77+4KOkC9lTS5xhK1AT
        SlVWumQJnWJrIL9gOf6g+k+g3x/YxmWrLZFO78F/ebRUEmrdBDMYlVaJVR+GhCekg5C0zMwvIz8gu
        2VPMTy1GH4lb8bbupsPqSD6eEbt+fx/zHgX7EXf7pQcodhKqW6GllCgOJncAzhacLOWnk1gvbn/DK
        ia+RONyx2XRZTS8fdiPJd2TNqcBeqvErJcSmm/r2UBBTrCfD4iVnhGc+7tMlrMJqUD0Vx1cdoqCWS
        lavi5phru2MkhHEZS2FC1+Ccvp6B04D1G5PA65ivGjeYCt2Rc0HRjEteXtMceH0urAUyJadoFtLGG
        BJrvsWcA==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYn5A-0008HB-DU; Sat, 31 Oct 2020 09:21:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/13] mm: move putting the page on error out of filemap_make_page_uptodate
Date:   Sat, 31 Oct 2020 10:00:00 +0100
Message-Id: <20201031090004.452516-10-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the put_page on error from filemap_make_page_uptodate into the
callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6089f1d9dd429f..5f4937715689e7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2219,11 +2219,11 @@ static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t last = iocb->ki_pos + iter->count;
 	pgoff_t last_index = (last + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	loff_t pos = max(iocb->ki_pos, (loff_t)pg_index << PAGE_SHIFT);
-	int error = -EAGAIN;
+	int error;
 
 	if (PageReadahead(page)) {
 		if (iocb->ki_flags & IOCB_NOIO)
-			goto put_page;
+			return -EAGAIN;
 		page_cache_async_readahead(mapping, &file->f_ra, file, page,
 					   pg_index, last_index - pg_index);
 	}
@@ -2232,7 +2232,7 @@ static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
 		return 0;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
-		goto put_page;
+		return -EAGAIN;
 
 	/*
 	 * See comment in do_read_cache_page on why wait_on_page_locked is used
@@ -2240,13 +2240,13 @@ static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
 	 */
 	if (iocb->ki_flags & IOCB_WAITQ) {
 		if (!first)
-			goto put_page;
+			return -EAGAIN;
 		error = wait_on_page_locked_async(page, iocb->ki_waitq);
 	} else {
 		error = wait_on_page_locked_killable(page);
 	}
 	if (unlikely(error))
-		goto put_page;
+		return error;
 
 	if (PageUptodate(page))
 		return 0;
@@ -2274,27 +2274,19 @@ static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
 	/* Get exclusive access to the page ... */
 	error = lock_page_for_iocb(iocb, page);
 	if (unlikely(error))
-		goto put_page;
+		return error;
 
 page_not_up_to_date_locked:
 	/* Did it get truncated before we got the lock? */
 	if (!page->mapping) {
 		unlock_page(page);
-		error = AOP_TRUNCATED_PAGE;
-		goto put_page;
+		return AOP_TRUNCATED_PAGE;
 	}
 
 	/* Did somebody else fill it already? */
 	if (PageUptodate(page))
 		goto unlock_page;
-	error = filemap_readpage(iocb, page);
-	if (error)
-		goto put_page;
-	return 0;
-
-put_page:
-	put_page(page);
-	return error;
+	return filemap_readpage(iocb, page);
 }
 
 static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
@@ -2317,7 +2309,10 @@ static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
 	error = filemap_readpage(iocb, *page);
 	if (error)
 		goto put_page;
-	return filemap_make_page_uptodate(iocb, iter, *page, index, true);
+	error = filemap_make_page_uptodate(iocb, iter, *page, index, true);
+	if (error)
+		goto put_page;
+	return 0;
 put_page:
 	put_page(*page);
 	return error;
@@ -2360,7 +2355,7 @@ static int filemap_read_pages(struct kiocb *iocb, struct iov_iter *iter,
 			err = filemap_make_page_uptodate(iocb, iter, pages[i],
 					index + i, i == 0);
 			if (err) {
-				for (j = i + 1; j < nr_pages; j++)
+				for (j = i; j < nr_pages; j++)
 					put_page(pages[j]);
 				nr_pages = i;
 				break;
-- 
2.28.0

