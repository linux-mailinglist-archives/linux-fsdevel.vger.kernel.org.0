Return-Path: <linux-fsdevel+bounces-69876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D753C8982F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA583B38D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D104B322A1F;
	Wed, 26 Nov 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aCDh9/52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDCC320CBC;
	Wed, 26 Nov 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156443; cv=none; b=rT/yVX+VHx8vgr7lwmqH57foDsYTryj5b+NQyQrdUbR9Hv3DmKqYZW1LPCFRq8iUrtw1V3bCRxeRTTy8CJuo9YjFoymXDEWWieNMqDlJ5FK4UHR4jIXTBVS/UUnDOp0sxRtFC6thrVc2B3LtMKWkDPkK3S944nxoEt1dOz14AkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156443; c=relaxed/simple;
	bh=5jSzTBPfufCpEyNV49uirTrK7mte/qRYBZ7wq1cwWLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLQ7He/bpKQrPT//mW7MniwBIdtd3EJXQzUB+VOu4rcCm6OB2N9Or071Ica6x6tWepzslCkDJ4a4N3suB3eVKo2UL1Sp04/d5z6pQ6qER3/BAeIl3mju173lk/ySs+SzlpXvFh7pYOXHFkJnMdWDTBbnnELppprD7pvU93v6VGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aCDh9/52; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ3jD8H007087;
	Wed, 26 Nov 2025 11:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=D6BL16U4IlNnEKVJ+sjPgQ4X0OhX+r
	0RjandaVzh4XA=; b=aCDh9/526JUZ396CC8/MDiD8J+OrtS2I1gmpHHvATl67pK
	brAgzxFJL/Qyc0M5gad2t67nrLLeeHiAt+8K1/SrswzterKgv4qBOFXY6E9ccJzP
	pQDbMgPOaGqOsm+Ted6UDNvXoUojMevfLoasL3FZZj/Y8EYGVBO4flY5v6O04LkN
	Y7WFl0jY7gKuyiEXh+bmE1NwZ3PeXJKuBjPeIUfXLTccFnEZw99NJzXhF7YDv6nU
	xAQepiRFGcCgZOzpSW3O0cP4KkWatTGWoFmGuvCkchUuZOjQ+zQ6xoqMcp3ABxSo
	74foV0QrsQyjdXipYMco7N6FH37UHNh66DwuqKHA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u22rh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:26:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQApkrd017497;
	Wed, 26 Nov 2025 11:26:53 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u22rh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:26:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQAS51b025083;
	Wed, 26 Nov 2025 11:26:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71hpta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:26:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQBQoQF8258004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:26:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 875D220040;
	Wed, 26 Nov 2025 11:26:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D98EA20043;
	Wed, 26 Nov 2025 11:26:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 11:26:47 +0000 (GMT)
Date: Wed, 26 Nov 2025 16:56:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 01/13] ext4: cleanup zeroout in ext4_split_extent_at()
Message-ID: <aSbj9XNcW2fmE5tt@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-2-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfXwM71G+NkQQp9
 K288q0wGXRDmD76Pc78STzAcfK+o/Iiz2zi7+6vfnWvSrSSKqet0wvuFYKyWdeCgAotgSpFP96f
 OZ0dr969FLzrJEMyFE3KvGUmlPPIB+nrilOakHtvL7O1MK2NOiHm1h5P0XB4+jWqSk6xRttPYHq
 lr7CRpIVVpBBeRFgM0wv1x3i9AYJJ4UrVXvNqPBSFyXHZ2vEB6FOo8G3wjFOTtP0jy4Orn2QyV9
 T9emDbhIYb3myKvMsznki2ZWh9aQ7mTyU5v+XR0w8iix4uIyBLfZwDlx2VG0ui6f/UOt1ov9HfY
 zFW69uDP1r4cidSxW2nNnVMZ4CXSr/fpLhSLWSC2y2KVljd5WUUMAkGGuIJjVAfuxSRofJfYaks
 OOWRzk3Gj0Ck+jL2vGg+kVIkktDsLA==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=6926e3fd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=JKi_HSNj8FsWOE7nqXQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 67udsd4f6dqlxL3svCtQk_PzGXIF7fHE
X-Proofpoint-GUID: FwHZDZ12O8HydMNb1fPj2jrsonbkEsCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220021

On Fri, Nov 21, 2025 at 02:07:59PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> zero_ex is a temporary variable used only for writing zeros and
> inserting extent status entry, it will not be directly inserted into the
> tree. Therefore, it can be assigned values from the target extent in
> various scenarios, eliminating the need to explicitly assign values to
> each variable individually.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents.c | 63 ++++++++++++++++++-----------------------------
>  1 file changed, 24 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c7d219e6c6d8..91682966597d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3278,46 +3278,31 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  	ex = path[depth].p_ext;
>  
>  	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> -		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
> -			if (split_flag & EXT4_EXT_DATA_VALID1) {
> -				err = ext4_ext_zeroout(inode, ex2);
> -				zero_ex.ee_block = ex2->ee_block;
> -				zero_ex.ee_len = cpu_to_le16(
> -						ext4_ext_get_actual_len(ex2));
> -				ext4_ext_store_pblock(&zero_ex,
> -						      ext4_ext_pblock(ex2));
> -			} else {
> -				err = ext4_ext_zeroout(inode, ex);
> -				zero_ex.ee_block = ex->ee_block;
> -				zero_ex.ee_len = cpu_to_le16(
> -						ext4_ext_get_actual_len(ex));
> -				ext4_ext_store_pblock(&zero_ex,
> -						      ext4_ext_pblock(ex));
> -			}
> -		} else {
> -			err = ext4_ext_zeroout(inode, &orig_ex);
> -			zero_ex.ee_block = orig_ex.ee_block;
> -			zero_ex.ee_len = cpu_to_le16(
> -						ext4_ext_get_actual_len(&orig_ex));
> -			ext4_ext_store_pblock(&zero_ex,
> -					      ext4_ext_pblock(&orig_ex));
> -		}
> +		if (split_flag & EXT4_EXT_DATA_VALID1)
> +			memcpy(&zero_ex, ex2, sizeof(zero_ex));
> +		else if (split_flag & EXT4_EXT_DATA_VALID2)
> +			memcpy(&zero_ex, ex, sizeof(zero_ex));
> +		else
> +			memcpy(&zero_ex, &orig_ex, sizeof(zero_ex));
>  
> -		if (!err) {
> -			/* update the extent length and mark as initialized */
> -			ex->ee_len = cpu_to_le16(ee_len);
> -			ext4_ext_try_to_merge(handle, inode, path, ex);
> -			err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -			if (!err)
> -				/* update extent status tree */
> -				ext4_zeroout_es(inode, &zero_ex);
> -			/* If we failed at this point, we don't know in which
> -			 * state the extent tree exactly is so don't try to fix
> -			 * length of the original extent as it may do even more
> -			 * damage.
> -			 */
> -			goto out;
> -		}
> +		err = ext4_ext_zeroout(inode, &zero_ex);
> +		if (err)
> +			goto fix_extent_len;
> +
> +		/* update the extent length and mark as initialized */
> +		ex->ee_len = cpu_to_le16(ee_len);
> +		ext4_ext_try_to_merge(handle, inode, path, ex);
> +		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> +		if (!err)
> +			/* update extent status tree */
> +			ext4_zeroout_es(inode, &zero_ex);
> +		/*
> +		 * If we failed at this point, we don't know in which
> +		 * state the extent tree exactly is so don't try to fix
> +		 * length of the original extent as it may do even more
> +		 * damage.
> +		 */
> +		goto out;
>  	}
>  
>  fix_extent_len:
> -- 
> 2.46.1
> 

