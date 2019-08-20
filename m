Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2AD69580D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 09:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfHTHPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 03:15:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfHTHPd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:15:33 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1012B334FDD0942BBE70;
        Tue, 20 Aug 2019 15:15:28 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 20 Aug
 2019 15:15:18 +0800
Subject: Re: [PATCH] erofs: move erofs out of staging
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Gao Xiang <hsiangkao@aol.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, "Dave Chinner" <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
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
 <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
 <c6f6de48-2594-05e4-2048-9a9c59c018d7@gmx.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c9a27e20-33fa-2cad-79f2-ecc26f6f3490@huawei.com>
Date:   Tue, 20 Aug 2019 15:15:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c6f6de48-2594-05e4-2048-9a9c59c018d7@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/8/20 10:38, Qu Wenruo wrote:
> 
> 
> On 2019/8/20 上午10:24, Chao Yu wrote:
>> On 2019/8/20 8:55, Qu Wenruo wrote:
>>> [...]
>>>>>> I have made a simple fuzzer to inject messy in inode metadata,
>>>>>> dir data, compressed indexes and super block,
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental-fuzzer
>>>>>>
>>>>>> I am testing with some given dirs and the following script.
>>>>>> Does it look reasonable?
>>>>>>
>>>>>> # !/bin/bash
>>>>>>
>>>>>> mkdir -p mntdir
>>>>>>
>>>>>> for ((i=0; i<1000; ++i)); do
>>>>>> 	mkfs/mkfs.erofs -F$i testdir_fsl.fuzz.img testdir_fsl > /dev/null 2>&1
>>>>>
>>>>> mkfs fuzzes the image? Er....
>>>>
>>>> Thanks for your reply.
>>>>
>>>> First, This is just the first step of erofs fuzzer I wrote yesterday night...
>>>>
>>>>>
>>>>> Over in XFS land we have an xfs debugging tool (xfs_db) that knows how
>>>>> to dump (and write!) most every field of every metadata type.  This
>>>>> makes it fairly easy to write systematic level 0 fuzzing tests that
>>>>> check how well the filesystem reacts to garbage data (zeroing,
>>>>> randomizing, oneing, adding and subtracting small integers) in a field.
>>>>> (It also knows how to trash entire blocks.)
>>>
>>> The same tool exists for btrfs, although lacks the write ability, but
>>> that dump is more comprehensive and a great tool to learn the on-disk
>>> format.
>>>
>>>
>>> And for the fuzzing defending part, just a few kernel releases ago,
>>> there is none for btrfs, and now we have a full static verification
>>> layer to cover (almost) all on-disk data at read and write time.
>>> (Along with enhanced runtime check)
>>>
>>> We have covered from vague values inside tree blocks and invalid/missing
>>> cross-ref find at runtime.
>>>
>>> Currently the two layered check works pretty fine (well, sometimes too
>>> good to detect older, improper behaved kernel).
>>> - Tree blocks with vague data just get rejected by verification layer
>>>   So that all members should fit on-disk format, from alignment to
>>>   generation to inode mode.
>>>
>>>   The error will trigger a good enough (TM) error message for developer
>>>   to read, and if we have other copies, we retry other copies just as
>>>   we hit a bad copy.
>>>
>>> - At runtime, we have much less to check
>>>   Only cross-ref related things can be wrong now. since everything
>>>   inside a single tree block has already be checked.
>>>
>>> In fact, from my respect of view, such read time check should be there
>>> from the very beginning.
>>> It acts kinda of a on-disk format spec. (In fact, by implementing the
>>> verification layer itself, it already exposes a lot of btrfs design
>>> trade-offs)
>>>
>>> Even for a fs as complex (buggy) as btrfs, we only take 1K lines to
>>> implement the verification layer.
>>> So I'd like to see every new mainlined fs to have such ability.
>>
>> Out of curiosity, it looks like every mainstream filesystem has its own
>> fuzz/injection tool in their tool-set, if it's really such a generic
>> requirement, why shouldn't there be a common tool to handle that, let specified
>> filesystem fill the tool's callback to seek a node/block and supported fields
>> can be fuzzed in inode.
> 
> It could be possible for XFS/EXT* to share the same infrastructure
> without much hassle.
> (If not considering external journal)
> 
> But for btrfs, it's like a regular fs on a super large dm-linear, which
> further builds its chunks on different dm-raid1/dm-linear/dm-raid56.
> 
> So not sure if it's possible for btrfs, as it contains its logical
> address layer bytenr (the most common one) along with per-chunk physical
> mapping bytenr (in another tree).

Yeah, it looks like we need searching more levels mapping to find the final
physical block address of inode/node/data in btrfs.

IMO, in a little lazy way, we can reform and reuse existed function in
btrfs-progs which can find the mapping info of inode/node/data according to
specified ino or ino+pg_no.

> 
> It may depends on the granularity. But definitely a good idea to do so
> in a generic way.
> Currently we depend on super kind student developers/reporters on such

Yup, I just guess Wen Xu may be interested in working on a generic way to fuzz
filesystem, as I know they dig deep in filesystem code when doing fuzz. BTW,
which impresses me is, constructing checkpoint by injecting one byte, and then
write a correct recalculated checksum value on that checkpoint, making that
checkpoint looks valid...

Thanks,

> fuzzed images, and developers sometimes get inspired by real world
> corruption (or his/her mood) to add some valid but hard-to-hit corner
> case check.
> 
> Thanks,
> Qu
> 
>> It can help to avoid redundant work whenever Linux
>> welcomes a new filesystem....
>>
>> Thanks,
>>
>>>
>>>>
>>>> Actually, compared with XFS, EROFS has rather simple on-disk format.
>>>> What we inject one time is quite deterministic.
>>>>
>>>> The first step just purposely writes some random fuzzed data to
>>>> the base inode metadata, compressed indexes, or dir data field
>>>> (one round one field) to make it validity and coverability.
>>>>
>>>>>
>>>>> You might want to write such a debugging tool for erofs so that you can
>>>>> take apart crashed images to get a better idea of what went wrong, and
>>>>> to write easy fuzzing tests.
>>>>
>>>> Yes, we will do such a debugging tool of course. Actually Li Guifu is now
>>>> developping a erofs-fuse to support old linux versions or other OSes for
>>>> archiveing only use, we will base on that code to develop a better fuzzer
>>>> tool as well.
>>>
>>> Personally speaking, debugging tool is way more important than a running
>>> kernel module/fuse.
>>> It's human trying to write the code, most of time is spent educating
>>> code readers, thus debugging tool is way more important than dead cold code.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>>
>>>>> --D
>>>>>
>>>>>> 	umount mntdir
>>>>>> 	mount -t erofs -o loop testdir_fsl.fuzz.img mntdir
>>>>>> 	for j in `find mntdir -type f`; do
>>>>>> 		md5sum $j > /dev/null
>>>>>> 	done
>>>>>> done
>>>>>>
>>>>>> Thanks,
>>>>>> Gao Xiang
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Gao Xiang
>>>>>>>
>>>
> 
