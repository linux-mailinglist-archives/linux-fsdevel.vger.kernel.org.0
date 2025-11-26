Return-Path: <linux-fsdevel+bounces-69885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F0BC899EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D404B358206
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169EA32824F;
	Wed, 26 Nov 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nBLp/0kv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63B327BE8;
	Wed, 26 Nov 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158225; cv=none; b=Fw9Gg2gN8yBdhaZrGNQO4kY9UEu4O3Tx7fuhcj24j5VY9MOcrpUzftSL/qnorh1Q60JfGi6XiEuvxWCSYHfcsd12j4Jnn+ot+0tRkcrNzlxlxjr5aBXXB//b1pstucWLwSG3FId4KsSjoxuBB7pzpP9RUJco51ioXFG+Jp8Q+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158225; c=relaxed/simple;
	bh=6dBf3er36NM2t0BUxs2BvzSr59O2QZqm/BC2W9TmzMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOgwXpzFPm9YMLApx1FEimeMun0QjtWHcenQXkpe82utYYl6tRyrkmNPdJyt9L4SKsl+3POUZBM6fJv/S/oWVNddNPuf/OKbbcd1t8ILXIC97Jt6+yD0ZoxI8G+XichQKQM2TiQzYFQqErufrqe2WFdDT3/Jj0sxAGwqgzwC/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nBLp/0kv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ23GaB002398;
	Wed, 26 Nov 2025 11:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KaL8MAcUlIqR+mH5g8YfMcNYu5yU65
	lzJUw2lHj3MKA=; b=nBLp/0kv5vLaFHkV1F5wGxwWWqbtZMjJxptE/0XXCrWx3P
	9irimueqaxGQeWV2534A94CLvBi9gFilMQ4Ahot0r38CJpn77nKtWwAo7bfaHMet
	ahxKzAHoLK4mfnwWqF7yBOsc+CrDuV5GCPmtir8NGh2DAOQtCWDiSpH0yun0W8NM
	axfdIwNu6j7GhB8/cSGaiV5FksT5ZlsRRqwKNZTg4HGXjuILqNE8CmxeSaNnlV8W
	T9vSnUEKRk8MDyV+qJINT3Gep2i7BBE3XOgFf3m/WbRkOA0V9a21GOHSzLvkAZwm
	hfsDnK80OurOR0hxxhB81H4Yt8fY6wyHASFLeXQw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvbvff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:56:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQBunrd019478;
	Wed, 26 Nov 2025 11:56:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvbvfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:56:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQBASQa027389;
	Wed, 26 Nov 2025 11:56:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4anq4h30yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:56:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQBukhW29295170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:56:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDD9A2004B;
	Wed, 26 Nov 2025 11:56:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01FD820040;
	Wed, 26 Nov 2025 11:56:44 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 11:56:43 +0000 (GMT)
Date: Wed, 26 Nov 2025 17:26:41 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 05/13] ext4: correct the mapping status if the extent
 has been zeroed
Message-ID: <aSbq-cXrYMdA74jm@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-6-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX6q36onGLFtS1
 5hSHwsTRxEMylqXUTMacVJfS8ULjG23SSstErRsfsKQZVTWJAitXRVRhHK5NMPU22h0Je7aatl+
 oarcYPa5RgVs6QRCcMhgxiCqAsSKL0rjXSbL1p8SHAMs+Q8mHsX9Dz4pafAo5rcAaG08EAWp6bz
 v2SkZUZOLcHzWNQECPgCCqyU3deDUwlq47B+b4d2vvq3m7I5TKPqHE+4Xh69wp+k2lfPKVsOl8S
 vA3AIKVraLOzqFJSgDWpD7HvIcLLUuw3+LJyIzTkzjK0OvPQA3Hc4vPutcTemqPv6+U9UEeeJrX
 GHfjwhFa5qnywF/zej5Ng51hX2H+KscQcg4YkjD0auBPnTbNvKFFwSRACKvd+Jg3YbV2p2Z4py/
 ws2MD6KeQpkqNj0ti02/iH5QjAG7VA==
X-Authority-Analysis: v=2.4 cv=PLoCOPqC c=1 sm=1 tr=0 ts=6926eb02 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=CZjMgEM6iNVPd6lrJsIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: dMC5N7YOePFvPArL0GcvxGDFY0y2f6uY
X-Proofpoint-GUID: w5AcvfBAkl1lwYEq11GbSlcNziLgHcMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

On Fri, Nov 21, 2025 at 02:08:03PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Before submitting I/O and allocating blocks with the
> EXT4_GET_BLOCKS_PRE_IO flag set, ext4_split_convert_extents() may
> convert the target extent range to initialized due to ENOSPC, ENOMEM, or
> EQUOTA errors. However, it still marks the mapping as incorrectly
> unwritten. Although this may not seem to cause any practical problems,
> it will result in an unnecessary extent conversion operation after I/O
> completion. Therefore, it's better to correct the returned mapping
> status.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2db84f6b0056..19338f488550 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3916,6 +3916,8 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  
>  	/* get_block() before submitting IO, split the extent */
>  	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
> +		int depth;
> +
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  						  flags, allocated);
>  		if (IS_ERR(path))
> @@ -3931,7 +3933,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  			err = -EFSCORRUPTED;
>  			goto errout;
>  		}
> -		map->m_flags |= EXT4_MAP_UNWRITTEN;
> +		/* Don't mark unwritten if the extent has been zeroed out. */
> +		path = ext4_find_extent(inode, map->m_lblk, path, flags);
> +		if (IS_ERR(path))
> +			return path;
> +		depth = ext_depth(inode);
> +		if (ext4_ext_is_unwritten(path[depth].p_ext))
> +			map->m_flags |= EXT4_MAP_UNWRITTEN;
>  		goto out;
>  	}
>  	/* IO end_io complete, convert the filled extent to written */
> -- 
> 2.46.1
> 

