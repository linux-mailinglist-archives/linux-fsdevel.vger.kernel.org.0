Return-Path: <linux-fsdevel+bounces-11072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD11850CDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 03:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A710E1F24A61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 02:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5413FDB;
	Mon, 12 Feb 2024 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GxbPFSd2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D91848
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707703602; cv=none; b=Lb68AkF3jlFdpg1uN4k4enFSWZix7pLxIGtXbefzsQuPKhOh+czm8F6yepk3c93FoXbsUwWj0RZEfy7bEECFyxXa1WAuZ4OzTXk6ZY4OmhfInUr5MCJUS5vSuM8DidZ2l20xuLvzpNivIxtZaWxT/WtjmQSmO9FuS4pt441e+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707703602; c=relaxed/simple;
	bh=PtR6O5zZ11yErUWhE9os+Sw1jkakz3YXuvpeb+zUVY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW8O89C/K9ZB5fcRYTBWzBrfWojMGSe5Mu+OBLgnmQ4U6Y+yaGnzwr5mJZhGXrhy2g+5EItAjpWcCYavuagS49PAPsODPDEJOYLasUysyelDsrlDQSOw8Q7Oavt0uk4UUNkfawaXe1Pkxtg2owRtDGUcgs6tzo2dUqE2/Q9H7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GxbPFSd2; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 11 Feb 2024 21:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707703598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODlaXhkp4vNT3K0AelVxp1/w7y1kMZExEnw/9cBEPxU=;
	b=GxbPFSd26AFaNHCeMPJ02uyrdsbSMtgY+mZM1EFMOAauPC7HPf+I9ClVXfiBaoYx0XD23/
	u0MT8umyB5uGwJ6JBSJH23EzW85RaPUn2PCFDyi07wGWg8RFh4aatF/e8vO2nCaAXTh6Kz
	OCc6I8tCD9HbuCTq3aRTDGozxbRosrs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <5p4zwxtfqwm3wgvzwqfg6uwy5m3lgpfypij4fzea63gu67ve4t@77to5kukmiic>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
 <ZcUQfzfQ9R8X0s47@tiehlicka>
 <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
 <ZclyYBO0vcQHZ5dV@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZclyYBO0vcQHZ5dV@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 12, 2024 at 12:20:32PM +1100, Dave Chinner wrote:
> On Thu, Feb 08, 2024 at 08:55:05PM +0100, Vlastimil Babka (SUSE) wrote:
> > On 2/8/24 18:33, Michal Hocko wrote:
> > > On Thu 08-02-24 17:02:07, Vlastimil Babka (SUSE) wrote:
> > >> On 1/9/24 05:47, Dave Chinner wrote:
> > >> > On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
> > >> 
> > >> Your points and Kent's proposal of scoped GFP_NOWAIT [1] suggests to me this
> > >> is no longer FS-only topic as this isn't just about converting to the scoped
> > >> apis, but also how they should be improved.
> > > 
> > > Scoped GFP_NOFAIL context is slightly easier from the semantic POV than
> > > scoped GFP_NOWAIT as it doesn't add a potentially unexpected failure
> > > mode. It is still tricky to deal with GFP_NOWAIT requests inside the
> > > NOFAIL scope because that makes it a non failing busy wait for an
> > > allocation if we need to insist on scope NOFAIL semantic. 
> > > 
> > > On the other hand we can define the behavior similar to what you
> > > propose with RETRY_MAYFAIL resp. NORETRY. Existing NOWAIT users should
> > > better handle allocation failures regardless of the external allocation
> > > scope.
> > > 
> > > Overriding that scoped NOFAIL semantic with RETRY_MAYFAIL or NORETRY
> > > resembles the existing PF_MEMALLOC and GFP_NOMEMALLOC semantic and I do
> > > not see an immediate problem with that.
> > > 
> > > Having more NOFAIL allocations is not great but if you need to
> > > emulate those by implementing the nofail semantic outside of the
> > > allocator then it is better to have those retries inside the allocator
> > > IMO.
> > 
> > I see potential issues in scoping both the NOWAIT and NOFAIL
> > 
> > - NOFAIL - I'm assuming Dave is adding __GFP_NOFAIL to xfs allocations or
> > adjacent layers where he knows they must not fail for his transaction. But
> > could the scope affect also something else underneath that could fail
> > without the failure propagating in a way that it affects xfs?
> 
> Memory allocaiton failures below the filesystem (i.e. in the IO
> path) will fail the IO, and if that happens for a read IO within
> a transaction then it will have the same effect as XFS failing a
> memory allocation. i.e. it will shut down the filesystem.
> 
> The key point here is the moment we go below the filesystem we enter
> into a new scoped allocation context with a guaranteed method of
> returning errors: NOIO and bio errors.

Hang on, you're conflating NOIO to mean something completely different -
NOIO means "don't recurse in reclaim", it does _not_ mean anything about
what happens when the allocation fails, and in particular it definitely
does _not_ mean that failing the allocation is going to result in an IO
error.

That's because in general most code in the IO path knows how to make
effective use of biosets and mempools (which may take some work! you
have to ensure that you're always able to make forward progress when
memory is limited, and in particular that you don't double allocate from
the same mempool if you're blocking the first allocation from
completing/freeing).

> i.e NOFAIL scopes are not relevant outside the subsystem that sets
> it.  Hence we likely need helpers to clear and restore NOFAIL when
> we cross an allocation context boundaries. e.g. as we cross from
> filesystem to block layer in the IO stack via submit_bio(). Maybe
> they should be doing something like:
> 
> 	nofail_flags = memalloc_nofail_clear();

NOFAIL is not a scoped thing at all, period; it is very much a
_callsite_ specific thing, and it depends on whether that callsite has a
fallback.

The most obvious example being, as mentioned previously, mempools.

> > - NOWAIT - as said already, we need to make sure we're not turning an
> > allocation that relied on too-small-to-fail into a null pointer exception or
> > BUG_ON(!page).
> 
> Agreed. NOWAIT is removing allocation failure constraints and I
> don't think that can be made to work reliably. Error injection
> cannot prove the absence of errors  and so we can never be certain
> the code will always operate correctly and not crash when an
> unexepected allocation failure occurs.

You saying we don't know how to test code? Come on, that's just throwing
your hands up and giving up. We can write error injection tests that
cycle through each injection point and test them individuall and then
verify that they've been tested with coverage analysis.

Anyways, NOWAIT is no different here from NORETRY/RETRY_MAYFAIL. We need
to be able to handle allocation failures, period...

