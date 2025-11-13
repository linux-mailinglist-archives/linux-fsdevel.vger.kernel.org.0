Return-Path: <linux-fsdevel+bounces-68338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EEDC5909C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA724A2CD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0730364EAA;
	Thu, 13 Nov 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hKalO9U9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721AA364E91;
	Thu, 13 Nov 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052069; cv=none; b=d7oervClUIcP9/b2/xbVSi48A0mlaTNDu/n+YGHd611Fj1MtbxjzNljHjjyNQyMtHynwclVHkpc4qfL/q42KMgofccrKKzQZQ5bfIyq7tpAAUfntCjTC5nO51jcpysqUqXOZ587RldpTfg54CP4z+AscvNSzDL2qvAp2a3qOOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052069; c=relaxed/simple;
	bh=4Rn0vCFHOxl/VzU4cOhHH6GQ0jaVdmc7ugJUND5kF+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQwlCo1OK771sgSBg/d2icVhRicdy/1edVQn/Ad+IsXH7klyX2tLqlEy5UTCtJF5tUPxG6UyYXE1u4yq4ouP0l7UyhfUcVVJI8upvvvB7FkUwSrEInVL2d85KnP7rMWTGZupx9G8p4UvsG9lJxepS/8j1aDL55BiTWtTR7SeKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hKalO9U9; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEA1JJ014807;
	Thu, 13 Nov 2025 16:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4M+ZR
	WcQlgT2VqGUHd87FWqJ9ZR7SqE1GN6V64xvi4A=; b=hKalO9U9hto5IZ0xZQOTl
	CLznFCa2ke/8bZC4QkDBEsoAwfRAv3qE/uC+xHpje7Xa/hdktyjyLv/7cV2n+y2Y
	Fahzj5i2RlQhH/TlyniTiHcCNiAD96XOTQWZc21r+e72+n8VjGbJsw4VTDmL2lUN
	4iiFjse/XCsyTq1RW/yiLRCKoFiXOCt3LDaevjI1y93q8svvHGHQOQda70l5pP1s
	pmWWzb83vRD145ZMJUjhcDk9t1Qkee4a6VaJ5/8WdWogfKQZZbanqdcoSQRMQRqt
	kLSI0gwyAugnKtDh/J/2+3flHXlhhmZLrYO9QHtdDd5gX7r/W3jM1xa5Z99N9L5O
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxwq276q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:40:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGAtae003088;
	Thu, 13 Nov 2025 16:40:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacw50v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:40:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGenxL039586;
	Thu, 13 Nov 2025 16:40:51 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacw4y7-3;
	Thu, 13 Nov 2025 16:40:51 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFSD: Fix server hang when there are multiple layout conflicts
Date: Thu, 13 Nov 2025 08:39:16 -0800
Message-ID: <20251113164043.1809156-3-dai.ngo@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfXx413xExnIwED
 700TJuTESblpWk5tFVVqZl3oF6GA/NUPIoHfqiBytbToEAZR1Pavk21PDAv7cTgiE0L01QTmsMQ
 0lpjR5A9+sy7x+hKsuCvlecAAFiWtyxlKyCiwg+aXoqrGjKTy1C2M8XotwXZ+mGUKxNGfH9Ekiw
 6dWYpGPX69KmNkLCiPQMCqqskuc8UqYIDtD7FgDUR5FPmyjbzZj2Gsbm1s5HJBKSKa0sSnuk0+J
 yo5tPLh5oQNWq5sd2cp4I43F8YUdxtRe8PLK87q2lmyNFQSiP8gjI8fjJ+d9aWWVTrMIMk53KOY
 VKW5/wj3JynyXFXiPkk5w2FRUWsrzB4VgjEtdYc4WIQdmYs3ZYY8pkK1GPfY6A+myOUmCho217i
 OjXkckSHvw9bNdl2fOtMBe6HZkGmng==
X-Proofpoint-ORIG-GUID: LbbuX_3LE0oaYbTJqARQ8m4R8sZJ7moD
X-Authority-Analysis: v=2.4 cv=RrjI7SmK c=1 sm=1 tr=0 ts=69160a14 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=JZ68toWLD79TXSsNRLAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: LbbuX_3LE0oaYbTJqARQ8m4R8sZJ7moD

When a layout conflict triggers a call to __break_lease, the function
nfsd4_layout_lm_break clears the fl_break_time timeout before sending
the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
its loop, waiting indefinitely for the conflicting file lease to be
released.

If the number of lease conflicts matches the number of NFSD threads
(which defaults to 8), all available NFSD threads become occupied.
Consequently, there are no threads left to handle incoming requests
or callback replies, leading to a total hang of the NFS server.

This issue is reliably reproducible by running the Git test suite
on a configuration using SCSI layout.

This patch addresses the problem by using the break lease timeout
and ensures that the unresponsive client is fenced, preventing it
from accessing the data server directly. Also, threads wait in
__break_lease for layout conflict must wait until one of the waiting
threads done with the fencing operation before these threads can
continue.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/locks.c               | 16 +++++++++++++++-
 fs/nfsd/nfs4layouts.c    | 25 +++++++++++++++++++++----
 include/linux/filelock.h |  2 ++
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1f254e0cd398..c4ec491e181c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1610,6 +1610,10 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		goto out;
 	}
 
+	if (type == FL_LAYOUT && !ctx->flc_conflict) {
+		ctx->flc_conflict = true;
+		ctx->flc_wait_for_dispose = false;
+	}
 restart:
 	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
 	break_time = fl->fl_break_time;
@@ -1638,14 +1642,24 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		 */
 		if (error == 0)
 			time_out_leases(inode, &dispose);
-		if (any_leases_conflict(inode, new_fl))
+		if (any_leases_conflict(inode, new_fl) ||
+			(type == FL_LAYOUT && ctx->flc_wait_for_dispose))
 			goto restart;
 		error = 0;
+		if (type == FL_LAYOUT)
+			ctx->flc_wait_for_dispose = true;
 	}
 out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 	locks_dispose_list(&dispose);
+
+	if (type == FL_LAYOUT) {
+		spin_lock(&ctx->flc_lock);
+		ctx->flc_wait_for_dispose = false;
+		ctx->flc_conflict = false;
+		spin_unlock(&ctx->flc_lock);
+	}
 free_lock:
 	locks_free_lease(new_fl);
 	return error;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 683bd1130afe..4f1388bf6e20 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -747,11 +747,10 @@ static bool
 nfsd4_layout_lm_break(struct file_lease *fl)
 {
 	/*
-	 * We don't want the locks code to timeout the lease for us;
-	 * we'll remove it ourself if a layout isn't returned
-	 * in time:
+	 * Enforce break lease timeout to prevent starvation of
+	 * NFSD threads in __break_lease that causes server to
+	 * hang.
 	 */
-	fl->fl_break_time = 0;
 	nfsd4_recall_file_layout(fl->c.flc_owner);
 	return false;
 }
@@ -764,9 +763,27 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
 	return lease_modify(onlist, arg, dispose);
 }
 
+static void nfsd_layout_breaker_timedout(struct file_lease *fl)
+{
+	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
+	struct nfsd_file *nf;
+
+	rcu_read_lock();
+	nf = nfsd_file_get(ls->ls_file);
+	rcu_read_unlock();
+	if (nf) {
+		u32 type = ls->ls_layout_type;
+
+		if (nfsd4_layout_ops[type]->fence_client)
+			nfsd4_layout_ops[type]->fence_client(ls, nf);
+		nfsd_file_put(nf);
+	}
+}
+
 static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
 	.lm_break	= nfsd4_layout_lm_break,
 	.lm_change	= nfsd4_layout_lm_change,
+	.lm_breaker_timedout	= nfsd_layout_breaker_timedout,
 };
 
 int
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 06ccd6b66012..95f489806c61 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -146,6 +146,8 @@ struct file_lock_context {
 	struct list_head	flc_flock;
 	struct list_head	flc_posix;
 	struct list_head	flc_lease;
+	bool			flc_conflict;
+	bool			flc_wait_for_dispose;
 };
 
 #ifdef CONFIG_FILE_LOCKING
-- 
2.47.3


