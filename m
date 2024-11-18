Return-Path: <linux-fsdevel+bounces-35050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AAB9D0792
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 02:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92780B21451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AC620309;
	Mon, 18 Nov 2024 01:29:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED8610D;
	Mon, 18 Nov 2024 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731893373; cv=none; b=eUxbwmFqBsXTnpTSWf3Sn1R8JiAmu0rZZVACW7HW1G+lG7zmZQDLjNmKfUqm0q5gNQhtWVeP1NS42Rk4k9VYpn/nT3aZaWf6uYkJuMgtx8xEfs7kxLI+cZ2igi/iLPWpQyBHZ/s/dm2ZbRyV2kVboyyF989BXuvHuomkq3o3BrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731893373; c=relaxed/simple;
	bh=IAgjN1C4/DyHBzGR3jNG5O1uDHZ9aJY7evMyRoUgrjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LbOoRBgB0PYmmflCK4uQzA6O+V+ZqlYhk7KYHyVUc0RUKC39QLRfU4fAOwmLyQeka6K+bXYQ6Jlmv4JUy30SeomLyj8TeYdh5t1S6q+yCVY4sVrS34qE2hU81B6MQ7aKdqFF87btzYT2t1pzx5lrRm+ujnuX5Xb0ltnvs15KmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xs9001sKXz1JB8c;
	Mon, 18 Nov 2024 09:24:32 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id F398E1A0188;
	Mon, 18 Nov 2024 09:29:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Nov
 2024 09:29:20 +0800
Message-ID: <7077c905-2a19-46f2-9f45-d82ed673d48b@huawei.com>
Date: Mon, 18 Nov 2024 09:29:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] quota: flush quota_release_work upon quota writeback
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: Ritesh Harjani <ritesh.list@gmail.com>, <linux-ext4@vger.kernel.org>, Jan
 Kara <jack@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Disha Goel <disgoel@linux.ibm.com>, Yang
 Erkun <yangerkun@huawei.com>
References: <20241115183449.2058590-1-ojaswin@linux.ibm.com>
 <20241115183449.2058590-2-ojaswin@linux.ibm.com> <87plmwcjcd.fsf@gmail.com>
 <ZzjdggicyuGqaVs8@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZzjdggicyuGqaVs8@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2024/11/17 1:59, Ojaswin Mujoo wrote:
> On Sat, Nov 16, 2024 at 02:20:26AM +0530, Ritesh Harjani wrote:
>> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>>
>>> One of the paths quota writeback is called from is:
>>>
>>> freeze_super()
>>>    sync_filesystem()
>>>      ext4_sync_fs()
>>>        dquot_writeback_dquots()
>>>
>>> Since we currently don't always flush the quota_release_work queue in
>>> this path, we can end up with the following race:
>>>
>>>   1. dquot are added to releasing_dquots list during regular operations.
>>>   2. FS freeze starts, however, this does not flush the quota_release_work queue.
>>>   3. Freeze completes.
>>>   4. Kernel eventually tries to flush the workqueue while FS is frozen which
>>>      hits a WARN_ON since transaction gets started during frozen state:
>>>
>>>    ext4_journal_check_start+0x28/0x110 [ext4] (unreliable)
>>>    __ext4_journal_start_sb+0x64/0x1c0 [ext4]
>>>    ext4_release_dquot+0x90/0x1d0 [ext4]
>>>    quota_release_workfn+0x43c/0x4d0
>>>
>>> Which is the following line:
>>>
>>>    WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
>>>
>>> Which ultimately results in generic/390 failing due to dmesg
>>> noise. This was detected on powerpc machine 15 cores.
>>>
>>> To avoid this, make sure to flush the workqueue during
>>> dquot_writeback_dquots() so we dont have any pending workitems after
>>> freeze.
>> Not just that, sync_filesystem can also be called from other places and
>> quota_release_workfn() could write out and and release the dquot
>> structures if such are found during processing of releasing_dquots list.
>> IIUC, this was earlier done in the same dqput() context but had races
>> with dquot_mark_dquot_dirty(). Hence the final dqput() will now add the
>> dquot structures to releasing_dquots list and will schedule a delayed
>> workfn which will process the releasing_dquots list.
> Hi Ritesh,
>
> Ohh right, thanks for the context. I see this was done here:
>
>    dabc8b207566 quota: fix dqput() to follow the guarantees dquot_srcu
>    should provide
>
> Which went in v6.5. Let me cc Baokun as well.
Hello Ojaswin,

Nice catch! Thanks for fixing this up!

Have you tested the performance impact of this patch? It looks like the
unconditional call to flush_delayed_work() in dquot_writeback_dquots()
may have some performance impact for frequent chown/sync scenarios.

When calling release_dquot(), we will only remove the quota of an object
(user/group/project) from disk if it is not quota-limited and does not
use any inode or block.

Asynchronous removal is now much more performance friendly, not only does
it make full use of the multi-core, but for scenarios where we have to
repeatedly chown between two objects, delayed release avoids the need to
repeatedly allocate/free space in memory and on disk.

Overall, since the actual dirty data is already on the disk, there is no
consistency issue here as it is just clearing unreferenced quota on the
disk, so I thought maybe it would be better to call flush_delayed_work()
in the freeze context.


Thanks,
Baokun
>> And so after the final dqput and before the release_workfn gets
>> scheduled, if dquot gets marked as dirty or dquot_transfer gets called -
>> then I am suspecting that it could lead to a dirty or an active dquot.
>>
>> Hence, flushing the delayed quota_release_work at the end of
>> dquot_writeback_dquots() looks like the right thing to do IMO.
>>
>> But I can give another look as this part of the code is not that well
>> known to me.
>>
>>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>> ---
>> Maybe a fixes tag as well?
> Right, I'll add that in the next revision. I believe it would be:
>
> Fixes: dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should provide")
>
> Regards,
> ojaswin
>
>>>   fs/quota/dquot.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
>>> index 3dd8d6f27725..2782cfc8c302 100644
>>> --- a/fs/quota/dquot.c
>>> +++ b/fs/quota/dquot.c
>>> @@ -729,6 +729,8 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
>>>   			sb->dq_op->write_info(sb, cnt);
>>>   	dqstats_inc(DQST_SYNCS);
>>>   
>>> +	flush_delayed_work(&quota_release_work);
>>> +
>>>   	return ret;
>>>   }
>>>   EXPORT_SYMBOL(dquot_writeback_dquots);
>>> -- 
>>> 2.43.5



