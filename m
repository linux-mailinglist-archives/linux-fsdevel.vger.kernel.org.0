Return-Path: <linux-fsdevel+bounces-11353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CB852ECE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 12:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361C8B22A00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4D364C5;
	Tue, 13 Feb 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BG9E8ZDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469612C69A;
	Tue, 13 Feb 2024 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822555; cv=none; b=Jo99At/ZHF47pTbi7vonm1c513bolscBEYH3li0vERJ6Qx4q59QHgarsILvxrM7YONn8msMyvyEoeHYjfzOsCTQJJQmxL9m3W1exGEVClo406dYtRuYmFii56pwn1a1qCEvWS4yqmGlU4/UnzQJwViLMD710woOnlXIvGmV0azQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822555; c=relaxed/simple;
	bh=BxkpbCWHI5A/EVO4cHovB3iWEf/1RW3L/ybUBeIgCjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fy8nCbhHtocSstHuiCF2Fur8/gW8SgAHOxCdGIwnZ/aBkMWvYSNFXc7ij/lpBPntZHnBzO0I+W6WZEQehc0Ec06G6rH/EW9gwPeKCZ+oDaVFPPxKKIB3jkBu37yOeRuoVJzI55TweVS8luC5YgAvrQijKTkDX+bZ5yotT9hKlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BG9E8ZDA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DB6NSF008529;
	Tue, 13 Feb 2024 11:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=y6gcA0FwwLcQ+USrtr82gM+J0plPqQJrcFFJlFssEvQ=;
 b=BG9E8ZDACdcTX9tYoHQKTk06X9gRTLYsD3U+Q3JMytOmcf8MGvxAqEJeMt22/cCm60xe
 Te02bOTOLk8DvLdvtDuIDofoMjRovuyozvc3L6yHM00ptHBOpOGVx2QawAsst5/0pxuh
 vkmhGEDCzB5VLy9wsNR/lQ6srBqfYkXrs27yu5jmpJG5vHDgW7Lc/O4d6ahINuI0joOz
 eE3nOAsUfXIac88qF82J29MbM0hgrRWZ9InuuQZpHXpgCPUC2q55xLIZ/c4xIZIgriV8
 anMhj1xBPR4costNDfUrIXsvZNY2JEp/SoeVFnlazf7ZGS24nhE7fKo8XJPvXfH4gONL 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86s0gp6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:08:45 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DB8iMC020351;
	Tue, 13 Feb 2024 11:08:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86s0gp5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:08:44 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41DB6tfs024888;
	Tue, 13 Feb 2024 11:08:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp6wr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:08:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DB8d4A13500960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 11:08:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ADF9582C0;
	Tue, 13 Feb 2024 11:08:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77120582B1;
	Tue, 13 Feb 2024 11:08:32 +0000 (GMT)
Received: from [9.109.198.187] (unknown [9.109.198.187])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 11:08:32 +0000 (GMT)
Message-ID: <e99cf4ef-40ec-4e66-956f-c9e2aebb4621@linux.ibm.com>
Date: Tue, 13 Feb 2024 16:38:31 +0530
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
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <9ffc3102-2936-4f83-b69d-bbf64793b9ca@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wgYyCpTyGo1nKNUZEvPPGbkeV49XjQVm
X-Proofpoint-GUID: x8JhR4pjGebwkn0QUFWqvWDNH0parMX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130087



On 2/13/24 15:28, John Garry wrote:
> On 13/02/2024 09:36, Nilay Shroff wrote:
>>> +static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
>>
>>> +                      struct iov_iter *iter)
>>
>>> +{
>>
>>> +    struct request_queue *q = bdev_get_queue(bdev);
>>
>>> +    unsigned int min_bytes = queue_atomic_write_unit_min_bytes(q);
>>
>>> +    unsigned int max_bytes = queue_atomic_write_unit_max_bytes(q);
>>
>>> +
>>
>>> +    if (!iter_is_ubuf(iter))
>>
>>> +        return false;
>>
>>> +    if (iov_iter_count(iter) & (min_bytes - 1))
>>
>>> +        return false;
>>
>>> +    if (!is_power_of_2(iov_iter_count(iter)))
>>
>>> +        return false;
>>
>>> +    if (pos & (iov_iter_count(iter) - 1))
>>
>>> +        return false;
>>
>>> +    if (iov_iter_count(iter) > max_bytes)
>>
>>> +        return false;
>>
>>> +    return true;
>>
>>> +}
>>
>>
>>
>> Here do we need to also validate whether the IO doesn't straddle
>>
>> the atmic bondary limit (if it's non-zero)? We do check that IO
>>
>> doesn't straddle the atomic boundary limit but that happens very
>>
>> late in the IO code path either during blk-merge or in NVMe driver
>>
>> code.
> 
> It's relied that atomic_write_unit_max is <= atomic_write_boundary and both are a power-of-2. Please see the NVMe patch, which this is checked. Indeed, it would not make sense if atomic_write_unit_max > atomic_write_boundary (when non-zero).
> 
> So if the write is naturally aligned and its size is <= atomic_write_unit_max, then it cannot be straddling a boundary.

Ok fine but in case the device doesn't support namespace atomic boundary size (i.e. NABSPF is zero) then still do we need 
to restrict IO which crosses the atomic boundary? 

I am quoting this from NVMe spec (Command Set Specification, revision 1.0a, Section 2.1.4.3) : 
"To ensure backwards compatibility, the values reported for AWUN, AWUPF, and ACWU shall be set such that 
they  are  supported  even  if  a  write  crosses  an  atomic  boundary.  If  a  controller  does  not  
guarantee atomicity across atomic boundaries, the controller shall set AWUN, AWUPF, and ACWU to 0h (1 LBA)." 

Thanks,
--Nilay


  


