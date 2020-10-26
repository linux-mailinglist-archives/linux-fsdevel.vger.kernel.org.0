Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E802298CCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 13:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772471AbgJZMRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 08:17:33 -0400
Received: from casper.infradead.org ([90.155.50.34]:38660 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgJZMRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TJ7A8YWRqbXP5svQLVghfVUxrZ30JvU6Kp7xKSa+O5c=; b=JMlUFYQZKGONkoMhM1DBe2cJsD
        MiXQGrSkT0HCmvIJagpbuBsXuI73bgoCzqh5b3YlCPgX+0TyFHs7u+G+51vL84P8Mtlkxb1cWPeWw
        POdnJdauLKy52Yr0ZoFQUaDKel/rkj9MAPuzRM/YHN0I6M0cKmoHRpvPwj+UeQD2jvRUMRK1IIxIe
        kZY/QbhPWWFUQGK3ezw8dZizTegpl+GXj6qnDreCG63DjgogYEJfVkZR6ZiJ4bQvso+R4qbKTw8ZJ
        n0tL9QzgAfD3Od5qytdnuY8JebWKjU/P9Uanp08daI+jAlUsvUaMhd4taLo8XH2t06rKkAzAT0daR
        Ggr/PhBw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX1RH-0002T5-Kg; Mon, 26 Oct 2020 12:17:27 +0000
Date:   Mon, 26 Oct 2020 12:17:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v3 04/12] mm/filemap: Add mapping_seek_hole_data
Message-ID: <20201026121727.GO20115@casper.infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
 <20201026041408.25230-5-willy@infradead.org>
 <20201026104806.GB29758@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026104806.GB29758@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 11:48:06AM +0100, Jan Kara wrote:
> > +static inline loff_t page_seek_hole_data(struct page *page,
> > +		loff_t start, loff_t end, bool seek_data)
> > +{
> > +	if (xa_is_value(page) || PageUptodate(page))
> 
> Please add a comment here that this is currently tmpfs specific treating
> exceptional entries as swapped out pages and thus data. It took me quite a
> while to figure this out. You can remove the comment later when it is no
> longer true...

But it's not tmpfs specific.  If the value entry is a DAX entry, there's
data here, and if the value entry is a shadow entry, there's data here
too.  Not that it should be called for either of those cases because the
filesystem should know, but a value entry always means there's data here.

I'm open to adding a comment, but saying "A value entry always means data"
seems a little redundant with the code.  What would have helped?

> > +		return seek_data ? start : end;
> > +	return seek_data ? end : start;
> > +}
> > +
> > +static inline
> > +unsigned int seek_page_size(struct xa_state *xas, struct page *page)
> > +{
> > +	if (xa_is_value(page))
> > +		return PAGE_SIZE << xa_get_order(xas->xa, xas->xa_index);
> > +	return thp_size(page);
> > +}
> > +
> > +/**
> > + * mapping_seek_hole_data - Seek for SEEK_DATA / SEEK_HOLE in the page cache.
> > + * @mapping: Address space to search.
> > + * @start: First byte to consider.
> > + * @end: Limit of search (exclusive).
> > + * @whence: Either SEEK_HOLE or SEEK_DATA.
> > + *
> > + * If the page cache knows which blocks contain holes and which blocks
> > + * contain data, your filesystem can use this function to implement
> > + * SEEK_HOLE and SEEK_DATA.  This is useful for filesystems which are
> > + * entirely memory-based such as tmpfs, and filesystems which support
> > + * unwritten extents.
> > + *
> > + * Return: The requested offset on successs, or -ENXIO if @whence specifies
> > + * SEEK_DATA and there is no data after @start.  There is an implicit hole
> > + * after @end - 1, so SEEK_HOLE returns @end if all the bytes between @start
> > + * and @end contain data.
> > + */
> > +loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
> > +		loff_t end, int whence)
> > +{
> > +	XA_STATE(xas, &mapping->i_pages, start >> PAGE_SHIFT);
> > +	pgoff_t max = (end - 1) / PAGE_SIZE;
> > +	bool seek_data = (whence == SEEK_DATA);
> > +	struct page *page;
> > +
> > +	if (end <= start)
> > +		return -ENXIO;
> > +
> > +	rcu_read_lock();
> > +	while ((page = xas_find_get_entry(&xas, max, XA_PRESENT))) {
> > +		loff_t pos = xas.xa_index * PAGE_SIZE;
> > +
> > +		if (start < pos) {
> > +			if (!seek_data)
> > +				goto unlock;
> > +			start = pos;
> > +		}
> > +
> > +		pos += seek_page_size(&xas, page);
> > +		start = page_seek_hole_data(page, start, pos, seek_data);
> > +		if (start < pos)
> > +			goto unlock;
> 
> Uh, I was staring at this function for half an hour but I still couldn't
> convince myself that it is correct in all the corner cases. Maybe I'm dumb
> but I'd wish this was more intuitive (and I have to say that the original
> tmpfs function is much more obviously correct to me). It would more 
> understandable for me if we had a code like:
> 
> 		if (page_seek_match(page, seek_data))
> 			goto unlock;
> 
> which would be just the condition in page_seek_hole_data(). Honestly at the
> moment I fail to see why you bother with 'pos' in the above four lines at
> all.

So this?

static bool page_seek_match(struct page *page, bool seek_data)
{
	/* Swap, shadow & DAX entries all represent data */
	if (xa_is_value(page) || PageUptodate(page))
		return seek_data;
	return !seek_data;
}

...

		if (page_seek_match(page, seek_data))
			goto unlock;
		start = pos + seek_page_size(&xas, page);

The function makes more sense when page_seek_hole_data() gains the
ability to look at sub-page uptodate status and it needs to return
where in the page the data (or hole) starts.  But that can be delayed
for the later patch.

With those changes,

Ran: generic/285 generic/286 generic/436 generic/445 generic/448 generic/490 generic/539
Passed all 7 tests

> BTW I suspect that this loop forgets to release the page reference it has got
> when doing SEEK_HOLE.

You're right.  I need a put_page() at the end of the loop.  Also true
for the case where we find a !Uptodate page when doing SEEK_DATA.

> > +	}
> > +	rcu_read_unlock();
> > +
> > +	if (seek_data)
> > +		return -ENXIO;
> > +	goto out;
> > +
> > +unlock:
> > +	rcu_read_unlock();
> > +	if (!xa_is_value(page))
> > +		put_page(page);
> > +out:
> > +	if (start > end)
> > +		return end;
> > +	return start;
> > +}
> 
> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
