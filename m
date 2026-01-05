Return-Path: <linux-fsdevel+bounces-72370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CA8CF18C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 02:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F83C300E017
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 01:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F552BE7D2;
	Mon,  5 Jan 2026 01:17:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6397251795;
	Mon,  5 Jan 2026 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767575839; cv=none; b=rrpdvgZBWbyqZBfKw4q+26eP5GIzTA3herTKAMj7Ok2NyPtqSnBBu14EnkePzl/5t98mTTNTVCQbvkaQXvIkDvjD0GYBBKpW1KvxEvUtoFLaJ4n3oPUGHZdLZsiWTActt9Lm2jtrXiAHzkQupf6OBcDt9wHA8OYTdqlSy27/SDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767575839; c=relaxed/simple;
	bh=41sG10tY1sP2SCwNZ1u4ooUei2L09MHgmJvyXBqOZb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hh4NPBiPERoTH0zvFn3HtYbeowJhwPuwF38ubrJ/Pjbmuxmbe4tV4bpyQYuqiZH0SMt1J17GIiEeUwDYC+LO9cEgXcTebhLmuHpI3Z2ZGh2vDJPdpR9qUIvJulaohGtdtj7bC3bmMFMHB1H9pq9iA91PQw+pNmnuh+U2FXuWUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dkxGF0thxzKHLxq;
	Mon,  5 Jan 2026 09:16:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9833A4059C;
	Mon,  5 Jan 2026 09:17:14 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_cWEVtpgr6pCg--.39286S3;
	Mon, 05 Jan 2026 09:17:14 +0800 (CST)
Message-ID: <2ad8c0d5-cd6f-4943-86b1-be8f6a385414@huaweicloud.com>
Date: Mon, 5 Jan 2026 09:17:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 1/7] ext4: use reserved metadata blocks when
 splitting extent on endio
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, yi.zhang@huawei.com,
 yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-2-yi.zhang@huaweicloud.com>
 <aVkc27cw-m5Skeo0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aVkc27cw-m5Skeo0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXd_cWEVtpgr6pCg--.39286S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr43tF1fJFW8JFWDAF4Dtwb_yoW5Jw1kpr
	yak3WUKr40q34Y9rWIya1UGryjv3W5GF47urZ0q3y5Way2yrnYqF12kw1F9F90vrZ7Jw4Y
	vr40vw18Zwn8Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 1/3/2026 9:42 PM, Ojaswin Mujoo wrote:
> On Tue, Dec 23, 2025 at 09:17:56AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When performing buffered writes, we may need to split and convert an
>> unwritten extent into a written one during the end I/O process. However,
>> we do not reserve space specifically for these metadata changes, we only
>> reserve 2% of space or 4096 blocks. To address this, we use
>> EXT4_GET_BLOCKS_PRE_IO to potentially split extents in advance and
>> EXT4_GET_BLOCKS_METADATA_NOFAIL to utilize reserved space if necessary.
>>
>> These two approaches can reduce the likelihood of running out of space
>> and losing data. However, these methods are merely best efforts, we
>> could still run out of space, and there is not much difference between
>> converting an extent during the writeback process and the end I/O
>> process, it won't increase the rick of losing data if we postpone the
>                                 ^^^^ risk
> 
> Other than the minor typo above, feel free to add:
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thank you for reviewing this series, I will revise it in v3.

Cheers,
Yi.

> 
>> conversion.
>>
>> Therefore, also use EXT4_GET_BLOCKS_METADATA_NOFAIL in
>> ext4_convert_unwritten_extents_endio() to prepare for the buffered I/O
>> iomap conversion, which may perform extent conversion during the end I/O
>> process.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> ---
>>  fs/ext4/extents.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 27eb2c1df012..e53959120b04 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3794,6 +3794,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>>  	 * illegal.
>>  	 */
>>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
>> +		int flags = EXT4_GET_BLOCKS_CONVERT |
>> +			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
>>  #ifdef CONFIG_EXT4_DEBUG
>>  		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
>>  			     " len %u; IO logical block %llu, len %u",
>> @@ -3801,7 +3803,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>>  			     (unsigned long long)map->m_lblk, map->m_len);
>>  #endif
>>  		path = ext4_split_convert_extents(handle, inode, map, path,
>> -						EXT4_GET_BLOCKS_CONVERT, NULL);
>> +						  flags, NULL);
>>  		if (IS_ERR(path))
>>  			return path;
>>  
>> -- 
>> 2.52.0
>>


