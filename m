Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236E0659EBE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiL3Xu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiL3Xu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:50:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37FC1E3C1;
        Fri, 30 Dec 2022 15:50:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35E0F61C39;
        Fri, 30 Dec 2022 23:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945CFC433EF;
        Fri, 30 Dec 2022 23:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444224;
        bh=pwJlrVcqRb9Q59nbn0Wa6w7tHQw2GK948+drrUiHIQU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jGJ+uDlm5ARFkmSetFXh8ucjHgSzZZ3rUeILTiqvJIX8X9+rKI9xtBgofxVA5TaZX
         mcG+Z5qxJWVRhF+9gV+mwv5/i05T+jBJwNHYo3zPkMbPT8+MiLM787zIZ91J7Owemo
         caketwe34C6hnwxtKHEF0mdvQb5+UGnCk7/NoByp5dIlHlUwM1MqdTlir3tfy/AwcM
         Yf3gqMU63n98kvkwZuT53yrYuRKTLSeeh1Xaaq8H4IP0GmxZIg0UgNitziF1V7xYqd
         ZOI00X3cLwAd2/hUvqNcJ5U+pqe4OkMorak9Sj+2MYSW2tPKZXLOKhp8JRaAVLKTHI
         RoUnO16jNDdSw==
Subject: [PATCH 01/21] vfs: introduce new file range exchange ioctl
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:55 -0800
Message-ID: <167243843535.699466.9038562542810181371.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Introduce a new ioctl to handle swapping ranges of bytes between files.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 Documentation/filesystems/vfs.rst |   16 ++
 fs/ioctl.c                        |   27 +++
 fs/remap_range.c                  |  296 +++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_fs.h            |    1 
 include/linux/fs.h                |   14 ++
 include/uapi/linux/fiexchange.h   |  101 +++++++++++++
 6 files changed, 454 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/fiexchange.h


diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 2c15e7053113..cae6dd3a8a0b 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1036,6 +1036,8 @@ This describes how the VFS can manipulate an open file.  As of kernel
 		loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
 					   struct file *file_out, loff_t pos_out,
 					   loff_t len, unsigned int remap_flags);
+                int (*xchg_file_range)(struct file *file1, struct file *file2,
+                                       struct file_xchg_range *fxr);
 		int (*fadvise)(struct file *, loff_t, loff_t, int);
 	};
 
@@ -1154,6 +1156,20 @@ otherwise noted.
 	ok with the implementation shortening the request length to
 	satisfy alignment or EOF requirements (or any other reason).
 
+``xchg_file_range``
+	called by the ioctl(2) system call for FIEXCHANGE_RANGE to exchange the
+	contents of two file ranges.  An implementation should exchange
+	fxr.length bytes starting at fxr.file1_offset in file1 with the same
+	number of bytes starting at fxr.file2_offset in file2.  Refer to
+	fiexchange.h file for more information.  Implementations must call
+	generic_xchg_file_range_prep to prepare the two files prior to taking
+	locks; they must call generic_xchg_file_range_check_fresh once the
+	inode is locked to abort the call if file2 has changed; and they must
+	update the inode change and mod times of both files as part of the
+	metadata update.  The timestamp updates must be done atomically as part
+	of the data exchange operation to ensure correctness of the freshness
+	check.
+
 ``fadvise``
 	possibly called by the fadvise64() system call.
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 80ac36aea913..bd636daf8e90 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -259,6 +259,30 @@ static long ioctl_file_clone_range(struct file *file,
 				args.src_length, args.dest_offset);
 }
 
+static long ioctl_file_xchg_range(struct file *file2,
+				  struct file_xchg_range __user *argp)
+{
+	struct file_xchg_range args;
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
+	ret = vfs_xchg_file_range(file1.file, file2, &args);
+fdput:
+	fdput(file1);
+	return ret;
+}
+
 /*
  * This provides compatibility with legacy XFS pre-allocation ioctls
  * which predate the fallocate syscall.
@@ -825,6 +849,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	case FIDEDUPERANGE:
 		return ioctl_file_dedupe_range(filp, argp);
 
+	case FIEXCHANGE_RANGE:
+		return ioctl_file_xchg_range(filp, argp);
+
 	case FIONREAD:
 		if (!S_ISREG(inode->i_mode))
 			return vfs_ioctl(filp, cmd, arg);
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 41f60477bb41..469d53fb42e9 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -567,3 +567,299 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	return ret;
 }
 EXPORT_SYMBOL(vfs_dedupe_file_range);
+
+/* Performs necessary checks before doing a range exchange. */
+static int generic_xchg_file_range_checks(struct file *file1,
+					  struct file *file2,
+					  struct file_xchg_range *fxr,
+					  unsigned int blocksize)
+{
+	struct inode *inode1 = file1->f_mapping->host;
+	struct inode *inode2 = file2->f_mapping->host;
+	uint64_t blkmask = blocksize - 1;
+	int64_t test_len;
+	uint64_t blen;
+	loff_t size1, size2;
+	int ret;
+
+	/* Don't touch certain kinds of inodes */
+	if (IS_IMMUTABLE(inode1) || IS_IMMUTABLE(inode2))
+		return -EPERM;
+	if (IS_SWAPFILE(inode1) || IS_SWAPFILE(inode2))
+		return -ETXTBSY;
+
+	size1 = i_size_read(inode1);
+	size2 = i_size_read(inode2);
+
+	/* Ranges cannot start after EOF. */
+	if (fxr->file1_offset > size1 || fxr->file2_offset > size2)
+		return -EINVAL;
+
+	/*
+	 * If the caller asked for full files, check that the offset/length
+	 * values cover all of both files.
+	 */
+	if ((fxr->flags & FILE_XCHG_RANGE_FULL_FILES) &&
+	    (fxr->file1_offset != 0 || fxr->file2_offset != 0 ||
+	     fxr->length != size1 || fxr->length != size2))
+		return -EDOM;
+
+	/*
+	 * If the caller said to exchange to EOF, we set the length of the
+	 * request large enough to cover everything to the end of both files.
+	 */
+	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF)
+		fxr->length = max_t(int64_t, size1 - fxr->file1_offset,
+					     size2 - fxr->file2_offset);
+
+	/* The start of both ranges must be aligned to an fs block. */
+	if (!IS_ALIGNED(fxr->file1_offset, blocksize) ||
+	    !IS_ALIGNED(fxr->file2_offset, blocksize))
+		return -EINVAL;
+
+	/* Ensure offsets don't wrap. */
+	if (fxr->file1_offset + fxr->length < fxr->file1_offset ||
+	    fxr->file2_offset + fxr->length < fxr->file2_offset)
+		return -EINVAL;
+
+	/*
+	 * We require both ranges to be within EOF, unless we're exchanging
+	 * to EOF.  generic_xchg_range_prep already checked that both
+	 * fxr->file1_offset and fxr->file2_offset are within EOF.
+	 */
+	if (!(fxr->flags & FILE_XCHG_RANGE_TO_EOF) &&
+	    (fxr->file1_offset + fxr->length > size1 ||
+	     fxr->file2_offset + fxr->length > size2))
+		return -EINVAL;
+
+	/*
+	 * Make sure we don't hit any file size limits.  If we hit any size
+	 * limits such that test_length was adjusted, we abort the whole
+	 * operation.
+	 */
+	test_len = fxr->length;
+	ret = generic_write_check_limits(file2, fxr->file2_offset, &test_len);
+	if (ret)
+		return ret;
+	ret = generic_write_check_limits(file1, fxr->file1_offset, &test_len);
+	if (ret)
+		return ret;
+	if (test_len != fxr->length)
+		return -EINVAL;
+
+	/*
+	 * If the user wanted us to exchange up to the infile's EOF, round up
+	 * to the next block boundary for this check.  Do the same for the
+	 * outfile.
+	 *
+	 * Otherwise, reject the range length if it's not block aligned.  We
+	 * already confirmed the starting offsets' block alignment.
+	 */
+	if (fxr->file1_offset + fxr->length == size1)
+		blen = ALIGN(size1, blocksize) - fxr->file1_offset;
+	else if (fxr->file2_offset + fxr->length == size2)
+		blen = ALIGN(size2, blocksize) - fxr->file2_offset;
+	else if (!IS_ALIGNED(fxr->length, blocksize))
+		return -EINVAL;
+	else
+		blen = fxr->length;
+
+	/* Don't allow overlapped exchanges within the same file. */
+	if (inode1 == inode2 &&
+	    fxr->file2_offset + blen > fxr->file1_offset &&
+	    fxr->file1_offset + blen > fxr->file2_offset)
+		return -EINVAL;
+
+	/* If we already failed the freshness check, we're done. */
+	ret = generic_xchg_file_range_check_fresh(inode2, fxr);
+	if (ret)
+		return ret;
+
+	/*
+	 * Ensure that we don't exchange a partial EOF block into the middle of
+	 * another file.
+	 */
+	if ((fxr->length & blkmask) == 0)
+		return 0;
+
+	blen = fxr->length;
+	if (fxr->file2_offset + blen < size2)
+		blen &= ~blkmask;
+
+	if (fxr->file1_offset + blen < size1)
+		blen &= ~blkmask;
+
+	return blen == fxr->length ? 0 : -EINVAL;
+}
+
+/*
+ * Check that the two inodes are eligible for range exchanges, the ranges make
+ * sense, and then flush all dirty data.  Caller must ensure that the inodes
+ * have been locked against any other modifications.
+ */
+int generic_xchg_file_range_prep(struct file *file1, struct file *file2,
+				 struct file_xchg_range *fxr,
+				 unsigned int blocksize)
+{
+	struct inode *inode1 = file_inode(file1);
+	struct inode *inode2 = file_inode(file2);
+	bool same_inode = (inode1 == inode2);
+	int ret;
+
+	/* Check that we don't violate system file offset limits. */
+	ret = generic_xchg_file_range_checks(file1, file2, fxr, blocksize);
+	if (ret || fxr->length == 0)
+		return ret;
+
+	/* Wait for the completion of any pending IOs on both files */
+	inode_dio_wait(inode1);
+	if (!same_inode)
+		inode_dio_wait(inode2);
+
+	ret = filemap_write_and_wait_range(inode1->i_mapping, fxr->file1_offset,
+					   fxr->file1_offset + fxr->length - 1);
+	if (ret)
+		return ret;
+
+	ret = filemap_write_and_wait_range(inode2->i_mapping, fxr->file2_offset,
+					   fxr->file2_offset + fxr->length - 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the files or inodes involved require synchronous writes, amend
+	 * the request to force the filesystem to flush all data and metadata
+	 * to disk after the operation completes.
+	 */
+	if (((file1->f_flags | file2->f_flags) & (__O_SYNC | O_DSYNC)) ||
+	    IS_SYNC(inode1) || IS_SYNC(inode2))
+		fxr->flags |= FILE_XCHG_RANGE_FSYNC;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(generic_xchg_file_range_prep);
+
+/*
+ * Finish a range exchange operation, if it was successful.  Caller must ensure
+ * that the inodes are still locked against any other modifications.
+ */
+int generic_xchg_file_range_finish(struct file *file1, struct file *file2)
+{
+	int ret;
+
+	ret = file_remove_privs(file1);
+	if (ret)
+		return ret;
+	if (file_inode(file1) == file_inode(file2))
+		return 0;
+
+	return file_remove_privs(file2);
+}
+EXPORT_SYMBOL_GPL(generic_xchg_file_range_finish);
+
+/*
+ * Check that both files' metadata agree with the snapshot that we took for
+ * the range exchange request.
+
+ * This should be called after the filesystem has locked /all/ inode metadata
+ * against modification.
+ */
+int generic_xchg_file_range_check_fresh(struct inode *inode2,
+					const struct file_xchg_range *fxr)
+{
+	/* Check that file2 hasn't otherwise been modified. */
+	if ((fxr->flags & FILE_XCHG_RANGE_FILE2_FRESH) &&
+	    (fxr->file2_ino        != inode2->i_ino ||
+	     fxr->file2_ctime      != inode2->i_ctime.tv_sec  ||
+	     fxr->file2_ctime_nsec != inode2->i_ctime.tv_nsec ||
+	     fxr->file2_mtime      != inode2->i_mtime.tv_sec  ||
+	     fxr->file2_mtime_nsec != inode2->i_mtime.tv_nsec))
+		return -EBUSY;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(generic_xchg_file_range_check_fresh);
+
+static inline int xchg_range_verify_area(struct file *file, loff_t pos,
+					 struct file_xchg_range *fxr)
+{
+	int64_t len = fxr->length;
+
+	if (pos < 0)
+		return -EINVAL;
+
+	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF)
+		len = min_t(int64_t, len, i_size_read(file_inode(file)) - pos);
+	return remap_verify_area(file, pos, len, true);
+}
+
+int do_xchg_file_range(struct file *file1, struct file *file2,
+		       struct file_xchg_range *fxr)
+{
+	struct inode *inode1 = file_inode(file1);
+	struct inode *inode2 = file_inode(file2);
+	int ret;
+
+	if ((fxr->flags & ~FILE_XCHG_RANGE_ALL_FLAGS) ||
+	    memchr_inv(&fxr->pad, 0, sizeof(fxr->pad)))
+		return -EINVAL;
+
+	if ((fxr->flags & FILE_XCHG_RANGE_FULL_FILES) &&
+	    (fxr->flags & FILE_XCHG_RANGE_TO_EOF))
+		return -EINVAL;
+
+	/*
+	 * The ioctl enforces that src and dest files are on the same mount.
+	 * Practically, they only need to be on the same file system.
+	 */
+	if (inode1->i_sb != inode2->i_sb)
+		return -EXDEV;
+
+	/* This only works for regular files. */
+	if (S_ISDIR(inode1->i_mode) || S_ISDIR(inode2->i_mode))
+		return -EISDIR;
+	if (!S_ISREG(inode1->i_mode) || !S_ISREG(inode2->i_mode))
+		return -EINVAL;
+
+	ret = generic_file_rw_checks(file1, file2);
+	if (ret < 0)
+		return ret;
+
+	ret = generic_file_rw_checks(file2, file1);
+	if (ret < 0)
+		return ret;
+
+	if (!file1->f_op->xchg_file_range)
+		return -EOPNOTSUPP;
+
+	ret = xchg_range_verify_area(file1, fxr->file1_offset, fxr);
+	if (ret)
+		return ret;
+
+	ret = xchg_range_verify_area(file2, fxr->file2_offset, fxr);
+	if (ret)
+		return ret;
+
+	ret = file2->f_op->xchg_file_range(file1, file2, fxr);
+	if (ret)
+		return ret;
+
+	fsnotify_modify(file1);
+	if (file2 != file1)
+		fsnotify_modify(file2);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(do_xchg_file_range);
+
+int vfs_xchg_file_range(struct file *file1, struct file *file2,
+			struct file_xchg_range *fxr)
+{
+	int ret;
+
+	file_start_write(file2);
+	ret = do_xchg_file_range(file1, file2, fxr);
+	file_end_write(file2);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfs_xchg_file_range);
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 400cf68e551e..210c17f5a16c 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -841,6 +841,7 @@ struct xfs_scrub_metadata {
 #define XFS_IOC_FSGEOMETRY	     _IOR ('X', 126, struct xfs_fsop_geom)
 #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
 #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
+/*	FIEXCHANGE_RANGE ----------- hoisted 129	 */
 /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
 
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 066555ad1bf8..cd86ac22c339 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -46,6 +46,7 @@
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
+#include <uapi/linux/fiexchange.h>
 
 struct backing_dev_info;
 struct bdi_writeback;
@@ -2125,6 +2126,8 @@ struct file_operations {
 	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
+	int (*xchg_file_range)(struct file *file1, struct file *file2,
+			       struct file_xchg_range *fsr);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
@@ -2205,6 +2208,10 @@ int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  loff_t *count, unsigned int remap_flags);
+int generic_xchg_file_range_prep(struct file *file1, struct file *file2,
+				 struct file_xchg_range *fsr,
+				 unsigned int blocksize);
+int generic_xchg_file_range_finish(struct file *file1, struct file *file2);
 extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  loff_t len, unsigned int remap_flags);
@@ -2216,7 +2223,12 @@ extern int vfs_dedupe_file_range(struct file *file,
 extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
-
+extern int do_xchg_file_range(struct file *file1, struct file *file2,
+			      struct file_xchg_range *fsr);
+extern int vfs_xchg_file_range(struct file *file1, struct file *file2,
+			       struct file_xchg_range *fsr);
+extern int generic_xchg_file_range_check_fresh(struct inode *inode2,
+					const struct file_xchg_range *fsr);
 
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
diff --git a/include/uapi/linux/fiexchange.h b/include/uapi/linux/fiexchange.h
new file mode 100644
index 000000000000..72bc228d4141
--- /dev/null
+++ b/include/uapi/linux/fiexchange.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
+/*
+ * FIEXCHANGE_RANGE ioctl definitions, to facilitate exchanging parts of files.
+ *
+ * Copyright (C) 2022 Oracle.  All Rights Reserved.
+ *
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef _LINUX_FIEXCHANGE_H
+#define _LINUX_FIEXCHANGE_H
+
+#include <linux/types.h>
+
+/*
+ * Exchange part of file1 with part of the file that this ioctl that is being
+ * called against (which we'll call file2).  Filesystems must be able to
+ * restart and complete the operation even after the system goes down.
+ */
+struct file_xchg_range {
+	__s64		file1_fd;
+	__s64		file1_offset;	/* file1 offset, bytes */
+	__s64		file2_offset;	/* file2 offset, bytes */
+	__u64		length;		/* bytes to exchange */
+
+	__u64		flags;		/* see FILE_XCHG_RANGE_* below */
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
+ * Atomic exchange operations are not required.  This relaxes the requirement
+ * that the filesystem must be able to complete the operation after a crash.
+ */
+#define FILE_XCHG_RANGE_NONATOMIC	(1 << 0)
+
+/*
+ * Check that file2's inode number, mtime, and ctime against the values
+ * provided, and return -EBUSY if there isn't an exact match.
+ */
+#define FILE_XCHG_RANGE_FILE2_FRESH	(1 << 1)
+
+/*
+ * Check that the file1's length is equal to file1_offset + length, and that
+ * file2's length is equal to file2_offset + length.  Returns -EDOM if there
+ * isn't an exact match.
+ */
+#define FILE_XCHG_RANGE_FULL_FILES	(1 << 2)
+
+/*
+ * Exchange file data all the way to the ends of both files, and then exchange
+ * the file sizes.  This flag can be used to replace a file's contents with a
+ * different amount of data.  length will be ignored.
+ */
+#define FILE_XCHG_RANGE_TO_EOF		(1 << 3)
+
+/* Flush all changes in file data and file metadata to disk before returning. */
+#define FILE_XCHG_RANGE_FSYNC		(1 << 4)
+
+/* Dry run; do all the parameter verification but do not change anything. */
+#define FILE_XCHG_RANGE_DRY_RUN		(1 << 5)
+
+/*
+ * Do not exchange any part of the range where file1's mapping is a hole.  This
+ * can be used to emulate scatter-gather atomic writes with a temp file.
+ */
+#define FILE_XCHG_RANGE_SKIP_FILE1_HOLES (1 << 6)
+
+/*
+ * Commit the contents of file1 into file2 if file2 has the same inode number,
+ * mtime, and ctime as the arguments provided to the call.  The old contents of
+ * file2 will be moved to file1.
+ *
+ * With this flag, all committed information can be retrieved even if the
+ * system crashes or is rebooted.  This includes writing through or flushing a
+ * disk cache if present.  The call blocks until the device reports that the
+ * commit is complete.
+ *
+ * This flag should not be combined with NONATOMIC.  It can be combined with
+ * SKIP_FILE1_HOLES.
+ */
+#define FILE_XCHG_RANGE_COMMIT		(FILE_XCHG_RANGE_FILE2_FRESH | \
+					 FILE_XCHG_RANGE_FSYNC)
+
+#define FILE_XCHG_RANGE_ALL_FLAGS	(FILE_XCHG_RANGE_NONATOMIC | \
+					 FILE_XCHG_RANGE_FILE2_FRESH | \
+					 FILE_XCHG_RANGE_FULL_FILES | \
+					 FILE_XCHG_RANGE_TO_EOF | \
+					 FILE_XCHG_RANGE_FSYNC | \
+					 FILE_XCHG_RANGE_DRY_RUN | \
+					 FILE_XCHG_RANGE_SKIP_FILE1_HOLES)
+
+#define FIEXCHANGE_RANGE	_IOWR('X', 129, struct file_xchg_range)
+
+#endif /* _LINUX_FIEXCHANGE_H */

