Return-Path: <linux-fsdevel+bounces-37709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA899F5F10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 08:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1F216330E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 07:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E72158555;
	Wed, 18 Dec 2024 07:10:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C63156991;
	Wed, 18 Dec 2024 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734505848; cv=none; b=b0pFgh6h9MN1Uci25ci9Ke5Xp4H7epxTswnu/8xwhCjaunYuPSdf87v2KnexE3E/Y594WdmMHI6sp/fHOuHF6gXcx6ncz+lrz8hzJCHcMppjg8V2DQY/Pca8LZ2UU3OxEBPEbbWO4ZRTrCwbmkGwzML3Jq+Ocmk2eKls7m5vkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734505848; c=relaxed/simple;
	bh=27ynmtoAzFELLV0Poyw1T6ytRdrA/E3LEGeXPNkHfKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVMvGkczyvy9Pq0ZsZ5mGfMMYslA8gkrwhOFJNlsW/PxDPhnH+hyYBTnb+ksfcl4ZK5HpinNFzywMO5w1r2A3zdLwj+l16zixMiRQFS1jWHersjodAVONY/xiWcj2zdy9MmHBAkGZPP/ZZxknljht1yleThWpp2uyOqLRej1mJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YClF54nDmz4f3lVg;
	Wed, 18 Dec 2024 15:10:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 32AC21A0194;
	Wed, 18 Dec 2024 15:10:38 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4dsdWJnUKC5Ew--.47684S3;
	Wed, 18 Dec 2024 15:10:38 +0800 (CST)
Message-ID: <ff8abd75-b325-4f93-a838-0020e97e0b25@huaweicloud.com>
Date: Wed, 18 Dec 2024 15:10:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] ext4: don't write back data before punch hole in
 nojournal mode
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-4-yi.zhang@huaweicloud.com>
 <Z2GLPnX24/gvYl98@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z2GLPnX24/gvYl98@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHo4dsdWJnUKC5Ew--.47684S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1DCw13AFy3ZrWkAw15twb_yoWrXw48pr
	WYkFy5KF4kWayDCwn2gFsFqF1rKws7CrWUXryrW3Wa93s8Arn2gF4jgr1F9ayUGrZ7J3y0
	vF45tryxWFyUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	i0ePUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/17 22:31, Ojaswin Mujoo wrote:
> On Mon, Dec 16, 2024 at 09:39:08AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> There is no need to write back all data before punching a hole in
>> non-journaled mode since it will be dropped soon after removing space.
>> Therefore, the call to filemap_write_and_wait_range() can be eliminated.
> 
> Hi, sorry I'm a bit late to this however following the discussion here
> [1], I believe the initial concern was that we don't in PATCH v1 01/10 
> was that after truncating the pagecache, the ext4_alloc_file_blocks()
> call might fail with errors like EIO, ENOMEM etc leading to inconsistent
> data. 
> 
> Is my understanding correct that  we realised that these are very rare
> cases and are not worth the performance penalty of writeback? In which
> case, is it really okay to just let the scope for corruption exist even
> though its rare. There might be some other error cases we might be
> missing which might be more easier to hit. For eg I think we can also
> fail ext4_alloc_file_blocks() with ENOSPC in case there is a written to
> unwritten extent conversion causing an extent split leading to  extent
> tree node allocation. (Maybe can be avoided by using PRE_IO with
> EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT in the first ext4_alloc_file_blocks() call)
> 
> So does it make sense to retain the writeback behavior or am I just
> being paranoid :) 
> 

Hi, Ojaswin!

Yeah, from my point of view, ENOSPC could happen, and it may be more
likely to happen if we intentionally create conditions for it. However,
all the efforts we can make at this point are merely best efforts and
reduce the probability. We cannot 100% guarantee it will not happen,
even if we write back the whole range before manipulating extents and
blocks. This is because we do not accurately reserve space for extents
split. Additionally, In ext4_punch_hole(), we have used 'nofail' flag
while freeing blocks to reduce the possibility of ENOSPC. So I suppose
it's fine by now, but we may need to implement additional measures if
we truly want to resolve the issue completely.

Thanks,
Yi.

> 
>> Besides, similar to ext4_zero_range(), we must address the case of
>> partially punched folios when block size < page size. It is essential to
>> remove writable userspace mappings to ensure that the folio can be
>> faulted again during subsequent mmap write access.
>>
>> In journaled mode, we need to write dirty pages out before discarding
>> page cache in case of crash before committing the freeing data
>> transaction, which could expose old, stale data, even if synchronization
>> has been performed.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/inode.c | 18 +++++-------------
>>  1 file changed, 5 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index bf735d06b621..a5ba2b71d508 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4018,17 +4018,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  
>>  	trace_ext4_punch_hole(inode, offset, length, 0);
>>  
>> -	/*
>> -	 * Write out all dirty pages to avoid race conditions
>> -	 * Then release them.
>> -	 */
>> -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
>> -		ret = filemap_write_and_wait_range(mapping, offset,
>> -						   offset + length - 1);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>  	inode_lock(inode);
>>  
>>  	/* No need to punch hole beyond i_size */
>> @@ -4090,8 +4079,11 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  		ret = ext4_update_disksize_before_punch(inode, offset, length);
>>  		if (ret)
>>  			goto out_dio;
>> -		truncate_pagecache_range(inode, first_block_offset,
>> -					 last_block_offset);
>> +
>> +		ret = ext4_truncate_page_cache_block_range(inode,
>> +				first_block_offset, last_block_offset + 1);
>> +		if (ret)
>> +			goto out_dio;
>>  	}
>>  
>>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>> -- 
>> 2.46.1
>>


