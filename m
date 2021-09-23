Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFB8415815
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 08:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhIWGIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 02:08:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9910 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbhIWGIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:08:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HFPhY23Y7z8ykH;
        Thu, 23 Sep 2021 14:02:37 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 14:07:07 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 23 Sep 2021 14:07:06 +0800
Message-ID: <84fc0f56-c15d-1561-f138-e5060ce5a461@huawei.com>
Date:   Thu, 23 Sep 2021 14:07:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] ramfs: fix mount source show for ramfs
From:   yangerkun <yangerkun@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     <sfr@canb.auug.org.au>, <jack@suse.cz>,
        <gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <yukuai3@huawei.com>
References: <20210811122811.2288041-1-yangerkun@huawei.com>
 <720f6c7a-6745-98ad-5c71-7747857a7f01@huawei.com>
 <20210908153958.19054d439ae59ee3a7e41519@linux-foundation.org>
 <b82b7472-be64-4681-98a2-9d16736e3edd@huawei.com>
 <b66aa49b-8289-be25-6126-92e6ce1c50ab@huawei.com>
 <64893b00-d606-8ea9-0fd7-c6c819e5d387@huawei.com>
In-Reply-To: <64893b00-d606-8ea9-0fd7-c6c819e5d387@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping again...

在 2021/9/18 15:08, yangerkun 写道:
> Ping...
> 
> 在 2021/9/13 9:10, yangerkun 写道:
>>
>>
>> 在 2021/9/9 16:37, yangerkun 写道:
>>>
>>>
>>> 在 2021/9/9 6:39, Andrew Morton 写道:
>>>> On Wed, 8 Sep 2021 16:56:25 +0800 yangerkun <yangerkun@huawei.com> 
>>>> wrote:
>>>>
>>>>> 在 2021/8/11 20:28, yangerkun 写道:
>>>>>> ramfs_parse_param does not parse key "source", and will convert
>>>>>> -ENOPARAM to 0. This will skip vfs_parse_fs_param_source in
>>>>>> vfs_parse_fs_param, which lead always "none" mount source for 
>>>>>> ramfs. Fix
>>>>>> it by parse "source" in ramfs_parse_param.
>>>>>>
>>>>>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>>>>>> ---
>>>>>>    fs/ramfs/inode.c | 4 ++++
>>>>>>    1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
>>>>>> index 65e7e56005b8..0d7f5f655fd8 100644
>>>>>> --- a/fs/ramfs/inode.c
>>>>>> +++ b/fs/ramfs/inode.c
>>>>>> @@ -202,6 +202,10 @@ static int ramfs_parse_param(struct 
>>>>>> fs_context *fc, struct fs_parameter *param)
>>>>>>        struct ramfs_fs_info *fsi = fc->s_fs_info;
>>>>>>        int opt;
>>>>>> +    opt = vfs_parse_fs_param_source(fc, param);
>>>>>> +    if (opt != -ENOPARAM)
>>>>>> +        return opt;
>>>>>> +
>>>>>>        opt = fs_parse(fc, ramfs_fs_parameters, param, &result);
>>>>>>        if (opt < 0) {
>>>>>>            /*
>>>>>>
>>>>
>>>> (top-posting repaired)
>>>>
>>>>> Hi, this patch seems still leave in linux-next, should we pull it to
>>>>> mainline?
>>>>
>>>> I was hoping for a comment from Al?
>>>
>>> Hi, Al,
>>>
>>> Can you help to review this patch...
>>
>> Hi, Al,
>>
>> Sorry for the noise again, can you help to give some comments for this 
>> patch.
>>
>>>
>>> Thanks,
>>> Kun.
>>>
>>>> .
>>>>
>>> .
>> .
> .
