Return-Path: <linux-fsdevel+bounces-20388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0758D2A33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 03:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F60F1C22583
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 01:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF26C15B0F2;
	Wed, 29 May 2024 01:59:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937F26AF3;
	Wed, 29 May 2024 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947963; cv=none; b=Szo7FiX+/k1DHzqE6Ufnkd/nLGCnlBTkTdSRxoJPHOrv5bYC6L6z3Ep2KDWFqXXq1dqcoBdQxW6icls10NC+fNXBUwwwvLycZxYg5f0XFn18Fb262r8k0Ka5Eo/rleGEqLmAN9WFXqOzI8z2etPsJmAgW2rixgaX1dfs08dEli0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947963; c=relaxed/simple;
	bh=Y5H4B2GimGqHOmxdbFuWXZ+OG9CyjoKYo2vqZhKSZF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVTng/xSbW+mu198evMtCSSQxh80nInCcApY2fmbMGYrlKUcU8kGGZExLACAJHuHo6p3y/3naBtkNYGKuCyfJwhx3TTBJpBySZKJh8nR+cPPBBhLV5xQeIG58VHeLJEx7hCXcwuH/OMNdXHViuqqQgOPnR9aSFgYg/ehIc5De7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vpsxl56B2z4f3nZx;
	Wed, 29 May 2024 09:59:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7F01E1A01D2;
	Wed, 29 May 2024 09:59:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7wi1Zmr3XbNw--.12147S7;
	Wed, 29 May 2024 09:59:18 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH v4 3/8] iomap: pass blocksize to iomap_truncate_page()
Date: Wed, 29 May 2024 17:52:01 +0800
Message-Id: <20240529095206.2568162-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7wi1Zmr3XbNw--.12147S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyrKF15GFykZr4xJF1fZwb_yoW5Aw4UpF
	1qkF45Gws3Xryj9F1kWFyjvw15tF1DGr40kryfKrZxZwn2qr1xtFn2kF42yF1jqrs7uF4j
	qFZ8K3y8Wr15ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRLvttUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

iomap_truncate_page() always assumes the block size of the truncating
inode is i_blocksize(), this is not always true for some filesystems,
e.g. XFS does extent size alignment for realtime inodes. Drop this
assumption and pass the block size for zeroing into
iomap_truncate_page(), allow filesystems to indicate the correct block
size.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 8 ++++----
 fs/xfs/xfs_iomap.c     | 3 ++-
 include/linux/iomap.h  | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a3a5d4eb7289..30b49d6e9d48 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
+#include <linux/math64.h>
 #include "trace.h"
 
 #include "../internal.h"
@@ -1483,11 +1484,10 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 EXPORT_SYMBOL_GPL(iomap_zero_range);
 
 int
-iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops)
+iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
+		bool *did_zero, const struct iomap_ops *ops)
 {
-	unsigned int blocksize = i_blocksize(inode);
-	unsigned int off = pos & (blocksize - 1);
+	unsigned int off = rem_u64(pos, blocksize);
 
 	/* Block boundary? Nothing to do */
 	if (!off)
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 378342673925..32306804b01b 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1471,10 +1471,11 @@ xfs_truncate_page(
 	bool			*did_zero)
 {
 	struct inode		*inode = VFS_I(ip);
+	unsigned int		blocksize = i_blocksize(inode);
 
 	if (IS_DAX(inode))
 		return dax_truncate_page(inode, pos, did_zero,
 					&xfs_dax_write_iomap_ops);
-	return iomap_truncate_page(inode, pos, did_zero,
+	return iomap_truncate_page(inode, pos, blocksize, did_zero,
 				   &xfs_buffered_write_iomap_ops);
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..d67bf86ec582 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -273,8 +273,8 @@ int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops);
-int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops);
+int iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
+		bool *did_zero, const struct iomap_ops *ops);
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
 			const struct iomap_ops *ops);
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-- 
2.39.2


