Return-Path: <linux-fsdevel+bounces-54087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F613AFB21F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 13:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5C71701BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CF9299A8E;
	Mon,  7 Jul 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeaijYXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488D286894;
	Mon,  7 Jul 2025 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887036; cv=none; b=oBbiHpBwYFBcAVASdKGv6KYps13631x8SIhi9b3WmD88kOCttGFIhuKClqFalzm8z9DcyT81czgv7jyqoKKCxO0IwofF0k87rEcW+gvIq5iLRn/30YRE1zspagmeqvZ2ppk9ed5opCLYkp82yv+1d24z4MTZUTD1M5h/vd2jAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887036; c=relaxed/simple;
	bh=mZci8TeX7qUcPrKXdFIKPDSMO9TpTh92KYP/6ZMcG9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btD53u+q0Y234pwS9F1Y3hjFgFnvJVvhiG/j+GWdOV19g/bZd1BAudN261qDiaRTyPGCWin2qh1lqAKXOlozY6sbsfBH3DTeY2YI0CXeqr0F9QCscZSXijCCJNnJ/cVxqhPcbSHLM2k3jM4kYNo2Lg/qs89fnq+GCmPg8DnLxkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeaijYXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10EAC4CEE3;
	Mon,  7 Jul 2025 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751887035;
	bh=mZci8TeX7qUcPrKXdFIKPDSMO9TpTh92KYP/6ZMcG9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VeaijYXKWeUXseYflfhabXjRCJZwlOXubNU6omLNg3MEQYZN6d9J7h9zjM7+p33pe
	 K++TjgTLtkpWwdIQ8JJWWGwtd9Gd3rQPGtx3rezu0p3lyklk0tkTGsSmNGpOpthJ2u
	 xBJPkTwko21LRQodClE9gzgVTYLpryhajvHYUGMLGaAmWd2HnswxFwXxUQDxWPliet
	 8WMa1ppaAOFmr4NxtTZ8ZpbY/yMoyn0AdWUGqIHpQTtboViieVZ/aW9C3Gxkt7q3Cd
	 2MfcQjJ4CzqcD/Pf7AYMVjDPChXmpB30JGJSJevD1Trzajd0SFmJi2D0aNMu5Gw49U
	 wnVJTqRZctz1Q==
Date: Mon, 7 Jul 2025 13:17:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Song Liu <songliubraving@meta.com>, Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Message-ID: <20250707-netto-campieren-501525a7d10a@brauner>
References: <>
 <127D7BC6-1643-403B-B019-D442A89BADAB@meta.com>
 <175097828167.2280845.5635569182786599451@noble.neil.brown.name>
 <20250707-kneifen-zielvereinbarungen-62c1ccdbb9c6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707-kneifen-zielvereinbarungen-62c1ccdbb9c6@brauner>

On Mon, Jul 07, 2025 at 12:46:41PM +0200, Christian Brauner wrote:
> On Fri, Jun 27, 2025 at 08:51:21AM +1000, NeilBrown wrote:
> > On Fri, 27 Jun 2025, Song Liu wrote:
> > > 
> > > 
> > > > On Jun 26, 2025, at 3:22 AM, NeilBrown <neil@brown.name> wrote:
> > > 
> > > [...]
> > > 
> > > >> I guess I misunderstood the proposal of vfs_walk_ancestors() 
> > > >> initially, so some clarification:
> > > >> 
> > > >> I think vfs_walk_ancestors() is good for the rcu-walk, and some 
> > > >> rcu-then-ref-walk. However, I don’t think it fits all use cases. 
> > > >> A reliable step-by-step ref-walk, like this set, works well with 
> > > >> BPF, and we want to keep it.
> > > > 
> > > > The distinction between rcu-walk and ref-walk is an internal
> > > > implementation detail.  You as a caller shouldn't need to think about
> > > > the difference.  You just want to walk.  Note that LOOKUP_RCU is
> > > > documented in namei.h as "semi-internal".  The only uses outside of
> > > > core-VFS code is in individual filesystem's d_revalidate handler - they
> > > > are checking if they are allowed to sleep or not.  You should never
> > > > expect to pass LOOKUP_RCU to an VFS API - no other code does.
> > > > 
> > > > It might be reasonable for you as a caller to have some control over
> > > > whether the call can sleep or not.  LOOKUP_CACHED is a bit like that.
> > > > But for dotdot lookup the code will never sleep - so that is not
> > > > relevant.
> > > 
> > > Unfortunately, the BPF use case is more complicated. In some cases, 
> > > the callback function cannot be call in rcu critical sections. For 
> > > example, the callback may need to read xatter. For these cases, we
> > > we cannot use RCU walk at all. 
> > 
> > I really think you should stop using the terms RCU walk and ref-walk.  I
> > think they might be focusing your thinking in an unhelpful direction.
> 
> Thank you! I really appreciate you helping to shape this API and it
> aligns a lot with my thinking.
> 
> > The key issue about reading xattrs is that it might need to sleep.
> > Focusing on what might need to sleep and what will never need to sleep
> > is a useful approach - the distinction is wide spread in the kernel and
> > several function take a flag indicating if they are permitted to sleep,
> > or if failure when sleeping would be required.
> > 
> > So your above observation is better described as 
> > 
> >    The vfs_walk_ancestors() API has an (implicit) requirement that the
> >    callback mustn't sleep.  This is a problem for some use-cases
> >    where the call back might need to sleep - e.g. for accessing xattrs.
> > 
> > That is a good and useful observation.  I can see three possibly
> > responses:
> > 
> > 1/ Add a vfs_walk_ancestors_maysleep() API for which the callback is
> >    always allowed to sleep.  I don't particularly like this approach.
> 
> Agreed.
> 
> > 
> > 2/ Use repeated calls to vfs_walk_parent() when the handling of each
> >    ancestor might need to sleep.  I see no problem with supporting both
> >    vfs_walk_ancestors() and vfs_walk_parent().  There is plenty of
> >    precedent for having different  interfaces for different use cases.
> 
> Meh.
> 
> > 
> > 3/ Extend vfs_walk_ancestors() to pass a "may sleep" flag to the callback.
> 
> I think that's fine.

Ok, sorry for the delay but there's a lot of different things going on
right now and this one isn't exactly an easy thing to solve.

I mentioned this before and so did Neil: the lookup implementation
supports two modes sleeping and non-sleeping. That api is abstracted
away as heavily as possible by the VFS so that non-core code will not be
exposed to it other than in exceptional circumstances and doesn't have
to care about it.

It is a conceptual dead-end to expose these two modes via separate APIs
and leak this implementation detail into non-core code. It will not
happen as far as I'm concerned.

I very much understand the urge to get the refcount step-by-step thing
merged asap. Everyone wants their APIs merged fast. And if it's
reasonable to move fast we will (see the kernfs xattr thing).

But here are two use-cases that ask for the same thing with different
constraints that closely mirror our unified approach. Merging one
quickly just to have something and then later bolting the other one on
top, augmenting, or replacing, possible having to deprecate the old API
is just objectively nuts. That's how we end up with a spaghetthi helper
collection. We want as little helper fragmentation as possible.

We need a unified API that serves both use-cases. I dislike
callback-based APIs generally but we have precedent in the VFS for this
for cases where the internal state handling is delicate enough that it
should not be exposed (see __iterate_supers() which does exactly work
like Neil suggested down to the flag argument itself I added).

So I'm open to the callback solution.

(Note for really absurd perf requirements you could even make it work
with static calls I'm pretty sure.)

