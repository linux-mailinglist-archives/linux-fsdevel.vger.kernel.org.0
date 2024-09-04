Return-Path: <linux-fsdevel+bounces-28468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8DD96B038
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1E11C23C31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 04:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7089A823AF;
	Wed,  4 Sep 2024 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA7pW3yC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E2286A6
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 04:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725425958; cv=none; b=QzpD7p93xDj3Zdxbd/zpAGD/HAMuO8CUCa1wu/bYjNtFD/tXgMd3tV3SfZ39g0vs5tPiqry8ni99Bp83IZGH5YmhBBzc361KKKgXAZCk3yBdZXOTgPLWgydDBjSFLC3wT9LV/AYwxgPkECDUpimoBm9zybtUxbwWL0l7QBX67sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725425958; c=relaxed/simple;
	bh=8+GnIVhs2cEaVvWGHlSmiYB3pqH0EWCyi0fO4HvJCgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ2D4nHUSrab4of4lqlcCdcpd31h9cDYysF56S4wRATV1csbyLvL33+qL7eH1OcYVDtNU9eixQuA+SLF1mST7OaFXph8sTPogOBhzJjF8H4iDjNH7YUzgMNAVYCXHoqNGL6deCu+R+s/yJvF2QIpSp+2iTPgF/iN8Tj+BXIOgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA7pW3yC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE073C4CEC2;
	Wed,  4 Sep 2024 04:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725425958;
	bh=8+GnIVhs2cEaVvWGHlSmiYB3pqH0EWCyi0fO4HvJCgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sA7pW3yC3Gq3w1RC/zQVLwOYDz0qMNK4ZoZZMYDS40Fqi9B66fwyyFa1OFUXP+74B
	 qcZacOC1/KwDhipq3I0Exu8vupYXaNYe0Plc19Nwr4mu0oNucfOsufTDROzPqG7QIV
	 2slBBzwxEE0uoT29f/6V8OloAocKQ2S1Gzfy6vOOhEBGB9zlm2iWOE6KcbBq0F+IkD
	 sPVdDTbIxccOHyfnsRFcYedXb8qcYYauIRJvH4iWqCXShdHufDnrwl91QeAJrSF5HJ
	 nm0yreYYRi6GtNzLguY36ko6R43opwP3UyrNFHX+lUe/AzjFkr1Ccl/l1mtLMOTgOW
	 65TxIsNTBW3cg==
Date: Wed, 4 Sep 2024 07:56:32 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] slab: port kmem_cache_create_usercopy() to
 struct kmem_cache_args
Message-ID: <ZtfogLMBElWPT6Iw@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-5-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-5-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:46PM +0200, Christian Brauner wrote:
> Pprt kmem_cache_create_usercopy() to struct kmem_cache_args and remove
> the now unused do_kmem_cache_create_usercopy() helper.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/slab_common.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index da62ed30f95d..16c36a946135 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -351,26 +351,6 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  }
>  EXPORT_SYMBOL(__kmem_cache_create_args);
>  
> -static struct kmem_cache *
> -do_kmem_cache_create_usercopy(const char *name,
> -                 unsigned int size, unsigned int freeptr_offset,
> -                 unsigned int align, slab_flags_t flags,
> -                 unsigned int useroffset, unsigned int usersize,
> -                 void (*ctor)(void *))
> -{
> -	struct kmem_cache_args kmem_args = {
> -		.align			= align,
> -		.use_freeptr_offset	= freeptr_offset != UINT_MAX,
> -		.freeptr_offset		= freeptr_offset,
> -		.useroffset		= useroffset,
> -		.usersize		= usersize,
> -		.ctor			= ctor,
> -	};
> -
> -	return __kmem_cache_create_args(name, size, &kmem_args, flags);
> -}
> -
> -
>  /**
>   * kmem_cache_create_usercopy - Create a cache with a region suitable
>   * for copying to userspace
> @@ -405,8 +385,14 @@ kmem_cache_create_usercopy(const char *name, unsigned int size,
>  			   unsigned int useroffset, unsigned int usersize,
>  			   void (*ctor)(void *))
>  {
> -	return do_kmem_cache_create_usercopy(name, size, UINT_MAX, align, flags,
> -					     useroffset, usersize, ctor);
> +	struct kmem_cache_args kmem_args = {
> +		.align		= align,
> +		.ctor		= ctor,
> +		.useroffset	= useroffset,
> +		.usersize	= usersize,
> +	};
> +
> +	return __kmem_cache_create_args(name, size, &kmem_args, flags);
>  }
>  EXPORT_SYMBOL(kmem_cache_create_usercopy);
>  
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

