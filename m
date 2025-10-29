Return-Path: <linux-fsdevel+bounces-66004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEDFC179CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 422D5355E1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3542D3EE4;
	Wed, 29 Oct 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWjgzupX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5111B85FD;
	Wed, 29 Oct 2025 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698729; cv=none; b=Qh/5IwjsZVPnvbYgQL8Y3ysBxjFUESNaVYuiequRzFyNYxbrQ/fxLS2b8KRqgYISVMhYYK6PHW5bBbZWwVc5rSeoBibqKv4NgwnME8kyT3Se8LAZLOSqLnctNMy4ToHHFDuG6ZQHB11n3Ui3lnWx0qTzYOnBT/VkBZl3bwNrthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698729; c=relaxed/simple;
	bh=JwhskwbZbvFEHY2euSGNWBdaJvRYGgGt9cVKARFKLWk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSvDvXjkSdGEzxROaJ9byc3flKi15M/4ElAqeY+eV4lTKoFZDa0xBOdZ+GneoL2xRn82+ldubipSJIBYVf//85Xdi/rXAwX73QNsh0WmZo7fjZ0/DoQC6QqbWX4r3wasmO9ZKjmPb5zj7DeIOr1KMtkI40vxrhqX3wlS4N3/gmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWjgzupX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B41C4CEE7;
	Wed, 29 Oct 2025 00:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698729;
	bh=JwhskwbZbvFEHY2euSGNWBdaJvRYGgGt9cVKARFKLWk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MWjgzupXRae1dDhycMxRgCHGCTy6BGWQBdrjvDyXyjZdB9P+rue4nYd/OhNziYjSf
	 20wELBR4CkuL0Ut1WOm7gF9ILjUXVcgwNyBvTKLc+IjBOWMRL9UZFVE1XOPgayrqWa
	 vZOaonMspgoZLN6Nw1Iap1fIOXMMQJ0+F72F53nTeIyfA5HfZA9kcGupniAGmJ/lIB
	 TXr0sX1JaGsHC2g/lBCILNnuIDNlN0N8NSwhUFHqTc91ascJ/ToHQZZ9aLA20LhCDv
	 anOsyEcSbuHne1lxhcIj638faywYvZIxZ6P/qN605SdHa+ZZ7iBGAk8LJGBQTxWAZh
	 5WedicVyaH+mA==
Date: Tue, 28 Oct 2025 17:45:28 -0700
Subject: [PATCH 02/31] fuse_trace: implement the basic iomap mechanisms
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810394.1424854.9157669895873356380.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |  295 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/iomap_i.h    |    6 +
 fs/fuse/file_iomap.c |   12 ++
 3 files changed, 312 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 286a0845dc0898..c0878253e7c6ad 100644
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
@@ -77,6 +79,54 @@ OPCODES
 #define EM(a, b)	{a, b},
 #define EMe(a, b)	{a, b}
 
+/* tracepoint boilerplate so we don't have to keep doing this */
+#define FUSE_INODE_FIELDS \
+		__field(dev_t,			connection) \
+		__field(uint64_t,		ino) \
+		__field(uint64_t,		nodeid) \
+		__field(loff_t,			isize)
+
+#define FUSE_INODE_ASSIGN(inode, fi, fm) \
+		const struct fuse_inode *fi = get_fuse_inode(inode); \
+		const struct fuse_mount *fm = get_fuse_mount(inode); \
+\
+		__entry->connection	=	(fm)->fc->dev; \
+		__entry->ino		=	(fi)->orig_ino; \
+		__entry->nodeid		=	(fi)->nodeid; \
+		__entry->isize		=	i_size_read(inode)
+
+#define FUSE_INODE_FMT \
+		"connection %u ino %llu nodeid %llu isize 0x%llx"
+
+#define FUSE_INODE_PRINTK_ARGS \
+		__entry->connection, \
+		__entry->ino, \
+		__entry->nodeid, \
+		__entry->isize
+
+#define FUSE_FILE_RANGE_FIELDS(prefix) \
+		__field(loff_t,			prefix##offset) \
+		__field(loff_t,			prefix##length)
+
+#define FUSE_FILE_RANGE_FMT(prefix) \
+		" " prefix "pos 0x%llx length 0x%llx"
+
+#define FUSE_FILE_RANGE_PRINTK_ARGS(prefix) \
+		__entry->prefix##offset, \
+		__entry->prefix##length
+
+/* combinations of boilerplate to reduce typing further */
+#define FUSE_IO_RANGE_FIELDS(prefix) \
+		FUSE_INODE_FIELDS \
+		FUSE_FILE_RANGE_FIELDS(prefix)
+
+#define FUSE_IO_RANGE_FMT(prefix) \
+		FUSE_INODE_FMT FUSE_FILE_RANGE_FMT(prefix)
+
+#define FUSE_IO_RANGE_PRINTK_ARGS(prefix) \
+		FUSE_INODE_PRINTK_ARGS, \
+		FUSE_FILE_RANGE_PRINTK_ARGS(prefix)
+
 TRACE_EVENT(fuse_request_send,
 	TP_PROTO(const struct fuse_req *req),
 
@@ -159,6 +209,251 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
 DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #endif /* CONFIG_FUSE_BACKING */
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP)
+
+/* tracepoint boilerplate so we don't have to keep doing this */
+#define FUSE_IOMAP_OPFLAGS_FIELD \
+		__field(unsigned,		opflags)
+
+#define FUSE_IOMAP_OPFLAGS_FMT \
+		" opflags (%s)"
+
+#define FUSE_IOMAP_OPFLAGS_PRINTK_ARG \
+		__print_flags(__entry->opflags, "|", FUSE_IOMAP_OP_STRINGS)
+
+#define FUSE_IOMAP_MAP_FIELDS(prefix) \
+		__field(uint64_t,		prefix##offset) \
+		__field(uint64_t,		prefix##length) \
+		__field(uint64_t,		prefix##addr) \
+		__field(uint32_t,		prefix##dev) \
+		__field(uint16_t,		prefix##type) \
+		__field(uint16_t,		prefix##flags)
+
+#define FUSE_IOMAP_MAP_FMT(prefix) \
+		" " prefix "offset 0x%llx length 0x%llx type %s dev %u addr 0x%llx mapflags (%s)"
+
+#define FUSE_IOMAP_MAP_PRINTK_ARGS(prefix) \
+		__entry->prefix##offset, \
+		__entry->prefix##length, \
+		__print_symbolic(__entry->prefix##type, FUSE_IOMAP_TYPE_STRINGS), \
+		__entry->prefix##dev, \
+		__entry->prefix##addr, \
+		__print_flags(__entry->prefix##flags, "|", FUSE_IOMAP_F_STRINGS)
+
+/* combinations of boilerplate to reduce typing further */
+#define FUSE_IOMAP_OP_FIELDS(prefix) \
+		FUSE_INODE_FIELDS \
+		FUSE_IOMAP_OPFLAGS_FIELD \
+		FUSE_FILE_RANGE_FIELDS(prefix)
+
+#define FUSE_IOMAP_OP_FMT(prefix) \
+		FUSE_INODE_FMT FUSE_IOMAP_OPFLAGS_FMT FUSE_FILE_RANGE_FMT(prefix)
+
+#define FUSE_IOMAP_OP_PRINTK_ARGS(prefix) \
+		FUSE_INODE_PRINTK_ARGS, \
+		FUSE_IOMAP_OPFLAGS_PRINTK_ARG, \
+		FUSE_FILE_RANGE_PRINTK_ARGS(prefix)
+
+/* string decoding */
+#define FUSE_IOMAP_F_STRINGS \
+	{ FUSE_IOMAP_F_NEW,			"new" }, \
+	{ FUSE_IOMAP_F_DIRTY,			"dirty" }, \
+	{ FUSE_IOMAP_F_SHARED,			"shared" }, \
+	{ FUSE_IOMAP_F_MERGED,			"merged" }, \
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
+	{ FUSE_IOMAP_OP_DAX,			"fsdax" }, \
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
+DECLARE_EVENT_CLASS(fuse_iomap_check_class,
+	TP_PROTO(const char *func, int line, const char *condition),
+
+	TP_ARGS(func, line, condition),
+
+	TP_STRUCT__entry(
+		__string(func,			func)
+		__field(int,			line)
+		__string(condition,		condition)
+	),
+
+	TP_fast_assign(
+		__assign_str(func);
+		__assign_str(condition);
+		__entry->line		=	line;
+	),
+
+	TP_printk("func %s line %d condition %s", __get_str(func),
+		  __entry->line, __get_str(condition))
+);
+#define DEFINE_FUSE_IOMAP_CHECK_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_check_class, name,	\
+	TP_PROTO(const char *func, int line, const char *condition), \
+	TP_ARGS(func, line, condition))
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+DEFINE_FUSE_IOMAP_CHECK_EVENT(fuse_iomap_assert);
+#endif
+DEFINE_FUSE_IOMAP_CHECK_EVENT(fuse_iomap_bad_data);
+
+TRACE_EVENT(fuse_iomap_begin,
+	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
+		 unsigned opflags),
+
+	TP_ARGS(inode, pos, count, opflags),
+
+	TP_STRUCT__entry(
+		FUSE_IOMAP_OP_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+		__entry->opflags	=	opflags;
+	),
+
+	TP_printk(FUSE_IOMAP_OP_FMT(),
+		  FUSE_IOMAP_OP_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_begin_error,
+	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
+		 unsigned opflags, int error),
+
+	TP_ARGS(inode, pos, count, opflags, error),
+
+	TP_STRUCT__entry(
+		FUSE_IOMAP_OP_FIELDS()
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+		__entry->opflags	=	opflags;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IOMAP_OP_FMT() " err %d",
+		  FUSE_IOMAP_OP_PRINTK_ARGS(),
+		  __entry->error)
+);
+
+DECLARE_EVENT_CLASS(fuse_iomap_mapping_class,
+	TP_PROTO(const struct inode *inode, const struct fuse_iomap_io *map),
+
+	TP_ARGS(inode, map),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		FUSE_IOMAP_MAP_FIELDS(map)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->mapdev		=	map->dev;
+		__entry->mapaddr	=	map->addr;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+	),
+
+	TP_printk(FUSE_INODE_FMT FUSE_IOMAP_MAP_FMT(),
+		  FUSE_INODE_PRINTK_ARGS,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map))
+);
+#define DEFINE_FUSE_IOMAP_MAPPING_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_mapping_class, name,	\
+	TP_PROTO(const struct inode *inode, const struct fuse_iomap_io *map), \
+	TP_ARGS(inode, map))
+DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iomap_read_map);
+DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iomap_write_map);
+
+TRACE_EVENT(fuse_iomap_end,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_end_in *inarg),
+
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_IOMAP_OP_FIELDS()
+		__field(size_t,			written)
+		FUSE_IOMAP_MAP_FIELDS(map)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->opflags	=	inarg->opflags;
+		__entry->written	=	inarg->written;
+		__entry->offset		=	inarg->pos;
+		__entry->length		=	inarg->count;
+
+		__entry->mapoffset	=	inarg->map.offset;
+		__entry->maplength	=	inarg->map.length;
+		__entry->mapdev		=	inarg->map.dev;
+		__entry->mapaddr	=	inarg->map.addr;
+		__entry->maptype	=	inarg->map.type;
+		__entry->mapflags	=	inarg->map.flags;
+	),
+
+	TP_printk(FUSE_IOMAP_OP_FMT() " written %zd" FUSE_IOMAP_MAP_FMT(),
+		  FUSE_IOMAP_OP_PRINTK_ARGS(),
+		  __entry->written,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map))
+);
+
+TRACE_EVENT(fuse_iomap_end_error,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_end_in *inarg, int error),
+
+	TP_ARGS(inode, inarg, error),
+
+	TP_STRUCT__entry(
+		FUSE_IOMAP_OP_FIELDS()
+		__field(size_t,			written)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	inarg->pos;
+		__entry->length		=	inarg->count;
+		__entry->opflags	=	inarg->opflags;
+		__entry->written	=	inarg->written;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IOMAP_OP_FMT() " written %zd error %d",
+		  FUSE_IOMAP_OP_PRINTK_ARGS(),
+		  __entry->written,
+		  __entry->error)
+);
+#endif /* CONFIG_FUSE_IOMAP */
+
 #endif /* _TRACE_FUSE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/fuse/iomap_i.h b/fs/fuse/iomap_i.h
index d773f728579d1d..6d9ce9c0f40a04 100644
--- a/fs/fuse/iomap_i.h
+++ b/fs/fuse/iomap_i.h
@@ -10,16 +10,22 @@
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
 # define ASSERT(condition) do {						\
 	int __cond = !!(condition);					\
+	if (unlikely(!__cond))						\
+		trace_fuse_iomap_assert(__func__, __LINE__, #condition); \
 	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
 } while (0)
 # define BAD_DATA(condition) ({						\
 	int __cond = !!(condition);					\
+	if (unlikely(__cond))						\
+		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
 	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
 })
 #else
 # define ASSERT(condition)
 # define BAD_DATA(condition) ({						\
 	int __cond = !!(condition);					\
+	if (unlikely(__cond))						\
+		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
 	unlikely(__cond);						\
 })
 #endif /* CONFIG_FUSE_IOMAP_DEBUG */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index d564d60d0f1779..a88f5d8d2bce15 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -327,6 +327,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	FUSE_ARGS(args);
 	int err;
 
+	trace_fuse_iomap_begin(inode, pos, count, opflags);
+
 	args.opcode = FUSE_IOMAP_BEGIN;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
@@ -336,8 +338,13 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
 	err = fuse_simple_request(fm, &args);
-	if (err)
+	if (err) {
+		trace_fuse_iomap_begin_error(inode, pos, count, opflags, err);
 		return err;
+	}
+
+	trace_fuse_iomap_read_map(inode, &outarg.read);
+	trace_fuse_iomap_write_map(inode, &outarg.write);
 
 	err = fuse_iomap_begin_validate(inode, opflags, pos, &outarg);
 	if (err)
@@ -404,6 +411,8 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 
 		fuse_iomap_to_server(&inarg.map, iomap);
 
+		trace_fuse_iomap_end(inode, &inarg);
+
 		args.opcode = FUSE_IOMAP_END;
 		args.nodeid = get_node_id(inode);
 		args.in_numargs = 1;
@@ -421,6 +430,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 		case 0:
 			break;
 		default:
+			trace_fuse_iomap_end_error(inode, &inarg, err);
 			break;
 		}
 	}


