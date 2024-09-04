Return-Path: <linux-fsdevel+bounces-28613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E98E196C637
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40522B20D99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83BB1E1A04;
	Wed,  4 Sep 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1VJst9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380AB1D6790
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474078; cv=none; b=HgUzVYymOvG5BCST5ht144KwLEqiao9qd69RaC1XOWs0lHC7UEso/d0V+M53nLC5YA0BpF0+5QdqFJIuUwq2XiLx4J6Y9577JT1s40bLXgL0Z9CBY4gf++MoFkOYpydZFBLiClkOaRlJE+X+bHplXGKhsn/8pEvo2xH89BpMvJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474078; c=relaxed/simple;
	bh=V1uKUFVLNzDRxnwoyhKTpWj6r8IKWS9JkIbr4UGgtn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9J6BxNVHLtkuHdztJlMXV+EL8O+/ZQTvQXiJVlhm+A5yI6dW1JrMrT+0dLcsr4Rt0iF7cma8mE1E/kz8RuohczkOXJ7cRAFKBN1QXnbQ3BxTxDLfh4SPVpXzJS0cFcXSrmNii7ellasNE2biZDMxqiC+fHxb3bCF5Yw6IafhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1VJst9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30A6C4CEC2;
	Wed,  4 Sep 2024 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725474077;
	bh=V1uKUFVLNzDRxnwoyhKTpWj6r8IKWS9JkIbr4UGgtn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1VJst9y+dSonlwue5C7bteIVSPpGPZFpzqx/T0ieIu0KXzmEDLBFNsEpNm5EUQ7K
	 18x3CVnP+KCrnc+QAoJ+WaQ8KVxtSB+uC5XOTUSI58ZqiNJVxYJRaoXE8+KrJJInMB
	 aeSz8Dhx7592scQxnLJAdRs//vFIfX/wIrD/LEsxBBFYAbRkQwxpeYxLNW8uE9AfGo
	 /1YXSiNcV71d7ahbKQdKzr5M69qLwlPjcgmiFF88bY7IKhiOgWMTgIWdHLFuuUScoj
	 RP7Ebse2FcunwZ5dBobYFV2UBz14KbDHcayYnJ285Ux+M3/Qq2D4HwlCCuqaC7mtl9
	 fN+ku2dCTv6Aw==
Date: Wed, 4 Sep 2024 20:21:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
Message-ID: <20240904-kauffreudig-bauch-c2890b265e7e@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
 <Zth5wHtDkX78gl1l@kernel.org>
 <9303896a-e3c8-4dc3-926b-c7e8fc75cf6b@suse.cz>
 <ZtiH7UNQ7Rnftr0o@kernel.org>
 <3ade6827-701d-4b50-b9bd-96c60ba38658@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ade6827-701d-4b50-b9bd-96c60ba38658@suse.cz>

On Wed, Sep 04, 2024 at 06:22:45PM GMT, Vlastimil Babka wrote:
> On 9/4/24 18:16, Mike Rapoport wrote:
> > On Wed, Sep 04, 2024 at 05:49:15PM +0200, Vlastimil Babka wrote:
> >> On 9/4/24 17:16, Mike Rapoport wrote:
> >> > On Tue, Sep 03, 2024 at 04:20:43PM +0200, Christian Brauner wrote:
> >> >> @@ -275,7 +285,7 @@ do_kmem_cache_create_usercopy(const char *name,
> >> >>  
> >> >>  	mutex_lock(&slab_mutex);
> >> >>  
> >> >> -	err = kmem_cache_sanity_check(name, size);
> >> >> +	err = kmem_cache_sanity_check(name, object_size);
> >> >>  	if (err) {
> >> >>  		goto out_unlock;
> >> >>  	}
> >> >> @@ -296,12 +306,14 @@ do_kmem_cache_create_usercopy(const char *name,
> >> >>  
> >> >>  	/* Fail closed on bad usersize of useroffset values. */
> >> >>  	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
> >> >> -	    WARN_ON(!usersize && useroffset) ||
> >> >> -	    WARN_ON(size < usersize || size - usersize < useroffset))
> >> >> -		usersize = useroffset = 0;
> >> >> -
> >> >> -	if (!usersize)
> >> >> -		s = __kmem_cache_alias(name, size, align, flags, ctor);
> >> >> +	    WARN_ON(!args->usersize && args->useroffset) ||
> >> >> +	    WARN_ON(object_size < args->usersize ||
> >> >> +		    object_size - args->usersize < args->useroffset))
> >> >> +		args->usersize = args->useroffset = 0;
> >> >> +
> >> >> +	if (!args->usersize)
> >> >> +		s = __kmem_cache_alias(name, object_size, args->align, flags,
> >> >> +				       args->ctor);
> >> > 
> >> > Sorry I missed it in the previous review, but nothing guaranties that
> >> > nobody will call kmem_cache_create_args with args != NULL.
> >> > 
> >> > I think there should be a check for args != NULL and a substitution of args
> >> > with defaults if it actually was NULL.
> >> 
> >> Hm there might be a bigger problem with this? If we wanted to do a
> >> (non-flag-day) conversion to the new kmem_cache_create() for some callers
> >> that need none of the extra args, passing NULL wouldn't work for the
> >> _Generic((__args) looking for "struct kmem_cache_args *" as NULL is not of
> >> that type, right?
> >> 
> >> I tried and it really errors out.
> > 
> > How about
> > 
> > #define kmem_cache_create(__name, __object_size, __args, ...)           \
> > 	_Generic((__args),                                              \
> > 		struct kmem_cache_args *: __kmem_cache_create_args,	\
> > 		void *: __kmem_cache_create_args,			\
> > 		default: __kmem_cache_create)(__name, __object_size, __args, __VA_ARGS__)
> 
> Seems to work. I'd agree with the "if NULL, use a static default" direction
> then. It just seems like a more user-friendly API to me.

Sure. So can you fold your suggestion above and the small diff below
into the translation layer patch?

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 30000dcf0736..3c12d87825e3 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -255,9 +255,14 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
                                            slab_flags_t flags)
 {
        struct kmem_cache *s = NULL;
+       struct kmem_cache_args kmem_args = {};
        const char *cache_name;
        int err;

+       /* If no custom arguments are requested just assume the default values. */
+       if (!args)
+               args = &kmem_args;
+
 #ifdef CONFIG_SLUB_DEBUG
        /*
         * If no slab_debug was enabled globally, the static key is not yet

