Return-Path: <linux-fsdevel+bounces-28194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A97967D69
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 03:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208711C215B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 01:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6212231C;
	Mon,  2 Sep 2024 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IFkv4OKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B116F9E6;
	Mon,  2 Sep 2024 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240940; cv=none; b=Xb9Gby/AhUvE5MozlC+B5aFH8PGLqwKV1dkKLABTWPkls4UJIa5G+BE3l4Tzm2u9tUDNXqiy8oIMu1UtVW+oscaUkbP3uSXcKhs8D64iUPi33v8XJFnjGx8xQ8n8vg1DmzZ/hys+lLUPVgPcM8+2pRDLhZ+xHXAAmAgURTZy/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240940; c=relaxed/simple;
	bh=Si7FJ1SST9rktRporsGadBi8V+pby1S8BrOPLcc+z6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0qf4YaGVvYfMFpMy52ghXmIdtBOjiRV0EQxyyz8KspebkCVKRPC5/9D0JQrdgdvSVgnhlB76umutI3LG+2kN1etFfD3WJa7CqAlbBEwYEydzTi0uTc+X7gosqOmOMHD7j18SbhcV8AdyZADRQkXp1MinOBXfH+HeIu7ezJI8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IFkv4OKQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 1 Sep 2024 21:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725240936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGvvId3No4R93nBZ4AK/V7aWjZbCAbfSAH2hNYlNpxc=;
	b=IFkv4OKQhiFdAAREhmHS0itadtn1E/1DcejCuTUdNxg5TIFmSLRC8oMCdDyfEa9qdp3I+x
	BlZtHfwSGYTrZbHu6oJt5H8caBfZ01miG4ZAQhJnwWKVcvOyZQF5lEf8xdkREfttJtQrA2
	3svbZTBEUyrfClcpo2YNWbks3xSQCRQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtUFaq3vD+zo0gfC@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 02, 2024 at 10:23:06AM GMT, Dave Chinner wrote:
> On Thu, Aug 29, 2024 at 09:32:52AM -0400, Kent Overstreet wrote:
> > And more than that, this is coming from you saying "We didn't have
> > to handle memory allocation failures in IRIX, why can't we be like
> > IRIX?  All those error paths are a pain to test, why can't we get
> > rid of them?"
> >
> You're not listening, Kent. We are not eliding error paths because
> they aren't (or cannot be) tested.
> 
> It's a choice between whether a transient error (e.g. ENOMEM) should
> be considered a fatal error or not. The architectural choice that
> was made for XFS back in the 1990s was that the filesystem should
> never fail when transient errors occur. The choice was to wait for
> the transient error to go away and then continue on. The rest of the
> filesystem was build around these fundamental behavioural choices.

<snipped>

> Hence failing an IO and shutting down the filesystem because there
> are transient errors occuring in either the storage or the OS was
> absolutely the wrong thing to be doing. It still is the wrong thing
> to be doing - we want to wait until the transient error has
> progressed to being classified as a permanent error before we take
> drastic action like denying service to the filesystem.

Two different things are getting conflated here.

I'm saying forcefully that __GFP_NOFAIL isn't a good design decision,
and it's bad for system behaviour when we're thrashing, because you,
willy and others have been talking openly about making something like
that the norm, and that concerns me.

I'm _not_ saying that you should have to rearchitect your codebase to
deal with transient -ENOMEMs... that's clearly not going to happen.

But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
in the case of bugs, because that's going to be an improvement w.r.t.
system robustness, in exactly the same way we don't use BUG_ON() if it's
something that we can't guarantee won't happen in the wild - we WARN()
and try to handle the error as best we can.

If we could someday get PF_MEMALLOC_NORECLAIM annotated everywhere we're
not in a sleepable context (or more likely, teach kmalloc() about
preempt count) - that turns a whole class of "scheduling while atomic"
bugs into recoverable errors. That'd be a good thing.

In XFS's case, the only thing you'd ever want to do on failure of a
__GFP_NOFAIL allocation is do an emergency shutdown - the code is buggy,
and those bugs tend to be quickly found and fixed (even quicker when the
system stays usable and the user can collect a backtrace).

> > Except that's bullshit; at the very least any dynamically sized
> > allocation _definitely_ has to have an error path that's tested, and if
> > there's questions about the context a code path might run in, that
> > that's another reason.
> 
> We know the context we run __GFP_NOFAIL allocations in - transaction
> context absolutely requires a task context because we take sleeping
> locks, submit and wait on IO, do blocking memory allocation, etc. We
> also know the size of the allocations because we've bounds checked
> everything before we do an allocation.

*nod*

> Hence this argument of "__GFP_NOFAIL aboslutely requires error
> checking because an invalid size or wonrg context might be used"
> is completely irrelevant to XFS. If you call into the filesytsem
> from an atomic context, you've lost long before we get to memory
> allocation because filesystems take sleeping locks....

Yeah, if you know the context of your allocation and you have bounds on
the allocation size that's all fine - that's your call.

_As a general policy_, I will say that even __GFP_NOFAIL allocations
should have error paths - becuase lots of allocations have sizes that
userspace can control, so it becomes a security issue and we need to be
careful what we tell people.

> > GFP_NOFAIL is the problem here, and if it's encouraging this brain
> > damaged "why can't we just get rid of error paths?" thinking, then it
> > should be removed.
> >
> > Error paths have to exist, and they have to be tested.
> 
> __GFP_NOFAIL is *not the problem*, and we are not "avoiding error
> handling".  Backing off, looping and trying again is a valid
> mechanism for handling transient failure conditions. Having a flag
> that tells the allocator to "backoff, loop and try again" is a
> perfectly good way of providing a generic error handling mechanism.

But we do have to differentiate between transient allocation failures
and failures that are a result of bugs. Because just looping means a
buggy allocation call becomes, at best, a hung task you can't kill.

