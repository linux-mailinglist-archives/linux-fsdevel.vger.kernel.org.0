Return-Path: <linux-fsdevel+bounces-18255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB18B68B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242A5B2258E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B540E10A1D;
	Tue, 30 Apr 2024 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT5okxST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B015101CE;
	Tue, 30 Apr 2024 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447838; cv=none; b=kXTSVCoOFgZGa1P7+8WFABzG07q+6l0lvrQ80wt/msCP8qKTLfZqxkKbqE+ay6lX4xB51D4Sb4MoCuDN5NS6Fv+Psy3rACWj4Hl06pcFhO6c4bN5bV55xg9vEB/p0YjTV9T1o+eS8t3LGvDCL2urw43cf+g5PAkZ1E9s4bu5EeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447838; c=relaxed/simple;
	bh=JVEiBxX3j8lBQpVlJZ9cPZlFt4fOEyztd1O3jB6/XtI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baSuUS3UVbDiG8qO32n4idN2CDwxJ8w714lKoAQ27ogbr5llclFLzJE9J+244yzQC9c/PPCtY05foYHinjnwmCrkeZcNce5asYq7DYBFEXkJCzWJKp5ur3zLlPbsZ3T0xQYsLIqbpK4LRKg3rorIr4Le6kSzisD7IX17qsSzpRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT5okxST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E560AC116B1;
	Tue, 30 Apr 2024 03:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447838;
	bh=JVEiBxX3j8lBQpVlJZ9cPZlFt4fOEyztd1O3jB6/XtI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oT5okxSTEdhnyMjPdyqULzPN9gLMbfvEdn45yKfNRFx9cQzgoO5yUSWeLs9fOay1G
	 co54M5B2F1wOg1hF3IFZzeTDpPVaf5PTYPNXdc1p0ahoQEYNqrrDgbGcM5nCPyt0ME
	 XA84g9toRoyp7N+ZE9J9z+bjKQJlFecsXNZc8RoqFFMXuBpoRjCwgWtbJ+WUpBYbhs
	 ke0cFQb9f9PRGp/etUUiFV9MS5qky5kH74POn4nHpykk8PlNW+2hnGFaeJWI3ma2C7
	 zz64tW/Z6CkpvrGyrTqg2GvPAkDsdK91GfC8SrDCiBs9d9Og7aBdyd2wfItbcpytxs
	 mbF+Qg6hEzIZg==
Date: Mon, 29 Apr 2024 20:30:37 -0700
Subject: [PATCH 25/26] xfs: make it possible to disable fsverity
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create an experimental ioctl so that we can turn off fsverity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 Documentation/filesystems/fsverity.rst |   10 ++++++
 fs/verity/enable.c                     |   50 ++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsverity.c                  |   46 +++++++++++++++++++++++++++++
 fs/xfs/xfs_ioctl.c                     |    6 ++++
 include/linux/fsverity.h               |   24 +++++++++++++++
 include/trace/events/fsverity.h        |   13 ++++++++
 include/uapi/linux/fsverity.h          |    1 +
 7 files changed, 150 insertions(+)


diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 887cdaf162a99..dc688b2eda68d 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -189,6 +189,16 @@ FS_IOC_ENABLE_VERITY can fail with the following errors:
   caller's file descriptor, another open file descriptor, or the file
   reference held by a writable memory map.
 
+FS_IOC_DISABLE_VERITY
+--------------------
+
+The FS_IOC_DISABLE_VERITY ioctl disables fs-verity on a file.  It takes
+a file descriptor.
+
+FS_IOC_DISABLE_VERITY can fail with the following errors:
+
+- ``EOPNOTSUPP``: the filesystem does not support disabling fs-verity.
+
 FS_IOC_MEASURE_VERITY
 ---------------------
 
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 8c6fe4b72b14e..adf8886f4ed29 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -415,3 +415,53 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
 	return err;
 }
 EXPORT_SYMBOL_GPL(fsverity_ioctl_enable);
+
+/**
+ * fsverity_ioctl_disable() - disable verity on a file
+ * @filp: file to enable verity on
+ *
+ * Disable fs-verity on a file.  See the "FS_IOC_DISABLE_VERITY" section of
+ * Documentation/filesystems/fsverity.rst for the documentation.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int fsverity_ioctl_disable(struct file *filp)
+{
+	struct inode *inode = file_inode(filp);
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
+	struct fsverity_info *vi;
+	u64 tree_size = 0;
+	unsigned int block_size = 0;
+	int err;
+
+	trace_fsverity_disable(inode);
+
+	inode_lock(inode);
+	if (IS_VERITY(inode)) {
+		err = 0;
+		goto out_unlock;
+	}
+
+	if (!vops->disable_verity) {
+		err = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
+	vi = fsverity_get_info(inode);
+	if (vi) {
+		block_size = vi->tree_params.block_size;
+		tree_size = vi->tree_params.tree_size;
+	}
+
+	err = vops->disable_verity(filp, tree_size, block_size);
+	if (err)
+		goto out_unlock;
+
+	fsverity_cleanup_inode(inode);
+	inode_unlock(inode);
+	return 0;
+out_unlock:
+	inode_unlock(inode);
+	return err;
+}
+EXPORT_SYMBOL_GPL(fsverity_ioctl_disable);
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 87edf23954336..184c3e14d581f 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -940,9 +940,55 @@ xfs_fsverity_file_corrupt(
 	xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_DATA);
 }
 
+/* Turn off fs-verity. */
+static int
+xfs_fsverity_disable(
+	struct file		*file,
+	u64			tree_size,
+	unsigned int		block_size)
+{
+	struct inode		*inode = file_inode(file);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	int			error;
+
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+		return -EBUSY;
+
+	error = xfs_qm_dqattach(ip);
+	if (error)
+		return error;
+
+	xfs_fsverity_drop_cache(ip, tree_size, block_size);
+
+	/* Clear fsverity inode flag */
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange, 0, 0, false,
+			&tp);
+	if (error)
+		return error;
+
+	ip->i_diflags2 &= ~XFS_DIFLAG2_VERITY;
+
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+	xfs_trans_set_sync(tp);
+
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	if (error)
+		return error;
+
+	inode->i_flags &= ~S_VERITY;
+	fsverity_cleanup_inode(inode);
+
+	/* Remove the fsverity xattrs. */
+	return xfs_fsverity_delete_metadata(ip, tree_size, block_size);
+}
+
 const struct fsverity_operations xfs_fsverity_ops = {
 	.begin_enable_verity		= xfs_fsverity_begin_enable,
 	.end_enable_verity		= xfs_fsverity_end_enable,
+	.disable_verity			= xfs_fsverity_disable,
 	.get_verity_descriptor		= xfs_fsverity_get_descriptor,
 	.read_merkle_tree_block		= xfs_fsverity_read_merkle,
 	.write_merkle_tree_block	= xfs_fsverity_write_merkle,
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index b05930462f461..d71fc9e6b83eb 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -42,6 +42,7 @@
 #include "xfs_exchrange.h"
 #include "xfs_handle.h"
 #include "xfs_rtgroup.h"
+#include "xfs_fsverity.h"
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
@@ -1590,6 +1591,11 @@ xfs_file_ioctl(
 			return -EOPNOTSUPP;
 		return fsverity_ioctl_read_metadata(filp, arg);
 
+	case FS_IOC_DISABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_disable(filp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 1336f4b9011ea..e9f570f65ed54 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -135,6 +135,24 @@ struct fsverity_operations {
 				 size_t desc_size, u64 merkle_tree_size,
 				 unsigned int tree_blocksize);
 
+	/**
+	 * Disable verity on the given file.
+	 *
+	 * @filp: a readonly file descriptor for the file
+	 * @merkle_tree_size: total bytes the Merkle tree takes up
+	 * @tree_blocksize: the Merkle tree block size
+	 *
+	 * The filesystem must do any needed filesystem-specific preparations
+	 * for disabling verity, e.g. truncating the merkle tree.  It also must
+	 * return -EBUSY if verity is already being enabled on the given file.
+	 *
+	 * i_rwsem is held for write.
+	 *
+	 * Return: 0 on success, -errno on failure
+	 */
+	int (*disable_verity)(struct file *filp, u64 merkle_tree_size,
+			      unsigned int tree_blocksize);
+
 	/**
 	 * Get the verity descriptor of the given inode.
 	 *
@@ -260,6 +278,7 @@ static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 /* enable.c */
 
 int fsverity_ioctl_enable(struct file *filp, const void __user *arg);
+int fsverity_ioctl_disable(struct file *filp);
 
 /* measure.c */
 
@@ -326,6 +345,11 @@ static inline int fsverity_ioctl_enable(struct file *filp,
 	return -EOPNOTSUPP;
 }
 
+static inline int fsverity_ioctl_disable(struct file *filp)
+{
+	return -EOPNOTSUPP;
+}
+
 /* measure.c */
 
 static inline int fsverity_ioctl_measure(struct file *filp, void __user *arg)
diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
index 375fdddac6a99..2678dd3249b32 100644
--- a/include/trace/events/fsverity.h
+++ b/include/trace/events/fsverity.h
@@ -37,6 +37,19 @@ TRACE_EVENT(fsverity_enable,
 		__entry->num_levels)
 );
 
+TRACE_EVENT(fsverity_disable,
+	TP_PROTO(const struct inode *inode),
+	TP_ARGS(inode),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+	),
+	TP_printk("ino %lu",
+		(unsigned long) __entry->ino)
+);
+
 TRACE_EVENT(fsverity_tree_done,
 	TP_PROTO(const struct inode *inode, const struct fsverity_info *vi,
 		 const struct merkle_tree_params *params),
diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
index 15384e22e331e..73a5f83754792 100644
--- a/include/uapi/linux/fsverity.h
+++ b/include/uapi/linux/fsverity.h
@@ -99,5 +99,6 @@ struct fsverity_read_metadata_arg {
 #define FS_IOC_MEASURE_VERITY	_IOWR('f', 134, struct fsverity_digest)
 #define FS_IOC_READ_VERITY_METADATA \
 	_IOWR('f', 135, struct fsverity_read_metadata_arg)
+#define FS_IOC_DISABLE_VERITY	_IO('f', 136)
 
 #endif /* _UAPI_LINUX_FSVERITY_H */


