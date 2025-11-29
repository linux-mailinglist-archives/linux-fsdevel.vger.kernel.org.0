Return-Path: <linux-fsdevel+bounces-70266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB4C94695
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 19:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52464346B11
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 18:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA02494D8;
	Sat, 29 Nov 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZTlmn01d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D72459ED;
	Sat, 29 Nov 2025 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764441731; cv=none; b=AN/WXJ9agUC9ssmFwg5O5M/jnKRkFvnTtQv7bgaIqNa6XWkwhB3dAxd5Hy1IB29+SI5eYEPOKsgaDifhM3TbmekW6z8Wner2joS2b0HXWDiV2+11MB2wTpGUlt61zrfkHpPUQ2X7P92FHUqWLWJsk1shubzUxNK+yFd+TcFUqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764441731; c=relaxed/simple;
	bh=v+V8/03RTax7Gno4hr3fhmSCKyT3N2ruKD8KekdsZxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdMVMoCtJJhKf9a9mklFj5o9UHNjYZzGhqTS66QFnkuiOrkPpgCzVyrTtsjqKdiXZcJIOEvih9pc88aD94PqO1CCEWHxMczhKe9pnHfdNWnmbKpMOJ1tKfz21SENvDJXTs1KKCZZYeHotgFHSj+DpRWX8IhNOv3q7tk/GEQeid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZTlmn01d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AT2uQUV021827;
	Sat, 29 Nov 2025 18:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DXUFpa
	F6G4o6yt2etVBBgciPhN4r2Y9+zGIUHZe5hlg=; b=ZTlmn01dfmMEE3RkG4MfCP
	JbrOkVGzdq+YbvMepPKycnnWsi+smV++u5zCuQ07SGkgyPxPa8bjemh/XAwTs1fO
	d06+GQZeWKDEzY9y30UrH5NGsPsz3QK2pddj7dCyQR9KWjgeZFuKrIXiRQfM0BFX
	dItTv3n0jqF799w4VoSCeAeMokTNm+lUax8ZPxTba774Og4Wzsxap2KYrLLSvNr3
	8KD2oJiN0aCc4nKpG7z0oh6Iao3EeNwkI0b0z+BDs6jQWE5sxlH2pHKkcEQ9spk6
	gSpcTxQJnYOc4wJgQsqo4XaNNmZwx1XtiXSr352OgvzM9e9gNxXhS05T90RXBX9A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg51fds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 18:41:44 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ATIfiib018608;
	Sat, 29 Nov 2025 18:41:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg51fdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 18:41:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATEZkT1000861;
	Sat, 29 Nov 2025 18:41:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvyj601-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 18:41:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ATIffhT24445206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Nov 2025 18:41:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A089020040;
	Sat, 29 Nov 2025 18:41:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 347442004B;
	Sat, 29 Nov 2025 18:41:39 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 29 Nov 2025 18:41:39 +0000 (GMT)
Date: Sun, 30 Nov 2025 00:11:36 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huaweicloud.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, yi.zhang@huawei.com,
        yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/13] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1
Message-ID: <aSs-YExXqLQ0k49M@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
 <yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq>
 <aSlPFohdm8IfB7r7@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <i3voptrv4rm3q3by7gksrgmgy2n5flchuveugjll5cchustm4z@qvixahynpize>
 <DDB4CC13-C509-478E-81C3-F37240016A69@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDB4CC13-C509-478E-81C3-F37240016A69@dilger.ca>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5_ZbgcuVYMdjWIFU1OS3T9vb1o6XwJM4
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=692b3e69 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=D-dcYy2LwJFk0zEjfIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX2MIgFBtYcepg
 h+Q51zkH24dJFG4mQ6cl7QKATSdqTPDKoPzaPZEEysBlvEaf5EW+OXHO8pw26ezMJS5vQo+U9bT
 W1ngkvXnvLs74Bzvhjgx76PtSV0u9DqTptMHcdbr7sCEpLj//jOVo2jzDTd3ZyC3KFxn/bfhdbg
 /TmWeJ5U//nPCyZCMItbwDf47Vu1RXL8jHIZeCLgglhENequ5XTu42x3ZmvQDCJQFDuiwpYt4l7
 ELDQs5TZqRPy41r4X5oA0jFjME0ZUSbOVQgOBqJY8gWwpxLMgTEmpbjNL7bg2oN3QK8vkBNdTTo
 DXFyi9f8FC7RrFnMYjKKTUXV61+2dKW5UcgkFeRr3Kcv22E5CHc5a+mxlUKq0GOATAe9PwkpalW
 ZEAGYTSzH+zyglWKHxEgvavYnm2eqg==
X-Proofpoint-GUID: bcWkEPtvpD1VZDpPaQEA-IuX2HPDgNWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020

On Fri, Nov 28, 2025 at 12:52:30PM -0700, Andreas Dilger wrote:
> 
> 
> > On Nov 28, 2025, at 4:14 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > On Fri 28-11-25 12:58:22, Ojaswin Mujoo wrote:
> >> On Thu, Nov 27, 2025 at 02:41:52PM +0100, Jan Kara wrote:
> >>> Good catch on the data exposure issue! First I'd like to discuss whether
> >>> there isn't a way to fix these problems in a way that doesn't make the
> >>> already complex code even more complex. My observation is that
> >>> EXT4_EXT_MAY_ZEROOUT is only set in ext4_ext_convert_to_initialized() and
> >>> in ext4_split_convert_extents() which both call ext4_split_extent(). The
> >>> actual extent zeroing happens in ext4_split_extent_at() and in
> >>> ext4_ext_convert_to_initialized(). I think the code would be much clearer
> >>> if we just centralized all the zeroing in ext4_split_extent(). At that
> >>> place the situation is actually pretty simple:
> >> 
> >> This is exactly what I was playing with in my local tree to refactor this
> >> particular part of code :). I agree that ext4_split_extent() is a much
> >> better place to do the zeroout and it looks much cleaner but I agree
> >> with Yi that it might be better to do it after fixing the stale
> >> exposures so backports are straight forward. 
> >> 
> >> Am I correct in understanding that you are suggesting to zeroout
> >> proactively if we are below max_zeroout before even trying to extent
> >> split (which seems be done in ext4_ext_convert_to_initialized() as well)?
> > 
> > Yes. I was suggesting to effectively keep the behavior from
> > ext4_ext_convert_to_initialized().
> > 
> >> In this case, I have 2 concerns:
> >> 
> >>> 
> >>> 1) 'ex' is unwritten, 'map' describes part with already written data which
> >>> we want to convert to initialized (generally IO completion situation) => we
> >>> can zero out boundaries if they are smaller than max_zeroout or if extent
> >>> split fails.
> >> 
> >> Firstly, I know you mentioned in another email that zeroout of small ranges
> >> gives us a performance win but is it really faster on average than
> >> extent manipulation?
> > 
> > I guess it depends on the storage and the details of the extent tree. But
> > it definitely does help in cases like when you have large unwritten extent
> > and then start writing randomly 4k blocks into it because this zeroout
> > logic effectively limits the fragmentation of the extent tree. Overall
> > sequentially writing a few blocks more of zeros is very cheap practically
> > with any storage while fragmenting the extent tree becomes expensive rather
> > quickly (you generally get deeper extent tree due to smaller extents etc.).
> 
> The zeroout logic is not primarily an issue with the extent tree complexity.
> I agree with Ojaswin that in the common case the extent split would not
> cause a new index block to be written, though it can become unwieldy in the
> extreme case.
> 
> As Jan wrote, the main performance win is to avoid writing a bunch of
> small discontiguous blocks.  For HDD *and* flash, the overhead of writing
> several separate small blocks is much higher than writing a single 32KiB
> or 64KiB block to the storage.  Multiple separate blocks means more items
> in the queue and submitted to storage, separate seeks on an HDD and/or read-
> modify-write on a RAID controller, or erase blocks on a flash device.

Okay makes sense, so basically zeroout helps in the long run by reducing
fragmentation.

> 
> It also defers the conversion of those unwritten extents to a later time,
> when they would need to be processed again anyway if the blocks were written.
> 
> I was also considering whether the unwritten blocks would save on reads,
> but I suspect that would not be the case either.  Doing sequential reads
> would need to submit multiple small reads to the device and then zeroout
> the unwritten blocks instead of a single 32KiB or 64KiB read (which is
> basically free once the request is processed.
> 
> > 
> >> For example, for case 1 where both zeroout and splitting need
> >> journalling, I understand that splitting has high journal overhead in
> >> worst case, where tree might grow, but more often than not we would be
> >> manipulating within the same leaf so journalling only 1 bh (same as
> >> zeroout). In which case seems like zeroout might be slower no matter
> >> how fast the IO can be done. So proactive zeroout might be for beneficial
> >> for case 3 than case 1.
> > 
> > I agree that initially while the split extents still fit into the same leaf
> > block, zero out is likely to be somewhat slower but over the longer term
> > the gains from less extent fragmentation win.
> 
> I doubt that writing a single contiguous 32KiB chunk is ever going to be
> slower than writing 2 or 3 separate 4KiB chunks to the storage.  _Maybe_
> if it was NVRAM, but I don't think that would be the common case?
> 
> >>> 2) 'ex' is unwritten, 'map' describes part we are preparing for write (IO
> >>> submission) => the split is opportunistic here, if we cannot split due to
> >>> ENOSPC, just go on and deal with it at IO completion time. No zeroing
> >>> needed.
> >>> 
> >>> 3) 'ex' is written, 'map' describes part that should be converted to
> >>> unwritten => we can zero out the 'map' part if smaller than max_zeroout or
> >>> if extent split fails.
> >> 
> >> Proactive zeroout before trying split does seem benficial to help us
> >> avoid journal overhead for split. However, judging from
> >> ext4_ext_convert_to_initialized(), max zeroout comes from
> >> sbi->s_extent_max_zeroout_kb which is hardcoded to 32 irrespective of
> >> the IO device, so that means theres a chance a zeroout might be pretty
> >> slow if say we are doing it on a device than doesn't support accelerated
> >> zeroout operations. Maybe we need to be more intelligent in setting
> >> s_extent_max_zeroout_kb?
> > 
> > You can also tune the value in sysfs. I'm not 100% sure how the kernel
> > could do a better guess. Also I think 32k works mostly because it is small
> > enough to be cheap to write but already large enough to noticeably reduce
> > fragmentation for some pathological workloads (you can easily get 1/4 of
> > the extents than without this logic). But I'm open to ideas if you have
> > some.
> 
> Aligning this size with the flash erase block size might be a win?
> It may be that 32KiB is still large enough today (I've heard of 16KiB
> sector flash devices arriving soon, and IIRC 64KiB sectors are the
> norm for HDDs if anyone still cares).  Having this tuned automatically
> by the physical device characteristics (like max(32KiB, sector size) or
> similar if the flash erase block size is available somehow in the kernel)
> would future proof this as device sizes continue to grow.

okay so do you think it makes sense to consider the
max_write_zeroes_sectors() value of the underlying device. Enterprise
NVMEs and SCSI disks can utilize WRITE_ZEROES or WRITE_SAME which can
allow us to potentially zeroout much larger ranges with minimal overhead
of data movement. Maybe we can leverage these to zeroout more
aggressively without much of a performance penalty.

Let me try to see if i can find a disk and try a POC for this.

Regards,
ojaswin

> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 

