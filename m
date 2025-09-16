Return-Path: <linux-fsdevel+bounces-61519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D38B58985
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B9A2A4C11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3751E8337;
	Tue, 16 Sep 2025 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDv5mpm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183F2BB13;
	Tue, 16 Sep 2025 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982667; cv=none; b=H6JQ/0NwjPyL4KrGh4PBxMBHaSKG75OchiIZEf35xhcpepMWdujIDv2VVYn4l2wnW7/jPRkNrRPUhEVss4Ujrn1892vuDqMQwam4YpfeeUYTPyuXoBoCIrCRe2aR0gjg+gMWtMEo6Sq8EplpMmm6UmUn0jeWj4TVbigbg7rQbMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982667; c=relaxed/simple;
	bh=yuYSxM64RT9QKQn+YFVGDOknNoBkXuIeZh13X4SCbQo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwktxxQHkEwvBmEGBnKdKtpveJ1jjWus2rH9Tf50HH1EFsQJrs+bk1KAGbz//toG0fRsoQocm9dLQtUvsXOFhfbBqSfb+HkXUS+kWeAvsjaxFQ2yL3KW2nEqHNqZk5C8ZT9EeFcMu/uHnpLVvqto7banlpbAMmSxZvFTmXb444Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDv5mpm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC057C4CEF1;
	Tue, 16 Sep 2025 00:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982666;
	bh=yuYSxM64RT9QKQn+YFVGDOknNoBkXuIeZh13X4SCbQo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KDv5mpm6FTD65nq+/7JcMiRiytwz3sMLF1mKODm+yJx1sDpL17xqBjShuh1upV9cI
	 7CIdQ53duFHFQ+LMLEoR9fDzDZ7S7yf7jo+5EojQRpvLApk+rTI421AnG99E5R62PC
	 14+yBYNeNqTZ7zF9w9Owx+DZUXf8uyrR/hRRLDQafPhLpZzW/+7SLkf5MLobdO0MCU
	 Le3s35SJrvt4PyK45BXsVmI4ojwAhYH2zb/MgOjLIGrwpRMe7/3puDA2hpps+F61xW
	 zO1MgGg5e+FUNwvRTR8evFRbi/UcsZj3ZJZzPKFSjM1Yn62poUkE9NrxYFBXkQUMH1
	 GVLJViDvXu8Og==
Date: Mon, 15 Sep 2025 17:31:06 -0700
Subject: [PATCH 12/28] fuse: implement direct IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151523.382724.10172072512776056808.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Start implementing the fuse-iomap file I/O paths by adding direct I/O
support and all the signalling flags that come with it.  Buffered I/O
is much more complicated, so we leave that to a subsequent patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   30 +++++
 include/uapi/linux/fuse.h |   22 ++++
 fs/fuse/dir.c             |    7 +
 fs/fuse/file.c            |   16 +++
 fs/fuse/file_iomap.c      |  249 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/trace.c           |    1 
 6 files changed, 323 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ea879b45e904c5..ed0608d84ac76c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -643,6 +643,16 @@ struct fuse_sync_bucket {
 	struct rcu_head rcu;
 };
 
+#ifdef CONFIG_FUSE_IOMAP
+struct fuse_iomap_conn {
+	/* fuse server doesn't implement iomap_end */
+	unsigned int no_end:1;
+
+	/* fuse server doesn't implement iomap_ioend */
+	unsigned int no_ioend:1;
+};
+#endif
+
 /**
  * A Fuse connection.
  *
@@ -992,6 +1002,11 @@ struct fuse_conn {
 	struct idr backing_files_map;
 #endif
 
+#ifdef CONFIG_FUSE_IOMAP
+	/** iomap information */
+	struct fuse_iomap_conn iomap_conn;
+#endif
+
 #ifdef CONFIG_FUSE_IO_URING
 	/**  uring connection information*/
 	struct fuse_ring *ring;
@@ -1732,6 +1747,17 @@ int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 length);
 loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
 sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
+
+void fuse_iomap_open(struct inode *inode, struct file *file);
+
+static inline bool fuse_want_iomap_directio(const struct kiocb *iocb)
+{
+	return (iocb->ki_flags & IOCB_DIRECT) &&
+		fuse_inode_has_iomap(file_inode(iocb->ki_filp));
+}
+
+ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1743,6 +1769,10 @@ sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 # define fuse_iomap_fiemap			NULL
 # define fuse_iomap_lseek(...)			(-ENOSYS)
 # define fuse_iomap_bmap(...)			(-ENOSYS)
+# define fuse_iomap_open(...)			((void)0)
+# define fuse_want_iomap_directio(...)		(false)
+# define fuse_iomap_direct_read(...)		(-ENOSYS)
+# define fuse_iomap_direct_write(...)		(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index cc4bca2941cb79..4835a40b8af664 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -666,6 +666,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1389,4 +1390,25 @@ struct fuse_iomap_end_in {
 	struct fuse_iomap_io	map;
 };
 
+/* out of place write extent */
+#define FUSE_IOMAP_IOEND_SHARED		(1U << 0)
+/* unwritten extent */
+#define FUSE_IOMAP_IOEND_UNWRITTEN	(1U << 1)
+/* don't merge into previous ioend */
+#define FUSE_IOMAP_IOEND_BOUNDARY	(1U << 2)
+/* is direct I/O */
+#define FUSE_IOMAP_IOEND_DIRECT		(1U << 3)
+/* is append ioend */
+#define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
+
+struct fuse_iomap_ioend_in {
+	uint32_t ioendflags;	/* FUSE_IOMAP_IOEND_* */
+	int32_t error;		/* negative errno or 0 */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t new_addr;	/* disk offset of new mapping, in bytes */
+	uint32_t written;	/* bytes processed */
+	uint32_t reserved1;	/* zero */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 467ea2f46798ba..e0022eea806fbd 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -712,6 +712,10 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		goto out_acl_release;
 	fuse_dir_changed(dir);
+
+	if (fuse_inode_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (!err) {
 		file->private_data = ff;
@@ -1750,6 +1754,9 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_inode_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1941dd7846f12a..baf433b4c23e1b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -246,6 +246,9 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (is_iomap)
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
@@ -1754,10 +1757,17 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
+	ssize_t ret;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_want_iomap_directio(iocb)) {
+		ret = fuse_iomap_direct_read(iocb, to);
+		if (ret != -ENOSYS)
+			return ret;
+	}
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
@@ -1779,6 +1789,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_want_iomap_directio(iocb)) {
+		ssize_t ret = fuse_iomap_direct_write(iocb, from);
+		if (ret != -ENOSYS)
+			return ret;
+	}
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 88d85d572faf97..84eb1fe4fcde49 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -495,10 +495,15 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 }
 
 /* Decide if we send FUSE_IOMAP_END to the fuse server */
-static bool fuse_should_send_iomap_end(const struct iomap *iomap,
+static bool fuse_should_send_iomap_end(const struct fuse_mount *fm,
+				       const struct iomap *iomap,
 				       unsigned int opflags, loff_t count,
 				       ssize_t written)
 {
+	/* Not implemented on fuse server */
+	if (fm->fc->iomap_conn.no_end)
+		return false;
+
 	/* fuse server demanded an iomap_end call. */
 	if (iomap->flags & FUSE_IOMAP_F_WANT_IOMAP_END)
 		return true;
@@ -523,7 +528,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	int err = 0;
 
-	if (fuse_should_send_iomap_end(iomap, opflags, count, written)) {
+	if (fuse_should_send_iomap_end(fm, iomap, opflags, count, written)) {
 		struct fuse_iomap_end_in inarg = {
 			.opflags = fuse_iomap_op_to_server(opflags),
 			.attr_ino = fi->orig_ino,
@@ -549,6 +554,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			 * libfuse returns ENOSYS for servers that don't
 			 * implement iomap_end
 			 */
+			fm->fc->iomap_conn.no_end = 1;
 			err = 0;
 			break;
 		case 0:
@@ -567,6 +573,95 @@ static const struct iomap_ops fuse_iomap_ops = {
 	.iomap_end		= fuse_iomap_end,
 };
 
+static inline bool
+fuse_should_send_iomap_ioend(const struct fuse_mount *fm,
+			     const struct fuse_iomap_ioend_in *inarg)
+{
+	/* Not implemented on fuse server */
+	if (fm->fc->iomap_conn.no_ioend)
+		return false;
+
+	/* Always send an ioend for errors. */
+	if (inarg->error)
+		return true;
+
+	/* Send an ioend if we performed an IO involving metadata changes. */
+	return inarg->written > 0 &&
+	       (inarg->ioendflags & (FUSE_IOMAP_IOEND_SHARED |
+				     FUSE_IOMAP_IOEND_UNWRITTEN |
+				     FUSE_IOMAP_IOEND_APPEND));
+}
+
+/*
+ * Fast and loose check if this write could update the on-disk inode size.
+ */
+static inline bool fuse_ioend_is_append(const struct fuse_inode *fi,
+					loff_t pos, size_t written)
+{
+	return pos + written > i_size_read(&fi->inode);
+}
+
+static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
+			    int error, unsigned ioendflags, sector_t new_addr)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_iomap_ioend_in inarg = {
+		.ioendflags = ioendflags,
+		.error = error,
+		.attr_ino = fi->orig_ino,
+		.pos = pos,
+		.written = written,
+		.new_addr = new_addr,
+	};
+
+	if (fuse_ioend_is_append(fi, pos, written))
+		inarg.ioendflags |= FUSE_IOMAP_IOEND_APPEND;
+
+	if (fuse_should_send_iomap_ioend(fm, &inarg)) {
+		FUSE_ARGS(args);
+		int err;
+
+		args.opcode = FUSE_IOMAP_IOEND;
+		args.nodeid = get_node_id(inode);
+		args.in_numargs = 1;
+		args.in_args[0].size = sizeof(inarg);
+		args.in_args[0].value = &inarg;
+		err = fuse_simple_request(fm, &args);
+		switch (err) {
+		case -ENOSYS:
+			/*
+			 * fuse servers can return ENOSYS if ioend processing
+			 * is never needed for this filesystem.
+			 */
+			fm->fc->iomap_conn.no_ioend = 1;
+			err = 0;
+			break;
+		case 0:
+			break;
+		default:
+			/*
+			 * If the write IO failed, return the failure code to
+			 * the caller no matter what happens with the ioend.
+			 * If the write IO succeeded but the ioend did not,
+			 * pass the new error up to the caller.
+			 */
+			if (!error)
+				error = err;
+			break;
+		}
+	}
+	if (error)
+		return error;
+
+	/*
+	 * If there weren't any ioend errors, update the incore isize, which
+	 * confusingly takes the new i_size as "pos".
+	 */
+	fuse_write_update_attr(inode, pos + written, written);
+	return 0;
+}
+
 static int fuse_iomap_may_admin(struct fuse_conn *fc, unsigned int flags)
 {
 	if (!fc->iomap)
@@ -616,6 +711,8 @@ void fuse_iomap_mount(struct fuse_mount *fm)
 	 * freeze/thaw properly.
 	 */
 	fc->sync_fs = true;
+	fc->iomap_conn.no_end = 0;
+	fc->iomap_conn.no_ioend = 0;
 }
 
 void fuse_iomap_unmount(struct fuse_mount *fm)
@@ -739,3 +836,151 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
 		return offset;
 	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
 }
+
+void fuse_iomap_open(struct inode *inode, struct file *file)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+}
+
+enum fuse_ilock_type {
+	SHARED,
+	EXCL,
+};
+
+static int fuse_iomap_ilock_iocb(const struct kiocb *iocb,
+				 enum fuse_ilock_type type)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		switch (type) {
+		case SHARED:
+			return inode_trylock_shared(inode) ? 0 : -EAGAIN;
+		case EXCL:
+			return inode_trylock(inode) ? 0 : -EAGAIN;
+		default:
+			ASSERT(0);
+			return -EIO;
+		}
+	} else {
+		switch (type) {
+		case SHARED:
+			inode_lock_shared(inode);
+			break;
+		case EXCL:
+			inode_lock(inode);
+			break;
+		default:
+			ASSERT(0);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (!iov_iter_count(to))
+		return 0; /* skip atime */
+
+	file_accessed(iocb->ki_filp);
+
+	ret = fuse_iomap_ilock_iocb(iocb, SHARED);
+	if (ret)
+		return ret;
+	ret = iomap_dio_rw(iocb, to, &fuse_iomap_ops, NULL, 0, NULL, 0);
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+
+static int fuse_iomap_dio_write_end_io(struct kiocb *iocb, ssize_t written,
+				       int error, unsigned dioflags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	unsigned int nofs_flag;
+	unsigned int ioendflags = FUSE_IOMAP_IOEND_DIRECT;
+	int ret;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (dioflags & IOMAP_DIO_COW)
+		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
+	if (dioflags & IOMAP_DIO_UNWRITTEN)
+		ioendflags |= FUSE_IOMAP_IOEND_UNWRITTEN;
+
+	/*
+	 * We can allocate memory here while doing writeback on behalf of
+	 * memory reclaim.  To avoid memory allocation deadlocks set the
+	 * task-wide nofs context for the following operations.
+	 */
+	nofs_flag = memalloc_nofs_save();
+	ret = fuse_iomap_ioend(inode, iocb->ki_pos, written, error, ioendflags,
+			       FUSE_IOMAP_NULL_ADDR);
+	memalloc_nofs_restore(nofs_flag);
+	return ret;
+}
+
+static const struct iomap_dio_ops fuse_iomap_dio_write_ops = {
+	.end_io		= fuse_iomap_dio_write_end_io,
+};
+
+ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	loff_t blockmask = i_blocksize(inode) - 1;
+	size_t count = iov_iter_count(from);
+	unsigned int flags = 0;
+	ssize_t ret;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (!count)
+		return 0;
+
+	/*
+	 * Unaligned direct writes require zeroing of unwritten head and tail
+	 * blocks.  Extending writes require zeroing of post-EOF tail blocks.
+	 * The zeroing writes must complete before we return the direct write
+	 * to userspace.  Don't even bother trying the fast path.
+	 */
+	if ((iocb->ki_pos | count) & blockmask)
+		flags = IOMAP_DIO_FORCE_WAIT;
+
+	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
+	if (ret)
+		goto out_dsync;
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out_unlock;
+
+	/*
+	 * If we are doing exclusive unaligned I/O, this must be the only I/O
+	 * in-flight.  Otherwise we risk data corruption due to unwritten
+	 * extent conversions from the AIO end_io handler.  Wait for all other
+	 * I/O to drain first.
+	 */
+	if (flags & IOMAP_DIO_FORCE_WAIT)
+		inode_dio_wait(inode);
+
+	ret = iomap_dio_rw(iocb, from, &fuse_iomap_ops,
+			   &fuse_iomap_dio_write_ops, flags, NULL, 0);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	inode_unlock(inode);
+out_dsync:
+	return ret;
+}
diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
index 3b54f639a5423e..9de407148c867d 100644
--- a/fs/fuse/trace.c
+++ b/fs/fuse/trace.c
@@ -9,6 +9,7 @@
 #include "iomap_priv.h"
 
 #include <linux/pagemap.h>
+#include <linux/iomap.h>
 
 #define CREATE_TRACE_POINTS
 #include "fuse_trace.h"


