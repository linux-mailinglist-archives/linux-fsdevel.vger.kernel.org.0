Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC576413207
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhIULAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 07:00:05 -0400
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:37835 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231956AbhIULAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:00:04 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id 5B8A0FAFCD
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 11:58:33 +0100 (IST)
Received: (qmail 2738 invoked from network); 21 Sep 2021 10:58:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2021 10:58:32 -0000
Date:   Tue, 21 Sep 2021 11:58:31 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Linux-MM <linux-mm@kvack.org>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
Message-ID: <20210921105831.GO3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <20210920085436.20939-2-mgorman@techsingularity.net>
 <163218319798.3992.1165186037496786892@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163218319798.3992.1165186037496786892@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 10:13:17AM +1000, NeilBrown wrote:
> On Mon, 20 Sep 2021, Mel Gorman wrote:
> > -long wait_iff_congested(int sync, long timeout)
> > -{
> > -	long ret;
> > -	unsigned long start = jiffies;
> > -	DEFINE_WAIT(wait);
> > -	wait_queue_head_t *wqh = &congestion_wqh[sync];
> > -
> > -	/*
> > -	 * If there is no congestion, yield if necessary instead
> > -	 * of sleeping on the congestion queue
> > -	 */
> > -	if (atomic_read(&nr_wb_congested[sync]) == 0) {
> > -		cond_resched();
> > -
> > -		/* In case we scheduled, work out time remaining */
> > -		ret = timeout - (jiffies - start);
> > -		if (ret < 0)
> > -			ret = 0;
> > -
> > -		goto out;
> > -	}
> > -
> > -	/* Sleep until uncongested or a write happens */
> > -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> 
> Uninterruptible wait.
> 
> ....
> > +static void
> > +reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> > +							long timeout)
> > +{
> > +	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
> > +	unsigned long start = jiffies;
> > +	long ret;
> > +	DEFINE_WAIT(wait);
> > +
> > +	atomic_inc(&pgdat->nr_reclaim_throttled);
> > +	WRITE_ONCE(pgdat->nr_reclaim_start,
> > +		 node_page_state(pgdat, NR_THROTTLED_WRITTEN));
> > +
> > +	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
> 
> Interruptible wait.
> 
> Why the change?  I think these waits really need to be TASK_UNINTERRUPTIBLE.
> 

Because from mm/ context, I saw no reason why the task *should* be
uninterruptible. It's waiting on other tasks to complete IO and it is not
protecting device state, filesystem state or anything else. If it gets
a signal, it's safe to wake up, particularly if that signal is KILL and
the context is a direct reclaimer.

The original TASK_UNINTERRUPTIBLE is almost certainly a copy&paste from
congestion_wait which may be called because a filesystem operation must
complete before it can return to userspace so a signal waking it up is
pointless.

-- 
Mel Gorman
SUSE Labs
