Return-Path: <linux-fsdevel+bounces-37721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C49F62A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F25D18950A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA612199FB2;
	Wed, 18 Dec 2024 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eU3iE+rw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B5198E6F;
	Wed, 18 Dec 2024 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517185; cv=none; b=fY+pCXK9deCWZzhsYueGnrUhiMRrGViLwTLoePhNa52VcQLhBpet9QmwB9QIy3zvdeIzwjyVmqxDZ2p40XoHEaxeWKIUClUMpDmmVoGUNUbKrUsO0gfwMhhTyrTF2ENqiLkZhIJNTkJUY+bELrjs61TRRcIfGDIDt0D6NpBrWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517185; c=relaxed/simple;
	bh=gX41M2ZQ3aAf1oJLF7g2DBRhEDMDnvAOqBHRgkIpU1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOCOWu0l9WnEITrGQL/NTmRiPPnQ7yOkvU4u1EQjNRExgo4X9SoV7ofhpZqu6DRs1xErm7nqN5mgqxTGyh4mPcwBGbFYzVv85h33vO1VP92cqNQbFsMPD8+L3tKNjMlpftOi13s6miEJQL32P9KlripzZFkmfWT1qXmRmOv5k4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eU3iE+rw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI867KI028171;
	Wed, 18 Dec 2024 10:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aOuQMuwLqr1VuArRDHleGWWUv2aDd4
	0O8lpxALTIGVg=; b=eU3iE+rw7JlquzjGrdJl1oLWVQPeeEMIX3Blb/yMqwyNxf
	0TG0ZzgTq25ood+beklWQxhSv96w0HK8E7L9irA+tJfLZ9eVfN8Y1ktRukazPWkS
	QUfAJXtnS3NWbeEKeH+76+ahzy8SGslTI0vS+4hOZ8AnyDFCnbXCz8pnMNKUuLu9
	Z/5C/8Zfi3/lM6M3Okp1rZWu3h5NNbrsCT5IfKtW825XtEn/gxn54u3q/cB7TQCx
	D3qoTOD3tO+jbA+WAkSSZ19+JoNTAmKt/mDKrSSHuw58F+hnzaxKVbJF4rtLwuMX
	Dl91AJS6byu+T2oIeol4qSST2/vcVwjPQxqQh1ow==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ktk2gjup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:19:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI93O3C024041;
	Wed, 18 Dec 2024 10:19:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukf8pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:19:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIAJLrM54526442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 10:19:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16C6A2006A;
	Wed, 18 Dec 2024 10:19:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 286B620067;
	Wed, 18 Dec 2024 10:19:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Dec 2024 10:19:18 +0000 (GMT)
Date: Wed, 18 Dec 2024 15:49:16 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 09/10] ext4: move out inode_lock into ext4_fallocate()
Message-ID: <Z2KhpALL8Vw9EAO8@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-10-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hQ4RrD71myaIYPiIMgi3O_AdWZremhZq
X-Proofpoint-ORIG-GUID: hQ4RrD71myaIYPiIMgi3O_AdWZremhZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1015 mlxlogscore=916 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180080

On Mon, Dec 16, 2024 at 09:39:14AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, all five sub-functions of ext4_fallocate() acquire the
> inode's i_rwsem at the beginning and release it before exiting. This
> process can be simplified by factoring out the management of i_rwsem
> into the ext4_fallocate() function.
> 

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/extents.c | 90 +++++++++++++++--------------------------------
>  fs/ext4/inode.c   | 13 +++----
>  2 files changed, 33 insertions(+), 70 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a8bbbf8a9950..85f0de1abe78 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4578,23 +4578,18 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	int ret, flags, credits;
>  
>  	trace_ext4_zero_range(inode, offset, len, mode);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
>  
> -	inode_lock(inode);
> -
> -	/*
> -	 * Indirect files do not support unwritten extents
> -	 */
> -	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> +	/* Indirect files do not support unwritten extents */
> +	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
> +		return -EOPNOTSUPP;
>  
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
>  	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
>  		new_size = end;
>  		ret = inode_newsize_ok(inode, new_size);
>  		if (ret)
> -			goto out;
> +			return ret;
>  	}
>  
>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> @@ -4602,7 +4597,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released
> @@ -4684,8 +4679,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	ext4_journal_stop(handle);
>  out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out:
> -	inode_unlock(inode);
>  	return ret;
>  }
>  
> @@ -4699,12 +4692,11 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
>  	int ret;
>  
>  	trace_ext4_fallocate_enter(inode, offset, len, mode);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
>  
>  	start_lblk = offset >> inode->i_blkbits;
>  	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
>  
> -	inode_lock(inode);
> -
>  	/* We only support preallocation for extent-based files only. */
>  	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
>  		ret = -EOPNOTSUPP;
> @@ -4736,7 +4728,6 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
>  					EXT4_I(inode)->i_sync_tid);
>  	}
>  out:
> -	inode_unlock(inode);
>  	trace_ext4_fallocate_exit(inode, offset, len_lblk, ret);
>  	return ret;
>  }
> @@ -4771,9 +4762,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  
>  	inode_lock(inode);
>  	ret = ext4_convert_inline_data(inode);
> -	inode_unlock(inode);
>  	if (ret)
> -		return ret;
> +		goto out_inode_lock;
>  
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret = ext4_punch_hole(file, offset, len);
> @@ -4785,7 +4775,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		ret = ext4_zero_range(file, offset, len, mode);
>  	else
>  		ret = ext4_do_fallocate(file, offset, len, mode);
> -
> +out_inode_lock:
> +	inode_unlock(inode);
>  	return ret;
>  }
>  
> @@ -5295,36 +5286,27 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	int ret;
>  
>  	trace_ext4_collapse_range(inode, offset, len);
> -
> -	inode_lock(inode);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
>  
>  	/* Currently just for extent based files */
> -	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> -
> +	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		return -EOPNOTSUPP;
>  	/* Collapse range works only on fs cluster size aligned regions. */
> -	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> +	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
> +		return -EINVAL;
>  	/*
>  	 * There is no need to overlap collapse range with EOF, in which case
>  	 * it is effectively a truncate operation
>  	 */
> -	if (end >= inode->i_size) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (end >= inode->i_size)
> +		return -EINVAL;
>  
>  	/* Wait for existing dio to complete */
>  	inode_dio_wait(inode);
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -5399,8 +5381,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	ext4_journal_stop(handle);
>  out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out:
> -	inode_unlock(inode);
>  	return ret;
>  }
>  
> @@ -5426,39 +5406,27 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	loff_t start;
>  
>  	trace_ext4_insert_range(inode, offset, len);
> -
> -	inode_lock(inode);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
>  
>  	/* Currently just for extent based files */
> -	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> -
> +	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		return -EOPNOTSUPP;
>  	/* Insert range works only on fs cluster size aligned regions. */
> -	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> +	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
> +		return -EINVAL;
>  	/* Offset must be less than i_size */
> -	if (offset >= inode->i_size) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> +	if (offset >= inode->i_size)
> +		return -EINVAL;
>  	/* Check whether the maximum file size would be exceeded */
> -	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
> -		ret = -EFBIG;
> -		goto out;
> -	}
> +	if (len > inode->i_sb->s_maxbytes - inode->i_size)
> +		return -EFBIG;
>  
>  	/* Wait for existing dio to complete */
>  	inode_dio_wait(inode);
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -5559,8 +5527,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	ext4_journal_stop(handle);
>  out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out:
> -	inode_unlock(inode);
>  	return ret;
>  }
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7720d3700b27..2e1f070ab449 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4014,15 +4014,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	loff_t end = offset + length;
>  	handle_t *handle;
>  	unsigned int credits;
> -	int ret = 0;
> +	int ret;
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
> -
> -	inode_lock(inode);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
>  
>  	/* No need to punch hole beyond i_size */
>  	if (offset >= inode->i_size)
> -		goto out;
> +		return 0;
>  
>  	/*
>  	 * If the hole extends beyond i_size, set the hole to end after
> @@ -4042,7 +4041,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (!IS_ALIGNED(offset | end, sb->s_blocksize)) {
>  		ret = ext4_inode_attach_jinode(inode);
>  		if (ret < 0)
> -			goto out;
> +			return ret;
>  	}
>  
>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> @@ -4050,7 +4049,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -4126,8 +4125,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	ext4_journal_stop(handle);
>  out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out:
> -	inode_unlock(inode);
>  	return ret;
>  }
>  
> -- 
> 2.46.1
> 

