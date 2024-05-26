Return-Path: <linux-fsdevel+bounces-20185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD38CF591
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 21:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23471C20893
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2830C12BEA5;
	Sun, 26 May 2024 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X61oH3iL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF66DF59;
	Sun, 26 May 2024 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716750332; cv=none; b=TG/cIk8NNVnj5X9uneR88WywnG67qzctpKx7Z1s+4tAWAem+faFDh9vZaSyaVhiiuouVcPRmO3jRA4jRnAA7d6A5GWdkkH5UYJ7lwcKGMMLu4sUrnibibuI1wL7MpkRDGk1EaeVxnt62PGYe0tgQ1xN0urgbiONNreAAbxOvSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716750332; c=relaxed/simple;
	bh=1Y9Z8C0cIpWhMDKFiCbH1PYpUeHhR3lfizAmf9HWB94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=KhIABm2DIMefyRXw5S3hkvSKNvHGi7mHeftKv6O+V7j501yxwpnEiLx+ygXpIKPsWBuIZtvX+EC+J84p1h4jaq/EFglxufeG3EQSuFDFT4BkVJrIdEXkQ+/8F/J5QefHwCtH48TWn4TgkDXDJc4ZljA8gZdGO+9Sy1F5xdipD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X61oH3iL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44QJ5RJq019486;
	Sun, 26 May 2024 19:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=e63wKT96OSlju3LI2l36Gp
	afsb/iewRBEfZpislivxs=; b=X61oH3iLa8y+dzmqkQFa79tBMnAbF3hJkPkpOo
	094B5aZADp5sa4mXxYjBVQNMocYcNrAHkq26ca9QhRgjQfqRv0ZCqiJ+yD2dHBi8
	ixnz4kjsXEP+Mb2KlyA54/YVC0qz1kRYEtb0posyytUHGK0nqHJCxy+QacaMMlru
	Wi7MLqRRXskrjG0bGO7c2SzW905GrEaZ6lRwxfGCwfdqWqfRsACZ4pzz7LG82O57
	7/aHgzQbUxn2OXv7LaoJSCMKWz/35ceeW2wgwV88eFtHkXezP1O8omiHR7n0bihj
	/re70TYLd3+Znko73uf74f12zQRHcE/aB13bzFqKnLwdhQhQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2na2c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 May 2024 19:05:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44QJ5PRv022275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 May 2024 19:05:25 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 26 May
 2024 12:05:25 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 26 May 2024 12:05:23 -0700
Subject: [PATCH] isofs: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240526-md-fs-isofs-v1-1-60e2e36a3d46@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPKHU2YC/x2MQQqDQAxFryJZN2CH6WB7ldLFqEkN1FGSVhTx7
 k27+fDgv7eDkQoZ3KodlBYxmYrD+VRBN+TyJJTeGUIdYn0JCcce2VBs8o2cEseGrzE24MasxLL
 +a/eHc5uNsNVcuuHXeEn5rDhme5PivPkVjuMLSJbRuYIAAAA=
To: Jan Kara <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hOjWcYiXd13tu-Ft5kMNVMQ1QlyMq69o
X-Proofpoint-GUID: hOjWcYiXd13tu-Ft5kMNVMQ1QlyMq69o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=863 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405260160

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/isofs/isofs.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/isofs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 93b1077a380a..2bb8b422f434 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1625,4 +1625,5 @@ static void __exit exit_iso9660_fs(void)
 
 module_init(init_iso9660_fs)
 module_exit(exit_iso9660_fs)
+MODULE_DESCRIPTION("ISO 9660 CDROM file system support");
 MODULE_LICENSE("GPL");

---
base-commit: 416ff45264d50a983c3c0b99f0da6ee59f9acd68
change-id: 20240526-md-fs-isofs-4f66f48f9448


