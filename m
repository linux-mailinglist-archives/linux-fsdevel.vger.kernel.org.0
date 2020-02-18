Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA181633CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgBRVFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:05:31 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4342 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgBRVFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:05:31 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4c517a0000>; Tue, 18 Feb 2020 13:04:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 13:05:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Feb 2020 13:05:30 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 21:05:29 +0000
Subject: Re: [PATCH v6 01/19] mm: Return void from various readahead functions
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-2-willy@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <29d2d7ca-7f2b-7eb4-78bc-f2af36c4c426@nvidia.com>
Date:   Tue, 18 Feb 2020 13:05:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-2-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582059898; bh=3Tzi4YVjiGJU778/orjIDa7TSGwRy5taBn2/82oa+aQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hqloiqBqSuZGaYGkXI4y6uimyehARyGnYG70bfDk3yOB18R9uLM8BT6oDtBGecU3N
         Lqh9rx/iPO8/U18g2E2WaBCVhqRRwzPmIxsQ4YC2mK2lo21KXP1fIEhVpBLHsqVF2u
         +spNTSr0xUh2VFGuB3TbrYt/WmzmxtalFBYvXAWqVE5C7DowzCVSWA4uRMCnWv175V
         kKKp/N0Kuc4S7BOtfyFTo9/gvcyiICIqWPfvulCk6nDeR68LOPk75LEKPAc8BezVTf
         8/m4QzBRgIOBFNjb8rgcd5NrIT05x92/7JvGII/CGcNWKq5/Y9GhpYvAylBzuSi2WH
         gxTDwXiR8jocQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> ondemand_readahead has two callers, neither of which use the return value.
> That means that both ra_submit and __do_page_cache_readahead() can return
> void, and we don't need to worry that a present page in the readahead
> window causes us to return a smaller nr_pages than we ought to have.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/internal.h  |  8 ++++----
>  mm/readahead.c | 24 ++++++++++--------------
>  2 files changed, 14 insertions(+), 18 deletions(-)


This is an easy review and obviously correct, so:

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


Thoughts for the future of the API:

I will add that I could envision another patchset that went in the
opposite direction, and attempted to preserve the information about
how many pages were successfully read ahead. And that would be nice
to have (at least IMHO), even all the way out to the syscall level,
especially for the readahead syscall.

Of course, vague opinions about how the API might be improved are less
pressing than cleaning up the code now--I'm just bringing this up because
I suspect some people will wonder, "wouldn't it be helpful if I the 
syscall would tell me what happened here? Success (returning 0) doesn't
necessarily mean any pages were even read ahead." It just seems worth 
mentioning.


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 3cf20ab3ca01..f779f058118b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -49,18 +49,18 @@ void unmap_page_range(struct mmu_gather *tlb,
>  			     unsigned long addr, unsigned long end,
>  			     struct zap_details *details);
>  
> -extern unsigned int __do_page_cache_readahead(struct address_space *mapping,
> +extern void __do_page_cache_readahead(struct address_space *mapping,
>  		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
>  		unsigned long lookahead_size);
>  
>  /*
>   * Submit IO for the read-ahead request in file_ra_state.
>   */
> -static inline unsigned long ra_submit(struct file_ra_state *ra,
> +static inline void ra_submit(struct file_ra_state *ra,
>  		struct address_space *mapping, struct file *filp)
>  {
> -	return __do_page_cache_readahead(mapping, filp,
> -					ra->start, ra->size, ra->async_size);
> +	__do_page_cache_readahead(mapping, filp,
> +			ra->start, ra->size, ra->async_size);
>  }
>  
>  /*
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 2fe72cd29b47..8ce46d69e6ae 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -149,10 +149,8 @@ static int read_pages(struct address_space *mapping, struct file *filp,
>   * the pages first, then submits them for I/O. This avoids the very bad
>   * behaviour which would occur if page allocations are causing VM writeback.
>   * We really don't want to intermingle reads and writes like that.
> - *
> - * Returns the number of pages requested, or the maximum amount of I/O allowed.
>   */
> -unsigned int __do_page_cache_readahead(struct address_space *mapping,
> +void __do_page_cache_readahead(struct address_space *mapping,
>  		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
>  		unsigned long lookahead_size)
>  {
> @@ -166,7 +164,7 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
>  
>  	if (isize == 0)
> -		goto out;
> +		return;
>  
>  	end_index = ((isize - 1) >> PAGE_SHIFT);
>  
> @@ -211,8 +209,6 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
>  	if (nr_pages)
>  		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
>  	BUG_ON(!list_empty(&page_pool));
> -out:
> -	return nr_pages;
>  }
>  
>  /*
> @@ -378,11 +374,10 @@ static int try_context_readahead(struct address_space *mapping,
>  /*
>   * A minimal readahead algorithm for trivial sequential/random reads.
>   */
> -static unsigned long
> -ondemand_readahead(struct address_space *mapping,
> -		   struct file_ra_state *ra, struct file *filp,
> -		   bool hit_readahead_marker, pgoff_t offset,
> -		   unsigned long req_size)
> +static void ondemand_readahead(struct address_space *mapping,
> +		struct file_ra_state *ra, struct file *filp,
> +		bool hit_readahead_marker, pgoff_t offset,
> +		unsigned long req_size)
>  {
>  	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
>  	unsigned long max_pages = ra->ra_pages;
> @@ -428,7 +423,7 @@ ondemand_readahead(struct address_space *mapping,
>  		rcu_read_unlock();
>  
>  		if (!start || start - offset > max_pages)
> -			return 0;
> +			return;
>  
>  		ra->start = start;
>  		ra->size = start - offset;	/* old async_size */
> @@ -464,7 +459,8 @@ ondemand_readahead(struct address_space *mapping,
>  	 * standalone, small random read
>  	 * Read as is, and do not pollute the readahead state.
>  	 */
> -	return __do_page_cache_readahead(mapping, filp, offset, req_size, 0);
> +	__do_page_cache_readahead(mapping, filp, offset, req_size, 0);
> +	return;
>  
>  initial_readahead:
>  	ra->start = offset;
> @@ -489,7 +485,7 @@ ondemand_readahead(struct address_space *mapping,
>  		}
>  	}
>  
> -	return ra_submit(ra, mapping, filp);
> +	ra_submit(ra, mapping, filp);
>  }
>  
>  /**
> 
