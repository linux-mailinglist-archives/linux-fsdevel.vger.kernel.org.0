Return-Path: <linux-fsdevel+bounces-69884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F62C899C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2F33A46E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CA8325713;
	Wed, 26 Nov 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W1oyPUQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3231B818;
	Wed, 26 Nov 2025 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158139; cv=none; b=k5XtpCkYjqrbgE1HQIFi9LAXyXrElO6PLiaNo8/0LPcudzY+H+9BAV8gNbDpgLPq3Oontwkd8L+uw0+gUMcV0Mt3e9gyGnbvZ04On2OsMu19vQ51meY5tl+44KZUA9m5rzUTns17AYGE7ixeV+kVv3luyzjj5lI7TKBjEjceJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158139; c=relaxed/simple;
	bh=OWjQ1oACLoh96yPUjCR0+dE06IPxtFGXfvyneZuL4qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVGR3MeuNvaQE1vScXSQ05gftaONZPn5zOrOANuqmIP/DbYLl46LGP2Y0M9d0FCU5UuGsw22vBHGrrblGbNTu+patyd7h64WYUqzGogeJLsAi4GAjN5Ef/hwIf/osnwslaPIv4MjyP737Eri5MZN5U8XaIQfAzk8T19ZRA2grK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W1oyPUQc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ1NENV007900;
	Wed, 26 Nov 2025 11:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yxPfhpmBJsNIOTBe3Vo2h7Z457YkcU
	NS2mqsLirZfMA=; b=W1oyPUQcx03TDTgvbvGXnE1B9aeI0MEx3zHMOCNaXWEQ42
	NXs1D2N3+3S2UxkDxMdTTe6k4FP4izVlyQk8hZ6XUBQNFEmNgu1hkq7ysDnOMqV1
	HC5eoxtgP01vkxVyGsmHM1s/VU/zkmut4d5IVFyvyN7anPRLSw+NDnh+Ob27FPdi
	4zL9oG3vmQ0QPaTuwAnKszDDXLGUWtlMgklfOSWGqVis7/Ovnhc6s/eOl3mYS+5v
	XwxXQOBbg+S2UzKx6x88CPjYT5gi0wDAbRWoFRh+XCnhkpwCEdk0YP9ziYqoGRx+
	yuSwvsDxBrHYAozh9EhSirnJZS7ra9wd8q362SUg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kk2x0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:55:22 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQBtLQg010618;
	Wed, 26 Nov 2025 11:55:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kk2x0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:55:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQBNY1o000882;
	Wed, 26 Nov 2025 11:55:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvy27hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:55:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQBtI4U44040486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:55:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0F9B20043;
	Wed, 26 Nov 2025 11:55:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2527220040;
	Wed, 26 Nov 2025 11:55:16 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 11:55:15 +0000 (GMT)
Date: Wed, 26 Nov 2025 17:25:13 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 02/13] ext4: subdivide EXT4_EXT_DATA_VALID1
Message-ID: <aSbqoc4qgGf-pp0D@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-3-yi.zhang@huaweicloud.com>
 <aSbkH3HkHFxBZ45-@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSbkH3HkHFxBZ45-@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s_70laHZRlkwIsOkWgLwodrfnyth0_GG
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=6926eaaa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=7ef494N4gXLm18suy4IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: NxYm12uFfqViLhTIti6P44t6evLuGptN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX6nDuLOxoSKII
 7aj2x5PJ5XOGAoGJJaeQLMUqbv7m2KVoNI9bFOBUxixq6fckDUy4W0TplutZe7dW/iLd2U7pPIU
 u5KDACOqwhTZANb77Z/ZY1lSmde1Y2DTT6Vwy+77iSdwNEe2BM3AE6uyvaK5PFTBSxjGY+HqIJy
 4H/iwlI6qEHNiazNi8xvghC/Qbj4Dx7ZBijdxCIMskchtK5SvLEetWB3cegjUgUNDBxNjo59Hj+
 VhBThsZ747baUwCQ11fVQKdHx5Yz+WNl3h3qclFTA5vpkey8vOxcxN4/uX1x8vYe9Y5L4Z+XcjI
 ThvnpPiHDpwySkOy/cZ9WDhKExvj4R0K/1i2v1/v/jhkXC2vJHoqrWVitdQUZZtDiaeYozFGiId
 /0yuoGbQiEtDLnS6mCaLU3wEhHEOoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

On Wed, Nov 26, 2025 at 04:57:27PM +0530, Ojaswin Mujoo wrote:
> On Fri, Nov 21, 2025 at 02:08:00PM +0800, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > When splitting an extent, if the EXT4_GET_BLOCKS_CONVERT flag is set and
> > it is necessary to split the target extent in the middle,
> > ext4_split_extent() first handles splitting the latter half of the
> > extent and passes the EXT4_EXT_DATA_VALID1 flag. This flag implies that
> > all blocks before the split point contain valid data; however, this
> > assumption is incorrect.
> > 
> > Therefore, subdivid EXT4_EXT_DATA_VALID1 into
> > EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_DATA_PARTIAL_VALID1, which
> > indicate that the first half of the extent is either entirely valid or
> > only partially valid, respectively. These two flags cannot be set
> > simultaneously.
> > 
> > This patch does not use EXT4_EXT_DATA_PARTIAL_VALID1, it only replaces
> > EXT4_EXT_DATA_VALID1 with EXT4_EXT_DATA_ENTIRE_VALID1 at the location
> > where it is set, no logical changes.
> > 
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Looks good, feel free to add:
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> > ---
> >  fs/ext4/extents.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index 91682966597d..f7aa497e5d6c 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -43,8 +43,13 @@
> >  #define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
> >  #define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */
> >  
> > -#define EXT4_EXT_DATA_VALID1	0x8  /* first half contains valid data */
> > -#define EXT4_EXT_DATA_VALID2	0x10 /* second half contains valid data */
> > +/* first half contains valid data */
> > +#define EXT4_EXT_DATA_ENTIRE_VALID1	0x8   /* has partially valid data */
> > +#define EXT4_EXT_DATA_PARTIAL_VALID1	0x10  /* has entirely valid data */

Hey, sorry I forgot to mention this minor typo in my last email. The
comment for partial and entirely valid flags are mismatched :)

Regards,
ojaswin

> > +#define EXT4_EXT_DATA_VALID1		(EXT4_EXT_DATA_ENTIRE_VALID1 | \
> > +					 EXT4_EXT_DATA_PARTIAL_VALID1)
> > +
> > +#define EXT4_EXT_DATA_VALID2	0x20 /* second half contains valid data */
> >  
> >  static __le32 ext4_extent_block_csum(struct inode *inode,
> >  				     struct ext4_extent_header *eh)
> > @@ -3190,8 +3195,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
> >  	unsigned int ee_len, depth;
> >  	int err = 0;
> >  
> > -	BUG_ON((split_flag & (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2)) ==
> > -	       (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2));
> > +	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) == EXT4_EXT_DATA_VALID1);
> > +	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
> > +	       (split_flag & EXT4_EXT_DATA_VALID2));
> >  
> >  	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
> >  
> > @@ -3358,7 +3364,7 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
> >  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
> >  				       EXT4_EXT_MARK_UNWRIT2;
> >  		if (split_flag & EXT4_EXT_DATA_VALID2)
> > -			split_flag1 |= EXT4_EXT_DATA_VALID1;
> > +			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
> >  		path = ext4_split_extent_at(handle, inode, path,
> >  				map->m_lblk + map->m_len, split_flag1, flags1);
> >  		if (IS_ERR(path))
> > @@ -3717,7 +3723,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
> >  
> >  	/* Convert to unwritten */
> >  	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
> > -		split_flag |= EXT4_EXT_DATA_VALID1;
> > +		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
> >  	/* Convert to initialized */
> >  	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
> >  		split_flag |= ee_block + ee_len <= eof_block ?
> > -- 
> > 2.46.1
> > 

