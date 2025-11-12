Return-Path: <linux-fsdevel+bounces-68047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F188BC51D89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC571882652
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB0830F52B;
	Wed, 12 Nov 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CNh9saPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620EA30DD0F;
	Wed, 12 Nov 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945650; cv=none; b=K/5DVbJ+IX2hk6EA8vXd2Ia8CtBUIkqQl5xeFBrtaoEtELO04P57f2Kp6z8AC0wO5pPMv6Yio1UL3Mo6IHW32n3MsIqwCLIsXiY7EVyq9Py9YGEyvwm4hpwquvSp2VRLGuqE1U7IspsnMLDC5EicPn8dkeybEc4KIbLAClUQAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945650; c=relaxed/simple;
	bh=0hn4x7y3RdafhF+sw9aYc80jSchaY5r4idcjJCTvt+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9HtOfjeRiZt7vULaS2NfbcU7e0efB/f72ApNTer2tOkciUJYsboUAiP2xeg2RhKGeE0XdftkuQVY7PmQAP0IFvgfj8lauCMyGcmYFENzFYLoDHfmanNH9iQ42Wv1AaA2h2qQbNfgZW8nv70Wl52vMkdCAEVpd1+HCFu/FnPnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CNh9saPB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC75R3S006381;
	Wed, 12 Nov 2025 11:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mW0pKyBwlZQvck5vc
	KM5MUZDXfpxzSNxq6d+pSQ5Jas=; b=CNh9saPBrKG1sEn+nLEFZ6607f9QJOqFY
	xzJ6e/L4AJ0kSr8zGiCUnxn20Z9+LUQaZOcix6xn4RDzpb3No1ygaQ2tzY6cNjpY
	9FBW4JK8IO8pbpBpyNCoXyTfSZKqoU49nZeuj8oJu97w0A0pYvY3/9PJaz4kl8mG
	7Rum/Be0qM+X4ExAPdXqSyLo6GPi6pA+detTIWEA7YLzgF7APdp71S2lYG/Ag1Zq
	BmPJGD4VX+rWM7sW7PnLDz+N+kihcv+gdxmXtdEp6/zqwCVirG44F/us7BWbwFqF
	UXEp/lGm9tpEudTltQQ4UYB/x3Qf18pGL8AZahy9f8akFO3oh51iA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgx0q3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACB71vS031404;
	Wed, 12 Nov 2025 11:07:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgx0q39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACA6he4007314;
	Wed, 12 Nov 2025 11:07:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjfjmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACB6wtC62849296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:06:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6632F20043;
	Wed, 12 Nov 2025 11:06:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79CD120040;
	Wed, 12 Nov 2025 11:06:53 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 11:06:53 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
        willy@infradead.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
        martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 3/8] fs: Add initial buffered atomic write support info to statx
Date: Wed, 12 Nov 2025 16:36:06 +0530
Message-ID: <d304a337c17ba42092d7475ff1374bc481f72b32.1762945505.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762945505.git.ojaswin@linux.ibm.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZzKbyI_GzfEh3BUnmUWsa68tSjkRaDI7
X-Proofpoint-ORIG-GUID: LWs0wFaB3T-4QBBE3xPobpPwgyOlT-Iq
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69146a55 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=8MBPUBWLlftwMkNx52MA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX6GWhHtiOHnq9
 p0fly0Ldo2r+tn7E6bg+JHOSWHbSyNWIDjk60jmdC1D1nG3Zw8DoNsEMDo4BLsefeGHn6VhvmRF
 SxBmYmdGZLahlYcVv6fesTsVM4wCE11+M7cObL1PJmCBgYuCZwI0PxDLaF1SeOkuFaZll1YhtUS
 72BAu2QCs60XjwVx3+sY88svKkGhPNcHEpUB2t+zns+Dtaz/Ernb+FRVuyin86JkUQJ868d9Hgx
 emkigW7MiN0y4jx6XnC2aVd7Tg4KEtmdO5OKlGPYOF1sffcRqE+IksuQ0bCY3sG8GgyfHqOpfNe
 yJ1JddKMXG8VfuDkZmxb9zGQUq0gNt2KXxO/OHsDmnFL8SqngTj5yjY93CeoF/piXsVWpxjLdNA
 9Dlpjh1QjRuFNQzR6BolY68orNbofA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1011 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

Extend statx system call to return additional info for buffered atomic
write support for a file. Currently only direct IO is supported.

New flags STATX_WRITE_ATOMIC_BUF and STATX_ATTR_WRITE_ATOMIC_BUF are for
indicating whether the file knows and supports buffered atomic writes.

Structure statx members stx_atomic_write_unit_{min, max, segments_max}
will be reused for bufferd atomic writes. Flags STATX_WRITE_ATOMIC_DIO
and STATX_WRITE_ATOMIC_BUF are mutually exclusive. With both flags set,
statx will ignore the request and neither fields in statx.result_mask
will be set.

Also, make sure ext4 and xfs report atomic write unit min and max of 0
when the new flag is passed.

Co-developed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 block/bdev.c                                  |   3 +-
 fs/ext4/inode.c                               |   7 +-
 fs/stat.c                                     |  33 +++--
 fs/xfs/xfs_file.c                             |   9 +-
 fs/xfs/xfs_iops.c                             | 121 ++++++++++--------
 fs/xfs/xfs_iops.h                             |   6 +-
 include/linux/fs.h                            |   3 +-
 include/trace/misc/fs.h                       |   1 +
 include/uapi/linux/stat.h                     |   2 +
 tools/include/uapi/linux/stat.h               |   2 +
 .../trace/beauty/include/uapi/linux/stat.h    |   2 +
 11 files changed, 119 insertions(+), 70 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 3bc90d5feb4c..8f0eab0a1ecf 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1335,8 +1335,7 @@ void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
 
 		generic_fill_statx_atomic_writes(stat,
 			queue_atomic_write_unit_min_bytes(bd_queue),
-			queue_atomic_write_unit_max_bytes(bd_queue),
-			0);
+			queue_atomic_write_unit_max_bytes(bd_queue), 0, true);
 	}
 
 	stat->blksize = bdev_io_min(bdev);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9555149a8ba6..0d5013993fba 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6106,8 +6106,11 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 			awu_max = sbi->s_awu_max;
 		}
 
-		generic_fill_statx_atomic_writes(stat, awu_min, awu_max, 0);
-	}
+		generic_fill_statx_atomic_writes(stat, awu_min, awu_max, 0,
+						 true);
+	} else if (request_mask & STATX_WRITE_ATOMIC_BUF)
+		/* Atomic writes for buferred IO not supported yet */
+		generic_fill_statx_atomic_writes(stat, 0, 0, 0, false);
 
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 	if (flags & EXT4_APPEND_FL)
diff --git a/fs/stat.c b/fs/stat.c
index 7eb2a247ab67..8ba3993dcd09 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -137,20 +137,27 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
  * @unit_min:	Minimum supported atomic write length in bytes
  * @unit_max:	Maximum supported atomic write length in bytes
  * @unit_max_opt: Optimised maximum supported atomic write length in bytes
+ * @is_dio:	Is the stat request for dio
  *
- * Fill in the STATX{_ATTR}_WRITE_ATOMIC_DIO flags in the kstat structure from
- * atomic write unit_min and unit_max values.
+ * Fill in the STATX{_ATTR}_WRITE_ATOMIC_{DIO,BUF} flags in the kstat structure
+ * from atomic write unit_min and unit_max values.
  */
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
 				      unsigned int unit_max,
-				      unsigned int unit_max_opt)
+				      unsigned int unit_max_opt,
+				      bool is_dio)
 {
-	/* Confirm that the request type is known */
-	stat->result_mask |= STATX_WRITE_ATOMIC_DIO;
+	if (is_dio) {
+		/* Confirm that the request type is known */
+		stat->result_mask |= STATX_WRITE_ATOMIC_DIO;
 
-	/* Confirm that the file attribute type is known */
-	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC_DIO;
+		/* Confirm that the file attribute type is known */
+		stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC_DIO;
+	} else {
+		stat->result_mask |= STATX_WRITE_ATOMIC_BUF;
+		stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC_BUF;
+	}
 
 	if (unit_min) {
 		stat->atomic_write_unit_min = unit_min;
@@ -160,7 +167,10 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 		stat->atomic_write_segments_max = 1;
 
 		/* Confirm atomic writes are actually supported */
-		stat->attributes |= STATX_ATTR_WRITE_ATOMIC_DIO;
+		if (is_dio)
+			stat->attributes |= STATX_ATTR_WRITE_ATOMIC_DIO;
+		else
+			stat->attributes |= STATX_ATTR_WRITE_ATOMIC_BUF;
 	}
 }
 EXPORT_SYMBOL_GPL(generic_fill_statx_atomic_writes);
@@ -206,6 +216,13 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
 				  STATX_ATTR_DAX);
 
+	if (request_mask & STATX_WRITE_ATOMIC_BUF &&
+	    request_mask & STATX_WRITE_ATOMIC_DIO) {
+		/* Both are mutually exclusive, disable them */
+		request_mask &=
+			~(STATX_WRITE_ATOMIC_BUF | STATX_WRITE_ATOMIC_DIO);
+	}
+
 	idmap = mnt_idmap(path->mnt);
 	if (inode->i_op->getattr) {
 		int ret;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b9864c8582e..3efa575570ed 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1087,6 +1087,7 @@ xfs_file_write_iter(
 	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret;
 	size_t			ocount = iov_iter_count(from);
+	bool is_dio = iocb->ki_flags & IOCB_DIRECT;
 
 	XFS_STATS_INC(ip->i_mount, xs_write_calls);
 
@@ -1097,10 +1098,10 @@ xfs_file_write_iter(
 		return -EIO;
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		if (ocount < xfs_get_atomic_write_min(ip))
+		if (ocount < xfs_get_atomic_write_min(ip, is_dio))
 			return -EINVAL;
 
-		if (ocount > xfs_get_atomic_write_max(ip))
+		if (ocount > xfs_get_atomic_write_max(ip, is_dio))
 			return -EINVAL;
 
 		ret = generic_atomic_write_valid(iocb, from);
@@ -1111,7 +1112,7 @@ xfs_file_write_iter(
 	if (IS_DAX(inode))
 		return xfs_file_dax_write(iocb, from);
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
+	if (is_dio) {
 		/*
 		 * Allow a directio write to fall back to a buffered
 		 * write *only* in the case that we're doing a reflink
@@ -1568,7 +1569,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
+	if (xfs_get_atomic_write_min(XFS_I(inode), file->f_flags & O_DIRECT) > 0)
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f41fcdd3043b..f036c46b19c5 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -601,81 +601,99 @@ xfs_report_dioalign(
 
 unsigned int
 xfs_get_atomic_write_min(
-	struct xfs_inode	*ip)
+	struct xfs_inode	*ip,
+	bool			is_dio)
 {
-	struct xfs_mount	*mp = ip->i_mount;
+	if (is_dio) {
+		struct xfs_mount *mp = ip->i_mount;
 
-	/*
-	 * If we can complete an atomic write via atomic out of place writes,
-	 * then advertise a minimum size of one fsblock.  Without this
-	 * mechanism, we can only guarantee atomic writes up to a single LBA.
-	 *
-	 * If out of place writes are not available, we can guarantee an atomic
-	 * write of exactly one single fsblock if the bdev will make that
-	 * guarantee for us.
-	 */
-	if (xfs_inode_can_hw_atomic_write(ip) ||
-	    xfs_inode_can_sw_atomic_write(ip))
-		return mp->m_sb.sb_blocksize;
+		/*
+		 * If we can complete an atomic write via atomic out of place writes,
+		 * then advertise a minimum size of one fsblock.  Without this
+		 * mechanism, we can only guarantee atomic writes up to a single LBA.
+		 *
+		 * If out of place writes are not available, we can guarantee an atomic
+		 * write of exactly one single fsblock if the bdev will make that
+		 * guarantee for us.
+		 */
+		if (xfs_inode_can_hw_atomic_write(ip) ||
+		    xfs_inode_can_sw_atomic_write(ip))
+			return mp->m_sb.sb_blocksize;
+	}
 
+	/* buffered IO not supported yet so return 0 right away */
 	return 0;
 }
 
 unsigned int
 xfs_get_atomic_write_max(
-	struct xfs_inode	*ip)
+	struct xfs_inode	*ip,
+	bool			is_dio)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 
-	/*
-	 * If out of place writes are not available, we can guarantee an atomic
-	 * write of exactly one single fsblock if the bdev will make that
-	 * guarantee for us.
-	 */
-	if (!xfs_inode_can_sw_atomic_write(ip)) {
-		if (xfs_inode_can_hw_atomic_write(ip))
-			return mp->m_sb.sb_blocksize;
-		return 0;
+	if (is_dio) {
+		/*
+		 * If out of place writes are not available, we can guarantee an atomic
+		 * write of exactly one single fsblock if the bdev will make that
+		 * guarantee for us.
+		 */
+		if (!xfs_inode_can_sw_atomic_write(ip)) {
+			if (xfs_inode_can_hw_atomic_write(ip))
+				return mp->m_sb.sb_blocksize;
+			return 0;
+		}
+
+		/*
+		 * If we can complete an atomic write via atomic out of place writes,
+		 * then advertise a maximum size of whatever we can complete through
+		 * that means.  Hardware support is reported via max_opt, not here.
+		 */
+		if (XFS_IS_REALTIME_INODE(ip))
+			return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_RTG].awu_max);
+		return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_AG].awu_max);
 	}
 
-	/*
-	 * If we can complete an atomic write via atomic out of place writes,
-	 * then advertise a maximum size of whatever we can complete through
-	 * that means.  Hardware support is reported via max_opt, not here.
-	 */
-	if (XFS_IS_REALTIME_INODE(ip))
-		return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_RTG].awu_max);
-	return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_AG].awu_max);
+	/* buffered IO not supported yet so return 0 right away */
+	return 0;
 }
 
 unsigned int
 xfs_get_atomic_write_max_opt(
-	struct xfs_inode	*ip)
+	struct xfs_inode	*ip,
+	bool			is_dio)
 {
-	unsigned int		awu_max = xfs_get_atomic_write_max(ip);
+	if (is_dio) {
+		unsigned int awu_max = xfs_get_atomic_write_max(ip, is_dio);
 
-	/* if the max is 1x block, then just keep behaviour that opt is 0 */
-	if (awu_max <= ip->i_mount->m_sb.sb_blocksize)
-		return 0;
+		/* if the max is 1x block, then just keep behaviour that opt is 0 */
+		if (awu_max <= ip->i_mount->m_sb.sb_blocksize)
+			return 0;
 
-	/*
-	 * Advertise the maximum size of an atomic write that we can tell the
-	 * block device to perform for us.  In general the bdev limit will be
-	 * less than our out of place write limit, but we don't want to exceed
-	 * the awu_max.
-	 */
-	return min(awu_max, xfs_inode_buftarg(ip)->bt_awu_max);
+		/*
+		 * Advertise the maximum size of an atomic write that we can tell the
+		 * block device to perform for us.  In general the bdev limit will be
+		 * less than our out of place write limit, but we don't want to exceed
+		 * the awu_max.
+		 */
+		return min(awu_max, xfs_inode_buftarg(ip)->bt_awu_max);
+	}
+
+	/* buffered IO not supported yet so return 0 right away */
+	return 0;
 }
 
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
-	struct kstat		*stat)
+	struct kstat		*stat,
+	bool			is_dio)
 {
 	generic_fill_statx_atomic_writes(stat,
-			xfs_get_atomic_write_min(ip),
-			xfs_get_atomic_write_max(ip),
-			xfs_get_atomic_write_max_opt(ip));
+					 xfs_get_atomic_write_min(ip, is_dio),
+					 xfs_get_atomic_write_max(ip, is_dio),
+					 xfs_get_atomic_write_max_opt(ip, is_dio),
+					 is_dio);
 }
 
 STATIC int
@@ -741,8 +759,11 @@ xfs_vn_getattr(
 	case S_IFREG:
 		if (request_mask & (STATX_DIOALIGN | STATX_DIO_READ_ALIGN))
 			xfs_report_dioalign(ip, stat);
-		if (request_mask & STATX_WRITE_ATOMIC_DIO)
-			xfs_report_atomic_write(ip, stat);
+		if (request_mask &
+		    (STATX_WRITE_ATOMIC_DIO | STATX_WRITE_ATOMIC_BUF))
+			xfs_report_atomic_write(ip, stat,
+						(request_mask &
+						 STATX_WRITE_ATOMIC_DIO));
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 0896f6b8b3b8..09e79263add1 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,8 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
-unsigned int xfs_get_atomic_write_min(struct xfs_inode *ip);
-unsigned int xfs_get_atomic_write_max(struct xfs_inode *ip);
-unsigned int xfs_get_atomic_write_max_opt(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_min(struct xfs_inode *ip, bool is_dio);
+unsigned int xfs_get_atomic_write_max(struct xfs_inode *ip, bool is_dio);
+unsigned int xfs_get_atomic_write_max_opt(struct xfs_inode *ip, bool is_dio);
 
 #endif /* __XFS_IOPS_H__ */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..2dec66913e97 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3563,7 +3563,8 @@ void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
 				      unsigned int unit_max,
-				      unsigned int unit_max_opt);
+				      unsigned int unit_max_opt,
+				      bool is_dio);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
index 19ea9339b9bd..3b69910a5998 100644
--- a/include/trace/misc/fs.h
+++ b/include/trace/misc/fs.h
@@ -162,4 +162,5 @@
 		{ STATX_MNT_ID_UNIQUE,	"MNT_ID_UNIQUE" },	\
 		{ STATX_SUBVOL,		"SUBVOL" },		\
 		{ STATX_WRITE_ATOMIC_DIO,	"WRITE_ATOMIC_DIO" },   \
+		{ STATX_WRITE_ATOMIC_BUF,	"WRITE_ATOMIC_BUF" },   \
 		{ STATX_DIO_READ_ALIGN,	"DIO_READ_ALIGN" })
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 57f558be933e..2d77da04df23 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -221,6 +221,7 @@ struct statx {
 /* Old name kept for backward compatibility */
 #define STATX_WRITE_ATOMIC	STATX_WRITE_ATOMIC_DIO
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
+#define STATX_WRITE_ATOMIC_BUF	0x00040000U	/* Want/got buf-io atomic_write_* fields */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -259,6 +260,7 @@ struct statx {
 #define STATX_ATTR_WRITE_ATOMIC_DIO	0x00400000 /* File supports dio atomic write operations */
 /* Old name kept for backward compatibility */
 #define STATX_ATTR_WRITE_ATOMIC	STATX_ATTR_WRITE_ATOMIC_DIO
+#define STATX_ATTR_WRITE_ATOMIC_BUF	0x00800000 /* File supports buf-io atomic write operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 57f558be933e..a7e0036669c2 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -221,6 +221,7 @@ struct statx {
 /* Old name kept for backward compatibility */
 #define STATX_WRITE_ATOMIC	STATX_WRITE_ATOMIC_DIO
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
+#define STATX_WRITE_ATOMIC_BUF  0x00040000U	/* Want/got buf-io atomic_write_* fields */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -259,6 +260,7 @@ struct statx {
 #define STATX_ATTR_WRITE_ATOMIC_DIO	0x00400000 /* File supports dio atomic write operations */
 /* Old name kept for backward compatibility */
 #define STATX_ATTR_WRITE_ATOMIC	STATX_ATTR_WRITE_ATOMIC_DIO
+#define STATX_ATTR_WRITE_ATOMIC_BUF	0x00800000 /* File supports buf-io atomic write operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
diff --git a/tools/perf/trace/beauty/include/uapi/linux/stat.h b/tools/perf/trace/beauty/include/uapi/linux/stat.h
index 57f558be933e..2d77da04df23 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/stat.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/stat.h
@@ -221,6 +221,7 @@ struct statx {
 /* Old name kept for backward compatibility */
 #define STATX_WRITE_ATOMIC	STATX_WRITE_ATOMIC_DIO
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
+#define STATX_WRITE_ATOMIC_BUF	0x00040000U	/* Want/got buf-io atomic_write_* fields */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -259,6 +260,7 @@ struct statx {
 #define STATX_ATTR_WRITE_ATOMIC_DIO	0x00400000 /* File supports dio atomic write operations */
 /* Old name kept for backward compatibility */
 #define STATX_ATTR_WRITE_ATOMIC	STATX_ATTR_WRITE_ATOMIC_DIO
+#define STATX_ATTR_WRITE_ATOMIC_BUF	0x00800000 /* File supports buf-io atomic write operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.51.0


