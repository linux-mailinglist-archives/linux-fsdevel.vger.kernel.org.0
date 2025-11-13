Return-Path: <linux-fsdevel+bounces-68404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F462C5A89A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 00:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFE55348F59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F546328B49;
	Thu, 13 Nov 2025 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nzpxdj3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61621328260;
	Thu, 13 Nov 2025 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076340; cv=none; b=dI9OIurW35j0OYCrhYwM6+dZsOrYqtgAyj7qxXZWS8tawaKm7V99/QIMhP738s6fozBzhxtu4ELFXvN6BDkhlPB53iX4V2ucnPVj8o4o+L3GwQWzlfx4XCz3J7OTKUyuY8cyK/fit6EPwml80n0zoJ6RoL8DLdAq9PwFS9RATPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076340; c=relaxed/simple;
	bh=oc1JIyFsRid3IOiTXnPkk84jA0ktjV1qwz+JfUhXB+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnO+Ud3cu5wRgb03V1RTw7iB1TALb3OZerLzq0RW2k32XNMU9AUNUzPtYh3bPNCrh4ojqc3HmCppFljCrm7rD9Vaag703QpaTkQtFvscC7rCY3LBvKQXte1ttupbZjeYQLk64J1ry7f1QRrO0bxUlzwwWhb3fFDmCtzeIdPyFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nzpxdj3u; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADMatb9007303;
	Thu, 13 Nov 2025 23:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=aWs7V
	JKsSaOVMEcMAAuxOVyeHncOQkl7ATO4O5Zphjg=; b=nzpxdj3uDV400lnEP0KUS
	OnWNjGHHpIG+EMvnuo9e+pblnY4r9rGdb3h46k9JwIwr2U3S/nBMlT5UuaAtiTYL
	tIkOv7GAEtOlrb46DC1RMWsP3q8BJ8V8wH+AUTwPZyPWy6zkNVC7zpCYgTX4Jtdo
	EaKSwIPLJVnNhmgl0xj65snY4gN7/KhpbMrG7Qepc6N365pAJ8jf9yTEAiHTL0oW
	/5/gpVgj0jPAWboCUa51OmyAB2JFJkvQEvTHC6d5fKbre1P/NTYGvoWIPdLJ+1hc
	mcZZtZUXTRbi2EqCv8SRWYrNNYaZHTGB7R/OSkDzkMACPpsp/TqR4jFncN4Q8YYs
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8r81ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 23:25:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADLWTIp039193;
	Thu, 13 Nov 2025 23:25:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacsnjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 23:25:18 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADNPGuh035130;
	Thu, 13 Nov 2025 23:25:17 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacsnhm-3;
	Thu, 13 Nov 2025 23:25:17 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/3] locks: Threads with layout conflict must wait until the client was fenced.
Date: Thu, 13 Nov 2025 15:23:01 -0800
Message-ID: <20251113232512.2066584-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113232512.2066584-1-dai.ngo@oracle.com>
References: <20251113232512.2066584-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130184
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX+BDLC/lD6u7I
 goRC1VtSdSRxPt8+zdBMKHl4VFOnvbtkzC0Cx2v7o9a/pfLYZMK2WMmGbzgEJbHteEDj6fquXsR
 RYQShyw8ouBfKCMbEjt/6HgAG/dfM9b4BojNHgfECerVDLMPLDLxXbs4A5DIAKur7T36O94f7dC
 EmbytHQ0B+V/5SD/l9O1bAt2wNytgE/xjOwMh27N/s3e8n0/HGxuHoeIHpgp6GOOrvq2plxI+/d
 6e4RV+T/GcRj9Apkpdpp8H3kGlSO68s2pgov9McTtmAlEnfiYVr8iYxzifGOnkUDL96VZNH6zgn
 ygi4ZNQJBL6Folk82BENkKFtahxs1vOdAEV1p03EcqJ66Hi2CZugYsTorFvBa2GgYcyJk4rDvdB
 7OJ5fb5BjbvbAy5tjL5+PKCGkpr2Pg==
X-Authority-Analysis: v=2.4 cv=FqEIPmrq c=1 sm=1 tr=0 ts=691668df cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=J_HfMzXWCnhenW986ukA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 21_9Ihy3uQPo7FSDH95jlclg6-0n5lBS
X-Proofpoint-GUID: 21_9Ihy3uQPo7FSDH95jlclg6-0n5lBS

If multiple threads are waiting for a layout conflict on the same
file in __break_lease, these threads must wait until one of the
waiting threads completes the fencing operation before proceeding.
This ensures that I/O operations from these threads can only occurs
after the client was fenced.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/locks.c               | 15 ++++++++++++++-
 include/linux/filelock.h |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1f254e0cd398..7840108aad71 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1609,6 +1609,10 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		error = -EWOULDBLOCK;
 		goto out;
 	}
+	if (type == FL_LAYOUT && !ctx->flc_conflict) {
+		ctx->flc_conflict = true;
+		ctx->flc_wait_for_dispose = false;
+	}
 
 restart:
 	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
@@ -1638,14 +1642,23 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		 */
 		if (error == 0)
 			time_out_leases(inode, &dispose);
-		if (any_leases_conflict(inode, new_fl))
+		if (any_leases_conflict(inode, new_fl) ||
+				(type == FL_LAYOUT && ctx->flc_wait_for_dispose))
 			goto restart;
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
+		spin_unlock(&ctx->flc_lock);
+	}
 free_lock:
 	locks_free_lease(new_fl);
 	return error;
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


