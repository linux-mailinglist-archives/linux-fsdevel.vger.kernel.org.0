Return-Path: <linux-fsdevel+bounces-55325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30890B09803
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D674D1896F0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9EA255F53;
	Thu, 17 Jul 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCAKIxAt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66124DCF9
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794968; cv=none; b=b2JX5jdZ93KCZDyKciElnOoA0K/wD/Ex31prldXqN75IWYpRv9TPl9EtjAKVmhEy7iSf6Z0jK6ib1pIGkaqlNv0k6dFmSaLxXdQ1GRMm+G2clLaqqFdb16aKfO0o119a74xQzIAZA5C3w5oP1pFz/90i0hXHP79EJ27a4bhH/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794968; c=relaxed/simple;
	bh=ZwHmZ+8/BaWEaPYW30LChQ/JJXoDLax1CSlenMRf138=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xj10xR6oSAASeTm657ufCG4sCUvhoHbhGXTV35Vv6IGBOoNlMTLCGrJ7IYT7Cw4Fbx7MTGzSL819jjRCwkx0G1/TWWoBpNHHDJl+H6JOLUoSKh5vIZw5D0nbXbcpKHSnBc0tlduh8OlzgawKL1jX3UvWLMVUVcLR+oSYNCmo09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCAKIxAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44589C4CEE3;
	Thu, 17 Jul 2025 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794968;
	bh=ZwHmZ+8/BaWEaPYW30LChQ/JJXoDLax1CSlenMRf138=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HCAKIxAt/lWTsHvoPT8jEbhV6IwQa9YyJr6Yt6o8qOu1W1pHPrdYJ7gBT0Xfr4R9Z
	 xUD21hhqCHsEoGfgs2cdnD7wI/Uez7TDy70BQEHlfAUqidCNIV4E56CMM5P8GsSEh6
	 FjZKnWZCzucK5o1SgrNV1hNYeCUmV/vAQJPL03HDSnndDLev3iv1WdNNiRGxX9GzGi
	 WXDsIRhVP2SF7PtlGC5SL/tt+dsGm6p6YfrecMmExQQgSuDJmBiFBqytufBZppciED
	 EeZBOvoJPQcsIa9/ngNKeLJLtEohpixZhLygt02rbEFmyEDwg2pdtCrYRa1LWjuXl+
	 wcgUiBHhgZQ8Q==
Date: Thu, 17 Jul 2025 16:29:27 -0700
Subject: [PATCH 05/13] fuse: implement direct IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450044.711291.15459718192078080682.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement direct IO with iomap if it's available.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   33 +++++
 fs/fuse/fuse_trace.h      |  257 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   29 ++++
 fs/fuse/dir.c             |    7 +
 fs/fuse/file.c            |   17 +++
 fs/fuse/file_iomap.c      |  292 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    6 +
 7 files changed, 640 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4df51454858146..67e428da4391aa 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -226,6 +226,8 @@ enum {
 	FUSE_I_BTIME,
 	/* Wants or already has page cache IO */
 	FUSE_I_CACHE_IO_MODE,
+	/* Use iomap for directio reads and writes */
+	FUSE_I_IOMAP_DIRECTIO,
 };
 
 struct fuse_conn;
@@ -911,6 +913,9 @@ struct fuse_conn {
 	/* Use fs/iomap for FIEMAP and SEEK_{DATA,HOLE} file operations */
 	unsigned int iomap:1;
 
+	/* Use fs/iomap for direct I/O operations */
+	unsigned int iomap_directio:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
@@ -1648,6 +1653,27 @@ int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 length);
 loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
 sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
+
+void fuse_iomap_open(struct inode *inode, struct file *file);
+
+void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags);
+void fuse_iomap_evict_inode(struct inode *inode);
+
+static inline bool fuse_has_iomap_directio(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode_c(inode);
+
+	return test_bit(FUSE_I_IOMAP_DIRECTIO, &fi->state);
+}
+
+static inline bool fuse_want_iomap_directio(const struct kiocb *iocb)
+{
+	return (iocb->ki_flags & IOCB_DIRECT) &&
+		fuse_has_iomap_directio(file_inode(iocb->ki_filp));
+}
+
+ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1659,6 +1685,13 @@ sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 # define fuse_iomap_fiemap			NULL
 # define fuse_iomap_lseek(...)			(-ENOSYS)
 # define fuse_iomap_bmap(...)			(-ENOSYS)
+# define fuse_iomap_open(...)			((void)0)
+# define fuse_iomap_init_inode(...)		((void)0)
+# define fuse_iomap_evict_inode(...)		((void)0)
+# define fuse_has_iomap_directio(...)		(false)
+# define fuse_want_iomap_directio(...)		(false)
+# define fuse_iomap_direct_read(...)		(-ENOSYS)
+# define fuse_iomap_direct_write(...)		(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 9c02ca07571e1c..b888ae40e1116e 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -60,6 +60,7 @@
 	EM( FUSE_STATX,			"FUSE_STATX")		\
 	EM( FUSE_IOMAP_BEGIN,		"FUSE_IOMAP_BEGIN")	\
 	EM( FUSE_IOMAP_END,		"FUSE_IOMAP_END")	\
+	EM( FUSE_IOMAP_IOEND,		"FUSE_IOMAP_IOEND")	\
 	EMe(CUSE_INIT,			"CUSE_INIT")
 
 /*
@@ -161,6 +162,34 @@ TRACE_EVENT(fuse_request_end,
 	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
 
+#define FUSE_IOMAP_IOEND_STRINGS \
+	{ FUSE_IOMAP_IOEND_SHARED,		"shared" }, \
+	{ FUSE_IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
+	{ FUSE_IOMAP_IOEND_BOUNDARY,		"boundary" }, \
+	{ FUSE_IOMAP_IOEND_DIRECT,		"direct" }, \
+	{ FUSE_IOMAP_IOEND_APPEND,		"append" }
+
+#define IOMAP_DIOEND_STRINGS \
+	{ IOMAP_DIO_UNWRITTEN,			"unwritten" }, \
+	{ IOMAP_DIO_COW,			"cow" }
+
+TRACE_DEFINE_ENUM(FUSE_I_ADVISE_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_INIT_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_SIZE_UNSTABLE);
+TRACE_DEFINE_ENUM(FUSE_I_BAD);
+TRACE_DEFINE_ENUM(FUSE_I_BTIME);
+TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
+TRACE_DEFINE_ENUM(FUSE_I_IOMAP_DIRECTIO);
+
+#define FUSE_IFLAG_STRINGS \
+	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
+	{ 1 << FUSE_I_INIT_RDPLUS,		"init_rdplus" }, \
+	{ 1 << FUSE_I_SIZE_UNSTABLE,		"size_unstable" }, \
+	{ 1 << FUSE_I_BAD,			"bad" }, \
+	{ 1 << FUSE_I_BTIME,			"btime" }, \
+	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
+	{ 1 << FUSE_I_IOMAP_DIRECTIO,		"iomap_dio" }
+
 TRACE_EVENT(fuse_iomap_begin,
 	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
 		 unsigned opflags),
@@ -411,6 +440,89 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->error)
 );
 
+TRACE_EVENT(fuse_iomap_ioend,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_ioend_in *inarg),
+
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(unsigned,	ioendflags)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(loff_t,		pos)
+		__field(int,		error)
+		__field(uint64_t,	new_addr)
+		__field(size_t,		written)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->ioendflags	=	inarg->ioendflags;
+		__entry->error		=	inarg->error;
+		__entry->pos		=	inarg->pos;
+		__entry->new_addr	=	inarg->new_addr;
+		__entry->written	=	inarg->written;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx ioendflags (%s) pos 0x%llx written %zd error %d new_addr 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
+		  __entry->pos, __entry->written, __entry->error,
+		  __entry->new_addr)
+);
+
+TRACE_EVENT(fuse_iomap_ioend_error,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_ioend_in *inarg,
+		 int error),
+
+	TP_ARGS(inode, inarg, error),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(unsigned,	ioendflags)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(loff_t,		pos)
+		__field(int,		error)
+		__field(uint64_t,	new_addr)
+		__field(size_t,		written)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->ioendflags	=	inarg->ioendflags;
+		__entry->error		=	error;
+		__entry->pos		=	inarg->pos;
+		__entry->new_addr	=	inarg->new_addr;
+		__entry->written	=	inarg->written;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx ioendflags (%s) pos 0x%llx written %zd error %d new_addr 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
+		  __entry->pos, __entry->written, __entry->error,
+		  __entry->new_addr)
+);
+
 TRACE_EVENT(fuse_iomap_dev_add,
 	TP_PROTO(const struct fuse_conn *fc,
 		 const struct fuse_backing_map *map),
@@ -538,6 +650,151 @@ TRACE_EVENT(fuse_iomap_lseek,
 		  __entry->connection, __entry->ino, __entry->nodeid,
 		  __entry->isize, __entry->offset, __entry->whence)
 );
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_io_class,
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter),
+	TP_ARGS(iocb, iter),
+	TP_STRUCT__entry(
+		__field(dev_t, connection)
+		__field(uint64_t, ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t, isize)
+		__field(loff_t, offset)
+		__field(size_t, count)
+	),
+	TP_fast_assign(
+		const struct inode *inode = file_inode(iocb->ki_filp);
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->offset		=	iocb->ki_pos;
+		__entry->count		=	iov_iter_count(iter);
+	),
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx pos 0x%llx bytecount 0x%zx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->offset, __entry->count)
+)
+#define DEFINE_FUSE_IOMAP_FILE_IO_EVENT(name)		\
+DEFINE_EVENT(fuse_iomap_file_io_class, name,		\
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter), \
+	TP_ARGS(iocb, iter))
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_read);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_write);
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_ioend_class,
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter,
+		 ssize_t ret),
+	TP_ARGS(iocb, iter, ret),
+	TP_STRUCT__entry(
+		__field(dev_t, connection)
+		__field(uint64_t, ino)
+		__field(uint64_t, nodeid)
+		__field(loff_t, isize)
+		__field(loff_t, offset)
+		__field(size_t, count)
+		__field(ssize_t, ret)
+	),
+	TP_fast_assign(
+		const struct inode *inode = file_inode(iocb->ki_filp);
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->offset		=	iocb->ki_pos;
+		__entry->count		=	iov_iter_count(iter);
+		__entry->ret		=	ret;
+	),
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx pos 0x%llx bytecount 0x%zx ret 0x%zx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->offset, __entry->count, __entry->ret)
+)
+#define DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_file_ioend_class, name,		\
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter, \
+		 ssize_t ret), \
+	TP_ARGS(iocb, iter, ret))
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_read_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_write_end);
+
+TRACE_EVENT(fuse_iomap_dio_write_end_io,
+	TP_PROTO(const struct inode *inode, loff_t pos, ssize_t written,
+		 int error, unsigned flags),
+
+	TP_ARGS(inode, pos, written, error, flags),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(unsigned,	dioendflags)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(loff_t,		pos)
+		__field(size_t,		written)
+		__field(int,		error)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->dioendflags	=	flags;
+		__entry->error		=	error;
+		__entry->pos		=	pos;
+		__entry->written	=	written;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx dioendflags (%s) pos 0x%llx written %zd error %d",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __print_flags(__entry->dioendflags, "|", IOMAP_DIOEND_STRINGS),
+		  __entry->pos, __entry->written, __entry->error)
+);
+
+DECLARE_EVENT_CLASS(fuse_inode_state_class,
+	TP_PROTO(const struct inode *inode),
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(unsigned long,	state)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->state		=	fi->state;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx state (%s)",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __print_flags(__entry->state, "|", FUSE_IFLAG_STRINGS))
+);
+#define DEFINE_FUSE_INODE_STATE_EVENT(name)	\
+DEFINE_EVENT(fuse_inode_state_class, name,	\
+	TP_PROTO(const struct inode *inode),	\
+	TP_ARGS(inode))
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2fe83fc196b021..17ea82e23d7ef7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -240,6 +240,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
  *    SEEK_{DATA,HOLE} support
  *  - add FUSE_DEV_IOC_IOMAP_DEV_ADD to configure block devices for iomap
+ *  - add FUSE_IOMAP_DIRECTIO/FUSE_ATTR_IOMAP_DIRECTIO for direct I/O support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -450,6 +451,7 @@ struct fuse_file_lock {
  *			 init_out.request_timeout contains the timeout (in secs)
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
  *	       operations.
+ * FUSE_IOMAP_DIRECTIO: Client supports iomap for direct I/O operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -498,6 +500,7 @@ struct fuse_file_lock {
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
 #define FUSE_IOMAP		(1ULL << 43)
+#define FUSE_IOMAP_DIRECTIO	(1ULL << 44)
 
 /**
  * CUSE INIT request/reply flags
@@ -581,9 +584,11 @@ struct fuse_file_lock {
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ * FUSE_ATTR_IOMAP_DIRECTIO: Use iomap for directio
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
+#define FUSE_ATTR_IOMAP_DIRECTIO	(1 << 2)
 
 /**
  * Open flags
@@ -666,6 +671,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1377,4 +1383,27 @@ struct fuse_iomap_end_in {
 	uint32_t map_dev;	/* device cookie * */
 };
 
+/* out of place write extent */
+#define FUSE_IOMAP_IOEND_SHARED		(1U << 0)
+/* unwritten extent */
+#define FUSE_IOMAP_IOEND_UNWRITTEN	(1U << 1)
+/* don't merge into previous ioend */
+#define FUSE_IOMAP_IOEND_BOUNDARY	(1U << 2)
+/* is direct I/O */
+#define FUSE_IOMAP_IOEND_DIRECT		(1U << 3)
+
+/* is append ioend */
+#define FUSE_IOMAP_IOEND_APPEND		(1U << 15)
+
+struct fuse_iomap_ioend_in {
+	uint16_t ioendflags;	/* FUSE_IOMAP_IOEND_* */
+	uint16_t reserved;	/* zero */
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
index 5efd763d188559..e991bc1943e6f6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -713,6 +713,10 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	entry->d_time = epoch;
 	fuse_change_entry_timeout(entry, &outentry);
 	fuse_dir_changed(dir);
+
+	if (fuse_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (!err) {
 		file->private_data = ff;
@@ -1708,6 +1712,9 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d143990d9ed931..06223e56955ca3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -244,6 +244,9 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
@@ -1712,10 +1715,17 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
 
@@ -1737,6 +1747,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
 
@@ -3191,4 +3207,5 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, flags);
+	fuse_iomap_init_inode(inode, flags);
 }
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index fb33185852ff0b..3f96cab5de1fb4 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -470,6 +470,70 @@ const struct iomap_ops fuse_iomap_ops = {
 	.iomap_end		= fuse_iomap_end,
 };
 
+static inline bool fuse_want_ioend(const struct fuse_iomap_ioend_in *inarg)
+{
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
+static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
+			    int error, unsigned ioendflags, sector_t new_addr)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_iomap_ioend_in inarg = {
+		.ioendflags = ioendflags,
+		.error = error,
+		.attr_ino = fi->orig_ino,
+		.pos = pos,
+		.written = written,
+		.new_addr = new_addr,
+	};
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	int err = 0;
+
+	if (pos + written > i_size_read(inode))
+		inarg.ioendflags |= FUSE_IOMAP_IOEND_APPEND;
+
+	trace_fuse_iomap_ioend(inode, &inarg);
+
+	if (!fuse_want_ioend(&inarg))
+		goto out;
+
+	args.opcode = FUSE_IOMAP_IOEND;
+	args.nodeid = get_node_id(inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	err = fuse_simple_request(fm, &args);
+
+	trace_fuse_iomap_ioend_error(inode, &inarg, err);
+
+	/*
+	 * Preserve the original error code if userspace didn't respond or
+	 * returned success despite the error we passed along via the ioend.
+	 */
+	if (error && (err == 0 || err == -ENOSYS))
+		err = error;
+
+out:
+	/*
+	 * If there weren't any ioend errors, update the incore isize, which
+	 * confusingly takes the new i_size as "pos".
+	 */
+	if (!error && !err)
+		fuse_write_update_attr(inode, pos + written, written);
+
+	return err;
+}
+
 int fuse_iomap_conn_alloc(struct fuse_conn *fc)
 {
 	idr_init(&fc->iomap_conn.device_map);
@@ -678,3 +742,231 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
 		return offset;
 	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
 }
+
+void fuse_iomap_open(struct inode *inode, struct file *file)
+{
+	if (fuse_has_iomap_directio(inode))
+		file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
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
+static inline void fuse_iomap_set_directio(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(get_fuse_conn_c(inode)->iomap_directio);
+
+	set_bit(FUSE_I_IOMAP_DIRECTIO, &fi->state);
+}
+
+static inline void fuse_iomap_clear_directio(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(get_fuse_conn_c(inode)->iomap_directio);
+
+	clear_bit(FUSE_I_IOMAP_DIRECTIO, &fi->state);
+}
+
+void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags)
+{
+	struct fuse_conn *conn = get_fuse_conn(inode);
+
+	if (conn->iomap_directio && (attr_flags & FUSE_ATTR_IOMAP_DIRECTIO))
+		fuse_iomap_set_directio(inode);
+
+	trace_fuse_iomap_init_inode(inode);
+}
+
+void fuse_iomap_evict_inode(struct inode *inode)
+{
+	trace_fuse_iomap_evict_inode(inode);
+
+	if (fuse_has_iomap_directio(inode))
+		fuse_iomap_clear_directio(inode);
+}
+
+ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	ASSERT(fuse_has_iomap_directio(inode));
+
+	trace_fuse_iomap_direct_read(iocb, to);
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
+	trace_fuse_iomap_direct_read_end(iocb, to, ret);
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
+	ASSERT(fuse_has_iomap_directio(inode));
+
+	trace_fuse_iomap_dio_write_end_io(inode, iocb->ki_pos, written, error,
+					  dioflags);
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
+static int fuse_iomap_direct_write_sync(struct kiocb *iocb, loff_t start,
+					size_t count)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	loff_t end = start + count - 1;
+	int err;
+
+	/* Flush the file metadata, not the page cache. */
+	err = sync_inode_metadata(inode, 1);
+	if (err)
+		return err;
+
+	if (fc->no_fsync)
+		return 0;
+
+	err = fuse_fsync_common(iocb->ki_filp, start, end, iocb_is_dsync(iocb),
+				FUSE_FSYNC);
+	if (err == -ENOSYS) {
+		fc->no_fsync = 1;
+		err = 0;
+	}
+	return err;
+}
+
+ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	loff_t blockmask = i_blocksize(inode) - 1;
+	loff_t pos = iocb->ki_pos;
+	size_t count = iov_iter_count(from);
+	bool was_dsync = false;
+	ssize_t ret;
+
+	ASSERT(fuse_has_iomap_directio(inode));
+
+	trace_fuse_iomap_direct_write(iocb, from);
+
+	/*
+	 * direct I/O must be aligned to the fsblock size or we fall back to
+	 * the old paths
+	 */
+	if ((iocb->ki_pos | count) & blockmask)
+		return -ENOTBLK;
+
+	/* fuse doesn't support S_SYNC, so complain if we see this. */
+	if (IS_SYNC(inode)) {
+		ASSERT(!IS_SYNC(inode));
+		return -EIO;
+	}
+
+	/*
+	 * Strip off IOCB_DSYNC so that we can run the fsync ourselves because
+	 * we hold inode_lock; iomap_dio_rw calls generic_write_sync; and
+	 * fuse_fsync tries to take inode_lock again.
+	 */
+	if (iocb_is_dsync(iocb)) {
+		was_dsync = true;
+		iocb->ki_flags &= ~IOCB_DSYNC;
+	}
+
+	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
+	if (ret)
+		goto out_dsync;
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out_unlock;
+
+	ret = iomap_dio_rw(iocb, from, &fuse_iomap_ops,
+			&fuse_iomap_dio_write_ops, 0, NULL, 0);
+	if (ret)
+		goto out_unlock;
+
+	if (was_dsync) {
+		/* Restore IOCB_DSYNC and call our sync function */
+		iocb->ki_flags |= IOCB_DSYNC;
+		ret = fuse_iomap_direct_write_sync(iocb, pos, count);
+	}
+
+out_unlock:
+	inode_unlock(inode);
+out_dsync:
+	trace_fuse_iomap_direct_write_end(iocb, from, ret);
+	if (was_dsync)
+		iocb->ki_flags |= IOCB_DSYNC;
+	return ret;
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8b12284bced7e6..1a17983753c367 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -197,6 +197,8 @@ static void fuse_evict_inode(struct inode *inode)
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
+
+	fuse_iomap_evict_inode(inode);
 }
 
 static int fuse_reconfigure(struct fs_context *fsc)
@@ -1447,6 +1449,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 			if ((flags & FUSE_IOMAP) && fuse_iomap_enabled())
 				fc->iomap = 1;
+			if ((flags & FUSE_IOMAP_DIRECTIO) && fc->iomap)
+				fc->iomap_directio = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1519,7 +1523,7 @@ void fuse_send_init(struct fuse_mount *fm)
 	if (fuse_uring_enabled())
 		flags |= FUSE_OVER_IO_URING;
 	if (fuse_iomap_enabled())
-		flags |= FUSE_IOMAP;
+		flags |= FUSE_IOMAP | FUSE_IOMAP_DIRECTIO;
 
 	ia->in.flags = flags;
 	ia->in.flags2 = flags >> 32;


