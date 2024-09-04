Return-Path: <linux-fsdevel+bounces-28478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5090396B069
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E98E2858DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39AE82866;
	Wed,  4 Sep 2024 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooAxCfyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83854BD4
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 05:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725427090; cv=none; b=DFyTvtEEAKGsWPkEPT0J0haLM6MpmGSojq2FCxFDIvb+W8yxK6CfgsvEY5evdVmz6C22SKWzhuwyMFxbzCJlkAQWbhrYwxTDXlK1FokWFb4I7rGaFT1tHr8SPLC1bC744LIuV6UOJ0MJ4Hkqd1n/e43voYBCbk0Dap3OKmUVnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725427090; c=relaxed/simple;
	bh=Dz13rylvhrRPpHk9Sl6YRWeBjANz4ja7bmi9tj6+Jnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXf4yp55/ihNTdVszWc7Bl0KgpWZzzoByb4Z8zIvNMFzkdirZ82A/dajJbN4H8q3iEMZJTiNp6T/95QVflUTdVrky+7kVmZxnpIfNHjUARgFn9Dccv0a+bKuEzkPHSNW1rtneT7IYAHyaN0YyoD7J5EMZoa+dNF3qwYqe7+CUsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooAxCfyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5BCC4CEC2;
	Wed,  4 Sep 2024 05:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725427089;
	bh=Dz13rylvhrRPpHk9Sl6YRWeBjANz4ja7bmi9tj6+Jnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooAxCfyjE1CwmZ4uQnvj1dwiuK4wSFxniELKr5aWObC+Dbup1Mp+x2uQ0kT/azhNp
	 EL5OvmtlrdStG7PUdWwk1ljAFOs+laTPG9LT/46at9es9Y7eC9lrgQDTvO0RecgM2j
	 06F+vBx5hNsfBO+S8e23Vn7skAPIHabntFxjR79VZAabFvoQPTgZJ6vDGyHtlunQKn
	 /cVFF5LRPUY7njTUcapi0f7w/PZvQLQYugaE4wNQ8GH7XJ9JeYJOAHqs2ZbXHqq5+L
	 AB0EnB2gkRKIGlV1FD8kct0V3YnAVdNcalMqA+PY1bJJGU46cfYuo6jFDcyCSpKMS1
	 pQdi4bRHk7Rag==
Date: Wed, 4 Sep 2024 08:15:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 14/15] slab: remove kmem_cache_create_rcu()
Message-ID: <Ztfs6_Rvnbvap0Cr@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-14-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-14-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:55PM +0200, Christian Brauner wrote:
> Since we have kmem_cache_setup() and have ported kmem_cache_create_rcu()
> users over to it is unused and can be removed.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/slab.h |  3 ---
>  mm/slab_common.c     | 43 -------------------------------------------
>  2 files changed, 46 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 4292d67094c3..1176b30cd4b2 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -270,9 +270,6 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
>  			slab_flags_t flags,
>  			unsigned int useroffset, unsigned int usersize,
>  			void (*ctor)(void *));
> -struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
> -					 unsigned int freeptr_offset,
> -					 slab_flags_t flags);
>  
>  #define kmem_cache_create(__name, __object_size, __args, ...)           \
>  	_Generic((__args),                                              \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 418459927670..9133b9fafcb1 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -420,49 +420,6 @@ struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
>  }
>  EXPORT_SYMBOL(__kmem_cache_create);
>  
> -/**
> - * kmem_cache_create_rcu - Create a SLAB_TYPESAFE_BY_RCU cache.
> - * @name: A string which is used in /proc/slabinfo to identify this cache.
> - * @size: The size of objects to be created in this cache.
> - * @freeptr_offset: The offset into the memory to the free pointer
> - * @flags: SLAB flags
> - *
> - * Cannot be called within an interrupt, but can be interrupted.
> - *
> - * See kmem_cache_create() for an explanation of possible @flags.
> - *
> - * By default SLAB_TYPESAFE_BY_RCU caches place the free pointer outside
> - * of the object. This might cause the object to grow in size. Callers
> - * that have a reason to avoid this can specify a custom free pointer
> - * offset in their struct where the free pointer will be placed.
> - *
> - * Note that placing the free pointer inside the object requires the
> - * caller to ensure that no fields are invalidated that are required to
> - * guard against object recycling (See SLAB_TYPESAFE_BY_RCU for
> - * details.).
> - *
> - * Using zero as a value for @freeptr_offset is valid. To request no
> - * offset UINT_MAX must be specified.
> - *
> - * Note that @ctor isn't supported with custom free pointers as a @ctor
> - * requires an external free pointer.
> - *
> - * Return: a pointer to the cache on success, NULL on failure.
> - */
> -struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
> -					 unsigned int freeptr_offset,
> -					 slab_flags_t flags)
> -{
> -	struct kmem_cache_args kmem_args = {
> -		.freeptr_offset		= freeptr_offset,
> -		.use_freeptr_offset	= true,
> -	};
> -
> -	return __kmem_cache_create_args(name, size, &kmem_args,
> -					flags | SLAB_TYPESAFE_BY_RCU);
> -}
> -EXPORT_SYMBOL(kmem_cache_create_rcu);
> -
>  static struct kmem_cache *kmem_buckets_cache __ro_after_init;
>  
>  /**
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

