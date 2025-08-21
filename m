Return-Path: <linux-fsdevel+bounces-58478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054BAB2E9F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7687A176099
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068431DF97D;
	Thu, 21 Aug 2025 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTWRy59r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D34315A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738129; cv=none; b=D7saVnSLEuGBInwMw3lQv23PQmwFu/M0osd4ltEPXSd3YyLYZ3jNHEplVCpN4CjTljptVIJxViOFJarSuGtWjgyylKND6hZgRu9a9Mo31I+FOQaHQtgoJcUYI0hJJNE4hqumxprbaJ8fr5CHHpxqV1nZNmx01Hg0/Q8tigzZreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738129; c=relaxed/simple;
	bh=EqHnpa6A5780c19KK3Hh5ZyFye/YXQ8XoW/kFenuJXU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spfWo6sZfb5uUCNwKO1N19F85AUTQw4uGkwIWH8+xiRj/u40mZ9orxju+cQptk1BZ1NcKbglUExDCffqG4+Vi/S+ZIru6C4vqUnOU2OHvFd+qrvBvhOE97QC2TYHCpVLv0AqxZ1sow2hchTAGMP8m20uixe4/s0CJfpAqz6T/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTWRy59r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2AFC116B1;
	Thu, 21 Aug 2025 01:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738129;
	bh=EqHnpa6A5780c19KK3Hh5ZyFye/YXQ8XoW/kFenuJXU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lTWRy59r7ZdxJEt5rZQUcWwUaGz28gaT+gzfKmYNA5XvgNqa8CVssM3tkLVC2gHdx
	 NkOQLFJlGDIZuD7Cnl0ewzvmPI8pJb2ygE62BBHCAXfxNKozE1w73YxumwR5XAIW22
	 nULbpxUvAyFg9yCiJfddr5sJfO9VtMfUK6kbx7XoadBSEON2fs9ylWf9yLYVkzwz3h
	 8ezlwU6QzE+ezMZfP7UnSXACoN/0TrF3+YerHFG9Vh0VIjJzXqqOVArmEOJK25rEGA
	 EhfIR2W+cr+DS6TP+qIUWf5AY+JHH1PpJXiRSQHyH5WLOGKbiYE4faZhVROVmP5Uf2
	 YNRpqfa9Flz7Q==
Date: Wed, 20 Aug 2025 18:02:08 -0700
Subject: [PATCH 03/21] libfuse: add fuse commands for iomap_begin and end
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711338.19163.17584259312295034542.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Teach the low level API how to handle iomap begin and end commands that
we get from the kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |   68 +++++++++++++++++++++++++++++++
 include/fuse_kernel.h   |   40 ++++++++++++++++++
 include/fuse_lowlevel.h |   59 +++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |  102 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    3 +
 5 files changed, 272 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 8f87263d78f999..d10364a077f31d 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1145,7 +1145,75 @@ bool fuse_get_feature_flag(struct fuse_conn_info *conn, uint64_t flag);
  */
 int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
 
+/**
+ * iomap operations.
+ * These APIs are introduced in version 399 (FUSE_MAKE_VERSION(3, 99)).
+ */
 
+/* mapping types; see corresponding IOMAP_TYPE_ */
+#define FUSE_IOMAP_TYPE_HOLE		(0)
+#define FUSE_IOMAP_TYPE_DELALLOC	(1)
+#define FUSE_IOMAP_TYPE_MAPPED		(2)
+#define FUSE_IOMAP_TYPE_UNWRITTEN	(3)
+#define FUSE_IOMAP_TYPE_INLINE		(4)
+
+/* fuse-specific mapping type indicating that writes use the read mapping */
+#define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(255)
+
+#define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
+
+/* mapping flags passed back from iomap_begin; see corresponding IOMAP_F_ */
+#define FUSE_IOMAP_F_NEW		(1U << 0)
+#define FUSE_IOMAP_F_DIRTY		(1U << 1)
+#define FUSE_IOMAP_F_SHARED		(1U << 2)
+#define FUSE_IOMAP_F_MERGED		(1U << 3)
+#define FUSE_IOMAP_F_BOUNDARY		(1U << 4)
+#define FUSE_IOMAP_F_ANON_WRITE		(1U << 5)
+#define FUSE_IOMAP_F_ATOMIC_BIO		(1U << 6)
+
+/* fuse-specific mapping flag asking for ->iomap_end call */
+#define FUSE_IOMAP_F_WANT_IOMAP_END	(1U << 7)
+
+/* mapping flags passed to iomap_end */
+#define FUSE_IOMAP_F_SIZE_CHANGED	(1U << 8)
+#define FUSE_IOMAP_F_STALE		(1U << 9)
+
+/* operation flags from iomap; see corresponding IOMAP_* */
+#define FUSE_IOMAP_OP_WRITE		(1U << 0)
+#define FUSE_IOMAP_OP_ZERO		(1U << 1)
+#define FUSE_IOMAP_OP_REPORT		(1U << 2)
+#define FUSE_IOMAP_OP_FAULT		(1U << 3)
+#define FUSE_IOMAP_OP_DIRECT		(1U << 4)
+#define FUSE_IOMAP_OP_NOWAIT		(1U << 5)
+#define FUSE_IOMAP_OP_OVERWRITE_ONLY	(1U << 6)
+#define FUSE_IOMAP_OP_UNSHARE		(1U << 7)
+#define FUSE_IOMAP_OP_DAX		(1U << 8)
+#define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
+#define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
+
+#define FUSE_IOMAP_NULL_ADDR		(-1ULL)	/* addr is not valid */
+
+struct fuse_file_iomap {
+	uint64_t addr;		/* disk offset of mapping, bytes */
+	uint64_t offset;	/* file offset of mapping, bytes */
+	uint64_t length;	/* length of mapping, bytes */
+	uint16_t type;		/* FUSE_IOMAP_TYPE_* */
+	uint16_t flags;		/* FUSE_IOMAP_F_* */
+	uint32_t dev;		/* device cookie */
+};
+
+static inline bool fuse_iomap_is_write(unsigned int opflags)
+{
+	return opflags & (FUSE_IOMAP_OP_WRITE | FUSE_IOMAP_OP_ZERO |
+			  FUSE_IOMAP_OP_UNSHARE);
+}
+
+static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
+					const struct fuse_file_iomap *map)
+{
+	return map->type == FUSE_IOMAP_TYPE_HOLE &&
+		!(opflags & FUSE_IOMAP_OP_ZERO);
+}
 
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 6779b9c69bb9e2..2bcb3b394c0169 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -665,6 +665,9 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_BEGIN	= 4094,
+	FUSE_IOMAP_END		= 4095,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -1297,4 +1300,41 @@ struct fuse_uring_cmd_req {
 	uint8_t padding[6];
 };
 
+struct fuse_iomap_io {
+	uint64_t offset;	/* file offset of mapping, bytes */
+	uint64_t length;	/* length of mapping, bytes */
+	uint64_t addr;		/* disk offset of mapping, bytes */
+	uint16_t type;		/* FUSE_IOMAP_TYPE_* */
+	uint16_t flags;		/* FUSE_IOMAP_F_* */
+	uint32_t dev;		/* device cookie */
+};
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
+	/* read file data from here */
+	struct fuse_iomap_io	read;
+
+	/* write file data to here, if applicable */
+	struct fuse_iomap_io	write;
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
+	/* mapping that the kernel acted upon */
+	struct fuse_iomap_io	map;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 8d87be413bfe37..f9704533b5276d 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1342,6 +1342,43 @@ struct fuse_lowlevel_ops {
 	 */
 	void (*statx)(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
 		      struct fuse_file_info *fi);
+
+	/**
+	 * Fetch file I/O mappings to begin an operation
+	 *
+	 * Valid replies:
+	 *   fuse_reply_iomap_begin
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param nodeid the inode number
+	 * @param attr_ino inode number as told by fuse_attr::ino
+	 * @param pos position in file, in bytes
+	 * @param count length of operation, in bytes
+	 * @param opflags mask of FUSE_IOMAP_OP_ flags specifying operation
+	 */
+	void (*iomap_begin) (fuse_req_t req, fuse_ino_t nodeid,
+			     uint64_t attr_ino, off_t pos, uint64_t count,
+			     uint32_t opflags);
+
+	/**
+	 * Complete an iomap operation
+	 *
+	 * Valid replies:
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param nodeid the inode number
+	 * @param attr_ino inode number as told by fuse_attr::ino
+	 * @param pos position in file, in bytes
+	 * @param count length of operation, in bytes
+	 * @param written number of bytes processed, or a negative errno
+	 * @param opflags mask of FUSE_IOMAP_OP_ flags specifying operation
+	 * @param iomap file I/O mapping that was acted upon
+	 */
+	void (*iomap_end) (fuse_req_t req, fuse_ino_t nodeid, uint64_t attr_ino,
+			   off_t pos, uint64_t count, uint32_t opflags,
+			   ssize_t written, const struct fuse_file_iomap *iomap);
 };
 
 /**
@@ -1736,6 +1773,28 @@ int fuse_reply_lseek(fuse_req_t req, off_t off);
  */
 int fuse_reply_statx(fuse_req_t req, int flags, struct statx *statx, double attr_timeout);
 
+/**
+ * Set an iomap write mapping to be a pure overwrite of the read mapping.
+ * @param write mapping for file data writes
+ * @param read mapping for file data reads
+ */
+void fuse_iomap_pure_overwrite(struct fuse_file_iomap *write,
+			       const struct fuse_file_iomap *read);
+
+/**
+ * Reply with iomappings for an iomap_begin operation
+ *
+ * Possible requests:
+ *   iomap_begin
+ *
+ * @param req request handle
+ * @param read mapping for file data reads
+ * @param write mapping for file data writes
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_file_iomap *read,
+			   const struct fuse_file_iomap *write);
+
 /* ----------------------------------------------------------- *
  * Notification						       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 33c71ba216679c..c8106cb25a02d3 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2491,6 +2491,104 @@ static void do_statx(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 	_do_statx(req, nodeid, inarg, NULL);
 }
 
+void fuse_iomap_pure_overwrite(struct fuse_file_iomap *write,
+			       const struct fuse_file_iomap *read)
+{
+	write->addr = FUSE_IOMAP_NULL_ADDR;
+	write->offset = read->offset;
+	write->length = read->length;
+	write->type = FUSE_IOMAP_TYPE_PURE_OVERWRITE;
+	write->flags = 0;
+	write->dev = FUSE_IOMAP_DEV_NULL;
+}
+
+static inline void fuse_iomap_to_kernel(struct fuse_iomap_io *fmap,
+					const struct fuse_file_iomap *fimap)
+{
+	fmap->addr = fimap->addr;
+	fmap->offset = fimap->offset;
+	fmap->length = fimap->length;
+	fmap->type = fimap->type;
+	fmap->flags = fimap->flags;
+	fmap->dev = fimap->dev;
+}
+
+static inline void fuse_iomap_from_kernel(struct fuse_file_iomap *fimap,
+					  const struct fuse_iomap_io *fmap)
+{
+	fimap->addr = fmap->addr;
+	fimap->offset = fmap->offset;
+	fimap->length = fmap->length;
+	fimap->type = fmap->type;
+	fimap->flags = fmap->flags;
+	fimap->dev = fmap->dev;
+}
+
+int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_file_iomap *read,
+			   const struct fuse_file_iomap *write)
+{
+	struct fuse_iomap_begin_out arg = {
+		.write = {
+			.addr = FUSE_IOMAP_NULL_ADDR,
+			.offset = read->offset,
+			.length = read->length,
+			.type = FUSE_IOMAP_TYPE_PURE_OVERWRITE,
+			.flags = 0,
+			.dev = FUSE_IOMAP_DEV_NULL,
+		},
+	};
+
+	fuse_iomap_to_kernel(&arg.read, read);
+	if (write)
+		fuse_iomap_to_kernel(&arg.write, write);
+
+	return send_reply_ok(req, &arg, sizeof(arg));
+}
+
+static void _do_iomap_begin(fuse_req_t req, const fuse_ino_t nodeid,
+			    const void *op_in, const void *in_payload)
+{
+	const struct fuse_iomap_begin_in *arg = op_in;
+	(void)in_payload;
+	(void)nodeid;
+
+	if (req->se->op.iomap_begin)
+		req->se->op.iomap_begin(req, nodeid, arg->attr_ino, arg->pos,
+					arg->count, arg->opflags);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_iomap_begin(fuse_req_t req, const fuse_ino_t nodeid,
+			   const void *inarg)
+{
+	_do_iomap_begin(req, nodeid, inarg, NULL);
+}
+
+static void _do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
+			    const void *op_in, const void *in_payload)
+{
+	const struct fuse_iomap_end_in *arg = op_in;
+	(void)in_payload;
+	(void)nodeid;
+
+	if (req->se->op.iomap_end) {
+		struct fuse_file_iomap fimap;
+
+		fuse_iomap_from_kernel(&fimap, &arg->map);
+		req->se->op.iomap_end(req, nodeid, arg->attr_ino, arg->pos,
+				      arg->count, arg->opflags, arg->written,
+				      &fimap);
+	} else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
+			   const void *inarg)
+{
+	_do_iomap_end(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3376,6 +3474,8 @@ static struct {
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
+	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3431,6 +3531,8 @@ static struct {
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
+	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index ba8f3b00478b30..17c9e538a67bfa 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -218,6 +218,9 @@ FUSE_3.18 {
 } FUSE_3.17;
 
 FUSE_3.99 {
+	global:
+		fuse_iomap_pure_overwrite;
+		fuse_reply_iomap_begin;
 } FUSE_3.18;
 
 # Local Variables:


