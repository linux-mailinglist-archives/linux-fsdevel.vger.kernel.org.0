Return-Path: <linux-fsdevel+bounces-69886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EADE9C89B04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 13:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AA874E99D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9099326941;
	Wed, 26 Nov 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ePP8B3nD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A1325700;
	Wed, 26 Nov 2025 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158996; cv=none; b=G8xZQvFiuEo2BZ4ViTnGuNpxLXbaVqZTsoaDJbwlEBG9vtM31C0ms1OEin6a2GuYNr7m5JMyjCQns3h5lbbWZzihfGGBlVcYFbmy/l9dZdLpUwuYs0f4BmST6YtZZgFfJPgVZjN2KPKT56EDUIHoG3Q5f0DXkcGZyBbj4/xOpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158996; c=relaxed/simple;
	bh=MoJC6yFzFLFnqYxssN4YySjFA03O/+deE4wnoVXA8xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEOZOUGGtioEzNjqtSI45XcjkFoGEdWwYEHcMS6/0OjZUcui8MYZswv55YarzwLfMjQsYpFsUcjlla4C8AYwpmllEv/+P5VT3kYYtjXKFv6hNPIdThs2yII58vJfrxAhYwJ3bmQjD/C/P1xyqUrgbLlgoJ9IW018h0viUDbWw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ePP8B3nD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ2PXce008804;
	Wed, 26 Nov 2025 12:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jLLwbUfdetc16e9S7Qa1CyqcBbxf4J
	kjY2Vk26905G0=; b=ePP8B3nDk8MN9uPxW903D7duJkjqFsp81wAPbXwxLlpnJn
	Je+ardB+3c0U6xC5qkkcPup1ekLMYxbL/YJdSItBOqR0KCQmhs12w+XVWt9yzedX
	fqsH5F9k8VZq7M1bdfVpqMDxoiFLS61VhDjjvNyEKiuZ+n11bJBEb/BtWUUtjzTF
	h6TfVQvsYdXuj+TMKyHhFPJvE6SP9uJmWdRl0Fy21Qru24qAYs0MjKa71Tt8DWT4
	nAFNAaRiHLwd5yUtxoJml48LkjKZujX9dsSuRqEV+ImcPdaHG9Fq/zIuYuV9bU14
	mcm8w8vhjQgi5KqRn80FZpAT0aKws+vsIY4JyxqA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9kx8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 12:04:31 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQBu1rS011774;
	Wed, 26 Nov 2025 12:04:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9kx8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 12:04:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQAQ1HB025108;
	Wed, 26 Nov 2025 12:04:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71hwbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 12:04:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQC4SfQ15925726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 12:04:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 165F520043;
	Wed, 26 Nov 2025 12:04:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6805320040;
	Wed, 26 Nov 2025 12:04:25 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 12:04:25 +0000 (GMT)
Date: Wed, 26 Nov 2025 17:34:22 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 06/13] ext4: don't cache extent during splitting extent
Message-ID: <aSbsxpMSVGyywIIX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-7-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX5vkFiuNajigj
 BujmsodssEtGUeJKfGUkcEDh3QEpS1dw55gL6n+HmVUJsYV75R5VNx/szc6ZZh+L3Ru6DNJ3IlR
 n+vU2KkSMFNnMZyqrqh+Z673Qw08oh9Pcdau1QnlzMX+DiUX3UWjNecJ0LxZXKk2mIQfI3OyTf5
 uBy7iipjYU1i0z88ybHuFdfWexAJj6TU6MWQIwdheZAJzF3hb2qiFhB//mmqOBGWW2xG8USdy+v
 zzwVfrW0Xbq5Iy5sAjQiT4hC79Wgx2OUESiQgG+km2aepzn9Bb+3rnakFg+92fo7zuSSZh3TsYf
 pD/FqMmHHkeFtYHHa/alrQpuwD4Gjxc9R1nRwEkA7Ok9MTcfScyEbsobb+i075y02kG4RidowdB
 4ELPjAeFo1KNP7LlJoVa/4yw0D2KOQ==
X-Proofpoint-ORIG-GUID: 6MFEvxKXxKjyFHqJPVlC6y5eeiNoim50
X-Proofpoint-GUID: p4wAxt7BYiQhm37lwca9CQE7796n_3T8
X-Authority-Analysis: v=2.4 cv=TMJIilla c=1 sm=1 tr=0 ts=6926eccf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=CnngZZmD1jlomWZp134A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

On Fri, Nov 21, 2025 at 02:08:04PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Caching extents during the splitting process is risky, as it may result
> in stale extents remaining in the status tree. Moreover, in most cases,
> the corresponding extent block entries are likely already cached before
> the split happens, making caching here not particularly useful.
> 
> Assume we have an unwritten extent, and then DIO writes the first half.
> 
>   [UUUUUUUUUUUUUUUU] on-disk extent        U: unwritten extent
>   [UUUUUUUUUUUUUUUU] extent status tree
>   |<-   ->| ----> dio write this range
> 
> First, when ext4_split_extent_at() splits this extent, it truncates the
> existing extent and then inserts a new one. During this process, this
> extent status entry may be shrunk, and calls to ext4_find_extent() and
> ext4_cache_extents() may occur, which could potentially insert the
> truncated range as a hole into the extent status tree. After the split
> is completed, this hole is not replaced with the correct status.
> 
>   [UUUUUUU|UUUUUUUU] on-disk extent        U: unwritten extent
>   [UUUUUUU|HHHHHHHH] extent status tree    H: hole
> 
> Then, the outer calling functions will not correct this remaining hole
> extent either. Finally, if we perform a delayed buffer write on this
> latter part, it will re-insert the delayed extent and cause an error in
> space accounting.

Okay, makes sense. So one basic question, I see that in
ext4_ext_insert_extent() doesnt really care about updating es unless as a
side effect of ext4_find_extent().  For example, if we end up at goto
has_space; we don't add the new extent and niether do we update that the
exsisting extent has shrunk. 

Similarly, the splitting code also doesn't seem to care about the es
cache other than zeroout in the error handling.

Is there a reason for this? Do we expect the upper layers to maintain
the es cache?
> 
> In adition, if the unwritten extent cache is not shrunk during the
> splitting, ext4_cache_extents() also conflicts with existing extents
> when caching extents. In the future, we will add checks when caching
> extents, which will trigger a warning. Therefore, Do not cache extents
> that are being split.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/extents.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 19338f488550..2b5aec3f8882 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3199,6 +3199,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
>  	       (split_flag & EXT4_EXT_DATA_VALID2));
>  
> +	/* Do not cache extents that are in the process of being modified. */
> +	flags |= EXT4_EX_NOCACHE;
> +
>  	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
>  
>  	ext4_ext_show_leaf(inode, path);
> @@ -3364,6 +3367,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  	ee_len = ext4_ext_get_actual_len(ex);
>  	unwritten = ext4_ext_is_unwritten(ex);
>  
> +	/* Do not cache extents that are in the process of being modified. */
> +	flags |= EXT4_EX_NOCACHE;
> +
>  	if (map->m_lblk + map->m_len < ee_block + ee_len) {
>  		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
>  		flags1 = flags | EXT4_GET_BLOCKS_PRE_IO;
> -- 
> 2.46.1
> 

