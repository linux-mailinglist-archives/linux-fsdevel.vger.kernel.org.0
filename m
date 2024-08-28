Return-Path: <linux-fsdevel+bounces-27533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B499623DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC8B285E78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC9E166F14;
	Wed, 28 Aug 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6pFQw9F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2EC15D5CF
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838440; cv=none; b=o5MEvkT5aeZ3+cbMip7CKjugKlLtkcie6mhes/p6zv4ACguVp4ohhXfMqdeMQJ2nf4I776K9Y6BSyP0uQ14XV9JtMy/x0Ml2ykN02P8rflM4UM+HW/pX2QYR6DX47sOMLQWGEzZup1v8eKk11oOAxZf9Q+43HasOr8P+nPmaxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838440; c=relaxed/simple;
	bh=8e9pG6U+yU2XijdDDN5D22TTXrNVdvVl3m3ZxA2sVss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMFkIApfDVImcX9sPtYvKiGaAw8dZZsSJ/JHvhl8skhxDWN2EZVeK0TZcKK5IwecwJw5XCFe6vdNwONT43/Y743jjN9YGF82HWI0JTkk2g9QnLYU4MzydibU6m1VFB3cQLeM7AfrG/ZPeJXcUAzCv6k10EIBl9k3sg5EwP1Qvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6pFQw9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BC5C8DC25;
	Wed, 28 Aug 2024 09:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724838440;
	bh=8e9pG6U+yU2XijdDDN5D22TTXrNVdvVl3m3ZxA2sVss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6pFQw9FF3b1cP9Y8OcFlf4gPzS/9ZSEV3uJ+vrpzWSQLgrtJCOQo3Y70m3i27vOR
	 b2Ese0kc8iwIDhCcoWkW9V63GNlMWS9OiLJHbqRkCzDEMklkw2uMT+pwhwD9Omxk2S
	 aQe1QPXooXeCyNF6roqh5wciXUbOnQkWVxC6tWsCmOtIzZmwi5QCo2qfhlPznOtqgt
	 KCkBgGB6DnWnik4gKxGNJEBHDLHF8YTcJjvMpl7UqKq5Vko6nSKhiLnuPOp+G2xKIz
	 V739bTsye85ZOLFr+F2YsrozBPPMCmF+PPYX2hjMQ6b4gq9Iww5u2oY/SJyMBLIeUG
	 brUK0OhKGtsgA==
Date: Wed, 28 Aug 2024 11:47:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm: add kmem_cache_create_rcu()
Message-ID: <20240828-blicken-zeiteinheit-bbbe9724f1ea@brauner>
References: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>
 <20240827-work-kmem_cache-rcu-v2-2-7bc9c90d5eef@kernel.org>
 <ee495744-bb34-4467-8838-3cec016fda0d@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee495744-bb34-4467-8838-3cec016fda0d@suse.cz>

On Tue, Aug 27, 2024 at 11:10:10PM GMT, Vlastimil Babka wrote:
> On 8/27/24 17:59, Christian Brauner wrote:
> > When a kmem cache is created with SLAB_TYPESAFE_BY_RCU the free pointer
> > must be located outside of the object because we don't know what part of
> > the memory can safely be overwritten as it may be needed to prevent
> > object recycling.
> > 
> > That has the consequence that SLAB_TYPESAFE_BY_RCU may end up adding a
> > new cacheline. This is the case for .e.g, struct file. After having it
> > shrunk down by 40 bytes and having it fit in three cachelines we still
> > have SLAB_TYPESAFE_BY_RCU adding a fourth cacheline because it needs to
> > accomodate the free pointer and is hardware cacheline aligned.
> > 
> > I tried to find ways to rectify this as struct file is pretty much
> > everywhere and having it use less memory is a good thing. So here's a
> > proposal.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> So logistically patch 3 needs stuff in the vfs tree and having 1+2 in slab
> tree and 3 in vfs that depends on 1+2 elsewhere is infeasible, so it will be
> easiest for whole series to be in vfs, right?

Yeah, that's fine by me.

> 
> > ---
> >  include/linux/slab.h |   9 ++++
> >  mm/slab.h            |   1 +
> >  mm/slab_common.c     | 133 ++++++++++++++++++++++++++++++++++++---------------
> >  mm/slub.c            |  17 ++++---
> >  4 files changed, 114 insertions(+), 46 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index eb2bf4629157..5b2da2cf31a8 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -212,6 +212,12 @@ enum _slab_flag_bits {
> >  #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
> >  #endif
> >  
> > +/*
> > + * freeptr_t represents a SLUB freelist pointer, which might be encoded
> > + * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
> > + */
> > +typedef struct { unsigned long v; } freeptr_t;
> > +
> >  /*
> >   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
> >   *
> > @@ -242,6 +248,9 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
> >  			slab_flags_t flags,
> >  			unsigned int useroffset, unsigned int usersize,
> >  			void (*ctor)(void *));
> > +struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
> > +					 unsigned int freeptr_offset,
> > +					 slab_flags_t flags);
> >  void kmem_cache_destroy(struct kmem_cache *s);
> >  int kmem_cache_shrink(struct kmem_cache *s);
> >  
> > diff --git a/mm/slab.h b/mm/slab.h
> > index dcdb56b8e7f5..b05512a14f07 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -261,6 +261,7 @@ struct kmem_cache {
> >  	unsigned int object_size;	/* Object size without metadata */
> >  	struct reciprocal_value reciprocal_size;
> >  	unsigned int offset;		/* Free pointer offset */
> > +	unsigned int rcu_freeptr_offset; /* Specific free pointer requested */
> 
> More precisely something like:
> 
> 				  Specific offset requested (if not
> 				  UINT_MAX)

Yep, added that.

> 
> ?
> 
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> >  	/* Number of per cpu partial objects to keep around */
> >  	unsigned int cpu_partial;
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index c8dd7e08c5f6..c4beff642fff 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -202,9 +202,10 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
> >  }
> >  
> >  static struct kmem_cache *create_cache(const char *name,
> > -		unsigned int object_size, unsigned int align,
> > -		slab_flags_t flags, unsigned int useroffset,
> > -		unsigned int usersize, void (*ctor)(void *))
> > +		unsigned int object_size, unsigned int freeptr_offset,
> > +		unsigned int align, slab_flags_t flags,
> > +		unsigned int useroffset, unsigned int usersize,
> > +		void (*ctor)(void *))
> >  {
> >  	struct kmem_cache *s;
> >  	int err;
> > @@ -212,6 +213,12 @@ static struct kmem_cache *create_cache(const char *name,
> >  	if (WARN_ON(useroffset + usersize > object_size))
> >  		useroffset = usersize = 0;
> >  
> > +	err = -EINVAL;
> > +	if (freeptr_offset < UINT_MAX &&
> 
> freeptr_offset != UINT_MAX to be more obvious and match has_freeptr_offset() ?

Done.

> 
> > +	    (freeptr_offset >= object_size ||
> > +	     (freeptr_offset && !(flags & SLAB_TYPESAFE_BY_RCU))))
> 
> and here drop the "freeptr_offset &&" as zero is a valid value

Yes, thank you.

> 
> instead we could want alignment to sizeof(freeptr_t) if we were paranoid?

Added a check for that.

> 
> > +		goto out;
> 
> The rest seems good to me now.

Thanks for the review! v3 incoming

