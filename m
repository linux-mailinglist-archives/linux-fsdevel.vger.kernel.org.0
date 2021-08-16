Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD563EDF01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 23:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhHPVF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 17:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233348AbhHPVF4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:05:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB61B60FC3;
        Mon, 16 Aug 2021 21:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629147925;
        bh=nmau8PmNAO3QDOSYYjkBc5JrlWz9sq74GKPv8NKb+Ao=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jDTgM248cWDA+Yv1LWuIpigu3jzdQTeCUHn8wu7WqfpNeHlddJ4DUFvozFf7By/5b
         vAcgcBepK6g9vFeQyRUwlHNolJlo44oaDqiGzZvmJAN6KxW9uwIe964otlXaorwhmP
         1op7MGkQmmPxDxEqGvWcMUljU8/pwZq7zHErjpTJldfHpxL8MoT8B1DVDsoOdXOlqE
         i/u1dBBuMx+Zwo7WKb4mqLF4yLoyAaGhG/Ss/vC5DkFkcS792qpOzKvg4XEbg6o/N5
         yQTz7ZiibNCc5zRIfuwtuXD3cfDx7g1Z4PiJdXSkgQafcKqIOEC67oaXEbyNKBFqa0
         T5IsDvDF8OHzQ==
Subject: [PATCH 1/2] xfs: use DAX block device zeroout for FSDAX file
 ZERO_RANGE operations
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, jane.chu@oracle.com,
        willy@infradead.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sandeen@sandeen.net
Date:   Mon, 16 Aug 2021 14:05:24 -0700
Message-ID: <162914792458.197065.10399225679278399154.stgit@magnolia>
In-Reply-To: <162914791879.197065.12619905059952917229.stgit@magnolia>
References: <162914791879.197065.12619905059952917229.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Our current "advice" to people using persistent memory and FSDAX who
wish to recover upon receipt of a media error (aka 'hwpoison') event
from ACPI is to punch-hole that part of the file and then pwrite it,
which will magically cause the pmem to be reinitialized and the poison
to be cleared.

Punching doesn't make any sense at all -- the (re)allocation on pwrite
does not permit the caller to specify where to find blocks, which means
that we might not get the same pmem back.  This pushes the user farther
away from the goal of reinitializing poisoned memory and leads to
complaints about unnecessary file fragmentation.

AFAICT, the only reason why the "punch and write" dance works at all is
that the XFS and ext4 currently call blkdev_issue_zeroout when
allocating pmem ahead of a write call.  Even a regular overwrite won't
clear the poison, because dax_direct_access is smart enough to bail out
on poisoned pmem, but not smart enough to clear it.  To be fair, that
function maps pages and has no idea what kinds of reads and writes the
caller might want to perform.

Therefore, create a dax_zeroinit_range function that filesystems can
call from fallocate ZERO RANGE requests to reset the pmem contents to
zero and clear hardware media error flags, and hook it up to XFS.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c            |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_file.c   |   20 ++++++++++++++
 include/linux/dax.h |    7 +++++
 3 files changed, 99 insertions(+)


diff --git a/fs/dax.c b/fs/dax.c
index da41f9363568..fdd7b94f34f0 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1742,3 +1742,75 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 	return dax_insert_pfn_mkwrite(vmf, pfn, order);
 }
 EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
+
+static loff_t
+dax_zeroinit_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
+		struct iomap *iomap, struct iomap *srcmap)
+{
+	sector_t sector = iomap_sector(iomap, pos);
+	int ret;
+
+	if (!iomap->bdev)
+		return -ECANCELED;
+
+	/* Must be able to zero storage directly without fs intervention. */
+	if (iomap->flags & IOMAP_F_SHARED)
+		return -ECANCELED;
+	if (srcmap != iomap)
+		return -ECANCELED;
+
+	switch (iomap->type) {
+	case IOMAP_MAPPED:
+		ret = blkdev_issue_zeroout(iomap->bdev, sector,
+				length >> SECTOR_SHIFT, GFP_KERNEL, 0);
+		if (ret)
+			return ret;
+		fallthrough;
+	case IOMAP_UNWRITTEN:
+		return length;
+	}
+
+	/* Reject holes, inline data, or delalloc extents. */
+	return -ECANCELED;
+}
+
+/*
+ * Initialize storage mapped to a DAX-mode file to a known value and ensure the
+ * media are ready to accept read and write commands.  This requires the use of
+ * the block layer's zeroout function (with zero-page fallback enabled) to
+ * write zeroes to a pmem region and to reset any hardware media error state.
+ *
+ * The range arguments must be aligned to sector size.  The file must be backed
+ * by a block device.  The extents returned must not require copy on write (or
+ * any other mapping interventions from the filesystem) and must be contiguous.
+ * @done will be set to true if the reset succeeded.
+ */
+int
+dax_zeroinit_range(struct inode *inode, loff_t pos, loff_t len, bool *done,
+		const struct iomap_ops *ops)
+{
+	loff_t ret;
+
+	if (!IS_DAX(inode))
+		return -EINVAL;
+	if ((pos | len) & (SECTOR_SIZE - 1))
+		return -EINVAL;
+	if (pos + len > i_size_read(inode))
+		return -EINVAL;
+
+	while (len > 0) {
+		ret = iomap_apply(inode, pos, len, IOMAP_REPORT, ops, NULL,
+				dax_zeroinit_actor);
+		if (ret == -ECANCELED)
+			return 0;
+		if (ret < 0)
+			return ret;
+
+		pos += ret;
+		len -= ret;
+	}
+
+	*done = true;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_zeroinit_range);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index cc3cfb12df53..e77793820cf3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -956,6 +956,25 @@ xfs_file_fallocate(
 			goto out_unlock;
 	}
 
+	/*
+	 * If the file is in DAX mode, try to use a DAX-specific function to
+	 * zero the region.  We can fall back to punch-and-realloc if necessary.
+	 */
+	if ((mode & FALLOC_FL_ZERO_RANGE) && IS_DAX(inode)) {
+		bool	did_zeroout = false;
+
+		trace_xfs_zero_file_space(ip);
+
+		error = dax_zeroinit_range(inode, offset, len, &did_zeroout,
+				&xfs_read_iomap_ops);
+		if (error == -EINVAL)
+			error = 0;
+		if (error)
+			goto out_unlock;
+		if (did_zeroout)
+			goto done;
+	}
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		error = xfs_free_file_space(ip, offset, len);
 		if (error)
@@ -1059,6 +1078,7 @@ xfs_file_fallocate(
 		}
 	}
 
+done:
 	if (file->f_flags & O_DSYNC)
 		flags |= XFS_PREALLOC_SYNC;
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b52f084aa643..df52d0ce0ee0 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -152,6 +152,8 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
+int dax_zeroinit_range(struct inode *inode, loff_t pos, loff_t len, bool *done,
+			const struct iomap_ops *ops);
 #else
 static inline bool bdev_dax_supported(struct block_device *bdev,
 		int blocksize)
@@ -201,6 +203,11 @@ static inline dax_entry_t dax_lock_page(struct page *page)
 static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
 {
 }
+static inline int dax_zeroinit_range(struct inode *inode, loff_t pos, loff_t len,
+		bool *done, const struct iomap_ops *ops)
+{
+	return 0;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_DAX)

