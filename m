Return-Path: <linux-fsdevel+bounces-70107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F50DC90CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 04:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172633A8BA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 03:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05914274652;
	Fri, 28 Nov 2025 03:46:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A91D8E01;
	Fri, 28 Nov 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764301559; cv=none; b=h+7nJRA1fqXZKTz1cAs4xx7ZeR4dL6GWQoqPOjAyJ/X4k0WUbDCM0nX5bId5xTtyXu2dWEai4Hg5S/BJtxR3qPmme51da9lmjigKA9ITcfWBARsayB5STag+w4JVZKppwi2CMFMNHIq4rgq10z4t+knzD2oY/+t5c3NrlAKU+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764301559; c=relaxed/simple;
	bh=FZUuv7H6pce1VCr95JK0HcPzQSX2WJpzLVjAhxC4E2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACaYbC2cEjUF5v7vMUJ8Je6JLNfn6M7kGx3lbIhBygWnXcRUy4ctbPUQmN6eX8h/0vHn0dNUwR4nVBI0gazhQ8RXtOtRbupnzrCcxwx/LdEjnPeVPtDSLUdhgD/pC3RJPs/6rstTCXQPr8LMgaQzJfseM0wKFoQjaXy47KM/mVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dHfLy3vy4zYQtLW;
	Fri, 28 Nov 2025 11:44:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2BC411A07BB;
	Fri, 28 Nov 2025 11:45:53 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgB31HrvGilp3eEUCQ--.36832S3;
	Fri, 28 Nov 2025 11:45:52 +0800 (CST)
Message-ID: <2713db6e-ff43-4583-b328-412e38f3d7bf@huaweicloud.com>
Date: Fri, 28 Nov 2025 11:45:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com,
 yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
 <yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB31HrvGilp3eEUCQ--.36832S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4rtw4kJr47uw18WF4DJwb_yoWxJFWrpr
	4S93W8Kr4Dt34v934xZF4qvrn09w1rWrW7CryrGrn0ya4DWry2gFWfta1YqFyFgr48ZF1j
	vr40yr98G3Z8uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/27/2025 9:41 PM, Jan Kara wrote:
> On Fri 21-11-25 14:08:01, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When allocating initialized blocks from a large unwritten extent, or
>> when splitting an unwritten extent during end I/O and converting it to
>> initialized, there is currently a potential issue of stale data if the
>> extent needs to be split in the middle.
>>
>>        0  A      B  N
>>        [UUUUUUUUUUUU]    U: unwritten extent
>>        [--DDDDDDDD--]    D: valid data
>>           |<-  ->| ----> this range needs to be initialized
>>
>> ext4_split_extent() first try to split this extent at B with
>> EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
>> ext4_split_extent_at() failed to split this extent due to temporary lack
>> of space. It zeroout B to N and mark the entire extent from 0 to N
>> as written.
>>
>>        0  A      B  N
>>        [WWWWWWWWWWWW]    W: written extent
>>        [SSDDDDDDDDZZ]    Z: zeroed, S: stale data
>>
>> ext4_split_extent() then try to split this extent at A with
>> EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and left
>> a stale written extent from 0 to A.
>>
>>        0  A      B   N
>>        [WW|WWWWWWWWWW]
>>        [SS|DDDDDDDDZZ]
>>
>> Fix this by pass EXT4_EXT_DATA_PARTIAL_VALID1 to ext4_split_extent_at()
>> when splitting at B, don't convert the entire extent to written and left
>> it as unwritten after zeroing out B to N. The remaining work is just
>> like the standard two-part split. ext4_split_extent() will pass the
>> EXT4_EXT_DATA_VALID2 flag when it calls ext4_split_extent_at() for the
>> second time, allowing it to properly handle the split. If the split is
>> successful, it will keep extent from 0 to A as unwritten.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Good catch on the data exposure issue! First I'd like to discuss whether
> there isn't a way to fix these problems in a way that doesn't make the
> already complex code even more complex. My observation is that
> EXT4_EXT_MAY_ZEROOUT is only set in ext4_ext_convert_to_initialized() and
> in ext4_split_convert_extents() which both call ext4_split_extent(). The
> actual extent zeroing happens in ext4_split_extent_at() and in
> ext4_ext_convert_to_initialized().

Yes.

> I think the code would be much clearer
> if we just centralized all the zeroing in ext4_split_extent(). At that
> place the situation is actually pretty simple:

Thank you for your suggestion!

> 
> 1) 'ex' is unwritten, 'map' describes part with already written data which
> we want to convert to initialized (generally IO completion situation) => we
> can zero out boundaries if they are smaller than max_zeroout or if extent
> split fails.
> 

Yes. Agree.

> 2) 'ex' is unwritten, 'map' describes part we are preparing for write (IO
> submission) => the split is opportunistic here, if we cannot split due to
> ENOSPC, just go on and deal with it at IO completion time. No zeroing
> needed.

Yes. At the same time, if we can indeed move the entire split unwritten
operation to be handled after I/O completion in the future, it would also be
more convenient to remove this segment of logic.

> 
> 3) 'ex' is written, 'map' describes part that should be converted to
> unwritten => we can zero out the 'map' part if smaller than max_zeroout or
> if extent split fails.

This makes sense to me! This case it originates from the fallocate with Zero
Range operation. Currently, the zero-out operation will not be performed if
the split operation fails, instead, it immediately returns a failure.

I agree with you that we can do zero out if the 'map' part smaller than
max_zeroout instead of split extents. However, if the 'map' part is bigger
than max_zeroout and if extent split fails, I don't think zero out is a good
idea, Because it might cause zero-range calls to take a long time to execute.
Although fallocate doesn't explicitly specify how ZERO_RANGE should be
implemented, users expect it to be very fast. Therefore, in this case, if the
split fails, it would be better to simply return an error, leave things as
they are. What do you think?

> 
> This should all result in a relatively straightforward code where we can
> distinguish the three cases based on 'ex' and passed flags, we should be
> able to drop the 'EXT4_EXT_DATA_VALID*' flags and logic (possibly we could
> drop the 'split_flag' argument of ext4_split_extent() altogether), and fix
> the data exposure issues at the same time. What do you think? Am I missing
> some case?
> 

Indeed, I think the overall solution is a nice cleanup idea. :-)
But this would involve a significant amount of refactoring and logical changes.
Could we first merge the current set of patches(it could be more easier to
backport to the early LTS version), and then I can start a new series to
address this optimization?

Cheers,
Yi.

> 								Honza
> 
>> ---
>>  fs/ext4/extents.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index f7aa497e5d6c..cafe66cb562f 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3294,6 +3294,13 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>>  		err = ext4_ext_zeroout(inode, &zero_ex);
>>  		if (err)
>>  			goto fix_extent_len;
>> +		/*
>> +		 * The first half contains partially valid data, the splitting
>> +		 * of this extent has not been completed, fix extent length
>> +		 * and ext4_split_extent() split will the first half again.
>> +		 */
>> +		if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1)
>> +			goto fix_extent_len;
>>  
>>  		/* update the extent length and mark as initialized */
>>  		ex->ee_len = cpu_to_le16(ee_len);
>> @@ -3364,7 +3371,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>>  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
>>  				       EXT4_EXT_MARK_UNWRIT2;
>>  		if (split_flag & EXT4_EXT_DATA_VALID2)
>> -			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
>> +			split_flag1 |= map->m_lblk > ee_block ?
>> +				       EXT4_EXT_DATA_PARTIAL_VALID1 :
>> +				       EXT4_EXT_DATA_ENTIRE_VALID1;
>>  		path = ext4_split_extent_at(handle, inode, path,
>>  				map->m_lblk + map->m_len, split_flag1, flags1);
>>  		if (IS_ERR(path))
>> -- 
>> 2.46.1
>>


