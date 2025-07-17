Return-Path: <linux-fsdevel+bounces-55326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A7BB097F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6151710BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29131F0E32;
	Thu, 17 Jul 2025 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/dmaHSW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F52AEF5
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794984; cv=none; b=PXU0FGNpgnSIxP8kqfE3O+ctIqPThpdKPEfSCMxWdDfp1fG2qF9njcdELogtng6NqcjhczpcXatnaj53qZThMqgYILSf2nVamPJJggrja3PL5oXWiyxVPhAjOWlNS/J2BgPkMKBsZ4FRfXiIUVjiQoyjIc2ycSFLeXdzws/BITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794984; c=relaxed/simple;
	bh=lscDcm8zSa9gAFB+8WVS1RM6vcSoL20rRmyukEJsB6w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f19uuxBUi0HrWdkoHsOIMt+0pFgrj4bYjrtl0nkIW2Q5jY98ySQzUM0Bvb7FfEodxZ6k9gmZ4iCY2GZcsE+RJo4+2J2b0kF3fsd13TU/eXlV6k9hjTzSCx5S7JXyBZpvKsqa2tXRxmljPs17tuMkZ5zQkYUwh3sNOM7SszDc6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/dmaHSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2DFC4CEE3;
	Thu, 17 Jul 2025 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794983;
	bh=lscDcm8zSa9gAFB+8WVS1RM6vcSoL20rRmyukEJsB6w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=V/dmaHSWRzvBe8TCkWkaW2VolUm/z26dDE11UbjlHUMV+CEDhMKSoCnYOLIm8aMBD
	 DTr02OV2HF/6wGPQ6+qej2m/IXNdxYYDuLaTnL2XxCSVbSBdglt+Goyu3nO/SxyjrQ
	 RrowzI7oE1KxXjZj1ktwyJh06Zh/n1TH0DwR6khsO1jHUTlFY9DnegdyzzopStcZJl
	 oP+xWEijnTyIDKUMXsAqY552gJ4b5n5Kr3UQY3hUvMYRLegw82Qr1Y+3B/CqwWnQlx
	 x0TXFEk11kBjDjJbDQdhBaIOq+f/9rv+LgEYBw5mNTCPVKbMzlVmrjvg+yuodBcwAI
	 Ovr0Pnr2PHBnw==
Date: Thu, 17 Jul 2025 16:29:43 -0700
Subject: [PATCH 06/13] fuse: implement buffered IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450066.711291.11325657475144563199.stgit@frogsfrogsfrogs>
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

Implement pagecache IO with iomap, complete with hooks into truncate and
fallocate so that the fuse server needn't implement disk block zeroing
of post-EOF and unaligned punch/zero regions.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   46 +++
 fs/fuse/fuse_trace.h      |  391 ++++++++++++++++++++++++
 include/uapi/linux/fuse.h |    5 
 fs/fuse/dir.c             |   23 +
 fs/fuse/file.c            |   90 +++++-
 fs/fuse/file_iomap.c      |  723 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   14 +
 7 files changed, 1268 insertions(+), 24 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 67e428da4391aa..f33b348d296d5e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -161,6 +161,13 @@ struct fuse_inode {
 
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
@@ -228,6 +235,8 @@ enum {
 	FUSE_I_CACHE_IO_MODE,
 	/* Use iomap for directio reads and writes */
 	FUSE_I_IOMAP_DIRECTIO,
+	/* Use iomap for buffered read and writes */
+	FUSE_I_IOMAP_FILEIO,
 };
 
 struct fuse_conn;
@@ -916,6 +925,9 @@ struct fuse_conn {
 	/* Use fs/iomap for direct I/O operations */
 	unsigned int iomap_directio:1;
 
+	/* Use fs/iomap for buffered I/O operations */
+	unsigned int iomap_fileio:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
@@ -1631,6 +1643,9 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+sector_t fuse_bmap(struct address_space *mapping, sector_t block);
+ssize_t fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
+
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 # include <linux/fiemap.h>
 # include <linux/iomap.h>
@@ -1674,6 +1689,28 @@ static inline bool fuse_want_iomap_directio(const struct kiocb *iocb)
 
 ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from);
+
+static inline bool fuse_has_iomap_fileio(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode_c(inode);
+
+	return test_bit(FUSE_I_IOMAP_FILEIO, &fi->state);
+}
+
+static inline bool fuse_want_iomap_buffered_io(const struct kiocb *iocb)
+{
+	return fuse_has_iomap_fileio(file_inode(iocb->ki_filp));
+}
+
+int fuse_iomap_mmap(struct file *file, struct vm_area_struct *vma);
+ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from);
+int fuse_iomap_setsize(struct inode *inode, loff_t newsize);
+void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits);
+int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
+			 loff_t length, loff_t new_size);
+int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
+				 loff_t endpos);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1692,6 +1729,15 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from);
 # define fuse_want_iomap_directio(...)		(false)
 # define fuse_iomap_direct_read(...)		(-ENOSYS)
 # define fuse_iomap_direct_write(...)		(-ENOSYS)
+# define fuse_has_iomap_fileio(...)		(false)
+# define fuse_want_iomap_buffered_io(...)	(false)
+# define fuse_iomap_mmap(...)			(-ENOSYS)
+# define fuse_iomap_buffered_read(...)		(-ENOSYS)
+# define fuse_iomap_buffered_write(...)		(-ENOSYS)
+# define fuse_iomap_setsize(...)		(-ENOSYS)
+# define fuse_iomap_set_i_blkbits(...)		((void)0)
+# define fuse_iomap_fallocate(...)		(-ENOSYS)
+# define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index b888ae40e1116e..5d9b5a4e93fca5 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -180,6 +180,7 @@ TRACE_DEFINE_ENUM(FUSE_I_BAD);
 TRACE_DEFINE_ENUM(FUSE_I_BTIME);
 TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
 TRACE_DEFINE_ENUM(FUSE_I_IOMAP_DIRECTIO);
+TRACE_DEFINE_ENUM(FUSE_I_IOMAP_FILEIO);
 
 #define FUSE_IFLAG_STRINGS \
 	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
@@ -188,7 +189,14 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP_DIRECTIO);
 	{ 1 << FUSE_I_BAD,			"bad" }, \
 	{ 1 << FUSE_I_BTIME,			"btime" }, \
 	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
-	{ 1 << FUSE_I_IOMAP_DIRECTIO,		"iomap_dio" }
+	{ 1 << FUSE_I_IOMAP_DIRECTIO,		"iomap_dio" }, \
+	{ 1 << FUSE_I_IOMAP_FILEIO,		"iomap_fileio" }
+
+#define IOMAP_IOEND_STRINGS \
+	{ IOMAP_IOEND_SHARED,			"shared" }, \
+	{ IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
+	{ IOMAP_IOEND_BOUNDARY,			"boundary" }, \
+	{ IOMAP_IOEND_DIRECT,			"direct" }
 
 TRACE_EVENT(fuse_iomap_begin,
 	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
@@ -684,6 +692,9 @@ DEFINE_EVENT(fuse_iomap_file_io_class, name,		\
 	TP_ARGS(iocb, iter))
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_read);
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_read);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_write_zero_eof);
 
 DECLARE_EVENT_CLASS(fuse_iomap_file_ioend_class,
 	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter,
@@ -722,6 +733,8 @@ DEFINE_EVENT(fuse_iomap_file_ioend_class, name,		\
 	TP_ARGS(iocb, iter, ret))
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_read_end);
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_write_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_read_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_write_end);
 
 TRACE_EVENT(fuse_iomap_dio_write_end_io,
 	TP_PROTO(const struct inode *inode, loff_t pos, ssize_t written,
@@ -795,6 +808,382 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
 	TP_ARGS(inode))
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
+
+TRACE_EVENT(fuse_iomap_end_ioend,
+	TP_PROTO(const struct iomap_ioend *ioend),
+
+	TP_ARGS(ioend),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
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
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->offset		=	ioend->io_offset;
+		__entry->size		=	ioend->io_size;
+		__entry->ioendflags	=	ioend->io_flags;
+		__entry->error		=
+				blk_status_to_errno(ioend->io_bio.bi_status);
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx offset 0x%llx size %zu ioendflags (%s) error %d",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->offset, __entry->size,
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
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
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
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->offset		=	offset;
+		__entry->count		=	count;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx offset 0x%llx count 0x%x",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->offset, __entry->count)
+);
+
+TRACE_EVENT(fuse_iomap_submit_ioend,
+	TP_PROTO(const struct iomap_writepage_ctx *wpc, int error),
+
+	TP_ARGS(wpc, error),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(loff_t,		pos)
+		__field(size_t,		len)
+		__field(unsigned int,	nr_folios)
+		__field(u64,		addr)
+		__field(int,		error)
+	),
+
+	TP_fast_assign(
+		const struct inode *inode = wpc->ioend->io_inode;
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->nr_folios	=	wpc->nr_folios;
+		__entry->pos		=	wpc->ioend->io_offset;
+		__entry->len		=	wpc->ioend->io_size;
+		__entry->addr		=	wpc->ioend->io_sector << 9;
+		__entry->error		=	error;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx pos 0x%llx len 0x%zx addr 0x%llx nr_folios %u error %d",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->pos, __entry->len, __entry->addr,
+		  __entry->nr_folios, __entry->error)
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
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
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
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->offset		=	offset;
+		__entry->count		=	count;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx offset 0x%llx count 0x%zx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->offset, __entry->count)
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
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
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
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->start		=	wbc->range_start;
+		__entry->end		=	wbc->range_end;
+		__entry->nr_to_write	=	wbc->nr_to_write;
+		__entry->sync_all	=	wbc->sync_mode == WB_SYNC_ALL;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx start 0x%llx end 0x%llx nr %ld sync_all? %d",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->start, __entry->end,
+		  __entry->nr_to_write, __entry->sync_all)
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
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
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
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->pos		=	folio_pos(folio);
+		__entry->count		=	folio_size(folio);
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx offset 0x%llx count 0x%zx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->pos, __entry->count)
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
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
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
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->pos		=	readahead_pos(mutrac);
+		__entry->count		=	readahead_length(mutrac);
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx offset 0x%llx count 0x%zx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->pos, __entry->count)
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
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
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
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->pos		=	folio_pos(folio);
+		__entry->count		=	folio_size(folio);
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx offset 0x%llx count 0x%zx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->pos, __entry->count)
+);
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_range_class,
+	TP_PROTO(const struct inode *inode, loff_t offset, loff_t length),
+	TP_ARGS(inode, offset, length),
+	TP_STRUCT__entry(
+		__field(dev_t, connection)
+		__field(uint64_t, ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(loff_t, offset)
+		__field(loff_t, length)
+	),
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+	),
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx pos 0x%llx bytecount 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->offset, __entry->length)
+)
+#define DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(name)		\
+DEFINE_EVENT(fuse_iomap_file_range_class, name,		\
+	TP_PROTO(const struct inode *inode, loff_t offset, loff_t length), \
+	TP_ARGS(inode, offset, length))
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_up);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_setsize);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_flush_unmap_range);
+
+TRACE_EVENT(fuse_iomap_set_i_blkbits,
+	TP_PROTO(const struct inode *inode, u8 new_blkbits),
+	TP_ARGS(inode, new_blkbits),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(u8,		old_blkbits)
+		__field(u8,		new_blkbits)
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
+		__entry->old_blkbits	=	inode->i_blkbits;
+		__entry->new_blkbits	=	new_blkbits;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx old_blkbits %u new_blkbits %u",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->old_blkbits, __entry->new_blkbits)
+);
+
+TRACE_EVENT(fuse_iomap_fallocate,
+	TP_PROTO(const struct inode *inode, int mode, loff_t offset,
+		 loff_t length, loff_t newsize),
+	TP_ARGS(inode, mode, offset, length, newsize),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
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
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->mode		=	mode;
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+		__entry->newsize	=	newsize;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx mode 0x%x offset 0x%llx length 0x%llx newsize 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->mode, __entry->offset,
+		  __entry->length, __entry->newsize)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 17ea82e23d7ef7..71129db79a1dd0 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -241,6 +241,7 @@
  *    SEEK_{DATA,HOLE} support
  *  - add FUSE_DEV_IOC_IOMAP_DEV_ADD to configure block devices for iomap
  *  - add FUSE_IOMAP_DIRECTIO/FUSE_ATTR_IOMAP_DIRECTIO for direct I/O support
+ *  - add FUSE_IOMAP_FILEIO/FUSE_ATTR_IOMAP_FILEIO for buffered I/O support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -452,6 +453,7 @@ struct fuse_file_lock {
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
  *	       operations.
  * FUSE_IOMAP_DIRECTIO: Client supports iomap for direct I/O operations.
+ * FUSE_IOMAP_FILEIO: Client supports iomap for buffered I/O operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -501,6 +503,7 @@ struct fuse_file_lock {
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
 #define FUSE_IOMAP		(1ULL << 43)
 #define FUSE_IOMAP_DIRECTIO	(1ULL << 44)
+#define FUSE_IOMAP_FILEIO	(1ULL << 45)
 
 /**
  * CUSE INIT request/reply flags
@@ -585,10 +588,12 @@ struct fuse_file_lock {
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_IOMAP_DIRECTIO: Use iomap for directio
+ * FUSE_ATTR_IOMAP_FILEIO: Use iomap for buffered io
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_IOMAP_DIRECTIO	(1 << 2)
+#define FUSE_ATTR_IOMAP_FILEIO	(1 << 3)
 
 /**
  * Open flags
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e991bc1943e6f6..7a398e42e9818b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1984,7 +1984,10 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		is_truncate = true;
 	}
 
-	if (FUSE_IS_DAX(inode) && is_truncate) {
+	if (fuse_has_iomap_fileio(inode) && is_truncate) {
+		filemap_invalidate_lock(mapping);
+		fault_blocked = true;
+	} else if (FUSE_IS_DAX(inode) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, -1);
@@ -1999,6 +2002,18 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		WARN_ON(!(attr->ia_valid & ATTR_SIZE));
 		WARN_ON(attr->ia_size != 0);
 		if (fc->atomic_o_trunc) {
+			if (fuse_has_iomap_fileio(inode)) {
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
@@ -2071,6 +2086,12 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		goto error;
 	}
 
+	if (fuse_has_iomap_fileio(inode) && is_truncate) {
+		err = fuse_iomap_setsize(inode, outarg.attr.size);
+		if (err)
+			goto error;
+	}
+
 	spin_lock(&fi->lock);
 	/* the kernel maintains i_mtime locally */
 	if (trust_local_cmtime) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 06223e56955ca3..2dd4e5c2933c0f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -384,7 +384,7 @@ static int fuse_release(struct inode *inode, struct file *file)
 	 * Dirty pages might remain despite write_inode_now() call from
 	 * fuse_flush() due to writes racing with the close.
 	 */
-	if (fc->writeback_cache)
+	if (fc->writeback_cache || fuse_has_iomap_fileio(inode))
 		write_inode_now(inode, 1);
 
 	fuse_release_common(file, false);
@@ -1668,8 +1668,6 @@ static ssize_t __fuse_direct_read(struct fuse_io_priv *io,
 	return res;
 }
 
-static ssize_t fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
-
 static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t res;
@@ -1726,6 +1724,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 	}
 
+	if (fuse_want_iomap_buffered_io(iocb))
+		return fuse_iomap_buffered_read(iocb, to);
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
@@ -1749,10 +1750,29 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
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
 
@@ -2378,6 +2398,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	struct inode *inode = file_inode(file);
 	int rc;
 
+	if (fuse_has_iomap_fileio(inode))
+		return fuse_iomap_mmap(file, vma);
+
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_mmap(file, vma);
@@ -2576,7 +2599,7 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
 	return err;
 }
 
-static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
+sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -2832,8 +2855,7 @@ static inline loff_t fuse_round_up(struct fuse_conn *fc, loff_t off)
 	return round_up(off, fc->max_pages << PAGE_SHIFT);
 }
 
-static ssize_t
-fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+ssize_t fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	ssize_t ret = 0;
@@ -2930,8 +2952,12 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static int fuse_writeback_range(struct inode *inode, loff_t start, loff_t end)
 {
-	int err = filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
+	int err;
 
+	if (fuse_has_iomap_fileio(inode))
+		return fuse_iomap_flush_unmap_range(inode, start, end);
+
+	err = filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
 	if (!err)
 		fuse_sync_writes(inode);
 
@@ -2952,6 +2978,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.length = length,
 		.mode = mode
 	};
+	loff_t newsize = 0;
 	int err;
 	bool block_faults = FUSE_IS_DAX(inode) &&
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
@@ -2965,7 +2992,10 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
-	if (block_faults) {
+	if (fuse_has_iomap_fileio(inode)) {
+		filemap_invalidate_lock(inode->i_mapping);
+		block_faults = true;
+	} else if (block_faults) {
 		filemap_invalidate_lock(inode->i_mapping);
 		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
@@ -2980,11 +3010,23 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
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
+	if (fuse_has_iomap_fileio(inode))
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
@@ -3007,14 +3049,23 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (err)
 		goto out;
 
-	/* we could have extended the file */
-	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
-		if (fuse_write_update_attr(inode, offset + length, length))
-			file_update_time(file);
-	}
+	if (fuse_has_iomap_fileio(inode)) {
+		err = fuse_iomap_fallocate(file, mode, offset, length,
+					   newsize);
+		if (err)
+			goto out;
+	} else {
+		/* we could have extended the file */
+		if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+			if (fuse_write_update_attr(inode, offset + length,
+						   length))
+				file_update_time(file);
+		}
 
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
-		truncate_pagecache_range(inode, offset, offset + length - 1);
+		if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
+			truncate_pagecache_range(inode, offset,
+						 offset + length - 1);
+	}
 
 	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 
@@ -3100,6 +3151,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
+	/* See inode_dio_wait comment in fuse_file_fallocate */
+	if (fuse_has_iomap_fileio(inode_out))
+		inode_dio_wait(inode_out);
+
 	if (is_unstable)
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
 
@@ -3119,7 +3174,8 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
-	truncate_inode_pages_range(inode_out->i_mapping,
+	if (!fuse_has_iomap_fileio(inode_out))
+		truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
 
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 3f96cab5de1fb4..ab0dee6460a7dd 100644
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
@@ -747,6 +749,8 @@ void fuse_iomap_open(struct inode *inode, struct file *file)
 {
 	if (fuse_has_iomap_directio(inode))
 		file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (fuse_has_iomap_fileio(inode))
+		file->f_mode |= FMODE_NOWAIT;
 }
 
 enum fuse_ilock_type {
@@ -804,12 +808,26 @@ static inline void fuse_iomap_clear_directio(struct inode *inode)
 	clear_bit(FUSE_I_IOMAP_DIRECTIO, &fi->state);
 }
 
+static inline void fuse_iomap_set_fileio(struct inode *inode);
+
+static inline void fuse_iomap_clear_fileio(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(get_fuse_conn_c(inode)->iomap_fileio);
+	ASSERT(list_empty(&fi->ioend_list));
+
+	clear_bit(FUSE_I_IOMAP_FILEIO, &fi->state);
+}
+
 void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags)
 {
 	struct fuse_conn *conn = get_fuse_conn(inode);
 
 	if (conn->iomap_directio && (attr_flags & FUSE_ATTR_IOMAP_DIRECTIO))
 		fuse_iomap_set_directio(inode);
+	if (conn->iomap_fileio && (attr_flags & FUSE_ATTR_IOMAP_FILEIO))
+		fuse_iomap_set_fileio(inode);
 
 	trace_fuse_iomap_init_inode(inode);
 }
@@ -820,6 +838,8 @@ void fuse_iomap_evict_inode(struct inode *inode)
 
 	if (fuse_has_iomap_directio(inode))
 		fuse_iomap_clear_directio(inode);
+	if (fuse_has_iomap_fileio(inode))
+		fuse_iomap_clear_fileio(inode);
 }
 
 ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
@@ -908,6 +928,109 @@ static int fuse_iomap_direct_write_sync(struct kiocb *iocb, loff_t start,
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
+	if (fuse_has_iomap_fileio(inode) &&
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
@@ -947,8 +1070,9 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -970,3 +1094,598 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
+	ASSERT(fuse_has_iomap_fileio(inode));
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
+	ASSERT(fuse_has_iomap_fileio(inode));
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
+	ASSERT(fuse_has_iomap_fileio(inode));
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
+	ASSERT(fuse_has_iomap_fileio(ioend->io_inode));
+
+	trace_fuse_iomap_submit_ioend(wpc, status);
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
+	ASSERT(fuse_has_iomap_fileio(inode));
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
+	ASSERT(fuse_has_iomap_fileio(mapping->host));
+
+	trace_fuse_iomap_writepages(mapping->host, wbc);
+
+	return iomap_writepages(mapping, wbc, &wpc.ctx,
+				&fuse_iomap_writeback_ops);
+}
+
+static int fuse_iomap_read_folio(struct file *file, struct folio *folio)
+{
+	ASSERT(fuse_has_iomap_fileio(file_inode(file)));
+
+	trace_fuse_iomap_read_folio(folio);
+
+	return iomap_read_folio(folio, &fuse_iomap_ops);
+}
+
+static void fuse_iomap_readahead(struct readahead_control *rac)
+{
+	ASSERT(fuse_has_iomap_fileio(file_inode(rac->file)));
+
+	trace_fuse_iomap_readahead(rac);
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
+	.direct_IO		= fuse_direct_IO,
+};
+
+static inline void fuse_iomap_set_fileio(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(get_fuse_conn_c(inode)->iomap_fileio);
+
+	inode->i_data.a_ops = &fuse_iomap_aops;
+
+	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
+	INIT_LIST_HEAD(&fi->ioend_list);
+	spin_lock_init(&fi->ioend_lock);
+	set_bit(FUSE_I_IOMAP_FILEIO, &fi->state);
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
+	ASSERT(fuse_has_iomap_fileio(inode));
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
+	ASSERT(fuse_has_iomap_fileio(file_inode(file)));
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
+	ASSERT(fuse_has_iomap_fileio(inode));
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
+	ASSERT(fuse_has_iomap_fileio(inode));
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
+	 * Flush the entire pagecache to ensure the fuse server logs the inode
+	 * size change and all dirty data that might be associated with it.
+	 * We don't know the ondisk inode size, so we only have this clumsy
+	 * hammer.
+	 */
+	return filemap_write_and_wait(inode->i_mapping);
+}
+
+int
+fuse_iomap_setsize(
+	struct inode		*inode,
+	loff_t			newsize)
+{
+	int error;
+
+	ASSERT(fuse_has_iomap(inode));
+	ASSERT(fuse_has_iomap_fileio(inode));
+
+	trace_fuse_iomap_setsize(inode, newsize, 0);
+
+	error = inode_newsize_ok(inode, newsize);
+	if (error)
+		return error;
+	return fuse_iomap_setattr_size(inode, newsize);
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
+	trace_fuse_iomap_flush_unmap_range(inode, start, end + 1 - start);
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
+void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits)
+{
+	trace_fuse_iomap_set_i_blkbits(inode, new_blkbits);
+
+	if (inode->i_blkbits == new_blkbits)
+		return;
+
+	if (!S_ISREG(inode->i_mode))
+		goto set_it;
+
+	/*
+	 * iomap attaches per-block state to each folio, so we cannot allow
+	 * the file block size to change if there's anything in the page cache.
+	 * In theory, fuse servers should never be doing this.
+	 */
+	if (inode->i_mapping->nrpages > 0) {
+		WARN_ON(inode->i_blkbits != new_blkbits &&
+			inode->i_mapping->nrpages > 0);
+		return;
+	}
+
+set_it:
+	inode->i_blkbits = new_blkbits;
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
+	ASSERT(fuse_has_iomap_fileio(inode));
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
+	 * new EOF and bounce the new size out to userspace.
+	 */
+	if (new_size) {
+		error = fuse_iomap_setsize(inode, new_size);
+		if (error)
+			return error;
+
+		fuse_write_update_attr(inode, new_size, length);
+	}
+
+	file_update_time(file);
+	return 0;
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1a17983753c367..3e92a29d1030c9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -231,6 +231,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	u8 new_blkbits;
 
 	lockdep_assert_held(&fi->lock);
 
@@ -292,9 +293,14 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	}
 
 	if (attr->blksize != 0)
-		inode->i_blkbits = ilog2(attr->blksize);
+		new_blkbits = ilog2(attr->blksize);
 	else
-		inode->i_blkbits = inode->i_sb->s_blocksize_bits;
+		new_blkbits = inode->i_sb->s_blocksize_bits;
+
+	if (fuse_has_iomap_fileio(inode))
+		fuse_iomap_set_i_blkbits(inode, new_blkbits);
+	else
+		inode->i_blkbits = new_blkbits;
 
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
@@ -1451,6 +1457,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->iomap = 1;
 			if ((flags & FUSE_IOMAP_DIRECTIO) && fc->iomap)
 				fc->iomap_directio = 1;
+			if ((flags & FUSE_IOMAP_FILEIO) && fc->iomap)
+				fc->iomap_fileio = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1523,7 +1531,7 @@ void fuse_send_init(struct fuse_mount *fm)
 	if (fuse_uring_enabled())
 		flags |= FUSE_OVER_IO_URING;
 	if (fuse_iomap_enabled())
-		flags |= FUSE_IOMAP | FUSE_IOMAP_DIRECTIO;
+		flags |= FUSE_IOMAP | FUSE_IOMAP_DIRECTIO | FUSE_IOMAP_FILEIO;
 
 	ia->in.flags = flags;
 	ia->in.flags2 = flags >> 32;


