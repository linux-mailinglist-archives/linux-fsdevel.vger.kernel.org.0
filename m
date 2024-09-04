Return-Path: <linux-fsdevel+bounces-28542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBD096BAF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 13:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBE41C208B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F81D0152;
	Wed,  4 Sep 2024 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEXC1Eiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980A1CF5F6
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449942; cv=none; b=MsgZiS22I7khyN7TSV9Tepn4q1ziqUBEbefGYE0LUTskkmQacSWrqleKyU+LqqBHUVb96w8l24485tuvbyogPYLlvsYywtyACvy2InhNGJ1bPUNnSuJ2de6s/21IEJ1kmDWkXnlrex6QZiSaYJabfarP22O+6ZURB5ZopB/kkRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449942; c=relaxed/simple;
	bh=+w0xFoTV0Lh4uapfvz5wp1iY4crS8ZjQkBVqDb/Sj5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvzJaliIuv7NEMQecPZKZjpIHmfrCnaWKjIVUTNOJk5XaMABlBwmlVId51/zbXXMZZusRd0iCscgiKcSQNEWxr15/d7DcwypmURxKhgJF7RAezp+aaTSCyQ4l+p91gyY2n03Qu3H8kwQ+Js4d17aeWGyPBJ36z40AHlDSBO/vqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEXC1Eiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39423C4CEC2;
	Wed,  4 Sep 2024 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725449942;
	bh=+w0xFoTV0Lh4uapfvz5wp1iY4crS8ZjQkBVqDb/Sj5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEXC1Eiv8SQnU2Vu7kYshplTkF4FdzhAl+YEhVvcaqm1UqSYNNn8VwmBBjvDCAUZF
	 coVR0WmfSKTc9SDCfNtlDghkwaEGrlbDJ03DpMj8C+X3vXkoPG5bO8TeaA9ArYlpfM
	 /UxiPQ9732dLzjoJTA+g1FRePlw22E/TxKCjqj7EsFylUXmcX5FnbE/Gktnw+8tSeA
	 EGq6EjLBqK0PjAJMw3MBJI97WnDshAojp5cV4EBcS2OrwMre6KXx8oRcIvEQL4LEf2
	 XNkLzwBg6HgTGjIchWJhXP3VkrM95VGHXEN+kuySXEhqqFTa0h4pyXGCeQibei0D3N
	 Sz/XfJi95VW1A==
Date: Wed, 4 Sep 2024 13:38:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] slab: create kmem_cache_create() compatibility
 layer
Message-ID: <20240904-absuchen-gockel-8246820867b4@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-12-76f97e9a4560@kernel.org>
 <ZtfssAqDeyd_-4MJ@kernel.org>
 <20240904-storch-worin-32db25e60f32@brauner>
 <23eb55c3-0a8c-404b-b787-9f21c2739c4e@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23eb55c3-0a8c-404b-b787-9f21c2739c4e@suse.cz>

On Wed, Sep 04, 2024 at 12:50:28PM GMT, Vlastimil Babka wrote:
> On 9/4/24 11:45, Christian Brauner wrote:
> > On Wed, Sep 04, 2024 at 08:14:24AM GMT, Mike Rapoport wrote:
> >> On Tue, Sep 03, 2024 at 04:20:53PM +0200, Christian Brauner wrote:
> >> > Use _Generic() to create a compatibility layer that type switches on the
> >> > third argument to either call __kmem_cache_create() or
> >> > __kmem_cache_create_args(). This can be kept in place until all callers
> >> > have been ported to struct kmem_cache_args.
> >> > 
> >> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> >> 
> >> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >> 
> >> > ---
> >> >  include/linux/slab.h | 13 ++++++++++---
> >> >  mm/slab_common.c     | 10 +++++-----
> >> >  2 files changed, 15 insertions(+), 8 deletions(-)
> >> > 
> >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> > index aced16a08700..4292d67094c3 100644
> >> > --- a/include/linux/slab.h
> >> > +++ b/include/linux/slab.h
> >> > @@ -261,9 +261,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
> >> >  					    unsigned int object_size,
> >> >  					    struct kmem_cache_args *args,
> >> >  					    slab_flags_t flags);
> >> > -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
> >> > -			unsigned int align, slab_flags_t flags,
> >> > -			void (*ctor)(void *));
> >> > +
> >> > +struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> >> > +				       unsigned int align, slab_flags_t flags,
> >> > +				       void (*ctor)(void *));
> >> 
> >> As I said earlier, this can become _kmem_cache_create and
> >> __kmem_cache_create_args can be __kmem_cache_create from the beginning.
> 
> I didn't notice an answer to this suggestion? Even if it's just that you
> don't think it's worth the rewrite, or it's not possible because X Y Z.
> Thanks.

I'm confused. I sent two patches as a reply to the thread plus the
answer below and there's two patches in v3 that you can use or drop.

> 
> >> And as a followup cleanup both kmem_cache_create_usercopy() and
> >> kmem_cache_create() can be made static inlines.
> > 
> > Seems an ok suggestion to me. See the two patches I sent out now.
> 

