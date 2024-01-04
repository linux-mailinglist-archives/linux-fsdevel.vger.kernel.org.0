Return-Path: <linux-fsdevel+bounces-7324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37408239CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 01:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A7F2881D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 00:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED38139B;
	Thu,  4 Jan 2024 00:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kmokchby"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03947184F;
	Thu,  4 Jan 2024 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403NxDD4010114;
	Thu, 4 Jan 2024 00:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1u0u+cekK6SHjywKHnBLUlogJbeRDzmxVO7K7k6K7N4=; b=km
	okchbyqfOBzDREYspDvaZ3JlCItQPzkFSoeNdtlnUuT/a9T/n6gnvV2HuKhQoSDK
	V4aBkI3ODTJXVFR+ijSwsMwoMk+PFw16fHDAYCLF4K/EyCJe7oN81A+F64zZwWix
	U9yVZYRMI4Y/B810WRiNQ2f18WqNVwt63yB7658cgpc/t5lMvFVYsxBViUvbcIjC
	UvzXci4c0UJtyWMYXbqyPkHeN5Xuj0yzKZWn3hChqVzf7BakTKcC6+YEHrZlVG/4
	Y73ix0pEIOX2BX/X4mPjW4zFQStH1UDPF6QuF9NmuV5Jib5dE4MffklNko/npKAj
	ywb4iC/KdrEyk2TmOsVw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd3mb24nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 00:46:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4040kf2d016654
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 00:46:41 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 16:46:33 -0800
Message-ID: <02e09c99-3431-4ba1-86bb-c4c68ebdc6b0@quicinc.com>
Date: Thu, 4 Jan 2024 08:46:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Hillf Danton
	<hdanton@sina.com>, <kernel@quicinc.com>,
        <quic_pkondeti@quicinc.com>, <keescook@chromium.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <oleg@redhat.com>,
        <dhowells@redhat.com>, <jarkko@kernel.org>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
 <ZXnaNSrtaWbS2ivU@casper.infradead.org>
 <87o7eu7ybq.fsf@email.froward.int.ebiederm.org>
 <ZY30k7OCtxrdR9oP@casper.infradead.org>
 <cd0f6613-9aa9-4698-bebe-0f61286d7552@quicinc.com>
 <ZZPT8hMiuT1pCBP7@casper.infradead.org>
 <99c44790-5f1b-4535-9858-c5e9c752159c@quicinc.com>
 <ZZWk368hZpOc25X0@casper.infradead.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <ZZWk368hZpOc25X0@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mpBZUrhu1N_Po1rEL0id7yrHQrooFGeq
X-Proofpoint-ORIG-GUID: mpBZUrhu1N_Po1rEL0id7yrHQrooFGeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=707 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040002



On 1/4/2024 2:18 AM, Matthew Wilcox wrote:
> On Wed, Jan 03, 2024 at 10:58:33AM +0800, Aiqun Yu (Maria) wrote:
>> On 1/2/2024 5:14 PM, Matthew Wilcox wrote:
>>>>> -void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
>>>>> +void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock, bool irq)
>>>>>     {
>>>>>     	int cnts;
>>>>> @@ -82,7 +83,11 @@ void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
>>>> Also a new state showed up after the current design:
>>>> 1. locked flag with _QW_WAITING, while irq enabled.
>>>> 2. And this state will be only in interrupt context.
>>>> 3. lock->wait_lock is hold by the write waiter.
>>>> So per my understanding, a different behavior also needed to be done in
>>>> queued_write_lock_slowpath:
>>>>     when (unlikely(in_interrupt())) , get the lock directly.
>>>
>>> I don't think so.  Remember that write_lock_irq() can only be called in
>>> process context, and when interrupts are enabled.
>> In current kernel drivers, I can see same lock called with write_lock_irq
>> and write_lock_irqsave in different drivers.
>>
>> And this is the scenario I am talking about:
>> 1. cpu0 have task run and called write_lock_irq.(Not in interrupt context)
>> 2. cpu0 hold the lock->wait_lock and re-enabled the interrupt.
> 
> Oh, I missed that it was holding the wait_lock.  Yes, we also need to
> release the wait_lock before spinning with interrupts disabled.
> 
>> I was thinking to support both write_lock_irq and write_lock_irqsave with
>> interrupt enabled together in queued_write_lock_slowpath.
>>
>> That's why I am suggesting in write_lock_irqsave when (in_interrupt()),
>> instead spin for the lock->wait_lock, spin to get the lock->cnts directly.
> 
> Mmm, but the interrupt could come in on a different CPU and that would
> lead to it stealing the wait_lock from the CPU which is merely waiting
> for the readers to go away.
That's right.
The fairness(or queue mechanism) wouldn't be ensured (only in interrupt 
context) if we have the special design when (in_interrupt()) spin to get 
the lock->cnts directly. When in interrupt context, the later 
write_lock_irqsave may get the lock earlier than the write_lock_irq() 
which is not in interrupt context.

This is a side effect of the design, while similar unfairness design in 
read lock as well. I think it is reasonable to have in_interrupt() 
waiters get lock earlier from the whole system's performance of view.
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

