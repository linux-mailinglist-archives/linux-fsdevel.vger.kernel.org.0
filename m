Return-Path: <linux-fsdevel+bounces-28597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DC396C471
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686B3B213B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184D1E0B6C;
	Wed,  4 Sep 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk8nuKUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4171D1DFE1F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468786; cv=none; b=cwY7D83dqDuD4SrYWh5idbQZBvET3zNlv7A0/qESnw0ikNLfyx+36WqUvy9YHKoiXcqPf3EKZIpPCB9pVqA0SyULrrLbSr8soef3O8nb+Fz93ZM6uJ3w1xs+ZXQomB6DR5QAJJ+D6awFzeZzmnf0c034z23o864yZAk5t7p5ngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468786; c=relaxed/simple;
	bh=u1tfE+6LTF/AZPaX62ARJpFZTaHNZWfbhWhv90/bG3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Srwuz1iKDD+KvOtoqCgvUYozmD3OWYucyc7r3pkbVVcxyBVKXwGGOVhhl2wJVwXzIyR6t3ftBkfLTyDwvHKEmNSz9YStpLS9nedFqhckf2Li4opq+8QE6diSCK697onFgpvEDJETAbJfMQ2vcVRezyJmZBaN3WU1ytyYY1FJI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk8nuKUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D58C4CEC2;
	Wed,  4 Sep 2024 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725468785;
	bh=u1tfE+6LTF/AZPaX62ARJpFZTaHNZWfbhWhv90/bG3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sk8nuKUVpGPOYGgLAnFueUUTfsYVEYnDPrpSv0ecfRmwV4ID2QN+6CZJ52PZeMEyq
	 PffZmkN9T3tcvABDERA/L7KuP7H8bebBjTBxS/80+7ZQoZ/mJTcpmqMsXFy19uLc5K
	 LMioyZDfR5rkW+6LYJKFZaYxWLLOEkZ2i837+cd5rx0YUy3zxqPV1xP+Z1VzTCJocl
	 5qASXHEvlnPlb7v7ql6jHpsBWHUy3DEZKm/37slbHE/n6FuB+HqXWEu7RqRea4lAHC
	 SiNfmh2JSl6Tpbudo2zc35pkpcISRqR3lipSVgE5e0I3mfNYSqnFdCUNzh/cpzx/zM
	 QCNtmUd5TDutw==
Date: Wed, 4 Sep 2024 18:53:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
Message-ID: <20240904-warfen-labyrinth-f16ea368a200@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
 <Zth5wHtDkX78gl1l@kernel.org>
 <20240904-bauaufsicht-gewohnheit-a70bd9266986@brauner>
 <ZtiHxywbBG38cciA@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtiHxywbBG38cciA@kernel.org>

On Wed, Sep 04, 2024 at 07:16:07PM GMT, Mike Rapoport wrote:
> On Wed, Sep 04, 2024 at 05:48:31PM +0200, Christian Brauner wrote:
> > On Wed, Sep 04, 2024 at 06:16:16PM GMT, Mike Rapoport wrote:
> > > On Tue, Sep 03, 2024 at 04:20:43PM +0200, Christian Brauner wrote:
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > >  include/linux/slab.h | 21 ++++++++++++++++
> > > >  mm/slab_common.c     | 67 +++++++++++++++++++++++++++++++++++++++-------------
> > > >  2 files changed, 72 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > > index 5b2da2cf31a8..79d8c8bca4a4 100644
> > > > --- a/include/linux/slab.h
> > > > +++ b/include/linux/slab.h
> > > > @@ -240,6 +240,27 @@ struct mem_cgroup;
> > > >   */
> > > >  bool slab_is_available(void);
> > > >  
> > > > +/**
> > > > + * @align: The required alignment for the objects.
> > > > + * @useroffset: Usercopy region offset
> > > > + * @usersize: Usercopy region size
> > > > + * @freeptr_offset: Custom offset for the free pointer in RCU caches
> > > > + * @use_freeptr_offset: Whether a @freeptr_offset is used
> > > > + * @ctor: A constructor for the objects.
> > > > + */
> > > > +struct kmem_cache_args {
> > > > +	unsigned int align;
> > > > +	unsigned int useroffset;
> > > > +	unsigned int usersize;
> > > > +	unsigned int freeptr_offset;
> > > > +	bool use_freeptr_offset;
> > > > +	void (*ctor)(void *);
> > > > +};
> > > > +
> > > > +struct kmem_cache *__kmem_cache_create_args(const char *name,
> > > > +					    unsigned int object_size,
> > > > +					    struct kmem_cache_args *args,
> > > > +					    slab_flags_t flags);
> > > >  struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
> > > >  			unsigned int align, slab_flags_t flags,
> > > >  			void (*ctor)(void *));
> > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > index 91e0e36e4379..0f13c045b8d1 100644
> > > > --- a/mm/slab_common.c
> > > > +++ b/mm/slab_common.c
> > > > @@ -248,14 +248,24 @@ static struct kmem_cache *create_cache(const char *name,
> > > >  	return ERR_PTR(err);
> > > >  }
> > > >  
> > > > -static struct kmem_cache *
> > > > -do_kmem_cache_create_usercopy(const char *name,
> > > > -		  unsigned int size, unsigned int freeptr_offset,
> > > > -		  unsigned int align, slab_flags_t flags,
> > > > -		  unsigned int useroffset, unsigned int usersize,
> > > > -		  void (*ctor)(void *))
> > > > +/**
> > > > + * __kmem_cache_create_args - Create a kmem cache
> > > > + * @name: A string which is used in /proc/slabinfo to identify this cache.
> > > > + * @object_size: The size of objects to be created in this cache.
> > > > + * @args: Arguments for the cache creation (see struct kmem_cache_args).
> > > > + * @flags: See %SLAB_* flags for an explanation of individual @flags.
> > > > + *
> > > > + * Cannot be called within a interrupt, but can be interrupted.
> > > > + *
> > > > + * Return: a pointer to the cache on success, NULL on failure.
> > > > + */
> > > > +struct kmem_cache *__kmem_cache_create_args(const char *name,
> > > > +					    unsigned int object_size,
> > > > +					    struct kmem_cache_args *args,
> > > > +					    slab_flags_t flags)
> > > >  {
> > > >  	struct kmem_cache *s = NULL;
> > > > +	unsigned int freeptr_offset = UINT_MAX;
> > > >  	const char *cache_name;
> > > >  	int err;
> > > >  
> > > > @@ -275,7 +285,7 @@ do_kmem_cache_create_usercopy(const char *name,
> > > >  
> > > >  	mutex_lock(&slab_mutex);
> > > >  
> > > > -	err = kmem_cache_sanity_check(name, size);
> > > > +	err = kmem_cache_sanity_check(name, object_size);
> > > >  	if (err) {
> > > >  		goto out_unlock;
> > > >  	}
> > > > @@ -296,12 +306,14 @@ do_kmem_cache_create_usercopy(const char *name,
> > > >  
> > > >  	/* Fail closed on bad usersize of useroffset values. */
> > > >  	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
> > > > -	    WARN_ON(!usersize && useroffset) ||
> > > > -	    WARN_ON(size < usersize || size - usersize < useroffset))
> > > > -		usersize = useroffset = 0;
> > > > -
> > > > -	if (!usersize)
> > > > -		s = __kmem_cache_alias(name, size, align, flags, ctor);
> > > > +	    WARN_ON(!args->usersize && args->useroffset) ||
> > > > +	    WARN_ON(object_size < args->usersize ||
> > > > +		    object_size - args->usersize < args->useroffset))
> > > > +		args->usersize = args->useroffset = 0;
> > > > +
> > > > +	if (!args->usersize)
> > > > +		s = __kmem_cache_alias(name, object_size, args->align, flags,
> > > > +				       args->ctor);
> > > 
> > > Sorry I missed it in the previous review, but nothing guaranties that
> > > nobody will call kmem_cache_create_args with args != NULL.
> > > 
> > > I think there should be a check for args != NULL and a substitution of args
> > > with defaults if it actually was NULL.
> > 
> > I think that callers that pass NULL should all be switched to
> > KMEM_CACHE() and passing NULL should simply not be supported. And the
> > few callers that need some very special alignment need to pass struct
> > kmem_cache_args anyway. So there should never be a need to pass NULL.
> 
> But you can't guarantee that some random driver won't call
> 
> 	__kmem_cache_create_args("name", size, NULL, flags);
> 
> At least we'd need
> 	
> 	if (!args)
> 		return -EINVAL;

Calling __kmem_cache_create_args() directly is a bug. That's why it's __*().
And we don't check for non-NULL @name either. In fact we almost never do
such checks.

Plus, if someone did:

kmem_cache_create("foo", sizeof(foo), NULL, flags);

they'd get a compile time error due to _Generic().

