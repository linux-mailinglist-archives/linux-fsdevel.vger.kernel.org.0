Return-Path: <linux-fsdevel+bounces-36316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE89E1423
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 08:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06993B2280F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 07:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDD18B484;
	Tue,  3 Dec 2024 07:24:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7B18B494;
	Tue,  3 Dec 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210682; cv=none; b=FNjwy6YFx3yqIGqdTSWy+rsPtkfbQ7/mmLP2Slyx+byMbUynkX6VEB10oPqJKV3+4sVEMgD7Ew5kfYcur8AV5ZHXDUM4f9yx1DxY75UsYAEY4cGAdovQAtw1BXDCq66F6HMqZ5q8No+Oy0piF2KP5Vysll/FQKngO5dOhf6sE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210682; c=relaxed/simple;
	bh=wZDhPDXNvUjoFpCisQxrnEojAHLpQWqiRYE+KJYhNYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXUD5FqkVYoME4Jc436SyIapFGXnodx3mFdADuiKKnEbG7L3NyX7X+8e68u5y4Eu0XS0M5/uU1i5EzVQiABp3/jn0s9t0s/bd7/myb6ExP1Mc7dW+qcpZELdDcejxmHORBr0CauIwJL6jQyXaUpPc8vaOVFMCGbRBjFBYkehr+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y2XG01Xs4z4f3lVb;
	Tue,  3 Dec 2024 15:24:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2A8031A0359;
	Tue,  3 Dec 2024 15:24:28 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4cqsk5ne0saDg--.52485S3;
	Tue, 03 Dec 2024 15:24:27 +0800 (CST)
Message-ID: <ab380b0c-9a9b-4f16-a427-7fef8a2ef212@huaweicloud.com>
Date: Tue, 3 Dec 2024 15:24:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] jbd2: flush filesystem device before updating tail
 sequence
To: Kemeng Shi <shikemeng@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
 <20241203014407.805916-3-yi.zhang@huaweicloud.com>
 <ca1c680f-f3f4-40b5-13af-f8ee49d99dae@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ca1c680f-f3f4-40b5-13af-f8ee49d99dae@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHY4cqsk5ne0saDg--.52485S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13Zr47Gw4DWw47Aw43Jrb_yoW8Zw45pF
	y8Ca4jyrWkZF4UCFn7tF48XFW7XFWqya48WFyDCrnagw4qqwn3KFW3trySgr1jyr1F9w48
	Xr4Iqa4qg34jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/3 14:53, Kemeng Shi wrote:
> 
> 
> on 12/3/2024 9:44 AM, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When committing transaction in jbd2_journal_commit_transaction(), the
>> disk caches for the filesystem device should be flushed before updating
>> the journal tail sequence. However, this step is missed if the journal
>> is not located on the filesystem device. As a result, the filesystem may
>> become inconsistent following a power failure or system crash. Fix it by
>> ensuring that the filesystem device is flushed appropriately.
>>
>> Fixes: 3339578f0578 ("jbd2: cleanup journal tail after transaction commit")
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/jbd2/commit.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
>> index 4305a1ac808a..f95cf272a1b5 100644
>> --- a/fs/jbd2/commit.c
>> +++ b/fs/jbd2/commit.c
>> @@ -776,9 +776,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>>  	/*
>>  	 * If the journal is not located on the file system device,
>>  	 * then we must flush the file system device before we issue
>> -	 * the commit record
>> +	 * the commit record and update the journal tail sequence.
>>  	 */
>> -	if (commit_transaction->t_need_data_flush &&
>> +	if ((commit_transaction->t_need_data_flush || update_tail) &&
>>  	    (journal->j_fs_dev != journal->j_dev) &&
>>  	    (journal->j_flags & JBD2_BARRIER))
>>  		blkdev_issue_flush(journal->j_fs_dev);
>>
> In journal_submit_commit_record(), we will submit commit block with REQ_PREFLUSH
> which is supposed to ensure disk cache is flushed before writing commit block.
> So I think the current code is fine.
> Please correct me if I miss anything.
> 

The commit I/O with REQ_PREFLUSH only flushes 'journal->j_dev', not
'journal->j_fs_dev'. We need to flush journal->j_fs_dev to ensure that all
written metadata has been persisted to the filesystem disk, Until then, we
cannot update the tail sequence.

Thanks,
Yi.


