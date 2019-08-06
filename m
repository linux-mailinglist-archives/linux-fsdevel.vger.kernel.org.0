Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A944D83158
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 14:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfHFM3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 08:29:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHFM3v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:29:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40F8D85539;
        Tue,  6 Aug 2019 12:29:51 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6D6E608A7;
        Tue,  6 Aug 2019 12:29:50 +0000 (UTC)
Date:   Tue, 6 Aug 2019 08:29:49 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/24] xfs: synchronous AIL pushing
Message-ID: <20190806122949.GB2979@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-14-david@fromorbit.com>
 <20190805175153.GC14760@bfoster>
 <20190805232132.GY7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805232132.GY7777@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 06 Aug 2019 12:29:51 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:21:32AM +1000, Dave Chinner wrote:
> On Mon, Aug 05, 2019 at 01:51:53PM -0400, Brian Foster wrote:
> > On Thu, Aug 01, 2019 at 12:17:41PM +1000, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Provide an interface to push the AIL to a target LSN and wait for
> > > the tail of the log to move past that LSN. This is used to wait for
> > > all items older than a specific LSN to either be cleaned (written
> > > back) or relogged to a higher LSN in the AIL. The primary use for
> > > this is to allow IO free inode reclaim throttling.
> > > 
> > > Factor the common AIL deletion code that does all the wakeups into a
> > > helper so we only have one copy of this somewhat tricky code to
> > > interface with all the wakeups necessary when the LSN of the log
> > > tail changes.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  fs/xfs/xfs_inode_item.c | 12 +------
> > >  fs/xfs/xfs_trans_ail.c  | 69 +++++++++++++++++++++++++++++++++--------
> > >  fs/xfs/xfs_trans_priv.h |  6 +++-
> > >  3 files changed, 62 insertions(+), 25 deletions(-)
> > > 
> > ...
> > > diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> > > index 6ccfd75d3c24..9e3102179221 100644
> > > --- a/fs/xfs/xfs_trans_ail.c
> > > +++ b/fs/xfs/xfs_trans_ail.c
> > > @@ -654,6 +654,37 @@ xfs_ail_push_all(
> > >  		xfs_ail_push(ailp, threshold_lsn);
> > >  }
> > >  
> > > +/*
> > > + * Push the AIL to a specific lsn and wait for it to complete.
> > > + */
> > > +void
> > > +xfs_ail_push_sync(
> > > +	struct xfs_ail		*ailp,
> > > +	xfs_lsn_t		threshold_lsn)
> > > +{
> > > +	struct xfs_log_item	*lip;
> > > +	DEFINE_WAIT(wait);
> > > +
> > > +	spin_lock(&ailp->ail_lock);
> > > +	while ((lip = xfs_ail_min(ailp)) != NULL) {
> > > +		prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
> > > +		if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
> > > +		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) <= 0)
> > > +			break;
> > > +		/* XXX: cmpxchg? */
> > > +		while (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
> > > +			xfs_trans_ail_copy_lsn(ailp, &ailp->ail_target, &threshold_lsn);
> > 
> > Why the need to repeatedly copy the ail_target like this? If the push
> 
> It's a hack because the other updates are done unlocked and this
> doesn't contain the memroy barriers needed to make it correct
> and race free.
> 
> Hence the comment "XXX: cmpxchg" to ensure that:
> 
> 	a) we only ever move the target forwards;
> 	b) we resolve update races in an obvious, simple manner; and
> 	c) we can get rid of the possibly incorrect memory
> 	   barriers around this (unlocked) update.
> 
> RFC. WIP. :)
> 

Ack..

> > target only ever moves forward, we should only need to do this once at
> > the start of the function. In fact I'm kind of wondering why we can't
> > just call xfs_ail_push(). If we check the tail item after grabbing the
> > spin lock, we should be able to avoid any races with the waker, no?
> 
> I didn't use xfs_ail_push() because of having to prepare to wait
> between determining if the AIL is empty and checking if we need
> to update the target.
> 
> I also didn't want to affect the existing xfs_ail_push() as I was
> modifying the xfs_ail_push_sync() code to do what was needed.
> Eventually they can probably come back together, but for now I'm not
> 100% sure that the code is correct and race free.
> 

Ok, just chalk this up to general feedback around seeing if we can
improve the factoring between the several AIL pushing functions we now
have once this mechanism is working/correct.

> > > +void
> > > +xfs_ail_delete_finish(
> > > +	struct xfs_ail		*ailp,
> > > +	bool			do_tail_update) __releases(ailp->ail_lock)
> > > +{
> > > +	struct xfs_mount	*mp = ailp->ail_mount;
> > > +
> > > +	if (!do_tail_update) {
> > > +		spin_unlock(&ailp->ail_lock);
> > > +		return;
> > > +	}
> > > +
> > 
> > Hmm.. so while what we really care about here are tail updates, this
> > logic is currently driven by removing the min ail log item. That seems
> > like a lot of potential churn if we're waking the pusher on every object
> > written back covered by a single log record / checkpoint. Perhaps we
> > should implement a bit more coarse wakeup logic such as only when the
> > tail lsn actually changes, for example?
> 
> You mean the next patch?
> 

Yep, hadn't got to that point yet. FWIW, I think the next patch should
probably come before this one so there isn't a transient state with
whatever behavior results from this patch by itself.

Brian

> > FWIW, it also doesn't look like you've handled the case of relogged
> > items moving the tail forward anywhere that I can see, so we might be
> > missing some wakeups here. See xfs_trans_ail_update_bulk() for
> > additional AIL manipulation.
> 
> Good catch. That might be the race the next patch exposes :)
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
