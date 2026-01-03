Return-Path: <linux-fsdevel+bounces-72340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2ECF00AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97681300B01A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEACF30C62C;
	Sat,  3 Jan 2026 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qjC3uUee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD3299954;
	Sat,  3 Jan 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767449261; cv=none; b=QYu+lt+dLNaUROTf2CUz9CkQJ2z0ey3YEikv7Lsj6RJxekKBrYwq5NYzQk7lpD8adrZEt+XtbTp8fSDjdBID4ISBpwjTi5nRCgkxQkGORqGUouQeIg1pWsJjCBAxNbPq79cjr8t21IXHQgIII6IHjm0M+vQh1WjDms3DUOv+osc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767449261; c=relaxed/simple;
	bh=ia5apwccu/WRfZFdCUjTE5iaEuisLNmwMenDA0pYWTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQi2AWAqDk2Y/TnnHSASkUfp3LOK0SCoQqp5uUAD2OVIFO0n67OdLh8Uv3CLDrOTS6rzkA1CgcL4xJiw2hr1ac2Yu7jh/fG1dQD63ij04zZoAm26P6BI2+MKX0abz+w7enY9WXbcZLRnU6Rbngn7e+y/FOTrYx+qbBgcn2nTDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qjC3uUee; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 603CtxPj001034;
	Sat, 3 Jan 2026 14:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5EGjkxyoD/hh6GxCiyYaO/SBJhzSLk
	573NzFmp0RUm8=; b=qjC3uUeeKM7XcsKBD+cNyRK6I3ClSTDwMdMR2FCdT6ur1G
	rCq2SIOpYZwXAQFc0ZAbSiO79fQdpGVJFLI4r0wVWAI8RAIVeMzY0TFNqS6henkO
	qME+GtcSu9hBFT2WKpOEBjy30Ia3jMWKZezzLgygcqdZkLYjsLeVs4+v3dR/XOq7
	WkqAV6B1w9wKgp404dsGlXfP1QY7pSFmCwpR1bp6LHI3GgYeA5qA4Lxxj7H1HXZl
	gRK4P8LDJSfYLhx9wn7SYZoZVc9fwpZCsVBJloaTkzmonwx/btWofiqksxTZv4LM
	j/h1d9P0nGqo7xxt4D5Jvi76BI2h3NafVLIipL0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4besheh83p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:07:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 603E6xv4024528;
	Sat, 3 Jan 2026 14:06:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4besheh83m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:06:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 603D1GnQ012851;
	Sat, 3 Jan 2026 14:06:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4basstakup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:06:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 603E6vij51970366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Jan 2026 14:06:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1A620043;
	Sat,  3 Jan 2026 14:06:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1293A20040;
	Sat,  3 Jan 2026 14:06:54 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  3 Jan 2026 14:06:53 +0000 (GMT)
Date: Sat, 3 Jan 2026 19:36:51 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, yi.zhang@huawei.com,
        yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
        yukuai@fnnas.com
Subject: Re: [PATCH -next v2 3/7] ext4: avoid starting handle when dio
 writing an unwritten extent
Message-ID: <aVkie8pdqg8_NtqT@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223011802.31238-4-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDEyNSBTYWx0ZWRfXxZ0N/tUFS52Y
 M8YrOqW4mkCQT9bsniIr7oJguityhO+XzhCicKyGYJ/kMStNPBcj2Yj3koRyUZUQsysC4Eoj/gJ
 5gzYGOR+keXCxS+U0rNIYiJZsGxIyxakHj4UZLsnoLQsaL/bt8JLujzhVUtWsvGmhQb29Gc54tp
 mI/Mllkm/WOxMv9jq1wMhdDm7Qj/seWeFZCNLiZFUNnDNP71k+y/6a0ItMtEyDQRn8jt+lhzv8L
 XNiT1spnPV/nOQz+JfZe5lHe/XL37sOIEQBiiImL3yGvTwPYqR8ia5mylMggp748SUzLE+aDVsd
 4WpHkZ7P57GEZfquTmlAFtjLh52+czSoo0w/JM5uMaPWtX48CBFSeIG3fRkqrZnA5Z5D48qPrNa
 2Fa6BIHpao6iL4MLAXDbCU/MXP9B4sofJAtmZNPlyCqM2iVTMkzhY748EvAZK1zKnUa+7zc6iHo
 p3sRcmhYCiRBrNQe/0g==
X-Proofpoint-GUID: YBDc3nvyLNGo4dQx6Pp1L_mn0lEXxmMq
X-Proofpoint-ORIG-GUID: mMEkLm-5sFTP3jVT-ztktlZzgupVvzBO
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=69592284 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=BiM9-E9gWugAvIAtniIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-03_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601030125

On Tue, Dec 23, 2025 at 09:17:58AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since we have deferred the split of the unwritten extent until after I/O
> completion, it is not necessary to initiate the journal handle when
> submitting the I/O.
> 
> This can improve the write performance of concurrent DIO for multiple
> files. The fio tests below show a ~25% performance improvement when
> wirting to unwritten files on my VM with a mem disk.
> 
>   [unwritten]
>   direct=1
>   ioengine=psync
>   numjobs=16
>   rw=write     # write/randwrite
>   bs=4K
>   iodepth=1
>   directory=/mnt
>   size=5G
>   runtime=30s
>   overwrite=0
>   norandommap=1
>   fallocate=native
>   ramp_time=5s
>   group_reporting=1
> 
>  [w/o]
>   w:  IOPS=62.5k, BW=244MiB/s
>   rw: IOPS=56.7k, BW=221MiB/s
> 
>  [w]
>   w:  IOPS=79.6k, BW=311MiB/s
>   rw: IOPS=70.2k, BW=274MiB/s
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/file.c  | 4 +---
>  fs/ext4/inode.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7a8b30932189..9f571acc7782 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -418,9 +418,7 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>   *
>   * - shared locking will only be true mostly with overwrites, including
> - *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
> - *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
> - *   also release exclusive i_rwsem lock.
> + *   initialized blocks and unwritten blocks.
>   *
>   * - Otherwise we will switch to exclusive i_rwsem lock.
>   */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ffde24ff7347..ff3ad1a2df45 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3817,9 +3817,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			ret = ext4_map_blocks(NULL, inode, &map, 0);
>  			/*
>  			 * For atomic writes the entire requested length should
> -			 * be mapped.
> +			 * be mapped. For DAX we convert extents to initialized
> +			 * ones before copying the data, otherwise we do it
> +			 * after I/O so there's no need to call into
> +			 * ext4_iomap_alloc().
>  			 */
> -			if (map.m_flags & EXT4_MAP_MAPPED) {
> +			if ((map.m_flags & EXT4_MAP_MAPPED) ||
> +			    (!(flags & IOMAP_DAX) &&
> +			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
>  				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
>  				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
>  					goto out;
> -- 
> 2.52.0
> 

