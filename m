Return-Path: <linux-fsdevel+bounces-69882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF6DC89980
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AF13B33AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85D3254A7;
	Wed, 26 Nov 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H06a3pYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01C28688C;
	Wed, 26 Nov 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157878; cv=none; b=cGycBOPx29nD/HqvOqlsar4qtP+53plw1zYymdPuSa3oRmVF37EeiUZGUVF8x9dGrWqsqCNqQkZWxF8WZgdNoR5clWct0xU97/5ffPmmGdhm9nV5wesRk/KcPGScczt5NKTn46C9f6SUxnC5KQ4T/qUi7gDn22Y/oFKDEFJ1KF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157878; c=relaxed/simple;
	bh=9buDUVenNSbl0iQ9G/8eEDMbr1pqN20zrAGQR2SqgWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAfoPDoxwix3WKGD2t2jG5+In/EqM3sbPF4n8r1+Qlz6olpjeqU1WfXd1QbwR+xDAfJ3JoWyB9ZO0JaXJzuzJggT24RgHwlryglyFynJ41BXCxFjQzge2nfInFx/Kl8R4wuCEMq5ORBO8y7zyP29ZxhsLktq2lKoCQyKiWVwv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H06a3pYk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ2PXbA008804;
	Wed, 26 Nov 2025 11:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9RH7tjFlyKNOPNOqzBqQMG0OH1ttow
	DhYa9CxtQoWOo=; b=H06a3pYkBkKhntdYswiSz9uEIuHd/OW3NOVeKABNsX7VXd
	XPJum4MOpWs9Pv15ahjMcYepJiJ4HqeS9PKkocB/tyrPGCTTlq7S/hNj9tsZsLvX
	6Kr6fxLbrxi9s6h6UI351MbjcMJFPMHgjrjEN7lcdKm1uquRcsN9OGYoy7FrFppu
	h6SxmbQlgKnn76ntjPHxpHnD4RDGtSqS1GSO1cYfsEDsf+BPXik1E9/73h8ucOD1
	9g/frdPWwr89NJcBZSBY8wCCaoCmom7Ze/VPdVtAZuLsRc+WCaVIUORFyOgWCMeA
	30gTj89GN7bdaLMvTnlNCmSdifMsbd1zfbyNoO4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9kv0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:51:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQBp3e3002927;
	Wed, 26 Nov 2025 11:51:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9kv0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:51:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQAphxa025089;
	Wed, 26 Nov 2025 11:51:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71htu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:51:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQBp1Kh48955798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:51:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3718A20043;
	Wed, 26 Nov 2025 11:51:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62DD920040;
	Wed, 26 Nov 2025 11:50:58 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 11:50:58 +0000 (GMT)
Date: Wed, 26 Nov 2025 17:20:55 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 04/13] ext4: don't set EXT4_GET_BLOCKS_CONVERT when
 splitting before submitting I/O
Message-ID: <aSbpn7xquvdglW21@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-5-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfXxqnAbyzVRhGN
 6SDsjK/rtXx4r7a7MO8cR4hKvQyOSA5iG51Gl2KDuVxBtG1FOQpbtPuRXclCH7b9zdtG+DddNTF
 r5PKF9D3RBtjkVYrdVHr8S7Td1mNIl/492BaAvcT0R99QjI8+Ly/44UaSd8sJbrfhWdy3pWQT7r
 s247yTMUoS+UlwL9poGT6H0gglsI3wiAj5zZf6gY/eU1mC4KvuLw9WmP3vxdksTtsuWI3gfn/AZ
 6o6GSoYwgnYFnAcvWW3TuzSv5y8jyxCzVDqCC9ThjQgte6at9qnxrVv6PPL1K0IApXfw07muSA+
 65s8f795iNDMJUl+FyISumxWBHfFdLULzrluPxMWqIbHrEvbtb1xVgy+DebQhEB4oaH9FBZ3UL1
 tfuuSmh85A3ZsbMd3hLczNFIdb1Vcw==
X-Proofpoint-ORIG-GUID: PuHngoFKwZpmn5RY01FhePFOI78cFUuV
X-Proofpoint-GUID: 5rPWB0KvRuFv21PzhiQQmr9xqI2xN8Mn
X-Authority-Analysis: v=2.4 cv=TMJIilla c=1 sm=1 tr=0 ts=6926e9a8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=RPK8XPxtaZJAbN14I0kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

On Fri, Nov 21, 2025 at 02:08:02PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When allocating blocks during within-EOF DIO and writeback with
> dioread_nolock enabled, EXT4_GET_BLOCKS_PRE_IO was set to split an
> existing large unwritten extent. However, EXT4_GET_BLOCKS_CONVERT was
> set when calling ext4_split_convert_extents(), which may potentially
> result in stale data issues.
> 
> Assume we have an unwritten extent, and then DIO writes the second half.
> 
>    [UUUUUUUUUUUUUUUU] on-disk extent        U: unwritten extent
>    [UUUUUUUUUUUUUUUU] extent status tree
>             |<-   ->| ----> dio write this range
> 
> First, ext4_iomap_alloc() call ext4_map_blocks() with
> EXT4_GET_BLOCKS_PRE_IO, EXT4_GET_BLOCKS_UNWRIT_EXT and
> EXT4_GET_BLOCKS_CREATE flags set. ext4_map_blocks() find this extent and
> call ext4_split_convert_extents() with EXT4_GET_BLOCKS_CONVERT and the
> above flags set.
> 
> Then, ext4_split_convert_extents() calls ext4_split_extent() with
> EXT4_EXT_MAY_ZEROOUT, EXT4_EXT_MARK_UNWRIT2 and EXT4_EXT_DATA_VALID2
> flags set, and it calls ext4_split_extent_at() to split the second half
> with EXT4_EXT_DATA_VALID2, EXT4_EXT_MARK_UNWRIT1, EXT4_EXT_MAY_ZEROOUT
> and EXT4_EXT_MARK_UNWRIT2 flags set. However, ext4_split_extent_at()
> failed to insert extent since a temporary lack -ENOSPC. It zeroes out
> the first half but convert the entire on-disk extent to written since
> the EXT4_EXT_DATA_VALID2 flag set, but left the second half as unwritten
> in the extent status tree.
> 
>    [0000000000SSSSSS]  data                S: stale data, 0: zeroed
>    [WWWWWWWWWWWWWWWW]  on-disk extent      W: written extent
>    [WWWWWWWWWWUUUUUU]  extent status tree
> 
> Finally, if the DIO failed to write data to the disk, the stale data in
> the second half will be exposed once the cached extent entry is gone.
> 
> Fix this issue by not passing EXT4_GET_BLOCKS_CONVERT when splitting
> an unwritten extent before submitting I/O, and make
> ext4_split_convert_extents() to zero out the entire extent range
> to zero for this case, and also mark the extent in the extent status
> tree for consistency.

Hi Yi,

Your analysis makes sense to me and I agree that passing CONVERT flag
there might not have been correct since we are not neccessarily
converting the extent to initialized.

Other than that, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/extents.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index cafe66cb562f..2db84f6b0056 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3733,11 +3733,15 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  	/* Convert to unwritten */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
>  		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
> -	/* Convert to initialized */
> -	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
> +	/* Split the existing unwritten extent */
> +	} else if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
> +			    EXT4_GET_BLOCKS_CONVERT)) {
>  		split_flag |= ee_block + ee_len <= eof_block ?
>  			      EXT4_EXT_MAY_ZEROOUT : 0;
> -		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
> +		split_flag |= EXT4_EXT_MARK_UNWRIT2;
> +		/* Convert to initialized */
> +		if (flags & EXT4_GET_BLOCKS_CONVERT)
> +			split_flag |= EXT4_EXT_DATA_VALID2;
>  	}
>  	flags |= EXT4_GET_BLOCKS_PRE_IO;
>  	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
> @@ -3913,7 +3917,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	/* get_block() before submitting IO, split the extent */
>  	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
>  		path = ext4_split_convert_extents(handle, inode, map, path,
> -				flags | EXT4_GET_BLOCKS_CONVERT, allocated);
> +						  flags, allocated);
>  		if (IS_ERR(path))
>  			return path;
>  		/*
> -- 
> 2.46.1
> 

