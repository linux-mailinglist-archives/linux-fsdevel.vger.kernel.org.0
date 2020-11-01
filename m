Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9464C2A1D50
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 11:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKAKbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 05:31:48 -0500
Received: from verein.lst.de ([213.95.11.211]:58328 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgKAKbr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 05:31:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 383406736F; Sun,  1 Nov 2020 11:31:45 +0100 (CET)
Date:   Sun, 1 Nov 2020 11:31:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] mm: handle readahead in
 generic_file_buffered_read_pagenotuptodate
Message-ID: <20201101103144.GC26447@lst.de>
References: <20201031090004.452516-1-hch@lst.de> <20201031090004.452516-5-hch@lst.de> <20201031170646.GT27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031170646.GT27442@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 31, 2020 at 05:06:46PM +0000, Matthew Wilcox wrote:
> > +static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
> > +		struct page *page, pgoff_t pg_index, bool first)
> 
> I prefer "filemap_update_page".

That has the advantage of being shorter, while I find it less descriptive.
I can updated it and add a comment explaining what it does, as that is
probably warranted anyway.

> I don't understand why you pass in pg_index instead of using page->index.
> We dereferenced the page pointer already to check PageReadahead(), so
> there's no performance issue here.

Yes, we should do that.

> Also, if filemap_find_get_pages() stops on the first !Uptodate or
> Readahead page, as I had it in my patchset, then we don't need the loop
> at all -- filemap_read_pages() looks like:
> 
>         nr_pages = filemap_find_get_pages(iocb, iter, pages, nr);
> 	if (!nr_pages) {
> 		pages[0] = filemap_create_page(iocb, iter);
> 		if (!IS_ERR_OR_NULL(pages[0]))
> 			return 1;
> 		if (!pages[0])
> 			goto retry;
> 		return PTR_ERR(pages[0]);
> 	}
> 
> 	page = pages[nr_pages - 1];
> 	if (PageUptodate(page) && !PageReadahead(page))
> 		return nr_pages;
> 	err = filemap_update_page(iocb, iter, page);
> 	if (!err)
> 		return nr_pages;
> 	nr_pages -= 1;
> 	if (nr_pages)
> 		return nr_pages;
> 	return err;

This looks sensible, but goes beyond the simple refactoring I had
intended.  Let me take a more detailed look at your series (I had just
updated my existing series to to the latest linux-next) and see how
it can nicely fit in.
