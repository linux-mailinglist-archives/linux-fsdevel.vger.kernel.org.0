Return-Path: <linux-fsdevel+bounces-28476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC696B066
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2660CB225FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB3C82488;
	Wed,  4 Sep 2024 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBqC2xVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969526AC3
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725427031; cv=none; b=RezHvQA8utDMokwmyMxE5yXHo1GPAAh+Ifhak8dYwxXEwFb3Jn3DzojroHe9fPmdOE2LGZpS7CuLhws8a2DraSr/qWieDRaOZXiqQTp18UxmekGPOkWfrr/SDY306mMh3I9vm9kw6yQqQd5jx1fx3IbOkGfajJhu018lwFHdJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725427031; c=relaxed/simple;
	bh=UWJ3IrTm1u6boS0Ss1RlAPOifSdksQzwJ9xv5pb3ogM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkG+qDA+PVfL3iyDCY2OWoxAaUIYav2BBKHq/fCxJLELUmmIRdnf789oTN1cmcFbiar3MeTkYx0rZIlC+kZd8U0ij0N2b4SoKhdRwPhdx1vsfQFhGmQHyBOfac8B8swNg3r81xqwBlr9EURGP7/cdGcq9D+EZRHM5wY7pwRlQCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBqC2xVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30579C4CEC2;
	Wed,  4 Sep 2024 05:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725427030;
	bh=UWJ3IrTm1u6boS0Ss1RlAPOifSdksQzwJ9xv5pb3ogM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBqC2xVw3KIPPtyfNucYAUNIRriQbgEgfAA/Luz+Dq7uKkeVYZQFS2irmIv5oJ8HO
	 iW3jbihcNIVYiaAHrPGOKjeWybXbDuJnMt39dvAgFDjyGXo6kLHMFZgIw5P6afkvaq
	 SSNnLRfxmY3D7YqW4Hk7FsRVVms7lXA9CU1cKvDRaJ9MW9Yghy82H4p2ubz4au9Go0
	 MsIP5Q6MGqLgGUNp4UPavK5X76gjGzTk+QkAkznUlgwCVcZp9nWjwzCbdDf2qtUT3V
	 9EF/4XDMrBg8hDpxMRkxXNXejw2prXIXVpvQl8SbG0c2KXWJ8eZECXv3cWCsQ0p5pT
	 I/bgNWRcyck1A==
Date: Wed, 4 Sep 2024 08:14:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] slab: create kmem_cache_create() compatibility
 layer
Message-ID: <ZtfssAqDeyd_-4MJ@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-12-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-12-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:53PM +0200, Christian Brauner wrote:
> Use _Generic() to create a compatibility layer that type switches on the
> third argument to either call __kmem_cache_create() or
> __kmem_cache_create_args(). This can be kept in place until all callers
> have been ported to struct kmem_cache_args.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/slab.h | 13 ++++++++++---
>  mm/slab_common.c     | 10 +++++-----
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index aced16a08700..4292d67094c3 100644
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

As I said earlier, this can become _kmem_cache_create and
__kmem_cache_create_args can be __kmem_cache_create from the beginning.

And as a followup cleanup both kmem_cache_create_usercopy() and
kmem_cache_create() can be made static inlines.

>  struct kmem_cache *kmem_cache_create_usercopy(const char *name,
>  			unsigned int size, unsigned int align,
>  			slab_flags_t flags,
> @@ -272,6 +273,12 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
>  struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
>  					 unsigned int freeptr_offset,
>  					 slab_flags_t flags);
> +
> +#define kmem_cache_create(__name, __object_size, __args, ...)           \
> +	_Generic((__args),                                              \
> +		struct kmem_cache_args *: __kmem_cache_create_args,	\
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

