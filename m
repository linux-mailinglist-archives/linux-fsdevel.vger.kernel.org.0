Return-Path: <linux-fsdevel+bounces-49491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68250ABD56B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 12:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3012F1BA30EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C353280334;
	Tue, 20 May 2025 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n2KjSX80"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D527815B;
	Tue, 20 May 2025 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737748; cv=none; b=a1KkWxZ02geHJIFKGEvJxqtTTjP3WO+qMp3C/7L3DcBv0WZFwT6nIyGF5yb6lDngjry4vqUzzTABn9Oo7pTaGnClXTJ1nG6HAMDeA4Ny7JMymwPdjSKfV2tJtH8DGB0c/FgRQlKLISDQVuUUvV8+97Qhx6ajzWtf/SP+NMJHLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737748; c=relaxed/simple;
	bh=BkJI7sUJ6eARd6Ob2SNQ2vFFFwLfx9QkgapjlHpGBsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6sLBaexJmOh89aZQeHKQcA4tMTOcPvuVGXaetrF/urFDIBuYvWrH/sCde0wGj8/EN7ImCeUPRmA+WJrLDFAMjJbXJYx/rY6RFJ+UUw9meeLyhOCUWr7p6bIWYOEpFehrIAZE8NDETVb9XVcpKiMm21bP84m2JoP21IhcMK8BSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n2KjSX80; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7Y03U014192;
	Tue, 20 May 2025 10:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PKNZ0MGdf/TKhlhurGUEDnkEPvYngx
	nYNytPKB6og94=; b=n2KjSX808hXkYl97o0HgfSGJBUUsh8fhjwjhen9ITzed5I
	k0pecA/nx4UgG35j+Ci5oamToCm9tFkQqoSe70LPFmhuDKex7GekugRisE75qZUj
	SIC7gWL2FLaz1C6YQxRr2Z9LLubO3BaJU+9N8B6TjFY/vYo8SH70gmkhKn5Y+AY7
	isgyXL6b18h6iVjPTDQB5wxYq5myXXvRxgO6ydwrv9QR3vYm/4s9M7x/3tTMIIAW
	0Vj+pKwivzD3pQLTYQbLt+mizuenWsnhdf3XUxx1vRkGNLFMHQpoaYLNOVmY1u+q
	J0HpKdQkFl1YhxZCpGkEsmlw2pjRSsf+9i8emLyg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ra99km6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:42:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9cpGu028878;
	Tue, 20 May 2025 10:42:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q55yuk0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:42:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KAfxNT16974226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:41:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C6B6200A3;
	Tue, 20 May 2025 10:41:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E20D3200A2;
	Tue, 20 May 2025 10:41:56 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.28.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 10:41:56 +0000 (GMT)
Date: Tue, 20 May 2025 16:11:54 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 3/8] ext4: make __ext4_block_zero_page_range() support
 large folio
Message-ID: <aCxccnStpSuJ5ZhU@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512063319.3539411-4-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J/mq7BnS c=1 sm=1 tr=0 ts=682c5c7a cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=z1FBhPMU8gvHw_kh6WIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA4NyBTYWx0ZWRfX2nKHB3NR9JkB r622VqhL6yhxEzbyeZWjgaDkLgMsvhyg+l2TGHd/QfdrddKyBSnB5qo8dHi9FW++opjUoe/hFIo NjhDIgQGmk3iLvmW7gYDwKv/PfGGYeY9HVp2TsobpLJWhjrH6Wc71XqfXBaXAsbZ1cmxd/tbdT2
 rV2PSoCBKk0Z5ov1Aehr2H+lHWjaEmtcjnjbo8ko1RivSc2CE0dMhDi+trhmkNtPMuzjwpocazE FDvmwfOyNuD+QdTKtPw5GWfVjs8sGwuEDld51DZ+suDI/rv8W9ciHgvyNUtWAUWkf8n07ZT+wDg BSuJgYjSt2t4jKBa/Rsc7V7i3Vf7QGhytpCSkHHUMERAP4+jMVIz97hmV54RrIg9XYmG4RnQWCV
 N0yE9mEXHd66IlebeHyNvkdd3lHsMB3fhCiF60MhBTerPZrzNr/Kv343LOaoA2CzJAZmQk+i
X-Proofpoint-ORIG-GUID: WS-XRq-2RPegaF4cbRp5esDsmXLbdJ5t
X-Proofpoint-GUID: WS-XRq-2RPegaF4cbRp5esDsmXLbdJ5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200087

On Mon, May 12, 2025 at 02:33:14PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The partial block zero range helper __ext4_block_zero_page_range()
> currently only supports folios of PAGE_SIZE in size. The calculations
> for the start block and the offset within a folio for the given range
> are incorrect. Modify the implementation to use offset_in_folio()
> instead of directly masking PAGE_SIZE - 1, which will be able to support
> for large folios.

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4d8187f3814e..573ae0b3be1d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3701,9 +3701,7 @@ void ext4_set_aops(struct inode *inode)
>  static int __ext4_block_zero_page_range(handle_t *handle,
>  		struct address_space *mapping, loff_t from, loff_t length)
>  {
> -	ext4_fsblk_t index = from >> PAGE_SHIFT;
> -	unsigned offset = from & (PAGE_SIZE-1);
> -	unsigned blocksize, pos;
> +	unsigned int offset, blocksize, pos;
>  	ext4_lblk_t iblock;
>  	struct inode *inode = mapping->host;
>  	struct buffer_head *bh;
> @@ -3718,13 +3716,14 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  
>  	blocksize = inode->i_sb->s_blocksize;
>  
> -	iblock = index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
> +	iblock = folio->index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
>  
>  	bh = folio_buffers(folio);
>  	if (!bh)
>  		bh = create_empty_buffers(folio, blocksize, 0);
>  
>  	/* Find the buffer that contains "offset" */
> +	offset = offset_in_folio(folio, from);
>  	pos = blocksize;
>  	while (offset >= pos) {
>  		bh = bh->b_this_page;
> -- 
> 2.46.1
> 

