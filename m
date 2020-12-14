Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A72DA25E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 22:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503695AbgLNVJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 16:09:40 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:39672 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503647AbgLNVJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 16:09:20 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id B9B5749952;
        Tue, 15 Dec 2020 08:08:33 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kov57-003zjp-3R; Tue, 15 Dec 2020 08:08:33 +1100
Date:   Tue, 15 Dec 2020 08:08:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 3/4] xfs: refactor the usage around
 xfs_trans_context_{set,clear}
Message-ID: <20201214210833.GE632069@dread.disaster.area>
References: <20201209131146.67289-1-laoar.shao@gmail.com>
 <20201209131146.67289-4-laoar.shao@gmail.com>
 <20201209195235.GN1943235@magnolia>
 <CALOAHbD_DK9w=s9RDsVBNaYwgeRi4UUEGDHFb3zEsqh_V8gLMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbD_DK9w=s9RDsVBNaYwgeRi4UUEGDHFb3zEsqh_V8gLMA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=pGLkceISAAAA:8 a=rA-29Kngl8b7e2x1wjEA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 05:09:02PM +0800, Yafang Shao wrote:
> On Thu, Dec 10, 2020 at 3:52 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Wed, Dec 09, 2020 at 09:11:45PM +0800, Yafang Shao wrote:
> > > The xfs_trans context should be active after it is allocated, and
> > > deactive when it is freed.
> > >
> > > So these two helpers are refactored as,
> > > - xfs_trans_context_set()
> > >   Used in xfs_trans_alloc()
> > > - xfs_trans_context_clear()
> > >   Used in xfs_trans_free()
> > >
> > > This patch is based on Darrick's work to fix the issue in xfs/141 in the
> > > earlier version. [1]
> > >
> > > 1. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia
> > >
> > > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  fs/xfs/xfs_trans.c | 28 +++++++++++++++-------------
> > >  1 file changed, 15 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > > index 11d390f0d3f2..4f4645329bb2 100644
> > > --- a/fs/xfs/xfs_trans.c
> > > +++ b/fs/xfs/xfs_trans.c
> > > @@ -67,6 +67,17 @@ xfs_trans_free(
> > >       xfs_extent_busy_sort(&tp->t_busy);
> > >       xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
> > >
> > > +
> > > +     /* Detach the transaction from this thread. */
> > > +     ASSERT(current->journal_info != NULL);
> > > +     /*
> > > +      * The PF_MEMALLOC_NOFS is bound to the transaction itself instead
> > > +      * of the reservation, so we need to check if tp is still the
> > > +      * current transaction before clearing the flag.
> > > +      */
> > > +     if (current->journal_info == tp)
> >
> > Um, you don't start setting journal_info until the next patch, so this
> > means that someone who lands on this commit with git bisect will have a
> > xfs with broken logic.
> >
> > Because this is the patch that changes where we set and restore NOFS
> > context, I think you have to introduce xfs_trans_context_swap here,
> > and not in the next patch.
> >
> 
> Thanks for the review. I will change it in the next version.
> 
> > I also think the _swap routine has to move the old NOFS state to the
> > new transaction's t_pflags,
> 
> Sure
> 
> > and then set NOFS in the old transaction's
> > t_pflags so that when we clear the context on the old transaction we
> > don't actually change the thread's NOFS state.
> >
> 
> Both thread's NOFS state and thead's journal_info state can't be
> changed in that case, right ?
> So should it better be,
> 
>     __xfs_trans_commit(tp, regrant)
>         xfs_trans_free(tp, regrant)
>             if (!regrant). // don't clear the xfs_trans_context if
> regrant is true.
>                 xfs_trans_context_clear()

No. You are trying to make this way more complex than it needs to be.
The logic in the core XFS code is *already correct* and all we need
to do is move that logic to wrapper functions, then slightly modify
the implementation inside the wrapper functions.

That is, xfs_trans_context_clear() should end up like this:

static inline void
xfs_trans_context_clear(struct xfs_trans *tp)
{
	/*
	 * If xfs_trans_context_swap() handed the NOFS context to a
	 * new transaction we do not clear the context here.
	 */
	if (current->journal_info != tp)
		return;
	current->journal_info = NULL;
	memalloc_nofs_restore(tp->t_pflags);
}

-Dave.
-- 
Dave Chinner
david@fromorbit.com
