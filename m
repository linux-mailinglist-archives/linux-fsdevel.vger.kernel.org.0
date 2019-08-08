Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A3385CD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbfHHI2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 04:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731844AbfHHI2O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 679082F30D3;
        Thu,  8 Aug 2019 08:28:13 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-236.brq.redhat.com [10.40.204.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD285C219;
        Thu,  8 Aug 2019 08:28:11 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Date:   Thu,  8 Aug 2019 10:27:43 +0200
Message-Id: <20190808082744.31405-9-cmaiolino@redhat.com>
In-Reply-To: <20190808082744.31405-1-cmaiolino@redhat.com>
References: <20190808082744.31405-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 08 Aug 2019 08:28:13 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enables the usage of FIEMAP ioctl infrastructure to handle FIBMAP calls.
From now on, ->bmap() methods can start to be removed from filesystems
which already provides ->fiemap().

This adds a new helper - bmap_fiemap() - which is used to fill in the
fiemap request, call into the underlying filesystem and check the flags
set in the extent requested.

Add a new fiemap fill extent callback to handle the in-kernel only
fiemap_extent structure used for FIBMAP.

The new FIEMAP_KERNEL_FIBMAP flag, is used to tell the filesystem
->fiemap interface, that the call is coming from ioctl_fibmap. The
addition of this new flag, requires an update to fiemap_check_flags(),
so it doesn't treat FIBMAP requests as invalid.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
Changelog:

	V5:
		- Properly rebase against 5.3
		- Fix xfs coding style
		- Use xfs_is_cow_inode() check in xfs_vn_fiemap.
		- Fix small conflict due indentation update in xfs_vn_fiemap
	V4:
		- Fix if conditional in bmap()
		- Add filesystem-specific modifications
	V3:
		- Add FIEMAP_EXTENT_SHARED to the list of invalid extents in
		  bmap_fiemap()
		- Rename fi_extents_start to fi_cb_data
		- Use if conditional instead of ternary operator
		- Make fiemap_fill_* callbacks static (which required the
		  removal of some macros
		- Set FIEMAP_FLAG_SYNC when calling in ->fiemap method from
		  fibmap
		- Add FIEMAP_KERNEL_FIBMAP flag, to identify the usage of fiemap
		  infrastructure for fibmap calls, defined in fs.h so it's not
		  exported to userspace.
		- Update fiemap_check_flags() to understand FIEMAP_KERNEL_FIBMAP
		- Update filesystems supporting both FIBMAP and FIEMAP, which
		  need extra checks on FIBMAP calls

	V2:
		- Now based on the updated fiemap_extent_info,
		- move the fiemap call itself to a new helper

 fs/ext4/extents.c     |  7 +++-
 fs/f2fs/data.c        | 10 +++++-
 fs/gfs2/inode.c       |  6 +++-
 fs/inode.c            | 81 +++++++++++++++++++++++++++++++++++++++++--
 fs/ioctl.c            | 40 ++++++++++++++-------
 fs/iomap/fiemap.c     |  2 +-
 fs/ocfs2/extent_map.c |  8 ++++-
 fs/xfs/xfs_iops.c     |  6 ++++
 include/linux/fs.h    |  4 +++
 9 files changed, 145 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 300339d1cd62..06160279a842 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5018,7 +5018,9 @@ static int ext4_find_delayed_extent(struct inode *inode,
 	return next_del;
 }
 /* fiemap flags we can handle specified here */
-#define EXT4_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR)
+#define EXT4_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC | \
+				 FIEMAP_FLAG_XATTR| \
+				 FIEMAP_KERNEL_FIBMAP)
 
 static int ext4_xattr_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo)
@@ -5065,6 +5067,9 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 	if (ext4_has_inline_data(inode)) {
 		int has_inline = 1;
 
+		if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP)
+			return -EINVAL;
+
 		error = ext4_inline_data_fiemap(inode, fieinfo, &has_inline,
 						start, len);
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 83e8c2d4a7a9..439863c84b34 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1476,6 +1476,9 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 	return (err < 0 ? err : 0);
 }
 
+#define F2FS_FIEMAP_COMPAT	(FIEMAP_FLAG_SYNC | \
+				 FIEMAP_FLAG_XATTR| \
+				 FIEMAP_KERNEL_FIBMAP)
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 {
 	u64 start = fieinfo->fi_start;
@@ -1493,7 +1496,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 			return ret;
 	}
 
-	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
+	ret = fiemap_check_flags(fieinfo, F2FS_FIEMAP_COMPAT);
 	if (ret)
 		return ret;
 
@@ -1505,6 +1508,11 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 	}
 
 	if (f2fs_has_inline_data(inode)) {
+
+		ret = -EINVAL;
+		if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP)
+			goto out;
+
 		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
 		if (ret != -EAGAIN)
 			goto out;
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index dc192dfd8941..a8d1c0a29b45 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2013,7 +2013,11 @@ static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 	if (ret)
 		goto out;
 
-	ret = iomap_fiemap(inode, fieinfo, &gfs2_iomap_ops);
+	if (gfs2_is_stuffed(ip) &&
+	    (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP))
+		ret = -EINVAL;
+	else
+		ret = iomap_fiemap(inode, fieinfo, &gfs2_iomap_ops);
 
 	gfs2_glock_dq_uninit(&gh);
 
diff --git a/fs/inode.c b/fs/inode.c
index 5dfe5e4bfa50..7a7a9f179639 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1588,6 +1588,78 @@ void iput(struct inode *inode)
 }
 EXPORT_SYMBOL(iput);
 
+static int fiemap_fill_kernel_extent(struct fiemap_extent_info *fieinfo,
+			u64 logical, u64 phys, u64 len, u32 flags)
+{
+	struct fiemap_extent *extent = fieinfo->fi_cb_data;
+
+	/* only count the extents */
+	if (fieinfo->fi_cb_data == 0) {
+		fieinfo->fi_extents_mapped++;
+		goto out;
+	}
+
+	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
+		return 1;
+
+	if (flags & FIEMAP_EXTENT_DELALLOC)
+		flags |= FIEMAP_EXTENT_UNKNOWN;
+	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
+		flags |= FIEMAP_EXTENT_ENCODED;
+	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
+		flags |= FIEMAP_EXTENT_NOT_ALIGNED;
+
+	extent->fe_logical = logical;
+	extent->fe_physical = phys;
+	extent->fe_length = len;
+	extent->fe_flags = flags;
+
+	fieinfo->fi_extents_mapped++;
+
+	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
+		return 1;
+
+out:
+	if (flags & FIEMAP_EXTENT_LAST)
+		return 1;
+	return 0;
+}
+
+static int bmap_fiemap(struct inode *inode, sector_t *block)
+{
+	struct fiemap_extent_info fieinfo = { 0, };
+	struct fiemap_extent fextent;
+	u64 start = *block << inode->i_blkbits;
+	int error = -EINVAL;
+
+	fextent.fe_logical = 0;
+	fextent.fe_physical = 0;
+	fieinfo.fi_extents_max = 1;
+	fieinfo.fi_extents_mapped = 0;
+	fieinfo.fi_cb_data = &fextent;
+	fieinfo.fi_start = start;
+	fieinfo.fi_len = 1 << inode->i_blkbits;
+	fieinfo.fi_cb = fiemap_fill_kernel_extent;
+	fieinfo.fi_flags = (FIEMAP_KERNEL_FIBMAP | FIEMAP_FLAG_SYNC);
+
+	error = inode->i_op->fiemap(inode, &fieinfo);
+
+	if (error)
+		return error;
+
+	if (fieinfo.fi_flags & (FIEMAP_EXTENT_UNKNOWN |
+				FIEMAP_EXTENT_ENCODED |
+				FIEMAP_EXTENT_DATA_INLINE |
+				FIEMAP_EXTENT_UNWRITTEN |
+				FIEMAP_EXTENT_SHARED))
+		return -EINVAL;
+
+	*block = (fextent.fe_physical +
+		  (start - fextent.fe_logical)) >> inode->i_blkbits;
+
+	return error;
+}
+
 /**
  *	bmap	- find a block number in a file
  *	@inode:  inode owning the block number being requested
@@ -1604,10 +1676,15 @@ EXPORT_SYMBOL(iput);
  */
 int bmap(struct inode *inode, sector_t *block)
 {
-	if (!inode->i_mapping->a_ops->bmap)
+	if (inode->i_op->fiemap)
+		return bmap_fiemap(inode, block);
+
+	if (inode->i_mapping->a_ops->bmap)
+		*block = inode->i_mapping->a_ops->bmap(inode->i_mapping,
+						       *block);
+	else
 		return -EINVAL;
 
-	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
 	return 0;
 }
 EXPORT_SYMBOL(bmap);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index d72696c222de..0759ac6e4c7e 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -77,11 +77,8 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 	return error;
 }
 
-#define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
-#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
-#define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
-int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
-			    u64 phys, u64 len, u32 flags)
+static int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo,
+			u64 logical, u64 phys, u64 len, u32 flags)
 {
 	struct fiemap_extent extent;
 	struct fiemap_extent __user *dest = fieinfo->fi_cb_data;
@@ -89,17 +86,17 @@ int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 	/* only count the extents */
 	if (fieinfo->fi_extents_max == 0) {
 		fieinfo->fi_extents_mapped++;
-		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
+		goto out;
 	}
 
 	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
 		return 1;
 
-	if (flags & SET_UNKNOWN_FLAGS)
+	if (flags & FIEMAP_EXTENT_DELALLOC)
 		flags |= FIEMAP_EXTENT_UNKNOWN;
-	if (flags & SET_NO_UNMOUNTED_IO_FLAGS)
+	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
 		flags |= FIEMAP_EXTENT_ENCODED;
-	if (flags & SET_NOT_ALIGNED_FLAGS)
+	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
 		flags |= FIEMAP_EXTENT_NOT_ALIGNED;
 
 	memset(&extent, 0, sizeof(extent));
@@ -115,7 +112,11 @@ int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 	fieinfo->fi_extents_mapped++;
 	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
 		return 1;
-	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
+
+out:
+	if (flags & FIEMAP_EXTENT_LAST)
+		return 1;
+	return 0;
 }
 
 /**
@@ -151,13 +152,23 @@ EXPORT_SYMBOL(fiemap_fill_next_extent);
  * flags, the invalid values will be written into the fieinfo structure, and
  * -EBADR is returned, which tells ioctl_fiemap() to return those values to
  * userspace. For this reason, a return code of -EBADR should be preserved.
+ * In case ->fiemap is being used for FIBMAP calls, and the filesystem does not
+ * support it, return -EINVAL.
  *
- * Returns 0 on success, -EBADR on bad flags.
+ * Returns 0 on success, -EBADR on bad flags, -EINVAL for an unsupported FIBMAP
+ * request.
  */
 int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags)
 {
 	u32 incompat_flags;
 
+	if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP) {
+		if (fs_flags & FIEMAP_KERNEL_FIBMAP)
+			return 0;
+
+		return -EINVAL;
+	}
+
 	incompat_flags = fieinfo->fi_flags & ~(FIEMAP_FLAGS_COMPAT & fs_flags);
 	if (incompat_flags) {
 		fieinfo->fi_flags = incompat_flags;
@@ -208,6 +219,10 @@ static int ioctl_fiemap(struct file *filp, unsigned long arg)
 	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
 		return -EINVAL;
 
+	/* Userspace has no access to this flag */
+	if (fiemap.fm_flags & FIEMAP_KERNEL_FIBMAP)
+		return -EINVAL;
+
 	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
 				    &len);
 	if (error)
@@ -318,7 +333,8 @@ int __generic_block_fiemap(struct inode *inode,
 	bool past_eof = false, whole_file = false;
 	int ret = 0;
 
-	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
+	ret = fiemap_check_flags(fieinfo,
+				 FIEMAP_FLAG_SYNC | FIEMAP_KERNEL_FIBMAP);
 	if (ret)
 		return ret;
 
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 03f214f5df94..7116c451e67a 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -76,7 +76,7 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
 	ctx.fi = fi;
 	ctx.prev.type = IOMAP_HOLE;
 
-	ret = fiemap_check_flags(fi, FIEMAP_FLAG_SYNC);
+	ret = fiemap_check_flags(fi, FIEMAP_FLAG_SYNC | FIEMAP_KERNEL_FIBMAP);
 	if (ret)
 		return ret;
 
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 1a5b6af62ee0..7d8ff6888c0d 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -734,7 +734,7 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 	return 0;
 }
 
-#define OCFS2_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
+#define OCFS2_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC | FIEMAP_KERNEL_FIBMAP)
 
 int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 {
@@ -743,6 +743,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 	unsigned int hole_size;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	u64 len_bytes, phys_bytes, virt_bytes;
+
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_extent_rec rec;
 	u64 map_start = fieinfo->fi_start;
@@ -752,6 +753,11 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 	if (ret)
 		return ret;
 
+	if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP) {
+		if (ocfs2_is_refcount_inode(inode))
+			return -EINVAL;
+	}
+
 	ret = ocfs2_inode_lock(inode, &di_bh, 0);
 	if (ret) {
 		mlog_errno(ret);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 514c4620a9e8..e43742fe101a 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -20,6 +20,7 @@
 #include "xfs_symlink.h"
 #include "xfs_dir2.h"
 #include "xfs_iomap.h"
+#include "xfs_reflink.h"
 
 #include <linux/xattr.h>
 #include <linux/posix_acl.h>
@@ -1102,8 +1103,13 @@ xfs_vn_fiemap(
 	struct inode			*inode,
 	struct fiemap_extent_info	*fieinfo)
 {
+	struct xfs_inode		*ip = XFS_I(inode);
 	int				error;
 
+	if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP)
+		if (xfs_is_cow_inode(ip) || XFS_IS_REALTIME_INODE(ip))
+			return -EINVAL;
+
 	xfs_ilock(XFS_I(inode), XFS_IOLOCK_SHARED);
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5f37f13be260..30aa65fc5ac4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1716,6 +1716,10 @@ extern bool may_open_dev(const struct path *path);
 typedef int (*fiemap_fill_cb)(struct fiemap_extent_info *fieinfo, u64 logical,
 			      u64 phys, u64 len, u32 flags);
 
+#define FIEMAP_KERNEL_FIBMAP 0x10000000		/* FIBMAP call through FIEMAP
+						   interface. This is a kernel
+						   only flag */
+
 struct fiemap_extent_info {
 	unsigned int	fi_flags;		/* Flags as passed from user */
 	u64		fi_start;		/* Logical offset at which
-- 
2.20.1

