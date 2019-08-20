Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD7D95532
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 05:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfHTDeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 23:34:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfHTDeL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:34:11 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DBDB2710DAB2CA212462;
        Tue, 20 Aug 2019 11:34:02 +0800 (CST)
Received: from [10.177.249.225] (10.177.249.225) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 20 Aug
 2019 11:33:53 +0800
Reply-To: <miaoxie@huawei.com>
Subject: Re: [PATCH] erofs: move erofs out of staging
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Gao Xiang <hsiangkao@aol.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Li Guifu" <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, "Pavel Machek" <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
References: <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu> <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
From:   Miao Xie <miaoxie@huawei.com>
Organization: Huawei Technologies Co., LTD.
Message-ID: <698e2fa6-956b-b367-6f6a-3e6b09bfef5f@huawei.com>
Date:   Tue, 20 Aug 2019 11:33:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.249.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



on 2019/8/20 at 8:55, Qu Wenruo wrote:
> [...]
>>>> I have made a simple fuzzer to inject messy in inode metadata,
>>>> dir data, compressed indexes and super block,
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental-fuzzer
>>>>
>>>> I am testing with some given dirs and the following script.
>>>> Does it look reasonable?
>>>>
>>>> # !/bin/bash
>>>>
>>>> mkdir -p mntdir
>>>>
>>>> for ((i=0; i<1000; ++i)); do
>>>> 	mkfs/mkfs.erofs -F$i testdir_fsl.fuzz.img testdir_fsl > /dev/null 2>&1
>>>
>>> mkfs fuzzes the image? Er....
>>
>> Thanks for your reply.
>>
>> First, This is just the first step of erofs fuzzer I wrote yesterday night...
>>
>>>
>>> Over in XFS land we have an xfs debugging tool (xfs_db) that knows how
>>> to dump (and write!) most every field of every metadata type.  This
>>> makes it fairly easy to write systematic level 0 fuzzing tests that
>>> check how well the filesystem reacts to garbage data (zeroing,
>>> randomizing, oneing, adding and subtracting small integers) in a field.
>>> (It also knows how to trash entire blocks.)
> 
> The same tool exists for btrfs, although lacks the write ability, but
> that dump is more comprehensive and a great tool to learn the on-disk
> format.
> 
> 
> And for the fuzzing defending part, just a few kernel releases ago,
> there is none for btrfs, and now we have a full static verification
> layer to cover (almost) all on-disk data at read and write time.
> (Along with enhanced runtime check)
> 
> We have covered from vague values inside tree blocks and invalid/missing
> cross-ref find at runtime.
> 
> Currently the two layered check works pretty fine (well, sometimes too
> good to detect older, improper behaved kernel).
> - Tree blocks with vague data just get rejected by verification layer
>   So that all members should fit on-disk format, from alignment to
>   generation to inode mode.
> 
>   The error will trigger a good enough (TM) error message for developer
>   to read, and if we have other copies, we retry other copies just as
>   we hit a bad copy.
> 
> - At runtime, we have much less to check
>   Only cross-ref related things can be wrong now. since everything
>   inside a single tree block has already be checked.
> 
> In fact, from my respect of view, such read time check should be there
> from the very beginning.
> It acts kinda of a on-disk format spec. (In fact, by implementing the
> verification layer itself, it already exposes a lot of btrfs design
> trade-offs)
> 
> Even for a fs as complex (buggy) as btrfs, we only take 1K lines to
> implement the verification layer.
> So I'd like to see every new mainlined fs to have such ability.

It is a good idea. In fact, we already have a verification layer which was implemented
as a device mapper sub-module. I think it is enough for a read-only filesystem because
it is simple, flexible and independent(we can modify the filesystem layout without
verification module modification).

 
>>
>> Actually, compared with XFS, EROFS has rather simple on-disk format.
>> What we inject one time is quite deterministic.
>>
>> The first step just purposely writes some random fuzzed data to
>> the base inode metadata, compressed indexes, or dir data field
>> (one round one field) to make it validity and coverability.
>>
>>>
>>> You might want to write such a debugging tool for erofs so that you can
>>> take apart crashed images to get a better idea of what went wrong, and
>>> to write easy fuzzing tests.
>>
>> Yes, we will do such a debugging tool of course. Actually Li Guifu is now
>> developping a erofs-fuse to support old linux versions or other OSes for
>> archiveing only use, we will base on that code to develop a better fuzzer
>> tool as well.
> 
> Personally speaking, debugging tool is way more important than a running
> kernel module/fuse.
> It's human trying to write the code, most of time is spent educating
> code readers, thus debugging tool is way more important than dead cold code.

Agree, Xiang and I have no time to developing this feature now, we are glad very much if you could help
us to do it ;)

Thanks
Miao

> 
> Thanks,
> Qu
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> --D
>>>
>>>> 	umount mntdir
>>>> 	mount -t erofs -o loop testdir_fsl.fuzz.img mntdir
>>>> 	for j in `find mntdir -type f`; do
>>>> 		md5sum $j > /dev/null
>>>> 	done
>>>> done
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>>
>>>>> Thanks,
>>>>> Gao Xiang
>>>>>
> 
