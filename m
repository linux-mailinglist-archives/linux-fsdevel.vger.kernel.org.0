Return-Path: <linux-fsdevel+bounces-37012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C4A9EC613
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3068718846DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F01F1D7998;
	Wed, 11 Dec 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UX73zzqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F91D4610;
	Wed, 11 Dec 2024 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903664; cv=none; b=bo/FTwY2fJgTfaVymkuMPt5HE/hGKJdzb1rnmvASNVkrrVUSmUobwUKfYa9R4xeapVqa3l9zlMG2h+ze90bluGPBTs9CXuruT6FR/GF2bhmXpp1m1WJXcCDLjUqdIaq8aNof+HSjDLAm37vlOgRBxxhLatE3S2j+9OoYcvBtvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903664; c=relaxed/simple;
	bh=axX8Rs8fCIAa7yHd06SvWN/1+357Te2hyqUEDYDIhK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqyL1XO5I9/YViY7eeUYg9OoA8ics8BPfFkbx9vCOOfy/0eQztH1s9tzVRJ2q5RMsHwaMWAG6PcYRcpm1ev3ymCiETHZFQ1Wy/e9X7iGWftqLKDnI+Li4nsRvfAX947rfpexNB1L9GIFAb3411da+0s/L+ILBguFeONvWGvYcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UX73zzqI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAN243s025982;
	Wed, 11 Dec 2024 07:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gNeYCLrrXrBMTdGxm
	Twjs2/qN/TjHQxLio1ngFJcVmQ=; b=UX73zzqIA8g1K4jhve1yZMmZ6JcO/DF/N
	Fmnk67EJYSGsxOse8ElQCKO52wgGSqPr6S8cjJX061fntWAkOk9hOT+qO9cDiGFM
	xAvZHpkOq09AiW70/vWVehgnsXKzzB5HjlJdJlEHlBZ1rJLaRZLkPi7aZv654+Rf
	lv3xBzPnK0oMtCjHU56Cf7BOKzxar7vra1VgruJsDQvJSRH+w+O1s+nN/EvN/Zc6
	cBmWWBi1YAx58N7AdSniEJdU1Ik7bICsdeuOYIO7pURbOh7HgqaF7Ysla4PzWE//
	MKEf05DcAF9ycnq62lJ5rAiZFktPnTW+4CzKQ6SCHGlOTy1zTM90w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqb3cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BB7sHo3002061;
	Wed, 11 Dec 2024 07:54:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqb3ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB60CkA018618;
	Wed, 11 Dec 2024 07:54:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26kg4u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB7sEJm35258876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 07:54:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86D562004B;
	Wed, 11 Dec 2024 07:54:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AB4C20040;
	Wed, 11 Dec 2024 07:54:13 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.30.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 07:54:12 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: [RFC 1/3] include/linux.h: Factor out generic platform_test_fs_fd() helper
Date: Wed, 11 Dec 2024 13:24:02 +0530
Message-ID: <5996d6854a16852daca5977063af6f2af2f0f4ca.1733902742.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1733902742.git.ojaswin@linux.ibm.com>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wPTgXinEIitIBHVsZOpmudcZ69X-d8zT
X-Proofpoint-GUID: wpuxY-BeZ4zx2yXrkJeXVphrixv6ze7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=868 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110056

Factor our the generic code to detect the FS type out of
platform_test_fs_fd(). This can then be used to detect different file
systems types based on magic number.

Also, add a helper to detect if the fd is from an ext4 filesystem.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 include/linux.h | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux.h b/include/linux.h
index e9eb7bfb26a1..52c64014c57f 100644
--- a/include/linux.h
+++ b/include/linux.h
@@ -43,13 +43,7 @@ static __inline__ int xfsctl(const char *path, int fd, int cmd, void *p)
 	return ioctl(fd, cmd, p);
 }
 
-/*
- * platform_test_xfs_*() implies that xfsctl will succeed on the file;
- * on Linux, at least, special files don't get xfs file ops,
- * so return 0 for those
- */
-
-static __inline__ int platform_test_xfs_fd(int fd)
+static __inline__ int platform_test_fs_fd(int fd, long type)
 {
 	struct statfs statfsbuf;
 	struct stat statbuf;
@@ -60,7 +54,22 @@ static __inline__ int platform_test_xfs_fd(int fd)
 		return 0;
 	if (!S_ISREG(statbuf.st_mode) && !S_ISDIR(statbuf.st_mode))
 		return 0;
-	return (statfsbuf.f_type == 0x58465342);	/* XFSB */
+	return (statfsbuf.f_type == type);
+}
+
+/*
+ * platform_test_xfs_*() implies that xfsctl will succeed on the file;
+ * on Linux, at least, special files don't get xfs file ops,
+ * so return 0 for those
+ */
+static __inline__ int platform_test_xfs_fd(int fd)
+{
+	return platform_test_fs_fd(fd, 0x58465342); /* XFSB */
+}
+
+static __inline__ int platform_test_ext4_fd(int fd)
+{
+	return platform_test_fs_fd(fd, 0xef53); /* EXT4 magic number */
 }
 
 static __inline__ int platform_test_xfs_path(const char *path)
-- 
2.43.5


