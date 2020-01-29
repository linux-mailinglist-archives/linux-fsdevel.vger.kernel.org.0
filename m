Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB6A14C443
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 01:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgA2A5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 19:57:46 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55111 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbgA2A5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:57:46 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 57DB03A1476;
        Wed, 29 Jan 2020 11:57:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iwbfp-0005wG-QY; Wed, 29 Jan 2020 11:57:41 +1100
Date:   Wed, 29 Jan 2020 11:57:41 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 07/12] erofs: Convert uncompressed files from readpages
 to readahead
Message-ID: <20200129005741.GJ18610@dread.disaster.area>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125013553.24899-8-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=JfrnYn6hAAAA:8 a=voM4FWlXAAAA:8 a=7-415B0cAAAA:8 a=ARdszsHN92wWq2Ddru8A:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=IC2XNlieTeVoXbcui8wp:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 05:35:48PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in erofs.  Fix what I believe to be
> a refcounting bug in the error case.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: linux-erofs@lists.ozlabs.org
> ---
>  fs/erofs/data.c              | 34 ++++++++++++++--------------------
>  fs/erofs/zdata.c             |  2 +-
>  include/trace/events/erofs.h |  6 +++---
>  3 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index fc3a8d8064f8..335c1ab05312 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -280,42 +280,36 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
>  	return 0;
>  }
>  
> -static int erofs_raw_access_readpages(struct file *filp,
> +static unsigned erofs_raw_access_readahead(struct file *file,
>  				      struct address_space *mapping,
> -				      struct list_head *pages,
> +				      pgoff_t start,
>  				      unsigned int nr_pages)
>  {
>  	erofs_off_t last_block;
>  	struct bio *bio = NULL;
> -	gfp_t gfp = readahead_gfp_mask(mapping);
> -	struct page *page = list_last_entry(pages, struct page, lru);
>  
> -	trace_erofs_readpages(mapping->host, page, nr_pages, true);
> +	trace_erofs_readpages(mapping->host, start, nr_pages, true);
>  
>  	for (; nr_pages; --nr_pages) {
> -		page = list_entry(pages->prev, struct page, lru);
> +		struct page *page = readahead_page(mapping, start++);
>  
>  		prefetchw(&page->flags);
> -		list_del(&page->lru);
>  
> -		if (!add_to_page_cache_lru(page, mapping, page->index, gfp)) {
> -			bio = erofs_read_raw_page(bio, mapping, page,
> -						  &last_block, nr_pages, true);
> +		bio = erofs_read_raw_page(bio, mapping, page, &last_block,
> +				nr_pages, true);
>  
> -			/* all the page errors are ignored when readahead */
> -			if (IS_ERR(bio)) {
> -				pr_err("%s, readahead error at page %lu of nid %llu\n",
> -				       __func__, page->index,
> -				       EROFS_I(mapping->host)->nid);
> +		/* all the page errors are ignored when readahead */
> +		if (IS_ERR(bio)) {
> +			pr_err("%s, readahead error at page %lu of nid %llu\n",
> +			       __func__, page->index,
> +			       EROFS_I(mapping->host)->nid);
>  
> -				bio = NULL;
> -			}
> +			bio = NULL;
> +			put_page(page);
>  		}
>  
> -		/* pages could still be locked */
>  		put_page(page);

A double put_page() on error?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
