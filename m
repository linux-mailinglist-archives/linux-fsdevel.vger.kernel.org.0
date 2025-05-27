Return-Path: <linux-fsdevel+bounces-49904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC227AC4EB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 14:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6243AA496
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C69826989D;
	Tue, 27 May 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l6lXegh5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23854265603
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748349108; cv=none; b=WQ9+ktn9heRoFKXngYcSLcJfvS9X2A2OhP1m58rVwZcrne/9k6eyFVaj9nbge+MNMktu/Kf5jmn7TXp148j+ipROJk4j+kiYdFi37zzcrmj10tk1O1c0EwbsFt/tx3kezmtFTJCOmXzCCRt3Bmn6vZE5hCvm7Jg8PniybpTXZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748349108; c=relaxed/simple;
	bh=ngOWaqjpPJPqOinoR98VO/3tchn+oidW6yViqAZhawI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=aC1ltDTE0POZq2QL+h02cDD5Ffy2E3ZJnFAOna6lsj9Fhq8UPIc8MDlqRlogcrOO1ciDAZc6ok710ct4FbbuYCK6W0DhjBzzzzYeivhMK49uQ/Wg8oxF8BBKY50oeUUo33BmKXXoeXuVvl9zboExBC3mEzdV5EtGk1GY7BMjuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l6lXegh5; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250527123138epoutp026dcd18998b87452a8344704bde2aa9e9~DYj3oqWX81146911469epoutp02F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 12:31:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250527123138epoutp026dcd18998b87452a8344704bde2aa9e9~DYj3oqWX81146911469epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748349098;
	bh=WPc3bcceTg7LZPfb9ZGVKB7LMCBTxKzrLktdvrYguN0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=l6lXegh5BIuoIoyd/UOvLCGVA/CrIfVJF39C1/qlA90u/e8+3HcuPM+PXJCMmBn7R
	 A6PvzsGnkCsBSjmpz10SNIvAddAx/EqPom3QVz5y+yYXmcwaeb8oCwDXfYuVfWoGkS
	 jSnN8Ks10K0degMc9OzZF0Xh45Gwew6hrNlcOmcE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250527123137epcas5p35c588d070a3ac2bded5d7a0931d2cb0b~DYj3L6WeC2409724097epcas5p35;
	Tue, 27 May 2025 12:31:37 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.180]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b6Bp05KZtz6B9m4; Tue, 27 May
	2025 12:31:36 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263~DXTtsa3A61183511835epcas5p1x;
	Tue, 27 May 2025 10:59:50 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250527105950epsmtrp2d6937265278435f8b632963b5e83c658~DXTtrws3E0683706837epsmtrp2D;
	Tue, 27 May 2025 10:59:50 +0000 (GMT)
X-AuditID: b6c32a28-46cef70000001e8a-2c-68359b26c3e4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	38.68.07818.62B95386; Tue, 27 May 2025 19:59:50 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250527105948epsmtip20b0c4cb1c4bbc8c86a276c5c6f23709f~DXTsADlkt0930409304epsmtip2l;
	Tue, 27 May 2025 10:59:48 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: jack@suse.cz, anuj1072538@gmail.com, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: [RFC] fs: add ioctl to query protection info capabilities
Date: Tue, 27 May 2025 16:12:37 +0530
Message-Id: <20250527104237.2928-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvK7abNMMgzWvWS0+fv3NYtE04S+z
	xeq7/WwWrw9/YrQ4PWERk8Xs6c1MFkf/v2Wz2HtL22LP3pMsFsuP/2OyOP/3OKsDt8fOWXfZ
	PTav0PK4fLbUY9OqTjaPj09vsXj0bVnF6HFmwRF2j8+b5Dw2PXnLFMAZxWWTkpqTWZZapG+X
	wJWx7ekE1oIjuhX/9/WzNDCeUu1i5OSQEDCRmL79GGMXIxeHkMBuRonL12+wQyQkJE69XMYI
	YQtLrPz3nB2i6COjxPLzv9hAEmwC6hJHnreCdYsILGCUWH3yB1iCWaBGYvL+fWCThAWcJN7+
	mgUU5+BgEVCVWPNRFyTMK2Ah0f5uMxPEAnmJmZe+s0PEBSVOznzCAjFGXqJ562zmCYx8s5Ck
	ZiFJLWBkWsUomVpQnJuem2xYYJiXWq5XnJhbXJqXrpecn7uJERzwWho7GN99a9I/xMjEwXiI
	UYKDWUmEd9sEkwwh3pTEyqrUovz4otKc1OJDjNIcLErivCsNI9KFBNITS1KzU1MLUotgskwc
	nFINTEYOKxinFnUuT80y+VOY/72VuT/R2T12Sf6p5Pk86Qt+S5uESL2Uu/KN/6BajfUqw77v
	Si0P/FJPrjzXVMNWuFsz5kREzuEPpmFNy0T1mrN/GQpf4zK78ab6peQKq1M6ThJ7Mr+368aK
	H5yYN63Uparx0ZHdVgftLvaesWBsaT7RZhVxNs3A80CmycyV7m8FCq7tmKLq2r3fat7yWb8e
	rAzWKnW6OmHf1FS2jnje9d/m2/tfPP9J7I9Qb0zd802vq6SWpm5UkYy8mnRXKaL67Jf6mwvX
	bzjaf57zVeIdBtUzM5vYWkW36x348adx10dJU6e1avr1FUaVUfaPSnqrfh6KTb+34c2qar2d
	5ps9lFiKMxINtZiLihMB1lc9iucCAAA=
X-CMS-MailID: 20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>

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
1. flags: Bitmask of capability flags.
2. interval: the data block interval (in bytes) for which the protection
information is generated.
3. csum type: type of checksum used.
4. tuple_size: size (in bytes) of the protection information tuple.
5. tag_size: size (in bytes) of tag information.
6. pi_offset: offset of protection info within the tuple.
7. rsvd: reserved for future use.

The internal logic to fetch the capability is encapsulated in a helper
function blk_get_pi_cap(), which uses the blk_integrity profile
associated with the device. The ioctl returns -EOPNOTSUPP, if
CONFIG_BLK_DEV_INTEGRITY is not enabled.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-integrity.c         | 24 ++++++++++++++++++++++++
 block/ioctl.c                 |  3 +++
 include/linux/blk-integrity.h |  6 ++++++
 include/uapi/linux/fs.h       | 25 +++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index a1678f0a9f81..81c25b7ec1eb 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -54,6 +54,30 @@ int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
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
+		pi_cap.flags |= FILE_PI_CAP_INTEGRITY;
+	if (bi->flags & BLK_INTEGRITY_REF_TAG)
+		pi_cap.flags |= FILE_PI_CAP_REFTAG;
+	pi_cap.csum_type = bi->csum_type;
+	pi_cap.tuple_size = bi->tuple_size;
+	pi_cap.tag_size = bi->tag_size;
+	pi_cap.interval = 1 << bi->interval_exp;
+	pi_cap.pi_offset = bi->pi_offset;
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
index e762e1af650c..32383efca896 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -91,6 +91,29 @@ struct fs_sysfs_path {
 	__u8			name[128];
 };
 
+#define	FILE_PI_CAP_INTEGRITY		(1 << 0)
+#define	FILE_PI_CAP_REFTAG		(1 << 1)
+
+/*
+ * struct fs_pi_cap - protection information(PI) capability descriptor
+ * @flags:			Bitmask of capability flags
+ * @interval:			Number of bytes of data per PI tuple
+ * @csum_type:			Checksum type
+ * @tuple_size:			Size in bytes of the PI tuple
+ * @tag_size:			Size of the tag area within the tuple
+ * @pi_offset:			Offset in bytes of the PI metadata within the tuple
+ * @rsvd:			Reserved for future use
+ */
+struct fs_pi_cap {
+	__u32	flags;
+	__u16	interval;
+	__u8	csum_type;
+	__u8	tuple_size;
+	__u8	tag_size;
+	__u8	pi_offset;
+	__u8	rsvd[6];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -247,6 +270,8 @@ struct fsxattr {
  * also /sys/kernel/debug/ for filesystems with debugfs exports
  */
 #define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
+/* Get protection info capability details */
+#define FS_IOC_GETPICAP			_IOR('f', 3, struct fs_pi_cap)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
-- 
2.25.1


