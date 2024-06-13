Return-Path: <linux-fsdevel+bounces-21618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 008A69067F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6B528559F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029E513DDD7;
	Thu, 13 Jun 2024 09:01:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590286136;
	Thu, 13 Jun 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269272; cv=none; b=o6C/oRUQtpZWnkeuB1CZlYlM7yiZElFeoE2970GJYxJ69sQ+48JfZXP0KLK9K4ZcKiu4P8K7zmlldAj0yCGRp1jGWUCSyIjf61LlcQjaCWTfOELe6xfxqdqgMVcd0uFlyvMfjlXqI7n9HWtzzPy/4bY7xR41EfwUiYsbIiMSlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269272; c=relaxed/simple;
	bh=K3Eh+FqW9LwDC45mM+t6rRMFCNUZs2uHIWdVLJqpYzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCu6V/IyYV+y8wf1nz1viEBP96fcXEgpbl91nEUuCMQYH7oFWcMqr1BPJ2abZlLc/7rjJtmgBuIHoTTdEB4SW8f8WM7JuRIcxL5+52rSUL7i8h1yjyqErChAMp+MA7sJn9RbhFsEHv5cjya1L3kNrw2p2N9sI/LWNHfkrbjkiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W0GbY3Nkpz4f3jMh;
	Thu, 13 Jun 2024 17:00:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8854D1A0568;
	Thu, 13 Jun 2024 17:01:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFOtWpmHK1uPQ--.16895S6;
	Thu, 13 Jun 2024 17:01:07 +0800 (CST)
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
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH -next v5 2/8] iomap: pass blocksize to iomap_truncate_page()
Date: Thu, 13 Jun 2024 17:00:27 +0800
Message-Id: <20240613090033.2246907-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFOtWpmHK1uPQ--.16895S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyrKF15GFykZr47Kr45Jrb_yoW5Aw4UpF
	1qkF45Gws3Xryj9F1kuFyjvw15tF1DGr40kryfKrZxZrn2qr1xtFn2kF42yF1jqrs7uF4j
	qFZ8K3y8Wr15A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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
index 9952cc3a239b..4a23c3950a47 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
+#include <linux/math64.h>
 #include "trace.h"
 
 #include "../internal.h"
@@ -1453,11 +1454,10 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
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


