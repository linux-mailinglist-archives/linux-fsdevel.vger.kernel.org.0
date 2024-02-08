Return-Path: <linux-fsdevel+bounces-10748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925A84DCCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88851C229E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57BD6BB47;
	Thu,  8 Feb 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a69GVgQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7EF6BFA6;
	Thu,  8 Feb 2024 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384189; cv=none; b=bbiGTD10VviojDU49InhDPyWy6CDmwNh3wi4arYsmzDUX0TiTbAExzkpvF0bnOHylv1N/fFvrgtxVMK+qQihYnf9wmBGmCeM7Nm1WbwYIxpqyzZYyPqdFPPl1k11IwLJeOMEABIL6V9vIPx66LiB3/0a1ieO3ugcgLu42pJ87so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384189; c=relaxed/simple;
	bh=gdfBej27euGxJcT9NXwgasXWvHeRtnjKy2yiVwekJ4A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=qdi8V1UDty9CKmsFB49Rafcp6a+wBNOUvie+3WvMQuYCVCgwJJncJvINI0LOAguwPDy9r0mddbFDZNTvqTT0LedVgNM/c4K25LsVoLT9W75jnUMwZUcQGOJwQ0FPeK3c6Hfo5oDrBNKIhIzcAvxlKBQ5XDIz48AL0ogCSXVzmXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a69GVgQO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4185PxZ6031708;
	Thu, 8 Feb 2024 09:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yIsFGzjC2AWz7C0/no0S1EAVpf2e+m6kDY2d+317iyg=; b=a6
	9GVgQOrPS9NO26yK+GxGX1Hswx1AN7AN+g3u/2eHnUc2ui2Ylo4RSMOLe5zLBWoT
	hMElQRCELAiAnRQCZWV5HWtbs8DfH/tknHubjr/MfftH7iDaMUAZ6tySizyo9R7+
	jFhS/gqrOofS3tFhK4d5seIezBWXBe6t3QJRlvDhngrJe7hEDCU+VuUG6gvuUuKB
	z9sF+Q/h5J1bdKGgldQukX2XjbqFiB/V26TKTdZ6s3/+/a9/ATi92SRHM4ZlnKJK
	AwZe+fgndca5yvUo07C8aJHy+0Tp1phS0+hDq/uJSY4/76BOil0CLGCXYp00lEtd
	ILWwj2Pzp81T+ar0kCXw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w44fwk7hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 09:22:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4189Mh2r025552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 09:22:43 GMT
Received: from [10.239.132.50] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 01:22:36 -0800
Message-ID: <ec99fdee-8d3f-476f-842f-f57b2b817dae@quicinc.com>
Date: Thu, 8 Feb 2024 17:22:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Huang Yiwei <quic_hyiwei@quicinc.com>
Subject: Re: [PATCH v4] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
To: Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt
	<rostedt@goodmis.org>
CC: <mhiramat@kernel.org>, <mark.rutland@arm.com>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <j.granados@samsung.com>,
        <mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <quic_bjorande@quicinc.com>, <quic_tsoni@quicinc.com>,
        <quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, Ross Zwisler <zwisler@google.com>
References: <20240206094650.1696566-1-quic_hyiwei@quicinc.com>
 <50cdbe95-c14c-49db-86aa-458e87ae9513@joelfernandes.org>
 <20240207061429.3e29afc8@rorschach.local.home>
 <CAEXW_YSUD-CW_=BHbfrfPZAfRUtk_hys5r06uJP2TJJeYJb-1g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEXW_YSUD-CW_=BHbfrfPZAfRUtk_hys5r06uJP2TJJeYJb-1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q_Xwq2R-qjMYvW3jW5NKo5PQzDK1nXS8
X-Proofpoint-ORIG-GUID: Q_Xwq2R-qjMYvW3jW5NKo5PQzDK1nXS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=964
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080049



On 2/7/2024 10:13 PM, Joel Fernandes wrote:
> On Wed, Feb 7, 2024 at 6:14 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Wed, 7 Feb 2024 05:24:58 -0500
>> Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>>> Btw, hopefully the "trace off on warning" and related boot parameters also apply
>>> to instances, I haven't personally checked but I often couple those with the
>>> dump-on-oops ones.
>>
>> Currently they do not. It would require an updated interface to do so,
>> as sometimes instances can be used to continue tracing after a warning,
>> so I don't want to make it for all instances.
> 
> Thanks for clarifying.
> 
>> Perhaps we need an option for these too, and have all options be
>> updated via the command line. That way we don't need to make special
>> boot line parameters for this. If we move these to options (keeping the
>> proc interface for backward compatibility) it would make most features
>> available to all with one change.
It's a good idea that "traceoff_on_warning" also has instance support, 
but we will use another patchset to do this, right?

And for this patchset, shall I fix the typo and resend again? Thanks.
> 
> Agreed, that would be nice!!
> 
>   - Joel
Regards,
Huang Yiwei

