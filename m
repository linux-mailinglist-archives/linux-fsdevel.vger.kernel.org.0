Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3734355ECA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 00:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhDFW2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 18:28:19 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53128 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhDFW2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 18:28:18 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B23C610429C2;
        Wed,  7 Apr 2021 08:28:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lTuB5-00DU1q-T8; Wed, 07 Apr 2021 08:28:07 +1000
Date:   Wed, 7 Apr 2021 08:28:07 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210406222807.GD1990290@dread.disaster.area>
References: <20210405054848.GA1077931@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405054848.GA1077931@in.ibm.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_x
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=5kV5c3wLyvlqFobTF28A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 05, 2021 at 11:18:48AM +0530, Bharata B Rao wrote:
> Hi,
> 
> When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> consumption increases quite a lot (around 172G) when the containers are
> running. Most of it comes from slab (149G) and within slab, the majority of
> it comes from kmalloc-32 cache (102G)
> 
> The major allocator of kmalloc-32 slab cache happens to be the list_head
> allocations of list_lru_one list. These lists are created whenever a
> FS mount happens. Specially two such lists are registered by alloc_super(),
> one for dentry and another for inode shrinker list. And these lists
> are created for all possible NUMA nodes and for all given memcgs
> (memcg_nr_cache_ids to be particular)
> 
> If,
> 
> A = Nr allocation request per mount: 2 (one for dentry and inode list)
> B = Nr NUMA possible nodes
> C = memcg_nr_cache_ids
> D = size of each kmalloc-32 object: 32 bytes,
> 
> then for every mount, the amount of memory consumed by kmalloc-32 slab
> cache for list_lru creation is A*B*C*D bytes.
> 
> Following factors contribute to the excessive allocations:
> 
> - Lists are created for possible NUMA nodes.
> - memcg_nr_cache_ids grows in bulk (see memcg_alloc_cache_id() and additional
>   list_lrus are created when it grows. Thus we end up creating list_lru_one
>   list_heads even for those memcgs which are yet to be created.
>   For example, when 10000 memcgs are created, memcg_nr_cache_ids reach
>   a value of 12286.

So, by your numbers, we have 2 * 2 * 12286 * 32 = 1.5MB per mount.

So for that to make up 100GB of RAM, you must have somewhere over
500,000 mounted superblocks on the machine?

That implies 50+ unique mounted superblocks per container, which
seems like an awful lot.

> - When a memcg goes offline, the list elements are drained to the parent
>   memcg, but the list_head entry remains.
> - The lists are destroyed only when the FS is unmounted. So list_heads
>   for non-existing memcgs remain and continue to contribute to the
>   kmalloc-32 allocation. This is presumably done for performance
>   reason as they get reused when new memcgs are created, but they end up
>   consuming slab memory until then.
> - In case of containers, a few file systems get mounted and are specific
>   to the container namespace and hence to a particular memcg, but we
>   end up creating lists for all the memcgs.
>   As an example, if 7 FS mounts are done for every container and when
>   10k containers are created, we end up creating 2*7*12286 list_lru_one
>   lists for each NUMA node. It appears that no elements will get added
>   to other than 2*7=14 of them in the case of containers.

Yeah, at first glance this doesn't strike me as a problem with the
list_lru structure, it smells more like a problem resulting from a
huge number of superblock instantiations on the machine. Which,
probably, mostly have no significant need for anything other than a
single memcg awareness?

Can you post a typical /proc/self/mounts output from one of these
idle/empty containers so we can see exactly how many mounts and
their type are being instantiated in each container?

> One straight forward way to prevent this excessive list_lru_one
> allocations is to limit the list_lru_one creation only to the
> relevant memcg. However I don't see an easy way to figure out
> that relevant memcg from FS mount path (alloc_super())

Superblocks have to support an unknown number of memcgs after they
have been mounted. bind mounts, child memcgs, etc, all mean that we
can't just have a static, single mount time memcg instantiation.

> As an alternative approach, I have this below hack that does lazy
> list_lru creation. The memcg-specific list is created and initialized
> only when there is a request to add an element to that particular
> list. Though I am not sure about the full impact of this change
> on the owners of the lists and also the performance impact of this,
> the overall savings look good.

Avoiding memory allocation in list_lru_add() was one of the main
reasons for up-front static allocation of memcg lists. We cannot do
memory allocation while callers are holding multiple spinlocks in
core system algorithms (e.g. dentry_kill -> retain_dentry ->
d_lru_add -> list_lru_add), let alone while holding an internal
spinlock.

Putting a GFP_ATOMIC allocation inside 3-4 nested spinlocks in a
path we know might have memory demand in the *hundreds of GB* range
gets an NACK from me. It's a great idea, but it's just not a
feasible, robust solution as proposed. Work out how to put the
memory allocation outside all the locks (including caller locks) and
it might be ok, but that's messy.

Another approach may be to identify filesystem types that do not
need memcg awareness and feed that into alloc_super() to set/clear
the SHRINKER_MEMCG_AWARE flag. This could be based on fstype - most
virtual filesystems that expose system information do not really
need full memcg awareness because they are generally only visible to
a single memcg instance...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
