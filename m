Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52814102AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 03:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhIRBcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 21:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235000AbhIRBcS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 21:32:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F3966112E;
        Sat, 18 Sep 2021 01:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631928656;
        bh=nEus6JVO0rVrNO4U1GpVQsTU6C8NnLDQuj58n91u7wU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A7yBcdRNgMFJa3es62kKFc8ydkygnm9GiEU3ifw7DNZ9RHQUZQgD2QsBZZtYVkVW4
         kXjrbGGNZiwOh3jDPcZmXJ1HjX0zLGPEaLKtLXq+oepq91u1dO5+umcTZsJg13sZ0j
         SOHGIKQTkTvrw1EAu+2qVHMAMQ0GOoFOabP+4m5TP3KlYnAEGRxiBvGBtznZsGdGrG
         y8vi2kOS+eQArmE1KBcxEPecXCL1r0ZCg4ksghCwof51hOY9f6VJ0su6dd/optJHCN
         yp5CpdkdEt7HNFu4PfhsmHLXGkp72cDXQZ9hjAn9ajqT+3O0oTpl/EtK++ty3OqWsf
         Kh1djwgmXTQwg==
Subject: [PATCH 2/5] iomap: use accelerated zeroing on a block device to zero
 a file range
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, jane.chu@oracle.com
Cc:     linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Date:   Fri, 17 Sep 2021 18:30:55 -0700
Message-ID: <163192865577.417973.11122330974455662098.stgit@magnolia>
In-Reply-To: <163192864476.417973.143014658064006895.stgit@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Create a function that ensures that the storage backing part of a file
contains zeroes and will not trip over old media errors if the contents
are re-read.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/direct-io.c  |   75 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iomap.h |    3 ++
 2 files changed, 78 insertions(+)


diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4ecd255e0511..48826a49f976 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -652,3 +652,78 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	return iomap_dio_complete(dio);
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
+
+static loff_t
+iomap_zeroinit_iter(struct iomap_iter *iter)
+{
+	struct iomap *iomap = &iter->iomap;
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	const u64 start = iomap->addr + iter->pos - iomap->offset;
+	const u64 nr_bytes = iomap_length(iter);
+	sector_t sector = start >> SECTOR_SHIFT;
+	sector_t nr_sectors = nr_bytes >> SECTOR_SHIFT;
+	int ret;
+
+	if (!iomap->bdev)
+		return -ECANCELED;
+
+	/* The physical extent must be sector-aligned for block layer APIs. */
+	if ((start | nr_bytes) & (SECTOR_SIZE - 1))
+		return -EINVAL;
+
+	/* Must be able to zero storage directly without fs intervention. */
+	if (iomap->flags & IOMAP_F_SHARED)
+		return -ECANCELED;
+	if (srcmap != iomap)
+		return -ECANCELED;
+
+	switch (iomap->type) {
+	case IOMAP_MAPPED:
+		ret = blkdev_issue_zeroout(iomap->bdev, sector, nr_sectors,
+				GFP_KERNEL, 0);
+		if (ret)
+			return ret;
+		fallthrough;
+	case IOMAP_UNWRITTEN:
+		return nr_bytes;
+	}
+
+	/* Reject holes, inline data, or delalloc extents. */
+	return -ECANCELED;
+}
+
+/*
+ * Use a storage device's accelerated zero-writing command to ensure the media
+ * are ready to accept read and write commands.  FSDAX is not supported.
+ *
+ * The range arguments must be aligned to sector size.  The file must be backed
+ * by a block device.  The extents returned must not require copy on write (or
+ * any other mapping interventions from the filesystem) and must be contiguous.
+ * @done will be set to true if the reset succeeded.
+ *
+ * Returns 0 if the zero initialization succeeded, -ECANCELED if the storage
+ * mappings do not support zero initialization, -EOPNOTSUPP if the device does
+ * not support it, or the usual negative errno.
+ */
+int
+iomap_zeroout_range(struct inode *inode, loff_t pos, u64 len,
+		   const struct iomap_ops *ops)
+{
+	struct iomap_iter iter = {
+		.inode		= inode,
+		.pos		= pos,
+		.len		= len,
+		.flags		= IOMAP_REPORT,
+	};
+	int ret;
+
+	if (IS_DAX(inode))
+		return -EINVAL;
+	if (pos + len > i_size_read(inode))
+		return -EINVAL;
+
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = iomap_zeroinit_iter(&iter);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iomap_zeroout_range);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 24f8489583ca..f4b9c6698388 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -339,6 +339,9 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
+int iomap_zeroout_range(struct inode *inode, loff_t pos, u64 len,
+		const struct iomap_ops *ops);
+
 #ifdef CONFIG_SWAP
 struct file;
 struct swap_info_struct;

