Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8149114ACC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 03:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfLFCKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 21:10:08 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45500 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfLFCKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:10:07 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4B22F7EA9DE;
        Fri,  6 Dec 2019 13:09:54 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1id345-0007fT-Ps; Fri, 06 Dec 2019 13:09:53 +1100
Date:   Fri, 6 Dec 2019 13:09:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: fix hanging shrinker management on long
 do_shrink_slab
Message-ID: <20191206020953.GS2695@dread.disaster.area>
References: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
 <4e2d959a-0b0e-30aa-59b4-8e37728e9793@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2d959a-0b0e-30aa-59b4-8e37728e9793@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=qrpnvERzZt7yDo6Pn0wA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[please cc me on future shrinker infrastructure modifications]

On Mon, Dec 02, 2019 at 07:36:03PM +0300, Andrey Ryabinin wrote:
> 
> On 11/30/19 12:45 AM, Pavel Tikhomirov wrote:
> > We have a problem that shrinker_rwsem can be held for a long time for
> > read in shrink_slab, at the same time any process which is trying to
> > manage shrinkers hangs.
> > 
> > The shrinker_rwsem is taken in shrink_slab while traversing shrinker_list.
> > It tries to shrink something on nfs (hard) but nfs server is dead at
> > these moment already and rpc will never succeed. Generally any shrinker
> > can take significant time to do_shrink_slab, so it's a bad idea to hold
> > the list lock here.

registering/unregistering a shrinker is not a performance critical
task. If a shrinker is blocking for a long time, then we need to
work to fix the shrinker implementation because blocking is a much
bigger problem than just register/unregister.

> > The idea of the patch is to inc a refcount to the chosen shrinker so it
> > won't disappear and release shrinker_rwsem while we are in
> > do_shrink_slab, after that we will reacquire shrinker_rwsem, dec
> > the refcount and continue the traversal.

This is going to cause a *lot* of traffic on the shrinker rwsem.
It's already a pretty hot lock on large machines under memory
pressure (think thousands of tasks all doing direct reclaim across
hundreds of CPUs), and so changing them to cycle the rwsem on every
shrinker that will only make this worse. Esepcially when we consider
that there may be hundreds to thousands of registered shrinker
instances on large machines.

As an example of how frequent cycling of a global lock in shrinker
instances causes issues, we used to take references to superblock
shrinker count invocations to guarantee existence. This was found to
be a scalability limitation when lots of near-empty superblocks were
present in a system (see commit d23da150a37c ("fs/superblock: avoid
locking counting inodes and dentries before reclaiming them")).

This alleviated the problem for a while, but soon we had problems
with just taking a reference to the superblock in the callbacks that
did actual work. Hence we changed it to just take a per-superblock
rwsem to get rid of the global sb_lock spinlock in this path. See
commit eb6ef3df4faa ("trylock_super(): replacement for
grab_super_passive()". Now we don't have a scalability problem.

IOWs, we already know that cycling a global rwsem on every
individual shrinker invocation is going to cause noticable
scalability problems. Hence I don't think that this sort of "cycle
the global rwsem faster to reduce [un]register latency" solution is
going to fly because of the runtime performance regressions it will
introduce....

> I don't think this patch solves the problem, it only fixes one minor symptom of it.
> The actual problem here the reclaim hang in the nfs.

The nfs client is waiting on the NFS server to respond. It may
actually be that the server has hung, not the client...

> It means that any process, including kswapd, may go into nfs inode reclaim and stuck there.

*nod*

> I think this should be handled on nfs/vfs level by making  inode eviction during reclaim more asynchronous.

That's what we are trying to do with similar blocking based issues
in XFS inode reclaim. It's not simple, though, because these days
memory reclaim is like a bowl full of spaghetti covered with a
delicious sauce of non-obvious heuristics and broken
functionality....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
