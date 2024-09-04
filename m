Return-Path: <linux-fsdevel+bounces-28473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD2096B055
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22A61C23FF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8F82863;
	Wed,  4 Sep 2024 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0d9g5qV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B4433A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426653; cv=none; b=rU3yjprP84XaYi+936tkStRvTbD2blYyjwIkJ4fy7ocrdMXj3i6Lwo9ViBVequ6sEi9Jg+K/e1/Cu42nVS8gScpxLeN9vI5kJsvGNG2TdS8zpz2L/lhbet06EX3tIhsjmvZCk7r+12o3cslHTvr/h3/U4x4KhaHGzolen5ehaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426653; c=relaxed/simple;
	bh=eiQDbB65MOj/skZg+CxDwDPLc8nbgEl5X6AiGv621pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9Jkx+5jJQwuDEbCIQLohq/luCTFtR6JxJ6CO2ZmXtH4cgvqSM+o2Z4WH8OiXToxARYWxcgeDVCtGYicceuLOvuq8ZjGi2yRmnU3V9Nx5FSSJcsjNbkOtOBfcpfdSgxdz6kPsgbo2FH8fsyieNPrwhy09xlcjo8QZVClmc5SFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0d9g5qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08326C4CEC2;
	Wed,  4 Sep 2024 05:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725426652;
	bh=eiQDbB65MOj/skZg+CxDwDPLc8nbgEl5X6AiGv621pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0d9g5qVMmRbKnQkTATRthi67y3J3rGMX2uI124WLH/x14GH7eSI44TWHXDYggqo2
	 bn5NjaXt7c+pwfI3W4ToeWIWUEnrs8y7vVPAYewieHtVcgZeurB3+AwTXoK3icsabV
	 RNRYijRUC57dfrr2dAEukkiQHxNYUMjv0tzuNG1H+stio3oJtI0l6EsuC7Q82OOMWP
	 j9fZYVpEsRxb+WEkrKiM1wyRCQjqx4IyKYW9Cb1U2Seqgl3sEqCdvuTsBq9JLjiZvI
	 FONArJUoVgUjBJEZ9U+DEkIdzxVF4V5VrJk5ryg/nJLp0kWBIOwIsUCGZIL/rtFlpT
	 0rpw/BNC7L+LA==
Date: Wed, 4 Sep 2024 08:08:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 09/15] sl*b: remove rcu_freeptr_offset from struct
 kmem_cache
Message-ID: <ZtfrNWTZxCAiB2ok@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-9-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-9-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:50PM +0200, Christian Brauner wrote:
> Now that we pass down struct kmem_cache_args to calculate_sizes() we
> don't need it anymore.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  mm/slab.h |  2 --
>  mm/slub.c | 25 +++++++------------------
>  2 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index c7a4e0fc3cf1..36ac38e21fcb 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -261,8 +261,6 @@ struct kmem_cache {
>  	unsigned int object_size;	/* Object size without metadata */
>  	struct reciprocal_value reciprocal_size;
>  	unsigned int offset;		/* Free pointer offset */
> -	/* Specific free pointer requested (if not UINT_MAX) */
> -	unsigned int rcu_freeptr_offset;
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	/* Number of per cpu partial objects to keep around */
>  	unsigned int cpu_partial;
> diff --git a/mm/slub.c b/mm/slub.c
> index 4719b60215b8..a23c7036cd61 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3916,8 +3916,7 @@ static void *__slab_alloc_node(struct kmem_cache *s,
>   * If the object has been wiped upon free, make sure it's fully initialized by
>   * zeroing out freelist pointer.
>   *
> - * Note that we also wipe custom freelist pointers specified via
> - * s->rcu_freeptr_offset.
> + * Note that we also wipe custom freelist pointers.
>   */
>  static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
>  						   void *obj)
> @@ -5141,17 +5140,11 @@ static void set_cpu_partial(struct kmem_cache *s)
>  #endif
>  }
>  
> -/* Was a valid freeptr offset requested? */
> -static inline bool has_freeptr_offset(const struct kmem_cache *s)
> -{
> -	return s->rcu_freeptr_offset != UINT_MAX;
> -}
> -
>  /*
>   * calculate_sizes() determines the order and the distribution of data within
>   * a slab object.
>   */
> -static int calculate_sizes(struct kmem_cache *s)
> +static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)

I'd keep kmem_cache the first argument.
As for the rest

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  {
>  	slab_flags_t flags = s->flags;
>  	unsigned int size = s->object_size;
> @@ -5192,7 +5185,7 @@ static int calculate_sizes(struct kmem_cache *s)
>  	 */
>  	s->inuse = size;
>  
> -	if (((flags & SLAB_TYPESAFE_BY_RCU) && !has_freeptr_offset(s)) ||
> +	if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset) ||
>  	    (flags & SLAB_POISON) || s->ctor ||
>  	    ((flags & SLAB_RED_ZONE) &&
>  	     (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {
> @@ -5214,8 +5207,8 @@ static int calculate_sizes(struct kmem_cache *s)
>  		 */
>  		s->offset = size;
>  		size += sizeof(void *);
> -	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && has_freeptr_offset(s)) {
> -		s->offset = s->rcu_freeptr_offset;
> +	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && args->use_freeptr_offset) {
> +		s->offset = args->freeptr_offset;
>  	} else {
>  		/*
>  		 * Store freelist pointer near middle of object to keep
> @@ -5856,10 +5849,6 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>  	s->random = get_random_long();
>  #endif
> -	if (args->use_freeptr_offset)
> -		s->rcu_freeptr_offset = args->freeptr_offset;
> -	else
> -		s->rcu_freeptr_offset = UINT_MAX;
>  	s->align = args->align;
>  	s->ctor = args->ctor;
>  #ifdef CONFIG_HARDENED_USERCOPY
> @@ -5867,7 +5856,7 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>  	s->usersize = args->usersize;
>  #endif
>  
> -	if (!calculate_sizes(s))
> +	if (!calculate_sizes(args, s))
>  		goto out;
>  	if (disable_higher_order_debug) {
>  		/*
> @@ -5877,7 +5866,7 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>  		if (get_order(s->size) > get_order(s->object_size)) {
>  			s->flags &= ~DEBUG_METADATA_FLAGS;
>  			s->offset = 0;
> -			if (!calculate_sizes(s))
> +			if (!calculate_sizes(args, s))
>  				goto out;
>  		}
>  	}
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

