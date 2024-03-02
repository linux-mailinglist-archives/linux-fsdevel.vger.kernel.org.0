Return-Path: <linux-fsdevel+bounces-13343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84D86ED30
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 01:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AD91F222D7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557553AC;
	Sat,  2 Mar 2024 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6zKOxO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8017F3
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337757; cv=none; b=n0smr2D7/T1ED7V24SWRn0Ec/fjwBujpyPGlEaJEtB6lYSHdNflIZw9pdo6cQI4sPeXMTQVquyCgjjQak9R+LsFREoYqUSRkAstYcHORveqBu0opVusL5t8AyE3DBZxgct5qfxc/v3Q77RNWp3c2+i8hLXzl81cuMD+spcOqUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337757; c=relaxed/simple;
	bh=arrOqwq0BEC5pSCjRCmVf/2KFBOEd14NQ4zxAb+qHQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MirprndcHdUIq2WpaUUDRuJPie8ZIeV0PQcQIslDF4g/TR30QIQVvAwvdNh2H8cybd5A1XR9WHsJugmwPqWfJQzDQdLJ8mZ443pkmcnO7qK9dbOzfCvYR64ePAh9FDpgU2SLP2luX3iJvcaU0Y1FK362Lv6/Wsc7HsHT9ji49lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j6zKOxO8; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Mar 2024 19:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709337752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NHjZYBPaS4fHXiqG86Vmwt7S0fvkx8xr2DfgC0OSpw=;
	b=j6zKOxO8cxmyJa8amNdox8uWmadC5xdEBohd6FaiNMyyu95kjltv1y4fRkyhm8dnxb3kk6
	iyDCldJFmhVgL3sp5NcpWK+bLArdwveVpM6MF4PxFSQDrYQMsn0GzJcY9yp5M+/EpOwHkK
	3vKnFNtaY7EsYct/6w9bvvjzoADytgI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Dave Chinner <david@fromorbit.com>, 
	Matthew Wilcox <willy@infradead.org>, Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, 
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170933687972.24797.18406852925615624495@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 02, 2024 at 10:47:59AM +1100, NeilBrown wrote:
> On Sat, 02 Mar 2024, Kent Overstreet wrote:
> > On Fri, Mar 01, 2024 at 04:54:55PM +1100, Dave Chinner wrote:
> > > On Fri, Mar 01, 2024 at 01:16:18PM +1100, NeilBrown wrote:
> > > > While we are considering revising mm rules, I would really like to
> > > > revised the rule that GFP_KERNEL allocations are allowed to fail.
> > > > I'm not at all sure that they ever do (except for large allocations - so
> > > > maybe we could leave that exception in - or warn if large allocations
> > > > are tried without a MAY_FAIL flag).
> > > > 
> > > > Given that GFP_KERNEL can wait, and that the mm can kill off processes
> > > > and clear cache to free memory, there should be no case where failure is
> > > > needed or when simply waiting will eventually result in success.  And if
> > > > there is, the machine is a gonner anyway.
> > > 
> > > Yes, please!
> > > 
> > > XFS was designed and implemented on an OS that gave this exact
> > > guarantee for kernel allocations back in the early 1990s.  Memory
> > > allocation simply blocked until it succeeded unless the caller
> > > indicated they could handle failure. That's what __GFP_NOFAIL does
> > > and XFS is still heavily dependent on this behaviour.
> > 
> > I'm not saying we should get rid of __GFP_NOFAIL - actually, I'd say
> > let's remove the underscores and get rid of the silly two page limit.
> > GFP_NOFAIL|GFP_KERNEL is perfectly safe for larger allocations, as long
> > as you don't mind possibly waiting a bit.
> > 
> > But it can't be the default because, like I mentioned to Neal, there are
> > a _lot_ of different places where we allocate memory in the kernel, and
> > they have to be able to fail instead of shoving everything else out of
> > memory.
> > 
> > > This is the sort of thing I was thinking of in the "remove
> > > GFP_NOFS" discussion thread when I said this to Kent:
> > > 
> > > 	"We need to start designing our code in a way that doesn't require
> > > 	extensive testing to validate it as correct. If the only way to
> > > 	validate new code is correct is via stochastic coverage via error
> > > 	injection, then that is a clear sign we've made poor design choices
> > > 	along the way."
> > > 
> > > https://lore.kernel.org/linux-fsdevel/ZcqWh3OyMGjEsdPz@dread.disaster.area/
> > > 
> > > If memory allocation doesn't fail by default, then we can remove the
> > > vast majority of allocation error handling from the kernel. Make the
> > > common case just work - remove the need for all that code to handle
> > > failures that is hard to exercise reliably and so are rarely tested.
> > > 
> > > A simple change to make long standing behaviour an actual policy we
> > > can rely on means we can remove both code and test matrix overhead -
> > > it's a win-win IMO.
> > 
> > We definitely don't want to make GFP_NOIO/GFP_NOFS allocations nofail by
> > default - a great many of those allocations have mempools in front of
> > them to avoid deadlocks, and if you do that you've made the mempools
> > useless.
> > 
> 
> Not strictly true.  mempool_alloc() adds __GFP_NORETRY so the allocation
> will certainly fail if that is appropriate.

*nod* 

> I suspect that most places where there is a non-error fallback already
> use NORETRY or RETRY_MAYFAIL or similar.

NORETRY and RETRY_MAYFAIL actually weren't on my radar, and I don't see
_tons_ of uses for either of them - more for NORETRY.

My go-to is NOWAIT in this scenario though; my common pattern is "try
nonblocking with locks held, then drop locks and retry GFP_KERNEL".
 
> But I agree that changing the meaning of GFP_KERNEL has a potential to
> cause problems.  I support promoting "GFP_NOFAIL" which should work at
> least up to PAGE_ALLOC_COSTLY_ORDER (8 pages).

I'd support this change.

> I'm unsure how it should be have in PF_MEMALLOC_NOFS and
> PF_MEMALLOC_NOIO context.  I suspect Dave would tell me it should work in
> these contexts, in which case I'm sure it should.
> 
> Maybe we could then deprecate GFP_KERNEL.

What do you have in mind?

Deprecating GFP_NOFS and GFP_NOIO would be wonderful - those should
really just be PF_MEMALLOC_NOFS and PF_MEMALLOC_NOIO, now that we're
pushing for memalloc_flags_(save|restore) more.

Getting rid of those would be a really nice cleanup beacuse then gfp
flags would mostly just be:
 - the type of memory to allocate (highmem, zeroed, etc.)
 - how hard to try (don't block at all, block some, block forever)

