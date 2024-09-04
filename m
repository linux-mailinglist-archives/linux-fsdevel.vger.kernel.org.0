Return-Path: <linux-fsdevel+bounces-28472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E8C96B052
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731AF281993
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB684E0A;
	Wed,  4 Sep 2024 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQYXFhhj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3084D12
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426428; cv=none; b=cZr+8mxqKHhlGtiwT82Z09ezstP+FerXiWiR+JWhj//Lhg2SHkXb6iM3KX7qWeNKRx9IWON1Gb9leQTd5KRlR4fqSy8zfc5PY/1GteFadehagNVqmMuwkk+R1ZYun65OhORFw7eaMfN6dv88lsiiYMMoSK4BZ0WYiaNTAfqCuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426428; c=relaxed/simple;
	bh=6ZfBzM/jQeLuMoY9RwgpNL0az2L3n0G0wqsjMs3H5kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu/bFSBjIA22qfAGbsYflyKsDgIAyACgZmJVkZZc6HAOJxXxW0douQwX98Wgx0UrhHRQM6P3oj+gl4e2nLYjtDclNN9zHpV3wA9R1OSaarG5n8lNKx6Dk5Tafo351rbZHSbp55Cdq3WitFFZjT+bQxFd/2kLIX78lK4N6fX8zfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQYXFhhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62269C4CEC2;
	Wed,  4 Sep 2024 05:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725426427;
	bh=6ZfBzM/jQeLuMoY9RwgpNL0az2L3n0G0wqsjMs3H5kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQYXFhhjsZSr/ytMoB4VS7nbOjXkCIZNDLki9v4Mzph9syzIPNLCCgAy61bkT0RWo
	 q5S0Vf1rfYDJGweu0hZZCQJE8wOGzgTJl6koGOa57NL1SNlChh3fcLW+cQMH/a4v+P
	 lNx5AAhMjsT23YgMBY10MrKrIh+mLSim5ABS9kJaEq9+kXfDLUFY0vavSpADNIJU3+
	 7pi6n83sByJYuaM8/5YhL/w8+C2bWMe9wKY0LhejHRTsiWLeY3goyTqu8+vAXSBoUW
	 uO+hbSvQCIhjRU3agAy9FBEWKdPa7GsfZxA1mfvJ/JAEzZOWB3mn54/cM9bwL3Gnts
	 hYgaWDWYVUriQ==
Date: Wed, 4 Sep 2024 08:04:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] slab: pass struct kmem_cache_args to
 do_kmem_cache_create()
Message-ID: <ZtfqVXGPepiCZ0s2@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-8-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-8-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:49PM +0200, Christian Brauner wrote:
> and initialize most things in do_kmem_cache_create(). In a follow-up
> patch we'll remove rcu_freeptr_offset from struct kmem_cache.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/slab.h        |  4 +++-
>  mm/slab_common.c | 27 ++++++---------------------
>  mm/slub.c        | 17 ++++++++++++++++-
>  3 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 684bb48c4f39..c7a4e0fc3cf1 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -424,7 +424,9 @@ kmalloc_slab(size_t size, kmem_buckets *b, gfp_t flags, unsigned long caller)
>  gfp_t kmalloc_fix_flags(gfp_t flags);
>  
>  /* Functions provided by the slab allocators */
> -int do_kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
> +int do_kmem_cache_create(struct kmem_cache *s, const char *name,
> +			 unsigned int size, struct kmem_cache_args *args,
> +			 slab_flags_t flags);
>  
>  void __init kmem_cache_init(void);
>  extern void create_boot_cache(struct kmem_cache *, const char *name,
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 9baa61c9c670..19ae3dd6e36f 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -224,20 +224,7 @@ static struct kmem_cache *create_cache(const char *name,
>  	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
>  	if (!s)
>  		goto out;
> -
> -	s->name = name;
> -	s->size = s->object_size = object_size;
> -	if (args->use_freeptr_offset)
> -		s->rcu_freeptr_offset = args->freeptr_offset;
> -	else
> -		s->rcu_freeptr_offset = UINT_MAX;
> -	s->align = args->align;
> -	s->ctor = args->ctor;
> -#ifdef CONFIG_HARDENED_USERCOPY
> -	s->useroffset = args->useroffset;
> -	s->usersize = args->usersize;
> -#endif
> -	err = do_kmem_cache_create(s, flags);
> +	err = do_kmem_cache_create(s, name, object_size, args, flags);
>  	if (err)
>  		goto out_free_cache;
>  
> @@ -788,9 +775,7 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
>  {
>  	int err;
>  	unsigned int align = ARCH_KMALLOC_MINALIGN;
> -
> -	s->name = name;
> -	s->size = s->object_size = size;
> +	struct kmem_cache_args kmem_args = {};
>  
>  	/*
>  	 * kmalloc caches guarantee alignment of at least the largest
> @@ -799,14 +784,14 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
>  	 */
>  	if (flags & SLAB_KMALLOC)
>  		align = max(align, 1U << (ffs(size) - 1));
> -	s->align = calculate_alignment(flags, align, size);
> +	kmem_args.align = calculate_alignment(flags, align, size);
>  
>  #ifdef CONFIG_HARDENED_USERCOPY
> -	s->useroffset = useroffset;
> -	s->usersize = usersize;
> +	kmem_args.useroffset = useroffset;
> +	kmem_args.usersize = usersize;
>  #endif
>  
> -	err = do_kmem_cache_create(s, flags);
> +	err = do_kmem_cache_create(s, name, size, &kmem_args, flags);
>  
>  	if (err)
>  		panic("Creation of kmalloc slab %s size=%u failed. Reason %d\n",
> diff --git a/mm/slub.c b/mm/slub.c
> index 30f4ca6335c7..4719b60215b8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5843,14 +5843,29 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>  	return s;
>  }
>  
> -int do_kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
> +int do_kmem_cache_create(struct kmem_cache *s, const char *name,
> +			 unsigned int size, struct kmem_cache_args *args,
> +			 slab_flags_t flags)
>  {
>  	int err = -EINVAL;
>  
> +	s->name = name;
> +	s->size = s->object_size = size;
> +
>  	s->flags = kmem_cache_flags(flags, s->name);
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>  	s->random = get_random_long();
>  #endif
> +	if (args->use_freeptr_offset)
> +		s->rcu_freeptr_offset = args->freeptr_offset;
> +	else
> +		s->rcu_freeptr_offset = UINT_MAX;
> +	s->align = args->align;
> +	s->ctor = args->ctor;
> +#ifdef CONFIG_HARDENED_USERCOPY
> +	s->useroffset = args->useroffset;
> +	s->usersize = args->usersize;
> +#endif
>  
>  	if (!calculate_sizes(s))
>  		goto out;
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

