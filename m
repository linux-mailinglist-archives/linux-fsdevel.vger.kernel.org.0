Return-Path: <linux-fsdevel+bounces-13176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDDB86C496
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6071F26DA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CCD58104;
	Thu, 29 Feb 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nxhvRwww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60654F88;
	Thu, 29 Feb 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197936; cv=none; b=rURpkmqOF8997QXr6jMye7gH6gpPkUmUEVrPu/89ZYBWYU/yOzoMHA7bukhItbj6qjTxKjfTrbvQ0sMwtAbfj89/EldL56c3kUeGKgTAYxMpG/NFr/3/0YPsWRaHpb6FivibyudPdsr8bhmn9t4m5/TzXvnFZ1aKvfVoA4K6Mh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197936; c=relaxed/simple;
	bh=U3Px1lJgZf8Wxf0bHQWvP3wOddXHoFh0xH9zCwn039M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HOPstSPZIAggbVwEt59OoAz8IZyMODo+IprNd7YpG6d1yNF+yfJM5m0hGn+2b5QtZj8YtQJW7TU27BdWRgbaoQXa4kzUwZsmI4SMdbtRRetbC6NNYXWcHGWqFOgrNWbh9/qtdXI/3qZGWocDWgXPOBeLjf/gzEzsECOyMAJNSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nxhvRwww; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T4l82R015512;
	Thu, 29 Feb 2024 09:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=e6vxTqMVoE/Q+7XEzKgFJBUmLUJTol47fJlTs4K2EZw=; b=nx
	hvRwwwfutOjznayqEiu1dcv5bmaGBCN7X2NxJh+9bb8N75RTCm30ur9Tg2hgMNQz
	8JVl2atbD0LYAsGVZKJLpZo0Fh1EWPztLAuVnFnkM9DrsLh0eKnS1t0EUjEPHnuL
	Teuez5HSV8HttArOFVa3E2P/xm3VMYFLnEmI2RS2g6Z6VR8xUqO3/2O1MIo4INyz
	kBd1nOrXBWta9QlxFmBvqstebdpOSk4TIQ3ukiyMmSQsqngnWr3rfZbE5sdv1Jqe
	Gkkg1v0SfIDQ7XO7VYKq3smu/t4WbizvIjjywnOV1FTzEG2bobMq1KMnS/Sxmlpq
	vhOaDpCsp4xU5w50LGGw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wja0eht36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:12:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41T9Bxtc008274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:11:59 GMT
Received: from [10.239.132.50] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 01:11:52 -0800
Message-ID: <dbcd66cd-4d59-4246-88ab-db32abbd8e00@quicinc.com>
Date: Thu, 29 Feb 2024 17:11:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
CC: <mhiramat@kernel.org>, <mark.rutland@arm.com>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <j.granados@samsung.com>,
        <mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <quic_bjorande@quicinc.com>, <quic_tsoni@quicinc.com>,
        <quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, Ross Zwisler <zwisler@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20240208131814.614691-1-quic_hyiwei@quicinc.com>
 <20240226204757.1a968a10@gandalf.local.home>
From: Huang Yiwei <quic_hyiwei@quicinc.com>
In-Reply-To: <20240226204757.1a968a10@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CXpUofEduj0UnN7KTEGwvuO0FKX5QSQx
X-Proofpoint-ORIG-GUID: CXpUofEduj0UnN7KTEGwvuO0FKX5QSQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402290070



On 2/27/2024 9:47 AM, Steven Rostedt wrote:
> On Thu, 8 Feb 2024 21:18:14 +0800
> Huang Yiwei <quic_hyiwei@quicinc.com> wrote:
> 
>> Currently ftrace only dumps the global trace buffer on an OOPs. For
>> debugging a production usecase, instance trace will be helpful to
>> check specific problems since global trace buffer may be used for
>> other purposes.
>>
>> This patch extend the ftrace_dump_on_oops parameter to dump a specific
>> or multiple trace instances:
>>
>>    - ftrace_dump_on_oops=0: as before -- don't dump
>>    - ftrace_dump_on_oops[=1]: as before -- dump the global trace buffer
>>    on all CPUs
>>    - ftrace_dump_on_oops=2 or =orig_cpu: as before -- dump the global
>>    trace buffer on CPU that triggered the oops
>>    - ftrace_dump_on_oops=<instance_name>: new behavior -- dump the
>>    tracing instance matching <instance_name>
>>    - ftrace_dump_on_oops[=2/orig_cpu],<instance1_name>[=2/orig_cpu],
>>    <instrance2_name>[=2/orig_cpu]: new behavior -- dump the global trace
>>    buffer and multiple instance buffer on all CPUs, or only dump on CPU
>>    that triggered the oops if =2 or =orig_cpu is given
> 
> So we need to add that the syntax is:
> 
>   ftrace_dump_on_oops[=[<0|1|2|orig_cpu>,][<instance_name>[=<1|2|orig_cpu>][,...]]
> 
Yeah, this is much more clear, will update the commit message and kernel 
docs in new patchset.
>>
>> Also, the sysctl node can handle the input accordingly.
>>
>> Cc: Ross Zwisler <zwisler@google.com>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  26 ++-
>>   Documentation/admin-guide/sysctl/kernel.rst   |  30 +++-
>>   include/linux/ftrace.h                        |   4 +-
>>   include/linux/kernel.h                        |   1 +
>>   kernel/sysctl.c                               |   4 +-
>>   kernel/trace/trace.c                          | 156 +++++++++++++-----
>>   kernel/trace/trace_selftest.c                 |   2 +-
>>   7 files changed, 168 insertions(+), 55 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 31b3a25680d0..3d6ea8e80c2f 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1561,12 +1561,28 @@
>>   			The above will cause the "foo" tracing instance to trigger
>>   			a snapshot at the end of boot up.
>>   
>> -	ftrace_dump_on_oops[=orig_cpu]
>> +	ftrace_dump_on_oops[=2(orig_cpu) | =<instance>][,<instance> |
>> +			  ,<instance>=2(orig_cpu)]
>>   			[FTRACE] will dump the trace buffers on oops.
>> -			If no parameter is passed, ftrace will dump
>> -			buffers of all CPUs, but if you pass orig_cpu, it will
>> -			dump only the buffer of the CPU that triggered the
>> -			oops.
>> +			If no parameter is passed, ftrace will dump global
>> +			buffers of all CPUs, if you pass 2 or orig_cpu, it
>> +			will dump only the buffer of the CPU that triggered
>> +			the oops, or the specific instance will be dumped if
>> +			its name is passed. Multiple instance dump is also
>> +			supported, and instances are separated by commas. Each
>> +			instance supports only dump on CPU that triggered the
>> +			oops by passing 2 or orig_cpu to it.
>> +
>> +			ftrace_dump_on_oops=foo=orig_cpu
>> +
>> +			The above will dump only the buffer of "foo" instance
>> +			on CPU that triggered the oops.
>> +
>> +			ftrace_dump_on_oops,foo,bar=orig_cpu
> 
> I believe the above is incorrect. It should be:
> 
> 			ftrace_dump_on_oops=foo,bar=orig_cpu
> 
> And you can add here as well:
> 
>    ftrace_dump_on_oops[=[<0|1|2|orig_cpu>,][<instance_name>[=<1|2|orig_cpu>][,...]]
> 
> 
> Thanks,
> 
> --Steve
> 
The explanation is below, I think it's correct?
  - "ftrace_dump_on_oops," means global buffer on all CPUs
  - "foo," means foo instance on all CPUs
  - "bar=orig_cpu" means bar instance on CPU that triggered the oops.

I'm trying to make the example to cover more possibilities.

Regards,
Huang Yiwei
>> +
>> +			The above will dump global buffer on all CPUs, the
>> +			buffer of "foo" instance on all CPUs and the buffer
>> +			of "bar" instance on CPU that triggered the oops.
>>   
>>   	ftrace_filter=[function-list]

