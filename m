Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5F32A332F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgKBSnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgKBSnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33781C061A49
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=73msYa311R11WAkHAc3cSVAXeaQOWUerwPhWbLhOqVE=; b=DCaCsr2SioJGpGQUS75coYTkcw
        Y/6SR4iAb+jkb4MUbGIwu34RdotOOrFJF1qe4BfRZFdx0PAAgsoq8kUR6zEoI6DA2PlBhm4DI5z1B
        yM+cFtXZJsWF6VC0rmq0yOCewwamZMJZJI38bKB30+evYQWty+SVd5Lhq8r9rJMIDkg80rdRxj6hx
        w3NUzDOrWRJ3RptaiI3JFB7tk/ReLEsEHSV5qBwQJT/bTbw4G76eRiYfvLNigrh2Q0CthVui19zEx
        2KgL/d82nyEnDIOKApXYd5YJCkIy9ZWVHg6w1vwX/BsjDNNq1Y2+HFTkpbESF6+2K59vYPcTyAjsL
        7BfvRwpw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenZ-0006n8-S2; Mon, 02 Nov 2020 18:43:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 08/17] mm/filemap: Change filemap_create_page arguments
Date:   Mon,  2 Nov 2020 18:43:03 +0000
Message-Id: <20201102184312.25926-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_create_page() doesn't need the iocb or the iter.  It just needs
the file and the index.  Move the iocb flag checks to the caller.  We can
skip checking GFP_NOIO as that's checked a few lines earlier.  There's no
need to fall through to filemap_update_page() -- if filemap_create_page
couldn't update it, filemap_update_page will not be able to.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 171da5c592fa..5527b239771c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2285,26 +2285,20 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
 	return NULL;
 }
 
-static struct page *filemap_create_page(struct kiocb *iocb,
-		struct iov_iter *iter)
+static struct page *filemap_create_page(struct file *file,
+		struct address_space *mapping, pgoff_t index)
 {
-	struct file *filp = iocb->ki_filp;
-	struct address_space *mapping = filp->f_mapping;
-	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	struct page *page;
 	int error;
 
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
-		return ERR_PTR(-EAGAIN);
-
 	page = page_cache_alloc(mapping);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
 	error = add_to_page_cache_lru(page, mapping, index,
-				      mapping_gfp_constraint(mapping, GFP_KERNEL));
+			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (!error)
-		error = filemap_read_page(iocb->ki_filp, mapping, page);
+		error = filemap_read_page(file, mapping, page);
 	if (!error)
 		return page;
 	put_page(page);
@@ -2338,13 +2332,17 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
 
 	nr_got = mapping_get_read_thps(mapping, index, nr, pages);
-	if (nr_got)
-		goto got_pages;
-
-	pages[0] = filemap_create_page(iocb, iter);
-	err = PTR_ERR_OR_ZERO(pages[0]);
-	if (!IS_ERR_OR_NULL(pages[0]))
-		nr_got = 1;
+	if (!nr_got) {
+		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
+			return -EAGAIN;
+		pages[0] = filemap_create_page(filp, mapping,
+				iocb->ki_pos >> PAGE_SHIFT);
+		if (!pages[0])
+			goto find_page;
+		if (IS_ERR(pages[0]))
+			return PTR_ERR(pages[0]);
+		return 1;
+	}
 got_pages:
 	if (nr_got > 0) {
 		struct page *page = pages[nr_got - 1];
-- 
2.28.0

