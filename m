Return-Path: <linux-fsdevel+bounces-55332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB9EB09818
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D273A5483
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12042690ED;
	Thu, 17 Jul 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS++2BdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865F2451C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795062; cv=none; b=n5GC+suSvNJAZT2Ry74QDe7fkqMVXSNydl0lJN2l4O5ECKvm2bfJkD7wy7QOrYGkk+/iHChOKLaWpLvVwJU4Xs1x38Kl9Y8ORG677YJx/VuX1ZGlBNItvxV8uqVAYdA091AiuPK7PY2YmeHn7ri45QQ2pkSNYL5amShpjexvaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795062; c=relaxed/simple;
	bh=TcLybbdhWaoTL3fy+gsMg0L6r+W6o9oN+39bCSLKm1w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVZFJL70Qm5nFTwy+wc3QrEo4ihfPfzqT1TAQt9hxpdGsSa4p6EELRVMP1lhh2E+2YXwuk2wkpwIQFGVgFfSTqavP5EAE5Zk3Zg1iNVG3sLUYcHV9iJUtLIfVGEa6beaTy3r9JIGlPn6IiRjMtBD2bryZbIbmuPoNEPzMWEvmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS++2BdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14749C4CEE3;
	Thu, 17 Jul 2025 23:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795062;
	bh=TcLybbdhWaoTL3fy+gsMg0L6r+W6o9oN+39bCSLKm1w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pS++2BdWAGYDgCbTQPqEblwG2k5PhyU58nTbZK2ClUOmqtI5B46uhbxZg0TociW9Q
	 3skF+aOgb3lGcc4Mpu4s0hh9RGtqxRxlVfWq8UWASHGRGJ+TP27tLaTy5Dnr9qmDAF
	 aqXHxPEQfRHTsDkvBeEESH5FvvcHrI4/V00Iblj9nNWY7Y6ny7FPNmubO7jbluqUlP
	 RdKby+O23KShl/aplZbAyLcqog+ux8Esx8F4gdRF3gidUlYNEcW5WPLPqClkFZkm3d
	 +n+dFoVfCBlMF9EILbUSdxsT1K+oWK3QBUA7kRoUk1+Cx8+KC4+Wynt0ZIMXN7iJU7
	 QrZ1mDVcPHYyA==
Date: Thu, 17 Jul 2025 16:31:01 -0700
Subject: [PATCH 11/13] fuse: query filesystem geometry when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450173.711291.4593676996499991502.stgit@frogsfrogsfrogs>
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

Add a new upcall to the fuse server so that the kernel can request
filesystem geometry bits when iomap mode is in use.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h      |   48 +++++++++++++++++++++++
 include/uapi/linux/fuse.h |   38 +++++++++++++++++++
 fs/fuse/file_iomap.c      |   92 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 5d9b5a4e93fca5..0078a9ad2a2871 100644
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
@@ -198,6 +199,14 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP_FILEIO);
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
 TRACE_EVENT(fuse_iomap_begin,
 	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
 		 unsigned opflags),
@@ -1184,6 +1193,45 @@ TRACE_EVENT(fuse_iomap_fallocate,
 		  __entry->isize, __entry->mode, __entry->offset,
 		  __entry->length, __entry->newsize)
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
index cd484de60a7c09..2aac5a0c4cef0a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -242,6 +242,7 @@
  *  - add FUSE_DEV_IOC_IOMAP_DEV_ADD to configure block devices for iomap
  *  - add FUSE_IOMAP_DIRECTIO/FUSE_ATTR_IOMAP_DIRECTIO for direct I/O support
  *  - add FUSE_IOMAP_FILEIO/FUSE_ATTR_IOMAP_FILEIO for buffered I/O support
+ *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  */
 
 #ifndef _LINUX_FUSE_H
@@ -676,6 +677,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
@@ -1424,4 +1426,40 @@ struct fuse_iomap_ioend_in {
 	uint32_t reserved1;	/* zero */
 };
 
+struct fuse_iomap_config_in {
+	uint64_t flags;		/* zero for now */
+	int64_t maxbytes;	/* maximum supported file size */
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
index 673647ddda0ccd..5253f7ef88c110 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -575,12 +575,104 @@ static struct fuse_iomap_dev *fuse_iomap_dev_alloc(struct file *file)
 	return fb;
 }
 
+#define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_SID | \
+			       FUSE_IOMAP_CONFIG_UUID | \
+			       FUSE_IOMAP_CONFIG_BLOCKSIZE | \
+			       FUSE_IOMAP_CONFIG_MAX_LINKS | \
+			       FUSE_IOMAP_CONFIG_TIME | \
+			       FUSE_IOMAP_CONFIG_MAXBYTES)
+
+static int fuse_iomap_config(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_in inarg = {
+		.maxbytes = MAX_LFS_FILESIZE,
+	};
+	struct fuse_iomap_config_out outarg = { };
+	FUSE_ARGS(args);
+	struct super_block *sb = fm->sb;
+	int err;
+
+	args.opcode = FUSE_IOMAP_CONFIG;
+	args.nodeid = 0;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(outarg);
+	args.out_args[0].value = &outarg;
+	args.force = true;
+	args.nocreds = true;
+	err = fuse_simple_request(fm, &args);
+	if (err == -ENOSYS)
+		return 0;
+	if (err)
+		return err;
+
+	trace_fuse_iomap_config(fm, &outarg);
+
+	if (outarg.flags & ~FUSE_IOMAP_CONFIG_ALL)
+		return -EINVAL;
+
+	if (outarg.s_uuid_len > sizeof(outarg.s_uuid))
+		return -EINVAL;
+
+	if (memchr_inv(outarg.s_pad, 0, sizeof(outarg.s_pad)))
+		return -EINVAL;
+
+	if (outarg.flags & FUSE_IOMAP_CONFIG_BLOCKSIZE) {
+		if (sb->s_bdev) {
+#ifdef CONFIG_BLOCK
+			if (!sb_set_blocksize(sb, outarg.s_blocksize))
+				return -EINVAL;
+#else
+			/*
+			 * XXX: how do we have a bdev filesystem without
+			 * CONFIG_BLOCK???
+			 */
+			return -EINVAL;
+#endif
+		} else {
+			sb->s_blocksize = outarg.s_blocksize;
+			sb->s_blocksize_bits = blksize_bits(outarg.s_blocksize);
+		}
+	}
+
+	if (outarg.flags & FUSE_IOMAP_CONFIG_SID)
+		memcpy(sb->s_id, outarg.s_id, sizeof(sb->s_id));
+
+	if (outarg.flags & FUSE_IOMAP_CONFIG_UUID) {
+		memcpy(&sb->s_uuid, outarg.s_uuid, outarg.s_uuid_len);
+		sb->s_uuid_len = outarg.s_uuid_len;
+	}
+
+	if (outarg.flags & FUSE_IOMAP_CONFIG_MAX_LINKS)
+		sb->s_max_links = outarg.s_max_links;
+
+	if (outarg.flags & FUSE_IOMAP_CONFIG_TIME) {
+		sb->s_time_gran = outarg.s_time_gran;
+		sb->s_time_min = outarg.s_time_min;
+		sb->s_time_max = outarg.s_time_max;
+	}
+
+	if (outarg.flags & FUSE_IOMAP_CONFIG_MAXBYTES)
+		sb->s_maxbytes = outarg.s_maxbytes;
+
+	return 0;
+}
+
 bool fuse_iomap_fill_super(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct super_block *sb = fm->sb;
 	int res;
 
+	res = fuse_iomap_config(fm);
+	if (res) {
+		printk(KERN_ERR "%s: could not configure iomap, err=%d",
+		       sb->s_id, res);
+		return false;
+	}
+
 	if (sb->s_bdev) {
 		/*
 		 * Try to install s_bdev as the first iomap device, if this


