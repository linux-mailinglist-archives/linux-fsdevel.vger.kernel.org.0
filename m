Return-Path: <linux-fsdevel+bounces-49490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94934ABD554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 12:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAAC3A4FAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD990272E71;
	Tue, 20 May 2025 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="APsi/QlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED426A1D0;
	Tue, 20 May 2025 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737699; cv=none; b=e9hrKtHbIK0427/iCCU0S53Go1NM51aSj1Bo7/Rq9O6jyoJJIISsebtVTGq6iMmNXEfIGihbLOYUK3Zw+iWCy7maD834/jbkqUAYtX6hOBkWi1ObrARMz8Zz+22ma+u9Zyc0Tr7K39rxRIuj1KloyKVWIKeetA36WGfdMsKpe8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737699; c=relaxed/simple;
	bh=n4h2V5SmzC1ZUjo2G15VA0dTRIrQmh9K6r8Km3mbPFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0aw3q5girSyyMgR4kSn3oqWvLfB4Ai+9n2tw6BVQTju2+Qbo7kAxpdyhWx0ZBmW3ickbq+41Ln+IR4HUseryiAvumhcuZ28BK6bemQSDmcNWih0f0CVwpwfZJAQqJ8I4aEyl+lpvzl6L0SAsujNHHHx0jDlvf5WhR5fJKH6I0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=APsi/QlC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K66oeT012174;
	Tue, 20 May 2025 10:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6z3YaGeUGXxa1hAtSSbZLPaCRXs+zn
	8KwizU32tRIQM=; b=APsi/QlCTU4l4q0gPgrTX8S46FwT92o43UUjRl/p8tutsK
	5fnbcZiY+vy3u5IiN5QV2eZRAaWWY5RdxL/d8djhXEwJWpuhlc/jYhVh5P3Z/KuZ
	C2ZrEbATf6wJFL6OY3DkjOYCT+mougcWjtXoCLrE0KmhS4VMa98Mcak+3BwgBldm
	HcR4FWmyufEDaLebe0LSTmPeK3QWbmfcFq4bMGRfO8plEKctu9dhZ+KI2GXnDzaH
	5mpXy7Q00Tu9QZ+vWF/M3Lm1XdaYqIM7qsYNQUobBHFNq3YaZv8ELXr0i8EJVYoD
	LHNaF8bzAAoBA+mQWB5Qb4niZtwgB2TUTxr+G2jg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rab73gua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:41:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9mCSu013843;
	Tue, 20 May 2025 10:41:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q4stbmak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:41:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KAfGZb56230184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:41:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 711242008C;
	Tue, 20 May 2025 10:41:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DCF820082;
	Tue, 20 May 2025 10:41:13 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.28.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 10:41:13 +0000 (GMT)
Date: Tue, 20 May 2025 16:11:11 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 1/8] ext4: make ext4_mpage_readpages() support large
 folios
Message-ID: <aCxcRwFnmd4uspB0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512063319.3539411-2-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=682c5c4f cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=SBqxFbGtptZprEQTPsgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 5FYHLFZHSHYO_S6Zx8kpGKpu0PkVlUc-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA4NyBTYWx0ZWRfXwga7VT/JcKBI +3Y8W6jejft/1F2EGPMNV/YlwLLV+j2LcJhNeBb8csgT7k1FOKyyBq4L4bmmx635K3vFVSdwSEN qUivof6L3o0KGYzG56nog243QsFDiTqwDmx2wKGFtxXWkxJgLM92Qy/Hiq5prsIveZ98hd1/ka1
 pnzcJjPWVQOxSshkICeg2TssQ1JoZFMdev8a8wX82I7jSVU1Lm7mCQpW8n6FSWO5efUcUr0IGLR JqJCPRy70w6Fp2Leu2pNBdugGheK7Em3iQ8JQV9qaukLy4YaD7P83KVXUFM4tzoQgBTyyYxmJLd aX0bhKrPr3daPXyeoRflPv8Z2wQqOHFK6NAxXawh83LJgpI8GSNaKJdm4IhC//2RrLgqWCNPj8m
 R9c3oAHfxKEDRR+3rRpd+0UJCnV3kPXpbRLsF0lM489IGHEJWXYdkkNJ6gLyC9XiUgSTyR8k
X-Proofpoint-GUID: 5FYHLFZHSHYO_S6Zx8kpGKpu0PkVlUc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=948
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200087

On Mon, May 12, 2025 at 02:33:12PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> ext4_mpage_readpages() currently assumes that each folio is the size of
> PAGE_SIZE. Modify it to atomically calculate the number of blocks per
> folio and iterate through the blocks in each folio, which would allow
> for support of larger folios.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Going through this path is pretty confusing. I'm not sure why we keep
falling back to full folio read in case of mixed or non continuous mappings.
Seems like there's some read amplification here. 

Regardless, the changes here look okay to me.

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks,
ojaswin
> ---
>  fs/ext4/readpage.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 5d3a9dc9a32d..f329daf6e5c7 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -227,24 +227,30 @@ int ext4_mpage_readpages(struct inode *inode,
>  	int length;
>  	unsigned relative_block = 0;
>  	struct ext4_map_blocks map;
> -	unsigned int nr_pages = rac ? readahead_count(rac) : 1;
> +	unsigned int nr_pages, folio_pages;
>  
>  	map.m_pblk = 0;
>  	map.m_lblk = 0;
>  	map.m_len = 0;
>  	map.m_flags = 0;
>  
> -	for (; nr_pages; nr_pages--) {
> +	nr_pages = rac ? readahead_count(rac) : folio_nr_pages(folio);
> +	for (; nr_pages; nr_pages -= folio_pages) {
>  		int fully_mapped = 1;
> -		unsigned first_hole = blocks_per_page;
> +		unsigned int first_hole;
> +		unsigned int blocks_per_folio;
>  
>  		if (rac)
>  			folio = readahead_folio(rac);
> +
> +		folio_pages = folio_nr_pages(folio);
>  		prefetchw(&folio->flags);
>  
>  		if (folio_buffers(folio))
>  			goto confused;
>  
> +		blocks_per_folio = folio_size(folio) >> blkbits;
> +		first_hole = blocks_per_folio;
>  		block_in_file = next_block =
>  			(sector_t)folio->index << (PAGE_SHIFT - blkbits);
>  		last_block = block_in_file + nr_pages * blocks_per_page;
> @@ -270,7 +276,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  					map.m_flags &= ~EXT4_MAP_MAPPED;
>  					break;
>  				}
> -				if (page_block == blocks_per_page)
> +				if (page_block == blocks_per_folio)
>  					break;
>  				page_block++;
>  				block_in_file++;
> @@ -281,7 +287,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  		 * Then do more ext4_map_blocks() calls until we are
>  		 * done with this folio.
>  		 */
> -		while (page_block < blocks_per_page) {
> +		while (page_block < blocks_per_folio) {
>  			if (block_in_file < last_block) {
>  				map.m_lblk = block_in_file;
>  				map.m_len = last_block - block_in_file;
> @@ -296,13 +302,13 @@ int ext4_mpage_readpages(struct inode *inode,
>  			}
>  			if ((map.m_flags & EXT4_MAP_MAPPED) == 0) {
>  				fully_mapped = 0;
> -				if (first_hole == blocks_per_page)
> +				if (first_hole == blocks_per_folio)
>  					first_hole = page_block;
>  				page_block++;
>  				block_in_file++;
>  				continue;
>  			}
> -			if (first_hole != blocks_per_page)
> +			if (first_hole != blocks_per_folio)
>  				goto confused;		/* hole -> non-hole */
>  
>  			/* Contiguous blocks? */
> @@ -315,13 +321,13 @@ int ext4_mpage_readpages(struct inode *inode,
>  					/* needed? */
>  					map.m_flags &= ~EXT4_MAP_MAPPED;
>  					break;
> -				} else if (page_block == blocks_per_page)
> +				} else if (page_block == blocks_per_folio)
>  					break;
>  				page_block++;
>  				block_in_file++;
>  			}
>  		}
> -		if (first_hole != blocks_per_page) {
> +		if (first_hole != blocks_per_folio) {
>  			folio_zero_segment(folio, first_hole << blkbits,
>  					  folio_size(folio));
>  			if (first_hole == 0) {
> @@ -367,11 +373,11 @@ int ext4_mpage_readpages(struct inode *inode,
>  
>  		if (((map.m_flags & EXT4_MAP_BOUNDARY) &&
>  		     (relative_block == map.m_len)) ||
> -		    (first_hole != blocks_per_page)) {
> +		    (first_hole != blocks_per_folio)) {
>  			submit_bio(bio);
>  			bio = NULL;
>  		} else
> -			last_block_in_bio = first_block + blocks_per_page - 1;
> +			last_block_in_bio = first_block + blocks_per_folio - 1;
>  		continue;
>  	confused:
>  		if (bio) {
> -- 
> 2.46.1
> 

