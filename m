Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48771827DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 01:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfHEXWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 19:22:43 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45594 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728483AbfHEXWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 19:22:43 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 461F743DEF8;
        Tue,  6 Aug 2019 09:22:39 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1humIG-0005EA-AB; Tue, 06 Aug 2019 09:21:32 +1000
Date:   Tue, 6 Aug 2019 09:21:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/24] xfs: synchronous AIL pushing
Message-ID: <20190805232132.GY7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-14-david@fromorbit.com>
 <20190805175153.GC14760@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805175153.GC14760@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=-ljn3MnX72N5CFMTOV4A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 01:51:53PM -0400, Brian Foster wrote:
> On Thu, Aug 01, 2019 at 12:17:41PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Provide an interface to push the AIL to a target LSN and wait for
> > the tail of the log to move past that LSN. This is used to wait for
> > all items older than a specific LSN to either be cleaned (written
> > back) or relogged to a higher LSN in the AIL. The primary use for
> > this is to allow IO free inode reclaim throttling.
> > 
> > Factor the common AIL deletion code that does all the wakeups into a
> > helper so we only have one copy of this somewhat tricky code to
> > interface with all the wakeups necessary when the LSN of the log
> > tail changes.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  fs/xfs/xfs_inode_item.c | 12 +------
> >  fs/xfs/xfs_trans_ail.c  | 69 +++++++++++++++++++++++++++++++++--------
> >  fs/xfs/xfs_trans_priv.h |  6 +++-
> >  3 files changed, 62 insertions(+), 25 deletions(-)
> > 
> ...
> > diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> > index 6ccfd75d3c24..9e3102179221 100644
> > --- a/fs/xfs/xfs_trans_ail.c
> > +++ b/fs/xfs/xfs_trans_ail.c
> > @@ -654,6 +654,37 @@ xfs_ail_push_all(
> >  		xfs_ail_push(ailp, threshold_lsn);
> >  }
> >  
> > +/*
> > + * Push the AIL to a specific lsn and wait for it to complete.
> > + */
> > +void
> > +xfs_ail_push_sync(
> > +	struct xfs_ail		*ailp,
> > +	xfs_lsn_t		threshold_lsn)
> > +{
> > +	struct xfs_log_item	*lip;
> > +	DEFINE_WAIT(wait);
> > +
> > +	spin_lock(&ailp->ail_lock);
> > +	while ((lip = xfs_ail_min(ailp)) != NULL) {
> > +		prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
> > +		if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
> > +		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) <= 0)
> > +			break;
> > +		/* XXX: cmpxchg? */
> > +		while (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
> > +			xfs_trans_ail_copy_lsn(ailp, &ailp->ail_target, &threshold_lsn);
> 
> Why the need to repeatedly copy the ail_target like this? If the push

It's a hack because the other updates are done unlocked and this
doesn't contain the memroy barriers needed to make it correct
and race free.

Hence the comment "XXX: cmpxchg" to ensure that:

	a) we only ever move the target forwards;
	b) we resolve update races in an obvious, simple manner; and
	c) we can get rid of the possibly incorrect memory
	   barriers around this (unlocked) update.

RFC. WIP. :)

> target only ever moves forward, we should only need to do this once at
> the start of the function. In fact I'm kind of wondering why we can't
> just call xfs_ail_push(). If we check the tail item after grabbing the
> spin lock, we should be able to avoid any races with the waker, no?

I didn't use xfs_ail_push() because of having to prepare to wait
between determining if the AIL is empty and checking if we need
to update the target.

I also didn't want to affect the existing xfs_ail_push() as I was
modifying the xfs_ail_push_sync() code to do what was needed.
Eventually they can probably come back together, but for now I'm not
100% sure that the code is correct and race free.

> > +void
> > +xfs_ail_delete_finish(
> > +	struct xfs_ail		*ailp,
> > +	bool			do_tail_update) __releases(ailp->ail_lock)
> > +{
> > +	struct xfs_mount	*mp = ailp->ail_mount;
> > +
> > +	if (!do_tail_update) {
> > +		spin_unlock(&ailp->ail_lock);
> > +		return;
> > +	}
> > +
> 
> Hmm.. so while what we really care about here are tail updates, this
> logic is currently driven by removing the min ail log item. That seems
> like a lot of potential churn if we're waking the pusher on every object
> written back covered by a single log record / checkpoint. Perhaps we
> should implement a bit more coarse wakeup logic such as only when the
> tail lsn actually changes, for example?

You mean the next patch?

> FWIW, it also doesn't look like you've handled the case of relogged
> items moving the tail forward anywhere that I can see, so we might be
> missing some wakeups here. See xfs_trans_ail_update_bulk() for
> additional AIL manipulation.

Good catch. That might be the race the next patch exposes :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
