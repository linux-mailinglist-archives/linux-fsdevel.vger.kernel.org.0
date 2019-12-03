Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E188110FC28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 12:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCLEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 06:04:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:53806 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfLCLEV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:04:21 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ic5y8-0005ik-KU; Tue, 03 Dec 2019 14:03:48 +0300
Subject: Re: [PATCH] mm: fix hanging shrinker management on long
 do_shrink_slab
To:     Shakeel Butt <shakeelb@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
 <4e2d959a-0b0e-30aa-59b4-8e37728e9793@virtuozzo.com>
 <CALvZod7rhaOBUNR=Pt5a1vAEPimrwN=41dmDD9dekCGztAe=NQ@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <01bdd7bd-3730-71f7-725c-42779ead9a12@virtuozzo.com>
Date:   Tue, 3 Dec 2019 14:03:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALvZod7rhaOBUNR=Pt5a1vAEPimrwN=41dmDD9dekCGztAe=NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.12.2019 03:13, Shakeel Butt wrote:
> On Mon, Dec 2, 2019 at 8:37 AM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>
>>
>> On 11/30/19 12:45 AM, Pavel Tikhomirov wrote:
>>> We have a problem that shrinker_rwsem can be held for a long time for
>>> read in shrink_slab, at the same time any process which is trying to
>>> manage shrinkers hangs.
>>>
>>> The shrinker_rwsem is taken in shrink_slab while traversing shrinker_list.
>>> It tries to shrink something on nfs (hard) but nfs server is dead at
>>> these moment already and rpc will never succeed. Generally any shrinker
>>> can take significant time to do_shrink_slab, so it's a bad idea to hold
>>> the list lock here.
>>>
>>> We have a similar problem in shrink_slab_memcg, except that we are
>>> traversing shrinker_map+shrinker_idr there.
>>>
>>> The idea of the patch is to inc a refcount to the chosen shrinker so it
>>> won't disappear and release shrinker_rwsem while we are in
>>> do_shrink_slab, after that we will reacquire shrinker_rwsem, dec
>>> the refcount and continue the traversal.
>>>
>>> We also need a wait_queue so that unregister_shrinker can wait for the
>>> refcnt to become zero. Only after these we can safely remove the
>>> shrinker from list and idr, and free the shrinker.
>>>
>>> I've reproduced the nfs hang in do_shrink_slab with the patch applied on
>>> ms kernel, all other mount/unmount pass fine without any hang.
>>>
>>> Here is a reproduction on kernel without patch:
>>>
>>> 1) Setup nfs on server node with some files in it (e.g. 200)
>>>
>>> [server]# cat /etc/exports
>>> /vz/nfs2 *(ro,no_root_squash,no_subtree_check,async)
>>>
>>> 2) Hard mount it on client node
>>>
>>> [client]# mount -ohard 10.94.3.40:/vz/nfs2 /mnt
>>>
>>> 3) Open some (e.g. 200) files on the mount
>>>
>>> [client]# for i in $(find /mnt/ -type f | head -n 200); \
>>>   do setsid sleep 1000 &>/dev/null <$i & done
>>>
>>> 4) Kill all openers
>>>
>>> [client]# killall sleep -9
>>>
>>> 5) Put your network cable out on client node
>>>
>>> 6) Drop caches on the client, it will hang on nfs while holding
>>>   shrinker_rwsem lock for read
>>>
>>> [client]# echo 3 > /proc/sys/vm/drop_caches
>>>
>>>   crash> bt ...
>>>   PID: 18739  TASK: ...  CPU: 3   COMMAND: "bash"
>>>    #0 [...] __schedule at ...
>>>    #1 [...] schedule at ...
>>>    #2 [...] rpc_wait_bit_killable at ... [sunrpc]
>>>    #3 [...] __wait_on_bit at ...
>>>    #4 [...] out_of_line_wait_on_bit at ...
>>>    #5 [...] _nfs4_proc_delegreturn at ... [nfsv4]
>>>    #6 [...] nfs4_proc_delegreturn at ... [nfsv4]
>>>    #7 [...] nfs_do_return_delegation at ... [nfsv4]
>>>    #8 [...] nfs4_evict_inode at ... [nfsv4]
>>>    #9 [...] evict at ...
>>>   #10 [...] dispose_list at ...
>>>   #11 [...] prune_icache_sb at ...
>>>   #12 [...] super_cache_scan at ...
>>>   #13 [...] do_shrink_slab at ...
>>>   #14 [...] shrink_slab at ...
>>>   #15 [...] drop_slab_node at ...
>>>   #16 [...] drop_slab at ...
>>>   #17 [...] drop_caches_sysctl_handler at ...
>>>   #18 [...] proc_sys_call_handler at ...
>>>   #19 [...] vfs_write at ...
>>>   #20 [...] ksys_write at ...
>>>   #21 [...] do_syscall_64 at ...
>>>   #22 [...] entry_SYSCALL_64_after_hwframe at ...
>>>
>>> 7) All other mount/umount activity now hangs with no luck to take
>>>   shrinker_rwsem for write.
>>>
>>> [client]# mount -t tmpfs tmpfs /tmp
>>>
>>>   crash> bt ...
>>>   PID: 5464   TASK: ...  CPU: 3   COMMAND: "mount"
>>>    #0 [...] __schedule at ...
>>>    #1 [...] schedule at ...
>>>    #2 [...] rwsem_down_write_slowpath at ...
>>>    #3 [...] prealloc_shrinker at ...
>>>    #4 [...] alloc_super at ...
>>>    #5 [...] sget at ...
>>>    #6 [...] mount_nodev at ...
>>>    #7 [...] legacy_get_tree at ...
>>>    #8 [...] vfs_get_tree at ...
>>>    #9 [...] do_mount at ...
>>>   #10 [...] ksys_mount at ...
>>>   #11 [...] __x64_sys_mount at ...
>>>   #12 [...] do_syscall_64 at ...
>>>   #13 [...] entry_SYSCALL_64_after_hwframe at ...
>>>
>>
>>
>> I don't think this patch solves the problem, it only fixes one minor symptom of it.
>> The actual problem here the reclaim hang in the nfs.
>> It means that any process, including kswapd, may go into nfs inode reclaim and stuck there.
>>
>> Even mount() itself has GFP_KERNEL allocations in its path, so it still might stuck there even with your patch.
>>
>> I think this should be handled on nfs/vfs level by making  inode eviction during reclaim more asynchronous.
> 
> Though I agree that we should be fixing shrinkers to not get stuck
> (and be more async), I still think the problem this patch is solving
> is worth fixing. On machines running multiple workloads, one job stuck
> in slab shrinker and blocking all other unrelated jobs wanting
> shrinker_rwsem, breaks the isolation and causes DoS.

This makes jobs isolated till global reclaim occurs. In that case any process
(including kswapd) become stuck, and nothing will help. But (as it was spoken
in this list some time ago) many people configure their workload in the way
they don't have global reclaim, and they may get some profit from this.
