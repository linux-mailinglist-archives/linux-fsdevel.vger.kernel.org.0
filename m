Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E926D147
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 04:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIQChu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 22:37:50 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47931 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbgIQChs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 22:37:48 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2EBC38270C7;
        Thu, 17 Sep 2020 12:37:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kIjnq-00011T-Rc; Thu, 17 Sep 2020 12:37:42 +1000
Date:   Thu, 17 Sep 2020 12:37:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Remove shrinker's nr_deferred
Message-ID: <20200917023742.GT12096@dread.disaster.area>
References: <20200916185823.5347-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916185823.5347-1-shy828301@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=Q-JY_qLZEkq_jSbg818A:9 a=_x8q4c4buY6SSWo_:21 a=-F0HHi-jCq9ankDh:21
        a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:58:21AM -0700, Yang Shi wrote:
> 
> Recently huge amount one-off slab drop was seen on some vfs metadata heavy workloads,
> it turned out there were huge amount accumulated nr_deferred objects seen by the
> shrinker.
> 
> I managed to reproduce this problem with kernel build workload plus negative dentry
> generator.
> 
> First step, run the below kernel build test script:
> 
> NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`
> 
> cd /root/Buildarea/linux-stable
> 
> for i in `seq 1500`; do
>         cgcreate -g memory:kern_build
>         echo 4G > /sys/fs/cgroup/memory/kern_build/memory.limit_in_bytes
> 
>         echo 3 > /proc/sys/vm/drop_caches
>         cgexec -g memory:kern_build make clean > /dev/null 2>&1
>         cgexec -g memory:kern_build make -j$NR_CPUS > /dev/null 2>&1
> 
>         cgdelete -g memory:kern_build
> done
> 
> That would generate huge amount deferred objects due to __GFP_NOFS allocations.
> 
> Then run the below negative dentry generator script:
> 
> NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`
> 
> mkdir /sys/fs/cgroup/memory/test
> echo $$ > /sys/fs/cgroup/memory/test/tasks
> 
> for i in `seq $NR_CPUS`; do
>         while true; do
>                 FILE=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64`
>                 cat $FILE 2>/dev/null
>         done &
> done
> 
> Then kswapd will shrink half of dentry cache in just one loop as the below tracing result
> showed:
> 
> 	kswapd0-475   [028] .... 305968.252561: mm_shrink_slab_start: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0
> objects to shrink 4994376020 gfp_flags GFP_KERNEL cache items 93689873 delta 45746 total_scan 46844936 priority 12
> 	kswapd0-475   [021] .... 306013.099399: mm_shrink_slab_end: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0 unused
> scan count 4994376020 new scan count 4947576838 total_scan 8 last shrinker return val 46844928


You have 93M dentries and inodes in the cache, and the reclaim delta is 45746,
which is totally sane for a priority 12 reclaim priority. SO you've
basically had to do a couple of million GFP_NOFS direct reclaim
passes that were unable to reclaim anything to get to a point
where the deferred reclaim would up to 4.9 -billion- objects.

Basically, you would up the deferred work so far that it got out of
control before a GFP_KERNEL reclaim context could do anything to
bring it under control.

However, removing defered work is not the solution. If we don't
defer some of this reclaim work, then filesystem intensive workloads
-cannot reclaim memory from their own caches- when they need memory.
And when those caches largely dominate the used memory in the
machine, this will grind the filesystem workload to a halt.. Hence
this deferral mechanism is actually critical to keeping the
filesystem caches balanced with the rest of the system.

The behaviour you see is the windup clamping code triggering:

        /*
         * We need to avoid excessive windup on filesystem shrinkers
         * due to large numbers of GFP_NOFS allocations causing the
         * shrinkers to return -1 all the time. This results in a large
         * nr being built up so when a shrink that can do some work
         * comes along it empties the entire cache due to nr >>>
         * freeable. This is bad for sustaining a working set in
         * memory.
         *
         * Hence only allow the shrinker to scan the entire cache when
         * a large delta change is calculated directly.
         */
        if (delta < freeable / 4)
                total_scan = min(total_scan, freeable / 2);

It clamps the worst case freeing to half the cache, and that is
exactly what you are seeing. This, unfortunately, won't be enough to
fix the windup problem once it's spiralled out of control. It's
fairly rare for this to happen - it takes effort to find an adverse
workload that will cause windup like this.

So, with all that said, a year ago I actually fixed this problem
as part of some work I did to provide non-blocking inode reclaim
infrastructure in the shrinker for XFS inode reclaim.
See this patch:

https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/

It did two things. First it ensured all the deferred work was done
by kswapd so that some poor direct reclaim victim didn't hit a
massive reclaim latency spike because of windup. Secondly, it
clamped the maximum windup to the maximum single pass reclaim scan
limit, which is (freeable * 2) objects.

Finally it also changed the amount of deferred work a single kswapd
pass did to be directly proportional to the reclaim priority. Hence
as we get closer to OOM, kswapd tries much harder to get the
deferred work backlog down to zero. This means that a single, low
priority reclaim pass will never reclaim half the cache - only
sustained memory pressure and _reclaim priority windup_ will do
that.

You probably want to look at all the shrinker infrastructure patches
in that series as the deferred work tracking and accounting changes
span a few patches in the series:

https://lore.kernel.org/linux-xfs/20191031234618.15403-1-david@fromorbit.com/

Unfortunately, none of the MM developers showed any interest in
these patches, so when I found a different solution to the XFS
problem it got dropped on the ground.

> So why do we have to still keep it around? 

Because we need a feedback mechanism to allow us to maintain control
of the size of filesystem caches that grow via GFP_NOFS allocations.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
