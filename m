Return-Path: <linux-fsdevel+bounces-69878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8316AC8985F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1BF3B2973
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC4322A21;
	Wed, 26 Nov 2025 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NFDRdOn6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98737320CD6;
	Wed, 26 Nov 2025 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156622; cv=none; b=O9oPIlD54F0XucgY1IBVYl6WUjR5Pvrm8/sqmuEc9adwXhTUWyDjgBFgfmmkuH7rS+El9OKQaVjCBaNM+/naFCqiuNGqsPrprZ1KHkOfR2pRpPnnf0c+OHP1YjsUlg5/BmF7uj7Mko3W8gF4Pb+GPURz8CWEVnA2IkbOgQxmSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156622; c=relaxed/simple;
	bh=lNf8ZqwigN9DZMExwmrwe/+l/hqIeeOWgDZUPTUO8jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMNikoondEFwcwixvXQlyBFrUWQkYcQEtlZQz4qIQfvWI5Lr/OUvChrcxJpyiQE4gtz4AOtcGpwLXSnwtOSIN10a92OekWyduzDpfnT08e4XeEbW87040SAX1T45sgyLYS6KcKfsOPBqMqr5x105waYEH0TOaMvbp8r11t8++EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NFDRdOn6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ5CmPC011802;
	Wed, 26 Nov 2025 11:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7VkbkMv8E76o53+Qe4SRD71rIx8trL
	5JvgAU5C/oU9M=; b=NFDRdOn6uyqrd3U6SEu8K44rr+WSFTQZwtjP0F14ktT5lN
	fpk14k6xk85ZCUaERaYGwqbRBJvjU8IcYj0zeWLOhG6zX3iIXpvoC5b9XnTq7mHp
	q44sKfaGAcpv5pnDJRtYL7RELrGu+6m/UzC4Fe5rH0EWMcXTk4KSADbVAzVKI4L8
	XZFogvzGh03xY5nTlpCHPGinX+M//lsZrZnveQHRgF4VjudeicYHfi9m/LgmTyEY
	tJiBk03NAnuYDrmCIWKmOKpSKbdWnd2FJL3Aw/EnMnTmx+qpEw+yWWSQg4OWeMBv
	yAub+eUk1Lj2PkSdBrZ5YlbJ2RYpf/VWX+fSe6hQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pj3vnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:30:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQBU1qS006416;
	Wed, 26 Nov 2025 11:30:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pj3vne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:30:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ99apv014527;
	Wed, 26 Nov 2025 11:30:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgna1u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:30:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQBTwEc31850806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:29:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7168520043;
	Wed, 26 Nov 2025 11:29:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F2BD20040;
	Wed, 26 Nov 2025 11:29:55 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 11:29:55 +0000 (GMT)
Date: Wed, 26 Nov 2025 16:59:53 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/13] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1
Message-ID: <aSbksRztaQ0UtHKB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX1MeJTlL0iQ5o
 3Ra1EbnTFR9vrdPG8NBskIvjScYkSjeJj7sztHPLQtf3tT6wNmghmA1NGsgc1d2T9mQuG4ipv+S
 5c0g1Bco17+NkwC7sVxSCFzo/Ym1EXJbc43KqYNNUL8rCkwsDzfz4yW82dXx1rN8DvtxvV0Q5ox
 1EuZ9CFItsZp8UlXeoG9PauQpAGKvPFAjnYtgWywRsSNGP1UjYvT6IkeOG3+ZMGhc3kkRZOdUtE
 41UT1tCTc1liLiaaNTNHIpOSm78iRubdyixVXrjPTBqW8Go8361OmZw/yhPS4kt/qy8uDf0gj4y
 1rJHaiRqX589GkSlPvmYMCfd4t3lrN9vjez9/q/zhTJqJKnavNJ60O6G9MS6huNhkOb3FA79gvM
 1iRnRzVyI7q55oJb0U/uD/bPpK6P0g==
X-Proofpoint-ORIG-GUID: kiJ_7ZL2Jpg2WKV0JzGExiNlv57yzNuT
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=6926e4ba cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=JGrP17Lop6qqZo5us_kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: NuXCZfR-Mm043OmLasAoE_M5SfRU_Nqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016

On Fri, Nov 21, 2025 at 02:08:01PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When allocating initialized blocks from a large unwritten extent, or
> when splitting an unwritten extent during end I/O and converting it to
> initialized, there is currently a potential issue of stale data if the
> extent needs to be split in the middle.
> 
>        0  A      B  N
>        [UUUUUUUUUUUU]    U: unwritten extent
>        [--DDDDDDDD--]    D: valid data
>           |<-  ->| ----> this range needs to be initialized
> 
> ext4_split_extent() first try to split this extent at B with
> EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
> ext4_split_extent_at() failed to split this extent due to temporary lack
> of space. It zeroout B to N and mark the entire extent from 0 to N
> as written.
> 
>        0  A      B  N
>        [WWWWWWWWWWWW]    W: written extent
>        [SSDDDDDDDDZZ]    Z: zeroed, S: stale data
> 
> ext4_split_extent() then try to split this extent at A with
> EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and left
> a stale written extent from 0 to A.
> 
>        0  A      B   N
>        [WW|WWWWWWWWWW]
>        [SS|DDDDDDDDZZ]
> 
> Fix this by pass EXT4_EXT_DATA_PARTIAL_VALID1 to ext4_split_extent_at()
> when splitting at B, don't convert the entire extent to written and left
> it as unwritten after zeroing out B to N. The remaining work is just
> like the standard two-part split. ext4_split_extent() will pass the
> EXT4_EXT_DATA_VALID2 flag when it calls ext4_split_extent_at() for the
> second time, allowing it to properly handle the split. If the split is
> successful, it will keep extent from 0 to A as unwritten.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Hi Yi,

This patch looks good to me. I'm just wondering since this is a stale
data exposure that might need a backport, should we add a Fixes: tag 
and also keep these fixes before the refactor in 1/13 so backport is
easier.

Other than that, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f7aa497e5d6c..cafe66cb562f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3294,6 +3294,13 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  		err = ext4_ext_zeroout(inode, &zero_ex);
>  		if (err)
>  			goto fix_extent_len;
> +		/*
> +		 * The first half contains partially valid data, the splitting
> +		 * of this extent has not been completed, fix extent length
> +		 * and ext4_split_extent() split will the first half again.
> +		 */
> +		if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1)
> +			goto fix_extent_len;
>  
>  		/* update the extent length and mark as initialized */
>  		ex->ee_len = cpu_to_le16(ee_len);
> @@ -3364,7 +3371,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
>  				       EXT4_EXT_MARK_UNWRIT2;
>  		if (split_flag & EXT4_EXT_DATA_VALID2)
> -			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
> +			split_flag1 |= map->m_lblk > ee_block ?
> +				       EXT4_EXT_DATA_PARTIAL_VALID1 :
> +				       EXT4_EXT_DATA_ENTIRE_VALID1;
>  		path = ext4_split_extent_at(handle, inode, path,
>  				map->m_lblk + map->m_len, split_flag1, flags1);
>  		if (IS_ERR(path))
> -- 
> 2.46.1
> 

