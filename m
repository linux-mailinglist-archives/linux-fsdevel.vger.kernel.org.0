Return-Path: <linux-fsdevel+bounces-20267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1018D098D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 19:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43C41C215CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90815F3E1;
	Mon, 27 May 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PqEjF2Jk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E6155C8D;
	Mon, 27 May 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832397; cv=none; b=luJqZbuIe5AJYMhMJC/WIXTaZ+D5zkSw2C1BtNmqO2GVEbF16qEz2mgd8P4jmU5en7rS4LD2JstSHwpc0+S0Xj1FpKMN3Zcc26xrm3U70kdN3BRkv8G5IOF/elOvt8g4/Qzoo7Hf7cGWgMUaZj18TY+u576aKu9znjMOlBzz+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832397; c=relaxed/simple;
	bh=Nb19pvCAX60hu3sngA2twTyIu9RvEKagaSk1gDX49VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=PZFEI9Y3EBWJFBoVgYvZtq/AC+bRoP+0eqqoUWOWXWB3/oltiqaTpuoenCNkin4E1uVL4DmgcHVQ3YhTwGR4jrTUTHPo52TkUulFOS37sxvSl9Ue4VfB8HylYoJJny+mSCR84NFIZ9w00XugBBZF6r4FUfiADlStjtWXeXIqEcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PqEjF2Jk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RAKNFq014999;
	Mon, 27 May 2024 17:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nwKU7LPZVfifHRJ1f2VlRf
	2ydMeqxoyUFxEAapD043o=; b=PqEjF2JkgHKW0uJPVPcl5WoUKFUCi87nNGU1Qu
	T/lab5iwC0FSey6BL5gHn9LjQ2cTLo8eeFvkhFLVJyxJmHKzWGJcqOVasuLloY5c
	THYIQCCCqf7xqsRVRJEZviDIYrZEQf0rgsAGHxZjQn3V1bed277ZPMj94FzzrfE0
	OuDc4VdTu5Zs8My099wwBtogzsWsizKy8ZcPVfNvfRyPhibHzEOUcU2NThXIFhfp
	/HIR2Zu1YkAjADYoejBjDYCB0hewwmFsIl9llmqmnpA5j7Go1zid21zXEYyZoqro
	6gBuVSIGK/UIHJ/ySE0BK/fqABbq91CPoEl+QMegIFJo/IJg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qcbbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 17:53:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44RHrBmn015927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 17:53:11 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 10:53:10 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 27 May 2024 10:53:08 -0700
Subject: [PATCH] fs: hfs: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240527-md-fs-hfs-v1-1-4be79ef7e187@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIPIVGYC/x3MQQqDQAyF4atI1g1MR+1Ir1K6iBo7gTotiRVBv
 HvTLt7ig8e/g7EKG1yrHZRXMXkVx/lUwZCpPBhldEMMsQltTDiPOBlmX9c2qU6BLx0R+P+tPMn
 2b93u7p6MsVcqQ/4VnlI+G85kCyscxxfsmrdhegAAAA==
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6DRIjS5sTXcdMWVdiwxHcvJHoFymKXAW
X-Proofpoint-ORIG-GUID: 6DRIjS5sTXcdMWVdiwxHcvJHoFymKXAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=912 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270146

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/hfs/hfs.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/hfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 6764afa98a6f..eeac99765f0d 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -28,6 +28,7 @@
 
 static struct kmem_cache *hfs_inode_cachep;
 
+MODULE_DESCRIPTION("Apple Macintosh file system support");
 MODULE_LICENSE("GPL");
 
 static int hfs_sync_fs(struct super_block *sb, int wait)

---
base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
change-id: 20240527-md-fs-hfs-8547370e68aa


