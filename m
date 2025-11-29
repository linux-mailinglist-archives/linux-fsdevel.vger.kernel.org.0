Return-Path: <linux-fsdevel+bounces-70265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522C3C945E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 18:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081CF3A7531
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 17:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A8130FC2D;
	Sat, 29 Nov 2025 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ish+qb+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7A1E3DDB;
	Sat, 29 Nov 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437792; cv=none; b=Q84ysggf3abB2o390t7lpr69HNjDvvt+rQmyC83/L0dhudjZ04DgkigDc01PFdskzj5NyCZKZFtcLH+Q6TrTeuDHKeGULSIM7eFeICcts++R44m2B0xgkbWUj9IGXzujti08ePGdTF6pGT9EUws6bCvnE/gPntvjUo8qWg0C9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437792; c=relaxed/simple;
	bh=w/okGBZBm5nuZ9ThtwDbqvn7TI4ZA8bYP63qOnSVVEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KICzihkQszcpVDM+tuuwIElkLXKHYv9ltgN11K1JC9aahbkdCxyNuq32BJ2UwPvrGosfvEFePS1ShiHRL3A/3uMMSI2PQ/QesAu3Jwwu0Fu/c/HpgJ+sPny3mG+rk/oAjGyeNA12lvx3+B3KK4dc7K+DP8B2INU4ejL7jx8Km/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ish+qb+w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATDu6Wh029247;
	Sat, 29 Nov 2025 17:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=N0M+MnCPiRbiKqa8OaoGMr9lX4bDLx
	sMwn1usjcvbUg=; b=Ish+qb+wmgc46Ls5TNs5eNQaqCho5X7U8FpvDKa6F5oIgs
	t2t/5v8Emnv96ipiP2hZitHqxd/ZeqevxMnV0Og7kea8Lb3ZtqyWgWuHRMyPmogz
	wHjBhnv/mGs0Om7q8DTGWKdza/KdM1682MNTVH7VLgqyI/g+IJNd9l5HbcGLatSq
	KjX2bGlvRC5ei31jnRVb/KCyzcMfZqELo1NQea/8OExEPwEvXzdV3JFCFbtILSnu
	/hwT7axMi+GhUWpdw6pUTefD7uCpuaU+grEHIQxncbjxCU+B0xlPXorfCbZZICCd
	lrdv7SXq2o9+qzq6CfPmaoMltNNyEMzVMZrqLbCg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbfsc9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 17:36:12 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ATHaCwm020137;
	Sat, 29 Nov 2025 17:36:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbfsc98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 17:36:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATFPDhM013794;
	Sat, 29 Nov 2025 17:36:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgnsw7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 17:36:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ATHa8EA42926366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Nov 2025 17:36:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B800220043;
	Sat, 29 Nov 2025 17:36:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F038120040;
	Sat, 29 Nov 2025 17:36:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 29 Nov 2025 17:36:05 +0000 (GMT)
Date: Sat, 29 Nov 2025 23:04:54 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 07/14] ext4: drop extent cache when splitting extent
 fails
Message-ID: <aSsuvq4L0cOoQJPg@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
 <20251129103247.686136-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129103247.686136-8-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zYFPGGwooT_9_d8AjG1hsYpUxcXCZImS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX+eFxC2IPtlUq
 5Vss/hTZA/UP95smeyrYVhmIHIy3+FJG9Nr+LPEtoY8RvKg7l5IEakoGBh2XEYFWzVqxH4EB0+f
 E0kS/djJLRu+Q5wllU/1cPlN+YrtfOImZ6sLPJQfBNt+USmTjY2EJawsQRlGUCEMnn2O87mhPPe
 ckPBnLsVLv+RyYyd7MBziJqhpo9v8UQvvx71UUY+lwLDcgJd/56YeQLP8yDugaGJGIbl62fVPa+
 p0IyovVnrOLTlmlpNy35OTdnAy60FaQrB84V0BHb75TAx0TO/4iOfbmqg73JuLGI/xOisBzxrzr
 n/e3zh09Fr7IbsMy5JPne7Gx2dXwImVKKDolx4anOS92RSny28H9KfiGJQ1M0WUkfkdYkcXwAC8
 ndZ6RDKD1zStRwo6vdKfGd40iqmjmw==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692b2f0c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8cGh_D-LIEn_MYWo3KkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: jm0N6vx1KxwGYKUUAZjXf9ULeaxtgeDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

On Sat, Nov 29, 2025 at 06:32:39PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When the split extent fails, we might leave some extents still being
> processed and return an error directly, which will result in stale
> extent entries remaining in the extent status tree. So drop all of the
> remaining potentially stale extents if the splitting fails.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Baokun Li <libaokun1@huawei.com>
> Cc: stable@kernel.org

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 1094e4923451..945995d68c4d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3267,7 +3267,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  
>  	err = PTR_ERR(path);
>  	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> -		return path;
> +		goto out_path;
>  
>  	/*
>  	 * Get a new path to try to zeroout or fix the extent length.
> @@ -3281,7 +3281,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  	if (IS_ERR(path)) {
>  		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
>  				 split, PTR_ERR(path));
> -		return path;
> +		goto out_path;
>  	}
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
> @@ -3358,6 +3358,10 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  		ext4_free_ext_path(path);
>  		path = ERR_PTR(err);
>  	}
> +out_path:
> +	if (IS_ERR(path))
> +		/* Remove all remaining potentially stale extents. */
> +		ext4_es_remove_extent(inode, ee_block, ee_len);
>  	ext4_ext_show_leaf(inode, path);
>  	return path;
>  }
> -- 
> 2.46.1
> 

