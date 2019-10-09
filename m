Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E13D05FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfJIDVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:46 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47365 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730555AbfJIDVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:42 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3F9B743EC2D;
        Wed,  9 Oct 2019 14:21:27 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-0006B1-KZ; Wed, 09 Oct 2019 14:21:26 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-00038u-Gh; Wed, 09 Oct 2019 14:21:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 00/26] mm, xfs: non-blocking inode reclaim
Date:   Wed,  9 Oct 2019 14:20:58 +1100
Message-Id: <20191009032124.10541-1-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=XobE76Q3jBoA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=sqMGF3jvcCa2L6b3jykA:9 a=_feknGxYtQO_6_7X:21 a=ZM5fkm-pDuIZzAoa:21
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

This is the second version of the RFC I originally posted here:

https://lore.kernel.org/linux-xfs/20190801021752.4986-1-david@fromorbit.com/

The original description of the patchset is below, the issues and
approach to solving them has not changed. THere is some
restructuring of the patch set - the first few patches are all the
XFS fixes that can be merged regardless of the rest of the patchset,
but the non-blocking reclaim is somewhat dependent of them for
correct behaviour. The second set of patches are the shrinker
infrastructure changes needed for the shrinkers to feed back
reclaim progress to the main reclaim instructure and act on the
feedback. The last set of patches are the XFS changes needed to
convert inode reclaim over to a non-blocking, IO-less algorithm.

Version 2:

- added current_reclaim_account_pages() wrapper for reclaim_state updates
- moved xfs_buf page free accounting to the page freeing code rather than
  the reclaim loop that drops the LRU buffer reference.
- increased log CIL flush limit by 2x
- moved xfs_buf GFP_NOFS reclaim changes to correct patch
- renamed sc->will_defer to sc->defer_work
- used min() in do_shrink_slab() appropriately
- converted xfs_trans_ail_update_bulk() to use new xfs_ail_update_finish()
  function (fixes missing wakeups w/ xfs_ail_push_sync())
- fixed CIL size limit calculation units - was calculating min size in sectors
  rather than bytes. Fixes performance degradation w/ patch series.
- dropped shadow buffer freeing - Brain pointed out it wasn't doing exactly what
  I thought it was, and the memory saving were from the massively undersized
  CIL limits, not early freeing of the shadow buffers. Needs rethinking.
- fixed stray NULLCOMMITLSN in comments
- pinned items don't track the commit LSN, just the CIL sequence number so we
  can't use that to push the AIL.
- removed stale tracing debug from AIL push code.
- fixes to memory reclaim shrinker accounting in 5.3-rc3 result in direct
  reclaim backoff working a whole lot better, such that it's no long necessary
  for the XFS inode shrinker to wait for IO to complete. Changed the LRU reclaim
  logic to simply push on the AIL if dirty inodes are hit, but never wait on
  them. See the following commits for details of the shrinker
  accounting changes:

  0308f7cf19c9 ("mm/vmscan.c: calculate reclaimed slab caches in all reclaim paths")
  e5ca8071fe65 ("mm/vmscan.c: add a new member reclaim_state in struct shrink_control")

- Added a patch to convert xfs_reclaim_inodes() to use xfs_ail_push_all() which
  gets rid of the last user of xfs_ail_push_sync(). This allows it to be removed
  as "temporary infrastructure for the series" rather than having to be fixed up
  and made robust. The optimisations and factoring it drove are retained, as
  they are still a net improvement overall.
- fixed atomic_long vs atomic64 issues with shrinker deferral rework.
- don't drop ag reclaim cursor locking any more, it gets removed when all the
  old reclaim code is removed.
- added patch to change inode reclaim vs unreferenced XFS indoe lookup done by
  inode write clustering and inode cluster freeing. This gets rid of the need
  to cycle the ILOCK before running call_rcu() to queue the inode to be freed
  when the current RCU grace period expires. In doing so, the last major
  blocking point in XFS inode reclaim is removed.

Comments, thoughts, testing all welcome....

Cheers,

Dave.

---
Diffstat:

 drivers/staging/android/ashmem.c |   8 +-
 fs/gfs2/glock.c                  |   5 +-
 fs/gfs2/quota.c                  |   6 +-
 fs/inode.c                       |   3 +-
 fs/nfs/dir.c                     |   6 +-
 fs/super.c                       |   6 +-
 fs/xfs/xfs_buf.c                 |   4 +-
 fs/xfs/xfs_icache.c              | 628 +++++++++++----------------------------
 fs/xfs/xfs_icache.h              |  20 +-
 fs/xfs/xfs_inode.c               | 131 ++++----
 fs/xfs/xfs_inode.h               |   8 +
 fs/xfs/xfs_inode_item.c          |  28 +-
 fs/xfs/xfs_log.c                 |  10 +-
 fs/xfs/xfs_log_cil.c             |  37 ++-
 fs/xfs/xfs_log_priv.h            |  53 +++-
 fs/xfs/xfs_mount.c               |  10 +-
 fs/xfs/xfs_mount.h               |   6 +-
 fs/xfs/xfs_qm.c                  |  11 +-
 fs/xfs/xfs_super.c               |  94 ++++--
 fs/xfs/xfs_trace.h               |   1 +
 fs/xfs/xfs_trans_ail.c           |  88 ++++--
 fs/xfs/xfs_trans_priv.h          |   6 +-
 include/linux/shrinker.h         |   9 +-
 include/linux/swap.h             |  23 +-
 include/trace/events/vmscan.h    |  69 ++---
 mm/slab.c                        |   3 +-
 mm/slob.c                        |   4 +-
 mm/slub.c                        |   3 +-
 mm/vmscan.c                      | 231 +++++++++-----
 net/sunrpc/auth.c                |   5 +-
 30 files changed, 741 insertions(+), 775 deletions(-)

---
[Original V1 patchset description]

We've had a problem with inode reclaim for a long time - XFS is
capable of caching tens of millions of inodes with ease and dirtying
hundreds of thousands of those cached inodes every second. It is
also capable of reclaiming more than half a million clean inodes per
second per reclaim thread.

The result of this is that when there is a significant change in
sustained memory pressure on a system ith a large inode cache,
memory reclaim rapdily frees all the clean inodes, but cannot make
progress on reclaiming dirty inodes because they are rate limited
by IO.

However, the shrinker infrastructure in the kernel has no way to
feed back rate limiting to the core memory reclaim algorithms.  In
fact there are no feedback mechanisms at all, and so when reclaim
has freed all the clean inodes and starts hitting dirty inodes, the
filesystem has no way of telling reclaim that the inode reclaim rate
has dropped from 500k/s to 500/s.

The result is that reclaim continues to try to free memory, and
because it makes no progress freeing inodes, it puts much more
pressure on the page LRUs and frees pages. When it runs out of
pages, it starts swapping, and when it runs out of swap or can't get
a page for swap-in it starts going on an OOM kill rampage.

That does nothing to "fix" the shortage of memory caused by the
slowness of dirty inode reclaim - if memory demand continues we just
keep hitting the OOM killer until either something critical is
killed or memory demand eases.

For a long time, XFS has avoided the insane spiral of shouty
OOM-killer rage death by cleaning inodes directly in the shrinker.
This has the effect of throttling memory reclaim to the rate at
which dirty inodes can be cleaned, and so when we get into the state
when memory reclaim is dependent on inode reclaim making progress
we don't ever allow LRU reclaim to run so far ahead of inode reclaim
that it winds up reclaim priority and runs out of LRU pages to
reclaim and/or swap.

This has a downside, though. When there is a large amount of clean
page cache and a small amount of inode cache that is dirty (e.g.
lots of file data pressure and/or application memory demand) the
inode reclaim shrinkers can run out of clean inodes to reclaim and
start blocking on inode writeback. This can result in long reclaim
latencies even though there is lots of memory that can be
immediately reclaimed from the page cache.

There are other issues, too. We have to block kswapd, too, because
it will continue running until watermarks are satisfied, and that
is largely the vector for shouty swappy death if it doesn't back
off before priority windup from lack of progress occurs. Blocking
kswapd then affects direct reclaim function, which often backs off
expecting kswapd to make progress in the mean time. But if kswapd
is not making progress, direct reclaim ends up in priority windup
from lack of progress, too. This is especially prevalent in
workloads that have a high percentage of GFP_NOFS allocations (e.g.
filesystem modification workloads).

The shrinkers have another problem w/ GFP_NOFS reclaim: the work
that is deferred because the shrinker cannot make progress gets
lumped on the first reclaim context that can do that work. That
means a direct reclaimer might get lumped with scanning millions of
objects during low priority scanning when it should only be scanning
a couple of thousand objects. This can result in highly
unpredictable and extremely long direct reclaim delays.

This is most definitely sub-optimal, but it's better than random
and/or premature OOM killer invocation under trivial workloads and
lots of reclaimable memory still being available.

This patch set aims to fix all these problems. The memory reclaim
and shrinker changes involve:

- a substantial rework of how the shrinker defers work, moving all
  the deferred work to kswapd to remove all the unpredictability
  from direct reclaim.  Direct reclaim will only do the work the
  direct reclaim context determines is necesary.

- deferred work is capped, and the amount of deferred work kswapd
  will do in each scan is increased linearly w.r.t. increasing
  reclaim priority. Hence when we are desparate for memory, kswapd
  will be running all the deferred work as quickly as possible.

- The amount of deferred work and the amount of scanning that is
  done by the shrinkers is now tracked in the struct reclaim_state.
  This allows shrink_node() to see how much work is being done in
  comparison to both the LRU scanning and how much is being deferred
  to kswapd. This allows direct reclaim to back off when too much
  work is being deferred and hence allow kswapd to make progress on
  the deferred work while it waits.

- A "need backoff" flag has been added to the struct reclaim_state.
  This allows individual shrinkers to indicate to kswapd that they
  need some time to finish work before being scanned again. This is
  basically for the same case as kswapd backs off from LRU scanning.

  i.e. the LRU scanning has run into the tail of the LRU and is
  finding dirty objects that require IO to complete before reclaim
  can make further progress. This is exactly the same problem we
  have with inode reclaim in XFS, and it is this mechanism that
  enables us to move to IO-less inode reclaim.

The XFS changes are all over the place, and address both the reclaim
blocking problems and all the other related issues I found while
working on this patchest. These involve:

- fixing IO priority inversion problems between metadata
  writeback (inodes!) and log IO caused by the block layer write
  throttling (more on this later).

- some slab caches weren't marked as reclaimable, so were
  incorrectly accounted. Also account for the pages xfs_buf reclaim
  releases.

- reduced the delayed logging dirty item aggregation size (the CIL).
  This defines the minimum amount of memory XFS can operate in when
  there is heavy modifications in progress.

- reduced the memory footprint of the CIL when repeated
  modifications to objects occur.

- Added a mechanism to push the AIL to a specific LSN (metadata
  modification epoch) and wait for it. This forms the basis for
  direct inode reclaim deferring IO and waiting for some progress
  without issuing IO iteslf.

- reworked inode reclaim to use a list_lru to track inodes in
  reclaim rather than a radix tree tag in the inode cache. We
  iterated the radix tree for reclaim because it resulted in optimal
  IO patterns from multiple concurrent reclaimers, but we dont' have
  to care about that any more because all IO comes from the AIL now.

  This gives us try LRU reclaim, and it allows us to effectively
  determine when we've run out of clean inodes to easily reclaim and
  provide that feedback to the higher levels via the "need backoff"
  flag.

- direct reclaim is non-blocking while scanning, but at the end of a
  scan it will still block waiting for IO, but only for /some/
  progress to be made and not specific individual IOs.

- kswapd based reclaim is fully non-blocking.

The result is that there is now enough feedback from the shrinkers
into the main memory reclaim loop for it to back off in the
situations where back-off is required to avoid OOM killer
invocation, despite XFS now largely doing non-blocking reclaim.

Testing involves at 16p/16GB machine running a fsmark workload that
creates sustained heavy dirty inode cache pressure, then
progressively locking 2GB of memory at time to squeeze the workload
into less and less memory. A vanilla kernel runs well up to 12GB
squeezed, but at 14GB squeezed performance goes to hell. With just
the hacky "don't block kswapd by removing SYNC_WAIT" patch that
people seem to like, OOM kills start when squeezed to 12GB. With
that extended to direct reclaim, OOM kills start with squeezed to
just 8GB. With the full patchset, it runs similar to a vanilla
kernel up to 12GB squeezed, and vastly out-performs the vanilla
kernel with 14GB squeezed. Performance only drops ~20% with a 14GB
squeeze, whereas the vanilla kernel sees up to a 90% drop in
performance.

I also run testing with simoop, a simulated workload that Chris
Mason put together to demonstrate the long tail latency and
allocation stall problems the blocking in inode reclaim was causing.
The vanilla kernel averaged ~5 stalls/s over a test period of 10
hours, this patch series resulted in:

alloc stall rate = 0.00/sec (avg: 0.04) (p50: 0.04) (p95: 0.16) (p99: 0.32)

stalls almost going away entirely.

So the signs are there that this is a workable solution to the
problems caused by blocking inode reclaim without re-introducing the
the Death-by-OOM-killer issues the blocking avoids.

Please note that I haven't full gone non-blocking on direct reclaim
for a couple of reasons:

1. congestion_wait() and wait_iff_congested() are completely broken.
The blkmq change-over ripped out all the block layer congestion
reporting in 5.0 and didn't replace it with anything, so unless you
are operating on an NFS client, Ceph, FUSE or a DVD, congestion
checks and backoff aren't actually doing what they are supposed to.
i.e. wait_iff_congested() never blocks, and congestion_wait() always
sleeps for it's full timeout.

IOWs, the whole bdi-based IO congestion feedback mechanism no longer
functions as intended, and so I'm betting a lot of the memory
reclaim heuristics no longer function as they were intended to...

2. The block layer write throttle is full of priority inversions.
Apart from the log IO one I fixed in this series, I noticed that
swap in/out has a major problem. I lost count of the number of OOM
kills that occurred from the swap in path when there were several
processes blocked in wbt_wait() in the block layer in the swap out
path. i.e. if swap out had been making progress, swap in would not
have oom killed. Hence I found it still necessary to throttle direct
reclaim back in the shrinker as there wasn't a realiable way to get
the core reclaim code to throttle effectively.

FWIW, from the swap in/out perspective, this whole inversion problem
is made worse by #1: the congestion_wait/wait_iff_congested
interfaces being broken. Direct reclaim uses wait_iff_congested() to
back off if kswapd has indicated that the node is congested
(PGDAT_CONGESTED) and reclaim is struggling to make progress.
However, this backoff never actually happens now and hence direct
reclaim barrels into the swap code as hard as it can and blocks in
wbt_wait() waiting behind other swap IO instead of backing off and
waiting for some IO to complete and then retrying it's allocation....

So maybe if we fix the bdi congestion interfaces so they work again
we can get rid of the waiting in direct reclaim, but right now I
don't see any other choice....


