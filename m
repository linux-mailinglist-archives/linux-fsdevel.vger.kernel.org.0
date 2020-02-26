Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8139A170041
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgBZNlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:41:25 -0500
Received: from relay.sw.ru ([185.231.240.75]:44738 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBZNlY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:41:24 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j6wvm-0006rH-Qw; Wed, 26 Feb 2020 16:40:54 +0300
Subject: [PATCH RFC 1/5] fs: Add new argument to file_operations::fallocate()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        ktkhai@virtuozzo.com, dmonakhov@gmail.com,
        mbobrowski@mbobrowski.org, enwlinux@gmail.com, sblbir@amazon.com,
        khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 26 Feb 2020 16:40:54 +0300
Message-ID: <158272445470.281342.8801644318823700525.stgit@localhost.localdomain>
In-Reply-To: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After the patch the prototype will look in the following way:

long (*fallocate)(struct file *file, int mode, loff_t offset,
		  loff_t len, u64 physical);

@physical is the new argument. This patch does not contain
functional changes, and it will be used in further patches.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 drivers/block/loop.c              |    2 +-
 drivers/staging/android/ashmem.c  |    2 +-
 drivers/target/target_core_file.c |    2 +-
 fs/block_dev.c                    |    4 ++--
 fs/btrfs/file.c                   |    4 +++-
 fs/ceph/file.c                    |    5 ++++-
 fs/cifs/cifsfs.c                  |    7 ++++---
 fs/cifs/smb2ops.c                 |    5 ++++-
 fs/ext4/ext4.h                    |    2 +-
 fs/ext4/extents.c                 |    6 +++++-
 fs/f2fs/file.c                    |    4 +++-
 fs/fat/file.c                     |    7 +++++--
 fs/fuse/file.c                    |    5 ++++-
 fs/gfs2/file.c                    |    5 ++++-
 fs/hugetlbfs/inode.c              |    5 ++++-
 fs/nfs/nfs4file.c                 |    6 +++++-
 fs/ocfs2/file.c                   |    4 +++-
 fs/open.c                         |    2 +-
 fs/overlayfs/file.c               |    6 +++++-
 fs/xfs/xfs_file.c                 |    5 ++++-
 include/linux/fs.h                |    2 +-
 ipc/shm.c                         |    6 +++---
 mm/shmem.c                        |    4 +++-
 23 files changed, 71 insertions(+), 29 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da8ec0b9d909..6416111a2ae1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -438,7 +438,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 		goto out;
 	}
 
-	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
+	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq), (u64)-1);
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		ret = -EIO;
  out:
diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 8044510d8ec6..ea05ff484ebe 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -489,7 +489,7 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		mutex_unlock(&ashmem_mutex);
 		f->f_op->fallocate(f,
 				   FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				   start, end - start);
+				   start, end - start, (u64)-1);
 		fput(f);
 		if (atomic_dec_and_test(&ashmem_shrink_inflight))
 			wake_up_all(&ashmem_shrink_wait);
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 7143d03f0e02..feafb731bbd9 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -581,7 +581,7 @@ fd_execute_unmap(struct se_cmd *cmd, sector_t lba, sector_t nolb)
 		if (!file->f_op->fallocate)
 			return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
-		ret = file->f_op->fallocate(file, mode, pos, len);
+		ret = file->f_op->fallocate(file, mode, pos, len, (u64)-1);
 		if (ret < 0) {
 			pr_warn("FILEIO: fallocate() failed: %d\n", ret);
 			return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..d356f7d7f666 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2078,7 +2078,7 @@ static const struct address_space_operations def_blk_aops = {
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
 
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
-			     loff_t len)
+			     loff_t len, u64 physical)
 {
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
 	struct address_space *mapping;
@@ -2087,7 +2087,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	int error;
 
 	/* Fail if we don't recognize the flags. */
-	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
+	if ((mode & ~BLKDEV_FALLOC_FL_SUPPORTED) || physical != (u64)-1)
 		return -EOPNOTSUPP;
 
 	/* Don't go off the end of the device. */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6f6f1805e6fd..5d80da6d14eb 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3174,7 +3174,7 @@ static int btrfs_zero_range(struct inode *inode,
 }
 
 static long btrfs_fallocate(struct file *file, int mode,
-			    loff_t offset, loff_t len)
+			    loff_t offset, loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(file);
 	struct extent_state *cached_state = NULL;
@@ -3201,6 +3201,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
 		return -EOPNOTSUPP;
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		return btrfs_punch_hole(inode, offset, len);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 7e0190b1f821..948694b478a4 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1775,7 +1775,7 @@ static int ceph_zero_objects(struct inode *inode, loff_t offset, loff_t length)
 }
 
 static long ceph_fallocate(struct file *file, int mode,
-				loff_t offset, loff_t length)
+				loff_t offset, loff_t length, u64 physical)
 {
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file_inode(file);
@@ -1790,6 +1790,9 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (mode != (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
+
 	if (!S_ISREG(inode->i_mode))
 		return -EOPNOTSUPP;
 
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index fa77fe5258b0..ddf7888798af 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -281,14 +281,15 @@ cifs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static long cifs_fallocate(struct file *file, int mode, loff_t off, loff_t len)
+static long cifs_fallocate(struct file *file, int mode,
+			   loff_t off, loff_t len, u64 physical)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(file);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 	struct TCP_Server_Info *server = tcon->ses->server;
 
-	if (server->ops->fallocate)
-		return server->ops->fallocate(file, tcon, mode, off, len);
+	if (server->ops->fallocate && physical != (u64)-1)
+		return server->ops->fallocate(file, tcon, mode, off, len, (u64)-1);
 
 	return -EOPNOTSUPP;
 }
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 5fa34225a99b..30cb1b911ebf 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3460,8 +3460,11 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
 }
 
 static long smb3_fallocate(struct file *file, struct cifs_tcon *tcon, int mode,
-			   loff_t off, loff_t len)
+			   loff_t off, loff_t len, u64 physical)
 {
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
+
 	/* KEEP_SIZE already checked for by do_fallocate */
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		return smb3_punch_hole(file, tcon, off, len);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 61b37a052052..5a98081c5369 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3347,7 +3347,7 @@ extern int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 extern void ext4_ext_init(struct super_block *);
 extern void ext4_ext_release(struct super_block *);
 extern long ext4_fallocate(struct file *file, int mode, loff_t offset,
-			  loff_t len);
+			  loff_t len, u64 physical);
 extern int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 					  loff_t offset, ssize_t len);
 extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 954013d6076b..10d0188a712d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4835,7 +4835,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
  * of writing zeroes to the required new blocks (the same behavior which is
  * expected for file systems which do not support fallocate() system call).
  */
-long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+long ext4_fallocate(struct file *file, int mode,
+		    loff_t offset, loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(file);
 	loff_t new_size = 0;
@@ -4861,6 +4862,9 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
+
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		return ext4_punch_hole(inode, offset, len);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0d4da644df3b..2dfd886a2e75 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1685,7 +1685,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 }
 
 static long f2fs_fallocate(struct file *file, int mode,
-				loff_t offset, loff_t len)
+			   loff_t offset, loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(file);
 	long ret = 0;
@@ -1696,6 +1696,8 @@ static long f2fs_fallocate(struct file *file, int mode,
 		return -ENOSPC;
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
 
 	/* f2fs only support ->fallocate for regular file */
 	if (!S_ISREG(inode->i_mode))
diff --git a/fs/fat/file.c b/fs/fat/file.c
index bdc4503c00a3..4febd1e4f5af 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -19,7 +19,7 @@
 #include "fat.h"
 
 static long fat_fallocate(struct file *file, int mode,
-			  loff_t offset, loff_t len);
+			  loff_t offset, loff_t len, u64 physical);
 
 static int fat_ioctl_get_attributes(struct inode *inode, u32 __user *user_attr)
 {
@@ -257,7 +257,7 @@ static int fat_cont_expand(struct inode *inode, loff_t size)
  * allocate and zero out clusters via an expanding truncate.
  */
 static long fat_fallocate(struct file *file, int mode,
-			  loff_t offset, loff_t len)
+			  loff_t offset, loff_t len, u64 physical)
 {
 	int nr_cluster; /* Number of clusters to be allocated */
 	loff_t mm_bytes; /* Number of bytes to be allocated for file */
@@ -271,6 +271,9 @@ static long fat_fallocate(struct file *file, int mode,
 	if (mode & ~FALLOC_FL_KEEP_SIZE)
 		return -EOPNOTSUPP;
 
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
+
 	/* No support for dir */
 	if (!S_ISREG(inode->i_mode))
 		return -EOPNOTSUPP;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d67b830fb7a..5981ad057b7c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3166,7 +3166,7 @@ static int fuse_writeback_range(struct inode *inode, loff_t start, loff_t end)
 }
 
 static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
-				loff_t length)
+				loff_t length, u64 physical)
 {
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
@@ -3186,6 +3186,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
+
 	if (fc->no_fallocate)
 		return -EOPNOTSUPP;
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index cb26be6f4351..40f958ea0fde 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1114,7 +1114,8 @@ static long __gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t
 	return error;
 }
 
-static long gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+static long gfs2_fallocate(struct file *file, int mode,
+			   loff_t offset, loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(file);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
@@ -1127,6 +1128,8 @@ static long gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	/* fallocate is needed by gfs2_grow to reserve space in the rindex */
 	if (gfs2_is_jdata(ip) && inode != sdp->sd_rindex)
 		return -EOPNOTSUPP;
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
 
 	inode_lock(inode);
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index aff8642f0c2e..98d9af6529fa 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -563,7 +563,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 }
 
 static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
-				loff_t len)
+				loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(file);
 	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
@@ -580,6 +580,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
+
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		return hugetlbfs_punch_hole(inode, offset, len);
 
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1297919e0fce..51061872e9fc 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -214,7 +214,8 @@ static loff_t nfs4_file_llseek(struct file *filep, loff_t offset, int whence)
 	}
 }
 
-static long nfs42_fallocate(struct file *filep, int mode, loff_t offset, loff_t len)
+static long nfs42_fallocate(struct file *filep, int mode,
+			    loff_t offset, loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(filep);
 	long ret;
@@ -225,6 +226,9 @@ static long nfs42_fallocate(struct file *filep, int mode, loff_t offset, loff_t
 	if ((mode != 0) && (mode != (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)))
 		return -EOPNOTSUPP;
 
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
+
 	ret = inode_newsize_ok(inode, offset + len);
 	if (ret < 0)
 		return ret;
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 6cd5e4924e4d..a749ff71b8e4 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2022,7 +2022,7 @@ int ocfs2_change_file_space(struct file *file, unsigned int cmd,
 }
 
 static long ocfs2_fallocate(struct file *file, int mode, loff_t offset,
-			    loff_t len)
+			    loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(file);
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
@@ -2032,6 +2032,8 @@ static long ocfs2_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
 	if (!ocfs2_writes_unwritten_extents(osb))
 		return -EOPNOTSUPP;
 
diff --git a/fs/open.c b/fs/open.c
index 0788b3715731..73f27c9b518c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -306,7 +306,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		return -EOPNOTSUPP;
 
 	file_start_write(file);
-	ret = file->f_op->fallocate(file, mode, offset, len);
+	ret = file->f_op->fallocate(file, mode, offset, len, (u64)-1);
 
 	/*
 	 * Create inotify and fanotify events.
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index a5317216de73..abe34162d9d4 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -460,13 +460,17 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 	return ret;
 }
 
-static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+static long ovl_fallocate(struct file *file, int mode,
+			  loff_t offset, loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(file);
 	struct fd real;
 	const struct cred *old_cred;
 	int ret;
 
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
+
 	ret = ovl_real_fdget(file, &real);
 	if (ret)
 		return ret;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b8a4a3f29b36..61ca96469fa0 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -802,7 +802,8 @@ xfs_file_fallocate(
 	struct file		*file,
 	int			mode,
 	loff_t			offset,
-	loff_t			len)
+	loff_t			len,
+	u64			physical)
 {
 	struct inode		*inode = file_inode(file);
 	struct xfs_inode	*ip = XFS_I(inode);
@@ -816,6 +817,8 @@ xfs_file_fallocate(
 		return -EINVAL;
 	if (mode & ~XFS_FALLOC_FL_SUPPORTED)
 		return -EOPNOTSUPP;
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
 
 	xfs_ilock(ip, iolock);
 	error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f814ccd8d929..17c111e164d2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1846,7 +1846,7 @@ struct file_operations {
 	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
 	int (*setlease)(struct file *, long, struct file_lock **, void **);
 	long (*fallocate)(struct file *file, int mode, loff_t offset,
-			  loff_t len);
+			  loff_t len, u64 physical);
 	void (*show_fdinfo)(struct seq_file *m, struct file *f);
 #ifndef CONFIG_MMU
 	unsigned (*mmap_capabilities)(struct file *);
diff --git a/ipc/shm.c b/ipc/shm.c
index ce1ca9f7c6e9..3ab15a1c2d91 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -532,13 +532,13 @@ static int shm_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 }
 
 static long shm_fallocate(struct file *file, int mode, loff_t offset,
-			  loff_t len)
+			  loff_t len, u64 physical)
 {
 	struct shm_file_data *sfd = shm_file_data(file);
 
-	if (!sfd->file->f_op->fallocate)
+	if (!sfd->file->f_op->fallocate || physical != (u64)-1)
 		return -EOPNOTSUPP;
-	return sfd->file->f_op->fallocate(file, mode, offset, len);
+	return sfd->file->f_op->fallocate(file, mode, offset, len, (u64)-1);
 }
 
 static unsigned long shm_get_unmapped_area(struct file *file,
diff --git a/mm/shmem.c b/mm/shmem.c
index 31b4bcc95f17..a07afc5b06d0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2724,7 +2724,7 @@ static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 }
 
 static long shmem_fallocate(struct file *file, int mode, loff_t offset,
-							 loff_t len)
+			    loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(file);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
@@ -2735,6 +2735,8 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
+	if (physical != (u64)-1)
+		return -EOPNOTSUPP;
 
 	inode_lock(inode);
 


