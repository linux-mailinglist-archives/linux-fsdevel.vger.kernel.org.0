Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2ECD13653A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 03:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgAJCIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 21:08:42 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50267 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730601AbgAJCIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 21:08:41 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E49A47EB504;
        Fri, 10 Jan 2020 13:08:34 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ipjiz-0007T5-L4; Fri, 10 Jan 2020 13:08:33 +1100
Date:   Fri, 10 Jan 2020 13:08:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
Message-ID: <20200110020833.GU23195@dread.disaster.area>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <20191217115603.GA10016@dhcp22.suse.cz>
 <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
 <20191217165422.GA213613@cmpxchg.org>
 <20191218015124.GS19213@dread.disaster.area>
 <20191218043727.GA4877@cmpxchg.org>
 <20191218101626.GV19213@dread.disaster.area>
 <20191218213832.GA230750@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218213832.GA230750@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=1tRGglfpWey_l5rkNEMA:9 a=dEzsVAPaqpQDe6r7:21
        a=d4bkyZV3VSRJtGYr:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 04:38:32PM -0500, Johannes Weiner wrote:
> On Wed, Dec 18, 2019 at 09:16:26PM +1100, Dave Chinner wrote:
> > On Tue, Dec 17, 2019 at 11:37:27PM -0500, Johannes Weiner wrote:
> > > On Wed, Dec 18, 2019 at 12:51:24PM +1100, Dave Chinner wrote:
> > > > On Tue, Dec 17, 2019 at 11:54:22AM -0500, Johannes Weiner wrote:
> > > > > This problem exists independent of cgroup protection.
> > > > > 
> > > > > The inode shrinker may take down an inode that's still holding a ton
> > > > > of (potentially active) page cache pages when the inode hasn't been
> > > > > referenced recently.
> > > > 
> > > > Ok, please explain to me how are those pages getting repeated
> > > > referenced and kept active without referencing the inode in some
> > > > way?
> > > > 
> > > > e.g. active mmap pins a struct file which pins the inode.
> > > > e.g. open fd pins a struct file which pins the inode.
> > > > e.g. open/read/write/close keeps a dentry active in cache which pins
> > > > the inode when not actively referenced by the open fd.
> > > > 
> > > > AFAIA, all of the cases where -file pages- are being actively
> > > > referenced require also actively referencing the inode in some way.
> > > > So why is the inode being reclaimed as an unreferenced inode at the
> > > > end of the LRU if these are actively referenced file pages?
> > > > 
> > > > > IMO we shouldn't be dropping data that the VM still considers hot
> > > > > compared to other data, just because the inode object hasn't been used
> > > > > as recently as other inode objects (e.g. drowned in a stream of
> > > > > one-off inode accesses).
> > > > 
> > > > It should not be drowned by one-off inode accesses because if
> > > > the file data is being actively referenced then there should be
> > > > frequent active references to the inode that contains the data and
> > > > that should be keeping it away from the tail of the inode LRU.
> > > > 
> > > > If the inode is not being frequently referenced, then it
> > > > isn't really part of the current working set of inodes, is it?
> > > 
> > > The inode doesn't have to be currently open for its data to be used
> > > frequently and recently.
> > 
> > No, it doesn't have to be "open", but it has to be referenced if
> > pages are being added to or accessed from it's mapping tree.
> > 
> > e.g. you can do open/mmap/close, and the vma backing the mmap region
> > holds a reference to the inode via vma->vm_file until munmap is
> > called and the vma is torn down.
> > 
> > So:
> > 
> > > Executables that run periodically come to mind.
> > 
> > this requires mmap, hence an active inode reference, and so when the
> > vma is torn down, the inode is moved to the head of the inode cache
> > LRU. IF we keep running that same executable, the inode will be
> > repeatedly relocated to the head of the LRU every time the process
> > running the executable exits.
> > 
> > > An sqlite file database that is periodically opened and queried, then
> > > closed again.
> > 
> > dentry pins inode on open, struct file pins inpde until close,
> > dentry reference pins inode until shrinker reclaims dentry. Inode
> > goes on head of LRU when dentry is reclaimed. Repeated cycles will
> > hit either the dentry cache or if that's been reclaimed the inode
> > cache will get hit.
> > 
> > > A git repository.
> > 
> > same as sqlite case, just with many files.
> > 
> > IOWs, all of these data references take an active reference to the
> > inode and reset it's position in the inode cache LRU when the last
> > reference is dropped. If it's a dentry, it may not get dropped until
> > memory presure relaims the dentry. Hence inode cache LRU order does
> > not reflect the file data page LRU order in any way.
> > 
> > But my question still stands: how do you get page LRU references
> > without inode references? And if you can't, why should having cached
> > pages on the oldest unused, unreferenced inode in the LRU prevent
> > it's reclaim?
> 
> One of us is missing something really obvious here.
> 
> Let's say I'm routinely working with a git tree and the objects are
> cached by active pages. I'm using a modified mincore() that reports
> page active state, so the output here is active/present/filesize:
> 
> [hannes@computer linux]$ ~/src/mincore .git/objects/pack/*
> 17/17/17 .git/objects/pack/pack-1993efac574359d041b010c84d04eb0f05275bfd.idx
> 97/97/1168 .git/objects/pack/pack-1993efac574359d041b010c84d04eb0f05275bfd.pack

....

> Now something like updatedb, a find or comparable goes off and in a
> short amount of time creates a ton of one-off dentries, inodes, and
> file cache:
> 
> $ find /usr -type f -exec grep -q dave {} \;
> 
> LRU reclaim recognizes that the file cache produced by this operation
> is not used repeatedly and lets an infinite amount of it pass through
> the inactive list without disturbing my git tree workingset.

Yes, but even streaming single use pages through the cache slowly
turns over the active list. i.e. If you aren't referencing the git
tree working set, and that find takes long enough, it will still
turn over the active list and reclaim the git tree workingset.
"working set" only references cache that is being actively used -
you cannot expect unreferenced cached objects to be retained forever
under ongoing memory demand....

> The inode/dentry reclaim doesn't do the same thing. It looks at the
> references and delays the inevitable for a few more items coming
> through the LRU, but eventually it lets a bunch of objects that are
> only used once push out data that has been used over and over right
> before this burst of metadata objects came along.

Sure. The point I'm making is that this is the right behaviour for
at least as many workloads as it is the wrong behaviour, especially
on machines where that "single use" workload needs a lot of memory.
e.g. kernel compiles on machines with less memory than the build
requires greatly benefits from accelerated page cache pruning via
inode cache eviction.

> This isn't a theoretical issue. The reason people keep coming up with
> the same patch is because they hit exactly this problem in real life.

And they keep finding out that it causes performance regressions.

I'm not saying the current inode cache code is perfect - what I'm
saying is that just removing this heuristic causes unacceptible
performance regressions in common workloads, and so we *need a
different solution*.

> > Further, because inode LRU order is going to be different to page LRU
> > order, there's going to be a lot more useless scanning trying to
> > find inodes that can be reclaimed. Hence this changes cache balance,
> > reduces reclaim efficiency, increases reclaim priority windup as
> > less gets freed per scan, and this all ends up causing performance
> > and behavioural regressions in unexpected places.
> 
> It would be better to keep the inodes off the LRU entirely as long as
> they are not considered for reclaim. That would save some CPU churn.

I don't think there's any sane way to have the page cache pages on
an unreferenced inode keep it off the LRU. The whole point of the
LRU is that it tracks unreferenced inodes....

> > Experience tells me we've solved this problem before, and it's right
> > in your area or expertise, too. We could modify the list-lru to use
> > a different LRU algorithm that is resilient against the sort of
> > flooding you are worried about. We could simply use a double clock
> > list like the page LRU uses - we promote frequently referenced
> > inodes to the active list when instead of setting a reference bit
> > when a reference is dropped and the indoe is on the inactive list.
> > And a small part of each shrinker scan count can be used to demote
> > the tail of the active list to keep it slowly cycling. This way
> > single use inodes will only ever pass through the inactive list
> > without perturbing the active list, and we've solved the problem of
> > single use inode streams trashing the working cache for all use
> > cases, not just one special case....
> 
> I'm not opposed to any of this work, but I don't see how it would be a
> prerequisite to fixing the aging inversion we're talking about here -
> throwing out "unused" containers without looking at what's inside.
>
> On the contrary, the inode scanner would already make better decisions
> by simply not discarding all the usage information painstakingly
> gathered by the VM.

You appear to be starting from the position that "the VM is always
right", but the regressions that have been reported by changing this
code indicate otherwise. i.e. we know that page reclaim is not
perfect, and that despite the sophistication of the the workingset
retention code it is not onmipotent and so page reclaim still makes
wrong decisions. Similarly, inode reclaim can make wrong decisions.

From that perspective, simply replacing code that makes the wrong
decision in one common circumstance with code that makes a different
wrong decision in a different common cicrumstance is not an
improvement.  The solution needs to improve the situation without
regressions in common workloads, and if possible address the
fundamental issue that causes the problem.

> We can talk about the implementation, of course. Repeatedly skipping
> over inodes rather than physically taking them off the list can be a
> scalability problem; pushing the shrinker into dirty inodes can be a
> problem for certain filesystems. I didn't submit a patch for
> upstreaming, I sent a diff hunk to propose an aging hierarchy.

Sure, But history tells us that the proposed "aging hierarchy"
doesn't work for everyone.  It's not a viable solution, so can we
please move on from this specific idea?

AFAICT, all your problematic workloads are single use inodes causing
inode cache working set eviction. Making the inode cache LRU
resistant to single use cache eviction will solve these problems. It
will keep the existing "expediate page cache reclaim because the
current working set is larger than memory" behaviour of the inode
shrinker, but it will prevent this specific shrinker behaviour from
being invoked under workloads that stream single use inodes through
the cache.

Yes, it is more work, but architecturally it is the right way to
solve this problem because it will also likely improve the inode
cache working set retention (and hence performance) for a host of
other workloads, too.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
