Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3A1FA3DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 01:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFOXG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 19:06:27 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:39356 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgFOXG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:06:27 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 69597D7BB12;
        Tue, 16 Jun 2020 09:06:16 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jkyB3-0000zE-Vj; Tue, 16 Jun 2020 09:06:05 +1000
Date:   Tue, 16 Jun 2020 09:06:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in
 ->writepages
Message-ID: <20200615230605.GV2040@dread.disaster.area>
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
 <e4c7868a-9107-573f-c1f4-24c3aa4c9d1f@applied-asynchrony.com>
 <20200615145331.GK25296@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615145331.GK25296@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=8nJEP1OIZ-IA:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=sTEJVhqn8-_9IwXEd_sA:9 a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:53:31PM +0200, Michal Hocko wrote:
> On Mon 15-06-20 16:25:52, Holger Hoffstätte wrote:
> > On 2020-06-15 13:56, Yafang Shao wrote:
> [...]
> > > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > > index b356118..1ccfbf2 100644
> > > --- a/fs/xfs/xfs_aops.c
> > > +++ b/fs/xfs/xfs_aops.c
> > > @@ -573,9 +573,21 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
> > >   	struct writeback_control *wbc)
> > >   {
> > >   	struct xfs_writepage_ctx wpc = { };
> > > +	unsigned int nofs_flag;
> > > +	int ret;
> > >   	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> > > -	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> > > +
> > > +	/*
> > > +	 * We can allocate memory here while doing writeback on behalf of
> > > +	 * memory reclaim.  To avoid memory allocation deadlocks set the
> > > +	 * task-wide nofs context for the following operations.
> > > +	 */
> > > +	nofs_flag = memalloc_nofs_save();
> > > +	ret = iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> > > +	memalloc_nofs_restore(nofs_flag);
> > > +
> > > +	return ret;
> > >   }
> > >   STATIC int
> > > 
> > 
> > Not sure if I did something wrong, but while the previous version of this patch
> > worked fine, this one gave me (with v2 removed obviously):
> > 
> > [  +0.000004] WARNING: CPU: 0 PID: 2811 at fs/iomap/buffered-io.c:1544 iomap_do_writepage+0x6b4/0x780
> 
> This corresponds to
>         /*
>          * Given that we do not allow direct reclaim to call us, we should
>          * never be called in a recursive filesystem reclaim context.
>          */
>         if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
>                 goto redirty;
> 
> which effectivelly says that memalloc_nofs_save/restore cannot be used
> for that code path.

No it doesn't. Everyone is ignoring the -context- of this code, most
especially the previous 3 lines of code and it's comment:

        /*
         * Refuse to write the page out if we are called from reclaim context.
         *
         * This avoids stack overflows when called from deeply used stacks in
         * random callers for direct reclaim or memcg reclaim.  We explicitly
         * allow reclaim from kswapd as the stack usage there is relatively low.
         *
         * This should never happen except in the case of a VM regression so
         * warn about it.
         */
        if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
                        PF_MEMALLOC))
                goto redirty;

You will see that we specifically avoid this path from reclaim
context except for kswapd. And kswapd always runs with GFP_KERNEL
context so we allow writeback from it, so it will pass both this
check and the NOFS check above. 

IOws, we can't trigger to the WARN_ON_ONCE(current->flags &
PF_MEMALLOC_NOFS)) check from a memory reclaim context: this
PF_MEMALLOC_NOFS check here is not doing what people think it is.

History lesson time, eh?

The recursion protection here -used- to use PF_FSTRANS, not
PF_MEMALLOC_NOFS. See commit 9070733b4efac ("xfs: abstract
PF_FSTRANS to PF_MEMALLOC_NOFS"). This hunk is most instructive
when you look at the comment:

         * Given that we do not allow direct reclaim to call us, we should
         * never be called while in a filesystem transaction.
         */
-       if (WARN_ON_ONCE(current->flags & PF_FSTRANS))
+       if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
                goto redirty;

It wasn't for memory allocation recursion protection in XFS - it was
for transaction reservation recursion protection by something trying
to flush data pages while holding a transaction reservation. Doing
this could deadlock the journal because the existing reservation
could prevent the nested reservation for being able to reserve space
in the journal and that is a self-deadlock vector.

IOWs, this check is not protecting against memory reclaim recursion
bugs at all (that's the previous check I quoted). This check is
protecting against the filesystem calling writepages directly from a
context where it can self-deadlock.

So what we are seeing here is that the PF_FSTRANS ->
PF_MEMALLOC_NOFS abstraction lost all the actual useful information
about what type of error this check was protecting against.

> Your stack trace doesn't point to a reclaim path
> which shows that this path is shared and also underlines that this is
> not really an intended use of the api.

Actually, Michal, it was your PF_FSTRANS -> PF_MEMALLOC_NOFS
abstraction of this code that turned this from "exactly what
PF_FSTRANS was intended to catch" to what you call "unintended use
of the API"....

IOWs, putting the iomap_writepage path under NOFS context is the
right thing to do from a "prevent memory reclaim" perspective, but
now we are hitting against the problems of repurposing filesystem
specific flags for subtlely different generic semantics...

I suspect we need to re-introduce PF_FSTRANS, set/clear/transfer it
again in all the places XFS used to transfer it, and change this
iomap check to use PF_FSTRANS and not PF_MEMALLOC_NOFS, because it's
clearly not and never has been a memory reclaim recursion warning
check....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
