Return-Path: <linux-fsdevel+bounces-61521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05EAB58989
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8226B17066B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6E11EDA2C;
	Tue, 16 Sep 2025 00:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWElLhEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E321AAE28;
	Tue, 16 Sep 2025 00:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982699; cv=none; b=RRZ5r8uukfMqBcwEgJObwPG0RmF5JgyNKq/CqchZd4cxY7OffD75ibIFDLxK7TJkYS3zmPTFuarzxtSGD0Ij53sjXSJWYwvUz37+1XhvkrMT+k9Q+ppYlmxGTXUNrPY+oWpClV1dZ95SEJkX4RPJNrEBHW9rSKjk2S18I22kOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982699; c=relaxed/simple;
	bh=qsbPUkyF5W63g9t2gf+WZUf6e6ihj1jWoY9ffV3a/t4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDjLaTPFFloQ8GtyAOnJWhfaLhtXB+vQ24Q+3iL85IIcYAaQPnB1uict5sFIJMzHb9p1CUE3YXTZlixsAhDlPHhzFPj9iNUZGKNRa2podenVPYRdMIukcQnaeXtRTl04KI1Kyuk6uCldX2vC3pRuVy8Z8/uP44s7TD3LOVAxkSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWElLhEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF97BC4CEF1;
	Tue, 16 Sep 2025 00:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982698;
	bh=qsbPUkyF5W63g9t2gf+WZUf6e6ihj1jWoY9ffV3a/t4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GWElLhECFOPloahB4FaP6ndsFjn4rsWimeRYSMbCcIY7QoVzwKHD6v9+mw4J/NKiG
	 7vk4OueJesd4PKlkQqSLWS7fI60gTYFuVy/j+XMmtd5nD2618zXl1gObhDvIKfgPSy
	 Vr3LTzSAkGOyCi0p/vU1HwZSYQjKNWeva13AZTw7+KUFQUMOBEcmoBnc1Hw38zUqvE
	 Z2+3xq+ixzr07aVSjCU4UUHK3UMrt0qhS1p/OLr5BMcKYLbo2Vs25N7DPEJxehyE1i
	 sWOCGLCk8Lzn7k7hfYgTDHspnPUlEMtV42GGLQAJqywvXr3IVLTRbteellc1C1yOgc
	 UmfuLtYxsu4+A==
Date: Mon, 15 Sep 2025 17:31:37 -0700
Subject: [PATCH 14/28] fuse: implement buffered IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151567.382724.5288338069388850292.stgit@frogsfrogsfrogs>
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

Implement pagecache IO with iomap, complete with hooks into truncate and
fallocate so that the fuse server needn't implement disk block zeroing
of post-EOF and unaligned punch/zero regions.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   30 ++
 include/uapi/linux/fuse.h |    5 
 fs/fuse/dir.c             |   23 ++
 fs/fuse/file.c            |   86 +++++-
 fs/fuse/file_iomap.c      |  659 ++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 777 insertions(+), 26 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ed0608d84ac76c..7581d22de2340c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -179,6 +179,13 @@ struct fuse_inode {
 
 			/* waitq for direct-io completion */
 			wait_queue_head_t direct_io_waitq;
+
+#ifdef CONFIG_FUSE_IOMAP
+			/* pending io completions */
+			spinlock_t ioend_lock;
+			struct work_struct ioend_work;
+			struct list_head ioend_list;
+#endif
 		};
 
 		/* readdir cache (directory only) */
@@ -1720,6 +1727,8 @@ void fuse_iomap_sysfs_cleanup(struct kobject *kobj);
 # define fuse_iomap_sysfs_cleanup(...)		((void)0)
 #endif
 
+sector_t fuse_bmap(struct address_space *mapping, sector_t block);
+
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 bool fuse_iomap_enabled(void);
 
@@ -1758,6 +1767,20 @@ static inline bool fuse_want_iomap_directio(const struct kiocb *iocb)
 
 ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from);
+
+static inline bool fuse_want_iomap_buffered_io(const struct kiocb *iocb)
+{
+	return fuse_inode_has_iomap(file_inode(iocb->ki_filp));
+}
+
+int fuse_iomap_mmap(struct file *file, struct vm_area_struct *vma);
+ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from);
+int fuse_iomap_setsize_start(struct inode *inode, loff_t newsize);
+int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
+			 loff_t length, loff_t new_size);
+int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
+				 loff_t endpos);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1773,6 +1796,13 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from);
 # define fuse_want_iomap_directio(...)		(false)
 # define fuse_iomap_direct_read(...)		(-ENOSYS)
 # define fuse_iomap_direct_write(...)		(-ENOSYS)
+# define fuse_want_iomap_buffered_io(...)	(false)
+# define fuse_iomap_mmap(...)			(-ENOSYS)
+# define fuse_iomap_buffered_read(...)		(-ENOSYS)
+# define fuse_iomap_buffered_write(...)		(-ENOSYS)
+# define fuse_iomap_setsize_start(...)		(-ENOSYS)
+# define fuse_iomap_fallocate(...)		(-ENOSYS)
+# define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 4835a40b8af664..c0af8a4d3e30d8 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1351,6 +1351,9 @@ struct fuse_uring_cmd_req {
 #define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
 #define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
 
+/* pagecache writeback operation */
+#define FUSE_IOMAP_OP_WRITEBACK		(1U << 31)
+
 #define FUSE_IOMAP_NULL_ADDR		(-1ULL)	/* addr is not valid */
 
 struct fuse_iomap_io {
@@ -1400,6 +1403,8 @@ struct fuse_iomap_end_in {
 #define FUSE_IOMAP_IOEND_DIRECT		(1U << 3)
 /* is append ioend */
 #define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
+/* is pagecache writeback */
+#define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
 
 struct fuse_iomap_ioend_in {
 	uint32_t ioendflags;	/* FUSE_IOMAP_IOEND_* */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e0022eea806fbd..d62ceadbc05fb2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2027,7 +2027,10 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		is_truncate = true;
 	}
 
-	if (FUSE_IS_DAX(inode) && is_truncate) {
+	if (is_iomap && is_truncate) {
+		filemap_invalidate_lock(mapping);
+		fault_blocked = true;
+	} else if (FUSE_IS_DAX(inode) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, -1);
@@ -2042,6 +2045,18 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		WARN_ON(!(attr->ia_valid & ATTR_SIZE));
 		WARN_ON(attr->ia_size != 0);
 		if (fc->atomic_o_trunc) {
+			if (is_iomap) {
+				/*
+				 * fuse_open already set the size to zero and
+				 * truncated the pagecache, and we've since
+				 * cycled the inode locks.  Another thread
+				 * could have performed an appending write, so
+				 * we don't want to touch the file further.
+				 */
+				filemap_invalidate_unlock(mapping);
+				return 0;
+			}
+
 			/*
 			 * No need to send request to userspace, since actual
 			 * truncation has already been done by OPEN.  But still
@@ -2075,6 +2090,12 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 		if (trust_local_cmtime && attr->ia_size != inode->i_size)
 			attr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
+
+		if (is_iomap) {
+			err = fuse_iomap_setsize_start(inode, attr->ia_size);
+			if (err)
+				goto error;
+		}
 	}
 
 	memset(&inarg, 0, sizeof(inarg));
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index baf433b4c23e1b..dd65485c9743bf 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -384,7 +384,7 @@ static int fuse_release(struct inode *inode, struct file *file)
 	 * Dirty pages might remain despite write_inode_now() call from
 	 * fuse_flush() due to writes racing with the close.
 	 */
-	if (fc->writeback_cache)
+	if (fc->writeback_cache || fuse_inode_has_iomap(inode))
 		write_inode_now(inode, 1);
 
 	fuse_release_common(file, false);
@@ -1768,6 +1768,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 	}
 
+	if (fuse_want_iomap_buffered_io(iocb))
+		return fuse_iomap_buffered_read(iocb, to);
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
@@ -1791,10 +1794,29 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (fuse_want_iomap_directio(iocb)) {
 		ssize_t ret = fuse_iomap_direct_write(iocb, from);
-		if (ret != -ENOSYS)
+		switch (ret) {
+		case -ENOTBLK:
+			/*
+			 * If we're going to fall back to the iomap buffered
+			 * write path only, then try the write again as a
+			 * synchronous buffered write.  Otherwise we let it
+			 * drop through to the old ->direct_IO path.
+			 */
+			if (fuse_want_iomap_buffered_io(iocb))
+				iocb->ki_flags |= IOCB_SYNC;
+			fallthrough;
+		case -ENOSYS:
+			/* no implementation, fall through */
+			break;
+		default:
+			/* errors, no progress, or even partial progress */
 			return ret;
+		}
 	}
 
+	if (fuse_want_iomap_buffered_io(iocb))
+		return fuse_iomap_buffered_write(iocb, from);
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
@@ -2331,6 +2353,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	struct inode *inode = file_inode(file);
 	int rc;
 
+	if (fuse_inode_has_iomap(inode))
+		return fuse_iomap_mmap(file, vma);
+
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_mmap(file, vma);
@@ -2529,7 +2554,7 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
 	return err;
 }
 
-static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
+sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -2883,8 +2908,12 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static int fuse_writeback_range(struct inode *inode, loff_t start, loff_t end)
 {
-	int err = filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
+	int err;
 
+	if (fuse_inode_has_iomap(inode))
+		return fuse_iomap_flush_unmap_range(inode, start, end);
+
+	err = filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
 	if (!err)
 		fuse_sync_writes(inode);
 
@@ -2905,7 +2934,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.length = length,
 		.mode = mode
 	};
+	loff_t newsize = 0;
 	int err;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool block_faults = FUSE_IS_DAX(inode) &&
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
 		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
@@ -2918,7 +2949,10 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
-	if (block_faults) {
+	if (is_iomap) {
+		filemap_invalidate_lock(inode->i_mapping);
+		block_faults = true;
+	} else if (block_faults) {
 		filemap_invalidate_lock(inode->i_mapping);
 		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
@@ -2933,11 +2967,23 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 			goto out;
 	}
 
+	/*
+	 * If we are using iomap for file IO, fallocate must wait for all AIO
+	 * to complete before we continue as AIO can change the file size on
+	 * completion without holding any locks we currently hold. We must do
+	 * this first because AIO can update the in-memory inode size, and the
+	 * operations that follow require the in-memory size to be fully
+	 * up-to-date.
+	 */
+	if (is_iomap)
+		inode_dio_wait(inode);
+
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
 	    offset + length > i_size_read(inode)) {
 		err = inode_newsize_ok(inode, offset + length);
 		if (err)
 			goto out;
+		newsize = offset + length;
 	}
 
 	err = file_modified(file);
@@ -2960,14 +3006,22 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (err)
 		goto out;
 
-	/* we could have extended the file */
-	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
-		if (fuse_write_update_attr(inode, offset + length, length))
-			file_update_time(file);
-	}
+	if (is_iomap) {
+		err = fuse_iomap_fallocate(file, mode, offset, length,
+					   newsize);
+		if (err)
+			goto out;
+	} else {
+		/* we could have extended the file */
+		if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+			if (fuse_write_update_attr(inode, newsize, length))
+				file_update_time(file);
+		}
 
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
-		truncate_pagecache_range(inode, offset, offset + length - 1);
+		if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
+			truncate_pagecache_range(inode, offset,
+						 offset + length - 1);
+	}
 
 	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 
@@ -3010,6 +3064,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	ssize_t err;
 	/* mark unstable when write-back is not used, and file_out gets
 	 * extended */
+	const bool is_iomap = fuse_inode_has_iomap(inode_out);
 	bool is_unstable = (!fc->writeback_cache) &&
 			   ((pos_out + len) > inode_out->i_size);
 
@@ -3053,6 +3108,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
+	/* See inode_dio_wait comment in fuse_file_fallocate */
+	if (is_iomap)
+		inode_dio_wait(inode_out);
+
 	if (is_unstable)
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
 
@@ -3075,7 +3134,8 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
-	truncate_inode_pages_range(inode_out->i_mapping,
+	if (!is_iomap)
+		truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
 
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 54e09f60980ef1..64f851d04a009b 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -5,6 +5,8 @@
  */
 #include <linux/iomap.h>
 #include <linux/fiemap.h>
+#include <linux/pagemap.h>
+#include <linux/falloc.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "iomap_priv.h"
@@ -241,7 +243,7 @@ static inline uint16_t fuse_iomap_flags_from_server(uint16_t fuse_f_flags)
 		ret |= FUSE_IOMAP_OP_##word
 static inline uint32_t fuse_iomap_op_to_server(unsigned iomap_op_flags)
 {
-	uint32_t ret = 0;
+	uint32_t ret = iomap_op_flags & FUSE_IOMAP_OP_WRITEBACK;
 
 	XMAP(WRITE);
 	XMAP(ZERO);
@@ -389,7 +391,8 @@ fuse_iomap_begin_validate(const struct inode *inode,
 
 static inline bool fuse_is_iomap_file_write(unsigned int opflags)
 {
-	return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE);
+	return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE |
+			  FUSE_IOMAP_OP_WRITEBACK);
 }
 
 static inline struct fuse_backing *
@@ -736,14 +739,7 @@ void fuse_iomap_unmount(struct fuse_mount *fm)
 	fuse_send_destroy(fm);
 }
 
-static inline void fuse_inode_set_iomap(struct inode *inode)
-{
-	struct fuse_inode *fi = get_fuse_inode(inode);
-
-	ASSERT(fuse_has_iomap(inode));
-
-	set_bit(FUSE_I_IOMAP, &fi->state);
-}
+static inline void fuse_inode_set_iomap(struct inode *inode);
 
 static inline void fuse_inode_clear_iomap(struct inode *inode)
 {
@@ -946,6 +942,110 @@ static const struct iomap_dio_ops fuse_iomap_dio_write_ops = {
 	.end_io		= fuse_iomap_dio_write_end_io,
 };
 
+static const struct iomap_write_ops fuse_iomap_write_ops = {
+};
+
+static int
+fuse_iomap_zero_range(
+	struct inode		*inode,
+	loff_t			pos,
+	loff_t			len,
+	bool			*did_zero)
+{
+	return iomap_zero_range(inode, pos, len, did_zero, &fuse_iomap_ops,
+				&fuse_iomap_write_ops, NULL);
+}
+
+/* Take care of zeroing post-EOF blocks when they might exist. */
+static ssize_t
+fuse_iomap_write_zero_eof(
+	struct kiocb		*iocb,
+	struct iov_iter		*from,
+	bool			*drained_dio)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	loff_t			isize;
+	int			error;
+
+	/*
+	 * We need to serialise against EOF updates that occur in IO
+	 * completions here. We want to make sure that nobody is changing the
+	 * size while we do this check until we have placed an IO barrier (i.e.
+	 * hold i_rwsem exclusively) that prevents new IO from being
+	 * dispatched.  The spinlock effectively forms a memory barrier once we
+	 * have i_rwsem exclusively so we are guaranteed to see the latest EOF
+	 * value and hence be able to correctly determine if we need to run
+	 * zeroing.
+	 */
+	spin_lock(&fi->lock);
+	isize = i_size_read(inode);
+	if (iocb->ki_pos <= isize) {
+		spin_unlock(&fi->lock);
+		return 0;
+	}
+	spin_unlock(&fi->lock);
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+
+	if (!(*drained_dio)) {
+		/*
+		 * We now have an IO submission barrier in place, but AIO can
+		 * do EOF updates during IO completion and hence we now need to
+		 * wait for all of them to drain.  Non-AIO DIO will have
+		 * drained before we are given the exclusive i_rwsem, and so
+		 * for most cases this wait is a no-op.
+		 */
+		inode_dio_wait(inode);
+		*drained_dio = true;
+		return 1;
+	}
+
+	filemap_invalidate_lock(mapping);
+	error = fuse_iomap_zero_range(inode, isize, iocb->ki_pos - isize, NULL);
+	filemap_invalidate_unlock(mapping);
+
+	return error;
+}
+
+static ssize_t
+fuse_iomap_write_checks(
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	ssize_t			error;
+	bool			drained_dio = false;
+
+restart:
+	error = generic_write_checks(iocb, from);
+	if (error <= 0)
+		return error;
+
+	/*
+	 * If the offset is beyond the size of the file, we need to zero all
+	 * blocks that fall between the existing EOF and the start of this
+	 * write.
+	 *
+	 * We can do an unlocked check for i_size here safely as I/O completion
+	 * can only extend EOF.  Truncate is locked out at this point, so the
+	 * EOF cannot move backwards, only forwards. Hence we only need to take
+	 * the slow path when we are at or beyond the current EOF.
+	 */
+	if (fuse_inode_has_iomap(inode) &&
+	    iocb->ki_pos > i_size_read(inode)) {
+		error = fuse_iomap_write_zero_eof(iocb, from, &drained_dio);
+		if (error == 1)
+			goto restart;
+		if (error)
+			return error;
+	}
+
+	return kiocb_modified(iocb);
+}
+
 ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -973,8 +1073,9 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
 	if (ret)
 		goto out_dsync;
-	ret = generic_write_checks(iocb, from);
-	if (ret <= 0)
+
+	ret = fuse_iomap_write_checks(iocb, from);
+	if (ret)
 		goto out_unlock;
 
 	/*
@@ -997,3 +1098,537 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	trace_fuse_iomap_direct_write_end(iocb, from, ret);
 	return ret;
 }
+
+struct fuse_writepage_ctx {
+	struct iomap_writepage_ctx ctx;
+};
+
+static void fuse_iomap_end_ioend(struct iomap_ioend *ioend)
+{
+	struct inode *inode = ioend->io_inode;
+	unsigned int ioendflags = FUSE_IOMAP_IOEND_WRITEBACK;
+	unsigned int nofs_flag;
+	int error = blk_status_to_errno(ioend->io_bio.bi_status);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (fuse_is_bad(inode))
+		return;
+
+	if (ioend->io_flags & IOMAP_IOEND_SHARED)
+		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
+	if (ioend->io_flags & IOMAP_IOEND_UNWRITTEN)
+		ioendflags |= FUSE_IOMAP_IOEND_UNWRITTEN;
+
+	/*
+	 * We can allocate memory here while doing writeback on behalf of
+	 * memory reclaim.  To avoid memory allocation deadlocks set the
+	 * task-wide nofs context for the following operations.
+	 */
+	nofs_flag = memalloc_nofs_save();
+	fuse_iomap_ioend(inode, ioend->io_offset, ioend->io_size, error,
+			 ioendflags, ioend->io_sector);
+	iomap_finish_ioends(ioend, error);
+	memalloc_nofs_restore(nofs_flag);
+}
+
+/*
+ * Finish all pending IO completions that require transactional modifications.
+ *
+ * We try to merge physical and logically contiguous ioends before completion to
+ * minimise the number of transactions we need to perform during IO completion.
+ * Both unwritten extent conversion and COW remapping need to iterate and modify
+ * one physical extent at a time, so we gain nothing by merging physically
+ * discontiguous extents here.
+ *
+ * The ioend chain length that we can be processing here is largely unbound in
+ * length and we may have to perform significant amounts of work on each ioend
+ * to complete it. Hence we have to be careful about holding the CPU for too
+ * long in this loop.
+ */
+static void fuse_iomap_end_io(struct work_struct *work)
+{
+	struct fuse_inode *fi =
+		container_of(work, struct fuse_inode, ioend_work);
+	struct iomap_ioend *ioend;
+	struct list_head tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fi->ioend_lock, flags);
+	list_replace_init(&fi->ioend_list, &tmp);
+	spin_unlock_irqrestore(&fi->ioend_lock, flags);
+
+	iomap_sort_ioends(&tmp);
+	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
+			io_list))) {
+		list_del_init(&ioend->io_list);
+		iomap_ioend_try_merge(ioend, &tmp);
+		fuse_iomap_end_ioend(ioend);
+		cond_resched();
+	}
+}
+
+static void fuse_iomap_end_bio(struct bio *bio)
+{
+	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
+	struct inode *inode = ioend->io_inode;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	unsigned long flags;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	spin_lock_irqsave(&fi->ioend_lock, flags);
+	if (list_empty(&fi->ioend_list))
+		WARN_ON_ONCE(!queue_work(system_unbound_wq, &fi->ioend_work));
+	list_add_tail(&ioend->io_list, &fi->ioend_list);
+	spin_unlock_irqrestore(&fi->ioend_lock, flags);
+}
+
+/*
+ * Fast revalidation of the cached writeback mapping. Return true if the current
+ * mapping is valid, false otherwise.
+ */
+static bool fuse_iomap_revalidate_writeback(struct iomap_writepage_ctx *wpc,
+					    loff_t offset)
+{
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length)
+		return false;
+
+	/* XXX actually use revalidation cookie */
+	return true;
+}
+
+/*
+ * If the folio has delalloc blocks on it, the caller is asking us to punch them
+ * out. If we don't, we can leave a stale delalloc mapping covered by a clean
+ * page that needs to be dirtied again before the delalloc mapping can be
+ * converted. This stale delalloc mapping can trip up a later direct I/O read
+ * operation on the same region.
+ *
+ * We prevent this by truncating away the delalloc regions on the folio. Because
+ * they are delalloc, we can do this without needing a transaction. Indeed - if
+ * we get ENOSPC errors, we have to be able to do this truncation without a
+ * transaction as there is no space left for block reservation (typically why
+ * we see a ENOSPC in writeback).
+ */
+static void fuse_iomap_discard_folio(struct folio *folio, loff_t pos, int error)
+{
+	struct inode *inode = folio->mapping->host;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	loff_t end = folio_pos(folio) + folio_size(folio);
+
+	if (fuse_is_bad(inode))
+		return;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	printk_ratelimited(KERN_ERR
+		"page discard on page %px, inode 0x%llx, pos %llu.",
+			folio, fi->orig_ino, pos);
+
+	/* Userspace may need to remove delayed allocations */
+	fuse_iomap_ioend(inode, pos, end - pos, error, 0, FUSE_IOMAP_NULL_ADDR);
+}
+
+static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
+					  struct folio *folio, u64 offset,
+					  unsigned int len, u64 end_pos)
+{
+	struct inode *inode = wpc->inode;
+	struct iomap write_iomap, dontcare;
+	ssize_t ret;
+
+	if (fuse_is_bad(inode)) {
+		ret = -EIO;
+		goto discard_folio;
+	}
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (!fuse_iomap_revalidate_writeback(wpc, offset)) {
+		ret = fuse_iomap_begin(inode, offset, len,
+				       FUSE_IOMAP_OP_WRITEBACK,
+				       &write_iomap, &dontcare);
+		if (ret)
+			goto discard_folio;
+
+		/*
+		 * Landed in a hole or beyond EOF?  Send that to iomap, it'll
+		 * skip writing back the file range.
+		 */
+		if (write_iomap.offset > offset) {
+			write_iomap.length = write_iomap.offset - offset;
+			write_iomap.offset = offset;
+			write_iomap.type = IOMAP_HOLE;
+		}
+
+		memcpy(&wpc->iomap, &write_iomap, sizeof(struct iomap));
+	}
+
+	ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
+	if (ret < 0)
+		goto discard_folio;
+
+	return ret;
+discard_folio:
+	fuse_iomap_discard_folio(folio, offset, ret);
+	return ret;
+}
+
+static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
+				       int error)
+{
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+
+	ASSERT(fuse_inode_has_iomap(ioend->io_inode));
+
+	/* always call our ioend function, even if we cancel the bio */
+	ioend->io_bio.bi_end_io = fuse_iomap_end_bio;
+	return iomap_ioend_writeback_submit(wpc, error);
+}
+
+static const struct iomap_writeback_ops fuse_iomap_writeback_ops = {
+	.writeback_range	= fuse_iomap_writeback_range,
+	.writeback_submit	= fuse_iomap_writeback_submit,
+};
+
+static int fuse_iomap_writepages(struct address_space *mapping,
+				 struct writeback_control *wbc)
+{
+	struct fuse_writepage_ctx wpc = {
+		.ctx = {
+			.inode = mapping->host,
+			.wbc = wbc,
+			.ops = &fuse_iomap_writeback_ops,
+		},
+	};
+
+	ASSERT(fuse_inode_has_iomap(mapping->host));
+
+	return iomap_writepages(&wpc.ctx);
+}
+
+static int fuse_iomap_read_folio(struct file *file, struct folio *folio)
+{
+	ASSERT(fuse_inode_has_iomap(file_inode(file)));
+
+	return iomap_read_folio(folio, &fuse_iomap_ops);
+}
+
+static void fuse_iomap_readahead(struct readahead_control *rac)
+{
+	ASSERT(fuse_inode_has_iomap(file_inode(rac->file)));
+
+	iomap_readahead(rac, &fuse_iomap_ops);
+}
+
+static const struct address_space_operations fuse_iomap_aops = {
+	.read_folio		= fuse_iomap_read_folio,
+	.readahead		= fuse_iomap_readahead,
+	.writepages		= fuse_iomap_writepages,
+	.dirty_folio		= iomap_dirty_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate  = iomap_is_partially_uptodate,
+	.error_remove_folio	= generic_error_remove_folio,
+
+	/* These aren't pagecache operations per se */
+	.bmap			= fuse_bmap,
+};
+
+static inline void fuse_inode_set_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_has_iomap(inode));
+
+	inode->i_data.a_ops = &fuse_iomap_aops;
+
+	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
+	INIT_LIST_HEAD(&fi->ioend_list);
+	spin_lock_init(&fi->ioend_lock);
+	set_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+/*
+ * Locking for serialisation of IO during page faults. This results in a lock
+ * ordering of:
+ *
+ * mmap_lock (MM)
+ *   sb_start_pagefault(vfs, freeze)
+ *     invalidate_lock (vfs - truncate serialisation)
+ *       page_lock (MM)
+ *         i_lock (FUSE - extent map serialisation)
+ */
+static vm_fault_t fuse_iomap_page_mkwrite(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	vm_fault_t ret;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	sb_start_pagefault(inode->i_sb);
+	file_update_time(vmf->vma->vm_file);
+
+	filemap_invalidate_lock_shared(mapping);
+	ret = iomap_page_mkwrite(vmf, &fuse_iomap_ops, NULL);
+	filemap_invalidate_unlock_shared(mapping);
+
+	sb_end_pagefault(inode->i_sb);
+	return ret;
+}
+
+static const struct vm_operations_struct fuse_iomap_vm_ops = {
+	.fault		= filemap_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= fuse_iomap_page_mkwrite,
+};
+
+int fuse_iomap_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	ASSERT(fuse_inode_has_iomap(file_inode(file)));
+
+	file_accessed(file);
+	vma->vm_ops = &fuse_iomap_vm_ops;
+	return 0;
+}
+
+ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to)
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
+	ret = generic_file_read_iter(iocb, to);
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+
+ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	loff_t pos = iocb->ki_pos;
+	ssize_t ret;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (!iov_iter_count(from))
+		return 0;
+
+	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
+	if (ret)
+		return ret;
+
+	ret = fuse_iomap_write_checks(iocb, from);
+	if (ret)
+		goto out_unlock;
+
+	if (inode->i_size < pos + iov_iter_count(from))
+		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+
+	ret = iomap_file_buffered_write(iocb, from, &fuse_iomap_ops,
+					&fuse_iomap_write_ops, NULL);
+
+	if (ret > 0)
+		fuse_write_update_attr(inode, pos + ret, ret);
+	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+
+out_unlock:
+	inode_unlock(inode);
+
+	if (ret > 0) {
+		/* Handle various SYNC-type writes */
+		ret = generic_write_sync(iocb, ret);
+	}
+	return ret;
+}
+
+static int
+fuse_iomap_truncate_page(
+	struct inode *inode,
+	loff_t			pos,
+	bool			*did_zero)
+{
+	return iomap_truncate_page(inode, pos, did_zero, &fuse_iomap_ops,
+				   &fuse_iomap_write_ops, NULL);
+}
+/*
+ * Truncate pagecache for a file before sending the truncate request to
+ * userspace.  Must have write permission and not be a directory.
+ *
+ * Caution: The caller of this function is responsible for calling
+ * setattr_prepare() or otherwise verifying the change is fine.
+ */
+int
+fuse_iomap_setsize_start(
+	struct inode		*inode,
+	loff_t			newsize)
+{
+	loff_t			oldsize = i_size_read(inode);
+	int			error;
+	bool			did_zeroing = false;
+
+	rwsem_assert_held_write(&inode->i_rwsem);
+	rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
+	ASSERT(S_ISREG(inode->i_mode));
+
+	/*
+	 * Wait for all direct I/O to complete.
+	 */
+	inode_dio_wait(inode);
+
+	/*
+	 * File data changes must be complete and flushed to disk before we
+	 * call userspace to modify the inode.
+	 *
+	 * Start with zeroing any data beyond EOF that we may expose on file
+	 * extension, or zeroing out the rest of the block on a downward
+	 * truncate.
+	 */
+	if (newsize > oldsize)
+		error = fuse_iomap_zero_range(inode, oldsize, newsize - oldsize,
+					      &did_zeroing);
+	else
+		error = fuse_iomap_truncate_page(inode, newsize, &did_zeroing);
+	if (error)
+		return error;
+
+	/*
+	 * We've already locked out new page faults, so now we can safely
+	 * remove pages from the page cache knowing they won't get refaulted
+	 * until we drop the mapping invalidation lock after the extent
+	 * manipulations are complete. The truncate_setsize() call also cleans
+	 * folios spanning EOF on extending truncates and hence ensures
+	 * sub-page block size filesystems are correctly handled, too.
+	 *
+	 * And we update in-core i_size and truncate page cache beyond newsize
+	 * before writing back the whole file, so we're guaranteed not to write
+	 * stale data past the new EOF on truncate down.
+	 */
+	truncate_setsize(inode, newsize);
+
+	/*
+	 * Flush the entire pagecache to ensure the fuse server logs the inode
+	 * size change and all dirty data that might be associated with it.
+	 * We don't know the ondisk inode size, so we only have this clumsy
+	 * hammer.
+	 */
+	return filemap_write_and_wait(inode->i_mapping);
+}
+
+/*
+ * Prepare for a file data block remapping operation by flushing and unmapping
+ * all pagecache for the entire range.
+ */
+int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
+				 loff_t endpos)
+{
+	loff_t			start, end;
+	unsigned int		rounding;
+	int			error;
+
+	/*
+	 * Make sure we extend the flush out to extent alignment boundaries so
+	 * any extent range overlapping the start/end of the modification we
+	 * are about to do is clean and idle.
+	 */
+	rounding = max_t(unsigned int, i_blocksize(inode), PAGE_SIZE);
+	start = round_down(pos, rounding);
+	end = round_up(endpos + 1, rounding) - 1;
+
+	error = filemap_write_and_wait_range(inode->i_mapping, start, end);
+	if (error)
+		return error;
+	truncate_pagecache_range(inode, start, end);
+	return 0;
+}
+
+static int fuse_iomap_punch_range(struct inode *inode, loff_t offset,
+				  loff_t length)
+{
+	loff_t isize = i_size_read(inode);
+	int error;
+
+	/*
+	 * Now that we've unmap all full blocks we'll have to zero out any
+	 * partial block at the beginning and/or end.  iomap_zero_range is
+	 * smart enough to skip holes and unwritten extents, including those we
+	 * just created, but we must take care not to zero beyond EOF, which
+	 * would enlarge i_size.
+	 */
+	if (offset >= isize)
+		return 0;
+	if (offset + length > isize)
+		length = isize - offset;
+	error = fuse_iomap_zero_range(inode, offset, length, NULL);
+	if (error)
+		return error;
+
+	/*
+	 * If we zeroed right up to EOF and EOF straddles a page boundary we
+	 * must make sure that the post-EOF area is also zeroed because the
+	 * page could be mmap'd and iomap_zero_range doesn't do that for us.
+	 * Writeback of the eof page will do this, albeit clumsily.
+	 */
+	if (offset + length >= isize && offset_in_page(offset + length) > 0) {
+		error = filemap_write_and_wait_range(inode->i_mapping,
+					round_down(offset + length, PAGE_SIZE),
+					LLONG_MAX);
+	}
+
+	return error;
+}
+
+int
+fuse_iomap_fallocate(
+	struct file		*file,
+	int			mode,
+	loff_t			offset,
+	loff_t			length,
+	loff_t			new_size)
+{
+	struct inode *inode = file_inode(file);
+	int error;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	/*
+	 * If we unmapped blocks from the file range, then we zero the
+	 * pagecache for those regions and push them to disk rather than make
+	 * the fuse server manually zero the disk blocks.
+	 */
+	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) {
+		error = fuse_iomap_punch_range(inode, offset, length);
+		if (error)
+			return error;
+	}
+
+	/*
+	 * If this is an extending write, we need to zero the bytes beyond the
+	 * new EOF and bounce the new size out to userspace.
+	 */
+	if (new_size) {
+		error = fuse_iomap_setsize_start(inode, new_size);
+		if (error)
+			return error;
+
+		fuse_write_update_attr(inode, new_size, length);
+	}
+
+	file_update_time(file);
+	return 0;
+}


