Return-Path: <linux-fsdevel+bounces-49609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CFAC00EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE66D9E4942
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0115EC5;
	Thu, 22 May 2025 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IczmYm9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655218D;
	Thu, 22 May 2025 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872194; cv=none; b=mi3NNkieuSp+aiTXkHROKn7yw7WuUnF3RsdnfSwH4KlvPy2Fdso4XeygB/eWDK4OuOTIjlLyto4hGUqH5DSmUISRuUXy8ID8FhWdPWhPZ2MXrFvXnJlS3srGT1Cir907fAzYzJiVhb99I8gNJi/7EUx2iqV+3lM7KR7Opp9ZpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872194; c=relaxed/simple;
	bh=ep2vFu2zcC0sXZn+l8qPEWlV4RlcGBI9Y+x8rmEk1yE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjjuhpOy3VSLHLUWTbZkXQ1G3KYkoIwQV2I93bMnHazb/h4N9gJmh9CixBcUXyxyxxyzAR4CH3auWmoYFaqjh2eYpMr9dhtQHndgodISxU4QalUfXXCHjlinOdATtknjD3Fkm69jb232CdMfn5QKLEABmu5Us2yenxUymRKEBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IczmYm9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83717C4CEE4;
	Thu, 22 May 2025 00:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872193;
	bh=ep2vFu2zcC0sXZn+l8qPEWlV4RlcGBI9Y+x8rmEk1yE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IczmYm9AWCD4vkVnft82gXbbE4kVnnOdARs/HOETnmmfHB1oc++ozUf87oqV4+U+1
	 rilmYmuC1ZUoA4ae1iemyCyWS9SEBC9vst/1WblOdoW+xjpG4wNrI8eiFut2JEdZXE
	 Xx8l53zOE01zv88Br15zG0+tJ1wPaX5wtzclu7FgHj9W7OrbWHNu3WosyiFhfHLdua
	 6hRwvwyRhPmEKAyjFiO3NqyMiEaOMQAnJUqT2a6wTPR3oSWGHynoboJNstC/fOn9ms
	 KFBpmfp7SJGy3Qu+LsVgp7fK/Xy058MgDbTUPUAsSXRi726GBMKiE6M2XlXx2d3z5Y
	 t0GixRWmc6eEg==
Date: Wed, 21 May 2025 17:03:13 -0700
Subject: [PATCH 03/11] fuse: implement the basic iomap mechanisms
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195629.1483178.7917092102987513364.stgit@frogsfrogsfrogs>
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

Implement functions to enable upcalling of iomap_begin and iomap_end to
userspace fuse servers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   38 ++++++
 fs/fuse/fuse_trace.h      |  258 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   87 ++++++++++++++
 fs/fuse/Kconfig           |   23 ++++
 fs/fuse/Makefile          |    1 
 fs/fuse/file_iomap.c      |  280 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    5 +
 7 files changed, 691 insertions(+), 1 deletion(-)
 create mode 100644 fs/fuse/file_iomap.c


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d56d4fd956db99..aa51f25856697d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -895,6 +895,9 @@ struct fuse_conn {
 	/* Is link not implemented by fs? */
 	unsigned int no_link:1;
 
+	/* Use fs/iomap for FIEMAP and SEEK_{DATA,HOLE} file operations */
+	unsigned int iomap:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
@@ -1017,6 +1020,11 @@ static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+static inline const struct fuse_mount *get_fuse_mount_super_c(const struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
 {
 	return get_fuse_mount_super(sb)->fc;
@@ -1027,16 +1035,31 @@ static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
 	return get_fuse_mount_super(inode->i_sb);
 }
 
+static inline const struct fuse_mount *get_fuse_mount_c(const struct inode *inode)
+{
+	return get_fuse_mount_super_c(inode->i_sb);
+}
+
 static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
 {
 	return get_fuse_mount_super(inode->i_sb)->fc;
 }
 
+static inline const struct fuse_conn *get_fuse_conn_c(const struct inode *inode)
+{
+	return get_fuse_mount_super_c(inode->i_sb)->fc;
+}
+
 static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
 {
 	return container_of(inode, struct fuse_inode, inode);
 }
 
+static inline const struct fuse_inode *get_fuse_inode_c(const struct inode *inode)
+{
+	return container_of(inode, struct fuse_inode, inode);
+}
+
 static inline u64 get_node_id(struct inode *inode)
 {
 	return get_fuse_inode(inode)->nodeid;
@@ -1577,4 +1600,19 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP)
+# include <linux/fiemap.h>
+# include <linux/iomap.h>
+
+bool fuse_iomap_enabled(void);
+
+static inline bool fuse_has_iomap(const struct inode *inode)
+{
+	return get_fuse_conn_c(inode)->iomap;
+}
+#else
+# define fuse_iomap_enabled(...)		(false)
+# define fuse_has_iomap(...)			(false)
+#endif
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index bbe9ddd8c71696..f9a316c9788e06 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -58,6 +58,8 @@
 	EM( FUSE_SYNCFS,		"FUSE_SYNCFS")		\
 	EM( FUSE_TMPFILE,		"FUSE_TMPFILE")		\
 	EM( FUSE_STATX,			"FUSE_STATX")		\
+	EM( FUSE_IOMAP_BEGIN,		"FUSE_IOMAP_BEGIN")	\
+	EM( FUSE_IOMAP_END,		"FUSE_IOMAP_END")	\
 	EMe(CUSE_INIT,			"CUSE_INIT")
 
 /*
@@ -124,6 +126,262 @@ TRACE_EVENT(fuse_request_end,
 		  __entry->unique, __entry->len, __entry->error)
 );
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP)
+
+#define FUSE_IOMAP_F_STRINGS \
+	{ FUSE_IOMAP_F_NEW,			"new" }, \
+	{ FUSE_IOMAP_F_DIRTY,			"dirty" }, \
+	{ FUSE_IOMAP_F_SHARED,			"shared" }, \
+	{ FUSE_IOMAP_F_MERGED,			"merged" }, \
+	{ FUSE_IOMAP_F_XATTR,			"xattr" }, \
+	{ FUSE_IOMAP_F_BOUNDARY,		"boundary" }, \
+	{ FUSE_IOMAP_F_ANON_WRITE,		"anon_write" }, \
+	{ FUSE_IOMAP_F_ATOMIC_BIO,		"atomic" }, \
+	{ FUSE_IOMAP_F_WANT_IOMAP_END,		"iomap_end" }, \
+	{ FUSE_IOMAP_F_SIZE_CHANGED,		"append" }, \
+	{ FUSE_IOMAP_F_STALE,			"stale" }
+
+#define FUSE_IOMAP_OP_STRINGS \
+	{ FUSE_IOMAP_OP_WRITE,			"write" }, \
+	{ FUSE_IOMAP_OP_ZERO,			"zero" }, \
+	{ FUSE_IOMAP_OP_REPORT,			"report" }, \
+	{ FUSE_IOMAP_OP_FAULT,			"fault" }, \
+	{ FUSE_IOMAP_OP_DIRECT,			"direct" }, \
+	{ FUSE_IOMAP_OP_NOWAIT,			"nowait" }, \
+	{ FUSE_IOMAP_OP_OVERWRITE_ONLY,		"overwrite" }, \
+	{ FUSE_IOMAP_OP_UNSHARE,		"unshare" }, \
+	{ FUSE_IOMAP_OP_ATOMIC,			"atomic" }, \
+	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }
+
+#define FUSE_IOMAP_TYPE_STRINGS \
+	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
+	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
+	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
+	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
+	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
+	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
+
+TRACE_EVENT(fuse_iomap_begin,
+	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
+		 unsigned opflags),
+
+	TP_ARGS(inode, pos, count, opflags),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		pos)
+		__field(loff_t,		count)
+		__field(unsigned,	opflags)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->pos		=	pos;
+		__entry->count		=	count;
+		__entry->opflags	=	opflags;
+	),
+
+	TP_printk("connection %u ino %llu opflags (%s) pos 0x%llx count 0x%llx",
+		  __entry->connection, __entry->ino,
+		  __print_flags(__entry->opflags, "|", FUSE_IOMAP_OP_STRINGS),
+		  __entry->pos, __entry->count)
+);
+
+TRACE_EVENT(fuse_iomap_begin_error,
+	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
+		 unsigned opflags, int error),
+
+	TP_ARGS(inode, pos, count, opflags, error),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		pos)
+		__field(loff_t,		count)
+		__field(unsigned,	opflags)
+		__field(int,		error)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->pos		=	pos;
+		__entry->count		=	count;
+		__entry->opflags	=	opflags;
+		__entry->error		=	error;
+	),
+
+	TP_printk("connection %u ino %llu opflags (%s) pos 0x%llx count 0x%llx err %d",
+		  __entry->connection, __entry->ino,
+		  __print_flags(__entry->opflags, "|", FUSE_IOMAP_OP_STRINGS),
+		  __entry->pos, __entry->count, __entry->error)
+);
+
+TRACE_EVENT(fuse_iomap_read_map,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_begin_out *outarg),
+
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		offset)
+		__field(loff_t,		length)
+		__field(uint32_t,	dev)
+		__field(uint64_t,	addr)
+		__field(uint16_t,	type)
+		__field(uint16_t,	mapflags)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->offset		=	outarg->offset;
+		__entry->length		=	outarg->length;
+		__entry->dev		=	outarg->read_dev;
+		__entry->addr		=	outarg->read_addr;
+		__entry->type		=	outarg->read_type;
+		__entry->mapflags	=	outarg->read_flags;
+	),
+
+	TP_printk("connection %u ino %llu read offset 0x%llx count 0x%llx dev %u addr 0x%llu type %s mapflags (%s)",
+		  __entry->connection, __entry->ino, __entry->offset,
+		  __entry->length, __entry->dev, __entry->addr,
+		  __print_symbolic(__entry->type, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->mapflags, "|", FUSE_IOMAP_F_STRINGS))
+);
+
+TRACE_EVENT(fuse_iomap_write_map,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_begin_out *outarg),
+
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		offset)
+		__field(loff_t,		length)
+		__field(uint32_t,	dev)
+		__field(uint64_t,	addr)
+		__field(uint16_t,	type)
+		__field(uint16_t,	mapflags)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->offset		=	outarg->offset;
+		__entry->length		=	outarg->length;
+		__entry->dev		=	outarg->write_dev;
+		__entry->addr		=	outarg->write_addr;
+		__entry->type		=	outarg->write_type;
+		__entry->mapflags	=	outarg->write_flags;
+	),
+
+	TP_printk("connection %u ino %llu write offset 0x%llx count 0x%llx dev %u addr 0x%llu type %s mapflags (%s)",
+		  __entry->connection, __entry->ino, __entry->offset,
+		  __entry->length, __entry->dev, __entry->addr,
+		  __print_symbolic(__entry->type, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->mapflags, "|", FUSE_IOMAP_F_STRINGS))
+);
+
+TRACE_EVENT(fuse_iomap_end,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_end_in *inarg),
+
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		pos)
+		__field(loff_t,		count)
+		__field(unsigned,	opflags)
+		__field(size_t,		written)
+
+		__field(uint32_t,	dev)
+		__field(uint64_t,	addr)
+		__field(uint16_t,	type)
+		__field(uint16_t,	mapflags)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->pos		=	inarg->pos;
+		__entry->count		=	inarg->count;
+		__entry->opflags	=	inarg->opflags;
+		__entry->written	=	inarg->written;
+		__entry->dev		=	inarg->map_dev;
+		__entry->addr		=	inarg->map_addr;
+		__entry->type		=	inarg->map_type;
+		__entry->mapflags	=	inarg->map_flags;
+	),
+
+	TP_printk("connection %u ino %llu opflags (%s) pos 0x%llx count 0x%llx written %zd dev %u addr 0x%llx type 0x%x mapflags (%s)",
+		  __entry->connection, __entry->ino,
+		  __print_flags(__entry->opflags, "|", FUSE_IOMAP_OP_STRINGS),
+		  __entry->pos, __entry->count, __entry->written, __entry->dev,
+		  __entry->addr, __entry->type,
+		  __print_flags(__entry->mapflags, "|", FUSE_IOMAP_F_STRINGS))
+);
+
+TRACE_EVENT(fuse_iomap_end_error,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_end_in *inarg, int error),
+
+	TP_ARGS(inode, inarg, error),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(loff_t,		pos)
+		__field(loff_t,		count)
+		__field(unsigned,	opflags)
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
+		__entry->pos		=	inarg->pos;
+		__entry->count		=	inarg->count;
+		__entry->opflags	=	inarg->opflags;
+		__entry->written	=	inarg->written;
+		__entry->error		=	error;
+	),
+
+	TP_printk("connection %u ino %llu opflags (%s) pos 0x%llx count 0x%llx written %zd error %d",
+		  __entry->connection, __entry->ino,
+		  __print_flags(__entry->opflags, "|", FUSE_IOMAP_OP_STRINGS),
+		  __entry->pos, __entry->count, __entry->written,
+		  __entry->error)
+);
+#endif /* CONFIG_FUSE_IOMAP */
+
 #endif /* _TRACE_FUSE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5ec43ecbceb783..ce6c9960f2418f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -232,6 +232,10 @@
  *
  *  7.43
  *  - add FUSE_REQUEST_TIMEOUT
+ *
+ *  7.44
+ *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
+ *    SEEK_{DATA,HOLE} support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -267,7 +271,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 43
+#define FUSE_KERNEL_MINOR_VERSION 44
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -440,6 +444,8 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
+ *	       operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -487,6 +493,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_IOMAP		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
@@ -655,6 +662,9 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_BEGIN	= 4094,
+	FUSE_IOMAP_END		= 4095,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -1286,4 +1296,79 @@ struct fuse_uring_cmd_req {
 	uint8_t padding[6];
 };
 
+#define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(0xFFFF) /* use read mapping data */
+#define FUSE_IOMAP_TYPE_HOLE		0	/* no blocks allocated, need allocation */
+#define FUSE_IOMAP_TYPE_DELALLOC	1	/* delayed allocation blocks */
+#define FUSE_IOMAP_TYPE_MAPPED		2	/* blocks allocated at @addr */
+#define FUSE_IOMAP_TYPE_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
+#define FUSE_IOMAP_TYPE_INLINE		4	/* data inline in the inode */
+
+#define FUSE_IOMAP_DEV_FUSEBLK		(0U)	/* fuseblk sb_dev device cookie */
+#define FUSE_IOMAP_DEV_NULL		(~0U)	/* null device cookie */
+
+#define FUSE_IOMAP_F_NEW		(1U << 0)
+#define FUSE_IOMAP_F_DIRTY		(1U << 1)
+#define FUSE_IOMAP_F_SHARED		(1U << 2)
+#define FUSE_IOMAP_F_MERGED		(1U << 3)
+#define FUSE_IOMAP_F_XATTR		(1U << 5)
+#define FUSE_IOMAP_F_BOUNDARY		(1U << 6)
+#define FUSE_IOMAP_F_ANON_WRITE		(1U << 7)
+#define FUSE_IOMAP_F_ATOMIC_BIO		(1U << 8)
+#define FUSE_IOMAP_F_WANT_IOMAP_END	(1U << 12) /* want ->iomap_end call */
+
+/* only for iomap_end */
+#define FUSE_IOMAP_F_SIZE_CHANGED	(1U << 14)
+#define FUSE_IOMAP_F_STALE		(1U << 15)
+
+#define FUSE_IOMAP_OP_WRITE		(1 << 0) /* writing, must allocate blocks */
+#define FUSE_IOMAP_OP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
+#define FUSE_IOMAP_OP_REPORT		(1 << 2) /* report extent status, e.g. FIEMAP */
+#define FUSE_IOMAP_OP_FAULT		(1 << 3) /* mapping for page fault */
+#define FUSE_IOMAP_OP_DIRECT		(1 << 4) /* direct I/O */
+#define FUSE_IOMAP_OP_NOWAIT		(1 << 5) /* do not block */
+#define FUSE_IOMAP_OP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
+#define FUSE_IOMAP_OP_UNSHARE		(1 << 7) /* unshare_file_range */
+#define FUSE_IOMAP_OP_ATOMIC		(1 << 9) /* torn-write protection */
+#define FUSE_IOMAP_OP_DONTCACHE		(1 << 10) /* dont retain pagecache */
+
+#define FUSE_IOMAP_NULL_ADDR		(-1ULL)	/* addr is not valid */
+
+struct fuse_iomap_begin_in {
+	uint32_t opflags;	/* FUSE_IOMAP_OP_* */
+	uint32_t reserved;	/* zero */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t count;		/* operation length, in bytes */
+};
+
+struct fuse_iomap_begin_out {
+	uint64_t offset;	/* file offset of mapping, bytes */
+	uint64_t length;	/* length of both mappings, bytes */
+
+	uint64_t read_addr;	/* disk offset of mapping, bytes */
+	uint16_t read_type;	/* FUSE_IOMAP_TYPE_* */
+	uint16_t read_flags;	/* FUSE_IOMAP_F_* */
+	uint32_t read_dev;	/* device cookie */
+
+	uint64_t write_addr;	/* disk offset of mapping, bytes */
+	uint16_t write_type;	/* FUSE_IOMAP_TYPE_* */
+	uint16_t write_flags;	/* FUSE_IOMAP_F_* */
+	uint32_t write_dev;	/* device cookie * */
+};
+
+struct fuse_iomap_end_in {
+	uint32_t opflags;	/* FUSE_IOMAP_OP_* */
+	uint32_t reserved;	/* zero */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t count;		/* operation length, in bytes */
+	int64_t written;	/* bytes processed */
+
+	uint64_t map_length;	/* length of mapping, bytes */
+	uint64_t map_addr;	/* disk offset of mapping, bytes */
+	uint16_t map_type;	/* FUSE_IOMAP_TYPE_* */
+	uint16_t map_flags;	/* FUSE_IOMAP_F_* */
+	uint32_t map_dev;	/* device cookie * */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index ca215a3cba3e31..fc7c5bf1cef52d 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -64,6 +64,29 @@ config FUSE_PASSTHROUGH
 
 	  If you want to allow passthrough operations, answer Y.
 
+config FUSE_IOMAP
+	bool "FUSE file IO over iomap"
+	default y
+	depends on FUSE_FS
+	select FS_IOMAP
+	help
+	  For supported fuseblk servers, this allows the file IO path to run
+	  through the kernel.
+
+config FUSE_IOMAP_BY_DEFAULT
+	bool "FUSE file I/O over iomap by default"
+	default n
+	depends on FUSE_IOMAP
+	help
+	  Enable sending FUSE file I/O over iomap by default.
+
+config FUSE_IOMAP_DEBUG
+	bool "Debug FUSE file IO over iomap"
+	default n
+	depends on FUSE_IOMAP
+	help
+	  Enable debugging assertions for the fuse iomap code paths.
+
 config FUSE_IO_URING
 	bool "FUSE communication over io-uring"
 	default y
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 3f0f312a31c1cc..63a41ef9336aaa 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -16,5 +16,6 @@ fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
+fuse-$(CONFIG_FUSE_IOMAP) += file_iomap.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
new file mode 100644
index 00000000000000..dfa0c309803113
--- /dev/null
+++ b/fs/fuse/file_iomap.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org.
+ */
+#include "fuse_i.h"
+#include "fuse_trace.h"
+#include <linux/iomap.h>
+
+static bool __read_mostly enable_iomap =
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
+	true;
+#else
+	false;
+#endif
+module_param(enable_iomap, bool, 0644);
+MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
+
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+# define ASSERT(a)	do { WARN_ON(!(a)); } while (0)
+#else
+# define ASSERT(a)
+#endif
+
+bool fuse_iomap_enabled(void)
+{
+	return enable_iomap;
+}
+
+static inline bool fuse_iomap_check_type(uint16_t type)
+{
+	BUILD_BUG_ON(FUSE_IOMAP_TYPE_HOLE	!= IOMAP_HOLE);
+	BUILD_BUG_ON(FUSE_IOMAP_TYPE_DELALLOC	!= IOMAP_DELALLOC);
+	BUILD_BUG_ON(FUSE_IOMAP_TYPE_MAPPED	!= IOMAP_MAPPED);
+	BUILD_BUG_ON(FUSE_IOMAP_TYPE_UNWRITTEN	!= IOMAP_UNWRITTEN);
+	BUILD_BUG_ON(FUSE_IOMAP_TYPE_INLINE	!= IOMAP_INLINE);
+
+	switch (type) {
+	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+	case FUSE_IOMAP_TYPE_HOLE:
+	case FUSE_IOMAP_TYPE_DELALLOC:
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+	case FUSE_IOMAP_TYPE_INLINE:
+		return true;
+	}
+
+	return false;
+}
+
+#define FUSE_IOMAP_F_ALL (FUSE_IOMAP_F_NEW | \
+			  FUSE_IOMAP_F_DIRTY | \
+			  FUSE_IOMAP_F_SHARED | \
+			  FUSE_IOMAP_F_MERGED | \
+			  FUSE_IOMAP_F_XATTR | \
+			  FUSE_IOMAP_F_BOUNDARY | \
+			  FUSE_IOMAP_F_ANON_WRITE | \
+			  FUSE_IOMAP_F_ATOMIC_BIO | \
+			  FUSE_IOMAP_F_WANT_IOMAP_END)
+
+static inline bool fuse_iomap_check_flags(uint16_t flags)
+{
+	BUILD_BUG_ON(FUSE_IOMAP_F_NEW		!= IOMAP_F_NEW);
+	BUILD_BUG_ON(FUSE_IOMAP_F_DIRTY		!= IOMAP_F_DIRTY);
+	BUILD_BUG_ON(FUSE_IOMAP_F_SHARED	!= IOMAP_F_SHARED);
+	BUILD_BUG_ON(FUSE_IOMAP_F_MERGED	!= IOMAP_F_MERGED);
+	BUILD_BUG_ON(FUSE_IOMAP_F_XATTR		!= IOMAP_F_XATTR);
+	BUILD_BUG_ON(FUSE_IOMAP_F_BOUNDARY	!= IOMAP_F_BOUNDARY);
+	BUILD_BUG_ON(FUSE_IOMAP_F_ANON_WRITE	!= IOMAP_F_ANON_WRITE);
+	BUILD_BUG_ON(FUSE_IOMAP_F_ATOMIC_BIO	!= IOMAP_F_ATOMIC_BIO);
+	BUILD_BUG_ON(FUSE_IOMAP_F_WANT_IOMAP_END != IOMAP_F_PRIVATE);
+
+	return (flags & ~FUSE_IOMAP_F_ALL) == 0;
+}
+
+/* Check the incoming mappings to make sure they're not nonsense */
+static inline int fuse_iomap_validate(const struct fuse_iomap_begin_out *outarg,
+				      unsigned opflags, loff_t pos)
+{
+	BUILD_BUG_ON(FUSE_IOMAP_OP_WRITE	!= IOMAP_WRITE);
+	BUILD_BUG_ON(FUSE_IOMAP_OP_ZERO		!= IOMAP_ZERO);
+	BUILD_BUG_ON(FUSE_IOMAP_OP_REPORT	!= IOMAP_REPORT);
+	BUILD_BUG_ON(FUSE_IOMAP_OP_FAULT	!= IOMAP_FAULT);
+	BUILD_BUG_ON(FUSE_IOMAP_OP_DIRECT	!= IOMAP_DIRECT);
+	BUILD_BUG_ON(FUSE_IOMAP_OP_NOWAIT	!= IOMAP_NOWAIT);
+	BUILD_BUG_ON(FUSE_IOMAP_OP_OVERWRITE_ONLY != IOMAP_OVERWRITE_ONLY);
+	BUILD_BUG_ON(FUSE_IOMAP_OP_UNSHARE	!= IOMAP_UNSHARE);
+	BUILD_BUG_ON(FUSE_IOMAP_OP_ATOMIC	!= IOMAP_ATOMIC);
+	BUILD_BUG_ON(FUSE_IOMAP_OP_DONTCACHE	!= IOMAP_DONTCACHE);
+
+	if (outarg->read_dev == FUSE_IOMAP_DEV_NULL) {
+		ASSERT(outarg->read_dev != FUSE_IOMAP_DEV_NULL);
+		return -EIO;
+	}
+	if (outarg->write_dev == FUSE_IOMAP_DEV_NULL) {
+		ASSERT(outarg->write_dev != FUSE_IOMAP_DEV_NULL);
+		return -EIO;
+	}
+	if (outarg->offset > pos) {
+		ASSERT(outarg->offset <= pos);
+		return -EIO;
+	}
+	if (outarg->length == 0) {
+		ASSERT(outarg->length != 0);
+		return -EIO;
+	}
+	if (outarg->offset + outarg->length <= pos) {
+		ASSERT(outarg->offset + outarg->length > pos);
+		return -EIO;
+	}
+	if (!fuse_iomap_check_type(outarg->write_type)) {
+		ASSERT(fuse_iomap_check_type(outarg->write_type));
+		return -EIO;
+	}
+	if (!fuse_iomap_check_flags(outarg->write_flags)) {
+		ASSERT(fuse_iomap_check_flags(outarg->write_flags));
+		return -EIO;
+	}
+	if (!fuse_iomap_check_type(outarg->read_type)) {
+		ASSERT(fuse_iomap_check_type(outarg->read_type));
+		return -EIO;
+	}
+	if (!fuse_iomap_check_flags(outarg->read_flags)) {
+		ASSERT(fuse_iomap_check_flags(outarg->read_flags));
+		return -EIO;
+	}
+
+	if (!(opflags & FUSE_IOMAP_OP_REPORT)) {
+		/*
+		 * XXX inline data reads and writes are not supported, how do
+		 * we do this?
+		 */
+		ASSERT(outarg->read_type != FUSE_IOMAP_TYPE_INLINE);
+		ASSERT(outarg->write_type != FUSE_IOMAP_TYPE_INLINE);
+
+		if (outarg->read_type == FUSE_IOMAP_TYPE_INLINE)
+			return -EIO;
+		if (outarg->write_type == FUSE_IOMAP_TYPE_INLINE)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
+			    unsigned opflags, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_iomap_begin_in inarg = {
+		.attr_ino = fi->orig_ino,
+		.opflags = opflags,
+		.pos = pos,
+		.count = count,
+	};
+	struct fuse_iomap_begin_out outarg = { };
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	int err;
+
+	trace_fuse_iomap_begin(inode, pos, count, opflags);
+
+	args.opcode = FUSE_IOMAP_BEGIN;
+	args.nodeid = get_node_id(inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(outarg);
+	args.out_args[0].value = &outarg;
+	err = fuse_simple_request(fm, &args);
+	if (err) {
+		trace_fuse_iomap_begin_error(inode, pos, count, opflags, err);
+		return err;
+	}
+
+	trace_fuse_iomap_read_map(inode, &outarg);
+	trace_fuse_iomap_write_map(inode, &outarg);
+
+	err = fuse_iomap_validate(&outarg, opflags, pos);
+	if (err)
+		return err;
+
+	if ((opflags & IOMAP_WRITE) &&
+	    outarg.write_type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+		/*
+		 * For an out of place write, we must supply the write mapping
+		 * via @iomap, and the read mapping via @srcmap.
+		 */
+		iomap->addr = outarg.write_addr;
+		iomap->offset = outarg.offset;
+		iomap->length = outarg.length;
+		iomap->type = outarg.write_type;
+		iomap->flags = outarg.write_flags;
+		iomap->bdev = inode->i_sb->s_bdev;
+
+		srcmap->addr = outarg.read_addr;
+		srcmap->offset = outarg.offset;
+		srcmap->length = outarg.length;
+		srcmap->type = outarg.read_type;
+		srcmap->flags = outarg.read_flags;
+		srcmap->bdev = inode->i_sb->s_bdev;
+	} else {
+		/*
+		 * For everything else (reads, reporting, and pure overwrites),
+		 * we can return the sole mapping through @iomap and leave
+		 * @srcmap unchanged from its default (HOLE).
+		 */
+		iomap->addr = outarg.read_addr;
+		iomap->offset = outarg.offset;
+		iomap->length = outarg.length;
+		iomap->type = outarg.read_type;
+		iomap->flags = outarg.read_flags;
+		iomap->bdev = inode->i_sb->s_bdev;
+	}
+
+	return 0;
+}
+
+static bool fuse_want_iomap_end(const struct iomap *iomap, unsigned int opflags,
+				loff_t count, ssize_t written)
+{
+	/* Caller demanded an iomap_end call. */
+	if (iomap->flags & FUSE_IOMAP_F_WANT_IOMAP_END)
+		return true;
+
+	/* Reads and reporting should never affect the filesystem metadata */
+	if (!(opflags & (IOMAP_WRITE | IOMAP_ZERO)))
+		return false;
+
+	/* Appending writes get an iomap_end call */
+	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
+		return true;
+
+	/* Short writes get an iomap_end call to clean up delalloc */
+	return written < count;
+}
+
+static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
+			  ssize_t written, unsigned opflags,
+			  struct iomap *iomap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_iomap_end_in inarg = {
+		.opflags = opflags,
+		.attr_ino = fi->orig_ino,
+		.pos = pos,
+		.count = count,
+		.written = written,
+
+		.map_addr = iomap->addr,
+		.map_length = iomap->length,
+		.map_type = iomap->type,
+		.map_flags = iomap->flags,
+	};
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	int err;
+
+	if (!fuse_want_iomap_end(iomap, opflags, count, written))
+		return 0;
+
+	trace_fuse_iomap_end(inode, &inarg);
+
+	args.opcode = FUSE_IOMAP_END;
+	args.nodeid = get_node_id(inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	err = fuse_simple_request(fm, &args);
+
+	trace_fuse_iomap_end_error(inode, &inarg, err);
+
+	return err;
+}
+
+const struct iomap_ops fuse_iomap_ops = {
+	.iomap_begin		= fuse_iomap_begin,
+	.iomap_end		= fuse_iomap_end,
+};
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd48e8d37f2edc..88730d26c9b5e2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1438,6 +1438,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
+
+			if ((flags & FUSE_IOMAP) && fuse_iomap_enabled())
+				fc->iomap = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1506,6 +1509,8 @@ void fuse_send_init(struct fuse_mount *fm)
 	 */
 	if (fuse_uring_enabled())
 		flags |= FUSE_OVER_IO_URING;
+	if (fuse_iomap_enabled())
+		flags |= FUSE_IOMAP;
 
 	ia->in.flags = flags;
 	ia->in.flags2 = flags >> 32;


