Return-Path: <linux-fsdevel+bounces-28570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDFD96C213
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F531C248C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74971DC1B5;
	Wed,  4 Sep 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5eBQYXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561631D88D0
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463144; cv=none; b=H2pccwJ9AP6c4qgd5dBE7io1vwHGL+Q5xLhRoX6nH+OkNoy2qpqp5ODq+/sebnEikEFlnEDGEiytWX5pv/WwTGsNQ18KREx5R8eE+hEsv6u2jPe9iotLwYyix6C8JULtkzLJYhTXLwrF8Igixo77cJY22LHNIqTm+ffHl1kcQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463144; c=relaxed/simple;
	bh=4Chh2Trjq5PXaev8Wq994yU6ASdDaYO/5cXJBfvCKsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPX98+Xsno4t1iYzPe1rs7Alhi7ADhlJkk8mC/Zi2S8VdxitIGjIl8HHaSpNcNlREIe5luFOigMtWsNPQ/XNkxkppZ1eJ56jiEX7jUM8WVNwnFPhqAg2HT7KjP2LltNbRNc2RugJmM3p7e7pGqpFTBpjlpSLrScsM1aNC7zE7dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5eBQYXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7543DC4CEC2;
	Wed,  4 Sep 2024 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725463144;
	bh=4Chh2Trjq5PXaev8Wq994yU6ASdDaYO/5cXJBfvCKsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5eBQYXJngCBoEx6C7EPsk11Sq40ju6uc3HzdMFGqc1mPFsJiULiAJ3Y0DT8sW5Qu
	 4B6H0MTzcjpf/Smyed2MU7S7uB/FHysVHHW1ZMW2Wq3Zqt/lY2rVpklJ9P9sAJgPpT
	 K3OnAn6KQeQnwuTGL8MqDu0Ot5neBtxoN52Jk9PUfjRAwzoj9lj4XlR9GPinYC4Hum
	 UZzaOlzE3t4yBLviHQDZsiHB45ajDg86UrehJjYyVb27k8c3qEnQcqxBKo4QB5lbkk
	 g+VKledzKUFdUcDhT5weErza6vVhVNzoez5ZVu4v6g3/UYuYpsMmaq3XQst3S5ntvB
	 nzSd0euuHHy0g==
Date: Wed, 4 Sep 2024 18:16:16 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
Message-ID: <Zth5wHtDkX78gl1l@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:43PM +0200, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/slab.h | 21 ++++++++++++++++
>  mm/slab_common.c     | 67 +++++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 72 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 5b2da2cf31a8..79d8c8bca4a4 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -240,6 +240,27 @@ struct mem_cgroup;
>   */
>  bool slab_is_available(void);
>  
> +/**
> + * @align: The required alignment for the objects.
> + * @useroffset: Usercopy region offset
> + * @usersize: Usercopy region size
> + * @freeptr_offset: Custom offset for the free pointer in RCU caches
> + * @use_freeptr_offset: Whether a @freeptr_offset is used
> + * @ctor: A constructor for the objects.
> + */
> +struct kmem_cache_args {
> +	unsigned int align;
> +	unsigned int useroffset;
> +	unsigned int usersize;
> +	unsigned int freeptr_offset;
> +	bool use_freeptr_offset;
> +	void (*ctor)(void *);
> +};
> +
> +struct kmem_cache *__kmem_cache_create_args(const char *name,
> +					    unsigned int object_size,
> +					    struct kmem_cache_args *args,
> +					    slab_flags_t flags);
>  struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
>  			unsigned int align, slab_flags_t flags,
>  			void (*ctor)(void *));
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 91e0e36e4379..0f13c045b8d1 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -248,14 +248,24 @@ static struct kmem_cache *create_cache(const char *name,
>  	return ERR_PTR(err);
>  }
>  
> -static struct kmem_cache *
> -do_kmem_cache_create_usercopy(const char *name,
> -		  unsigned int size, unsigned int freeptr_offset,
> -		  unsigned int align, slab_flags_t flags,
> -		  unsigned int useroffset, unsigned int usersize,
> -		  void (*ctor)(void *))
> +/**
> + * __kmem_cache_create_args - Create a kmem cache
> + * @name: A string which is used in /proc/slabinfo to identify this cache.
> + * @object_size: The size of objects to be created in this cache.
> + * @args: Arguments for the cache creation (see struct kmem_cache_args).
> + * @flags: See %SLAB_* flags for an explanation of individual @flags.
> + *
> + * Cannot be called within a interrupt, but can be interrupted.
> + *
> + * Return: a pointer to the cache on success, NULL on failure.
> + */
> +struct kmem_cache *__kmem_cache_create_args(const char *name,
> +					    unsigned int object_size,
> +					    struct kmem_cache_args *args,
> +					    slab_flags_t flags)
>  {
>  	struct kmem_cache *s = NULL;
> +	unsigned int freeptr_offset = UINT_MAX;
>  	const char *cache_name;
>  	int err;
>  
> @@ -275,7 +285,7 @@ do_kmem_cache_create_usercopy(const char *name,
>  
>  	mutex_lock(&slab_mutex);
>  
> -	err = kmem_cache_sanity_check(name, size);
> +	err = kmem_cache_sanity_check(name, object_size);
>  	if (err) {
>  		goto out_unlock;
>  	}
> @@ -296,12 +306,14 @@ do_kmem_cache_create_usercopy(const char *name,
>  
>  	/* Fail closed on bad usersize of useroffset values. */
>  	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
> -	    WARN_ON(!usersize && useroffset) ||
> -	    WARN_ON(size < usersize || size - usersize < useroffset))
> -		usersize = useroffset = 0;
> -
> -	if (!usersize)
> -		s = __kmem_cache_alias(name, size, align, flags, ctor);
> +	    WARN_ON(!args->usersize && args->useroffset) ||
> +	    WARN_ON(object_size < args->usersize ||
> +		    object_size - args->usersize < args->useroffset))
> +		args->usersize = args->useroffset = 0;
> +
> +	if (!args->usersize)
> +		s = __kmem_cache_alias(name, object_size, args->align, flags,
> +				       args->ctor);

Sorry I missed it in the previous review, but nothing guaranties that
nobody will call kmem_cache_create_args with args != NULL.

I think there should be a check for args != NULL and a substitution of args
with defaults if it actually was NULL.

>  	if (s)
>  		goto out_unlock;
>  
> @@ -311,9 +323,11 @@ do_kmem_cache_create_usercopy(const char *name,
>  		goto out_unlock;
>  	}
>  
> -	s = create_cache(cache_name, size, freeptr_offset,
> -			 calculate_alignment(flags, align, size),
> -			 flags, useroffset, usersize, ctor);
> +	if (args->use_freeptr_offset)
> +		freeptr_offset = args->freeptr_offset;
> +	s = create_cache(cache_name, object_size, freeptr_offset,
> +			 calculate_alignment(flags, args->align, object_size),
> +			 flags, args->useroffset, args->usersize, args->ctor);
>  	if (IS_ERR(s)) {
>  		err = PTR_ERR(s);
>  		kfree_const(cache_name);
> @@ -335,6 +349,27 @@ do_kmem_cache_create_usercopy(const char *name,
>  	}
>  	return s;
>  }
> +EXPORT_SYMBOL(__kmem_cache_create_args);
> +
> +static struct kmem_cache *
> +do_kmem_cache_create_usercopy(const char *name,
> +                 unsigned int size, unsigned int freeptr_offset,
> +                 unsigned int align, slab_flags_t flags,
> +                 unsigned int useroffset, unsigned int usersize,
> +                 void (*ctor)(void *))
> +{
> +	struct kmem_cache_args kmem_args = {
> +		.align			= align,
> +		.use_freeptr_offset	= freeptr_offset != UINT_MAX,
> +		.freeptr_offset		= freeptr_offset,
> +		.useroffset		= useroffset,
> +		.usersize		= usersize,
> +		.ctor			= ctor,
> +	};
> +
> +	return __kmem_cache_create_args(name, size, &kmem_args, flags);
> +}
> +
>  
>  /**
>   * kmem_cache_create_usercopy - Create a cache with a region suitable
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

