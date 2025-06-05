Return-Path: <linux-fsdevel+bounces-50751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EBBACF4A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2719D1894ADA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 16:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3718B275842;
	Thu,  5 Jun 2025 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UFdrOtmC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77C275118
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142058; cv=none; b=DRNATikXIMKRDSjLDtPaRRqeqfa+5EWsar3ms8jhhlD4vpxnsd1QiwStOe/1Ac5qtcLLdJ/b3q/RIxzQOaISbFTQ0u0MHtOt59Caj/rcACMzEYm1fmBsZN7+HqIqwy8ke8c1iQhdBh2QBznQXxDhDGAw02NYa5BcSHyc2jsHGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142058; c=relaxed/simple;
	bh=stSQhM9oiVBFvkHBqOnTa5TMAucgKidLrRfp+FKPUjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=abYNPD9BKW2cnZB6pKbLNrtp0fipCyL3NI9jjVkojP254xIwSaWGAQqNMBcZkT0rqd45mv3lSdA8FpnOBdjsuabqFYJ5ud9avvxwjYm0S90230aJgOk8FDfIGxgD+HC2R7ZV/2jxknkCJiKmbk7NLt2Dqi9zb6sLvjRnVuECWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UFdrOtmC; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250605164734epoutp0494814dd5ffb5d0d76560a2d7287d9eb5~GM25t2m-91825618256epoutp04V
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 16:47:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250605164734epoutp0494814dd5ffb5d0d76560a2d7287d9eb5~GM25t2m-91825618256epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749142054;
	bh=/pTLbwJCQHe8TTdF5U6Y1r/VKTkEZ9q9eMvSUTXAvEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFdrOtmC9JCScGIBZoQm/cXw3vYN0Xf2Clu7s3A66GjnNkVd5vtcPgrfQ/611nugp
	 cIKLcHXE9Gspf+DjCEPJ6RfM7NVTMUAtmyjPWJQ7bF/kA9n7Qq16CsD86UzIJqe75p
	 8w7DT7/QEw9V/CqJVTRyc4McBY+mHvMbOXP25QGA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250605164733epcas5p38024696e959e425b67e0db4f827e2727~GM249--5P2291822918epcas5p3S;
	Thu,  5 Jun 2025 16:47:33 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.175]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bCr380cSLz6B9m4; Thu,  5 Jun
	2025 16:47:32 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70~GLfwWHWh41133911339epcas5p11;
	Thu,  5 Jun 2025 15:07:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250605150744epsmtip1f3f92e41405a57e7ceb8f7fa9baf9b54~GLfujuGOu2783627836epsmtip12;
	Thu,  5 Jun 2025 15:07:43 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v2 2/2] fs: add ioctl to query protection info
 capabilities
Date: Thu,  5 Jun 2025 20:37:29 +0530
Message-Id: <20250605150729.2730-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250605150729.2730-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70
References: <20250605150729.2730-1-anuj20.g@samsung.com>
	<CGME20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70@epcas5p1.samsung.com>

Add a new ioctl, FS_IOC_GETPICAP, to query protection info (PI)
capabilities. This ioctl returns information about the files integrity
profile. This is useful for userspace applications to understand a files
end-to-end data protection support and configure the I/O accordingly.

For now this interface is only supported by block devices. However the
design and placement of this ioctl in generic FS ioctl space allows us
to extend it to work over files as well. This maybe useful when
filesystems start supporting  PI-aware layouts.

A new structure struct fs_pi_cap is introduced, which contains the
following fields:
1. fpc_flags: bitmask of capability flags.
2. fpc_interval: the data block interval (in bytes) for which the
protection information is generated.
3. fpc_csum type: type of checksum used.
4. fpc_metadata_size: size (in bytes) of the metadata associated with each
interval.
5. fpc_pi_size: size (in bytes) of the PI associated with each interval.
6. fpc_tag_size: size (in bytes) of tag information.
7. pi_offset: offset of protection information tuple within the
metadata.
8. fpc_ref_tag_size: size in bytes of the reference tag.
9. fpc_storage_tag_size: size in bytes of the storage tag.
10. fpc_rsvd: reserved for future use.

The internal logic to fetch the capability is encapsulated in a helper
function blk_get_pi_cap(), which uses the blk_integrity profile
associated with the device. The ioctl returns -EOPNOTSUPP, if
CONFIG_BLK_DEV_INTEGRITY is not enabled.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-integrity.c         | 41 +++++++++++++++++++++++++++++++++++
 block/ioctl.c                 |  3 +++
 include/linux/blk-integrity.h |  6 +++++
 include/uapi/linux/fs.h       | 38 ++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e4e2567061f9..8f2c3a017328 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -13,6 +13,7 @@
 #include <linux/scatterlist.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/t10-pi.h>
 
 #include "blk.h"
 
@@ -54,6 +55,46 @@ int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
 	return segments;
 }
 
+int blk_get_pi_cap(struct block_device *bdev, struct fs_pi_cap __user *argp)
+{
+	struct blk_integrity *bi = blk_get_integrity(bdev->bd_disk);
+	struct fs_pi_cap pi_cap = {};
+
+	if (!bi)
+		goto out;
+
+	if (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)
+		pi_cap.fpc_flags |= FILE_PI_CAP_INTEGRITY;
+	if (bi->flags & BLK_INTEGRITY_REF_TAG)
+		pi_cap.fpc_flags |= FILE_PI_CAP_REFTAG;
+	pi_cap.fpc_csum_type = bi->csum_type;
+	pi_cap.fpc_metadata_size = bi->tuple_size;
+	pi_cap.fpc_tag_size = bi->tag_size;
+	pi_cap.fpc_interval = 1 << bi->interval_exp;
+	pi_cap.fpc_pi_offset = bi->pi_offset;
+	pi_cap.fpc_pi_size = bi->pi_size;
+	if (bi->flags & BLK_INTEGRITY_REF_TAG) {
+		switch (bi->csum_type) {
+		case BLK_INTEGRITY_CSUM_CRC64:
+			pi_cap.fpc_ref_tag_size =
+				sizeof_field(struct crc64_pi_tuple, ref_tag);
+			break;
+		case BLK_INTEGRITY_CSUM_CRC:
+		case BLK_INTEGRITY_CSUM_IP:
+			pi_cap.fpc_ref_tag_size =
+				sizeof_field(struct t10_pi_tuple, ref_tag);
+			break;
+		default:
+			break;
+		}
+	}
+
+out:
+	if (copy_to_user(argp, &pi_cap, sizeof(struct fs_pi_cap)))
+		return -EFAULT;
+	return 0;
+}
+
 /**
  * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
  * @rq:		request to map
diff --git a/block/ioctl.c b/block/ioctl.c
index e472cc1030c6..53b35bf3e6fa 100644
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
+	case FS_IOC_GETPICAP:
+		return blk_get_pi_cap(bdev, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index c7eae0bfb013..6118a0c28605 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -29,6 +29,7 @@ int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes);
+int blk_get_pi_cap(struct block_device *bdev, struct fs_pi_cap __user *argp);
 
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -92,6 +93,11 @@ static inline struct bio_vec rq_integrity_vec(struct request *rq)
 				 rq->bio->bi_integrity->bip_iter);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
+static inline int blk_get_pi_cap(struct block_device *bdev,
+				 struct fs_pi_cap __user *argp)
+{
+	return -EOPNOTSUPP;
+}
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
 					    struct bio *b)
 {
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 0098b0ce8ccb..5557a4598a38 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -91,6 +91,42 @@ struct fs_sysfs_path {
 	__u8			name[128];
 };
 
+/* Protection info capability flags */
+#define	FILE_PI_CAP_INTEGRITY		(1 << 0)
+#define	FILE_PI_CAP_REFTAG		(1 << 1)
+
+/* Checksum types for Protection Information */
+#define FS_PI_CSUM_NONE			0
+#define FS_PI_CSUM_IP			1
+#define FS_PI_CSUM_CRC16_T10DIF		2
+#define FS_PI_CSUM_CRC64_NVME		3
+
+/*
+ * struct fs_pi_cap - protection information(PI) capability descriptor
+ * @fpc_flags:			Bitmask of capability flags
+ * @fpc_interval:		Number of bytes of data per PI tuple
+ * @fpc_csum_type:		Checksum type
+ * @fpc_metadata_size:		Size in bytes of the metadata associated with each interval
+ * @fpc_pi_size:		Size in bytes of the PI associated with each interval
+ * @fpc_tag_size:		Size of the tag area within the tuple
+ * @fpc_pi_offset:		Offset of protection information tuple within the metadata
+ * @fpc_ref_tag_size:		Size in bytes of the reference tag
+ * @fpc_storage_tag_size:	Size in bytes of the storage tag
+ * @fpc_rsvd:			Reserved for future use
+ */
+struct fs_pi_cap {
+	__u32	fpc_flags;
+	__u16	fpc_interval;
+	__u8	fpc_csum_type;
+	__u8	fpc_metadata_size;
+	__u8	fpc_pi_size;
+	__u8	fpc_tag_size;
+	__u8	fpc_pi_offset;
+	__u8	fpc_ref_tag_size;
+	__u8	fpc_storage_tag_size;
+	__u8	fpc_rsvd[19];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -247,6 +283,8 @@ struct fsxattr {
  * also /sys/kernel/debug/ for filesystems with debugfs exports
  */
 #define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
+/* Get protection info capability details */
+#define FS_IOC_GETPICAP			_IOR(0x15, 2, struct fs_pi_cap)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
-- 
2.25.1


