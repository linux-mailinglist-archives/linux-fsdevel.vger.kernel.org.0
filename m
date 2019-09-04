Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9EDA7B69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 08:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfIDGQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 02:16:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728756AbfIDGQO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:16:14 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4E91F158A750B92E3B7A;
        Wed,  4 Sep 2019 14:16:12 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 14:16:04 +0800
Subject: Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <jack@suse.cz>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, <renxudong1@huawei.com>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
Date:   Wed, 4 Sep 2019 14:15:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190903154114.GK1131@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/9/3 23:41, Al Viro wrote:

> On Tue, Sep 03, 2019 at 04:40:07PM +0100, Al Viro wrote:
>> On Tue, Sep 03, 2019 at 10:44:32PM +0800, zhengbin (A) wrote:
>>> We recently encountered an oops(the filesystem is tmpfs)
>>> crash> bt
>>>  #9 [ffff0000ae77bd60] dcache_readdir at ffff0000672954bc
>>>
>>> The reason is as follows:
>>> Process 1 cat test which is not exist in directory A, process 2 cat test in directory A too.
>>> process 3 create new file in directory B, process 4 ls directory A.
>>
>> good grief, what screen width do you have to make the table below readable?
>>
>> What I do not understand is how the hell does your dtry2 manage to get actually
>> freed and reused without an RCU delay between its removal from parent's
>> ->d_subdirs and freeing its memory.  What should've happened in that
>> scenario is
>> 	* process 4, in next_positive() grabs rcu_read_lock().
>> 	* it walks into your dtry2, which might very well be
>> just a chunk of memory waiting to be freed; it sure as hell is
>> not positive.  skipped is set to true, 'i' is not decremented.
>> Note that ->d_child.next points to the next non-cursor sibling
>> (if any) or to the ->d_subdir of parent, so we can keep walking.
>> 	* we keep walking for a while; eventually we run out of
>> counter and leave the loop.
>>
>> Only after that we do rcu_read_unlock() and only then anything
>> observed in that loop might be freed and reused.
You are right, I miss this.
>>
>> Confused...  OTOH, I might be misreading that table of yours -
>> it's about 30% wider than the widest xterm I can get while still
>> being able to read the font...

The table is my guess. This oops happens sometimes

(We have one vmcore, others just have log, and the backtrace is same with vmcore, so the reason should be same).

Unfortunately, we do not know how to reproduce it. The vmcore has such a law:

1、dirA has 177 files, and it is OK

2、dirB has 25 files, and it is OK

3、When we ls dirA, it begins with ".", "..", dirB's first file, second file... last file,  last file->next = &(dirB->d_subdirs)

-------->

crash> struct dir_context ffff0000ae77be30  --->dcache_readdir ctx

struct dir_context {

actor = 0xffff00006727d760 <filldir64>,

pos = 27   --->27 = . + .. + 25 files

}


next_positive

  for (p = from->next; p != &parent->d_subdirs; p = p->next)  --->parent is dirA, so will continue


This should be a bug, I think it is related with locks,  especially with commit ebaaa80e8f20 ("lockless next_positive()").

Howerver, until now, I do not find the reason, Any suggestions?
> Incidentally, which kernel was that on?
4.19-stable,  the code of iterate_dir and d_alloc_parallel is same with master
>
> .
>

