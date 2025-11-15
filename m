Return-Path: <linux-fsdevel+bounces-68566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389CC60A63
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 20:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2661C4E12AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 19:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4908E30ACF6;
	Sat, 15 Nov 2025 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EeQBIjUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704C3090F5;
	Sat, 15 Nov 2025 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763234916; cv=none; b=Qfs02XtpPD31EyqO0ZC117Xw6GSuB0AAPcaM5WCd9poosblAMNw71WxEjx0MHRMIHJOw145zJqjzKJQ9G9Qb+Y6uky2IOp7N0O9Jxf2gM8rSAQ7k33DvwIv6W8Iuvu6Qwo5x1NSaDd3Q6WYGSKDCKro4s1+NbM1nPqy5UGJDSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763234916; c=relaxed/simple;
	bh=3PJSs2pF2UONpxjIJ9fvxdOTBs2MBv5GV9S/Q2jkp1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4dvcD1rl52QoMyZ7XbC7J403WCbSva1L5rtnaA3uVu4UwThEsbymdYbDMkCk2FsHmN5GCM4blToC8N/9enArvpSjtGchiz+SDSTgxHZ7FY+nn3WPnL2i0o9mupNSXaOnrkiHarHoxmh7g9sDQ+L1/A1umhOkCFOqwb5XXsF/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EeQBIjUu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFJNQu5029324;
	Sat, 15 Nov 2025 19:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=zf7tL
	q8fCm+LGDIaN7QEUnoOq/v1wROCfyqYfZoTfmI=; b=EeQBIjUukok8or1j0GcyR
	Wl1hv7amF/FNYbYXsQb8SGlnYjxv2eNgcupkHU03mJx1cTP4FqHDaGCqoEoobPs+
	nQpK+uW1L5eXxucjTTS9DhQTEk4cVfHVO9G2lfL8I8HRtp7l89IFTiH6wmBXaFKM
	ov4zUrLljRJkNxzinPN7PYcenKdUM7mDq/I85q2UyU9sPLzQEa+o/o0jI83yKHb+
	8AbhuBZAQGExuUK2QEs7cVVuN0IAYDHoZ5OTovUn8JnTXrHvq1jJnef9+nGxktAk
	62Xs93r0Qv4j/eu4yqo11R9uYDp3foRTJPwbEItTotRDpa/c/rU0ZuA522XR+KWb
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd18ef2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 19:28:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFDJAN2002711;
	Sat, 15 Nov 2025 19:17:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy68kfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 19:17:27 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AFJHPj4012081;
	Sat, 15 Nov 2025 19:17:26 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4aefy68kff-3;
	Sat, 15 Nov 2025 19:17:26 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/3] locks: Threads with layout conflict must wait until client was fenced.
Date: Sat, 15 Nov 2025 11:16:38 -0800
Message-ID: <20251115191722.3739234-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115191722.3739234-1-dai.ngo@oracle.com>
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511150159
X-Proofpoint-GUID: -WpVk4wB4NuFTyqHcG2GAjE3U2i8F_k3
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=6918d44d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=3U65dn-wvXf3y1xs9awA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX9QDFb8Mn8gBM
 /5R7c02WNZkZOsj9rT2+C5cypejHVUObw2LT/e1jc45jFX8HWk5uLH/ZYkb+hA0XJ6Abx3aa7ap
 11Hc2cGfh9MHHJlpZFYLuXOcmDAIWxdLoQ4wYyJ2TXsqLdPhjFuQwMr+oYrXEwWp3rypbtyqcFk
 AQicaVc24f3GR4rDGVqhLDhQCCTWNOOcPHxlc3tvheQsMe80NQQso108FHvssIlDuUcHV/ZuxDz
 RCqxstFmE9CU+hS/e8pAfc3HjLiLx7TrBqdJ3q6wkRSMv9O/mphpmJ1nPm68wo6x6tmblH3AySM
 t8JN9GhB1UjXj1mnPloNgutnSLlvjakNphs8uPAp/DmgcUzqO8CLiElCvzaxzx8m/WOBIT6HOUZ
 /uUZ+PowFre/RZvdwsMG5DFquBSMSw==
X-Proofpoint-ORIG-GUID: -WpVk4wB4NuFTyqHcG2GAjE3U2i8F_k3

If multiple threads are waiting for a layout conflict on the same
file in __break_lease, these threads must wait until one of the
waiting threads completes the fencing operation before proceeding.
This ensures that I/O operations from these threads can only occurs
after the client was fenced.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/locks.c               | 24 ++++++++++++++++++++++++
 include/linux/filelock.h |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 1f254e0cd398..b6fd6aa2498c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -191,6 +191,7 @@ locks_get_lock_context(struct inode *inode, int type)
 	INIT_LIST_HEAD(&ctx->flc_flock);
 	INIT_LIST_HEAD(&ctx->flc_posix);
 	INIT_LIST_HEAD(&ctx->flc_lease);
+	init_waitqueue_head(&ctx->flc_dispose_wait);
 
 	/*
 	 * Assign the pointer if it's not already assigned. If it is, then
@@ -1609,6 +1610,10 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		error = -EWOULDBLOCK;
 		goto out;
 	}
+	if (type == FL_LAYOUT && !ctx->flc_conflict) {
+		ctx->flc_conflict = true;
+		ctx->flc_wait_for_dispose = false;
+	}
 
 restart:
 	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
@@ -1640,12 +1645,31 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 			time_out_leases(inode, &dispose);
 		if (any_leases_conflict(inode, new_fl))
 			goto restart;
+		if (type == FL_LAYOUT && ctx->flc_wait_for_dispose) {
+			/*
+			 * wait for flc_wait_for_dispose to ensure
+			 * the offending client has been fenced.
+			 */
+			spin_unlock(&ctx->flc_lock);
+			wait_event_interruptible(ctx->flc_dispose_wait,
+				ctx->flc_wait_for_dispose == false);
+			spin_lock(&ctx->flc_lock);
+		}
 		error = 0;
+		if (type == FL_LAYOUT)
+			ctx->flc_wait_for_dispose = true;
 	}
 out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 	locks_dispose_list(&dispose);
+	if (type == FL_LAYOUT) {
+		spin_lock(&ctx->flc_lock);
+		ctx->flc_wait_for_dispose = false;
+		ctx->flc_conflict = false;
+		wake_up(&ctx->flc_dispose_wait);
+		spin_unlock(&ctx->flc_lock);
+	}
 free_lock:
 	locks_free_lease(new_fl);
 	return error;
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 06ccd6b66012..5c5353aabbc8 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -146,6 +146,11 @@ struct file_lock_context {
 	struct list_head	flc_flock;
 	struct list_head	flc_posix;
 	struct list_head	flc_lease;
+
+	/* for FL_LAYOUT */
+	bool			flc_conflict;
+	bool			flc_wait_for_dispose;
+	wait_queue_head_t	flc_dispose_wait;
 };
 
 #ifdef CONFIG_FILE_LOCKING
-- 
2.47.3


