Return-Path: <linux-fsdevel+bounces-69888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD87CC89C49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 13:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 605AD35125E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE4328B5E;
	Wed, 26 Nov 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i5BdkKLV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AEF31E0FA;
	Wed, 26 Nov 2025 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160222; cv=none; b=opUwq6mG3ihPmQCm4ZznJ5plU8bOYtWH87bwiQ/Nb2ybTJ4NexM7W6xWRYe8D1Y2a+a14kfw6DTmSjr4A9WPAYiDuioiBDgWX0h4AKYTseNhbFkI6DCh38zOhkh2H1FpSAS92L3NjGkjDIOBaCYNXJ7HrtKtQB0NsMc2q0lLI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160222; c=relaxed/simple;
	bh=rBWTlq/9ES9o/3FgpX9/DDUZ1liNvZVvQTVCMFJQTrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4lKnJNFQdMCNED4czwZg0fBYzFHoYuHnssxTNXH8op5LUt9WxaE+4u3icnoGDwTlbiSQFyII51/OWW5+04g19AxIILMr9Px21W2ZEIL7sY/O4pGyO2OP1qFJIW0gPy3qCgOV5MpRm8iKcv1JjP9GoWUH43MHokk/dYjHLT6vuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i5BdkKLV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ8DfE5005649;
	Wed, 26 Nov 2025 12:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hEtAAnqed7FOxj61IA+IWbXOkiXhD5
	JPYgCoARi8Bbg=; b=i5BdkKLVZa+uplsJsMrQMENsNA05heqzhh0XjBjUqKvqS7
	yactFSzQJ+zvNeLjYqH6AFikzdVTI68NJr7S0zEhZh0mtOeblPDT0bEV8sWDNhnb
	wuliYBx+86ytSiG085ge3FzeI1IBsYiidJdiy4gL01lWJh1Zn+3r2myCxcYnq1ri
	RjrX5ui1wf4XruNkb5UMKOF/+2ij695TQ6PQizh8Ep8IGouUCSEM80deQ4KWid/+
	kjlYz6hcDsNce77wjXvtrGsk3cd+e1VeQSu0R5I4NNAzynNeH/lmI1+AL+m5WPTi
	Vkb2TkTSd/8g6ZfPMiEvyEJeXnyD9bKCjNFOSGJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pj45b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 12:24:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQC4fX1013034;
	Wed, 26 Nov 2025 12:24:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pj45b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 12:24:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQAphC4025089;
	Wed, 26 Nov 2025 12:24:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71j0vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 12:24:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQCOpZ853543174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 12:24:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85F6120043;
	Wed, 26 Nov 2025 12:24:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F104620040;
	Wed, 26 Nov 2025 12:24:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 12:24:48 +0000 (GMT)
Date: Wed, 26 Nov 2025 17:54:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 07/13] ext4: drop extent cache before splitting extent
Message-ID: <aSbxjVypU3vdOUmK@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-8-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX+k8nOuXalw9Y
 1YoPVSAPEImF20V8PeovQHP21RG1ky1MXTvDSneiY71mHzWmC3/Av/YZbk2+AYYEhf0Pw1vQjUP
 DEM4dvb7hFtDcBmahMt/7NJZYBAJm6o/a1NjX5PKbuW2tg+ZePLBw8a3IPuA1rd4dsaMGgFr6Tw
 czEO3AvgRIoFnkofItByvN0GjBMLz0ndEvO6G4rIiER/uzfefeTLoxU7yMD4Ro+51ADIgGJpOcZ
 mjyMXgJZk28Ql2Jagji/IGEb9+v5QpGfszU+zLeYu5opySrrmPmslYgGnzDwvaykXbtB+Nkrvn9
 zSZCH8po+xcMCr1e9gjjEtWDxQ/NyF2h2d/OAXmi84+qlNziVSuOiEsN6a9+mX5z0GRuXsz7giO
 b5jco+y3K+Bjlul3Q3UcXB3xiNb1yw==
X-Proofpoint-ORIG-GUID: bdR6KaGzHm6mdPOqm5LZupvnA4Gd9sOv
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=6926f197 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=aLcW1nmjqn6KqM0SkAcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: t-x7tBwFfuZeGrM5fPEJ26ArjF7RH0t_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016

On Fri, Nov 21, 2025 at 02:08:05PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When splitting an unwritten extent in the middle and converting it to
> initialized in ext4_split_extent() with the EXT4_EXT_MAY_ZEROOUT and
> EXT4_EXT_DATA_VALID2 flags set, it could leave a stale unwritten extent.
> 
> Assume we have an unwritten file and buffered write in the middle of it
> without dioread_nolock enabled, it will allocate blocks as written
> extent.
> 
>        0  A      B  N
>        [UUUUUUUUUUUU] on-disk extent      U: unwritten extent
>        [UUUUUUUUUUUU] extent status tree
>        [--DDDDDDDD--]                     D: valid data
>           |<-  ->| ----> this range needs to be initialized
> 
> ext4_split_extent() first try to split this extent at B with
> EXT4_EXT_DATA_PARTIAL_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
> ext4_split_extent_at() failed to split this extent due to temporary lack
> of space. It zeroout B to N and leave the entire extent as unwritten.
> 
>        0  A      B  N
>        [UUUUUUUUUUUU] on-disk extent
>        [UUUUUUUUUUUU] extent status tree
>        [--DDDDDDDDZZ]                     Z: zeroed data
> 
> ext4_split_extent() then try to split this extent at A with
> EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and
> leave
> an written extent from A to N.

Hi Yi, 

thanks for the detailed description. I'm trying to understand the
codepath a bit and I believe you are talking about:

ext4_ext_handle_unwritten_extents()
  ext4_ext_convert_to_initialized()
	  // Case 5: split 1 unwrit into 3 parts and convert to init
		ext4_split_extent()

in which case, after the second split succeeds
> 
>        0  A      B   N
>        [UU|WWWWWWWWWW] on-disk extent     W: written extent
>        [UU|UUUUUUUUUU] extent status tree

WHen will extent status get split into 2 unwrit extents as you show
above? I seem to be missing that call since IIUC ext4_ext_insert_extent
itself doesn't seem to be accounting for the newly inserted extent in es.

Regards,
ojaswin

>        [--|DDDDDDDDZZ]

> 
> Finally ext4_map_create_blocks() only insert extent A to B to the extent
> status tree, and leave an stale unwritten extent in the status tree.
> 
>        0  A      B   N
>        [UU|WWWWWWWWWW] on-disk extent     W: written extent
>        [UU|WWWWWWWWUU] extent status tree
>        [--|DDDDDDDDZZ]
> 
> Fix this issue by always remove cached extent status entry before
> splitting extent.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/extents.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2b5aec3f8882..9bb80af4b5cf 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3367,6 +3367,12 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  	ee_len = ext4_ext_get_actual_len(ex);
>  	unwritten = ext4_ext_is_unwritten(ex);
>  
> +	/*
> +	 * Drop extent cache to prevent stale unwritten extents remaining
> +	 * after zeroing out.
> +	 */
> +	ext4_es_remove_extent(inode, ee_block, ee_len);
> +
>  	/* Do not cache extents that are in the process of being modified. */
>  	flags |= EXT4_EX_NOCACHE;
>  
> -- 
> 2.46.1
> 

