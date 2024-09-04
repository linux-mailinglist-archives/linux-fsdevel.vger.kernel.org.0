Return-Path: <linux-fsdevel+bounces-28464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3286896B02F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B0C2842D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 04:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2106823A9;
	Wed,  4 Sep 2024 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA8cFhpf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FA635
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725425741; cv=none; b=kUMRQWDK5/IdwE1lTrgvQojSgaDmLB+t/ZXHjcytvJM///uL/4gF0m+gJig1pa1QdBbd5LKobOmqcWJIVXV0H40qM63Qo7ZqDD+tv31EhKThpJwZ/iz3FW+ILnsytmiBn1HKqjXuZPg6EMdJXTul57IQilXq7Pu8P/QrLfJ9Bj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725425741; c=relaxed/simple;
	bh=xCVg5YijMeWw+7qHt6YjC5F2EL8jztaPbo/u9wdC1Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4T6FpInujPpEfgFalUQIGN9sfanobaZQm4jjmkeHdFJaAqAgWLVGqCue3Nkig/fI6kbAzr76E+9XYDqZFruWuHDFWCqDmF/yGGzmwiwr35MI2LgN2vykv2t+qnsPDRK/AkFefzu8Yqxj4i9M0pMnfmx+gMlaVy+iSZzXy7LwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA8cFhpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5FEC4CEC2;
	Wed,  4 Sep 2024 04:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725425740;
	bh=xCVg5YijMeWw+7qHt6YjC5F2EL8jztaPbo/u9wdC1Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hA8cFhpfATY35yiENDqd6tjJxVC4e70M59UOg+nM7FoIB5Bimojlx5Xu7FCVU7WSi
	 ffXbyvyttiIt54X5uvQ/70Wrk/PvukPNRThAKIji43pUBjksiI4UtjV0NAvtTr1/Dh
	 Cm+DUHE0uArb80O2kjhm5oWAlhSs49jHPLeN9GetrctOzufW04g0d4YvGFpcSbFZGz
	 oO+igcAEYo0KDAOhA0l5YdB7y2EiMs0UdSxVBm1aVpX4BU2kw1Q/5b8QqY3FBHkomw
	 MBqSJ+FjhZ3u1oW/W77GBqpE2Rgqj/vlUTqm8Ifen+as3IouwmzmpWJCYjTD48uH6l
	 x9SMIu1A8VGuw==
Date: Wed, 4 Sep 2024 07:52:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] sl*b:
 s/__kmem_cache_create/do_kmem_cache_create/g
Message-ID: <Ztfnpm7Qq9CqRxXm@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-1-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-1-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:42PM +0200, Christian Brauner wrote:
> Free up reusing the double-underscore variant for follow-up patches.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/slab.h        | 2 +-
>  mm/slab_common.c | 4 ++--
>  mm/slub.c        | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index a6051385186e..684bb48c4f39 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -424,7 +424,7 @@ kmalloc_slab(size_t size, kmem_buckets *b, gfp_t flags, unsigned long caller)
>  gfp_t kmalloc_fix_flags(gfp_t flags);
>  
>  /* Functions provided by the slab allocators */
> -int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
> +int do_kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
>  
>  void __init kmem_cache_init(void);
>  extern void create_boot_cache(struct kmem_cache *, const char *name,
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 95db3702f8d6..91e0e36e4379 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -234,7 +234,7 @@ static struct kmem_cache *create_cache(const char *name,
>  	s->useroffset = useroffset;
>  	s->usersize = usersize;
>  #endif
> -	err = __kmem_cache_create(s, flags);
> +	err = do_kmem_cache_create(s, flags);
>  	if (err)
>  		goto out_free_cache;
>  
> @@ -778,7 +778,7 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
>  	s->usersize = usersize;
>  #endif
>  
> -	err = __kmem_cache_create(s, flags);
> +	err = do_kmem_cache_create(s, flags);
>  
>  	if (err)
>  		panic("Creation of kmalloc slab %s size=%u failed. Reason %d\n",
> diff --git a/mm/slub.c b/mm/slub.c
> index 9aa5da1e8e27..23d9d783ff26 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5902,7 +5902,7 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>  	return s;
>  }
>  
> -int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
> +int do_kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
>  {
>  	int err;
>  
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

