Return-Path: <linux-fsdevel+bounces-37161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C19EE6D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E931C1885C63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22AC213251;
	Thu, 12 Dec 2024 12:34:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D25211493;
	Thu, 12 Dec 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006858; cv=none; b=gvIe1MK0iEqx46V+hRsPLSIyy4/shqTWBPUUz5I8zGLt8g6KohIcNVSDdwieLOqiD/wNk1STDxQNdgbLHbPa2gUMqtj5fi/URSJtnuMMSTxXqTw3IGJeKihw6F/2GBeOA3RldXNcC5GeBdN7UCKH6cSSFyvc3vCreMGWhPfrvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006858; c=relaxed/simple;
	bh=kuGc7LUr4NoH6Qx7IXS8GWBwCDQd5WS+8hnrdDTH1fs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H4Ni7aLhl4yWFIhKKlhoTm/BhlDngZUUWm3qZTV9T3zzwfMR5sa856/hl6KLbofj2YRZorrkvskBIwpyD8UBraP40lssyWT31T2mz+CEelZCYmLY/A8rp20Tj4zg0FyE1KIVc7s1vH30bnpe+SfI2N4+rwAEJyGJHyAU7uytm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y8Bj93ZYJz4f3lDh;
	Thu, 12 Dec 2024 20:33:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C770B1A0359;
	Thu, 12 Dec 2024 20:34:09 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgDHoYVB2FpnoESPEQ--.40606S2;
	Thu, 12 Dec 2024 20:34:09 +0800 (CST)
Subject: Re: [PATCH 2/2] jbd2: flush filesystem device before updating tail
 sequence
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
 <20241203014407.805916-3-yi.zhang@huaweicloud.com>
 <ca1c680f-f3f4-40b5-13af-f8ee49d99dae@huaweicloud.com>
 <ab380b0c-9a9b-4f16-a427-7fef8a2ef212@huaweicloud.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <027261aa-9d57-861a-fd78-0acd2d7836ec@huaweicloud.com>
Date: Thu, 12 Dec 2024 20:34:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ab380b0c-9a9b-4f16-a427-7fef8a2ef212@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHoYVB2FpnoESPEQ--.40606S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4fGrWfKw48JFyxXry8Grg_yoW8tF4fpF
	y8Ca4jkrWkZF4UCFn7tF4kXFW2qrWqyFyUWFyDurnagw4qqwn3KFW7trySgF1qyr1S9w48
	Xr1Igas2g34jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/3/2024 3:24 PM, Zhang Yi wrote:
> On 2024/12/3 14:53, Kemeng Shi wrote:
>>
>>
>> on 12/3/2024 9:44 AM, Zhang Yi wrote:
>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> When committing transaction in jbd2_journal_commit_transaction(), the
>>> disk caches for the filesystem device should be flushed before updating
>>> the journal tail sequence. However, this step is missed if the journal
>>> is not located on the filesystem device. As a result, the filesystem may
>>> become inconsistent following a power failure or system crash. Fix it by
>>> ensuring that the filesystem device is flushed appropriately.
>>>
>>> Fixes: 3339578f0578 ("jbd2: cleanup journal tail after transaction commit")
>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>> ---
>>>  fs/jbd2/commit.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
>>> index 4305a1ac808a..f95cf272a1b5 100644
>>> --- a/fs/jbd2/commit.c
>>> +++ b/fs/jbd2/commit.c
>>> @@ -776,9 +776,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>>>  	/*
>>>  	 * If the journal is not located on the file system device,
>>>  	 * then we must flush the file system device before we issue
>>> -	 * the commit record
>>> +	 * the commit record and update the journal tail sequence.
>>>  	 */
>>> -	if (commit_transaction->t_need_data_flush &&
>>> +	if ((commit_transaction->t_need_data_flush || update_tail) &&
>>>  	    (journal->j_fs_dev != journal->j_dev) &&
>>>  	    (journal->j_flags & JBD2_BARRIER))
>>>  		blkdev_issue_flush(journal->j_fs_dev);
>>>
>> In journal_submit_commit_record(), we will submit commit block with REQ_PREFLUSH
>> which is supposed to ensure disk cache is flushed before writing commit block.
>> So I think the current code is fine.
>> Please correct me if I miss anything.
>>
> 
> The commit I/O with REQ_PREFLUSH only flushes 'journal->j_dev', not
> 'journal->j_fs_dev'. We need to flush journal->j_fs_dev to ensure that all
> written metadata has been persisted to the filesystem disk, Until then, we
> cannot update the tail sequence.
My bad...
Look good to me. Feel free to add:

Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Thanks,
> Yi.
> 
> 


