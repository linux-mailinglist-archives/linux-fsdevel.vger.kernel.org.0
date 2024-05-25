Return-Path: <linux-fsdevel+bounces-20154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3A8CEFD1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C401C209AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8644E84D2C;
	Sat, 25 May 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e6jJvMUF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28444C6F;
	Sat, 25 May 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716650773; cv=none; b=g1XDBTXj86awzDkgUPIk5QrrCp/lLR5+427IivamkkhSyMsaW7GjQ6xIb1JmzHJZs/6i+hpmmShx0f2uJWvvOepqrWzc8n072FSBEu4hlEggPykkd5YoyfcfWcceSPBnr5EobZSLEVMpi2hD7kvd39O/9CL/oB9sFudsgJyrPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716650773; c=relaxed/simple;
	bh=UpornZwFGcZkt9ze4fdtoh3iyUIkzReEUqXzo7qNhTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=SuE7cMYKgBBo/25+WS5W+60TGwUeAwRAiauT+SebHvqkj45sBP0Yx7QIpZE9vpFJcdhqXp1efE/gS2GL6+5EhmMXCgA8IX5UhcH6sAtYh502adeKZDamXJbsmekPApM6dLgZ9C7kwSQmRF0svQhLyFakGyY3rD1yXCzfT3vYi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e6jJvMUF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44PB9tm3022757;
	Sat, 25 May 2024 15:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9dCJ/M81ZarIpNHGwnzW6v
	E62xjRIb1v5A0jpB2E2+w=; b=e6jJvMUFvroAl87b3MvOlhuG6xi56VvQNH4WFr
	4N32zul/MkrAQTwk/ZVcuJaDxgOBuKG+pxbGmwsLuyw5KIKYp7VQ7nVpS2gXCeYV
	mmN5iF3xjmfWQsUPIMuIjGK0VRSuyPFeRBCTMlWLQ5gsjBCP9TxQZ8OlLOQLx4gI
	l5nCaf2yXclhEju4q+xFbMh/WWgkKlElYQQ1zKft37fKFmTWh8EO/0RGpk5aeUi/
	pDasP0hMBmx6Uw7RPhmzx4U310icbgtLDVZT3k7NyaQ6rijKV7/Us/6XYx1DBFQO
	02qimBkF93DGq/QWBa/Y0WMQbL5Y6KNM2S20129BykMj0HmQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h0ggf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 May 2024 15:25:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44PFPvR2006005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 May 2024 15:25:57 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 25 May
 2024 08:25:56 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 25 May 2024 08:25:56 -0700
Subject: [PATCH] fs: minix: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240525-md-fs-minix-v1-1-824800f78f7d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAMDUmYC/x3M0QrCMAyF4VcZuTZQy4riq4gX6Za6gI2jcVIZe
 /fVXX5wzr+CcRE2uHUrFP6KyVsbzqcOhon0yShjM3jnexd8wDxiMsyiUtGn0Ed3iVdKCdpjLpy
 kHrX7ozmSMcZCOkz/xkt0qZjJPlxw/rUpbNsOJHnmyoIAAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jNiwyS40TNX6W4vfdHtZ5wzWx3c4ZRsR
X-Proofpoint-ORIG-GUID: jNiwyS40TNX6W4vfdHtZ5wzWx3c4ZRsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-25_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=790 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405250125

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/minix/minix.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/minix/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 7f9a2d8aa420..1c3df63162ef 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -730,5 +730,6 @@ static void __exit exit_minix_fs(void)
 
 module_init(init_minix_fs)
 module_exit(exit_minix_fs)
+MODULE_DESCRIPTION("Minix file system");
 MODULE_LICENSE("GPL");
 

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240525-md-fs-minix-2f54b07b8aff


