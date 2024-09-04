Return-Path: <linux-fsdevel+bounces-28574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0A196C2A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FFA28398A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9D71DEFED;
	Wed,  4 Sep 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuHeDTM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CA1DEFE5
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464293; cv=none; b=UPB2eskQr2Czv1dlJQcDZ4xSUbpj9C4nQyBkgM2jF+GzY528rFRPftUs5c4cRFxrQqLHrGZIgMCEKRVXTJHms5adbR5zs+mBoOLnkSeKX3zHssP70knk0WNsc1kJVMb+JD3+WePtp8USLIEPisYvJP436jNhnsVX4fRkObWbqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464293; c=relaxed/simple;
	bh=ZfETaz0B7LpTRKh6FFeIC4dGBSh3vZF5GwyRz7DMWRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQloUbkD43ytcpaS1c4amKLUtCQXSKE5H6Uw1mhnjAGmFAy/cReDubPs5oUjB56itIpfr1YyD8fPqImLDsfd8izaNz97+rO2VWxDlUwbScldAq0ugdP5xoqt6OL5RUcCv+cN78jMolV/Hn56Mvk9DiPT3YqHILPNUTDDU7MERDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuHeDTM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC531C4CEC2;
	Wed,  4 Sep 2024 15:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725464292;
	bh=ZfETaz0B7LpTRKh6FFeIC4dGBSh3vZF5GwyRz7DMWRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuHeDTM05btjoP8pFurCaeX1oVCeyJ9ptCWfhdduyvLn6BlIRYhgEjHVLsEF2sgiT
	 7jZrMDJoiSA16ed6Tc+OPnb3G46fLteMBRPkoWQj/XDhjhhiglgwf04pPfvKv742xE
	 M9BkU/OMUICIIYcBZZyMipSyU/2E2xB/xEtYcicD5uT72SqbOKWHdW74l2nZUj9vKx
	 Z4oEsH0Tot/qjPma8+bOMtUaIWehNEawAQVrWQflbbPE7A9DjDgOPgu+MJ4mDsS7mt
	 wikB5MaVc9SQqoSuIfgInozphr83S+5R2FG5T0HF48kpL0Y+Z/acF1fSpp4wumnNQT
	 dGhllyWdiFyTQ==
Date: Wed, 4 Sep 2024 17:38:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] slab: create kmem_cache_create() compatibility
 layer
Message-ID: <20240904-seide-witzfigur-c35c62726d93@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-12-76f97e9a4560@kernel.org>
 <ZtfssAqDeyd_-4MJ@kernel.org>
 <20240904-storch-worin-32db25e60f32@brauner>
 <23eb55c3-0a8c-404b-b787-9f21c2739c4e@suse.cz>
 <20240904-absuchen-gockel-8246820867b4@brauner>
 <24717bab-7d5d-4ed1-a17d-65d4676e22a9@suse.cz>
 <20240904-gegessen-kalziumreich-2817b07433b7@brauner>
 <Zth4jqJQJAXdSLzE@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zth4jqJQJAXdSLzE@kernel.org>

On Wed, Sep 04, 2024 at 06:11:10PM GMT, Mike Rapoport wrote:
> On Wed, Sep 04, 2024 at 04:44:03PM +0200, Christian Brauner wrote:
> > On Wed, Sep 04, 2024 at 03:33:30PM GMT, Vlastimil Babka wrote:
> > > On 9/4/24 13:38, Christian Brauner wrote:
> > > > On Wed, Sep 04, 2024 at 12:50:28PM GMT, Vlastimil Babka wrote:
> > > >> On 9/4/24 11:45, Christian Brauner wrote:
> > > >> > On Wed, Sep 04, 2024 at 08:14:24AM GMT, Mike Rapoport wrote:
> > > >> >> On Tue, Sep 03, 2024 at 04:20:53PM +0200, Christian Brauner wrote:
> > > >> >> > Use _Generic() to create a compatibility layer that type switches on the
> > > >> >> > third argument to either call __kmem_cache_create() or
> > > >> >> > __kmem_cache_create_args(). This can be kept in place until all callers
> > > >> >> > have been ported to struct kmem_cache_args.
> > > >> >> > 
> > > >> >> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > >> >> 
> > > >> >> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > >> >> 
> > > >> >> > ---
> > > >> >> >  include/linux/slab.h | 13 ++++++++++---
> > > >> >> >  mm/slab_common.c     | 10 +++++-----
> > > >> >> >  2 files changed, 15 insertions(+), 8 deletions(-)
> > > >> >> > 
> > > >> >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > >> >> > index aced16a08700..4292d67094c3 100644
> > > >> >> > --- a/include/linux/slab.h
> > > >> >> > +++ b/include/linux/slab.h
> > > >> >> > @@ -261,9 +261,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
> > > >> >> >  					    unsigned int object_size,
> > > >> >> >  					    struct kmem_cache_args *args,
> > > >> >> >  					    slab_flags_t flags);
> > > >> >> > -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
> > > >> >> > -			unsigned int align, slab_flags_t flags,
> > > >> >> > -			void (*ctor)(void *));
> > > >> >> > +
> > > >> >> > +struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> > > >> >> > +				       unsigned int align, slab_flags_t flags,
> > > >> >> > +				       void (*ctor)(void *));
> > > >> >> 
> > > >> >> As I said earlier, this can become _kmem_cache_create and
> > > >> >> __kmem_cache_create_args can be __kmem_cache_create from the beginning.
> > > >> 
> > > >> I didn't notice an answer to this suggestion? Even if it's just that you
> > > >> don't think it's worth the rewrite, or it's not possible because X Y Z.
> > > >> Thanks.
> > > > 
> > > > I'm confused. I sent two patches as a reply to the thread plus the
> > > > answer below and there's two patches in v3 that you can use or drop.
> > > 
> > > Right, that's the part below. But the suggestion above, and also in Mike's
> > > reply to 02/12 was AFAICS to rename __kmem_cache_create_args to
> > > __kmem_cache_create (since patch 02) and here __kmem_cache_create to
> > > _kmem_cache_create. It just seemed odd to see no reaction to that (did I
> > > miss or not receive it?).
> > 
> > Oh, I see. I read it as a expressing taste and so I didn't bother
> > replying. And I really dislike single underscore function names so I
> > would like to avoid it and it also seems more confusing to me.
> 
> Heh, not quite. I don't like kmem_cache_create_args essentially becoming a
> replacement for kmem_cache_create* and I'd prefer __kmem_cache_create
> naming.
> 
> As for the single underscore, I don't have strong feelings about it, but I
> do think that it should be renamed to something else than
> __kmem_cache_create to leave __kmem_cache_create for the core function.

I honestly don't care especially because it's not visible outside of the
header. If you care then a simple patch on top of the series to rename
to whatever is fine by me.

But single vs double underscore with fundamentally different parameters
seems ripe for visual confusion and the compatibility layer will go away
anyway.

