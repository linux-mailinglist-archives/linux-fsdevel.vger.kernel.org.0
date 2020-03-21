Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D9E18DF5F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Mar 2020 11:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgCUKSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Mar 2020 06:18:05 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:36876 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727052AbgCUKSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Mar 2020 06:18:05 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id A1CE02E1471;
        Sat, 21 Mar 2020 13:18:00 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id YtLecgDI86-HxAehnBO;
        Sat, 21 Mar 2020 13:18:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1584785880; bh=qBScgYCZjZTlIpm/AdZDrRFl7YnlFGv41LveLZYaOxs=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=Na2YlNyAY45EcKPYHXLhelGXdR0Fx1EPBQijjQr63f3fU7LBbX6C5VBbZyS7VLaU7
         xzomeNK71b4GO0HSSn8ADmiIhRSMWJEHrK1Nj2YhC08JSCEe1k0w4c/cAa9n8t2gt/
         sCkxKxbmtqIBQ2YKg4Xz6m2GGCw8HVaa5PKo5x68=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b081:918::1:1])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 8ruPl76BlO-HxceQfsw;
        Sat, 21 Mar 2020 13:17:59 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
To:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200315034640.GV22433@bombadil.infradead.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <6fcf86e9-8555-b86b-17f0-cc15217d834e@yandex-team.ru>
Date:   Sat, 21 Mar 2020 13:17:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315034640.GV22433@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/03/2020 06.46, Matthew Wilcox wrote:
> On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
>> As there is no limit for negative dentries, it is possible that a sizeable
>> portion of system memory can be tied up in dentry cache slabs. Dentry slabs
>> are generally recalimable if the dentries are in the LRUs. Still having
>> too much memory used up by dentries can be problematic:
>>
>>   1) When a filesystem with too many negative dentries is being unmounted,
>>      the process of draining the dentries associated with the filesystem
>>      can take some time. To users, the system may seem to hang for
>>      a while.  The long wait may also cause unexpected timeout error or
>>      other warnings.  This can happen when a long running container with
>>      many negative dentries is being destroyed, for instance.
>>
>>   2) Tying up too much memory in unused negative dentries means there
>>      are less memory available for other use. Even though the kernel is
>>      able to reclaim unused dentries when running out of free memory,
>>      it will still introduce additional latency to the application
>>      reducing its performance.
> 
> There's a third problem, which is that having a lot of negative dentries
> can clog the hash chains.  I tried to quantify this, and found a weird result:

Yep. I've seen this in the wild. Server hard too much unused memory.

https://lore.kernel.org/lkml/ff0993a2-9825-304c-6a5b-2e9d4b940032@yandex-team.ru/T/#u

---quote---

I've seen problem on large server where horde of negative dentries
slowed down all lookups significantly:

watchdog: BUG: soft lockup - CPU#25 stuck for 22s! [atop:968884] at __d_lookup_rcu+0x6f/0x190

slabtop:

    OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
85118166 85116916   0%    0.19K 2026623       42  16212984K dentry
16577106 16371723   0%    0.10K 425054       39   1700216K buffer_head
935850 934379   0%    1.05K  31195       30    998240K ext4_inode_cache
663740 654967   0%    0.57K  23705       28    379280K radix_tree_node
399987 380055   0%    0.65K   8163       49    261216K proc_inode_cache
226380 168813   0%    0.19K   5390       42     43120K cred_jar
   70345  65721   0%    0.58K   1279       55     40928K inode_cache
105927  43314   0%    0.31K   2077       51     33232K filp
630972 601503   0%    0.04K   6186      102     24744K ext4_extent_status
    5848   4269   0%    3.56K    731        8     23392K task_struct
   16224  11531   0%    1.00K    507       32     16224K kmalloc-1024
    6752   5833   0%    2.00K    422       16     13504K kmalloc-2048
199680 158086   0%    0.06K   3120       64     12480K anon_vma_chain
156128 154751   0%    0.07K   2788       56     11152K Acpi-Operand

Total RAM is 256 GB

These dentries came from temporary files created and deleted by postgres.
But this could be easily reproduced by lookup of non-existent files.

Of course, memory pressure easily washes them away.

Similar problem happened before around proc sysctl entries:
https://lkml.org/lkml/2017/2/10/47

This one does not concentrate in one bucket and needs much more memory.

Looks like dcache needs some kind of background shrinker started
when dcache size or fraction of negative dentries exceeds some threshold.

---end---

> > root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
> real	0m5.402s
> user	0m4.361s
> sys	0m1.230s
> root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
> real	0m5.572s
> user	0m4.337s
> sys	0m1.407s
> root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
> real	0m5.607s
> user	0m4.522s
> sys	0m1.342s
> root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
> real	0m5.599s
> user	0m4.472s
> sys	0m1.369s
> root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
> real	0m5.574s
> user	0m4.498s
> sys	0m1.300s
> 
> Pretty consistent system time, between about 1.3 and 1.4 seconds.
> 
> root@bobo-kvm:~# grep dentry /proc/slabinfo
> dentry             20394  21735    192   21    1 : tunables    0    0    0 : slabdata   1035   1035      0
> root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
> real	0m5.515s
> user	0m4.353s
> sys	0m1.359s
> 
> At this point, we have 20k dentries allocated.
> 
> Now, pollute the dcache with names that don't exist:
> 
> root@bobo-kvm:~# for i in `seq 1 100000`; do cat /dev/null$i >/dev/zero; done 2>/dev/null
> root@bobo-kvm:~# grep dentry /proc/slabinfo
> dentry             20605  21735    192   21    1 : tunables    0    0    0 : slabdata   1035   1035      0
> 
> Huh.  We've kept the number of dentries pretty constant.  Still, maybe the
> bad dentries have pushed out the good ones.
> 
> root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
> real	0m6.644s
> user	0m4.921s
> sys	0m1.946s
> root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
> real	0m6.676s
> user	0m5.004s
> sys	0m1.909s
> root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
> real	0m6.662s
> user	0m4.980s
> sys	0m1.916s
> root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
> real	0m6.714s
> user	0m4.973s
> sys	0m1.986s
> 
> Well, we certainly made it suck.  Up to a pretty consistent 1.9-2.0 seconds
> of kernel time, or 50% worse.  We've also made user time worse, somehow.
> 
> Anyhow, I should write a proper C program to measure this.  But I thought
> I'd share this raw data with you now to demonstrate that dcache pollution
> is a real problem today, even on a machine with 2GB.
> 

