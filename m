Return-Path: <linux-fsdevel+bounces-31813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8985499B840
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 06:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF8B2825EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 04:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC020433B0;
	Sun, 13 Oct 2024 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E7juDQ4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C31DA32
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728795307; cv=none; b=MVM/Ec20b+hJTNJpftMD4nlAKLlNMz9dN+TDB5kotwRaX3J/ZTGlLbhq9kmtNnZ0X8t8AS3xL0b3KF5TLsPmcbKXbXh+aY0lUoX9LQxQweyI0m1jHTESG9ar07SDD/U3th4GDj9ddVTwL8OERoYHhgvToCiCGEtutqIToAzX8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728795307; c=relaxed/simple;
	bh=6yh11jRXSz+nef7SDsqR3k8VSsejweq2loqQzUVt5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+jTKuqjCl92b2rx0shmgDhm4fW2l0s3ge/FLBkM+ShQdx9+UmvVRjw4N1Ckn/hNF5dcL8/GmBnIQcmGuoLjjwVHXl5ipwHO5MqJTz1JWIQ2nnZS0Ye6+2lHmaC/RLVnuoFuDDg/xNxsHAdGsPXNxKIdgupnTSFBpEbLTIAGz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E7juDQ4m; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 12 Oct 2024 21:54:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728795302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/JeRHxxFFj0bX2toEeHeEhD+6g9XfctiL4Bv2VRl9E=;
	b=E7juDQ4mbGHRmv3c4jeCa09nsPryytQjosMifU/i7ZT722lufDY2s3/3RIt58YZM1PE58X
	0wZh0venqNzjwgOzXvLLe6sPRj6YT9Q9HS0Ydl+nO06DSZliSDeh5taTXC67WchyMv2zeR
	q6KS4qJ4qlv5pl8W8UgCADK4Vo4AJuo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH 1/2] mm: skip reclaiming folios in writeback contexts
 that may trigger deadlock
Message-ID: <prx7opxb3zqofuejohnqikxqbau6mde3lqxkistcwqun2xzr36@rpxky5oltnvs>
References: <20241011223434.1307300-1-joannelkoong@gmail.com>
 <20241011223434.1307300-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011223434.1307300-2-joannelkoong@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 11, 2024 at 03:34:33PM GMT, Joanne Koong wrote:
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
> This commit allows filesystems to set a ASOP_NO_RECLAIM_IN_WRITEBACK
> flag in the address_space_operations struct to signify that reclaim
> should not happen when the folio is already in writeback. This only has
> effects on the case where cgroupv1 memcg encounters a folio under
> writeback that already has the reclaim flag set (eg case 3 above), and
> allows for the suboptimal workarounds added to address the "reclaim wait
> on writeback" deadlock scenario to be removed.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/fs.h | 14 ++++++++++++++
>  mm/vmscan.c        |  6 ++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e3c603d01337..808164e3dd84 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -394,7 +394,10 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
>  	return kiocb->ki_complete == NULL;
>  }
>  
> +typedef unsigned int __bitwise asop_flags_t;
> +
>  struct address_space_operations {
> +	asop_flags_t asop_flags;
>  	int (*writepage)(struct page *page, struct writeback_control *wbc);
>  	int (*read_folio)(struct file *, struct folio *);
>  
> @@ -438,6 +441,12 @@ struct address_space_operations {
>  	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
>  };
>  
> +/**
> + * This flag is only to be used by filesystems whose folios cannot be
> + * reclaimed when in writeback (eg fuse)
> + */
> +#define ASOP_NO_RECLAIM_IN_WRITEBACK	((__force asop_flags_t)(1 << 0))
> +
>  extern const struct address_space_operations empty_aops;
>  
>  /**
> @@ -586,6 +595,11 @@ static inline void mapping_allow_writable(struct address_space *mapping)
>  	atomic_inc(&mapping->i_mmap_writable);
>  }
>  
> +static inline bool mapping_no_reclaim_in_writeback(struct address_space *mapping)
> +{
> +	return mapping->a_ops->asop_flags & ASOP_NO_RECLAIM_IN_WRITEBACK;

Any reason not to add this flag in enum mapping_flags and use
mapping->flags field instead of adding a field in struct
address_space_operations?

> +}
> +
>  /*
>   * Use sequence counter to get consistent i_size on 32-bit processors.
>   */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749cdc110c74..2beffbdae572 100644
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
> +			    (mapping && mapping_no_reclaim_in_writeback(mapping))) {
>  				/*
>  				 * This is slightly racy -
>  				 * folio_end_writeback() might have
> @@ -1320,7 +1323,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		if (folio_maybe_dma_pinned(folio))
>  			goto activate_locked;
>  
> -		mapping = folio_mapping(folio);
>  		if (folio_test_dirty(folio)) {
>  			/*
>  			 * Only kswapd can writeback filesystem folios
> -- 
> 2.43.5
> 

