Return-Path: <linux-fsdevel+bounces-28471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D16196B042
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B9F1F2547F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E80502B5;
	Wed,  4 Sep 2024 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzksLJpy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579D2A1BF
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426324; cv=none; b=ZcLYSar251okCZXojrMZ+HjOMuKQZCVGC1j9FYviOU4qO9nUmgJLwsswUrsUMvGkT2z3hZQR/EH3ux9qP5uW8akDmxYP1iTz317g8+RGlCYhaV/B78geEw2tkWhMS9YUIebFQNYX7lpTzGD07h9+vsYl5MARX1JgtoTlhH/rPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426324; c=relaxed/simple;
	bh=hYYe/f3Heq7cL4pkEkMqVo9uukiq3LWgcMvvuf73EzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggkZnNOxRhEgD65R+cKPVB4yokZb8k72gIb4lpvGZ6MedB0FOEg0vx/fFmuqlFj6xkrh/7pDtb6umEvyPQ1xWg2vPWhM1XIR7YNAqV/tp6KoyH6JLbyRb1DvRjVJi6LpRsikSs6qkW7XtnKYqRlguxbrmTug53EmL2qiy4qGRrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzksLJpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FDCC4CEC3;
	Wed,  4 Sep 2024 05:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725426324;
	bh=hYYe/f3Heq7cL4pkEkMqVo9uukiq3LWgcMvvuf73EzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzksLJpyMDutTGERgh2LGapeYK0k/1/Si86MKcPc+MS1RCwiis3kv6glhhmhcs1C8
	 u+FeRZSJ6xGTrv/k3bipSpZMDJ7ijphZVEuATZC6hnsF9DfnXToF4Obv/1L8VixsOW
	 nuzj1LLF1Vz0HLp45gPj0Zc2AWEBiU7YTZAJ0fqDlQw9kx5pFxdGG5QxXrDR+Ykq66
	 kY3XjBEQ9lRtRxOw6IkgzpVzgrZWlSE6V9j4BeusYJdA0qM5tp5DtFXWWXr4rFSFdS
	 d5DinNiXeQguXXi3uCuNpNyAYh2UxYzNAIq2bX+nwnkmaBGN/QfUyWtj3PLJcD5d8N
	 BPbhH4GASpodw==
Date: Wed, 4 Sep 2024 08:02:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/15] slub: pull kmem_cache_open() into
 do_kmem_cache_create()
Message-ID: <Ztfp7e4CkTnSNzra@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-7-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-7-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:48PM +0200, Christian Brauner wrote:
> do_kmem_cache_create() is the only caller and we're going to pass down
> struct kmem_cache_args in a follow-up patch.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Error handling in kmem_cache_open begs for improvement, but that's not
related to this patch.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/slub.c | 132 +++++++++++++++++++++++++++++---------------------------------
>  1 file changed, 62 insertions(+), 70 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 23d9d783ff26..30f4ca6335c7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5290,65 +5290,6 @@ static int calculate_sizes(struct kmem_cache *s)
>  	return !!oo_objects(s->oo);
>  }
>  
> -static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> -{
> -	s->flags = kmem_cache_flags(flags, s->name);
> -#ifdef CONFIG_SLAB_FREELIST_HARDENED
> -	s->random = get_random_long();
> -#endif
> -
> -	if (!calculate_sizes(s))
> -		goto error;
> -	if (disable_higher_order_debug) {
> -		/*
> -		 * Disable debugging flags that store metadata if the min slab
> -		 * order increased.
> -		 */
> -		if (get_order(s->size) > get_order(s->object_size)) {
> -			s->flags &= ~DEBUG_METADATA_FLAGS;
> -			s->offset = 0;
> -			if (!calculate_sizes(s))
> -				goto error;
> -		}
> -	}
> -
> -#ifdef system_has_freelist_aba
> -	if (system_has_freelist_aba() && !(s->flags & SLAB_NO_CMPXCHG)) {
> -		/* Enable fast mode */
> -		s->flags |= __CMPXCHG_DOUBLE;
> -	}
> -#endif
> -
> -	/*
> -	 * The larger the object size is, the more slabs we want on the partial
> -	 * list to avoid pounding the page allocator excessively.
> -	 */
> -	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
> -	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
> -
> -	set_cpu_partial(s);
> -
> -#ifdef CONFIG_NUMA
> -	s->remote_node_defrag_ratio = 1000;
> -#endif
> -
> -	/* Initialize the pre-computed randomized freelist if slab is up */
> -	if (slab_state >= UP) {
> -		if (init_cache_random_seq(s))
> -			goto error;
> -	}
> -
> -	if (!init_kmem_cache_nodes(s))
> -		goto error;
> -
> -	if (alloc_kmem_cache_cpus(s))
> -		return 0;
> -
> -error:
> -	__kmem_cache_release(s);
> -	return -EINVAL;
> -}
> -
>  static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
>  			      const char *text)
>  {
> @@ -5904,26 +5845,77 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>  
>  int do_kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
>  {
> -	int err;
> +	int err = -EINVAL;
>  
> -	err = kmem_cache_open(s, flags);
> -	if (err)
> -		return err;
> +	s->flags = kmem_cache_flags(flags, s->name);
> +#ifdef CONFIG_SLAB_FREELIST_HARDENED
> +	s->random = get_random_long();
> +#endif
> +
> +	if (!calculate_sizes(s))
> +		goto out;
> +	if (disable_higher_order_debug) {
> +		/*
> +		 * Disable debugging flags that store metadata if the min slab
> +		 * order increased.
> +		 */
> +		if (get_order(s->size) > get_order(s->object_size)) {
> +			s->flags &= ~DEBUG_METADATA_FLAGS;
> +			s->offset = 0;
> +			if (!calculate_sizes(s))
> +				goto out;
> +		}
> +	}
> +
> +#ifdef system_has_freelist_aba
> +	if (system_has_freelist_aba() && !(s->flags & SLAB_NO_CMPXCHG)) {
> +		/* Enable fast mode */
> +		s->flags |= __CMPXCHG_DOUBLE;
> +	}
> +#endif
> +
> +	/*
> +	 * The larger the object size is, the more slabs we want on the partial
> +	 * list to avoid pounding the page allocator excessively.
> +	 */
> +	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
> +	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
> +
> +	set_cpu_partial(s);
> +
> +#ifdef CONFIG_NUMA
> +	s->remote_node_defrag_ratio = 1000;
> +#endif
> +
> +	/* Initialize the pre-computed randomized freelist if slab is up */
> +	if (slab_state >= UP) {
> +		if (init_cache_random_seq(s))
> +			goto out;
> +	}
> +
> +	if (!init_kmem_cache_nodes(s))
> +		goto out;
> +
> +	if (!alloc_kmem_cache_cpus(s))
> +		goto out;
>  
>  	/* Mutex is not taken during early boot */
> -	if (slab_state <= UP)
> -		return 0;
> +	if (slab_state <= UP) {
> +		err = 0;
> +		goto out;
> +	}
>  
>  	err = sysfs_slab_add(s);
> -	if (err) {
> -		__kmem_cache_release(s);
> -		return err;
> -	}
> +	if (err)
> +		goto out;
>  
>  	if (s->flags & SLAB_STORE_USER)
>  		debugfs_slab_add(s);
>  
> -	return 0;
> +out:
> +	if (err)
> +		__kmem_cache_release(s);
> +	return err;
>  }
>  
>  #ifdef SLAB_SUPPORTS_SYSFS
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

