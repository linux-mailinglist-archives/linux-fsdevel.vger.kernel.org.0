Return-Path: <linux-fsdevel+bounces-4402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7638C7FF241
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F46B217DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3655100C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZqBLLreS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D861FD4;
	Thu, 30 Nov 2023 05:53:57 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUCrWA3025556;
	Thu, 30 Nov 2023 13:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+KBImv1Kwt2AH4T96+jehckjTlPaL/qSymwuwqCxsAg=;
 b=ZqBLLreSH5NBgrAzh6GPuF4HceTE702NAOA9srBr+eWV7KlJXhG2VYp5UJIm5oy1bxu4
 FqdXTgFGJ5tYRmWp28M9cU6jzpPZIkCJptLE/nlDIr1xIyj5ucxwwgIChr6bx68/kgNu
 GWaY3DOwHfxSRMbF4DPBrfeMnIgN/gRbaEXv4/gCMm2rSrCxPwWiJV7VNb2t7IwtI78s
 3pA8ZuxN8BCKJJjjMpSjtUeDokCOhXO4YG0nkOjXSchbiHmVgDs7efrBrsxKfLehHRof
 xyEjbfNfhk6pbsvkUPf98R9zxDe5JHLoNzOChT5S0UwLDbJ2e1HVNnqils2vBpK5QpZ6 qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uptsv9vpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:51 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AUDVmVJ027422;
	Thu, 30 Nov 2023 13:53:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uptsv9vp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDn0vH022631;
	Thu, 30 Nov 2023 13:53:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8nxdjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUDrkVb63701370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 13:53:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9695820043;
	Thu, 30 Nov 2023 13:53:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E3A120040;
	Thu, 30 Nov 2023 13:53:44 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.76.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Nov 2023 13:53:43 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 7/7] ext4: Support atomic write for statx
Date: Thu, 30 Nov 2023 19:23:16 +0530
Message-Id: <e299f66d5b8f77c8e17970868d83fa1ff7655faa.1701339358.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1701339358.git.ojaswin@linux.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -KeN6sr_sn17w2SrVL9t35CbXj7Q8qNh
X-Proofpoint-ORIG-GUID: MXWF82-sNdeumF3xiLVzTrUYOn44tg3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300102

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size, but a
lower limit could be supported in future.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/inode.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d185ec54ffa3..c8f974d0f113 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5621,6 +5621,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct ext4_inode *raw_inode;
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	unsigned int flags;
+	struct block_device *bdev = inode->i_sb->s_bdev;
 
 	if ((request_mask & STATX_BTIME) &&
 	    EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime)) {
@@ -5639,8 +5640,6 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 		stat->result_mask |= STATX_DIOALIGN;
 		if (dio_align == 1) {
-			struct block_device *bdev = inode->i_sb->s_bdev;
-
 			/* iomap defaults */
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
@@ -5650,6 +5649,41 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		}
 	}
 
+	if ((request_mask & STATX_WRITE_ATOMIC)) {
+		unsigned int awumin, awumax;
+		unsigned int blocksize = 1 << inode->i_blkbits;
+
+		awumin = queue_atomic_write_unit_min_bytes(bdev->bd_queue);
+		awumax = queue_atomic_write_unit_max_bytes(bdev->bd_queue);
+
+		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) ||
+		    EXT4_SB(inode->i_sb)->s_cluster_ratio > 1) {
+			/*
+			 * Currently not supported for non extent files or
+			 * with bigalloc
+			 */
+			stat->atomic_write_unit_min = 0;
+			stat->atomic_write_unit_max = 0;
+		} else if (awumin && awumax) {
+			/*
+			 * For now we support atomic writes which are
+			 * at least block size bytes. If that exceeds the
+			 * max atomic unit, then don't advertise support
+			 */
+			stat->atomic_write_unit_min = max(awumin, blocksize);
+
+			if (awumax < stat->atomic_write_unit_min) {
+				stat->atomic_write_unit_min = 0;
+				stat->atomic_write_unit_max = 0;
+			} else {
+				stat->atomic_write_unit_max = awumax;
+				stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
+			}
+		}
+		stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
+		stat->result_mask |= STATX_WRITE_ATOMIC;
+	}
+
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 	if (flags & EXT4_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
-- 
2.39.3


