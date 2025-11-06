Return-Path: <linux-fsdevel+bounces-67353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49565C3CB81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 18:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80CB189796A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6965534DCE1;
	Thu,  6 Nov 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JTZR3pIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3025FA2D;
	Thu,  6 Nov 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448870; cv=none; b=gbpwSK2A4a4Jt6ed9f484SLtmTZmfiSeoas8bb8pNCMYmjUqCvns7qIsKPV/W4GSClsMCIYerrKivcqihTrbG0qXukg2bSl5OBkAnzQqsj3/61LO/krcmEhbwbed8s3/iissmyJZm2uLLnsetT7GvhZBVmw8KhQq4RQix0+NLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448870; c=relaxed/simple;
	bh=YrCTfvsppb+Z0yj6vQ4Z4iLo0XmktOIVlHarsCvbeUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cr5b3o9TjXC/mgB54FmDATkRmewAmf/kV34aazyZi0ICTCA0Yip+XpgmNxTB4wi290MRX0KQTMizfis5YRH8YB1qcz8/aXFz6aktv9lcKFsHB4R9sVnWV9VOGLatqdFcC4hhWnthKzHU6qwNgs7NVcq8+pES1BFXN9u00OtnSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JTZR3pIZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CPwxV030120;
	Thu, 6 Nov 2025 17:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ogTYW
	XmchI1Tg5JKI2yyNa9kegdnnZOybJ40fGQpHDQ=; b=JTZR3pIZFWevH4ENG6tef
	WfKuRRmI6fYOgcf8pRpE3BGqua6MmDLw9fYxV2Ci8i+i1Uk24cYFrS/IFxncnItJ
	ylJvVeYthy/asLGZ46N/prRrROJV3vm73c1zSn0C2QLl/rODlB3C8PM+PVn0AKXn
	pejQrUzofAoL+Sld5z8nr+94oX0zZL1yfsogqim8DeMYQAqDPZ0dD/p0+CeoOKwJ
	nn3cSVii45f5q92FLqF6Hy71B2YQIg55gAc5H/GMpacy3qdvWGUus2x0N4N8Yftk
	+M+cI2L0S68JpYC2K1zXDlAtSqLkx6uxnhm/OY1ff74EpB+Oz9gQKQTLDhQQftrr
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8anjjg8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:07:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6Fww6C010885;
	Thu, 6 Nov 2025 17:07:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncpaxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:07:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6H7Zxb007846;
	Thu, 6 Nov 2025 17:07:36 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58ncpav3-2;
	Thu, 06 Nov 2025 17:07:36 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] locks: Introduce lm_breaker_timedout op to lease_manager_operations
Date: Thu,  6 Nov 2025 09:05:25 -0800
Message-ID: <20251106170729.310683-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106170729.310683-1-dai.ngo@oracle.com>
References: <20251106170729.310683-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX+dx+7m2uvKb3
 SGdQ8QfSye+aZQ+77l/H6QLc0AWV60qzsEBimztmawuUc4V3u2GTW3REt3WxXmILrAR6hO6tuw7
 2RaQyFA29SYkVY3X7zN3UfbUyUHgAJPPO3al0VnhQ/8IK+VfWRHt2K20SCFvET6v86Sy9gbqRBm
 ANTILdElOE7aQmWVFYxxUIQ5/+AV3ld1TJnSG+FRR94u6Bv/YSgelUQn/BfmGPWcIVz8Z0Frlin
 o0+1FFcPo3KBu2oh9kBn4spyTgNBvsi/opS58BsL5jsFXBgI4xOh1y95OSoDhD95dGmLE4cX7O7
 S5qw8u959D655KB55bVPSnHH6m02LSnAwbz5/HHBYp1snq6EUvzFlMvpTKqkNAj2IJXpdmEF5wM
 gRAMgj7Ujm7RQsGfyyYLHNkgoT/FTQ==
X-Authority-Analysis: v=2.4 cv=dfqNHHXe c=1 sm=1 tr=0 ts=690cd5da cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=S97X5fav3GynFx1AP6AA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: kXgKXuhJM3_OIkscNE4quJqV_D19zAZR
X-Proofpoint-ORIG-GUID: kXgKXuhJM3_OIkscNE4quJqV_D19zAZR

Some consumers of the lease_manager_operations need to perform additional
actions when a lease break, triggered by a conflict, times out.

The NFS server is the first consumer of this operation.

When a pNFS layout conflict occurs, and the lease break times out -
resulting in the layout being revoked and its file_lease beeing removed
from the flc_lease list, the NFS server must issue a fence operation.
This ensures that the client is prevented from accessing the data
server after the layout is revoked.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 Documentation/filesystems/locking.rst |  2 ++
 fs/locks.c                            | 14 +++++++++++---
 include/linux/filelock.h              |  2 ++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 77704fde9845..cd600db6c4b9 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -403,6 +403,7 @@ prototypes::
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
         bool (*lm_lock_expirable)(struct file_lock *);
         void (*lm_expire_lock)(void);
+        void (*lm_breaker_timedout)(struct file_lease *);
 
 locking rules:
 
@@ -416,6 +417,7 @@ lm_change		yes		no			no
 lm_breaker_owns_lease:	yes     	no			no
 lm_lock_expirable	yes		no			no
 lm_expire_lock		no		no			yes
+lm_breaker_timedout     no              no                      yes
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e20724..1f254e0cd398 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -369,9 +369,15 @@ locks_dispose_list(struct list_head *dispose)
 	while (!list_empty(dispose)) {
 		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
 		list_del_init(&flc->flc_list);
-		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
+		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
+			if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
+				struct file_lease *fl = file_lease(flc);
+
+				if (fl->fl_lmops->lm_breaker_timedout)
+					fl->fl_lmops->lm_breaker_timedout(fl);
+			}
 			locks_free_lease(file_lease(flc));
-		else
+		} else
 			locks_free_lock(file_lock(flc));
 	}
 }
@@ -1482,8 +1488,10 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 		trace_time_out_leases(inode, fl);
 		if (past_time(fl->fl_downgrade_time))
 			lease_modify(fl, F_RDLCK, dispose);
-		if (past_time(fl->fl_break_time))
+		if (past_time(fl->fl_break_time)) {
 			lease_modify(fl, F_UNLCK, dispose);
+			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
+		}
 	}
 }
 
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index c2ce8ba05d06..06ccd6b66012 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -17,6 +17,7 @@
 #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
 #define FL_LAYOUT	2048	/* outstanding pNFS layout */
 #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
+#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
@@ -49,6 +50,7 @@ struct lease_manager_operations {
 	int (*lm_change)(struct file_lease *, int, struct list_head *);
 	void (*lm_setup)(struct file_lease *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lease *);
+	void (*lm_breaker_timedout)(struct file_lease *fl);
 };
 
 struct lock_manager {
-- 
2.47.3


