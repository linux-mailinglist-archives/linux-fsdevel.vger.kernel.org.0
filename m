Return-Path: <linux-fsdevel+bounces-58450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0C6B2E9CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041081899A85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A841E493C;
	Thu, 21 Aug 2025 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG1Hdvmj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E51804A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737691; cv=none; b=OQkFBB96YqefHis1qWOinHVkrjdq6eOk4vzsZa2qc+OjzwmbXROKIBNralF3OnHITvLqn441sHXqwqC35uYdJtKQOQ/Nvx1P3qSANlIXkrlKFJP8qa9ahHn7NzobNLowypkOtoDUEZo86djVa92cdtUTFPyoSPPf4RPLHN1MAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737691; c=relaxed/simple;
	bh=CHKGQ7Yj1dCqxcxJbTjV9ny6FYH8sg27int9zttMWA8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4wt7geHvdf/SkW9pbJhwgsNJ4ZM3DvIxHQtIbCJ6JNDPFpGbT/hGNrfloDZMbSMQPKCULzOwq03ZF8Wty+vduacJWJYN7J4D9t9kKmpNoq0Nuy69QZ+dqc/Ut2Z6ofQj9wu8P2d1GuxeBvt0jCnuOfAigQHWPTWdzlTr4kkB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG1Hdvmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5288AC4CEE7;
	Thu, 21 Aug 2025 00:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737691;
	bh=CHKGQ7Yj1dCqxcxJbTjV9ny6FYH8sg27int9zttMWA8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nG1HdvmjCKGnuQUbHuC58UTRWizpmNBxFNcOGmKZ80so8kGXrGgBqzgJCpDwSdU09
	 96UMAuKq1OCV3sNvWmp9rTnVSFfO3V6435NwA0Ecp7M1Qv5l10B6t4IPv8qLT7F1oF
	 XlRA3k0lH7x4JUzQVEP1Rm0OBy6cfFBJ3brnROsgvwRntKnRR608qj1r61Ci4L1G7c
	 vAnahVXVc6Wi0rnzzj78AuKbya2FcIyHPk/4QGwTHisLMvTyfSpxemUAwOyUTLEkPx
	 RCTeOV5+IzhKnJG+cXaFLytPoAHlouUX2ZFx303j5cG3okuA++4YStty6KU2dEBHiV
	 /ZS/YFMZLZwfA==
Date: Wed, 20 Aug 2025 17:54:50 -0700
Subject: [PATCH 09/23] fuse: implement direct IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709308.17510.17145040362771536045.stgit@frogsfrogsfrogs>
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

Start implementing the fuse-iomap file I/O paths by adding direct I/O
support and all the signalling flags that come with it.  Buffered I/O
is much more complicated, so we leave that to a subsequent patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   50 +++++++
 fs/fuse/fuse_trace.h      |  186 +++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   29 ++++
 fs/fuse/dir.c             |    7 +
 fs/fuse/file.c            |   17 ++
 fs/fuse/file_iomap.c      |  338 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    2 
 fs/fuse/trace.c           |    1 
 8 files changed, 624 insertions(+), 6 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e7dc8229bcc5e7..1415db4ebf47b1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -234,6 +234,8 @@ enum {
 	FUSE_I_BTIME,
 	/* Wants or already has page cache IO */
 	FUSE_I_CACHE_IO_MODE,
+	/* Use iomap for this inode */
+	FUSE_I_IOMAP,
 };
 
 struct fuse_conn;
@@ -624,6 +626,16 @@ struct fuse_sync_bucket {
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
@@ -903,7 +915,10 @@ struct fuse_conn {
 	/* Is link not implemented by fs? */
 	unsigned int no_link:1;
 
-	/* Use fs/iomap for FIEMAP and SEEK_{DATA,HOLE} file operations */
+	/*
+	 * Use fs/iomap for FIEMAP and SEEK_{DATA,HOLE} file operations and
+	 * direct I/O.
+	 */
 	unsigned int iomap:1;
 
 	/* Use io_uring for communication */
@@ -967,6 +982,11 @@ struct fuse_conn {
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
@@ -1656,6 +1676,27 @@ int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 length);
 loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
 sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
+
+void fuse_iomap_open(struct inode *inode, struct file *file);
+
+void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags);
+void fuse_iomap_evict_inode(struct inode *inode);
+
+static inline bool fuse_inode_has_iomap(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode_c(inode);
+
+	return test_bit(FUSE_I_IOMAP, &fi->state);
+}
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
@@ -1666,6 +1707,13 @@ sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 # define fuse_iomap_fiemap			NULL
 # define fuse_iomap_lseek(...)			(-ENOSYS)
 # define fuse_iomap_bmap(...)			(-ENOSYS)
+# define fuse_iomap_open(...)			((void)0)
+# define fuse_iomap_init_inode(...)		((void)0)
+# define fuse_iomap_evict_inode(...)		((void)0)
+# define fuse_inode_has_iomap(...)		(false)
+# define fuse_want_iomap_directio(...)		(false)
+# define fuse_iomap_direct_read(...)		(-ENOSYS)
+# define fuse_iomap_direct_write(...)		(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index d2a926124a5d54..12dd05877727ab 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -60,6 +60,7 @@
 	EM( FUSE_STATX,			"FUSE_STATX")		\
 	EM( FUSE_IOMAP_BEGIN,		"FUSE_IOMAP_BEGIN")	\
 	EM( FUSE_IOMAP_END,		"FUSE_IOMAP_END")	\
+	EM( FUSE_IOMAP_IOEND,		"FUSE_IOMAP_IOEND")	\
 	EMe(CUSE_INIT,			"CUSE_INIT")
 
 /*
@@ -307,6 +308,34 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
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
+TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+
+#define FUSE_IFLAG_STRINGS \
+	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
+	{ 1 << FUSE_I_INIT_RDPLUS,		"init_rdplus" }, \
+	{ 1 << FUSE_I_SIZE_UNSTABLE,		"size_unstable" }, \
+	{ 1 << FUSE_I_BAD,			"bad" }, \
+	{ 1 << FUSE_I_BTIME,			"btime" }, \
+	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
+	{ 1 << FUSE_I_IOMAP,			"iomap" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -472,6 +501,65 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->error)
 );
 
+TRACE_EVENT(fuse_iomap_ioend,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_ioend_in *inarg),
+
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned,		ioendflags)
+		__field(int,			error)
+		__field(uint64_t,		new_addr)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	inarg->pos;
+		__entry->length		=	inarg->written;
+		__entry->ioendflags	=	inarg->ioendflags;
+		__entry->error		=	inarg->error;
+		__entry->new_addr	=	inarg->new_addr;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d new_addr 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
+		  __entry->error,
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
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned,		ioendflags)
+		__field(int,			error)
+		__field(uint64_t,		new_addr)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	inarg->pos;
+		__entry->length		=	inarg->written;
+		__entry->ioendflags	=	inarg->ioendflags;
+		__entry->error		=	error;
+		__entry->new_addr	=	inarg->new_addr;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d new_addr 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
+		  __entry->error,
+		  __entry->new_addr)
+);
+
 TRACE_EVENT(fuse_iomap_dev_add,
 	TP_PROTO(const struct fuse_conn *fc,
 		 const struct fuse_backing_map *map),
@@ -541,6 +629,104 @@ TRACE_EVENT(fuse_iomap_lseek,
 		  __entry->offset,
 		  __entry->whence)
 );
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_io_class,
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter),
+	TP_ARGS(iocb, iter),
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(file_inode(iocb->ki_filp), fi, fm);
+		__entry->offset		=	iocb->ki_pos;
+		__entry->length		=	iov_iter_count(iter);
+	),
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
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
+		FUSE_IO_RANGE_FIELDS()
+		__field(ssize_t,		ret)
+	),
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(file_inode(iocb->ki_filp), fi, fm);
+		__entry->offset		=	iocb->ki_pos;
+		__entry->length		=	iov_iter_count(iter);
+		__entry->ret		=	ret;
+	),
+	TP_printk(FUSE_IO_RANGE_FMT() " ret 0x%zx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->ret)
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
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned,		dioendflags)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	written;
+		__entry->dioendflags	=	flags;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " dioendflags (%s) error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->dioendflags, "|", IOMAP_DIOEND_STRINGS),
+		  __entry->error)
+);
+
+DECLARE_EVENT_CLASS(fuse_inode_state_class,
+	TP_PROTO(const struct inode *inode),
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(unsigned long,		state)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->state		=	fi->state;
+	),
+
+	TP_printk(FUSE_INODE_FMT " state (%s)",
+		  FUSE_INODE_PRINTK_ARGS,
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
index 3b9e337119d792..10882fa1452e49 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -238,7 +238,8 @@
  *
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
- *    SEEK_{DATA,HOLE}
+ *    SEEK_{DATA,HOLE}, and direct I/O
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -448,7 +449,7 @@ struct fuse_file_lock {
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
- *	       operations.
+ *	       operations and direct I/O.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -580,9 +581,11 @@ struct fuse_file_lock {
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ * FUSE_ATTR_IOMAP: Use iomap for this inode
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
+#define FUSE_ATTR_IOMAP		(1 << 2)
 
 /**
  * Open flags
@@ -665,6 +668,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1380,4 +1384,25 @@ struct fuse_iomap_end_in {
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
index 4ea763699c1bae..04e1242014c9c9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -712,6 +712,10 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		goto out_acl_release;
 	fuse_dir_changed(dir);
+
+	if (fuse_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (!err) {
 		file->private_data = ff;
@@ -1749,6 +1753,9 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 54432cf0be82ba..f01a9346d4f8bc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -245,6 +245,9 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
@@ -1751,10 +1754,17 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
 
@@ -1776,6 +1786,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
 
@@ -3139,4 +3155,5 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, flags);
+	fuse_iomap_init_inode(inode, flags);
 }
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 691ca3a4ec95e5..0a4433e9fe14ea 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -500,10 +500,15 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
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
@@ -528,7 +533,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	int err = 0;
 
-	if (fuse_should_send_iomap_end(iomap, opflags, count, written)) {
+	if (fuse_should_send_iomap_end(fm, iomap, opflags, count, written)) {
 		struct fuse_iomap_end_in inarg = {
 			.opflags = fuse_iomap_op_to_server(opflags),
 			.attr_ino = fi->orig_ino,
@@ -554,6 +559,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			 * libfuse returns ENOSYS for servers that don't
 			 * implement iomap_end
 			 */
+			fm->fc->iomap_conn.no_end = 1;
 			err = 0;
 			break;
 		case 0:
@@ -567,11 +573,104 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	return err;
 }
 
-const struct iomap_ops fuse_iomap_ops = {
+static const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
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
+	trace_fuse_iomap_ioend(inode, &inarg);
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
+			trace_fuse_iomap_ioend_error(inode, &inarg, err);
+
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
 int fuse_iomap_backing_open(struct fuse_conn *fc, struct fuse_backing *fb)
 {
 	if (!fc->iomap)
@@ -605,6 +704,8 @@ void fuse_iomap_mount(struct fuse_mount *fm)
 	 * freeze/thaw properly.
 	 */
 	fc->sync_fs = true;
+	fc->iomap_conn.no_end = 0;
+	fc->iomap_conn.no_ioend = 0;
 }
 
 void fuse_iomap_unmount(struct fuse_mount *fm)
@@ -693,3 +794,234 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
 		return offset;
 	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
 }
+
+void fuse_iomap_open(struct inode *inode, struct file *file)
+{
+	if (fuse_inode_has_iomap(inode))
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
+static inline void fuse_inode_set_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_has_iomap(inode));
+
+	set_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+static inline void fuse_inode_clear_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_has_iomap(inode));
+
+	clear_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags)
+{
+	struct fuse_conn *conn = get_fuse_conn(inode);
+
+	if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP))
+		fuse_inode_set_iomap(inode);
+
+	trace_fuse_iomap_init_inode(inode);
+}
+
+void fuse_iomap_evict_inode(struct inode *inode)
+{
+	trace_fuse_iomap_evict_inode(inode);
+
+	if (fuse_inode_has_iomap(inode))
+		fuse_inode_clear_iomap(inode);
+}
+
+ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	ASSERT(fuse_inode_has_iomap(inode));
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
+	ASSERT(fuse_inode_has_iomap(inode));
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
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	trace_fuse_iomap_direct_write(iocb, from);
+
+	if (!count)
+		return 0;
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
index 3274ee1c31b62b..3d54fabbd64b0c 100644
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


