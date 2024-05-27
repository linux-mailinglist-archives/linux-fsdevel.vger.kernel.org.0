Return-Path: <linux-fsdevel+bounces-20269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 285AA8D09AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 20:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9FAAB269A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD815F3F6;
	Mon, 27 May 2024 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LdYnP5Gd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779561FE9;
	Mon, 27 May 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832849; cv=none; b=XoolFWzMUjpmf1WuqXaq484gSL1hQzKmPbq/2ZI/0ALaU4Olo1G0osI95G1sr7vG7HKTaGa/wIKLcOJrKilU0GCXZEca9e2TUIdCvImuESq5yU0fzdQsorPhlNZAMTKRRoYjQIBugrxHI7MJz/cxjPUcpQmUkYiJfB4c0ihmBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832849; c=relaxed/simple;
	bh=eH0F+mcDg68xYOmkWzDUC99VgUBAlwGAxJqRd4FEZbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tb0r6Y0Lb+J+xeoEEfz6TaVyLuGTvgPoxOB6/y41T6D4X70D02qrvtmkCtMcw+5VgAyo3EOqQ4AZC3O2jVgTyAuj2MnPeLMLVccpW4LFHPXI9R/uMKUjExBoq9QFL94MTE0EJTWMRIAGg/gBjW1DQfo5izvuH7p0xScUeox9nGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LdYnP5Gd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RAeA2c020732;
	Mon, 27 May 2024 18:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GYwbbxR7Ls3JknzZfO3p5B
	u7SiImZ41nDz1cBFVIUl4=; b=LdYnP5GdnQcYtq+fjDSMwGEEWd5RGar7VW3/MT
	bxxS2enE2/YoUE0vBVPSFke5YRygXthCpHZ0ojrLife/9JMBjMY3dyPG1Wpr5KKA
	/PjgDlrS61g7T85x2yND1H20vbobJk3QRGf9UK64zDUqexnM2sJHsSEZyr6+7fnH
	5bFnF+Kp/m/0/Br3tZTCmOtPdJo4CfCoq/KsyDstKWfKGyNKGR+MIZ26Oc8TiRIm
	XPUYWKwiCsBcMfL21MKkOIeLVq4uHtk7c2FsOOLHrONhLUqtFpuAjM4KhQcqZk2c
	uTXJ28IHmmi8fodFZ1SKXqtfbiITGqfw1WFEub6pf3TKbV4A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0g4f0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 18:00:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44RI0eu0007850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 18:00:40 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 11:00:40 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 27 May 2024 11:00:40 -0700
Subject: [PATCH] fs: fat: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240527-md-fs-fat-v1-1-b6ba7cfcb8aa@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEfKVGYC/x3M0QqDMAxA0V+RPC/Q1cpwvzL2kNZUA7NK4oYg/
 vu6PR643AOMVdjg3hyg/BGTpVRcLw2kicrIKEM1eOeD6/wN5wGzYaYNI1MffEh961qo/aqcZf+
 /Hs/qSMYYlUqafoeXlPeOM9nGCuf5BQBUl5B6AAAA
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Alexander Viro
	<viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bLRKA5kT8Y2JLT52CahHIU6mj6dPZ14-
X-Proofpoint-ORIG-GUID: bLRKA5kT8Y2JLT52CahHIU6mj6dPZ14-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=949 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270148

Fix the 'make W=1' warnings:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/fat/fat.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/fat/fat_test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/fat/fat_test.c | 1 +
 fs/fat/inode.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
index 2dab4ca1d0d8..1f0062659067 100644
--- a/fs/fat/fat_test.c
+++ b/fs/fat/fat_test.c
@@ -193,4 +193,5 @@ static struct kunit_suite fat_test_suite = {
 
 kunit_test_suites(&fat_test_suite);
 
+MODULE_DESCRIPTION("KUnit tests for FAT filesystems");
 MODULE_LICENSE("GPL v2");
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index d9e6fbb6f246..3027d275dbf1 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1978,4 +1978,5 @@ static void __exit exit_fat_fs(void)
 module_init(init_fat_fs)
 module_exit(exit_fat_fs)
 
+MODULE_DESCRIPTION("Core FAT filesystem support");
 MODULE_LICENSE("GPL");

---
base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
change-id: 20240527-md-fs-fat-bea9424c9303


