Return-Path: <linux-fsdevel+bounces-33346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E789B7B46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 14:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED611F23836
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A2C19D890;
	Thu, 31 Oct 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq3fT/Ao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25213A869
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379736; cv=none; b=mzOMzXkANkVaVPnUnuibwYjdXU2nGPcMhPPdL+79nd/D+IAyC3kWD64K6qwSxg5cNNsypE9n/qWJTAGqdkSLszo0UdpI1rLYMabk3IXhfpPKsgjT0E/RivNxH4ovhrzTFjfqU5x97csNKwBuACHIHm0b+KvBZAoeHsnYXQbeK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379736; c=relaxed/simple;
	bh=IDfNzpA6hwt0WIyAbYtZYCRS9ZwnrB+kkgX4TA3/UZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ng68GMEBjnsjc2uKOQDU0Z3R6972KklOlSNulZ55Kne/w81pQr1/VCDtnzPcyHs7e5985p1pYxpEAWoTze4Ogof1xu5AiNWIr4pDwoP2/KTv0zOQijI/Cb+BQOv/BZadP9cZJ65ynE0ntKI13h3LjNNMg112EiZ+HP8WxpW2EjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq3fT/Ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482DFC4FF7A;
	Thu, 31 Oct 2024 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730379736;
	bh=IDfNzpA6hwt0WIyAbYtZYCRS9ZwnrB+kkgX4TA3/UZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fq3fT/Aoc8aG33xyhDAJTlHgIf6sXA3Dvyxx8wOCwpIjVg+bCU0iWPBMf1Hq5LcYs
	 GUVCTP8ylx7h734fK1uEJ5bVJvY4+mBxahkOjHjVKB9q4vgmjGd3lBEhUE9nFvaLXM
	 5wrqtCzQxzmTQwXdt8sbLzBWKlKEQLnGtIkNGKjx1bwJIYgQsfNRJyF/EC0840JKAU
	 K8ZrJnKE4sdvh+TYRQXl+3n7UXLNuoMB2W/h/jIRQwL/NV6GoV5ILTidX6MC9p0KSL
	 889Eslt50gePYn5j+xD9Ys0G+SyQcAIz87wEbBzBW5GtXy0ZtDkO0QhTDdeLbSwltp
	 /HYKmHeDufOUA==
Date: Thu, 31 Oct 2024 14:02:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <20241031-klaglos-geldmangel-c0e7775d42a7@brauner>
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>

On Wed, Oct 30, 2024 at 06:16:22PM -1000, Linus Torvalds wrote:
> So call me crazy, but due to entirely unrelated changes (the x86
> barrier_nospec optimization) I was doing some profiles to check that
> everything looked fine.
> 
> And just looking at kernel profiles, I noticed that
> "generic_permission()" wasn't entirely in the noise. It was right
> there along with strncpy_from_user() etc. Which is a bit surprising,
> because it should be really cheap to check basic Unix permissions?
> 
> It's all really just "acl_permission_check()" and that code is
> actually fairly optimized, except that the whole
> 
>         vfsuid = i_uid_into_vfsuid(idmap, inode);
> 
> to check whether we're the owner is *not* cheap. It causes a call to
> make_vfsuid(), and it's just messy.

I assume you ran your benchmark on baremetal so no containers or
idmappings? I find this somewhat suprising. One thing to optimize here
independent of your proposal would be to try and __always_inline
make_vfsuid().

> 
> Which made me wonder: we already have code that says "if the Group and
> Other permission bits are the same wrt the mask we are checking, don't
> bother doing the expensive group checks".
> 
> Why not extend that to "if any of the UGO choices are ok with the
> permissions, why bother looking up ownership at all?"
> 
> Now, there is one reason to look up the owner: POSIX ACL's don't
> matter to owners, but do matter to others.
> 
> But we could check for the cached case of "no POSIX ACLs" very
> cheaply, and only do it for that case.
> 
> IOW, a patch something like the attached.

I think this should work (though I find the permission checking model in
general to be an unruly mess - that's ignoring the fun hardening bits of
it...).

Can you send give me a proper SoB patch? Liberal comments in the code
would be appreciated. I'd like to put this through LTP and some of the
permission tests I've written over the years.

> 
> No, I didn't really check whether it makes any difference at all. But
> my gut feel is that a *lot* of permission checks succeed for any user,
> with things like system directories are commonly drwxr-xr-x, so if you
> want to check read or execute permissions, it really doesn't matter
> whether you are the User, the Group, or Other.
> 
> So thus the code does that
> 
>         unsigned int all;
>         all = mode & (mode >> 3); // combine g into o
>         all &= mode >> 6;         // ... and u into o
> 
> so now the low three bits of 'all' are the bits that *every* case has
> set. And then
> 
>         if (!(mask & ~all & 7))
>                 return 0;
> 
> basically says "if what we are asking for is not zero in any of those
> bits, we're good".
> 
> And it's entirely possible that I'm missing something silly and am
> being just stupid. Somebody hit me with the clue bat if so.
> 
>                Linus



