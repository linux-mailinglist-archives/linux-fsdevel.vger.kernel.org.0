Return-Path: <linux-fsdevel+bounces-72339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75330CF0082
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 14:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6B443020CF4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB5730BBAB;
	Sat,  3 Jan 2026 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iRHOdDRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8C3B1BD;
	Sat,  3 Jan 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767448121; cv=none; b=dScylNSOFnD7Pn+q2ZEexm+1UwGBAmQ39+mPi2+0Dlh0Yfuhj8FpzuzRUpvnSCy7DdBcC2K5z1LMD6VFVNznXzPUmHDu15jgfRbC3tWbkgZOJ5yPg4Zl92ubwxeJv0dGI3jaVR3x8Qlf+oYa69IHAf2tYyO46QKyu6XR6grtZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767448121; c=relaxed/simple;
	bh=mWRqdR+3naClpP9JuegqdqWPmlkpHeTEIySzpLwI6lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muWkiNxSoQ9YCqeKUfI+Z3M0XsVCr2hS0i4vcXwoJrahn1L7DHSu9yFHZTro5zS00PoREjUptBvnEHaLsXLmPT4tGy7p63Kozw8Wco+r+gMGjQnZK+LqWXG/AIfIjiJj12SmLqUDlGYv26Nzvxp8SxLaaEvmUiFZePJZ42GgbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iRHOdDRt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 603DaRgt005707;
	Sat, 3 Jan 2026 13:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=20iqiW/9Wg4ktCfjTufRGfxkp/ZVRJ
	ry69rMWdziPKE=; b=iRHOdDRtz8oI+O7aTGUFC9m2EJBTGT16YsLts7NzFr10xT
	NJ9p7Mx2oIHYqi4J3QLBiI6RFUGA16oQ7FgEJiE8ogucBTu3MgwYTLCbsemJNE3K
	i+77n7PzPFfQMEvtkCLdoXV1U50Argq81CpPHFwnYvy0aIl+NcJgdNLgJjD7qy5Y
	CUWXVVzW65kTqSyKGsbMW5/VfZGXG9bNbhytZI42914G0pIHRMD0fofOb34NNZcj
	09icoYCxEvN3dBzsiTcq8V2z9RmCuF7ZJc8omuKUgLyZEWbgmAqwwJehe0UYwrgE
	bTeXnQJaBdefAmuv90VDzY2p+N271MQG/EDa0ckg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4besheh6y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 13:47:55 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 603DltvW024815;
	Sat, 3 Jan 2026 13:47:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4besheh6xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 13:47:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6039ZdeV008053;
	Sat, 3 Jan 2026 13:47:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bav0ka6rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 13:47:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 603DlqEd47317432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Jan 2026 13:47:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65BE120043;
	Sat,  3 Jan 2026 13:47:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B657A20040;
	Sat,  3 Jan 2026 13:47:49 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  3 Jan 2026 13:47:49 +0000 (GMT)
Date: Sat, 3 Jan 2026 19:17:47 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, yi.zhang@huawei.com,
        yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
        yukuai@fnnas.com
Subject: Re: [PATCH -next v2 2/7] ext4: don't split extent before submitting
 I/O
Message-ID: <aVkeAxFsES5kWQRF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223011802.31238-3-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDEyNSBTYWx0ZWRfX21M+/9w9fFAj
 WdUXxwuGkJ4uDeSRTCWIHJtGFl+GCAlHVbFc+D9ZA3IfIrmUkBMAyRRNer6YgRkAYDaoQWe6bAr
 tDkAAHSwuFbhYshRlj1Px4p1MMdetrlEEOr4GCyLEyTydvXdoaFn0ntq72i47ld2WgFPTUo7TRH
 gLCW2OihXOaL5v9Q4VAhG7IwkgQ47JzCzguvJ/doPOT0gOEBN2tmNow/MXjuNf5PjY7NyGRUFTj
 4zqRv+1IDTGOkr3y1lRM4VXGPseo79MpGvPo3GKuLhBFfD+E0EVY0Or7Gj4tc6pApAMVJQNk2O5
 a8//FPRWd39OzNekxpPqy7jWKd8khnP5SnbEmAt0DyMWfm/LSVf6vjdffVjF5S+dhwyDe0Veaf0
 2GRJ4nQ6lzHMEhiPYjEP9RZiDCjG2+IRcTIEpi5RF2Dt6kB+wHa22o43v1ZIIKzOaqRF3MzgyyB
 1Jyn9eJ/5kfC3wWYLZA==
X-Proofpoint-GUID: LtE_acntFsScrbhQ6vKNPJxyDcwZ8v3f
X-Proofpoint-ORIG-GUID: QsMAv_LvTva6Cz3-mteDyp33iXo-39zc
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=69591e0b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=n84QdMwvnG8v0qfENHsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-03_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601030125

On Tue, Dec 23, 2025 at 09:17:57AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, when writing back dirty pages to the filesystem with the
> dioread_nolock feature enabled and when doing DIO, if the area to be
> written back is part of an unwritten extent, the
> EXT4_GET_BLOCKS_IO_CREATE_EXT flag is set during block allocation before
> submitting I/O. The function ext4_split_convert_extents() then attempts
> to split this extent in advance. This approach is designed to prevents
> extent splitting and conversion to the written type from failing due to
> insufficient disk space at the time of I/O completion, which could
> otherwise result in data loss.
> 
> However, we already have two mechanisms to ensure successful extent
> conversion. The first is the EXT4_GET_BLOCKS_METADATA_NOFAIL flag, which
> is a best effort, it permits the use of 2% of the reserved space or
> 4,096 blocks in the file system when splitting extents. This flag covers
> most scenarios where extent splitting might fail. The second is the
> EXT4_EXT_MAY_ZEROOUT flag, which is also set during extent splitting. If
> the reserved space is insufficient and splitting fails, it does not
> retry the allocation. Instead, it directly zeros out the extra part of
> the extent, thereby avoiding splitting and directly converting the
> entire extent to the written type.
> 
> These two mechanisms also exist when I/Os are completed because there is
> a concurrency window between write-back and fallocate, which may still
> require us to split extents upon I/O completion. There is no much
> difference between splitting extents before submitting I/O. Therefore,
> It seems possible to defer the splitting until I/O completion, it won't
> increase the risk of I/O failure and data loss. On the contrary, if some
> I/Os can be merged when I/O completion, it can also reduce unnecessary
> splitting operations, thereby alleviating the pressure on reserved
> space.
> 
> In addition, deferring extent splitting until I/O completion can
> also simplify the IO submission process and avoid initiating unnecessary
> journal handles when writing unwritten extents.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents.c | 13 +------------
>  fs/ext4/inode.c   |  4 ++--
>  2 files changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e53959120b04..c98f7c5482b4 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3787,21 +3787,10 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)ee_block, ee_len);
>  
> -	/* If extent is larger than requested it is a clear sign that we still
> -	 * have some extent state machine issues left. So extent_split is still
> -	 * required.
> -	 * TODO: Once all related issues will be fixed this situation should be
> -	 * illegal.
> -	 */
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
>  		int flags = EXT4_GET_BLOCKS_CONVERT |
>  			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
> -#ifdef CONFIG_EXT4_DEBUG
> -		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
> -			     " len %u; IO logical block %llu, len %u",
> -			     inode->i_ino, (unsigned long long)ee_block, ee_len,
> -			     (unsigned long long)map->m_lblk, map->m_len);
> -#endif
> +
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  						  flags, NULL);
>  		if (IS_ERR(path))
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bb8165582840..ffde24ff7347 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2376,7 +2376,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  
>  	dioread_nolock = ext4_should_dioread_nolock(inode);
>  	if (dioread_nolock)
> -		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
> +		get_blocks_flags |= EXT4_GET_BLOCKS_UNWRIT_EXT;
>  
>  	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
>  	if (err < 0)
> @@ -3744,7 +3744,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>  	else if (EXT4_LBLK_TO_B(inode, map->m_lblk) >= i_size_read(inode))
>  		m_flags = EXT4_GET_BLOCKS_CREATE;
>  	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> +		m_flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
>  
>  	if (flags & IOMAP_ATOMIC)
>  		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
> -- 
> 2.52.0
> 

