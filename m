Return-Path: <linux-fsdevel+bounces-37722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 661059F62AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468277A3149
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC6519B5BE;
	Wed, 18 Dec 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tJ1JDyEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D519884B;
	Wed, 18 Dec 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517264; cv=none; b=aZnL5WGJ4Xe/fQnlHYqTi3FhFVveA4MvuW5NxyavLAm3kTAON2MSJ0YKIK1A50lskNL6yRvZhIiOy3XCtIgF2fGCD9LIhqdYL5gi28UMrttDOY4aX28gDnw+yAPQqNPmNK4VPhvEYIv6kHATSPFiRpRt3VsxgwMhy9aGiHSARyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517264; c=relaxed/simple;
	bh=s3p3/aNcOWBvxR0d2yr4SG9jNuK4X3ro4/+sfpfTkHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrVhZEgKRmABfBp2SH7gq4oPlmE7iU+X2IY1ha2WBqQIem3DWnVrtHmnynR7/vC1FImSr3ScNA3fzUpqG6g781qmfxh4jSyUWGhk5cfGefCIe7DUxobhfSIejouGSFCGhHqiMfRUT5EC1mSAMsw00fGjUUMg+j6t8X/2zTpmpDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tJ1JDyEi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHNaFK6018826;
	Wed, 18 Dec 2024 10:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Jl0Ca+eaGBhmp8rMqEfy51NdBSDSk1
	oLaQhvAxTeAxw=; b=tJ1JDyEictT+HquWphnKLtVCSO1PGDzA9zF4Vqyag7Cc7r
	1DcbF2CbRIqVHmznbEKHsHsNIO8KCcrgM44unRHOBlZYt0CiuRRCiUke/+lWKr0S
	NqWSOTRTdUSSjNcufte3WPkM43pixAnbTxS5pp2Iv/ut2Q9JPUowJa9s2D1wz1Ab
	YSuH//weTHaXh9ERe7f2D69KhrIBp8y52r5k/UAevITYKrXOt0kzbsdOCwD58Dgh
	p+Ztr8wxfqZcMmdcF2J66Ofo4K8GBD6XfAzRGwIkV9AW5oV/8rhpBfUMgS+jfElU
	O4Y6qdor1Wf+mUGnMzxV9fZI32LztIYHgBJEqu2g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kk4aa939-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:20:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI9gimr014383;
	Wed, 18 Dec 2024 10:20:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21q0cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:20:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIAKgoF56557962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 10:20:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C1BD20065;
	Wed, 18 Dec 2024 10:20:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A9B220077;
	Wed, 18 Dec 2024 10:20:40 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Dec 2024 10:20:39 +0000 (GMT)
Date: Wed, 18 Dec 2024 15:50:37 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 10/10] ext4: move out common parts into
 ext4_fallocate()
Message-ID: <Z2Kh9SxYfkIv6NYJ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-11-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-11-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eGsG9_z_Nt28Ue8q5kNxa5bmQB2frOJo
X-Proofpoint-ORIG-GUID: eGsG9_z_Nt28Ue8q5kNxa5bmQB2frOJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=790 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180080

On Mon, Dec 16, 2024 at 09:39:15AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, all zeroing ranges, punch holes, collapse ranges, and insert
> ranges first wait for all existing direct I/O workers to complete, and
> then they acquire the mapping's invalidate lock before performing the
> actual work. These common components are nearly identical, so we can
> simplify the code by factoring them out into the ext4_fallocate().
> 

I really like the long due cleanup of fallocate paths. Thanks for
taking it up! Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/extents.c | 124 ++++++++++++++++------------------------------
>  fs/ext4/inode.c   |  25 ++--------
>  2 files changed, 45 insertions(+), 104 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 85f0de1abe78..1b028be19193 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4568,7 +4568,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  			    loff_t len, int mode)
>  {
>  	struct inode *inode = file_inode(file);
> -	struct address_space *mapping = file->f_mapping;
>  	handle_t *handle = NULL;
>  	loff_t new_size = 0;
>  	loff_t end = offset + len;
> @@ -4592,23 +4591,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  			return ret;
>  	}
>  
> -	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Prevent page faults from reinstantiating pages we have released
> -	 * from page cache.
> -	 */
> -	filemap_invalidate_lock(mapping);
> -
> -	ret = ext4_break_layouts(inode);
> -	if (ret)
> -		goto out_invalidate_lock;
> -
>  	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
>  	/* Preallocate the range including the unaligned edges */
>  	if (!IS_ALIGNED(offset | end, blocksize)) {
> @@ -4618,17 +4600,17 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
>  					     new_size, flags);
>  		if (ret)
> -			goto out_invalidate_lock;
> +			return ret;
>  	}
>  
>  	ret = ext4_update_disksize_before_punch(inode, offset, len);
>  	if (ret)
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	/* Now release the pages and zero block aligned part of pages */
>  	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
>  	if (ret)
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	/* Zero range excluding the unaligned edges */
>  	start_lblk = EXT4_B_TO_LBLK(inode, offset);
> @@ -4640,11 +4622,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
>  					     new_size, flags);
>  		if (ret)
> -			goto out_invalidate_lock;
> +			return ret;
>  	}
>  	/* Finish zeroing out if it doesn't contain partial block */
>  	if (IS_ALIGNED(offset | end, blocksize))
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	/*
>  	 * In worst case we have to writeout two nonadjacent unwritten
> @@ -4657,7 +4639,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		ext4_std_error(inode->i_sb, ret);
> -		goto out_invalidate_lock;
> +		return ret;
>  	}
>  
>  	/* Zero out partial block at the edges of the range */
> @@ -4677,8 +4659,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  
>  out_handle:
>  	ext4_journal_stop(handle);
> -out_invalidate_lock:
> -	filemap_invalidate_unlock(mapping);
>  	return ret;
>  }
>  
> @@ -4711,13 +4691,6 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
>  			goto out;
>  	}
>  
> -	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		goto out;
> -
>  	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
>  				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
>  	if (ret)
> @@ -4742,6 +4715,7 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
>  long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  {
>  	struct inode *inode = file_inode(file);
> +	struct address_space *mapping = file->f_mapping;
>  	int ret;
>  
>  	/*
> @@ -4765,6 +4739,29 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	if (ret)
>  		goto out_inode_lock;
>  
> +	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> +	inode_dio_wait(inode);
> +
> +	ret = file_modified(file);
> +	if (ret)
> +		return ret;
> +
> +	if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
> +		ret = ext4_do_fallocate(file, offset, len, mode);
> +		goto out_inode_lock;
> +	}
> +
> +	/*
> +	 * Follow-up operations will drop page cache, hold invalidate lock
> +	 * to prevent page faults from reinstantiating pages we have
> +	 * released from page cache.
> +	 */
> +	filemap_invalidate_lock(mapping);
> +
> +	ret = ext4_break_layouts(inode);
> +	if (ret)
> +		goto out_invalidate_lock;
> +
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret = ext4_punch_hole(file, offset, len);
>  	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
> @@ -4774,7 +4771,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	else if (mode & FALLOC_FL_ZERO_RANGE)
>  		ret = ext4_zero_range(file, offset, len, mode);
>  	else
> -		ret = ext4_do_fallocate(file, offset, len, mode);
> +		ret = -EOPNOTSUPP;
> +
> +out_invalidate_lock:
> +	filemap_invalidate_unlock(mapping);
>  out_inode_lock:
>  	inode_unlock(inode);
>  	return ret;
> @@ -5301,23 +5301,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	if (end >= inode->i_size)
>  		return -EINVAL;
>  
> -	/* Wait for existing dio to complete */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Prevent page faults from reinstantiating pages we have released from
> -	 * page cache.
> -	 */
> -	filemap_invalidate_lock(mapping);
> -
> -	ret = ext4_break_layouts(inode);
> -	if (ret)
> -		goto out_invalidate_lock;
> -
>  	/*
>  	 * Write tail of the last page before removed range and data that
>  	 * will be shifted since they will get removed from the page cache
> @@ -5331,16 +5314,15 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	if (!ret)
>  		ret = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
>  	if (ret)
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	truncate_pagecache(inode, start);
>  
>  	credits = ext4_writepage_trans_blocks(inode);
>  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
> -	if (IS_ERR(handle)) {
> -		ret = PTR_ERR(handle);
> -		goto out_invalidate_lock;
> -	}
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +
>  	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
>  
>  	start_lblk = offset >> inode->i_blkbits;
> @@ -5379,8 +5361,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  
>  out_handle:
>  	ext4_journal_stop(handle);
> -out_invalidate_lock:
> -	filemap_invalidate_unlock(mapping);
>  	return ret;
>  }
>  
> @@ -5421,23 +5401,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	if (len > inode->i_sb->s_maxbytes - inode->i_size)
>  		return -EFBIG;
>  
> -	/* Wait for existing dio to complete */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Prevent page faults from reinstantiating pages we have released from
> -	 * page cache.
> -	 */
> -	filemap_invalidate_lock(mapping);
> -
> -	ret = ext4_break_layouts(inode);
> -	if (ret)
> -		goto out_invalidate_lock;
> -
>  	/*
>  	 * Write out all dirty pages. Need to round down to align start offset
>  	 * to page size boundary for page size > block size.
> @@ -5445,16 +5408,15 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	start = round_down(offset, PAGE_SIZE);
>  	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
>  	if (ret)
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	truncate_pagecache(inode, start);
>  
>  	credits = ext4_writepage_trans_blocks(inode);
>  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
> -	if (IS_ERR(handle)) {
> -		ret = PTR_ERR(handle);
> -		goto out_invalidate_lock;
> -	}
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +
>  	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
>  
>  	/* Expand file to avoid data loss if there is error while shifting */
> @@ -5525,8 +5487,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  
>  out_handle:
>  	ext4_journal_stop(handle);
> -out_invalidate_lock:
> -	filemap_invalidate_unlock(mapping);
>  	return ret;
>  }
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2e1f070ab449..2677a2cace58 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4009,7 +4009,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	struct inode *inode = file_inode(file);
>  	struct super_block *sb = inode->i_sb;
>  	ext4_lblk_t start_lblk, end_lblk;
> -	struct address_space *mapping = inode->i_mapping;
>  	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
>  	loff_t end = offset + length;
>  	handle_t *handle;
> @@ -4044,31 +4043,15 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  			return ret;
>  	}
>  
> -	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Prevent page faults from reinstantiating pages we have released from
> -	 * page cache.
> -	 */
> -	filemap_invalidate_lock(mapping);
> -
> -	ret = ext4_break_layouts(inode);
> -	if (ret)
> -		goto out_invalidate_lock;
>  
>  	ret = ext4_update_disksize_before_punch(inode, offset, length);
>  	if (ret)
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	/* Now release the pages and zero block aligned part of pages*/
>  	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
>  	if (ret)
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		credits = ext4_writepage_trans_blocks(inode);
> @@ -4078,7 +4061,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		ext4_std_error(sb, ret);
> -		goto out_invalidate_lock;
> +		return ret;
>  	}
>  
>  	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
> @@ -4123,8 +4106,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  		ext4_handle_sync(handle);
>  out_handle:
>  	ext4_journal_stop(handle);
> -out_invalidate_lock:
> -	filemap_invalidate_unlock(mapping);
>  	return ret;
>  }
>  
> -- 
> 2.46.1
> 

