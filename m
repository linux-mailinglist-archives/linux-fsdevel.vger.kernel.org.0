Return-Path: <linux-fsdevel+bounces-28699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29D96D1D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8DD281EDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A6194A60;
	Thu,  5 Sep 2024 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtSTKHg5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9531946B9
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524277; cv=none; b=XN41JADCLxoTMY51kcQLaKLwuG8MKPCnd5m0MNUAqPc4YcQkpSowQ4w4vtNIR/8lsBJiY4QLy+0aO8WICjMw/WgQNxgByOfbCzqf9Z6Z2G90dyhFbesDMMEVe8bIFxHuzdv81ys+SWyXkad0lh661n7dxy0hsqfI5PTMPrDXfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524277; c=relaxed/simple;
	bh=5TgCuB2LLe9eQrdVm1yMGNqreXfg9pwWN4AzFS2fvb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEHTPqr5JfZOgTvs8/VzUq2ONpqLp4Byk6sI8UHsN5vH7kuTZFRfvfWHzU8rv+hGpn6tFgx5EtCWTSrDPKOe4UOfIgtgGdjBh0VnMPi/UlDd4+z3zkRCrFAw/9XhvlXFRRlBeQ2dRurQQN0IYAKkL1Ls5ZysX7oweS+SA2vMz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtSTKHg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F584C4CEC7;
	Thu,  5 Sep 2024 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725524277;
	bh=5TgCuB2LLe9eQrdVm1yMGNqreXfg9pwWN4AzFS2fvb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtSTKHg5Q6X+udB4GEEpwMf+I11xNOyg5uF1MvPWJTcIk07gM2iv+Pm/N60btv+fv
	 hs1DfCN5GoXRDpn/+qu2QBuEAQ0syor9uC3j4czyn42vrf3lG7KpaHxe21hzwGcAfs
	 tAAmGd1RL4lOg/P2B4hfR3ZUT1zhrLijDO/W95sKPIHD1iGtqJuy/7FJalpXJgMfiu
	 g/WsqfJsCTKRM4ihaiXUiZYEsl3/Y2QG++WF6RR3Y+8XXLYXZ+FcgTS/oSJ/45LIFd
	 xwgHnjEtUt1TEQY9aPZZft4Tg4gZAwrnQS//ldRSZNdaYv49tm+x5NGBZUXRiHIEBS
	 8ZbFh/AxHCkwA==
Date: Thu, 5 Sep 2024 11:15:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 12/17] slab: create kmem_cache_create() compatibility
 layer
Message-ID: <ZtloidQLbHVgrkF8@kernel.org>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-12-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-work-kmem_cache_args-v4-12-ed45d5380679@kernel.org>

On Thu, Sep 05, 2024 at 09:56:55AM +0200, Christian Brauner wrote:
> Use _Generic() to create a compatibility layer that type switches on the
> third argument to either call __kmem_cache_create() or
> __kmem_cache_create_args(). If NULL is passed for the struct
> kmem_cache_args argument use default args making porting for callers
> that don't care about additional arguments easy.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/slab.h | 29 ++++++++++++++++++++++++++---
>  mm/slab_common.c     | 10 +++++-----
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index cb264dded324..f74ceb788ac1 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -261,9 +261,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  					    unsigned int object_size,
>  					    struct kmem_cache_args *args,
>  					    slab_flags_t flags);
> -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
> -			unsigned int align, slab_flags_t flags,
> -			void (*ctor)(void *));
> +
> +struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> +				       unsigned int align, slab_flags_t flags,
> +				       void (*ctor)(void *));
>  struct kmem_cache *kmem_cache_create_usercopy(const char *name,
>  			unsigned int size, unsigned int align,
>  			slab_flags_t flags,
> @@ -272,6 +273,28 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
>  struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
>  					 unsigned int freeptr_offset,
>  					 slab_flags_t flags);
> +
> +/* If NULL is passed for @args, use this variant with default arguments. */
> +static inline struct kmem_cache *
> +__kmem_cache_default_args(const char *name, unsigned int size,
> +			  struct kmem_cache_args *args,
> +			  slab_flags_t flags)
> +{
> +	struct kmem_cache_args kmem_default_args = {};
> +
> +	/* Make sure we don't get passed garbage. */
> +	if (WARN_ON_ONCE(args))
> +		return NULL;
> +
> +	return __kmem_cache_create_args(name, size, &kmem_default_args, flags);
> +}
> +
> +#define kmem_cache_create(__name, __object_size, __args, ...)           \
> +	_Generic((__args),                                              \
> +		struct kmem_cache_args *: __kmem_cache_create_args,	\
> +		void *: __kmem_cache_default_args,			\
> +		default: __kmem_cache_create)(__name, __object_size, __args, __VA_ARGS__)
> +
>  void kmem_cache_destroy(struct kmem_cache *s);
>  int kmem_cache_shrink(struct kmem_cache *s);
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 19ae3dd6e36f..418459927670 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -383,7 +383,7 @@ kmem_cache_create_usercopy(const char *name, unsigned int size,
>  EXPORT_SYMBOL(kmem_cache_create_usercopy);
>  
>  /**
> - * kmem_cache_create - Create a cache.
> + * __kmem_cache_create - Create a cache.
>   * @name: A string which is used in /proc/slabinfo to identify this cache.
>   * @size: The size of objects to be created in this cache.
>   * @align: The required alignment for the objects.
> @@ -407,9 +407,9 @@ EXPORT_SYMBOL(kmem_cache_create_usercopy);
>   *
>   * Return: a pointer to the cache on success, NULL on failure.
>   */
> -struct kmem_cache *
> -kmem_cache_create(const char *name, unsigned int size, unsigned int align,
> -		slab_flags_t flags, void (*ctor)(void *))
> +struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> +				       unsigned int align, slab_flags_t flags,
> +				       void (*ctor)(void *))
>  {
>  	struct kmem_cache_args kmem_args = {
>  		.align	= align,
> @@ -418,7 +418,7 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>  
>  	return __kmem_cache_create_args(name, size, &kmem_args, flags);
>  }
> -EXPORT_SYMBOL(kmem_cache_create);
> +EXPORT_SYMBOL(__kmem_cache_create);
>  
>  /**
>   * kmem_cache_create_rcu - Create a SLAB_TYPESAFE_BY_RCU cache.
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

