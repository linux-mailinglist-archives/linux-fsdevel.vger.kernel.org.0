Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D99EA5A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 22:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfJ3Vnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 17:43:42 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43060 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbfJ3Vnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:43:41 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C48267E9BCE;
        Thu, 31 Oct 2019 08:43:37 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iPvkd-0006QK-OU; Thu, 31 Oct 2019 08:43:35 +1100
Date:   Thu, 31 Oct 2019 08:43:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191030214335.GQ4614@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191030172517.GO15222@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030172517.GO15222@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=D5QIZhWRPjQ8d_Cs2q0A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 30, 2019 at 10:25:17AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 09, 2019 at 02:21:02PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > The buffer cache shrinker frees more than just the xfs_buf slab
> > objects - it also frees the pages attached to the buffers. Make sure
> > the memory reclaim code accounts for this memory being freed
> > correctly, similar to how the inode shrinker accounts for pages
> > freed from the page cache due to mapping invalidation.
> > 
> > We also need to make sure that the mm subsystem knows these are
> > reclaimable objects. We provide the memory reclaim subsystem with a
> > a shrinker to reclaim xfs_bufs, so we should really mark the slab
> > that way.
> > 
> > We also have a lot of xfs_bufs in a busy system, spread them around
> > like we do inodes.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  fs/xfs/xfs_buf.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index e484f6bead53..45b470f55ad7 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -324,6 +324,9 @@ xfs_buf_free(
> >  
> >  			__free_page(page);
> >  		}
> > +		if (current->reclaim_state)
> > +			current->reclaim_state->reclaimed_slab +=
> > +							bp->b_page_count;
> 
> Hmm, ok, I see how ZONE_RECLAIM and reclaimed_slab fit together.
> 
> >  	} else if (bp->b_flags & _XBF_KMEM)
> >  		kmem_free(bp->b_addr);
> >  	_xfs_buf_free_pages(bp);
> > @@ -2064,7 +2067,8 @@ int __init
> >  xfs_buf_init(void)
> >  {
> >  	xfs_buf_zone = kmem_zone_init_flags(sizeof(xfs_buf_t), "xfs_buf",
> > -						KM_ZONE_HWALIGN, NULL);
> > +			KM_ZONE_HWALIGN | KM_ZONE_SPREAD | KM_ZONE_RECLAIM,
> 
> I guess I'm fine with ZONE_SPREAD too, insofar as it only seems to apply
> to a particular "use another node" memory policy when slab is in use.
> Was that your intent?

It's more documentation than anything - that we shouldn't be piling
these structures all on to one node because that can have severe
issues with NUMA memory reclaim algorithms. i.e. the xfs-buf
shrinker sets SHRINKER_NUMA_AWARE, so memory pressure on a single
node can reclaim all the xfs-bufs on that node without touching any
other node.

That means, for example, if we instantiate all the AG header buffers
on a single node (e.g. like we do at mount time) then memory
pressure on that one node will generate IO stalls across the entire
filesystem as other nodes doing work have to repopulate the buffer
cache for any allocation for freeing of space/inodes..

IOWs, for large NUMA systems using cpusets this cache should be
spread around all of memory, especially as it has NUMA aware
reclaim. For everyone else, it's just documentation that improper
cgroup or NUMA memory policy could cause you all sorts of problems
with this cache.

It's worth noting that SLAB_MEM_SPREAD is used almost exclusively in
filesystems for inode caches largely because, at the time (~2006),
the only reclaimable cache that could grow to any size large enough
to cause problems was the inode cache. It's been cargo-culted ever
since, whether it is needed or not (e.g. ceph).

In the case of the xfs_bufs, I've been running workloads recently
that cache several million xfs_bufs and only a handful of inodes
rather than the other way around. If we spread inodes because
caching millions on a single node can cause problems on large NUMA
machines, then we also need to spread xfs_bufs...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
