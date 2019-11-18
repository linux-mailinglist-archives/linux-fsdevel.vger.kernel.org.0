Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3948FFC91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 01:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfKRAuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 19:50:09 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53788 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbfKRAuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 19:50:09 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B94683A1E80;
        Mon, 18 Nov 2019 11:49:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iWVEq-0004JH-F4; Mon, 18 Nov 2019 11:49:56 +1100
Date:   Mon, 18 Nov 2019 11:49:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] mm: directed shrinker work deferral
Message-ID: <20191118004956.GR4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-10-david@fromorbit.com>
 <20191104152525.GA10665@bfoster>
 <20191114204926.GC4614@dread.disaster.area>
 <20191115172140.GA55854@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115172140.GA55854@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=2Pa82YUKK1kpi_zZjHcA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 12:21:40PM -0500, Brian Foster wrote:
> On Fri, Nov 15, 2019 at 07:49:26AM +1100, Dave Chinner wrote:
> > On Mon, Nov 04, 2019 at 10:25:25AM -0500, Brian Foster wrote:
> > > On Fri, Nov 01, 2019 at 10:45:59AM +1100, Dave Chinner wrote:
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > Introduce a mechanism for ->count_objects() to indicate to the
> > > > shrinker infrastructure that the reclaim context will not allow
> > > > scanning work to be done and so the work it decides is necessary
> > > > needs to be deferred.
> > > > 
> > > > This simplifies the code by separating out the accounting of
> > > > deferred work from the actual doing of the work, and allows better
> > > > decisions to be made by the shrinekr control logic on what action it
> > > > can take.
> > > > 
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > ---
> > > 
> > > My understanding from the previous discussion(s) is that this is not
> > > tied directly to the gfp mask because that is not the only intended use.
> > > While it is currently a boolean tied to the the entire shrinker call,
> > > the longer term objective is per-object granularity.
> > 
> > Longer term, yes, but right now such things are not possible as the
> > shrinker needs more context to be able to make sane per-object
> > decisions. shrinker policy decisions that affect the entire run
> > scope should be handled by the ->count operation - it's the one that
> > says whether the scan loop should run or not, and right now GFP_NOFS
> > for all filesystem shrinkers is a pure boolean policy
> > implementation.
> > 
> > The next future step is to provide a superblock context with
> > GFP_NOFS to indicate which filesystem we cannot recurse into. That
> > is also a shrinker instance wide check, so again it's something that
> > ->count should be deciding.
> > 
> > i.e. ->count determines what is to be done, ->scan iterates the work
> > that has to be done until we are done.
> > 
> 
> Sure, makes sense in general.
> 
> > > I find the argument reasonable enough, but if the above is true, why do
> > > we move these checks from ->scan_objects() to ->count_objects() (in the
> > > next patch) when per-object decisions will ultimately need to be made by
> > > the former?
> > 
> > Because run/no-run policy belongs in one place, and things like
> > GFP_NOFS do no change across calls to the ->scan loop. i.e. after
> > the first ->scan call in a loop that calls it hundreds to thousands
> > of times, the GFP_NOFS run/no-run check is completely redundant.
> > 
> 
> What loop is currently called hundreds to thousands of times that this
> change prevents? AFAICT the current nofs checks in the ->scan calls
> explicitly terminate the scan loop.

Right, but when we are in GFP_KERNEL context, every call to ->scan()
checks it and says "ok". If we are scanning tens of thousands of
objects in a scan, and we are using a befault batch size of 128
objects per scan, then we have hundreds of calls in a single scan
loop that check the GFP context and say "ok"....

> So we're effectively saving a
> function call by doing this earlier in the count ->call. (Nothing wrong
> with that, I'm just not following the numbers used in this reasoning..).

It's the don't terminate case. :)

> > Once we introduce a new policy that allows the fs shrinker to do
> > careful reclaim in GFP_NOFS conditions, we need to do substantial
> > rework the shrinker scan loop and how it accounts the work that is
> > done - we now have at least 3 or 4 different return counters
> > (skipped because locked, skipped because referenced,
> > reclaimed, deferred reclaim because couldn't lock/recursion) and
> > the accounting and decisions to be made are a lot more complex.
> > 
> 
> Yeah, that's generally what I expected from your previous description.
> 
> > In that case, the ->count function will drop the GFP_NOFS check, but
> > still do all the other things is needs to do. The GFP_NOFS check
> > will go deep in the guts of the shrinker scan implementation where
> > the per-object recursion problem exists. But for most shrinkers,
> > it's still going to be a global boolean check...
> > 
> 
> So once the nofs checks are lifted out of the ->count callback and into
> the core shrinker, is there still a use case to defer an entire ->count
> instance from the callback?

Not right now. There may be in future, but I don't want to make
things more complex than they need to be by trying to support
functionality that isn't used.

> > If people want to call avoiding repeated, unnecessary evaluation of
> > the same condition hundreds of times instead of once "unnecessary
> > churn", then I'll drop it.
> > 
> 
> I'm not referring to the functional change as churn. What I was
> referring to is that we're shuffling around the boilerplate gfp checking
> code between the different shrinker callbacks, knowing that it's
> eventually going to be lifted out, when we could potentially just lift
> that code up a level now.

I don't think that lifting it up will save much code at all, once we
add all the gfp mask intialisation to all the shrinkers, etc. It's
just means we can't look at the shrinker implementation and know
that it can't run in GFP_NOFS context - we have to go look up
where it is instantiated instead to see if there are gfp context
constraints.

I think it's better where it is, documenting the constraints the
shrinker implementation runs under in the implementation itself...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
