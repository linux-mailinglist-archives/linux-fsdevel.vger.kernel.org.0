Return-Path: <linux-fsdevel+bounces-25500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68FE94C8E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 05:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7DB2870EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 03:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B1118EA2;
	Fri,  9 Aug 2024 03:35:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448728E7;
	Fri,  9 Aug 2024 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723174558; cv=none; b=coWbHZWFMXcFladQWS4p245HO640UlIv2+ruj8I151fg4awt7NrCOtaBk0Sqbgp9KQpZQK/42vXkwtkgkG2uisM0HnfxZ9j0mAtcicgxlIHi6jQjv2zDJwsgx1V0FsDy+b3VzGHWzSn+zxs41uUjLpbSdeJ6y8NEGp5D/g6YkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723174558; c=relaxed/simple;
	bh=ib8wUqk2OXKpIuu3/m0t2PwjSJ0DL1sy2nsSPF7pCa0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ej/xqgtK8Pg6xzRx22BJmUWLjK6oEhhxNq2bKbU3HSBZkVKFudxri3l0YvRnk9mmzfLRpJWciwQYLO7aNisKTkh2p9uf0eu6AmGyyLGAGLqIYESq//6eSXZIVaZqk0dTmOLI/8UK/8w+YUnLAWEUiKLrCtophDoTLl0VopYvamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wg8gt2qDGz4f3jXV;
	Fri,  9 Aug 2024 11:35:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D005D1A07B6;
	Fri,  9 Aug 2024 11:35:51 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXfoSVjrVmSIeyBA--.26518S3;
	Fri, 09 Aug 2024 11:35:51 +0800 (CST)
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
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <d6b8ed3c-82a7-6344-bdb9-8c18b1f526ca@huaweicloud.com>
Date: Fri, 9 Aug 2024 11:35:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240808183619.vmxttspcs5ngm6g3@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXfoSVjrVmSIeyBA--.26518S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF43Xw18Zr18WFy5Kr1DGFg_yoW3CF18pr
	WqkF1ftw15Wr17CrZIvw43Xr1Sga1kJF4UJrZYqry0vF98JF1fWF9rJF45uFZ2krs7JFn8
	XFy5Ca47uF90ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2024/8/9 2:36, Jan Kara wrote:
> On Thu 08-08-24 19:18:30, Zhang Yi wrote:
>> On 2024/8/8 1:41, Jan Kara wrote:
>>> On Fri 02-08-24 19:51:16, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> Now that we update data reserved space for delalloc after allocating
>>>> new blocks in ext4_{ind|ext}_map_blocks(), and if bigalloc feature is
>>>> enabled, we also need to query the extents_status tree to calculate the
>>>> exact reserved clusters. This is complicated now and it appears that
>>>> it's better to do this job in ext4_es_insert_extent(), because
>>>> __es_remove_extent() have already count delalloc blocks when removing
>>>> delalloc extents and __revise_pending() return new adding pending count,
>>>> we could update the reserved blocks easily in ext4_es_insert_extent().
>>>>
>>>> Thers is one special case needs to concern is the quota claiming, when
>>>> bigalloc is enabled, if the delayed cluster allocation has been raced
>>>> by another no-delayed allocation(e.g. from fallocate) which doesn't
>>>> cover the delayed blocks:
>>>>
>>>>   |<       one cluster       >|
>>>>   hhhhhhhhhhhhhhhhhhhdddddddddd
>>>>   ^            ^
>>>>   |<          >| < fallocate this range, don't claim quota again
>>>>
>>>> We can't claim quota as usual because the fallocate has already claimed
>>>> it in ext4_mb_new_blocks(), we could notice this case through the
>>>> removed delalloc blocks count.
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>> ...
>>>> @@ -926,9 +928,27 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>>>  			__free_pending(pr);
>>>>  			pr = NULL;
>>>>  		}
>>>> +		pending = err3;
>>>>  	}
>>>>  error:
>>>>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>>>> +	/*
>>>> +	 * Reduce the reserved cluster count to reflect successful deferred
>>>> +	 * allocation of delayed allocated clusters or direct allocation of
>>>> +	 * clusters discovered to be delayed allocated.  Once allocated, a
>>>> +	 * cluster is not included in the reserved count.
>>>> +	 *
>>>> +	 * When bigalloc is enabled, allocating non-delayed allocated blocks
>>>> +	 * which belong to delayed allocated clusters (from fallocate, filemap,
>>>> +	 * DIO, or clusters allocated when delalloc has been disabled by
>>>> +	 * ext4_nonda_switch()). Quota has been claimed by ext4_mb_new_blocks(),
>>>> +	 * so release the quota reservations made for any previously delayed
>>>> +	 * allocated clusters.
>>>> +	 */
>>>> +	resv_used = rinfo.delonly_cluster + pending;
>>>> +	if (resv_used)
>>>> +		ext4_da_update_reserve_space(inode, resv_used,
>>>> +					     rinfo.delonly_block);
>>>
>>> I'm not sure I understand here. We are inserting extent into extent status
>>> tree. We are replacing resv_used clusters worth of space with delayed
>>> allocation reservation with normally allocated clusters so we need to
>>> release the reservation (mballoc already reduced freeclusters counter).
>>> That I understand. In normal case we should also claim quota because we are
>>> converting from reserved into allocated state. Now if we allocated blocks
>>> under this range (e.g. from fallocate()) without
>>> EXT4_GET_BLOCKS_DELALLOC_RESERVE, we need to release quota reservation here
>>> instead of claiming it. But I fail to see how rinfo.delonly_block > 0 is
>>> related to whether EXT4_GET_BLOCKS_DELALLOC_RESERVE was set when allocating
>>> blocks for this extent or not.
>>
>> Oh, this is really complicated due to the bigalloc feature, please let me
>> explain it more clearly by listing all related situations.
>>
>> There are 2 types of paths of allocating delayed/reserved cluster:
>> 1. Normal case, normally allocate delayed clusters from the write back path.
>> 2. Special case, allocate blocks under this delayed range, e.g. from
>>    fallocate().
>>
>> There are 4 situations below:
>>
>> A. bigalloc is disabled. This case is simple, after path 2, we don't need
>>    to distinguish path 1 and 2, when calling ext4_es_insert_extent(), we
>>    set EXT4_GET_BLOCKS_DELALLOC_RESERVE after EXT4_MAP_DELAYED bit is
>>    detected. If the flag is set, we must be replacing a delayed extent and
>>    rinfo.delonly_block must be > 0. So rinfo.delonly_block > 0 is equal
>>    to set EXT4_GET_BLOCKS_DELALLOC_RESERVE.
> 
> Right. So fallocate() will call ext4_map_blocks() and
> ext4_es_lookup_extent() will find delayed extent and set EXT4_MAP_DELAYED
> which you (due to patch 2 of this series) transform into
> EXT4_GET_BLOCKS_DELALLOC_RESERVE. We used to update the delalloc
> accounting through in ext4_ext_map_blocks() but this patch moved the update
> to ext4_es_insert_extent(). But there is one cornercase even here AFAICT:
> 
> Suppose fallocate is called for range 0..16k, we have delalloc extent at
> 8k..16k. In this case ext4_map_blocks() at block 0 will not find the
> delalloc extent but ext4_ext_map_blocks() will allocate 16k from mballoc
> without using delalloc reservation but then ext4_es_insert_extent() will
> still have rinfo.delonly_block > 0 so we claim the quota reservation
> instead of releasing it?
> 

After commit 6430dea07e85 ("ext4: correct the hole length returned by
ext4_map_blocks()"), the fallocate range 0-16K would be divided into two
rounds. When we first calling ext4_map_blocks() with 0-16K, the map range
will be corrected to 0-8k by ext4_ext_determine_insert_hole() and the
allocating range should not cover any delayed range. Then
ext4_alloc_file_blocks() will call ext4_map_blocks() again to allocate
8K-16K in the second round, in this round, we are allocating a real
delayed range. Please below graph for details,

ext4_alloc_file_blocks() //0-16K
 ext4_map_blocks()  //0-16K
  ext4_es_lookup_extent() //find nothing
   ext4_ext_map_blocks(0)
    ext4_ext_determine_insert_hole() //change map range to 0-8K
   ext4_ext_map_blocks(EXT4_GET_BLOCKS_CREATE) //allocate blocks under hole
 ext4_map_blocks()  //8-16K
  ext4_es_lookup_extent() //find delayed extent
  ext4_ext_map_blocks(EXT4_GET_BLOCKS_CREATE)
    //allocate blocks under a whole delayed range,
    //use rinfo.delonly_block > 0 is okay

Hence the allocating range can't mixed with delayed and non-delayed extent
at a time, and the rinfo.delonly_block > 0 should work.

>> B. bigalloc is enabled, there a 3 sub-cases of allocating a delayed
>>    cluster:
>> B0.Allocating a whole delayed cluster, this case is the same to A.
>>
>>      |<         one cluster       >|
>>      ddddddd+ddddddd+ddddddd+ddddddd
>>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ allocating the whole range
> 
> I agree. In this case there's no difference.
> 
>  
>> B1.Allocating delayed blocks in a reserved cluster, this case is the same
>>    to A, too.
>>
>>      |<         one cluster       >|
>>      hhhhhhh+hhhhhhh+ddddddd+ddddddd
>>                              ^^^^^^^
>>                              allocating this range
> 
> Yes, if the allocation starts within delalloc range, we will have
> EXT4_GET_BLOCKS_DELALLOC_RESERVE set and ndelonly_blocks will always be >
> 0.
> 
>> B2.Allocating blocks which doesn't cover the delayed blocks in one reserved
>>    cluster,
>>
>>      |<         one cluster       >|
>>      hhhhhhh+hhhhhhh+hhhhhhh+ddddddd
>>      ^^^^^^^
>>      fallocating this range
>>
>>   This case must from path 2, which means allocating blocks without
>>   EXT4_GET_BLOCKS_DELALLOC_RESERVE. In this case, rinfo.delonly_block must
>>   be 0 since we are not replacing any delayed extents, so
>>   rinfo.delonly_block == 0 means allocate blocks without EXT4_MAP_DELAYED
>>   detected, which further means that EXT4_GET_BLOCKS_DELALLOC_RESERVE is
>>   not set. So I think we could use rinfo.delonly_block to identify this
>>   case.
> 
> Well, this is similar to the non-bigalloc case I was asking about above.
> Why the allocated unwritten extent cannot extend past the start of delalloc
> extent? I didn't find anything that would disallow that...
> 

The same to above, ext4_ext_determine_insert_hole() should work fine for
this case.

Thanks,
Yi.


