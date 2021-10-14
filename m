Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560FC42D76D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 12:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJNKtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 06:49:53 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:56656 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230264AbhJNKtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:49:52 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id D87DC1E006
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Oct 2021 11:47:45 +0100 (IST)
Received: (qmail 19320 invoked from network); 14 Oct 2021 10:47:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Oct 2021 10:47:45 -0000
Date:   Thu, 14 Oct 2021 11:47:44 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
Message-ID: <20211014104744.GY3959@techsingularity.net>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
 <20211008135332.19567-2-mgorman@techsingularity.net>
 <63898e7a-0846-3105-96b5-76c89635e499@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <63898e7a-0846-3105-96b5-76c89635e499@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Vlastimil

On Wed, Oct 13, 2021 at 05:39:36PM +0200, Vlastimil Babka wrote:
> > +/*
> > + * Account for pages written if tasks are throttled waiting on dirty
> > + * pages to clean. If enough pages have been cleaned since throttling
> > + * started then wakeup the throttled tasks.
> > + */
> > +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
> > +							int nr_throttled)
> > +{
> > +	unsigned long nr_written;
> > +
> > +	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);
> 
> Is this intentionally using the __ version that normally expects irqs to be
> disabled (AFAIK they are not in this path)? I think this is rarely used cold
> path so it doesn't seem worth to trade off speed for accuracy.
> 

It was intentional because IRQs can be disabled and if it's race-prone,
it's not overly problematic but you're right, better to be safe.  I changed
it to the safe type as it's mostly free on x86, arm64 and s390 and for
other architectures, this is a slow path.

> > +	nr_written = node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
> > +		READ_ONCE(pgdat->nr_reclaim_start);
> 
> Even if the inc above was safe, node_page_state() will return only the
> global counter, so the value we read here will only actually increment when
> some cpu's counter overflows, so it will be "bursty". Maybe it's ok, just
> worth documenting?
> 

I didn't think the penalty of doing an accurate read while writeback
throttled is worth it. I'll add a comment.

> > +
> > +	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
> > +		wake_up_all(&pgdat->reclaim_wait);
> 
> Hm it seems a bit weird that the more tasks are throttled, the more we wait,
> and then wake up all. Theoretically this will lead to even more
> bursty/staggering herd behavior. Could be better to wake up single task each
> SWAP_CLUSTER_MAX, and bump nr_reclaim_start? But maybe it's not a problem in
> practice due to HZ/10 timeouts being short enough?
> 

Yes, the more tasks are throttled the longer tasks wait because tasks are
allocating faster than writeback can complete so I wanted to reduce the
allocation pressure. I considered waking one task at a time but there is
no prioritisation of tasks on the waitqueue and it's not clear that the
additional complexity is justified. With inaccurate counters, a light
allocator could get throttled for the full timeout unnecessarily.

Even if we were to wake one task at a time, I would prefer it was done
as a potential optimisation on top.

Diff on top based on review feedback;

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bcd22e53795f..735b1f2b5d9e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1048,7 +1048,15 @@ void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
 {
 	unsigned long nr_written;
 
-	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);
+	inc_node_page_state(page, NR_THROTTLED_WRITTEN);
+
+	/*
+	 * This is an inaccurate read as the per-cpu deltas may not
+	 * be synchronised. However, given that the system is
+	 * writeback throttled, it is not worth taking the penalty
+	 * of getting an accurate count. At worst, the throttle
+	 * timeout guarantees forward progress.
+	 */
 	nr_written = node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
 		READ_ONCE(pgdat->nr_reclaim_start);

