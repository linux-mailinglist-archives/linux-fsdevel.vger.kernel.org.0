Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3E3C9FCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 15:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhGONnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 09:43:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59702 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhGONn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:43:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7BDA21FE26;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626356433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEFMUcS9qjUtKezhyR8KVCgUDuuKy80h1wOdNoRHn94=;
        b=KBrOk5LequeM0FN8Q5Sy2x0GnG6DR9O0ak7P/8WZ/2ZuU8WWf9rVSrLxNt5eJZLeXOxiCe
        8r80IozYO7t6LAyRaNUGnaAdzd/FyLtc+hrI4Lu5dYOLeL4cOp+xB+YF/vqF40uzma2Src
        GGe2Me2h+1aMoZxfFREziM1GDehT15o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626356433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEFMUcS9qjUtKezhyR8KVCgUDuuKy80h1wOdNoRHn94=;
        b=h5Q1HCsGJCzTKtWC47Z97uBk3hj2WXAnTbdcqzK0pfMqT/N0yK9yHGV/KvZOpi84vxitRP
        N43q3QGn2MwAaDDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 68331A3B9F;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 224281E0CCF; Thu, 15 Jul 2021 15:40:33 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/14] xfs: Convert double locking of MMAPLOCK to use VFS helpers
Date:   Thu, 15 Jul 2021 15:40:19 +0200
Message-Id: <20210715134032.24868-9-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715133202.5975-1-jack@suse.cz>
References: <20210715133202.5975-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4962; h=from:subject; bh=BkFIeDQJLt3VUlGxHPiHMbNyQjSPAglxlFXoJSefPwA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg8DrDrmnnYiDuJLkZN6B9soYAFPxL773Kba3F9V27 njF+av+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYPA6wwAKCRCcnaoHP2RA2ZwhCA Dl065EY3OZ4xioVDa5sRhZvi9W5w6YVk8vLXfzZDKRb66PCmY+oMO3baxEQDUPCHhhapITjgMTziNv 5w1MmUZL5p7hXqFQm6w6i2zcm9BCZhcAeNCqBKdruxsHGBteGhyBbFyAbQqxqByfNEAIDkF2YylFrS 2wDZw83OIHXDQ61xcwpfKzHMbFXfSLExaxWNKHLlUxKhLwG2WTiwnAuOF/UiKtyG1M6QhQQ4qM96pP i0SpQ0pLa3jYsNIbXwVH6I+wYA9gjZxmaZQIBMmbtCpWvFSryIEveSJ/ah4ysErTcpqKu+m4pJuj7w b/otyB9lNH7lPC2wfP71O8Ekz5Fe1d
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert places in XFS that take MMAPLOCK for two inodes to use helper
VFS provides for it (filemap_invalidate_down_write_two()). Note that
this changes lock ordering for MMAPLOCK from inode number based ordering
to pointer based ordering VFS generally uses.

CC: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_bmap_util.c | 15 ++++++++-------
 fs/xfs/xfs_inode.c     | 37 +++++++++++--------------------------
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 213a97a921bb..1cd3f940fa6a 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1626,7 +1626,6 @@ xfs_swap_extents(
 	struct xfs_bstat	*sbp = &sxp->sx_stat;
 	int			src_log_flags, target_log_flags;
 	int			error = 0;
-	int			lock_flags;
 	uint64_t		f;
 	int			resblks = 0;
 	unsigned int		flags = 0;
@@ -1638,8 +1637,8 @@ xfs_swap_extents(
 	 * do the rest of the checks.
 	 */
 	lock_two_nondirectories(VFS_I(ip), VFS_I(tip));
-	lock_flags = XFS_MMAPLOCK_EXCL;
-	xfs_lock_two_inodes(ip, XFS_MMAPLOCK_EXCL, tip, XFS_MMAPLOCK_EXCL);
+	filemap_invalidate_lock_two(VFS_I(ip)->i_mapping,
+				    VFS_I(tip)->i_mapping);
 
 	/* Verify that both files have the same format */
 	if ((VFS_I(ip)->i_mode & S_IFMT) != (VFS_I(tip)->i_mode & S_IFMT)) {
@@ -1711,7 +1710,6 @@ xfs_swap_extents(
 	 * or cancel will unlock the inodes from this point onwards.
 	 */
 	xfs_lock_two_inodes(ip, XFS_ILOCK_EXCL, tip, XFS_ILOCK_EXCL);
-	lock_flags |= XFS_ILOCK_EXCL;
 	xfs_trans_ijoin(tp, ip, 0);
 	xfs_trans_ijoin(tp, tip, 0);
 
@@ -1830,13 +1828,16 @@ xfs_swap_extents(
 	trace_xfs_swap_extent_after(ip, 0);
 	trace_xfs_swap_extent_after(tip, 1);
 
+out_unlock_ilock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	xfs_iunlock(tip, XFS_ILOCK_EXCL);
 out_unlock:
-	xfs_iunlock(ip, lock_flags);
-	xfs_iunlock(tip, lock_flags);
+	filemap_invalidate_unlock_two(VFS_I(ip)->i_mapping,
+				      VFS_I(tip)->i_mapping);
 	unlock_two_nondirectories(VFS_I(ip), VFS_I(tip));
 	return error;
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
-	goto out_unlock;
+	goto out_unlock_ilock;
 }
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index d6a8ac76b45d..3c0bb21453dc 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -552,12 +552,10 @@ xfs_lock_inodes(
 }
 
 /*
- * xfs_lock_two_inodes() can only be used to lock one type of lock at a time -
- * the mmaplock or the ilock, but not more than one type at a time. If we lock
- * more than one at a time, lockdep will report false positives saying we have
- * violated locking orders.  The iolock must be double-locked separately since
- * we use i_rwsem for that.  We now support taking one lock EXCL and the other
- * SHARED.
+ * xfs_lock_two_inodes() can only be used to lock ilock. The iolock and
+ * mmaplock must be double-locked separately since we use i_rwsem and
+ * invalidate_lock for that. We now support taking one lock EXCL and the
+ * other SHARED.
  */
 void
 xfs_lock_two_inodes(
@@ -575,15 +573,8 @@ xfs_lock_two_inodes(
 	ASSERT(hweight32(ip1_mode) == 1);
 	ASSERT(!(ip0_mode & (XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL)));
 	ASSERT(!(ip1_mode & (XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL)));
-	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
-	       !(ip0_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
-	ASSERT(!(ip1_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
-	       !(ip1_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
-	ASSERT(!(ip1_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
-	       !(ip0_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
-	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
-	       !(ip1_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
-
+	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)));
+	ASSERT(!(ip1_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)));
 	ASSERT(ip0->i_ino != ip1->i_ino);
 
 	if (ip0->i_ino > ip1->i_ino) {
@@ -3748,11 +3739,8 @@ xfs_ilock2_io_mmap(
 	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
 	if (ret)
 		return ret;
-	if (ip1 == ip2)
-		xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
-	else
-		xfs_lock_two_inodes(ip1, XFS_MMAPLOCK_EXCL,
-				    ip2, XFS_MMAPLOCK_EXCL);
+	filemap_invalidate_lock_two(VFS_I(ip1)->i_mapping,
+				    VFS_I(ip2)->i_mapping);
 	return 0;
 }
 
@@ -3762,12 +3750,9 @@ xfs_iunlock2_io_mmap(
 	struct xfs_inode	*ip1,
 	struct xfs_inode	*ip2)
 {
-	bool			same_inode = (ip1 == ip2);
-
-	xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
-	if (!same_inode)
-		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
+	filemap_invalidate_unlock_two(VFS_I(ip1)->i_mapping,
+				      VFS_I(ip2)->i_mapping);
 	inode_unlock(VFS_I(ip2));
-	if (!same_inode)
+	if (ip1 != ip2)
 		inode_unlock(VFS_I(ip1));
 }
-- 
2.26.2

