Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5A946739E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 10:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351182AbhLCJFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 04:05:05 -0500
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:42831 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379334AbhLCJFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:05:04 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id A162DBED84
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 09:01:39 +0000 (GMT)
Received: (qmail 7408 invoked from network); 3 Dec 2021 09:01:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Dec 2021 09:01:39 -0000
Date:   Fri, 3 Dec 2021 09:01:37 +0000
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
Message-ID: <20211203090137.GA3366@techsingularity.net>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <CALvZod6am_QrZCSf_de6eyzbOtKnWuL1CQZVn+srQVt20cnpFg@mail.gmail.com>
 <20211202165220.GZ3366@techsingularity.net>
 <CALvZod5tiDgEz4JwxMHQvkzLxYeV0OtNGGsX5ZdT5mTQdUdUUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CALvZod5tiDgEz4JwxMHQvkzLxYeV0OtNGGsX5ZdT5mTQdUdUUA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 09:41:04AM -0800, Shakeel Butt wrote:
> On Thu, Dec 2, 2021 at 8:52 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Thu, Dec 02, 2021 at 08:30:51AM -0800, Shakeel Butt wrote:
> > > Hi Mel,
> > >
> > > On Thu, Dec 2, 2021 at 7:07 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> > > >
> > > > Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> > > > problems due to reclaim throttling for excessive lengths of time.
> > > > In Alexey's case, a memory hog that should go OOM quickly stalls for
> > > > several minutes before stalling. In Mike and Darrick's cases, a small
> > > > memcg environment stalled excessively even though the system had enough
> > > > memory overall.
> > > >
> > > > Commit 69392a403f49 ("mm/vmscan: throttle reclaim when no progress is being
> > > > made") introduced the problem although commit a19594ca4a8b ("mm/vmscan:
> > > > increase the timeout if page reclaim is not making progress") made it
> > > > worse. Systems at or near an OOM state that cannot be recovered must
> > > > reach OOM quickly and memcg should kill tasks if a memcg is near OOM.
> > > >
> > >
> > > Is there a reason we can't simply revert 69392a403f49 instead of adding
> > > more code/heuristics? Looking more into 69392a403f49, I don't think the
> > > code and commit message are in sync.
> > >
> > > For the memcg reclaim, instead of just removing congestion_wait or
> > > replacing it with schedule_timeout in mem_cgroup_force_empty(), why
> > > change the behavior of all memcg reclaim. Also this patch effectively
> > > reverts that behavior of 69392a403f49.
> > >
> >
> > It doesn't fully revert it but I did consider reverting it. The reason
> > why I preserved it because the intent originally was to throttle somewhat
> > when progress is not being made to avoid a premature OOM and I wanted to
> > preserve that charactersistic. Right now, this is the least harmful way
> > of doing it.
> 
> If I understand correctly, the original intent of 69392a403f49 which
> you want to preserve is "avoid premature OOMs when reclaim is not
> making progress". Were there any complaints or bug reports on these
> premature OOMs?
> 

Not recently that I'm aware of but historically reclaim has been plagued by
at least two classes of problems -- premature OOM and excessive CPU usage
churning through the LRU. Going back, the solution was basically to sleep
something like "disable kswapd if it fails to make progress for too long".
Commit 69392a403f49 addressed a case where calling congestion_wait might as
well have been schedule_timeout_uninterruptible(HZ/10) because congestion
is no longer tracked by the block layer.

Hence 69392a403f49 allows reclaim to throttle on NOPROGRESS but if
another task makes progress, the throttled tasks can be woken before the
timeout. The flaw was throttling too easily or for too long delaying OOM
being properly detected.

> >
> > As more memcg, I removed the NOTHROTTLE because the primary reason why a
> > memcg might fail to make progress is excessive writeback and that should
> > still throttle. Completely failing to make progress in a memcg is most
> > likely due to a memcg-OOM.
> >
> > > For direct reclaimers under global pressure, why is page allocator a bad
> > > place for stalling on no progress reclaim? IMHO the callers of the
> > > reclaim should decide what to do if reclaim is not making progress.
> >
> > Because it's a layering violation and the caller has little direct control
> > over the reclaim retry logic. The page allocator has no visibility on
> > why reclaim failed only that it did fail.
> >
> 
> Isn't it better that the reclaim returns why it is failing instead of
> littering the reclaim code with 'is this global reclaim', 'is this
> memcg reclaim', 'am I kswapd' which is also a layering violation. IMO
> this is the direction we should be going towards though not asking to
> do this now.
> 

It's not clear why you think the page allocator can make better decisions
about reclaim than reclaim can. It might make sense if callers were
returned enough information to make a decision but even if they could,
it would not be popular as the API would be difficult to use properly.

Is your primary objection the cgroup_reclaim(sc) check? If so, I can
remove it. While there is a mild risk that OOM would be delayed, it's very
unlikely because a memcg failing to make progress in the local case will
probably call cond_resched() if there are not lots of of pages pending
writes globally.

> Regarding this patch and 69392a403f49, I am still confused on the main
> motivation behind 69392a403f49 to change the behavior of 'direct
> reclaimers from page allocator'.
> 

The main motivation of the series overall was to remove the reliance on
congestion_wait and wait_iff_congested because both are fundamentally
broken when congestion is not tracked by the block layer. Replacing with
schedule_timeout_uninterruptible() would be silly because where possible
decisions on whether to pause or throttle should be based on events,
not time. For example, if there are too many pages waiting on writeback
then throttle but if writeback completes, wake the throttled tasks
instead of "sleep some time and hope for the best".

-- 
Mel Gorman
SUSE Labs
