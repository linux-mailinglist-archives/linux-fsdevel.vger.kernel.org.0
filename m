Return-Path: <linux-fsdevel+bounces-68046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BE3C51F40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A78FD4F61A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D030DEB8;
	Wed, 12 Nov 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hyjTNEGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69A30B521;
	Wed, 12 Nov 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945648; cv=none; b=NooxkZfTMI+6WVOEhWK7aPiaHMUASC1eUQXsehLRK2naxmh4MsO/raNw3sut0YSj6lgRJ991jDhCpN7vSqCpqkdE95xdMX3emMfAemARQco8WTcv4f6oag4BkJB12kExbyE6zriidNYoqThoJ6s4mNIICpxK7RhslvMHSs1U1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945648; c=relaxed/simple;
	bh=gGhX/HF7HE1xGclbvXDnFZ1UyaqcuO4KNg2AefNw2SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/g2KB7NgvmW4yM/M29JphACYe1Yq8V46fLwHbnKS0mzWByg+48mzeoSRy86QN4bLL00t92Fi/K0QkCpOeG2OWXP/IfxIpqlK8Y7G0lW++AVAIH6w353XQpgY4UVgYZroqq0aWyM5Ua+c+CGmPTKFloq+v4NnKS8WPm6NTG6GhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hyjTNEGP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC0eJdB001349;
	Wed, 12 Nov 2025 11:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=C7FUT7CXCMJDSthjg
	LtKb/tltjvIkhsm/ZNpYvb4/Uc=; b=hyjTNEGPpK2DJ6rNqRRYGanaHkb6URVkX
	Iq0nstPA6nclATWcapf0FYw7yVKfkSEZSlBK5wKQpQ87K9u6nvQu3z0Dh/fWZaKK
	6XB3haorTbi6ijpjufEzFCSzcD8vyFv7olzEBvzlSfHU2vXyDg7cuRE8diLReUG8
	o/eSmDYrce3MjHMOpwaISKwzWXM2LfMxm3km9KYyeeaihJa/w0Ph6saHTJbwgsJH
	Rk3sCHR0+rMJNGtvbb3Sf8wclLAUOxn+0bFU+RXEijSHlddaUvTFfMlNWVmLFtiL
	EhGxZj5BK14APsyF7olxhtCFwYUkLuSVeTs2cvvBacquW6Vxz2VCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7a4r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:06:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACAuRZQ016182;
	Wed, 12 Nov 2025 11:06:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7a4r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:06:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9llv3011431;
	Wed, 12 Nov 2025 11:06:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1fe8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:06:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACB6lxv42926548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:06:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE67E2004E;
	Wed, 12 Nov 2025 11:06:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0BFC20040;
	Wed, 12 Nov 2025 11:06:42 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 11:06:42 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
        willy@infradead.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
        martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 1/8] fs: Rename STATX{_ATTR}_WRITE_ATOMIC -> STATX{_ATTR}_WRITE_ATOMIC_DIO
Date: Wed, 12 Nov 2025 16:36:04 +0530
Message-ID: <ccd33f7150973c1477fc0924562003015952c266.1762945505.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX8RHd0xysnFkm
 BTbYLiuv9HhYQymQ/qMQe3hmNZXQj9DmvwRJ4WUmYIn+bk1Cx1TFQCIXpx6ciWFUqP4oDISG7nY
 Rc36xneczqWB4hs9Hbln6io8UeB2u/2Pt4Ak0NwQLFVz0B9p75WDg4PlCXLSkR4Sguka65is/zK
 AbyNNodLBltUArzZ74FokRQwFq10fNocUgft8F4ojCuWg6EP1v8pfSWR8fDWku60JJULSWvr4dX
 gUpsN6nVKrfd3kZp67NgAYxFMCZ/tq1NHQUq5pxvCo3CymTxi8bMPJoof9rBY0MMFe6H7+NpNj2
 zAx648ue8gc1cXqjWOEpHhb4Dvl6mABiL8jsNP8ws6B14y6eqVBaPAeEpk1c+DJuciQy2FRLHGP
 J0IHig2F0o+ofuOUwX2ryZYNYicfNw==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69146a4b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=K79LtrNRiPSSlZyMgSkA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: E3J5AjRFcPVFQWLOrRVyKxfjvV2iJ8BQ
X-Proofpoint-ORIG-GUID: 4AEucmdFLFmf76SGVsvYw5hJhGMr-oLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

From: John Garry <john.g.garry@oracle.com>

This is in preparation for adding atomic write support for buffered
IO. Since the limits reported by FS for atomic write buffered IO
could be different from direct IO, rename STATX_WRITE_ATOMIC ->
STATX_WRITE_ATOMIC_DIO and STATX_ATTR_WRITE_ATOMIC ->
STATX_ATTR_WRITE_ATOMIC_DIO, to make it clear that they are only
relevant to direct IO.

Later we will add a separate flag for reporting atomic write with
buffered IO

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/filesystems/ext4/atomic_writes.rst  | 4 ++--
 block/bdev.c                                      | 4 ++--
 fs/ext4/inode.c                                   | 2 +-
 fs/stat.c                                         | 8 ++++----
 fs/xfs/xfs_iops.c                                 | 2 +-
 include/trace/misc/fs.h                           | 2 +-
 include/uapi/linux/stat.h                         | 8 ++++++--
 tools/include/uapi/linux/stat.h                   | 8 ++++++--
 tools/perf/trace/beauty/include/uapi/linux/stat.h | 8 ++++++--
 9 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
index ae8995740aa8..108c9e9cb977 100644
--- a/Documentation/filesystems/ext4/atomic_writes.rst
+++ b/Documentation/filesystems/ext4/atomic_writes.rst
@@ -189,7 +189,7 @@ The write must be aligned to the filesystem's block size and not exceed the
 filesystem's maximum atomic write unit size.
 See ``generic_atomic_write_valid()`` for more details.
 
-``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provide following
+``statx()`` system call with ``STATX_WRITE_ATOMIC_DIO`` flag can provide following
 details:
 
  * ``stx_atomic_write_unit_min``: Minimum size of an atomic write request.
@@ -198,7 +198,7 @@ details:
    separate memory buffers that can be gathered into a write operation
    (e.g., the iovcnt parameter for IOV_ITER). Currently, this is always set to one.
 
-The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
+The STATX_ATTR_WRITE_ATOMIC_DIO flag in ``statx->attributes`` is set if atomic
 writes are supported.
 
 .. _atomic_write_bdev_support:
diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..3bc90d5feb4c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1308,7 +1308,7 @@ void sync_bdevs(bool wait)
 }
 
 /*
- * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
+ * Handle STATX_{DIOALIGN, WRITE_ATOMIC_DIO} for block devices.
  */
 void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
 {
@@ -1330,7 +1330,7 @@ void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
 		stat->result_mask |= STATX_DIOALIGN;
 	}
 
-	if (request_mask & STATX_WRITE_ATOMIC && bdev_can_atomic_write(bdev)) {
+	if (request_mask & STATX_WRITE_ATOMIC_DIO && bdev_can_atomic_write(bdev)) {
 		struct request_queue *bd_queue = bdev->bd_queue;
 
 		generic_fill_statx_atomic_writes(stat,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f9e4ac87211e..9555149a8ba6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6097,7 +6097,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		}
 	}
 
-	if ((request_mask & STATX_WRITE_ATOMIC) && S_ISREG(inode->i_mode)) {
+	if ((request_mask & STATX_WRITE_ATOMIC_DIO) && S_ISREG(inode->i_mode)) {
 		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 		unsigned int awu_min = 0, awu_max = 0;
 
diff --git a/fs/stat.c b/fs/stat.c
index 6c79661e1b96..7eb2a247ab67 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -138,7 +138,7 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
  * @unit_max:	Maximum supported atomic write length in bytes
  * @unit_max_opt: Optimised maximum supported atomic write length in bytes
  *
- * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
+ * Fill in the STATX{_ATTR}_WRITE_ATOMIC_DIO flags in the kstat structure from
  * atomic write unit_min and unit_max values.
  */
 void generic_fill_statx_atomic_writes(struct kstat *stat,
@@ -147,10 +147,10 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_max_opt)
 {
 	/* Confirm that the request type is known */
-	stat->result_mask |= STATX_WRITE_ATOMIC;
+	stat->result_mask |= STATX_WRITE_ATOMIC_DIO;
 
 	/* Confirm that the file attribute type is known */
-	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
+	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC_DIO;
 
 	if (unit_min) {
 		stat->atomic_write_unit_min = unit_min;
@@ -160,7 +160,7 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 		stat->atomic_write_segments_max = 1;
 
 		/* Confirm atomic writes are actually supported */
-		stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
+		stat->attributes |= STATX_ATTR_WRITE_ATOMIC_DIO;
 	}
 }
 EXPORT_SYMBOL_GPL(generic_fill_statx_atomic_writes);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index caff0125faea..f41fcdd3043b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -741,7 +741,7 @@ xfs_vn_getattr(
 	case S_IFREG:
 		if (request_mask & (STATX_DIOALIGN | STATX_DIO_READ_ALIGN))
 			xfs_report_dioalign(ip, stat);
-		if (request_mask & STATX_WRITE_ATOMIC)
+		if (request_mask & STATX_WRITE_ATOMIC_DIO)
 			xfs_report_atomic_write(ip, stat);
 		fallthrough;
 	default:
diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
index 7ead1c61f0cb..19ea9339b9bd 100644
--- a/include/trace/misc/fs.h
+++ b/include/trace/misc/fs.h
@@ -161,5 +161,5 @@
 		{ STATX_DIOALIGN,	"DIOALIGN" },		\
 		{ STATX_MNT_ID_UNIQUE,	"MNT_ID_UNIQUE" },	\
 		{ STATX_SUBVOL,		"SUBVOL" },		\
-		{ STATX_WRITE_ATOMIC,	"WRITE_ATOMIC" },	\
+		{ STATX_WRITE_ATOMIC_DIO,	"WRITE_ATOMIC_DIO" },   \
 		{ STATX_DIO_READ_ALIGN,	"DIO_READ_ALIGN" })
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1686861aae20..57f558be933e 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -217,7 +217,9 @@ struct statx {
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
-#define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+#define STATX_WRITE_ATOMIC_DIO	0x00010000U	/* Want/got dio atomic_write_* fields */
+/* Old name kept for backward compatibility */
+#define STATX_WRITE_ATOMIC	STATX_WRITE_ATOMIC_DIO
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
@@ -254,7 +256,9 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
-#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
+#define STATX_ATTR_WRITE_ATOMIC_DIO	0x00400000 /* File supports dio atomic write operations */
+/* Old name kept for backward compatibility */
+#define STATX_ATTR_WRITE_ATOMIC	STATX_ATTR_WRITE_ATOMIC_DIO
 
 
 #endif /* _UAPI_LINUX_STAT_H */
diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 1686861aae20..57f558be933e 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -217,7 +217,9 @@ struct statx {
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
-#define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+#define STATX_WRITE_ATOMIC_DIO	0x00010000U	/* Want/got dio atomic_write_* fields */
+/* Old name kept for backward compatibility */
+#define STATX_WRITE_ATOMIC	STATX_WRITE_ATOMIC_DIO
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
@@ -254,7 +256,9 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
-#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
+#define STATX_ATTR_WRITE_ATOMIC_DIO	0x00400000 /* File supports dio atomic write operations */
+/* Old name kept for backward compatibility */
+#define STATX_ATTR_WRITE_ATOMIC	STATX_ATTR_WRITE_ATOMIC_DIO
 
 
 #endif /* _UAPI_LINUX_STAT_H */
diff --git a/tools/perf/trace/beauty/include/uapi/linux/stat.h b/tools/perf/trace/beauty/include/uapi/linux/stat.h
index 1686861aae20..57f558be933e 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/stat.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/stat.h
@@ -217,7 +217,9 @@ struct statx {
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
-#define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+#define STATX_WRITE_ATOMIC_DIO	0x00010000U	/* Want/got dio atomic_write_* fields */
+/* Old name kept for backward compatibility */
+#define STATX_WRITE_ATOMIC	STATX_WRITE_ATOMIC_DIO
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
@@ -254,7 +256,9 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
-#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
+#define STATX_ATTR_WRITE_ATOMIC_DIO	0x00400000 /* File supports dio atomic write operations */
+/* Old name kept for backward compatibility */
+#define STATX_ATTR_WRITE_ATOMIC	STATX_ATTR_WRITE_ATOMIC_DIO
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.51.0


