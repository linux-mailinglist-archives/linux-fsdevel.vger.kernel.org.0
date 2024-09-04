Return-Path: <linux-fsdevel+bounces-28564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D19B96C102
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBF31C2283F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CDA1DB55A;
	Wed,  4 Sep 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwAqlyvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C963D
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461048; cv=none; b=Pj9LZFq6lL7p3zszpkQ/k2cK02q1kxv+ZVJoPYfe3MTejXEVmz+vlygTJUXkF0loMRhU1HUfNgQM16f4/3rioCkaOJlMXVBfB5x/anzvplrz5Bue4BMHj/etBI01ov97n0cS+Ofv0vQk3CyOPQp6ZVeCQm9+BzGTMULOHlfiMBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461048; c=relaxed/simple;
	bh=3h2/8kiGs8hQepiNOVw377i6agmyGFWtRxl9uQnfOXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCQrrwaIf/3GOAOxVKpuUdoLcOLl0Yt/CHM8R2Yl6YOJD3pgKgfRXPs7buV16Azv1vOOz7xoxD2ExSGgG6e4qEdG4iH7uI5ZdakdlD8wQ/r7QeVvHuo9lId33hx1IktuLslYTeGyeTf31LTp8iA2rAIYpk3yWt5Rt5KQHnV4QzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwAqlyvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC36CC4CEC2;
	Wed,  4 Sep 2024 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725461047;
	bh=3h2/8kiGs8hQepiNOVw377i6agmyGFWtRxl9uQnfOXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwAqlyvIn4eDqRM7LT+9spYpM65FWgAdjy8PXvfNTTu5OwqvCE2ADdFPDNe+0+8iP
	 Uv6rEOBKP7z3RmymOrUed2d+kiMTO47uPSu4CkJQNu1ZHVduLlFGGWwxA1GJA5RXFc
	 B2b8CyCO10IRKSrVzn84FbtfHB4obKFJvtI60ywgO1T4xcOWDax7UvJgUpV3dl2mI2
	 UaBx0YsdoKUWRqshw5x+Ox7iqHVZgaeuNO7pXgdZkSclHc6BYI368j48ajRPET56a0
	 YTyI/7pyWz3xJ1iGzHSbSsEY2uMICWexSJGfny4HR75qMPe2nEcu+sOrCLlB3pbP27
	 qPBfmNlm/sHPg==
Date: Wed, 4 Sep 2024 16:44:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] slab: create kmem_cache_create() compatibility
 layer
Message-ID: <20240904-gegessen-kalziumreich-2817b07433b7@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-12-76f97e9a4560@kernel.org>
 <ZtfssAqDeyd_-4MJ@kernel.org>
 <20240904-storch-worin-32db25e60f32@brauner>
 <23eb55c3-0a8c-404b-b787-9f21c2739c4e@suse.cz>
 <20240904-absuchen-gockel-8246820867b4@brauner>
 <24717bab-7d5d-4ed1-a17d-65d4676e22a9@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24717bab-7d5d-4ed1-a17d-65d4676e22a9@suse.cz>

On Wed, Sep 04, 2024 at 03:33:30PM GMT, Vlastimil Babka wrote:
> On 9/4/24 13:38, Christian Brauner wrote:
> > On Wed, Sep 04, 2024 at 12:50:28PM GMT, Vlastimil Babka wrote:
> >> On 9/4/24 11:45, Christian Brauner wrote:
> >> > On Wed, Sep 04, 2024 at 08:14:24AM GMT, Mike Rapoport wrote:
> >> >> On Tue, Sep 03, 2024 at 04:20:53PM +0200, Christian Brauner wrote:
> >> >> > Use _Generic() to create a compatibility layer that type switches on the
> >> >> > third argument to either call __kmem_cache_create() or
> >> >> > __kmem_cache_create_args(). This can be kept in place until all callers
> >> >> > have been ported to struct kmem_cache_args.
> >> >> > 
> >> >> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> >> >> 
> >> >> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >> >> 
> >> >> > ---
> >> >> >  include/linux/slab.h | 13 ++++++++++---
> >> >> >  mm/slab_common.c     | 10 +++++-----
> >> >> >  2 files changed, 15 insertions(+), 8 deletions(-)
> >> >> > 
> >> >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> >> > index aced16a08700..4292d67094c3 100644
> >> >> > --- a/include/linux/slab.h
> >> >> > +++ b/include/linux/slab.h
> >> >> > @@ -261,9 +261,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
> >> >> >  					    unsigned int object_size,
> >> >> >  					    struct kmem_cache_args *args,
> >> >> >  					    slab_flags_t flags);
> >> >> > -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
> >> >> > -			unsigned int align, slab_flags_t flags,
> >> >> > -			void (*ctor)(void *));
> >> >> > +
> >> >> > +struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> >> >> > +				       unsigned int align, slab_flags_t flags,
> >> >> > +				       void (*ctor)(void *));
> >> >> 
> >> >> As I said earlier, this can become _kmem_cache_create and
> >> >> __kmem_cache_create_args can be __kmem_cache_create from the beginning.
> >> 
> >> I didn't notice an answer to this suggestion? Even if it's just that you
> >> don't think it's worth the rewrite, or it's not possible because X Y Z.
> >> Thanks.
> > 
> > I'm confused. I sent two patches as a reply to the thread plus the
> > answer below and there's two patches in v3 that you can use or drop.
> 
> Right, that's the part below. But the suggestion above, and also in Mike's
> reply to 02/12 was AFAICS to rename __kmem_cache_create_args to
> __kmem_cache_create (since patch 02) and here __kmem_cache_create to
> _kmem_cache_create. It just seemed odd to see no reaction to that (did I
> miss or not receive it?).

Oh, I see. I read it as a expressing taste and so I didn't bother
replying. And I really dislike single underscore function names so I
would like to avoid it and it also seems more confusing to me.

