Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C65180B65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 23:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgCJWWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 18:22:32 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:60663 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727685AbgCJWWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:22:32 -0400
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3FD997E9BA9;
        Wed, 11 Mar 2020 09:22:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jBnGd-0004dQ-FO; Wed, 11 Mar 2020 09:22:27 +1100
Date:   Wed, 11 Mar 2020 09:22:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/direct-io.c: avoid workqueue allocation race
Message-ID: <20200310222227.GP10776@dread.disaster.area>
References: <CACT4Y+Zt+fjBwJk-TcsccohBgxRNs37Hb4m6ZkZGy7u5P2+aaA@mail.gmail.com>
 <20200308055221.1088089-1-ebiggers@kernel.org>
 <20200308231253.GN10776@dread.disaster.area>
 <20200309012424.GB371527@sol.localdomain>
 <20200310162758.GJ8036@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310162758.GJ8036@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=1XWaLZrsAAAA:8 a=7-415B0cAAAA:8 a=nc9e2v5Tfj97ZLR5cfIA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Sorry, my responses are limited at the moment because I took a
chunk out of a fingertip a couple of days ago and I can only do
about half an hour before my hand and arm start to cramp from the
weird positions and motions 3 finger typing results in.... ]

On Tue, Mar 10, 2020 at 09:27:58AM -0700, Darrick J. Wong wrote:
> On Sun, Mar 08, 2020 at 06:24:24PM -0700, Eric Biggers wrote:
> > On Mon, Mar 09, 2020 at 10:12:53AM +1100, Dave Chinner wrote:
> > > On Sat, Mar 07, 2020 at 09:52:21PM -0800, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > When a thread loses the workqueue allocation race in
> > > > sb_init_dio_done_wq(), lockdep reports that the call to
> > > > destroy_workqueue() can deadlock waiting for work to complete.  This is
> > > > a false positive since the workqueue is empty.  But we shouldn't simply
> > > > skip the lockdep check for empty workqueues for everyone.
> > > 
> > > Why not? If the wq is empty, it can't deadlock, so this is a problem
> > > with the workqueue lockdep annotations, not a problem with code that
> > > is destroying an empty workqueue.
> > 
> > Skipping the lockdep check when flushing an empty workqueue would reduce the
> > ability of lockdep to detect deadlocks when flushing that workqueue.  I.e., it
> > could cause lots of false negatives, since there are many cases where workqueues
> > are *usually* empty when flushed/destroyed but it's still possible that they are
> > nonempty.
> > 
> > > 
> > > > Just avoid this issue by using a mutex to serialize the workqueue
> > > > allocation.  We still keep the preliminary check for ->s_dio_done_wq, so
> > > > this doesn't affect direct I/O performance.
> > > > 
> > > > Also fix the preliminary check for ->s_dio_done_wq to use READ_ONCE(),
> > > > since it's a data race.  (That part wasn't actually found by syzbot yet,
> > > > but it could be detected by KCSAN in the future.)
> > > > 
> > > > Note: the lockdep false positive could alternatively be fixed by
> > > > introducing a new function like "destroy_unused_workqueue()" to the
> > > > workqueue API as previously suggested.  But I think it makes sense to
> > > > avoid the double allocation anyway.
> > > 
> > > Fix the infrastructure, don't work around it be placing constraints
> > > on how the callers can use the infrastructure to work around
> > > problems internal to the infrastructure.
> > 
> > Well, it's also preferable not to make our debugging tools less effective to
> > support people doing weird things that they shouldn't really be doing anyway.
> > 
> > (BTW, we need READ_ONCE() on ->sb_init_dio_done_wq anyway to properly annotate
> > the data race.  That could be split into a separate patch though.)
> > 
> > Another idea that came up is to make each workqueue_struct track whether work
> > has been queued on it or not yet, and make flush_workqueue() skip the lockdep
> > check if the workqueue has always been empty.  (That could still cause lockdep
> > false negatives, but not as many as if we checked if the workqueue is
> > *currently* empty.)  Would you prefer that solution?  Adding more overhead to
> > workqueues would be undesirable though, so I think it would have to be
> > conditional on CONFIG_LOCKDEP, like (untested):
> 
> I can't speak for Dave, but if the problem here really is that lockdep's
> modelling of flush_workqueue()'s behavior could be improved to eliminate
> false reports, then this seems reasonable to me...

Yeah, that's what I've been trying to say. IT seems much more
reasonable to fix it for everyone once with a few lines of code than
have to re-write every caller that might trip over this. e.g. think
of all the failure teardown paths that destroy workqueues without
having used them...

So, yeah, this seems like a much better approach....

> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 301db4406bc37..72222c09bcaeb 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -263,6 +263,7 @@ struct workqueue_struct {
> >  	char			*lock_name;
> >  	struct lock_class_key	key;
> >  	struct lockdep_map	lockdep_map;
> > +	bool			used;
> >  #endif
> >  	char			name[WQ_NAME_LEN]; /* I: workqueue name */
> >  
> > @@ -1404,6 +1405,9 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
> >  	lockdep_assert_irqs_disabled();
> >  
> >  	debug_work_activate(work);
> > +#ifdef CONFIG_LOCKDEP
> > +	WRITE_ONCE(wq->used, true);
> > +#endif

....with an appropriate comment to explain why this code is needed.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
