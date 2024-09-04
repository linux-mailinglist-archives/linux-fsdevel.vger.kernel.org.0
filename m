Return-Path: <linux-fsdevel+bounces-28587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C796C3E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5457C1F22E7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B471DEFD8;
	Wed,  4 Sep 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr0W+cR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5901DA635
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466734; cv=none; b=ifPTgUhxdlswf9wV+D53EcblMqXuuRbiOtunrHQfXLGm68PqaTt3OCG4iW6zKt0hm3znxLtnBjnzvq4p2yrqdyICCTmJONwcdt3JAvTKtzplmYqiTlh006DHFy/C/WZKARpuQVIGif2+bzMDCQnOONe8uD1XW/6SmB1sbfsvo10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466734; c=relaxed/simple;
	bh=tesxBCfwTg/kuycru8Mg8u33/AsWOez2Oe+2bc/mUpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrfBTc02xEdYY0WS990uYpr2A6WORlKmiNqluUTRTe8nKhx6Haj31szOy8NTmC1iZMmaibzHJxtLIQJ218PX/e4vwdyI7hhIJW+v8Dvu4jN4k7IiausInqIth2Pfi+vG4TW8m+DvTrCPMOZpRud9xCpJ3AgdNm9E6hfOX5GrpZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr0W+cR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3286C4CEC2;
	Wed,  4 Sep 2024 16:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466734;
	bh=tesxBCfwTg/kuycru8Mg8u33/AsWOez2Oe+2bc/mUpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jr0W+cR8hIUdNwmqShiz1t9o+WnBH+SKdPQBjMZobL8IaSZmfyg16ByWaUSNmn3az
	 eQ2V7PjXigS7rWNXM3TDxuIM4nNMT1Z2K2AGImWSjnP3HEVpjQTCUWLaBsaMu0bDJH
	 SWKOTJFC1Ha7BQo4fOCsrVooZL3wUiTkI10L69koN8q7dRUG5PX4Yzd6NvQeAW89sE
	 4lM6KUoGKB2xgkW6DQ/VR1jLlqh5oQJDz/gz09dcshIHHIqdP6nqK06BaAmW4bSl1I
	 GPqCiXVnPV7eKuWETTIHoJN2sSvh86xKDJt3Oq7aLImNtI2gyXcCjU0p76x1qBv+HB
	 rquw64gZAScWQ==
Date: Wed, 4 Sep 2024 19:16:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
Message-ID: <ZtiHxywbBG38cciA@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
 <Zth5wHtDkX78gl1l@kernel.org>
 <20240904-bauaufsicht-gewohnheit-a70bd9266986@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-bauaufsicht-gewohnheit-a70bd9266986@brauner>

On Wed, Sep 04, 2024 at 05:48:31PM +0200, Christian Brauner wrote:
> On Wed, Sep 04, 2024 at 06:16:16PM GMT, Mike Rapoport wrote:
> > On Tue, Sep 03, 2024 at 04:20:43PM +0200, Christian Brauner wrote:
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  include/linux/slab.h | 21 ++++++++++++++++
> > >  mm/slab_common.c     | 67 +++++++++++++++++++++++++++++++++++++++-------------
> > >  2 files changed, 72 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > index 5b2da2cf31a8..79d8c8bca4a4 100644
> > > --- a/include/linux/slab.h
> > > +++ b/include/linux/slab.h
> > > @@ -240,6 +240,27 @@ struct mem_cgroup;
> > >   */
> > >  bool slab_is_available(void);
> > >  
> > > +/**
> > > + * @align: The required alignment for the objects.
> > > + * @useroffset: Usercopy region offset
> > > + * @usersize: Usercopy region size
> > > + * @freeptr_offset: Custom offset for the free pointer in RCU caches
> > > + * @use_freeptr_offset: Whether a @freeptr_offset is used
> > > + * @ctor: A constructor for the objects.
> > > + */
> > > +struct kmem_cache_args {
> > > +	unsigned int align;
> > > +	unsigned int useroffset;
> > > +	unsigned int usersize;
> > > +	unsigned int freeptr_offset;
> > > +	bool use_freeptr_offset;
> > > +	void (*ctor)(void *);
> > > +};
> > > +
> > > +struct kmem_cache *__kmem_cache_create_args(const char *name,
> > > +					    unsigned int object_size,
> > > +					    struct kmem_cache_args *args,
> > > +					    slab_flags_t flags);
> > >  struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
> > >  			unsigned int align, slab_flags_t flags,
> > >  			void (*ctor)(void *));
> > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > index 91e0e36e4379..0f13c045b8d1 100644
> > > --- a/mm/slab_common.c
> > > +++ b/mm/slab_common.c
> > > @@ -248,14 +248,24 @@ static struct kmem_cache *create_cache(const char *name,
> > >  	return ERR_PTR(err);
> > >  }
> > >  
> > > -static struct kmem_cache *
> > > -do_kmem_cache_create_usercopy(const char *name,
> > > -		  unsigned int size, unsigned int freeptr_offset,
> > > -		  unsigned int align, slab_flags_t flags,
> > > -		  unsigned int useroffset, unsigned int usersize,
> > > -		  void (*ctor)(void *))
> > > +/**
> > > + * __kmem_cache_create_args - Create a kmem cache
> > > + * @name: A string which is used in /proc/slabinfo to identify this cache.
> > > + * @object_size: The size of objects to be created in this cache.
> > > + * @args: Arguments for the cache creation (see struct kmem_cache_args).
> > > + * @flags: See %SLAB_* flags for an explanation of individual @flags.
> > > + *
> > > + * Cannot be called within a interrupt, but can be interrupted.
> > > + *
> > > + * Return: a pointer to the cache on success, NULL on failure.
> > > + */
> > > +struct kmem_cache *__kmem_cache_create_args(const char *name,
> > > +					    unsigned int object_size,
> > > +					    struct kmem_cache_args *args,
> > > +					    slab_flags_t flags)
> > >  {
> > >  	struct kmem_cache *s = NULL;
> > > +	unsigned int freeptr_offset = UINT_MAX;
> > >  	const char *cache_name;
> > >  	int err;
> > >  
> > > @@ -275,7 +285,7 @@ do_kmem_cache_create_usercopy(const char *name,
> > >  
> > >  	mutex_lock(&slab_mutex);
> > >  
> > > -	err = kmem_cache_sanity_check(name, size);
> > > +	err = kmem_cache_sanity_check(name, object_size);
> > >  	if (err) {
> > >  		goto out_unlock;
> > >  	}
> > > @@ -296,12 +306,14 @@ do_kmem_cache_create_usercopy(const char *name,
> > >  
> > >  	/* Fail closed on bad usersize of useroffset values. */
> > >  	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
> > > -	    WARN_ON(!usersize && useroffset) ||
> > > -	    WARN_ON(size < usersize || size - usersize < useroffset))
> > > -		usersize = useroffset = 0;
> > > -
> > > -	if (!usersize)
> > > -		s = __kmem_cache_alias(name, size, align, flags, ctor);
> > > +	    WARN_ON(!args->usersize && args->useroffset) ||
> > > +	    WARN_ON(object_size < args->usersize ||
> > > +		    object_size - args->usersize < args->useroffset))
> > > +		args->usersize = args->useroffset = 0;
> > > +
> > > +	if (!args->usersize)
> > > +		s = __kmem_cache_alias(name, object_size, args->align, flags,
> > > +				       args->ctor);
> > 
> > Sorry I missed it in the previous review, but nothing guaranties that
> > nobody will call kmem_cache_create_args with args != NULL.
> > 
> > I think there should be a check for args != NULL and a substitution of args
> > with defaults if it actually was NULL.
> 
> I think that callers that pass NULL should all be switched to
> KMEM_CACHE() and passing NULL should simply not be supported. And the
> few callers that need some very special alignment need to pass struct
> kmem_cache_args anyway. So there should never be a need to pass NULL.

But you can't guarantee that some random driver won't call

	__kmem_cache_create_args("name", size, NULL, flags);

At least we'd need
	
	if (!args)
		return -EINVAL;

-- 
Sincerely yours,
Mike.

