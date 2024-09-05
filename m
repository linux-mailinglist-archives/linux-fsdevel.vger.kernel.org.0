Return-Path: <linux-fsdevel+bounces-28701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B4E96D1E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9F01F2C24D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC018194C73;
	Thu,  5 Sep 2024 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaTH0Fv0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE119341D
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524353; cv=none; b=ZqPsMBbQMXfO9KLAAQTuXHwMXb1fx5jLXxpyxZ+Tjsr7Hd5XFMrcV8nYWfpQo0ICuHpM3r6Co8fj0IsS4/bhd+EjX3NWHvUTBfruDvONUhdvmrFIGKMcjEqrth8PmOUFki89jOy6Wx9X+Ws6uPFmJ85/Z8U4A0izN2O5gBGv5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524353; c=relaxed/simple;
	bh=sv2gQtQX2pmJd2dgqLsOPXPgZNnpjXpyckrdF9ZT0Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwuKeg8bzkJbHJWlbE77OqjGzBKM8At6iVPzfhBvogjTsvzd7mSG7HqsCN7/Ml8AsAMdB8vyL06wGJEir5VkTiyzdmynWaV4g0ATWv4IoGnRObVhKhdrx7BsdZW4XpY2TiLScI7Ts6XucRfs0oQFvgM3JK8pwKh4BlVCESHjTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaTH0Fv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C173C4CEC3;
	Thu,  5 Sep 2024 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725524353;
	bh=sv2gQtQX2pmJd2dgqLsOPXPgZNnpjXpyckrdF9ZT0Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaTH0Fv0RzPdsLBgnK8ihQjwMRHr8XojIf86cTHdtVv38M6wQJZsrOwy18iBPeVHl
	 9c6zyuWAIimBf2npB5AW9ji76uQHC2rhnPBrpxKsGKRRTofWQLKa+oQQ7+YyP1LEqR
	 oOaV6q4vEFQ1W8eknqyWb/UBsKlBKxCPr2VLA0+iqnPyLWcunskoHjcUmF0vWSpc5N
	 FLr1aOonTzDNTqjCa3BZbotQlOscTOPPYIFu75SBpHhQ4fD3Ux1kn1ATmmDISCGSYS
	 q8dM1W0w/u40L+0b19R/voQJrdcEuh1v1JgeadPx6Oqw6BK9OAiLnKN1scXQfFM0eZ
	 yb8pYmgB5kjQA==
Date: Thu, 5 Sep 2024 11:16:22 +0300
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
Subject: Re: [PATCH v4 16/17] slab: make __kmem_cache_create() static inline
Message-ID: <Ztlo1sZfIpJ_wNG4@kernel.org>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-16-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-work-kmem_cache_args-v4-16-ed45d5380679@kernel.org>

On Thu, Sep 05, 2024 at 09:56:59AM +0200, Christian Brauner wrote:
> Make __kmem_cache_create() a static inline function.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/slab.h | 13 ++++++++++---
>  mm/slab_common.c     | 38 --------------------------------------
>  2 files changed, 10 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d744397aa46f..597f6913cc0f 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -261,10 +261,17 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  					    unsigned int object_size,
>  					    struct kmem_cache_args *args,
>  					    slab_flags_t flags);
> +static inline struct kmem_cache *
> +__kmem_cache_create(const char *name, unsigned int size, unsigned int align,
> +		    slab_flags_t flags, void (*ctor)(void *))
> +{
> +	struct kmem_cache_args kmem_args = {
> +		.align	= align,
> +		.ctor	= ctor,
> +	};
>  
> -struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> -				       unsigned int align, slab_flags_t flags,
> -				       void (*ctor)(void *));
> +	return __kmem_cache_create_args(name, size, &kmem_args, flags);
> +}
>  
>  /**
>   * kmem_cache_create_usercopy - Create a cache with a region suitable
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 3477a3918afd..30000dcf0736 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -337,44 +337,6 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  }
>  EXPORT_SYMBOL(__kmem_cache_create_args);
>  
> -/**
> - * __kmem_cache_create - Create a cache.
> - * @name: A string which is used in /proc/slabinfo to identify this cache.
> - * @size: The size of objects to be created in this cache.
> - * @align: The required alignment for the objects.
> - * @flags: SLAB flags
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
> -struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> -				       unsigned int align, slab_flags_t flags,
> -				       void (*ctor)(void *))
> -{
> -	struct kmem_cache_args kmem_args = {
> -		.align	= align,
> -		.ctor	= ctor,
> -	};
> -
> -	return __kmem_cache_create_args(name, size, &kmem_args, flags);
> -}
> -EXPORT_SYMBOL(__kmem_cache_create);
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

