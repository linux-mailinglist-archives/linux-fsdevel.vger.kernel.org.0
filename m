Return-Path: <linux-fsdevel+bounces-72344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87814CF00F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 15:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7963302D91C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B9830DD08;
	Sat,  3 Jan 2026 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sx9tl1ud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78DC1E1DE5;
	Sat,  3 Jan 2026 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767449921; cv=none; b=aVhBChOtMjgPDiD0pSS8CzFRirWi3aqvL0dimD3ug5I2gdrJQ/hr/X1J7DE6ZAiG0qad1oY8UfWUOsxPBQM6ETZcDa6UmRI/p53hvugIdi5+wvPetaFpbotFi6L3SPYAERlR3Z2q7CscIz/Hx6cB03/1F8MjaZuRmSVP85F4RI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767449921; c=relaxed/simple;
	bh=b2Ixarepcnj0YstAHyuc+6v40xtaO9LsoVIqOE23fqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9bHNxE6EnNcY//43CHDNycK0TfqQ7qE2LRNasb+RUBQ5qOJrN3MQITrV8saDoUvIEzYS1cl1EH96Rc9N+/lIlJ1IOtbC8WAPsPMaKnCE7XrkFr7sOuE/QCvYqH1vDY04RKY9pokBoEfF+euGBltke4q4crnP3VqHTvlj9zvT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sx9tl1ud; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6031FXRV016188;
	Sat, 3 Jan 2026 14:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CVkGICilnsCI/vIuqh7RJ25lTgX13D
	+R1LAi7t60p9o=; b=sx9tl1udyIsfI+SFZYm50R0pVh2p2EPrDGnYrntCTBNA5+
	t/RCNundN2Vwh1f5NJAB1dmPiTkz35D9fQLwoJhdLz1+gzeYgYx1EghW2bTyZmC5
	26WCEhDG7zJpEctkDWzd5NOt8XZ9LUpICru/apFk9CwnlJT1audxfKE6QAdiakP1
	eg0CnZb+aujmQJWgkigalVijYyBWLCxn+CaEzF7qpMz4shfsAzS65dnxBAe3Hvh/
	8hPyYebCFoH4KORHGhR2D0b+U0g3wngldbX388eO5T4JECbU6R01LDpBUe5GuGR/
	/93oMn25xgQFNb2BOESo796GIMoTR/wEQsq0TXVw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhjscnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:18:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 603EIAu0018660;
	Sat, 3 Jan 2026 14:18:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhjscnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:18:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6039ZdjD008053;
	Sat, 3 Jan 2026 14:18:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bav0ka97h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:18:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 603EI3Dh55247340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Jan 2026 14:18:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A5EF2004B;
	Sat,  3 Jan 2026 14:18:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 195D120043;
	Sat,  3 Jan 2026 14:18:00 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  3 Jan 2026 14:17:59 +0000 (GMT)
Date: Sat, 3 Jan 2026 19:47:57 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, yi.zhang@huawei.com,
        yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
        yukuai@fnnas.com
Subject: Re: [PATCH -next v2 6/7] ext4: simply the mapping query logic in
 ext4_iomap_begin()
Message-ID: <aVklFae8eF4ZziSW@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223011802.31238-7-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=69592523 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=z9pMmLfz73O0ZsV4afUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: yYwM9PUKcyX3H5z2MAjHPj5mhIcPhlp4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDEzMCBTYWx0ZWRfX2VJpRI/X9jSG
 rNEOnWosTHs3RdyDz1ItHPsCoUm9x4WDLCeB7yKi7pLH6tfPP6H1dx18hraWikk2Z+oyx0VXfze
 G/2xhC6+zDhGGq7Hf2Xi6+q8flq0eB5t+PTH+UbYXuExqblJyEWOXFlaTDXITW8O5+KyIvdKzLM
 vRCtJ+QT9C18m/nz2wrgSO1bdQuqwnD280Bm+YvbS3s40OjXrPuYbKw0hbgJ153uwEAfHJO9uIO
 gEVZBxvuq9vy4rXJ2HchyBSQ3UEN4uwSaRB/FlOUKscJcpJ+p4Q4GPxjIl85jkPX74TANJPhjE9
 x6tsyNh5S/UB8oy4IiSfxKO/UTnoOHPmUU3/cfKF9qd/wCmnlsXlHcV2huIIN4WTyD5c/bCA5vg
 QRjrL9qeUrY5Fm+bOaFzXf9ugPc8ZRpzSFr+cQLVEQv07Z2mTEYk+F7P/emgnvvCy4FL/7Y9kAh
 a52NRfgsYd0hBxBAg2g==
X-Proofpoint-GUID: lrm-HCl0QADx3byi_G9AXHaYElwqFWwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-03_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601030130

On Tue, Dec 23, 2025 at 09:18:01AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In the write path mapping check of ext4_iomap_begin(), the return value
> 'ret' should never greater than orig_mlen. If 'ret' equals 'orig_mlen',
> it can be returned directly without checking IOMAP_ATOMIC.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/inode.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b84a2a10dfb8..67fe7d0f47e3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3816,17 +3816,19 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		if (offset + length <= i_size_read(inode)) {
>  			ret = ext4_map_blocks(NULL, inode, &map, 0);
>  			/*
> -			 * For atomic writes the entire requested length should
> -			 * be mapped. For DAX we convert extents to initialized
> -			 * ones before copying the data, otherwise we do it
> -			 * after I/O so there's no need to call into
> -			 * ext4_iomap_alloc().
> +			 * For DAX we convert extents to initialized ones before
> +			 * copying the data, otherwise we do it after I/O so
> +			 * there's no need to call into ext4_iomap_alloc().
>  			 */
>  			if ((map.m_flags & EXT4_MAP_MAPPED) ||
>  			    (!(flags & IOMAP_DAX) &&
>  			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
> -				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
> -				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
> +				/*
> +				 * For atomic writes the entire requested
> +				 * length should be mapped.
> +				 */
> +				if (ret == orig_mlen ||
> +				    (!(flags & IOMAP_ATOMIC) && ret > 0))
>  					goto out;
>  			}
>  			map.m_len = orig_mlen;
> -- 
> 2.52.0
> 

