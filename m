Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33BBC14C470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 02:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA2Bio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 20:38:44 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33395 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbgA2Bio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 20:38:44 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 423E27EA451;
        Wed, 29 Jan 2020 12:38:40 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iwcJT-0006Af-LC; Wed, 29 Jan 2020 12:38:39 +1100
Date:   Wed, 29 Jan 2020 12:38:39 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/12] iomap: Convert from readpages to readahead
Message-ID: <20200129013839.GL18610@dread.disaster.area>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125013553.24899-13-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=rbi3LzHp19PN_Qk40xAA:9
        a=PRpOWFZumF8D-HGV:21 a=3BwcHNtil7AkR3Nb:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 05:35:53PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in XFS and iomap.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: linux-xfs@vger.kernel.org

....
> +unsigned
> +iomap_readahead(struct address_space *mapping, pgoff_t start,
>  		unsigned nr_pages, const struct iomap_ops *ops)
>  {
>  	struct iomap_readpage_ctx ctx = {
> -		.pages		= pages,
>  		.is_readahead	= true,
>  	};
> -	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
> -	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
> -	loff_t length = last - pos + PAGE_SIZE, ret = 0;
> +	loff_t pos = start * PAGE_SIZE;
> +	loff_t length = nr_pages * PAGE_SIZE;
>  
> -	trace_iomap_readpages(mapping->host, nr_pages);
> +	trace_iomap_readahead(mapping->host, nr_pages);
>  
>  	while (length > 0) {
> -		ret = iomap_apply(mapping->host, pos, length, 0, ops,
> -				&ctx, iomap_readpages_actor);
> +		loff_t ret = iomap_apply(mapping->host, pos, length, 0, ops,
> +				&ctx, iomap_readahead_actor);
>  		if (ret <= 0) {
>  			WARN_ON_ONCE(ret == 0);
> -			goto done;
> +			break;
>  		}
>  		pos += ret;
>  		length -= ret;
>  	}
> -	ret = 0;
> -done:
> +
>  	if (ctx.bio)
>  		submit_bio(ctx.bio);
> -	if (ctx.cur_page) {
> -		if (!ctx.cur_page_in_bio)
> -			unlock_page(ctx.cur_page);
> +	if (ctx.cur_page && ctx.cur_page_in_bio)
>  		put_page(ctx.cur_page);
> -	}
>  
> -	/*
> -	 * Check that we didn't lose a page due to the arcance calling
> -	 * conventions..
> -	 */
> -	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
> -	return ret;
> +	return length / PAGE_SIZE;

Took me quite some time to get my head around whether this was
correct or not.

I'm still not certain in the cases where block size != page size and
we've got an extent boundary in the middle of the page and had a
read error on the second extent in the page. In this case,
ctx.cur_page_in_bio is true so we drop the readahead reference to
the page. Also, length is not a multiple of page size, and so the
nr_pages value returned includes the partial page that we have IO
underway on.

That, I think, leads to both a double unlock and a double put_page()
of the partial page in question.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
