Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4072D35690E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350701AbhDGKH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 06:07:58 -0400
Received: from relay.sw.ru ([185.231.240.75]:60322 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350740AbhDGKHv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=viSTuxs1TbvntX0V9jn+SqiOPlF9KJSz3P3BWHyPYoI=; b=yatOTgcV++Qd/gWdU
        Ns7Io0AqJ8bL8avA9ZvymCvehtt/AtVaQhm71N5IrjhVZrpsPapaESf2/2ZecmKupql7l6exrbe8l
        QBLEtktvqnhyBYIGKRq3FQhUWA3sgSs4xq+a0l+/dMZcRqEwAezceKUpb82t5ePBTd3LToIQs8dhc
        =;
Received: from [192.168.15.55]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1lU55s-000OgD-G4; Wed, 07 Apr 2021 13:07:28 +0300
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
To:     bharata@linux.ibm.com, Dave Chinner <david@fromorbit.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20210405054848.GA1077931@in.ibm.com>
 <20210406222807.GD1990290@dread.disaster.area>
 <20210407050541.GC1354243@in.ibm.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c9bd1744-f15c-669a-b3a9-5a0c47bd4e1d@virtuozzo.com>
Date:   Wed, 7 Apr 2021 13:07:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210407050541.GC1354243@in.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07.04.2021 08:05, Bharata B Rao wrote:
> On Wed, Apr 07, 2021 at 08:28:07AM +1000, Dave Chinner wrote:
>> On Mon, Apr 05, 2021 at 11:18:48AM +0530, Bharata B Rao wrote:
>>> Hi,
>>>
>>> When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
>>> server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
>>> consumption increases quite a lot (around 172G) when the containers are
>>> running. Most of it comes from slab (149G) and within slab, the majority of
>>> it comes from kmalloc-32 cache (102G)
>>>
>>> The major allocator of kmalloc-32 slab cache happens to be the list_head
>>> allocations of list_lru_one list. These lists are created whenever a
>>> FS mount happens. Specially two such lists are registered by alloc_super(),
>>> one for dentry and another for inode shrinker list. And these lists
>>> are created for all possible NUMA nodes and for all given memcgs
>>> (memcg_nr_cache_ids to be particular)
>>>
>>> If,
>>>
>>> A = Nr allocation request per mount: 2 (one for dentry and inode list)
>>> B = Nr NUMA possible nodes
>>> C = memcg_nr_cache_ids
>>> D = size of each kmalloc-32 object: 32 bytes,
>>>
>>> then for every mount, the amount of memory consumed by kmalloc-32 slab
>>> cache for list_lru creation is A*B*C*D bytes.
>>>
>>> Following factors contribute to the excessive allocations:
>>>
>>> - Lists are created for possible NUMA nodes.
>>> - memcg_nr_cache_ids grows in bulk (see memcg_alloc_cache_id() and additional
>>>   list_lrus are created when it grows. Thus we end up creating list_lru_one
>>>   list_heads even for those memcgs which are yet to be created.
>>>   For example, when 10000 memcgs are created, memcg_nr_cache_ids reach
>>>   a value of 12286.
>>
>> So, by your numbers, we have 2 * 2 * 12286 * 32 = 1.5MB per mount.
>>
>> So for that to make up 100GB of RAM, you must have somewhere over
>> 500,000 mounted superblocks on the machine?
>>
>> That implies 50+ unique mounted superblocks per container, which
>> seems like an awful lot.
> 
> Here is how the calculation turns out to be in my setup:
> 
> Number of possible NUMA nodes = 2
> Number of mounts per container = 7 (Check below to see which are these)
> Number of list creation requests per mount = 2
> Number of containers = 10000
> memcg_nr_cache_ids for 10k containers = 12286

Luckily, we have "+1" in memcg_nr_cache_ids formula: size = 2 * (id + 1).
In case of we only multiplied it, you would have to had memcg_nr_cache_ids=20000.

Maybe, we need change that formula to increase memcg_nr_cache_ids more accurate
for further growths of containers number. Say,

size = id < 2000 ? 2 * (id + 1) : id + 2000

> size of kmalloc-32 = 32 byes
> 
> 2*7*2*10000*12286*32 = 110082560000 bytes = 102.5G
> 
>>
>>> - When a memcg goes offline, the list elements are drained to the parent
>>>   memcg, but the list_head entry remains.
>>> - The lists are destroyed only when the FS is unmounted. So list_heads
>>>   for non-existing memcgs remain and continue to contribute to the
>>>   kmalloc-32 allocation. This is presumably done for performance
>>>   reason as they get reused when new memcgs are created, but they end up
>>>   consuming slab memory until then.
>>> - In case of containers, a few file systems get mounted and are specific
>>>   to the container namespace and hence to a particular memcg, but we
>>>   end up creating lists for all the memcgs.
>>>   As an example, if 7 FS mounts are done for every container and when
>>>   10k containers are created, we end up creating 2*7*12286 list_lru_one
>>>   lists for each NUMA node. It appears that no elements will get added
>>>   to other than 2*7=14 of them in the case of containers.
>>
>> Yeah, at first glance this doesn't strike me as a problem with the
>> list_lru structure, it smells more like a problem resulting from a
>> huge number of superblock instantiations on the machine. Which,
>> probably, mostly have no significant need for anything other than a
>> single memcg awareness?
>>
>> Can you post a typical /proc/self/mounts output from one of these
>> idle/empty containers so we can see exactly how many mounts and
>> their type are being instantiated in each container?
> 
> Tracing type->name in alloc_super() lists these 7 types for
> every container.
> 
> 3-2691    [041] ....   222.761041: alloc_super: fstype: mqueue
> 3-2692    [072] ....   222.812187: alloc_super: fstype: proc
> 3-2692    [072] ....   222.812261: alloc_super: fstype: tmpfs
> 3-2692    [072] ....   222.812329: alloc_super: fstype: devpts
> 3-2692    [072] ....   222.812392: alloc_super: fstype: tmpfs
> 3-2692    [072] ....   222.813102: alloc_super: fstype: tmpfs
> 3-2692    [072] ....   222.813159: alloc_super: fstype: tmpfs
> 
>>
>>> One straight forward way to prevent this excessive list_lru_one
>>> allocations is to limit the list_lru_one creation only to the
>>> relevant memcg. However I don't see an easy way to figure out
>>> that relevant memcg from FS mount path (alloc_super())
>>
>> Superblocks have to support an unknown number of memcgs after they
>> have been mounted. bind mounts, child memcgs, etc, all mean that we
>> can't just have a static, single mount time memcg instantiation.
>>
>>> As an alternative approach, I have this below hack that does lazy
>>> list_lru creation. The memcg-specific list is created and initialized
>>> only when there is a request to add an element to that particular
>>> list. Though I am not sure about the full impact of this change
>>> on the owners of the lists and also the performance impact of this,
>>> the overall savings look good.
>>
>> Avoiding memory allocation in list_lru_add() was one of the main
>> reasons for up-front static allocation of memcg lists. We cannot do
>> memory allocation while callers are holding multiple spinlocks in
>> core system algorithms (e.g. dentry_kill -> retain_dentry ->
>> d_lru_add -> list_lru_add), let alone while holding an internal
>> spinlock.
>>
>> Putting a GFP_ATOMIC allocation inside 3-4 nested spinlocks in a
>> path we know might have memory demand in the *hundreds of GB* range
>> gets an NACK from me. It's a great idea, but it's just not a
>> feasible, robust solution as proposed. Work out how to put the
>> memory allocation outside all the locks (including caller locks) and
>> it might be ok, but that's messy.
> 
> Ok, I see the problem and it looks like hard to get allocations
> outside of those locks.
> 
>>
>> Another approach may be to identify filesystem types that do not
>> need memcg awareness and feed that into alloc_super() to set/clear
>> the SHRINKER_MEMCG_AWARE flag. This could be based on fstype - most
>> virtual filesystems that expose system information do not really
>> need full memcg awareness because they are generally only visible to
>> a single memcg instance...
> 
> This however seems like a feasible approach, let me check on this.
> 
> Regards,
> Bharata.
> 

