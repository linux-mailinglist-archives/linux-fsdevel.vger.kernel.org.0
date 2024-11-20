Return-Path: <linux-fsdevel+bounces-35257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670779D327B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 04:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24934283F1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 03:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB0A15625A;
	Wed, 20 Nov 2024 03:19:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487714B08E;
	Wed, 20 Nov 2024 03:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072742; cv=none; b=pzOKil0y9qyes+TC+cr9iATj69vYC1hj21QWHYkwgCiPHv/J7dnooqVG3jkWL24DsINVV55Cr9bupJNh38v1oQuST+MH5GnxPKoLdADu3LBg7lfaC7NIYunZ1fFb3oJBrRavqYnC0om54rLlZjoY7fQ20lsX7Il6G5sD1/IOIu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072742; c=relaxed/simple;
	bh=6hQ3dTT7sGQuw6UkcwFG/mwv2unLMu4axt+aZufCRc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxWjkYknWuijEBZCxPM2u0nnBM0uYMo0YzkovXtbFKu+2Bp3YvTsGmVAdQpvtZt7hW6MZtvi8cb4SMfCa5MuiM72WJJcPq4hE33E3JGlT9mA3OVpf5gf4+05UYrOh++kRxCPBRNrYi8eAmO4c6k/5Yps7HujQPclF7/U4niYsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XtRQg2WfGz4f3jq9;
	Wed, 20 Nov 2024 11:18:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C12661A0196;
	Wed, 20 Nov 2024 11:18:48 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4cWVT1nZT8rCQ--.59190S3;
	Wed, 20 Nov 2024 11:18:48 +0800 (CST)
Message-ID: <c41a2dd8-de10-4f9e-9a5e-6927ebef2b3c@huaweicloud.com>
Date: Wed, 20 Nov 2024 11:18:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/27] ext4: refactor ext4_punch_hole()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, hch@infradead.org, david@fromorbit.com,
 zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-5-yi.zhang@huaweicloud.com>
 <20241118232712.GB9417@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241118232712.GB9417@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHo4cWVT1nZT8rCQ--.59190S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1fur1xXr4xGFy5AF1kKrg_yoWfXF4fpr
	9xJFy5Gr48WFyq9F4Iqr4DXF1I93WDKrWUXryxGF1fW34qywn3KF1qkF1rWa42yrsrZr40
	vF4Utr9rW34UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/11/19 7:27, Darrick J. Wong wrote:
> On Tue, Oct 22, 2024 at 07:10:35PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The current implementation of ext4_punch_hole() contains complex
>> position calculations and stale error tags. To improve the code's
>> clarity and maintainability, it is essential to clean up the code and
>> improve its readability, this can be achieved by: a) simplifying and
>> renaming variables; b) eliminating unnecessary position calculations;
>> c) writing back all data in data=journal mode, and drop page cache from
>> the original offset to the end, rather than using aligned blocks,
>> d) renaming the stale error tags.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/inode.c | 140 +++++++++++++++++++++---------------------------
>>  1 file changed, 62 insertions(+), 78 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 94b923afcd9c..1d128333bd06 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3955,13 +3955,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  {
>>  	struct inode *inode = file_inode(file);
>>  	struct super_block *sb = inode->i_sb;
>> -	ext4_lblk_t first_block, stop_block;
>> +	ext4_lblk_t start_lblk, end_lblk;
>>  	struct address_space *mapping = inode->i_mapping;
>> -	loff_t first_block_offset, last_block_offset, max_length;
>> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>> +	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
>> +	loff_t end = offset + length;
>> +	unsigned long blocksize = i_blocksize(inode);
>>  	handle_t *handle;
>>  	unsigned int credits;
>> -	int ret = 0, ret2 = 0;
>> +	int ret = 0;
>>  
>>  	trace_ext4_punch_hole(inode, offset, length, 0);
>>  
>> @@ -3969,36 +3970,27 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  
>>  	/* No need to punch hole beyond i_size */
>>  	if (offset >= inode->i_size)
>> -		goto out_mutex;
>> +		goto out;
>>  
>>  	/*
>> -	 * If the hole extends beyond i_size, set the hole
>> -	 * to end after the page that contains i_size
>> +	 * If the hole extends beyond i_size, set the hole to end after
>> +	 * the page that contains i_size, and also make sure that the hole
>> +	 * within one block before last range.
>>  	 */
>> -	if (offset + length > inode->i_size) {
>> -		length = inode->i_size +
>> -		   PAGE_SIZE - (inode->i_size & (PAGE_SIZE - 1)) -
>> -		   offset;
>> -	}
>> +	if (end > inode->i_size)
>> +		end = round_up(inode->i_size, PAGE_SIZE);
>> +	if (end > max_end)
>> +		end = max_end;
>> +	length = end - offset;
>>  
>>  	/*
>> -	 * For punch hole the length + offset needs to be within one block
>> -	 * before last range. Adjust the length if it goes beyond that limit.
>> +	 * Attach jinode to inode for jbd2 if we do any zeroing of partial
>> +	 * block.
>>  	 */
>> -	max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;
>> -	if (offset + length > max_length)
>> -		length = max_length - offset;
>> -
>> -	if (offset & (sb->s_blocksize - 1) ||
>> -	    (offset + length) & (sb->s_blocksize - 1)) {
>> -		/*
>> -		 * Attach jinode to inode for jbd2 if we do any zeroing of
>> -		 * partial block
>> -		 */
>> +	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
> 
> IS_ALIGNED(offset | end, blocksize) ?

Right, this helper looks better, thanks for pointing this out.

> 
>>  		ret = ext4_inode_attach_jinode(inode);
>>  		if (ret < 0)
>> -			goto out_mutex;
>> -
>> +			goto out;
>>  	}
>>  
>>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
>> @@ -4006,7 +3998,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  
>>  	ret = file_modified(file);
>>  	if (ret)
>> -		goto out_mutex;
>> +		goto out;
>>  
>>  	/*
>>  	 * Prevent page faults from reinstantiating pages we have released from
>> @@ -4016,34 +4008,24 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  
>>  	ret = ext4_break_layouts(inode);
>>  	if (ret)
>> -		goto out_dio;
>> -
>> -	first_block_offset = round_up(offset, sb->s_blocksize);
>> -	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
>> +		goto out_invalidate_lock;
>>  
>> -	/* Now release the pages and zero block aligned part of pages*/
>> -	if (last_block_offset > first_block_offset) {
>> +	/*
>> +	 * For journalled data we need to write (and checkpoint) pages
>> +	 * before discarding page cache to avoid inconsitent data on
> 
> inconsistent

Yeah.

> 
>> +	 * disk in case of crash before punching trans is committed.
>> +	 */
>> +	if (ext4_should_journal_data(inode)) {
>> +		ret = filemap_write_and_wait_range(mapping, offset, end - 1);
>> +	} else {
>>  		ret = ext4_update_disksize_before_punch(inode, offset, length);
>> -		if (ret)
>> -			goto out_dio;
>> -
>> -		/*
>> -		 * For journalled data we need to write (and checkpoint) pages
>> -		 * before discarding page cache to avoid inconsitent data on
>> -		 * disk in case of crash before punching trans is committed.
>> -		 */
>> -		if (ext4_should_journal_data(inode)) {
>> -			ret = filemap_write_and_wait_range(mapping,
>> -					first_block_offset, last_block_offset);
>> -			if (ret)
>> -				goto out_dio;
>> -		}
>> -
>> -		ext4_truncate_folios_range(inode, first_block_offset,
>> -					   last_block_offset + 1);
>> -		truncate_pagecache_range(inode, first_block_offset,
>> -					 last_block_offset);
>> +		ext4_truncate_folios_range(inode, offset, end);
>>  	}
>> +	if (ret)
>> +		goto out_invalidate_lock;
>> +
>> +	/* Now release the pages and zero block aligned part of pages*/
>> +	truncate_pagecache_range(inode, offset, end - 1);
>>  
>>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>>  		credits = ext4_writepage_trans_blocks(inode);
>> @@ -4053,52 +4035,54 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  	if (IS_ERR(handle)) {
>>  		ret = PTR_ERR(handle);
>>  		ext4_std_error(sb, ret);
>> -		goto out_dio;
>> +		goto out_invalidate_lock;
>>  	}
>>  
>> -	ret = ext4_zero_partial_blocks(handle, inode, offset,
>> -				       length);
>> +	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
>>  	if (ret)
>> -		goto out_stop;
>> -
>> -	first_block = (offset + sb->s_blocksize - 1) >>
>> -		EXT4_BLOCK_SIZE_BITS(sb);
>> -	stop_block = (offset + length) >> EXT4_BLOCK_SIZE_BITS(sb);
>> +		goto out_handle;
>>  
>>  	/* If there are blocks to remove, do it */
>> -	if (stop_block > first_block) {
>> -		ext4_lblk_t hole_len = stop_block - first_block;
>> +	start_lblk = round_up(offset, blocksize) >> inode->i_blkbits;
> 
> egad I wish ext4 had nicer unit conversion helpers.
> 
> static inline ext4_lblk_t
> EXT4_B_TO_LBLK(struct ext4_sb_info *sbi, ..., loff_t offset)
> {
> 	return round_up(offset, blocksize) >> inode->i_blkbits;
> }
> 
> 	start_lblk = EXT4_B_TO_LBLK(sbi, offset);
> 
> ah well.
> 

Sure, it looks clearer.

>> +	end_lblk = end >> inode->i_blkbits;
>> +
>> +	if (end_lblk > start_lblk) {
>> +		ext4_lblk_t hole_len = end_lblk - start_lblk;
>>  
>>  		down_write(&EXT4_I(inode)->i_data_sem);
>>  		ext4_discard_preallocations(inode);
>>  
>> -		ext4_es_remove_extent(inode, first_block, hole_len);
>> +		ext4_es_remove_extent(inode, start_lblk, hole_len);
>>  
>>  		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>> -			ret = ext4_ext_remove_space(inode, first_block,
>> -						    stop_block - 1);
>> +			ret = ext4_ext_remove_space(inode, start_lblk,
>> +						    end_lblk - 1);
>>  		else
>> -			ret = ext4_ind_remove_space(handle, inode, first_block,
>> -						    stop_block);
>> +			ret = ext4_ind_remove_space(handle, inode, start_lblk,
>> +						    end_lblk);
>> +		if (ret) {
>> +			up_write(&EXT4_I(inode)->i_data_sem);
>> +			goto out_handle;
>> +		}
>>  
>> -		ext4_es_insert_extent(inode, first_block, hole_len, ~0,
>> +		ext4_es_insert_extent(inode, start_lblk, hole_len, ~0,
>>  				      EXTENT_STATUS_HOLE, 0);
>>  		up_write(&EXT4_I(inode)->i_data_sem);
>>  	}
>> -	ext4_fc_track_range(handle, inode, first_block, stop_block);
>> +	ext4_fc_track_range(handle, inode, start_lblk, end_lblk);
>> +
>> +	ret = ext4_mark_inode_dirty(handle, inode);
>> +	if (unlikely(ret))
>> +		goto out_handle;
>> +
>> +	ext4_update_inode_fsync_trans(handle, inode, 1);
>>  	if (IS_SYNC(inode))
>>  		ext4_handle_sync(handle);
>> -
>> -	ret2 = ext4_mark_inode_dirty(handle, inode);
>> -	if (unlikely(ret2))
>> -		ret = ret2;
>> -	if (ret >= 0)
>> -		ext4_update_inode_fsync_trans(handle, inode, 1);
>> -out_stop:
>> +out_handle:
>>  	ext4_journal_stop(handle);
>> -out_dio:
>> +out_invalidate_lock:
>>  	filemap_invalidate_unlock(mapping);
>> -out_mutex:
>> +out:
> 
> Why drop "_mutex"?  You're unlocking *something* on the way out.
> 

"_mutex" is no longer accurate, as the inode has changed to using rwsem instead.
But never mind, this "out" tag is also removed in patch 9.

Thanks,
Yi.

> 
>>  	inode_unlock(inode);
>>  	return ret;
>>  }
>> -- 
>> 2.46.1
>>
>>


