Return-Path: <linux-fsdevel+bounces-44280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1385A66C87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F647A187F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F8207E05;
	Tue, 18 Mar 2025 07:44:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD827204F99;
	Tue, 18 Mar 2025 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283860; cv=none; b=qzbFEkNAe6JgsrgNQ0BO9Z59nS1x7R7INlH26DvWmBBkO+fPBccZr9apcbm6ZpEbEuTrisJUAX1Uc0lliqnj6Cb/HtQ7bvN9UCOHBSwq/vhcKGYwT70mv56o5Jv5aebP1p0xkCgUVfc8boqsNbQbp188EyaPlAQq5MdA3PP16F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283860; c=relaxed/simple;
	bh=2E54SF8d1nfV3iPq0LJfs0ecdIL7mOwEMENHD8Jhp4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH2GH1c5ltLSxgx//DSMjWdEMV1XkKY0pM5nMQahWbfjXPTU9HhJ87qf+Yefk0PAq7Mh0HSdpX2ZnXm5ti2Sj6Kgr92iZG5TzuseH1h5Wjx20q4I7p0r6Gvmu8wKu+LtqvhSe3v48etX1pHZhekJgIDcvH0xSceL2qryynnpkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3kP1y4Bz4f3k5x;
	Tue, 18 Mar 2025 15:43:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7FA051A0E8E;
	Tue, 18 Mar 2025 15:44:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH6189JNlnEt1YGw--.55732S11;
	Tue, 18 Mar 2025 15:44:14 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH -next v3 07/10] fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
Date: Tue, 18 Mar 2025 15:35:42 +0800
Message-ID: <20250318073545.3518707-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH6189JNlnEt1YGw--.55732S11
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrGFW7Jr18Aw1kArW3GFg_yoWrWryxpF
	W3GF1rGrW0ga4rC3s3Can7ur98Zws5Wr43ZrW2gr1UZr45tr1xKFsFgFyYva4xJrW7AF4Y
	qrnIgr98ua47A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sRitxhPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

With the development of flash-based storage devices, we can quickly
write zeros to SSDs using the WRITE_ZERO command if the devices do not
actually write physical zeroes to the media. Therefore, we can use this
command to quickly preallocate a real all-zero file with written
extents. This approach should be beneficial for subsequent pure
overwriting within this file, as it can save on block allocation and,
consequently, significant metadata changes, which should greatly improve
overwrite performance on certain filesystems.

Therefore, introduce a new operation FALLOC_FL_WRITE_ZEROES to
fallocate. This flag is used to convert a specified range of a file to
zeros by issuing a zeroing operation. Blocks should be allocated for the
regions that span holes in the file, and the entire range is converted
to written extents. If the underlying device supports the actual offload
write zeroes command, the process of zeroing out operation can be
accelerated. If it does not, we currently don't prevent the file system
from writing actual zeros to the device. This provides users with a new
method to quickly generate a zeroed file, users no longer need to write
zero data to create a file with written extents.

Users can check the disk support of unmap write zeroes command by
querying:

    /sys/block/<disk>/queue/write_zeroes_unmap

Finally, this flag should not be specified in conjunction with the
FALLOC_FL_KEEP_SIZE since allocating written extents beyond file EOF is
not permitted, and filesystems that always require out-of-place writes
should not support this flag since they still need to allocated new
blocks during subsequent overwrites.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/open.c                   |  1 +
 include/linux/falloc.h      |  3 ++-
 include/uapi/linux/falloc.h | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index bdbf03f799a1..03b30613d7dc 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -278,6 +278,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		break;
 	case FALLOC_FL_COLLAPSE_RANGE:
 	case FALLOC_FL_INSERT_RANGE:
+	case FALLOC_FL_WRITE_ZEROES:
 		if (mode & FALLOC_FL_KEEP_SIZE)
 			return -EOPNOTSUPP;
 		break;
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index 3f49f3df6af5..7c38c6b76b60 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -36,7 +36,8 @@ struct space_resv {
 				 FALLOC_FL_COLLAPSE_RANGE |	\
 				 FALLOC_FL_ZERO_RANGE |		\
 				 FALLOC_FL_INSERT_RANGE |	\
-				 FALLOC_FL_UNSHARE_RANGE)
+				 FALLOC_FL_UNSHARE_RANGE |	\
+				 FALLOC_FL_WRITE_ZEROES)
 
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_X86_64)
diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
index 5810371ed72b..265aae7ff8c1 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -78,4 +78,22 @@
  */
 #define FALLOC_FL_UNSHARE_RANGE		0x40
 
+/*
+ * FALLOC_FL_WRITE_ZEROES is used to convert a specified range of a file to
+ * zeros by issuing a zeroing operation. Blocks should be allocated for the
+ * regions that span holes in the file, and the entire range is converted to
+ * written extents. This flag is beneficial for subsequent pure overwriting
+ * within this range, as it can save on block allocation and, consequently,
+ * significant metadata changes. Therefore, filesystems that always require
+ * out-of-place writes should not support this flag.
+ *
+ * Different filesystems may implement different limitations on the
+ * granularity of the zeroing operation. Most will preferably be accelerated
+ * by submitting write zeroes command if the backing storage supports, which
+ * may not physically write zeros to the media.
+ *
+ * This flag cannot be specified in conjunction with the FALLOC_FL_KEEP_SIZE.
+ */
+#define FALLOC_FL_WRITE_ZEROES		0x80
+
 #endif /* _UAPI_FALLOC_H_ */
-- 
2.46.1


