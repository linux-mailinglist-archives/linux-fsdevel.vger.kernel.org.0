Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D869D2A333B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKBSni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgKBSni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77087C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/CeGi8DzEW3bR+G9BPlfR5yNaaVvUzZl8ckDh3b7Jv8=; b=azWrD4yjPzI3HrnmonDw0uzTIV
        oQKZEKnN7T8C5HXUrNxupDQm4PkJ8qPZmmcICSQhSuKKJmjM9A/i7hJKf59FzaCnI6FhpDCXFldw4
        J1XqH3F7NYUl7J10TZMRSDfwMaD+lXel7jfyYnHG8v3kcB1iyqPhrxBaBfN/yLWIyupuLp55XlJeF
        YTYQiKu5YZLNL9BzANbrv2ZIILnwArOlU7ZtYIFIaKbjNdoBgmG2C68yohQ1EgGfDgKK0opeYgCIV
        HF+AQsvW24tnWccvMGPt6YsPp5MY6H3NQuboZCvFA8jprtusI9DoLrCBvee+2ue3HHI8xZj6fN0El
        MCJRRH0A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenh-0006q0-Fd; Mon, 02 Nov 2020 18:43:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 14/17] mm/filemap: Restructure filemap_get_pages
Date:   Mon,  2 Nov 2020 18:43:09 +0000
Message-Id: <20201102184312.25926-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid a goto, and by the time we get to calling filemap_update_page(),
we definitely have at least one page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0ae8305ccb97..f16b1eb03bca 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2343,6 +2343,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
+	struct page *page;
 	int nr_got, err = 0;
 
 	nr = min_t(unsigned long, last_index - index, nr);
@@ -2351,15 +2352,13 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		return -EINTR;
 
 	nr_got = mapping_get_read_thps(mapping, index, nr, pages);
-	if (nr_got)
-		goto got_pages;
-
-	if (iocb->ki_flags & IOCB_NOIO)
-		return -EAGAIN;
-
-	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
-
-	nr_got = mapping_get_read_thps(mapping, index, nr, pages);
+	if (!nr_got) {
+		if (iocb->ki_flags & IOCB_NOIO)
+			return -EAGAIN;
+		page_cache_sync_readahead(mapping, ra, filp, index,
+				last_index - index);
+		nr_got = mapping_get_read_thps(mapping, index, nr, pages);
+	}
 	if (!nr_got) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
@@ -2371,20 +2370,16 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 			return PTR_ERR(pages[0]);
 		return 1;
 	}
-got_pages:
-	if (nr_got > 0) {
-		struct page *page = pages[nr_got - 1];
 
-		if (PageReadahead(page))
-			err = filemap_readahead(iocb, filp, mapping, page,
-					last_index);
-		if (!err && !PageUptodate(page))
-			err = filemap_update_page(iocb, mapping, iter, page,
-					nr_got == 1);
-		if (err)
-			nr_got--;
-	}
+	page = pages[nr_got - 1];
+	if (PageReadahead(page))
+		err = filemap_readahead(iocb, filp, mapping, page, last_index);
+	if (!err && !PageUptodate(page))
+		err = filemap_update_page(iocb, mapping, iter, page,
+				nr_got == 1);
 
+	if (err)
+		nr_got--;
 	if (likely(nr_got))
 		return nr_got;
 	if (err < 0)
-- 
2.28.0

