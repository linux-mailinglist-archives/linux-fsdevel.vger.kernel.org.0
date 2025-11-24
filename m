Return-Path: <linux-fsdevel+bounces-69669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBE0C809AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 13:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B7164E9134
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 12:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA935302767;
	Mon, 24 Nov 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aEAYMrWs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38B3019B5;
	Mon, 24 Nov 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988670; cv=none; b=drh0+JuQWSNpaLpF2dVf31S+U1sR0ipkUSo9xx3cP7vJVWgsCFWabnUDQ7/200QOaMaxVh/YMb377f1eCgchAzaaQCLWwxMud3GAojoPVlq52f9kHpkrbq3okcb24HFB6mtHH+w6fT2cGhFzy7KXFHsvjUV/i5E+vaaiD/Wqids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988670; c=relaxed/simple;
	bh=CfAy31q2lb+iACwJS3ZNEhHvdH0Ckqb0R7qTYoKELLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXXBjJQDbvtKLuqTVUTmpE+cJK38pLMGZV4N/4AEI9U9iiv+gml6GHU1tAEzALjDNXmacKX+Y5km2+hXLCOHfF3zCf/9Ixsz132kP8CUiEBMYOt6xzTOEQFqybrUN0NMgZkqvUwkkWbWuLaOlXzMsUilF3WdWNQpKsyjokP4u9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aEAYMrWs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ANNhDJK019444;
	Mon, 24 Nov 2025 12:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=c+TqOEGJci1sFytT3AS+LBkgx8Akvv
	csadiuWVoN2aY=; b=aEAYMrWsFUar/hZFqWgCz3ECdrpfVCt4SatQeJGnBrb+O/
	NnzJbeahsPHMKROaOs/DLnFIOE9RP8ZpvYcsJekOPHeeBvVi3WbVgpUhL76CSrjs
	lVdAwCN5nY5ayRE08TAOm3LnPdxS97YIu3NSj8M3c5iGBvuBrCzTBOyA8m/0OeGe
	aFp/qiq4ightdzcCRR7nwpomHnbRxk98rK0K1jVvIqIhYHtjpgA5E8axgl8oOtLU
	U4k9R3BM94S0+rcfCEhhxY8DPUw1XrDepTZQIi9k7lPpwlar+vJCnaKP3b5pQfFE
	U29NxDb38w68mNME6wUiQ2VifnICWuAyfTh/fXLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjqr4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 12:50:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AOCiM4R022608;
	Mon, 24 Nov 2025 12:50:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjqr4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 12:50:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOAtgSp014527;
	Mon, 24 Nov 2025 12:50:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgmx05m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 12:50:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AOColJb35258794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 12:50:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CCC020043;
	Mon, 24 Nov 2025 12:50:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0C4E20040;
	Mon, 24 Nov 2025 12:50:44 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.21.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Nov 2025 12:50:44 +0000 (GMT)
Date: Mon, 24 Nov 2025 18:20:42 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 00/13] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
Message-ID: <aSRUohHsq3MsiGv0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <aSLoN-oEqS-OpLKE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9cef3b97-083e-48e6-aced-3e250df364e3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cef3b97-083e-48e6-aced-3e250df364e3@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GEdzfgLqv5az0qPyuFk4N3bRRbkDuL7U
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=692454aa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=Flq6I1naRifewFLxwkEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: OTDfnSE0a6zmfgxr8oavHBCxhkFDvhZl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX42XfYweSJfPl
 GP32UGXbr5H0Bd786dZbufFD++WTjI3ltd2W0Kg/zuitzDmjL6wd2kHpa8gKY9mZE64TMZ64ly4
 CG7Gqal0T/lJ7iOPmTBsr2VVRROOpQiURNoWLuGUQxfqW/hS0jSLLpgijxfIG3+y11KzdPDqlmC
 UbqjXkWKP4x+7CLg0iJLlkZyebtryEjhoVowAPXSbXT/YYT9Z4v6xIsWODBU1Frq7WiV6io1jWB
 hISd1UuM16HSA5P7mLqSy++YMIERgWDKgFAZ0L9bJ3358ykgVhq91T4gJiXWevikRxtoNqd6CXo
 oVMQXnvc/2lVXLdllpmn5tOkbo+bnAruv8BT9S7iDDaspQ58tuI/a3cCwlzA+rxxKXkm3/NqbXK
 2PkmK2cM4644BcEqjpqw/qHZ7Iw5/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

On Mon, Nov 24, 2025 at 01:04:04PM +0800, Zhang Yi wrote:
> Hi, Ojaswin!
> 
> On 11/23/2025 6:55 PM, Ojaswin Mujoo wrote:
> > On Fri, Nov 21, 2025 at 02:07:58PM +0800, Zhang Yi wrote:
> >> Changes since v1:
> >>  - Rebase the codes based on the latest linux-next 20251120.
> >>  - Add patches 01-05, fix two stale data problems caused by
> > 
> > Hi Zhang, thanks for the patches.
> > 
> 
> Thank you for take time to look at this series.
> 
> > I've always felt uncomfortable with the ZEROOUT code here because it
> > seems to have many such bugs as you pointed out in the series. Its very
> > fragile and the bugs are easy to miss behind all the data valid and
> > split flags mess. 
> > 
> 
> Yes, I agree with you. The implementation of EXT4_EXT_MAY_ZEROOUT has
> significantly increased the complexity of split extents and the
> potential for bugs.
> 
> > As per my understanding, ZEROOUT logic seems to be a special best-effort
> > try to make the split/convert operation "work" when dealing with
> > transient errors like ENOSPC etc. I was just wondering if it makes sense
> > to just get rid of the whole ZEROOUT logic completely and just reset the
> > extent to orig state if there is any error. This allows us to get rid of
> > DATA_VALID* flags as well and makes the whole ext4_split_convert_extents() 
> > slightly less messy.
> > 
> > Maybe we can have a retry loop at the top level caller if we want to try
> > again for say ENOSPC or ENOMEM. 
> > 
> > Would love to hear your thoughts on it.
> > 
> 
> I think this is a direction worth exploring. However, what I am
> currently considering is that we need to address this scenario of
> splitting extent during the I/O completion. Although the ZEROOUT logic
> is fragile and has many issues recently, it currently serves as a
> fallback solution for handling ENOSPC errors that arise when splitting
> extents during I/O completion. It ensures that I/O operations do not
> fail due to insufficient extent blocks.
> 
> Please see ext4_convert_unwritten_extents_endio(). Although we have made
> our best effort to tried to split extents using
> EXT4_GET_BLOCKS_IO_CREATE_EXT before issuing I/Os, we still have not
> covered all scenarios. Moreover, after converting the buffered I/O path
> to the iomap infrastructure in the future, we may need to split extents
> during the I/O completion worker[1].
> 
> In most block allocation processes, we already have a retry loop to deal
> with ENOSPC or ENOMEM, such as ext4_should_retry_alloc(). However, it
> doesn't seem appropriate to place this logic into the I/O completion
> handling process (I haven't thought this solution through deeply yet,
> but I'm afraid it could introduce potential deadlock risks due to its
> involvement with journal operations), and we can't just simply try again.
> If we remove the ZEROOUT logic, we may lose our last line of defense
> during the I/O completion.
> 
> Currently, I am considering whether it is possible to completely remove
> EXT4_GET_BLOCKS_IO_CREATE_EXT so that extents are not split before
> submitting I/Os; instead, all splitting would be performed when
> converting extents to written after the I/O completes. Based on my patch,
> "ext4: use reserved metadata blocks when splitting extent on endio"[2],
> and the ZEROOUT logic, this approach appears feasible, and xfstest-bld
> shows no regressions.
> 
> So I think the ZEROOUT logic remains somewhat useful until we find better
> solution(e.g., making more precise reservations for metadata). Perhaps we
> can refactor both the split extent and ZEROOUT logic to make them more
> concise.

Hi Yi,

Okay it makese sense to keep the zeroout if iomap path is planning to
shift the extent splitting to endio. Plus, I agree based on the comments
in the ext4_convert_unwritte_extents_endio() that we might even today
need to split in endio (although i cant recall when this happens) which
would need a zeroout fallback.

And yes, I think refactoring the whole logic to be less confusing would
be better. I had an older unposted untested patch cleaning up some of
this, I was looking at it again today and there seems to be a lot of
cleanups we can do here but that becomes out of scope of this patchset I
believe.

Sure then, lets keep it as it is for now. I'll review the changes you
made and later I can post a patch refactoring this area.

Regards,
ojaswin

> 
> [1] https://lore.kernel.org/linux-ext4/20241022111059.2566137-18-yi.zhang@huaweicloud.com/
> [2] https://lore.kernel.org/linux-ext4/20241022111059.2566137-12-yi.zhang@huaweicloud.com/
> 
> Cheers,
> Yi.
> 
> > Thanks,
> > Ojaswin
> > 
> >>    EXT4_EXT_MAY_ZEROOUT when splitting extent.
> >>  - Add patches 06-07, fix two stale extent status entries problems also
> >>    caused by splitting extent.
> >>  - Modify patches 08-10, extend __es_remove_extent() and
> >>    ext4_es_cache_extent() to allow them to overwrite existing extents of
> >>    the same status when caching on-disk extents, while also checking
> >>    extents of different stauts and raising alarms to prevent misuse.
> >>  - Add patch 13 to clear the usage of ext4_es_insert_extent(), and
> >>    remove the TODO comment in it.
> >>
> >> v1: https://lore.kernel.org/linux-ext4/20251031062905.4135909-1-yi.zhang@huaweicloud.com/
> >>
> >> Original Description
> >>
> >> This series addresses the optimization that Jan pointed out [1]
> >> regarding the introduction of a sequence number to
> >> ext4_es_insert_extent(). The proposal is to replace all instances where
> >> the cache of on-disk extents is updated by using ext4_es_cache_extent()
> >> instead of ext4_es_insert_extent(). This change can prevent excessive
> >> cache invalidations caused by unnecessarily increasing the extent
> >> sequence number when reading from the on-disk extent tree.
> >>
> >> [1] https://lore.kernel.org/linux-ext4/ympvfypw3222g2k4xzd5pba4zhkz5jihw4td67iixvrqhuu43y@wse63ntv4s6u/
> >>
> >> Cheers,
> >> Yi.
> >>
> >> Zhang Yi (13):
> >>   ext4: cleanup zeroout in ext4_split_extent_at()
> >>   ext4: subdivide EXT4_EXT_DATA_VALID1
> >>   ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
> >>   ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before
> >>     submitting I/O
> >>   ext4: correct the mapping status if the extent has been zeroed
> >>   ext4: don't cache extent during splitting extent
> >>   ext4: drop extent cache before splitting extent
> >>   ext4: cleanup useless out tag in __es_remove_extent()
> >>   ext4: make __es_remove_extent() check extent status
> >>   ext4: make ext4_es_cache_extent() support overwrite existing extents
> >>   ext4: adjust the debug info in ext4_es_cache_extent()
> >>   ext4: replace ext4_es_insert_extent() when caching on-disk extents
> >>   ext4: drop the TODO comment in ext4_es_insert_extent()
> >>
> >>  fs/ext4/extents.c        | 127 +++++++++++++++++++++++----------------
> >>  fs/ext4/extents_status.c | 121 ++++++++++++++++++++++++++++---------
> >>  fs/ext4/inode.c          |  18 +++---
> >>  3 files changed, 176 insertions(+), 90 deletions(-)
> >>
> >> -- 
> >> 2.46.1
> >>
> 

