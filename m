Return-Path: <linux-fsdevel+bounces-37436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1263A9F22E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 10:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D41165D51
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1441714B7;
	Sun, 15 Dec 2024 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cwVwLGzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB814A604;
	Sun, 15 Dec 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734254263; cv=none; b=SjGSAnqn9DiriIDcuuleKXHuq5WL+Xr1Qbj3imuTyE0v/+K71Rv7OCfvXtm6YTSgNpG4G5wLvNtBiaNF+9xjdFk8uM8h22F4WeAOgcW7SS4IN0D5JO/bxokWEaTSBUB8E2+OxS82WfoA+eFYdL389TnLQ9pBU5QAf8fzCLRO4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734254263; c=relaxed/simple;
	bh=6aeQoPPhjSTLAIpt9Pme+pM/1AgdYlsLH520tvGJqcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLXsJJu2qwJD0DB9Zs5ruVMr1t/DaEmwFztgoBIzNx3dyAoYJ9qs1RC2e3EKa0rzUtP2qjSUe+6mkgbLjvYPTPjfb1BjqWsZ8IIIn/ZeOMttXjIbFOMeQdv2h3FOU7HkuGGHtZJNiIRaQRH9x+SNWIYp82BP4e38FbgeW1syMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cwVwLGzO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BF1k7Nt010643;
	Sun, 15 Dec 2024 09:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dlH7q3cP1NjRA0ySa
	5TB1D1j8xmoS0D2fm0YzjmNQC8=; b=cwVwLGzOlJOxTpvS1Elu0Lh1O652OiqFp
	d0060/wr6WGhOtA6zzkUSG5HpwIFTLFxV4Sg0N90NBkr2lmj+GdlyID3PRzQsoE5
	m0b0x1qRgPTjqCbcTSAYVEboDcsOZLS0p1ZkPnUkSV6BtuOt0DtHxEe8o64frnOG
	jCVPiUU6q3zlmgSYqyS0S2uDBR44OleHDjLeRszIC2iBdKPMc9kdausnFLOIrKyn
	kbrwCTmJCM0KG4mStc+ZWD8+T2fvwx9vjYKi7TDPcY51Cd/KoNaM2rJvT6XSX78w
	5Xv3xrAWwXk2uzLt8x0HZBEKt0xtebrNBo9zFdnByl94Wp4cskf0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hm5gsc5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BF9HUtT017717;
	Sun, 15 Dec 2024 09:17:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hm5gsc5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BF81T6n011249;
	Sun, 15 Dec 2024 09:17:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjjs2ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BF9HS1O57803190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Dec 2024 09:17:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F7C820043;
	Sun, 15 Dec 2024 09:17:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7024120040;
	Sun, 15 Dec 2024 09:17:26 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.124.213.165])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Dec 2024 09:17:26 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/3] include/linux.h: use linux/magic.h to get XFS_SUPER_MAGIC
Date: Sun, 15 Dec 2024 14:47:15 +0530
Message-ID: <713c4e61358b95bbdf95daca094abc73a230e52f.1734253505.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1734253505.git.ojaswin@linux.ibm.com>
References: <cover.1734253505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9O8ltBblyVW0WNvzQr2J2vvRljfqcVTS
X-Proofpoint-GUID: Sw549-82DhBEEc9dxZJb7iiU725u3-pM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=631 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412150076

This avoids open coding the magic number

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 include/linux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux.h b/include/linux.h
index e9eb7bfb26a1..306a31e092a7 100644
--- a/include/linux.h
+++ b/include/linux.h
@@ -37,6 +37,7 @@
 #endif
 #include <unistd.h>
 #include <assert.h>
+#include <linux/magic.h> /* super block magic numbers */
 
 static __inline__ int xfsctl(const char *path, int fd, int cmd, void *p)
 {
@@ -60,7 +61,7 @@ static __inline__ int platform_test_xfs_fd(int fd)
 		return 0;
 	if (!S_ISREG(statbuf.st_mode) && !S_ISDIR(statbuf.st_mode))
 		return 0;
-	return (statfsbuf.f_type == 0x58465342);	/* XFSB */
+	return (statfsbuf.f_type == XFS_SUPER_MAGIC);
 }
 
 static __inline__ int platform_test_xfs_path(const char *path)
-- 
2.43.5


