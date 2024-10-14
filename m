Return-Path: <linux-fsdevel+bounces-31915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566899D6A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 20:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8567284FA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3F21C877E;
	Mon, 14 Oct 2024 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="abRtzuYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA011AB6FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931137; cv=none; b=scobcFnIJAXtSOSCd1WpEOoPAkhVbwCG75erxEEg1jO892YTqPS1Nin6vGn3roC6l+ZhqdYMyn/4vEj6ggPUq4B9Cy+mVIBk3J7yMEU55TXwlL9HXgmuRDTQ1QhoJpMBfyfyLeNAlq05voeLVjMMrkQbsNIM+fo9gi7baxlV8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931137; c=relaxed/simple;
	bh=dkmSpM35trMSJEcdTX++/bAQIHWRFYVefdglpgpQg9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inebJVke3oHHlTmChal+hxuRDZHSZfyUNVv7WL22c2ShpzRjcmhp3HCty2NYr9ot8N05Xpbon2PWi2Ds+7AOqDCZnboNmRqZVF8P9wf5HkBBtWbDNAouLv2F3U/h7DcwaxVp97uIQTUZQZwI1/n7gKvguOYfi4mC6p1C+7yd2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=abRtzuYf; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Oct 2024 11:38:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728931132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IqlvY1cmnsPONjSxitMWFO4oU3mXdPExHv7VOQKaoE8=;
	b=abRtzuYfqExHRbn1ZNvhyM3nl48wV2cfPCC/2XVniLXYM0PmDPqOwlWdvRy/WgImTFwscS
	QXy3m49XgkR3ItWwncrHp5RYxT0jtZmE7yjog8Uh9EFJTDr4Wqg8yUdd4BJcDU6aYdrV2I
	TWSXk49uBT4XLiKmMlwCeuEP/9Q8puI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] mm: skip reclaiming folios in writeback contexts
 that may trigger deadlock
Message-ID: <265keu5uzo3gzqrvhcn2cagii4sak3e2a372ra7jlav35fnkrx@aicyzyftun3l>
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014182228.1941246-2-joannelkoong@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 11:22:27AM GMT, Joanne Koong wrote:
> Currently in shrink_folio_list(), reclaim for folios under writeback
> falls into 3 different cases:
> 1) Reclaim is encountering an excessive number of folios under
>    writeback and this folio has both the writeback and reclaim flags
>    set
> 2) Dirty throttling is enabled (this happens if reclaim through cgroup
>    is not enabled, if reclaim through cgroupv2 memcg is enabled, or
>    if reclaim is on the root cgroup), or if the folio is not marked for
>    immediate reclaim, or if the caller does not have __GFP_FS (or
>    __GFP_IO if it's going to swap) set
> 3) Legacy cgroupv1 encounters a folio that already has the reclaim flag
>    set and the caller did not have __GFP_FS (or __GFP_IO if swap) set
> 
> In cases 1) and 2), we activate the folio and skip reclaiming it while
> in case 3), we wait for writeback to finish on the folio and then try
> to reclaim the folio again. In case 3, we wait on writeback because
> cgroupv1 does not have dirty folio throttling, as such this is a
> mitigation against the case where there are too many folios in writeback
> with nothing else to reclaim.
> 
> The issue is that for filesystems where writeback may block, sub-optimal
> workarounds need to be put in place to avoid potential deadlocks that may
> arise from the case where reclaim waits on writeback. (Even though case
> 3 above is rare given that legacy cgroupv1 is on its way to being
> deprecated, this case still needs to be accounted for)
> 
> For example, for FUSE filesystems, when a writeback is triggered on a
> folio, a temporary folio is allocated and the pages are copied over to
> this temporary folio so that writeback can be immediately cleared on the
> original folio. This additionally requires an internal rb tree to keep
> track of writeback state on the temporary folios. Benchmarks show
> roughly a ~20% decrease in throughput from the overhead incurred with 4k
> block size writes. The temporary folio is needed here in order to avoid
> the following deadlock if reclaim waits on writeback:
> * single-threaded FUSE server is in the middle of handling a request that
>   needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback (eg falls into case 3
>   above) that needs to be written back to the fuse server
> * the FUSE server can't write back the folio since it's stuck in direct
>   reclaim
> 
> This commit adds a new flag, AS_NO_WRITEBACK_RECLAIM, to "enum
> mapping_flags" which filesystems can set to signify that reclaim
> should not happen when the folio is already in writeback. This only has
> effects on the case where cgroupv1 memcg encounters a folio under
> writeback that already has the reclaim flag set (eg case 3 above), and
> allows for the suboptimal workarounds added to address the "reclaim wait
> on writeback" deadlock scenario to be removed.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/pagemap.h | 11 +++++++++++
>  mm/vmscan.c             |  6 ++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 68a5f1ff3301..513a72b8451b 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>  	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
>  				   folio contents */
>  	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
> +	AS_NO_WRITEBACK_RECLAIM = 9, /* Do not reclaim folios under writeback */

Isn't it "Do not wait for writeback completion for folios of this
mapping during reclaim"?

>  	/* Bits 16-25 are used for FOLIO_ORDER */
>  	AS_FOLIO_ORDER_BITS = 5,
>  	AS_FOLIO_ORDER_MIN = 16,
> @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct address_space *mapping)
>  	return test_bit(AS_INACCESSIBLE, &mapping->flags);
>  }
>  
> +static inline void mapping_set_no_writeback_reclaim(struct address_space *mapping)
> +{
> +	set_bit(AS_NO_WRITEBACK_RECLAIM, &mapping->flags);
> +}
> +
> +static inline int mapping_no_writeback_reclaim(struct address_space *mapping)
> +{
> +	return test_bit(AS_NO_WRITEBACK_RECLAIM, &mapping->flags);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>  {
>  	return mapping->gfp_mask;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749cdc110c74..885d496ae652 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1110,6 +1110,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		if (writeback && folio_test_reclaim(folio))
>  			stat->nr_congested += nr_pages;
>  
> +		mapping = folio_mapping(folio);
> +
>  		/*
>  		 * If a folio at the tail of the LRU is under writeback, there
>  		 * are three cases to consider.
> @@ -1165,7 +1167,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  			/* Case 2 above */
>  			} else if (writeback_throttling_sane(sc) ||
>  			    !folio_test_reclaim(folio) ||
> -			    !may_enter_fs(folio, sc->gfp_mask)) {
> +			    !may_enter_fs(folio, sc->gfp_mask) ||
> +			    (mapping && mapping_no_writeback_reclaim(mapping))) {
>  				/*
>  				 * This is slightly racy -
>  				 * folio_end_writeback() might have
> @@ -1320,7 +1323,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		if (folio_maybe_dma_pinned(folio))
>  			goto activate_locked;
>  
> -		mapping = folio_mapping(folio);

We should not remove the above line as it will make anon pages added to
the swap in this code path skip reclaim. Basically the mapping of anon
pages which are not yet in swap cache, will be null at the newly added
mapping = folio_mapping(folio) but will be swapcache mapping at this
location (there is add_to_swap() in between), so if we remove this line,
the kernel will skip the reclaim of that folio in this iteration. This
will increase memory pressure.

>  		if (folio_test_dirty(folio)) {
>  			/*
>  			 * Only kswapd can writeback filesystem folios
> -- 
> 2.43.5
> 

