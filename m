Return-Path: <linux-fsdevel+bounces-45548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C280AA7951B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE5316F488
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E41C07D9;
	Wed,  2 Apr 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PySjimlQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DA80B
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618620; cv=none; b=AfokXG62j4haZ8bwolBghJHgUIIV3K30Kh4reCWCMQY2FJ+7kv8hScMe0P22Koi3HBYI3gMfNvMRSQ4kN6HTv5E8ROH2G27L+ezvfG6A3YZc2V7mduIpu7ekt2poSYLX7SGXRKNiZHizkqnny2fCzK3u9Pk/gOqog8Z4szhq218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618620; c=relaxed/simple;
	bh=5x2issN15vB42zgZIfNc/uBiGhxFXgYG5j4rbXf2OPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0EXi7W1a40JpMpat6ktlhvpcKYjXd5LX+69R6MmYRPivtNzBIahXGPppZaiWEvEfs/ehEn27EWam+NXh1QCAu3tm/Xc5YWC3asVlYDzA+anxaUdL6RyhB4gisIKKB3OlY075mqAWyrWJe1nIZGRziaqJLM7MYcggGFt6Nk9IaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PySjimlQ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Apr 2025 11:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743618615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RRd3SQcvztMwM6nVkcAFoWMZZ4yVqjmYprozJgTEDhQ=;
	b=PySjimlQBSxDpoJBYRyJxPQX5UpQ3bEXK4WqSxSBQq3lQsdjcZ3pft3X45O3k9kKcmTIxp
	qnZtHY0MvLbowPwWBVCXOWBHpr/KAWGybO6i7YS4frnUMuYCtrHjbTedEihOjnwzqkxHpt
	YUA+D+cNrQ4LgfNb3wc5WN7NV3Szmak=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>, 
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <vwlkfkkz3hezfwedklvybe3lhy2haz2l5fmcojmcjjwj3axye7@ac7junf6ay2f>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <Z-1yui_QgubgRAmL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-1yui_QgubgRAmL@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 02, 2025 at 06:24:10PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 02, 2025 at 02:24:45PM +0200, Michal Hocko wrote:
> > On Wed 02-04-25 22:32:14, Dave Chinner wrote:
> > > > > > >+    /*
> > > > > > >+     * Use vmalloc if the count is too large to avoid costly high-order page
> > > > > > >+     * allocations.
> > > > > > >+     */
> > > > > > >+    if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> > > > > > >+            kbuf = kvzalloc(count + 1, GFP_KERNEL);
> > > > > >
> > > > > > Why not move this check into kvmalloc family?
> > > > >
> > > > > Hmm should this check really be in kvmalloc family?
> > > > 
> > > > Modifying the existing kvmalloc functions risks performance regressions.
> > > > Could we instead introduce a new variant like vkmalloc() (favoring
> > > > vmalloc over kmalloc) or kvmalloc_costless()?
> > > 
> > > We should fix kvmalloc() instead of continuing to force
> > > subsystems to work around the limitations of kvmalloc().
> > 
> > Agreed!
> > 
> > > Have a look at xlog_kvmalloc() in XFS. It implements a basic
> > > fast-fail, no retry high order kmalloc before it falls back to
> > > vmalloc by turning off direct reclaim for the kmalloc() call.
> > > Hence if the there isn't a high-order page on the free lists ready
> > > to allocate, it falls back to vmalloc() immediately.
> 
> ... but if vmalloc fails, it goes around again!  This is exactly why
> we don't want filesystems implementing workarounds for MM problems.
> What a mess.
> 
> >  	if (size > PAGE_SIZE) {
> >  		flags |= __GFP_NOWARN;
> >  
> >  		if (!(flags & __GFP_RETRY_MAYFAIL))
> >  			flags |= __GFP_NORETRY;
> > +		else
> > +			flags &= ~__GFP_DIRECT_RECLAIM;
> 
> I think it might be better to do this:
> 
> 		flags |= __GFP_NOWARN;
> 
> 		if (!(flags & __GFP_RETRY_MAYFAIL))
> 			flags |= __GFP_NORETRY;
> +		else if (size > (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> +			flags &= ~__GFP_DIRECT_RECLAIM;

The above seems more appropriate then the Michal's bigger hammer.
In addition I think Vlastimil has a very good point about the kswapd
reclaim for such cases (the patch explicitly complains about kcompactd
cpu usage).

> 
> I think it's entirely appropriate for a call to kvmalloc() to do
> direct reclaim if it's asking for, say, 16KiB and we don't have any of
> those available.  Better than exacerbating the fragmentation problem by
> allocating 4x4KiB pages, each from different groupings.

