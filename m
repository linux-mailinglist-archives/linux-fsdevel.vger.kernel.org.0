Return-Path: <linux-fsdevel+bounces-28510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C406B96B75E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7041FB2A5B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8E41CEE8B;
	Wed,  4 Sep 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qn21v1/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5E19B3C3
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443128; cv=none; b=ufnk74KAozWUKccYerlFxtvqFGWSgAb/oWhNLWfhtuileovAFRbqIifPFF0//6ZfLZ6eMhG9n9BC+Zcr6erBi91kMIbDUQ0/dsHVDPSW/ov5FAa8N7fiwP6h1yJiphnGLqA20SNvpxpjr07LsVbDduciE4AenfhTaaHvlHpI7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443128; c=relaxed/simple;
	bh=sE3L7k91QpI1rNM6w5JFxo/0WUtl8HANuErXC/gqVEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD593zJIFgMds2V+gQnWuXxcqoVY9wFiJF94lE2crRuHaGW/Yolhk9QkrFXDlPYK187nrp3tOq1/DkMOocS7Dx9PZ+NQo/ErEgESFRhYk416uqeagbsbN3FLuh07wBUNnNwXhiNihq2ZHcOBNyKigBngDMWie1HGoVSrr6ZYoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qn21v1/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73FEC4CEC2;
	Wed,  4 Sep 2024 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725443126;
	bh=sE3L7k91QpI1rNM6w5JFxo/0WUtl8HANuErXC/gqVEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qn21v1/5/Upjnc5tjWJTf1AL81Yumo5b4zIkQPcU7pH0aAoz2Vq589P4YLNTjtl0m
	 2Kqge+S+4rJl0xWDiyRuYUHZU/OosXZ+29HBmqsVaK5EEOf71v4MPeqCG/CKNgED4p
	 dynLPzCKrq6CJsLlkAVha8JZV2Ik1y7U/+dLKf+Pevxed/WvzO9nbbCcAPtu1455w8
	 hh/BTcb4sVZaRTMLEsvZ+xXSlhIkj8hmIWT5baiebkiksGjhL3qJcNLuCG2SSyZjos
	 mXbSb4sTWoZAlMjh9MAv3ShsJwd5oEHOpFWyDpj6uEKeqGDEezn1H4svIV1heXMuYg
	 fUN6rS9SmQrUA==
Date: Wed, 4 Sep 2024 11:45:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] slab: create kmem_cache_create() compatibility
 layer
Message-ID: <20240904-storch-worin-32db25e60f32@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-12-76f97e9a4560@kernel.org>
 <ZtfssAqDeyd_-4MJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtfssAqDeyd_-4MJ@kernel.org>

On Wed, Sep 04, 2024 at 08:14:24AM GMT, Mike Rapoport wrote:
> On Tue, Sep 03, 2024 at 04:20:53PM +0200, Christian Brauner wrote:
> > Use _Generic() to create a compatibility layer that type switches on the
> > third argument to either call __kmem_cache_create() or
> > __kmem_cache_create_args(). This can be kept in place until all callers
> > have been ported to struct kmem_cache_args.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> > ---
> >  include/linux/slab.h | 13 ++++++++++---
> >  mm/slab_common.c     | 10 +++++-----
> >  2 files changed, 15 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index aced16a08700..4292d67094c3 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -261,9 +261,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
> >  					    unsigned int object_size,
> >  					    struct kmem_cache_args *args,
> >  					    slab_flags_t flags);
> > -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
> > -			unsigned int align, slab_flags_t flags,
> > -			void (*ctor)(void *));
> > +
> > +struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
> > +				       unsigned int align, slab_flags_t flags,
> > +				       void (*ctor)(void *));
> 
> As I said earlier, this can become _kmem_cache_create and
> __kmem_cache_create_args can be __kmem_cache_create from the beginning.
> 
> And as a followup cleanup both kmem_cache_create_usercopy() and
> kmem_cache_create() can be made static inlines.

Seems an ok suggestion to me. See the two patches I sent out now.

