Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6126140CF81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 00:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhIOWk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 18:40:27 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:37072 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229538AbhIOWk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:40:26 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 4357499FB;
        Thu, 16 Sep 2021 08:39:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mQdYQ-00CvLU-9f; Thu, 16 Sep 2021 08:38:58 +1000
Date:   Thu, 16 Sep 2021 08:38:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
Message-ID: <20210915223858.GM2361455@dread.disaster.area>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
 <20210914163432.GR3828@suse.com>
 <20210914235535.GL2361455@dread.disaster.area>
 <20210915085904.GU3828@suse.com>
 <20210915143510.GE3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915143510.GE3959@techsingularity.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=rs-OYbL5b6b9dbSePnwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 03:35:10PM +0100, Mel Gorman wrote:
> On Wed, Sep 15, 2021 at 09:59:04AM +0100, Mel Gorman wrote:
> > > Yup, that's what we need, but I don't see why it needs to be exposed
> > > outside the allocation code at all.
> > > 
> > 
> > Probably not. At least some of it could be contained within reclaim
> > itself to block when reclaim is not making progress as opposed to anything
> > congestion related. That might still livelock if no progress can be made
> > but that's not new, the OOM hammer should eventually kick in.
> > 
> 
> There are two sides to the reclaim-related throttling
> 
> 1. throttling because zero progress is being made
> 2. throttling because there are too many dirty pages or pages under
>    writeback cycling through the LRU too quickly.
> 
> The dirty page aspects (and the removal of wait_iff_congested which is
> almost completely broken) could be done with something like the following
> (completly untested). The downside is that end_page_writeback() takes an
> atomic penalty if reclaim is throttled but at that point the system is
> struggling anyway so I doubt it matters.

The atomics are pretty nasty, as is directly accessing the pgdat on
every call to end_page_writeback(). Those will be performance
limiting factors. Indeed, we don't use atomics for dirty page
throttling, which does dirty page accounting via
percpu counters on the BDI and doesn't require wakeups.

Also, we've already got per-node and per-zone counters there for
dirty/write pending stats, so do we actually need new counters and
wakeups here?

i.e. balance_dirty_pages() does not have an explicit wakeup - it
bases it's sleep time on the (memcg aware) measured writeback rate
on the BDI the page belongs to and the amount of outstanding dirty
data on that BDI. i.e. it estimates fairly accurately what the wait
time for this task should be given the dirty page demand and current
writeback progress being made is and just sleeps for that length of
time.

Ideally, that's what should be happening here - we should be able to
calculate a page cleaning rate estimation and then base the sleep
time on that. No wakeups needed - when we've waited for the
estimated time, we try to reclaim again...

In fact, why can't this "too many dirty pages" case just use the
balance_dirty_pages() infrastructure to do the "wait for writeback"
reclaim backoff? Why do we even need to re-invent the wheel here?

> diff --git a/mm/filemap.c b/mm/filemap.c
> index dae481293b5d..b9be9afa4308 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1606,6 +1606,8 @@ void end_page_writeback(struct page *page)
>  	smp_mb__after_atomic();
>  	wake_up_page(page, PG_writeback);
>  	put_page(page);
> +
> +	acct_reclaim_writeback(page);

UAF - that would need to be before the put_page() call...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
