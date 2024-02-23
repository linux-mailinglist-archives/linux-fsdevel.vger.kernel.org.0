Return-Path: <linux-fsdevel+bounces-12545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846FB860C17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910E91C24BA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B5217C67;
	Fri, 23 Feb 2024 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PygQxaZH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97D18E1A;
	Fri, 23 Feb 2024 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676377; cv=none; b=bb0oYdzYYJB+m/8FtYS+qrI3m3hOlgbaNNskA2SPliAaUxUXRZUYkFtG6zdYQGCyLqOnAVzkPgMBdLTlG4BPZpoZU8HVQbF53qGd09itkqHvUruEDy55mkilduI/O1UjSfMx7OrKtRdj9WRd9VoSo4LESAVJNQbNCfTtKc3LxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676377; c=relaxed/simple;
	bh=bxKVLfXUOrYCc1HMf6cA/qaIlndRkwywoIcyCvZE+20=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XY+v9ZPbi2aRXTdrWeJcnf96Ygyt9X4pdv2szBIu907r1NHknWD+LZJjny+52kaOoG1wNt/iPyyc7SsMBV1fy8Jx+4dImogrOKl5jOujKCulAvhOUHQRj5zejKJAgdlLs6aUSzZgKUgb+Zpp9Re7pNvhamLDbq110mps+G93jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PygQxaZH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N6wQAJ018192;
	Fri, 23 Feb 2024 08:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=V+b8YmX5afdJWa/CAGosDW6KMworhmpiey78aaLn9yg=; b=Py
	gQxaZHLztNdHdQPcRPH30ClSetOUcfzv/sxYchehMnO+Wx1HyvAsRYAdlA0tt5zW
	MRxva8K1AS8+Qksk62Z4yl39DdcxMswyfZQXLlcHkfadr8hFtSMj6ZH8DGV4eB8y
	bJIPhrG10vJrVurNTC08mQhGTwqn8O78r065yEqENYFeURxX5guoGCcSsrWwbtjq
	biztfLMFVXtzKFPr23yeTwu/2Kgf+IYx4Q4Kng1WJQXJ05YXG69FtJvBeoSboM4x
	CEjfPqRc7sizIHKEovZRZaYNgOGg8Sg4xHF2UERlDisdzSWVNU4wbiRY7NbInyag
	A5/RvwSQAqPkajEVBopA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we97thg3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 08:19:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41N8JIY0019231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 08:19:18 GMT
Received: from [10.239.132.50] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 00:19:11 -0800
Message-ID: <48cd594d-e06a-43e8-a825-18d477733aaf@quicinc.com>
Date: Fri, 23 Feb 2024 16:19:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tracing: Support to dump instance traces by
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
References: <20240208131814.614691-1-quic_hyiwei@quicinc.com>
 <20240222204701.6b9de71e@gandalf.local.home>
Content-Language: en-US
From: Huang Yiwei <quic_hyiwei@quicinc.com>
In-Reply-To: <20240222204701.6b9de71e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KfQQVn5X8xNy--G7pi6nB1mcrylIty4n
X-Proofpoint-ORIG-GUID: KfQQVn5X8xNy--G7pi6nB1mcrylIty4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230057



On 2/23/2024 9:47 AM, Steven Rostedt wrote:
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
>>
>> Also, the sysctl node can handle the input accordingly.
>>
>> Cc: Ross Zwisler <zwisler@google.com>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
> 
> This patch failed with the following warning:
> 
>    kernel/trace/trace.c:10029:6: warning: no previous prototype for ‘ftrace_dump_one’ [-Wmissing-prototypes]
> 
> -- Steve

My bad, will add the missing 'static' keyword in next patch.

Regards,
Huang Yiwei

