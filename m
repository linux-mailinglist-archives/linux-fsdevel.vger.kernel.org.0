Return-Path: <linux-fsdevel+bounces-67069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3014C341A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 07:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E89462EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 06:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45B2C21EF;
	Wed,  5 Nov 2025 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DXWblFML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AA261B9F;
	Wed,  5 Nov 2025 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325655; cv=none; b=mzwfulBKyLSbenTbHNLTkbqSTr9CqRupe8kpmUUT1r42T0HOM9lVoJzSWVxpC/EdTT7/zXeTH8DLWMTQTPXgAUbZRsx//ULWk05LBVOygXX3WAdFT0W4VgT3N7G4p1BiHtZCN7ma26t8k0JexMBbZQjlYogWDf0fCt0ZBXMfI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325655; c=relaxed/simple;
	bh=uBFkuZWkTbQtVaFIvftCub5c2XfflkmLEvSymfgliiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwbfAacWctePTUWbhZqlD7XyiMc5NPMQ4rPaLk4c177v+gPzawJOBxsN3vYtI0/HghFSJimUC00D4qxgrQl1mfnwvvtfuVcglzpsqnVImfcqgaDYzKZobbLTwtLSMp2Jk9PsbZzJtX/tLit1HpOywWlppNoOFm+/h4gGHyKj5jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DXWblFML; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4KKCrS016813;
	Wed, 5 Nov 2025 06:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NIgReO
	Lt1nH2NiTpdMcRGEfC2amuOW8w72i+WvMIeLw=; b=DXWblFMLcMK7dQnPYAng2p
	ovWrkQ8gQI0cvrhoMcZjBmvQIx8P+Sz2NL+Md6+V+xPNXyBJHnTTCSL/4y/5MrFA
	PMOUp9zQhTeMcnS8+c0mfcPXHBIwaeNnON/Cp0jV+p5XME/AxxcF0Ut4bNxasgV7
	V75jLM1HqjQauUz1cqtytC3U+wRSdS5Wq/OZdOs4ITExeN9qf6EFf8qZF9oD1XL7
	dSSNM8DBrQj26v3pRKinhfxEoFk8aB1QHnvVNdCeKrd8npYdR+x8KF4ePv8NNwgM
	2X/c6fcNJnu+6XowVbD9ZV2Onr12uofr9HeJ9fHgqYFXNWbFmi6NKheHroM1mZMQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v1ygt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 06:54:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A542OCU021471;
	Wed, 5 Nov 2025 06:54:03 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrjpmy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 06:54:03 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A56s33P30671612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 06:54:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8076858058;
	Wed,  5 Nov 2025 06:54:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588BB5805D;
	Wed,  5 Nov 2025 06:54:02 +0000 (GMT)
Received: from [9.109.198.245] (unknown [9.109.198.245])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 06:54:02 +0000 (GMT)
Message-ID: <b8e86d6f-dadc-477e-b0f9-f5d9d50a3127@linux.ibm.com>
Date: Wed, 5 Nov 2025 12:24:00 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] fstests generic/085 btrfs hang with use-after-free
 at bdev_super_lock
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <asuxk7u6tlrjb5ruugshjvydiixo6vcvayu6yzfeu5fblkxdxh@3whdau6mprqv>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <asuxk7u6tlrjb5ruugshjvydiixo6vcvayu6yzfeu5fblkxdxh@3whdau6mprqv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: udrflgboVtG4Ikl1yGaWkSVzHEZVTTFX
X-Proofpoint-ORIG-GUID: udrflgboVtG4Ikl1yGaWkSVzHEZVTTFX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX54Kf18vUpkfq
 EPH90OZY5n4r3Mt8s8W/td22KKfurh8k59kqTpmTnVe0xt+pJDyQUtntiBqx8Yape9UfP6hog7k
 d25NeVjQgzyU9Vk6Hsd5ovjW/fAulwQ51etq0WL2j/iuxvInOSNaZHNVxy7rchSqG6PMT4vo1kB
 z4gs8sJaEYfNN5VDKkH8gpTSjgGDUPFmBjCmOO4tLbp5nHgE7QHnFOmThpvN57+1DNfdCWlxi8E
 AV5BelXeBf7ddbbfFv6vcw0ESsp41aScKMzFo8+vfkIrIgjpCYz9lJK5858GA4GGVs/az2KF3Ue
 KBEzCjoM5JaNSC82MimLFL85pBdLoWwgSzMZck1H1Qp1OBpYieaPqvGWY/DA6+MGDUvWNCy3U3S
 fz2YcWk3NqV0jhnpQAwFNphJauxRIQ==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=690af48c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_FWC9dmBtg7OGuMU_m4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

Hi Shinichiro,

On 11/5/25 6:31 AM, Shinichiro Kawasaki wrote:
> When I run fstests for btrfs on regular null_blk devices, I observe KASAN
> slab-use-after-free in bdev_super_lock() followed by kernel hang. I observed it
> for the kernel v6.17-rc4 for the first time. And I still observe it for the
> latest kernel v6.18-rc4.
> 
> The hang is recreated when I prepare eight of 5Gib size null_blk devices, assign
> one for TEST_DEV, and assign the other seven for SCRATCH_DEV_POOl. The hang
> happens at generic/085. It is sporadic. When I repeat the test case g085 only,
> the hang is not recreated. But when I repeat the whole fstests a few times, the
> hang is recreated in stable manner. It takes several hours to recreate the hang.
> 
> I spent some weeks to bisect, and found the trigger commit is this:
> 
>   370ac285f23a ("block: avoid cpu_hotplug_lock depedency on freeze_lock")
> 
> The commit was included in the kernel tag v6.17-rc3. When I reverted the commit
> from v6.17-rc3, the hang disappeared (I repeated the whole fstests 5 times on
> two test nodes, and did not observe the hang). I'm not sure if the commit
> created the problem cause or revealed the hidden problem.

Thanks for the report!

This doesn't seem to be caused due to 370ac285f23a ("block: avoid cpu_hotplug_lock
depedency on freeze_lock"). However it appears that we're hitting a race while 
freezing/unfreezing filesystem. It'd better if someone from fs team can take a 
look at it.

Thanks,
--Nilay

