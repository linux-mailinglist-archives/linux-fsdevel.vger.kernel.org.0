Return-Path: <linux-fsdevel+bounces-28568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7170196C1EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9C81C2307A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06F1DCB10;
	Wed,  4 Sep 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtFNBJ9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB81DA61A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462838; cv=none; b=kypfuXvNqSZo9sEIo5DmtWGImwQ9RACIxv6fHSj36gDZEG2htbeDVkD8gGIjk89A4gVsqjt54Ty1VxH3WBesCAHu+dYv6c/k+oP5rAOsrZddIdlP8cLcqKHO49MbZPsefX1SevzZcULFTpZ08cTtrKML98vdoW7H4za43bEyyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462838; c=relaxed/simple;
	bh=rX0vS1zR5X7dTFyMgPdiMHFhqaGeKMhYHOljR2dXDA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpsLn9H6vKUQR6uERZdUvceohGO4h5sqedQMR6HuorLg9CJTAwX94PPntw40Bp2m/D/vbOb0wyQEOGp/R5qH/bogExlLQsavR2DUWIPdiYMqcDTaJhzwtwIj8epv1LBXm8068eqYYQt7K4b9mE2AqfI33O/neTgUQnm6Du+ir5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtFNBJ9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D51C4CEC2;
	Wed,  4 Sep 2024 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725462838;
	bh=rX0vS1zR5X7dTFyMgPdiMHFhqaGeKMhYHOljR2dXDA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtFNBJ9AwQe6ozrVAAu6Gv0mBSh1UeN347L+FByBeT7DFYXbXBgkLXQ2xq3ZKRLva
	 xlPbWd2Mj+tVnhN+kDGr0UvIVT1qzALnKCTOxNh357NVg6NFVBAfSk7zgBSFbeS0Ne
	 IS49rNakaIyhirV4GyV/LJ24E9E1IJZJOUCWeR750RY8sLR9t9dE8aC4pKtu8pshXo
	 MjgIxwVZ5IJpvTnT77ngWCjM/ObgJ1aUj5imsR+SYllXc9MxkoIY7IHOXTlB+40zLk
	 dUCEHUUlWUyM9ptqqoYMcyReF4EIPabXIj5vXaFTKclIH+hhXGZjio2mkzJCR9m95D
	 ZzwDDJAShVnvA==
Date: Wed, 4 Sep 2024 18:11:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] slab: create kmem_cache_create() compatibility
 layer
Message-ID: <Zth4jqJQJAXdSLzE@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-12-76f97e9a4560@kernel.org>
 <ZtfssAqDeyd_-4MJ@kernel.org>
 <20240904-storch-worin-32db25e60f32@brauner>
 <23eb55c3-0a8c-404b-b787-9f21c2739c4e@suse.cz>
 <20240904-absuchen-gockel-8246820867b4@brauner>
 <24717bab-7d5d-4ed1-a17d-65d4676e22a9@suse.cz>
 <20240904-gegessen-kalziumreich-2817b07433b7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-gegessen-kalziumreich-2817b07433b7@brauner>

On Wed, Sep 04, 2024 at 04:44:03PM +0200, Christian Brauner wrote:
> On Wed, Sep 04, 2024 at 03:33:30PM GMT, Vlastimil Babka wrote:
> > On 9/4/24 13:38, Christian Brauner wrote:
> > > On Wed, Sep 04, 2024 at 12:50:28PM GMT, Vlastimil Babka wrote:
> > >> On 9/4/24 11:45, Christian Brauner wrote:
> > >> > On Wed, Sep 04, 2024 at 08:14:24AM GMT, Mike Rapoport wrote:
> > >> >> On Tue, Sep 03, 2024 at 04:20:53PM +0200, Christian Brauner wrote:
> > >> >> > Use _Generic() to create a compatibility layer that type switches on the
> > >> >> > third argument to either call __kmem_cache_create() or
> > >> >> > __kmem_cache_create_args(). This can be kept in place until all callers
> > >> >> > have been ported to struct kmem_cache_args.
> > >> >> > 
> > >> >> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > >> >> 
> > >> >> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > >> >> 
> > >> >> > ---
> > >> >> >  include/linux/slab.h | 13 ++++++++++---
> > >> >> >  mm/slab_common.c     | 10 +++++-----
> > >> >> >  2 files changed, 15 insertions(+), 8 deletions(-)
> > >> >> > 
> > >> >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > >> >> > index aced16a08700..4292d67094c3 100644
> > >> >> > --- a/include/linux/slab.h
> > >> >> > +++ b/include/linux/slab.h
> > >> >> > @@ -261,9 +261,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
> > >> >> >  					    unsigned int object_size,
> > >> >> >  					    struct kmem_cache_args *args,
> > >> >> >  					    slab_flags_t flags);
> > >> >> > -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
> > >> >> > -			unsigned int align, slab_flags_t flags,
> > >> >> > -			void (*ctor)(void *));
> > >> >> > +
> > >> >> > +struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> > >> >> > +				       unsigned int align, slab_flags_t flags,
> > >> >> > +				       void (*ctor)(void *));
> > >> >> 
> > >> >> As I said earlier, this can become _kmem_cache_create and
> > >> >> __kmem_cache_create_args can be __kmem_cache_create from the beginning.
> > >> 
> > >> I didn't notice an answer to this suggestion? Even if it's just that you
> > >> don't think it's worth the rewrite, or it's not possible because X Y Z.
> > >> Thanks.
> > > 
> > > I'm confused. I sent two patches as a reply to the thread plus the
> > > answer below and there's two patches in v3 that you can use or drop.
> > 
> > Right, that's the part below. But the suggestion above, and also in Mike's
> > reply to 02/12 was AFAICS to rename __kmem_cache_create_args to
> > __kmem_cache_create (since patch 02) and here __kmem_cache_create to
> > _kmem_cache_create. It just seemed odd to see no reaction to that (did I
> > miss or not receive it?).
> 
> Oh, I see. I read it as a expressing taste and so I didn't bother
> replying. And I really dislike single underscore function names so I
> would like to avoid it and it also seems more confusing to me.

Heh, not quite. I don't like kmem_cache_create_args essentially becoming a
replacement for kmem_cache_create* and I'd prefer __kmem_cache_create
naming.

As for the single underscore, I don't have strong feelings about it, but I
do think that it should be renamed to something else than
__kmem_cache_create to leave __kmem_cache_create for the core function.

-- 
Sincerely yours,
Mike.

