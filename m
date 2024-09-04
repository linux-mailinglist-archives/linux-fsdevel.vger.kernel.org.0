Return-Path: <linux-fsdevel+bounces-28588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B66796C3E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786F11C21409
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494DD1DEFDF;
	Wed,  4 Sep 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+qjX0/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EE1DA635
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466771; cv=none; b=iyiSeEknsA6eboR/vkDGXIQjq2qrMAL2xHW7NnGkrv5u7zUFlurRGx66cG27Q06Ls66WeTORaFx8lZx5/cjvawPQYtJl29xDaVx4JadMFfdYk+VuZVY1hJu5aT6uBtoyPjX+o1hH43/2+lg4Dx9XDgY1PlPeY2icduSeV5ikiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466771; c=relaxed/simple;
	bh=zux/Q6f4GHCljD7witUCfRLF6iwgNCywYMqZ73GamjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTQN5aWr5dqTZq/5Hybe3vhHyN/oQjkw9mibP0aXgmlOnrqCxjEhvcuV5FGuglPPEWP8/tupaCEW4o5LITJDvYogUsyH7s4K5XpQJ2rrgqnMBvAvqVI7SdWhR8LhLRhVOhbNxDK9tVM5rbgBTb3HUzeEyVfR+KS+x20Ujq3s+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+qjX0/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4010C4CEC6;
	Wed,  4 Sep 2024 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466771;
	bh=zux/Q6f4GHCljD7witUCfRLF6iwgNCywYMqZ73GamjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+qjX0/qWy9hx1FU2ZjCAbOeZiD8kg3OkHuZIckSG3Ymj2TJ1jGOvKtlNGvtZfQ4p
	 DxC9UZfJ5J3szU1/4b26OjSINeWohL1S3X18fvStMLE2wPxDSfQdm8rPeaBQiPGtEY
	 h0YmCPq+3ClvU/HjjV5IKiItJjqQPpSO2ZhVnb1P0svz7A9TquHlYW46hhgbj/+6Ez
	 uLbQl2su/gCeZxRGtkNcipMBrpUfljeuM7qr56DARJJ1eY6b/5pY9bogzpP6NFirkI
	 3djAvqKxIAOQda/XHzunCtW+cBsE6xwKmlGBxp0xvgTYObkmhbB1rI548bnWabDryf
	 tJJZ4kr4zSQCQ==
Date: Wed, 4 Sep 2024 19:16:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
Message-ID: <ZtiH7UNQ7Rnftr0o@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
 <Zth5wHtDkX78gl1l@kernel.org>
 <9303896a-e3c8-4dc3-926b-c7e8fc75cf6b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9303896a-e3c8-4dc3-926b-c7e8fc75cf6b@suse.cz>

On Wed, Sep 04, 2024 at 05:49:15PM +0200, Vlastimil Babka wrote:
> On 9/4/24 17:16, Mike Rapoport wrote:
> > On Tue, Sep 03, 2024 at 04:20:43PM +0200, Christian Brauner wrote:
> >> @@ -275,7 +285,7 @@ do_kmem_cache_create_usercopy(const char *name,
> >>  
> >>  	mutex_lock(&slab_mutex);
> >>  
> >> -	err = kmem_cache_sanity_check(name, size);
> >> +	err = kmem_cache_sanity_check(name, object_size);
> >>  	if (err) {
> >>  		goto out_unlock;
> >>  	}
> >> @@ -296,12 +306,14 @@ do_kmem_cache_create_usercopy(const char *name,
> >>  
> >>  	/* Fail closed on bad usersize of useroffset values. */
> >>  	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
> >> -	    WARN_ON(!usersize && useroffset) ||
> >> -	    WARN_ON(size < usersize || size - usersize < useroffset))
> >> -		usersize = useroffset = 0;
> >> -
> >> -	if (!usersize)
> >> -		s = __kmem_cache_alias(name, size, align, flags, ctor);
> >> +	    WARN_ON(!args->usersize && args->useroffset) ||
> >> +	    WARN_ON(object_size < args->usersize ||
> >> +		    object_size - args->usersize < args->useroffset))
> >> +		args->usersize = args->useroffset = 0;
> >> +
> >> +	if (!args->usersize)
> >> +		s = __kmem_cache_alias(name, object_size, args->align, flags,
> >> +				       args->ctor);
> > 
> > Sorry I missed it in the previous review, but nothing guaranties that
> > nobody will call kmem_cache_create_args with args != NULL.
> > 
> > I think there should be a check for args != NULL and a substitution of args
> > with defaults if it actually was NULL.
> 
> Hm there might be a bigger problem with this? If we wanted to do a
> (non-flag-day) conversion to the new kmem_cache_create() for some callers
> that need none of the extra args, passing NULL wouldn't work for the
> _Generic((__args) looking for "struct kmem_cache_args *" as NULL is not of
> that type, right?
> 
> I tried and it really errors out.

How about

#define kmem_cache_create(__name, __object_size, __args, ...)           \
	_Generic((__args),                                              \
		struct kmem_cache_args *: __kmem_cache_create_args,	\
		void *: __kmem_cache_create_args,			\
		default: __kmem_cache_create)(__name, __object_size, __args, __VA_ARGS__)

 

-- 
Sincerely yours,
Mike.

