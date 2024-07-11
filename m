Return-Path: <linux-fsdevel+bounces-23596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E7592F027
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 22:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628E31C21349
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE5919E839;
	Thu, 11 Jul 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C1/NzMWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF318E20;
	Thu, 11 Jul 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728699; cv=none; b=u4GI89vjhcGz8sqPOmYg8MxseUucIRUK7CvP6dPibIrNA54rgsDStbhvAnqtXsivge4zWIGKS045Os+RCexy4eglOh2SdKe2qcskWtI/u6FaGKt5JM0FK5vUaLCoXA0Y+mtBUYjlhJVEToa/hZyNIL4ay8lvXyxxvZt2bgSzoXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728699; c=relaxed/simple;
	bh=a4IaAwMHzvt/g9ptiPrgRWeIx0HREljSiORyiBGvSl4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=I71blgCOSDCvF0WSdFtcZHG29mKDjoTQ1DCoLPmbLNWHVE3gAr3c2fVtw9DfZ4/FuAcPsb+q7DSAdZhGkJ828mLVLXjrxPP39ODh4yvCvDjFFIKVsitjAYj61HJYSiRZ3XPJSdZHfBqURHUeoY/FuDd12Z23EDlKELbh/UCHV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C1/NzMWf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BJtWjY012893;
	Thu, 11 Jul 2024 20:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=bPDFKO
	mAM620KQJrPcT369nPFBjX//sGP3qTkmP3d2A=; b=C1/NzMWfXwsRJ1co8XM3iB
	lkf/lG+JzmFYUGsIoXmOOf+nUXcRKFbCgkkQ9W+nUWmM1sWjJDFT8Hn3DDp7dcqK
	oHoFBL6IV32v5DZpQb7c8IVHbHPplYDXR0vR4kagu7Z06cBPmwgSULUEC1mlKqoq
	PsEARxP3MzilJyTF4arGpCN23HbGaP3biylgPJCydLdiV1T1bZbkAEQKoyx0FtsG
	kHkMEytnHAyEKUz6lYVwy3f/OHvak6+fbYe/GUNwK4B41jWCLmOB5zLTqLIma4Uy
	bulHu6sU1vOMP5MnUwQOhj48vpJuiJwQLhKSIPalS0EVy97ui4CGGgDYJmLAtpMw
	==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcjchj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 20:11:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BJHofv028793;
	Thu, 11 Jul 2024 20:11:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5gadw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Thu, 11 Jul 2024 20:11:33 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46BKBWkE010359;
	Thu, 11 Jul 2024 20:11:32 GMT
Received: from pp-thinkcentre-m82.us.oracle.com (dhcp-10-132-95-245.usdhcp.oraclecorp.com [10.132.95.245])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5gadb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Thu, 11 Jul 2024 20:11:32 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH] vfs: ensure mount source is set to "none" if empty string specified
Date: Thu, 11 Jul 2024 13:24:22 -0700
Message-Id: <1720729462-30935-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_14,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110140
X-Proofpoint-ORIG-GUID: XngfTtqeEw_i6NTOO5Emtq2AGre32dMl
X-Proofpoint-GUID: XngfTtqeEw_i6NTOO5Emtq2AGre32dMl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Due to changes from commit 0f89589a8c6f1033cb847a606517998efb0da8ee
mount source devname is no longer getting set to 'none' if an empty
source string is passed. Therefore /proc/<PID>/mountinfo will have a
empty string for source devname instead of 'none'.

This is due to following change in this commit
in vfs_parse_fs_string()

-       if (v_size > 0) {
+       if (value) {
                param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
                if (!param.string)
                        return -ENOMEM;
+               param.type = fs_value_is_string;
        }

That results in fc->source, which is copied from param.string, to point
to an empty string instead of it being NULL. So, alloc_vfsmnt() called
from vfs_create_mount() would be passed the empty string in fc->source
not 'none'.

This patch fix checks if fc->source is an empty string in the call to
alloc_vfsmnt() and passes 'none'.

The issue can be easily reproduced.
 #mount -t tmpfs "" /tmp/tdir
 #grep "/tmp/tdir" /proc/$$/mountinfo

With the fix
506 103 0:48 / /tmp/tdir rw,relatime shared:268 - tmpfs none rw,...

Without the fix
506 103 0:48 / /tmp/tdir rw,relatime shared:268 - tmpfs rw,...

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315..409b48c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1100,7 +1100,8 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	if (!fc->root)
 		return ERR_PTR(-EINVAL);
 
-	mnt = alloc_vfsmnt(fc->source ?: "none");
+	mnt = alloc_vfsmnt(fc->source && strlen(fc->source) > 0 ?
+			   fc->source : "none");
 	if (!mnt)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.7.4


