Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95C60808D4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2019 03:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfHDBun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 21:50:43 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:51456 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728274AbfHDBum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 21:50:42 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E5CE8364280;
        Sun,  4 Aug 2019 11:50:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hu5eM-00054o-Fl; Sun, 04 Aug 2019 11:49:30 +1000
Date:   Sun, 4 Aug 2019 11:49:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/24] mm: directed shrinker work deferral
Message-ID: <20190804014930.GR7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-2-david@fromorbit.com>
 <20190802152709.GA60893@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802152709.GA60893@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=BosphLL6vozEvtcKRvYA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:27:09AM -0400, Brian Foster wrote:
> On Thu, Aug 01, 2019 at 12:17:29PM +1000, Dave Chinner wrote:
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
> >  include/linux/shrinker.h | 7 +++++++
> >  mm/vmscan.c              | 8 ++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > index 9443cafd1969..af78c475fc32 100644
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
> > +	bool will_defer;
> 
> Functionality wise this seems fairly straightforward. FWIW, I find the
> 'will_defer' name a little confusing because it implies to me that the
> shrinker is telling the caller about something it would do if called as
> opposed to explicitly telling the caller to defer. I'd just call it
> 'defer' I guess, but that's just my .02. ;P

Ok, I'll change it to something like "defer_work" or "defer_scan"
here.

> >  };
> >  
> >  #define SHRINK_STOP (~0UL)
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 44df66a98f2a..ae3035fe94bc 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -541,6 +541,13 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> >  				   freeable, delta, total_scan, priority);
> >  
> > +	/*
> > +	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
> > +	 * defer the work to a context that can scan the cache.
> > +	 */
> > +	if (shrinkctl->will_defer)
> > +		goto done;
> > +
> 
> Who's responsible for clearing the flag? Perhaps we should do so here
> once it's acted upon since we don't call into the shrinker again?

Each shrinker invocation has it's own shrink_control context - they
are not shared between shrinkers - the higher level is responsible
for setting up the control state of each individual shrinker
invocation...

> Note that I see this structure is reinitialized on every iteration in
> the caller, but there already is the SHRINK_EMPTY case where we call
> back into do_shrink_slab().

.... because there is external state tracking in memcgs that
determine what shrinkers get run. See shrink_slab_memcg().

i.e. The SHRINK_EMPTY return value is a special hack for memcg
shrinkers so it can track whether there are freeable objects in the
cache externally to try to avoid calling into shrinkers where no
work can be done.  Think about having hundreds of shrinkers and
hundreds of memcgs...

Anyway, the tracking of the freeable bit is racy, so the
SHRINK_EMPTY hack where it clears the bit and calls back into the
shrinker is handling the case where objects were freed between the
shrinker running and shrink_slab_memcg() clearing the freeable bit
from the slab. Hence it has to call back into the shrinker again -
if it gets anything other than SHRINK_EMPTY returned, then it will
set the bit again.

In reality, SHRINK_EMPTY and deferring work are mutually exclusive.
Work only gets deferred when there's work that can be done and in
that case SHRINK_EMPTY will not be returned - a value of "0 freed
objects" will be returned when we defer work. So if the first call
returns SHRINK_EMPTY, the "defer" state has not been touched and
so doesn't require resetting to zero here.

> Granted the deferred state likely hasn't
> changed, but the fact that we'd call back into the count callback to set
> it again implies the logic could be a bit more explicit, particularly if
> this will eventually be used for more dynamic shrinker state that might
> change call to call (i.e., object dirty state, etc.).
> 
> BTW, do we need to care about the ->nr_cached_objects() call from the
> generic superblock shrinker (super_cache_scan())?

No, and we never had to because it is inside the superblock shrinker
and the superblock shrinker does the GFP_NOFS context checks.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
