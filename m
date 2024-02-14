Return-Path: <linux-fsdevel+bounces-11544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B28548BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225391F29D85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118511AADF;
	Wed, 14 Feb 2024 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CGiKXwMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CCB18E12;
	Wed, 14 Feb 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911311; cv=none; b=DnJcvRNqXf7gCy8nwb0fGV2B64ijHRnZ3lO++FPMsY6mrcnYc49oE+vSFGP4GhV/ydolnOP3YW3ixZjVrqTO4/5W/GhnyUPRWdAhtWpMiUpv0UgmLcTXfTGAFrJn6dzF4Or2lIJe+/5moJPyRfWIzAfqr+VMMo/iVQHWFcbkyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911311; c=relaxed/simple;
	bh=oALlycvzijqT3u6LKZHjCMTl3ICm8/2EuzPGAMI7hY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsofPdYUlWaGh7m4NHHiepIfP9R3sjJE6SNIQgZAcd20eof+SSiBEplvnyd5yBQLYVGRvwaXSPo81Tdk7NzyW46q1JrsA5X67n+nCtV59yfHFJI71cz989FxO1d9KoT+XMays5lZtWZmpUiep77hwLitDgsKqc1lA6PDKiJ0hIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CGiKXwMs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EBMIgT010608;
	Wed, 14 Feb 2024 11:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sWznURwDi0Ucv8qJGKi9O2ogY+i+OfhMkhYPI07d+tM=;
 b=CGiKXwMslGXDXbFJALr77tRRmEawlwBk2hI/7aaS0o41K8nGwZ9YHr7RWmILJ9fNWs5t
 qcBv4z4/jHSOcHSEQUcnJZGLILl0sPwMNERl2OOr9nGNhVBtFD5No7/aTZkdtRJadCLz
 LcIcMqCnL+9Tl3aJxkX4/0+d2c1zpJLCu3Mp/ja8MoAnfE1pEgDT8KK6Fz9S85ipLwZh
 I1FRneUfehyKvakb4zOPlpfQJL6J7+y4QphwGTeIQkh2CCQwU4yj9SjSEy22PK319c/v
 qsbq7zZfh4cFLaI2PBUu8ekkf/8cidbdeTgIYboHlzFsZOnYUQHCik1k4A90AUfemjnc ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8vk48k1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 11:48:02 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EBMU1b011026;
	Wed, 14 Feb 2024 11:48:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8vk48k10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 11:48:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EB7h8m010060;
	Wed, 14 Feb 2024 11:47:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npkw9by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 11:47:59 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EBluLJ16384724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 11:47:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D06958054;
	Wed, 14 Feb 2024 11:47:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 332FB5805C;
	Wed, 14 Feb 2024 11:47:49 +0000 (GMT)
Received: from [9.109.198.187] (unknown [9.109.198.187])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 11:47:48 +0000 (GMT)
Message-ID: <d34ef016-88d2-4ae9-9a7b-f7431429acc7@linux.ibm.com>
Date: Wed, 14 Feb 2024 17:17:47 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] block: Add fops atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de, jack@suse.cz,
        jbongio@google.com, jejb@linux.ibm.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        sagi@grimberg.me, tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-11-john.g.garry@oracle.com>
 <20240213093619.106770-1-nilay@linux.ibm.com>
 <9ffc3102-2936-4f83-b69d-bbf64793b9ca@oracle.com>
 <e99cf4ef-40ec-4e66-956f-c9e2aebb4621@linux.ibm.com>
 <30909525-73e4-42cb-a695-672b8e5a6235@oracle.com>
 <c130133f-7c4c-4875-a850-1a8ac9ad4845@linux.ibm.com>
 <445a05e7-f912-4fb8-b66e-204a05a1524f@oracle.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <445a05e7-f912-4fb8-b66e-204a05a1524f@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u5CeVbzKi9CLDto2Dg4aM4LeEF2I1AVP
X-Proofpoint-ORIG-GUID: oaVLQ4nXIlQnXwUlwvkPIXDU3F47q6iq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140092



On 2/14/24 16:59, John Garry wrote:
> On 14/02/2024 09:38, Nilay Shroff wrote:
>>
>>
>> On 2/13/24 17:22, John Garry wrote:
>>> On 13/02/2024 11:08, Nilay Shroff wrote:
>>>>> It's relied that atomic_write_unit_max is <= atomic_write_boundary and both are a power-of-2. Please see the NVMe patch, which this is checked. Indeed, it would not make sense if atomic_write_unit_max > atomic_write_boundary (when non-zero).
>>>>>
>>>>> So if the write is naturally aligned and its size is <= atomic_write_unit_max, then it cannot be straddling a boundary.
>>>> Ok fine but in case the device doesn't support namespace atomic boundary size (i.e. NABSPF is zero) then still do we need
>>>> to restrict IO which crosses the atomic boundary?
>>>
>>> Is there a boundary if NABSPF is zero?
>> If NABSPF is zero then there's no boundary and so we may not need to worry about IO crossing boundary.
>>
>> Even though, the atomic boundary is not defined, this function doesn't allow atomic write crossing atomic_write_unit_max_bytes.
>> For instance, if AWUPF is 63 and an IO starts atomic write from logical block #32 and the number of logical blocks to be written
> 
> When you say "IO", you need to be clearer. Do you mean a write from userspace or a merged atomic write?
Yes I meant write from the userspace. Sorry for the confusion here.
> 
> If userspace issues an atomic write which is 64 blocks at offset 32, then it will be rejected.
> 
> It will be rejected as it is not naturally aligned, e.g. a 64 block writes can only be at offset 0, 64, 128,
So it means that even though h/w may support atomic-write crossing natural alignment boundary, the kernel would still reject it.
> 
>> in this IO equals to #64 then it's not allowed.
>>  However if this same IO starts from logical block #0 then it's allowed.
>> So my point here's that can this restriction be avoided when atomic boundary is zero (or not defined)?
> 
> We want a consistent set of rules for userspace to follow, whether the atomic boundary is zero or non-zero.
> 
> Currently the atomic boundary only comes into play for merging writes, i.e. we cannot merge a write in which the resultant IO straddles a boundary.
> 
>>
>> Also, it seems that the restriction implemented for atomic write to succeed are very strict. For example, atomic-write can't
>> succeed if an IO starts from logical block #8 and the number of logical blocks to be written in this IO equals to #16.
>> In this particular case, IO is well within atomic-boundary (if it's defined) and atomic-size-limit, so why do we NOT want to
>> allow it? Is it intentional? I think, the spec doesn't mention about such limitation.
> 
> According to the NVMe spec, this is ok. However we don't want the user to have to deal with things like NVMe boundaries. Indeed, for FSes, we do not have a direct linear map from FS blocks to physical blocks, so it would be impossible for the user to know about a boundary condition in this context.
> 
> We are trying to formulate rules which work for the somewhat orthogonal HW features of both SCSI and NVMe for both block devices and FSes, while also dealing with alignment concerns of extent-based FSes, like XFS.
Hmm OK, thanks for that explanation. 

Thanks,
--Nilay

