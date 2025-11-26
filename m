Return-Path: <linux-fsdevel+bounces-69877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89548C89832
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 535204E57A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD621322A00;
	Wed, 26 Nov 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hzt1ns2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DDC32142D;
	Wed, 26 Nov 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156471; cv=none; b=AXF65kL4lmCfp413UzMY12LdM2dMXZBZcM4EWzxX8OZrPPhf1dk3D78Gyv1Xi22JS/uOxzjC7k02WgozT42ep73VRur/c83VyBzMN2bdDbRlmnEt3IxeO848AMjBo26Faw5lXOXrJD9nfUXc8xa0iz377E1CEDgt1M0gjlPCtCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156471; c=relaxed/simple;
	bh=U5MRymRa5wlmvuipGy9e6jweYIfYATs9w3xQFYLvgns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzetEKyFoKMycC1X6iGEW45F5SBJkM6Q0gUSCIy0F5UKO5Ek/rwIwuNLlLQ+SZ08zi49jn1Aym7/EyCUe+WXDcL7fwSjMvXG/CdYvujuLbgtFTr2lVdvj1juAMIwPsiUy9B+qAecsZmDAgXK0VcyvdcS5jXP6BCinftVLtv/uM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hzt1ns2C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQB74FY012833;
	Wed, 26 Nov 2025 11:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tH57Ax0Pr7fEfYdprtVu7WjKDuAtFW
	MDEmZlel3I6PA=; b=hzt1ns2CtRh63EN/u5JDL+GK+dr4fGUEN7OqVT6GLrJ626
	GM0aA6uFfHPOtNW07BGJseA2yzmiGSFZOHvmpoj3VMJ5UYdw0I1emHM4vVTszwIe
	EAMbge+mY7002E9aaToUbFofTjPl85QT8XoM2Bu/OFpx58rmipyuJneNwgjURUyW
	q/O/LX/Vd4ttgfg5B2hq8F5yvTU3rZ7nNEyw6evpMyEoIdG+FkmQerVRGEloOjgD
	Ftr4hVryfBTqZJEBe5QL+YdGGiRxUrpPhzk0Cir4Ocq7kouo9waHUTYIa80Ny4Iz
	KQ7kkbTKMyLtRi3hA81XjpBs5bmNyhb4v2HcsWEw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u22rq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:27:36 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQBQPPZ005318;
	Wed, 26 Nov 2025 11:27:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u22rq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:27:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQBBob1030778;
	Wed, 26 Nov 2025 11:27:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgsj50k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:27:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQBRYqU42271106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:27:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E76A520040;
	Wed, 26 Nov 2025 11:27:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4412820043;
	Wed, 26 Nov 2025 11:27:30 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 11:27:30 +0000 (GMT)
Date: Wed, 26 Nov 2025 16:57:27 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 02/13] ext4: subdivide EXT4_EXT_DATA_VALID1
Message-ID: <aSbkH3HkHFxBZ45-@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-3-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX1XhkKxCQhZDt
 u5Ikyri7vSMjckFBDBOLUoSz2MSdGXMMeqH7cO/KUTV0oka708dN7ioReI/BCEPFxyb/l05y7Kj
 xDFfqG0xWS16S1jBf2ZP4v0thg86nRF9NurkUNO+bBbCKcBXZz7ZXt0RBrUlwUSJuORQ5B/tn7/
 jT/CUTmYs776Jh96oyGdO4aGRJknM2g7FKdQ4YBR2Hv1xUDnYGRukznmpYgp632jCptpW8TXX4P
 JlfjK+OHRsj95HeujyiO8Ilisn4I+89UK5DyBBHAxNgPw2w+2P7Bw2Dj4YVVdq/0Bk2p5TMrNX1
 CiDDG6ZHYAqMJlhbEMX7uqBd6inieHVBe0tqSH/xKIJk2mxSbJyoEt2wPLL/Z6moQRm03I9sNtN
 tiWbuVSfcX/GkmEhPi59aJnQXDFHbA==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=6926e429 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=X5QvFoTBmktik7cTCq4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 9pGPNPOJ8WrOZr9OEjuGCp0P1rhk9hRz
X-Proofpoint-GUID: U4GlWa4qf2GD3-Z9X4VVGoDm52soOBtV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220021

On Fri, Nov 21, 2025 at 02:08:00PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When splitting an extent, if the EXT4_GET_BLOCKS_CONVERT flag is set and
> it is necessary to split the target extent in the middle,
> ext4_split_extent() first handles splitting the latter half of the
> extent and passes the EXT4_EXT_DATA_VALID1 flag. This flag implies that
> all blocks before the split point contain valid data; however, this
> assumption is incorrect.
> 
> Therefore, subdivid EXT4_EXT_DATA_VALID1 into
> EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_DATA_PARTIAL_VALID1, which
> indicate that the first half of the extent is either entirely valid or
> only partially valid, respectively. These two flags cannot be set
> simultaneously.
> 
> This patch does not use EXT4_EXT_DATA_PARTIAL_VALID1, it only replaces
> EXT4_EXT_DATA_VALID1 with EXT4_EXT_DATA_ENTIRE_VALID1 at the location
> where it is set, no logical changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  fs/ext4/extents.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 91682966597d..f7aa497e5d6c 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -43,8 +43,13 @@
>  #define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
>  #define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */
>  
> -#define EXT4_EXT_DATA_VALID1	0x8  /* first half contains valid data */
> -#define EXT4_EXT_DATA_VALID2	0x10 /* second half contains valid data */
> +/* first half contains valid data */
> +#define EXT4_EXT_DATA_ENTIRE_VALID1	0x8   /* has partially valid data */
> +#define EXT4_EXT_DATA_PARTIAL_VALID1	0x10  /* has entirely valid data */
> +#define EXT4_EXT_DATA_VALID1		(EXT4_EXT_DATA_ENTIRE_VALID1 | \
> +					 EXT4_EXT_DATA_PARTIAL_VALID1)
> +
> +#define EXT4_EXT_DATA_VALID2	0x20 /* second half contains valid data */
>  
>  static __le32 ext4_extent_block_csum(struct inode *inode,
>  				     struct ext4_extent_header *eh)
> @@ -3190,8 +3195,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  	unsigned int ee_len, depth;
>  	int err = 0;
>  
> -	BUG_ON((split_flag & (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2)) ==
> -	       (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2));
> +	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) == EXT4_EXT_DATA_VALID1);
> +	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
> +	       (split_flag & EXT4_EXT_DATA_VALID2));
>  
>  	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
>  
> @@ -3358,7 +3364,7 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
>  				       EXT4_EXT_MARK_UNWRIT2;
>  		if (split_flag & EXT4_EXT_DATA_VALID2)
> -			split_flag1 |= EXT4_EXT_DATA_VALID1;
> +			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
>  		path = ext4_split_extent_at(handle, inode, path,
>  				map->m_lblk + map->m_len, split_flag1, flags1);
>  		if (IS_ERR(path))
> @@ -3717,7 +3723,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  
>  	/* Convert to unwritten */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
> -		split_flag |= EXT4_EXT_DATA_VALID1;
> +		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
>  	/* Convert to initialized */
>  	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
>  		split_flag |= ee_block + ee_len <= eof_block ?
> -- 
> 2.46.1
> 

