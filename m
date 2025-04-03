Return-Path: <linux-fsdevel+bounces-45597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E35EA79B13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 07:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3044C1895CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 05:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0600219B5A3;
	Thu,  3 Apr 2025 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UM5R2RfB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB119DF41
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656771; cv=none; b=OcJvbM7nwn6hSHPaM2HXeXXIrkrGu6wRnLto25JsRz/RpKtphOMr2ZdhyCmhC5VamXaYpKSJMzRKAt4cFnFqVnoxfg/OvKKCg5Gdhwti5+QNswiD6d1+slcKNcMjM+yZs0uAKcScSyzTO28RVu1NSrtSyU/Ku4ZUeH7ZvzacuvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656771; c=relaxed/simple;
	bh=fNy2ULDybDVWnQvFoGLYUCTR5hbLLshqpI25XobBWkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZhzqY/biJHC5C7aDjbEJC3IHMzRJTBuLmQgIEtHbOmlx+ztFlijMqPBWWuwaslIX6+JJg8Z4Ohn4XuNEguRa+vAAPNtm/OSuHs3CkWp/AooyEavbaHL232QvYcG6UxHvWAKHxQO2krwKWEVAP+1exbpjJ6yztpWEV5Sx0vA+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UM5R2RfB; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Apr 2025 22:05:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743656762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WNARpdbUPSnkit1inDWc8sAf3hL37+HU5+sK+taKmoU=;
	b=UM5R2RfBpH6yPzHKqknVCKOCncJLrdg9ocpISSNbAYz7MLL2hbCVvQX6PBX4usBOn0zU2L
	8MHr5mVrg6/I1q6MSk7W9FeejHGO+MmGmTl8YMa0IUeHhWwZUE/i5h8yBhEvoC3b6LrvFR
	cb2pdD8edbA/7FBrH00mWy3iIyab1Ks=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>, joel.granados@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <7gmvaxj5hpd7aal4xgcis7j7jicwxtlaqjatshrwrorit3jwn6@67j2mc6itkm6>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <Z-2pSF7Zu0CrLBy_@dread.disaster.area>
 <b7qr6djsicpkecrkjk6473btzztfrvxifiy34u2vdb4cp5ktjf@lvg3rtwrbmsx>
 <Z-3i1wATGh6vI8x8@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-3i1wATGh6vI8x8@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 12:22:31PM +1100, Dave Chinner wrote:
> On Wed, Apr 02, 2025 at 04:10:06PM -0700, Shakeel Butt wrote:
> > On Thu, Apr 03, 2025 at 08:16:56AM +1100, Dave Chinner wrote:
> > > On Wed, Apr 02, 2025 at 02:24:45PM +0200, Michal Hocko wrote:
> > > > On Wed 02-04-25 22:32:14, Dave Chinner wrote:
> > > > > Have a look at xlog_kvmalloc() in XFS. It implements a basic
> > > > > fast-fail, no retry high order kmalloc before it falls back to
> > > > > vmalloc by turning off direct reclaim for the kmalloc() call.
> > > > > Hence if the there isn't a high-order page on the free lists ready
> > > > > to allocate, it falls back to vmalloc() immediately.
> > > > > 
> > > > > For XFS, using xlog_kvmalloc() reduced the high-order per-allocation
> > > > > overhead by around 80% when compared to a standard kvmalloc()
> > > > > call. Numbers and profiles were documented in the commit message
> > > > > (reproduced in whole below)...
> > > > 
> > > > Btw. it would be really great to have such concerns to be posted to the
> > > > linux-mm ML so that we are aware of that.
> > > 
> > > I have brought it up in the past, along with all the other kvmalloc
> > > API problems that are mentioned in that commit message.
> > > Unfortunately, discussion focus always ended up on calling context
> > > and API flags (e.g. whether stuff like GFP_NOFS should be supported
> > > or not) no the fast-fail-then-no-fail behaviour we need.
> > > 
> > > Yes, these discussions have resulted in API changes that support
> > > some new subset of gfp flags, but the performance issues have never
> > > been addressed...
> > > 
> > > > kvmalloc currently doesn't support GFP_NOWAIT semantic but it does allow
> > > > to express - I prefer SLAB allocator over vmalloc.
> > > 
> > > The conditional use of __GFP_NORETRY for the kmalloc call is broken
> > > if we try to use __GFP_NOFAIL with kvmalloc() - this causes the gfp
> > > mask to hold __GFP_NOFAIL | __GFP_NORETRY....
> > > 
> > > We have a hard requirement for xlog_kvmalloc() to provide
> > > __GFP_NOFAIL semantics.
> > > 
> > > IOWs, we need kvmalloc() to support kmalloc(GFP_NOWAIT) for
> > > performance with fallback to vmalloc(__GFP_NOFAIL) for
> > > correctness...
> > 
> > Are you asking the above kvmalloc() semantics just for xfs or for all
> > the users of kvmalloc() api? 
> 
> I'm suggesting that fast-fail should be the default behaviour for
> everyone.
> 
> If you look at __vmalloc() internals, you'll see that it turns off
> __GFP_NOFAIL for high order allocations because "reclaim is too
> costly and it's far cheaper to fall back to order-0 pages".
> 
> That's pretty much exactly what we are doing with xlog_kvmalloc(),
> and what I'm suggesting that kvmalloc should be doing by default.
> 
> i.e. If it's necessary for mm internal implementations to avoid
> high-order reclaim when there is a faster order-0 allocation
> fallback path available for performance reasons, then we should be
> using that same behaviour anywhere optimisitic high-order allocation
> is used as an optimisation for those same performance reasons.
> 

I am convinced and I think Michal is onboard as well for the above. At
least we should try and see how it goes.

> The overall __GFP_NOFAIL requirement is something XFS needs, but it
> is most definitely not something that should be enabled by default.
> However, it needs to work with kvmalloc(), and it is not possible to
> do so right now.

After the kmalloc(GFP_NOWAIT) being default in kvmalloc(), what remains
to support kvmalloc(__GFP_NOFAIL)? (Yafang mentioned vmap_huge)


