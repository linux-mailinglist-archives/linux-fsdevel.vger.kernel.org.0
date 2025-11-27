Return-Path: <linux-fsdevel+bounces-69980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02793C8CE58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 07:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C834BB31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 06:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277430F808;
	Thu, 27 Nov 2025 06:09:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7C83C1F;
	Thu, 27 Nov 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764223767; cv=none; b=nNeV32QJ0GBwEEKfkNZZCyinlGVCoQ17Q5J4c/BKR6lLHH6WprtBI/AuKe4pxtkgVMbu2uR//hsLeVnj8Qcr8TEA3i1KGIBQkGPP/icvDMDnHPYfYDJssgYfAjvLNLPD9tA3SyVoUINliH5foJqWHcNWxwnO5JSo+Ac/KurEUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764223767; c=relaxed/simple;
	bh=zAtUk9UT42sUuIg/6t3PluP9Xg0Am1UlGg/IvPDI5So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkecXbQZMJ1EAg1I5aev0WyMtzug4QlmE/WGne476u76yPv0B7BiW4Ibi+JdM8v71VovnEEfsSK38Nl8rcnVipaw56SZEgnPnC3b2wVqkF0Qd9YlsKil1r/Bqw/oowJ7OWhz4dTRUsPRv+XHy43z7kAPorkNrQNtdxxzaIU56kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dH5Zy6JCKzYQtvR;
	Thu, 27 Nov 2025 14:08:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 00E651A19AF;
	Thu, 27 Nov 2025 14:09:19 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHsN6ydpQ1OsCA--.17834S3;
	Thu, 27 Nov 2025 14:09:19 +0800 (CST)
Message-ID: <67f710d0-2ea3-425a-b604-651bf1009e75@huaweicloud.com>
Date: Thu, 27 Nov 2025 14:09:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] ext4: subdivide EXT4_EXT_DATA_VALID1
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
 libaokun1@huawei.com, yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-3-yi.zhang@huaweicloud.com>
 <aSbkH3HkHFxBZ45-@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aSbqoc4qgGf-pp0D@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aSbqoc4qgGf-pp0D@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3VHsN6ydpQ1OsCA--.17834S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45Jw1fGw47XF13XFWkZwb_yoWrAry5pr
	WS9ayUJr1DtryY934IqF1qgr1Yqw1xKw1DurnxWw15ta9rta4agF1fKw1Yga4Y9rs3ZrWU
	ZrWFyrWfCF98CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, thank you again for reviewing this series!

On 11/26/2025 7:55 PM, Ojaswin Mujoo wrote:
> On Wed, Nov 26, 2025 at 04:57:27PM +0530, Ojaswin Mujoo wrote:
>> On Fri, Nov 21, 2025 at 02:08:00PM +0800, Zhang Yi wrote:
>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> When splitting an extent, if the EXT4_GET_BLOCKS_CONVERT flag is set and
>>> it is necessary to split the target extent in the middle,
>>> ext4_split_extent() first handles splitting the latter half of the
>>> extent and passes the EXT4_EXT_DATA_VALID1 flag. This flag implies that
>>> all blocks before the split point contain valid data; however, this
>>> assumption is incorrect.
>>>
>>> Therefore, subdivid EXT4_EXT_DATA_VALID1 into
>>> EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_DATA_PARTIAL_VALID1, which
>>> indicate that the first half of the extent is either entirely valid or
>>> only partially valid, respectively. These two flags cannot be set
>>> simultaneously.
>>>
>>> This patch does not use EXT4_EXT_DATA_PARTIAL_VALID1, it only replaces
>>> EXT4_EXT_DATA_VALID1 with EXT4_EXT_DATA_ENTIRE_VALID1 at the location
>>> where it is set, no logical changes.
>>>
>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>
>> Looks good, feel free to add:
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>
>>> ---
>>>  fs/ext4/extents.c | 18 ++++++++++++------
>>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>> index 91682966597d..f7aa497e5d6c 100644
>>> --- a/fs/ext4/extents.c
>>> +++ b/fs/ext4/extents.c
>>> @@ -43,8 +43,13 @@
>>>  #define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
>>>  #define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */
>>>  
>>> -#define EXT4_EXT_DATA_VALID1	0x8  /* first half contains valid data */
>>> -#define EXT4_EXT_DATA_VALID2	0x10 /* second half contains valid data */
>>> +/* first half contains valid data */
>>> +#define EXT4_EXT_DATA_ENTIRE_VALID1	0x8   /* has partially valid data */
>>> +#define EXT4_EXT_DATA_PARTIAL_VALID1	0x10  /* has entirely valid data */
> 
> Hey, sorry I forgot to mention this minor typo in my last email. The
> comment for partial and entirely valid flags are mismatched :)

Ha, right, I missed that, will fix in next iteration.

Thanks,
Yi.

> 
> Regards,
> ojaswin
> 
>>> +#define EXT4_EXT_DATA_VALID1		(EXT4_EXT_DATA_ENTIRE_VALID1 | \
>>> +					 EXT4_EXT_DATA_PARTIAL_VALID1)
>>> +
>>> +#define EXT4_EXT_DATA_VALID2	0x20 /* second half contains valid data */
>>>  
>>>  static __le32 ext4_extent_block_csum(struct inode *inode,
>>>  				     struct ext4_extent_header *eh)
>>> @@ -3190,8 +3195,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>>>  	unsigned int ee_len, depth;
>>>  	int err = 0;
>>>  
>>> -	BUG_ON((split_flag & (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2)) ==
>>> -	       (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2));
>>> +	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) == EXT4_EXT_DATA_VALID1);
>>> +	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
>>> +	       (split_flag & EXT4_EXT_DATA_VALID2));
>>>  
>>>  	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
>>>  
>>> @@ -3358,7 +3364,7 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>>>  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
>>>  				       EXT4_EXT_MARK_UNWRIT2;
>>>  		if (split_flag & EXT4_EXT_DATA_VALID2)
>>> -			split_flag1 |= EXT4_EXT_DATA_VALID1;
>>> +			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
>>>  		path = ext4_split_extent_at(handle, inode, path,
>>>  				map->m_lblk + map->m_len, split_flag1, flags1);
>>>  		if (IS_ERR(path))
>>> @@ -3717,7 +3723,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>>>  
>>>  	/* Convert to unwritten */
>>>  	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
>>> -		split_flag |= EXT4_EXT_DATA_VALID1;
>>> +		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
>>>  	/* Convert to initialized */
>>>  	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
>>>  		split_flag |= ee_block + ee_len <= eof_block ?
>>> -- 
>>> 2.46.1
>>>


