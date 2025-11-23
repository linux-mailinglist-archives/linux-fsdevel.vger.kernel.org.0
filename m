Return-Path: <linux-fsdevel+bounces-69506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E58D0C7DFD5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 11:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F934B6B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 10:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA912C21F0;
	Sun, 23 Nov 2025 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PmXgvW47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE51FE44B;
	Sun, 23 Nov 2025 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763895397; cv=none; b=q2TV1fzpBTpsXMrxzWNIWqoyVfXrqKWMEsqQZh+dCbeFNGPm5VDIZSpZOffrk/pWWO49KyuvBJjK+gsvnFefubUhQ3YBeZP5qe+8QqL+qeLTsENQgL5j4ZYtFcsur1GyzWs+OO1v43rvCo2XZhOVkCmU/y+Pfu22j99OBpfc9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763895397; c=relaxed/simple;
	bh=GkSzqgsTYXp1zNpvNbNUQMDQNihfpJFOf3yV20EHI84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE+GtWmv6otda3vltstpz9XK+VfT5GZxCm+fzWp5Yh/m7FUC4q/EKiY1zlRNQ24MKUWstSXtdit3LT+Nw49LukMXCk433LyYGFTriOJG5ZASCbn5Mc27IV115iD6/oYlHT6qwlveWwFDz2RSJPJ5jWfTq033IEyNPrSqg/alxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PmXgvW47; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AMANdWZ032079;
	Sun, 23 Nov 2025 10:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MQHzhJofqd5Te675fl9syEPKLO0Oga
	kW917OTuVZ0nQ=; b=PmXgvW47Pn1HNQZEywQxSaPdtpMRIpp8GxEuX9rM4sYkvk
	w7cLtOeMMEV+zZ2OBUBTF9AGF0Lf8z4GdiMHh8zUYk7rlqg38TYsv4MtjP6T7+CA
	laLRtQfkwOYF645lllkFp8GL8YqJhmhSrEwdpdGYPy9wdqy2EnNGa6hTWuYjoIoe
	3umRLhpZpXzVcKCXFCHVpPKsHSfryvzcese2Jv6rXZhIjuKbCcjUnjWrRJy4JT0W
	g8ZKBycSvhTMqNbX0vBKHYGRmnNUPwIevatYfwnvr9nMeL9/ll6ZFrKgIth9HObA
	NOy7sZ/UGBEsdm0MlfBHu8oMm1EBuNNU/gbFyHZw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u1kw01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Nov 2025 10:56:14 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ANAuD3D007994;
	Sun, 23 Nov 2025 10:56:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u1kvyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Nov 2025 10:56:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AN7bHQW014527;
	Sun, 23 Nov 2025 10:56:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgmsdbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Nov 2025 10:56:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ANAuBrD41877940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Nov 2025 10:56:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 030AF20043;
	Sun, 23 Nov 2025 10:56:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54AD220040;
	Sun, 23 Nov 2025 10:56:08 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.98])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 23 Nov 2025 10:56:08 +0000 (GMT)
Date: Sun, 23 Nov 2025 16:25:51 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 00/13] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
Message-ID: <aSLoN-oEqS-OpLKE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX69xyYtqE/MMy
 +QPv01V7kyD6MBDLP9PtY7Rj+Oxjxz5biuYIJCdMtyVzMo67QuLh3hmCNN3JYV9zt40iEkTAMNA
 kUGaM0L0tVGLfGlagdMGNikDabU2jL1y+d68HU2aZvry+5943ZAff1gaQfm314VyYoYVmRMYlHo
 OPT3EJ6kr3dY7aHhEhHeO0+Zrb6mKvbbhedd2vT8Z20EO3IromOVhcXn3z1MOVrOpyQiaCTwBgP
 eaoRZzed+fZd1StIkQLotuiMxwcQD9HaxAP6WebtO0poViMN2hxsepeC/85o2gidn3Q/XtgQ9vn
 gUCyge7lh3TfYmijF4ai1QVctZpjh/pj1UCwlxkKoCi4ivYfPYlWq5Xcl3c6Qhq4veCw/7lYHdz
 XO9MyBbypPOatQAQwEj20Caw3ShtVg==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=6922e84e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=_SqwtH-sqpylD6Pudx8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 8HxBmSJ2rkYvFFWNWYnGb1rl8SRrpyA6
X-Proofpoint-GUID: NcbcQtEc6iaBpxvvstFUbqHYnoE0M-aI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-23_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220021

On Fri, Nov 21, 2025 at 02:07:58PM +0800, Zhang Yi wrote:
> Changes since v1:
>  - Rebase the codes based on the latest linux-next 20251120.
>  - Add patches 01-05, fix two stale data problems caused by

Hi Zhang, thanks for the patches.

I've always felt uncomfortable with the ZEROOUT code here because it
seems to have many such bugs as you pointed out in the series. Its very
fragile and the bugs are easy to miss behind all the data valid and
split flags mess. 

As per my understanding, ZEROOUT logic seems to be a special best-effort
try to make the split/convert operation "work" when dealing with
transient errors like ENOSPC etc. I was just wondering if it makes sense
to just get rid of the whole ZEROOUT logic completely and just reset the
extent to orig state if there is any error. This allows us to get rid of
DATA_VALID* flags as well and makes the whole ext4_split_convert_extents() 
slightly less messy.

Maybe we can have a retry loop at the top level caller if we want to try
again for say ENOSPC or ENOMEM. 

Would love to hear your thoughts on it.

Thanks,
Ojaswin

>    EXT4_EXT_MAY_ZEROOUT when splitting extent.
>  - Add patches 06-07, fix two stale extent status entries problems also
>    caused by splitting extent.
>  - Modify patches 08-10, extend __es_remove_extent() and
>    ext4_es_cache_extent() to allow them to overwrite existing extents of
>    the same status when caching on-disk extents, while also checking
>    extents of different stauts and raising alarms to prevent misuse.
>  - Add patch 13 to clear the usage of ext4_es_insert_extent(), and
>    remove the TODO comment in it.
> 
> v1: https://lore.kernel.org/linux-ext4/20251031062905.4135909-1-yi.zhang@huaweicloud.com/
> 
> Original Description
> 
> This series addresses the optimization that Jan pointed out [1]
> regarding the introduction of a sequence number to
> ext4_es_insert_extent(). The proposal is to replace all instances where
> the cache of on-disk extents is updated by using ext4_es_cache_extent()
> instead of ext4_es_insert_extent(). This change can prevent excessive
> cache invalidations caused by unnecessarily increasing the extent
> sequence number when reading from the on-disk extent tree.
> 
> [1] https://lore.kernel.org/linux-ext4/ympvfypw3222g2k4xzd5pba4zhkz5jihw4td67iixvrqhuu43y@wse63ntv4s6u/
> 
> Cheers,
> Yi.
> 
> Zhang Yi (13):
>   ext4: cleanup zeroout in ext4_split_extent_at()
>   ext4: subdivide EXT4_EXT_DATA_VALID1
>   ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
>   ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before
>     submitting I/O
>   ext4: correct the mapping status if the extent has been zeroed
>   ext4: don't cache extent during splitting extent
>   ext4: drop extent cache before splitting extent
>   ext4: cleanup useless out tag in __es_remove_extent()
>   ext4: make __es_remove_extent() check extent status
>   ext4: make ext4_es_cache_extent() support overwrite existing extents
>   ext4: adjust the debug info in ext4_es_cache_extent()
>   ext4: replace ext4_es_insert_extent() when caching on-disk extents
>   ext4: drop the TODO comment in ext4_es_insert_extent()
> 
>  fs/ext4/extents.c        | 127 +++++++++++++++++++++++----------------
>  fs/ext4/extents_status.c | 121 ++++++++++++++++++++++++++++---------
>  fs/ext4/inode.c          |  18 +++---
>  3 files changed, 176 insertions(+), 90 deletions(-)
> 
> -- 
> 2.46.1
> 

