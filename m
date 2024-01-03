Return-Path: <linux-fsdevel+bounces-7153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1EA82274E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 03:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75885B226D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 02:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C93C4A16;
	Wed,  3 Jan 2024 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SWPbE308"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C0171CA;
	Wed,  3 Jan 2024 02:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4031rH8u024488;
	Wed, 3 Jan 2024 02:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=78wPF0LpF+mCsihLbL7RxjqIwFhHSG0CJebLE27EJ7A=; b=SW
	PbE308oFm1Ak4hQC8cEqwf2AhPJ80ppP7abzkSVekcxti4PSosah7eey0EEu/PEy
	yfWQJzsm/7tRl39xuUt4fsdh/Wo3x/exEZEI6U+qWAtMfKd1BD1KeE6yjnWwNnLe
	yPjSJ92bZB6O6pU8keh332ZEuT09Sr96A/C2Gz0CJZFMh1nI8zVSVohhJV/tbTaZ
	4w0z5lwARisQ6isgho6xp9iGMbvO5u7aIJzjVaAuIekuop+B40GH3ZC9Qt8ZZ4RV
	ycrZcfXDbUKRH4MovRH6BfvOCwlSp6J889HDfshPaWcs2NisHTLKdiqTTzELHjos
	lmvfu/e6DlH7vJdim0GA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcgku9t91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 02:58:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4032wj23031959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 02:58:45 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Jan
 2024 18:58:35 -0800
Message-ID: <99c44790-5f1b-4535-9858-c5e9c752159c@quicinc.com>
Date: Wed, 3 Jan 2024 10:58:33 +0800
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
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <ZZPT8hMiuT1pCBP7@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6nIpjVYtECWvlGZA32t55-3fW4z4m_OS
X-Proofpoint-ORIG-GUID: 6nIpjVYtECWvlGZA32t55-3fW4z4m_OS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1011 phishscore=0 mlxlogscore=645
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030023



On 1/2/2024 5:14 PM, Matthew Wilcox wrote:
> On Tue, Jan 02, 2024 at 10:19:47AM +0800, Aiqun Yu (Maria) wrote:
>> On 12/29/2023 6:20 AM, Matthew Wilcox wrote:
>>> On Wed, Dec 13, 2023 at 12:27:05PM -0600, Eric W. Biederman wrote:
>>>> Matthew Wilcox <willy@infradead.org> writes:
>>>>> I think the right way to fix this is to pass a boolean flag to
>>>>> queued_write_lock_slowpath() to let it know whether it can re-enable
>>>>> interrupts while checking whether _QW_WAITING is set.
>>>>
>>>> Yes.  It seems to make sense to distinguish between write_lock_irq and
>>>> write_lock_irqsave and fix this for all of write_lock_irq.
>>>
>>> I wasn't planning on doing anything here, but Hillf kind of pushed me into
>>> it.  I think it needs to be something like this.  Compile tested only.
>>> If it ends up getting used,
>> Happy new year!
> 
> Thank you!  I know your new year is a few weeks away still ;-)
Yeah, Chinese new year will come about 5 weeks later. :)
> 
>>> -void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
>>> +void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock, bool irq)
>>>    {
>>>    	int cnts;
>>> @@ -82,7 +83,11 @@ void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
>> Also a new state showed up after the current design:
>> 1. locked flag with _QW_WAITING, while irq enabled.
>> 2. And this state will be only in interrupt context.
>> 3. lock->wait_lock is hold by the write waiter.
>> So per my understanding, a different behavior also needed to be done in
>> queued_write_lock_slowpath:
>>    when (unlikely(in_interrupt())) , get the lock directly.
> 
> I don't think so.  Remember that write_lock_irq() can only be called in
> process context, and when interrupts are enabled.
In current kernel drivers, I can see same lock called with 
write_lock_irq and write_lock_irqsave in different drivers.

And this is the scenario I am talking about:
1. cpu0 have task run and called write_lock_irq.(Not in interrupt context)
2. cpu0 hold the lock->wait_lock and re-enabled the interrupt.
* this is the new state with _QW_WAITING set, lock->wait_lock locked, 
interrupt enabled. *
3. cpu0 in-interrupt context and want to do write_lock_irqsave.
4. cpu0 tried to acquire lock->wait_lock again.

I was thinking to support both write_lock_irq and write_lock_irqsave 
with interrupt enabled together in queued_write_lock_slowpath.

That's why I am suggesting in write_lock_irqsave when (in_interrupt()), 
instead spin for the lock->wait_lock, spin to get the lock->cnts directly.
> 
>> So needed to be done in release path. This is to address Hillf's concern on
>> possibility of deadlock.
> 
> Hillf's concern is invalid.
> 
>>>    	/* When no more readers or writers, set the locked flag */
>>>    	do {
>>> +		if (irq)
>>> +			local_irq_enable();
>> I think write_lock_irqsave also needs to be take account. So
>> loal_irq_save(flags) should be take into account here.
> 
> If we did want to support the same kind of spinning with interrupts
> enabled for write_lock_irqsave(), we'd want to pass the flags in
> and do local_irq_restore(), but I don't know how we'd support
> write_lock_irq() if we did that -- can we rely on passing in 0 for flags
> meaning "reenable" on all architectures?  And ~0 meaning "don't
> reenable" on all architectures?
What about for all write_lock_irq, pass the real flags from 
local_irq_save(flags) into the queued_write_lock_slowpath?
Arch specific valid flags won't be !0 limited then.
> 
> That all seems complicated, so I didn't do that.
This is complicated. Also need test verify to ensure.
More careful design more better.

Fixed previous wrong email address. ^-^!
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

