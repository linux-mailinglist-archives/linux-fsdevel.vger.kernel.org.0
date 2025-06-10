Return-Path: <linux-fsdevel+bounces-51178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A0AD3DC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 17:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8FF168821
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A484F238C03;
	Tue, 10 Jun 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P6Ctzxc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1C238144
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570284; cv=none; b=ioCWUnqBK5fGnY70U/ITavTfKjV5DKq4n4b38U8CJQUCGJHkM0QZYLEpJOHHAx4eYcJLl4zEk6ZuypOgCSTth0/mCVtTZG8BFts3eVuppLXahWeOm5S1McUjIuk7+wIB7Z1rgPRwEpuVQEErGIv/dZakT2e14J0s4rUOSOnAre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570284; c=relaxed/simple;
	bh=Ki/D0Tl8Pv8XAiwxWoKJLHITxw/kYN5PxBkw5i4oikE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=rkTPHlEgRyWQt2wP03RBzUT+4TDkHPSkBkYjJdvl4Hvq+ZDP7tMRfMRw+chQf7bSpMtRC772et24PSWsCXd7jPL6qZsYS49qJ0Rp+hDZks9QZa4MULrZmiZ7MDxMWu/29ooH+xs4QeVanDkOap5NDztKWeFHOBLYSslZU4A4R5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=P6Ctzxc+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250610154438epoutp032cd197cddcdf80e0b17217de9795de9f~HuOYccatG0751607516epoutp03I
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 15:44:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250610154438epoutp032cd197cddcdf80e0b17217de9795de9f~HuOYccatG0751607516epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749570278;
	bh=GlAnwSu/SMQBNQbpbAQy9TOB98j2OblkwhvWTfU6qjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6Ctzxc+V4HVVSApl6YDCN4dhLutGFXIX7TewnirmVg3rqSqpJAxS7G74LBDMpVWl
	 xWLeekhlipeEBZVvfcJODoShZNc6EPK+21e+aj6PIBMuedHtQ/I2gbcYyPlhBIdlo4
	 3XADqAN0GczUT43aSkcAyXhZmjRL1BRTUgIqR65E=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250610154437epcas5p19ecd405861a7e3f338f603dc531eccc3~HuOXJ7HC02642326423epcas5p14;
	Tue, 10 Jun 2025 15:44:37 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.176]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bGtQC4VNgz2SSKY; Tue, 10 Jun
	2025 15:44:35 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250610132312epcas5p20cdd1a3119df8ffc68770f06745e8481~HsS5YPhDH1244312443epcas5p2A;
	Tue, 10 Jun 2025 13:23:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250610132310epsmtip229d1e25b5c1f5cb072479a0d2cdbc089~HsS3hMc330360903609epsmtip2P;
	Tue, 10 Jun 2025 13:23:10 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig
	<hch@lst.de>
Subject: [PATCH for-next v3 1/2] block: introduce pi_size field in
 blk_integrity
Date: Tue, 10 Jun 2025 18:52:53 +0530
Message-Id: <20250610132254.6152-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610132254.6152-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250610132312epcas5p20cdd1a3119df8ffc68770f06745e8481
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250610132312epcas5p20cdd1a3119df8ffc68770f06745e8481
References: <20250610132254.6152-1-anuj20.g@samsung.com>
	<CGME20250610132312epcas5p20cdd1a3119df8ffc68770f06745e8481@epcas5p2.samsung.com>

Introduce a new pi_size field in struct blk_integrity to explicitly
represent the size (in bytes) of the protection information (PI) tuple.
This is a prep patch.
Add validation in blk_validate_integrity_limits() to ensure that
pi_size matches the expected size for know checksum types and never
exceeds the tuple_size.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-settings.c     | 37 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c |  1 +
 drivers/scsi/sd_dif.c    |  1 +
 include/linux/blkdev.h   |  1 +
 4 files changed, 40 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..125b23acb5b7 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -14,6 +14,8 @@
 #include <linux/jiffies.h>
 #include <linux/gfp.h>
 #include <linux/dma-mapping.h>
+#include <linux/t10-pi.h>
+#include <linux/crc64.h>
 
 #include "blk.h"
 #include "blk-rq-qos.h"
@@ -135,6 +137,41 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 		return -EINVAL;
 	}
 
+	if (bi->pi_size > bi->tuple_size) {
+		pr_warn("pi_size (%u) exceeds tuple_size (%u)\n",
+						bi->pi_size, bi->tuple_size);
+		return -EINVAL;
+	}
+
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_NONE:
+		if (!bi->pi_size) {
+			pr_warn("pi_size must be 0 when checksum type \
+				 is none\n");
+			return -EINVAL;
+		}
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		if (bi->pi_size != sizeof(struct t10_pi_tuple)) {
+			pr_warn("pi_size mismatch for T10 PI: expected \
+				 %zu, got %u\n",
+				 sizeof(struct t10_pi_tuple),
+				 bi->pi_size);
+			return -EINVAL;
+		}
+		break;
+	case BLK_INTEGRITY_CSUM_CRC64:
+		if (bi->pi_size != sizeof(struct crc64_pi_tuple)) {
+			pr_warn("pi_size mismatch for CRC64 PI: \
+				 expected %zu, got %u\n",
+				 sizeof(struct crc64_pi_tuple),
+				 bi->pi_size);
+			return -EINVAL;
+		}
+		break;
+	}
+
 	if (!bi->interval_exp)
 		bi->interval_exp = ilog2(lim->logical_block_size);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f69a232a000a..a9a2a0ca9797 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1868,6 +1868,7 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	}
 
 	bi->tuple_size = head->ms;
+	bi->pi_size = head->pi_size;
 	bi->pi_offset = info->pi_offset;
 	return true;
 }
diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index ae6ce6f5d622..9c39a82298da 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -53,6 +53,7 @@ void sd_dif_config_host(struct scsi_disk *sdkp, struct queue_limits *lim)
 		bi->flags |= BLK_INTEGRITY_REF_TAG;
 
 	bi->tuple_size = sizeof(struct t10_pi_tuple);
+	bi->pi_size = bi->tuple_size;
 
 	if (dif && type) {
 		bi->flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 332b56f323d9..1ed604b70e0f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -120,6 +120,7 @@ struct blk_integrity {
 	unsigned char				pi_offset;
 	unsigned char				interval_exp;
 	unsigned char				tag_size;
+	unsigned char				pi_size;
 };
 
 typedef unsigned int __bitwise blk_mode_t;
-- 
2.25.1


