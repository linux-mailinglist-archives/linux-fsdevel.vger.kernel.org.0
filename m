Return-Path: <linux-fsdevel+bounces-70264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 497C9C945D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 18:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21C403473A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994530FF21;
	Sat, 29 Nov 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iNUdtGlA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C18020F067;
	Sat, 29 Nov 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437720; cv=none; b=Eh69NhFykXKGS9wsLr/goIVRZR4x+s2IYrwFoiNhQK0WVy+6c4/9Ul6Odf756wbL1owHyV1WXs6rF5hw6h/yaObkWA6xHL3e46uF+5mQAgFXAypNVxFWRtxu43icH9wlwdF7QANgG7NfQsrljirU9tDswrdrKGV25hLVxtfrcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437720; c=relaxed/simple;
	bh=pXD6nrW8Ad2l1MosS0Zp8E0uNalZTDZ0RARbAngFbhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnyA882MoP/aFXXp2nFlliZ2csprkAcS1MxfVFuINbwf51ZeMnCxeJb2eYayLPCrp4VMCTEXmVK2PqyDGdA9X3lZUICOvYdYPRpL9n8/XI+Ig41A8qNYbOb3HamTxqBYx5pwkfXCO/OuKAMnzxemr+Kelyq6kigD47Q094Mx7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iNUdtGlA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AT6FVXY005056;
	Sat, 29 Nov 2025 17:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QpWuELSXAKSWhIxSjZxxU7A7VFDRp1
	wb/s5PUXN0EJ4=; b=iNUdtGlAH7Q205KThNEhX8boAc+ux53uRSLqVMJoFxjbX2
	4DxWD58yMyiYE+g7RIVkgc4DwvVV+1IXOoBw5iIJ4MX7lv5Usfp//YzaQ1TrzdA0
	23UDS2DZnqR2HBox6sMn5T6jtCS2lGDEpll5GnAOO2CPY9+erY3tcJ1RlKvwxKah
	6xm303nytVgPdZjd2N2VyFwq8D6DVgTIphmPxUIILd1chMPVb5lOv4gEFiFBdYyp
	YBIYcu8TtH++SqxjXJ3pPfNooia8512HUeRx+6I1JrT7EOSv54jwXCoayNFivCAW
	PaZBsXDe0gbjC6ZWmAuTWa5zi/yMaXPsfxasQlwA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8phjc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 17:34:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ATHYu7Z032110;
	Sat, 29 Nov 2025 17:34:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8phjc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 17:34:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATF2G45000850;
	Sat, 29 Nov 2025 17:34:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvyhykv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 17:34:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ATHYrsQ51315104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Nov 2025 17:34:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FBB120043;
	Sat, 29 Nov 2025 17:34:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0855720040;
	Sat, 29 Nov 2025 17:34:51 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 29 Nov 2025 17:34:50 +0000 (GMT)
Date: Sat, 29 Nov 2025 23:03:43 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 06/14] ext4: drop extent cache after doing
 PARTIAL_VALID1 zeroout
Message-ID: <aSsud_c9UtP3Xcmm@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
 <20251129103247.686136-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129103247.686136-7-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX9fDY1Jc+OlME
 Br4S7QvtEXpjUCSWmFUOYmUz0BcvTbU4yFmdx9FTk5c7k6V/ghXfroCO90dYx1PrzPoy2h9r74M
 zHhJQjmU2lCafRPf0tLmYyaQ0ivF5r9Bwy9pFGepKoLdnXMkm8YwtZIyRI3rHO8B7bQpZ4P16gP
 yiwB8C+mfNp1hRch6jpU+HMklNy9w8yybGrDEwaZyZmmsGWRdL+2qkcAnZ7kYb37sudIm9VEUdV
 nfh/QDzUI/elXE72jrR2RcEoesu4RNi2lMoGl26hfxaePfJ23kwNteuWEO8EjzAnH/2/BxadfPO
 YFyD3i1QyMrCt/WgDI5wyu7k93XDx7xdIDKBxemqb6OZ7kY9n+ZAgEPgOh1QJIQMaLRg8liGmD/
 84zXGnL4i0J0/JFO9NLfG240QTXAZQ==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692b2ec1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=VxLEsmLLjGsxDua8HicA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: yM2_7dlMr4HsLIlkHPRWwEsSdrx8TVFe
X-Proofpoint-GUID: EdquWRUJcXCDLcZ1QEKSO4I5axie_U4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

On Sat, Nov 29, 2025 at 06:32:38PM +0800, Zhang Yi wrote:
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
> leave an written extent from A to N.
> 
>        0  A      B  N
>        [UUWWWWWWWWWW] on-disk extent      W: written extent
>        [UUUUUUUUUUUU] extent status tree
>        [--DDDDDDDDZZ]
> 
> Finally ext4_map_create_blocks() only insert extent A to B to the extent
> status tree, and leave an stale unwritten extent in the status tree.
> 
>        0  A      B  N
>        [UUWWWWWWWWWW] on-disk extent      W: written extent
>        [UUWWWWWWWWUU] extent status tree
>        [--DDDDDDDDZZ]
> 
> Fix this issue by always cached extent status entry after zeroing out
> the second part.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Baokun Li <libaokun1@huawei.com>
> Cc: stable@kernel.org

Okay so now we only drop the part that would have become stale. Looks
good to me.

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index be9fd2ab8667..1094e4923451 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3319,8 +3319,16 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  			 * extent length and ext4_split_extent() split will the
>  			 * first half again.
>  			 */
> -			if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1)
> +			if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1) {
> +				/*
> +				 * Drop extent cache to prevent stale unwritten
> +				 * extents remaining after zeroing out.
> +				 */
> +				ext4_es_remove_extent(inode,
> +					le32_to_cpu(zero_ex.ee_block),
> +					ext4_ext_get_actual_len(&zero_ex));
>  				goto fix_extent_len;
> +			}
>  
>  			/* update the extent length and mark as initialized */
>  			ex->ee_len = cpu_to_le16(ee_len);
> -- 
> 2.46.1
> 

