Return-Path: <linux-fsdevel+bounces-34123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3539C28BC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92607B22209
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96434A18;
	Sat,  9 Nov 2024 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uYov01vI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C910E0
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111395; cv=none; b=qrzf5JzDyPrK5YfjWqSOT7NUvj/QpDeZBh7eRukVbfQO5l0EQlcuTee67QoFb1c4i7YNJRYDWDQ4csx8v9GmrqbLQI+KZXoft23goQpxEcLAT7pps3XDoMAl5P4kk9fVWv8uBoBcqHBMztbKMVejWLOinAHADE8HarOpCsbRG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111395; c=relaxed/simple;
	bh=NHaA1F7/WDEnoijJHEuyS21SRYtjbOGcJArc2PsE9A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzVEnY/7lLzcEf9lPiZn2PnPFiP/aaR2RqwN3dAyN23RTTcawYSuwsRa35dnZkPqGDrunjOxGyLPXcBbEUhCuTwUwkoa4TNs2YyoljQNZCdASFWDwstfMMKbopVWutAtQfF0ZKelGmeBgLsYCXWB/9pV33PQ71FTlkCNdijRz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uYov01vI; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 Nov 2024 16:16:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731111390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A839SDJM87IOrSNeKyC99w1i2Ui1CJ5PhN/T3xM/Kqk=;
	b=uYov01vIAWR+sG5rjBY+oTmqvVpROBs1ulB7AQn82jepVM13jQYl8q+XrK3rMb56cMdSpL
	fRkGlK7c6f3SPzxxmkl6gidSNov6IfVJERjD/wz4zj6cD6qsJggWbLEoVxP9MrWu+95V7i
	d9b8xPxYIupYdcNyqxfC6uICyRwb0s0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v4 2/6] mm: skip reclaiming folios in legacy memcg
 writeback contexts that may block
Message-ID: <tlwkh4pxerhijg5uz2556d4jwswctfyftpxvfjgb3tw64mewek@fy4cto4t5nmj>
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107235614.3637221-3-joannelkoong@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 07, 2024 at 03:56:10PM -0800, Joanne Koong wrote:
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
> workarounds may need to be put in place to avoid a potential deadlock
> that may arise from reclaim waiting on writeback. (Even though case 3
> above is rare given that legacy cgroupv1 is on its way to being
> deprecated, this case still needs to be accounted for). For example, for
> FUSE filesystems, a temp page gets allocated per dirty page and the
> contents of the dirty page are copied over to the temp page so that
> writeback can be immediately cleared on the dirty page in order to avoid
> the following deadlock:
> * single-threaded FUSE server is in the middle of handling a request that
>   needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback (eg falls into case 3
>   above) that needs to be written back to the FUSE server
> * the FUSE server can't write back the folio since it's stuck in direct
>   reclaim
> 
> In this commit, if legacy memcg encounters a folio with the reclaim flag
> set (eg case 3) and the folio belongs to a mapping that has the
> AS_WRITEBACK_MAY_BLOCK flag set, the folio will be activated and skip
> reclaim (eg default to behavior in case 2) instead.
> 
> This allows for the suboptimal workarounds added to address the
> "reclaim wait on writeback" deadlock scenario to be removed.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

This looks good just one nit below.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

> ---
>  mm/vmscan.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749cdc110c74..e9755cb7211b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1110,6 +1110,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		if (writeback && folio_test_reclaim(folio))
>  			stat->nr_congested += nr_pages;
>  
> +		mapping = folio_mapping(folio);

Move the above line within folio_test_writeback() check block.

> +
>  		/*
>  		 * If a folio at the tail of the LRU is under writeback, there
>  		 * are three cases to consider.
> @@ -1129,8 +1131,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		 * 2) Global or new memcg reclaim encounters a folio that is
>  		 *    not marked for immediate reclaim, or the caller does not
>  		 *    have __GFP_FS (or __GFP_IO if it's simply going to swap,
> -		 *    not to fs). In this case mark the folio for immediate
> -		 *    reclaim and continue scanning.
> +		 *    not to fs), or writebacks in the mapping may block.
> +		 *    In this case mark the folio for immediate reclaim and
> +		 *    continue scanning.
>  		 *
>  		 *    Require may_enter_fs() because we would wait on fs, which
>  		 *    may not have submitted I/O yet. And the loop driver might
> @@ -1165,7 +1168,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  			/* Case 2 above */
>  			} else if (writeback_throttling_sane(sc) ||
>  			    !folio_test_reclaim(folio) ||
> -			    !may_enter_fs(folio, sc->gfp_mask)) {
> +			    !may_enter_fs(folio, sc->gfp_mask) ||
> +			    (mapping && mapping_writeback_may_block(mapping))) {
>  				/*
>  				 * This is slightly racy -
>  				 * folio_end_writeback() might have
> -- 
> 2.43.5
> 

