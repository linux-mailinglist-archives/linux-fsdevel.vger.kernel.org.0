Return-Path: <linux-fsdevel+bounces-20391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6168D2A40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 04:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F353B23743
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D915B15C;
	Wed, 29 May 2024 01:59:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549D15A4BC;
	Wed, 29 May 2024 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947964; cv=none; b=GSgUEMDBzwggw+FSBkgXJsArFauNoCyhxspDY4hWsE0uTe2Nehdc11/tD+AOvEgLkkia8nuOCxXtCk5jEwXMEnOuI2BsZQz82ncCqJPq2zP3Ov8m0xqwQ9riPo7aRy0E3v3jOfksZo66AIgnUGfT61+9Mx+y9W6SSveAlo9VJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947964; c=relaxed/simple;
	bh=EUEzZy0qO2Yaih+zbbYXFiy2BA0aBiE0VQ67Tmmy2jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dt6WZRDx1XqWBKRku7RtofIF+a2lyhKc89GuR6oHC+MJMeG2BtbLDQgW5I77WRSwiwuN5XYCBgKcpDralqEg3FWRN3/NprWBtHDRSrSJONDEFlFGEexguXPcKrR0W0Yfg0Q3rdr1yXl8sptSRTVd/aRkGgYlIj1pCr45ttbs0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vpsxm5VCTz4f3nb0;
	Wed, 29 May 2024 09:59:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8BA9B1A01A7;
	Wed, 29 May 2024 09:59:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7wi1Zmr3XbNw--.12147S9;
	Wed, 29 May 2024 09:59:19 +0800 (CST)
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
Subject: [RFC PATCH v4 5/8] xfs: refactor the truncating order
Date: Wed, 29 May 2024 17:52:03 +0800
Message-Id: <20240529095206.2568162-6-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn9g7wi1Zmr3XbNw--.12147S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4fZw1DGr1kAFyUCF48Zwb_yoW3GrWxpF
	93GasxGrs7GryUZr1kZr1jqw1rK3Z5JFW0yFyIgF97ZayDJr1IyF97tFy8trWUKrs3Ww4F
	gFs8GayfWwn5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4U
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRHa0PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When truncating down an inode, we call xfs_truncate_page() to zero out
the tail partial block that beyond new EOF, which prevents exposing
stale data. But xfs_truncate_page() always assumes the blocksize is
i_blocksize(inode), it's not always true if we have a large allocation
unit for a file and we should aligned to this unitsize, e.g. realtime
inode should aligned to the rtextsize.

Current xfs_setattr_size() can't support zeroing out a large alignment
size on trucate down since the process order is wrong. We first do zero
out through xfs_truncate_page(), and then update inode size through
truncate_setsize() immediately. If the zeroed range is larger than a
folio, the write back path would not write back zeroed pagecache beyond
the EOF folio, so it doesn't write zeroes to the entire tail extent and
could expose stale data after an appending write into the next aligned
extent.

We need to adjust the order to zero out tail aligned blocks, write back
zeroed or cached data, update i_size and drop cache beyond aligned EOF
block, preparing for the fix of realtime inode and supporting the
upcoming forced alignment feature.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/xfs_iomap.c |   2 +-
 fs/xfs/xfs_iomap.h |   3 +-
 fs/xfs/xfs_iops.c  | 107 ++++++++++++++++++++++++++++-----------------
 3 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 8cdfcbb5baa7..0369b64cc3f4 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1468,10 +1468,10 @@ int
 xfs_truncate_page(
 	struct xfs_inode	*ip,
 	loff_t			pos,
+	unsigned int		blocksize,
 	bool			*did_zero)
 {
 	struct inode		*inode = VFS_I(ip);
-	unsigned int		blocksize = i_blocksize(inode);
 
 	if (IS_DAX(inode))
 		return dax_truncate_page(inode, pos, blocksize, did_zero,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 4da13440bae9..feb1610cb645 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -25,7 +25,8 @@ int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
 
 int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
 		bool *did_zero);
-int xfs_truncate_page(struct xfs_inode *ip, loff_t pos, bool *did_zero);
+int xfs_truncate_page(struct xfs_inode *ip, loff_t pos,
+		unsigned int blocksize, bool *did_zero);
 
 static inline xfs_filblks_t
 xfs_aligned_fsb_count(
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index d44508930b67..d24927075022 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -812,6 +812,7 @@ xfs_setattr_size(
 	int			error;
 	uint			lock_flags = 0;
 	bool			did_zeroing = false;
+	bool			write_back = false;
 
 	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
 	ASSERT(S_ISREG(inode->i_mode));
@@ -853,30 +854,7 @@ xfs_setattr_size(
 	 * the transaction because the inode cannot be unlocked once it is a
 	 * part of the transaction.
 	 *
-	 * Start with zeroing any data beyond EOF that we may expose on file
-	 * extension, or zeroing out the rest of the block on a downward
-	 * truncate.
-	 */
-	if (newsize > oldsize) {
-		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
-		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
-				&did_zeroing);
-	} else if (newsize != oldsize) {
-		error = xfs_truncate_page(ip, newsize, &did_zeroing);
-	}
-
-	if (error)
-		return error;
-
-	/*
-	 * We've already locked out new page faults, so now we can safely remove
-	 * pages from the page cache knowing they won't get refaulted until we
-	 * drop the XFS_MMAP_EXCL lock after the extent manipulations are
-	 * complete. The truncate_setsize() call also cleans partial EOF page
-	 * PTEs on extending truncates and hence ensures sub-page block size
-	 * filesystems are correctly handled, too.
-	 *
-	 * We have to do all the page cache truncate work outside the
+	 * And we have to do all the page cache truncate work outside the
 	 * transaction context as the "lock" order is page lock->log space
 	 * reservation as defined by extent allocation in the writeback path.
 	 * Hence a truncate can fail with ENOMEM from xfs_trans_alloc(), but
@@ -884,27 +862,74 @@ xfs_setattr_size(
 	 * user visible changes). There's not much we can do about this, except
 	 * to hope that the caller sees ENOMEM and retries the truncate
 	 * operation.
-	 *
-	 * And we update in-core i_size and truncate page cache beyond newsize
-	 * before writeback the [i_disk_size, newsize] range, so we're
-	 * guaranteed not to write stale data past the new EOF on truncate down.
 	 */
-	truncate_setsize(inode, newsize);
+	write_back = newsize > ip->i_disk_size && oldsize != ip->i_disk_size;
+	if (newsize < oldsize) {
+		unsigned int blocksize = i_blocksize(inode);
 
-	/*
-	 * We are going to log the inode size change in this transaction so
-	 * any previous writes that are beyond the on disk EOF and the new
-	 * EOF that have not been written out need to be written here.  If we
-	 * do not write the data out, we expose ourselves to the null files
-	 * problem. Note that this includes any block zeroing we did above;
-	 * otherwise those blocks may not be zeroed after a crash.
-	 */
-	if (did_zeroing ||
-	    (newsize > ip->i_disk_size && oldsize != ip->i_disk_size)) {
-		error = filemap_write_and_wait_range(VFS_I(ip)->i_mapping,
-						ip->i_disk_size, newsize - 1);
+		/*
+		 * Zeroing out the partial EOF block and the rest of the extra
+		 * aligned blocks on a downward truncate.
+		 */
+		error = xfs_truncate_page(ip, newsize, blocksize, &did_zeroing);
 		if (error)
 			return error;
+
+		/*
+		 * We are going to log the inode size change in this transaction
+		 * so any previous writes that are beyond the on disk EOF and
+		 * the new EOF that have not been written out need to be written
+		 * here.  If we do not write the data out, we expose ourselves
+		 * to the null files problem. Note that this includes any block
+		 * zeroing we did above; otherwise those blocks may not be
+		 * zeroed after a crash.
+		 */
+		if (did_zeroing || write_back) {
+			error = filemap_write_and_wait_range(inode->i_mapping,
+					min_t(loff_t, ip->i_disk_size, newsize),
+					roundup_64(newsize, blocksize) - 1);
+			if (error)
+				return error;
+		}
+
+		/*
+		 * Updating i_size after writing back to make sure the zeroed
+		 * blocks could been written out, and drop all the page cache
+		 * range that beyond blocksize aligned new EOF block.
+		 *
+		 * We've already locked out new page faults, so now we can
+		 * safely remove pages from the page cache knowing they won't
+		 * get refaulted until we drop the XFS_MMAP_EXCL lock after the
+		 * extent manipulations are complete.
+		 */
+		i_size_write(inode, newsize);
+		truncate_pagecache(inode, roundup_64(newsize, blocksize));
+	} else {
+		/*
+		 * Start with zeroing any data beyond EOF that we may expose on
+		 * file extension.
+		 */
+		if (newsize > oldsize) {
+			trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
+			error = xfs_zero_range(ip, oldsize, newsize - oldsize,
+					       &did_zeroing);
+			if (error)
+				return error;
+		}
+
+		/*
+		 * The truncate_setsize() call also cleans partial EOF page
+		 * PTEs on extending truncates and hence ensures sub-page block
+		 * size filesystems are correctly handled, too.
+		 */
+		truncate_setsize(inode, newsize);
+
+		if (did_zeroing || write_back) {
+			error = filemap_write_and_wait_range(inode->i_mapping,
+					ip->i_disk_size, newsize - 1);
+			if (error)
+				return error;
+		}
 	}
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
-- 
2.39.2


