Return-Path: <linux-fsdevel+bounces-20139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16E88CEBB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 23:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE05281DF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9D8529E;
	Fri, 24 May 2024 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kc9ZUNH/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249784047;
	Fri, 24 May 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716585072; cv=none; b=o0mKF1K8rUEuAQbT1ltYgcrNRuYpi7a79yLeeVj8UD+lGIbtQ+jVvmLQTssebCn+xWnoPbqqc89Cmqasf4Q05miHjckJ/W+EAomcuqF8Zd67C8Cp1+vVoI6kwMaEjwDz6LKMgvgZ+bsPIrhB60S6Mm0BHtcoPPHSVyIK1TiDTFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716585072; c=relaxed/simple;
	bh=V+il1BpyLqguUN5u3WorxTuH/oNecBF5wDbRT8VY/24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=WFrpNU64bsmXD5VcIdwH9iDDxaJFpYOXbR1MN/jjtGon3Yh/YcJDA7feORJtmsbxlsGS98HsUliZrC4TO67aXnQxkCnYw75SebkTAcnKdk2NWL07OtZVhDD3wlLfH5xDf/2D+BTYHogG6dz0kwrd5H8I5eGmwwxV0DAe+NjUC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kc9ZUNH/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O9ngob004282;
	Fri, 24 May 2024 21:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=x66SqudCH7fhj49RHmi5YV
	d+DD2Xux89EX5heurLxOg=; b=Kc9ZUNH/26+JnF9XJ/verpLCVbaNRWTLknP4Fo
	bT8YstvyZTpiX+RemGEamHtZh/oK6L8ba7UrLnW5lUvOITrwBlNq3iEhc3YF1vYk
	gGy40oez4fU1fV5+2KZcjUOjAl27tc7cmiiChsM86PkaAEyVXlfn9lLs4JMmdb7a
	eU1oXVuFADa8ebkLQg8KTPlXJyM99PmsjycidpwYKmZ1ga/5l8F6sSPYT0KTAGZ6
	/hzz5fi7JopFS+WFVIrVxI/2MAJWyf47UV2qAunq+q6W9HDhkM5Amy6kyszRSqAn
	I8foLzly1p24GIzuK8exg1Pr5bX5vt7/EofBO249koJj1OJA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaabq3f69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 21:11:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44OLB5Bq005006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 21:11:05 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 14:11:05 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 24 May 2024 14:11:04 -0700
Subject: [PATCH] fs: sysv: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240524-md-fs-sysv-v1-1-9ebcd4f61aa5@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGgCUWYC/x3MQQqDQAyF4atI1g3YYRSmV5EuRidqoI6SVFHEu
 zd1+cF7/wlKwqTwKk4Q2lh5zobno4BujHkg5GQGVzpfVs7jlLBX1EM3DD5UFKh2dUpgh0Wo5/2
 ONW9zG5WwlZi78Z/4cF53nKJ+SXA5bArX9QNTkzxagQAAAA==
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QScsE7XIEo-Ml0rSSP25xiPEwjQcyb9g
X-Proofpoint-ORIG-GUID: QScsE7XIEo-Ml0rSSP25xiPEwjQcyb9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_07,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=804
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240152

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/sysv/sysv.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/sysv/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index 3365a30dc1e0..5c0d07ddbda2 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -591,4 +591,5 @@ static void __exit exit_sysv_fs(void)
 
 module_init(init_sysv_fs)
 module_exit(exit_sysv_fs)
+MODULE_DESCRIPTION("SystemV Filesystem");
 MODULE_LICENSE("GPL");

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240524-md-fs-sysv-9495e9e626dd


