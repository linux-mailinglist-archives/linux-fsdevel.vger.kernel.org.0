Return-Path: <linux-fsdevel+bounces-50119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6ABAC85F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 03:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E7D7A8D12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 01:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57F614386D;
	Fri, 30 May 2025 01:20:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474109475;
	Fri, 30 May 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748568009; cv=none; b=ttAcxmGSI+nHPhM2ZDWZM++basjPUPN+H2X7/J/O0zlsTXgqdz+C9lnUj8ixaa8F2QSN7TPbnOLTpfcivHFnuy3Un+eiIwnkOKyZz3/DxVSDCpGpRtif0KhvFQDXA+5vMh3pGBRqfazti8n3dXbCQQvTD7pPJ0hIrKHwq4ZdRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748568009; c=relaxed/simple;
	bh=Y8SThuf6xuBG1JxYeUiYYoTvwrrlE43YOnDfoVgrLas=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aR4rh2VIwg1C1RLbGV2/Zvp9dA+S6SttWXRtuqwqKUgE1mqLebSezmuuZboJKhqQL/u3rVxv0VlgUvywsQ228APNWCD/shcW3LS5/G1PM550MET3i6cxcz9MBJZpwDlqiEnI52F6lX+egTTw6Qj1df8lRh0wpeQRvPjWSNxTZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4b7lgP21PHzCth4;
	Fri, 30 May 2025 09:16:17 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 34DC81402CC;
	Fri, 30 May 2025 09:20:03 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 May 2025 09:20:02 +0800
Message-ID: <09201af5-f94c-482f-a271-f2eac322c1a2@huawei.com>
Date: Fri, 30 May 2025 09:20:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hfsplus: remove mutex_lock check in
 hfsplus_free_extents
To: Yangtao Li <frank.li@vivo.com>, <slava@dubeyko.com>,
	<glaubitz@physik.fu-berlin.de>, Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>
References: <20250529061807.2213498-1-frank.li@vivo.com>
 <7fd48db1-949a-46d9-ad73-a3cf5c95796e@huawei.com>
 <e90474a7-a84c-4585-a4f3-120b783ee0a8@vivo.com>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <e90474a7-a84c-4585-a4f3-120b783ee0a8@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2025/5/29 18:46, Yangtao Li wrote:
> Hi,
> 
> 在 2025/5/29 18:34, wangjianjian (C) 写道:
>> [You don't often get email from wangjianjian3@huawei.com. Learn why 
>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On 2025/5/29 14:18, Yangtao Li wrote:
>>> Syzbot reported an issue in hfsplus filesystem:
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 4400 at fs/hfsplus/extents.c:346
>>>       hfsplus_free_extents+0x700/0xad0
>>> Call Trace:
>>> <TASK>
>>> hfsplus_file_truncate+0x768/0xbb0 fs/hfsplus/extents.c:606
>>> hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
>>> cont_expand_zero fs/buffer.c:2383 [inline]
>>> cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
>>> hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
>>> generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
>>> hfsplus_setattr+0x168/0x280 fs/hfsplus/inode.c:263
>>> notify_change+0xe38/0x10f0 fs/attr.c:420
>>> do_truncate+0x1fb/0x2e0 fs/open.c:65
>>> do_sys_ftruncate+0x2eb/0x380 fs/open.c:193
>>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>> do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>> To avoid deadlock, Commit 31651c607151 ("hfsplus: avoid deadlock
>>> on file truncation") unlock extree before hfsplus_free_extents(),
>>> and add check wheather extree is locked in hfsplus_free_extents().
>>>
>>> However, when operations such as hfsplus_file_release,
>>> hfsplus_setattr, hfsplus_unlink, and hfsplus_get_block are executed
>>> concurrently in different files, it is very likely to trigger the
>>> WARN_ON, which will lead syzbot and xfstest to consider it as an
>>> abnormality.
>>>
>>> The comment above this warning also describes one of the easy
>>> triggering situations, which can easily trigger and cause
>>> xfstest&syzbot to report errors.
>>>
>>> [task A]                      [task B]
>>> ->hfsplus_file_release
>>>    ->hfsplus_file_truncate
>>>      ->hfs_find_init
>>>        ->mutex_lock
>>>      ->mutex_unlock
>>>                               ->hfsplus_write_begin
>>>                                 ->hfsplus_get_block
>>>                                   ->hfsplus_file_extend
>>>                                     ->hfsplus_ext_read_extent
>>>                                       ->hfs_find_init
>>>                                         ->mutex_lock
>>>      ->hfsplus_free_extents
>>>        WARN_ON(mutex_is_locked) !!!
>> I am not familiar with hfsplus, but hfsplus_file_release calls
>> hfsplus_file_truncate with inode lock, and hfsplus_write_begin can be
>> called from hfsplus_file_truncate and buffer write, which should also
>> grab inode lock, so that I think task B should be writeback process,
>> which call hfsplus_get_block.
> 
> Did you read the commit log carefully? I mentioned different files.
> 
sorry, didn't not notice that.
>>
>> And ->opencnt seems serves as something like link count of other fs, may
>> be we can move hfsplus_file_truncate to hfsplus_evict_inode, which can
>> only be called when all users of this inode disappear and writeback
>> process should also finished for this inode.
>>>
>>> Several threads could try to lock the shared extents tree.
>>> And warning can be triggered in one thread when another thread
>>> has locked the tree. This is the wrong behavior of the code and
>>> we need to remove the warning.
>>>
>>> Fixes: 31651c607151f ("hfsplus: avoid deadlock on file truncation")
>>> Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
>>> Closes: https://apc01.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Flore.kernel.org%2Fall%2F00000000000057fa4605ef101c4c%40google.com%2F&data=05%7C02%7Cfrank.li%40vivo.com%7C54c2b4030d4c4a98c6c908dd9e9c71b1%7C923e42dc48d54cbeb5821a797a6412ed%7C0%7C0%7C638841116945048579%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4snXozMFZN%2FsmsL9CP5VJb4mf2p0ReNhQIEuA%2B3tD3A%3D&reserved=0
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>   fs/hfsplus/extents.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
>>> index a6d61685ae79..b1699b3c246a 100644
>>> --- a/fs/hfsplus/extents.c
>>> +++ b/fs/hfsplus/extents.c
>>> @@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct 
>>> super_block *sb,
>>>       int i;
>>>       int err = 0;
>>>
>>> -     /* Mapping the allocation file may lock the extent tree */
>>> -     WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree->tree_lock));
>>> -
>>>       hfsplus_dump_extent(extent);
>>>       for (i = 0; i < 8; extent++, i++) {
>>>               count = be32_to_cpu(extent->block_count);
>> -- 
>> Regards
>>
> 
> Thx,
> Yangtao
> 
-- 
Regards


