Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC882A6F0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbgKDUme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgKDUmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:42:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C84C040203
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p52FzgOz2FkBPUpnXRWkpt0LYlXomk3WlbSKftpD8c0=; b=A+juBz0+LHy7JTvLeBVBKewTTR
        X/CvHXGs8uyBLGTy6KRUItl4+ruaI/d23fCFh5VUyqDx+lMTHT8pr/ITZklMTsxNzOTSK+RVAoZ2i
        rdWiVTpFByEcLysgEswUZF9uNeznw62defgCcvDRh09E1zQNLOBewikFTImphLoLQFIhFGdWTr24c
        xfj2O1yUOAovnWbjcTj6ZbRw7fR1nqAOEiTIA7jJrO33KzdrG2l7LJ+y4AI8TKwTF9P+tAER5tbOD
        oy7jn8eGQQpOLql+b9/0JWR6k2MF1ni6QMqwBOlNKY0bwMJQ9ZmtznHvnbO270vL7NOGb8JxqGu8n
        MGii6dnA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaPbu-0006EW-2z; Wed, 04 Nov 2020 20:42:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v2 15/18] mm/filemap: Restructure filemap_get_pages
Date:   Wed,  4 Nov 2020 20:42:16 +0000
Message-Id: <20201104204219.23810-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201104204219.23810-1-willy@infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the got_pages label, remove indentation, rename find_page to retry,
simplify error handling.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 64 +++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7af0e656c5f6..22716f4bc977 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2349,67 +2349,55 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
+	struct page *page;
 	int err = 0;
 
 	last_index = DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
-find_page:
+retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
 	pagevec_init(pvec);
 	filemap_get_read_batch(mapping, index, last_index, pvec);
-	if (pvec->nr)
-		goto got_pages;
-
-	if (iocb->ki_flags & IOCB_NOIO)
-		return -EAGAIN;
-
-	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
-
-	filemap_get_read_batch(mapping, index, last_index, pvec);
+	if (!pagevec_count(pvec)) {
+		if (iocb->ki_flags & IOCB_NOIO)
+			return -EAGAIN;
+		page_cache_sync_readahead(mapping, ra, filp, index,
+				last_index - index);
+		filemap_get_read_batch(mapping, index, last_index, pvec);
+	}
 	if (!pagevec_count(pvec)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
 		err = filemap_create_page(filp, mapping,
 				iocb->ki_pos >> PAGE_SHIFT, pvec);
 		if (err == AOP_TRUNCATED_PAGE)
-			goto find_page;
+			goto retry;
 		return err;
 	}
-got_pages:
-	{
-		struct page *page = pvec->pages[pvec->nr - 1];
-
-		if (PageReadahead(page)) {
-			err = filemap_readahead(iocb, filp, mapping, page,
-					last_index);
-			if (err) {
-				pvec->nr--;
-				goto err;
-			}
-		}
 
-		if (!PageUptodate(page)) {
-			if ((iocb->ki_flags & IOCB_WAITQ) &&
-			    pagevec_count(pvec) > 1)
-				iocb->ki_flags |= IOCB_NOWAIT;
-			err = filemap_update_page(iocb, mapping, iter, page);
-			if (err)
-				pvec->nr--;
-		}
+	page = pvec->pages[pagevec_count(pvec) - 1];
+	if (PageReadahead(page)) {
+		err = filemap_readahead(iocb, filp, mapping, page, last_index);
+		if (err)
+			goto err;
+	}
+	if (!PageUptodate(page)) {
+		if ((iocb->ki_flags & IOCB_WAITQ) && pagevec_count(pvec) > 1)
+			iocb->ki_flags |= IOCB_NOWAIT;
+		err = filemap_update_page(iocb, mapping, iter, page);
+		if (err)
+			goto err;
 	}
 
+	return 0;
 err:
+	pvec->nr--;
 	if (likely(pvec->nr))
 		return 0;
 	if (err == AOP_TRUNCATED_PAGE)
-		goto find_page;
-	if (err)
-		return err;
-	/*
-	 * No pages and no error means we raced and should retry:
-	 */
-	goto find_page;
+		goto retry;
+	return err;
 }
 
 /**
-- 
2.28.0

