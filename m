Return-Path: <linux-fsdevel+bounces-8527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FA838BA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF751F26084
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A02E5A790;
	Tue, 23 Jan 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qymh1s+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293C5BADB;
	Tue, 23 Jan 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005467; cv=none; b=QfFIoZF/gFTJTFPbOewfEEV1VOCLF6Qhc3/xKPjcxxJbBsnM14ASHC04nU+MyLuZIP7rQ3v0+0PPUatIsDcwzvWeBSPNQr+mNYcd72xSIPj7jj7YTVAjqMoqMn7st+lcaSM6T1yksHIXzTGJ51dhKNa0Xu6zPv8LWIvvq+XnqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005467; c=relaxed/simple;
	bh=JL6BeJoE4MAlJcppuQ/wuCvD8T8BoLZFIrU5xZIK2PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UEH+4Z+PDyodI0Cm+wmi7spV18/IIkldaU4SNkmF5Fye+feMHqsgavWgyzoKByf1dDiTIqiisso9Xe4fX1nmD+miGTIJTQxo2ifSNw5iYjNr3inPgtG1GzwwLSDPgHm8ReN61eJYBn110CYPrNVWAzRro6kYKBMMXFFonWGrhcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qymh1s+J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N6ca7X018752;
	Tue, 23 Jan 2024 10:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cGEm4MSSsDJwUpA2OLjGOg0um3TNsnUlO7+C97hH8sQ=; b=Qy
	mh1s+Jj+M++1K/SUs6xLgnXhqziFFCMup6gvvHFYn5GhOTJue0zcZYokpjHdOQcj
	Jy7SE6CVhhAHWZ1OFsPvJvYVec+OVD8LiJA/8PUFQwGIvyYvPPXr1nK52sLcglIy
	QhmxxyukOBgOHPdBmrsL1r0p7yEtfU1+nGAYGMaz27dC/MV6/pyOq+QlyxQGzzrJ
	Np1nvyPz7vDlJWV5ZPBqmfJLf4fxDkXT1F29UYl947lEhLqCuBVyIksTJz3TfK6q
	tKoPv2/YpZTyE6ERuuFOCwGdzTohmrF1wejguVTe3XDl4NHW0xWJf6HQuk+TNTfq
	BIQ67khh+5B9v/t4VOJg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vssw9jc9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 10:24:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NAO8Aq022776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 10:24:08 GMT
Received: from [10.239.132.50] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 02:24:01 -0800
Message-ID: <0279a4cb-ced0-447a-a06f-37c38650ed5b@quicinc.com>
Date: Tue, 23 Jan 2024 18:23:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
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
References: <20240119080824.907101-1-quic_hyiwei@quicinc.com>
 <20240119115625.603188d1@gandalf.local.home>
Content-Language: en-US
From: Huang Yiwei <quic_hyiwei@quicinc.com>
In-Reply-To: <20240119115625.603188d1@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T6o3v9mVoqN-Mc6LKdNfCCB5ZrbPxkLE
X-Proofpoint-ORIG-GUID: T6o3v9mVoqN-Mc6LKdNfCCB5ZrbPxkLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230075



On 1/20/2024 12:56 AM, Steven Rostedt wrote:
> On Fri, 19 Jan 2024 16:08:24 +0800
> Huang Yiwei <quic_hyiwei@quicinc.com> wrote:
> 
>> -	ftrace_dump_on_oops[=orig_cpu]
>> +	ftrace_dump_on_oops[=orig_cpu | =<instance>]
> 
> I wonder if we should have it be:
> 
> 	ftrace_dump_on_oops[=orig_cpu | =<instance> | =<instance>:orig_cpu ]
> 
> Then last would be to only print out a specific CPU trace of the given instance.
> 
> And if we really want to be fancy!
> 
> 	ftrace_dump_on_opps[=orig_cpu | =<instance> | =orig_cpu:<instance> ][,<instance> | ,<instance>:orig_cpu]
> 
Yeah, I agree to make the parameter more flexible.

"=orig_cpu:<instance>" means to dump global and another instance?

I'm thinking of the following format:

ftrace_dump_on_opps[=orig_cpu | =<instance>][,<instance> | 
,<instance>=orig_cpu]

Here list some possible situations:

1. Dump global on orig_cpu:
ftrace_dump_on_oops=orig_cpu

2. Dump global and instance1 on all cpu, instance2 on orig_cpu:
ftrace_dump_on_opps,<instance1>,<instance2>=orig_cpu

3. Dump global and instance1 on orig_cpu, instance2 on all cpu:
ftrace_dump_on_opps=orig_cpu,<instance1>=orig_cpu,<instance2>

4. Dump instance1 on all cpu, instance2 on orig_cpu:
ftrace_dump_on_opps=<instance1>,<instance2>=orig_cpu

5. Dump instance1 and instance2 on orig_cpu:
ftrace_dump_on_opps=<instance1>=orig_cpu,<instance2>=orig_cpu

This makes orig_cpu dump for global same as instance, the parameter may 
seems more unified and users don't need to remember another markers to 
request orig_cpu dump.

But one problem here is if there's an instance named "orig_cpu", then we 
may not dump it correctly.

Regards,
Huang Yiwei

> That would allow dumping more than one instance.
> 
> If you want to dump the main buffer and an instance foo:
> 
> 	ftrace_dump_on_opps,foo
> 
> Where the ',' says to dump the top instance as well as the foo instance.
> 
> -- Steve
> 
> 
>>   			[FTRACE] will dump the trace buffers on oops.
>> -			If no parameter is passed, ftrace will dump
>> -			buffers of all CPUs, but if you pass orig_cpu, it will
>> +			If no parameter is passed, ftrace will dump global
>> +			buffers of all CPUs, if you pass orig_cpu, it will
>>   			dump only the buffer of the CPU that triggered the
>> -			oops.
>> +			oops, or specific instance will be dumped if instance
>> +			name is passed.
>>   

