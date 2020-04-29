Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466F81BD25E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgD2Cok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:44:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38382 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2Coj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:44:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2ibu8122095;
        Wed, 29 Apr 2020 02:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jk8EPYg3gUBxdiB0ZPxBzPkSOBbhlCvMSpzZSp9mc3Y=;
 b=gfPq8EKisCoo2kUL/B692ceNG2qGt5s9t9apJoxCj2CoYrcq4zPnkozydTHRnG4TjETE
 4joH35KKioAGtxFvEiqPi1UmONrSmXUiH+DCtScTjEafUAHunzrTaQZf5sB2wQkcjw7u
 7siw+zIuJoQMsMu+K4fzcrW43ZxAqonKK5p5Ckl9IZgUORoSv9i9WkbG85PjGF6lqFnF
 4n/tmhhxnROFf1inhjLm41eLQXaI75HgP4Xo0msraiiHZnzJBuOZIL7P7At+NBjIB9Ro
 voP7jgGdzHKHONRIdSdaz+nkJ5V4WGOVWtvd9weBbqtW6wXpsh+fX8oyTmBhic80kEuA +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30p2p08p1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:44:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2g4jm039276;
        Wed, 29 Apr 2020 02:44:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30mxru03tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:44:35 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03T2iYxD003471;
        Wed, 29 Apr 2020 02:44:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:44:34 -0700
Subject: [PATCH 03/18] vfs: introduce new file extent swap ioctl
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:44:33 -0700
Message-ID: <158812827320.168506.17255602633619684843.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=1
 mlxlogscore=807 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=1 mlxlogscore=862 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Introduce a new ioctl to handle swapping extents between two files.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/ioctl.c              |   32 ++++++++
 fs/read_write.c         |  188 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_fs.h  |    1 
 include/linux/fs.h      |   15 ++++
 include/uapi/linux/fs.h |   55 ++++++++++++++
 mm/filemap.c            |   77 +++++++++++++++++++
 6 files changed, 367 insertions(+), 1 deletion(-)


diff --git a/fs/ioctl.c b/fs/ioctl.c
index 282d45be6f45..f564e6f2fad5 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -268,6 +268,35 @@ static long ioctl_file_clone_range(struct file *file,
 				args.src_length, args.dest_offset);
 }
 
+static long ioctl_file_swap_range(struct file *file2,
+				  struct file_swap_range __user *argp)
+{
+	struct file_swap_range args;
+	struct fd file1;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	file1 = fdget(args.file1_fd);
+	if (!file1.file)
+		return -EBADF;
+
+	ret = -EXDEV;
+	if (file1.file->f_path.mnt != file2->f_path.mnt)
+		goto fdput;
+
+	ret = vfs_swap_file_range(file1.file, file2, &args);
+	if (ret)
+		goto fdput;
+
+	if (copy_to_user(argp, &args, sizeof(args)))
+		ret = -EFAULT;
+fdput:
+	fdput(file1);
+	return ret;
+}
+
 #ifdef CONFIG_BLOCK
 
 static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
@@ -730,6 +759,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	case FIDEDUPERANGE:
 		return ioctl_file_dedupe_range(filp, argp);
 
+	case FISWAPRANGE:
+		return ioctl_file_swap_range(filp, argp);
+
 	case FIONREAD:
 		if (!S_ISREG(inode->i_mode))
 			return vfs_ioctl(filp, cmd, arg);
diff --git a/fs/read_write.c b/fs/read_write.c
index bbfa9b12b15e..2b5116f129de 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -2081,6 +2081,92 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 }
 EXPORT_SYMBOL(generic_remap_file_range_prep);
 
+/*
+ * Check that the two inodes are eligible for range swapping, the ranges make
+ * sense, and then flush all dirty data.  Caller must ensure that the inodes
+ * have been locked against any other modifications.
+ */
+int generic_swap_file_range_prep(struct file *file1, struct file *file2,
+				 struct file_swap_range *fsr)
+{
+	struct inode *inode1 = file_inode(file1);
+	struct inode *inode2 = file_inode(file2);
+	u64 blkmask = i_blocksize(inode1) - 1;
+	bool same_inode = (inode1 == inode2);
+	int ret;
+
+	/* Don't touch certain kinds of inodes */
+	if (IS_IMMUTABLE(inode2))
+		return -EPERM;
+
+	if (IS_SWAPFILE(inode1) || IS_SWAPFILE(inode2))
+		return -ETXTBSY;
+
+	/* Don't reflink dirs, pipes, sockets... */
+	if (S_ISDIR(inode1->i_mode) || S_ISDIR(inode2->i_mode))
+		return -EISDIR;
+	if (!S_ISREG(inode1->i_mode) || !S_ISREG(inode2->i_mode))
+		return -EINVAL;
+
+	/* Ranges cannot start after EOF. */
+	if (fsr->file1_offset > i_size_read(inode1) ||
+	    fsr->file2_offset > i_size_read(inode2))
+		return -EINVAL;
+
+	/*
+	 * If the caller said to swap to EOF, we set the length of the request
+	 * large enough to cover everything to the end of both files.
+	 */
+	if (fsr->flags & FILE_SWAP_RANGE_TO_EOF)
+		fsr->length = max_t(int64_t,
+				    i_size_read(inode1) - fsr->file1_offset,
+				    i_size_read(inode2) - fsr->file2_offset);
+
+	/* Zero length swapext exits immediately. */
+	if (fsr->length == 0)
+		return 0;
+
+	/* Check that we don't violate system file offset limits. */
+	ret = generic_swap_file_range_checks(file1, file2, fsr);
+	if (ret)
+		return ret;
+
+	/*
+	 * Ensure that we don't swap a partial EOF block into the middle of
+	 * another file.
+	 */
+	if (fsr->length & blkmask) {
+		loff_t new_length = fsr->length;
+
+		if (fsr->file2_offset + new_length < i_size_read(inode2))
+			new_length &= ~blkmask;
+
+		if (fsr->file1_offset + new_length < i_size_read(inode1))
+			new_length &= ~blkmask;
+
+		if (new_length != fsr->length)
+			return -EINVAL;
+	}
+
+	/* Wait for the completion of any pending IOs on both files */
+	inode_dio_wait(inode1);
+	if (!same_inode)
+		inode_dio_wait(inode2);
+
+	ret = filemap_write_and_wait_range(inode1->i_mapping, fsr->file1_offset,
+					   fsr->file1_offset + fsr->length - 1);
+	if (ret)
+		return ret;
+
+	ret = filemap_write_and_wait_range(inode2->i_mapping, fsr->file2_offset,
+					   fsr->file2_offset + fsr->length - 1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(generic_swap_file_range_prep);
+
 loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 			   struct file *file_out, loff_t pos_out,
 			   loff_t len, unsigned int remap_flags)
@@ -2278,3 +2364,105 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	return ret;
 }
 EXPORT_SYMBOL(vfs_dedupe_file_range);
+
+/*
+ * Check that both files' metadata agree with the snapshot that we took for
+ * the range swap request.
+
+ * This should be called after the filesystem has locked /all/ inode metadata
+ * against modification.
+ */
+int generic_swap_file_range_check_fresh(struct inode *inode1,
+					struct inode *inode2,
+					const struct file_swap_range *fsr)
+{
+	/* Check that the offset/length values cover all of both files */
+	if ((fsr->flags & FILE_SWAP_RANGE_FULL_FILES) &&
+	    (fsr->file1_offset != 0 ||
+	     fsr->file2_offset != 0 ||
+	     fsr->length != i_size_read(inode1) ||
+	     fsr->length != i_size_read(inode2)))
+		return -EDOM;
+
+	/* Check that file2 hasn't otherwise been modified. */
+	if ((fsr->flags & FILE_SWAP_RANGE_FILE2_FRESH) &&
+	    (fsr->file2_ino        != inode2->i_ino ||
+	     fsr->file2_ctime      != inode2->i_ctime.tv_sec  ||
+	     fsr->file2_ctime_nsec != inode2->i_ctime.tv_nsec ||
+	     fsr->file2_mtime      != inode2->i_mtime.tv_sec  ||
+	     fsr->file2_mtime_nsec != inode2->i_mtime.tv_nsec))
+		return -EBUSY;
+
+	return 0;
+}
+EXPORT_SYMBOL(generic_swap_file_range_check_fresh);
+
+static inline int swap_range_verify_area(struct file *file, loff_t pos,
+					 struct file_swap_range *fsr)
+{
+	int64_t len = fsr->length;
+
+	if (fsr->flags & FILE_SWAP_RANGE_TO_EOF)
+		len = min_t(int64_t, len, i_size_read(file_inode(file)) - pos);
+	return remap_verify_area(file, pos, len, true);
+}
+
+int do_swap_file_range(struct file *file1, struct file *file2,
+		       struct file_swap_range *fsr)
+{
+	int ret;
+
+	if ((fsr->flags & ~FILE_SWAP_RANGE_ALL_FLAGS) ||
+	    memchr_inv(&fsr->pad, 0, sizeof(fsr->pad)))
+		return -EINVAL;
+
+	if ((fsr->flags & FILE_SWAP_RANGE_FULL_FILES) &&
+	    (fsr->flags & FILE_SWAP_RANGE_TO_EOF))
+		return -EINVAL;
+
+	/*
+	 * FISWAPRANGE ioctl enforces that src and dest files are on the same
+	 * mount. Practically, they only need to be on the same file system.
+	 */
+	if (file_inode(file1)->i_sb != file_inode(file2)->i_sb)
+		return -EXDEV;
+
+	ret = generic_file_rw_checks(file1, file2);
+	if (ret < 0)
+		return ret;
+
+	if (!file1->f_op->swap_file_range)
+		return -EOPNOTSUPP;
+
+	ret = swap_range_verify_area(file1, fsr->file1_offset, fsr);
+	if (ret)
+		return ret;
+
+	ret = swap_range_verify_area(file2, fsr->file2_offset, fsr);
+	if (ret)
+		return ret;
+
+	ret = file2->f_op->swap_file_range(file1, file2, fsr);
+	if (ret)
+		return ret;
+
+	file_modified(file1);
+	file_modified(file2);
+	fsnotify_modify(file1);
+	fsnotify_modify(file2);
+	return ret;
+}
+EXPORT_SYMBOL(do_swap_file_range);
+
+int vfs_swap_file_range(struct file *file1, struct file *file2,
+			struct file_swap_range *fsr)
+{
+	int ret;
+
+	file_start_write(file2);
+	ret = do_swap_file_range(file1, file2, fsr);
+	file_end_write(file2);
+
+	return ret;
+}
+EXPORT_SYMBOL(vfs_swap_file_range);
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 18054120074e..c5b75082b9db 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -844,6 +844,7 @@ struct xfs_scrub_metadata {
 #define XFS_IOC_FSGEOMETRY	     _IOR ('X', 126, struct xfs_fsop_geom)
 #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
 #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
+/*	FISWAPRANGE ---------------- hoisted 129	 */
 /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
 
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..63acc11d0804 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1862,6 +1862,8 @@ struct file_operations {
 	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
+	int (*swap_file_range)(struct file *file_in, struct file *file_out,
+			       struct file_swap_range *fsr);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
 } __randomize_layout;
 
@@ -1931,6 +1933,8 @@ extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 					 struct file *file_out, loff_t pos_out,
 					 loff_t *count,
 					 unsigned int remap_flags);
+extern int generic_swap_file_range_prep(struct file *file1, struct file *file2,
+					struct file_swap_range *fsr);
 extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  loff_t len, unsigned int remap_flags);
@@ -1942,7 +1946,13 @@ extern int vfs_dedupe_file_range(struct file *file,
 extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
-
+extern int do_swap_file_range(struct file *file1, struct file *file2,
+			      struct file_swap_range *fsr);
+extern int vfs_swap_file_range(struct file *file1, struct file *file2,
+			       struct file_swap_range *fsr);
+extern int generic_swap_file_range_check_fresh(struct inode *inode1,
+					struct inode *inode2,
+					const struct file_swap_range *fsr);
 
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
@@ -3120,6 +3130,9 @@ extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
 extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				loff_t *count, unsigned int remap_flags);
+extern int generic_swap_file_range_checks(struct file *file1,
+					  struct file *file2,
+					  const struct file_swap_range *fsr);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
 extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8f1d..a74b49b02e75 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -93,6 +93,60 @@ struct file_dedupe_range {
 	struct file_dedupe_range_info info[0];
 };
 
+/*
+ * Swap part of file1 with part of the file that this ioctl that is being
+ * called against (which we'll call file2).  Filesystems must be able to
+ * complete the operation even if the system goes down.
+ */
+struct file_swap_range {
+	__s64		file1_fd;
+	__s64		file1_offset;	/* file1 offset, bytes */
+	__s64		file2_offset;	/* file2 offset, bytes */
+	__s64		length;		/* bytes to swap */
+
+	__u64		flags;		/* see FILE_SWAP_RANGE_* below */
+
+	/* file2 metadata for optional freshness checks */
+	__s64		file2_ino;	/* inode number */
+	__s64		file2_mtime;	/* modification time */
+	__s64		file2_ctime;	/* change time */
+	__s32		file2_mtime_nsec; /* mod time, nsec */
+	__s32		file2_ctime_nsec; /* change time, nsec */
+
+	__u64		pad[6];		/* must be zeroes */
+};
+
+/*
+ * Atomic swap operations are not required.  This relaxes the requirement that
+ * the filesystem must be able to complete the operation after a crash.
+ */
+#define FILE_SWAP_RANGE_NONATOMIC	(1 << 0)
+
+/*
+ * Check that file2's inode number, mtime, and ctime against the values
+ * provided, and return -EBUSY if there isn't an exact match.
+ */
+#define FILE_SWAP_RANGE_FILE2_FRESH	(1 << 1)
+
+/*
+ * Check that the file1's length is equal to file1_offset + length, and that
+ * file2's length is equal to file2_offset + length.  Returns -EDOM if there
+ * isn't an exact match.
+ */
+#define FILE_SWAP_RANGE_FULL_FILES	(1 << 2)
+
+/*
+ * Swap file data all the way to the ends of both files, and then swap the file
+ * sizes.  This flag can be used to replace a file's contents with a different
+ * amount of data.  length will be ignored.
+ */
+#define FILE_SWAP_RANGE_TO_EOF		(1 << 3)
+
+#define FILE_SWAP_RANGE_ALL_FLAGS	(FILE_SWAP_RANGE_NONATOMIC | \
+					 FILE_SWAP_RANGE_FILE2_FRESH | \
+					 FILE_SWAP_RANGE_FULL_FILES | \
+					 FILE_SWAP_RANGE_TO_EOF)
+
 /* And dynamically-tunable limits and defaults: */
 struct files_stat_struct {
 	unsigned long nr_files;		/* read only */
@@ -198,6 +252,7 @@ struct fsxattr {
 #define FICLONE		_IOW(0x94, 9, int)
 #define FICLONERANGE	_IOW(0x94, 13, struct file_clone_range)
 #define FIDEDUPERANGE	_IOWR(0x94, 54, struct file_dedupe_range)
+#define FISWAPRANGE	_IOWR('X', 129, struct file_swap_range)
 
 #define FSLABEL_MAX 256	/* Max chars for the interface; each fs may differ */
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 23a051a7ef0f..e21b63654767 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3035,6 +3035,83 @@ int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	return 0;
 }
 
+/* Performs necessary checks before doing a range swap. */
+int generic_swap_file_range_checks(struct file *file1, struct file *file2,
+				   const struct file_swap_range *fsr)
+{
+	struct inode *inode1 = file1->f_mapping->host;
+	struct inode *inode2 = file2->f_mapping->host;
+	int64_t test_len;
+	uint64_t blen;
+	loff_t size1, size2;
+	loff_t bs = inode2->i_sb->s_blocksize;
+	int ret;
+
+	if (fsr->length < 0)
+		return -EINVAL;
+
+	/* The start of both ranges must be aligned to an fs block. */
+	if (!IS_ALIGNED(fsr->file1_offset, bs) ||
+	    !IS_ALIGNED(fsr->file2_offset, bs))
+		return -EINVAL;
+
+	/* Ensure offsets don't wrap. */
+	if (fsr->file1_offset + fsr->length < fsr->file1_offset ||
+	    fsr->file2_offset + fsr->length < fsr->file2_offset)
+		return -EINVAL;
+
+	size1 = i_size_read(inode1);
+	size2 = i_size_read(inode2);
+
+	/*
+	 * Swapext require both ranges to be within EOF, unless we're swapping
+	 * to EOF.  generic_swap_range_prep already checked that both
+	 * fsr->file1_offset and fsr->file2_offset are within EOF.
+	 */
+	if (!(fsr->flags & FILE_SWAP_RANGE_TO_EOF) &&
+	    (fsr->file1_offset + fsr->length > size1 ||
+	     fsr->file2_offset + fsr->length > size2))
+		return -EINVAL;
+
+	/*
+	 * Make sure we don't hit any file size limits.  If we hit any size
+	 * limits such that test_length was adjusted, we abort the whole
+	 * operation.
+	 */
+	test_len = fsr->length;
+	ret = generic_write_check_limits(file2, fsr->file2_offset, &test_len);
+	if (ret)
+		return ret;
+	ret = generic_write_check_limits(file1, fsr->file1_offset, &test_len);
+	if (ret)
+		return ret;
+	if (test_len != fsr->length)
+		return -EINVAL;
+
+	/*
+	 * If the user wanted us to swap to the infile's EOF, round up to the
+	 * next block boundary for this check.  Do the same for the outfile.
+	 *
+	 * Otherwise, reject the range length if it's not block aligned.  We
+	 * already confirmed the starting offsets' block alignment.
+	 */
+	if (fsr->file1_offset + fsr->length == size1)
+		blen = ALIGN(size1, bs) - fsr->file1_offset;
+	else if (fsr->file2_offset + fsr->length == size2)
+		blen = ALIGN(size2, bs) - fsr->file2_offset;
+	else if (!IS_ALIGNED(fsr->length, bs))
+		return -EINVAL;
+	else
+		blen = fsr->length;
+
+	/* Don't allow overlapped swapping within the same file. */
+	if (inode1 == inode2 &&
+	    fsr->file2_offset + blen > fsr->file1_offset &&
+	    fsr->file1_offset + blen > fsr->file2_offset)
+		return -EINVAL;
+
+	return 0;
+}
 
 /*
  * Performs common checks before doing a file copy/clone

