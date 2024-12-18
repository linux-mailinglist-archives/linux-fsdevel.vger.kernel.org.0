Return-Path: <linux-fsdevel+bounces-37720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379FB9F629E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59488171233
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83B119AD48;
	Wed, 18 Dec 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lcjH43xM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469118A6A8;
	Wed, 18 Dec 2024 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517163; cv=none; b=LpWzEjjTsWGgDcWJCCeLnWinKF8GUM1M4adrhyCYOEklqAwcCqYA6G3WFoLQJZL7XvbFMXBkHhSVoMVLnHYX8p7meyJ3O4IxV3uv7dd0uQ2SfFXedmMtc1V0M6xa0lnVUI55Wl63iDRxpLypvyk9LmgCGXHFfcK6/79egejSi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517163; c=relaxed/simple;
	bh=s06LiYfkxhc2Y66zrclscevB28JoWMRm98DO+7pf0YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM5lf8V9bAbs8VneByZr+Oop+3FisF/ztJ6zkmtkiJvVIddKxdhOqdZJ8XaVevbuE9xhYSU13W4tokg+kg23MolvDUCTDrLl0kNRyosZ7LegmV21wzUsIipx7GT66x+kjkXQix8J7MNdDcIJpip1IEoH2h6EElk732e4wPVOPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lcjH43xM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHNaNct019010;
	Wed, 18 Dec 2024 10:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=T2x4OECDlc7Vub7GNC97PVIJOO3cst
	kBflq4b5DRUd4=; b=lcjH43xMyaLKN7Ye/YWcP8YJvmpOD01wnBTQLZDeVQFvPE
	Y8ZuKIFOmfjRtPSwq6lZ6BQuryavneKbyOzvzuE/VdPgNlt8hEa7DrAc2cbVnydg
	MwnL7N5WGToziBr2b9uWrOL8Xjugs/e3jxFuVQHECztb0I86dTDZ2sLMk0hAXPdM
	Jm+Nyd5IKJ5saEmDl86fIu/kFftSyL3YCmymq/ji3JgJqBra0rYSF4c+j0kSPyWL
	HaU8P06S3e4M3sFqoZ2QR1AAhEAhT07xsaKVxiYRZet9ckbw29Rermj8mkfXsKyI
	ZjUQoJY5H62ib4hP4nDKkdFQy9W8g3FlE1GTTMUg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kk4aa8wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:19:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI9gime014383;
	Wed, 18 Dec 2024 10:19:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21q070-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:19:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIAJ4VT65143206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 10:19:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17CD620072;
	Wed, 18 Dec 2024 10:19:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 041132006F;
	Wed, 18 Dec 2024 10:19:02 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Dec 2024 10:19:01 +0000 (GMT)
Date: Wed, 18 Dec 2024 15:48:59 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 08/10] ext4: factor out ext4_do_fallocate()
Message-ID: <Z2Khk0kU4THoUEbs@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-9-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qa5p2d-vslfX2uDC-IiZqJjjOsG-60u9
X-Proofpoint-ORIG-GUID: qa5p2d-vslfX2uDC-IiZqJjjOsG-60u9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=833 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180080

On Mon, Dec 16, 2024 at 09:39:13AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now the real job of normal fallocate are open coded in ext4_fallocate(),
> factor out a new helper ext4_do_fallocate() to do the real job, like
> others functions (e.g. ext4_zero_range()) in ext4_fallocate() do, this
> can make the code more clear, no functional changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  fs/ext4/extents.c | 125 ++++++++++++++++++++++------------------------
>  1 file changed, 60 insertions(+), 65 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index be44dd7aacdb..a8bbbf8a9950 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4689,6 +4689,58 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	return ret;
>  }
>  
> +static long ext4_do_fallocate(struct file *file, loff_t offset,
> +			      loff_t len, int mode)
> +{
> +	struct inode *inode = file_inode(file);
> +	loff_t end = offset + len;
> +	loff_t new_size = 0;
> +	ext4_lblk_t start_lblk, len_lblk;
> +	int ret;
> +
> +	trace_ext4_fallocate_enter(inode, offset, len, mode);
> +
> +	start_lblk = offset >> inode->i_blkbits;
> +	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
> +
> +	inode_lock(inode);
> +
> +	/* We only support preallocation for extent-based files only. */
> +	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
> +	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
> +		new_size = end;
> +		ret = inode_newsize_ok(inode, new_size);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> +	inode_dio_wait(inode);
> +
> +	ret = file_modified(file);
> +	if (ret)
> +		goto out;
> +
> +	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
> +				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
> +	if (ret)
> +		goto out;
> +
> +	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
> +		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
> +					EXT4_I(inode)->i_sync_tid);
> +	}
> +out:
> +	inode_unlock(inode);
> +	trace_ext4_fallocate_exit(inode, offset, len_lblk, ret);
> +	return ret;
> +}
> +
>  /*
>   * preallocate space for a file. This implements ext4's fallocate file
>   * operation, which gets called from sys_fallocate system call.
> @@ -4699,12 +4751,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  {
>  	struct inode *inode = file_inode(file);
> -	loff_t new_size = 0;
> -	unsigned int max_blocks;
> -	int ret = 0;
> -	int flags;
> -	ext4_lblk_t lblk;
> -	unsigned int blkbits = inode->i_blkbits;
> +	int ret;
>  
>  	/*
>  	 * Encrypted inodes can't handle collapse range or insert
> @@ -4726,71 +4773,19 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	ret = ext4_convert_inline_data(inode);
>  	inode_unlock(inode);
>  	if (ret)
> -		goto exit;
> +		return ret;
>  
> -	if (mode & FALLOC_FL_PUNCH_HOLE) {
> +	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret = ext4_punch_hole(file, offset, len);
> -		goto exit;
> -	}
> -
> -	if (mode & FALLOC_FL_COLLAPSE_RANGE) {
> +	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
>  		ret = ext4_collapse_range(file, offset, len);
> -		goto exit;
> -	}
> -
> -	if (mode & FALLOC_FL_INSERT_RANGE) {
> +	else if (mode & FALLOC_FL_INSERT_RANGE)
>  		ret = ext4_insert_range(file, offset, len);
> -		goto exit;
> -	}
> -
> -	if (mode & FALLOC_FL_ZERO_RANGE) {
> +	else if (mode & FALLOC_FL_ZERO_RANGE)
>  		ret = ext4_zero_range(file, offset, len, mode);
> -		goto exit;
> -	}
> -	trace_ext4_fallocate_enter(inode, offset, len, mode);
> -	lblk = offset >> blkbits;
> -
> -	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
> -	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
> -
> -	inode_lock(inode);
> -
> -	/*
> -	 * We only support preallocation for extent-based files only
> -	 */
> -	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> -
> -	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
> -	    (offset + len > inode->i_size ||
> -	     offset + len > EXT4_I(inode)->i_disksize)) {
> -		new_size = offset + len;
> -		ret = inode_newsize_ok(inode, new_size);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		goto out;
> -
> -	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
> -	if (ret)
> -		goto out;
> +	else
> +		ret = ext4_do_fallocate(file, offset, len, mode);
>  
> -	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
> -		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
> -					EXT4_I(inode)->i_sync_tid);
> -	}
> -out:
> -	inode_unlock(inode);
> -	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
> -exit:
>  	return ret;
>  }
>  
> -- 
> 2.46.1
> 

