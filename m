Return-Path: <linux-fsdevel+bounces-38091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713789FB96C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 06:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B621E7A1C38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 05:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF914831F;
	Tue, 24 Dec 2024 05:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p1tXSh+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1A4C62;
	Tue, 24 Dec 2024 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735016984; cv=none; b=aNdF8y8v1KILf5+M50ILL4EhhNsj+KymLohGHQ61jnrm9MiHgQdhyc9h1tTezmZ/yaIS4t3/Mj23Yzh8lrEP08LMVlAH+RZTBrwhBaOPtbh6/IRMo461UvrV0WbqJq3Y4zdYpPKwioCMNBsrxQyzUvGmIIj3XTR9do1/jet+pMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735016984; c=relaxed/simple;
	bh=ETKj/RAcn3RvZ9aHj2NGPUkL1zabjL4twbjVbx+zj/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/ZL/2BgWBE15GChzFrZRFx7MqhzHvO3F5mv7XX3s2LP5QYVYX7Sf74xLMNgTlmDSY/EYd2c+30CXkTy21GvMEKu8JnJBthFBRIO8iSFyniLrqMH+tx/zVvVrJw8/zRaYFrXaKUClRSznbjXwZ4Yyp74zUB+yPhpF72iDE2aW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p1tXSh+c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO4ni93009724;
	Tue, 24 Dec 2024 05:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FJKJ15
	UtNlNNa4xpivnI2ygQL4e7UdUf4HgpweJvtrg=; b=p1tXSh+c5udWyiHnFfp5PU
	BCmRVjcwBhuXFFsvPvKWJnwiF37BbP0bY0eAksKNMhSOyGb7B2QeSTgb1MIO2NZd
	LdGKGJ5iEghSU7d0h41xHZLosAsmjV3J223fAUY1DIJPl1U6e47HN/+wcinIJzeW
	q6sXtc+mQQckWeP2g8xPzZ33ZJHOiJqNIPJW1gmbjTCKWTkyDjj0EUUPK6sUTkkL
	Mpghdqt0PnHnDiOICgrqg5X5dBaZ+XFYJcUQTU1uGRqiiIV7eX6NnMBE+cD4euGl
	UzH9IOFDyBbOKLEIZKjEpQytlIAG6I3+oGUgCvlshWOg0NEuea7Bsy/sstFdOSyg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43q9b4jtqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 05:09:34 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BO58MpG014193;
	Tue, 24 Dec 2024 05:09:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43q9b4jtqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 05:09:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO24Cau002154;
	Tue, 24 Dec 2024 05:09:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43pa7jrdgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 05:09:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BO59VlH21954928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 05:09:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA8FE20063;
	Tue, 24 Dec 2024 05:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD49720040;
	Tue, 24 Dec 2024 05:09:30 +0000 (GMT)
Received: from [9.39.24.171] (unknown [9.39.24.171])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Dec 2024 05:09:30 +0000 (GMT)
Message-ID: <20ededbc-d915-4850-80f7-61585fdfd156@linux.ibm.com>
Date: Tue, 24 Dec 2024 10:39:29 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fsx: support reads/writes from buffers backed by
 hugepages
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@meta.com
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
 <20241218210122.3809198-2-joannelkoong@gmail.com>
 <c74087b50970bf953c78c8756e41d25df28637b1.camel@linux.ibm.com>
 <CAJnrk1ad0KPYkLmW3sXimrJ52LL_quoxAYX6WUZ9jKnMTUa8-A@mail.gmail.com>
Content-Language: en-US
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <CAJnrk1ad0KPYkLmW3sXimrJ52LL_quoxAYX6WUZ9jKnMTUa8-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rRbqxuGAbKa9raQsefBstR_M4mqeVwhy
X-Proofpoint-GUID: liv96U2P8ENXZFwEo2tJaJCeLIrnqOn_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240037


On 12/24/24 02:37, Joanne Koong wrote:
> On Thu, Dec 19, 2024 at 11:47 PM Nirjhar Roy <nirjhar@linux.ibm.com> wrote:
>> On Wed, 2024-12-18 at 13:01 -0800, Joanne Koong wrote:
>>> Add support for reads/writes from buffers backed by hugepages.
>>> This can be enabled through the '-h' flag. This flag should only be
>>> used
>>> on systems where THP capabilities are enabled.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>   ltp/fsx.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++---
>>> --
>>>   1 file changed, 92 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/ltp/fsx.c b/ltp/fsx.c
>>> index 41933354..3656fd9f 100644
>>> --- a/ltp/fsx.c
>>> +++ b/ltp/fsx.c
>>> @@ -190,6 +190,7 @@ int       o_direct;                       /* -Z */
>>> +static long
>>> +get_hugepage_size(void)
>>> +{
>>> +     const char *str = "Hugepagesize:";
>>> +     long hugepage_size = -1;
>>> +     char buffer[64];
>>> +     FILE *file;
>>> +
>>> +     file = fopen("/proc/meminfo", "r");
>>> +     if (!file) {
>>> +             prterr("get_hugepage_size: fopen /proc/meminfo");
>>> +             return -1;
>>> +     }
>>> +     while (fgets(buffer, sizeof(buffer), file)) {
>>> +             if (strncmp(buffer, str, strlen(str)) == 0) {
>> Extremely minor: Since str is a fixed string, why not calculate the
>> length outside the loop and not re-use strlen(str) multiple times?
> Thinking about this some more, maybe it'd be best to define it as
> const char str[] = "Hugepagesize:" as an array of chars and use sizeof
> which would be at compile-time instead of runtime.
> I'll do this for v2.
Yes, that is a good idea too. Thanks.
>
>>> +                     sscanf(buffer + strlen(str), "%ld",
>>> &hugepage_size);
>>> +                     break;
>>> +             }
>>> +     }
>>> +     fclose(file);
>>> +     if (hugepage_size == -1) {
>>> +             prterr("get_hugepage_size: failed to find "
>>> +                     "hugepage size in /proc/meminfo\n");
>>> +             return -1;
>>> +     }
>>> +
>>> +     /* convert from KiB to bytes  */
>>> +     return hugepage_size * 1024;
>> Minor: << 10 might be faster instead of '*' ?
> Will do for v2.
Thanks.
>
>>> +}
>>> +
>>> +static void *
>>> +init_hugepages_buf(unsigned len, long hugepage_size)
>>> +{
>>> +     void *buf;
>>> +     long buf_size = roundup(len, hugepage_size);
>>> +
>>> +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
>>> +             prterr("posix_memalign for buf");
>>> +             return NULL;
>>> +     }
>>> +     memset(buf, '\0', len);
>>> +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
>>> +             prterr("madvise collapse for buf");
>>> +             free(buf);
>>> +             return NULL;
>>> +     }
>>> +
>>> +     return buf;
>>> +}
>>> +
>>>   static struct option longopts[] = {
>>>        {"replay-ops", required_argument, 0, 256},
>>>        {"record-ops", optional_argument, 0, 255},
>>> @@ -2883,7 +2935,7 @@ main(int argc, char **argv)
>>>        setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout
>>> */
>>>
>>>        while ((ch = getopt_long(argc, argv,
>>> -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xy
>>> ABD:EFJKHzCILN:OP:RS:UWXZ",
>>> +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:x
>>> yABD:EFJKHzCILN:OP:RS:UWXZ",
>>>                                 longopts, NULL)) != EOF)
>>>                switch (ch) {
>>>                case 'b':
>>> @@ -2916,6 +2968,9 @@ main(int argc, char **argv)
>>>                case 'g':
>>>                        filldata = *optarg;
>>>                        break;
>>> +             case 'h':
>>> +                     hugepages = 1;
>>> +                     break;
>>>                case 'i':
>>>                        integrity = 1;
>>>                        logdev = strdup(optarg);
>>> @@ -3232,12 +3287,41 @@ main(int argc, char **argv)
>>>        original_buf = (char *) malloc(maxfilelen);
>>>        for (i = 0; i < maxfilelen; i++)
>>>                original_buf[i] = random() % 256;
>>> -     good_buf = (char *) malloc(maxfilelen + writebdy);
>>> -     good_buf = round_ptr_up(good_buf, writebdy, 0);
>>> -     memset(good_buf, '\0', maxfilelen);
>>> -     temp_buf = (char *) malloc(maxoplen + readbdy);
>>> -     temp_buf = round_ptr_up(temp_buf, readbdy, 0);
>>> -     memset(temp_buf, '\0', maxoplen);
>>> +     if (hugepages) {
>>> +             long hugepage_size;
>>> +
>>> +             hugepage_size = get_hugepage_size();
>>> +             if (hugepage_size == -1) {
>>> +                     prterr("get_hugepage_size()");
>>> +                     exit(99);
>>> +             }
>>> +
>>> +             if (writebdy != 1 && writebdy != hugepage_size)
>>> +                     prt("ignoring write alignment (since -h is
>>> enabled)");
>>> +
>>> +             if (readbdy != 1 && readbdy != hugepage_size)
>>> +                     prt("ignoring read alignment (since -h is
>>> enabled)");
>>> +
>>> +             good_buf = init_hugepages_buf(maxfilelen,
>>> hugepage_size);
>>> +             if (!good_buf) {
>>> +                     prterr("init_hugepages_buf failed for
>>> good_buf");
>>> +                     exit(100);
>>> +             }
>>> +
>>> +             temp_buf = init_hugepages_buf(maxoplen, hugepage_size);
>>> +             if (!temp_buf) {
>>> +                     prterr("init_hugepages_buf failed for
>>> temp_buf");
>>> +                     exit(101);
>>> +             }
>>> +     } else {
>>> +             good_buf = (char *) malloc(maxfilelen + writebdy);
>>> +             good_buf = round_ptr_up(good_buf, writebdy, 0);
>> Not sure if it would matter but aren't we seeing a small memory leak
>> here since good_buf's original will be lost after rounding up?
> This is inherited from the original code but AFAICT, it relies on the
> memory being cleaned up at exit time (eg free() is never called on
> good_buf and temp_buf either).

Okay, makes sense.

--

NR

>
>
> Thanks,
> Joanne
>
>>> +             memset(good_buf, '\0', maxfilelen);
>>> +
>>> +             temp_buf = (char *) malloc(maxoplen + readbdy);
>>> +             temp_buf = round_ptr_up(temp_buf, readbdy, 0);
>>> +             memset(temp_buf, '\0', maxoplen);
>>> +     }
>>>        if (lite) {     /* zero entire existing file */
>>>                ssize_t written;
>>>
-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


