Return-Path: <linux-fsdevel+bounces-20492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6153B8D4041
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 23:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932621C21DDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF111C9EAD;
	Wed, 29 May 2024 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nSQgRTgb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB21C0DE6;
	Wed, 29 May 2024 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017954; cv=none; b=YAEbeYP7D+ZOvKtc4V6HCnW66oGeZkTu575qtUNWdBGslvbXmf+tsmVao2SXVDRatxRtU3aq5shTP3Jxg0J0eliKa47qchi6ACo0J4sp3dbI+GC4R1DIgnFUu6/ka/dhK2/P7N1M/0vaT1dQWLUYsHlj42G3oIER+vDkwfLNV/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017954; c=relaxed/simple;
	bh=h1QhB6hICUgKv+7p6D3d7j4Hjc8YN0CB2Z+FBNtFbJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EwxWRx6+lMcHQYll+CZEEMp5kXV6VLXbb3ZbpzQ7DRl5dUyFZBngTXL7bN8GFLwbaa/AmdB02LwpNkWUTCYMcM6l0Wa5SBUxj31FevLB4fKi9oXjy3ZrMPDSSxkGZPq0pksOsqQeDvEufNix3VFVatB52y5ZvY9nD4mFteGLYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nSQgRTgb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44THreb9006499;
	Wed, 29 May 2024 21:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tlUzw7shh7yNT2JTebOxTw
	EiHkpnudMGBkPRR3vYDWA=; b=nSQgRTgbKnSDY7kzUYMixuzpZWt8XvzdZL3wkQ
	er1TgMOCjvtllX720acvObzF7F7L6yNECv24UjLtNETA4MJ/aF+hCTkS7GWjGaJR
	9a+Xwk8SFBEPMRkYfducEQqkX1lQXPpdPVcu4RPLQdm43a/0UCbElzzbz6dKEzJY
	xpD7B99fOI9wnCMQnvhS+jM29VqfG+v+AlgzUW20u2JABf/FLxrVSynNZ+alqymf
	AnczQpSwNlwL6j7JuMS9Bs2Xc45HTQNrQE6dGzyz8XWW5G41kz9cVK7fAy8jV+NA
	pi8Fs7o6kT1wv8BGGgsFhOqnxrO+MDSgsFW9hgRGe6DxKHyA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yjafx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 21:25:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TLPhBh005773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 21:25:43 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 14:25:43 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 29 May 2024 14:25:41 -0700
Subject: [PATCH] kernel/sysctl-test: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-md-kernel-sysctl-test-v1-1-32597f712634@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFWdV2YC/x3MwQ6CMAyA4VchPdsEJ2rwVQyHbqvSOKZpp8EQ3
 p3p8Tv8/wLGKmxwaRZQ/ojJM1fsdw2EkfKdUWI1uNZ17dH1OEV8sGZOaF8LJWFhK+i8p3juDxR
 ODmr7Ur7J/P9eh2pPxuiVchh/tyT5PeNEVlhhXTfJOx3nhgAAAA==
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6AzJHYSdKDg1sBegalRxg8eFC7NnGO1q
X-Proofpoint-ORIG-GUID: 6AzJHYSdKDg1sBegalRxg8eFC7NnGO1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=962 spamscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290152

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/sysctl-test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/sysctl-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 6ef887c19c48..92f94ea28957 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -388,4 +388,5 @@ static struct kunit_suite sysctl_test_suite = {
 
 kunit_test_suites(&sysctl_test_suite);
 
+MODULE_DESCRIPTION("KUnit test of proc sysctl");
 MODULE_LICENSE("GPL v2");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240529-md-kernel-sysctl-test-2bbad793ac62


