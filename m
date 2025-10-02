Return-Path: <linux-fsdevel+bounces-63299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30A4BB45B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 17:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EB519E3E67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0CB228C99;
	Thu,  2 Oct 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZdKRmhI0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345EA2264B2;
	Thu,  2 Oct 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419057; cv=none; b=CsE5Z37ct3dWfsZlbZhryRFN0NMDbhX7ZQ3YDOSMvZIaISa6C6+k5Sqv1UOo5IEUC6MPyLaE6CUsRI0aiNZCMUwE0OT5CrMgEzG5Wg07ArmRVaRgIoquOJdEOwAVq1UMi2wgB4DuSw7HjXua9af9P+aRqw/7nvc6dZggzJRERvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419057; c=relaxed/simple;
	bh=nSOZHkedgoi+vn8yqycPcjnC2rTm/1Y7IRlM0OjwTg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lz8UUNx3tc6jvZ3GImzR7tPNFixzfsMxvE1gU8dsDEjOrdnosavdMNDwpjMp0lH774qj3w8jTZjMxXAIQEVrXNpUJn3hkYkl4gy8qgUzI55XKfs53nsJf3iCGPcQPk68aWRncIr+CALPbQA87FB1LdEy8BHmxiYePG7d2vlR+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZdKRmhI0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592C72Ej007741;
	Thu, 2 Oct 2025 15:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=68awHT
	wvfNWSifEoUYe+z7wdZ54JP/tr2nfG3khpqVQ=; b=ZdKRmhI0BddXUnQ/7Zo/uN
	yHxFEDMmfxwOz5/MUlFQLVaRUKdFlnUxBtJI3O+nXGNzAHOSEFQ1jU4rP8EgrFVc
	zrrigUHLpvoQ5FAcOYCjnzVZJpRSlR4Q5xhDTEiAGds3ce4gDWDZaRoZW9sQC4cs
	vfO5GVhmfSZ1mHYheemZ2MNDXSCkjD+woHRRu25U+Fh7akyZEZrKuM3kI2opbiFg
	1ky+hAj/2Q4JShxEn94DtSaERVTjylyPcjD/GjfoJ+QQsoysh5b0Q0x005nnRT6w
	VHpuFPMC2E/VLGMH7t3fFDdHTyNZrT+U+jRQp4wFrkAtHBvCVRXXMkgbkdrZwlZQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n868c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 15:30:45 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 592F6EM5007421;
	Thu, 2 Oct 2025 15:30:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n868bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 15:30:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592D3uTD007331;
	Thu, 2 Oct 2025 15:30:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk6h8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 15:30:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 592FUgBp13894188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 15:30:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01B6958043;
	Thu,  2 Oct 2025 15:30:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD80458059;
	Thu,  2 Oct 2025 15:30:36 +0000 (GMT)
Received: from [9.43.27.61] (unknown [9.43.27.61])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Oct 2025 15:30:36 +0000 (GMT)
Message-ID: <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com>
Date: Thu, 2 Oct 2025 21:00:34 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
To: Kyle Sanderson <kyle.leet@gmail.com>, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, axboe@kernel.dk
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com,
        gjoyce@ibm.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
 <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9dte93drl-1B0LFvztQZJ89iO5zNAYuW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX1gLMbr02FcTW
 sAbm4ymqrLLg5wQYWv7Q16d8yBWW9OtOiT59zCVBjc5HWNl/rC01kDsUEkwyUe6t7ZoNX7eU/cM
 IPbzTt3DMKCqogaljfbWpBuyG0+A+xjRBsHwTbVkCNsBCQ+3CHEAWHjyl7URr3G/BALDu18HIXv
 MF+lG9bZrbMjt8s4uV0im2bLKXoU4/rRo8w58iYJ5Ysettowg1POTRse8CTIV+KI6GXOX8mVj9u
 hUT8HNyry0xoLLlWGY6MfPydtxLYSYlBoZLMHAyFV7rXvAdR988hM/X8soJAZM57ofCw9KPXSio
 l2w5031G1IOVa4q/CqHsGbyafz+5qUtW4nmaNqiyZ/DXgvu5oiGES+CcoABOi9Evs3HKAxjmjmv
 jOUEc363uvBAbGvCyE4jlRKCWIUf/w==
X-Proofpoint-GUID: 7h9h4MsZI86IyclypeXsxfvMSyco83Z2
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68de9aa5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=SU-AqdwiyQoJ0AQ-xJMA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025



On 10/1/25 6:35 PM, Kyle Sanderson wrote:
> On 9/30/2025 10:20 PM, Kyle Sanderson wrote:
>> On 7/30/2025 12:46 AM, Nilay Shroff wrote:
>>> To address this, move all sched_tags allocations and deallocations outside
>>> of both the ->elevator_lock and the ->freeze_lock.
>>
>> Hi Nilay,
>>
>> I am coming off of a 36 hour travel stint, and 6.16.7 (I do not have that log, and it mightily messed up my xfs root requiring offline repair), 6.16.9, and 6.17.0 simply do not boot on my system. After unlocking with LUKS I get this panic consistently and immediately, and I believe this is the problematic commit which was unfortunately carried to the previous and current stable. I am using this udev rule: `ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", ATTR{queue/ scheduler}="bfq"`
> 
> Hi Greg,
> 
> Slept for a couple hours. This appears to be well known in block (the fix is in the 6.18 pull) that it is causing panics on stable, and didn't make it back to 6.17 past the initial merge window (as well as 6.16).
> 
> Presumably adjusting the request depth isn't common (if this is indeed the problem)?
> 
> I also have ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", ATTR{queue/nr_requests}="1024" as a udev rule.
> 
So the above udev rule suggests that you're updating
nr_requests which do update the queue depth. 

> Jens, is this the only patch from August that is needed to fix this panic?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.18/block&id=ba28afbd9eff2a6370f23ef4e6a036ab0cfda409
> 
Greg, I think we should have the above commit ba28afbd9eff ("blk-mq: fix 
blk_mq_tags double free while nr_requests grown") backported to the 6.16.x
stable kernel, if it hasn't yet queued up. 

Thanks,
--Nilay

