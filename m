Return-Path: <linux-fsdevel+bounces-51179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5BCAD3DCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 17:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74BF1889622
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287A52376EF;
	Tue, 10 Jun 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sHivzWGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62381238C0C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570286; cv=none; b=f1+AiGU3UdDwzqgQmyYAMWO73I4ApSNd4DmJZmWOoie39cB28DCZF4V7/DFlR4ap5+YXuj4k70wDSaxEKULKnvMin29rNal6gvy4ZDWqAQvWpr/p2js5EXOHLImjX5+MkktqWRsImJXxZwGEV4C8FmKfd/hI0PTNglqU3SkRouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570286; c=relaxed/simple;
	bh=0JAbAGuyFC4eBTahSWb568/wIDNOPS9ZfrE1eBKH34M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=SXc2JoGoFEd9Swejoqel/95vNLvks9MaHYrEADOuUwzDs9769BV3vseawtS9viT1kvBjHKUW4B1JHHgI9hc7XhcMmVLTGEZZyemqCwjgS9hZxH9ypt1GUtYguJR7LXJL0C2j8OsNRmbIr2J2XnS84vXK5ybYcon5HEOixnmbCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sHivzWGj; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250610154442epoutp010cfb5ba8fd7a8c5c7f52517cbf1500bb~HuOb47uvH1774517745epoutp013
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 15:44:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250610154442epoutp010cfb5ba8fd7a8c5c7f52517cbf1500bb~HuOb47uvH1774517745epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749570282;
	bh=AGV6hPX+hYGrogCO0YHy18HPVoLdBiStbifCZdlTe9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHivzWGjQ8QH6KrvdyBnxOrwbC2BY+zbBjRYH1ucST7VAFhOD3KW2chvvwgzlwZgh
	 ymKtimV+335oBLyy/Ozl48gmvFDzaLIq988NtRnkAASXb5hC2OnIgU7a9VKnkhPEeI
	 Je0rF7e45FOuzNFsIqSn9N0VX3+BVyNjHCF/DhkQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250610154441epcas5p12417bf279e84efd21354485b8632df05~HuObDSMF62642926429epcas5p10;
	Tue, 10 Jun 2025 15:44:41 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.176]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bGtQH5m1xz6B9m6; Tue, 10 Jun
	2025 15:44:39 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250610132317epcas5p442ce20c039224fb691ab0ba03fcb21e7~HsS9wH2Ug3202032020epcas5p4Z;
	Tue, 10 Jun 2025 13:23:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250610132315epsmtip2af61efba414d3408e1a09ddfc64a1b24~HsS7-lpZD0336803368epsmtip2Z;
	Tue, 10 Jun 2025 13:23:15 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v3 2/2] fs: add ioctl to query metadata and
 protection info capabilities
Date: Tue, 10 Jun 2025 18:52:54 +0530
Message-Id: <20250610132254.6152-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610132254.6152-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250610132317epcas5p442ce20c039224fb691ab0ba03fcb21e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250610132317epcas5p442ce20c039224fb691ab0ba03fcb21e7
References: <20250610132254.6152-1-anuj20.g@samsung.com>
	<CGME20250610132317epcas5p442ce20c039224fb691ab0ba03fcb21e7@epcas5p4.samsung.com>

Add a new ioctl, FS_IOC_GETLBMD_CAP, to query metadata and protection
info (PI) capabilities. This ioctl returns information about the files
integrity profile. This is useful for userspace applications to
understand a files end-to-end data protection support and configure the
I/O accordingly.

For now this interface is only supported by block devices. However the
design and placement of this ioctl in generic FS ioctl space allows us
to extend it to work over files as well. This maybe useful when
filesystems start supporting  PI-aware layouts.

A new structure struct logical_block_metadata_cap is introduced, which
contains the following fields:

1. lbmd_flags: bitmask of logical block metadata capability flags
2. lbmd_interval: the amount of data described by each unit of logical
block metadata
3. lbmd_size: size in bytes of the logical block metadata associated
with each interval
4. lbmd_opaque_size: size in bytes of the opaque block tag associated
with each interval
5. lbmd_opaque_offset: offset in bytes of the opaque block tag within
the logical block metadata
6. lbmd_pi_size: size in bytes of the T10 PI tuple associated with each
interval
7. lbmd_pi_offset: offset in bytes of T10 PI tuple within the logical
block metadata
8. lbmd_pi_guard_tag_type: T10 PI guard tag type
9. lbmd_pi_app_tag_size: size in bytes of the T10 PI application tag
10. lbmd_pi_ref_tag_size: size in bytes of the T10 PI reference tag
11. lbmd_pi_storage_tag_size: size in bytes of the T10 PI storage tag
12. lbmd_rsvd: reserved for future use

The internal logic to fetch the capability is encapsulated in a helper
function blk_get_meta_cap(), which uses the blk_integrity profile
associated with the device. The ioctl returns -EOPNOTSUPP, if
CONFIG_BLK_DEV_INTEGRITY is not enabled.

Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-integrity.c         | 53 +++++++++++++++++++++++++++++++++++
 block/ioctl.c                 |  3 ++
 include/linux/blk-integrity.h |  7 +++++
 include/uapi/linux/fs.h       | 43 ++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e4e2567061f9..f9ad5bdb84f5 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -13,6 +13,7 @@
 #include <linux/scatterlist.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/t10-pi.h>
 
 #include "blk.h"
 
@@ -54,6 +55,58 @@ int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
 	return segments;
 }
 
+int blk_get_meta_cap(struct block_device *bdev,
+		     struct logical_block_metadata_cap __user *argp)
+{
+	struct blk_integrity *bi = blk_get_integrity(bdev->bd_disk);
+	struct logical_block_metadata_cap meta_cap = {};
+
+	if (!bi)
+		goto out;
+
+	if (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)
+		meta_cap.lbmd_flags |= LBMD_PI_CAP_INTEGRITY;
+	if (bi->flags & BLK_INTEGRITY_REF_TAG)
+		meta_cap.lbmd_flags |= LBMD_PI_CAP_REFTAG;
+	meta_cap.lbmd_interval = 1 << bi->interval_exp;
+	meta_cap.lbmd_size = bi->tuple_size;
+	if (bi->csum_type == BLK_INTEGRITY_CSUM_NONE) {
+		/* treat entire tuple as opaque block tag */
+		meta_cap.lbmd_opaque_size = bi->tuple_size;
+		goto out;
+	}
+	meta_cap.lbmd_pi_size = bi->pi_size;
+	meta_cap.lbmd_pi_offset = bi->pi_offset;
+	meta_cap.lbmd_opaque_size = bi->tuple_size - bi->pi_size;
+	if (meta_cap.lbmd_opaque_size && !bi->pi_offset)
+		meta_cap.lbmd_opaque_offset = bi->pi_size;
+
+	meta_cap.lbmd_guard_tag_type = bi->csum_type;
+	meta_cap.lbmd_app_tag_size = 2;
+
+	if (bi->flags & BLK_INTEGRITY_REF_TAG) {
+		switch (bi->csum_type) {
+		case BLK_INTEGRITY_CSUM_CRC64:
+			meta_cap.lbmd_ref_tag_size =
+				sizeof_field(struct crc64_pi_tuple, ref_tag);
+			break;
+		case BLK_INTEGRITY_CSUM_CRC:
+		case BLK_INTEGRITY_CSUM_IP:
+			meta_cap.lbmd_ref_tag_size =
+				sizeof_field(struct t10_pi_tuple, ref_tag);
+			break;
+		default:
+			break;
+		}
+	}
+
+out:
+	if (copy_to_user(argp, &meta_cap,
+			 sizeof(struct logical_block_metadata_cap)))
+		return -EFAULT;
+	return 0;
+}
+
 /**
  * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
  * @rq:		request to map
diff --git a/block/ioctl.c b/block/ioctl.c
index e472cc1030c6..19782f7b5ff1 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -13,6 +13,7 @@
 #include <linux/uaccess.h>
 #include <linux/pagemap.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/blk-integrity.h>
 #include <uapi/linux/blkdev.h>
 #include "blk.h"
 #include "blk-crypto-internal.h"
@@ -643,6 +644,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return blkdev_pr_preempt(bdev, mode, argp, true);
 	case IOC_PR_CLEAR:
 		return blkdev_pr_clear(bdev, mode, argp);
+	case FS_IOC_GETLBMD_CAP:
+		return blk_get_meta_cap(bdev, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index c7eae0bfb013..b4aff4dff843 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -29,6 +29,8 @@ int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes);
+int blk_get_meta_cap(struct block_device *bdev,
+		     struct logical_block_metadata_cap __user *argp);
 
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -92,6 +94,11 @@ static inline struct bio_vec rq_integrity_vec(struct request *rq)
 				 rq->bio->bi_integrity->bip_iter);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
+static inline int blk_get_meta_cap(struct block_device *bdev,
+				   struct logical_block_metadata_cap __user *argp)
+{
+	return -EOPNOTSUPP;
+}
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
 					    struct bio *b)
 {
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 0098b0ce8ccb..70350d5a4cd6 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -91,6 +91,47 @@ struct fs_sysfs_path {
 	__u8			name[128];
 };
 
+/* Protection info capability flags */
+#define	LBMD_PI_CAP_INTEGRITY		(1 << 0)
+#define	LBMD_PI_CAP_REFTAG		(1 << 1)
+
+/* Checksum types for Protection Information */
+#define LBMD_PI_CSUM_NONE		0
+#define LBMD_PI_CSUM_IP			1
+#define LBMD_PI_CSUM_CRC16_T10DIF	2
+#define LBMD_PI_CSUM_CRC64_NVME		4
+
+/*
+ * struct logical_block_metadata_cap - Logical block metadata
+ * @lbmd_flags:			Bitmask of logical block metadata capability flags
+ * @lbmd_interval:		The amount of data described by each unit of logical block metadata
+ * @lbmd_size:			Size in bytes of the logical block metadata associated with each interval
+ * @lbmd_opaque_size:		Size in bytes of the opaque block tag associated with each interval
+ * @lbmd_opaque_offset:		Offset in bytes of the opaque block tag within the logical block metadata
+ * @lbmd_pi_size:		Size in bytes of the T10 PI tuple associated with each interval
+ * @lbmd_pi_offset:		Offset in bytes of T10 PI tuple within the logical block metadata
+ * @lbmd_pi_guard_tag_type:	T10 PI guard tag type
+ * @lbmd_pi_app_tag_size:	Size in bytes of the T10 PI application tag
+ * @lbmd_pi_ref_tag_size:	Size in bytes of the T10 PI reference tag
+ * @lbmd_pi_storage_tag_size:	Size in bytes of the T10 PI storage tag
+ * @lbmd_rsvd:			Reserved for future use
+ */
+
+struct logical_block_metadata_cap {
+	__u32	lbmd_flags;
+	__u16	lbmd_interval;
+	__u8	lbmd_size;
+	__u8	lbmd_opaque_size;
+	__u8	lbmd_opaque_offset;
+	__u8	lbmd_pi_size;
+	__u8	lbmd_pi_offset;
+	__u8	lbmd_guard_tag_type;
+	__u8	lbmd_app_tag_size;
+	__u8	lbmd_ref_tag_size;
+	__u8	lbmd_storage_tag_size;
+	__u8	lbmd_rsvd[17];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -247,6 +288,8 @@ struct fsxattr {
  * also /sys/kernel/debug/ for filesystems with debugfs exports
  */
 #define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
+/* Get logical block metadata capability details */
+#define FS_IOC_GETLBMD_CAP		_IOR(0x15, 2, struct logical_block_metadata_cap)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
-- 
2.25.1


