Return-Path: <linux-fsdevel+bounces-25585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B810294DA8F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 06:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77D01C219C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 04:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABA213B592;
	Sat, 10 Aug 2024 04:01:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B21FDD;
	Sat, 10 Aug 2024 04:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723262497; cv=none; b=hbE0osm30Im26QBahy3xyINYCysa9glwlYDMWOGE7FEQd+bhqWxAuP+LNwsOHlJCEDBYD6SVdnaBKwbxbEm5Qi4fgx5k6jp3ez9m4d6JtuF+L2Esmg1vEYtDlxfHEWvYv8MCcf0pDJCwNKSvgyudoH0O96tJ6jTbxlLLKM7y0vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723262497; c=relaxed/simple;
	bh=YOlRbOcCiL7cuUSlHsIqsz7g3qu4gdisg6LvYPh3ndU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VuK0gvh4/M36ofAuq1Z/F1qLX7VQaAHaGUTTKtfePoVPa3GWZGe5bBe4oARZw2VbBfhUk5EurJwACgJYhQjB3D7cNbrwsMwucySo+I/+j/2yukIqd6OqcDyl3kVSxQEI1GHRH0CHPI0+xkBBsksMzHyjIIPDbQ8ASgFW+GJaCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WgnC127Dxz4f3jrx;
	Sat, 10 Aug 2024 12:01:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C74841A1356;
	Sat, 10 Aug 2024 12:01:30 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UZ5rZmoskSBQ--.6322S3;
	Sat, 10 Aug 2024 12:01:30 +0800 (CST)
Subject: Re: [PATCH v2 06/10] ext4: update delalloc data reserve spcae in
 ext4_es_insert_extent()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-7-yi.zhang@huaweicloud.com>
 <20240807174108.l2bbbhlnpznztp34@quack3>
 <a23023f6-93cc-584d-c55a-9f8395e360ae@huaweicloud.com>
 <20240808183619.vmxttspcs5ngm6g3@quack3>
 <d6b8ed3c-82a7-6344-bdb9-8c18b1f526ca@huaweicloud.com>
 <20240809162013.tieom26umwqcsfe4@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <5dcb2dc2-7622-05bd-d330-610e9c009fe2@huaweicloud.com>
Date: Sat, 10 Aug 2024 12:01:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240809162013.tieom26umwqcsfe4@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHr4UZ5rZmoskSBQ--.6322S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry5Xw1fZrW3Ar47tFyrWFg_yoWfJFyUpF
	W5CF15Kw15Jr1UCrZIqw15Xr1S9w4DJF4UXrZIqry8ZF98tF1fWFnrJF45uFZ29r4xJFn8
	XFy5C347uF98Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/10 0:20, Jan Kara wrote:
> On Fri 09-08-24 11:35:49, Zhang Yi wrote:
>> On 2024/8/9 2:36, Jan Kara wrote:
>>> On Thu 08-08-24 19:18:30, Zhang Yi wrote:
>>>> On 2024/8/8 1:41, Jan Kara wrote:
>>>>> On Fri 02-08-24 19:51:16, Zhang Yi wrote:
>>>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>>>
>>>>>> Now that we update data reserved space for delalloc after allocating
>>>>>> new blocks in ext4_{ind|ext}_map_blocks(), and if bigalloc feature is
>>>>>> enabled, we also need to query the extents_status tree to calculate the
>>>>>> exact reserved clusters. This is complicated now and it appears that
>>>>>> it's better to do this job in ext4_es_insert_extent(), because
>>>>>> __es_remove_extent() have already count delalloc blocks when removing
>>>>>> delalloc extents and __revise_pending() return new adding pending count,
>>>>>> we could update the reserved blocks easily in ext4_es_insert_extent().
>>>>>>
>>>>>> Thers is one special case needs to concern is the quota claiming, when
>>>>>> bigalloc is enabled, if the delayed cluster allocation has been raced
>>>>>> by another no-delayed allocation(e.g. from fallocate) which doesn't
>>>>>> cover the delayed blocks:
>>>>>>
>>>>>>   |<       one cluster       >|
>>>>>>   hhhhhhhhhhhhhhhhhhhdddddddddd
>>>>>>   ^            ^
>>>>>>   |<          >| < fallocate this range, don't claim quota again
>>>>>>
>>>>>> We can't claim quota as usual because the fallocate has already claimed
>>>>>> it in ext4_mb_new_blocks(), we could notice this case through the
>>>>>> removed delalloc blocks count.
>>>>>>
>>>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>>> ...
>>>>>> @@ -926,9 +928,27 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>>>>>  			__free_pending(pr);
>>>>>>  			pr = NULL;
>>>>>>  		}
>>>>>> +		pending = err3;
>>>>>>  	}
>>>>>>  error:
>>>>>>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>>>>>> +	/*
>>>>>> +	 * Reduce the reserved cluster count to reflect successful deferred
>>>>>> +	 * allocation of delayed allocated clusters or direct allocation of
>>>>>> +	 * clusters discovered to be delayed allocated.  Once allocated, a
>>>>>> +	 * cluster is not included in the reserved count.
>>>>>> +	 *
>>>>>> +	 * When bigalloc is enabled, allocating non-delayed allocated blocks
>>>>>> +	 * which belong to delayed allocated clusters (from fallocate, filemap,
>>>>>> +	 * DIO, or clusters allocated when delalloc has been disabled by
>>>>>> +	 * ext4_nonda_switch()). Quota has been claimed by ext4_mb_new_blocks(),
>>>>>> +	 * so release the quota reservations made for any previously delayed
>>>>>> +	 * allocated clusters.
>>>>>> +	 */
>>>>>> +	resv_used = rinfo.delonly_cluster + pending;
>>>>>> +	if (resv_used)
>>>>>> +		ext4_da_update_reserve_space(inode, resv_used,
>>>>>> +					     rinfo.delonly_block);
>>>>>
>>>>> I'm not sure I understand here. We are inserting extent into extent status
>>>>> tree. We are replacing resv_used clusters worth of space with delayed
>>>>> allocation reservation with normally allocated clusters so we need to
>>>>> release the reservation (mballoc already reduced freeclusters counter).
>>>>> That I understand. In normal case we should also claim quota because we are
>>>>> converting from reserved into allocated state. Now if we allocated blocks
>>>>> under this range (e.g. from fallocate()) without
>>>>> EXT4_GET_BLOCKS_DELALLOC_RESERVE, we need to release quota reservation here
>>>>> instead of claiming it. But I fail to see how rinfo.delonly_block > 0 is
>>>>> related to whether EXT4_GET_BLOCKS_DELALLOC_RESERVE was set when allocating
>>>>> blocks for this extent or not.
>>>>
>>>> Oh, this is really complicated due to the bigalloc feature, please let me
>>>> explain it more clearly by listing all related situations.
>>>>
>>>> There are 2 types of paths of allocating delayed/reserved cluster:
>>>> 1. Normal case, normally allocate delayed clusters from the write back path.
>>>> 2. Special case, allocate blocks under this delayed range, e.g. from
>>>>    fallocate().
>>>>
>>>> There are 4 situations below:
>>>>
>>>> A. bigalloc is disabled. This case is simple, after path 2, we don't need
>>>>    to distinguish path 1 and 2, when calling ext4_es_insert_extent(), we
>>>>    set EXT4_GET_BLOCKS_DELALLOC_RESERVE after EXT4_MAP_DELAYED bit is
>>>>    detected. If the flag is set, we must be replacing a delayed extent and
>>>>    rinfo.delonly_block must be > 0. So rinfo.delonly_block > 0 is equal
>>>>    to set EXT4_GET_BLOCKS_DELALLOC_RESERVE.
>>>
>>> Right. So fallocate() will call ext4_map_blocks() and
>>> ext4_es_lookup_extent() will find delayed extent and set EXT4_MAP_DELAYED
>>> which you (due to patch 2 of this series) transform into
>>> EXT4_GET_BLOCKS_DELALLOC_RESERVE. We used to update the delalloc
>>> accounting through in ext4_ext_map_blocks() but this patch moved the update
>>> to ext4_es_insert_extent(). But there is one cornercase even here AFAICT:
>>>
>>> Suppose fallocate is called for range 0..16k, we have delalloc extent at
>>> 8k..16k. In this case ext4_map_blocks() at block 0 will not find the
>>> delalloc extent but ext4_ext_map_blocks() will allocate 16k from mballoc
>>> without using delalloc reservation but then ext4_es_insert_extent() will
>>> still have rinfo.delonly_block > 0 so we claim the quota reservation
>>> instead of releasing it?
>>>
>>
>> After commit 6430dea07e85 ("ext4: correct the hole length returned by
>> ext4_map_blocks()"), the fallocate range 0-16K would be divided into two
>> rounds. When we first calling ext4_map_blocks() with 0-16K, the map range
>> will be corrected to 0-8k by ext4_ext_determine_insert_hole() and the
>> allocating range should not cover any delayed range.
> 
> Eww, subtle, subtle, subtle... And isn't this also racy? We drop i_data_sem
> in ext4_map_blocks() after we do the initial lookup. So there can be some
> changes to both the extent tree and extent status tree before we grab
> i_data_sem again for the allocation. We hold inode_lock so there can be
> only writeback and page faults racing with us but e.g. ext4_page_mkwrite()
> -> block_page_mkwrite -> ext4_da_get_block_prep() -> ext4_da_map_blocks()
> can add delayed extent into extent status tree in that window causing
> breakage, can't it?

Oh! you are totally right, I missed that current ext4_fallocate() doesn't
hold invalidate_lock for the normal fallocate path, hence there's nothing
could prevent this race now, thanks a lot for pointing this out.

> 
>> Then
>> ext4_alloc_file_blocks() will call ext4_map_blocks() again to allocate
>> 8K-16K in the second round, in this round, we are allocating a real
>> delayed range. Please below graph for details,
>>
>> ext4_alloc_file_blocks() //0-16K
>>  ext4_map_blocks()  //0-16K
>>   ext4_es_lookup_extent() //find nothing
>>    ext4_ext_map_blocks(0)
>>     ext4_ext_determine_insert_hole() //change map range to 0-8K
>>    ext4_ext_map_blocks(EXT4_GET_BLOCKS_CREATE) //allocate blocks under hole
>>  ext4_map_blocks()  //8-16K
>>   ext4_es_lookup_extent() //find delayed extent
>>   ext4_ext_map_blocks(EXT4_GET_BLOCKS_CREATE)
>>     //allocate blocks under a whole delayed range,
>>     //use rinfo.delonly_block > 0 is okay
>>
>> Hence the allocating range can't mixed with delayed and non-delayed extent
>> at a time, and the rinfo.delonly_block > 0 should work.
> 
> Besides the race above I agree. So either we need to trim mapping extent in
> ext4_map_blocks() after re-acquiring i_data_sem

Yeah, if we keep on using this solution, it looks like we have to add similar
logic we've done in ext4_da_map_blocks() a few months ago into the begin of
the new helper ext4_map_create_blocks(). I guess it may expensive and not
worth now.

	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
		map->m_len = min_t(unsigned int, map->m_len,
				   es.es_len - (map->m_lblk - es.es_lblk));
	} else
		retval = ext4_map_query_blocks(NULL, inode, map);
		...
	}

> or we need to deal with
> unwritten extents that are partially delalloc. I'm more and more leaning
> towards just passing the information whether delalloc was used or not to
> extent status tree insertion. Because that can deal with partial extents
> just fine...
> 

Yeah, I agree with you, passing the information to ext4_es_init_extent()
is simple and looks fine. I will change to use this solution.

> Thanks for your patience with me :).
> 

Anytime! I appreciate your review and suggestions as well. :)

Thanks,
Yi.


