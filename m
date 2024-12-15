Return-Path: <linux-fsdevel+bounces-37435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84C9F22E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 10:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08A116608F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 09:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7D5152166;
	Sun, 15 Dec 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ncvX0Zix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF54437A;
	Sun, 15 Dec 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734254262; cv=none; b=Mjx32/u0DDauazBlZ40ebSeuawP99Cxdq3Ix25QKZD0nMwZyxkcxQbvCFlNziEHA5wbp0/HN+rbQ9iaR40STP7aPKywS14CrcorHOGSUeSNOuJ1H5DfTZnWHdg1wfzIhX/nnQ/Xe0pDAtTT8MRfmeb2u6SGzbzO+tJTzzGtF4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734254262; c=relaxed/simple;
	bh=90lMp4bnxmYkRBBPinXYFbWXFgyPUo8c23umpPHs5RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1BfDeGpuwV94Bw1dbvKNFGFZCx8z9lJ4TBgKfE8oPsTkMbdeVLEQHtMpzPoEoViuZtJTT3V7EEwhwE4Nc62N/ZjeJI6JCHEJN1JcF8AcbvQ3oV0Po0ev+UNvjXim4haWeYNtjjkmyTxdvG5maaRpcOfivJYvR8inSJ156HW9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ncvX0Zix; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BF3rZMV022857;
	Sun, 15 Dec 2024 09:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rbs2KeWSMHh5QUqIS
	xTVc+VALG2wLP6H5PXmmKzieS4=; b=ncvX0Zix9RcVs1tsWMCc9pWZU99fHK8VH
	Xl3FJy/hJ+Nm5YQqnUwfJuO72GUXa4BNP+xLF52QUMOrhxzJasGGWcXmbPN8KSnb
	p5Pox2XYnaR8Ficvy+XTprNFgpYVImbtAz9UKIjrh6EhGvjubokCSHrCR3sf/qvG
	qxo/sFda97gUHQC6ppU+ip2FY2WeN4xhlKlnkUQYrDb3L0uIKJ8/ZtCndBecnEN3
	Q/HrPlgN9hwb2tpE98PY1ENSrHBE6xbxwMTvAF8LMZLEBoW+0dA3zvOvoNYtF7jN
	SPh4iDeGrntRUsNwIV4CwlYf85ghGgRJjO3qotvvPXGOqQW4wTqQw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hqkgrt6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BF9HYc4021988;
	Sun, 15 Dec 2024 09:17:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hqkgrt6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BF95egX014391;
	Sun, 15 Dec 2024 09:17:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq218xhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 09:17:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BF9HVXH56951090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Dec 2024 09:17:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 814E920043;
	Sun, 15 Dec 2024 09:17:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 676A120040;
	Sun, 15 Dec 2024 09:17:28 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.124.213.165])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Dec 2024 09:17:28 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/3] xfs_io: allow foreign FSes to show FS_IOC_FSGETXATTR details
Date: Sun, 15 Dec 2024 14:47:16 +0530
Message-ID: <592adf8dd6cbc469608dfde3b340c6180fdc19d3.1734253505.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: YjZBwv7NVH1IQ1y608o8lLCuH4flKOid
X-Proofpoint-ORIG-GUID: uaaZWKlB5N0K6vlihn37SUekxzqM55IE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412150076

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


