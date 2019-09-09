Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC6ADAC4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 16:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405166AbfIIOKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 10:10:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405006AbfIIOKM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:10:12 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B5EBE1E1A20DC75C29F6;
        Mon,  9 Sep 2019 22:10:07 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 9 Sep 2019
 22:10:01 +0800
Subject: Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
From:   "zhengbin (A)" <zhengbin13@huawei.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <jack@suse.cz>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, <renxudong1@huawei.com>,
        Hou Tao <houtao1@huawei.com>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
Message-ID: <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
Date:   Mon, 9 Sep 2019 22:10:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2019/9/4 14:15, zhengbin (A) wrote:
> On 2019/9/3 23:41, Al Viro wrote:
>
>> On Tue, Sep 03, 2019 at 04:40:07PM +0100, Al Viro wrote:
>>> On Tue, Sep 03, 2019 at 10:44:32PM +0800, zhengbin (A) wrote:
>>>> We recently encountered an oops(the filesystem is tmpfs)
>>>> crash> bt
>>>>  #9 [ffff0000ae77bd60] dcache_readdir at ffff0000672954bc
>>>>
>>>> The reason is as follows:
>>>> Process 1 cat test which is not exist in directory A, process 2 cat test in directory A too.
>>>> process 3 create new file in directory B, process 4 ls directory A.
>>> good grief, what screen width do you have to make the table below readable?
>>>
>>> What I do not understand is how the hell does your dtry2 manage to get actually
>>> freed and reused without an RCU delay between its removal from parent's
>>> ->d_subdirs and freeing its memory.  What should've happened in that
>>> scenario is
>>> 	* process 4, in next_positive() grabs rcu_read_lock().
>>> 	* it walks into your dtry2, which might very well be
>>> just a chunk of memory waiting to be freed; it sure as hell is
>>> not positive.  skipped is set to true, 'i' is not decremented.
>>> Note that ->d_child.next points to the next non-cursor sibling
>>> (if any) or to the ->d_subdir of parent, so we can keep walking.
>>> 	* we keep walking for a while; eventually we run out of
>>> counter and leave the loop.
>>>
>>> Only after that we do rcu_read_unlock() and only then anything
>>> observed in that loop might be freed and reused.
> You are right, I miss this.
>>> Confused...  OTOH, I might be misreading that table of yours -
>>> it's about 30% wider than the widest xterm I can get while still
>>> being able to read the font...
> The table is my guess. This oops happens sometimes
>
> (We have one vmcore, others just have log, and the backtrace is same with vmcore, so the reason should be same).
>
> Unfortunately, we do not know how to reproduce it. The vmcore has such a law:
>
> 1、dirA has 177 files, and it is OK
>
> 2、dirB has 25 files, and it is OK
>
> 3、When we ls dirA, it begins with ".", "..", dirB's first file, second file... last file,  last file->next = &(dirB->d_subdirs)
>
> -------->
>
> crash> struct dir_context ffff0000ae77be30  --->dcache_readdir ctx
>
> struct dir_context {
>
> actor = 0xffff00006727d760 <filldir64>,
>
> pos = 27   --->27 = . + .. + 25 files
>
> }
>
>
> next_positive
>
>   for (p = from->next; p != &parent->d_subdirs; p = p->next)  --->parent is dirA, so will continue
>
>
> This should be a bug, I think it is related with locks,  especially with commit ebaaa80e8f20 ("lockless next_positive()").
>
> Howerver, until now, I do not find the reason, Any suggestions?

They will be a such timing as follows:

1. insert a negative dentryB1 to dirB,  dentryB1->next = dirB's first positive dentry(such as fileB)      d_alloc_parallel-->d_alloc

2.insert a negative dentryB2 to dirB, dentryB2->next = dentryB1                                                        d_alloc_parallel-->d_alloc

3. remove dentryB1 from dirB,  dentryB1->next will be fileB too                                                         d_alloc_parallel->dput(new)

4. alloc dentryB1 to dirA,  dirA's d_subdirs->next will be dentryB1


process 1(ls dirA)                       |  process 2(alloc dentryB1 to dirA: d_alloc_parallel-->d_alloc)

dcache_readdir                          |  d_alloc                             

    p = &dentry->d_subdirs;      |      

    next_positive                         |      

                                                  |       __d_alloc-->INIT_LIST_HEAD(&dentry->d_child)

                                                  |       list_add(&dentry->d_child, &parent->d_subdirs)  --->cpu may be executed out of order, first set parent->d_subdirs->next = dentryB1

        p = from->next                 |

        ---> p will be dentryB1, and dentryB1->next will be fileB


We can solute it in 2 ways:

1. add a smp_wmb between __d_alloc and list_add(&dentry->d_child, &parent->d_subdirs)

2. revert commit ebaaa80e8f20 ("lockless next_positive()")

>> Incidentally, which kernel was that on?
> 4.19-stable,  the code of iterate_dir and d_alloc_parallel is same with master
>> .
>>

