Return-Path: <linux-fsdevel+bounces-68568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D49C60A71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 20:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 421FB359ED1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 19:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B526830ACEC;
	Sat, 15 Nov 2025 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U12B8JIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D8222584;
	Sat, 15 Nov 2025 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763235568; cv=none; b=t/Kch/yZG9LVsAdc65tzQG6oUzzbC7v0P/5Yxxir47jJZ1GpTjqgxktmCfggY5fuksrN/D5EYpWTWV9IbA0hL/AWNhZRWIZR9WVRsALXQ6NiITYkg0mhPHnxfJNyB2gbOEvCk92NVrZ8/sWyDu3wwnRSAkVCz5emLpCwmiLjR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763235568; c=relaxed/simple;
	bh=dY8R29ngQR1QkG4zlqiOF7jYHIJKeBuRuHA/g9Ym/b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1lhYbww3CE2uGjEKtO7tsQe51Fv+jDKyaHCrB9hs3aIQgaLDJXc0D+UKdsVhEvDcksHbKybx/7dv7314bn2V1jJjHqRg6jG9+wgqqTYkFiHqmxlqCqiXEEzdR/LPwmb3CfZOvIwLRKNDHghABbAD1e0pIOMbPmTlt847bcoy5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U12B8JIf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFJ3htg027081;
	Sat, 15 Nov 2025 19:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gV3nJ0sh6lr7o1xcg8xHONBaTTubVkriyRpjj8c25VY=; b=
	U12B8JIfuLG/uxPU+91GyTRnXjkF64Wg1FAKAOB+Z1UViqkSBQPHvrJCVH+7TJZW
	magyUjLVeDTgUnJmko4bwRzJmTkMqD6XtA0ntcl5m9uA6XSSpt5vt9qNp+YZkuIa
	NL6szLPkTNmuo6gxi1Wj/nVnV76VzOyCSV7JORwyHSGgqg7CPzjmivGaLe26q3Yb
	kYggNben1cu8V8eXErHvgh2kXMCpqNeIfPbA9hJ6ApDycWf2Xl4hTnD6lYCPQ2Vy
	BzR7MLAKNfT0n90F2i/fptpqbpNVnL5D8mty94xvgieOVXt0oOncXxnklhsLHxVy
	g3yD04OVXVAeTgKR4H+p4w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej960eyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 19:39:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFIaCXl002532;
	Sat, 15 Nov 2025 19:17:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy68kft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 19:17:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AFJHPj2012081;
	Sat, 15 Nov 2025 19:17:26 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4aefy68kff-2;
	Sat, 15 Nov 2025 19:17:26 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/3] locks: Introduce lm_breaker_timedout operation to lease_manager_operations
Date: Sat, 15 Nov 2025 11:16:37 -0800
Message-ID: <20251115191722.3739234-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115191722.3739234-1-dai.ngo@oracle.com>
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511150159
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=6918d6df b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=S97X5fav3GynFx1AP6AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: geiWuntRGZDE4IJpe-Oum554BKkj-vOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX93b4Zv6pAvvu
 F00T8GuqKfhZ67CYA/gFSrg+Dxsw8iAVdv2sBHkhc+OPInSzCNQ8nEmPZbPyztwNqt4EtesUC2N
 dMDlWH/S3EkzanoQDVL8obBx/++xggADmA92w7xQZOE11uqNEc1FlNyHum66LE3ggVIfmP86cA9
 CfXkbqstYuLzC5uSz+W3ap48DVniEZ/PQTu9DQV3URdLTXshJqzsxhB/sYMxrfivxjQa1ohzoRB
 C7w3nJw0Ax4ojhfXvy1m1HqXc1zsasj0ekoEimJOBww8VH77IKQXKP9Y2kHb4WF7Z2lRNH1Env5
 QHHTHv/YLJOfkmykneYIzXSmxft4rwaHuFSUo5d8vJuU8yEofTSagrSf954emTATv62395nziUl
 zK6SM6rZd13uGoGgrJjB6B4Ks6UANg==
X-Proofpoint-ORIG-GUID: geiWuntRGZDE4IJpe-Oum554BKkj-vOa

Some consumers of the lease_manager_operations structure need
to perform additional actions when a lease break, triggered by
a conflict, times out.

The NFS server is the first consumer of this operation.

When a pNFS layout conflict occurs and the lease break times
out — resulting in the layout being revoked and its file lease
removed from the flc_lease list — the NFS server must issue a
fence operation. This operation ensures that the client is
prevented from accessing the data server after the layout
revocation.

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


