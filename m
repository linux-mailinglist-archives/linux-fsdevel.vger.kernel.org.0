Return-Path: <linux-fsdevel+bounces-9954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F4846691
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 04:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08CE1F28141
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 03:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70BBE57C;
	Fri,  2 Feb 2024 03:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Gulj+Tu+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99DBE54E;
	Fri,  2 Feb 2024 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844839; cv=none; b=KNJZA9lo3ajFf2IMDSOLcArd0PxNYN9l8/gunVDByVs1Eg/w6EBzDl1cOrZhsq2CwI7zcI7GqlOFu4Zl9rFTmCnKZhb+5g5mbkMysgqKX+iTmxJdFVW3hK+4ZspAJmLgDdMQhEaKV8U2Kl3eLR+fJHD9VPSXoWCqMMPrD+pK6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844839; c=relaxed/simple;
	bh=OyxBJ+A0yGlHECRXeVfAbJEuoSWpFLSlFOQ48riM33o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4sSGl/U8dp8p6aswXslzMU4LJU9ZDraxfh2qWqI2U1ReF8xkusyuqOi8aoD3tEInb+cjsIoUJmyJCvga1T++t+xRIq8DL00DKv/7taexMCj5/haVe1LXZC7uN+K+YQOu+CdkVqO1FHvIRWi754ZwxM+uYrqjjeENIoNfuugJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Gulj+Tu+; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121b31T011765;
	Fri, 2 Feb 2024 03:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=ZB6EemBjg4kqn54hPi694lZL5cl9eBwRNQ7kuQcXWig=; b=
	Gulj+Tu+3crXaFoBEGXPli3BzPOFtQ0HZxb/51R5LRhLop95qlGv2fEQRsFSZKhb
	fsaOaieQDWOx1q6tlCRC11ZwoaADhez6zTlMsMfvwMTjG6gGj+Bb6pijCcVUNM2Z
	IkGJQ18zpO2QlQa+kxCxqXr8knJv4bQcN3Q8S+If+5CGdK0TYVeFrlon9h7LlQq3
	3gXNWYNKDCTTKqCMsyI3Uj46r1lnCHjgbYrGsXGSPhg82MaPuvUNAWZWRKPMhG6g
	iNje9YaYkf/zvHoP866ZE4kqR/nzQPcfpnFsW1efHL0Woa44Xnvobgxg/K2P9Omg
	eVxkjPyhvlmAbKXcPxsGKQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w0pvcr28v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 02 Feb 2024 03:33:38 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 19:33:34 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 19:33:32 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com>
CC: <almaz.alexandrovich@paragon-software.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ntfs3@lists.linux.dev>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] fs/ntfs3: fix oob in mi_enum_attr
Date: Fri, 2 Feb 2024 11:33:34 +0800
Message-ID: <20240202033334.1784409-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000012d4ed0610537e34@google.com>
References: <00000000000012d4ed0610537e34@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jK86FqcCVEdZqEKrJxt2Cghy_RGh0MBu
X-Proofpoint-ORIG-GUID: jK86FqcCVEdZqEKrJxt2Cghy_RGh0MBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=574 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020023

When the value of attr->size is too large, it can cause overflow when taking
the next attr. Here, off is used to determine the offset first to avoid problems.

Reported-and-tested-by: syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/ntfs3/record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 53629b1f65e9..a435df98c2b1 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -243,14 +243,14 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		off += asize;
 	}
 
-	asize = le32_to_cpu(attr->size);
-
 	/* Can we use the first field (attr->type). */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
 		return NULL;
 	}
 
+	asize = le32_to_cpu(attr->size);
+
 	if (attr->type == ATTR_END) {
 		/* End of enumeration. */
 		return NULL;
-- 
2.43.0


