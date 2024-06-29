Return-Path: <linux-fsdevel+bounces-22805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA75891CB38
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 07:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C931C21CA8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 05:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03F25776;
	Sat, 29 Jun 2024 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ErGU/HQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF51C17;
	Sat, 29 Jun 2024 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719638139; cv=none; b=VeUS3UFDLG+8Dhk9XEooi19uCNBTroj7HiJUxlN5BmXzlyu+n9Hwrcn0g0PXdxkjCoSg5Hwsz9f+O1jbCSAceQ4OZufB7IH38UJ7ObtuSql0FG15ae9YvOcSeGTPY8OhCQ240pi/UrxU5BiXsyRVSIMv83zOyjpQwXdwNkMPz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719638139; c=relaxed/simple;
	bh=4rzkcSocCXly6FIs5mAC0IGHC60+lmuZpa3PiscqBY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f9rlI5MsYMOFurzL+avImKFR/5tc3+yYyNeutdHBV9PX6e/KYOhsPy/lfMwPTUdSccHvUp7guE0IYcTltc/wqsZCKy6RQYG8qcC60QbybvM32kX3vu2RsuSFVCM2zKaZTQ7B9mOh+4PM05chs7XkqN2rGvCE2gVvKRWBBfvSsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ErGU/HQF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T3jXFl002543;
	Sat, 29 Jun 2024 05:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MEKGNuauhVXs/t7b3r3wsTpKcSWQi4A+SFavxgLiGD4=; b=ErGU/HQF+qGpMpFD
	bnGk444vvNkJffW68EgQQIpMsap2Zwc5uB/hiYc3JPGzRVDzeUcHmhCwPnsH/vQv
	xHcDTJZakr+mxc9IwjvueGaSnSE8taAJMLyekt/87WwJTgitUHcsB+SXVhYcgro3
	hB/TJW1C/hJl9Cqo2nNapeC5JVF4BNoD49jZP3/KZGCSLvSNvteIV9fMJAsN272T
	zd1NvvXiafV28L1d43N2D+Sci/B7IsKI2pxGwvpIZE71Vn+viyjiN6XoR/woyTFp
	Gfkzn/Tp7xrdoH4Ckppg1CVheuWifxE8QRj5e2ZGiP6SoDfANN4szq91T3sWPjkS
	ylWZUw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402an707dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 05:15:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T5FXQY008166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 05:15:33 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 22:15:33 -0700
Message-ID: <9ac866c0-66f2-4b59-947b-289362baaa8f@quicinc.com>
Date: Fri, 28 Jun 2024 22:15:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] tools: Add support for running rosebush tests in
 userspace
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <maple-tree@lists.infradead.org>
References: <20240625211803.2750563-1-willy@infradead.org>
 <20240625211803.2750563-5-willy@infradead.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240625211803.2750563-5-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c3J8SbyrVfE-di8mjuLbq_vv2OOwRknn
X-Proofpoint-ORIG-GUID: c3J8SbyrVfE-di8mjuLbq_vv2OOwRknn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_02,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=744 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406290037

On 6/25/24 14:17, Matthew Wilcox (Oracle) wrote:
> Enable make -C tools/testing/radix-tree.  Much easier to debug than
> an in-kernel module.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   tools/include/linux/rosebush.h        |  1 +
>   tools/testing/radix-tree/.gitignore   |  1 +
>   tools/testing/radix-tree/Makefile     |  6 ++++-
>   tools/testing/radix-tree/kunit/test.h | 20 +++++++++++++++
>   tools/testing/radix-tree/rosebush.c   | 36 +++++++++++++++++++++++++++
>   5 files changed, 63 insertions(+), 1 deletion(-)
>   create mode 100644 tools/include/linux/rosebush.h
>   create mode 100644 tools/testing/radix-tree/kunit/test.h
>   create mode 100644 tools/testing/radix-tree/rosebush.c
...
> +#define MODULE_AUTHOR(x)
> +#define MODULE_LICENSE(x)

don't forget to #define MODULE_DESCRIPTION() here if/when you add it to 
the module


