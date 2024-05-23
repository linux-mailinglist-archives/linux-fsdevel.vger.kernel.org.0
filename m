Return-Path: <linux-fsdevel+bounces-20056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1DE8CD526
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 15:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3E81C20B34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8414B090;
	Thu, 23 May 2024 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qx88CsH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1614AD17;
	Thu, 23 May 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472699; cv=none; b=Gn0sFqLhcQQXayVZKmKWRnKuIVFFvJF7GHMHEJQo+DkgP8utYgUBhMcFbepORCoeqc8aGIC/+XHDYyIlWb/xM9rGHEwyXn4CvkLoamjBidVuTT45Gsuzf4qUAcr5L8Tbed+sN6UdfSr3FFAdZRGm5YPNku3Cvcvqm5/5OEUDXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472699; c=relaxed/simple;
	bh=YPfQzZYPkBwZc3FLAffaI2QalYlcnxIGXbskf7Lt0V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=CtR0tJJv1vHRs0bVeO5nRg6zsau9Am9ywLdo+QUedLHTzt5U0T0qq4abL5jLotDHfl6hUBiwhs9s9Lcxy0hR5rX9e1ZDpg5hfPZJvlL7inz2qqYPWrArJLm+CJh1p+Bs6kV2K+ElzZf1YAbcVtt7rqaI+/yQsa33dvjcCFcUBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qx88CsH6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NCs08d012860;
	Thu, 23 May 2024 13:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WeLFUlJqNSyS7HG9uH4T8X
	0EVSX5fdcaflLT4csqs4I=; b=Qx88CsH6UQxCdjUK3QJO1FoXtMCoM+jXXmYJGK
	FGMhrcY47RFLKFGgFffFPWs5GOlRPwVtmq9HmTwpYCPPmkMRJh3KJIU8ftAXLAvG
	GH2imnCnG15sQDPkCbrNrsKyyKaERJVwRcR5+LFqp/KxK9n0n3p1o/6pcQX6/6P2
	gQE8beXQFNIj+MyJLIQul5RlySzI2pfg9pSq+2kP6wSL6JM6ict4DLiM3YBs3eUs
	xob0Rl/CoCq213EUEET9SAeo5uvxnG+QoFyHnUOCGn4c4LmPaQwBAxcC9Njh9Zuo
	WcfOwoaA9p/nQZHy+g4ma/FiBmbh8HkSlg82dL3HE6OVWcgw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y9y2019jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 13:58:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44NDw61J023670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 13:58:06 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 06:58:05 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 23 May 2024 06:58:01 -0700
Subject: [PATCH] fs/adfs: add MODULE_DESCRIPTION
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-md-adfs-v1-1-364268e38370@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGhLT2YC/x3M0QrCMAyF4VcZuTbQlYrTVxEv0jZ1AVdHMmUy9
 u5WLz/4z9nAWIUNLt0Gym8xedaG/tBBGqneGSU3g3c+uKP3OGWkXAzDMJxcSSHSuYdWz8pF1v/
 T9dYcyRijUk3jb/+Q+lpxIltYcf60FPb9Cyi1UrF+AAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 79gAgrbAqP8qnLRjvLTO4tSCXgsLNQyg
X-Proofpoint-GUID: 79gAgrbAqP8qnLRjvLTO4tSCXgsLNQyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_08,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=955 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405230096

Fix the 'make W=1' issue:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/adfs/adfs.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
fs/adfs has no MAINTAINERS entry so falling back to the entry for
FILESYSTEMS (VFS and infrastructure)
---
 fs/adfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 9354b14bbfe3..f0b999a4961b 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -491,4 +491,5 @@ static void __exit exit_adfs_fs(void)
 
 module_init(init_adfs_fs)
 module_exit(exit_adfs_fs)
+MODULE_DESCRIPTION("Acorn Disc Filing System");
 MODULE_LICENSE("GPL");

---
base-commit: 5c4069234f68372e80e4edfcce260e81fd9da007
change-id: 20240522-md-adfs-48870fc4ba91


