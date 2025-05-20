Return-Path: <linux-fsdevel+bounces-49492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A271ABD585
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772F44A793D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96127AC48;
	Tue, 20 May 2025 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WLtnk0Uy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6752701D5;
	Tue, 20 May 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737806; cv=none; b=dmGg6WRX2L3VeqfIxBGot+/bSBDheKhQunkItyWPbbfDxp03AD60qIBKz06htRxD7ccIlwdw4LZNSiaLagr8z7Zq0TaDDoe3+5uWvhMT1MTlPBEUsQxnsotAb8NGKa0bFSlkxTG4I0Nl75MabD5xJJ9FeSBItZh98oUMoB4XHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737806; c=relaxed/simple;
	bh=V08AVv+/lAMqzRlpqb1FXcV1tIW3pW3roNbrQr3JBdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff4yiK8EomDmxZbCZTRNs3aH2yzuOnKLUhpzsSnIyagrQGIHYHoieRln/BWuGO03auJfG2qBPlJuE0wwwULQiA2Mr24jgouYt0e4vNr0vRffRtysFlLsVSxXpRJJXZa9FFIElsEXObFJUeG+B1AStbOic/hxteuf1NlfnZ8iNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WLtnk0Uy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6IOU8016865;
	Tue, 20 May 2025 10:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=B3U5JZ+urBABc5iue7NkxXnaFXJIoM
	sghZyTldyK+zc=; b=WLtnk0UyzGJW90ZTF6FsdvE7hChBHfb6CWPWPjueSjRQd/
	4j4CJIpaH6ty8wDQIPjIP2JFCBHNey18mn6PCkEfYktVRWHvnXyXS353jqgVUd7b
	NSyf0hFuI+JTlDtgc+v3dqxiShxcTSTLmu9PF8v0t0luiG66KO8rbmH84C9o/zON
	QgBwFKp7TQKyromT61VWETZ0GyCY6o/EiC1s/2Og1YtuNyC38enoh5T2hK0dCQcN
	mZXGsz6ybZPcdT/ArKDK9wKmiLW2GWKjjHdNeX7NYw+t9hYMATBLywv7Au+PwNlU
	23ET53HMy0sc7SALEAoj6dCflQNGKztG8GVubSYA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rmbss6kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:43:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54KAZQpa002502;
	Tue, 20 May 2025 10:43:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q5snuddw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:43:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KAgwlo51904898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:42:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1F2B200AE;
	Tue, 20 May 2025 10:42:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D89E4200B1;
	Tue, 20 May 2025 10:42:55 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.28.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 10:42:55 +0000 (GMT)
Date: Tue, 20 May 2025 16:12:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 6/8] ext4: make the writeback path support large folios
Message-ID: <aCxcpU_FBBQAguHR@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512063319.3539411-7-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA4NyBTYWx0ZWRfX86EtVG0FShOs 9QzQVkjvWpUakLlVowjEl4eVG1bKeqMeh0C8eihaMcvNgKLQlnz50bo5Of8zhW2SJFG8jHsQyIF GN0gxXIbejbciE2fIU4fPMMQeS6BOtcc7OblnEjkbXtqoXrFt8V6y/zRtgooZIDvcamnZm8YF5i
 bYyv6URmpJU3xQcG8wCSBAirDJca//WQjkLohnKTdn2rvq7IlAZB6fSWM3rV3PPP82rY6JGPbN0 fhx6wFAyKEt+JHo6iLugoDSHCOfboTAZGZ9kR+HEWCgtpksJE/vgvpWlpyxrEvUdOfIa4SQ42KV G6S+upJW8ywJtXYT8aMMgxP8jsHU8JskRnmc6zpCcBCET6MMmpDsDI8tJjxkpHtX8JXL+tHCRaD
 hu1fbQZVWIL83Hiow+i3ITiCSjfru7fuyAEZNS990TBduurhBauKVMvqwVvBuXSSZc8nvDf0
X-Proofpoint-ORIG-GUID: NyShGHtmB3n9HS7dCK_j0zXo1PX4PnY7
X-Proofpoint-GUID: NyShGHtmB3n9HS7dCK_j0zXo1PX4PnY7
X-Authority-Analysis: v=2.4 cv=DsxW+H/+ c=1 sm=1 tr=0 ts=682c5cb6 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=HOOD98lnpYojEHEThZwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=882
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200087

On Mon, May 12, 2025 at 02:33:17PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In mpage_map_and_submit_buffers(), the 'lblk' is now aligned to
> PAGE_SIZE. Convert it to be aligned to folio size. Additionally, modify
> the wbc->nr_to_write update to reduce the number of pages in a single
> folio, ensuring that the entire writeback path can support large folios.
> 
Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3e962a760d71..29eccdf8315a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1942,7 +1942,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
>  		len = size & (len - 1);
>  	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
>  	if (!err)
> -		mpd->wbc->nr_to_write--;
> +		mpd->wbc->nr_to_write -= folio_nr_pages(folio);
>  
>  	return err;
>  }
> @@ -2165,7 +2165,6 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
>  
>  	start = mpd->map.m_lblk >> bpp_bits;
>  	end = (mpd->map.m_lblk + mpd->map.m_len - 1) >> bpp_bits;
> -	lblk = start << bpp_bits;
>  	pblock = mpd->map.m_pblk;
>  
>  	folio_batch_init(&fbatch);
> @@ -2176,6 +2175,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
>  		for (i = 0; i < nr; i++) {
>  			struct folio *folio = fbatch.folios[i];
>  
> +			lblk = folio->index << bpp_bits;
>  			err = mpage_process_folio(mpd, folio, &lblk, &pblock,
>  						 &map_bh);
>  			/*
> @@ -2397,7 +2397,7 @@ static int mpage_journal_page_buffers(handle_t *handle,
>  	size_t len = folio_size(folio);
>  
>  	folio_clear_checked(folio);
> -	mpd->wbc->nr_to_write--;
> +	mpd->wbc->nr_to_write -= folio_nr_pages(folio);
>  
>  	if (folio_pos(folio) + len > size &&
>  	    !ext4_verity_in_progress(inode))
> -- 
> 2.46.1
> 

