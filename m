Return-Path: <linux-fsdevel+bounces-63628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E2BC7AC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 09:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C46A534DC9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 07:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD92D0C7F;
	Thu,  9 Oct 2025 07:21:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C0298CA4;
	Thu,  9 Oct 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994466; cv=none; b=N99+dRggTlxpfqEl7/OOO8FaRNSHnpIP/bUqO0qPkU6F4llJ2Bur+Kep/7cCRTlgqvGSDKFm0UPlsk4ezYCwy87GF/YqBAxkWSlWQn00QE2NH+mtd7L17KNB9UUJiyEIBQ4slbkNlrmESlTHHqThiMzPgjdL0b2F2nqusdLdc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994466; c=relaxed/simple;
	bh=mq2ZPLW0aGP6i2qiG5Ep8MFC8jCceNRZNu66ObNVVJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCHN9f8M5HAV5s61AxYr0mhv6n303JY+rr0icQ89KbCfdfMj4CTwvDXVtFkYPbFEB4u+6cxUJKxqFSz++gEQrWr85np2+e0M/1co+Qw4EB+7X9sj12lP5AkUgAV+hbnyHMchiNZrHp5lLStNFkuvte1fGwN0bgi0G1PoHytwRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cj1Vm5ycBzKHMgD;
	Thu,  9 Oct 2025 15:20:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 54C631A0D11;
	Thu,  9 Oct 2025 15:21:01 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgBnK2NbYudokcU4CQ--.38902S3;
	Thu, 09 Oct 2025 15:21:01 +0800 (CST)
Message-ID: <fcf30c3c-25c3-4b1a-8b34-a5dcd98b7ebd@huaweicloud.com>
Date: Thu, 9 Oct 2025 15:20:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] ext4: switch to using the new extent movement
 method
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-12-yi.zhang@huaweicloud.com>
 <wdluk2p7bmgkh3n3xzep3tf3qb7mv3x2o6ltemjcahgorgmhwb@hfu7t7ar2vol>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <wdluk2p7bmgkh3n3xzep3tf3qb7mv3x2o6ltemjcahgorgmhwb@hfu7t7ar2vol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnK2NbYudokcU4CQ--.38902S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1ruw47uw15Jw18Xr43Jrb_yoWxXw1DpF
	WxAr15G398Xa4Fgr1ktw4DXryFgw1UKr47ArWfGF1fWF9xArySg3Z8Aa1av34akrZ7JryF
	vF4jyr9rWa13tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/8/2025 8:49 PM, Jan Kara wrote:
> On Thu 25-09-25 17:26:07, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Now that we have mext_move_extent(), we can switch to this new interface
>> and deprecate move_extent_per_page(). First, after acquiring the
>> i_rwsem, we can directly use ext4_map_blocks() to obtain a contiguous
>> extent from the original inode as the extent to be moved. It can and
>> it's safe to get mapping information from the extent status tree without
>> needing to access the ondisk extent tree, because ext4_move_extent()
>> will check the sequence cookie under the folio lock. Then, after
>> populating the mext_data structure, we call ext4_move_extent() to move
>> the extent. Finally, the length of the extent will be adjusted in
>> mext.orig_map.m_len and the actual length moved is returned through
>> m_len.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Two small comments below:
> 
>> +int ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>> +		      __u64 donor_blk, __u64 len, __u64 *moved_len)
>>  {
>>  	struct inode *orig_inode = file_inode(o_filp);
>>  	struct inode *donor_inode = file_inode(d_filp);
>> -	struct ext4_ext_path *path = NULL;
>> -	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
>> -	ext4_lblk_t o_end, o_start = orig_blk;
>> -	ext4_lblk_t d_start = donor_blk;
>> +	struct mext_data mext;
>> +	struct super_block *sb = orig_inode->i_sb;
>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> +	int retries = 0;
>> +	u64 m_len;
>>  	int ret;
>>  
>> +	*moved_len = 0;
>> +
>>  	/* Protect orig and donor inodes against a truncate */
>>  	lock_two_nondirectories(orig_inode, donor_inode);
>>  
>>  	ret = mext_check_validity(orig_inode, donor_inode);
>>  	if (ret)
>> -		goto unlock;
>> +		goto out;
>>  
>>  	/* Wait for all existing dio workers */
>>  	inode_dio_wait(orig_inode);
>>  	inode_dio_wait(donor_inode);
>>  
>> -	/* Protect extent tree against block allocations via delalloc */
>> -	ext4_double_down_write_data_sem(orig_inode, donor_inode);
>>  	/* Check and adjust the specified move_extent range. */
>>  	ret = mext_check_adjust_range(orig_inode, donor_inode, orig_blk,
>>  				      donor_blk, &len);
>>  	if (ret)
>>  		goto out;
>> -	o_end = o_start + len;
>>  
>> -	*moved_len = 0;
>> -	while (o_start < o_end) {
>> -		struct ext4_extent *ex;
>> -		ext4_lblk_t cur_blk, next_blk;
>> -		pgoff_t orig_page_index, donor_page_index;
>> -		int offset_in_page;
>> -		int unwritten, cur_len;
>> -
>> -		path = get_ext_path(orig_inode, o_start, path);
>> -		if (IS_ERR(path)) {
>> -			ret = PTR_ERR(path);
>> +	mext.orig_inode = orig_inode;
>> +	mext.donor_inode = donor_inode;
>> +	while (len) {
>> +		mext.orig_map.m_lblk = orig_blk;
>> +		mext.orig_map.m_len = len;
>> +		mext.orig_map.m_flags = 0;
>> +		mext.donor_lblk = donor_blk;
>> +
>> +		ret = ext4_map_blocks(NULL, orig_inode, &mext.orig_map, 0);
>> +		if (ret < 0)
>>  			goto out;
>> -		}
>> -		ex = path[path->p_depth].p_ext;
>> -		cur_blk = le32_to_cpu(ex->ee_block);
>> -		cur_len = ext4_ext_get_actual_len(ex);
>> -		/* Check hole before the start pos */
>> -		if (cur_blk + cur_len - 1 < o_start) {
>> -			next_blk = ext4_ext_next_allocated_block(path);
>> -			if (next_blk == EXT_MAX_BLOCKS) {
>> -				ret = -ENODATA;
>> -				goto out;
>> -			}
>> -			d_start += next_blk - o_start;
>> -			o_start = next_blk;
>> -			continue;
>> -		/* Check hole after the start pos */
>> -		} else if (cur_blk > o_start) {
>> -			/* Skip hole */
>> -			d_start += cur_blk - o_start;
>> -			o_start = cur_blk;
>> -			/* Extent inside requested range ?*/
>> -			if (cur_blk >= o_end)
>> +
>> +		/* Skip moving if it is a hole or a delalloc extent. */
>> +		if (mext.orig_map.m_flags &
>> +		    (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
>> +			ret = mext_move_extent(&mext, &m_len);
>> +			if (ret == -ESTALE)
>> +				continue;
>> +			if (ret == -ENOSPC &&
>> +			    ext4_should_retry_alloc(sb, &retries))
>> +				continue;
> 
> ENOSPC here could come only from extent tree manipulations right? I was
> wondering for a while why do we check it here :).

Yes, I think so as well.

> 
>> +			if (ret == -EBUSY &&
>> +			    sbi->s_journal && retries++ < 4 &&
>> +			    jbd2_journal_force_commit_nested(sbi->s_journal))
>> +				continue;
>> +			if (ret)
>>  				goto out;
>> -		} else { /* in_range(o_start, o_blk, o_len) */
>> -			cur_len += cur_blk - o_start;
>> +
>> +			*moved_len += m_len;
>> +			retries = 0;
>>  		}
>> -		unwritten = ext4_ext_is_unwritten(ex);
>> -		if (o_end - o_start < cur_len)
>> -			cur_len = o_end - o_start;
>> -
>> -		orig_page_index = o_start >> (PAGE_SHIFT -
>> -					       orig_inode->i_blkbits);
>> -		donor_page_index = d_start >> (PAGE_SHIFT -
>> -					       donor_inode->i_blkbits);
>> -		offset_in_page = o_start % blocks_per_page;
>> -		if (cur_len > blocks_per_page - offset_in_page)
>> -			cur_len = blocks_per_page - offset_in_page;
>> -		/*
>> -		 * Up semaphore to avoid following problems:
>> -		 * a. transaction deadlock among ext4_journal_start,
>> -		 *    ->write_begin via pagefault, and jbd2_journal_commit
>> -		 * b. racing with ->read_folio, ->write_begin, and
>> -		 *    ext4_get_block in move_extent_per_page
>> -		 */
>> -		ext4_double_up_write_data_sem(orig_inode, donor_inode);
>> -		/* Swap original branches with new branches */
>> -		*moved_len += move_extent_per_page(o_filp, donor_inode,
>> -				     orig_page_index, donor_page_index,
>> -				     offset_in_page, cur_len,
>> -				     unwritten, &ret);
>> -		ext4_double_down_write_data_sem(orig_inode, donor_inode);
>> -		if (ret < 0)
>> -			break;
>> -		o_start += cur_len;
>> -		d_start += cur_len;
>> +		orig_blk += mext.orig_map.m_len;
>> +		donor_blk += mext.orig_map.m_len;
>> +		len -= mext.orig_map.m_len;
> 
> In case we've called mext_move_extent() we should update everything only by
> m_len, shouldn't we? Although I have somewhat hard time coming up with a
> realistic scenario where m_len != mext.orig_map.m_len for the parameters we
> call ext4_swap_extents() with... So maybe I'm missing something.
> 

In the case of MEXT_SKIP_EXTENT, the target move range of the donor file
is a hole. In this case, the m_len is return zero after calling
mext_move_extent(), not equal to mext.orig_map.m_len, and we need to move
forward and skip this range in the next iteration in ext4_move_extents().
Otherwise, it will lead to an infinite loop.

In the other two cases, MEXT_MOVE_EXTENT and MEXT_COPY_DATA, m_len should
be equal to mext.orig_map.m_len after calling mext_move_extent().

Thanks,
Yi.


