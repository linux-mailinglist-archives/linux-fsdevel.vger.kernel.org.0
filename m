Return-Path: <linux-fsdevel+bounces-28506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F67196B5FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265472867DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE491A3032;
	Wed,  4 Sep 2024 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuG1Q/25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E021146A7B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440816; cv=none; b=iag4Jxdw3W0UwLniM92UucsygBcszAzUgemBtu6UY6bMCChOitN8qciy3PHlIhWVYHic5wzvTE4NPUKLQWotJ2TAFQQgdTWMYc97YrjrBKkoNWPhMkzWst/xGn81i4sHY82A0iS2366P+eSdixNkg0wvr4irI2AaYTOb6VC6tqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440816; c=relaxed/simple;
	bh=8pXHE83HSgNwFHSJezj0X5u1fo8c8fnfaOMKDRq/dGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f48WkqxQMV1Cb+CK/38SV2d3EaK78dT/+WBHXphijy+WO/gTppdTvuW6mCgzGCqcVpx5f547vkJB99yowHwBTseeiPuLp8asB2rYPDTHqI4pm/nFyaQrppIkrirS4fyvUed19mxWcaDkoVDRI0PX5N5popN5a7P4058anGwuldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuG1Q/25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15895C4CEC2;
	Wed,  4 Sep 2024 09:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725440815;
	bh=8pXHE83HSgNwFHSJezj0X5u1fo8c8fnfaOMKDRq/dGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuG1Q/252JCVeDWOig9aL6xZcgQP62JDdfn6J5sJ91mmt//4+mVtwo4L7fEilCwcd
	 gTE42WmDbjOmSUIch+9232b/zyR93NHEFKtcyStQN+ltsL8h1MYnIKlHJWk4Pr4TPp
	 xW9Y67S5Ljg5PqWAbRelQ58HybRnNomyhOSIOjkBp8fU9MJG2qkUmedklL3fhDN9ss
	 r+oSJmAboOu2NQ9zcjKVY6YRPP6UDU4qFSp/Cz7R5ygEovY3WA4B9W1QzZsBwQnSor
	 5RW22RtdWQWkrqWriWkRi9CPUnTOiEBH6n4qH7bylRhZY11ufsi+MqHEtOjQ5A1lRl
	 +Nt0mdkVeXEtw==
Date: Wed, 4 Sep 2024 11:06:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
Message-ID: <20240904-trieb-waran-bcca80d7e223@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
 <c3b8a4e6-42ac-411a-ae0d-cd3aa5f1be50@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3b8a4e6-42ac-411a-ae0d-cd3aa5f1be50@suse.cz>

On Wed, Sep 04, 2024 at 10:13:11AM GMT, Vlastimil Babka wrote:
> On 9/3/24 16:20, Christian Brauner wrote:
> 
> You could describe that it's to hold less common args and there's
> __kmem_cache_create_args() that takes it, and
> do_kmem_cache_create_usercopy() is converted to it? Otherwise LGTM.

Hm, I seem to have dropped the contents of the commit message when I
split it into multiple individual commits. I've now added:

"Currently we have multiple kmem_cache_create*() variants that take up to
seven separate parameters with one of the functions having to grow an
eigth parameter in the future to handle both usercopy and a custom
freelist pointer.

Add a struct kmem_cache_args structure and move less common parameters
into it. Core parameters such as name, object size, and flags continue
to be passed separately.

Add a new function __kmem_cache_create_args() that takes a struct
kmem_cache_args pointer and port do_kmem_cache_create_usercopy() over to
it.

In follow-up patches we will port the other kmem_cache_create*()
variants over to it as well."

to the work.kmem_cache_args branch.

> 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  include/linux/slab.h | 21 ++++++++++++++++
> >  mm/slab_common.c     | 67 +++++++++++++++++++++++++++++++++++++++-------------
> >  2 files changed, 72 insertions(+), 16 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 5b2da2cf31a8..79d8c8bca4a4 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -240,6 +240,27 @@ struct mem_cgroup;
> >   */
> >  bool slab_is_available(void);
> >  
> > +/**
> > + * @align: The required alignment for the objects.
> > + * @useroffset: Usercopy region offset
> > + * @usersize: Usercopy region size
> > + * @freeptr_offset: Custom offset for the free pointer in RCU caches
> > + * @use_freeptr_offset: Whether a @freeptr_offset is used
> > + * @ctor: A constructor for the objects.
> > + */
> > +struct kmem_cache_args {
> > +	unsigned int align;
> > +	unsigned int useroffset;
> > +	unsigned int usersize;
> > +	unsigned int freeptr_offset;
> > +	bool use_freeptr_offset;
> > +	void (*ctor)(void *);
> > +};
> > +
> > +struct kmem_cache *__kmem_cache_create_args(const char *name,
> > +					    unsigned int object_size,
> > +					    struct kmem_cache_args *args,
> > +					    slab_flags_t flags);
> >  struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
> >  			unsigned int align, slab_flags_t flags,
> >  			void (*ctor)(void *));
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 91e0e36e4379..0f13c045b8d1 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -248,14 +248,24 @@ static struct kmem_cache *create_cache(const char *name,
> >  	return ERR_PTR(err);
> >  }
> >  
> > -static struct kmem_cache *
> > -do_kmem_cache_create_usercopy(const char *name,
> > -		  unsigned int size, unsigned int freeptr_offset,
> > -		  unsigned int align, slab_flags_t flags,
> > -		  unsigned int useroffset, unsigned int usersize,
> > -		  void (*ctor)(void *))
> > +/**
> > + * __kmem_cache_create_args - Create a kmem cache
> > + * @name: A string which is used in /proc/slabinfo to identify this cache.
> > + * @object_size: The size of objects to be created in this cache.
> > + * @args: Arguments for the cache creation (see struct kmem_cache_args).
> > + * @flags: See %SLAB_* flags for an explanation of individual @flags.
> > + *
> > + * Cannot be called within a interrupt, but can be interrupted.
> > + *
> > + * Return: a pointer to the cache on success, NULL on failure.
> > + */
> > +struct kmem_cache *__kmem_cache_create_args(const char *name,
> > +					    unsigned int object_size,
> > +					    struct kmem_cache_args *args,
> > +					    slab_flags_t flags)
> >  {
> >  	struct kmem_cache *s = NULL;
> > +	unsigned int freeptr_offset = UINT_MAX;
> >  	const char *cache_name;
> >  	int err;
> >  
> > @@ -275,7 +285,7 @@ do_kmem_cache_create_usercopy(const char *name,
> >  
> >  	mutex_lock(&slab_mutex);
> >  
> > -	err = kmem_cache_sanity_check(name, size);
> > +	err = kmem_cache_sanity_check(name, object_size);
> >  	if (err) {
> >  		goto out_unlock;
> >  	}
> > @@ -296,12 +306,14 @@ do_kmem_cache_create_usercopy(const char *name,
> >  
> >  	/* Fail closed on bad usersize of useroffset values. */
> >  	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
> > -	    WARN_ON(!usersize && useroffset) ||
> > -	    WARN_ON(size < usersize || size - usersize < useroffset))
> > -		usersize = useroffset = 0;
> > -
> > -	if (!usersize)
> > -		s = __kmem_cache_alias(name, size, align, flags, ctor);
> > +	    WARN_ON(!args->usersize && args->useroffset) ||
> > +	    WARN_ON(object_size < args->usersize ||
> > +		    object_size - args->usersize < args->useroffset))
> > +		args->usersize = args->useroffset = 0;
> > +
> > +	if (!args->usersize)
> > +		s = __kmem_cache_alias(name, object_size, args->align, flags,
> > +				       args->ctor);
> >  	if (s)
> >  		goto out_unlock;
> >  
> > @@ -311,9 +323,11 @@ do_kmem_cache_create_usercopy(const char *name,
> >  		goto out_unlock;
> >  	}
> >  
> > -	s = create_cache(cache_name, size, freeptr_offset,
> > -			 calculate_alignment(flags, align, size),
> > -			 flags, useroffset, usersize, ctor);
> > +	if (args->use_freeptr_offset)
> > +		freeptr_offset = args->freeptr_offset;
> > +	s = create_cache(cache_name, object_size, freeptr_offset,
> > +			 calculate_alignment(flags, args->align, object_size),
> > +			 flags, args->useroffset, args->usersize, args->ctor);
> >  	if (IS_ERR(s)) {
> >  		err = PTR_ERR(s);
> >  		kfree_const(cache_name);
> > @@ -335,6 +349,27 @@ do_kmem_cache_create_usercopy(const char *name,
> >  	}
> >  	return s;
> >  }
> > +EXPORT_SYMBOL(__kmem_cache_create_args);
> > +
> > +static struct kmem_cache *
> > +do_kmem_cache_create_usercopy(const char *name,
> > +                 unsigned int size, unsigned int freeptr_offset,
> > +                 unsigned int align, slab_flags_t flags,
> > +                 unsigned int useroffset, unsigned int usersize,
> > +                 void (*ctor)(void *))
> > +{
> > +	struct kmem_cache_args kmem_args = {
> > +		.align			= align,
> > +		.use_freeptr_offset	= freeptr_offset != UINT_MAX,
> > +		.freeptr_offset		= freeptr_offset,
> > +		.useroffset		= useroffset,
> > +		.usersize		= usersize,
> > +		.ctor			= ctor,
> > +	};
> > +
> > +	return __kmem_cache_create_args(name, size, &kmem_args, flags);
> > +}
> > +
> >  
> >  /**
> >   * kmem_cache_create_usercopy - Create a cache with a region suitable
> > 
> 

