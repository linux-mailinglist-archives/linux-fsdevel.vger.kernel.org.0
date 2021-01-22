Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5543300868
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbhAVQP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbhAVQOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:14:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB6C061788;
        Fri, 22 Jan 2021 08:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2Z2U/bAknO5pacSZOQIOc8zERYqgUMTGzojmzvHTzDA=; b=Hc4W6u/NLFRNaNTdc15sxIiLXf
        gitT3ZYXCqjwDrOE6gxzxJjPmnGrQ48PaVc6JDYaDjxLLFblVHIJWHFZU6OQQ4kPfJaBeXfyVTcBp
        /j2YWid4mDmgpcW7Sp6NqJMcU8isKSdheSc/LM/bopD25Aa6GgCG6/yubDfMbwpi6WPxXevW3EWw+
        +Eb6Qhwp01sbk09vKRESUz6qkNo/S/iS11XcOPyrZ1UuWYVp6hxywmdztTZVWrYay0fGf9Uzs54dk
        16cbKL3RMQ7SAsUSREujd8A6OHdtynP3lhHaXbcZuGSy/o5JEcxcxjqJHl5Hz1Y0rtMFR5kEeZnSE
        uG5Gp5Og==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2z2k-000wg7-Ng; Fri, 22 Jan 2021 16:12:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 15/18] mm/filemap: Restructure filemap_get_pages
Date:   Fri, 22 Jan 2021 16:01:37 +0000
Message-Id: <20210122160140.223228-16-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the got_pages label, remove indentation, rename find_page to retry,
simplify error handling.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 71 +++++++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ba20baef9056c..1fba96dab4b8e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2361,70 +2361,55 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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
2.29.2

