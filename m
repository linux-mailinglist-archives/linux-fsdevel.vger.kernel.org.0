Return-Path: <linux-fsdevel+bounces-29638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3F97BC37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB841F254DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F0189916;
	Wed, 18 Sep 2024 12:28:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE21CD23;
	Wed, 18 Sep 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662484; cv=none; b=rkuWxgRP4Lk2oUxonWZoaHLYLfNJBz5v9bNCxpu1BwiRnWwIAUaa7p/93FvPNw3Wba9vEMdMAQ9xjqBKIIY9iyCFD8jicUbMF5Eq7dhMA+mj5qTDKMrPfPR9VxIcQ5UkHRbuY7wRnK97LoN9Kx19iJUxOn4nIuRfPvgFgCa42vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662484; c=relaxed/simple;
	bh=QnxbKsMMbpfCIGFJd6cAvTvlWOO0UshcLuYIxorHJ2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX6WjUXikuEQqNEUEdZ//66sLkcsaYEbx7lpMjnvdTheo80aYU7AL6UYtLFmtx+WhHmF6N3ONdR1wVroyv+WmT/kRXnC5P5wOSCHurt48qCZaijNuG9n4lRQM7WrlnWmcMIpWFs6E6EdTv5iqe/Mj/YtsjHOWRiOvPAlB2Nq6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X7ybH5R4rz4f3jMf;
	Wed, 18 Sep 2024 20:27:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 918EE1A092F;
	Wed, 18 Sep 2024 20:27:55 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMhJx+pm0zCuBg--.17365S3;
	Wed, 18 Sep 2024 20:27:55 +0800 (CST)
Message-ID: <a99e8a54-17ae-432f-bf11-a1e90e082c05@huaweicloud.com>
Date: Wed, 18 Sep 2024 20:27:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] ext4: write out dirty data before dropping pages
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-2-yi.zhang@huaweicloud.com>
 <20240917165007.j5dywaekvnirfffm@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240917165007.j5dywaekvnirfffm@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXTMhJx+pm0zCuBg--.17365S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1xuw1DJw1fZr15WFWrGrg_yoWfJFW3pr
	Z8KFy5KF48XayUur12yanrZF10g3sFgrWUuryfWa40934qyrn3Kan0kryruFyUArZrAr40
	vF4jqr9rWrWjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/18 0:50, Jan Kara wrote:
> On Wed 04-09-24 14:29:16, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Current zero range, punch hole and collapse range have a common
>> potential data loss problem. In general, ext4_zero_range(),
>> ext4_collapse_range() and ext4_punch_hold() will discard all page cache
>> of the operation range before converting the extents status. However,
>> the first two functions don't write back dirty data before discarding
>> page cache, and ext4_punch_hold() write back at the very beginning
>> without holding i_rwsem and mapping invalidate lock. Hence, if some bad
>> things (e.g. EIO or ENOMEM) happens just after dropping dirty page
>> cache, the operation will failed but the user's valid data in the dirty
>> page cache will be lost. Fix this by write all dirty data under i_rwsem
>> and mapping invalidate lock before discarding pages.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> I'm not sure this is the direction we want to go. When zeroing / collapsing
> / punching writing out all the data we are going to remove seems suboptimal
> and we can spend significant time doing work that is mostly unnecessary.

Yes, I agree with you that it do bring some performance sacrifices and
seems not the best solution, but at the moment, I can't find a simple and
better solution.

I've also checked some other modern disk filesystems. IIUC, it seems that
each filesystem is different when doing this 3 operations, bcachefs only do
write back before dropping pagecache when collapsing, f2fs do write back
when zeroing range and collapsing, btrfs do write back when punching and
zeroing(it doesn't support collapse), xfs do write back for all of the
three operations. So, it seems that only btrfs and xfs can survival now.

> After all with truncate we also drop pagecache pages and the do on-disk
> modification which can fail.

Yeah, right, truncate may have the same problem too, and all of the above
other 4 filesystems are the same.

> The case of EIO is in my opinion OK - when there are disk errors, we are
> going to loose data and e2fsck is needed. So protecting with writeout
> against possible damage is pointless.

Yeah, please forgive me for this not good example.

> For ENOMEM I agree we should better
> preserve filesystem consistency. Is there some case where we would keep
> filesystem inconsistent on ENOMEM?

The ENOMEM case were seldom happen on our products, so it hasn't trigger
any real problem so far. I find it when I was refactoring these fallocate
functions. Theoretically, I believe it should be a problem, but based on
current filesystems' implementation, I'm not sure if we really need to
care about it, maybe xfs and btrfs do write back because they could have
more opportunity to fail after dropping pagecache when punching/zeroing/
(collapsing), so they have to write data back?

Thanks,
Yi.

> 
>> ---
>>  fs/ext4/extents.c | 77 +++++++++++++++++------------------------------
>>  fs/ext4/inode.c   | 19 +++++-------
>>  2 files changed, 36 insertions(+), 60 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index e067f2dd0335..7d5edfa2e630 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -4602,6 +4602,24 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>>  	if (ret)
>>  		goto out_mutex;
>>  
>> +	/*
>> +	 * Prevent page faults from reinstantiating pages we have released
>> +	 * from page cache.
>> +	 */
>> +	filemap_invalidate_lock(mapping);
>> +
>> +	ret = ext4_break_layouts(inode);
>> +	if (ret)
>> +		goto out_invalidate_lock;
>> +
>> +	/*
>> +	 * Write data that will be zeroed to preserve them when successfully
>> +	 * discarding page cache below but fail to convert extents.
>> +	 */
>> +	ret = filemap_write_and_wait_range(mapping, start, end - 1);
>> +	if (ret)
>> +		goto out_invalidate_lock;
>> +
>>  	/* Preallocate the range including the unaligned edges */
>>  	if (partial_begin || partial_end) {
>>  		ret = ext4_alloc_file_blocks(file,
>> @@ -4610,7 +4628,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>>  				 round_down(offset, 1 << blkbits)) >> blkbits,
>>  				new_size, flags);
>>  		if (ret)
>> -			goto out_mutex;
>> +			goto out_invalidate_lock;
>>  
>>  	}
>>  
>> @@ -4619,37 +4637,9 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>>  		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
>>  			  EXT4_EX_NOCACHE);
>>  
>> -		/*
>> -		 * Prevent page faults from reinstantiating pages we have
>> -		 * released from page cache.
>> -		 */
>> -		filemap_invalidate_lock(mapping);
>> -
>> -		ret = ext4_break_layouts(inode);
>> -		if (ret) {
>> -			filemap_invalidate_unlock(mapping);
>> -			goto out_mutex;
>> -		}
>> -
>>  		ret = ext4_update_disksize_before_punch(inode, offset, len);
>> -		if (ret) {
>> -			filemap_invalidate_unlock(mapping);
>> -			goto out_mutex;
>> -		}
>> -
>> -		/*
>> -		 * For journalled data we need to write (and checkpoint) pages
>> -		 * before discarding page cache to avoid inconsitent data on
>> -		 * disk in case of crash before zeroing trans is committed.
>> -		 */
>> -		if (ext4_should_journal_data(inode)) {
>> -			ret = filemap_write_and_wait_range(mapping, start,
>> -							   end - 1);
>> -			if (ret) {
>> -				filemap_invalidate_unlock(mapping);
>> -				goto out_mutex;
>> -			}
>> -		}
>> +		if (ret)
>> +			goto out_invalidate_lock;
>>  
>>  		/* Now release the pages and zero block aligned part of pages */
>>  		truncate_pagecache_range(inode, start, end - 1);
>> @@ -4657,12 +4647,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>>  
>>  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
>>  					     flags);
>> -		filemap_invalidate_unlock(mapping);
>>  		if (ret)
>> -			goto out_mutex;
>> +			goto out_invalidate_lock;
>>  	}
>>  	if (!partial_begin && !partial_end)
>> -		goto out_mutex;
>> +		goto out_invalidate_lock;
>>  
>>  	/*
>>  	 * In worst case we have to writeout two nonadjacent unwritten
>> @@ -4675,7 +4664,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>>  	if (IS_ERR(handle)) {
>>  		ret = PTR_ERR(handle);
>>  		ext4_std_error(inode->i_sb, ret);
>> -		goto out_mutex;
>> +		goto out_invalidate_lock;
>>  	}
>>  
>>  	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>> @@ -4694,6 +4683,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>>  
>>  out_handle:
>>  	ext4_journal_stop(handle);
>> +out_invalidate_lock:
>> +	filemap_invalidate_unlock(mapping);
>>  out_mutex:
>>  	inode_unlock(inode);
>>  	return ret;
>> @@ -5363,20 +5354,8 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>>  	 * for page size > block size.
>>  	 */
>>  	ioffset = round_down(offset, PAGE_SIZE);
>> -	/*
>> -	 * Write tail of the last page before removed range since it will get
>> -	 * removed from the page cache below.
>> -	 */
>> -	ret = filemap_write_and_wait_range(mapping, ioffset, offset);
>> -	if (ret)
>> -		goto out_mmap;
>> -	/*
>> -	 * Write data that will be shifted to preserve them when discarding
>> -	 * page cache below. We are also protected from pages becoming dirty
>> -	 * by i_rwsem and invalidate_lock.
>> -	 */
>> -	ret = filemap_write_and_wait_range(mapping, offset + len,
>> -					   LLONG_MAX);
>> +	/* Write out all dirty pages */
>> +	ret = filemap_write_and_wait_range(mapping, ioffset, LLONG_MAX);
>>  	if (ret)
>>  		goto out_mmap;
>>  	truncate_pagecache(inode, ioffset);
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 941c1c0d5c6e..c3d7606a5315 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3957,17 +3957,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
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
>> @@ -4021,6 +4010,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  	if (ret)
>>  		goto out_dio;
>>  
>> +	/* Write out all dirty pages to avoid race conditions */
>> +	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
>> +		ret = filemap_write_and_wait_range(mapping, offset,
>> +						   offset + length - 1);
>> +		if (ret)
>> +			goto out_dio;
>> +	}
>> +
>>  	first_block_offset = round_up(offset, sb->s_blocksize);
>>  	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
>>  
>> -- 
>> 2.39.2
>>


