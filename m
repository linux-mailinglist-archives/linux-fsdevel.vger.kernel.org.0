Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605D618D51E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 17:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgCTQ6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 12:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgCTQ6b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:58:31 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6434C20753;
        Fri, 20 Mar 2020 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584723510;
        bh=AxLDPN4LwuxzW4xjwlSgsVf6rtc0JFVKxbo5//wmPgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRbat8REA7EmmJnmLCrWxRoNW5LgyCKm+4EsNDf5E4lY0nLcYrSE6Jyr+LkCnKmyi
         n3W2x46nv8ZHmzqeZMc86Mj56kXxAhIEwG1PHXCTucYL5iivPYgJLLRVtDE0DPEV3X
         iA5d4+HsRZ/BNe0ydHe/SfLeiRxRKGyEVqIcRkok=
Date:   Fri, 20 Mar 2020 09:58:28 -0700
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
Subject: Re: [PATCH v9 12/25] mm: Move end_index check out of readahead loop
Message-ID: <20200320165828.GB851@sol.localdomain>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320142231.2402-13-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:22:18AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By reducing nr_to_read, we can eliminate this check from inside the loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  mm/readahead.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index d01531ef9f3c..a37b68f66233 100644
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
> @@ -178,22 +176,29 @@ void __do_page_cache_readahead(struct address_space *mapping,
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
> +	/* Avoid wrapping to the beginning of the file */
> +	if (index + nr_to_read < index)
> +		nr_to_read = ULONG_MAX - index + 1;
> +	/* Don't read past the page containing the last byte of the file */
> +	if (index + nr_to_read >= end_index)
> +		nr_to_read = end_index - index + 1;

There seem to be a couple off-by-one errors here.  Shouldn't it be:

	/* Avoid wrapping to the beginning of the file */
	if (index + nr_to_read < index)
		nr_to_read = ULONG_MAX - index;
	/* Don't read past the page containing the last byte of the file */
	if (index + nr_to_read > end_index)
		nr_to_read = end_index - index + 1;

I.e., 'ULONG_MAX - index' rather than 'ULONG_MAX - index + 1', so that
'index + nr_to_read' is then ULONG_MAX rather than overflowed to 0.

Then 'index + nr_to_read > end_index' rather 'index + nr_to_read >= end_index',
since otherwise nr_to_read can be increased by 1 rather than decreased or stay
the same as expected.

- Eric
