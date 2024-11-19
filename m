Return-Path: <linux-fsdevel+bounces-35172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0FF9D203D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 07:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102661F222F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3510515854A;
	Tue, 19 Nov 2024 06:30:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65D155C8A;
	Tue, 19 Nov 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731997810; cv=none; b=iGu0GkfFgvdO3DUTVtQw0HIMnjCINsFW7OTMXVU9k8kw0zi/4PWLm9j1bBQmhwkBDQhEMVQqavtEhDhwNWngpiKKf9n6H7HGY7FC3yjABXsUgtSNHrbYiLsB8eXo7F5+1gwmhp2EGcr6C6QPQ0i/SPNQiZ1q5yn1UJ9pKXSSNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731997810; c=relaxed/simple;
	bh=4qAzza/2ZTu6Ygf5D4eRWFT4hXBKg3JSc+ED4US8OMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UPPrJ24wF/A9aljGLlRcURVxWnP8KqfE+cR8SqRe6K/QMiOZ52QUcL7M8+ZdJch8KEknG5am5k3CfnoNw1xQbB1v0UFdO3pWxHXyMUOAn+COpppBrf2Addo+rGWRofMGnEd345gkbs5KLUcce9c4q26RzoW8HgBpKat9Eg84Hl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XsvkC3VFZz1yqbk;
	Tue, 19 Nov 2024 14:30:11 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id C252C1A016C;
	Tue, 19 Nov 2024 14:29:58 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Nov
 2024 14:29:57 +0800
Message-ID: <b2ea547a-6097-4f95-9ee7-097c8363a076@huawei.com>
Date: Tue, 19 Nov 2024 14:29:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] quota: flush quota_release_work upon quota writeback
To: Jan Kara <jack@suse.cz>
CC: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Ritesh Harjani
	<ritesh.list@gmail.com>, <linux-ext4@vger.kernel.org>, Jan Kara
	<jack@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Disha Goel <disgoel@linux.ibm.com>, Yang
 Erkun <yangerkun@huawei.com>
References: <20241115183449.2058590-1-ojaswin@linux.ibm.com>
 <20241115183449.2058590-2-ojaswin@linux.ibm.com> <87plmwcjcd.fsf@gmail.com>
 <ZzjdggicyuGqaVs8@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <7077c905-2a19-46f2-9f45-d82ed673d48b@huawei.com>
 <20241118125344.a3n3kn6crvrixglb@quack3>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241118125344.a3n3kn6crvrixglb@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2024/11/18 20:53, Jan Kara wrote:
> On Mon 18-11-24 09:29:19, Baokun Li wrote:
>> On 2024/11/17 1:59, Ojaswin Mujoo wrote:
>>> On Sat, Nov 16, 2024 at 02:20:26AM +0530, Ritesh Harjani wrote:
>>>> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>>>>
>>>>> One of the paths quota writeback is called from is:
>>>>>
>>>>> freeze_super()
>>>>>     sync_filesystem()
>>>>>       ext4_sync_fs()
>>>>>         dquot_writeback_dquots()
>>>>>
>>>>> Since we currently don't always flush the quota_release_work queue in
>>>>> this path, we can end up with the following race:
>>>>>
>>>>>    1. dquot are added to releasing_dquots list during regular operations.
>>>>>    2. FS freeze starts, however, this does not flush the quota_release_work queue.
>>>>>    3. Freeze completes.
>>>>>    4. Kernel eventually tries to flush the workqueue while FS is frozen which
>>>>>       hits a WARN_ON since transaction gets started during frozen state:
>>>>>
>>>>>     ext4_journal_check_start+0x28/0x110 [ext4] (unreliable)
>>>>>     __ext4_journal_start_sb+0x64/0x1c0 [ext4]
>>>>>     ext4_release_dquot+0x90/0x1d0 [ext4]
>>>>>     quota_release_workfn+0x43c/0x4d0
>>>>>
>>>>> Which is the following line:
>>>>>
>>>>>     WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
>>>>>
>>>>> Which ultimately results in generic/390 failing due to dmesg
>>>>> noise. This was detected on powerpc machine 15 cores.
>>>>>
>>>>> To avoid this, make sure to flush the workqueue during
>>>>> dquot_writeback_dquots() so we dont have any pending workitems after
>>>>> freeze.
>>>> Not just that, sync_filesystem can also be called from other places and
>>>> quota_release_workfn() could write out and and release the dquot
>>>> structures if such are found during processing of releasing_dquots list.
>>>> IIUC, this was earlier done in the same dqput() context but had races
>>>> with dquot_mark_dquot_dirty(). Hence the final dqput() will now add the
>>>> dquot structures to releasing_dquots list and will schedule a delayed
>>>> workfn which will process the releasing_dquots list.
>>> Hi Ritesh,
>>>
>>> Ohh right, thanks for the context. I see this was done here:
>>>
>>>     dabc8b207566 quota: fix dqput() to follow the guarantees dquot_srcu
>>>     should provide
> Yup.
>
>> Nice catch! Thanks for fixing this up!
>>
>> Have you tested the performance impact of this patch? It looks like the
>> unconditional call to flush_delayed_work() in dquot_writeback_dquots()
>> may have some performance impact for frequent chown/sync scenarios.
> Well, but sync(2) or so is expensive anyway. Also dquot_writeback_dquots()
> should persist all pending quota modifications and it is true that pending
> dquot_release() calls can remove quota structures from the quota file and
> thus are by definition pending modifications. So I agree with Ojaswin that
> putting the workqueue flush there makes sense and is practically required
> for data consistency guarantees.
Make sense.
>> When calling release_dquot(), we will only remove the quota of an object
>> (user/group/project) from disk if it is not quota-limited and does not
>> use any inode or block.
>>
>> Asynchronous removal is now much more performance friendly, not only does
>> it make full use of the multi-core, but for scenarios where we have to
>> repeatedly chown between two objects, delayed release avoids the need to
>> repeatedly allocate/free space in memory and on disk.
> True, but unless you call sync(2) in between these two calls this is going
> to still hold.
Yeah without sync or syncfs, it's the same as before.
>> Overall, since the actual dirty data is already on the disk, there is no
>> consistency issue here as it is just clearing unreferenced quota on the
>> disk, so I thought maybe it would be better to call flush_delayed_work()
>> in the freeze context.
> To summarise, I don't think real-life workloads are going to observe the
> benefit and conceptually the call really belongs more to
> dquot_writeback_dquots().
>
> 								Honza

Okay, thanks for the feedback!


Regards,
Baokun


