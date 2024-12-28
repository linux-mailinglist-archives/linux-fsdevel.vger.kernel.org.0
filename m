Return-Path: <linux-fsdevel+bounces-38175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39169FD8C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 02:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3307A207C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 01:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E11E4BE;
	Sat, 28 Dec 2024 01:49:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F391B644;
	Sat, 28 Dec 2024 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735350594; cv=none; b=ue6yP1708MUqrpEmozWLnMrkptE6hyaz2YepCpLjk2gq5i+TcFK5pbg1sCvNdJ1g9SNfo1HB7ImHvdab4oniAvWxmoU/YdlLYgJm3n4P26ac/mip1k7KHHJKX6wqvK8ARaxyFzcxCfPSUn8ExRvfM5xymC1NgdhESkLjh3yFHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735350594; c=relaxed/simple;
	bh=apXMFKdB33cHv6Y8GuqQ4tlJMAb7toilWfQwo4edzrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esF+GDG1EJE4qdcSHUuL4mGC9vV2RSiERxpXZIdfwX0RoEocSHjTz2YLFph3/1UrKGQX0JO+YxpeIEmbJlt5zrOmnKXjh/dpYywEb5gmlREIkkhCdL1rBf0pHaWXT32yh2J+KzIK/u/B6LYU0/R2EH/WuHjkPRcinl6aS8PR2jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YKlfH4yPNz4f3jJ5;
	Sat, 28 Dec 2024 09:49:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7D1A61A0196;
	Sat, 28 Dec 2024 09:49:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3U4cuWW9nXPNWFw--.42357S5;
	Sat, 28 Dec 2024 09:49:47 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	djwong@kernel.org,
	adilger.kernel@dilger.ca,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
Date: Sat, 28 Dec 2024 09:45:21 +0800
Message-Id: <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3U4cuWW9nXPNWFw--.42357S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1fCr17JFykAFWDXr4UCFg_yoWrAFW3pF
	WkKF18G340gryakr95Cws29rn8Zw4kGr45WrWI9ry8Zw45JF93Kr4q9rn5Jas7GrWDZF48
	Xr1agrZ8uFy2yFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUIiiDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Thanks to the development of flash-based storage devices, we can quickly
write zeros to SSDs using the WRITE_ZERO command. Therefore, we
introduce a new flag FALLOC_FL_FORCE_ZERO to fallocate, which acts as a
supported flag for FALLOC_FL_ZERO_RANGE. This flag forces the file
system to issue zeroes and allocate written extents. The process of
zeroing out can be accelerated with the REQ_OP_WRITE_ZEROES operation
when the underlying storage device supports WRITE_ZERO cmd and UMMAP bit
on SCSI SSDs or DEAC bit on NVMe SSDs.

This provides users with a new method to quickly generate a zeroed file.
Users no longer need to write zero data to create a file with written
extents. The subsequent overwriting of this file range can save
significant metadata changes, which should greatly improve overwrite
performance on certain filesystems.

This flag should not be used in conjunction with the FALLOC_FL_KEEP_SIZE
since allocating written extents beyond file EOF is not permitted.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/open.c                   | 14 +++++++++++---
 include/linux/falloc.h      |  5 ++++-
 include/uapi/linux/falloc.h | 12 ++++++++++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index e6911101fe71..d3afaddfcf27 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -246,7 +246,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (offset < 0 || len <= 0)
 		return -EINVAL;
 
-	if (mode & ~(FALLOC_FL_MODE_MASK | FALLOC_FL_KEEP_SIZE))
+	if (mode & ~(FALLOC_FL_MODE_MASK | FALLOC_FL_SUPPORT_MASK))
 		return -EOPNOTSUPP;
 
 	/*
@@ -259,15 +259,23 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	switch (mode & FALLOC_FL_MODE_MASK) {
 	case FALLOC_FL_ALLOCATE_RANGE:
 	case FALLOC_FL_UNSHARE_RANGE:
+		if (mode & FALLOC_FL_FORCE_ZERO)
+			return -EOPNOTSUPP;
+		break;
 	case FALLOC_FL_ZERO_RANGE:
+		if ((mode & FALLOC_FL_KEEP_SIZE) &&
+		     (mode & FALLOC_FL_FORCE_ZERO))
+			return -EOPNOTSUPP;
 		break;
 	case FALLOC_FL_PUNCH_HOLE:
-		if (!(mode & FALLOC_FL_KEEP_SIZE))
+		if (!(mode & FALLOC_FL_KEEP_SIZE) ||
+		    (mode & FALLOC_FL_FORCE_ZERO))
 			return -EOPNOTSUPP;
 		break;
 	case FALLOC_FL_COLLAPSE_RANGE:
 	case FALLOC_FL_INSERT_RANGE:
-		if (mode & FALLOC_FL_KEEP_SIZE)
+		if ((mode & FALLOC_FL_KEEP_SIZE) ||
+		    (mode & FALLOC_FL_FORCE_ZERO))
 			return -EOPNOTSUPP;
 		break;
 	default:
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index 3f49f3df6af5..75ac063d7eab 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -29,7 +29,8 @@ struct space_resv {
  * Mask of all supported fallocate modes.  Only one can be set at a time.
  *
  * In addition to the mode bit, the mode argument can also encode flags.
- * FALLOC_FL_KEEP_SIZE is the only supported flag so far.
+ * FALLOC_FL_KEEP_SIZE and FALLOC_FL_FORCE_ZERO are the only supported
+ * flags so far.
  */
 #define FALLOC_FL_MODE_MASK	(FALLOC_FL_ALLOCATE_RANGE |	\
 				 FALLOC_FL_PUNCH_HOLE |		\
@@ -37,6 +38,8 @@ struct space_resv {
 				 FALLOC_FL_ZERO_RANGE |		\
 				 FALLOC_FL_INSERT_RANGE |	\
 				 FALLOC_FL_UNSHARE_RANGE)
+#define FALLOC_FL_SUPPORT_MASK	(FALLOC_FL_KEEP_SIZE |		\
+				 FALLOC_FL_FORCE_ZERO)
 
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_X86_64)
diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
index 5810371ed72b..7c12bcdff7d3 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -78,4 +78,16 @@
  */
 #define FALLOC_FL_UNSHARE_RANGE		0x40
 
+/*
+ * FALLOC_FL_FORCE_ZERO should be used in conjunction with FALLOC_FL_ZERO_RANGE,
+ * it force the file system issuing zero and allocate written extents. The
+ * zeroing out can speed up with the REQ_OP_WRITE_ZEROES command, and sebsequent
+ * overwriting over this range can save significant metadata changes, which
+ * should be contribute to improve the overwrite performance on such
+ * preallocated range.
+ *
+ * This flag cannot be used in conjunction with the FALLOC_FL_KEEP_SIZE.
+ */
+#define FALLOC_FL_FORCE_ZERO		0x80
+
 #endif /* _UAPI_FALLOC_H_ */
-- 
2.39.2


