Return-Path: <linux-fsdevel+bounces-28456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9587396AD1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 01:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177131F25486
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 23:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A51D79A6;
	Tue,  3 Sep 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hrUItIpq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E259B647
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725407631; cv=none; b=YFKxJoIk7Nq2ViDr7o/4frV2RI/APpJdOAaSVwi8bX8VD/b9YCGDweXOJagopUims3Q34jQ5hW+p2veLOEiHYiW6A/B9etxV/gh0h8AAeU9gkelnd5syLofebZoLfU00mulFjSOwGwjC/wXp+Nspzh07UcQFm7iExfCbqiSiICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725407631; c=relaxed/simple;
	bh=X3asc9AUtZ5RGKcxdf+XMkzOIMZf7QXdviF+ggzC3Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiWH/OKD0PxgTxl0mYbgh+n8Tzl+7bnm+zpEuOv7ldOGXT6UybzSBpioQgw/bsm72WpIiooy749zNkZBvTe4m1upoVASy6yM0SDKlhcM/QqrmuRUD/K3Zm9ghZF5dKjJtZQ9mYJWGVlZSz7hKd4R3uBcNZI4mK94zRBmXdcZQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hrUItIpq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Sep 2024 19:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725407627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X6EYjF5RW8jhRsqnvywWRVkgXq/RsPBX3XbDK1ZCeIo=;
	b=hrUItIpqCMHs0ZwSqX3d6Cog07XIbIbkabXOH6dINQk1DaIRS0cqUjk2LcYTcQ9qhghNMI
	pfSq8RJ946z7zYHtCAu2ETRyKQcjOivZjXmPIRYpapN7IILKqa6n/qvdTqqPSJUoSU5+m0
	g2BkWPLHOIAw4m+r2z2gO0We1OQUXPs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <qlkjvxqdm72ijaaiauifgsnyzx3mw4edl2hexfabnsdncvpyhd@dvxliffsmkl6>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 02, 2024 at 06:32:40PM GMT, Kent Overstreet wrote:
> On Mon, Sep 02, 2024 at 02:52:52PM GMT, Andrew Morton wrote:
> > On Mon, 2 Sep 2024 05:53:59 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > 
> > > On Mon, Sep 02, 2024 at 11:51:48AM GMT, Michal Hocko wrote:
> > > > The previous version has been posted in [1]. Based on the review feedback
> > > > I have sent v2 of patches in the same threat but it seems that the
> > > > review has mostly settled on these patches. There is still an open
> > > > discussion on whether having a NORECLAIM allocator semantic (compare to
> > > > atomic) is worthwhile or how to deal with broken GFP_NOFAIL users but
> > > > those are not really relevant to this particular patchset as it 1)
> > > > doesn't aim to implement either of the two and 2) it aims at spreading
> > > > PF_MEMALLOC_NORECLAIM use while it doesn't have a properly defined
> > > > semantic now that it is not widely used and much harder to fix.
> > > > 
> > > > I have collected Reviewed-bys and reposting here. These patches are
> > > > touching bcachefs, VFS and core MM so I am not sure which tree to merge
> > > > this through but I guess going through Andrew makes the most sense.
> > > > 
> > > > Changes since v1;
> > > > - compile fixes
> > > > - rather than dropping PF_MEMALLOC_NORECLAIM alone reverted eab0af905bfc
> > > >   ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN") suggested
> > > >   by Matthew.
> > > 
> > > To reiterate:
> > > 
> > 
> > It would be helpful to summarize your concerns.
> > 
> > What runtime impact do you expect this change will have upon bcachefs?
> 
> For bcachefs: I try really hard to minimize tail latency and make
> performance robust in extreme scenarios - thrashing. A large part of
> that is that btree locks must be held for no longer than necessary.
> 
> We definitely don't want to recurse into other parts of the kernel,
> taking other locks (i.e. in memory reclaim) while holding btree locks;
> that's a great way to stack up (and potentially multiply) latencies.
> 
> But gfp flags don't work with vmalloc allocations (and that's unlikely
> to change), and we require vmalloc fallbacks for e.g. btree node
> allocation. That's the big reason we want MEMALLOC_PF_NORECLAIM.
> 
> Besides that, it's just cleaner, memalloc flags are the direction we
> want to be moving in, and it's going to be necessary if we ever want to
> do a malloc() that doesn't require a gfp flags parameter. That would be
> a win for safety and correctness in the kernel, and it's also likely
> required for proper Rust support.
> 
> And the "GFP_NOFAIL must not fail" argument makes no sense, because a
> failing a GFP_NOFAIL allocation is the only sane thing to do if the
> allocation is buggy (too big, i.e. resulting from an integer overflow
> bug, or wrong context). The alternatives are at best never returning
> (stuck unkillable process), or a scheduling while atomic bug, or Michal
> was even proposing killing the process (handling it like a BUG()!).
> 
> But we don't use BUG_ON() for things that we can't prove won't happen in
> the wild if we can write an error path.
> 
> That is, PF_MEMALLOC_NORECLAIM lets us turn bugs into runtime errors.

BTW, one of the reasons I've been giving this issue so much attention is
because of filesystem folks mentioning that they want GFP_NOFAIL
semantics more widely, and I actually _don't_ think that's a crazy idea,
provided we go about it the right way.

Not having error paths is right out; many allocations when you start to
look through more obscure code have sizes that are controlled by
userspace, so we'd be opening ourselves up to trivially expoitable
security bugs.

However, if we agreed that GFP_NOFAIL meant "only fail if it is not
possible to satisfy this allocation" (and I have been arguing that that
is the only sane meaning) - then that could lead to a lot of error paths
getting simpler.

Because there are a lot of places where there's essentially no good
reason to bubble up an -ENOMEM to userspace; if we're actually out of
memory the current allocation is just one out of many and not
particularly special, better to let the oom killer handle it...

So the error paths would be more along the lines of "there's a bug, or
userspace has requested something crazy, just shut down gracefully".

While we're at it, the definition of what allocation size is "too big"
is something we'd want to look at. Right now it's hardcoded to INT_MAX
for non GFP_NOFAIL and (I believe) 2 pages for GFP_NOFAL, we might want
to consider doing something based on total memory in the machine and
have the same limit apply to both...



