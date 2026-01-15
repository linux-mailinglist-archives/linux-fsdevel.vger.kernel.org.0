Return-Path: <linux-fsdevel+bounces-73942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6684D25E9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 702E53007F06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE04D274B43;
	Thu, 15 Jan 2026 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OkCmGmZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E23BF2EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496147; cv=none; b=QdByuuzEFznY94Zd+Ilpb6s2NXmOt46SBRKZUGaQcjYRzB5iGXyx7p6a+jyXmF/OP4G/K/C11DwMpTB+u5pJGLAT4wPgeCfjRCJuV76ZqJCQUYHvO8XmlpLtGfVWfBjmvvJADQEpwRzvlEXOgPuwykF28Sxbl9IdJ4RgTi44N2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496147; c=relaxed/simple;
	bh=/HlGffZbbOZ/1UXb3mvKKFsmx2gpC5HpF9dKR3nVclw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5fg0IL2cVZDMMwLDSVz6ikd7nOikRwctBfYjuzBMz/BExX1B6WXYOnJmsNXV3zXbYHZEBPIhrvZ8NXVnNTXzRaG9J4hKEM1xuoBfgrYf41RDqfOPAr78Dr+NyyDZ8tMazOwL981uaEKokBViwSfD8b7NWfRnPHYjCXxqg2PDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OkCmGmZT; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Jan 2026 16:55:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768496138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oN0TuaNOYXt16rCu+jFV5kzSUAKS5IS1k0m12m1o9aA=;
	b=OkCmGmZTlnLaXdUsV+HoNugWY3ZhFbdWednaJHtUzZ1vPpgYt21cQJubRfzCCYlcKC/B+6
	7B0kXUT18tvaZ/7o/q+dIgKTf2MKrNG5GPlQs0MKcv1mOfmD7Md5NF3K4sREyoozvSzTlV
	FkEqH9n+WmZgm82NA56jWhAADHzOb9E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, akpm@linux-foundation.org, 
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com, 
	ziy@nvidia.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, 
	rientjes@google.com, shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	osalvador@suse.de, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <fkxcxh4eilncsbtwt7jmuiaxrfvuidlnbovesa6m7eoif5tmxc@r34c5zy4nr4y>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
 <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
 <aWWEvAaUmpA_0ERP@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWWEvAaUmpA_0ERP@gourry-fedora-PF4VCD3F>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 12, 2026 at 06:33:16PM -0500, Gregory Price wrote:
> On Mon, Jan 12, 2026 at 09:13:26PM +0000, Yosry Ahmed wrote:
> > On Fri, Jan 09, 2026 at 04:40:08PM -0500, Gregory Price wrote:
> > > On Fri, Jan 09, 2026 at 04:00:00PM +0000, Yosry Ahmed wrote:
> > > > On Thu, Jan 08, 2026 at 03:37:54PM -0500, Gregory Price wrote:
> > > 
> > > Hardware Says : 8GB
> > > Hardware Has  : 1GB
> > > Node Capacity : 8GB
> > > 
> > > The capacity numbers are static.  Even with hotplug, they must be
> > > considered static - because the runtime compression ratio can change.
> > > 
> > > If the device fails to achieve a 4:1 compression ratio, and real usage
> > > starts to exceed real capacity - the system will fail.
> > > (dropped writes, poisons, machine checks, etc).
> > > 
> > > We can mitigate this with strong write-controls and querying the device
> > > for compression ratio data prior to actually migrating a page. 
> > 
> > I am a little bit confused about this. Why do we only need to query the
> > device before migrating the page?
> >
> 
> Because there is no other interposition point at which we could.
> Everything is memory semantic - it reduces to memcpy().
> 
> The actual question you're asking is "What happens if we write the page
> and we're out of memory?"
> 
> The answer is:  The page gets poisoned and the write gets dropped.
> 
> That's it.  The writer does not get notified.  The next reader of that
> memory will hit POISON and the failure process will happen (MCE or
> SIGBUS, essentially).
> 
> > Are we checking if the device has enough memory for the worst case
> > scenario (i.e. PAGE_SIZE)?
> > 
> > Or are we checking if the device can compress this specific page and
> > checking if it can compress it and store it? This seems like it could be
> > racy and there might be some throwaway work.
> > 
> 
> We essentially need to capture the current compression ratio and
> real-usage to determine whether there's another page available.
> 
> It is definitely racey, and the best we can do is set reasonable
> real-memory-usage limits to prevent ever finding ourselves in that
> scenario.  That most likely means requiring the hardware send an
> interrupt when usage and/or ratio hit some threshhold and setting a
> "NO ALLOCATION ALLOWED" bit.
> 
> But in software we can also try to query/track this as well, but we may
> not be able to query the device at allocation time (or at least that
> would be horribly non-performant).
> 
> So yeah, it's racy.

Yeah I think we should track it in software if possible to completely
avoid the poison scenario you describe above. Relying on setting a
reasonable limit and a certain compression ratio doesn't sound too
comforting.

> 
> > I guess my question is: why not just give the page to the device and get
> > either: successfully compressed and stored OR failed?
> > 
> 
> Yeah this is what I meant by this whole thing being sunk into the
> callback.  I think that's reasonable.
> 
> > Another question, can the device or driver be configured such that we
> > reject pages that compress poorly to avoid wasting memory and BW on the
> > device for little savings?
> > 
> 
> Memory semantics :]
> 
> memcpy(dst, src) -> no indication of compression ratio

Right..

> 
> > > on *write* access:
> > > - promote to real page
> > > - clean up the compressed page
> > 
> > This makes sense. I am assuming the main benefit of zswap.c over cram.c
> > in this scenario is limiting read accesses as well.
> >
> 
> For the first go, yeah.  A cram.c would need special page table handling
> bits that will take a while to get right.  We can make use of the
> hardware differently in the meantime.

Makes sense.

I just want to point out that using compressed memory with zswap doesn't
buy us much in terms of reclaim latency, so the main goal here is just
saving memory on the top tier, not improving performance, right?

> 
> > > --- assuming there isn't a way and we have to deal with fuzzy math ---
> > > 
> > > The goal should definitely be to leave the charging statistics the same
> > > from the perspective of services - i.e zswap should charge a whole page,
> > > because according to the OS it just used a whole page.
> > > 
> > > What this would mean is memcg would have to work with fuzzy data.
> > > If 1GB is charged and the compression ratio is 4:1, reclaim should
> > > operate (by way of callback) like it has used 256MB.
> > > 
> > > I think this is the best you can do without tracking individual pages.
> > 
> > This part needs more thought. Zswap cannot charge a full page because
> > then from the memcg perspective reclaim is not making any progress.
> > OTOH, as you mention, from the system perspective we just consumed a
> > full page, so not charging that would be inconsistent.
> > 
> > This is not a zswap-specific thing though, even with cram.c we have to
> > figure out how to charge memory on the compressed node to the memcg.
> > It's perhaps not as much of a problem as with zswap because we are not
> > dealing with reclaim not making progress.
> >
> > Maybe the memcg limits need to be "enlightened" about different tiers?
> > We did have such discussions in the past outside the context of
> > compressed memory, for memory tiering in general.
> > 
> > Not sure if this is the right place to discuss this, but I see the memcg
> > folks CC'd so maybe it is :)
> >
> 
> I will probably need some help to get the accounting right if I'm being
> honest.  I can't say I fully understanding the implications here, but
> what you describe makes sense.
> 
> One of the assumptions you have in zswap is that there's some known
> REAL chunk of memory X-GB, and the compression ratio dictates that you
> get to cram more than X-GB of data in there.
> 
> This device flips that on its head.  It lies to the system and says
> there's X-GB, and you can only actually use a fraction of it in the
> worst case - and in the best case you use all of it.
> 
> So in that sense, zswap has "infinite upside" (if you're infinitely
> compressible), whereas this device has "limited upside" (node capacity).
> 
> That changes how you account for things entirely, and that's why
> entry->length always has to be PAGE_SIZE.  Even if the device can tell
> us the real size, i'm not sure how useful that is - you still have to
> charge for an entire `struct page`.
> 
> Time for a good long :think:

Yeah it's counter-intuitive. Zswap needs to charge less than PAGE_SIZE
so that memcg tracking continues to make sense with reclaim (i.e. usage
goes down), but if zswap consumed a full page from the system
perspective, the math won't math.

Separate limits *could* be the answer, but it's harder to configure and
existing configuration won't "just work" with compressed memory.

> 
> > > 
> > > This is ignorance of zswap on my part, and yeah good point.  Will look
> > > into this accounting a little more.
> > 
> > This is similar-ish to the memcg charging problem, how do we count the
> > compressed memory usage toward the global zswap limit? Do we keep this
> > limit for the top-tier? If not, do we charge full size for pages in
> > c.zswap or compressed size?
> > 
> > Do we need a separate limit for c.zswap? Probably not if the whole node
> > is dedicated for zswap usage.
> >
> 
> Since we're accounting for entire `struct page` usage vs the hard cap of
> (device_capcity / PAGE_SIZE) - then this might actually be the answer.
> 
> > > 
> > > Thank you again for taking a look, this has been enlightening.  Good
> > > takeaways for the rest of the N_PRIVATE design.
> > 
> > Thanks for kicking off the discussion here, an interesting problem to
> > solve for sure :)
> > 
> 
> One of the more interesting ones i've had in a few years :]
> 
> Cheers,
> ~Gregory

