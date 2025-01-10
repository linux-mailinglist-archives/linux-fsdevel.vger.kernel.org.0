Return-Path: <linux-fsdevel+bounces-38920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056BAA09D87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 23:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9C416B4BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 22:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C3320ADC0;
	Fri, 10 Jan 2025 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PNDVkAZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC05464B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546453; cv=none; b=aTe4BbjbXz+25Cc7w7Prwc95X0LMuVyj/Ou3VOBT6REkl6MAtljdlFZ3d0ETf0kLyhj2x9WltH9dXi3tY5GLYUa+SF18ebuimKZOV48roXT5PSxsrzizi74RhsCVD+QVHXMntent/479DedotI94/lYgAZfyCo3JNidbUfY22so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546453; c=relaxed/simple;
	bh=rKr2x9Sitt8zg+HAkaxYKCuoj3DvasIL3dARRmrmlYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU/EKK3mB4pL/bNDlf8HR1dMDdDSxYAraUSKf3UvQ1JZ8UC73eTXe5FMe9MHcdKh5gyQU36gireEJEzaABiKPWLSgaVYEGKyRGREFKYat2xFwNGdgB73LiXwohsGxcSjW1j1ykM6v8dcclogZTODQMTEDEz54QTkGMdhHpVGKLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PNDVkAZY; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 10 Jan 2025 14:00:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736546443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaxYa+/pvGC0VMVl2r1hPuxMDV9adl0c5vS7IpWG08s=;
	b=PNDVkAZYG2ovbPLBVXu/Ml+vOIPMploI3ZSX8DijqUIkYFTqdwVfCdGnzBxhEuy3/58hbs
	tCzfHFIFhKjveaGUeKqOXZekEZ4M7Ul+0RGz9dWPOfG0ngUQTSBZ/c/rx/dKxF2R/3RPcv
	28oMQdXqL2+MVRYHyJHdRRQ3eAIm0lM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
 <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
 <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 10, 2025 at 10:13:17PM +0100, David Hildenbrand wrote:
> On 10.01.25 21:28, Jeff Layton wrote:
> > On Thu, 2025-01-09 at 12:22 +0100, David Hildenbrand wrote:
> > > On 07.01.25 19:07, Shakeel Butt wrote:
> > > > On Tue, Jan 07, 2025 at 09:34:49AM +0100, David Hildenbrand wrote:
> > > > > On 06.01.25 19:17, Shakeel Butt wrote:
> > > > > > On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
> > > > > > > On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
> > > > > > > > In any case, having movable pages be turned unmovable due to persistent
> > > > > > > > writaback is something that must be fixed, not worked around. Likely a
> > > > > > > > good topic for LSF/MM.
> > > > > > > 
> > > > > > > Yes, this seems a good cross fs-mm topic.
> > > > > > > 
> > > > > > > So the issue discussed here is that movable pages used for fuse
> > > > > > > page-cache cause a problems when memory needs to be compacted. The
> > > > > > > problem is either that
> > > > > > > 
> > > > > > >     - the page is skipped, leaving the physical memory block unmovable
> > > > > > > 
> > > > > > >     - the compaction is blocked for an unbounded time
> > > > > > > 
> > > > > > > While the new AS_WRITEBACK_INDETERMINATE could potentially make things
> > > > > > > worse, the same thing happens on readahead, since the new page can be
> > > > > > > locked for an indeterminate amount of time, which can also block
> > > > > > > compaction, right?
> > > > > 
> > > > > Yes, as memory hotplug + virtio-mem maintainer my bigger concern is these
> > > > > pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where there *must not be
> > > > > unmovable pages ever*. Not triggered by an untrusted source, not triggered
> > > > > by an trusted source.
> > > > > 
> > > > > It's a violation of core-mm principles.
> > > > 
> > > > The "must not be unmovable pages ever" is a very strong statement and we
> > > > are violating it today and will keep violating it in future. Any
> > > > page/folio under lock or writeback or have reference taken or have been
> > > > isolated from their LRU is unmovable (most of the time for small period
> > > > of time).
> > > 
> > > ^ this: "small period of time" is what I meant.
> > > 
> > > Most of these things are known to not be problematic: retrying a couple
> > > of times makes it work, that's why migration keeps retrying.
> > > 
> > > Again, as an example, we allow short-term O_DIRECT but disallow
> > > long-term page pinning. I think there were concerns at some point if
> > > O_DIRECT might also be problematic (I/O might take a while), but so far
> > > it was not a problem in practice that would make CMA allocations easily
> > > fail.
> > > 
> > > vmsplice() is a known problem, because it behaves like O_DIRECT but
> > > actually triggers long-term pinning; IIRC David Howells has this on his
> > > todo list to fix. [I recall that seccomp disallows vmsplice by default
> > > right now]
> > > 
> > > These operations are being done all over the place in kernel.
> > > > Miklos gave an example of readahead.
> > > 
> > > I assume you mean "unmovable for a short time", correct, or can you
> > > point me at that specific example; I think I missed that.

Please see https://lore.kernel.org/all/CAJfpegthP2enc9o1hV-izyAG9nHcD_tT8dKFxxzhdQws6pcyhQ@mail.gmail.com/

> > > 
> > > > The per-CPU LRU caches are another
> > > > case where folios can get stuck for long period of time.
> > > 
> > > Which is why memory offlining disables the lru cache. See
> > > lru_cache_disable(). Other users that care about that drain the LRU on
> > > all cpus.
> > > 
> > > > Reclaim and
> > > > compaction can isolate a lot of folios that they need to have
> > > > too_many_isolated() checks. So, "must not be unmovable pages ever" is
> > > > impractical.
> > > 
> > > "must only be short-term unmovable", better?

Yes and you have clarified further below of the actual amount.

> > > 
> > 
> > Still a little ambiguous.
> > 
> > How short is "short-term"? Are we talking milliseconds or minutes?
> 
> Usually a couple of seconds, max. For memory offlining, slightly longer
> times are acceptable; other things (in particular compaction or CMA
> allocations) will give up much faster.
> 
> > 
> > Imposing a hard timeout on writeback requests to unprivileged FUSE
> > servers might give us a better guarantee of forward-progress, but it
> > would probably have to be on the order of at least a minute or so to be
> > workable.
> 
> Yes, and that might already be a bit too much, especially if stuck on
> waiting for folio writeback ... so ideally we could find a way to migrate
> these folios that are under writeback and it's not your ordinary disk driver
> that responds rather quickly.
> 
> Right now we do it via these temp pages, and I can see how that's
> undesirable.
> 
> For NFS etc. we probably never ran into this, because it's all used in
> fairly well managed environments and, well, I assume NFS easily outdates CMA
> and ZONE_MOVABLE :)
> 
> > >>>
> > > > The point is that, yes we should aim to improve things but in iterations
> > > > and "must not be unmovable pages ever" is not something we can achieve
> > > > in one step.
> > > 
> > > I agree with the "improve things in iterations", but as
> > > AS_WRITEBACK_INDETERMINATE has the FOLL_LONGTERM smell to it, I think we
> > > are making things worse.

AS_WRITEBACK_INDETERMINATE is really a bad name we picked as it is still
causing confusion. It is a simple flag to avoid deadlock in the reclaim
code path and does not say anything about movability.

> > > 
> > > And as this discussion has been going on for too long, to summarize my
> > > point: there exist conditions where pages are short-term unmovable, and
> > > possibly some to be fixed that turn pages long-term unmovable (e.g.,
> > > vmsplice); that does not mean that we can freely add new conditions that
> > > turn movable pages unmovable long-term or even forever.
> > > 
> > > Again, this might be a good LSF/MM topic. If I would have the capacity I
> > > would suggest a topic around which things are know to cause pages to be
> > > short-term or long-term unmovable/unsplittable, and which can be
> > > handled, which not. Maybe I'll find the time to propose that as a topic.
> > > 
> > 
> > 
> > This does sound like great LSF/MM fodder! I predict that this session
> > will run long! ;)
> 
> Heh, fully agreed! :)

I would like more targeted topic and for that I want us to at least
agree where we are disagring. Let me write down two statements and
please tell me where you disagree:

1. For a normal running FUSE server (without tmp pages), the lifetime of
writeback state of fuse folios falls under "short-term unmovable" bucket
as it does not differ in anyway from anyother filesystems handling
writeback folios.

2. For a buggy or untrusted FUSE server (without tmp pages), the
lifetime of writeback state of fuse folios can be arbitrarily long and
we need some mechanism to limit it.

