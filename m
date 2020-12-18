Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB6C2DDC49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 01:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgLRAHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 19:07:51 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:53604 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727172AbgLRAHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 19:07:51 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id C77C65AF178;
        Fri, 18 Dec 2020 11:07:06 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kq3IX-00554r-Gw; Fri, 18 Dec 2020 11:07:05 +1100
Date:   Fri, 18 Dec 2020 11:07:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, willy@infradead.org,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 3/4] xfs: refactor the usage around
 xfs_trans_context_{set,clear}
Message-ID: <20201218000705.GR632069@dread.disaster.area>
References: <20201217011157.92549-1-laoar.shao@gmail.com>
 <20201217011157.92549-4-laoar.shao@gmail.com>
 <20201217221509.GQ632069@dread.disaster.area>
 <20201217230627.GB6911@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217230627.GB6911@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=qwrxGE5TCmE8IEyY0b0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 03:06:27PM -0800, Darrick J. Wong wrote:
> On Fri, Dec 18, 2020 at 09:15:09AM +1100, Dave Chinner wrote:
> > The obvious solution: we've moved the saved process state to a
> > different context, so it is no longer needed for the current
> > transaction we are about to commit. So How about just clearing the
> > saved state from the original transaction when swappingi like so:
> > 
> > static inline void
> > xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
> > {
> > 	ntp->t_pflags = tp->t_pflags;
> > 	tp->t_flags = 0;
> > }
> > 
> > And now, when we go to clear the transaction context, we can simply
> > do this:
> > 
> > static inline void
> > xfs_trans_context_clear(struct xfs_trans *tp)
> > {
> > 	if (tp->t_pflags)
> > 		memalloc_nofs_restore(tp->t_pflags);
> > }
> > 
> > and the problem is solved. The NOFS state will follow the active
> > transaction and not be reset until the entire transaction chain is
> > completed.
> 
> Er... correct me if I'm wrong, but I thought t_pflags stores the old
> state of current->flags from before we call xfs_trans_alloc?  So if we
> call into xfs_trans_alloc with current->flags==0 and we commit the
> transaction having not rolled, we won't unset the _NOFS state, and exit
> back to userspace with _NOFS set.

Minor thinko.

tp->t_pflags only stores a single bit of information w.r.t
PF_MEMALLOC_NOFS state, not the entire set of current task flags:
whether it should be cleared or not on a call to
memalloc_nofs_restore(). See memalloc_nofs_save():

static inline unsigned int memalloc_nofs_save(void)
{
        unsigned int flags = current->flags & PF_MEMALLOC_NOFS;
        current->flags |= PF_MEMALLOC_NOFS;
        return flags;
}

So, yeah, I got the t_pflags logic the wrong way around here - zero
means clear it, non-zero means don't clear it. IOWs, swap:

	ntp->t_pflags = tp->t_pflags;
	tp->t_flags = -1;

and clear:

	if (!tp->t_flags)
		memalloc_nofs_restore(tp->t_pflags);

This should only be temporary code, anyway. The next patch should
change this state clearing check to use current->journal_info, then
we aren't dependent on process flags state at all.

> I think the logic is correct here -- we transfer the old pflags value
> from @tp to @ntp, which effectively puts @ntp in charge of restoring the
> old pflags value; and then we set tp->t_pflags to current->flags, which
> means that @tp will "restore" the current pflags value into pflags, which
> is a nop.

That's pretty much what the current logic guarantees. Once the
wrappers provide this same guarantee, we can greatly simply the the
transaction context state management (i.e. set on alloc, swap on
dup, clear on free). And thread handoffs can just use clear/set
appropriately.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
