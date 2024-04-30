Return-Path: <linux-fsdevel+bounces-18315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0738B7499
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 13:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B512CB20471
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 11:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E012D779;
	Tue, 30 Apr 2024 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p5MeRN+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFD12C47A;
	Tue, 30 Apr 2024 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476956; cv=none; b=jS+Ub4NMszyWxGY8+1Nw76dO1JEIXA9KrJpOVcx7QUNSLOdpUwTLvfAuZ+itFIsq1TTvZjuyKTOCBCwGKXppT2Bab9HQChCknJKgqmDTm4ubThKup/OmaoY7kj7B3iRcLSwHPPHrnnwJ1cAiQaCtlasjUKlFvXUPSnFAQrYQgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476956; c=relaxed/simple;
	bh=g+cBr5orEjmAzQPCYbsMIuUiqJOlAHEMvwGH1h//IOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbolQhZT3aKxqfOc3rRb47o+Ecc14rFQcH30th8SaSUW0IVIlUu0dwr6TYhmhEt2OvF8iGfgt3HfzSFfuikYS0o5G8Lizj9WZlr10fCmA5VvXCrQzsRIVWggUvtEbgcRnVgTRSrDiDd+vJuoJxAHCeOFW3ME9bIia3Ub8Wx12As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p5MeRN+6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UBRLmn014950;
	Tue, 30 Apr 2024 11:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Rz9uygTbqVG62LQ7p2+/PWf+aNdpv9MlmOBId+rAPVU=;
 b=p5MeRN+6BvR5gu5pdMowbZIbZUXkxcEk9rpIE2pbvx0/fWIpcpb7XIShwJ4k/k9GXKvk
 0qne6Haivv7viZ0LolsY5bRYaFMXaly2pTRHR4Y68juVp5ZVXprTb6S265IVd5NVfcDi
 OE6Gw1RHoQN7Acm4dvMOqGfSzLCkEt4oOoV82OgPC5ndZ5Rm6m3umKArELou45t+gs+c
 EDcYRSN2wT0yKSXKOMv89BpQEyqGSkh864ntzzOm1c3CDeQF1DPRAA9mN6jQvPfS/u4k
 NShcMFi7dT3sCIL7qdjqEd5sqU3t93j3MTYnbJ6KyESOc1GTPv6LlP1Xe7ZbcsaYfJZM Bw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtysgg0pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 11:35:25 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43UB79BO015592;
	Tue, 30 Apr 2024 11:35:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsed2vbtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 11:35:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43UBZLbl15336182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 11:35:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E18458059;
	Tue, 30 Apr 2024 11:35:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C33058055;
	Tue, 30 Apr 2024 11:35:18 +0000 (GMT)
Received: from [9.152.212.230] (unknown [9.152.212.230])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Apr 2024 11:35:18 +0000 (GMT)
Message-ID: <84024ec7-4689-4f68-85ce-bee9fc7b1c5c@linux.ibm.com>
Date: Tue, 30 Apr 2024 13:35:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs.all 15/26] s390/dasd: use bdev api in dasd_format()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-s390@vger.kernel.org, jack@suse.cz, hch@lst.de, brauner@kernel.org,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
        yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-16-yukuai1@huaweicloud.com>
 <20240416013555.GZ2118490@ZenIV>
 <Zh47IY7M1LQXjckX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ca513589-2110-45fe-95b7-5ce23487ea10@linux.ibm.com>
 <20240428185823.GW2118490@ZenIV> <20240428232349.GY2118490@ZenIV>
 <dc4325fb-d723-4d9f-adb7-7ee65a195231@linux.ibm.com>
 <20240430003036.GD2118490@ZenIV>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20240430003036.GD2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -ZYTew2xQeNqA-vYR2MxqK4HBtCiky7r
X-Proofpoint-ORIG-GUID: -ZYTew2xQeNqA-vYR2MxqK4HBtCiky7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=565 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404300083

Am 30.04.24 um 02:30 schrieb Al Viro:
> On Mon, Apr 29, 2024 at 04:41:19PM +0200, Stefan Haberland wrote:
>
>> The dasdfmt tool checks if the disk is actually in use and refuses to
>> work on an 'in use' DASD.
>> So for example a partition that was in use has to be unmounted first.
> Hmm...  How is that check done?  Does it open device exclusive?
>

No, it just checks the open_count gathered from the driver through 
another ioctl.

And yes, of course there is a race in this check that between gathering 
the data
and disabling the device it could be opened.


