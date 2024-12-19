Return-Path: <linux-fsdevel+bounces-37779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC89F752D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 08:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC776188D792
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 07:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF33217716;
	Thu, 19 Dec 2024 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fAQq57Zj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C8217655;
	Thu, 19 Dec 2024 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592355; cv=none; b=SyGbTGdav35tVFI6ndheJiyvklTZAkJpU1BVOEyZ2F3ayO0vHI+udtjpjyHwfztt4So7Q/zd0ssHLVLo51sIuErsDf7ZWxEPf379yZHmTITI0UU8ExUrsuMIkTefbaFoWyW7e0JphCj7EgZ/wsolXc8QWBqp/jTJAK6oclTiFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592355; c=relaxed/simple;
	bh=Et8GaQnfejt8VC6wOj4VCKjek1EeZz1ihWWkPDNY0Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKO7/6wMQdXlNFy7ge+wlfot4JxFucppe1XW9RFbURZrsQYRzhFc9wnw2BYDh4Ii+Xy4yXcj5LvSZ2Nsj8CgMRIFC5NVB7hBz/IckFgsGx9KmEvlJExGzt/o8TLEiD9DKXpvA4BYYFoBFJIgbZQUZenxXWPeO/LvWN7/qq0PqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fAQq57Zj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIID0Kt026852;
	Thu, 19 Dec 2024 07:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lKE01dXl8PApmDhl4S87//4oIXhQXd
	TGPS3AHijjPHI=; b=fAQq57ZjB8DE3YFxXRpGvCI7sOP40JeOXtAdscFZNi62hB
	vhMIybVmJQpWsfLJ5DLQJKW0ATh0MKWqoZjE8WnM4CCq6bjlbJw0tf49YxiM0gqj
	rOxoe5yfcqtFtj7DwzTEpLJV9xDQC9qj+18wyC8rozmKtASSqBwwCD4VoIhneigv
	Eze4B0F+Gd/XGgPCUTwWes++9xS84x4496/qZeHrhLKeYT0i8+t9t11lEoWwAIbc
	dVXbIQ6MhxLjBs1610LtpsJUa+WoeE7bS+Gem9HkvEwPA3Q5fI4t6TT5JWu6FAzj
	QM3/03NZGFeXPKtuKZguwNjXIWZo6LzsATJUfJVQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ktk2nkxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 07:12:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ4F5TU005549;
	Thu, 19 Dec 2024 07:12:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbnbywu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 07:12:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJ7CAZn21823950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 07:12:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B3A2004B;
	Thu, 19 Dec 2024 07:12:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A88020040;
	Thu, 19 Dec 2024 07:12:08 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.218.178])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Dec 2024 07:12:08 +0000 (GMT)
Date: Thu, 19 Dec 2024 12:42:05 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 05/10] ext4: refactor ext4_zero_range()
Message-ID: <Z2PHRaj+S5M+fZ5U@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-6-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vFyitavhpiir5Uo6S3eCtKmXlLYMjKYf
X-Proofpoint-ORIG-GUID: vFyitavhpiir5Uo6S3eCtKmXlLYMjKYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190054

On Mon, Dec 16, 2024 at 09:39:10AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The current implementation of ext4_zero_range() contains complex
> position calculations and stale error tags. To improve the code's
> clarity and maintainability, it is essential to clean up the code and
> improve its readability, this can be achieved by: a) simplifying and
> renaming variables, making the style the same as ext4_punch_hole(); b)
> eliminating unnecessary position calculations, writing back all data in
> data=journal mode, and drop page cache from the original offset to the
> end, rather than using aligned blocks; c) renaming the stale out_mutex
> tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good Zhang, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> ---
>  fs/ext4/extents.c | 142 +++++++++++++++++++---------------------------
>  1 file changed, 57 insertions(+), 85 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 7fb38aab241d..97ad6fea58d3 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4570,40 +4570,15 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	struct inode *inode = file_inode(file);
>  	struct address_space *mapping = file->f_mapping;
>  	handle_t *handle = NULL;
> -	unsigned int max_blocks;
>  	loff_t new_size = 0;
> -	int ret = 0;
> -	int flags;
> -	int credits;
> -	int partial_begin, partial_end;
> -	loff_t start, end;
> -	ext4_lblk_t lblk;
> +	loff_t end = offset + len;
> +	ext4_lblk_t start_lblk, end_lblk;
> +	unsigned int blocksize = i_blocksize(inode);
>  	unsigned int blkbits = inode->i_blkbits;
> +	int ret, flags, credits;
>  
>  	trace_ext4_zero_range(inode, offset, len, mode);
>  
> -	/*
> -	 * Round up offset. This is not fallocate, we need to zero out
> -	 * blocks, so convert interior block aligned part of the range to
> -	 * unwritten and possibly manually zero out unaligned parts of the
> -	 * range. Here, start and partial_begin are inclusive, end and
> -	 * partial_end are exclusive.
> -	 */
> -	start = round_up(offset, 1 << blkbits);
> -	end = round_down((offset + len), 1 << blkbits);
> -
> -	if (start < offset || end > offset + len)
> -		return -EINVAL;
> -	partial_begin = offset & ((1 << blkbits) - 1);
> -	partial_end = (offset + len) & ((1 << blkbits) - 1);
> -
> -	lblk = start >> blkbits;
> -	max_blocks = (end >> blkbits);
> -	if (max_blocks < lblk)
> -		max_blocks = 0;
> -	else
> -		max_blocks -= lblk;
> -
>  	inode_lock(inode);
>  
>  	/*
> @@ -4611,77 +4586,70 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	 */
>  	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
>  		ret = -EOPNOTSUPP;
> -		goto out_mutex;
> +		goto out;
>  	}
>  
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
> -	    (offset + len > inode->i_size ||
> -	     offset + len > EXT4_I(inode)->i_disksize)) {
> -		new_size = offset + len;
> +	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
> +		new_size = end;
>  		ret = inode_newsize_ok(inode, new_size);
>  		if (ret)
> -			goto out_mutex;
> +			goto out;
>  	}
>  
> -	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
> -
>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
>  	inode_dio_wait(inode);
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out_mutex;
> -
> -	/* Preallocate the range including the unaligned edges */
> -	if (partial_begin || partial_end) {
> -		ret = ext4_alloc_file_blocks(file,
> -				round_down(offset, 1 << blkbits) >> blkbits,
> -				(round_up((offset + len), 1 << blkbits) -
> -				 round_down(offset, 1 << blkbits)) >> blkbits,
> -				new_size, flags);
> -		if (ret)
> -			goto out_mutex;
> +		goto out;
>  
> -	}
> +	/*
> +	 * Prevent page faults from reinstantiating pages we have released
> +	 * from page cache.
> +	 */
> +	filemap_invalidate_lock(mapping);
>  
> -	/* Zero range excluding the unaligned edges */
> -	if (max_blocks > 0) {
> -		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
> -			  EXT4_EX_NOCACHE);
> +	ret = ext4_break_layouts(inode);
> +	if (ret)
> +		goto out_invalidate_lock;
>  
> -		/*
> -		 * Prevent page faults from reinstantiating pages we have
> -		 * released from page cache.
> -		 */
> -		filemap_invalidate_lock(mapping);
> +	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
> +	/* Preallocate the range including the unaligned edges */
> +	if (!IS_ALIGNED(offset | end, blocksize)) {
> +		ext4_lblk_t alloc_lblk = offset >> blkbits;
> +		ext4_lblk_t len_lblk = EXT4_MAX_BLOCKS(len, offset, blkbits);
>  
> -		ret = ext4_break_layouts(inode);
> -		if (ret) {
> -			filemap_invalidate_unlock(mapping);
> -			goto out_mutex;
> -		}
> +		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
> +					     new_size, flags);
> +		if (ret)
> +			goto out_invalidate_lock;
> +	}
>  
> -		ret = ext4_update_disksize_before_punch(inode, offset, len);
> -		if (ret) {
> -			filemap_invalidate_unlock(mapping);
> -			goto out_mutex;
> -		}
> +	ret = ext4_update_disksize_before_punch(inode, offset, len);
> +	if (ret)
> +		goto out_invalidate_lock;
>  
> -		/* Now release the pages and zero block aligned part of pages */
> -		ret = ext4_truncate_page_cache_block_range(inode, start, end);
> -		if (ret) {
> -			filemap_invalidate_unlock(mapping);
> -			goto out_mutex;
> -		}
> +	/* Now release the pages and zero block aligned part of pages */
> +	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
> +	if (ret)
> +		goto out_invalidate_lock;
>  
> -		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
> -					     flags);
> -		filemap_invalidate_unlock(mapping);
> +	/* Zero range excluding the unaligned edges */
> +	start_lblk = EXT4_B_TO_LBLK(inode, offset);
> +	end_lblk = end >> blkbits;
> +	if (end_lblk > start_lblk) {
> +		ext4_lblk_t zero_blks = end_lblk - start_lblk;
> +
> +		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
> +		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
> +					     new_size, flags);
>  		if (ret)
> -			goto out_mutex;
> +			goto out_invalidate_lock;
>  	}
> -	if (!partial_begin && !partial_end)
> -		goto out_mutex;
> +	/* Finish zeroing out if it doesn't contain partial block */
> +	if (IS_ALIGNED(offset | end, blocksize))
> +		goto out_invalidate_lock;
>  
>  	/*
>  	 * In worst case we have to writeout two nonadjacent unwritten
> @@ -4694,25 +4662,29 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		ext4_std_error(inode->i_sb, ret);
> -		goto out_mutex;
> +		goto out_invalidate_lock;
>  	}
>  
> +	/* Zero out partial block at the edges of the range */
> +	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
> +	if (ret)
> +		goto out_handle;
> +
>  	if (new_size)
>  		ext4_update_inode_size(inode, new_size);
>  	ret = ext4_mark_inode_dirty(handle, inode);
>  	if (unlikely(ret))
>  		goto out_handle;
> -	/* Zero out partial block at the edges of the range */
> -	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
> -	if (ret >= 0)
> -		ext4_update_inode_fsync_trans(handle, inode, 1);
>  
> +	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	if (file->f_flags & O_SYNC)
>  		ext4_handle_sync(handle);
>  
>  out_handle:
>  	ext4_journal_stop(handle);
> -out_mutex:
> +out_invalidate_lock:
> +	filemap_invalidate_unlock(mapping);
> +out:
>  	inode_unlock(inode);
>  	return ret;
>  }
> -- 
> 2.46.1
> 

