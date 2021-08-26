Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510173F9056
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 23:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbhHZVyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 17:54:18 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:38607 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243662AbhHZVyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:54:15 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 7A65180C18D;
        Fri, 27 Aug 2021 07:53:21 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mJNJI-005K8B-D9; Fri, 27 Aug 2021 07:53:20 +1000
Date:   Fri, 27 Aug 2021 07:53:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, it+linux-xfs@molgen.mpg.de,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Minimum inode cache size? (was: Slow file operations on file
 server with 30 TB hardware RAID and 100 TB software RAID)
Message-ID: <20210826215320.GO3657114@dread.disaster.area>
References: <dcc07afa-08c3-d2d3-7900-75adb290a1bc@molgen.mpg.de>
 <3e380495-5f85-3226-f0cf-4452e2b77ccb@molgen.mpg.de>
 <58e701f4-6af1-d47a-7b3e-5cadf9e27296@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58e701f4-6af1-d47a-7b3e-5cadf9e27296@molgen.mpg.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=IkcTkHD0fZMA:10 a=MhDmnRu9jo8A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=LmiyH4qz7PP4_n44nj0A:9 a=QEXdDO2ut3YA:10 a=q5j3cmb3fbAA:10
        a=2Q4jQssJKWwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 12:41:25PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> > > The current explanation is, that over night several maintenance
> > > scripts like backup/mirroring and accounting scripts are run, which
> > > touch all files on the devices. Additionally sometimes other users
> > > run cluster jobs with millions of files on the software RAID. Such
> > > things invalidate the inode cache, and “my” are thrown out. When I
> > > use it afterward it’s slow in the beginning. There is still free
> > > memory during these times according to `top`.

Yup. Your inodes are not in use, so they get cycled out of memory
for other inodes that are in active use.

> >      $ free -h
> >                    total        used        free      shared  buff/cache available
> >      Mem:            94G        8.3G        5.3G        2.3M         80G       83G
> >      Swap:            0B          0B          0B
> > 
> > > Does that sound reasonable with ten million inodes? Is that easily
> > > verifiable?
> > 
> > If an inode consume 512 bytes with ten million inodes, that would be
> > around 500 MB, which should easily fit into the cache, so it does not
> > need to be invalidated?
> 
> Something is wrong with that calculation, and the cache size is much bigger.

Inode size on disk != inode size in memory. Typically a clean XFS
inode in memory takes up ~1.1kB, regardless of on-disk size. An
inode that has been dirtied takes about 1.7kB.

> Looking into `/proc/slabinfo` and XFS’ runtime/internal statistics [1], it
> turns out that the inode cache is likely the problem.
> 
> XFS’ internal stats show that only one third of the inodes requests are
> answered from cache.
> 
>     $ grep ^ig /sys/fs/xfs/stats/stats
>     ig 1791207386 647353522 20111 1143854223 394 1142080045 10683174

Pretty normal for a machine that has diverse worklaods, large data
sets and fairly constant memory pressure...

> During the problematic time, the SLAB size is around 4 GB and, according to
> slabinfo, the inode cache only has around 200.000 (sometimes even as low as
> 50.000).

Yup, that indicates the workload that has been running has been
generating either user space or page cache memory pressure, not
inode cache memory pressure. As a result, memory reclaim has
reclaimed the unused inode caches. This is how things are supposed
to work - the kernel adjusts it's memory usage according what is
consuming memory at the time there is memory demand.

>     $ sudo grep inode /proc/slabinfo
>     nfs_inode_cache       16     24   1064    3    1 : tunables   24 12    8
> : slabdata      8      8      0
>     rpc_inode_cache       94    138    640    6    1 : tunables   54 27    8
> : slabdata     23     23      0
>     mqueue_inode_cache      1      4    896    4    1 : tunables   54  27
> 8 : slabdata      1      1      0
>     xfs_inode         1693683 1722284    960    4    1 : tunables   54   27
> 8 : slabdata 430571 430571      0
>     ext2_inode_cache       0      0    768    5    1 : tunables   54 27    8
> : slabdata      0      0      0
>     reiser_inode_cache      0      0    760    5    1 : tunables   54  27
> 8 : slabdata      0      0      0
>     hugetlbfs_inode_cache      2     12    608    6    1 : tunables 54   27
> 8 : slabdata      2      2      0
>     sock_inode_cache     346    670    768    5    1 : tunables   54 27    8
> : slabdata    134    134      0
>     proc_inode_cache     121    288    656    6    1 : tunables   54 27    8
> : slabdata     48     48      0
>     shmem_inode_cache   2249   2827    696   11    2 : tunables   54 27    8
> : slabdata    257    257      0
>     inode_cache       209098 209482    584    7    1 : tunables   54 27    8
> : slabdata  29926  29926      0
> 
> (What is the difference between `xfs_inode` and `inode_cache`?)

"inode_cache" is the generic inode slab cache used for things like
/proc and other VFS level psuedo filesytems. "xfs_inode_cache" is
the inodes used by XFS.

> Then going through all the files with `find -ls`, the inode cache grows to
> four to five million and the SLAB size grows to around 8 GB. Over night it
> shrinks back to the numbers above and the page cache grows back.

Yup, that's caching all the inodes the find traverses because it is
accessing the inodes and not just reading the directory structure.
There's likely 4-5 million inodes in that directory structure.

This is normal - the kernel is adjusting it's memory usage according
to the workload that is currently running. However, if you don't
access those inodes again, and the system is put under memory
pressure, they'll get reclaimed and the memory used for whatever is
demanding memory at that point in time.

Again, this is normal behaviour for machines with mulitple discrete,
diverse workloads with individual data sets and memory demand that,
in aggregate, are larger than the machine has the memory to hold. At
some point, we have to give back kernel memory so the current
application and data set can run efficiently from RAM...

> In the discussions [2], adji`vfs_cache_pressure` is recommended, but –
> besides setting it to 0 – it only seems to delay the shrinking of the cache.
> (As it’s an integer 1 is the lowest non-zero (positive) number, which would
> delay it by a factor of 100.

That's exactly what vfs_cache_pressure is intended to do - you can
slow down the reclaim of inodes and dentries, but if you have enough
memory demand for long enough, it will not prevent indoes that have
not been accessed for hours from being reclaimed.

Of course, setting it so zero is also behaving as expected - that
prevents memory reclaim from reclaiming dentries and inodes and
other filesystem caches. This is absolutely not recommended as it
can result in all of memory being filled with filesystem caches and
the system can then OOM in unrecoverable ways because the memory
held in VFS caches cannot be reclaimed.

> Is there a way to specify the minimum numbers of entries in the inode cache,
> or a minimum SLAB size up to that the caches should not be decreased?

You have a workload resource control problem, not an inode cache
problem. This is a problem control groups are intended to solve. For
controlling memory usage behaviour of workloads, see:

https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#memory

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
