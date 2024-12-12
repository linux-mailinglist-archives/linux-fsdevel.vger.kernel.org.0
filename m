Return-Path: <linux-fsdevel+bounces-37171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1009EE867
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A318882F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD52153C1;
	Thu, 12 Dec 2024 14:08:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2820E307;
	Thu, 12 Dec 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012527; cv=none; b=RznuZj6ySEdC7z8rL9o5wb92+DCBlFBO4M3J1qHkqvP8yQklaQItShfwON9TF3Dnaw/xfzh3lUOjJ1x2GtM2SyxDfMYPP6pxEBs5AcHsqwSdtNrj0tYPks3lDgjmsqaL/vBrSvusKqFa72IMkt88tZYOaMsclk+ZKWfiCYZhIEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012527; c=relaxed/simple;
	bh=T0ptG1AmA/WjmW6m9thCBff7iLerJE3/hs1hucSpmwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBd15HZlwN1um+XtqUhIpFXs0DYMa6IT6Aq6CCPWDQvhE/RSAkLlv/e5MvEFqs0sX9bGkFkpDZYQeSPQBQ2uuQyKUD5aSZPVBm24kM0ss27RjVO6+V2HlE8Xt4kdFge3xWn37bMDjOs8o7AFK4nOf/PxhepP3UB08uh0bmx8O+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y8Dp55xd1z4f3khf;
	Thu, 12 Dec 2024 22:08:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 21B0D1A0568;
	Thu, 12 Dec 2024 22:08:33 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoJf7lpn4nyVEQ--.34851S3;
	Thu, 12 Dec 2024 22:08:32 +0800 (CST)
Message-ID: <c1dbb5ab-8a31-487f-8eae-dfe8b13204ad@huaweicloud.com>
Date: Thu, 12 Dec 2024 22:08:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] jbd2: flush filesystem device before updating tail
 sequence
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
 linux-ext4@vger.kernel.org
References: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
 <20241203014407.805916-3-yi.zhang@huaweicloud.com>
 <ca1c680f-f3f4-40b5-13af-f8ee49d99dae@huaweicloud.com>
 <ab380b0c-9a9b-4f16-a427-7fef8a2ef212@huaweicloud.com>
 <027261aa-9d57-861a-fd78-0acd2d7836ec@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <027261aa-9d57-861a-fd78-0acd2d7836ec@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3XoJf7lpn4nyVEQ--.34851S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyxuFWxKryDKw4rGr1DAwb_yoW8KFyfpF
	y8Ca4jyFWkZF4UCF1xtF4rXFW2qrWjyFy8Wr1DurnYga1qvw1fKFW7tryYgF1qyr1fKw48
	Xr1xJF9Fg34jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/12 20:34, Kemeng Shi wrote:
> 
> 
> on 12/3/2024 3:24 PM, Zhang Yi wrote:
>> On 2024/12/3 14:53, Kemeng Shi wrote:
>>>
>>>
>>> on 12/3/2024 9:44 AM, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> When committing transaction in jbd2_journal_commit_transaction(), the
>>>> disk caches for the filesystem device should be flushed before updating
>>>> the journal tail sequence. However, this step is missed if the journal
>>>> is not located on the filesystem device. As a result, the filesystem may
>>>> become inconsistent following a power failure or system crash. Fix it by
>>>> ensuring that the filesystem device is flushed appropriately.
>>>>
>>>> Fixes: 3339578f0578 ("jbd2: cleanup journal tail after transaction commit")
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>> ---
>>>>  fs/jbd2/commit.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
>>>> index 4305a1ac808a..f95cf272a1b5 100644
>>>> --- a/fs/jbd2/commit.c
>>>> +++ b/fs/jbd2/commit.c
>>>> @@ -776,9 +776,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>>>>  	/*
>>>>  	 * If the journal is not located on the file system device,
>>>>  	 * then we must flush the file system device before we issue
>>>> -	 * the commit record
>>>> +	 * the commit record and update the journal tail sequence.
>>>>  	 */
>>>> -	if (commit_transaction->t_need_data_flush &&
>>>> +	if ((commit_transaction->t_need_data_flush || update_tail) &&
>>>>  	    (journal->j_fs_dev != journal->j_dev) &&
>>>>  	    (journal->j_flags & JBD2_BARRIER))
>>>>  		blkdev_issue_flush(journal->j_fs_dev);
>>>>
>>> In journal_submit_commit_record(), we will submit commit block with REQ_PREFLUSH
>>> which is supposed to ensure disk cache is flushed before writing commit block.
>>> So I think the current code is fine.
>>> Please correct me if I miss anything.
>>>
>>
>> The commit I/O with REQ_PREFLUSH only flushes 'journal->j_dev', not
>> 'journal->j_fs_dev'. We need to flush journal->j_fs_dev to ensure that all
>> written metadata has been persisted to the filesystem disk, Until then, we
>> cannot update the tail sequence.
> My bad...
> Look good to me. Feel free to add:
> 
> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>

It's fine, thanks for your review.

Cheers,
Yi.


