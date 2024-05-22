Return-Path: <linux-fsdevel+bounces-19948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87758CB8B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 03:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3933F1F23C16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 01:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1B2DDBD;
	Wed, 22 May 2024 01:57:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04528EA;
	Wed, 22 May 2024 01:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716343045; cv=none; b=YxoR//Y2Bp8uoa/Epmfrz5y2Nh1ofL/2nHDTZv8Mbqv7Q8oQQ69uropyOC1n5E7Zh/ARMF4fuoS7R9e0iVI9BnP+/TwIaIwgLwJMizoleQ/F3Wv1d8bsdLXyKVh3YUoDpK358fpFt2A/E60iS3ndkll9Ylsk+ahetr4ptnraMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716343045; c=relaxed/simple;
	bh=xHf9C7VC9Cn5nDtbZqifMKKp/pMcFa4oDvkZBX+9g5U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=olH3OWTA3hLFXxKnhQSWBFJNO131t/j98ERPoKbh0aSNYN4XnJaGc8wXzZXiJrIA7Wz0ekQ3Mtv2DxyyK1clxH3I6KpycXLcV25X8p+Hh3L38yK0btjdAeR0hmmG9oqkjWkydKbeD6nEOW9LLP8ucdiasWp0G/RSazbNDS95TSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VkZDh3gnfz4f3jcy;
	Wed, 22 May 2024 09:57:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6ED461A01B9;
	Wed, 22 May 2024 09:57:17 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBHaw75UE1moSigNg--.25797S3;
	Wed, 22 May 2024 09:57:15 +0800 (CST)
Subject: Re: [PATCH v3 3/3] xfs: correct the zeroing truncate range
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, djwong@kernel.org,
 hch@infradead.org, brauner@kernel.org, chandanbabu@kernel.org, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-4-yi.zhang@huaweicloud.com>
 <ZkwJJuFCV+WQLl40@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <122ab6ed-147b-517c-148d-7cb35f7f888b@huaweicloud.com>
Date: Wed, 22 May 2024 09:57:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZkwJJuFCV+WQLl40@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHaw75UE1moSigNg--.25797S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1Dtry5Wr43ur48Cr48JFb_yoWxuryxpF
	WrK3W5Cr4Dt34Ivrn7ZF1qq3WFyw4rAF4IkryfJr42vwn8Xr1xtr9FgFWFg3yqkrs3Gr4j
	vF4Ut397u3Z5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/21 10:38, Dave Chinner wrote:
> On Fri, May 17, 2024 at 07:13:55PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When truncating a realtime file unaligned to a shorter size,
>> xfs_setattr_size() only flush the EOF page before zeroing out, and
>> xfs_truncate_page() also only zeros the EOF block. This could expose
>> stale data since 943bc0882ceb ("iomap: don't increase i_size if it's not
>> a write operation").
>>
>> If the sb_rextsize is bigger than one block, and we have a realtime
>> inode that contains a long enough written extent. If we unaligned
>> truncate into the middle of this extent, xfs_itruncate_extents() could
>> split the extent and align the it's tail to sb_rextsize, there maybe
>> have more than one blocks more between the end of the file. Since
>> xfs_truncate_page() only zeros the trailing portion of the i_blocksize()
>> value, so it may leftover some blocks contains stale data that could be
>> exposed if we append write it over a long enough distance later.
>>
>> xfs_truncate_page() should flush, zeros out the entire rtextsize range,
>> and make sure the entire zeroed range have been flushed to disk before
>> updating the inode size.
>>
>> Fixes: 943bc0882ceb ("iomap: don't increase i_size if it's not a write operation")
>> Reported-by: Chandan Babu R <chandanbabu@kernel.org>
>> Link: https://lore.kernel.org/linux-xfs/0b92a215-9d9b-3788-4504-a520778953c2@huaweicloud.com
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/xfs/xfs_iomap.c | 35 +++++++++++++++++++++++++++++++----
>>  fs/xfs/xfs_iops.c  | 10 ----------
>>  2 files changed, 31 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 4958cc3337bc..fc379450fe74 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -1466,12 +1466,39 @@ xfs_truncate_page(
>>  	loff_t			pos,
>>  	bool			*did_zero)
>>  {
>> +	struct xfs_mount	*mp = ip->i_mount;
>>  	struct inode		*inode = VFS_I(ip);
>>  	unsigned int		blocksize = i_blocksize(inode);
>> +	int			error;
>> +
>> +	if (XFS_IS_REALTIME_INODE(ip))
>> +		blocksize = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
>> +
>> +	/*
>> +	 * iomap won't detect a dirty page over an unwritten block (or a
>> +	 * cow block over a hole) and subsequently skips zeroing the
>> +	 * newly post-EOF portion of the page. Flush the new EOF to
>> +	 * convert the block before the pagecache truncate.
>> +	 */
>> +	error = filemap_write_and_wait_range(inode->i_mapping, pos,
>> +					     roundup_64(pos, blocksize));
>> +	if (error)
>> +		return error;
>>  
>>  	if (IS_DAX(inode))
>> -		return dax_truncate_page(inode, pos, blocksize, did_zero,
>> -					&xfs_dax_write_iomap_ops);
>> -	return iomap_truncate_page(inode, pos, blocksize, did_zero,
>> -				   &xfs_buffered_write_iomap_ops);
>> +		error = dax_truncate_page(inode, pos, blocksize, did_zero,
>> +					  &xfs_dax_write_iomap_ops);
>> +	else
>> +		error = iomap_truncate_page(inode, pos, blocksize, did_zero,
>> +					    &xfs_buffered_write_iomap_ops);
>> +	if (error)
>> +		return error;
>> +
>> +	/*
>> +	 * Write back path won't write dirty blocks post EOF folio,
>> +	 * flush the entire zeroed range before updating the inode
>> +	 * size.
>> +	 */
>> +	return filemap_write_and_wait_range(inode->i_mapping, pos,
>> +					    roundup_64(pos, blocksize));
>>  }
> 
> Ok, this means we do -three- blocking writebacks through this path
> instead of one or maybe two.
> 
> We already know that this existing blocking writeback case for dirty
> pages over unwritten extents is a significant performance issue for
> some workloads. I have a fix in progress for iomap to handle this
> case without requiring blocking writeback to be done to convert the
> extent to written before we do the truncate.
> 
> Regardless, I think this whole "truncate is allocation unit size
> aware" algorithm is largely unworkable without a rewrite. What XFS
> needs to do on truncate *down* before we start the truncate
> transaction is pretty simple:
> 
> 	- ensure that the new EOF extent tail contains zeroes
> 	- ensure that the range from the existing ip->i_disk_size to
> 	  the new EOF is on disk so data vs metadata ordering is
> 	  correct for crash recovery purposes.
> 
> What this patch does to acheive that is:
> 
> 	1. blocking writeback to clean dirty unwritten/cow blocks at
> 	the new EOF.
> 	2. iomap_truncate_page() writes zeroes into the page cache,
> 	which dirties the pages we just cleaned at the new EOF.
> 	3. blocking writeback to clean the dirty blocks at the new
> 	EOF.
> 	4. truncate_setsize() then writes zeros to partial folios at
> 	the new EOF, dirtying the EOF page again.
> 	5. blocking writeback to clean dirty blocks from the current
> 	on-disk size to the new EOF.
> 
> This is pretty crazy when you stop and think about it. We're writing
> the same EOF block -three- times. The first data write gets
> overwritten by zeroes on the second write, and the third write
> writes the same zeroes as the second write. There are two redundant
> *blocking* writes in this process.

Yes, this is indeed a performance disaster, and iomap_zero_range()
should aware the dirty pages. I had the same problem when developing
buffered iomap conversion on ext4.

> 
> We can do all this with a single writeback operation if we are a
> little bit smarter about the order of operations we perform and we
> are a little bit smarter in iomap about zeroing dirty pages in the
> page cache:
> 
> 	1. change iomap_zero_range() to do the right thing with
> 	dirty unwritten and cow extents (the patch I've been working
> 	on).
> 
> 	2. pass the range to be zeroed into iomap_truncate_page()
> 	(the fundamental change being made here).
> 
> 	3. zero the required range *through the page cache*
> 	(iomap_zero_range() already does this).
> 
> 	4. write back the XFS inode from ip->i_disk_size to the end
> 	of the range zeroed by iomap_truncate_page()
> 	(xfs_setattr_size() already does this).
> 
> 	5. i_size_write(newsize);
> 
> 	6. invalidate_inode_pages2_range(newsize, -1) to trash all
> 	the page cache beyond the new EOF without doing any zeroing
> 	as we've already done all the zeroing needed to the page
> 	cache through iomap_truncate_page().
> 
> 
> The patch I'm working on for step 1 is below. It still needs to be
> extended to handle the cow case, but I'm unclear on how to exercise
> that case so I haven't written the code to do it. The rest of it is
> just rearranging the code that we already use just to get the order
> of operations right. The only notable change in behaviour is using
> invalidate_inode_pages2_range() instead of truncate_pagecache(),
> because we don't want the EOF page to be dirtied again once we've
> already written zeroes to disk....
> 

Indeed, this sounds like the best solution. Since Darrick recommended
that we could fix the stale data exposure on realtime inode issue by
convert the tail extent to unwritten, I suppose we could do this after
fixing the problem.

Thanks,
Yi.


