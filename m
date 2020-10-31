Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35392A18E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgJaRGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 13:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgJaRGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 13:06:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FC6C0617A6
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2fuF80OZc+gvx2mAEagME1x9EKItLKMm/B5VZr0kCEU=; b=HeVU4LwzdFE3OR8gO6KSDQhY/c
        CS3iW+pzUJRP8DiiOc/xvmCnB5lWh2rVaWVXSv+jvIR7HVGkxj74mVMG+qs0icUQHxMX8hicjULdc
        3EX3wGUZ3Ortu/eLUmezSWF/UokGP8EERdG0JLDEBBEsIUH2NPGVvw8R8RmdriGxgHbmF/IiyFGOa
        bu5WJr2IHOL7VT1vbPlmWuvX3wPdtqssaxDbYSuXdIi8giQTJozOmg9yUUm4qJqNkvSoMqs6z5y8j
        6zPFxVVxeoXqnNpuVD/m8gsEgxTYl4AG9u1i5llrTYQxzHvgBvd82t5PadLq5JO1kHBUh6sIpwcIU
        VJZHxqnA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYuL0-00005G-9a; Sat, 31 Oct 2020 17:06:46 +0000
Date:   Sat, 31 Oct 2020 17:06:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] mm: handle readahead in
 generic_file_buffered_read_pagenotuptodate
Message-ID: <20201031170646.GT27442@casper.infradead.org>
References: <20201031090004.452516-1-hch@lst.de>
 <20201031090004.452516-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031090004.452516-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 31, 2020 at 09:59:55AM +0100, Christoph Hellwig wrote:
> Move the calculation of the per-page variables and the readahead handling
> from the only caller into generic_file_buffered_read_pagenotuptodate,
> which now becomes a routine to handle everything related to bringing
> one page uptodate and thus is renamed to filemap_read_one_page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/filemap.c | 63 +++++++++++++++++++++++-----------------------------
>  1 file changed, 28 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index bae5b905aa7bdc..5cdf8090d4e12c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2217,13 +2217,26 @@ static int filemap_readpage(struct kiocb *iocb, struct page *page)
>  	return error;
>  }
>  
> -static int generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
> -		struct iov_iter *iter, struct page *page, loff_t pos,
> -		loff_t count, bool first)
> +static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
> +		struct page *page, pgoff_t pg_index, bool first)

I prefer "filemap_update_page".

I don't understand why you pass in pg_index instead of using page->index.
We dereferenced the page pointer already to check PageReadahead(), so
there's no performance issue here.

Also, if filemap_find_get_pages() stops on the first !Uptodate or
Readahead page, as I had it in my patchset, then we don't need the loop
at all -- filemap_read_pages() looks like:

        nr_pages = filemap_find_get_pages(iocb, iter, pages, nr);
	if (!nr_pages) {
		pages[0] = filemap_create_page(iocb, iter);
		if (!IS_ERR_OR_NULL(pages[0]))
			return 1;
		if (!pages[0])
			goto retry;
		return PTR_ERR(pages[0]);
	}

	page = pages[nr_pages - 1];
	if (PageUptodate(page) && !PageReadahead(page))
		return nr_pages;
	err = filemap_update_page(iocb, iter, page);
	if (!err)
		return nr_pages;
	nr_pages -= 1;
	if (nr_pages)
		return nr_pages;
	return err;

