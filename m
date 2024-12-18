Return-Path: <linux-fsdevel+bounces-37719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF4C9F629A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86EB171023
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC519939D;
	Wed, 18 Dec 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rl0AIeYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2FD1991B8;
	Wed, 18 Dec 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517142; cv=none; b=mmg0W5jDWAcfqeXRYDUH/g9ki9fdCvb8BhsEo8OtPY39zHqzP55GMhsjBDt4KA15uZQ2g/oxduBziAqaGvdwC14UGrDRvWXLWTB/lQYv9LoeCRgdqN7r5JQGOwQLomthIk4M59Khgw1xOS5ibl7WEY4rXjkP7EdSdFx7fE09S4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517142; c=relaxed/simple;
	bh=w3XguxqXmvl1VV6NAI5UF9bh/F8qllwv7hM3eX+WUW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuCwCKTNiXmmu8VEMghAwSrlWkrFlpoYzk6LQ3b8kQ/4cXhUOOt+FwSEZSQvkCmnd0W8o6xaZPtBwxa5lcM1qpMQcKDS8UcGrkbH00iTfPx7+IFaSrLaC4Fn02iWTbbTYTiL8DOwK/etKG57dazmNNUSVu9TipTbHTy/wPbL3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rl0AIeYj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHNaotn019933;
	Wed, 18 Dec 2024 10:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=O9l79YHMhDOgLM6jadK9LgBf5ICaIM
	sidGjZGj48u3Y=; b=Rl0AIeYjr8bng6zJWiQ+ECmnsH6Ns3fSUif4CEFx0cTkt2
	i9LM4WhMpHIQYuSm69LmA6Ka4P0VQPHdBc18K95LFydd9nU1U2Q2gqAICtIUhaQc
	A89HM1TNPyIuS8lMpaT7R2vY2K8wO2lCTA3wSztq+A/yoFayepPWGgpuSkUA9DXt
	S+3uDEr2b0PfwrR/WozoHG+f98b1fib6Tnb9ucBzMHTnrc0Km9Y6YueOXq3V9nFg
	qElAqaxMZd0UJUACj5IbswDNaEAy2TViKXdpiD/sb8zVAAm93KrBthQTAYUN0ZSa
	kpoQYNCzeMXpTNCcjOqJWv0mqf+TSOHm4UqYou5w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kk4aa8ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:18:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI7DODm029312;
	Wed, 18 Dec 2024 10:18:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsqjh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:18:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIAIapX17826098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 10:18:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35AA420065;
	Wed, 18 Dec 2024 10:18:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24FBF2004F;
	Wed, 18 Dec 2024 10:18:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Dec 2024 10:18:33 +0000 (GMT)
Date: Wed, 18 Dec 2024 15:48:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 07/10] ext4: refactor ext4_insert_range()
Message-ID: <Z2Khd9+DUhqzCvjh@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-8-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FfsvhJdoH6XpXBf6GW3Z4LIFXhPk8obK
X-Proofpoint-ORIG-GUID: FfsvhJdoH6XpXBf6GW3Z4LIFXhPk8obK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180080

On Mon, Dec 16, 2024 at 09:39:12AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Simplify ext4_insert_range() and align its code style with that of
> ext4_collapse_range(). Refactor it by: a) renaming variables, b)
> removing redundant input parameter checks and moving the remaining
> checks under i_rwsem in preparation for future refactoring, and c)
> renaming the three stale error tags.

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/extents.c | 101 ++++++++++++++++++++++------------------------
>  1 file changed, 48 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 8a0a720803a8..be44dd7aacdb 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5425,45 +5425,37 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	handle_t *handle;
>  	struct ext4_ext_path *path;
>  	struct ext4_extent *extent;
> -	ext4_lblk_t offset_lblk, len_lblk, ee_start_lblk = 0;
> +	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
>  	unsigned int credits, ee_len;
> -	int ret = 0, depth, split_flag = 0;
> -	loff_t ioffset;
> -
> -	/*
> -	 * We need to test this early because xfstests assumes that an
> -	 * insert range of (0, 1) will return EOPNOTSUPP if the file
> -	 * system does not support insert range.
> -	 */
> -	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		return -EOPNOTSUPP;
> -
> -	/* Insert range works only on fs cluster size aligned regions. */
> -	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
> -		return -EINVAL;
> +	int ret, depth, split_flag = 0;
> +	loff_t start;
>  
>  	trace_ext4_insert_range(inode, offset, len);
>  
> -	offset_lblk = offset >> EXT4_BLOCK_SIZE_BITS(sb);
> -	len_lblk = len >> EXT4_BLOCK_SIZE_BITS(sb);
> -
>  	inode_lock(inode);
> +
>  	/* Currently just for extent based files */
>  	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
>  		ret = -EOPNOTSUPP;
> -		goto out_mutex;
> +		goto out;
>  	}
>  
> -	/* Check whether the maximum file size would be exceeded */
> -	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
> -		ret = -EFBIG;
> -		goto out_mutex;
> +	/* Insert range works only on fs cluster size aligned regions. */
> +	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  
>  	/* Offset must be less than i_size */
>  	if (offset >= inode->i_size) {
>  		ret = -EINVAL;
> -		goto out_mutex;
> +		goto out;
> +	}
> +
> +	/* Check whether the maximum file size would be exceeded */
> +	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
> +		ret = -EFBIG;
> +		goto out;
>  	}
>  
>  	/* Wait for existing dio to complete */
> @@ -5471,7 +5463,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -5481,25 +5473,24 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  
>  	ret = ext4_break_layouts(inode);
>  	if (ret)
> -		goto out_mmap;
> +		goto out_invalidate_lock;
>  
>  	/*
> -	 * Need to round down to align start offset to page size boundary
> -	 * for page size > block size.
> +	 * Write out all dirty pages. Need to round down to align start offset
> +	 * to page size boundary for page size > block size.
>  	 */
> -	ioffset = round_down(offset, PAGE_SIZE);
> -	/* Write out all dirty pages */
> -	ret = filemap_write_and_wait_range(inode->i_mapping, ioffset,
> -			LLONG_MAX);
> +	start = round_down(offset, PAGE_SIZE);
> +	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
>  	if (ret)
> -		goto out_mmap;
> -	truncate_pagecache(inode, ioffset);
> +		goto out_invalidate_lock;
> +
> +	truncate_pagecache(inode, start);
>  
>  	credits = ext4_writepage_trans_blocks(inode);
>  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
> -		goto out_mmap;
> +		goto out_invalidate_lock;
>  	}
>  	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
>  
> @@ -5508,16 +5499,19 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	EXT4_I(inode)->i_disksize += len;
>  	ret = ext4_mark_inode_dirty(handle, inode);
>  	if (ret)
> -		goto out_stop;
> +		goto out_handle;
> +
> +	start_lblk = offset >> inode->i_blkbits;
> +	len_lblk = len >> inode->i_blkbits;
>  
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  	ext4_discard_preallocations(inode);
>  
> -	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
> +	path = ext4_find_extent(inode, start_lblk, NULL, 0);
>  	if (IS_ERR(path)) {
>  		up_write(&EXT4_I(inode)->i_data_sem);
>  		ret = PTR_ERR(path);
> -		goto out_stop;
> +		goto out_handle;
>  	}
>  
>  	depth = ext_depth(inode);
> @@ -5527,16 +5521,16 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  		ee_len = ext4_ext_get_actual_len(extent);
>  
>  		/*
> -		 * If offset_lblk is not the starting block of extent, split
> -		 * the extent @offset_lblk
> +		 * If start_lblk is not the starting block of extent, split
> +		 * the extent @start_lblk
>  		 */
> -		if ((offset_lblk > ee_start_lblk) &&
> -				(offset_lblk < (ee_start_lblk + ee_len))) {
> +		if ((start_lblk > ee_start_lblk) &&
> +				(start_lblk < (ee_start_lblk + ee_len))) {
>  			if (ext4_ext_is_unwritten(extent))
>  				split_flag = EXT4_EXT_MARK_UNWRIT1 |
>  					EXT4_EXT_MARK_UNWRIT2;
>  			path = ext4_split_extent_at(handle, inode, path,
> -					offset_lblk, split_flag,
> +					start_lblk, split_flag,
>  					EXT4_EX_NOCACHE |
>  					EXT4_GET_BLOCKS_PRE_IO |
>  					EXT4_GET_BLOCKS_METADATA_NOFAIL);
> @@ -5545,31 +5539,32 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  		if (IS_ERR(path)) {
>  			up_write(&EXT4_I(inode)->i_data_sem);
>  			ret = PTR_ERR(path);
> -			goto out_stop;
> +			goto out_handle;
>  		}
>  	}
>  
>  	ext4_free_ext_path(path);
> -	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
> +	ext4_es_remove_extent(inode, start_lblk, EXT_MAX_BLOCKS - start_lblk);
>  
>  	/*
> -	 * if offset_lblk lies in a hole which is at start of file, use
> +	 * if start_lblk lies in a hole which is at start of file, use
>  	 * ee_start_lblk to shift extents
>  	 */
>  	ret = ext4_ext_shift_extents(inode, handle,
> -		max(ee_start_lblk, offset_lblk), len_lblk, SHIFT_RIGHT);
> -
> +		max(ee_start_lblk, start_lblk), len_lblk, SHIFT_RIGHT);
>  	up_write(&EXT4_I(inode)->i_data_sem);
> +	if (ret)
> +		goto out_handle;
> +
> +	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	if (IS_SYNC(inode))
>  		ext4_handle_sync(handle);
> -	if (ret >= 0)
> -		ext4_update_inode_fsync_trans(handle, inode, 1);
>  
> -out_stop:
> +out_handle:
>  	ext4_journal_stop(handle);
> -out_mmap:
> +out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out_mutex:
> +out:
>  	inode_unlock(inode);
>  	return ret;
>  }
> -- 
> 2.46.1
> 

