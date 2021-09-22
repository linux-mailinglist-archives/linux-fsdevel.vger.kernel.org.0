Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39B2414331
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhIVIFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 04:05:24 -0400
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:49727 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233390AbhIVIFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:05:23 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id 3A628FBD26
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 09:03:53 +0100 (IST)
Received: (qmail 15258 invoked from network); 22 Sep 2021 08:03:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Sep 2021 08:03:52 -0000
Date:   Wed, 22 Sep 2021 09:03:51 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <20210922080351.GU3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <20210920085436.20939-2-mgorman@techsingularity.net>
 <163218319798.3992.1165186037496786892@noble.neil.brown.name>
 <20210921105831.GO3959@techsingularity.net>
 <20210922060447.GA2361455@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210922060447.GA2361455@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 04:04:47PM +1000, Dave Chinner wrote:
> On Tue, Sep 21, 2021 at 11:58:31AM +0100, Mel Gorman wrote:
> > On Tue, Sep 21, 2021 at 10:13:17AM +1000, NeilBrown wrote:
> > > On Mon, 20 Sep 2021, Mel Gorman wrote:
> > > > -long wait_iff_congested(int sync, long timeout)
> > > > -{
> > > > -	long ret;
> > > > -	unsigned long start = jiffies;
> > > > -	DEFINE_WAIT(wait);
> > > > -	wait_queue_head_t *wqh = &congestion_wqh[sync];
> > > > -
> > > > -	/*
> > > > -	 * If there is no congestion, yield if necessary instead
> > > > -	 * of sleeping on the congestion queue
> > > > -	 */
> > > > -	if (atomic_read(&nr_wb_congested[sync]) == 0) {
> > > > -		cond_resched();
> > > > -
> > > > -		/* In case we scheduled, work out time remaining */
> > > > -		ret = timeout - (jiffies - start);
> > > > -		if (ret < 0)
> > > > -			ret = 0;
> > > > -
> > > > -		goto out;
> > > > -	}
> > > > -
> > > > -	/* Sleep until uncongested or a write happens */
> > > > -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> > > 
> > > Uninterruptible wait.
> > > 
> > > ....
> > > > +static void
> > > > +reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> > > > +							long timeout)
> > > > +{
> > > > +	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
> > > > +	unsigned long start = jiffies;
> > > > +	long ret;
> > > > +	DEFINE_WAIT(wait);
> > > > +
> > > > +	atomic_inc(&pgdat->nr_reclaim_throttled);
> > > > +	WRITE_ONCE(pgdat->nr_reclaim_start,
> > > > +		 node_page_state(pgdat, NR_THROTTLED_WRITTEN));
> > > > +
> > > > +	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
> > > 
> > > Interruptible wait.
> > > 
> > > Why the change?  I think these waits really need to be TASK_UNINTERRUPTIBLE.
> > > 
> > 
> > Because from mm/ context, I saw no reason why the task *should* be
> > uninterruptible. It's waiting on other tasks to complete IO and it is not
> > protecting device state, filesystem state or anything else. If it gets
> > a signal, it's safe to wake up, particularly if that signal is KILL and
> > the context is a direct reclaimer.
> 
> I disagree. whether the sleep should be interruptable or
> not is entirely dependent on whether the caller can handle failure
> or not. If this is GFP_NOFAIL, allocation must not fail no matter
> what the context is, so signals and the like are irrelevant.
> 
> For a context that can handle allocation failure, then it makes
> sense to wake on events that will result in the allocation failing
> immediately. But if all this does is make the allocation code go
> around another retry loop sooner, then an interruptible sleep still
> doesn't make any sense at all here...
> 

Ok, between this and Neil's mail on the same topic, I'm convinced.

-- 
Mel Gorman
SUSE Labs
