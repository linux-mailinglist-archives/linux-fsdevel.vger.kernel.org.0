Return-Path: <linux-fsdevel+bounces-49614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD2CAC00F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA27169E3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F2F3D76;
	Thu, 22 May 2025 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9P9Qtxq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981A17D2;
	Thu, 22 May 2025 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872272; cv=none; b=cf0wdyFtBLQL5QtTztV8AQbW7Bd79SaEHt9J90wjtoywf+Ep8u7cIR4ebvN1SaOFjvqDMufNx0XJn9G/TA8oNDqOF5gHYb/NaC9tvTHgUZJ/lAll8L2ibFqceNKnNwoBNnCWNTP5XR86rCVeOh0DxpdjAxJ7wCQgI6GZvsS04Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872272; c=relaxed/simple;
	bh=rsJu2eGbHzKtgyaw7E16V6MN2UJJ8FA0J4uXrO1JR0o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcVDwdWIMwHACGtLypZIZZY1XgwiijaYPc1UoeGgzT637lpJmW948o0JTevpszxTcYGdoU5frlFiG+r7tGboGMYuyWU9VALAPF0HcQEyDAts5PU9/I+CBmbuTGAVug/Qsvj7JZzm22CInWT6lyHRwH0nd5gqRyyJmjjafHbrazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9P9Qtxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6690C4CEE4;
	Thu, 22 May 2025 00:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872272;
	bh=rsJu2eGbHzKtgyaw7E16V6MN2UJJ8FA0J4uXrO1JR0o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=W9P9QtxqnDbop3ttuPkRk8igmj3wfk0mGYOPehF5ZPUA720WiE7nfF7VV2sk8d9QJ
	 yMzZs0g9VL7LWBBPvE4tTREZ+51w9aQR7XVpldHOYFOe/miO+l2yXKG/6K7KAuBMQ7
	 wyvAbPaLwJztGRY4dxJUmaT4c+xg7z0BUFldC1Jriv8txlwJiVHIptPRXDyKkul5OD
	 0E1DP3fmAL27sJR/mqeK4WEZiAvzvyEIx4xsJTq2idYgQ9gNF4M4Z4LsIjYTZTW5gC
	 eosuk8RzBvYUVWs5R9bmTl4/jQNSafS4+C5GokzaNrAhgAJiqtl8+NkcQbDzXcGuWQ
	 4UwxaH1Uq257A==
Date: Wed, 21 May 2025 17:04:31 -0700
Subject: [PATCH 08/11] fuse: implement buffered IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195736.1483178.12556410861384980577.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h          |   42 +++
 fs/fuse/fuse_trace.h      |  308 ++++++++++++++++++++
 include/uapi/linux/fuse.h |    3 
 fs/fuse/dir.c             |    6 
 fs/fuse/file.c            |   48 +++
 fs/fuse/file_iomap.c      |  684 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    7 
 7 files changed, 1088 insertions(+), 10 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 51a373bc7b03d9..8481b1d0299df0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -164,6 +164,13 @@ struct fuse_inode {
 
 			/* List of writepage requestst (pending or sent) */
 			struct rb_root writepages;
+
+#ifdef CONFIG_FUSE_IOMAP
+			/* pending io completions */
+			spinlock_t ioend_lock;
+			struct work_struct ioend_work;
+			struct list_head ioend_list;
+#endif
 		};
 
 		/* readdir cache (directory only) */
@@ -907,6 +914,9 @@ struct fuse_conn {
 	/* Use fs/iomap for direct I/O operations */
 	unsigned int iomap_directio:1;
 
+	/* Use fs/iomap for pagecache I/O operations */
+	unsigned int iomap_pagecache:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
@@ -1613,6 +1623,9 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+sector_t fuse_bmap(struct address_space *mapping, sector_t block);
+ssize_t fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
+
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 # include <linux/fiemap.h>
 # include <linux/iomap.h>
@@ -1650,6 +1663,26 @@ static inline bool fuse_want_iomap_direct_io(const struct kiocb *iocb)
 
 ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from);
+
+static inline bool fuse_has_iomap_pagecache(const struct inode *inode)
+{
+	return get_fuse_conn_c(inode)->iomap_pagecache;
+}
+
+static inline bool fuse_want_iomap_buffered_io(const struct kiocb *iocb)
+{
+	return fuse_has_iomap_pagecache(file_inode(iocb->ki_filp));
+}
+
+void fuse_iomap_init_pagecache(struct inode *inode);
+void fuse_iomap_destroy_pagecache(struct inode *inode);
+int fuse_iomap_mmap(struct file *file, struct vm_area_struct *vma);
+ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from);
+int fuse_iomap_setsize(struct mnt_idmap *idmap, struct dentry *dentry,
+		       struct iattr *iattr);
+int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
+			 loff_t length, loff_t new_size);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1664,6 +1697,15 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from);
 # define fuse_want_iomap_direct_io(...)		(false)
 # define fuse_iomap_direct_read(...)		(-ENOSYS)
 # define fuse_iomap_direct_write(...)		(-ENOSYS)
+# define fuse_has_iomap_pagecache(...)		(false)
+# define fuse_want_iomap_buffered_io(...)	(false)
+# define fuse_iomap_init_pagecache(...)		((void)0)
+# define fuse_iomap_destroy_pagecache(...)	((void)0)
+# define fuse_iomap_mmap(...)			(-ENOSYS)
+# define fuse_iomap_buffered_read(...)		(-ENOSYS)
+# define fuse_iomap_buffered_write(...)		(-ENOSYS)
+# define fuse_iomap_setsize(...)		(-ENOSYS)
+# define fuse_iomap_fallocate(...)		(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index da7c317b664a10..ef86cfa9195070 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -173,6 +173,12 @@ TRACE_EVENT(fuse_request_end,
 	{ IOMAP_DIO_UNWRITTEN,			"unwritten" }, \
 	{ IOMAP_DIO_COW,			"cow" }
 
+#define IOMAP_IOEND_STRINGS \
+	{ IOMAP_IOEND_SHARED,			"shared" }, \
+	{ IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
+	{ IOMAP_IOEND_BOUNDARY,			"boundary" }, \
+	{ IOMAP_IOEND_DIRECT,			"direct" }
+
 TRACE_EVENT(fuse_iomap_begin,
 	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
 		 unsigned opflags),
@@ -590,6 +596,9 @@ DEFINE_EVENT(fuse_iomap_file_io_class, name,		\
 	TP_ARGS(iocb, iter))
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_read);
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_read);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_write_zero_eof);
 
 DECLARE_EVENT_CLASS(fuse_iomap_file_ioend_class,
 	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter,
@@ -626,6 +635,8 @@ DEFINE_EVENT(fuse_iomap_file_ioend_class, name,		\
 	TP_ARGS(iocb, iter, ret))
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_read_end);
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_write_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_read_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_write_end);
 
 TRACE_EVENT(fuse_iomap_dio_write_end_io,
 	TP_PROTO(const struct inode *inode, loff_t pos, ssize_t written,
@@ -659,6 +670,303 @@ TRACE_EVENT(fuse_iomap_dio_write_end_io,
 		  __print_flags(__entry->dioendflags, "|", IOMAP_DIOEND_STRINGS),
 		  __entry->pos, __entry->written, __entry->error)
 );
+
+TRACE_EVENT(fuse_iomap_end_ioend,
+	TP_PROTO(const struct iomap_ioend *ioend),
+
+	TP_ARGS(ioend),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		offset)
+		__field(size_t,		size)
+		__field(unsigned int,	ioendflags)
+		__field(int,		error)
+	),
+
+	TP_fast_assign(
+		const struct inode *inode = ioend->io_inode;
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->offset		=	ioend->io_offset;
+		__entry->size		=	ioend->io_size;
+		__entry->ioendflags	=	ioend->io_flags;
+		__entry->error		=
+				blk_status_to_errno(ioend->io_bio.bi_status);
+	),
+
+	TP_printk("connection %u ino %llu offset 0x%llx size %zu ioendflags (%s) error %d",
+		  __entry->connection, __entry->ino, __entry->offset,
+		  __entry->size,
+		  __print_flags(__entry->ioendflags, "|", IOMAP_IOEND_STRINGS),
+		  __entry->error)
+);
+
+TRACE_EVENT(fuse_iomap_map_blocks,
+	TP_PROTO(const struct inode *inode, loff_t offset, unsigned int count),
+
+	TP_ARGS(inode, offset, count),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		offset)
+		__field(unsigned int,	count)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->offset		=	offset;
+		__entry->count		=	count;
+	),
+
+	TP_printk("connection %u ino %llu offset 0x%llx count %u",
+		  __entry->connection, __entry->ino, __entry->offset,
+		  __entry->count)
+);
+
+TRACE_EVENT(fuse_iomap_submit_ioend,
+	TP_PROTO(const struct inode *inode, unsigned int nr_folios, int error),
+
+	TP_ARGS(inode, nr_folios, error),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(unsigned int,	nr_folios)
+		__field(int,		error)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nr_folios	=	nr_folios;
+		__entry->error		=	error;
+	),
+
+	TP_printk("connection %u ino %llu nr_folios %u error %d",
+		  __entry->connection, __entry->ino, __entry->nr_folios,
+		  __entry->error)
+);
+
+TRACE_EVENT(fuse_iomap_discard_folio,
+	TP_PROTO(const struct inode *inode, loff_t offset, size_t count),
+
+	TP_ARGS(inode, offset, count),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		offset)
+		__field(size_t,		count)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->offset		=	offset;
+		__entry->count		=	count;
+	),
+
+	TP_printk("connection %u ino %llu offset 0x%llx count 0x%zx",
+		  __entry->connection, __entry->ino, __entry->offset,
+		  __entry->count)
+);
+
+TRACE_EVENT(fuse_iomap_writepages,
+	TP_PROTO(const struct inode *inode, const struct writeback_control *wbc),
+
+	TP_ARGS(inode, wbc),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		start)
+		__field(loff_t,		end)
+		__field(long,		nr_to_write)
+		__field(bool,		sync_all)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->start		=	wbc->range_start;
+		__entry->end		=	wbc->range_end;
+		__entry->nr_to_write	=	wbc->nr_to_write;
+		__entry->sync_all	=	wbc->sync_mode == WB_SYNC_ALL;
+	),
+
+	TP_printk("connection %u ino %llu start 0x%llx end 0x%llx nr %ld sync_all? %d",
+		  __entry->connection, __entry->ino, __entry->start,
+		  __entry->end, __entry->nr_to_write, __entry->sync_all)
+);
+
+TRACE_EVENT(fuse_iomap_read_folio,
+	TP_PROTO(const struct folio *folio),
+
+	TP_ARGS(folio),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		pos)
+		__field(size_t,		count)
+	),
+
+	TP_fast_assign(
+		const struct inode *inode = folio->mapping->host;
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->pos		=	folio_pos(folio);
+		__entry->count		=	folio_size(folio);
+	),
+
+	TP_printk("connection %u ino %llu offset 0x%llx count 0x%zx",
+		  __entry->connection, __entry->ino, __entry->pos,
+		  __entry->count)
+);
+
+TRACE_EVENT(fuse_iomap_readahead,
+	TP_PROTO(const struct readahead_control *rac),
+
+	TP_ARGS(rac),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		pos)
+		__field(size_t,		count)
+	),
+
+	TP_fast_assign(
+		const struct inode *inode = file_inode(rac->file);
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+		struct readahead_control *mutrac = (struct readahead_control *)rac;
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->pos		=	readahead_pos(mutrac);
+		__entry->count		=	readahead_length(mutrac);
+	),
+
+	TP_printk("connection %u ino %llu offset 0x%llx count 0x%zx",
+		  __entry->connection, __entry->ino, __entry->pos,
+		  __entry->count)
+);
+
+TRACE_EVENT(fuse_iomap_page_mkwrite,
+	TP_PROTO(const struct vm_fault *vmf),
+
+	TP_ARGS(vmf),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		pos)
+		__field(size_t,		count)
+	),
+
+	TP_fast_assign(
+		const struct inode *inode = file_inode(vmf->vma->vm_file);
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+		struct folio *folio = page_folio(vmf->page);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->pos		=	folio_pos(folio);
+		__entry->count		=	folio_size(folio);
+	),
+
+	TP_printk("connection %u ino %llu offset 0x%llx count 0x%zx",
+		  __entry->connection, __entry->ino, __entry->pos,
+		  __entry->count)
+);
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_range_class,
+	TP_PROTO(const struct inode *inode, loff_t offset, loff_t length),
+	TP_ARGS(inode, offset, length),
+	TP_STRUCT__entry(
+		__field(dev_t, connection)
+		__field(uint64_t, ino)
+		__field(loff_t, size)
+		__field(loff_t, offset)
+		__field(loff_t, length)
+	),
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->size		=	i_size_read(inode);
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+	),
+	TP_printk("connection %u ino %llu disize 0x%llx pos 0x%llx bytecount 0x%llx",
+		  __entry->connection, __entry->ino, __entry->size,
+		  __entry->offset, __entry->length)
+)
+#define DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(name)		\
+DEFINE_EVENT(fuse_iomap_file_range_class, name,		\
+	TP_PROTO(const struct inode *inode, loff_t offset, loff_t length), \
+	TP_ARGS(inode, offset, length))
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_up);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_setsize);
+
+TRACE_EVENT(fuse_iomap_fallocate,
+	TP_PROTO(const struct inode *inode, int mode, loff_t offset,
+		 loff_t length, loff_t newsize),
+	TP_ARGS(inode, mode, offset, length, newsize),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		offset)
+		__field(loff_t,		length)
+		__field(loff_t,		newsize)
+		__field(int,		mode)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->mode		=	mode;
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+		__entry->newsize	=	newsize;
+	),
+
+	TP_printk("connection %u ino %llu mode 0x%x offset 0x%llx length 0x%llx newsize 0x%llx",
+		  __entry->connection, __entry->ino, __entry->mode,
+		  __entry->offset, __entry->length, __entry->newsize)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 4611f912003593..c9402f2b2a335c 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -238,6 +238,7 @@
  *    SEEK_{DATA,HOLE} support
  *  - add FUSE_NOTIFY_ADD_IOMAP_DEVICE for multi-device filesystems
  *  - add FUSE_IOMAP_DIRECTIO for direct I/O support
+ *  - add FUSE_IOMAP_PAGECACHE for buffered I/O support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -449,6 +450,7 @@ struct fuse_file_lock {
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
  *	       operations.
  * FUSE_IOMAP_DIRECTIO: Client supports iomap for direct I/O operations.
+ * FUSE_IOMAP_PAGECACHE: Client supports iomap for pagecache I/O operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -498,6 +500,7 @@ struct fuse_file_lock {
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
 #define FUSE_IOMAP		(1ULL << 43)
 #define FUSE_IOMAP_DIRECTIO	(1ULL << 44)
+#define FUSE_IOMAP_PAGECACHE	(1ULL << 45)
 
 /**
  * CUSE INIT request/reply flags
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c947ad50a9a8eb..2b6c5f3c99338f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2012,6 +2012,12 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 		if (trust_local_cmtime && attr->ia_size != inode->i_size)
 			attr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
+
+		if (fuse_has_iomap_pagecache(inode)) {
+			err = fuse_iomap_setsize(idmap, dentry, attr);
+			if (err)
+				goto error;
+		}
 	}
 
 	memset(&inarg, 0, sizeof(inarg));
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7e8b20f56dd823..a3e9df5f9788d6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -384,7 +384,7 @@ static int fuse_release(struct inode *inode, struct file *file)
 	 * Dirty pages might remain despite write_inode_now() call from
 	 * fuse_flush() due to writes racing with the close.
 	 */
-	if (fc->writeback_cache)
+	if (fc->writeback_cache || fuse_has_iomap_pagecache(inode))
 		write_inode_now(inode, 1);
 
 	fuse_release_common(file, false);
@@ -1734,8 +1734,6 @@ static ssize_t __fuse_direct_read(struct fuse_io_priv *io,
 	return res;
 }
 
-static ssize_t fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
-
 static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t res;
@@ -1792,6 +1790,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 	}
 
+	if (fuse_want_iomap_buffered_io(iocb))
+		return fuse_iomap_buffered_read(iocb, to);
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
@@ -1815,10 +1816,29 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (fuse_want_iomap_direct_io(iocb)) {
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
 
@@ -2653,6 +2673,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	struct inode *inode = file_inode(file);
 	int rc;
 
+	if (fuse_has_iomap_pagecache(inode))
+		return fuse_iomap_mmap(file, vma);
+
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_mmap(file, vma);
@@ -2851,7 +2874,7 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
 	return err;
 }
 
-static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
+sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -3107,8 +3130,7 @@ static inline loff_t fuse_round_up(struct fuse_conn *fc, loff_t off)
 	return round_up(off, fc->max_pages << PAGE_SHIFT);
 }
 
-static ssize_t
-fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+ssize_t fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	ssize_t ret = 0;
@@ -3227,6 +3249,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.length = length,
 		.mode = mode
 	};
+	loff_t newsize = 0;
 	int err;
 	bool block_faults = FUSE_IS_DAX(inode) &&
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
@@ -3260,6 +3283,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		err = inode_newsize_ok(inode, offset + length);
 		if (err)
 			goto out;
+		newsize = offset + length;
 	}
 
 	err = file_modified(file);
@@ -3282,6 +3306,14 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (err)
 		goto out;
 
+	if (fuse_has_iomap_pagecache(inode)) {
+		err = fuse_iomap_fallocate(file, mode, offset, length,
+					   newsize);
+		if (err)
+			goto out;
+		file_update_time(file);
+	}
+
 	/* we could have extended the file */
 	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
 		if (fuse_write_update_attr(inode, offset + length, length))
@@ -3480,4 +3512,6 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, flags);
+	if (fuse_has_iomap_pagecache(inode))
+		fuse_iomap_init_pagecache(inode);
 }
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 077ef51ee47452..345610768edc80 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -6,6 +6,8 @@
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include <linux/iomap.h>
+#include <linux/pagemap.h>
+#include <linux/falloc.h>
 
 static bool __read_mostly enable_iomap =
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
@@ -530,6 +532,8 @@ void fuse_iomap_open(struct inode *inode, struct file *file)
 {
 	if (fuse_has_iomap_direct_io(inode))
 		file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (fuse_has_iomap_pagecache(inode))
+		file->f_mode |= FMODE_NOWAIT;
 }
 
 enum fuse_ilock_type {
@@ -655,6 +659,109 @@ static int fuse_iomap_direct_write_sync(struct kiocb *iocb, loff_t start,
 	return err;
 }
 
+static int
+fuse_iomap_zero_range(
+	struct inode		*inode,
+	loff_t			pos,
+	loff_t			len,
+	bool			*did_zero)
+{
+	return iomap_zero_range(inode, pos, len, did_zero, &fuse_iomap_ops,
+				NULL);
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
+	trace_fuse_iomap_write_zero_eof(iocb, from);
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
+	if (fuse_has_iomap_pagecache(inode) &&
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
@@ -694,8 +801,9 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
 	if (ret)
 		goto out_dsync;
-	ret = generic_write_checks(iocb, from);
-	if (ret <= 0)
+
+	ret = fuse_iomap_write_checks(iocb, from);
+	if (ret)
 		goto out_unlock;
 
 	ret = iomap_dio_rw(iocb, from, &fuse_iomap_ops,
@@ -717,3 +825,575 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		iocb->ki_flags |= IOCB_DSYNC;
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
+	unsigned int ioendflags = 0;
+	unsigned int nofs_flag;
+	int error = blk_status_to_errno(ioend->io_bio.bi_status);
+
+	ASSERT(fuse_has_iomap_pagecache(inode));
+
+	if (fuse_is_bad(inode))
+		return;
+
+	trace_fuse_iomap_end_ioend(ioend);
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
+			 ioendflags, FUSE_IOMAP_NULL_ADDR);
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
+	ASSERT(fuse_has_iomap_pagecache(inode));
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
+static int fuse_iomap_map_blocks(struct iomap_writepage_ctx *wpc,
+				 struct inode *inode, loff_t offset,
+				 unsigned int len)
+{
+	struct iomap write_iomap, dontcare;
+	int ret;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	ASSERT(fuse_has_iomap_pagecache(inode));
+
+	trace_fuse_iomap_map_blocks(inode, offset, len);
+
+	if (fuse_iomap_revalidate_writeback(wpc, offset))
+		return 0;
+
+	/* Pretend that this is a directio write */
+	ret = fuse_iomap_begin(inode, offset, len, IOMAP_DIRECT | IOMAP_WRITE,
+			       &write_iomap, &dontcare);
+	if (ret)
+		return ret;
+
+	/*
+	 * Landed in a hole or beyond EOF?  Send that to iomap, it'll skip
+	 * writing back the file range.
+	 */
+	if (write_iomap.offset > offset) {
+		write_iomap.length = write_iomap.offset - offset;
+		write_iomap.offset = offset;
+		write_iomap.type = IOMAP_HOLE;
+	}
+
+	memcpy(&wpc->iomap, &write_iomap, sizeof(struct iomap));
+	return 0;
+}
+
+static int fuse_iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int status)
+{
+	struct iomap_ioend *ioend = wpc->ioend;
+
+	ASSERT(fuse_has_iomap_pagecache(ioend->io_inode));
+
+	trace_fuse_iomap_submit_ioend(ioend->io_inode, wpc->nr_folios, status);
+
+	/* always call our ioend function, even if we cancel the bio */
+	ioend->io_bio.bi_end_io = fuse_iomap_end_bio;
+
+	if (status)
+		return status;
+	submit_bio(&ioend->io_bio);
+	return 0;
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
+static void fuse_iomap_discard_folio(struct folio *folio, loff_t pos)
+{
+	struct inode *inode = folio->mapping->host;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (fuse_is_bad(inode))
+		return;
+
+	ASSERT(fuse_has_iomap_pagecache(inode));
+
+	trace_fuse_iomap_discard_folio(inode, pos, folio_size(folio));
+
+	printk_ratelimited(KERN_ERR
+		"page discard on page %px, inode 0x%llx, pos %llu.",
+			folio, fi->orig_ino, pos);
+
+	/* XXX actually punch the new delalloc ranges? */
+}
+
+static const struct iomap_writeback_ops fuse_iomap_writeback_ops = {
+	.map_blocks		= fuse_iomap_map_blocks,
+	.submit_ioend		= fuse_iomap_submit_ioend,
+	.discard_folio		= fuse_iomap_discard_folio,
+};
+
+static int fuse_iomap_writepages(struct address_space *mapping,
+				 struct writeback_control *wbc)
+{
+	struct fuse_writepage_ctx wpc = { };
+
+	ASSERT(fuse_has_iomap_pagecache(mapping->host));
+
+	trace_fuse_iomap_writepages(mapping->host, wbc);
+
+	return iomap_writepages(mapping, wbc, &wpc.ctx,
+				&fuse_iomap_writeback_ops);
+}
+
+static int fuse_iomap_read_folio(struct file *file, struct folio *folio)
+{
+	ASSERT(fuse_has_iomap_pagecache(file_inode(file)));
+
+	trace_fuse_iomap_read_folio(folio);
+
+	return iomap_read_folio(folio, &fuse_iomap_ops);
+}
+
+static void fuse_iomap_readahead(struct readahead_control *rac)
+{
+	ASSERT(fuse_has_iomap_pagecache(file_inode(rac->file)));
+
+	trace_fuse_iomap_readahead(rac);
+
+	iomap_readahead(rac, &fuse_iomap_ops);
+}
+
+const struct address_space_operations fuse_iomap_aops = {
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
+	.direct_IO		= fuse_direct_IO,
+};
+
+void fuse_iomap_init_pagecache(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_has_iomap(inode));
+
+	/* Manage timestamps ourselves, don't make the fuse server do it */
+	inode->i_flags &= ~S_NOCMTIME;
+	inode->i_flags &= ~S_NOATIME;
+	inode->i_data.a_ops = &fuse_iomap_aops;
+
+	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
+	INIT_LIST_HEAD(&fi->ioend_list);
+	spin_lock_init(&fi->ioend_lock);
+}
+
+void fuse_iomap_destroy_pagecache(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_has_iomap(inode));
+	ASSERT(list_empty(&fi->ioend_list));
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
+	ASSERT(fuse_has_iomap_pagecache(inode));
+
+	trace_fuse_iomap_page_mkwrite(vmf);
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
+	struct inode *inode = file_inode(file);
+
+	ASSERT(fuse_has_iomap_pagecache(inode));
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
+	ASSERT(fuse_has_iomap_pagecache(inode));
+
+	trace_fuse_iomap_buffered_read(iocb, to);
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
+	trace_fuse_iomap_buffered_read_end(iocb, to, ret);
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
+	ASSERT(fuse_has_iomap_pagecache(inode));
+
+	trace_fuse_iomap_buffered_write(iocb, from);
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
+	ret = iomap_file_buffered_write(iocb, from, &fuse_iomap_ops, NULL);
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
+	trace_fuse_iomap_buffered_write_end(iocb, from, ret);
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
+				   NULL);
+}
+/*
+ * Truncate file.  Must have write permission and not be a directory.
+ *
+ * Caution: The caller of this function is responsible for calling
+ * setattr_prepare() or otherwise verifying the change is fine.
+ */
+static int
+fuse_iomap_setattr_size(
+	struct mnt_idmap	*idmap,
+	struct dentry		*dentry,
+	struct inode *inode,
+	struct iattr		*iattr)
+{
+	loff_t oldsize, newsize;
+	int			error;
+	bool			did_zeroing = false;
+
+	//xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
+	ASSERT(S_ISREG(inode->i_mode));
+	ASSERT((iattr->ia_valid & (ATTR_UID|ATTR_GID|ATTR_ATIME|ATTR_ATIME_SET|
+		ATTR_MTIME_SET|ATTR_TIMES_SET)) == 0);
+
+	oldsize = inode->i_size;
+	newsize = iattr->ia_size;
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
+	if (newsize > oldsize) {
+		trace_fuse_iomap_truncate_up(inode, oldsize, newsize - oldsize);
+
+		error = fuse_iomap_zero_range(inode, oldsize, newsize - oldsize,
+					      &did_zeroing);
+	} else {
+		trace_fuse_iomap_truncate_down(inode, newsize,
+					       oldsize - newsize);
+
+		error = fuse_iomap_truncate_page(inode, newsize, &did_zeroing);
+	}
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
+	 * We are going to tell userspace to log the inode size change so any
+	 * previous writes that are beyond the on disk EOF and the new EOF that
+	 * have not been written out need to be written here.  If we do not
+	 * write the data out, we expose ourselves to the null files problem.
+	 * Note that this includes any block zeroing we did above; otherwise
+	 * those blocks may not be zeroed after a crash.  It's really clumsy
+	 * to flush the entire file, but we don't know the ondisk inode size
+	 * so we use a big hammer instead.
+	 */
+	if (did_zeroing || newsize > 0) {
+		error = filemap_write_and_wait(inode->i_mapping);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
+int
+fuse_iomap_setsize(
+	struct mnt_idmap	*idmap,
+	struct dentry		*dentry,
+	struct iattr		*iattr)
+{
+	struct inode *inode = d_inode(dentry);
+	int error;
+
+	ASSERT(fuse_has_iomap(inode));
+	ASSERT(fuse_has_iomap_pagecache(inode));
+
+	trace_fuse_iomap_setsize(inode, iattr->ia_size, 0);
+
+	error = inode_newsize_ok(inode, iattr->ia_size);
+	if (error)
+		return error;
+	return fuse_iomap_setattr_size(idmap, dentry, inode, iattr);
+}
+
+static int fuse_iomap_punch_range(struct inode *inode, loff_t offset,
+				  loff_t length)
+{
+	loff_t isize = i_size_read(inode);
+	int error;
+
+	trace_fuse_iomap_punch_range(inode, offset, length);
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
+	ASSERT(fuse_has_iomap(inode));
+	ASSERT(fuse_has_iomap_pagecache(inode));
+
+	trace_fuse_iomap_fallocate(inode, mode, offset, length, new_size);
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
+	 * new EOF.
+	 */
+	if (new_size) {
+		struct iattr iattr = {
+			.ia_valid	= ATTR_SIZE,
+			.ia_size	= new_size,
+		};
+
+		return fuse_iomap_setsize(file_mnt_idmap(file),
+					  file_dentry(file), &iattr);
+	}
+
+	return 0;
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0b3ad7bf89b52d..2f185b7d9349b7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -193,6 +193,9 @@ static void fuse_evict_inode(struct inode *inode)
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
+
+	if (S_ISREG(inode->i_mode) && fuse_has_iomap_pagecache(inode))
+		fuse_iomap_destroy_pagecache(inode);
 }
 
 static int fuse_reconfigure(struct fs_context *fsc)
@@ -1445,6 +1448,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->iomap = 1;
 			if ((flags & FUSE_IOMAP_DIRECTIO) && fc->iomap)
 				fc->iomap_directio = 1;
+			if ((flags & FUSE_IOMAP_PAGECACHE) && fc->iomap)
+				fc->iomap_pagecache = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1517,7 +1522,7 @@ void fuse_send_init(struct fuse_mount *fm)
 	if (fuse_uring_enabled())
 		flags |= FUSE_OVER_IO_URING;
 	if (fuse_iomap_enabled())
-		flags |= FUSE_IOMAP | FUSE_IOMAP_DIRECTIO;
+		flags |= FUSE_IOMAP | FUSE_IOMAP_DIRECTIO | FUSE_IOMAP_PAGECACHE;
 
 	ia->in.flags = flags;
 	ia->in.flags2 = flags >> 32;


