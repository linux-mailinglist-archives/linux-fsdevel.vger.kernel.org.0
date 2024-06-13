Return-Path: <linux-fsdevel+bounces-21621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD408906800
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C5FB26EA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297EF140E26;
	Thu, 13 Jun 2024 09:01:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4700136E00;
	Thu, 13 Jun 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269273; cv=none; b=QrzLNQGBPGdomyNIJyx+xNHmNo0y4lneyId8e9lgevPG1oLFIHA/PxEjB6SIfzCnOSJqaQAOYK2Zp1mIeOXqjYSfGIW7mL/kkZVPWaPoJrGh+qK3L6nq8I8avBc/2IgFh2eNnMDbZfx9KACxwfgIkyfKGSHIvRf7k0lneQmXuR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269273; c=relaxed/simple;
	bh=8Ad+4LzW9z/L+C6yLlD1Vrpq/J5LuMDvIrmvgOZz/XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uFYGOzMc8w1e9Crve1+O3+s2HG5p3UUS+RlyIr5OSkXsiqlppunKBd1YVWYM+FQMUAGMEPhJifBlzvkkj3cOxT/Ifp5LtJRdcJA3Y+cEsjEN3Z4D3jsPOfDzcr2NXIH80nVwWMjxmEud0sQcnoMw6cAMsjySztQ9PMCItEGigFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W0Gbd6zPmz4f3kkF;
	Thu, 13 Jun 2024 17:01:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 90E021A0FB7;
	Thu, 13 Jun 2024 17:01:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFOtWpmHK1uPQ--.16895S8;
	Thu, 13 Jun 2024 17:01:08 +0800 (CST)
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
Subject: [PATCH -next v5 4/8] xfs: refactor the truncating order
Date: Thu, 13 Jun 2024 17:00:29 +0800
Message-Id: <20240613090033.2246907-5-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXKBFOtWpmHK1uPQ--.16895S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4fZw1DGr1kAFyUCF48Zwb_yoWfCry5pF
	9xGas8Gr4kGa4UZr1kZF10qw1Fk3Z5Jay0yry0gr97Za4DXryIkF97KFy0gFWUKrs3Jw4Y
	qF4DGayfW3s5ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF18B
	UUUUU
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
zeroed or cached data, update i_size and drop all the pagecache beyond
the allocation unit containing EOF, preparing for the fix of realtime
inode and supporting the upcoming forced alignment feature.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/xfs_iomap.c |   2 +-
 fs/xfs/xfs_iomap.h |   3 +-
 fs/xfs/xfs_iops.c  | 162 +++++++++++++++++++++++++++++----------------
 3 files changed, 109 insertions(+), 58 deletions(-)

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
index ff222827e550..0919a42cceb6 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -792,6 +792,108 @@ xfs_setattr_nonsize(
 	return error;
 }
 
+/*
+ * Zero and flush data on truncate.
+ *
+ * Zero out any data beyond EOF on size changed truncate, write back
+ * all cached data if we need to extend ondisk EOF, and drop all the
+ * pagecache that beyond the new EOF block.
+ */
+STATIC int
+xfs_setattr_truncate_data(
+	struct xfs_inode	*ip,
+	xfs_off_t		oldsize,
+	xfs_off_t		newsize)
+{
+	struct inode		*inode = VFS_I(ip);
+	bool			did_zeroing = false;
+	bool			extending_ondisk_eof;
+	unsigned int		blocksize;
+	int			error;
+
+	extending_ondisk_eof = newsize > ip->i_disk_size &&
+			       oldsize != ip->i_disk_size;
+
+	/*
+	 * Start with zeroing any data beyond EOF that we may expose on file
+	 * extension, or zeroing out the rest of the block on a downward
+	 * truncate.
+	 *
+	 * We've already locked out new page faults, so now we can safely call
+	 * truncate_setsize() or truncate_pagecache() to remove pages from the
+	 * page cache knowing they won't get refaulted until we drop the
+	 * XFS_MMAPLOCK_EXCL after the extent manipulations are complete.  The
+	 * truncate_setsize() call also cleans partial EOF page PTEs on
+	 * extending truncates and hence ensures sub-page block size filesystems
+	 * are correctly handled, too.
+	 */
+	if (newsize >= oldsize) {
+		/* File extentsion */
+		if (newsize != oldsize) {
+			trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
+			error = xfs_zero_range(ip, oldsize, newsize - oldsize,
+					       &did_zeroing);
+			if (error)
+				return error;
+		}
+
+		truncate_setsize(inode, newsize);
+
+		/*
+		 * We are going to log the inode size change in this transaction
+		 * so any previous writes that are beyond the on disk EOF and
+		 * the new EOF that have not been written out need to be written
+		 * here.  If we do not write the data out, we expose ourselves
+		 * to the null files problem.  Note that this includes any block
+		 * zeroing we did above; otherwise those blocks may not be
+		 * zeroed after a crash.
+		 */
+		if (did_zeroing || extending_ondisk_eof) {
+			error = filemap_write_and_wait_range(inode->i_mapping,
+					ip->i_disk_size, newsize - 1);
+			if (error)
+				return error;
+		}
+		return 0;
+	}
+
+	/* Truncate down */
+	blocksize = i_blocksize(inode);
+
+	/*
+	 * iomap won't detect a dirty page over an unwritten block (or a cow
+	 * block over a hole) and subsequently skips zeroing the newly post-EOF
+	 * portion of the page. Flush the new EOF to convert the block before
+	 * the pagecache truncate.
+	 */
+	error = filemap_write_and_wait_range(inode->i_mapping, newsize,
+			roundup_64(newsize, blocksize) - 1);
+	if (error)
+		return error;
+
+	error = xfs_truncate_page(ip, newsize, blocksize, &did_zeroing);
+	if (error)
+		return error;
+
+	if (did_zeroing || extending_ondisk_eof) {
+		error = filemap_write_and_wait_range(inode->i_mapping,
+				min_t(loff_t, ip->i_disk_size, newsize),
+				roundup_64(newsize, blocksize) - 1);
+		if (error)
+			return error;
+	}
+
+	/*
+	 * Open code truncate_setsize(), update the incore i_size after flushing
+	 * dirty tail pages to disk, don't zero out the partial EOF folio which
+	 * may contains already zeroed tail blocks again and just drop all the
+	 * pagecache beyond the allocation unit containing EOF.
+	 */
+	i_size_write(inode, newsize);
+	truncate_pagecache(inode, roundup_64(newsize, blocksize));
+	return 0;
+}
+
 /*
  * Truncate file.  Must have write permission and not be a directory.
  *
@@ -811,7 +913,6 @@ xfs_setattr_size(
 	struct xfs_trans	*tp;
 	int			error;
 	uint			lock_flags = 0;
-	bool			did_zeroing = false;
 
 	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
 	ASSERT(S_ISREG(inode->i_mode));
@@ -853,40 +954,7 @@ xfs_setattr_size(
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
-	} else {
-		/*
-		 * iomap won't detect a dirty page over an unwritten block (or a
-		 * cow block over a hole) and subsequently skips zeroing the
-		 * newly post-EOF portion of the page. Flush the new EOF to
-		 * convert the block before the pagecache truncate.
-		 */
-		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
-						     newsize);
-		if (error)
-			return error;
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
+	 * We also have to do all the page cache truncate work outside the
 	 * transaction context as the "lock" order is page lock->log space
 	 * reservation as defined by extent allocation in the writeback path.
 	 * Hence a truncate can fail with ENOMEM from xfs_trans_alloc(), but
@@ -894,28 +962,10 @@ xfs_setattr_size(
 	 * user visible changes). There's not much we can do about this, except
 	 * to hope that the caller sees ENOMEM and retries the truncate
 	 * operation.
-	 *
-	 * And we update in-core i_size and truncate page cache beyond newsize
-	 * before writeback the [i_disk_size, newsize] range, so we're
-	 * guaranteed not to write stale data past the new EOF on truncate down.
 	 */
-	truncate_setsize(inode, newsize);
-
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
-		if (error)
-			return error;
-	}
+	error = xfs_setattr_truncate_data(ip, oldsize, newsize);
+	if (error)
+		return error;
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
 	if (error)
-- 
2.39.2


