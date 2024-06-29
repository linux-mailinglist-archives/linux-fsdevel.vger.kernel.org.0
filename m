Return-Path: <linux-fsdevel+bounces-22804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21091CB36
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 07:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B91C22A25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 05:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9D23767;
	Sat, 29 Jun 2024 05:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z/a+BBpA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915DF18EAB;
	Sat, 29 Jun 2024 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719638030; cv=none; b=bldya9GPttuDJUprL2cp6Cf60pCdT7qzvXC/vqL9ldn79+a6Tds4LdYoqAAC+/dsu6387kRPC9Hl7R/EWXBOxW4c6UHexlXiyRRDWCNWZC+6A1xvtEsZBiVv2AxoFGZPIRSKJIEj0CDXs+WFfaExkEcrM7GqM1nxydxz/zsf/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719638030; c=relaxed/simple;
	bh=i1DiK0rT1hDgS/GUoJo/CNpA6w+8Ukpeg957+XdJXEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UoAQ582jORaE4SEl45AmcAhtxOfYseopaKK3bbTj2xvMf5NTnKlUhSZD0DD3FCU+eWLX2hiEhW4OSEPwtwu3bBhbWhlCxEfC8bkay6dvNG8wTkzMzv/bgSV6UHKPjbRXhxBviglHTixMAurpsVO8OMKgLAbzNkPmiX7OXClGo8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z/a+BBpA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T2qTBS015676;
	Sat, 29 Jun 2024 05:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yVIoEw9T4earyu5EwvDWpqz2/ji1nuinVMnfQFi/NCE=; b=Z/a+BBpA8yNfzuiJ
	yZRRu32Ty+rqPZDptVLow3h8BEAJKb03Oz3j6/qLx5Bw4uqd+0ns4a2Zt6vByzWm
	ULwAu9Uo1VE7gtEK5Y5vQNZZNR4tsFRX/q3fKPX6Ky5HcJdZ5oOljBXLYf0xZzDd
	s2FBeMJ9ixK3/a0MldUvWXk0PnC/fh4x9k6ykRdlWfYRSqTp2RLD4yCRsVIfPZjp
	Z1JJVYvCrpx/pRbk3K3PCgY3WW/EPYl2CIYbSP6rxyj2Cc+m5Cw+L+jdOWANuPMd
	zFgTdHwxuHuv6Bw6LGgBKpgq93wVrZ+95NdD4jSywaQwMiGR+wB33TKdLn4s/TEt
	HYHdMg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029ux8a2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 05:13:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T5Dd5S021711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 05:13:39 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 22:13:39 -0700
Message-ID: <0eb7ebed-3eaa-49af-9a34-18f732b9623a@quicinc.com>
Date: Fri, 28 Jun 2024 22:13:38 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] rosebush: Add test suite
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <maple-tree@lists.infradead.org>
References: <20240625211803.2750563-1-willy@infradead.org>
 <20240625211803.2750563-4-willy@infradead.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240625211803.2750563-4-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Llxg50fcXqBYCy4AV_T0iAf3QAzDNSif
X-Proofpoint-ORIG-GUID: Llxg50fcXqBYCy4AV_T0iAf3QAzDNSif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_02,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=701
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290036

On 6/25/24 14:17, Matthew Wilcox (Oracle) wrote:
> This is not a very sophisticated test suite yet, but it helped find
> a few bugs and provides a framework for adding more tests as more
> bugs are found.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
...
> +static struct kunit_suite rosebush_suite = {
> +	.name = "rosebush",
> +	.test_cases = rosebush_cases,
> +};
> +
> +kunit_test_suite(rosebush_suite);
> +
> +MODULE_AUTHOR("Matthew Wilcox (Oracle) <willy@infradead.org>");
> +MODULE_LICENSE("GPL");

make W=1 will warn if there isn't also a MODULE_DESCRIPTION()


