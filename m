Return-Path: <linux-fsdevel+bounces-37462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABB39F2821
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 02:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579EB166D91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 01:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814C91D514E;
	Mon, 16 Dec 2024 01:42:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA2155A4D;
	Mon, 16 Dec 2024 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313369; cv=none; b=S8T7KSfgN88Dz70rie4BIZYV0cf64caHIs+5urrBHHW44XtfcETrNEVHoT49u3kcp+fS7BUz/Xo8PtQhKcI3GftbRNMlK4U9sGYD+PKu0YIko58JiqToESWByNScQQ1+cDvXCUJ0qM/r5euUntePUBO0Fl3nMKZ/SBun+47mdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313369; c=relaxed/simple;
	bh=Jg0mqYaW+aXe2FY8p05EfbX63l+obWWoDuff6fPILMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGcg0qCIo0I+rwDByhO6IV3+cy1H4s7Cjm8gYmfb+2hvU/1yacfnWpEwNaAiP4aLYMPAN0FEjvPkOarEi9sIwWd3YrwsiFMfnd/3s7emynD44+33job50JMw5BYoGpwmYn2yu7k6ei+eVeVAbzoF1rDBGG7fhde7Pmj7oGhWWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YBN3T275cz4f3lVM;
	Mon, 16 Dec 2024 09:42:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B9C231A0568;
	Mon, 16 Dec 2024 09:42:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4d5hV9nYi3kEg--.4387S5;
	Mon, 16 Dec 2024 09:42:33 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 01/10] ext4: remove writable userspace mappings before truncating page cache
Date: Mon, 16 Dec 2024 09:39:06 +0800
Message-ID: <20241216013915.3392419-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4d5hV9nYi3kEg--.4387S5
X-Coremail-Antispam: 1UD129KBjvJXoW3WFykCry5Zr1rWF1UAF17GFg_yoW7uFyfpr
	9xGFyfCrW8Z3ZruF1S9F17Zr1rKa4kAFW8Jry3Gr1DZr9xX3Z2kF1DtF10kF4UKrW8Jw4j
	vF4Ut3y7KF45Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU2dgAUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When zeroing a range of folios on the filesystem which block size is
less than the page size, the file's mapped blocks within one page will
be marked as unwritten, we should remove writable userspace mappings to
ensure that ext4_page_mkwrite() can be called during subsequent write
access to these partial folios. Otherwise, data written by subsequent
mmap writes may not be saved to disk.

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

Fix this by introducing ext4_truncate_page_cache_block_range() to remove
writable userspace mappings when truncating a partial folio range.
Additionally, move the journal data mode-specific handlers and
truncate_pagecache_range() into this function, allowing it to serve as a
common helper that correctly manages the page cache in preparation for
block range manipulations.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  2 ++
 fs/ext4/extents.c | 19 ++++-----------
 fs/ext4/inode.c   | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 74f2071189b2..8843929b46ce 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3016,6 +3016,8 @@ extern int ext4_inode_attach_jinode(struct inode *inode);
 extern int ext4_can_truncate(struct inode *inode);
 extern int ext4_truncate(struct inode *);
 extern int ext4_break_layouts(struct inode *);
+extern int ext4_truncate_page_cache_block_range(struct inode *inode,
+						loff_t start, loff_t end);
 extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
 extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a07a98a4b97a..8dc6b4271b15 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4667,22 +4667,13 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			goto out_mutex;
 		}
 
-		/*
-		 * For journalled data we need to write (and checkpoint) pages
-		 * before discarding page cache to avoid inconsitent data on
-		 * disk in case of crash before zeroing trans is committed.
-		 */
-		if (ext4_should_journal_data(inode)) {
-			ret = filemap_write_and_wait_range(mapping, start,
-							   end - 1);
-			if (ret) {
-				filemap_invalidate_unlock(mapping);
-				goto out_mutex;
-			}
+		/* Now release the pages and zero block aligned part of pages */
+		ret = ext4_truncate_page_cache_block_range(inode, start, end);
+		if (ret) {
+			filemap_invalidate_unlock(mapping);
+			goto out_mutex;
 		}
 
-		/* Now release the pages and zero block aligned part of pages */
-		truncate_pagecache_range(inode, start, end - 1);
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 89aade6f45f6..c68a8b841148 100644
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
@@ -3902,6 +3903,67 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	return ret;
 }
 
+static inline void ext4_truncate_folio(struct inode *inode,
+				       loff_t start, loff_t end)
+{
+	unsigned long blocksize = i_blocksize(inode);
+	struct folio *folio;
+
+	/* Nothing to be done if no complete block needs to be truncated. */
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
+int ext4_truncate_page_cache_block_range(struct inode *inode,
+					 loff_t start, loff_t end)
+{
+	unsigned long blocksize = i_blocksize(inode);
+	int ret;
+
+	/*
+	 * For journalled data we need to write (and checkpoint) pages
+	 * before discarding page cache to avoid inconsitent data on disk
+	 * in case of crash before freeing or unwritten converting trans
+	 * is committed.
+	 */
+	if (ext4_should_journal_data(inode)) {
+		ret = filemap_write_and_wait_range(inode->i_mapping, start,
+						   end - 1);
+		if (ret)
+			return ret;
+		goto truncate_pagecache;
+	}
+
+	/*
+	 * If the block size is less than the page size, the file's mapped
+	 * blocks within one page could be freed or converted to unwritten.
+	 * So it's necessary to remove writable userspace mappings, and then
+	 * ext4_page_mkwrite() can be called during subsequent write access
+	 * to these partial folios.
+	 */
+	if (blocksize < PAGE_SIZE && start < inode->i_size) {
+		loff_t start_boundary = round_up(start, PAGE_SIZE);
+
+		ext4_truncate_folio(inode, start, min(start_boundary, end));
+		if (end > start_boundary)
+			ext4_truncate_folio(inode,
+					    round_down(end, PAGE_SIZE), end);
+	}
+
+truncate_pagecache:
+	truncate_pagecache_range(inode, start, end - 1);
+	return 0;
+}
+
 static void ext4_wait_dax_page(struct inode *inode)
 {
 	filemap_invalidate_unlock(inode->i_mapping);
-- 
2.46.1


