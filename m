Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C8FAFDEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfIKNng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 09:43:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbfIKNng (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:43:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D5DD18CB908;
        Wed, 11 Sep 2019 13:43:35 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17D3D1001944;
        Wed, 11 Sep 2019 13:43:33 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Date:   Wed, 11 Sep 2019 15:43:14 +0200
Message-Id: <20190911134315.27380-9-cmaiolino@redhat.com>
In-Reply-To: <20190911134315.27380-1-cmaiolino@redhat.com>
References: <20190911134315.27380-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Wed, 11 Sep 2019 13:43:35 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enables the usage of FIEMAP ioctl infrastructure to handle FIBMAP calls.
From now on, ->bmap() methods can start to be removed from filesystems
which already provides ->fiemap().

This adds a new helper - bmap_fiemap() - which is used to fill in the
fiemap request, call into the underlying filesystem, check the flags
set in the extent requested.

Add a new fiemap fill extent callback to handle the in-kernel only
fiemap_extent structure used for FIBMAP.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---

With the removal of FIEMAP_KERNEL_FIBMAP flag in this version, we hide
from the filesystem whether the call is coming from FIEMAP, or FIBMAP.

In this way, filesystems that previously did not support FIBMAP (but
supports FIEMAP), may start to support it. It *may* be an issue for
filesystems like btrfs, where we can't say for sure on which device the
requested block resides in. But well, this is also true for FIEMAP
requests.
At a first glance, I didn't see any harm in having FIBMAP enabled in
btrfs, my first worry was about bootloaders trying to use it, but I
don't think it will change much in practice.

Changelog:

	V6:
		- Fix sparse warning on fiemal_fill_kernel_extent:
			Reported-by: kbuild test robot <lkp@intel.com>
		- Fix conflict in ext4
		- Remove the FIEMAP_KERNEL_FIBMAP flag and let the
		  caller decide whether to reply user's FIBMAP call
		  based on the FIEMAP flags returned by the filesystem,
		  suggested by Christoph.

	V5:
		- Properly rebase against 5.3
		- Fix xfs coding style
		- Use xfs_is_cow_inode() check in xfs_vn_fiemap.
			- It needs xfs_reflink.h, but maybe it's better to move
			  static calls into xfs_inode.h
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

 fs/inode.c            | 84 +++++++++++++++++++++++++++++++++++++++++--
 fs/ioctl.c            | 21 +++++------
 fs/ocfs2/extent_map.c |  1 +
 3 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 0a20aaa572f2..ab33d16bc29d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1591,6 +1591,81 @@ void iput(struct inode *inode)
 }
 EXPORT_SYMBOL(iput);
 
+static int fiemap_fill_kernel_extent(struct fiemap_extent_info *fieinfo,
+			u64 logical, u64 phys, u64 len, u32 flags)
+{
+	struct fiemap_extent *extent = fieinfo->fi_cb_data;
+
+	/* only count the extents */
+	if (!fieinfo->fi_cb_data) {
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
+#define FIBMAP_INCOMPAT_FLAGS \
+	(FIEMAP_EXTENT_UNKNOWN | FIEMAP_EXTENT_DELALLOC | \
+	 FIEMAP_EXTENT_ENCODED | FIEMAP_EXTENT_DATA_ENCRYPTED | \
+	 FIEMAP_EXTENT_NOT_ALIGNED | FIEMAP_EXTENT_DATA_INLINE | \
+	 FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_UNWRITTEN | \
+	 FIEMAP_EXTENT_SHARED)
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
+	fieinfo.fi_flags = FIEMAP_FLAG_SYNC;
+
+	error = inode->i_op->fiemap(inode, &fieinfo);
+
+	if (error)
+		return error;
+
+	if (fextent.fe_flags & FIBMAP_INCOMPAT_FLAGS)
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
@@ -1607,10 +1682,15 @@ EXPORT_SYMBOL(iput);
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
index d72696c222de..fbfd631ba3cb 100644
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
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 1a5b6af62ee0..0dd838615d14 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -743,6 +743,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 	unsigned int hole_size;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	u64 len_bytes, phys_bytes, virt_bytes;
+
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_extent_rec rec;
 	u64 map_start = fieinfo->fi_start;
-- 
2.20.1

