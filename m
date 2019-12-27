Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC5812B07F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 03:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfL0CQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 21:16:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbfL0CQC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 21:16:02 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4BF3FDAAD5393AE5A973;
        Fri, 27 Dec 2019 10:16:00 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Dec 2019
 10:15:57 +0800
Subject: Re: [PATCH] fs: inode: Recycle inodenum from volatile inode slabs
To:     Amir Goldstein <amir73il@gmail.com>,
        Chris Down <chris@chrisdown.name>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
References: <20191226154808.GA418948@chrisdown.name>
 <CAOQ4uxj8NVwrCTswut+icF2t1-7gtW_cmyuGO7WUWdNZLHOBYA@mail.gmail.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <88698fed-528b-85b2-1d07-e00051d6db60@huawei.com>
Date:   Fri, 27 Dec 2019 10:15:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxj8NVwrCTswut+icF2t1-7gtW_cmyuGO7WUWdNZLHOBYA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2019/12/27 2:04, Amir Goldstein wrote:
> On Thu, Dec 26, 2019 at 5:48 PM Chris Down <chris@chrisdown.name> wrote:
>> In Facebook production we are seeing heavy i_ino wraparounds on tmpfs.
>> On affected tiers, in excess of 10% of hosts show multiple files with
>> different content and the same inode number, with some servers even
>> having as many as 150 duplicated inode numbers with differing file
>> content.
>>
>> This causes actual, tangible problems in production. For example, we
>> have complaints from those working on remote caches that their
>> application is reporting cache corruptions because it uses (device,
>> inodenum) to establish the identity of a particular cache object, but
>> because it's not unique any more, the application refuses to continue
>> and reports cache corruption. Even worse, sometimes applications may not
>> even detect the corruption but may continue anyway, causing phantom and
>> hard to debug behaviour.
>>
>> In general, userspace applications expect that (device, inodenum) should
>> be enough to be uniquely point to one inode, which seems fair enough.
>> One might also need to check the generation, but in this case:
>>
>> 1. That's not currently exposed to userspace
>>    (ioctl(...FS_IOC_GETVERSION...) returns ENOTTY);
>> 2. Even with generation, there shouldn't be two live inodes with the
>>    same inode number on one device.
>>
>> In order to fix this, we reuse inode numbers from recycled slabs where
>> possible, allowing us to significantly reduce the risk of 32 bit
>> wraparound.
>>
>> There are probably some other potential users of this, like some FUSE
>> internals, and {proc,sys,kern}fs style APIs, but doing a general opt-out
>> codemod requires some thinking depending on the particular callsites and
>> how far up the stack they are, we might end up recycling an i_ino value
>> that actually does have some semantic meaning. As such, to start with
>> this patch only opts in a few get_next_ino-heavy filesystems, and those
>> which looked straightforward and without likelihood for corner cases:
>>
>> - bpffs
>> - configfs
>> - debugfs
>> - efivarfs
>> - hugetlbfs
>> - ramfs
>> - tmpfs
>>
> I'm confused about this list.
> I suggested to convert tmpfs and hugetlbfs because they use a private
> inode cache pool, therefore, you can know for sure that a recycled i_ino
> was allocated by get_next_ino().

How about tmpfs and hugetlbfs use their own get_next_ino? like

static DEFINE_PER_CPU(unsigned int, tmpfs_last_ino),

which can reduce the risk of 32 bit wraparound further.

>
> If I am not mistaken, other fs above are using the common inode_cache
> pool, so when you recycle i_ino from that pool you don't know where it
> came from and cannot trust its uniqueness in the get_next_ino() domain.
> Even if *all* filesystems that currently use common inode_cache use
> get_next_ino() exclusively to allocate ino numbers, that could change
> in the future.
>
> I'd go even further to say that introducing a generic helper for this sort
> of thing is asking for trouble. It is best to keep the recycle logic well within
> the bounds of the specific filesystem driver, which is the owner of the
> private inode cache and the responsible for allocating ino numbers in
> this pool.
>
> Thanks and happy holidays,
> Amir.
>
> .
>

