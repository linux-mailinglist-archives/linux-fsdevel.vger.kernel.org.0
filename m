Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6014C29D6C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbgJ1WRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731654AbgJ1WRk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:40 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AEB92417E;
        Wed, 28 Oct 2020 07:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603871464;
        bh=5CnDlGXayyFOYH2dTVvk7eaghhMV+C1UUuCxwi3GGmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmj1uJtQNt65yUTovMQ4dJtCggiEI7V3Zy82V7yP1FafK6pDVaJ0fiEufCDAlOHTE
         +3b0rRDzZ8PRRUQDHCGs4VrfSqcCuYGSQxlBScO6OFwHl/PsYnMDdv4JeLDFb30A3E
         hku2SGt0DoF6SoB48S1+utefLVjVMbDI4KQ03fn4=
Date:   Wed, 28 Oct 2020 09:50:56 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v3 01/12] mm: Make pagecache tagged lookups return only
 head pages
Message-ID: <20201028075056.GB1362354@kernel.org>
References: <20201026041408.25230-1-willy@infradead.org>
 <20201026041408.25230-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026041408.25230-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 04:13:57AM +0000, Matthew Wilcox (Oracle) wrote:
> Pagecache tags are used for dirty page writeback.  Since dirtiness is
> tracked on a per-THP basis, we only want to return the head page rather
> than each subpage of a tagged page.  All the filesystems which use huge
> pages today are in-memory, so there are no tagged huge pages today.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  mm/filemap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d5e7c2029d16..edde5dc0d28f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2066,7 +2066,7 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
>  EXPORT_SYMBOL(find_get_pages_contig);
>  
>  /**
> - * find_get_pages_range_tag - find and return pages in given range matching @tag
> + * find_get_pages_range_tag - Find and return head pages matching @tag.
>   * @mapping:	the address_space to search
>   * @index:	the starting page index
>   * @end:	The final page index (inclusive)
> @@ -2074,8 +2074,8 @@ EXPORT_SYMBOL(find_get_pages_contig);
>   * @nr_pages:	the maximum number of pages
>   * @pages:	where the resulting pages are placed
>   *
> - * Like find_get_pages, except we only return pages which are tagged with
> - * @tag.   We update @index to index the next page for the traversal.
> + * Like find_get_pages(), except we only return head pages which are tagged
> + * with @tag.   We update @index to index the next page for the traversal.

Nit:                                           ^ next head page

>   *
>   * Return: the number of pages which were found.
>   */
> @@ -2109,9 +2109,9 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
>  		if (unlikely(page != xas_reload(&xas)))
>  			goto put_page;
>  
> -		pages[ret] = find_subpage(page, xas.xa_index);
> +		pages[ret] = page;
>  		if (++ret == nr_pages) {
> -			*index = xas.xa_index + 1;
> +			*index = page->index + thp_nr_pages(page);
>  			goto out;
>  		}
>  		continue;
> -- 
> 2.28.0
> 
> 

-- 
Sincerely yours,
Mike.
