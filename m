Return-Path: <linux-fsdevel+bounces-69981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9321CC8CE73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 07:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D916B4E2F46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 06:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56498306B35;
	Thu, 27 Nov 2025 06:13:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8F2C21DC;
	Thu, 27 Nov 2025 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764223993; cv=none; b=jZZKXGjdezhV6HMaywm5k0AQZzBDYnzd232+FRn+GnPFvBn8ZiUZ4Cch4CofFk26NaaMmuGSG5s86R/UtMJdBW+Adj/eWrPeqygmzhV5B48/IcMNEYe8OIZ4uDysn16L2VHCh25yc8hxm2Y+KKKuoH0jI5s8JippghOe9M+iwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764223993; c=relaxed/simple;
	bh=FbD8NOpvlKse2tL4sG2H1TmszWMrqtxg0iJSSiD1vao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSsYYsWa4vvEkccukJCI3yTqvX19wgTagkhMisKhGi9lLiRt9ihXwgWg1iVWR+ZeaBg9BzUoSQvJEM6KhbZO6QHxB/Q8hC3aRTvF/dPDwQ/MN/wxoVki8SKlO6c5kR6uht9bL1zcdRsA5EqqNqHifygsleFK9aQGE9PJlrQrsAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dH5gL1VWHzYQv3c;
	Thu, 27 Nov 2025 14:12:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5070F1A07BB;
	Thu, 27 Nov 2025 14:13:07 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBnD3bx6ydpPaKsCA--.42133S3;
	Thu, 27 Nov 2025 14:13:07 +0800 (CST)
Message-ID: <c3e847cd-064c-4bff-a464-be8d1b8fc778@huaweicloud.com>
Date: Thu, 27 Nov 2025 14:13:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
 libaokun1@huawei.com, yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
 <aSbksRztaQ0UtHKB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aSbksRztaQ0UtHKB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnD3bx6ydpPaKsCA--.42133S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWUZF4UWryrKw4DKw4rKrg_yoW5Kr17pF
	Wfua4UKr4kt340934IqF1qvr1q9w4FgrW7CrW5G3Z8KasFg342gFs7Gw4jqFyFgr48ZF1U
	Ar4Fyr98G3Z8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/26/2025 7:29 PM, Ojaswin Mujoo wrote:
> On Fri, Nov 21, 2025 at 02:08:01PM +0800, Zhang Yi wrote:
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
> Hi Yi,
> 
> This patch looks good to me. I'm just wondering since this is a stale
> data exposure that might need a backport, should we add a Fixes: tag 
> and also keep these fixes before the refactor in 1/13 so backport is
> easier.

Sure, I can move patch 01 after all the fix patches.

Thanks,
Yi.

> 
> Other than that, feel free to add:
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Regards,
> ojaswin
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


