Return-Path: <linux-fsdevel+bounces-58451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F2B2E9D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFAE189902C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1373320298C;
	Thu, 21 Aug 2025 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYNn6I22"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722471804A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737707; cv=none; b=iAl+OUQTI/wq/Ka7nqIPJdv1aaSS4tQXUYLtg+im0sf0SSWCjfDM56PcOUbfmVVj2CnXQxq21DobuOzsiSmOM0/V6afkD43G2G1o95DnfU5jLa4u1TObis+rXBS1f2n68xz6mV3DOZal94dwISM2MF0Vs2XJLwSTS631SJw3zt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737707; c=relaxed/simple;
	bh=x0sH5iYTk3rtzgwCc+2tdMQ2XYxz78RP517jkzKFgfA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXA0BPDaHX2ajoyysC5ChxgFW7xv3hgOyFyO68Pnfg2j3oj1Hg3jKEO6FFLBqZnoBlqxtUOJi8vIxLGiPZJ1i9Wn1zYRirbp53njzhl3j7NT6J+JRdDIYoiWWgwweCASoB85fgmWrhTNcMUEwRiQ85i8UtdElZrR96sI2Wya0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYNn6I22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD24C4CEE7;
	Thu, 21 Aug 2025 00:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737707;
	bh=x0sH5iYTk3rtzgwCc+2tdMQ2XYxz78RP517jkzKFgfA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jYNn6I22L6wGyEg3dX4ndflULcqqdmkQUCMbqcohTABLJHlYUl+LlRLeVuA8sJPHD
	 qCK/ujfnvcrzUmbBomSJiaSMRHEgwo73rIRimbSM4lhKBXa9PQe6rEes0YWzkkWK/p
	 M+PiHrc4ljlBQGZBSqsG59HO+zr23zq7s62F4GLTrWzF6Vm61MK20fCR2E6rIkF+pt
	 Ss1XLbvOKzPikIjkyqiY21AWUPEy05CWZwJZ4Ac/ANEzaTGhbn0rKRoBSAn1si5iMy
	 ep3JXdQlM4gyx6g4VFJphc3Ax+eJJk052az8VAYW0FlUecIbQz4YQLVW9jh908IPsj
	 /RMeWRkoDUBsA==
Date: Wed, 20 Aug 2025 17:55:06 -0700
Subject: [PATCH 10/23] fuse: implement buffered IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709331.17510.11991231175254097393.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h          |   36 ++
 fs/fuse/fuse_trace.h      |  268 +++++++++++++++++
 include/uapi/linux/fuse.h |    4 
 fs/fuse/dir.c             |   23 +
 fs/fuse/file.c            |   84 ++++-
 fs/fuse/file_iomap.c      |  718 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c           |   10 +
 7 files changed, 1113 insertions(+), 30 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1415db4ebf47b1..74fb5971f8fec7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -169,6 +169,13 @@ struct fuse_inode {
 
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
@@ -916,8 +923,8 @@ struct fuse_conn {
 	unsigned int no_link:1;
 
 	/*
-	 * Use fs/iomap for FIEMAP and SEEK_{DATA,HOLE} file operations and
-	 * direct I/O.
+	 * Use fs/iomap for FIEMAP and SEEK_{DATA,HOLE} file operations,
+	 * buffered I/O, and direct I/O.
 	 */
 	unsigned int iomap:1;
 
@@ -1659,6 +1666,8 @@ void fuse_iomap_sysfs_cleanup(struct kobject *kobj);
 # define fuse_iomap_sysfs_cleanup(...)		((void)0)
 #endif
 
+sector_t fuse_bmap(struct address_space *mapping, sector_t block);
+
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 bool fuse_iomap_enabled(void);
 
@@ -1697,6 +1706,21 @@ static inline bool fuse_want_iomap_directio(const struct kiocb *iocb)
 
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
+void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits);
+int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
+			 loff_t length, loff_t new_size);
+int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
+				 loff_t endpos);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1714,6 +1738,14 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from);
 # define fuse_want_iomap_directio(...)		(false)
 # define fuse_iomap_direct_read(...)		(-ENOSYS)
 # define fuse_iomap_direct_write(...)		(-ENOSYS)
+# define fuse_want_iomap_buffered_io(...)	(false)
+# define fuse_iomap_mmap(...)			(-ENOSYS)
+# define fuse_iomap_buffered_read(...)		(-ENOSYS)
+# define fuse_iomap_buffered_write(...)		(-ENOSYS)
+# define fuse_iomap_setsize_start(...)		(-ENOSYS)
+# define fuse_iomap_set_i_blkbits(...)		((void)0)
+# define fuse_iomap_fallocate(...)		(-ENOSYS)
+# define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 12dd05877727ab..10537a38b54556 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -231,6 +231,9 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #endif
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
+struct iomap_writepage_ctx;
+struct iomap_ioend;
+
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
 		__field(unsigned,		opflags)
@@ -336,6 +339,12 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
 	{ 1 << FUSE_I_IOMAP,			"iomap" }
 
+#define IOMAP_IOEND_STRINGS \
+	{ IOMAP_IOEND_SHARED,			"shared" }, \
+	{ IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
+	{ IOMAP_IOEND_BOUNDARY,			"boundary" }, \
+	{ IOMAP_IOEND_DIRECT,			"direct" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -650,6 +659,9 @@ DEFINE_EVENT(fuse_iomap_file_io_class, name,		\
 	TP_ARGS(iocb, iter))
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_read);
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_read);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_write_zero_eof);
 
 DECLARE_EVENT_CLASS(fuse_iomap_file_ioend_class,
 	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter,
@@ -676,6 +688,8 @@ DEFINE_EVENT(fuse_iomap_file_ioend_class, name,		\
 	TP_ARGS(iocb, iter, ret))
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_read_end);
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_write_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_read_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_write_end);
 
 TRACE_EVENT(fuse_iomap_dio_write_end_io,
 	TP_PROTO(const struct inode *inode, loff_t pos, ssize_t written,
@@ -727,6 +741,260 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
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
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		ioendflags)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(ioend->io_inode, fi, fm);
+		__entry->offset		=	ioend->io_offset;
+		__entry->length		=	ioend->io_size;
+		__entry->ioendflags	=	ioend->io_flags;
+		__entry->error		=	blk_status_to_errno(ioend->io_bio.bi_status);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->ioendflags, "|", IOMAP_IOEND_STRINGS),
+		  __entry->error)
+);
+
+TRACE_EVENT(fuse_iomap_writeback_range,
+	TP_PROTO(const struct inode *inode, u64 offset, unsigned int count,
+		 u64 end_pos),
+
+	TP_ARGS(inode, offset, count, end_pos),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(uint64_t,		end_pos)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	count;
+		__entry->end_pos	=	end_pos;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " end_pos 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->end_pos)
+);
+
+TRACE_EVENT(fuse_iomap_writeback_submit,
+	TP_PROTO(const struct iomap_writepage_ctx *wpc, int error),
+
+	TP_ARGS(wpc, error),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		nr_folios)
+		__field(uint64_t,		addr)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(wpc->inode, fi, fm);
+		__entry->nr_folios	=	wpc->nr_folios;
+		__entry->offset		=	wpc->iomap.offset;
+		__entry->length		=	wpc->iomap.length;
+		__entry->addr		=	wpc->iomap.addr << 9;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " addr 0x%llx nr_folios %u error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->addr,
+		  __entry->nr_folios,
+		  __entry->error)
+);
+
+TRACE_EVENT(fuse_iomap_discard_folio,
+	TP_PROTO(const struct inode *inode, loff_t offset, size_t count),
+
+	TP_ARGS(inode, offset, count),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	count;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_writepages,
+	TP_PROTO(const struct inode *inode, const struct writeback_control *wbc),
+
+	TP_ARGS(inode, wbc),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(long,			nr_to_write)
+		__field(bool,			sync_all)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	wbc->range_start;
+		__entry->length		=	wbc->range_end - wbc->range_start + 1;
+		__entry->nr_to_write	=	wbc->nr_to_write;
+		__entry->sync_all	=	wbc->sync_mode == WB_SYNC_ALL;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " nr_folios %ld sync_all? %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->nr_to_write,
+		  __entry->sync_all)
+);
+
+TRACE_EVENT(fuse_iomap_read_folio,
+	TP_PROTO(const struct folio *folio),
+
+	TP_ARGS(folio),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(folio->mapping->host, fi, fm);
+		__entry->offset		=	folio_pos(folio);
+		__entry->length		=	folio_size(folio);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_readahead,
+	TP_PROTO(const struct readahead_control *rac),
+
+	TP_ARGS(rac),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		struct readahead_control *mutrac = (struct readahead_control *)rac;
+		FUSE_INODE_ASSIGN(file_inode(rac->file), fi, fm);
+		__entry->offset		=	readahead_pos(mutrac);
+		__entry->length		=	readahead_length(mutrac);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_page_mkwrite,
+	TP_PROTO(const struct vm_fault *vmf),
+
+	TP_ARGS(vmf),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		struct folio *folio = page_folio(vmf->page);
+		FUSE_INODE_ASSIGN(file_inode(vmf->vma->vm_file), fi, fm);
+		__entry->offset		=	folio_pos(folio);
+		__entry->length		=	folio_size(folio);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_range_class,
+	TP_PROTO(const struct inode *inode, loff_t offset, loff_t length),
+
+	TP_ARGS(inode, offset, length),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
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
+		FUSE_INODE_FIELDS
+		__field(u8,			old_blkbits)
+		__field(u8,			new_blkbits)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->old_blkbits	=	inode->i_blkbits;
+		__entry->new_blkbits	=	new_blkbits;
+	),
+
+	TP_printk(FUSE_INODE_FMT " old_blkbits %u new_blkbits %u",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->old_blkbits,
+		  __entry->new_blkbits)
+);
+
+TRACE_EVENT(fuse_iomap_fallocate,
+	TP_PROTO(const struct inode *inode, int mode, loff_t offset,
+		 loff_t length, loff_t newsize),
+	TP_ARGS(inode, mode, offset, length, newsize),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(loff_t,			newsize)
+		__field(int,			mode)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+		__entry->mode		=	mode;
+		__entry->newsize	=	newsize;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " mode 0x%x newsize 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->mode,
+		  __entry->newsize)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 10882fa1452e49..12d15c186256f3 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -238,7 +238,7 @@
  *
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
- *    SEEK_{DATA,HOLE}, and direct I/O
+ *    SEEK_{DATA,HOLE}, buffered I/O, and direct I/O
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
@@ -449,7 +449,7 @@ struct fuse_file_lock {
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
- *	       operations and direct I/O.
+ *	       operations, buffered I/O, and direct I/O.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 04e1242014c9c9..6195ac3232ff22 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2025,7 +2025,10 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		is_truncate = true;
 	}
 
-	if (FUSE_IS_DAX(inode) && is_truncate) {
+	if (fuse_inode_has_iomap(inode) && is_truncate) {
+		filemap_invalidate_lock(mapping);
+		fault_blocked = true;
+	} else if (FUSE_IS_DAX(inode) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, -1);
@@ -2040,6 +2043,18 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		WARN_ON(!(attr->ia_valid & ATTR_SIZE));
 		WARN_ON(attr->ia_size != 0);
 		if (fc->atomic_o_trunc) {
+			if (fuse_inode_has_iomap(inode)) {
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
@@ -2070,6 +2085,12 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 		if (trust_local_cmtime && attr->ia_size != inode->i_size)
 			attr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
+
+		if (fuse_inode_has_iomap(inode)) {
+			err = fuse_iomap_setsize_start(inode, attr->ia_size);
+			if (err)
+				goto error;
+		}
 	}
 
 	memset(&inarg, 0, sizeof(inarg));
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f01a9346d4f8bc..43f3e2d4eacb8e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -385,7 +385,7 @@ static int fuse_release(struct inode *inode, struct file *file)
 	 * Dirty pages might remain despite write_inode_now() call from
 	 * fuse_flush() due to writes racing with the close.
 	 */
-	if (fc->writeback_cache)
+	if (fc->writeback_cache || fuse_inode_has_iomap(inode))
 		write_inode_now(inode, 1);
 
 	fuse_release_common(file, false);
@@ -1765,6 +1765,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 	}
 
+	if (fuse_want_iomap_buffered_io(iocb))
+		return fuse_iomap_buffered_read(iocb, to);
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
@@ -1788,10 +1791,29 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
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
 
@@ -2325,6 +2347,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	struct inode *inode = file_inode(file);
 	int rc;
 
+	if (fuse_inode_has_iomap(inode))
+		return fuse_iomap_mmap(file, vma);
+
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_mmap(file, vma);
@@ -2523,7 +2548,7 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
 	return err;
 }
 
-static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
+sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -2877,8 +2902,12 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
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
 
@@ -2899,6 +2928,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.length = length,
 		.mode = mode
 	};
+	loff_t newsize = 0;
 	int err;
 	bool block_faults = FUSE_IS_DAX(inode) &&
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
@@ -2912,7 +2942,10 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
-	if (block_faults) {
+	if (fuse_inode_has_iomap(inode)) {
+		filemap_invalidate_lock(inode->i_mapping);
+		block_faults = true;
+	} else if (block_faults) {
 		filemap_invalidate_lock(inode->i_mapping);
 		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
@@ -2927,11 +2960,23 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
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
+	if (fuse_inode_has_iomap(inode))
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
@@ -2954,14 +2999,22 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (err)
 		goto out;
 
-	/* we could have extended the file */
-	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
-		if (fuse_write_update_attr(inode, offset + length, length))
-			file_update_time(file);
-	}
+	if (fuse_inode_has_iomap(inode)) {
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
 
@@ -3047,6 +3100,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
+	/* See inode_dio_wait comment in fuse_file_fallocate */
+	if (fuse_inode_has_iomap(inode_out))
+		inode_dio_wait(inode_out);
+
 	if (is_unstable)
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
 
@@ -3066,7 +3123,8 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
-	truncate_inode_pages_range(inode_out->i_mapping,
+	if (!fuse_inode_has_iomap(inode_out))
+		truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
 
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 0a4433e9fe14ea..ff9298de193a26 100644
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
@@ -838,20 +840,14 @@ static int fuse_iomap_ilock_iocb(const struct kiocb *iocb,
 	return 0;
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
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	ASSERT(fuse_has_iomap(inode));
+	ASSERT(list_empty(&fi->ioend_list));
 
 	clear_bit(FUSE_I_IOMAP, &fi->state);
 }
@@ -960,6 +956,112 @@ static int fuse_iomap_direct_write_sync(struct kiocb *iocb, loff_t start,
 	return err;
 }
 
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
@@ -1002,8 +1104,9 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -1025,3 +1128,598 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
+	ASSERT(fuse_inode_has_iomap(inode));
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
+	trace_fuse_iomap_discard_folio(inode, pos, folio_size(folio));
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
+	trace_fuse_iomap_writeback_range(inode, offset, len, end_pos);
+
+	if (!fuse_iomap_revalidate_writeback(wpc, offset)) {
+		/* Pretend that this is a directio write */
+		ret = fuse_iomap_begin(inode, offset, len,
+				       IOMAP_DIRECT | IOMAP_WRITE,
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
+	trace_fuse_iomap_writeback_submit(wpc, error);
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
+	trace_fuse_iomap_writepages(mapping->host, wbc);
+
+	return iomap_writepages(&wpc.ctx);
+}
+
+static int fuse_iomap_read_folio(struct file *file, struct folio *folio)
+{
+	ASSERT(fuse_inode_has_iomap(file_inode(file)));
+
+	trace_fuse_iomap_read_folio(folio);
+
+	return iomap_read_folio(folio, &fuse_iomap_ops);
+}
+
+static void fuse_iomap_readahead(struct readahead_control *rac)
+{
+	ASSERT(fuse_inode_has_iomap(file_inode(rac->file)));
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
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	trace_fuse_iomap_buffered_write(iocb, from);
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
+	ASSERT(fuse_inode_has_iomap(inode));
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
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3d54fabbd64b0c..72ba71c609a248 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -231,6 +231,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	u8 new_blkbits;
 
 	lockdep_assert_held(&fi->lock);
 
@@ -295,9 +296,14 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	}
 
 	if (attr->blksize != 0)
-		inode->i_blkbits = ilog2(attr->blksize);
+		new_blkbits = ilog2(attr->blksize);
 	else
-		inode->i_blkbits = inode->i_sb->s_blocksize_bits;
+		new_blkbits = inode->i_sb->s_blocksize_bits;
+
+	if (fuse_inode_has_iomap(inode))
+		fuse_iomap_set_i_blkbits(inode, new_blkbits);
+	else
+		inode->i_blkbits = new_blkbits;
 
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS


