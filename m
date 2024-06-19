Return-Path: <linux-fsdevel+bounces-21927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BC490F0E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 16:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6650A1C243F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF33B784;
	Wed, 19 Jun 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZSg6+qb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89901F956;
	Wed, 19 Jun 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807911; cv=none; b=Or5tIp8IbwET+9/wi7VY23jqYAjXVEU0V/g5k5oF5vOM+9OzrHxYxlLwzIx/wOoD0+HtMiIGnfms5eQ+o64qlLrS8qpBGS+TziU5VCyIjnKbkBWYtyWOXXsnuuxmSRG8JLdCe4eGQKIL0LEtCbtn1Vgbk5xtymbkPXv+mkIFeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807911; c=relaxed/simple;
	bh=KyV7B1VywTOUp9ZqRVcsjZOlVmb+A7T5edxwqZZjMV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=UcD/jkr0TvCNCqIHqBoZUGS/blivrQHuReVg6IUPJ5CRTEcDvX/3meJcVYr6lKI9/P/NYWxzuR2r/Y1GyfKJ3a2BOvMHEm6KL4TG0EnxZKTP8tdzYtLMweSlBCSX+LpSx/KI9BTTpWSDyRCFujygsOkcOq1bmmfyYpXl587eVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZSg6+qb6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J94TpA028107;
	Wed, 19 Jun 2024 14:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pyRCJtYiaJBr7WjUnbFB21
	yBWPmFzTLjG6+4n7Y79VQ=; b=ZSg6+qb6YkETxS/Wd1D5PoO+luPMx0gVUJvMkg
	k5GNwzTHmutAe1rMHxhzawW5XXAj+nJYB3t00KBQEIFc1JPcfk6ngw/GiGvSB/tv
	Q+Ldr4Avekf3A+Sw3NDrgea/UN724yo1XuXXw4k+bv36q3WHf49ViFenf0XhqEjt
	gPBz14RZKpNq/eAYpBhpU2+ARi9kIoKPju+AiH7I9C5YxvUZX5q/Ui0CQJ49fVwZ
	cGVf5T+PRSqHYLyIFasVESAxdLg719HIoYapXr/FshpKBAueX3vX7/ap70khZXp6
	9Ta0Ej0jkXcnbY4dlyTFjqnc7E7tGOlDiLCL8UoztHfFGGHg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujc4hyxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:38:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JEcHm2026440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:38:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 07:38:17 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 19 Jun 2024 07:38:14 -0700
Subject: [PATCH] openpromfs: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240619-md-sparc-fs-openpromfs-v1-1-51c85ce90fa3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFXtcmYC/x2M3QrCMAxGX2Xk2sBW1KGvIl6kbeoC9odEZTD27
 lbvvsPHORsYq7DBddhA+SMmtXSYDgOEhcqDUWJncKM7jufpgjmiNdKAybA2Lk1r7nMO/Y0nSrN
 30OWmnGT9h2/3zp6M0SuVsPxyTynvFTPZixX2/QtcJbPDhwAAAA==
To: "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson
	<andreas@gaisler.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Christian
 Brauner" <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>
CC: <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Jo7YimzT4BRmNYbnx2Zs21d9nmIBd-LZ
X-Proofpoint-GUID: Jo7YimzT4BRmNYbnx2Zs21d9nmIBd-LZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190109

With ARCH=sparc, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/openpromfs/openpromfs.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/openpromfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index a7b527ea50d3..26ecda0e4d19 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -471,4 +471,5 @@ static void __exit exit_openprom_fs(void)
 
 module_init(init_openprom_fs)
 module_exit(exit_openprom_fs)
+MODULE_DESCRIPTION("OpenPROM filesystem support");
 MODULE_LICENSE("GPL");

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240619-md-sparc-fs-openpromfs-7c061d5af7b2


