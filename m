Return-Path: <linux-fsdevel+bounces-74513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E230DD3B4E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCCBE302BF4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6738432E690;
	Mon, 19 Jan 2026 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ck8NZX8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E332D45B;
	Mon, 19 Jan 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844885; cv=none; b=l7sijJ9EYgbmOdfa9Y/UPnQmZaA9lOqeU1P/KBMcbXAsDOqEJynmUIlBKwo+JR1fN1LTp+bzayVEWoH9L1H2btqw8wZeBdXueFeFlVdH+NuhrReUgyLfA/uccWyp6N7nJGhhfpx6+lP3Igk6Uj2xUBaAttRBbP2ptqZjzbJ0jfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844885; c=relaxed/simple;
	bh=ZUUpECovZ7HPBah6ed91wvA7t2LVF4DltpXp+XFhifw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAi4Becj19mGvEZs2EwISg4UZfSiGNKmUK0PDrtTRs46HTZaNxM/+EksD3Q0ZIIF+tEmk3HA7PhEB4SXmIaSEtOXhxEsBdRCByy3+1ZJ8rPoozVwPjzao2Ud38gijZm4xFhgtyPYkBQRKf5wdeZB14cT70+gnIdDgTnEAWZCSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ck8NZX8j; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBD3c02082864;
	Mon, 19 Jan 2026 17:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=7JKrObzoAd4GSUB8D/+3df/VX9a/f
	NZlo225SAjG4Dk=; b=Ck8NZX8j1r4HE+qw6X4AumsbpLf4a3XKNeHMBLMM4tGdG
	U6GX17TQ8Nn4KmXDDGk5G86VCER1F1mMrtvAWNropiw+nZe07p/JMeLLY2hbhjTj
	6H4Mx3l/mVih9gKEWmEhdGa/lCRqKFTqoOX8o3AH+kJwrWKETbCCWv/k0ryAaDDf
	LsxLPCX9YsxueR2g6FU29LWbIpuCdCcLcVydMNuFXAMP6W/fhn7WHSEwvxV9g599
	IjhkaAC8Ud2MHiAv3oBJmEtht/Jgb+fmWCYIQQS1j0Se9Jt28d2ITZU6e3cH1mcw
	sfrXq26J4qCefsrEXPjISGvPyGnBXF0yNDOT/PJZQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2fa2kwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 17:47:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JG6Rg7018129;
	Mon, 19 Jan 2026 17:47:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8ma20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 17:47:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60JHkPgD003195;
	Mon, 19 Jan 2026 17:47:50 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4br0v8ma1v-1;
	Mon, 19 Jan 2026 17:47:50 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
Date: Mon, 19 Jan 2026 09:47:24 -0800
Message-ID: <20260119174737.3619599-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0OCBTYWx0ZWRfX4C2FUjt9cBmx
 3yNDiJOZGdYF6a3fJ/z2ehpTrmOwokKVR8bLVsRmC9H2Ed4w+I0P3VNLtZAj+i3NrYh9OkAbZCh
 eFAtbQUrPPG6z4tFc18mIABGXLJc8dPkBPxu84HK+jUzooBmsEBwxnYJmvMGYa6Qw9RxFARbBtw
 d9C34qPYJny7cF4vPvbrn3bYbWV6VOHnwDqw2C2BQtbah0o+sLcbELqKkbzT6FpH4sZ3DFBNoae
 1cxASdKTi/7/7Nqq59LIaJk+vp6Qq1pB4uzNsbf1ymTvY0YzmwChk6uGLf0r0mVpTa7SgV+JcA+
 wfxBDyo6jzm1UKfdVcMipnqEbX9qjBHJp2neip+sIJmr2IMyYpSM2bo0bD/npgqNnlnhbvmaqon
 /qDyQcj/1XBycEI0ySA2wSYuTvpKcY6LYoyr3+M1JVKA6eYnCOIlMR1BOCtyNDbS8Te8xzsM5q3
 nqM3+38eo7Z842OeDnQ==
X-Authority-Analysis: v=2.4 cv=HvB72kTS c=1 sm=1 tr=0 ts=696e6e48 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=8Zh9NNwfbLLl7sfwaKcA:9
X-Proofpoint-ORIG-GUID: AnWmBujAp765V50_byZ_CTFmeHO0kIBq
X-Proofpoint-GUID: AnWmBujAp765V50_byZ_CTFmeHO0kIBq

When a layout conflict triggers a recall, enforcing a timeout
is necessary to prevent excessive nfsd threads from being tied
up in __break_lease and ensure the server can continue servicing
incoming requests efficiently.

This patch introduces two new functions in lease_manager_operations:

1. lm_breaker_timedout: Invoked when a lease recall times out,
   allowing the lease manager to take appropriate action.

   The NFSD lease manager uses this to handle layout recall
   timeouts. If the layout type supports fencing, a fence
   operation is issued to prevent the client from accessing
   the block device.

2. lm_need_to_retry: Invoked when there is a lease conflict.
   This allows the lease manager to instruct __break_lease
   to return an error to the caller, prompting a retry of
   the conflicting operation.

   The NFSD lease manager uses this to avoid excessive nfsd
   from being blocked in __break_lease, which could hinder
   the server's ability to service incoming requests.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 Documentation/filesystems/locking.rst |  4 ++
 fs/locks.c                            | 29 +++++++++++-
 fs/nfsd/nfs4layouts.c                 | 65 +++++++++++++++++++++++++--
 include/linux/filelock.h              |  7 +++
 4 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 04c7691e50e0..ae9a1b207b95 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -403,6 +403,8 @@ prototypes::
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
         bool (*lm_lock_expirable)(struct file_lock *);
         void (*lm_expire_lock)(void);
+        void (*lm_breaker_timedout)(struct file_lease *);
+        bool (*lm_need_to_retry)(struct file_lease *, struct file_lock_context *);
 
 locking rules:
 
@@ -417,6 +419,8 @@ lm_breaker_owns_lease:	yes     	no			no
 lm_lock_expirable	yes		no			no
 lm_expire_lock		no		no			yes
 lm_open_conflict	yes		no			no
+lm_breaker_timedout     no              no                      yes
+lm_need_to_retry        yes             no                      no
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index 46f229f740c8..cd08642ab8bb 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -381,6 +381,14 @@ lease_dispose_list(struct list_head *dispose)
 	while (!list_empty(dispose)) {
 		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
 		list_del_init(&flc->flc_list);
+		if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
+			struct file_lease *fl;
+
+			fl = file_lease(flc);
+			if (fl->fl_lmops &&
+					fl->fl_lmops->lm_breaker_timedout)
+				fl->fl_lmops->lm_breaker_timedout(fl);
+		}
 		locks_free_lease(file_lease(flc));
 	}
 }
@@ -1531,8 +1539,10 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
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
 
@@ -1633,6 +1643,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
 		if (!leases_conflict(&fl->c, &new_fl->c))
 			continue;
+		if (new_fl->fl_lmops != fl->fl_lmops)
+			new_fl->fl_lmops = fl->fl_lmops;
 		if (want_write) {
 			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
 				continue;
@@ -1657,6 +1669,18 @@ int __break_lease(struct inode *inode, unsigned int flags)
 		goto out;
 	}
 
+	/*
+	 * Check whether the lease manager wants the operation
+	 * causing the conflict to be retried.
+	 */
+	if (new_fl->fl_lmops && new_fl->fl_lmops->lm_need_to_retry &&
+			new_fl->fl_lmops->lm_need_to_retry(new_fl, ctx)) {
+		trace_break_lease_noblock(inode, new_fl);
+		error = -ERESTARTSYS;
+		goto out;
+	}
+	ctx->flc_in_conflict = true;
+
 restart:
 	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
 	break_time = fl->fl_break_time;
@@ -1693,6 +1717,9 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 	lease_dispose_list(&dispose);
+	spin_lock(&ctx->flc_lock);
+	ctx->flc_in_conflict = false;
+	spin_unlock(&ctx->flc_lock);
 free_lock:
 	locks_free_lease(new_fl);
 	return error;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index ad7af8cfcf1f..e7777d6ee8d0 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -747,11 +747,9 @@ static bool
 nfsd4_layout_lm_break(struct file_lease *fl)
 {
 	/*
-	 * We don't want the locks code to timeout the lease for us;
-	 * we'll remove it ourself if a layout isn't returned
-	 * in time:
+	 * Enforce break lease timeout to prevent NFSD
+	 * thread from hanging in __break_lease.
 	 */
-	fl->fl_break_time = 0;
 	nfsd4_recall_file_layout(fl->c.flc_owner);
 	return false;
 }
@@ -782,10 +780,69 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
 	return 0;
 }
 
+/**
+ * nfsd_layout_breaker_timedout - The layout recall has timed out.
+ * If the layout type supports fence operation then do it to stop
+ * the client from accessing the block device.
+ *
+ * @fl: file to check
+ *
+ * Return value: None.
+ */
+static void
+nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
+{
+	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
+	struct nfsd_file *nf;
+	u32 type;
+
+	rcu_read_lock();
+	nf = nfsd_file_get(ls->ls_file);
+	rcu_read_unlock();
+	if (!nf)
+		return;
+	type = ls->ls_layout_type;
+	if (nfsd4_layout_ops[type]->fence_client)
+		nfsd4_layout_ops[type]->fence_client(ls, nf);
+	nfsd_file_put(nf);
+}
+
+/**
+ * nfsd4_layout_lm_conflict - Handle multiple conflicts in the same file.
+ *
+ * This function is called from __break_lease when a conflict occurs.
+ * For layout conflicts on the same file, each conflict triggers a
+ * layout  recall. Only the thread handling the first conflict needs
+ * to remain in __break_lease to manage the timeout for these recalls;
+ * subsequent threads should not wait in __break_lease.
+ *
+ * This is done to prevent excessive nfsd threads from becoming tied up
+ * in __break_lease, which could hinder the server's ability to service
+ * incoming requests.
+ *
+ * Return true if thread should not wait in __break_lease else return
+ * false.
+ */
+static bool
+nfsd4_layout_lm_retry(struct file_lease *fl,
+				struct file_lock_context *ctx)
+{
+	struct svc_rqst *rqstp;
+
+	rqstp = nfsd_current_rqst();
+	if (!rqstp)
+		return false;
+	if ((fl->c.flc_flags & FL_LAYOUT) && ctx->flc_in_conflict)
+		return true;
+	return false;
+}
+
 static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
 	.lm_break		= nfsd4_layout_lm_break,
 	.lm_change		= nfsd4_layout_lm_change,
 	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
+	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
+	.lm_need_to_retry	= nfsd4_layout_lm_retry,
 };
 
 int
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 2f5e5588ee07..6967af8b7fd2 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -17,6 +17,7 @@
 #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
 #define FL_LAYOUT	2048	/* outstanding pNFS layout */
 #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
+#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
@@ -50,6 +51,9 @@ struct lease_manager_operations {
 	void (*lm_setup)(struct file_lease *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lease *);
 	int (*lm_open_conflict)(struct file *, int);
+	void (*lm_breaker_timedout)(struct file_lease *fl);
+	bool (*lm_need_to_retry)(struct file_lease *fl,
+			struct file_lock_context *ctx);
 };
 
 struct lock_manager {
@@ -145,6 +149,9 @@ struct file_lock_context {
 	struct list_head	flc_flock;
 	struct list_head	flc_posix;
 	struct list_head	flc_lease;
+
+	/* for FL_LAYOUT */
+	bool			flc_in_conflict;
 };
 
 #ifdef CONFIG_FILE_LOCKING
-- 
2.47.3


