Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F228467DC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 20:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353109AbhLCTLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 14:11:36 -0500
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:47843 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238521AbhLCTLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:11:35 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id B062DFB118
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 19:08:09 +0000 (GMT)
Received: (qmail 22072 invoked from network); 3 Dec 2021 19:08:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Dec 2021 19:08:09 -0000
Date:   Fri, 3 Dec 2021 19:08:07 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211203190807.GE3366@techsingularity.net>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <CALvZod6am_QrZCSf_de6eyzbOtKnWuL1CQZVn+srQVt20cnpFg@mail.gmail.com>
 <20211202165220.GZ3366@techsingularity.net>
 <CALvZod5tiDgEz4JwxMHQvkzLxYeV0OtNGGsX5ZdT5mTQdUdUUA@mail.gmail.com>
 <20211203090137.GA3366@techsingularity.net>
 <CALvZod46SFiNvUSLCJWEVccsXKx=NwT4=gk9wS6Nt8cZd0WOgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CALvZod46SFiNvUSLCJWEVccsXKx=NwT4=gk9wS6Nt8cZd0WOgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 03, 2021 at 09:50:51AM -0800, Shakeel Butt wrote:
> On Fri, Dec 3, 2021 at 1:01 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> [...]
> >
> > Not recently that I'm aware of but historically reclaim has been plagued by
> > at least two classes of problems -- premature OOM and excessive CPU usage
> > churning through the LRU. Going back, the solution was basically to sleep
> > something like "disable kswapd if it fails to make progress for too long".
> > Commit 69392a403f49 addressed a case where calling congestion_wait might as
> > well have been schedule_timeout_uninterruptible(HZ/10) because congestion
> > is no longer tracked by the block layer.
> >
> > Hence 69392a403f49 allows reclaim to throttle on NOPROGRESS but if
> > another task makes progress, the throttled tasks can be woken before the
> > timeout. The flaw was throttling too easily or for too long delaying OOM
> > being properly detected.
> >
> 
> To remove congestion_wait of mem_cgroup_force_empty_write(), the
> commit 69392a403f49 has changed the behavior of all memcg reclaim
> codepaths as well as direct global reclaimers.

Well, yes, it moved it to stalling on writeback if it's in progress
and waking up if writeback makes forward progress instead of a
schedule_timeout_interruptible().

> Were there other
> congestion_wait() instances which commit 69392a403f49 was targeting
> but those congestion_wait() were replaced/removed by different
> commits?
> 

Yes, the series removed congestion_wait from other places because the
interface is broken and has been for a long time.

> [...]
> 
> > >
> > > Isn't it better that the reclaim returns why it is failing instead of
> > > littering the reclaim code with 'is this global reclaim', 'is this
> > > memcg reclaim', 'am I kswapd' which is also a layering violation. IMO
> > > this is the direction we should be going towards though not asking to
> > > do this now.
> > >
> >
> > It's not clear why you think the page allocator can make better decisions
> > about reclaim than reclaim can. It might make sense if callers were
> > returned enough information to make a decision but even if they could,
> > it would not be popular as the API would be difficult to use properly.
> >
> 
> The above is a separate discussion for later.
> 
> > Is your primary objection the cgroup_reclaim(sc) check?
> 
> No, I am of the opinion that we should revert 69392a403f49 and we
> should have just replaced congestion_wait in
> mem_cgroup_force_empty_write with a simple
> schedule_timeout_interruptible.

That is a bit weak. Depending on the type of storage, writeback may
completes in microseconds or seconds. The event used to be "sleep until
congestion clears" which is no longer an event that can be waited upon
in the vast majority of cases (NFS being an obvious exception). Now,
it may throttle writeback on a waitqueue and if enough writeback
completes, the task will be woken before the timeout to minimise the
stall. schedule_timeout_interruptible() always waits for a fixed duration
regardless of what else happens in the meantime.

> The memory.force_empty is a cgroup v1
> interface (to be deprecated) and it is very normal to expect that the
> user will trigger that interface multiple times. We should not change
> the behavior of all the memcg reclaimers and direct global reclaimers
> so that we can remove congestion_wait from
> mem_cgroup_force_empty_write.
> 

The mem_cgroup_force_empty_write() path will throttle on writeback in
the same way that global reclaim does at this point

                /*
                 * If kswapd scans pages marked for immediate
                 * reclaim and under writeback (nr_immediate), it
                 * implies that pages are cycling through the LRU
                 * faster than they are written so forcibly stall
                 * until some pages complete writeback.
                 */
                if (sc->nr.immediate)
                        reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);

With this patch, memcg does not stall on NOPROGRESS.

> > If so, I can
> > remove it. While there is a mild risk that OOM would be delayed, it's very
> > unlikely because a memcg failing to make progress in the local case will
> > probably call cond_resched() if there are not lots of of pages pending
> > writes globally.
> >
> > > Regarding this patch and 69392a403f49, I am still confused on the main
> > > motivation behind 69392a403f49 to change the behavior of 'direct
> > > reclaimers from page allocator'.
> > >
> >
> > The main motivation of the series overall was to remove the reliance on
> > congestion_wait and wait_iff_congested because both are fundamentally
> > broken when congestion is not tracked by the block layer. Replacing with
> > schedule_timeout_uninterruptible() would be silly because where possible
> > decisions on whether to pause or throttle should be based on events,
> > not time. For example, if there are too many pages waiting on writeback
> > then throttle but if writeback completes, wake the throttled tasks
> > instead of "sleep some time and hope for the best".
> >
> 
> I am in agreement with the motivation of the whole series. I am just
> making sure that the motivation of VMSCAN_THROTTLE_NOPROGRESS based
> throttle is more than just the congestion_wait of
> mem_cgroup_force_empty_write.
> 

The commit that primarily targets congestion_wait is 8cd7c588decf
("mm/vmscan: throttle reclaim until some writeback completes if
congested"). The series recognises that there are other reasons why
reclaim can fail to make progress that is not directly writeback related.

-- 
Mel Gorman
SUSE Labs
