Return-Path: <linux-fsdevel+bounces-28474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586FA96B056
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84DA2811E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913782863;
	Wed,  4 Sep 2024 05:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaquArHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB129433A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 05:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426691; cv=none; b=JALRaksnmq2F1Wk7G6529d9Vpl6bylXVZNtOdwYfpcgBJuEHytjBsweVJZIEj/BSCITNUd1EatxLTO84Xxz6ZHZluW57gaWtAxQ3g8+XKgu6deMqbvq6DOA3mzotW032vAIcB7TKcElHWhQDTn6uuxxhTvG3vYUrxsfBNiXxQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426691; c=relaxed/simple;
	bh=zv+d8RqTD8nakbEm5vm6JLfyQuiLsX3JxcK/0vUOVC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1kRuHPLatKWVVDkEoeo6ep3fYG01ggd5E/xjQbYYZymsX3w8fPkNjs6G/0gOTE9K0LiNoJaWoybGH4qTJhN/x7681gLSqitb6+t0OBvFMrxN6QEVlqA5A5esqoHH5GP33xyJwfW8DVv9nuLBBaVDey7L2/hEP/xaSvwPsbR994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaquArHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC18C4CEC2;
	Wed,  4 Sep 2024 05:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725426691;
	bh=zv+d8RqTD8nakbEm5vm6JLfyQuiLsX3JxcK/0vUOVC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaquArHG4wK8LD6FLAVFXWK2tBgkWzS7vEWGdNJK82THFDZsmdSHP6vKdyTF9o0Tv
	 YxZMBHTP8+IKHxLTUcm3kv7Xt1h38iLCqMMXyKh89DJ9YjYCXvvFfD6IvCE1erjbZC
	 N9DOlbOoN3L7QG8urMxefgIcfWJeMd7Tytb5au0fImEvJO5UTrWnCOtQS4oAN75kQb
	 QzUqCzte0oZi5kg8im1FUFX4bT3s5OUoiHj/EZLs7F9BOp43xj3IzdCPgm8Ta8GwlH
	 +YjR+vmnHaA4RSx2w+zI4pj0OeS75SAh9/gDr9CJMsiYUqzWnrbVJD9MJWvz/PCGWU
	 CCzgeScca72TA==
Date: Wed, 4 Sep 2024 08:08:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 10/15] slab: port KMEM_CACHE() to struct
 kmem_cache_args
Message-ID: <ZtfrXS82RE1r1Ny3@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-10-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-10-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:51PM +0200, Christian Brauner wrote:
> Make KMEM_CACHE() use struct kmem_cache_args.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/slab.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 79d8c8bca4a4..d9c2ed5bc02f 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -283,9 +283,12 @@ int kmem_cache_shrink(struct kmem_cache *s);
>   * f.e. add ____cacheline_aligned_in_smp to the struct declaration
>   * then the objects will be properly aligned in SMP configurations.
>   */
> -#define KMEM_CACHE(__struct, __flags)					\
> -		kmem_cache_create(#__struct, sizeof(struct __struct),	\
> -			__alignof__(struct __struct), (__flags), NULL)
> +#define KMEM_CACHE(__struct, __flags)                                   \
> +	__kmem_cache_create_args(#__struct, sizeof(struct __struct),    \
> +			&(struct kmem_cache_args) {			\
> +				.align	= __alignof__(struct __struct), \
> +				.ctor	= NULL,                         \
> +			}, (__flags))
>  
>  /*
>   * To whitelist a single field for copying to/from usercopy, use this
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

