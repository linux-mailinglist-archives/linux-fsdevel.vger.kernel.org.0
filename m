Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9CA14C455
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 02:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgA2BIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 20:08:34 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43818 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgA2BIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 20:08:34 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EE9ED3A2496;
        Wed, 29 Jan 2020 12:08:30 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iwbqH-0005zH-9B; Wed, 29 Jan 2020 12:08:29 +1100
Date:   Wed, 29 Jan 2020 12:08:29 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] fuse: Convert from readpages to readahead
Message-ID: <20200129010829.GK18610@dread.disaster.area>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125013553.24899-12-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=XQoKVZl3_x8TtcCbSDwA:9
        a=dkzf7bQtNeN5L-sv:21 a=BzqqMxnNl6DEKTpg:21 a=CjuIK1q_8ugA:10
        a=WSd5SQCJy8UA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 05:35:52PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in fuse.  Switching away from the
> read_cache_pages() helper gets rid of an implicit call to put_page(),
> so we can get rid of the get_page() call in fuse_readpages_fill().
> We can also get rid of the call to fuse_wait_on_page_writeback() as
> this page is newly allocated and so cannot be under writeback.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
.....
> @@ -968,19 +962,24 @@ static int fuse_readpages(struct file *file, struct address_space *mapping,
>  	data.max_pages = min_t(unsigned int, nr_pages, fc->max_pages);
>  ;
>  	data.ia = fuse_io_alloc(NULL, data.max_pages);
> -	err = -ENOMEM;
>  	if (!data.ia)
>  		goto out;
>  
> -	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
> -	if (!err) {
> -		if (data.ia->ap.num_pages)
> -			fuse_send_readpages(data.ia, file);
> -		else
> -			fuse_io_free(data.ia);
> +	while (nr_pages--) {
> +		struct page *page = readahead_page(mapping, start++);
> +		int err = fuse_readpages_fill(&data, page);
> +
> +		if (!err)
> +			continue;
> +		nr_pages++;
> +		goto out;
>  	}

That's some pretty convoluted logic. Perhaps:

	for (; nr_pages > 0 ; nr_pages--) {
		struct page *page = readahead_page(mapping, start++);

		if (fuse_readpages_fill(&data, page))
			goto out;
	}

-Dave.
-- 
Dave Chinner
david@fromorbit.com
