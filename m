Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C53124411
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 11:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLRKQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 05:16:37 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:32940 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfLRKQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 05:16:36 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 24EA47EAA25;
        Wed, 18 Dec 2019 21:16:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ihWNW-0001D1-VB; Wed, 18 Dec 2019 21:16:26 +1100
Date:   Wed, 18 Dec 2019 21:16:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
Message-ID: <20191218101626.GV19213@dread.disaster.area>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <20191217115603.GA10016@dhcp22.suse.cz>
 <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
 <20191217165422.GA213613@cmpxchg.org>
 <20191218015124.GS19213@dread.disaster.area>
 <20191218043727.GA4877@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218043727.GA4877@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=7H7X384zT3chXl_or0EA:9
        a=oyxoQdQjQN0EMmIm:21 a=_HoB2m305JXCg2v8:21 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
        a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:37:27PM -0500, Johannes Weiner wrote:
> On Wed, Dec 18, 2019 at 12:51:24PM +1100, Dave Chinner wrote:
> > On Tue, Dec 17, 2019 at 11:54:22AM -0500, Johannes Weiner wrote:
> > > This problem exists independent of cgroup protection.
> > > 
> > > The inode shrinker may take down an inode that's still holding a ton
> > > of (potentially active) page cache pages when the inode hasn't been
> > > referenced recently.
> > 
> > Ok, please explain to me how are those pages getting repeated
> > referenced and kept active without referencing the inode in some
> > way?
> > 
> > e.g. active mmap pins a struct file which pins the inode.
> > e.g. open fd pins a struct file which pins the inode.
> > e.g. open/read/write/close keeps a dentry active in cache which pins
> > the inode when not actively referenced by the open fd.
> > 
> > AFAIA, all of the cases where -file pages- are being actively
> > referenced require also actively referencing the inode in some way.
> > So why is the inode being reclaimed as an unreferenced inode at the
> > end of the LRU if these are actively referenced file pages?
> > 
> > > IMO we shouldn't be dropping data that the VM still considers hot
> > > compared to other data, just because the inode object hasn't been used
> > > as recently as other inode objects (e.g. drowned in a stream of
> > > one-off inode accesses).
> > 
> > It should not be drowned by one-off inode accesses because if
> > the file data is being actively referenced then there should be
> > frequent active references to the inode that contains the data and
> > that should be keeping it away from the tail of the inode LRU.
> > 
> > If the inode is not being frequently referenced, then it
> > isn't really part of the current working set of inodes, is it?
> 
> The inode doesn't have to be currently open for its data to be used
> frequently and recently.

No, it doesn't have to be "open", but it has to be referenced if
pages are being added to or accessed from it's mapping tree.

e.g. you can do open/mmap/close, and the vma backing the mmap region
holds a reference to the inode via vma->vm_file until munmap is
called and the vma is torn down.

So:

> Executables that run periodically come to mind.

this requires mmap, hence an active inode reference, and so when the
vma is torn down, the inode is moved to the head of the inode cache
LRU. IF we keep running that same executable, the inode will be
repeatedly relocated to the head of the LRU every time the process
running the executable exits.

> An sqlite file database that is periodically opened and queried, then
> closed again.

dentry pins inode on open, struct file pins inpde until close,
dentry reference pins inode until shrinker reclaims dentry. Inode
goes on head of LRU when dentry is reclaimed. Repeated cycles will
hit either the dentry cache or if that's been reclaimed the inode
cache will get hit.

> A git repository.

same as sqlite case, just with many files.

IOWs, all of these data references take an active reference to the
inode and reset it's position in the inode cache LRU when the last
reference is dropped. If it's a dentry, it may not get dropped until
memory presure relaims the dentry. Hence inode cache LRU order does
not reflect the file data page LRU order in any way.

But my question still stands: how do you get page LRU references
without inode references? And if you can't, why should having cached
pages on the oldest unused, unreferenced inode in the LRU prevent
it's reclaim?

> I don't want a find or an updatedb, which doesn't produce active
> pages, and could be funneled through the cache with otherwise no side
> effects, kick out all my linux tree git objects via the inode shrinker
> just because I haven't run a git command in a few minutes.

That has nothing to do with this patch. updatedb and any file
traversal that touches data are going to be treated identically to
you precious working set because they all have nr_pages > 0.

IOWs, this patch does nothing to avoid the problem of single use
inodes streaming through the inode cache causing the reclaim of all
inodes. It just changes the reclaim behaviour and how quickly single
use inodes can be reclaimed. i.e. we now can't reclaim single use
inodes when they reach the end of the LRU, we have to wait for page
cache reclaim to free it's pages before the inode can be reclaimed.

Further, because inode LRU order is going to be different to page LRU
order, there's going to be a lot more useless scanning trying to
find inodes that can be reclaimed. Hence this changes cache balance,
reduces reclaim efficiency, increases reclaim priority windup as
less gets freed per scan, and this all ends up causing performance
and behavioural regressions in unexpected places.

i.e. this makes the page cache pin the inode in memory and that's a
major change in bheaviour. that's what caused all the performance
regressions with workloads that traverse a large single-use file set
such as a kernel compile - most files and their data are accessed
just once, and when they get to the end of the inode LRU we really
want to reclaim them immediately as they'll never get accessed
again.

To put it simply, if your goal is to avoid single use inodes from
trashing a long term working set of cached inodes, then this
patch does not provide the reliable or predictable object
management algorithm you are looking for.

If you want to address use-once cache trashing, how about working
towards a *smarter LRU algorithm* for the list_lru infrastructure?
Don't hack naive heuristics that "work for me" into the code, go
back to the algorithm and select something that is provent to
be resilient against use-once object storms.

i.e. The requirement is we retain quasi-LRU behaviour, but
allow use-once objects to cycle through the LRU without disturbing
frequently/recently referenced/active objects.  The
per-object reference bit we currently use isn't resilient against
large-scale use-once object cycling, so we have to improve on that.

Experience tells me we've solved this problem before, and it's right
in your area or expertise, too. We could modify the list-lru to use
a different LRU algorithm that is resilient against the sort of
flooding you are worried about. We could simply use a double clock
list like the page LRU uses - we promote frequently referenced
inodes to the active list when instead of setting a reference bit
when a reference is dropped and the indoe is on the inactive list.
And a small part of each shrinker scan count can be used to demote
the tail of the active list to keep it slowly cycling. This way
single use inodes will only ever pass through the inactive list
without perturbing the active list, and we've solved the problem of
single use inode streams trashing the working cache for all use
cases, not just one special case....

> > <sigh>
> > 
> > Remember this?
> > 
> > commit 69056ee6a8a3d576ed31e38b3b14c70d6c74edcc
> > Author: Dave Chinner <dchinner@redhat.com>
> > Date:   Tue Feb 12 15:35:51 2019 -0800
> > 
> >     Revert "mm: don't reclaim inodes with many attached pages"
> >     
> >     This reverts commit a76cf1a474d7d ("mm: don't reclaim inodes with many
> >     attached pages").
> >     
> >     This change causes serious changes to page cache and inode cache
> >     behaviour and balance, resulting in major performance regressions when
> >     combining worklaods such as large file copies and kernel compiles.
> >     
> >       https://bugzilla.kernel.org/show_bug.cgi?id=202441
> 
> I don't remember this, but reading this bugzilla thread is immensely
> frustrating.

So you're shooting the messenger as well, eh?

We went through this whole "blame XFS" circus sideshow when I found
the commits that caused the regression. It went on right up until
people using ext4 started reporting similar problems.

Yes, XFS users were the first to notice the issue, but that does
not make it an XFS problem!

> We've been carrying this patch here in our tree for over half a decade
> now to work around this exact stalling in the xfs shrinker:
>
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index d53a316162d6..45b3a4d07813 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -1344,7 +1344,7 @@ xfs_reclaim_inodes_nr(
>         xfs_reclaim_work_queue(mp);
>         xfs_ail_push_all(mp->m_ail);
> 
> -       return xfs_reclaim_inodes_ag(mp, SYNC_TRYLOCK | SYNC_WAIT, &nr_to_scan);
> +       return xfs_reclaim_inodes_ag(mp, SYNC_TRYLOCK, &nr_to_scan);
>  }
> 
> Because if we don't, our warmstorage machines lock up within minutes,
> long before Roman's patch.

Oh, go cry me a river. Poor little FB, has to carry an out-of-tree
hack that "works for them" because they don't care enough about
fixing it to help upstream address the underlying memory reclaim 
problems that SYNC_WAIT flag avoids.

Indeed, we (XFS devs) have repeatedly provided evidence that this
patch makes it relatively trivial for users to DOS systems via
OOM-killer rampages. It does not survive my trivial "fill memory
with inodes" test without the oom-killer killing the machine, and
any workload that empties the page cache before the inode cache is
prone to oom kill because nothing throttles reclaim anymore and
there are no pages left to reclaim or swap.

It is manifestly worse than what we have now, and that means it is
not a candidate for merging. We've told FB engineers this
*repeatedly*, and yet this horrible, broken, nasty, expedient hack
gets raised every time "shrinker" and "XFS" are mentioned in the
same neighbourhood.  Just stop it, please.

> The fact that xfs stalls on individual inodes while there might be a
> ton of clean cache on the LRUs is an xfs problem, not a VM problem.

No, at it's core it is a VM problem, because if we don't stall on
inode reclaim in XFS then memory reclaim does far worse things to
your machine than incur an occasional long tail latency.

You're free to use some other filesystem if you can't wait for
upstream XFS developers to fix it properly or you can't be bothered
to review the patches that actually attempt to fix the problem
properly...

> The right thing to do to avoid stalls in the inode shrinker is to skip
> over the dirty inodes and yield back to LRU reclaim; not circumvent
> page aging and drop clean inodes on the floor when those may or may
> not hold gigabytes of cache data that the inode shrinker knows
> *absolutely nothing* about.

*cough* [*]

https://lore.kernel.org/linux-mm/20191031234618.15403-1-david@fromorbit.com/

This implements exactly what you suggest - shrinkers that can
communicate the need for backoffs to the core infrastructure and
work deferral to kswapd rather than doing it themselves. And it uses
that capability to implement non-blocking inode reclaim for XFS.

So, how about doing something useful like reviewing the code that
tries to solve the problem you are whining about in the way you
say you want it solved?

I'd appreciate feedback on the shrinker algorithm factoring changes,
the scan algorithm changes,how I'm deferring work to kswapd, how I'm
triggering backoffs in the main vmscan loops differently for direct
reclaim vs kswapd, etc.

I'd also appreciate it if mm developers started working on fixing
the borken IO-based congestion back-off infrastructure (broken by
blk-mq) that makes it just about impossible to make core reclaim
backoffs work reliably or scale sufficiently to prevent
excessive/unbalanced reclaim occurring.

We also need better page vs shrinker reclaim balancing mechanisms to
allow the reclaim code throttle harder when there's a major page vs
slab cache imbalance. Right now it ends up swap-storming trying do
page reclaim when there's no page cache left and millions of clean
inodes to reclaim. (That's something that blocking on dirty inode
writeback avoided).

We also need mechanisms for detecting and preventing premature
priority windup (oom kill vector) that occurs when lots of direct
reclaim is run under GFP_NOFS context and shrinkers cannot make
reclaim progress and there is no page cache left to reclaim and
kswapd is blocked on swap IO...

There was also a bunch of broken swap vs block layer throttle
interactions as well that I've mentioned in the cover letters of
the initial patch sets that haven't been addressed, either...

All this requires core memory reclaim expertise, and that's
somethign I don't have. I can make the XFS inode cache shrinker
behave correctly, but I don't have the knowledge, expertise or
patience to fix the broken, horrible, spagetti-heuristic vmscan.c
code. So if you want this problem fixed, there's some work for you
to do....

-Dave.


[*] I've been saying this for *years*, ever since I first started
working on the shrinker scalability problem (~v3.0 timeframe, long
before FB ever tripped over it). But back then, nobody on the mm
side beleived that shrinkers needed to be as tightly integrated into
the memory reclaim scan loops as pages. There was a major disconnect
and lack of understanding that shrinkers, like page reclaim, need to
deal with throttling/back-off, IO, working set management, dirty
objects, numa scalabilty, etc.  Part of the problem was attitude -
"Oh, it's an XFS shrinker problem, ext4 doesn't need this, so we
don't need to care about that in core code...".

I'm glad that, after all these years, mm developers are finally
starting to realise that shrinker reclaim requirements are no
different to page reclaim requirements. Maybe it's time for me to
suggest, once again, that page LRU reclaim should just be another
set of shrinker instances and that all memory reclaim should be run
by a self-balancing shrinker instance scan loop, not just caches for
subsystems outside mm/.... 
-- 
Dave Chinner
david@fromorbit.com
