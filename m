Return-Path: <linux-fsdevel+bounces-68336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E23C590FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9531F4F8F14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CDB34DCFE;
	Thu, 13 Nov 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EhKk7Q9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA035BDC4;
	Thu, 13 Nov 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052066; cv=none; b=J3Z9+WxNB9d4MbCOKtvk2g+9IbDPVO2necmDl2dUqVprATMCuaR/0LJZi6Roe2KiEaAays4LPKuMHjmknkBMcO5/HcOnTE/gaj/lze8hnxqtWzcB6nLEnCmoZ5IULJN0uIJq5lLV/0gEfSvXOCBPtxYvrMcSjlbMmtZNYIzygXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052066; c=relaxed/simple;
	bh=tOYUjINfcS/OZ4aNlV6HbD9UFW6ST0HQ2u4JA7CALD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JevAz77DnR1DixfZsoScBwX77/Ja5LdEL77cuFjOMFebMkaoRM76UTuiQv9DioYa7SaGf8NcFkvMtb91Fk1jlA9+7c4h2RbRDpSfOAZZVwzcwFoyPica5gHCQk9qKUJGP337NfFSXnwyLiwpEKHIU+jbuI+lf8KBbVVeOL03sGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EhKk7Q9A; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9vUd028004;
	Thu, 13 Nov 2025 16:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xjk+f
	rohpoxtMH0m6RTPs6EJINywVkNm2blIhJq0a/c=; b=EhKk7Q9ANrAGlTlNX0Qe/
	/cQ6hQuK4a6QmEtQqrLSFDg1MBMHB/+YiLT7p/DV6ciOK0fgjRz2yD7z+h8M01OF
	itRavqQWvtWkN/93Fryjduv3G2s+54PBQpA2iPUE0r1vZHrYIkqtToHUFvbrFwEc
	14ULd1Op4vaQEiH7OPYDH0uON8fWVPzGXhmMcBI5aIMjbauXRUrQ1CLXmbnRBrKW
	NbQExM6zh9GRSDsjpmbS0SMPG/hjz7ll2297Lk9D1RGq8rKOG0A9NciG6mtOXXlD
	+a4aG8kOUVyuTZrwEmd2eh8cQbqa+AMxWyajyd4RiRPOOVb3ZYzu7sRgACNmhAR6
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjsa6yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:40:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG01wK003180;
	Thu, 13 Nov 2025 16:40:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacw509-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:40:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGenxJ039586;
	Thu, 13 Nov 2025 16:40:50 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacw4y7-2;
	Thu, 13 Nov 2025 16:40:50 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] locks: Introduce lm_breaker_timedout op to lease_manager_operations
Date: Thu, 13 Nov 2025 08:39:15 -0800
Message-ID: <20251113164043.1809156-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113164043.1809156-1-dai.ngo@oracle.com>
References: <20251113164043.1809156-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130129
X-Proofpoint-GUID: ZdzWUjz6AgOdyDFG1JhwgsjuNvdUEnSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX//7N4Fip9Z8z
 pqTeWrVqYUYknKhtJiuNwj5e92CxVH/w0u5CRXbmHonWJ9/XA/zbgHbRqFDtYAEpu8tcDSZLKJ5
 lhxKoPhes9QB8ahTiGGsTk6Tu8HcvlZeCkRznMP2VST+BAYsJJa0j345bL+ylUCHPV1gvFd/cuT
 aD88PHO2DMIaKDM0TDptqymDUoNF9mfUubEIGJh1MuyqKtnOThpomkspI5zSpw9NnCiySH+z5CY
 ZuSSf1kV/bvUmhcZPvGwjlfnUw4YpKwERy3IP1Ru3b4NLqO2fy3/ramfTHebBJCmK7VssFBRe3R
 LKcQPzkzjs2EhfVRVcnRG3VLMbzOYzQNbBMvEJ+EiLcUD3N2NmadN4V3MDqofs3heQ9Pa1Cq5ww
 8K1kn8kUIWCwPPqQU5kbW1CWxmJoVw==
X-Proofpoint-ORIG-GUID: ZdzWUjz6AgOdyDFG1JhwgsjuNvdUEnSL
X-Authority-Analysis: v=2.4 cv=HLzO14tv c=1 sm=1 tr=0 ts=69160a13 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=S97X5fav3GynFx1AP6AA:9 a=cPQSjfK2_nFv0Q5t_7PE:22

Some consumers of the lease_manager_operations need to perform additional
actions when a lease break, triggered by a conflict, times out.

The NFS server is the first consumer of this operation.

When a pNFS layout conflict occurs, and the lease break times out -
resulting in the layout being revoked and its file_lease being removed
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


