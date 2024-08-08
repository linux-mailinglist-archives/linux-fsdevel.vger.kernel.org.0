Return-Path: <linux-fsdevel+bounces-25411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4094BC1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 13:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2BEB216D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C2518B49B;
	Thu,  8 Aug 2024 11:18:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC3318B474;
	Thu,  8 Aug 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115920; cv=none; b=fvcwEwtgJBc9XVmrDde8sm41coU9iTvR41KKUQOi4Iagg98z95YaxM6C9YO+jztkAB4oe5mPgCg3wdbD0Ty6H/VWSqVUV7bbAo56Av4YUGmnd6e75Ksqqm9VWUvuWSsKaK3vr+DjHW7fLa7ua31KTIYBNT/dET198MzEMTD5Z18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115920; c=relaxed/simple;
	bh=YwjPmUk2cQyBCcP9PSXazsu7a2NRfKnC/bhbHcEIll4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PJzaAK2E+8DWQ6JcMQBt207+l9n7FzuZN+2fDMNWFrX5tGj6be9ORRvUxnq38TfO20IAC4ymVK+PZN19IteZAgtclPgXB4K8r5QSmyF+Xa5cCyQumFtBgkbtop1xfn9GEVkTupICz/mgyC6Hy4QiIgP9yfYiINHJWbNZOUBQuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wfl09710bz4f3l13;
	Thu,  8 Aug 2024 19:18:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5AE8C1A058E;
	Thu,  8 Aug 2024 19:18:32 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB37IKGqbRm25BzBA--.64659S3;
	Thu, 08 Aug 2024 19:18:32 +0800 (CST)
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
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <a23023f6-93cc-584d-c55a-9f8395e360ae@huaweicloud.com>
Date: Thu, 8 Aug 2024 19:18:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240807174108.l2bbbhlnpznztp34@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB37IKGqbRm25BzBA--.64659S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1xJF4Uur4rXr1xWw18Grg_yoWxJryrpr
	Z5CFyfJ3WUXrnrtrs3Zw43WrWSgws5tF4UGrsYq348ZFZ8JFn3WF9rtF45uFZ7Crs5JFn8
	Xry5u3s7uFyDCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/8 1:41, Jan Kara wrote:
> On Fri 02-08-24 19:51:16, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Now that we update data reserved space for delalloc after allocating
>> new blocks in ext4_{ind|ext}_map_blocks(), and if bigalloc feature is
>> enabled, we also need to query the extents_status tree to calculate the
>> exact reserved clusters. This is complicated now and it appears that
>> it's better to do this job in ext4_es_insert_extent(), because
>> __es_remove_extent() have already count delalloc blocks when removing
>> delalloc extents and __revise_pending() return new adding pending count,
>> we could update the reserved blocks easily in ext4_es_insert_extent().
>>
>> Thers is one special case needs to concern is the quota claiming, when
>> bigalloc is enabled, if the delayed cluster allocation has been raced
>> by another no-delayed allocation(e.g. from fallocate) which doesn't
>> cover the delayed blocks:
>>
>>   |<       one cluster       >|
>>   hhhhhhhhhhhhhhhhhhhdddddddddd
>>   ^            ^
>>   |<          >| < fallocate this range, don't claim quota again
>>
>> We can't claim quota as usual because the fallocate has already claimed
>> it in ext4_mb_new_blocks(), we could notice this case through the
>> removed delalloc blocks count.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ...
>> @@ -926,9 +928,27 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>  			__free_pending(pr);
>>  			pr = NULL;
>>  		}
>> +		pending = err3;
>>  	}
>>  error:
>>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>> +	/*
>> +	 * Reduce the reserved cluster count to reflect successful deferred
>> +	 * allocation of delayed allocated clusters or direct allocation of
>> +	 * clusters discovered to be delayed allocated.  Once allocated, a
>> +	 * cluster is not included in the reserved count.
>> +	 *
>> +	 * When bigalloc is enabled, allocating non-delayed allocated blocks
>> +	 * which belong to delayed allocated clusters (from fallocate, filemap,
>> +	 * DIO, or clusters allocated when delalloc has been disabled by
>> +	 * ext4_nonda_switch()). Quota has been claimed by ext4_mb_new_blocks(),
>> +	 * so release the quota reservations made for any previously delayed
>> +	 * allocated clusters.
>> +	 */
>> +	resv_used = rinfo.delonly_cluster + pending;
>> +	if (resv_used)
>> +		ext4_da_update_reserve_space(inode, resv_used,
>> +					     rinfo.delonly_block);
> 
> I'm not sure I understand here. We are inserting extent into extent status
> tree. We are replacing resv_used clusters worth of space with delayed
> allocation reservation with normally allocated clusters so we need to
> release the reservation (mballoc already reduced freeclusters counter).
> That I understand. In normal case we should also claim quota because we are
> converting from reserved into allocated state. Now if we allocated blocks
> under this range (e.g. from fallocate()) without
> EXT4_GET_BLOCKS_DELALLOC_RESERVE, we need to release quota reservation here
> instead of claiming it. But I fail to see how rinfo.delonly_block > 0 is
> related to whether EXT4_GET_BLOCKS_DELALLOC_RESERVE was set when allocating
> blocks for this extent or not.
> 

Oh, this is really complicated due to the bigalloc feature, please let me
explain it more clearly by listing all related situations.

There are 2 types of paths of allocating delayed/reserved cluster:
1. Normal case, normally allocate delayed clusters from the write back path.
2. Special case, allocate blocks under this delayed range, e.g. from
   fallocate().

There are 4 situations below:

A. bigalloc is disabled. This case is simple, after path 2, we don't need
   to distinguish path 1 and 2, when calling ext4_es_insert_extent(), we
   set EXT4_GET_BLOCKS_DELALLOC_RESERVE after EXT4_MAP_DELAYED bit is
   detected. If the flag is set, we must be replacing a delayed extent and
   rinfo.delonly_block must be > 0. So rinfo.delonly_block > 0 is equal
   to set EXT4_GET_BLOCKS_DELALLOC_RESERVE.

B. bigalloc is enabled, there a 3 sub-cases of allocating a delayed
   cluster:
B0.Allocating a whole delayed cluster, this case is the same to A.

     |<         one cluster       >|
     ddddddd+ddddddd+ddddddd+ddddddd
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ allocating the whole range

B1.Allocating delayed blocks in a reserved cluster, this case is the same
   to A, too.

     |<         one cluster       >|
     hhhhhhh+hhhhhhh+ddddddd+ddddddd
                             ^^^^^^^
                             allocating this range

B2.Allocating blocks which doesn't cover the delayed blocks in one reserved
   cluster,

     |<         one cluster       >|
     hhhhhhh+hhhhhhh+hhhhhhh+ddddddd
     ^^^^^^^
     fallocating this range

  This case must from path 2, which means allocating blocks without
  EXT4_GET_BLOCKS_DELALLOC_RESERVE. In this case, rinfo.delonly_block must
  be 0 since we are not replacing any delayed extents, so
  rinfo.delonly_block == 0 means allocate blocks without EXT4_MAP_DELAYED
  detected, which further means that EXT4_GET_BLOCKS_DELALLOC_RESERVE is
  not set. So I think we could use rinfo.delonly_block to identify this
  case.

As the cases listed above, I think we could use rinfo.delonly_block to
determine whether the EXT4_GET_BLOCKS_DELALLOC_RESERVE is set, so I use it
to determine if we need to claim quota or release quota.

> At this point it would seem much clearer if we passed flag to
> ext4_es_insert_extent() whether EXT4_GET_BLOCKS_DELALLOC_RESERVE was set
> when allocating extent or not instead of computing delonly_block and
> somehow infering from that. But maybe I miss some obvious reason why that
> is correct.
> 

Yeah, I agree that infer from computing delonly_block is little obscure
and not clear enough, passing a flag is a clearer solution, but we have
to pass one more parameter to ext4_es_insert_extent() which could only be
set or not set in the allocating path in ext4_map_create_blocks(), other
5 callers don't care about it (so they should always have no
EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set theoretically).

I have no strong feeling of which one is better, which one do you perfer
after reading my explanation above?

Thanks,
Yi.


