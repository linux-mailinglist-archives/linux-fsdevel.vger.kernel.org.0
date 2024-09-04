Return-Path: <linux-fsdevel+bounces-28612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCB096C5F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3C41C24FE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE78D1E1A18;
	Wed,  4 Sep 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wU9yIYF8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62C2AE9F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473005; cv=none; b=ndo1Z9RJbCgOtSyZEjIaPtZqn83k0ye/a0BeChRZl5ceYIZ3G1Cd2eP+pfZ6X5yeI5tuJDl/GDlPm1HCtRU/ZCKKLB6RWEEHB/RRhDXAeOBgv23tV40TchfCAOm2CKPrPOSIirZcbiIs5xhtFSd8xbdJcMsdYJWWDu5xdXZUP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473005; c=relaxed/simple;
	bh=kezW3hxgZleY+3rBgw6V29J9jFR6G7T1cr6q/Vqr81g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5tZ+QvJqSO4J2H2lOPAjpU6G97Mod+dcC/k2jipTdPyBYCrckOr+zEAGOAOgH78dLID57E2ugBSQROSEo26sN3jdfnLuD3/PlEf1uYau2cnVTCn95sO4o7qTQhXHu8oHMmltt1heEYFfeTx+F+Tsn2dWAr8Wff3/BmA19o9lvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wU9yIYF8; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Sep 2024 14:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725473000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WD4ErxPHxDTsEan3mK+kbR66xt5pTLcNQUyAHMP5/Rk=;
	b=wU9yIYF8S465+O10fQv/FL6kMdtyDtJolnB/naccAGhtDYrN8izylYMUxWBSUPMBx+wvaH
	9y1MP9IZtynVJIDHFyeu0l0Wghhsy2Z2VKJE8TQJKQdXupbdpeEGlqElxlOKyp0tVHWH1B
	Cdd0/Njjlkvfm//EDlRYEkWxBk3mJks=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Vlastimil Babka <vbabka@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <pmvxqqj5e6a2hdlyscmi36rcuf4kn37ry4ofdsp4aahpw223nk@lskmdcwkjeob>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <qlkjvxqdm72ijaaiauifgsnyzx3mw4edl2hexfabnsdncvpyhd@dvxliffsmkl6>
 <ZtgI1bKhE3imqE5s@tiehlicka>
 <xjtcom43unuubdtzj7pudew3m5yk34jdrhim5nynvoalk3bgbu@4aohsslg5c5m>
 <ZtiOyJ1vjY3OjAUv@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtiOyJ1vjY3OjAUv@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 04, 2024 at 06:46:00PM GMT, Michal Hocko wrote:
> On Wed 04-09-24 12:05:56, Kent Overstreet wrote:
> > On Wed, Sep 04, 2024 at 09:14:29AM GMT, Michal Hocko wrote:
> > > On Tue 03-09-24 19:53:41, Kent Overstreet wrote:
> > > [...]
> > > > However, if we agreed that GFP_NOFAIL meant "only fail if it is not
> > > > possible to satisfy this allocation" (and I have been arguing that that
> > > > is the only sane meaning) - then that could lead to a lot of error paths
> > > > getting simpler.
> > > >
> > > > Because there are a lot of places where there's essentially no good
> > > > reason to bubble up an -ENOMEM to userspace; if we're actually out of
> > > > memory the current allocation is just one out of many and not
> > > > particularly special, better to let the oom killer handle it...
> > > 
> > > This is exactly GFP_KERNEL semantic for low order allocations or
> > > kvmalloc for that matter. They simply never fail unless couple of corner
> > > cases - e.g. the allocating task is an oom victim and all of the oom
> > > memory reserves have been consumed. This is where we call "not possible
> > > to allocate".
> > 
> > *nod*
> > 
> > Which does beg the question of why GFP_NOFAIL exists.
> 
> Exactly for the reason that even rare failure is not acceptable and
> there is no way to handle it other than keep retrying. Typical code was 
> 	while (!(ptr = kmalloc()))
> 		;

But is it _rare_ failure, or _no_ failure?

You seem to be saying (and I just reviewed the code, it looks like
you're right) that there is essentially no difference in behaviour
between GFP_KERNEL and GFP_NOFAIL.

So given that - why the wart?

I think we might be able to chalk it up to history; I'd have to go
spunking through the history (or ask Dave or Ted, maybe they'll chime
in), but I suspect GFP_KERNEL didn't provide such strong guarantees when
the allocation loops & GFP_NOFAIL were introduced.

> Or the failure would be much more catastrophic than the retry loop
> taking unbound amount of time.

But if GFP_KERNEL has the retry loop...

> > And if you scan for GFP_NOFAIL uses in the kernel, a decent number
> > already do just that.
> 
> It's been quite some time since I've looked the last time. And I am not
> saying all the existing ones really require something as strong as
> GFP_NOFAIL semantic. If they could be dropped then great! The fewer we
> have the better.
> 
> But the point is there are some which _do_ need this. We have discussed
> that in other email thread where you have heard why XFS and EXT4 does
> that and why they are not going to change that model. 

No, I agree that they need the strong guarantees.

But if there's an actual bug, returning an error is better than killing
the task. Killing the task is really bad; these allocations are deep in
contexts where locks and refcounts are held, and the system will just
grind to a halt.

> > But as a matter of policy going forward, yes we should be saying that
> > even GFP_NOFAIL allocations should be checking for -ENOMEM.
> 
> I argue that such NOFAIL semantic has no well defined semantic and legit
> users are forced to do
> 	while (!(ptr = kmalloc(GFP_NOFAIL))) ;
> or
> 	BUG_ON(!(ptr = kmalloc(GFP_NOFAIL)));
> 
> So it has no real reason to exist.

I'm arguing that it does, provided when it returns NULL is defined to
be:
 - invalid allocation context
 - a size that is so big that it will never be possible to satisfy.

Returning an error is better than not returning at all, and letting the
system grind to a halt.

Let's also get Dave or Ted to chime in here if we can, because I
strongly suspect the situation was different when those retry loops were
introduced.

> We at the allocator level have 2 choices.  Either we tell users they
> will not get GFP_NOFAIL and you just do the above or we provide NOFAIL
> which really guarantees that there is no failure even if that means the
> allocation gets unbounded amount of time. The latter have a slight
> advantage because a) you can identify those callers more easily and b)
> the allocator can do some heuristics to help those allocations.

Or option 3: recognize that this is a correctness/soundness issue, and
that if there are buggy callers they need to be fixed.

To give a non-kernel correlary, in the Rust world, soundness issues are
taken very seriously, and they are the only situation in which existing
code will be broken if necessary to fix them. Probably with equal amount
of fighting as these threads, heh.

> > > Yes, we need to define some reasonable maximum supported sizes. For the
> > > page allocator this has been order > 1 and we considering we have a
> > > warning about those requests for years without a single report then we
> > > can assume we do not have such abusers. for kvmalloc to story is
> > > different. Current INT_MAX is just not any practical limit. Past
> > > experience says that anything based on the amount of memory just doesn't
> > > work (e.g. hash table sizes that used to that scaling and there are
> > > other examples). So we should be practical here and look at existing
> > > users and see what they really need and put a cap above that.
> > 
> > Not following what you're saying about hash tables? Hash tables scale
> > roughly with the amount of system memory/workingset.
> 
> I do not have sha handy but I do remember dcache hashtable scaling with
> the amount of memory in the past and that led to GBs of memory allocated
> on TB systems. This is not the case anymore I just wanted to mention
> that scaling with the amount of memory can get really wrong easily.

Was the solution then to change the dcache hash table implementation,
rather than lifting the INT_MAX allocation size limit?

> > But it seems to me that the limit should be lower if you're on e.g. a 2
> > GB machine (not failing with a warning, just failing immediately rather
> > than oom killing a bunch of stuff first) - and it's going to need to be
> > raised above INT_MAX as large memory machines keep growing, I keep
> > hitting it in bcachefs fsck code.
> 
> Do we actual usecase that would require more than couple of MB? The
> amount of memory wouldn't play any actual role then.

Which "amount of memory?" - not parsing that.

For large allocations in bcachefs: in journal replay we read all the
keys in the journal, and then we create a big flat array with references
to all of those keys to sort and dedup them.

We haven't hit the INT_MAX size limit there yet, but filesystem sizes
being what they are, we will soon. I've heard of users with 150 TB
filesystems, and once the fsck scalability issues are sorted we'll be
aiming for petabytes. Dirty keys in the journal scales more with system
memory, but I'm leasing machines right now with a quarter terabyte of
ram.

Another more pressing one is the extents -> backpointers and
backpointers -> extents passes of fsck; we do a linear scan through one
btree checking references to another btree. For the btree we're checking
references to the lookups are random, so we need to cache and pin the
entire btree in ram if possible, or if not whatever will fit and we run
in multiple passes.

This is the #1 scalability issue hitting a number of users right now, so
I may need to rewrite it to pull backpointers into an eytzinger array
and do our random lookups for backpointers on that - but that will be
"the biggest vmalloc array we can possible allocate", so the INT_MAX
size limit is clearly an issue there...

Q: Why isn't this in userspace?
A: Has to be in the kernel for online fsck to work, and these are fsck
passes we can already run online...

