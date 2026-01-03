Return-Path: <linux-fsdevel+bounces-72338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC925CF0046
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 14:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B30053032946
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2EC2F6168;
	Sat,  3 Jan 2026 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AgZhfVTi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34441E89C;
	Sat,  3 Jan 2026 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767447829; cv=none; b=KMeSHACvF7+79ZZIdLcLt+4IuU+o3lOKn4Y1YWh79CPRFXcqq5AwgptsedLNibT2bbpBUTTqn0mNMxb2aoy/mK71kIqwTqKjq+c4dhXRjpN1w1gP5FOKujYpk34Gq5mjpXQoy2RHcb/OiRHpEQihDAMEsNl81Xf8K8L/7A9Ig/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767447829; c=relaxed/simple;
	bh=RFVCIRLK5/LN0MbBdYbKAa8Xr9tPYcfMfkcQJACFBbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiFpCJZD/dt1YUwCtg2HWdUJk+TomouF2NriWEun7koVAfhsPT5Q1/M5FKKoHOtAI7E6I8ieE/uasLHyjDl/zs18YiSBGfL0a9IA1vMUZmWx1nG3YWUdp7RZoS2JEkHWmHRlCrpM9QIwaEqNoY6AC+q0XLIaB1xCCEKrIOw6G3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AgZhfVTi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6034RNkL006199;
	Sat, 3 Jan 2026 13:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=p/6bqbg5km0SNSAmT6UCf6veX/9H0g
	QRcGaZssMzQoM=; b=AgZhfVTi8T3qQttXWw+W6ZloDsl0WFY6Z7RlrH/n5gkjz8
	GCXJWTZG/v+Tf1+k0I+OETT5dkkP7BdQpRolz1P49ZB0uT1kBMlziCJwPfjDVEq6
	5jWteTlLoi2DbW+PhNo3j+Ym2rYZDwYkUFPm/dmQsJVAugOxMtVTSFlb8XvtGdhz
	7bHK+626KxgeTqmwa2tzyX/fEqmimCzF46N449HXF03MB9n7/LY/MIafYYKxslxw
	v4w2878Nuuf6mLQWhUhMU+cq0UBKnHq6Izw8zKqrVwHmLbJ7QTdggkkMbNOwvMvk
	kzGorcnm2NkWusmYJpEx/iZCpk8zAxgDtpRSIMTQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu5s4vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 13:43:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 603DgxUw007373;
	Sat, 3 Jan 2026 13:42:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu5s4vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 13:42:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6038naNq003067;
	Sat, 3 Jan 2026 13:42:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bavg2a514-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 13:42:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 603Dguth42139992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Jan 2026 13:42:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7FDD20043;
	Sat,  3 Jan 2026 13:42:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE59620040;
	Sat,  3 Jan 2026 13:42:53 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  3 Jan 2026 13:42:53 +0000 (GMT)
Date: Sat, 3 Jan 2026 19:12:51 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, yi.zhang@huawei.com,
        yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
        yukuai@fnnas.com
Subject: Re: [PATCH -next v2 1/7] ext4: use reserved metadata blocks when
 splitting extent on endio
Message-ID: <aVkc27cw-m5Skeo0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223011802.31238-2-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=69591ce4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=tI_HTh-t2pryGKuaV9oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: VQHYDeIX9DpnavNoadUxL2TD29dSNDQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDEyMCBTYWx0ZWRfX80HHyEXiP1ue
 04yIXMg+uYKhDBlt5Pd2dJrNRjaNFfGdnY9nT+g1PuRsZql9At8BoNqpK7T8UI0OAs/pbt2D107
 EmIgyZ8dBXev8su/MC3t2MaznI7hAJ8qN2Z2Oov86vxEVSpWE4ogNwFk92fKM/czZzl5bdhGgVL
 ZUUWFinTeMK1GFYDxAap6RmjYPiUifi4rp0NGiNQNwzgOw7hgkJC5p1JP2QGGIsKaR0spm4Kajd
 Qhw/L2/AB4UYMNc3f31LK5jCpN/C9CV2Adt3guyMl+XpCFWI0nCKc09n2iv/BYNe1SCsZ+DsLzO
 wQvEncfCh0Cfs8qVbCw72FuL7ClAxoUrJboJXk6An20Q9X790kg0La+QwnUlPeTs5JrKlGJI779
 vVxs7WTI/H9KA30fZNO9TZxjboG6d9ih0a5FW7j8vMgGemAHEmJddliWNErHR/GFx5ZWVdKzRgS
 PjnnRwM4YhbqfiJhq6g==
X-Proofpoint-GUID: Ei7WIWBISuaWeHl1JSuacjbFo3OPI0iu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-03_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601030120

On Tue, Dec 23, 2025 at 09:17:56AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When performing buffered writes, we may need to split and convert an
> unwritten extent into a written one during the end I/O process. However,
> we do not reserve space specifically for these metadata changes, we only
> reserve 2% of space or 4096 blocks. To address this, we use
> EXT4_GET_BLOCKS_PRE_IO to potentially split extents in advance and
> EXT4_GET_BLOCKS_METADATA_NOFAIL to utilize reserved space if necessary.
> 
> These two approaches can reduce the likelihood of running out of space
> and losing data. However, these methods are merely best efforts, we
> could still run out of space, and there is not much difference between
> converting an extent during the writeback process and the end I/O
> process, it won't increase the rick of losing data if we postpone the
                                ^^^^ risk

Other than the minor typo above, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> conversion.
> 
> Therefore, also use EXT4_GET_BLOCKS_METADATA_NOFAIL in
> ext4_convert_unwritten_extents_endio() to prepare for the buffered I/O
> iomap conversion, which may perform extent conversion during the end I/O
> process.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

> ---
>  fs/ext4/extents.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 27eb2c1df012..e53959120b04 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3794,6 +3794,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	 * illegal.
>  	 */
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> +		int flags = EXT4_GET_BLOCKS_CONVERT |
> +			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
>  #ifdef CONFIG_EXT4_DEBUG
>  		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
>  			     " len %u; IO logical block %llu, len %u",
> @@ -3801,7 +3803,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  			     (unsigned long long)map->m_lblk, map->m_len);
>  #endif
>  		path = ext4_split_convert_extents(handle, inode, map, path,
> -						EXT4_GET_BLOCKS_CONVERT, NULL);
> +						  flags, NULL);
>  		if (IS_ERR(path))
>  			return path;
>  
> -- 
> 2.52.0
> 

