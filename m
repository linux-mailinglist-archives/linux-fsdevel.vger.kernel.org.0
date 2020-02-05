Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482EE153506
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 17:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgBEQMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 11:12:18 -0500
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:53483 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbgBEQMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:12:18 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Feb 2020 11:12:15 EST
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 250B1FA982
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2020 16:05:53 +0000 (GMT)
Received: (qmail 17834 invoked from network); 5 Feb 2020 16:05:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Feb 2020 16:05:52 -0000
Date:   Wed, 5 Feb 2020 16:05:51 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
Message-ID: <20200205160551.GI3466@techsingularity.net>
References: <20191231125908.GD6788@bombadil.infradead.org>
 <20200106115514.GG12699@dhcp22.suse.cz>
 <20200106232100.GL23195@dread.disaster.area>
 <20200109110751.GF27035@quack2.suse.cz>
 <20200109230043.GS23195@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200109230043.GS23195@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This thread is ancient but I'm only getting to it now, to express an
interest in the general discussion as much as anything else.

On Fri, Jan 10, 2020 at 10:00:43AM +1100, Dave Chinner wrote:
> > I don't think so... So I think that to solve this
> > problem in a robust way, we need to provide a mechanism for slab shrinkers
> > to say something like "hang on, I can reclaim X objects you asked for but
> > it will take time, I'll signal to you when they are reclaimable". This way
> > we avoid blocking in the shrinker and can do more efficient async batched
> > reclaim and on mm side we have the freedom to either wait for slab reclaim
> > to progress (if this slab is fundamental to memory pressure) or just go try
> > reclaim something else. Of course, the devil is in the details :).
> 
> That's pretty much exactly what my non-blocking XFS inode reclaim
> patches do. It tries to scan, but when it can't make progress it
> sets a "need backoff" flag and defers the remaining work and expects
> the high level code to make a sensible back-off decision.
> 
> The problem is that the decision the high level code makes at the
> moment is not sensible - it is "back off for a bit, then increase
> the reclaim priority and reclaim from the page cache again. That;s
> what is driving the swap storms - inode reclaim says "back-off" and
> stops trying to do reclaim, and that causes the high level code to
> reclaim the page cache harder.
> 
> OTOH, if we *block in the inode shrinker* as we do now, then we
> don't increase reclaim priority (and hence the amount of page cache
> scanning) and so the reclaim algorithms don't drive deeply into
> swap-storm conditions.
> 
> That's the fundamental problem here - we need to throttle reclaim
> without *needing to restart the entire high level reclaim loop*.
> This is an architecture problem more than anything - node and memcg
> aware shrinkers outnumber the page cache LRU zones by a large
> number, but we can't throttle on individual shrinkers and wait for
> them to make progress like we can individual page LRU zone lists.
> Hence if we want to throttle an individual shrinker, the *only
> reliable option* we currently have is for the shrinker to block
> itself.
> 

Despite the topic name, I learning towards thinking that this is not a
congestion issue as such. The throttling mechanism based on BDI partially
solved old problems of swap storm, direct relaim issued writeback
(historical) or excessive scanning leading to premature OOM kill. When
reclaim stopped issuing waiting on writeback it had to rely on congestion
control instead and it always was a bit fragile but mostly worked until
hardware moved on, storage got faster, memories got larger, or did
something crazy like buy a second disk.

The  commonmreason that stalling would occur is because large amounts of
dirty/writeback pages were encountered at the tail of the LRU leading to
large amounts of CPU time spent on useless scanning and increasing scan
rates until OOM occurred. It never took into account any other factor
like shrinker state.

But fundamentally what gets a process into trouble is when "reclaim
efficiency" drops. Efficiency is the ratio between reclaim scan and
reclaim steal with perfect efficiency being one page scanned results in
one page reclaimed. As long as reclaim efficiency is perfect, a system
may be thrashing but it's not stalling on writeback. It may still be
stalling on read but that tends to be less harmful.

Blocking on "congestion" caught one very bad condition where efficiency
drops -- excessive dirty/writeback pages on the tail of the file LRU. It
happened to be a common condition such as if a USB stick was being written
but not the only one. When it happened, excessive clean file pages would
be taken, swap storms occur and the system thrashes while the dirty
pages are being cleaned.

In roughly in order of severity the most relevant causes of efficiency
drops that come to mind are

o page is unevictable due to mlock (goes to separate list)
o page is accessed and gets activated
o THP has to be split and does another lap through the LRU
o page could not be unmapped (probably heavily shared and should be
  activated anyway)
o page is dirty/writeback and goes back on the LRU
o page has associated buffers that cannot be freed

While I'm nowhere near having enough time to write a prototype, I think
it could be throttle reclaim based on recent allocation rate and the
contributors to poor reclaim efficiency.

Recent allocation rate is appropriate because processes dirtying memory
should get caught in balance_dirty_page. It's only heavy allocators that
can drive excessive reclaim for multiple unrelated processes. So first,
try and keep a rough track of the recent allocation rate or maybe just
something like the number of consecutive allocations that entered the
slow path due to a low watermark failure.

Once a task enters direct reclaim, track the reasons for poor reclaim
efficiency (like the list above but maybe add shrinkers) and calculate a
score based on weight. An accessed page would have a light weight, a dirty
page would have a heavy weight. Shrinkers could apply some unknown weight
but I don't know what might be sensible or what the relative weighting
would be.

If direct reclaim should continue for another loop, wait on a per-node
waitqueue until kswapd frees pages above the high watermark or a
timeout. The length of the timeout would depend on how heavy an allocator
the process is and the reasons why reclaim efficiency was dropping. The
timeout costs should accumulate while a task remains in direct reclaim
to limit the chance that an unrelated process is punished.

It's all hand-waving but I think this would be enough to detect a heavy
allocator encountering lots of dirty pages at the tail of the LRU at high
frequency without relying on BDI congestion detection. The downside is if
the system really is thrashing then a light allocator can become a heavy
allocator because it's trying to read itself from swap or fetch hot data.

> And, realistically, to make this all work in a consistent manner,
> the zone LRU walkers really should be transitioned to run as shrinker
> instances that are node and memcg aware, and so they do individual
> backoff and throttling in the same manner that large slab caches do.
> This way we end up with an integrated, consistent high level reclaim
> management architecture that automatically balances page cache vs
> slab cache reclaim balance...
> 

That'd probably make more sense but I don't think it would be mandatory
to get some basic replacement for wait_iff_congested working.

-- 
Mel Gorman
SUSE Labs
