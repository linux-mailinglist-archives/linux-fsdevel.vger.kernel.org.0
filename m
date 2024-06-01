Return-Path: <linux-fsdevel+bounces-20681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4209E8D6D9B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A641C21388
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 03:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EECFAD5A;
	Sat,  1 Jun 2024 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N6Bd/4xb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716B6FA8;
	Sat,  1 Jun 2024 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717211333; cv=none; b=nbYA0BzyMOH5mGZ/EhhwRcDyQYipMs6tnDkyCXw2839PhbneoCX56SpEsqA+f/nMScxL3RrQz3Ct2epybz+RhF5OBkfO/13UFypxlCFAoSV3bxxzlb3jVw3rpZi/NXr/zQApZmr/TbKSsq4qGbkaTVe3PoaJZIUZQetxhl9GbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717211333; c=relaxed/simple;
	bh=Hr7lNj8rNQelxv9ycFyPb/3vMY1/XzuEKLRHy2XNFCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=WAdmT+uHslId0gaPeQncCClnJKt1BpjH9YIrok5S4JZ0dXVTTkQyudldZcjJnbQP6vexa76crGxSEIf5oK28UWBpKLHmGRCTj8+Fpy+vAFdEgX3MhGJuNpOYxw5Oz6ENYUgVkCmP8kMdBcqovXECYvR5rNJeCSbigr68otWgq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N6Bd/4xb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VIf1Hq002217;
	Sat, 1 Jun 2024 03:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Hr7lNj8rNQelxv9ycFyPb/
	3vMY1/XzuEKLRHy2XNFCY=; b=N6Bd/4xb2OMBce+Z7XgyqmkcfquFoc/6V1CfhE
	R2F2HZf7WhOhkRD7pf/BvLE1uN9YY8+7+sehkKkHSJGn54RG5FjsOqJMFo8one2N
	T/ZBOda/jwpDjs1dfy86MMf3CuOZ7/EaUh6yO8oQk6qvEkgaajWI3zx0lJMQIRmr
	NSHqBK9o9v6K9uLb5Oij3EOtsaci9I6jUprnm+YGx1vm6D4JSrzch0zyD2BTfdh+
	93qssxFidDZ8j2c5g1JPzpAePzDYV/t/ZPuP4fbGsnz6yStB0R0R9bh8O8005jzz
	XSgmMHx9gLj+fQ1dUdjW13iYv14raKmGJ2OTBQm6u18XzUzA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfc9nja54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 03:08:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 45138e0m020184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 03:08:40 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 20:08:40 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 20:08:37 -0700
Subject: [PATCH] test_xarray: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-test_xarray-v1-1-42fd6833bdd4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALSQWmYC/x3MQQrCMBBA0auUWTuQ1EiJVxEpSTPagTbKTJRI6
 d2NLt/i/w2UhEnh3G0g9GblR26whw6mOeQ7Iadm6E3vzOlocU24cMRCWsYaRMIHvesH78klawZ
 o4VPoxvU/vVybY1DCKCFP82+1cH5VXIMWEtj3L9wu87aDAAAA
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
	<willy@infradead.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eNzcFjEk4ErfDeotMtVnihy0Ue90s6HH
X-Proofpoint-GUID: eNzcFjEk4ErfDeotMtVnihy0Ue90s6HH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_01,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010022

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_xarray.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_xarray.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index ab9cc42a0d74..d5c5cbba33ed 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -2173,4 +2173,5 @@ static void xarray_exit(void)
 module_init(xarray_checks);
 module_exit(xarray_exit);
 MODULE_AUTHOR("Matthew Wilcox <willy@infradead.org>");
+MODULE_DESCRIPTION("XArray API test module");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-test_xarray-942799e4d107


