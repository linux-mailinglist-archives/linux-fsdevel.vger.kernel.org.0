Return-Path: <linux-fsdevel+bounces-19491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D062D8C5F29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 04:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181D8B21B68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 02:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC1638DCD;
	Wed, 15 May 2024 02:39:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A52BB0D;
	Wed, 15 May 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740745; cv=none; b=ZPXVRl3fAjCfLeyB8MFqzFId+tmR/k5rZ2WC116KjsCpTqlVNZ9/WZgnEB/rs0Xa+OTZS93rwBI/ZTnOX1EIxwclNVdytHlk/JVR2JvLoVZCVTK37a91nMjAQnEf5VrtL9SKQOXnF0dzdwjaGxBegoJXZ+FpoXmAr4vhD+P5eWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740745; c=relaxed/simple;
	bh=XujiZ625YkMwUYco9phrrOmKK3leYBhdEU1A2DI+XqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFO2IgehBjxV8OPr/1qfRI/0WEndNfjghEg1aFLHelDB5YjK+jRfwrviG24++ppL730vVbgw0/5qE8nO6EXAQ9X4+L+SMYbkbRPIj5keY4+Adju77IivKVIShK+TNp+14FkaDkrBUXE9gmdvSkOt+kx/uO1h6dVgZrMUsE+EPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VfHV21JXKz4f3lfn;
	Wed, 15 May 2024 10:38:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 51BCE1A0182;
	Wed, 15 May 2024 10:39:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBE8IERmRFzIMg--.49754S6;
	Wed, 15 May 2024 10:39:00 +0800 (CST)
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
Subject: [PATCH 2/3] fsdax: pass blocksize to dax_truncate_page()
Date: Wed, 15 May 2024 10:28:28 +0800
Message-Id: <20240515022829.2455554-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515022829.2455554-1-yi.zhang@huaweicloud.com>
References: <20240515022829.2455554-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBE8IERmRFzIMg--.49754S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyrKF15GF1kGFWkAFWrKrg_yoW5CF4rpF
	1DGa15G397X34j9F1kWF1UZw45t3WDCF409ryxAws3Zr92qr1IyF18KF1jkF4jqr48Z3yq
	qF98Kw47Gr1rAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAGYLUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

dax_truncate_page() always assumes the block size of the truncating
inode is i_blocksize(), this is not always true for some filesystems,
e.g. XFS do extent size alignment for realtime inodes. Drop this
assumption and pass the block size for zeroing into dax_truncate_page(),
allow filesystems to indicate the correct block size.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/dax.c            | 7 +++----
 fs/ext2/inode.c     | 4 ++--
 fs/xfs/xfs_iomap.c  | 2 +-
 include/linux/dax.h | 4 ++--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 423fc1607dfa..ae3133cc816c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1403,11 +1403,10 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(dax_zero_range);
 
-int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops)
+int dax_truncate_page(struct inode *inode, loff_t pos, loff_t blocksize,
+		bool *did_zero, const struct iomap_ops *ops)
 {
-	unsigned int blocksize = i_blocksize(inode);
-	unsigned int off = pos & (blocksize - 1);
+	unsigned int off = pos % blocksize;
 
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
index 9d3e3327af4c..861fac466c76 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -210,8 +210,8 @@ int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		const struct iomap_ops *ops);
-int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops);
+int dax_truncate_page(struct inode *inode, loff_t pos, loff_t blocksize,
+		bool *did_zero, const struct iomap_ops *ops);
 
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
-- 
2.39.2


