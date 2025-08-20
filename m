Return-Path: <linux-fsdevel+bounces-58412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C90B2E818
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D12588344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 22:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE382848AA;
	Wed, 20 Aug 2025 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eeXW/WML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F027A134
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728561; cv=none; b=StBnyYTgVrKlVsW4WBJo4MJ+DZgwbUtmRnIoxDN74rAhQmUU0yaUqZm8esKBIdWkrY84YtAXEo6r1o9yjvfXLnYlzAZHtO0OxctiGgD36+89wIhP7xsOAYj3+5ln0Uk/uXFEWSSIoyW4xwLVPmGJb3H3f8wpeX6QE/6v9J+z7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728561; c=relaxed/simple;
	bh=1c4X17Q7ggtl32ABrVnl69tcyCh7f48iAi7TNSramjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrP9+IbRkDewWkKiAkE3yTanQt/+b06FzGW2BSKbfSibCAdqhdShpCERPiO52EU011kPiorHAu/RiBHTdI1bTHC5mwtdv3T5J3Tt5EVVe/bdztWiGKfV7YEhzpqbMkl5aUAhhIQnDcWBhWqcXBjIJwwhwoGZPOlwMx8Fx04E8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eeXW/WML; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Aug 2025 15:22:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755728547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKna9+pTrNiSBtEO552scEDaUumI8ZqvDqHtxxkqIFM=;
	b=eeXW/WMLq4obqxrBljin+eptqDeBv8yMznDNcxfiysjlI9wnD6ctl0ywYp5rkjziOAfyQ0
	/1c4DMMJf4OXjjdefa0/hTbmG4ZUACQKWj2bxTSqKUCg5ew9NYGuUxGeUcHhwlmXYEDFNd
	KNvQa5xnWbTUZx58x+ts+rGLw7/mLes=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Boris Burkov <boris@bur.io>, akpm@linux-foundation.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com, wqu@suse.com, willy@infradead.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v3 1/4] mm/filemap: add AS_UNCHARGED
Message-ID: <hdxyep67zjudwbawdyasxhe4xeu7ckua35wo7whwy3zkjaa5ie@tibviq22ndhf>
References: <cover.1755562487.git.boris@bur.io>
 <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>
 <hbdekl37pkdsvdvzgsz5prg5nlmyr67zrkqgucq3gdtepqjilh@ovc6untybhbg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hbdekl37pkdsvdvzgsz5prg5nlmyr67zrkqgucq3gdtepqjilh@ovc6untybhbg>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 21, 2025 at 12:06:42AM +0200, Klara Modin wrote:
[...]
> 
> The following diff resolves the issue for me:
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fae105a9cb46..c70e789201fc 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -809,7 +809,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  
>  static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
>  {
> -	if (mem_cgroup_disabled())
> +	if (mem_cgroup_disabled() || !memcg)
>  		return 0;
>  
>  	return memcg->id.id;
> 
> However, it's mentioned in folio_memcg() that it can return NULL so this
> might be an existing bug which this patch just makes more obvious.
> 
> There's also workingset_eviction() which instead gets the memcg from
> lruvec. Doing that in lru_gen_eviction() also resolves the issue for me:
> 
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 68a76a91111f..e805eadf0ec7 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -243,6 +243,7 @@ static void *lru_gen_eviction(struct folio *folio)
>  	int tier = lru_tier_from_refs(refs, workingset);
>  	struct mem_cgroup *memcg = folio_memcg(folio);
>  	struct pglist_data *pgdat = folio_pgdat(folio);
> +	int memcgid;
>  
>  	BUILD_BUG_ON(LRU_GEN_WIDTH + LRU_REFS_WIDTH > BITS_PER_LONG - EVICTION_SHIFT);
>  
> @@ -254,7 +255,9 @@ static void *lru_gen_eviction(struct folio *folio)
>  	hist = lru_hist_from_seq(min_seq);
>  	atomic_long_add(delta, &lrugen->evicted[hist][type][tier]);
>  
> -	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, workingset);
> +	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
> +
> +	return pack_shadow(memcgid, pgdat, token, workingset);
>  }
>  
>  /*
> 
> I don't really know what I'm doing here, though.

Thanks a lot for the report and I think we will prefer your second
approach which makes lru_gen_eviction() similar to
workingset_eviction(). Can you please send a formal patch and Boris can
add that patch in his series?

