Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575D763F039
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 13:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLAMOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 07:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLAMOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:14:46 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5916A8933B
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 04:14:44 -0800 (PST)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NNFNk4mtJzHwLD;
        Thu,  1 Dec 2022 20:13:58 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 20:14:41 +0800
Subject: Re: [PATCH] hfsplus: fix OOB of hfsplus_unistr in hfsplus_uni2asc()
To:     Viacheslav Dubeyko <slava@dubeyko.com>
References: <20221129023949.4186612-1-liushixin2@huawei.com>
 <E5B1AB48-05CB-4A1A-8EA2-373BA1C119EB@dubeyko.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Ting-Chang Hou <tchou@synology.com>,
        <linux-fsdevel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <0f5675f9-6501-967b-250e-46e305955f04@huawei.com>
Date:   Thu, 1 Dec 2022 20:14:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <E5B1AB48-05CB-4A1A-8EA2-373BA1C119EB@dubeyko.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/11/30 3:15, Viacheslav Dubeyko wrote:
>
>> On Nov 28, 2022, at 6:39 PM, Liu Shixin <liushixin2@huawei.com> wrote:
>>
>> syzbot found a slab-out-of-bounds Read in hfsplus_uni2asc:
>>
>> BUG: KASAN: slab-out-of-bounds in hfsplus_uni2asc+0x683/0x1290 fs/hfsplus/unicode.c:179
>> Read of size 2 at addr ffff88801887a40c by task syz-executor412/3632
>>
>> CPU: 1 PID: 3632 Comm: syz-executor412 Not tainted 6.1.0-rc6-syzkaller-00315-gfaf68e3523c2 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:88 [inline]
>>  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>>  print_address_description+0x74/0x340 mm/kasan/report.c:284
>>  print_report+0x107/0x1f0 mm/kasan/report.c:395
>>  kasan_report+0xcd/0x100 mm/kasan/report.c:495
>>  hfsplus_uni2asc+0x683/0x1290 fs/hfsplus/unicode.c:179
>>  hfsplus_readdir+0x8be/0x1230 fs/hfsplus/dir.c:207
>>  iterate_dir+0x257/0x5f0
>>  __do_sys_getdents64 fs/readdir.c:369 [inline]
>>  __se_sys_getdents64+0x1db/0x4c0 fs/readdir.c:354
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> The length of arrags ustr->unicode is HFSPLUS_MAX_STRLEN. Limit the value
>> of ustr->length to no more than HFSPLUS_MAX_STRLEN.
>>
>> Reported-by: syzbot+076d963e115823c4b9be@syzkaller.appspotmail.com
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>> fs/hfsplus/unicode.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
>> index 73342c925a4b..3df43a176acb 100644
>> --- a/fs/hfsplus/unicode.c
>> +++ b/fs/hfsplus/unicode.c
>> @@ -133,6 +133,8 @@ int hfsplus_uni2asc(struct super_block *sb,
>> 	op = astr;
>> 	ip = ustr->unicode;
>> 	ustrlen = be16_to_cpu(ustr->length);
>> +	if (ustrlen > HFSPLUS_MAX_STRLEN)
>> +		ustrlen = HFSPLUS_MAX_STRLEN;
> Hmmm.. It’s strange. As far as I can see, we read ustr from the volume
> because be16_to_cpu() is used. But how ustrlen can be bigger than HFSPLUS_MAX_STRLEN
> if we read it from volume? Do we have corrupted volume? What the environment of
> the issue?
>
> Thanks,
> Slava.
The bug is reported by syzbot. You can find the reprodution program there.
Link: https://syzkaller.appspot.com/bug?id=8a0515c326633c38c5145308835518579ea8af1e

It seems that there is a corrupted volume. But I don't know much about this so I'm not sure.
Is there any useful information here?

I noticed that syzbot found another bug of hfsplus recently, which seem to related to
corrupted volume too.
https://syzkaller.appspot.com/bug?id=9fa98e04385363b08013093b659020d8dedae2ec


Thanks,
.
>
>> 	len = *len_p;
>> 	ce1 = NULL;
>> 	compose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
>> -- 
>> 2.25.1
>>
> .
>

