Return-Path: <linux-fsdevel+bounces-37792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291F9F7BA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 13:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42161895F09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520A225780;
	Thu, 19 Dec 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IaLZEBE6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CA22577A;
	Thu, 19 Dec 2024 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611987; cv=none; b=cdU623ACjlOuNV3D6k11S+ohxHK9unrCeCGk9mciIqsWki4JvL1d6/rylAHhsAMkx8Kp8dCg0ZrusYnEJDTa88MruUlVw5/MwiSiKCwpwscYEDmFhk1ZKqbPT5Mpp2dUeiEiA+HUVpjzMekxY0TVWFrdeRSzrPHGtTKCk6Ve8/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611987; c=relaxed/simple;
	bh=90lMp4bnxmYkRBBPinXYFbWXFgyPUo8c23umpPHs5RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMjsdu7DPiWofZx/K4SJ8ABGPYg3lMJF4pZ6UPHV3Ne49dNQ0xAxFbtWCyO8PPZTy5YnWVkU9+V9+T4kskLZYnBdQ9Bzp/vRfFOOjhUvGcvym3Zm9l6iljuL5f+mSZlEj39CMMMP6VUdqhIsbpwqwYzo9kKAJzbnqHUWmLfwk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IaLZEBE6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ0WTwT012308;
	Thu, 19 Dec 2024 12:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rbs2KeWSMHh5QUqIS
	xTVc+VALG2wLP6H5PXmmKzieS4=; b=IaLZEBE6Jh5uoIu/WaFqmm9Qx+6OLMZ39
	qbm2Z2Z5c1oYbvRnU3xsIUuOtBaGHBK6Vclz/4w3NbHeV1VPIESBLnGFw4Y/Ot/p
	ENd61mNzKMorfiYssIF7rarOE2mD2J20xfnEvstVw+aZpLMY/dNodAHb2KHaS3rs
	K+mKxg6KVvs4s9Cu0RySi8GA+7VkiMbsmEGrnZ0VL8a/AmAx0xrgF/LXKeEKUlZb
	Pd2zAMrbGlmjFeMTxoEeoZnQ3J4Xt0obyBlVpABdbi28CgDK38dwJvUkAyqDEckJ
	URD8g+PvBNs7qPzzReH0d7AI2PF8BAdQYDda9sXuuPDkqIFbSjrbw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kyv4weqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:36 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BJCUkwg004165;
	Thu, 19 Dec 2024 12:39:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kyv4weqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJBWL9V029326;
	Thu, 19 Dec 2024 12:39:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbswb4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:39:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJCdXRS60948854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 12:39:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F20120040;
	Thu, 19 Dec 2024 12:39:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CF4020043;
	Thu, 19 Dec 2024 12:39:31 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.124.219.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 12:39:31 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH v2 2/3] xfs_io: allow foreign FSes to show FS_IOC_FSGETXATTR details
Date: Thu, 19 Dec 2024 18:09:14 +0530
Message-ID: <0d572efaadc1ed7726a79c0f8cc074914f45d320.1734611784.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1734611784.git.ojaswin@linux.ibm.com>
References: <cover.1734611784.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u5JfBTabQNbqHKogWeSApIoYFvnjdL-E
X-Proofpoint-ORIG-GUID: -4JGun3iQ1ZIMbZKbfYAr4U0DUwlHhHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412190100

Currently with stat we only show FS_IOC_FSGETXATTR details if the
filesystem is XFS. With extsize support also coming to ext4 and possibly
other filesystems, make sure to allow foreign FSes to display these details
when "stat" or "statx" is used.

(Thanks to Dave for suggesting implementation of print_extended_info())

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 io/stat.c | 63 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/io/stat.c b/io/stat.c
index 326f2822e276..3ce3308d0562 100644
--- a/io/stat.c
+++ b/io/stat.c
@@ -98,30 +98,45 @@ print_file_info(void)
 }
 
 static void
-print_xfs_info(int verbose)
+print_extended_info(int verbose)
 {
-	struct dioattr	dio;
-	struct fsxattr	fsx, fsxa;
-
-	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
-	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
-		perror("FS_IOC_FSGETXATTR");
-	} else {
-		printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
-		printxattr(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
-		printf(_("fsxattr.projid = %u\n"), fsx.fsx_projid);
-		printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
-		printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
-		printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);
-		printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
+	struct dioattr dio = {};
+	struct fsxattr fsx = {}, fsxa = {};
+
+	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
+		perror("FS_IOC_GETXATTR");
+		exitcode = 1;
+		return;
 	}
+
+	printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
+	printxattr(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
+	printf(_("fsxattr.projid = %u\n"), fsx.fsx_projid);
+	printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
+	printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
+	printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);
+
+	/* Only XFS supports FS_IOC_FSGETXATTRA and XFS_IOC_DIOINFO */
+	if (file->flags & IO_FOREIGN)
+		return;
+
+	if ((ioctl(file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
+		perror("XFS_IOC_GETXATTRA");
+		exitcode = 1;
+		return;
+	}
+
+	printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
+
 	if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
 		perror("XFS_IOC_DIOINFO");
-	} else {
-		printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
-		printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
-		printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
+		exitcode = 1;
+		return;
 	}
+
+	printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
+	printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
+	printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
 }
 
 int
@@ -167,10 +182,7 @@ stat_f(
 		printf(_("stat.ctime = %s"), ctime(&st.st_ctime));
 	}
 
-	if (file->flags & IO_FOREIGN)
-		return 0;
-
-	print_xfs_info(verbose);
+	print_extended_info(verbose);
 
 	return 0;
 }
@@ -440,10 +452,7 @@ statx_f(
 				ctime((time_t *)&stx.stx_btime.tv_sec));
 	}
 
-	if (file->flags & IO_FOREIGN)
-		return 0;
-
-	print_xfs_info(verbose);
+	print_extended_info(verbose);
 
 	return 0;
 }
-- 
2.43.5


