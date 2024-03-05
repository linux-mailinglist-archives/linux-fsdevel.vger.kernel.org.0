Return-Path: <linux-fsdevel+bounces-13618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CFA8720F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEFC282D0C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A525286126;
	Tue,  5 Mar 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NFMWNp06"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081EC5102B
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647065; cv=none; b=MjQhwpIHrGjXXr0yEeGTHXUXYWVBmkNce42iVVkuCHb/eG6tVd9ryzC0d/v20QOpFGf76EhnDx1QinSTWIvZZKJowtTjPdrDKV4NO6yJzRlI/7//HkynSmygGBxmLr7mz0HFiJHaG8cG2lQ15aA18mX3O4LCcN1y+Zmvb+YxAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647065; c=relaxed/simple;
	bh=2RbMP+kupMnEQeb/2D/p9ijn8lFZ23tlJ7+AWyRE65U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNloUscemE6kYFcEtFMn1BTh9yDE1ipck4Q7omJB707pd5M+Q2wVNmEiltxtYs2yCSHqpDq6kfBIYBrJ6u7v/OZMzILmqq26y8+MFm0+1/GmQwFV+ub/4srgY5MBJ7ZgHXAJ9NATVGT8TFnqba6gaDBCZqYep8Jichd2QwHLDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NFMWNp06; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425DtWfW025058;
	Tue, 5 Mar 2024 13:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8UCsdp/xIG2bzoqycvVBXhtlOY/m+1bIUbmtQu/HsdQ=;
 b=NFMWNp060b2Nev7vip+E7hd60hqsHrHGLVKnKhv/MVdcZFBIXlpEn2lDOC5qa7qgKNou
 sHchpYGKHBjXXvV/HDkmQPEgZ1KMiiiXGharZqfbGhIwAsPEnk6g/jBt7ZILDyBokb1o
 82KL/O1zETdgsxWQrkIdMvz13xhOkAXy1s1PYBlDct2vXvGCor+yR62lc3lX032p8krp
 G8kqjsYS2BAcwGxXG5EaW2WkbemLDVc5jdj11vC6OhfV6qlSslfzRr/UFje1+8Eek0fX
 zcb3DvHAAEKq4jHXgAi3L6XzBBqFEsq9j1LN/SZQsIN50PRTotqiJ4plIDt/TNxNBXKw FA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp4pwr1w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 13:57:39 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 425DupuV027667;
	Tue, 5 Mar 2024 13:57:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp4pwr1v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 13:57:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 425C8Qih010907;
	Tue, 5 Mar 2024 13:57:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh527edq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 13:57:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 425DvYGk43385180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Mar 2024 13:57:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 812E52004B;
	Tue,  5 Mar 2024 13:57:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60CFD20040;
	Tue,  5 Mar 2024 13:57:34 +0000 (GMT)
Received: from [9.152.212.129] (unknown [9.152.212.129])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Mar 2024 13:57:34 +0000 (GMT)
Message-ID: <1423c8eb-4646-4998-8e6a-43f9f8dd8be5@linux.ibm.com>
Date: Tue, 5 Mar 2024 14:57:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fanotify: move path permission and security check
To: Amir Goldstein <amir73il@gmail.com>
Cc: jack@suse.cz, repnop@google.com, linux-fsdevel@vger.kernel.org
References: <20240229174145.3405638-1-meted@linux.ibm.com>
 <CAOQ4uxh+Od_+ZuLDorbFw6nOnsuabOreH4OE=uP_JE53f0rotA@mail.gmail.com>
 <fc1ac345-6ec5-49dc-81db-c46aa62c8ae1@linux.ibm.com>
 <CAOQ4uxje7JGvSrrsBC=wLugjqtGMfADMqUBKPhcOULErZQjmGA@mail.gmail.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <CAOQ4uxje7JGvSrrsBC=wLugjqtGMfADMqUBKPhcOULErZQjmGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OoODgvppekIXl0akwq4ZgXgcXtCE1Vbd
X-Proofpoint-GUID: rQLnBc9uPAyyoFF6Uk_eK3XNsNzysIsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_11,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050113

On 3/2/24 10:58, Amir Goldstein wrote:
> On Fri, Mar 1, 2024 at 3:16 PM Mete Durlu <meted@linux.ibm.com> wrote:
>>
>> On 3/1/24 10:52, Amir Goldstein wrote:
>>> On Thu, Feb 29, 2024 at 7:53 PM Mete Durlu <meted@linux.ibm.com> wrote:
>>>>
>>>> In current state do_fanotify_mark() does path permission and security
>>>> checking before doing the event configuration checks. In the case
>>>> where user configures mount and sb marks with kernel internal pseudo
>>>> fs, security_path_notify() yields an EACESS and causes an earlier
>>>> exit. Instead, this particular case should have been handled by
>>>> fanotify_events_supported() and exited with an EINVAL.
>>>
>>> What makes you say that this is the expected outcome?
>>> I'd say that the expected outcome is undefined and we have no reason
>>> to commit to either  EACCESS or EINVAL outcome.
>>
>> TLDR; I saw the failing ltp test(fanotify14) started investigating, read
>> the comments on the related commits and noticed that the fanotify
>> documentation does not mention any EACESS as an errno. For these reasons
>> I made an attempt to provide a fix. The placement of the checks aim
>> minimal change, I just tried not to alter the logic more than needed.
>> Thanks for the feedback, will apply suggestions.
>>
> 
> Generally speaking, the reasons above themselves are good enough
> reasons for fixing the documentation and fixing the test code, but not
> enough reasons to change the code.
> 
> There may be other good reasons for changing the code, but I am not
> sure they apply here.
>

I understand the concerns and the reasoning. My findings and suggestions
are below.

>>
>> The main reason is the following commit;
>> * linux: 69562eb0bd3e ("fanotify: disallow mount/sb marks on kernel
>> internal pseudo fs")
>>
>> fanotify_user: fanotify_events_supported()
>>       /*
>>        * mount and sb marks are not allowed on kernel internal pseudo
>>            * fs, like pipe_mnt, because that would subscribe to events on
>>            * all the anonynous pipes in the system.
>>        */
>>       if (mark_type != FAN_MARK_INODE &&
>>           path->mnt->mnt_sb->s_flags & SB_NOUSER)
>>           return -EINVAL;
>>
>> It looks to me as, when configuring fanotify_mark with pipes and
>> FAN_MARK_MOUNT or FAN_MARK_FILESYSTEM, the path above should be taken
>> instead of an early return with EACCES.
>>
> 
> It is a subjective opinion. I do not agree with it, but it does not matter if
> I agree with this statement or not, what matters it that there is no clear
> definition across system calls of what SHOULD happen in this case
> and IMO there is no reason for us to commit to this behavior or the other.
> 
>> Also the following commit on linux test project(ltp) expects EINVAL as
>> expected errno.
>>
>> * ltp: 8e897008c ("fanotify14: Test disallow sb/mount mark on anonymous
>> pipe")
>>
>> To be honest, the test added on above commit is the main reason why I
>> started investigating this.
>>
> 
> This is something that I don't understand.
> If you are running LTP in a setup that rejects fanotify_mark() due to
> security policy, how do the rest of the fanotify tests pass?
> I feel like I am missing information about the test regression report.
> I never test with a security policy applied so I have no idea what
> might be expected.
> 
Ah, I always run with defconfig which has SELINUX enabled and by default
SELINUX is configured to `enforcing` (so far I tested with x86 and s390x
but a quick grep shows most other architectures also have it enabled on
their defconfigs). With SELINUX enabled LTP's fanotify14 shows failures
on

fanotify14.c:284: TINFO: Testing FAN_MARK_MOUNT with anonymous pipe
fanotify14.c:284: TINFO: Testing FAN_MARK_FILESYSTEM with anonymous pipe

since they return -EACCES instead of -EINVAL.Other test cases pass.
Once I disable SELINUX, ALL test cases pass.

>>>
>>> If we do accept your argument that security_path_notify() should be
>>> after fanotify_events_supported(). Why not also after fanotify_test_fsid()
>>> and fanotify_test_fid()?
>>
>> I tried to place the checks as close as possible to their original
>> position, that is why I placed them right after
>> fanotify_events_supported(). I wanted to keep the ordering as close as
>> possible to original to not break any other check. I am open to
>> suggestions regarding this.
>>
> 
> It is a matter of principle IMO.
> If you argue that access permission errors have priority over validity
> of API arguments, then  fanotify_test_{fsid,fid}() are not that much
> different (priority-wise) from fanotify_events_supported().
> 
> My preference is to not change the code, but maybe Jan will
> have a different opinion.

I understand the argument, then I propose patching the LTP and appending
the documentation. My first idea is to send a patch for LTP so that,
fanotify14 could check if SELINUX is enforcing and change the testcases
expected errno accordingly. How does that sound?

Thank you.
-Mete Durlu

