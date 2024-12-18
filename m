Return-Path: <linux-fsdevel+bounces-37715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988439F6240
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F481888713
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 09:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB331991BB;
	Wed, 18 Dec 2024 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qBwVJnCD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287B194A7C;
	Wed, 18 Dec 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734515929; cv=none; b=bn6aR1OqyCfkHlyCQpsPOZCecWzi+WEJGD54Jjiq+cyHnuCyMpNLLqlIk+56C2FGpqjMaYZoqbsYXzPq9xA2TJaa3WS7lrxH8gcSw8iT+ozs0lDCqndotwMs3dCuTFZ3EEzZvjzeCa8sFHAVc31xI5vM6wjVGFYzjLpIlE7+PMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734515929; c=relaxed/simple;
	bh=f5uNLv7U1R/d1PAezCRSLP/TspqNJUNG0eLx4UY7sHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ5Qrrtpc0i05s1YOTswojEQALhiuMILezzagow1SS0ieAA5d076rsRt1gi9cQ6t0rksFZqZr9moP7pFTnen3xfJ6D0G+YRgtMCaeYC63VuQjrbEsgtI7r4t5mbwGz6Cd2CmsGWwnjCUOMQR5qFP12Tlfl/Xbh0npO3dQZYUmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qBwVJnCD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHNwUFY000703;
	Wed, 18 Dec 2024 09:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Y3bS/uJoA7REFsauDvfvC/TvEatNUL
	iq0EoWQhLvc1g=; b=qBwVJnCDWBc/0pIrtU9dYb0JM4ux467ISyow9i1dBjmX4I
	O6lk3Iw8P641VJuS7lua9F1Q7Llvmxky1ZnRwLlEM1Jg/jApbiOYS9AL51M2lpLm
	RvOc5WN3KRONqLGaRRvDmz1XhxzWVSGVoh4edUUDdHw2FAyjLLGOOM4iSEJ1euEx
	p9FlxmF7eYbveIsj4A5iq3Him+wI+Zhe/Wo3bkhjE1/VcvuMTsejK7Yqf/lMSaBN
	3AcRDmfeyVh1iZfYwlPDRyoFT6D+KcvinaeP5dauFK/QG1OAi6GG5Zyw3sOKIyG2
	5Xdb4+FPyHKspgB7yoe03jzMma7G/farH8+GePZQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kkeha6xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 09:58:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI7DO8f029312;
	Wed, 18 Dec 2024 09:58:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsqg2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 09:58:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BI9wRv339322030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 09:58:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 967F420043;
	Wed, 18 Dec 2024 09:58:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B0E62004B;
	Wed, 18 Dec 2024 09:58:25 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Dec 2024 09:58:25 +0000 (GMT)
Date: Wed, 18 Dec 2024 15:28:23 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 02/10] ext4: don't explicit update times in
 ext4_fallocate()
Message-ID: <Z2Kcv8PiaE5q490j@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-3-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uq7jUPdXgVUko24T_aq8qpjQRfSgmaQO
X-Proofpoint-ORIG-GUID: Uq7jUPdXgVUko24T_aq8qpjQRfSgmaQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=743 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412180076

On Mon, Dec 16, 2024 at 09:39:07AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After commit 'ad5cd4f4ee4d ("ext4: fix fallocate to use file_modified to
> update permissions consistently"), we can update mtime and ctime
> appropriately through file_modified() when doing zero range, collapse
> rage, insert range and punch hole, hence there is no need to explicit
> update times in those paths, just drop them.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  fs/ext4/extents.c | 5 -----
>  fs/ext4/inode.c   | 1 -
>  2 files changed, 6 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 8dc6b4271b15..7fb38aab241d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4674,8 +4674,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  			goto out_mutex;
>  		}
>  
> -		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> -
>  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
>  					     flags);
>  		filemap_invalidate_unlock(mapping);
> @@ -4699,7 +4697,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		goto out_mutex;
>  	}
>  
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  	if (new_size)
>  		ext4_update_inode_size(inode, new_size);
>  	ret = ext4_mark_inode_dirty(handle, inode);
> @@ -5435,7 +5432,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  	if (IS_SYNC(inode))
>  		ext4_handle_sync(handle);
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  	ret = ext4_mark_inode_dirty(handle, inode);
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  
> @@ -5545,7 +5541,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	/* Expand file to avoid data loss if there is error while shifting */
>  	inode->i_size += len;
>  	EXT4_I(inode)->i_disksize += len;
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  	ret = ext4_mark_inode_dirty(handle, inode);
>  	if (ret)
>  		goto out_stop;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c68a8b841148..bf735d06b621 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4138,7 +4138,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (IS_SYNC(inode))
>  		ext4_handle_sync(handle);
>  
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  	ret2 = ext4_mark_inode_dirty(handle, inode);
>  	if (unlikely(ret2))
>  		ret = ret2;
> -- 
> 2.46.1
> 

