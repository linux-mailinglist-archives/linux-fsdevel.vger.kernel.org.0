Return-Path: <linux-fsdevel+bounces-37013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCD89EC616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1021884098
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510371D8DEA;
	Wed, 11 Dec 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ND1taurG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A21D7994;
	Wed, 11 Dec 2024 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903666; cv=none; b=TLAbhfETbRawBgDGpTrDR+bJ+4hvDc9MqGtj04mXVcAyue+WVHFUj2HOE5VPGvtMDKBnV5+4rWOV+mX/C9IURQFLVABws6Or4o3+zqW9LURLiBQa9YQ8fNvDDKVxXykfAxy7seeInEyictcAYQiUxgG3QZt2gcAsq/WifBcPzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903666; c=relaxed/simple;
	bh=R+Le9eHMyodYKLUy/sCV14U+hjz3fFLE47Hm+cEBwL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbZUTzhASRw9yKj8XTxVa0M/CKm/XIpyshHpTdvCeXULzSXsuNDSG35NEyceUt/C4lm8wyrZMqjd4dqDuknjSeN7rN8Ihy7JMz0OWBHShzN0uiIyBGsjFwhQ45ezpNsTd29ZHTYoXzZg+Lr5NABmplSVB8KCxs77/gSoio6+rT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ND1taurG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB0lUIl003941;
	Wed, 11 Dec 2024 07:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IzsxzOAcswDRsfeoR
	Iv2l8vtZ1Ep4s77VsAzBWWVcY0=; b=ND1taurG2QosRXXEU8IlCFE32XIcZTnD+
	iI+eC85puyZkEF0FzsgbLjyjMzO8p0+EzivOwpZkkVAsNIkyiV2qbnCvfoTmabNs
	YAba17CALa0TALxOXwSa98UB4xOCP84jaY91VBnH2URoeU3+xJpiRwHVNMGXb97e
	EgDec1dREd8rsik5C9EaR0lbHHP8NhhOWCKUyXKX8ShVBKE1NSLDepcWs64ooVrF
	aGG0KXOhTOw+t+Apdb+1j/ZuxSd5d9LETAcfDWxiUDsv9CeMjS1X6RwTX+gv30al
	kPr8f7gaJYFEyt+a0Mh67+bJhbRuxblWuo0In4C7i9pb+wDAHtCFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xjpw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:19 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BB7sJgJ027245;
	Wed, 11 Dec 2024 07:54:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xjpw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB7jPab017364;
	Wed, 11 Dec 2024 07:54:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1qv05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:54:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB7sG5l33096300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 07:54:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A90632004B;
	Wed, 11 Dec 2024 07:54:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8CC20040;
	Wed, 11 Dec 2024 07:54:14 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.30.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 07:54:14 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR details
Date: Wed, 11 Dec 2024 13:24:03 +0530
Message-ID: <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: zN0jENuyTW5_JS81wIx_ZUrWvrJ5PCty
X-Proofpoint-ORIG-GUID: xm7UNWL_Z6BLcgwCFZGGQdusl2_OcHhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=992
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110056

Currently with stat we only show FS_IOC_FSGETXATTR details
if the filesystem is XFS. With extsize support also coming
to ext4 make sure to show these details when -c "stat" or "statx"
is used.

No functional changes for filesystems other than ext4.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 io/stat.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/io/stat.c b/io/stat.c
index 326f2822e276..d06c2186cde4 100644
--- a/io/stat.c
+++ b/io/stat.c
@@ -97,14 +97,14 @@ print_file_info(void)
 		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
 }
 
-static void
-print_xfs_info(int verbose)
+static void print_extended_info(int verbose)
 {
-	struct dioattr	dio;
-	struct fsxattr	fsx, fsxa;
+	struct dioattr dio;
+	struct fsxattr fsx, fsxa;
+	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
 
-	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
-	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
+	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
+		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {
 		perror("FS_IOC_FSGETXATTR");
 	} else {
 		printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
@@ -113,14 +113,18 @@ print_xfs_info(int verbose)
 		printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
 		printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
 		printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);
-		printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
+		if (is_xfs_fd)
+			printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
 	}
-	if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
-		perror("XFS_IOC_DIOINFO");
-	} else {
-		printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
-		printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
-		printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
+
+	if (is_xfs_fd) {
+		if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
+			perror("XFS_IOC_DIOINFO");
+		} else {
+			printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
+			printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
+			printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
+		}
 	}
 }
 
@@ -167,10 +171,10 @@ stat_f(
 		printf(_("stat.ctime = %s"), ctime(&st.st_ctime));
 	}
 
-	if (file->flags & IO_FOREIGN)
+	if (file->flags & IO_FOREIGN && !platform_test_ext4_fd(file->fd))
 		return 0;
 
-	print_xfs_info(verbose);
+	print_extended_info(verbose);
 
 	return 0;
 }
@@ -440,10 +444,10 @@ statx_f(
 				ctime((time_t *)&stx.stx_btime.tv_sec));
 	}
 
-	if (file->flags & IO_FOREIGN)
+	if (file->flags & IO_FOREIGN && !platform_test_ext4_fd(file->fd))
 		return 0;
 
-	print_xfs_info(verbose);
+	print_extended_info(verbose);
 
 	return 0;
 }
-- 
2.43.5


