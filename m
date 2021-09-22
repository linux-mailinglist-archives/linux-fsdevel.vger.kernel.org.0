Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C841417F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 08:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhIVGGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 02:06:25 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:36692 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232490AbhIVGGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:06:24 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 218341BC362;
        Wed, 22 Sep 2021 16:04:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mSvN9-00FJVY-TE; Wed, 22 Sep 2021 16:04:47 +1000
Date:   Wed, 22 Sep 2021 16:04:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     NeilBrown <neilb@suse.de>, Linux-MM <linux-mm@kvack.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
Message-ID: <20210922060447.GA2361455@dread.disaster.area>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <20210920085436.20939-2-mgorman@techsingularity.net>
 <163218319798.3992.1165186037496786892@noble.neil.brown.name>
 <20210921105831.GO3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921105831.GO3959@techsingularity.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=XCLsOYAi7itVMiQYH0cA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:58:31AM +0100, Mel Gorman wrote:
> On Tue, Sep 21, 2021 at 10:13:17AM +1000, NeilBrown wrote:
> > On Mon, 20 Sep 2021, Mel Gorman wrote:
> > > -long wait_iff_congested(int sync, long timeout)
> > > -{
> > > -	long ret;
> > > -	unsigned long start = jiffies;
> > > -	DEFINE_WAIT(wait);
> > > -	wait_queue_head_t *wqh = &congestion_wqh[sync];
> > > -
> > > -	/*
> > > -	 * If there is no congestion, yield if necessary instead
> > > -	 * of sleeping on the congestion queue
> > > -	 */
> > > -	if (atomic_read(&nr_wb_congested[sync]) == 0) {
> > > -		cond_resched();
> > > -
> > > -		/* In case we scheduled, work out time remaining */
> > > -		ret = timeout - (jiffies - start);
> > > -		if (ret < 0)
> > > -			ret = 0;
> > > -
> > > -		goto out;
> > > -	}
> > > -
> > > -	/* Sleep until uncongested or a write happens */
> > > -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> > 
> > Uninterruptible wait.
> > 
> > ....
> > > +static void
> > > +reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> > > +							long timeout)
> > > +{
> > > +	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
> > > +	unsigned long start = jiffies;
> > > +	long ret;
> > > +	DEFINE_WAIT(wait);
> > > +
> > > +	atomic_inc(&pgdat->nr_reclaim_throttled);
> > > +	WRITE_ONCE(pgdat->nr_reclaim_start,
> > > +		 node_page_state(pgdat, NR_THROTTLED_WRITTEN));
> > > +
> > > +	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
> > 
> > Interruptible wait.
> > 
> > Why the change?  I think these waits really need to be TASK_UNINTERRUPTIBLE.
> > 
> 
> Because from mm/ context, I saw no reason why the task *should* be
> uninterruptible. It's waiting on other tasks to complete IO and it is not
> protecting device state, filesystem state or anything else. If it gets
> a signal, it's safe to wake up, particularly if that signal is KILL and
> the context is a direct reclaimer.

I disagree. whether the sleep should be interruptable or
not is entirely dependent on whether the caller can handle failure
or not. If this is GFP_NOFAIL, allocation must not fail no matter
what the context is, so signals and the like are irrelevant.

For a context that can handle allocation failure, then it makes
sense to wake on events that will result in the allocation failing
immediately. But if all this does is make the allocation code go
around another retry loop sooner, then an interruptible sleep still
doesn't make any sense at all here...

> The original TASK_UNINTERRUPTIBLE is almost certainly a copy&paste from
> congestion_wait which may be called because a filesystem operation must
> complete before it can return to userspace so a signal waking it up is
> pointless.

Yup, but that AFAICT that same logic still applies. Only now it's
the allocation context that determines whether signal waking is
pointless or not...

Cheer,

Dave.
-- 
Dave Chinner
david@fromorbit.com
