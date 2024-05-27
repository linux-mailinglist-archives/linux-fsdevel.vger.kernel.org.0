Return-Path: <linux-fsdevel+bounces-20268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E738D0997
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 19:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 070D1B259AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A35615F3EB;
	Mon, 27 May 2024 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T2tlCDxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CEF155C8D;
	Mon, 27 May 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832514; cv=none; b=JE+BiLQk9avuWmVhhvscVhAiC0fCI6cUOpGgaV2iWEexakKPRLea+NZwqhP3mzbcFQo1JE0DQKlY5OWnhq84WNnAYc9w3Q5/plUHgOHbkm+b3TM8lK/ARNyq/OY+UmaUkGFWwltk2IOKPjEq8dPVFl0ZjBpMTl7EV9OXaCWZVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832514; c=relaxed/simple;
	bh=4/wrbLy3tLM4pQAJX3ZUxOmitlqs8ZVtgtu8a9W9zUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Vvv8SYRP0fE9bdIdDY/oVXQDY3NCcPc5jBJf6TTgFCYpm9l8ayxv9ptAngBVfc8i2FM6dl0FUyMbqgLSksgAVNxcd5ubwAXJmBWHeaHmrVpIHQj7mpwaegaDy4m9LsUGZMCOkx8LXjJhUlA1Udl7sXjCp8a6WZL1dqLpkLD87k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T2tlCDxE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RB13Q2011350;
	Mon, 27 May 2024 17:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vDLTztAKMtbNomsyoxqxOG
	SafnWIUXeUC9jGH3RM3gE=; b=T2tlCDxEU6oU6J0EjUEziwYvOfIAmjh9gBG0Do
	XvYRTAO2W1kHed1PZIk4syJlxva8hhQTVygDnolgRdV+6jhrEvwjJ/xJItc8ZLj6
	WxohNyXsSIx4KTsCktVEFWpEcp+Vv9+VYTlEqQ+e1KK1sZJWxZUTUYVupcEVUtjT
	H1elqKphRuCbX5Ed6NSDv0ZEoxnpm/nYrU3LtmtP/dCxZb/XtqI9N3tWqlyzQoIc
	ytbzcObc7kM6Fm9lfjnaE1jVi3bkAVnHPXVEi5z/pKGquRZcZCTGiNhZTbsDEQw+
	62ts5q+OiCrcoWMwz02Br4XmhS4mEEK0HC1gnlTK1xXiL2Ag==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba1k4csu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 17:55:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44RHt2bD017548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 17:55:02 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 10:55:02 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 27 May 2024 10:55:02 -0700
Subject: [PATCH] fs: cramfs: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240527-md-fs-cramfs-v1-1-fa697441c8c5@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPXIVGYC/x3MQQrCQAyF4auUrA3MjDoFryIu0mlqA84oSZVC6
 d2Nrh7f4v0bGKuwwaXbQPkjJs/miIcOykztziijG1JIp3BOPdYRJ8OiVH1i4Jj6TMecE/jlpTz
 J+s9db+6BjHFQamX+RR7S3itWsoUV9v0LeLILxn0AAAA=
To: Nicolas Pitre <nico@fluxnic.net>,
        Alexander Viro
	<viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tJUvKGrVjRfTPw2TcV5MnPtMsYi93zqa
X-Proofpoint-GUID: tJUvKGrVjRfTPw2TcV5MnPtMsYi93zqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=817 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270147

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/cramfs/cramfs.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/cramfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 460690ca0174..d818ed1bb07e 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -1003,4 +1003,5 @@ static void __exit exit_cramfs_fs(void)
 
 module_init(init_cramfs_fs)
 module_exit(exit_cramfs_fs)
+MODULE_DESCRIPTION("Compressed ROM file system support");
 MODULE_LICENSE("GPL");

---
base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
change-id: 20240527-md-fs-cramfs-10e1276a3662


