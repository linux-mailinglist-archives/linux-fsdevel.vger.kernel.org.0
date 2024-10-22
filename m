Return-Path: <linux-fsdevel+bounces-32550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465319A969D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507F8283679
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8575146A7B;
	Tue, 22 Oct 2024 03:13:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1D13E03E;
	Tue, 22 Oct 2024 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566780; cv=none; b=dhEHvFWJ07qZFmQdLc8H38eysb9dNezr0icw2O01lRgjDSQ0M4DKqkpunrq4KLF/zELYsFb/1+bfv4yYe1MD/s32tkNLpdOfhLPiWn34E/b1FCpUKQ5rKuvHpL39bNog1pZecigPLSebOo4crJcuu13pNnVSqUBsvWo9jYNlB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566780; c=relaxed/simple;
	bh=Un7uRmLmnNBLObbxKEcGdntaorjVplO34POchkhMyuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/mBwx0ddok5DlagbdJlg/uCL4qd6vkf0+NJDuPPWb3VGDWNLR+nP9rvzjdiotMyVH9hD6WOQYSVsMhUhTfBiokdW4DBtt+btRTHbIJ7T4RnCpEBVfoWEOak682A6G23DS+H3MuQIDKljGpwpnHtT4qvhQXXI7k+OVjtb3NvxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcg34f5Lz4f3lW3;
	Tue, 22 Oct 2024 11:12:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CCB881A0359;
	Tue, 22 Oct 2024 11:12:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S5;
	Tue, 22 Oct 2024 11:12:49 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 01/27] ext4: remove writable userspace mappings before truncating page cache
Date: Tue, 22 Oct 2024 19:10:32 +0800
Message-ID: <20241022111059.2566137-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrJF43Xw18CFy5Gry5XFb_yoWrAF1kpr
	9rGFyfCrWrZasrWa1Sg3WUZw1rK3WkCF4UJ34fGr1UXFyrX3WkKF1Dtw1UAF4UKrW8Jw4j
	vF45trWjgF45A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sR_Q6LtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When zeroing a range of folios on the filesystem which block size is
less than the page size, the file's mapped partial blocks within one
page will be marked as unwritten, we should remove writable userspace
mappings to ensure that ext4_page_mkwrite() can be called during
subsequent write access to these folios. Otherwise, data written by
subsequent mmap writes may not be saved to disk.

 $mkfs.ext4 -b 1024 /dev/vdb
 $mount /dev/vdb /mnt
 $xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
               -c "mwrite -S 0x5a 2048 2048" -c "fzero 2048 2048" \
               -c "mwrite -S 0x59 2048 2048" -c "close" /mnt/foo

 $od -Ax -t x1z /mnt/foo
 000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
 *
 000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
 *
 001000

 $umount /mnt && mount /dev/vdb /mnt
 $od -Ax -t x1z /mnt/foo
 000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
 *
 000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 *
 001000

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  2 ++
 fs/ext4/extents.c |  1 +
 fs/ext4/inode.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..6d0267afd4c1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3020,6 +3020,8 @@ extern int ext4_inode_attach_jinode(struct inode *inode);
 extern int ext4_can_truncate(struct inode *inode);
 extern int ext4_truncate(struct inode *);
 extern int ext4_break_layouts(struct inode *);
+extern void ext4_truncate_folios_range(struct inode *inode, loff_t start,
+				       loff_t end);
 extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
 extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 34e25eee6521..2a054c3689f0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4677,6 +4677,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		}
 
 		/* Now release the pages and zero block aligned part of pages */
+		ext4_truncate_folios_range(inode, start, end);
 		truncate_pagecache_range(inode, start, end - 1);
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..8b34e79112d5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -31,6 +31,7 @@
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/mpage.h>
+#include <linux/rmap.h>
 #include <linux/namei.h>
 #include <linux/uio.h>
 #include <linux/bio.h>
@@ -3870,6 +3871,46 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	return ret;
 }
 
+static inline void ext4_truncate_folio(struct inode *inode,
+				       loff_t start, loff_t end)
+{
+	unsigned long blocksize = i_blocksize(inode);
+	struct folio *folio;
+
+	if (round_up(start, blocksize) >= round_down(end, blocksize))
+		return;
+
+	folio = filemap_lock_folio(inode->i_mapping, start >> PAGE_SHIFT);
+	if (IS_ERR(folio))
+		return;
+
+	if (folio_mkclean(folio))
+		folio_mark_dirty(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+}
+
+/*
+ * When truncating a range of folios, if the block size is less than the
+ * page size, the file's mapped partial blocks within one page could be
+ * freed or converted to unwritten. We should call this function to remove
+ * writable userspace mappings so that ext4_page_mkwrite() can be called
+ * during subsequent write access to these folios.
+ */
+void ext4_truncate_folios_range(struct inode *inode, loff_t start, loff_t end)
+{
+	unsigned long blocksize = i_blocksize(inode);
+
+	if (end > inode->i_size)
+		end = inode->i_size;
+	if (start >= end || blocksize >= PAGE_SIZE)
+		return;
+
+	ext4_truncate_folio(inode, start, min(round_up(start, PAGE_SIZE), end));
+	if (end > round_up(start, PAGE_SIZE))
+		ext4_truncate_folio(inode, round_down(end, PAGE_SIZE), end);
+}
+
 static void ext4_wait_dax_page(struct inode *inode)
 {
 	filemap_invalidate_unlock(inode->i_mapping);
-- 
2.46.1


