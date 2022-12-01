Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADEE63E75A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 02:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiLAByS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 20:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiLAByH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:54:07 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F91E9AE23;
        Wed, 30 Nov 2022 17:54:06 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NMzcW6qsYzHwJB;
        Thu,  1 Dec 2022 09:53:15 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 09:53:49 +0800
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 09:53:48 +0800
Message-ID: <2ca8a20b-047d-bae1-5a01-0892be4d7e7d@huawei.com>
Date:   Thu, 1 Dec 2022 09:53:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] hfs: Fix OOB Write in hfs_asc2mac
Content-Language: en-US
To:     Viacheslav Dubeyko <slava@dubeyko.com>
CC:     <zippel@linux-m68k.org>, <akpm@osdl.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>,
        <syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com>
References: <20221126043612.853428-1-zhangpeng362@huawei.com>
 <9F97B7A6-9E20-4D70-BA79-8301D80DF9DB@dubeyko.com>
 <8e298cc0-27b9-a61a-48cc-64a9186048c8@huawei.com>
 <481BF13E-8CEA-48B4-A29B-0BDE4CAABAF9@dubeyko.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <481BF13E-8CEA-48B4-A29B-0BDE4CAABAF9@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2022/11/30 3:08, Viacheslav Dubeyko wrote:
>> On Nov 28, 2022, at 6:23 PM, zhangpeng (AS) <zhangpeng362@huawei.com> wrote:
>>
>> On 2022/11/29 3:29, Viacheslav Dubeyko wrote:
>>>> On Nov 25, 2022, at 8:36 PM, Peng Zhang <zhangpeng362@huawei.com> wrote:
>>>>
>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>
>>>> Syzbot reported a OOB Write bug:
>>>>
>>>> loop0: detected capacity change from 0 to 64
>>>> ==================================================================
>>>> BUG: KASAN: slab-out-of-bounds in hfs_asc2mac+0x467/0x9a0
>>>> fs/hfs/trans.c:133
>>>> Write of size 1 at addr ffff88801848314e by task syz-executor391/3632
>>>>
>>>> Call Trace:
>>>> <TASK>
>>>> __dump_stack lib/dump_stack.c:88 [inline]
>>>> dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>>>> print_address_description+0x74/0x340 mm/kasan/report.c:284
>>>> print_report+0x107/0x1f0 mm/kasan/report.c:395
>>>> kasan_report+0xcd/0x100 mm/kasan/report.c:495
>>>> hfs_asc2mac+0x467/0x9a0 fs/hfs/trans.c:133
>>>> hfs_cat_build_key+0x92/0x170 fs/hfs/catalog.c:28
>>>> hfs_lookup+0x1ab/0x2c0 fs/hfs/dir.c:31
>>>> lookup_open fs/namei.c:3391 [inline]
>>>> open_last_lookups fs/namei.c:3481 [inline]
>>>> path_openat+0x10e6/0x2df0 fs/namei.c:3710
>>>> do_filp_open+0x264/0x4f0 fs/namei.c:3740
>>>>
>>>> If in->len is much larger than HFS_NAMELEN(31) which is the maximum
>>>> length of an HFS filename, a OOB Write could occur in hfs_asc2mac(). In
>>>> that case, when the dst reaches the boundary, the srclen is still
>>>> greater than 0, which causes a OOB Write.
>>>> Fix this by adding a Check on dstlen before Writing to dst address.
>>>>
>>>> Fixes: 328b92278650 ("[PATCH] hfs: NLS support")
>>>> Reported-by: syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com
>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>> ---
>>>> fs/hfs/trans.c | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/fs/hfs/trans.c b/fs/hfs/trans.c
>>>> index 39f5e343bf4d..886158db07b3 100644
>>>> --- a/fs/hfs/trans.c
>>>> +++ b/fs/hfs/trans.c
>>>> @@ -130,6 +130,8 @@ void hfs_asc2mac(struct super_block *sb, struct hfs_name *out, const struct qstr
>>>> 				dst += size;
>>>> 				dstlen -= size;
>>>> 			} else {
>>>> +				if (dstlen == 0)
>>>> +					goto out;
>>> Maybe, it makes sense to use dstlen instead of srclen in while()?
>>>
>>> We have now:
>>>
>>> while (srclen > 0) {
>>>     <skipped>
>>> } else {
>>>     <skipped>
>>> }
>>>
>>> We can use instead:
>>>
>>> while (dstlen > 0) {
>>>     <skipped>
>>> } else {
>>>     <skipped>
>>> }
>>>
>>> Will it fix the issue?
>>>
>>> Thanks,
>>> Slava.
>> Thank you for your help.
>>
>> After testing, it fix the issue.
>> Would it be better to add dstlen > 0 instead of replacing srclen > 0 with dstlen > 0?
>> Because there may be dstlen > 0 and srclen <= 0.
>>
>> we can use:
>>
>> while (srclen > 0 && dstlen > 0) {
>>    <skipped>
>> } else {
>>    <skipped>
>> }
>>
> Looks good to me.

Can I put you down as a Reviewed-by or Suggested-by?

Thanks,
Zhang Peng

> Thanks,
> Slava.
>
>> Thanks,
>> Zhang Peng
>>
>>>> 				*dst++ = ch > 0xff ? '?' : ch;
>>>> 				dstlen--;
>>>> 			}
>>>> -- 
>>>> 2.25.1
