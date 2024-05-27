Return-Path: <linux-fsdevel+bounces-20266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343488D098A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 19:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF26A1F2210F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7028D15F33A;
	Mon, 27 May 2024 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UXhyQ+Mz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B62155C8D;
	Mon, 27 May 2024 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832251; cv=none; b=RdJVMHztT1Hp+5nAgRAa3JsIT4G3T1Az9S9s6ZOe/YLl7SzboG4dZaylh4KsM2aXb5tucwnc+gMgMG6WS4uDaFE2mTfyXPkGRdX6ybyLRwPp730DS99TRNtmMPrV8bh9bPTcqRbVs9lJKmfFpL5DI4g3+ATHdH7fcBM96KHcd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832251; c=relaxed/simple;
	bh=GkrY3yo8W5UlO9VY56pPsTDgblgpfuf4j0U/zbkq8Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=kO6A83ZIylOJ1cMomZc8iVDlOjkILgn2GDOfP5k2Mr3cr9IwoyuYwu48G/GyFqaNvWuFUZ/7vCtLROMv/fr67r8LQVfOqg2cAb/oIYqMtgNN4R38qlaRNyGXK7wI2LTHm0JXA7o2DJHEWiQ6egqjH7IntWK0CIK1FIus2Kau7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UXhyQ+Mz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RAwcxu014262;
	Mon, 27 May 2024 17:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/ooyA51c3n+I3p96o9S6Cl
	EkUQsQ/Hr2I7vtFk6ZHmg=; b=UXhyQ+MzWBxrLf9/SkbW2TQgKgqyYUpoSMXuOa
	Ekrb/jXkeiMiANUqn7gCPdN3ntEaWMejACshG6E+w1ihCwcwL+7m0BtkRaZOYN2s
	vsmW2L2MwgmKDklnjrCyX0EvGazW0iuwojbJP8jMXnug5JYOhqdUMEcF3kCQoRl/
	xtm1Uy4BoSlizXZw38RVw13fK/LbUViGInQqXRa6YHt3IkV5h76VGq3YtNzlZ2Q8
	5SKwFQJeO20elD8XvgnS+ZhZjPRFbKDx+XBeV4+DPkOl30nzPpAzJgZV326noKY7
	LgODb4PgVLjSWD9dbdnXHwGZMF2OOehnoLIdVwklO2BTIaYw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2mvb6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 17:50:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44RHoUEN002569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 17:50:30 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 10:50:30 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 27 May 2024 10:50:29 -0700
Subject: [PATCH] fs: hpfs: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240527-md-fs-hpfs-v1-1-e0f3d8fa8385@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOTHVGYC/x3MQQrCQAyF4auUrA1MB+tQryIu0jbjBOxYkiqF0
 rsb3Tz4Fu/fwViFDa7NDsofMXlVR3tqYCxUH4wyuSGGeA5dTDhPmA3L4tP2sU8ppC5fCPywKGf
 Z/rHb3T2QMQ5KdSy/xFPqe8OZbGWF4/gClh3iRnsAAAA=
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
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
X-Proofpoint-GUID: RPIOaPDagfM0zZ3eQqZPbnUnn8WW7JkY
X-Proofpoint-ORIG-GUID: RPIOaPDagfM0zZ3eQqZPbnUnn8WW7JkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=701 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270147

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/hpfs/hpfs.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/hpfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 314834a078e9..e73717daa5f9 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -793,4 +793,5 @@ static void __exit exit_hpfs_fs(void)
 
 module_init(init_hpfs_fs)
 module_exit(exit_hpfs_fs)
+MODULE_DESCRIPTION("OS/2 HPFS file system support");
 MODULE_LICENSE("GPL");

---
base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
change-id: 20240527-md-fs-hpfs-192977075f6a


