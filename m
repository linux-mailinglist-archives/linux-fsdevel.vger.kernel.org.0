Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E8C2A49B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgKCPaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:30:15 -0500
Received: from verein.lst.de ([213.95.11.211]:37928 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbgKCP3t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 73C136736F; Tue,  3 Nov 2020 16:29:47 +0100 (CET)
Date:   Tue, 3 Nov 2020 16:29:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, kent.overstreet@gmail.com
Subject: Re: [PATCH 14/17] mm/filemap: Restructure filemap_get_pages
Message-ID: <20201103152947.GB10928@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-15-willy@infradead.org> <20201103075736.GM8389@lst.de> <20201103144619.GW27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103144619.GW27442@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 02:46:19PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 03, 2020 at 08:57:36AM +0100, Christoph Hellwig wrote:
> > On Mon, Nov 02, 2020 at 06:43:09PM +0000, Matthew Wilcox (Oracle) wrote:
> > > Avoid a goto, and by the time we get to calling filemap_update_page(),
> > > we definitely have at least one page.
> > 
> > I find the error handling flow hard to follow and the existing but
> > heavily touched naming of the nr_got variable and the find_pages label
> > not helpful.  I'd do the following on top of this patch:
> 
> I've removed nr_got entirely in my current tree ...

Even better.  The pagevec usage looks pretty nice!

> +static void mapping_get_read_thps(struct address_space *mapping,

Maybe call this pagevec_get_read_thps?

> +	pgoff_t maxindex = DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
>  	struct page *page;
> +	int err = 0;
>  
>  find_page:
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
>  
> +	pagevec_init(pvec);
> +	mapping_get_read_thps(mapping, index, maxindex, pvec);
> +	if (!pagevec_count(pvec)) {
>  		if (iocb->ki_flags & IOCB_NOIO)
>  			return -EAGAIN;
>  		page_cache_sync_readahead(mapping, ra, filp, index,
> +				maxindex - index);
> +		mapping_get_read_thps(mapping, index, maxindex, pvec);
>  	}
> +	if (!pagevec_count(pvec)) {
>  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
>  			return -EAGAIN;
> +		page = filemap_create_page(filp, mapping,
>  				iocb->ki_pos >> PAGE_SHIFT);
> +		if (!page)
>  			goto find_page;
> +		if (IS_ERR(page))
> +			return PTR_ERR(page);
> +		pagevec_add(pvec, page);
> +		return 0;

I'd pass the pagevec to filemap_create_page and just return an errno,
which should be a little easier to follow.

> -	page = pages[nr_got - 1];
> +	page = pvec->pages[pagevec_count(pvec) - 1];

I wonder if a pagevec_last_page() helper would be neat for things
like this? (might be a bit of over engineering..)
