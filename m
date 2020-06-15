Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458E91FA412
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 01:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFOXYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 19:24:09 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:60617 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgFOXYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:24:09 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id C9FC1108579;
        Tue, 16 Jun 2020 09:24:03 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jkySM-0000zv-Pn; Tue, 16 Jun 2020 09:23:58 +1000
Date:   Tue, 16 Jun 2020 09:23:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in
 ->writepages
Message-ID: <20200615232358.GW2040@dread.disaster.area>
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
 <e4c7868a-9107-573f-c1f4-24c3aa4c9d1f@applied-asynchrony.com>
 <20200615145331.GK25296@dhcp22.suse.cz>
 <20200615150736.GU8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615150736.GU8681@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=8nJEP1OIZ-IA:10 a=nTHF0DUjJn0A:10 a=07d9gI8wAAAA:8 a=7-415B0cAAAA:8
        a=1qhV6LbZMGmvVgBn4dMA:9 a=XM1BfgJEnEYWeaHb:21 a=yyMHCK8CtyEn-BmN:21
        a=wPNLvfGTeEIA:10 a=e2CUPOnPG4QKp8I52DXD:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:07:36AM -0700, Matthew Wilcox wrote:
> On Mon, Jun 15, 2020 at 04:53:31PM +0200, Michal Hocko wrote:
> > On Mon 15-06-20 16:25:52, Holger Hoffstätte wrote:
> > > On 2020-06-15 13:56, Yafang Shao wrote:
> > [...]
> > > > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > > > index b356118..1ccfbf2 100644
> > > > --- a/fs/xfs/xfs_aops.c
> > > > +++ b/fs/xfs/xfs_aops.c
> > > > @@ -573,9 +573,21 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
> > > >   	struct writeback_control *wbc)
> > > >   {
> > > >   	struct xfs_writepage_ctx wpc = { };
> > > > +	unsigned int nofs_flag;
> > > > +	int ret;
> > > >   	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> > > > -	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> > > > +
> > > > +	/*
> > > > +	 * We can allocate memory here while doing writeback on behalf of
> > > > +	 * memory reclaim.  To avoid memory allocation deadlocks set the
> > > > +	 * task-wide nofs context for the following operations.
> > > > +	 */
> > > > +	nofs_flag = memalloc_nofs_save();
> > > > +	ret = iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> > > > +	memalloc_nofs_restore(nofs_flag);
> > > > +
> > > > +	return ret;
> > > >   }
> > > >   STATIC int
> > > > 
> > > 
> > > Not sure if I did something wrong, but while the previous version of this patch
> > > worked fine, this one gave me (with v2 removed obviously):
> > > 
> > > [  +0.000004] WARNING: CPU: 0 PID: 2811 at fs/iomap/buffered-io.c:1544 iomap_do_writepage+0x6b4/0x780
> > 
> > This corresponds to
> >         /*
> >          * Given that we do not allow direct reclaim to call us, we should
> >          * never be called in a recursive filesystem reclaim context.
> >          */
> >         if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> >                 goto redirty;
> > 
> > which effectivelly says that memalloc_nofs_save/restore cannot be used
> > for that code path. Your stack trace doesn't point to a reclaim path
> > which shows that this path is shared and also underlines that this is
> > not really an intended use of the api. Please refer to
> > Documentation/core-api/gfp_mask-from-fs-io.rst for more details but
> > shortly the API should be used at the layer which defines a context
> > which shouldn't allow to recurse. E.g. a lock which would be problematic
> > in the reclaim recursion path.
> 
> I'm concerned that this might not be the correct approach.  Generally we
> have the rule that freeing memory should not require allocating memory
> to succeed.  Since XFS obviously does need to allocate memory to start
> a transaction, this allocation should normally be protected by a mempool
> or similar.

<sigh>

We've been down this path before about exactly how much memory XFS
uses to do extent allocation and why mempools nor any existing mm
infrastructure can actually guarantee filesystem transactions
forwards progress. e.g:

https://lwn.net/Articles/636797/

It's even more problematic now that extent allocation is not jsut
one transaction now, but is a series of overlapping linked
transactions that update things like refcount and reverse mapping
btrees, and not just the freespace and inode block map btrees...

> XFS is subtle and has its own rules around memory allocation and
> writeback, so I don't want to say this is definitely wrong.  I'm just
> saying that I have concerns it might not be right.

Almost all XFS memory allocations within the writeback path are
within transaction contexts - the transaction allocation itself is
an exception, but then xfs_trans_alloc() sets PF_MEMALLOC_NOFS
itself (used to be PF_FSTRANS, as per my previous comments in this
thread). Hence putting the entire ->writepages path under NOFS
context won't change anything materially for XFS.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
