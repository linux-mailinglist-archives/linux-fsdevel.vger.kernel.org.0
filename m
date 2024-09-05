Return-Path: <linux-fsdevel+bounces-28700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AE896D1DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1136B26600
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1270B198A03;
	Thu,  5 Sep 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9eRubES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A221993B0
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524309; cv=none; b=H0YMl5kCR13OGHh7wN5ttJM6i+oYi5IDfxwO82B3GYC0S0KbrXzV796CA6NkXvGQtJui7PBqHgc83WAuzQ819h0osBda/prGYR5LOrLgzfiexpQ4fqU+cJWED+wqY0vpXkDDmYcT4mO6g2RUA6KhDnjZt+zeIr6glP/NOK1rGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524309; c=relaxed/simple;
	bh=gNHAlcjyUiQhdcMW88pODZCcV2NS47zUsaBbz3VhaOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebmT7+unLIh3CeVIldXeg1ZbERA5zrV5vsvtcb1UaQ/Y3HDVg4YKRZCxEZQBLjMIVRQnvHKJybhouGFp3GwKFJP/ZEzBgxQxIRSM/zW9VkKClUwNX76+XugoVI4RybN9Q+vKd3KPaK2RkFjgC98pmvL91RXgoHizMGZut8H0mJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9eRubES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4E1C4AF0B;
	Thu,  5 Sep 2024 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725524308;
	bh=gNHAlcjyUiQhdcMW88pODZCcV2NS47zUsaBbz3VhaOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9eRubESyP9v1sdwltjL1AjeucOgMuA8zDtmIj3k5nCdhUqG6gX4gqWU4BWByoOfL
	 H/QBe22M52wvE7OBjrGsj78qOlHjXqj7c35g/OYONgQ7+JTGj5Q4rqUf6dM69dTglB
	 BnzXmrOvHQB2VavS2cq31+50UCV/UADMlU9wvnp0aoXRTEZ3cfaIeKRIWPuwYB3zyd
	 vOq48Wjg+jEqmmEXvFeRLp7B53YHvXrOLVLCjquOYCZ74/FcE0gID9UM+BCT33z5fM
	 Y2LYLlzoZlFgBFBN2Vv6QgP2ZFw3I94/JYWWRilSBBGYQiMOaQPxXxPP3cGNW7+3un
	 3d8eYeV5FD+jw==
Date: Thu, 5 Sep 2024 11:15:37 +0300
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
Subject: Re: [PATCH v4 15/17] slab: make kmem_cache_create_usercopy() static
 inline
Message-ID: <ZtloqXHmqw5cm8b4@kernel.org>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-15-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-work-kmem_cache_args-v4-15-ed45d5380679@kernel.org>

On Thu, Sep 05, 2024 at 09:56:58AM +0200, Christian Brauner wrote:
> Make kmem_cache_create_usercopy() a static inline function.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/slab.h | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
>  mm/slab_common.c     | 45 ---------------------------------------------
>  2 files changed, 44 insertions(+), 50 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 8246f9b28f43..d744397aa46f 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -265,11 +265,50 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
>  				       unsigned int align, slab_flags_t flags,
>  				       void (*ctor)(void *));
> -struct kmem_cache *kmem_cache_create_usercopy(const char *name,
> -			unsigned int size, unsigned int align,
> -			slab_flags_t flags,
> -			unsigned int useroffset, unsigned int usersize,
> -			void (*ctor)(void *));
> +
> +/**
> + * kmem_cache_create_usercopy - Create a cache with a region suitable
> + * for copying to userspace
> + * @name: A string which is used in /proc/slabinfo to identify this cache.
> + * @size: The size of objects to be created in this cache.
> + * @align: The required alignment for the objects.
> + * @flags: SLAB flags
> + * @useroffset: Usercopy region offset
> + * @usersize: Usercopy region size
> + * @ctor: A constructor for the objects.
> + *
> + * Cannot be called within a interrupt, but can be interrupted.
> + * The @ctor is run when new pages are allocated by the cache.
> + *
> + * The flags are
> + *
> + * %SLAB_POISON - Poison the slab with a known test pattern (a5a5a5a5)
> + * to catch references to uninitialised memory.
> + *
> + * %SLAB_RED_ZONE - Insert `Red` zones around the allocated memory to check
> + * for buffer overruns.
> + *
> + * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
> + * cacheline.  This can be beneficial if you're counting cycles as closely
> + * as davem.
> + *
> + * Return: a pointer to the cache on success, NULL on failure.
> + */
> +static inline struct kmem_cache *
> +kmem_cache_create_usercopy(const char *name, unsigned int size,
> +			   unsigned int align, slab_flags_t flags,
> +			   unsigned int useroffset, unsigned int usersize,
> +			   void (*ctor)(void *))
> +{
> +	struct kmem_cache_args kmem_args = {
> +		.align		= align,
> +		.ctor		= ctor,
> +		.useroffset	= useroffset,
> +		.usersize	= usersize,
> +	};
> +
> +	return __kmem_cache_create_args(name, size, &kmem_args, flags);
> +}
>  
>  /* If NULL is passed for @args, use this variant with default arguments. */
>  static inline struct kmem_cache *
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 9133b9fafcb1..3477a3918afd 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -337,51 +337,6 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  }
>  EXPORT_SYMBOL(__kmem_cache_create_args);
>  
> -/**
> - * kmem_cache_create_usercopy - Create a cache with a region suitable
> - * for copying to userspace
> - * @name: A string which is used in /proc/slabinfo to identify this cache.
> - * @size: The size of objects to be created in this cache.
> - * @align: The required alignment for the objects.
> - * @flags: SLAB flags
> - * @useroffset: Usercopy region offset
> - * @usersize: Usercopy region size
> - * @ctor: A constructor for the objects.
> - *
> - * Cannot be called within a interrupt, but can be interrupted.
> - * The @ctor is run when new pages are allocated by the cache.
> - *
> - * The flags are
> - *
> - * %SLAB_POISON - Poison the slab with a known test pattern (a5a5a5a5)
> - * to catch references to uninitialised memory.
> - *
> - * %SLAB_RED_ZONE - Insert `Red` zones around the allocated memory to check
> - * for buffer overruns.
> - *
> - * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
> - * cacheline.  This can be beneficial if you're counting cycles as closely
> - * as davem.
> - *
> - * Return: a pointer to the cache on success, NULL on failure.
> - */
> -struct kmem_cache *
> -kmem_cache_create_usercopy(const char *name, unsigned int size,
> -			   unsigned int align, slab_flags_t flags,
> -			   unsigned int useroffset, unsigned int usersize,
> -			   void (*ctor)(void *))
> -{
> -	struct kmem_cache_args kmem_args = {
> -		.align		= align,
> -		.ctor		= ctor,
> -		.useroffset	= useroffset,
> -		.usersize	= usersize,
> -	};
> -
> -	return __kmem_cache_create_args(name, size, &kmem_args, flags);
> -}
> -EXPORT_SYMBOL(kmem_cache_create_usercopy);
> -
>  /**
>   * __kmem_cache_create - Create a cache.
>   * @name: A string which is used in /proc/slabinfo to identify this cache.
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

