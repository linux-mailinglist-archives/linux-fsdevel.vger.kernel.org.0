Return-Path: <linux-fsdevel+bounces-25294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A160994A799
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C6281169
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827AC1E4F1C;
	Wed,  7 Aug 2024 12:18:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B91C6880;
	Wed,  7 Aug 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033108; cv=none; b=mixl6j1DOFMKddpE+ITwz1hfRPAh5KvA0Ox6nog4U36oAZ/Zb0PpPw6d/yljD/GleqbKhg0aPFkD5lFlK+keggDL/cWya53AgH4iwLOzWXupen2z2TRYCjLFQidSTTFZJurGZTSU3exBipHZLFR+lAT/ZriqGAxMqEoqjZy8jS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033108; c=relaxed/simple;
	bh=AP4rbMbRZn32pcJB0YS/Lu1lnbVzzDIy5mY/CNRCtjQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=midDHcyFYA8yEdihBzuc0U3ejUjozBaUVv1DLdAda5RBILpWYHQr7FHs4+DQ8ET7aj1cIuZS96v4v0RiV7skHEKJaiANKavDZ5HZR/80g1dWMgWluPfsYyRuBFwKrBTEYDhn/dfsLIf38S4PMdGfhFyEPLmZvxzl7b1yM46+S8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wf8Md71Wqz4f3kvs;
	Wed,  7 Aug 2024 20:18:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 50BFB1A12EB;
	Wed,  7 Aug 2024 20:18:20 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UKZrNm9g8ZBA--.25468S3;
	Wed, 07 Aug 2024 20:18:20 +0800 (CST)
Subject: Re: [PATCH v2 03/10] ext4: don't set EXTENT_STATUS_DELAYED on
 allocated blocks
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-4-yi.zhang@huaweicloud.com>
 <20240806152327.td572f7elpel4aeo@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <685055bc-0d56-6cf3-7716-f27e448c8c38@huaweicloud.com>
Date: Wed, 7 Aug 2024 20:18:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240806152327.td572f7elpel4aeo@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHr4UKZrNm9g8ZBA--.25468S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF48Zw4kKr4kJFWDKF1ftFb_yoW5ur47pr
	WxCr1rGa18Xw1UuayIvw4xWr1F9a10krWUCF409ry5Xa1rGryS9F1UJFWjgFWqgrWIyF1F
	qFW5u3s7CayfCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/6 23:23, Jan Kara wrote:
> On Fri 02-08-24 19:51:13, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Since we always set EXT4_GET_BLOCKS_DELALLOC_RESERVE when allocating
>> delalloc blocks, there is no need to keep delayed flag on the unwritten
>> extent status entry, so just drop it after allocation.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Let me improve the changelog because I was confused for some time before I
> understood:
> 
> Currently, we release delayed allocation reservation when removing delayed
> extent from extent status tree (which also happens when overwriting one
> extent with another one). When we allocated unwritten extent under
> some delayed allocated extent, we don't need the reservation anymore and
> hence we don't need to preserve the EXT4_MAP_DELAYED status bit. Inserting
> the new extent into extent status tree will properly release the
> reservation.
> 

Thanks for your review and change log improvement. My original idea was very
simple, after patch 2, we always set EXT4_GET_BLOCKS_DELALLOC_RESERVE when
allocating blocks for delalloc extent, these two conditions in the 'if'
branch can never be true at the same time, so they become dead code and I
dropped them.

	if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
	    ext4_es_scan_range(inode, &ext4_es_is_delayed, ...)

But after thinking your change log, I agree with you that we have already
properly update the reservation by searching delayed blocks through
ext4_es_delayed_clu() in ext4_ext_map_blocks() when we allocated unwritten
extent under some delayed allocated extent even it's not from the write
back path, so I think we can also drop them even without patch 2. But just
one point, I think the last last sentence isn't exactly true before path 6,
should it be "Allocating the new extent blocks will properly release the
reservation." now ?

Thanks,
Yi.

> Otherwise feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
> 
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 91b2610a6dc5..e9ce1e4e6acb 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -558,12 +558,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>>  
>>  	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>>  			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>> -	if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
>> -	    !(status & EXTENT_STATUS_WRITTEN) &&
>> -	    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
>> -			       map->m_lblk + map->m_len - 1))
>> -		status |= EXTENT_STATUS_DELAYED;
>> -
>>  	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
>>  			      map->m_pblk, status);
>>  
>> @@ -682,11 +676,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>  
>>  		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>>  				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>> -		if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
>> -		    !(status & EXTENT_STATUS_WRITTEN) &&
>> -		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
>> -				       map->m_lblk + map->m_len - 1))
>> -			status |= EXTENT_STATUS_DELAYED;
>>  		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
>>  				      map->m_pblk, status);
>>  	}
>> -- 
>> 2.39.2
>>


