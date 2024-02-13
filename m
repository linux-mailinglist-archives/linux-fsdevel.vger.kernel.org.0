Return-Path: <linux-fsdevel+bounces-11314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29564852969
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CD228715C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6617558;
	Tue, 13 Feb 2024 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S74kmW2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB31428D;
	Tue, 13 Feb 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807213; cv=none; b=r4rmxSxIm6tb9iNAZXCqBUaT7XorqSdSnq8LA8/hWMCa4w1TFd+0pQmzwyejJpW1B0sMK8v+8//2nH80ZZNLOPr/lIysZ887N1FfNmMuZ4fmnQRqMJ2y/MSqOcUgsIMyC8K53q6+IrEnPZcO4zAd8LpYhVBBV+9RgQRLoOYvKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807213; c=relaxed/simple;
	bh=ITCyrLghQ30aRAorX9qB6Sajy1pj+WJa1/6sGk5iABA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6iYEpackaG53PqGAi+2qAFVoo0hn13dl2NVb1m//AMulKOFxz6k8HaHwWcQ6YoamNkbP4+uRx3YqFMRSupaCPv7xzyjEba1DULgTLTBUbIOSl0qE3gpyJysKLGaX3s5PImMQs9P4e91KTQUhH7hJuRVIycqDuplrVYaBi0th+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S74kmW2d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D6HNoH025985;
	Tue, 13 Feb 2024 06:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4NKSIh+Fr8WTVMUu4ha6UjzCuFYZLVL2fWiORrY97GU=;
 b=S74kmW2d80x+hFC5/TxZKlmfG7tAde7IhH4F71YI8/UuQkebWKd9W11mUixEgpj+hZz5
 rNwjYSo88ST8ocy8BvYsXIdlHNzir5YFMf5Ijoc5WN9qTQHySxNMSaQgaHGg17hMiMBy
 3pSOyxlvTyjFdtVEfWw++ykuJTJk6WBKGO8z2YDjhg8Gm1H2PVCwJbD9XGvNth8AvHoG
 m/WWtf2uTePFI+T8Uoax2DWsf0RmwXHBqhAdc7audRu16xyIHw+IlcrShp2JM9x9qX8t
 P3FH8W23S6CE5Vtr2tdA/112ljGvHXNfzF+/H8wS/bMXfjbC8y9mThYUom0VcULqYbAM ng== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w83160nae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 06:53:01 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41D6k86N003140;
	Tue, 13 Feb 2024 06:53:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w83160n9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 06:53:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41D63fs3010083;
	Tue, 13 Feb 2024 06:53:00 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npkndw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 06:53:00 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41D6quVH22872716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 06:52:58 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEBD458063;
	Tue, 13 Feb 2024 06:52:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EFEA5805D;
	Tue, 13 Feb 2024 06:52:50 +0000 (GMT)
Received: from [9.109.198.187] (unknown [9.109.198.187])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 06:52:49 +0000 (GMT)
Message-ID: <8ce0068d-aaff-46e0-9fec-f09206938106@linux.ibm.com>
Date: Tue, 13 Feb 2024 12:22:48 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] block: Add checks to merging of atomic writes
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
References: <20240124113841.31824-10-john.g.garry@oracle.com>
 <20240212105444.43262-1-nilay@linux.ibm.com>
 <b3ce860d-4a1e-4980-97d9-0e8ad381c689@oracle.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b3ce860d-4a1e-4980-97d9-0e8ad381c689@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NEMKpa3nLFWJoO5v4hM9IsmvrbmlpotD
X-Proofpoint-GUID: PrYV3wPBZoaTkpgDGCYdZ-6A1zflaRBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_03,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130051



On 2/12/24 17:39, John Garry wrote:
> On 12/02/2024 10:54, Nilay Shroff wrote:
>>
>> Shall we ensure here that we don't cross max limit of atomic write supported by
>>
>> device? It seems that if the boundary size is not advertized by the device
>>
>> (in fact, I have one NVMe drive which has boundary size zero i.e. nabo/nabspf/
>>
>> nawupf are all zero but awupf is non-zero) then we (unconditionally) allow
>>
>> merging.
> 
> BTW, if you don't mind, can you share awupf value and device model? I have been on the search for NVMe devices which support atomic writes (with non-zero PF reported value). All I have is a M.2 card which has a 4KB PF atomic write value.
> 
> But if this is private info, then ok.
> 
> Thanks,
> John

Yeah sure. Below are the details about NVMe:

# lspci 
0040:01:00.0 Non-Volatile memory controller: KIOXIA Corporation Device 0025 (rev 01)

# nvme id-ctrl /dev/nvme0 -H 
NVME Identify Controller:
vid       : 0x1e0f
ssvid     : 0x1014
sn        : Z130A00LTGZ8        
mn        : 800GB NVMe Gen4 U.2 SSD                 
fr        : REV.C9S2
[...]
awun      : 65535
awupf     : 63
[...]

# nvme id-ns /dev/nvme0n1 -H 
NVME Identify Namespace 1:
nsze    : 0x18ffff3
ncap    : 0x18ffff3
nuse    : 0
nsfeat  : 0x14
  [4:4] : 0x1	NPWG, NPWA, NPDG, NPDA, and NOWS are Supported
  [3:3] : 0	NGUID and EUI64 fields if non-zero, Reused
  [2:2] : 0x1	Deallocated or Unwritten Logical Block error Supported
  [1:1] : 0	Namespace uses AWUN, AWUPF, and ACWU
  [0:0] : 0	Thin Provisioning Not Supported

[...]

nawun   : 0
nawupf  : 0
nacwu   : 0
nabsn   : 0
nabo    : 0
nabspf  : 0

[...]

LBA Format  0 : Metadata Size: 0   bytes - Data Size: 4096 bytes - Relative Performance: 0 Best (in use)
LBA Format  1 : Metadata Size: 8   bytes - Data Size: 4096 bytes - Relative Performance: 0 Best 
LBA Format  2 : Metadata Size: 0   bytes - Data Size: 512 bytes - Relative Performance: 0 Best 
LBA Format  3 : Metadata Size: 8   bytes - Data Size: 512 bytes - Relative Performance: 0 Best 
LBA Format  4 : Metadata Size: 64  bytes - Data Size: 4096 bytes - Relative Performance: 0 Best 
LBA Format  5 : Metadata Size: 8   bytes - Data Size: 512 bytes - Relative Performance: 0 Best 


As shown above, I am using KIOXIA NVMe. This NVMe has one namespace created(nvme0n1). 
The nsfeat reports that this namespace uses AWUN, AWUPF, and ACWU.The awupf for this NVMe is 63. 
As awupf is 0's based value, it's actually 64. The configured LBA for the namespace (in use) is 4096 
bytes and so that means that this NVMe supports writing 262144 (64*4096) bytes of data atomically 
during power failure. Further, please note that on this NVMe we have nawupf/nabspf/nabo all set
to zero. 

Let me know if you need any other details. And BTW, if you want I could help you with anything 
you'd like to test on this NVMe. 

Thanks,
--Nilay

