Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA318FFCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCWUt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgCWUt5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:49:57 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2370A20719;
        Mon, 23 Mar 2020 20:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584996596;
        bh=uca8lceeryIzQMAk4G4iarM7sj/2pw+KF5opo+TrNGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coWkHNesJ3VgUDx8upr085r4HZYltqISo1yUGjJ/WXKfvNR+04jgsegcd1wxMZodR
         fQGiy5Lk9Drq+w7ah2QA9gYBnXswZgZRIqxSJS3M98zDeMk86vooA8s3ntT5pmzqG+
         0iFnw5waVySEm2t9URBP8tlPK7izf9Vhqov96a5c=
Date:   Mon, 23 Mar 2020 13:49:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v10 12/25] mm: Move end_index check out of readahead loop
Message-ID: <20200323204954.GB61708@gmail.com>
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323202259.13363-13-willy@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 01:22:46PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By reducing nr_to_read, we can eliminate this check from inside the loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  mm/readahead.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index d01531ef9f3c..998fdd23c0b1 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -167,8 +167,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		unsigned long lookahead_size)
>  {
>  	struct inode *inode = mapping->host;
> -	struct page *page;
> -	unsigned long end_index;	/* The last page we want to read */
>  	LIST_HEAD(page_pool);
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> @@ -178,22 +176,26 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		._index = index,
>  	};
>  	unsigned long i;
> +	pgoff_t end_index;	/* The last page we want to read */
>  
>  	if (isize == 0)
>  		return;
>  
> -	end_index = ((isize - 1) >> PAGE_SHIFT);
> +	end_index = (isize - 1) >> PAGE_SHIFT;
> +	if (index > end_index)
> +		return;
> +	/* Don't read past the page containing the last byte of the file */
> +	if (nr_to_read > end_index - index)
> +		nr_to_read = end_index - index + 1;
>  
>  	/*
>  	 * Preallocate as many pages as we will need.
>  	 */
>  	for (i = 0; i < nr_to_read; i++) {
> -		if (index + i > end_index)
> -			break;
> +		struct page *page = xa_load(&mapping->i_pages, index + i);
>  
>  		BUG_ON(index + i != rac._index + rac._nr_pages);
>  
> -		page = xa_load(&mapping->i_pages, index + i);
>  		if (page && !xa_is_value(page)) {
>  			/*
>  			 * Page already present?  Kick off the current batch of
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
