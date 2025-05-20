Return-Path: <linux-fsdevel+bounces-49494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B74ABD66C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 13:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68618A499B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 11:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C698328033A;
	Tue, 20 May 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tYSGK4Xb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065727AC2C;
	Tue, 20 May 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739442; cv=none; b=V+PLJreeIevEVMGTkTQkaaeT2XnK2rTBfmYdgFB9S/LTox7Q5Syh4FEZyKgBSI6ouBTOlER7LyaTSwP6ZqH8br1t7LL0tWS31EqzvsenLfIeVu2hJu8FjLnT5rw2l1k/WSHKxmCzWTnxbqD5KSew6DdK2YFcrEiEm+ADuTdofR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739442; c=relaxed/simple;
	bh=xbXRoq3AxcBorszMvGlxF5d+xQMgEiOpuHwx99HBwEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkGwVNnIdzj1dms1Zbil4BuydB9NDwu81KOp6BMg1cdrVTpNTePTW0JjIIR4WBQjQup4FRdcQlxUzRoGNSD9DVGykQSQ7rXeAx9Jjbt0xcDI1HOIApBaB5PXiY4AAoCmD7HrjbKcDj6UF3GIzs51uKu2LtdHgJJ5prV4rs7enME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tYSGK4Xb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6IprO017731;
	Tue, 20 May 2025 11:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZX8Bdf9BE9wqzfTlFo1/yf1IoTK/py
	DTzXpUYRQZ8ss=; b=tYSGK4Xbol7PX5P20ygoWoofChII3yBh6AjNzPWYfKl8fF
	AklUsksxFQf5qcAvPziUG0oQMhMIQv5wYLWabuOPV9FawTrvTISMvURJPNhXs2ZN
	2fIGeNjht+MU5o0eo3wOwyzmr+jFvG7kYBRjQfeCEhZFNEIKY6ofgdjIIWRA+T3M
	jU0o2IIsAk+D6SAwhoFLkAB2LRmzdUf4Lv1SQ8rjdNo9jBEJc+gC2dHGYjD0Wxeu
	Y3e6mUnqb9lqQgt+9bNmgLFWQTGl+41ttXfynNVQ0TEi934ypuPpaF+UhNShpDwh
	Ym4P7hceLXWfCN36VQK/Jqie77h/hxb/YY0JAECw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rmbssb4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 11:10:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54K8OlJC016070;
	Tue, 20 May 2025 11:10:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q7g2b7mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 11:10:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KBAARC19071386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 11:10:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3D8C20117;
	Tue, 20 May 2025 10:48:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3293D20115;
	Tue, 20 May 2025 10:48:19 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.28.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 10:48:18 +0000 (GMT)
Date: Tue, 20 May 2025 16:18:16 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 8/8] ext4: enable large folio for regular file
Message-ID: <aCxd8FndlnTd6DJe@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA5MSBTYWx0ZWRfX8a5KJ86IU+ab ijAMjRYlZvEgtIyzYSOWKlDUBUbikyFLyquvVXbi4CqrzV2pSLhiAVMhK0Xu9w9KqbX/y2idfxv 21ci9hdoHXuMzLfNCRdwW/wsbl0047nv4Wy2xN840xUD7Xiq/qZ/1fRLSwZc/UVERzNBrUFDKBr
 5Fv/S/5NXR8Ri+qSH98a351aQfU3lY/b4Q0/1bL+MdLDfWPSGgR2aQygypAbM4PavQMA/w3xEyQ uMqzBOcEx0bu5BLyjn++8tta9a4puWM3+PkNwfz0Bd2lEW2Bndm5STqTGZSrJSEtKVLWiploA9v uiDZCSH/K7S7quEpVRB1FZM6rqZ6PbBqkQtoNECUQbnQMY0aZWd1C+87aPiwFh4yFO0A0lmM4iH
 /B12p5lISpnGarD8laX5bjMncpBo2pcnYH6VrKK/qF0Aqm/gWmbSB3AhaBus1r7CHpkH2+FU
X-Proofpoint-ORIG-GUID: N0W2yVvvZs4HVNZKxDrx4uatAgRU2mja
X-Proofpoint-GUID: N0W2yVvvZs4HVNZKxDrx4uatAgRU2mja
X-Authority-Analysis: v=2.4 cv=DsxW+H/+ c=1 sm=1 tr=0 ts=682c6318 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=eShqHSH9jOtii2gS3YIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200091

On Mon, May 12, 2025 at 02:33:19PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Besides fsverity, fscrypt, and the data=journal mode, ext4 now supports
> large folios for regular files. Enable this feature by default. However,
> since we cannot change the folio order limitation of mappings on active
> inodes, setting the journal=data mode via ioctl on an active inode will
> not take immediate effect in non-delalloc mode.
> 

Looks good:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks,
Ojaswin

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/ext4.h      |  1 +
>  fs/ext4/ext4_jbd2.c |  3 ++-
>  fs/ext4/ialloc.c    |  3 +++
>  fs/ext4/inode.c     | 20 ++++++++++++++++++++
>  4 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a20e9cd7184..2fad90c30493 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2993,6 +2993,7 @@ int ext4_walk_page_buffers(handle_t *handle,
>  				     struct buffer_head *bh));
>  int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  				struct buffer_head *bh);
> +bool ext4_should_enable_large_folio(struct inode *inode);
>  #define FALL_BACK_TO_NONDELALLOC 1
>  #define CONVERT_INLINE_DATA	 2
>  
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 135e278c832e..b3e9b7bd7978 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -16,7 +16,8 @@ int ext4_inode_journal_mode(struct inode *inode)
>  	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
>  	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
>  	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
> -	    !test_opt(inode->i_sb, DELALLOC))) {
> +	    !test_opt(inode->i_sb, DELALLOC) &&
> +	    !mapping_large_folio_support(inode->i_mapping))) {
>  		/* We do not support data journalling for encrypted data */
>  		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
>  			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index e7ecc7c8a729..4938e78cbadc 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1336,6 +1336,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		}
>  	}
>  
> +	if (ext4_should_enable_large_folio(inode))
> +		mapping_set_large_folios(inode->i_mapping);
> +
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  
>  	err = ext4_mark_inode_dirty(handle, inode);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 29eccdf8315a..7fd3921cfe46 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4774,6 +4774,23 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
>  	return -EFSCORRUPTED;
>  }
>  
> +bool ext4_should_enable_large_folio(struct inode *inode)
> +{
> +	struct super_block *sb = inode->i_sb;
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return false;
> +	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> +	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> +		return false;
> +	if (ext4_has_feature_verity(sb))
> +		return false;
> +	if (ext4_has_feature_encrypt(sb))
> +		return false;
> +
> +	return true;
> +}
> +
>  struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  			  ext4_iget_flags flags, const char *function,
>  			  unsigned int line)
> @@ -5096,6 +5113,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		ret = -EFSCORRUPTED;
>  		goto bad_inode;
>  	}
> +	if (ext4_should_enable_large_folio(inode))
> +		mapping_set_large_folios(inode->i_mapping);
> +
>  	ret = check_igot_inode(inode, flags, function, line);
>  	/*
>  	 * -ESTALE here means there is nothing inherently wrong with the inode,
> -- 
> 2.46.1
> 

