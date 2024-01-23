Return-Path: <linux-fsdevel+bounces-8605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B068393D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E7628ED53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734860B89;
	Tue, 23 Jan 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BRy2exoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B721B60240;
	Tue, 23 Jan 2024 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025152; cv=none; b=E+LxCRNUIKkZlsNjRgRb+yX4yunKYUnjMrC99zsBmaKqqVFrCbKZphcQM1ZNxkJuvOJqZJvnQQQezU2ac7CzdPzT1xHiglSsdsucvrBlCc/o/AW1yI9kA6k0r4CLyLDA9/f5IVRjOMdpfPOXn+S8SIcICF2wSGSwHCo7iSRrlMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025152; c=relaxed/simple;
	bh=lpOn925ITeoxcbmE2jG+i+i7BL7X1pvC6JLxC8iCIfA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjMc16D6BeUSvlYJCIiyHKgXjuIYfm4yAbJPJH3gBMwJD3pOYAmmirN/Y4+dsJxQTYcDPSfg1IMRTI7ROKWs22yHFv9GRzJ/mN0SV0R5dFJSpMMKD3zzD/y58KS0AKxV7P+sVeKR/FAwh+pre/whlBk+CxLtxONVEgiUgjDP9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BRy2exoP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N8KGt5022570;
	Tue, 23 Jan 2024 15:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=JUuUnFDFUMALA36+GlPkk
	/pGx33N4O0srUTkt71nu2k=; b=BRy2exoPAyDT44drpP3ByWRIZmJSvzC2Ea961
	WH1zpDAhLNZn4HbCkr0ePZg9xPpIcGlu5wtKlk75h9v+w1gK4Ep9ceKOhqLmcrVs
	N+sDpjaaAKJ6xhHZE8T3TaOSbbx7GCBvDxt3RNQqwLhUtuzAiDU9v9sFNXaSQSzt
	1RCvz3syJjXnFBxURyZ+jQh9wKW7pAv9lovEaVvDmXwGfYrkA1BgYo2drnZ4hliQ
	dKSut48nO/WCXsqUIEz5BD+P7US+OUuDq7CLV1lE7c/CCwR1KEW7Cp1YW34v7e8D
	49xTYWXKAl6dD0Xhc9gcelySBAq11ODtP0hR8tiInH5O3X8Sw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt9un945s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 15:52:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NFptAF030744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 15:51:55 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 07:51:53 -0800
Date: Tue, 23 Jan 2024 07:51:51 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Joel Granados <j.granados@samsung.com>
CC: Huang Yiwei <quic_hyiwei@quicinc.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <mark.rutland@arm.com>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <mathieu.desnoyers@efficios.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, Ross Zwisler
	<zwisler@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v3] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Message-ID: <20240123155151.GE2936378@hu-bjorande-lv.qualcomm.com>
References: <CGME20240119080907eucas1p12c357eae722d3a60d82c66b81cfc05ba@eucas1p1.samsung.com>
 <20240119080824.907101-1-quic_hyiwei@quicinc.com>
 <20240122135645.danb777cc5e7i77z@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240122135645.danb777cc5e7i77z@localhost>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zjlep91INoG0IKDkPXiFIGEo11yVSWoo
X-Proofpoint-GUID: Zjlep91INoG0IKDkPXiFIGEo11yVSWoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=613
 priorityscore=1501 adultscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401230117

On Mon, Jan 22, 2024 at 02:56:45PM +0100, Joel Granados wrote:
> On Fri, Jan 19, 2024 at 04:08:24PM +0800, Huang Yiwei wrote:
[..]
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
[..]
> > +enum ftrace_dump_mode get_ftrace_dump_mode(void)
> > +{
> > +	if (!strcmp("0", ftrace_dump_on_oops))
> Would using a strncmp be better in this case? And this question goes for
> all the strcmp in the patch. Something like strncmp("0",
> ftrace_dump_on_oops, 1); when they are equal, it would avoid 2
> assignments and two comparisons.

As you determine yourself below, Huang is looking for the string "0" not
just something with the first character being '0', so you you need to
check for null termination.

> Also might avoid runaway comparisons if
> the first string constant changes in the future.
> 

If the constant suddenly isn't null terminated, causing strcmp to run
"endlessly", we have bigger problems.

> Or maybe strncmp("0", ftrace_dump_on_oops, 2); if you want to check if
> they are both null terminated.
> 

This is just obscure. At best it would confuse future readers.

Regards,
Bjorn

