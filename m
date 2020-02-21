Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403AD166E16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 04:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgBUDum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 22:50:42 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16239 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgBUDul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 22:50:41 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4f53820000>; Thu, 20 Feb 2020 19:50:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 19:50:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 19:50:40 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 03:50:40 +0000
Subject: Re: [PATCH v7 11/24] mm: Move end_index check out of readahead loop
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-12-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <e6ef2075-b849-299e-0f11-c6ee82b0a3c7@nvidia.com>
Date:   Thu, 20 Feb 2020 19:50:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219210103.32400-12-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582257026; bh=tk14qMbQgXhzPHJvBXnjmNLCT+UAZJLvtKqXUx6iDgc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oCi6E75tCEIn+Ss5EINKDG6zfT/kx05YcufkjkALI/HJzrO/QVaq0+TS7NDuf6dDG
         3KJUx4kwLE0srSqcQb7ewkvP+MwPzM4WzzCl9NCAzj0iF7hBEKUI95wSnO5C+VYO8N
         PBHbwat8gbjdVT/oYADJD3U9KNdo/nsrMbDFNPGW66rGomZN4nRYnGdVhk/MG8IqMF
         qrYsOtbFP9PSayIDVKbUcW4lGHlBbQ/hIiN9gWwSGKey8zhdYc7nXNitnRnVppR8hu
         ugDl43YDuHfHI/5RPeAj7AoT/5aAHccP0NTXqSNiQSxuAloaSAzsHHurCa1NnOWQDL
         yLHsrmucQ0bFA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/19/20 1:00 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By reducing nr_to_read, we can eliminate this check from inside the loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 07cdfbf00f4b..ace611f4bf05 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -166,8 +166,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		unsigned long lookahead_size)
>  {
>  	struct inode *inode = mapping->host;
> -	struct page *page;
> -	unsigned long end_index;	/* The last page we want to read */
>  	LIST_HEAD(page_pool);
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> @@ -179,22 +177,27 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		._nr_pages = 0,
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
> +	if (index + nr_to_read < index)
> +		nr_to_read = ULONG_MAX - index + 1;
> +	if (index + nr_to_read >= end_index)
> +		nr_to_read = end_index - index + 1;


This tiny patch made me pause, because I wasn't sure at first of the exact
intent of the lines above. Once I worked it out, it seemed like it might
be helpful (or overkill??) to add a few hints for the reader, especially since
there are no hints in the function's (minimal) documentation header. What
do you think of this?

	/*
	 * If we can't read *any* pages without going past the inodes's isize
	 * limit, give up entirely:
	 */
	if (index > end_index)
		return;

	/* Cap nr_to_read, in order to avoid overflowing the ULONG type: */
	if (index + nr_to_read < index)
		nr_to_read = ULONG_MAX - index + 1;

	/* Cap nr_to_read, to avoid reading past the inode's isize limit: */
	if (index + nr_to_read >= end_index)
		nr_to_read = end_index - index + 1;


Either way, it looks corrected written to me, so:

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

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
> 
