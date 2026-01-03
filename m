Return-Path: <linux-fsdevel+bounces-72345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF37BCF00FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 15:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58E5E302CB83
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFA130DD08;
	Sat,  3 Jan 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PML7pCTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4D23E350;
	Sat,  3 Jan 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767450057; cv=none; b=qDTuaZNV6Si7smE7fXzyRFAsz/pCCw+Kpzax/Kczf3aR8h7ChlvQYRFzfcaGbjFllhncY0hMjErAnNZ5DezajSD6iVekqU7MFfMELADstL1cZOr1XUanQZwOYYBYmUuKX6myl4gdQvDnMQcysvZfZjVirpWy6ZQYgFRUUMqNPgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767450057; c=relaxed/simple;
	bh=mhtdT0N5lOtusN5DU9ihWD/5AYcjKlAv1G96lrfjdNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCcdO1OkH8rkU5hAnhpssufEpF45LjX3THcWJ/oOsad2zujCzqFjUHlqIommPE9SH/zl1DX9ve3XghHUqC1XfJ+/viGX0+ykUY1lN3kLmSpN1+n9KuAdGav8rOpcnxGA8bMzj26DK1RUjfNZWfcx6bVBmmN+Z40SmwQGcBHgjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PML7pCTJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6032xPaF007603;
	Sat, 3 Jan 2026 14:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RDZ3Ym74AbkoabYtF3BoFlAGA20UJu
	V6cz61HIvPAPc=; b=PML7pCTJLEgNvEmTLg7DIkbSLl4rk7oXzQP6kzwG+8eV5W
	YYkxsmwzii18qYWTPQFkmPaL11tGbg4K7yi3VpBXMmHaZzomS9QFvbwFXt6ExRzx
	JSx9KvjSlpeR6Fs09fVb1P5aTpWCnszPrFT++3Ynu6gi6+pmDg+IdU+9f8okgHh9
	mysDuWGLW3UNIXsqUoUiizKmsVIvudEeKr7l5iEKjKhzvNeMrJBf4Lf3dI9WybVB
	Zokr1lbTzzhgcDLFEgHjDi+iHRNLpMmvSeHhgFzSrxkV2Zv5zq++R4VXzkZjLFvX
	PYPO/pLvW0iMHzJUmvw0MINyIcf3YCb9EnS96ZLA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsps7y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:20:20 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 603EKKjv030236;
	Sat, 3 Jan 2026 14:20:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsps7y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:20:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6038Tf7x008412;
	Sat, 3 Jan 2026 14:20:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bav0ka9br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:20:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 603EKHh825559578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Jan 2026 14:20:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 987D220040;
	Sat,  3 Jan 2026 14:20:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D9BA20043;
	Sat,  3 Jan 2026 14:20:14 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  3 Jan 2026 14:20:14 +0000 (GMT)
Date: Sat, 3 Jan 2026 19:50:11 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, yi.zhang@huawei.com,
        yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
        yukuai@fnnas.com
Subject: Re: [PATCH -next v2 7/7] ext4: remove EXT4_GET_BLOCKS_IO_CREATE_EXT
Message-ID: <aVklm3LAg_SBH22S@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223011802.31238-8-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vA9K5n_EWEzZ4djFW2BKgCD_mwzq7taM
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695925a4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=mlgNnLZtXwf3JRKynsoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: IgqUtdBd6uJbxizL6UB6na48gCN9ylmy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDEzMCBTYWx0ZWRfX2dsnnub3uxdk
 hx29Zj7lIOVqYtohCrvaM6wEKVpx7HMZyHNg7SXCnNNWM3KnbUrtJeVHUXYtYlmkGi5VfCACI2G
 f5IA4CGa+Ev7i+Gc+I1a2KCM2UXtQ61jgPjjPLJUxCl2hBQR5hB5T22w/08VswV5CNqqiTYVeHW
 fwUmgCxg+pUSDWKUFV9B/44mRqT4k3wNNGknMyji3ZwbWVx6AXZkb+Sh9Dzj87qBgrRaI+1RtCX
 J6uZiN4lwIdSBhauqWqBSD85BiKFTgM86iibYiTd/6mUciYqU+XNCOL8XVO3lZUpGOHfNSm2B8b
 iwYGEaUswP6+Jx50+EISlgEeBnnHF/p6byXTsYGk1cegjSR9DWAxT+ljP/52IKsE+v7Q7Uo6nik
 9/pSxUDjnw5YrLwnZ0lgl4mb/TWdCUAqOxWFuzb33MFCf3xvtapXobGzupWbRaZ+GMuhZQVesFz
 joLCk5CQPkjfo3hmqZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-03_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601030130

On Tue, Dec 23, 2025 at 09:18:02AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> We do not use EXT4_GET_BLOCKS_IO_CREATE_EXT or split extents before
> submitting I/O; therefore, remove the related code.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Nice, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/ext4.h    |  9 ---------
>  fs/ext4/extents.c | 29 -----------------------------
>  fs/ext4/inode.c   | 11 -----------
>  3 files changed, 49 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9a71357f192d..174c51402864 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -707,15 +707,6 @@ enum {
>  	 * found an unwritten extent, we need to split it.
>  	 */
>  #define EXT4_GET_BLOCKS_SPLIT_NOMERGE		0x0008
> -	/*
> -	 * Caller is from the dio or dioread_nolock buffered IO, reqest to
> -	 * create an unwritten extent if it does not exist or split the
> -	 * found unwritten extent. Also do not merge the newly created
> -	 * unwritten extent, io end will convert unwritten to written,
> -	 * and try to merge the written extent.
> -	 */
> -#define EXT4_GET_BLOCKS_IO_CREATE_EXT		(EXT4_GET_BLOCKS_SPLIT_NOMERGE|\
> -					 EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT)
>  	/* Convert unwritten extent to initialized. */
>  #define EXT4_GET_BLOCKS_CONVERT			0x0010
>  	/* Eventual metadata allocation (due to growing extent tree)
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c98f7c5482b4..c7c66ab825e7 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3925,34 +3925,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	trace_ext4_ext_handle_unwritten_extents(inode, map, flags,
>  						*allocated, newblock);
>  
> -	/* get_block() before submitting IO, split the extent */
> -	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE) {
> -		int depth;
> -
> -		path = ext4_split_convert_extents(handle, inode, map, path,
> -						  flags, allocated);
> -		if (IS_ERR(path))
> -			return path;
> -		/*
> -		 * shouldn't get a 0 allocated when splitting an extent unless
> -		 * m_len is 0 (bug) or extent has been corrupted
> -		 */
> -		if (unlikely(*allocated == 0)) {
> -			EXT4_ERROR_INODE(inode,
> -					 "unexpected allocated == 0, m_len = %u",
> -					 map->m_len);
> -			err = -EFSCORRUPTED;
> -			goto errout;
> -		}
> -		/* Don't mark unwritten if the extent has been zeroed out. */
> -		path = ext4_find_extent(inode, map->m_lblk, path, flags);
> -		if (IS_ERR(path))
> -			return path;
> -		depth = ext_depth(inode);
> -		if (ext4_ext_is_unwritten(path[depth].p_ext))
> -			map->m_flags |= EXT4_MAP_UNWRITTEN;
> -		goto out;
> -	}
>  	/* IO end_io complete, convert the filled extent to written */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT) {
>  		path = ext4_convert_unwritten_extents_endio(handle, inode,
> @@ -4006,7 +3978,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  		goto errout;
>  	}
>  
> -out:
>  	map->m_flags |= EXT4_MAP_NEW;
>  map_out:
>  	map->m_flags |= EXT4_MAP_MAPPED;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 67fe7d0f47e3..2e79b09fe2f0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -588,7 +588,6 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  				  struct ext4_map_blocks *map, int flags)
>  {
> -	struct extent_status es;
>  	unsigned int status;
>  	int err, retval = 0;
>  
> @@ -649,16 +648,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  			return err;
>  	}
>  
> -	/*
> -	 * If the extent has been zeroed out, we don't need to update
> -	 * extent status tree.
> -	 */
> -	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE &&
> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
> -		if (ext4_es_is_written(&es))
> -			return retval;
> -	}
> -
>  	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>  			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,
> -- 
> 2.52.0
> 

