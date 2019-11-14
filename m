Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CEAFCFE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 21:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKNUte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 15:49:34 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:40500 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727016AbfKNUtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:49:32 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D942B3A2217;
        Fri, 15 Nov 2019 07:49:27 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVM3S-0003Bn-PF; Fri, 15 Nov 2019 07:49:26 +1100
Date:   Fri, 15 Nov 2019 07:49:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] mm: directed shrinker work deferral
Message-ID: <20191114204926.GC4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-10-david@fromorbit.com>
 <20191104152525.GA10665@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104152525.GA10665@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=pB-_RQp5JTZhIYxYDT0A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:25:25AM -0500, Brian Foster wrote:
> On Fri, Nov 01, 2019 at 10:45:59AM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Introduce a mechanism for ->count_objects() to indicate to the
> > shrinker infrastructure that the reclaim context will not allow
> > scanning work to be done and so the work it decides is necessary
> > needs to be deferred.
> > 
> > This simplifies the code by separating out the accounting of
> > deferred work from the actual doing of the work, and allows better
> > decisions to be made by the shrinekr control logic on what action it
> > can take.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> 
> My understanding from the previous discussion(s) is that this is not
> tied directly to the gfp mask because that is not the only intended use.
> While it is currently a boolean tied to the the entire shrinker call,
> the longer term objective is per-object granularity.

Longer term, yes, but right now such things are not possible as the
shrinker needs more context to be able to make sane per-object
decisions. shrinker policy decisions that affect the entire run
scope should be handled by the ->count operation - it's the one that
says whether the scan loop should run or not, and right now GFP_NOFS
for all filesystem shrinkers is a pure boolean policy
implementation.

The next future step is to provide a superblock context with
GFP_NOFS to indicate which filesystem we cannot recurse into. That
is also a shrinker instance wide check, so again it's something that
->count should be deciding.

i.e. ->count determines what is to be done, ->scan iterates the work
that has to be done until we are done.

> I find the argument reasonable enough, but if the above is true, why do
> we move these checks from ->scan_objects() to ->count_objects() (in the
> next patch) when per-object decisions will ultimately need to be made by
> the former?

Because run/no-run policy belongs in one place, and things like
GFP_NOFS do no change across calls to the ->scan loop. i.e. after
the first ->scan call in a loop that calls it hundreds to thousands
of times, the GFP_NOFS run/no-run check is completely redundant.

Once we introduce a new policy that allows the fs shrinker to do
careful reclaim in GFP_NOFS conditions, we need to do substantial
rework the shrinker scan loop and how it accounts the work that is
done - we now have at least 3 or 4 different return counters
(skipped because locked, skipped because referenced,
reclaimed, deferred reclaim because couldn't lock/recursion) and
the accounting and decisions to be made are a lot more complex.

In that case, the ->count function will drop the GFP_NOFS check, but
still do all the other things is needs to do. The GFP_NOFS check
will go deep in the guts of the shrinker scan implementation where
the per-object recursion problem exists. But for most shrinkers,
it's still going to be a global boolean check...

> That seems like unnecessary churn and inconsistent with the
> argument against just temporarily doing something like what Christoph
> suggested in the previous version, particularly since IIRC the only use
> in this series was for gfp mask purposes.

If people want to call avoiding repeated, unnecessary evaluation of
the same condition hundreds of times instead of once "unnecessary
churn", then I'll drop it.

> >  include/linux/shrinker.h | 7 +++++++
> >  mm/vmscan.c              | 8 ++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > index 0f80123650e2..3405c39ab92c 100644
> > --- a/include/linux/shrinker.h
> > +++ b/include/linux/shrinker.h
> > @@ -31,6 +31,13 @@ struct shrink_control {
> >  
> >  	/* current memcg being shrunk (for memcg aware shrinkers) */
> >  	struct mem_cgroup *memcg;
> > +
> > +	/*
> > +	 * set by ->count_objects if reclaim context prevents reclaim from
> > +	 * occurring. This allows the shrinker to immediately defer all the
> > +	 * work and not even attempt to scan the cache.
> > +	 */
> > +	bool defer_work;
> >  };
> >  
> >  #define SHRINK_STOP (~0UL)
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index ee4eecc7e1c2..a215d71d9d4b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -536,6 +536,13 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> >  				   freeable, delta, total_scan, priority);
> >  
> > +	/*
> > +	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
> > +	 * defer the work to a context that can scan the cache.
> > +	 */
> > +	if (shrinkctl->defer_work)
> > +		goto done;
> > +
> 
> I still find the fact that this per-shrinker invocation field is never
> reset unnecessarily fragile, and I don't see any good reason not to
> reset it prior to the shrinker callback that potentially sets it.

I missed that when updating. I'll reset it in the next version.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
