Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B846F98A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 08:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfGVGbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 02:31:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbfGVGbY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:31:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AA586B09DC79AE9496BF;
        Mon, 22 Jul 2019 14:31:21 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 14:31:14 +0800
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-13-gaoxiang25@huawei.com>
 <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
 <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
 <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <a9d4920c-cfb0-50c7-a1f3-3e3c0e581bd7@huawei.com>
Date:   Mon, 22 Jul 2019 14:31:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/22 14:16, Amir Goldstein wrote:
> On Mon, Jul 22, 2019 at 8:02 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
>>
>> Hi Amir,
>>
>> On 2019/7/22 12:39, Amir Goldstein wrote:
>>> On Mon, Jul 22, 2019 at 5:54 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
>>>>
>>>> Currently kernel has scattered tagged pointer usages
>>>> hacked by hand in plain code, without a unique and
>>>> portable functionset to highlight the tagged pointer
>>>> itself and wrap these hacked code in order to clean up
>>>> all over meaningless magic masks.
>>>>
>>>> This patch introduces simple generic methods to fold
>>>> tags into a pointer integer. Currently it supports
>>>> the last n bits of the pointer for tags, which can be
>>>> selected by users.
>>>>
>>>> In addition, it will also be used for the upcoming EROFS
>>>> filesystem, which heavily uses tagged pointer pproach
>>>>  to reduce extra memory allocation.
>>>>
>>>> Link: https://en.wikipedia.org/wiki/Tagged_pointer
>>>
>>> Well, it won't do much good for other kernel users in fs/erofs/ ;-)
>>
>> Thanks for your reply and interest in this patch.... :)
>>
>> Sigh... since I'm not sure kernel folks could have some interests in that stuffs.
>>
>> Actually at the time once I coded EROFS I found tagged pointer had 2 main advantages:
>> 1) it saves an extra field;
>> 2) it can keep the whole stuff atomicly...
>> And I observed the current kernel uses tagged pointer all around but w/o a proper wrapper...
>> and EROFS heavily uses tagged pointer... So I made a simple tagged pointer wrapper
>> to avoid meaningless magic masks and type casts in the code...
>>
>>>
>>> I think now would be a right time to promote this facility to
>>> include/linux as you initially proposed.
>>> I don't recall you got any objections. No ACKs either, but I think
>>> that was the good kind of silence (?)
>>
>> Yes, no NAK no ACK...(it seems the ordinary state for all EROFS stuffs... :'( sigh...)
>> Therefore I decided to leave it in fs/erofs/ in this series...
>>
>>>
>>> You might want to post the __fdget conversion patch [1] as a
>>> bonus patch on top of your series.
>>
>> I am not sure if another potential users could be quite happy with my ("sane?" or not)
>> implementation...
> 
> Well, let's ask potential users then.
> 
> CC kernel/trace maintainers for RB_PAGE_HEAD/RB_PAGE_UPDATE
> and kernel/locking maintainers for RT_MUTEX_HAS_WAITERS
> 
>> (Is there some use scenerios in overlayfs and fanotify?...)
> 
> We had one in overlayfs once. It is gone now.
> 
>>
>> and I'm not sure Al could accept __fdget conversion (I just wanted to give a example then...)
>>
>> Therefore, I tend to keep silence and just promote EROFS... some better ideas?...
>>
> 
> Writing example conversion patches to demonstrate cleaner code
> and perhaps reduce LOC seems the best way.
> 
> Also pointing out that fixing potential bugs in one implementation is preferred
> to having to patch all copied implementations.
> 
> I wonder if tagptr_unfold_tags() doesn't need READ_ONCE() as per:
> 1be5d4fa0af3 locking/rtmutex: Use READ_ONCE() in rt_mutex_owner()
> 
> rb_list_head() doesn't have READ_ONCE()
> Nor does hlist_bl_first() and BPF_MAP_PTR().
> 
> Are those all safe due to safe call sites? or potentially broken?

...Add a word (maybe not too ralated with this topic), I heard something
before from compiler guys like that the pointer type will be kept in atomic
by compilers during accessing, I personally think that makes sense
for pointer type.

However, in EROFS implementation (not in this patch) I tend to use
WRITE_ONCE / READ_ONCE in order to access once and as a hint to tell
compiler it should be access once in case of getting rare broken
generated code...

I cannot trust compiler all the time due to code optimization since
1) I have no idea it will generate in atomic for all cases...
2) I have no idea it will be accessed more than one time somewhere...

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.
> 
