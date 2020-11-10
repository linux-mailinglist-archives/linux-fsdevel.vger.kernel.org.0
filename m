Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36942ACBF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbgKJDhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731265AbgKJDhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A76C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+oFQLqyeqDfaRM5Oq7a5M0/S9gJbe43DsuDtSyQTxvA=; b=EZrW/E02KHCAKdeErh0YwgKd3y
        b+j4TumcULFbjSdDqHcCxSX5l4p8JeYliDWBF58Gm4VhhmC0kNFht3kYP/n2oNEXZmnE57w+np5v6
        U3apqNfraowVrKGstxcBhYhSOcjC4ez7BG1wgbrC/UNoTXtL/K2/x7K0KqLIwATuv+KKGPEp7j+zu
        88+WI/R+FhUpwxmYNC1KPvCpL0xs1LKFOB1zg1B/FYsBJmAu3ud6Ydc0LLccm0t/Gmv4UYnf0ifXt
        49qirZQBO0idPC36QVNq68J8WSLBXA9zjDogIEfbE95OiPK01dj3BQgm7uD+2WXuw3I6kGXbUB3j+
        purp52Lg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKT9-00067Y-3e; Tue, 10 Nov 2020 03:37:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 15/18] mm/filemap: Restructure filemap_get_pages
Date:   Tue, 10 Nov 2020 03:37:00 +0000
Message-Id: <20201110033703.23261-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
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
 mm/filemap.c | 71 +++++++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d9cabdff9245..9d0cbdd288fe 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2349,70 +2349,55 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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
 
-	filemap_get_read_batch(mapping, index, last_index, pvec);
-	if (pvec->nr)
-		goto got_pages;
-
-	if (iocb->ki_flags & IOCB_NOIO)
-		return -EAGAIN;
-
-	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
-
 	filemap_get_read_batch(mapping, index, last_index, pvec);
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
-				put_page(page);
-				pvec->nr--;
-				goto err;
-			}
-		}
 
-		if (!PageUptodate(page)) {
-			if ((iocb->ki_flags & IOCB_WAITQ) &&
-			    pagevec_count(pvec) > 1)
-				iocb->ki_flags |= IOCB_NOWAIT;
-			err = filemap_update_page(iocb, mapping, iter, page);
-			if (err) {
-				if (err < 0)
-					put_page(page);
-				pvec->nr--;
-			}
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
-	if (likely(pvec->nr))
+	if (err < 0)
+		put_page(page);
+	if (likely(--pvec->nr))
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

