Return-Path: <linux-fsdevel+bounces-18103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EE98B5930
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C7C1F20F04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11E854908;
	Mon, 29 Apr 2024 12:54:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EDE548E6;
	Mon, 29 Apr 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395266; cv=none; b=JgRvSEnDSGS9R1g6BJ5trR2zMiIITvh4Ue5UywQvWd0POz8yJgT0H7po9T9ModGwfJNpUDZs7hNzmJczHQsUB8vm8SoV0qn8tHuEMr/sZnqHUQN4O09z9BPGKRnV2TDVskn2jFWH7XDoVuelxR+/r84QXaTPJ9snQ3g091GB68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395266; c=relaxed/simple;
	bh=guw/nyeZnNGsEQjhYGD+vv6oq+tSkv94n7vFLKO6Xlw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L/Z8uBgVMSUj0IJ3GAX+1T9YFgwdPJQq+63Oi+lfhv8MYPBdSy6abvwGmmZn4bY6cvlzmw8v5QUECvjsp0b1R3Agg2I4xTtfEmWvWg7PO/XhbrJDcqrlu/HgsmnBor+tCNy5XHjst5IA9/UaQ9voZsDfPgTBr/AeqiYJPppYvp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VSjvQ1QLCz4f3m77;
	Mon, 29 Apr 2024 20:54:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9C96B1A0179;
	Mon, 29 Apr 2024 20:54:19 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBXfA95mC9m9qstLg--.45045S3;
	Mon, 29 Apr 2024 20:54:19 +0800 (CST)
Subject: Re: [PATCH v2 8/9] ext4: make ext4_insert_delayed_block() insert
 multi-blocks
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-9-yi.zhang@huaweicloud.com>
 <20240429100659.pudgimunspsmrthy@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <c89b9557-b971-8a9a-033f-57ff54511267@huaweicloud.com>
Date: Mon, 29 Apr 2024 20:54:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240429100659.pudgimunspsmrthy@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXfA95mC9m9qstLg--.45045S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGryUCF48JrW3tFW5tFyxXwb_yoW7JrWUpr
	Z8GF1fJ3yaqryIgF4SqF1DXrnIga1ktrWUJFZIg3WrZF93GF93KF1DKr15ua4xCrWkGa1Y
	vF45A347uan0ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/29 18:06, Jan Kara wrote:
> On Wed 10-04-24 11:42:02, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Rename ext4_insert_delayed_block() to ext4_insert_delayed_blocks(),
>> pass length parameter to make it insert multi delalloc blocks once a
>> time. For non-bigalloc case, just reserve len blocks and insert delalloc
>> extent. For bigalloc case, we can ensure the middle clusters are not
>> allocated, but need to check whether the start and end clusters are
>> delayed/allocated, if not, we should reserve more space for the start
>> and/or end block(s).
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Thanks for the patch. Some comments below.
> 
>> ---
>>  fs/ext4/inode.c | 51 ++++++++++++++++++++++++++++++++++---------------
>>  1 file changed, 36 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 46c34baa848a..08e2692b7286 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1678,24 +1678,28 @@ static int ext4_da_check_clu_allocated(struct inode *inode, ext4_lblk_t lblk,
>>  }
>>  
>>  /*
>> - * ext4_insert_delayed_block - adds a delayed block to the extents status
>> - *                             tree, incrementing the reserved cluster/block
>> - *                             count or making a pending reservation
>> - *                             where needed
>> + * ext4_insert_delayed_blocks - adds a multiple delayed blocks to the extents
>> + *                              status tree, incrementing the reserved
>> + *                              cluster/block count or making pending
>> + *                              reservations where needed
>>   *
>>   * @inode - file containing the newly added block
>> - * @lblk - logical block to be added
>> + * @lblk - start logical block to be added
>> + * @len - length of blocks to be added
>>   *
>>   * Returns 0 on success, negative error code on failure.
>>   */
>> -static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>> +static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
>> +				      ext4_lblk_t len)
>>  {
>>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>> -	int ret;
>> -	bool allocated = false;
>> +	int resv_clu, ret;
> 	    ^^^ this variable is in prinple the length of the extent. Thus
> it should be ext4_lblk_t type.
> 
>> +	bool lclu_allocated = false;
>> +	bool end_allocated = false;
>> +	ext4_lblk_t end = lblk + len - 1;
>>  
>>  	/*
>> -	 * If the cluster containing lblk is shared with a delayed,
>> +	 * If the cluster containing lblk or end is shared with a delayed,
>>  	 * written, or unwritten extent in a bigalloc file system, it's
>>  	 * already been accounted for and does not need to be reserved.
>>  	 * A pending reservation must be made for the cluster if it's
>> @@ -1706,21 +1710,38 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>>  	 * extents status tree doesn't get a match.
>>  	 */
>>  	if (sbi->s_cluster_ratio == 1) {
>> -		ret = ext4_da_reserve_space(inode, 1);
>> +		ret = ext4_da_reserve_space(inode, len);
>>  		if (ret != 0)   /* ENOSPC */
>>  			return ret;
>>  	} else {   /* bigalloc */
>> -		ret = ext4_da_check_clu_allocated(inode, lblk, &allocated);
>> +		resv_clu = EXT4_B2C(sbi, end) - EXT4_B2C(sbi, lblk) - 1;
>> +		if (resv_clu < 0)
>> +			resv_clu = 0;
> 
> Here resv_clu going negative is strange I'm not sure the math is 100%
> correct in all the cases. I think it would be more logical as:
> 
> 		resv_clu = EXT4_B2C(sbi, end) - EXT4_B2C(sbi, lblk) + 1;
>> and then update resv_clu below as:
> 
>> +
>> +		ret = ext4_da_check_clu_allocated(inode, lblk, &lclu_allocated);
>>  		if (ret < 0)
>>  			return ret;
>> -		if (ret > 0) {
>> -			ret = ext4_da_reserve_space(inode, 1);
>> +		if (ret > 0)
>> +			resv_clu++;
> 
> Here we would do:
> 		if (ret == 0)
> 			resv_clu--;
> 
>> +
>> +		if (EXT4_B2C(sbi, lblk) != EXT4_B2C(sbi, end)) {
>> +			ret = ext4_da_check_clu_allocated(inode, end,
>> +							  &end_allocated);
>> +			if (ret < 0)
>> +				return ret;
>> +			if (ret > 0)
>> +				resv_clu++;
> 
> And similarly here:
> 			if (ret == 0)
> 				resv_clu--;

Oh, yes, it is definitely more logical than mine. Thanks for taking time
to review this series, other changelog and comments suggestions in this
series are looks fine to me, I will use them. Besides, Ritesh improved
my changelog in patch 2, I will keep your reviewed tag if you don't have
different opinions.

Thanks,
Yi.

> 
>> +		}
>> +
>> +		if (resv_clu) {
>> +			ret = ext4_da_reserve_space(inode, resv_clu);
>>  			if (ret != 0)   /* ENOSPC */
>>  				return ret;
>>  		}
>>  	}
>>  
>> -	ext4_es_insert_delayed_extent(inode, lblk, 1, allocated, false);
>> +	ext4_es_insert_delayed_extent(inode, lblk, len, lclu_allocated,
>> +				      end_allocated);
>>  	return 0;
>>  }
>>  
>> @@ -1823,7 +1844,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>>  		}
>>  	}
>>  
>> -	retval = ext4_insert_delayed_block(inode, map->m_lblk);
>> +	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
>>  	up_write(&EXT4_I(inode)->i_data_sem);
>>  	if (retval)
>>  		return retval;
>> -- 
>> 2.39.2
>>


