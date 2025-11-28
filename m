Return-Path: <linux-fsdevel+bounces-70117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FFDC91208
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 09:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB0564E2958
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 08:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6F12D7DF2;
	Fri, 28 Nov 2025 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gkYRFzc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9917736;
	Fri, 28 Nov 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317965; cv=none; b=CFLeHQ7ja9e7T1DChjmga1fGTDS1HETLmfVMbpd5yPbTqoq3M5XQykPicimiMd1KC/Z0x+VX+0SUrTq2roIvqDtzn18nK5edlm1Iaw4Uga9+ZftjjA9bTGphLkIypa7W2TL+TbHjZYomJ87wYephHYaqBXZth4sDyg9Kz2kKIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317965; c=relaxed/simple;
	bh=t4svx544krK6UsFwhiuI3ZNWx3w13dC9+7tQ64IT6vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YijViJPw5b0CPlWL9Chy8ccXpsukofGJBXNxO776Q3YBVulf0S/2GTfobmHrzmG0YMzNYNU72s30n1Qa9Qf7V6xPPAH0WlKm7tTplV8HrT9SEKZCaCiINbQRP59/WhSWQSvSskwL3TjRIq+C2Xt41bFhJotNEMES6k+BHQsSq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gkYRFzc+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARG0aE6007359;
	Fri, 28 Nov 2025 08:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aEEp66bn90RXVnckRC44+5Gmepuu7v
	sjIaYK67s5GFk=; b=gkYRFzc+BpWhM+6atsB48x+OEanL8KcuO8gUeF36vYBmIo
	wV3KLoRHoOW+T3ZAM5J5C3r49M0Ozn2xXPDQIo1kjTLyU6fLI8JQQY0KKZ8oiPrK
	OLO+Rn7Kc642qtUJqv6b1aIpdT6SXFPRp71ntmO+Y/48qDGSh8WXFkqo6FZYe2GV
	tTZjtFJlXPJTpRkmEMnrGysYQmv9HJVUMycU/QcFdItWiaw8Fm/HT3CR6Z4pMdzm
	Je1moOo6SrenqcvvxfvV4YCGkMUt+RQzJ8mi4TlMopiqKUR4NoEoPAvc5bpRaBeu
	2b3dyyEsRcnsbJAcZGwrkA/zK6tVmEUMX8lMAMKw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kqbxj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 08:19:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AS8Cjou024069;
	Fri, 28 Nov 2025 08:19:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kqbxj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 08:19:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS5DdKv025127;
	Fri, 28 Nov 2025 08:19:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71uqe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 08:19:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AS8J3D661473220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 08:19:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94DA720043;
	Fri, 28 Nov 2025 08:19:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CE9F20040;
	Fri, 28 Nov 2025 08:19:01 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 08:19:00 +0000 (GMT)
Date: Fri, 28 Nov 2025 13:48:58 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 06/13] ext4: don't cache extent during splitting extent
Message-ID: <aSla8sc66ys6zCGZ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-7-yi.zhang@huaweicloud.com>
 <aSbsxpMSVGyywIIX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <bec5bcd5-59ea-4e69-bf4c-7031bcf9008b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec5bcd5-59ea-4e69-bf4c-7031bcf9008b@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX7guQdvD/qNDL
 66T8vbvQwTymAuNuw0ikKdmv+r/zAfm0ZZx8Gobp/OGpLEMYg8sOQ4K83P+c3XYcuwMx26IlTQx
 OjzqjDlM0s4HULGh4hz7PjwGYbltIvGPDiBoCGVO/TqkBAMzp/xAsvBxzyU1wzJjqxERum6y086
 NM+zEVzQE2Kkdpf19egNK1UBXc8A7wGkr7ORDSdlgLsxFBP4c20VKaFO8VHP24RhkyLh0qoyD14
 dgoQrqJZrRp0ZfHNlTLkc/c61HVQbxzYnQuf4Ruf8o8AjiU6CtXyROvw9jrDfN2/X1ymTmw3nzA
 uKKwwKd73HEL6o+UsFn+qJjO6nW+jq5XlyHf3ob0UG58tQ1WwggRZu8VrFiLE55t0Z7toO5juRX
 kS7oJoF0gCcoAueIWZ1UdL2zqccvLA==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=69295afa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=R1mwVcuV0LkZenN7glYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1a0EHTG4SCmkLJlnUUcbdZ0WiiaEnM_p
X-Proofpoint-ORIG-GUID: w6bu7QM9uitPWf5HTRI8-Pfv4M0rgk3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000

On Thu, Nov 27, 2025 at 03:01:27PM +0800, Zhang Yi wrote:
> On 11/26/2025 8:04 PM, Ojaswin Mujoo wrote:
> > On Fri, Nov 21, 2025 at 02:08:04PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Caching extents during the splitting process is risky, as it may result
> >> in stale extents remaining in the status tree. Moreover, in most cases,
> >> the corresponding extent block entries are likely already cached before
> >> the split happens, making caching here not particularly useful.
> >>
> >> Assume we have an unwritten extent, and then DIO writes the first half.
> >>
> >>   [UUUUUUUUUUUUUUUU] on-disk extent        U: unwritten extent
> >>   [UUUUUUUUUUUUUUUU] extent status tree
> >>   |<-   ->| ----> dio write this range
> >>
> >> First, when ext4_split_extent_at() splits this extent, it truncates the
> >> existing extent and then inserts a new one. During this process, this
> >> extent status entry may be shrunk, and calls to ext4_find_extent() and
> >> ext4_cache_extents() may occur, which could potentially insert the
> >> truncated range as a hole into the extent status tree. After the split
> >> is completed, this hole is not replaced with the correct status.
> >>
> >>   [UUUUUUU|UUUUUUUU] on-disk extent        U: unwritten extent
> >>   [UUUUUUU|HHHHHHHH] extent status tree    H: hole
> >>
> >> Then, the outer calling functions will not correct this remaining hole
> >> extent either. Finally, if we perform a delayed buffer write on this
> >> latter part, it will re-insert the delayed extent and cause an error in
> >> space accounting.
> > 
> > Okay, makes sense. So one basic question, I see that in
> > ext4_ext_insert_extent() doesnt really care about updating es unless as a
> > side effect of ext4_find_extent().  For example, if we end up at goto
> > has_space; we don't add the new extent and niether do we update that the
> > exsisting extent has shrunk. 
> > 
> > Similarly, the splitting code also doesn't seem to care about the es
> > cache other than zeroout in the error handling.
> > 
> > Is there a reason for this? Do we expect the upper layers to maintain
> > the es cache?
> 
> Yeah, if we don't consider the zeroout case caused by a failed split,
> under typical circumstances, the ext4_es_insert_extent() in
> ext4_map_create_blocks() is called to insert or update the cached
> extent entries.
> 
> However, ext4_map_create_blocks() only insert or update
> the range that the caller want to map, it can't know the actual
> initialized range if this extent has been zeroed out, so we have to
> update the extent cache in ext4_split_extent_at() for this special case.
> Please see commit adb2355104b2 ("ext4: update extent status tree after
> an extent is zeroed out") for details.
> 
> Unfortunately, the legacy scenario described in this patch remains
> unhandled.

Got it thanks for the details.

Feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> 
> Cheers,
> Yi.
> 
> >>
> >> In adition, if the unwritten extent cache is not shrunk during the
> >> splitting, ext4_cache_extents() also conflicts with existing extents
> >> when caching extents. In the future, we will add checks when caching
> >> extents, which will trigger a warning. Therefore, Do not cache extents
> >> that are being split.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  fs/ext4/extents.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> >> index 19338f488550..2b5aec3f8882 100644
> >> --- a/fs/ext4/extents.c
> >> +++ b/fs/ext4/extents.c
> >> @@ -3199,6 +3199,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
> >>  	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
> >>  	       (split_flag & EXT4_EXT_DATA_VALID2));
> >>  
> >> +	/* Do not cache extents that are in the process of being modified. */
> >> +	flags |= EXT4_EX_NOCACHE;
> >> +
> >>  	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
> >>  
> >>  	ext4_ext_show_leaf(inode, path);
> >> @@ -3364,6 +3367,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
> >>  	ee_len = ext4_ext_get_actual_len(ex);
> >>  	unwritten = ext4_ext_is_unwritten(ex);
> >>  
> >> +	/* Do not cache extents that are in the process of being modified. */
> >> +	flags |= EXT4_EX_NOCACHE;
> >> +
> >>  	if (map->m_lblk + map->m_len < ee_block + ee_len) {
> >>  		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
> >>  		flags1 = flags | EXT4_GET_BLOCKS_PRE_IO;
> >> -- 
> >> 2.46.1
> >>
> 

