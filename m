Return-Path: <linux-fsdevel+bounces-20274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8882C8D0CB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 21:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F127E1F2290F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 19:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5D31607A4;
	Mon, 27 May 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HRMsubYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A5168C4;
	Mon, 27 May 2024 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837745; cv=none; b=nZMLvo/xrWBRTkhA0YZ2v0yF9lNLJBuouu5lZbUHNVjnAygv8RAkD2sy6xEq4RON8Uc8y7Lvi/gkOVJUOhh7jiPTRoyNOUonn1L0mnGSFLcsJcsedhbNAHjWs+aVGUGtrAOux9S4q8b+edjBnQ12NOU7UVoTqbr9jDOUh6nb0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837745; c=relaxed/simple;
	bh=kRjyh3oVDFHZzlBJvCjPHdot1YuoXmIouFWC6CTwPJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tIIqV1w5z9gHSzedzFScVfMMA845WtqPpshH+voTIDTbGLyffgz/UfwHFspK3CKmWUODTxm/Zy/o3dB83ccFqB6Q9tl454uoTUiL+DT4cXll+iXgsK/rxyzEzVYRWz5QXRqwXQ2QvXGaZBsypDFnQQF9blJiWuR5rFzvSkLxjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HRMsubYG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RB5iAb011373;
	Mon, 27 May 2024 19:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uigtUjAeyX0roe9lGMfghP
	X4bcugzbG6bapakn4jByw=; b=HRMsubYGJfCaf5sR3VYKV02iFhdRl4LeY8c6zz
	Mf9qdyDwa/JR5QVO2J/hS1sbJYgR1QfvF1NIjMFCiqjlC3+IUmCKMvNeAFre5WDr
	DyBlNLuQXNmUEgKYtJ1sXLc1sr0ji88xoM/Cbcdu9jfHYkfUZP0tSnqL6/FaKdLS
	1oIFGBXRSEramOURRDhMHSyYpsn28BzMWnOMVfIPSS0+6k6lCCQJ5yfuOxG5LHox
	RyZwDXFXOc9/RqR1dNDM+5MPakp9JUorj5mZgjqqYC7cF4mnKphg13RmkjRL/47C
	59ttesy+pDYmJ5xdtGqPMUi83Lfjjd3UOMqKSDrEfUQvjK4A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba1k4g7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 19:22:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44RJMIER020640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 19:22:18 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 12:22:17 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 27 May 2024 12:22:16 -0700
Subject: [PATCH] fs: autofs: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240527-md-fs-autofs-v1-1-e06db1951bd1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGfdVGYC/x2MQQqDQAxFryJZN2BDZ4RepXQxo7EG6lgSFUG8e
 6Orz+Pz3g7GKmzwrHZQXsVkKg73WwXtkMqHUTpnoJoedaAGxw57w7TMk0+kSCH6EZoMrvyUe9m
 u3OvtnJMxZk2lHc7IV8qy4ZhsZoXj+ANfkFCMfQAAAA==
To: Ian Kent <raven@themaw.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <autofs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CvnCgo5XStgD70_VHR9EQR6Gj2C_lBf9
X-Proofpoint-GUID: CvnCgo5XStgD70_VHR9EQR6Gj2C_lBf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_05,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=729 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270159

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/autofs/autofs4.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/autofs/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/autofs/init.c b/fs/autofs/init.c
index b5e4dfa04ed0..1d644a35ffa0 100644
--- a/fs/autofs/init.c
+++ b/fs/autofs/init.c
@@ -38,4 +38,5 @@ static void __exit exit_autofs_fs(void)
 
 module_init(init_autofs_fs)
 module_exit(exit_autofs_fs)
+MODULE_DESCRIPTION("Kernel automounter support");
 MODULE_LICENSE("GPL");

---
base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
change-id: 20240527-md-fs-autofs-62625640557b


