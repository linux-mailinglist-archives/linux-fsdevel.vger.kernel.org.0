Return-Path: <linux-fsdevel+bounces-55334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED07B0981A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FF24A3C87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D585260590;
	Thu, 17 Jul 2025 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKPA4aED"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE82248AF
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795093; cv=none; b=JtTBxzGEtwbZgS5svIuq7hcJ/adXGBsRCyHlkLMK0kQvtPQakdDl2zDo8E/Vwl3cvelaMjd7LoNl+3QRaLKqgfrkvn/b7E6mtPP+i5JswnRWPi38c+kzFJeJBxCQjsm2QCvGPlPQk8nkra7mhMJ+ILg+yZj38wnQltJUAVItGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795093; c=relaxed/simple;
	bh=uUASekciC7laE3+r56iWnbgT9WXAu+yXM+VCxg9dETA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+DkHhk+UsmMoSXxP+Tvz95UkJK+/s5Bs7ZuQSU3XBtdFeJxTT6+bHm9zqiiQIcmlWP6kVRPgcyl09oZGBNRyktF8UOy+Sc04jrNGetB0Y+g/GG7VG5ztY9AfgYOhC1zY0d+cAxa3QiAZXyRmHoej89KTbr3wT/55iH0EyYXoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKPA4aED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B49C4CEE3;
	Thu, 17 Jul 2025 23:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795093;
	bh=uUASekciC7laE3+r56iWnbgT9WXAu+yXM+VCxg9dETA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bKPA4aEDh3f/FfwGlLeqoR8+rmp7MywZ5mStoNXNkrkNMlwBa6dGo3a2F8Hx/xPBV
	 sceevEQGX0FFFDC+uqftWNHULuaIvX64f/JjINIG7/LBthuKgZC9e4GUS87SLvWk30
	 TMhfAWKcVZAWpPiw6N+s4SjgE+7USV5nxcWOQelfBkO7brASHUgDpsoXrzbbsiIxnO
	 x/TliBxKhAsp+CAh/fqFVZDB9a1lp5Vqu9eTYWWd301Cm3JN5PphDcx/zUREO/Pf+9
	 ch6GVet6KE0XUXDNUlGWs2jRWusonF9G6xULJDR7IKgcRBTiBYPUcqDt+Q64Be1Eyt
	 qTec32ZqQXSBg==
Date: Thu, 17 Jul 2025 16:31:32 -0700
Subject: [PATCH 13/13] fuse: implement inline data file IO via iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450215.711291.8229131851095069469.stgit@frogsfrogsfrogs>
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

Implement inline data file IO by issuing FUSE_READ/FUSE_WRITE commands
in response to an inline data mapping.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   57 +++++++++++++++
 fs/fuse/file_iomap.c |  188 +++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 234 insertions(+), 11 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 0078a9ad2a2871..20257aed0cd89f 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1232,6 +1232,63 @@ TRACE_EVENT(fuse_iomap_config,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,
 		  __entry->uuid_len)
 );
+
+DECLARE_EVENT_CLASS(fuse_iomap_inline_class,
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count,
+		 const struct iomap *map),
+	TP_ARGS(inode, pos, count, map),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(loff_t,			isize)
+		__field(loff_t,			pos)
+		__field(uint64_t,		count)
+		__field(loff_t,			offset)
+		__field(uint64_t,		length)
+		__field(uint16_t,		maptype)
+		__field(uint16_t,		mapflags)
+		__field(bool,			has_buf)
+		__field(uint64_t,		validity_cookie)
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
+		__entry->pos		=	pos;
+		__entry->count		=	count;
+		__entry->offset		=	map->offset;
+		__entry->length		=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+		__entry->has_buf	=	map->inline_data != NULL;
+		__entry->validity_cookie=	map->validity_cookie;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx pos 0x%llx count 0x%llx offset 0x%llx length 0x%llx type %s mapflags (%s) has_buf? %d cookie 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __entry->pos, __entry->count,
+		  __entry->offset, __entry->length,
+		  __print_symbolic(__entry->maptype, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->mapflags, "|", FUSE_IOMAP_F_STRINGS),
+		  __entry->has_buf, __entry->validity_cookie)
+);
+#define DEFINE_FUSE_IOMAP_INLINE_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_inline_class, name,	\
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count, \
+		 const struct iomap *map), \
+	TP_ARGS(inode, pos, count, map))
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_read);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 3f6e0496c4744b..5ef9fa67db807e 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -201,17 +201,6 @@ fuse_iomap_begin_validate(const struct fuse_iomap_begin_out *outarg,
 	    BAD_DATA(check_add_overflow(outarg->write_addr, outarg->length, &end)))
 		return -EIO;
 
-	if (!(opflags & FUSE_IOMAP_OP_REPORT)) {
-		/*
-		 * XXX inline data reads and writes are not supported, how do
-		 * we do this?
-		 */
-		if (BAD_DATA(outarg->read_type == FUSE_IOMAP_TYPE_INLINE))
-			return -EIO;
-		if (BAD_DATA(outarg->write_type == FUSE_IOMAP_TYPE_INLINE))
-			return -EIO;
-	}
-
 	return 0;
 }
 
@@ -312,6 +301,157 @@ fuse_iomap_set_device(struct iomap *iomap, const struct fuse_iomap_dev *fb)
 	iomap->dax_dev = NULL;
 }
 
+static inline int fuse_iomap_inline_alloc(struct iomap *iomap)
+{
+	ASSERT(iomap->inline_data == NULL);
+	ASSERT(iomap->length > 0);
+
+	iomap->inline_data = kvzalloc(iomap->length, GFP_KERNEL);
+	return iomap->inline_data ? 0 : -ENOMEM;
+}
+
+static inline void fuse_iomap_inline_free(struct iomap *iomap)
+{
+	kvfree(iomap->inline_data);
+	iomap->inline_data = NULL;
+}
+
+/*
+ * Use the FUSE_READ command to read inline file data from the fuse server.
+ * Note that there's no file handle attached, so the fuse server must be able
+ * to reconnect to the inode via the nodeid.
+ */
+static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
+				  loff_t count, struct iomap *iomap)
+{
+	struct fuse_read_in in = {
+		.offset = pos,
+		.size = count,
+	};
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
+		return -EIO;
+
+	trace_fuse_iomap_inline_read(inode, pos, count, iomap);
+
+	args.opcode = FUSE_READ;
+	args.nodeid = fi->nodeid;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(in);
+	args.in_args[0].value = &in;
+	args.out_argvar = true;
+	args.out_numargs = 1;
+	args.out_args[0].size = count;
+	args.out_args[0].value = iomap_inline_data(iomap, pos);
+
+	ret = fuse_simple_request(fm, &args);
+	if (ret < 0) {
+		fuse_iomap_inline_free(iomap);
+		return ret;
+	}
+	/* no readahead means something bad happened */
+	if (ret == 0) {
+		fuse_iomap_inline_free(iomap);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * Use the FUSE_WRITE command to write inline file data from the fuse server.
+ * Note that there's no file handle attached, so the fuse server must be able
+ * to reconnect to the inode via the nodeid.
+ */
+static int fuse_iomap_inline_write(struct inode *inode, loff_t pos,
+				   loff_t count, struct iomap *iomap)
+{
+	struct fuse_write_in in = {
+		.offset = pos,
+		.size = count,
+	};
+	struct fuse_write_out out = { };
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
+		return -EIO;
+
+	trace_fuse_iomap_inline_write(inode, pos, count, iomap);
+
+	args.opcode = FUSE_WRITE;
+	args.nodeid = fi->nodeid;
+	args.in_numargs = 2;
+	args.in_args[0].size = sizeof(in);
+	args.in_args[0].value = &in;
+	args.in_args[1].size = count;
+	args.in_args[1].value = iomap_inline_data(iomap, pos);
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(out);
+	args.out_args[0].value = &out;
+
+	ret = fuse_simple_request(fm, &args);
+	if (ret < 0) {
+		fuse_iomap_inline_free(iomap);
+		return ret;
+	}
+	/* short write means something bad happened */
+	if (out.size < count) {
+		fuse_iomap_inline_free(iomap);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Set up inline data buffers for iomap_begin */
+static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
+				 loff_t pos, loff_t count,
+				 struct iomap *iomap, struct iomap *srcmap)
+{
+	int err;
+
+	if (opflags & FUSE_IOMAP_OP_REPORT)
+		return 0;
+
+	if (fuse_is_iomap_file_write(opflags)) {
+		if (iomap->type == IOMAP_INLINE) {
+			err = fuse_iomap_inline_alloc(iomap);
+			if (err)
+				return err;
+		}
+
+		if (srcmap->type == IOMAP_INLINE) {
+			err = fuse_iomap_inline_alloc(srcmap);
+			if (!err)
+				err = fuse_iomap_inline_read(inode, pos, count,
+							     srcmap);
+			if (err) {
+				fuse_iomap_inline_free(iomap);
+				return err;
+			}
+		}
+	} else if (iomap->type == IOMAP_INLINE) {
+		/* inline data read */
+		err = fuse_iomap_inline_alloc(iomap);
+		if (!err)
+			err = fuse_iomap_inline_read(inode, pos, count, iomap);
+		if (err)
+			return err;
+	}
+
+	trace_fuse_iomap_set_inline_iomap(inode, pos, count, iomap);
+	trace_fuse_iomap_set_inline_srcmap(inode, pos, count, srcmap);
+
+	return 0;
+}
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -399,12 +539,20 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		fuse_iomap_set_device(iomap, read_dev);
 	}
 
+	if (iomap->type == IOMAP_INLINE || srcmap->type == IOMAP_INLINE) {
+		err = fuse_iomap_set_inline(inode, opflags, pos, count, iomap,
+					    srcmap);
+		if (err)
+			goto out_write_dev;
+	}
+
 	/*
 	 * XXX: if we ever want to support closing devices, we need a way to 
 	 * track the fuse_iomap_dev refcount all the way through bio endios.
 	 * For now we put the refcount here because you can't remove an iomap
 	 * device until unmount time.
 	 */
+out_write_dev:
 	fuse_iomap_dev_put(write_dev);
 out_read_dev:
 	fuse_iomap_dev_put(read_dev);
@@ -448,9 +596,26 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 		.map_flags = iomap->flags,
 	};
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct iomap *srcmap = &iter->srcmap;
 	FUSE_ARGS(args);
 	int err;
 
+	if (srcmap->inline_data)
+		fuse_iomap_inline_free(srcmap);
+
+	if (iomap->inline_data) {
+		if (fuse_is_iomap_file_write(opflags) && written > 0) {
+			err = fuse_iomap_inline_write(inode, pos, written,
+						      iomap);
+			fuse_iomap_inline_free(iomap);
+			if (err)
+				goto out_err;
+		} else {
+			fuse_iomap_inline_free(iomap);
+		}
+	}
+
 	if (!fuse_want_iomap_end(iomap, opflags, count, written))
 		return 0;
 
@@ -463,6 +628,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	args.in_args[0].value = &inarg;
 	err = fuse_simple_request(fm, &args);
 
+out_err:
 	trace_fuse_iomap_end_error(inode, &inarg, err);
 
 	return err;


