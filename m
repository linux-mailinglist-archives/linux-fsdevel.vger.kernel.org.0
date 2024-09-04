Return-Path: <linux-fsdevel+bounces-28470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393D96B03E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3AF284738
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BD682D7F;
	Wed,  4 Sep 2024 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVD3dP/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649926AC3
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 05:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426124; cv=none; b=jiQWaU83E9trSj+BCzKrkiI2wmkyaiXJpNtYSvTttnI6i8Mop0czZdl9BJ3e0b1dCaMCXZsujLMpmq2eP0KxPN4F7Gtf7n9BQyloaGRRVzHP6fRdtABGNkzMolfMffmdoKTpWxy6ITOcR1Z+Sp7FAntRt+/6MExMYvM443nYWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426124; c=relaxed/simple;
	bh=9otNc/1h7eEutY4XYROpqf51IkwtHGhWF+hLMr+BPZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4EJ2FW0M5NXG3D/FaQ12C0jgwG7VQWEADpf2GmBGyyABgx2YS3q7Xd6XC18SkmgseEbY7nyq0Jff5J1KGq+T4fL1QRtVGdxFxFafbwebwlZr3mhthtV3QGx6j6wBEFu1dQKpQmgHGye0vI+O26CzzpxwP4BxK1IbZMd/89DY9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVD3dP/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CF1C4CEC2;
	Wed,  4 Sep 2024 05:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725426123;
	bh=9otNc/1h7eEutY4XYROpqf51IkwtHGhWF+hLMr+BPZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVD3dP/rGqLVme3d+wrVXAGwYA1QlAWUq7whQWTEltOmQ8LsqYknCJ0/CexsS2MMY
	 cjR87li2ptpCdCUzLkTFVpPZOSFuZ5PVZXzuhvV/YhxOGb/6AcnyPZp3JCROSa/X3t
	 Ll+Qmq68YLzhcQZzZC0x5Rcm9WpqmM1WDKeNjIE57SyVth4fVxoycr39QXumbBy4M/
	 UPk5q2c43LafDg2hbb2XHPNXgeU2jzqyiZqKb2mXpSwEtKzXU3dPsyhguCSUYpYmyP
	 reIeZjP0Cpek25+jnCvKy6kip9S1K1g9H0oiOKGEbeW/OIwL6jYTmhlNT+jfbkF1Mb
	 4odTGNauLTjIw==
Date: Wed, 4 Sep 2024 07:59:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 06/15] slab: pass struct kmem_cache_args to
 create_cache()
Message-ID: <ZtfpJUYYGMATiMtA@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-6-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-6-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:47PM +0200, Christian Brauner wrote:
> Pass struct kmem_cache_args to create_cache() so that we can later
> simplify further helpers.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/slab_common.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 16c36a946135..9baa61c9c670 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -202,22 +202,22 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
>  }
>  
>  static struct kmem_cache *create_cache(const char *name,
> -		unsigned int object_size, unsigned int freeptr_offset,
> -		unsigned int align, slab_flags_t flags,
> -		unsigned int useroffset, unsigned int usersize,
> -		void (*ctor)(void *))
> +				       unsigned int object_size,
> +				       struct kmem_cache_args *args,
> +				       slab_flags_t flags)
>  {
>  	struct kmem_cache *s;
>  	int err;
>  
> -	if (WARN_ON(useroffset + usersize > object_size))
> -		useroffset = usersize = 0;
> +	if (WARN_ON(args->useroffset + args->usersize > object_size))
> +		args->useroffset = args->usersize = 0;
>  
>  	/* If a custom freelist pointer is requested make sure it's sane. */
>  	err = -EINVAL;
> -	if (freeptr_offset != UINT_MAX &&
> -	    (freeptr_offset >= object_size || !(flags & SLAB_TYPESAFE_BY_RCU) ||
> -	     !IS_ALIGNED(freeptr_offset, sizeof(freeptr_t))))
> +	if (args->use_freeptr_offset &&
> +	    (args->freeptr_offset >= object_size ||
> +	     !(flags & SLAB_TYPESAFE_BY_RCU) ||
> +	     !IS_ALIGNED(args->freeptr_offset, sizeof(freeptr_t))))
>  		goto out;
>  
>  	err = -ENOMEM;
> @@ -227,12 +227,15 @@ static struct kmem_cache *create_cache(const char *name,
>  
>  	s->name = name;
>  	s->size = s->object_size = object_size;
> -	s->rcu_freeptr_offset = freeptr_offset;
> -	s->align = align;
> -	s->ctor = ctor;
> +	if (args->use_freeptr_offset)
> +		s->rcu_freeptr_offset = args->freeptr_offset;
> +	else
> +		s->rcu_freeptr_offset = UINT_MAX;
> +	s->align = args->align;
> +	s->ctor = args->ctor;
>  #ifdef CONFIG_HARDENED_USERCOPY
> -	s->useroffset = useroffset;
> -	s->usersize = usersize;
> +	s->useroffset = args->useroffset;
> +	s->usersize = args->usersize;
>  #endif
>  	err = do_kmem_cache_create(s, flags);
>  	if (err)
> @@ -265,7 +268,6 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  					    slab_flags_t flags)
>  {
>  	struct kmem_cache *s = NULL;
> -	unsigned int freeptr_offset = UINT_MAX;
>  	const char *cache_name;
>  	int err;
>  
> @@ -323,11 +325,8 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  		goto out_unlock;
>  	}
>  
> -	if (args->use_freeptr_offset)
> -		freeptr_offset = args->freeptr_offset;
> -	s = create_cache(cache_name, object_size, freeptr_offset,
> -			 calculate_alignment(flags, args->align, object_size),
> -			 flags, args->useroffset, args->usersize, args->ctor);
> +	args->align = calculate_alignment(flags, args->align, object_size);
> +	s = create_cache(cache_name, object_size, args, flags);
>  	if (IS_ERR(s)) {
>  		err = PTR_ERR(s);
>  		kfree_const(cache_name);
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

