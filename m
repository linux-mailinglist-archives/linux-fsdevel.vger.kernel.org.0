Return-Path: <linux-fsdevel+bounces-70116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6361C911FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 09:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 267A14E647F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 08:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9E2DC793;
	Fri, 28 Nov 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h8iHxMAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238F3595B;
	Fri, 28 Nov 2025 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317906; cv=none; b=SSDISDjgu8lid1muebQms5BduDtzt1IR8Y7ilLXf3EEiscdiGUsOsLLsi0x9BaIJ+gkbD/I4X29wyYkMiqunwvUTILMNB97tQdAHkt8uzHQI5uosi5taHXezBixJEdXnqPjzEYtqrOhpn+UGa7Fdsb/PQPKdvr/edtBbn/v5U28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317906; c=relaxed/simple;
	bh=MyglGBcal4bKrBcPU+c/6EGDwjOzxseGoMwX+kkK+UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBTlj3EpJNFyNKrG1mwLuyj22ifIsvLLinYq49fXsG5TOGUgOhr66Kjx43vt8eOQYNTrza8i9wgxPIr08EcXwCwc0NUEVpIwrUk9Eh9+YZwQV6yrOtBEsanZCheZvWuZWY/8cpfmpiyTe4ES8VemK2xU5M9AzumvGE/tXH69fys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h8iHxMAC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS1QmKC021968;
	Fri, 28 Nov 2025 08:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hSkGLB71mr368XkWLd5KTDUbK243B2
	4Tvn5YIx9dVXk=; b=h8iHxMACxpLcJfDDhayeRr+pxOekQPnIXM9RyTMfsav4rO
	7RP/C6nO7q+gdfOqHrVmVpZ69PAJcHPLJJrvLGkRT2uuQMW2oC1g6QyveEJH77xm
	Cni+picrTYjG9vFRUjpOhzJW82nWpXJqWX4wH65WAyqHH7hloRtuEPtaO/IbAtMj
	sMUfOtz6guobfCJT/zIn+PTxSL2SIXM3gyFVwspYH1LxZTSIU3k+RXoNekgn4Y0l
	DSrgxgCovIDcb3v4RwmflUmFsaXTQSJAU+SJgysVSfaFTfAZopnqW8uI49cFWe4I
	1Yi88Ym3Or7CpkuOavA5P+YaSPt0s2rZCQ2zY+HA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pjdh6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 08:17:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AS82v9n017277;
	Fri, 28 Nov 2025 08:17:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pjdh6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 08:17:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS7N8H3030768;
	Fri, 28 Nov 2025 08:17:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgsv58n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 08:17:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AS8H3I152756752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 08:17:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14D602004B;
	Fri, 28 Nov 2025 08:17:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66E5620040;
	Fri, 28 Nov 2025 08:17:00 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 08:17:00 +0000 (GMT)
Date: Fri, 28 Nov 2025 13:46:57 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 07/13] ext4: drop extent cache before splitting extent
Message-ID: <aSlaeSGfjlZbY3hB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-8-yi.zhang@huaweicloud.com>
 <aSbxjVypU3vdOUmK@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8680efcd-dc84-4b4e-ab75-216de959ec88@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8680efcd-dc84-4b4e-ab75-216de959ec88@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX4ke+wdaAoA7Y
 5V5Wn/J4SoKii3TqjZdwxnmxglgFuZJp0X7KXZ82OcJwWlS9Ap8f4y0C3CnypNH1cJCnUWGKw/f
 AalqxHofB7Zi+ZOV+ALey3YJxFS3f0lUAipl8v6++HiMX+fZc3YHSBY0nxVQ0E09iNarU+K0Yha
 aK6Fs/3yTm1rmzQMAsyswBbfq6uI+DGmTNzYqlxPx1lX1q4GbHo5ElHFWcawZQDmsyFnCOmunWj
 DH4mwD+35bP4IiYvaXEUReLXtMBLmCjP6E2snQ9nvhxwp+Bqwk5RbWocuBHgUsClvG2GvXdc0vT
 wtdmT+4F6cAn5TsX6tqy5vLsYGPSBYhsqPH/MFnGNC0TgTm65X4T93+uneLMFpaRzeSR50qkfSv
 3nkpWP/xvIO3ocoz9t5vwohXFqovbQ==
X-Proofpoint-ORIG-GUID: hLps9tKJ5Cp0iIpHP4iP68dSwmjRR9OM
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=69295a82 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=fqodqz1WO6RGQZwoOqgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 6FIoe6oOQ-VSjmLlGMVUMeDyzPdY2mM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016

On Thu, Nov 27, 2025 at 03:27:26PM +0800, Zhang Yi wrote:
> On 11/26/2025 8:24 PM, Ojaswin Mujoo wrote:
> > On Fri, Nov 21, 2025 at 02:08:05PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> When splitting an unwritten extent in the middle and converting it to
> >> initialized in ext4_split_extent() with the EXT4_EXT_MAY_ZEROOUT and
> >> EXT4_EXT_DATA_VALID2 flags set, it could leave a stale unwritten extent.
> >>
> >> Assume we have an unwritten file and buffered write in the middle of it
> >> without dioread_nolock enabled, it will allocate blocks as written
> >> extent.
> >>
> >>        0  A      B  N
> >>        [UUUUUUUUUUUU] on-disk extent      U: unwritten extent
> >>        [UUUUUUUUUUUU] extent status tree
> >>        [--DDDDDDDD--]                     D: valid data
> >>           |<-  ->| ----> this range needs to be initialized
> >>
> >> ext4_split_extent() first try to split this extent at B with
> >> EXT4_EXT_DATA_PARTIAL_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
> >> ext4_split_extent_at() failed to split this extent due to temporary lack
> >> of space. It zeroout B to N and leave the entire extent as unwritten.
> >>
> >>        0  A      B  N
> >>        [UUUUUUUUUUUU] on-disk extent
> >>        [UUUUUUUUUUUU] extent status tree
> >>        [--DDDDDDDDZZ]                     Z: zeroed data
> >>
> >> ext4_split_extent() then try to split this extent at A with
> >> EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and
> >> leave
> >> an written extent from A to N.
> > 
> > Hi Yi, 
> > 
> > thanks for the detailed description. I'm trying to understand the
> > codepath a bit and I believe you are talking about:
> > 
> > ext4_ext_handle_unwritten_extents()
> >   ext4_ext_convert_to_initialized()
> > 	  // Case 5: split 1 unwrit into 3 parts and convert to init
> > 		ext4_split_extent()
> 
> Yes, but in fact, it should be Case 1: split the extent into three
> extents.

Yes right my bad :) 

> 
> > 
> > in which case, after the second split succeeds
> >>
> >>        0  A      B   N
> >>        [UU|WWWWWWWWWW] on-disk extent     W: written extent
> >>        [UU|UUUUUUUUUU] extent status tree
> > 
> > WHen will extent status get split into 2 unwrit extents as you show
> > above? I seem to be missing that call since IIUC ext4_ext_insert_extent
> > itself doesn't seem to be accounting for the newly inserted extent in es.
> > 
> 
> Sorry for the confusion. This was drawn because I couldn't find a
> suitable symbol, so I followed the representation method used for
> on-disk extents. In fact, there is no splitting of extent status entries
> here. I have updated the last two graphs as follows(different types of
> extents are considered as different extents):
> 
>            0  A      B  N
>            [UUWWWWWWWWWW] on-disk extent     W: written extent
>            [UUUUUUUUUUUU] extent status tree
>            [--DDDDDDDDZZ]
> 
>            0  A      B  N
>            [UUWWWWWWWWWW] on-disk extent     W: written extent
>            [UUWWWWWWWWUU] extent status tree
>            [--DDDDDDDDZZ]

Thanks for confirming, I think according to our representation, the
following is what happens:

            0  A      B  N
            [UU|WWWWWWWWWW] on-disk extent   W: written extent  <--split
            [UUUUUUUUUUUUU] extent status tree   <---- no split
            [---DDDDDDDDZZ]
 
            0  A      B  N
            [UU|WWWWWWWWWW] on-disk extent   W: written extent  <--split
            [UU|WWWWWWW|UU] extent status tree   <--- split 
            [---DDDDDDDZZZ]

Anyways, I just had this doubt while trying to understand this codepath
so thanks for clarifying :)

> 
> Will this make it easier to understand?
> 
> Cheers,
> Yi.
> 
> 
> > Regards,
> > ojaswin
> > 
> >>        [--|DDDDDDDDZZ]
> > 
> >>
> >> Finally ext4_map_create_blocks() only insert extent A to B to the extent
> >> status tree, and leave an stale unwritten extent in the status tree.
> >>
> >>        0  A      B   N
> >>        [UU|WWWWWWWWWW] on-disk extent     W: written extent
> >>        [UU|WWWWWWWWUU] extent status tree
> >>        [--|DDDDDDDDZZ]
> >>
> >> Fix this issue by always remove cached extent status entry before
> >> splitting extent.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  fs/ext4/extents.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> >> index 2b5aec3f8882..9bb80af4b5cf 100644
> >> --- a/fs/ext4/extents.c
> >> +++ b/fs/ext4/extents.c
> >> @@ -3367,6 +3367,12 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
> >>  	ee_len = ext4_ext_get_actual_len(ex);
> >>  	unwritten = ext4_ext_is_unwritten(ex);
> >>  
> >> +	/*
> >> +	 * Drop extent cache to prevent stale unwritten extents remaining
> >> +	 * after zeroing out.
> >> +	 */
> >> +	ext4_es_remove_extent(inode, ee_block, ee_len);
> >> +

Okay this makes sense, there are many different combinations of how the
on disk extents might turn out and if will become complicated to keep
the es in sync to those, so this seems simpler.

There might be a small performance penalty of dropping the es here tho
but idk if it's anything measurable. As a middle ground do you think it
makes more sense to drop the es cache in ext4_split_extent_at() instead,
when we know we are about to go for zeroout. Since the default non
zeroout path seems to be okay?

Regards,
ojaswin



> >>  	/* Do not cache extents that are in the process of being modified. */
> >>  	flags |= EXT4_EX_NOCACHE;
> >>  
> >> -- 
> >> 2.46.1
> >>
> 

