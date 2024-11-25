Return-Path: <linux-fsdevel+bounces-35749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469BF9D7A3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 03:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4E9B21C1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 02:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9354199B8;
	Mon, 25 Nov 2024 02:55:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D302F2D;
	Mon, 25 Nov 2024 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732503350; cv=none; b=nMbp7KoCCqQTw1mEFBW7uugGPg2QyFeFTuAPS0bm0nIr+yuOChJaEGw6DURNa1Lpqw5WLQdITy1r1+8tPaCH57DykgwGKXmvTVrau/39m9T0P21K326fFfFCDHalUbDi+YocArGEmmWffIwGKNWhuXNk8zApCEljvY70ZtilPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732503350; c=relaxed/simple;
	bh=73REw1IMk4yCeJLrkWWsJrg8HNF5YcyzoqH5j3iD8aQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HqDt9THsz/UfeZj7+XaVt8cGUOViAa1fRgrNy+Gk+TvwM2/KbksMR9n65gI8P31rGNgp8cUYLUhGeN393ONZTgi/l8mJpHVz0D5fZBeQvyoTCmKX9zk5L/PKXyFo+E2r6K29roXNnuDNJfczqN661TwlSVimBR6uyZ0qAxtJC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XxVC13myVz1T5cV;
	Mon, 25 Nov 2024 10:34:05 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 133451A0188;
	Mon, 25 Nov 2024 10:36:11 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Nov
 2024 10:36:10 +0800
From: Long Li <leo.lilong@huawei.com>
To: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH v4 1/2] iomap: fix zero padding data issue in concurrent append writes
Date: Mon, 25 Nov 2024 10:33:40 +0800
Message-ID: <20241125023341.2816630-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500017.china.huawei.com (7.185.36.126)

During concurrent append writes to XFS filesystem, zero padding data
may appear in the file after power failure. This happens due to imprecise
disk size updates when handling write completion.

Consider this scenario with concurrent append writes same file:

  Thread 1:                  Thread 2:
  ------------               -----------
  write [A, A+B]
  update inode size to A+B
  submit I/O [A, A+BS]
                             write [A+B, A+B+C]
                             update inode size to A+B+C
  <I/O completes, updates disk size to min(A+B+C, A+BS)>
  <power failure>

After reboot:
  1) with A+B+C < A+BS, the file has zero padding in range [A+B, A+B+C]

  |<         Block Size (BS)      >|
  |DDDDDDDDDDDDDDDD0000000000000000|
  ^               ^        ^
  A              A+B     A+B+C
                         (EOF)

  2) with A+B+C > A+BS, the file has zero padding in range [A+B, A+BS]

  |<         Block Size (BS)      >|<           Block Size (BS)    >|
  |DDDDDDDDDDDDDDDD0000000000000000|00000000000000000000000000000000|
  ^               ^                ^               ^
  A              A+B              A+BS           A+B+C
                                  (EOF)

  D = Valid Data
  0 = Zero Padding

The issue stems from disk size being set to min(io_offset + io_size,
inode->i_size) at I/O completion. Since io_offset+io_size is block
size granularity, it may exceed the actual valid file data size. In
the case of concurrent append writes, inode->i_size may be larger
than the actual range of valid file data written to disk, leading to
inaccurate disk size updates.

This patch changes the meaning of io_size to represent the size of
valid data within eof in ioend, while the extent size of ioend can
be obtained by rounding up to block size in wrapper function.
This function is specifically used for ioend grow/merge management:
1. In concurrent writes, when one write's io_size is truncated due
   to non-block-aligned file size while another write extends the file
   size, if these two writes are physically and logically contiguous
   at block boundaries, rounding up io_size to block boundaries helps
   grow the first write's ioend and share this ioend between both
   writes.
2. During IO completion, we try to merge physically and logically
   contiguous ioends before completion to minimize the number of
   transactions. Rounding up io_size to block boundaries helps merge
   ioends whose io_size is not block-aligned.

Another benefit is that it makes the xfs_ioend_is_append() check more
accurate, which can reduce unnecessary end bio callbacks of xfs_end_bio()
in certain scenarios, such as repeated writes at the file tail without
extending the file size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
v3->v4:
  1. collect reviewed tag
  2. Modify the comment of io_size and iomap_ioend_size_aligned().
  3. Add explain of iomap_ioend_size_aligned() to commit message.
 fs/iomap/buffered-io.c | 37 +++++++++++++++++++++++++++++++------
 include/linux/iomap.h  |  2 +-
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d42f01e0fc1c..e59c08c0e529 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1593,12 +1593,24 @@ iomap_finish_ioends(struct iomap_ioend *ioend, int error)
 }
 EXPORT_SYMBOL_GPL(iomap_finish_ioends);
 
+/*
+ * Calculate the physical size of an ioend by rounding up to block granularity.
+ * io_size might be unaligned if the last block crossed an unaligned i_size
+ * boundary at creation time.
+ */
+static inline size_t iomap_ioend_size_aligned(struct iomap_ioend *ioend)
+{
+	return round_up(ioend->io_size, i_blocksize(ioend->io_inode));
+}
+
 /*
  * We can merge two adjacent ioends if they have the same set of work to do.
  */
 static bool
 iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 {
+	size_t size = iomap_ioend_size_aligned(ioend);
+
 	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
 		return false;
 	if (next->io_flags & IOMAP_F_BOUNDARY)
@@ -1609,7 +1621,7 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
 	    (next->io_type == IOMAP_UNWRITTEN))
 		return false;
-	if (ioend->io_offset + ioend->io_size != next->io_offset)
+	if (ioend->io_offset + size != next->io_offset)
 		return false;
 	/*
 	 * Do not merge physically discontiguous ioends. The filesystem
@@ -1621,7 +1633,7 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 	 * submission so does not point to the start sector of the bio at
 	 * completion.
 	 */
-	if (ioend->io_sector + (ioend->io_size >> 9) != next->io_sector)
+	if (ioend->io_sector + (size >> 9) != next->io_sector)
 		return false;
 	return true;
 }
@@ -1638,7 +1650,8 @@ iomap_ioend_try_merge(struct iomap_ioend *ioend, struct list_head *more_ioends)
 		if (!iomap_ioend_can_merge(ioend, next))
 			break;
 		list_move_tail(&next->io_list, &ioend->io_list);
-		ioend->io_size += next->io_size;
+		ioend->io_size = iomap_ioend_size_aligned(ioend) +
+					next->io_size;
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
@@ -1742,7 +1755,7 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
 		return false;
 	if (wpc->iomap.type != wpc->ioend->io_type)
 		return false;
-	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
+	if (pos != wpc->ioend->io_offset + iomap_ioend_size_aligned(wpc->ioend))
 		return false;
 	if (iomap_sector(&wpc->iomap, pos) !=
 	    bio_end_sector(&wpc->ioend->io_bio))
@@ -1774,6 +1787,8 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 {
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
+	loff_t isize = i_size_read(inode);
+	struct iomap_ioend *ioend;
 	int error;
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
@@ -1784,12 +1799,22 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos);
 	}
 
-	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
+	ioend = wpc->ioend;
+	if (!bio_add_folio(&ioend->io_bio, folio, len, poff))
 		goto new_ioend;
 
 	if (ifs)
 		atomic_add(len, &ifs->write_bytes_pending);
-	wpc->ioend->io_size += len;
+
+	/*
+	 * If the ioend spans i_size, trim io_size to the former to provide
+	 * the fs with more accurate size information. This is useful for
+	 * completion time on-disk size updates.
+	 */
+	ioend->io_size = iomap_ioend_size_aligned(ioend) + len;
+	if (ioend->io_offset + ioend->io_size > isize)
+		ioend->io_size = isize - ioend->io_offset;
+
 	wbc_account_cgroup_owner(wbc, folio, len);
 	return 0;
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5675af6b740c..75bf54e76f3b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -335,7 +335,7 @@ struct iomap_ioend {
 	u16			io_type;
 	u16			io_flags;	/* IOMAP_F_* */
 	struct inode		*io_inode;	/* file being written to */
-	size_t			io_size;	/* size of the extent */
+	size_t			io_size;	/* size of data within eof */
 	loff_t			io_offset;	/* offset in the file */
 	sector_t		io_sector;	/* start sector of ioend */
 	struct bio		io_bio;		/* MUST BE LAST! */
-- 
2.39.2


