Return-Path: <linux-fsdevel+bounces-19656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92D8C8590
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 13:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9A3B23359
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B63FBAE;
	Fri, 17 May 2024 11:24:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A093D541;
	Fri, 17 May 2024 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945090; cv=none; b=C2+nhnUpl7ss0wC+FSEIwvONPfb+u3H89CCmwek3brvNdACG7HQ3eiefiDmywQeKSBN6T6sY7FXePUYs44EZB9Ec9dq0xx3cZ93oUP0QxZ6IlzUdsGQ+I3nqxlGl381s3RQ/6ZWPQHdelQMvB2O7PIRAenLx80a1YSWgyL+c3RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945090; c=relaxed/simple;
	bh=Dba5XUZVcW5Tf5DatR3QHTIX0lxdY4+0RZjEenEo4c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DatVzSEob0Rc+fLZmop69MPwsmy7BCOQrG9OHloLGljHGslWAx/IIzgfK2ywIGMM5w34vKuBYMlS3lDHcifUw5Oi92vWawivx7vDgRA8bP0RtUfC4qLBocVKt1ZQdmVXqZgJ4s4KQQ72Nk1tHKz9D3SDoc1/IOxNowh4XXwJS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vgl3k6mQlz4f3mHc;
	Fri, 17 May 2024 19:24:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 32CA61A017F;
	Fri, 17 May 2024 19:24:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFrPkdm3V+kMw--.2732S6;
	Fri, 17 May 2024 19:24:45 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 2/3] fsdax: pass blocksize to dax_truncate_page()
Date: Fri, 17 May 2024 19:13:54 +0800
Message-Id: <20240517111355.233085-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFrPkdm3V+kMw--.2732S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyrKF15Gw17Xw48JF18Xwb_yoW5tr4rpF
	1DCa15G397X34j9F1kWF1jvw45t3WkCr40vryxZrZ3Zr9Fqr1IyF1vkF1YkF4Utr48Z3yj
	qFZ8Kw47Gr15ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbdOz7UUUUU=
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

dax_truncate_page() always assumes the block size of the truncating
inode is i_blocksize(), this is not always true for some filesystems,
e.g. XFS does extent size alignment for realtime inodes. Drop this
assumption and pass the block size for zeroing into dax_truncate_page(),
allow filesystems to indicate the correct block size.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/dax.c            | 13 +++++++++----
 fs/ext2/inode.c     |  4 ++--
 fs/xfs/xfs_iomap.c  |  2 +-
 include/linux/dax.h |  4 ++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 423fc1607dfa..98419280d9ae 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -25,6 +25,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
 #include <linux/rmap.h>
+#include <linux/math64.h>
 #include <asm/pgalloc.h>
 
 #define CREATE_TRACE_POINTS
@@ -1403,11 +1404,15 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(dax_zero_range);
 
-int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops)
+int dax_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
+		bool *did_zero, const struct iomap_ops *ops)
 {
-	unsigned int blocksize = i_blocksize(inode);
-	unsigned int off = pos & (blocksize - 1);
+	unsigned int off;
+
+	if (is_power_of_2(blocksize))
+		off = pos & (blocksize - 1);
+	else
+		div_u64_rem(pos, blocksize, &off);
 
 	/* Block boundary? Nothing to do */
 	if (!off)
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index f3d570a9302b..fbbd479f3c4e 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1278,8 +1278,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	inode_dio_wait(inode);
 
 	if (IS_DAX(inode))
-		error = dax_truncate_page(inode, newsize, NULL,
-					  &ext2_iomap_ops);
+		error = dax_truncate_page(inode, newsize, i_blocksize(inode),
+					  NULL, &ext2_iomap_ops);
 	else
 		error = block_truncate_page(inode->i_mapping,
 				newsize, ext2_get_block);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 31ac07bb8425..4958cc3337bc 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1470,7 +1470,7 @@ xfs_truncate_page(
 	unsigned int		blocksize = i_blocksize(inode);
 
 	if (IS_DAX(inode))
-		return dax_truncate_page(inode, pos, did_zero,
+		return dax_truncate_page(inode, pos, blocksize, did_zero,
 					&xfs_dax_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, blocksize, did_zero,
 				   &xfs_buffered_write_iomap_ops);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d3e3327af4c..4aa8ef7c8fd4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -210,8 +210,8 @@ int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		const struct iomap_ops *ops);
-int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops);
+int dax_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
+		bool *did_zero, const struct iomap_ops *ops);
 
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
-- 
2.39.2


