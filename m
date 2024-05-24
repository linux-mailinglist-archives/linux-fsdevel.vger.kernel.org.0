Return-Path: <linux-fsdevel+bounces-20144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E078CED06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 01:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74C51F218DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 23:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCF615887D;
	Fri, 24 May 2024 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cEwZWUb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11FF127E1E;
	Fri, 24 May 2024 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716594308; cv=none; b=VOet4F9ThGQuWBksLd+pWzzLzbUvUJ5ZsgbKT4yveE+gOebtn0vq1OEPDIfxweEU8UvS+bVuDNJVwlwXhuAtx1lMTfjD/ohhla1BEKoELFJekwcPOby9KuaPUUG4atgW3FxHwEinICu+qDvNrb+vsDBM6cUsrLDC9OZkSzwfwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716594308; c=relaxed/simple;
	bh=z/c1pH9qfJ0Qgl4zIa+H+u9yEECjhMkbLYfD/6viTDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=E/BZzp4ceKTBKcNjP1rZZztGLCoQ5eSoabpeTLKE9Jp6DNY03ygg90dWexctxxYO2zxJJlcV5/fYv8By8TedqB7iE6eUP6A3ORWS0PvtxjNC38FWpxfFlsiwyDxLlTaYO3lP7qBffGD3PX746AtbWQH07N2QWfUfdCxNcK27hgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cEwZWUb6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44ONN0LA016796;
	Fri, 24 May 2024 23:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=y5GPD/awB1Lj7SRaGStjnA
	WaGzPJXkqOnktpur/zvmA=; b=cEwZWUb6J5GAxt6XLQGDT4ZAKSnqT3hqSwVgVA
	hur0z1nqLhgh9KT+cbuK8voSmjeinYm4FV1SCHdOYelhY89LIvlAJVguP8PRKuL5
	w4NX0I4S9zYebiwPJGThlAsSF0plENjYzc+rLLIcwH4gcpyPV7nAJYn3kp6jKEEs
	jAzJdy0ky1lJhIqorOiolrm1o0xV6HeAWo6XIc6L8rn91FBhHHTSnZi5bu/6tpyt
	IM5GU/8Y7MYvlmEvln14+mB9Qd1BWoz4PBKycHm0UipnlRl1z4RxyskVMomRi8Sh
	RlwLSQi+DOOmQjcp7YxTEj4ZzQLq85TqscuX/IScUAN2f6Xg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa96kp33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 23:45:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44ONj1Xc018792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 23:45:01 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 16:45:00 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 24 May 2024 16:45:00 -0700
Subject: [PATCH] fs: efs: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240524-md-fs-efs-v1-1-1729726e494f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHsmUWYC/x2MQQrCQAwAv1JyNrAuqVC/Ih52u6kN2LUkKi2lf
 2/0MIeBYTYwVmGDa7OB8ldMXtXlfGqgH1N9MEpxhxgihTYSTgUHQ3a6zF1LTBQuBbyflQdZ/q/
 b3T0nY8yaaj/+Dk+pnwWnZG9WnFdPYd8PmLSKNYAAAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OjdhZgIu48ltmE8Gz4vaJdaHd_LtXELT
X-Proofpoint-ORIG-GUID: OjdhZgIu48ltmE8Gz4vaJdaHd_LtXELT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=811 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405240172

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/efs/efs.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/efs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 7844ab24b813..462619e59766 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -311,4 +311,5 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 	return 0;
 }  
 
+MODULE_DESCRIPTION("Extent File System (efs)");
 MODULE_LICENSE("GPL");

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240524-md-fs-efs-9be954e4406d


