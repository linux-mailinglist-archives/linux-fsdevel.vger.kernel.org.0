Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0912A1D3E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 11:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgKAK3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 05:29:10 -0500
Received: from verein.lst.de ([213.95.11.211]:58318 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgKAK3K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 05:29:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8ACD36736F; Sun,  1 Nov 2020 11:29:08 +0100 (CET)
Date:   Sun, 1 Nov 2020 11:29:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/13] mm: simplify
 generic_file_buffered_read_no_cached_page
Message-ID: <20201101102908.GB26447@lst.de>
References: <20201031090004.452516-1-hch@lst.de> <20201031090004.452516-6-hch@lst.de> <20201031162813.GS27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031162813.GS27442@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 31, 2020 at 04:28:13PM +0000, Matthew Wilcox wrote:
> On Sat, Oct 31, 2020 at 09:59:56AM +0100, Christoph Hellwig wrote:
> > +static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
> > +		struct page **page)
> 
> I don't like this calling convention.  It's too easy to get it wrong,
> as you demonstrated.  I preferred the way Kent had it with returning
> an ERR_PTR.

I guess for this function we can do that, here is the untested patch
on top of my series to show what we'd end up with:

diff --git a/mm/filemap.c b/mm/filemap.c
index b45f0bafdbaebf..1ac1fcd0067bf1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2281,38 +2281,40 @@ static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
 	return 0;
 }
 
-static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
-		struct page **page)
+static struct page *filemap_new_page(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
+	struct page *page;
 	int error;
 
 	if (iocb->ki_flags & IOCB_NOIO)
-		return -EAGAIN;
+		return ERR_PTR(-EAGAIN);
 
-	*page = page_cache_alloc(mapping);
+	page = page_cache_alloc(mapping);
 	if (!page)
-		return -ENOMEM;
-	error = add_to_page_cache_lru(*page, mapping, index, gfp);
+		return ERR_PTR(-ENOMEM);
+	error = add_to_page_cache_lru(page, mapping, index, gfp);
 	if (error)
 		goto put_page;
-	error = filemap_readpage(iocb, *page);
+	error = filemap_readpage(iocb, page);
 	if (error)
 		goto put_page;
-	if (PageReadahead(*page)) {
+	if (PageReadahead(page)) {
 		error = -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOIO)
 			goto put_page;
 		page_cache_async_readahead(mapping, &iocb->ki_filp->f_ra,
-				iocb->ki_filp, *page, index,
+				iocb->ki_filp, page, index,
 				(iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT);
 	}
 	return 0;
 put_page:
-	put_page(*page);
-	return error;
+	put_page(page);
+	if (error == -EEXIST || error == AOP_TRUNCATED_PAGE)
+		return NULL;
+	return ERR_PTR(error);
 }
 
 static int filemap_find_get_pages(struct kiocb *iocb, struct iov_iter *iter,
@@ -2347,28 +2349,30 @@ static int filemap_read_pages(struct kiocb *iocb, struct iov_iter *iter,
 		return -EINTR;
 
 	nr_pages = filemap_find_get_pages(iocb, iter, pages, nr);
-	if (nr_pages) {
-		for (i = 0; i < nr_pages; i++) {
-			err = filemap_make_page_uptodate(iocb, iter, pages[i],
-					index + i, i == 0);
-			if (err) {
-				for (j = i; j < nr_pages; j++)
-					put_page(pages[j]);
-				nr_pages = i;
-				break;
-			}
+	if (!nr_pages) {
+		pages[0] = filemap_new_page(iocb, iter);
+		if (pages[0] == NULL)
+			goto retry;
+		if (IS_ERR(pages[0]))
+			return PTR_ERR(pages[0]);
+		return 1;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		err = filemap_make_page_uptodate(iocb, iter, pages[i],
+				index + i, i == 0);
+		if (err) {
+			for (j = i; j < nr_pages; j++)
+				put_page(pages[j]);
+			if (likely(i > 0))
+				return i;
+			if (err == AOP_TRUNCATED_PAGE)
+				goto retry;
+			return err;
 		}
-	} else {
-		err = filemap_new_page(iocb, iter, &pages[0]);
-		if (!err)
-			nr_pages = 1;
 	}
 
-	if (likely(nr_pages))
-		return nr_pages;
-	if (err == -EEXIST || err == AOP_TRUNCATED_PAGE)
-		goto retry;
-	return err;
+	return nr_pages;
 }
 
 /**
