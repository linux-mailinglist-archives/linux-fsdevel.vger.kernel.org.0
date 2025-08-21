Return-Path: <linux-fsdevel+bounces-58456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E527B2E9D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB2E5624D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888E1E493C;
	Thu, 21 Aug 2025 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjVS7drW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E81804A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737785; cv=none; b=EzFq/duwjsraytc/aukMc+zTwrAS0vPlqFpr7Dr/f266r4a6C3vNbXJRg3OqXzmEPEcpkrONnUrriIIfMjCxaSZnSDq2Y6ScRFwCZVZKfoY0UCE/9pxrASrEdQssTtKVk24MCEKfJqmUO4zlJvUU2cZFMdZ0WGN+YCV1wrzoJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737785; c=relaxed/simple;
	bh=9sWX0m6rmnOg7of5YdLjlqnzXvUAN8JDGho/wF1P+c0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIKYSCkDqphqlqpLiDFS4KYGTmHRNhmsOLXOGFmqDZjXHqocApMWKfuZNzZDoi+rir5/1z8xdvjVdCd4sCDMZssfBeT/OGgMylNbpsLjLy8B0Gsw+zc3RAP30XP69imIcYusC/ZATliYGQVXDP7r0RO1w9kOPH/ymBM84WiBYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjVS7drW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DCBC4CEE7;
	Thu, 21 Aug 2025 00:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737785;
	bh=9sWX0m6rmnOg7of5YdLjlqnzXvUAN8JDGho/wF1P+c0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MjVS7drWr9ZFfBkat8xCpFyz+9SaJ4KjNwD6WlmWvzDbz6pA+W9+2dd6Sk6KSvmwL
	 C8OXD4TOfcChR3wKQrvjbfskWcTd++bXe0+35NhEcZyaUx5oBElsVq6GLe9ML0UjV4
	 LJc04qUSceFymZ+m0zHztxnn3yNk5tpGNBni83XhNxvbDk9W63m/NQO2ctnhoBGm3E
	 T84wRNAi5wUg+Dh0l0CnpKwIEr5FltIFOZRRUO92eQJlMjMzwp8SFKcBeiWWGSJLrw
	 VFvh3KYjteXnOCNXKv4YRDO2tP2xbdADmmTct5sSZlY5qimAHADL0WogPV686Q2DJX
	 1xDRyR4a5F6JA==
Date: Wed, 20 Aug 2025 17:56:24 -0700
Subject: [PATCH 15/23] fuse: query filesystem geometry when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709438.17510.8853745697831634820.stgit@frogsfrogsfrogs>
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

Add a new upcall to the fuse server so that the kernel can request
filesystem geometry bits when iomap mode is in use.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    4 +
 fs/fuse/fuse_trace.h      |   48 ++++++++++++++++++
 include/uapi/linux/fuse.h |   39 ++++++++++++++
 fs/fuse/file_iomap.c      |  122 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   26 +++++++---
 5 files changed, 231 insertions(+), 8 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5380a220741014..2572eab6100fe4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -999,6 +999,9 @@ struct fuse_conn {
 	struct fuse_ring *ring;
 #endif
 
+	/** How many subsystems still need initialization? */
+	atomic_t need_init;
+
 	/** Only used if the connection opts into request timeouts */
 	struct {
 		/* Worker for checking if any requests have timed out */
@@ -1366,6 +1369,7 @@ struct fuse_dev *fuse_dev_alloc(void);
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
 void fuse_send_init(struct fuse_mount *fm);
+void fuse_finish_init(struct fuse_conn *fc, bool ok);
 
 /**
  * Fill in superblock and initialize fuse connection
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 10537a38b54556..d3a0bd066370f5 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -58,6 +58,7 @@
 	EM( FUSE_SYNCFS,		"FUSE_SYNCFS")		\
 	EM( FUSE_TMPFILE,		"FUSE_TMPFILE")		\
 	EM( FUSE_STATX,			"FUSE_STATX")		\
+	EM( FUSE_IOMAP_CONFIG,		"FUSE_IOMAP_CONFIG")	\
 	EM( FUSE_IOMAP_BEGIN,		"FUSE_IOMAP_BEGIN")	\
 	EM( FUSE_IOMAP_END,		"FUSE_IOMAP_END")	\
 	EM( FUSE_IOMAP_IOEND,		"FUSE_IOMAP_IOEND")	\
@@ -345,6 +346,14 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ IOMAP_IOEND_BOUNDARY,			"boundary" }, \
 	{ IOMAP_IOEND_DIRECT,			"direct" }
 
+#define FUSE_IOMAP_CONFIG_STRINGS \
+	{ FUSE_IOMAP_CONFIG_SID,		"sid" }, \
+	{ FUSE_IOMAP_CONFIG_UUID,		"uuid" }, \
+	{ FUSE_IOMAP_CONFIG_BLOCKSIZE,		"blocksize" }, \
+	{ FUSE_IOMAP_CONFIG_MAX_LINKS,		"max_links" }, \
+	{ FUSE_IOMAP_CONFIG_TIME,		"time" }, \
+	{ FUSE_IOMAP_CONFIG_MAXBYTES,		"maxbytes" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -995,6 +1004,45 @@ TRACE_EVENT(fuse_iomap_fallocate,
 		  __entry->mode,
 		  __entry->newsize)
 );
+
+TRACE_EVENT(fuse_iomap_config,
+	TP_PROTO(const struct fuse_mount *fm,
+		 const struct fuse_iomap_config_out *outarg),
+	TP_ARGS(fm, outarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+
+		__field(uint32_t,		flags)
+		__field(uint32_t,		blocksize)
+		__field(uint32_t,		max_links)
+		__field(uint32_t,		time_gran)
+
+		__field(int64_t,		time_min)
+		__field(int64_t,		time_max)
+		__field(int64_t,		maxbytes)
+		__field(uint8_t,		uuid_len)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fm->fc->dev;
+		__entry->flags		=	outarg->flags;
+		__entry->blocksize	=	outarg->s_blocksize;
+		__entry->max_links	=	outarg->s_max_links;
+		__entry->time_gran	=	outarg->s_time_gran;
+		__entry->time_min	=	outarg->s_time_min;
+		__entry->time_max	=	outarg->s_time_max;
+		__entry->maxbytes	=	outarg->s_maxbytes;
+		__entry->uuid_len	=	outarg->s_uuid_len;
+	),
+
+	TP_printk("connection %u flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
+		  __entry->connection,
+		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
+		  __entry->blocksize, __entry->max_links, __entry->time_gran,
+		  __entry->time_min, __entry->time_max, __entry->maxbytes,
+		  __entry->uuid_len)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d0f71136837068..1a677e807c2846 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -240,6 +240,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
  *    SEEK_{DATA,HOLE}, buffered I/O, and direct I/O
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
+ *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  */
 
 #ifndef _LINUX_FUSE_H
@@ -668,6 +669,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
@@ -1414,4 +1416,41 @@ struct fuse_iomap_ioend_in {
 	uint32_t reserved1;	/* zero */
 };
 
+struct fuse_iomap_config_in {
+	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
+	int64_t maxbytes;	/* maximum supported file size */
+	uint64_t padding[6];	/* zero */
+};
+
+/* Which fields are set in fuse_iomap_config_out? */
+#define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
+#define FUSE_IOMAP_CONFIG_UUID		(1 << 1ULL)
+#define FUSE_IOMAP_CONFIG_BLOCKSIZE	(1 << 2ULL)
+#define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
+#define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
+#define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
+
+struct fuse_iomap_config_out {
+	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
+
+	char s_id[32];		/* Informational name */
+	char s_uuid[16];	/* UUID */
+
+	uint8_t s_uuid_len;	/* length of s_uuid */
+
+	uint8_t s_pad[3];	/* must be zeroes */
+
+	uint32_t s_blocksize;	/* fs block size */
+	uint32_t s_max_links;	/* max hard links */
+
+	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
+	uint32_t s_time_gran;
+
+	/* Time limits for c/m/atime in seconds */
+	int64_t s_time_min;
+	int64_t s_time_max;
+
+	int64_t s_maxbytes;	/* max file size */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 5a2910919ba209..d2b918521b7395 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -696,14 +696,105 @@ int fuse_iomap_backing_close(struct fuse_conn *fc, struct fuse_backing *fb)
 	return -EBUSY;
 }
 
-void fuse_iomap_mount(struct fuse_mount *fm)
+struct fuse_iomap_config_args {
+	struct fuse_args args;
+	struct fuse_iomap_config_in inarg;
+	struct fuse_iomap_config_out outarg;
+};
+
+#define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_SID | \
+			       FUSE_IOMAP_CONFIG_UUID | \
+			       FUSE_IOMAP_CONFIG_BLOCKSIZE | \
+			       FUSE_IOMAP_CONFIG_MAX_LINKS | \
+			       FUSE_IOMAP_CONFIG_TIME | \
+			       FUSE_IOMAP_CONFIG_MAXBYTES)
+
+static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
+				     const struct fuse_iomap_config_out *outarg)
 {
+	struct super_block *sb = fm->sb;
+
+	switch (error) {
+	case 0:
+		break;
+	case -ENOSYS:
+		return 0;
+	default:
+		return error;
+	}
+
+	trace_fuse_iomap_config(fm, outarg);
+
+	if (outarg->flags & ~FUSE_IOMAP_CONFIG_ALL)
+		return -EINVAL;
+
+	if (outarg->s_uuid_len > sizeof(outarg->s_uuid))
+		return -EINVAL;
+
+	if (memchr_inv(outarg->s_pad, 0, sizeof(outarg->s_pad)))
+		return -EINVAL;
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_BLOCKSIZE) {
+		if (sb->s_bdev) {
+#ifdef CONFIG_BLOCK
+			if (!sb_set_blocksize(sb, outarg->s_blocksize))
+				return -EINVAL;
+#else
+			/*
+			 * XXX: how do we have a bdev filesystem without
+			 * CONFIG_BLOCK???
+			 */
+			return -EINVAL;
+#endif
+		} else {
+			sb->s_blocksize = outarg->s_blocksize;
+			sb->s_blocksize_bits = blksize_bits(outarg->s_blocksize);
+		}
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_SID)
+		memcpy(sb->s_id, outarg->s_id, sizeof(sb->s_id));
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_UUID) {
+		memcpy(&sb->s_uuid, outarg->s_uuid, outarg->s_uuid_len);
+		sb->s_uuid_len = outarg->s_uuid_len;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_MAX_LINKS)
+		sb->s_max_links = outarg->s_max_links;
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_TIME) {
+		sb->s_time_gran = outarg->s_time_gran;
+		sb->s_time_min = outarg->s_time_min;
+		sb->s_time_max = outarg->s_time_max;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
+		sb->s_maxbytes = outarg->s_maxbytes;
+
+	return 0;
+}
+
+static void fuse_iomap_config_reply(struct fuse_mount *fm,
+				    struct fuse_args *args, int error)
+{
+	struct fuse_iomap_config_args *ia =
+		container_of(args, struct fuse_iomap_config_args, args);
 	struct fuse_conn *fc = fm->fc;
 	struct super_block *sb = fm->sb;
 	struct backing_dev_info *old_bdi = sb->s_bdi;
 	char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
+	bool ok = true;
 	int res;
 
+	res = fuse_iomap_process_config(fm, error, &ia->outarg);
+	if (res) {
+		printk(KERN_ERR "%s: could not configure iomap, err=%d",
+		       sb->s_id, res);
+		ok = false;
+		goto done;
+	}
+
 	/*
 	 * sb->s_bdi points to the initial private bdi.  However, we want to
 	 * redirect it to a new private bdi with default dirty and readahead
@@ -729,6 +820,35 @@ void fuse_iomap_mount(struct fuse_mount *fm)
 	fc->sync_fs = true;
 	fc->iomap_conn.no_end = 0;
 	fc->iomap_conn.no_ioend = 0;
+
+done:
+	kfree(ia);
+	fuse_finish_init(fc, ok);
+}
+
+void fuse_iomap_mount(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_args *ia;
+
+	ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
+	ia->inarg.maxbytes = MAX_LFS_FILESIZE;
+	ia->inarg.flags = FUSE_IOMAP_CONFIG_ALL;
+
+	ia->args.opcode = FUSE_IOMAP_CONFIG;
+	ia->args.nodeid = 0;
+	ia->args.in_numargs = 1;
+	ia->args.in_args[0].size = sizeof(ia->inarg);
+	ia->args.in_args[0].value = &ia->inarg;
+	ia->args.out_argvar = true;
+	ia->args.out_numargs = 1;
+	ia->args.out_args[0].size = sizeof(ia->outarg);
+	ia->args.out_args[0].value = &ia->outarg;
+	ia->args.force = true;
+	ia->args.nocreds = true;
+	ia->args.end = fuse_iomap_config_reply;
+
+	if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
+		fuse_iomap_config_reply(fm, &ia->args, -ENOTCONN);
 }
 
 void fuse_iomap_unmount(struct fuse_mount *fm)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b08b1961d03b3e..abb2beef3cfe1f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1323,6 +1323,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_init_out *arg = &ia->out;
 	bool ok = true;
 
+	atomic_inc(&fc->need_init);
+
 	if (error || arg->major != FUSE_KERNEL_VERSION)
 		ok = false;
 	else {
@@ -1466,9 +1468,6 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 		init_server_timeout(fc, timeout);
 
-		if (fc->iomap)
-			fuse_iomap_mount(fm);
-
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
@@ -1478,13 +1477,26 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	}
 	kfree(ia);
 
-	if (!ok) {
+	if (!ok)
 		fc->conn_init = 0;
+
+	if (ok && fc->iomap) {
+		atomic_inc(&fc->need_init);
+		fuse_iomap_mount(fm);
+	}
+
+	fuse_finish_init(fc, ok);
+}
+
+void fuse_finish_init(struct fuse_conn *fc, bool ok)
+{
+	if (!ok)
 		fc->conn_error = 1;
-	}
 
-	fuse_set_initialized(fc);
-	wake_up_all(&fc->blocked_waitq);
+	if (atomic_dec_and_test(&fc->need_init)) {
+		fuse_set_initialized(fc);
+		wake_up_all(&fc->blocked_waitq);
+	}
 }
 
 void fuse_send_init(struct fuse_mount *fm)


