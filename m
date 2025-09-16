Return-Path: <linux-fsdevel+bounces-61563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2003B589EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5CB3A72E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938931A3172;
	Tue, 16 Sep 2025 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOaE7T3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2671E571
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983355; cv=none; b=CYjRpIDE9Purukvs/AKWjYtNwiRXPn/nXy4BxCe1vJ/XEwELmpG/0opwYggx6DdWETpErzwmwkF9arqBMtGte6CaxC/4pE4gwxMd9MWqOxE5VCpG9nsDvqfDriM00u+5S8fhokqq1kZwHOylTjNa7qy1PNbus5qkOzDiiYv29ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983355; c=relaxed/simple;
	bh=csTesimoBYLAqLRqXLvyAxXx9ClFnsAgQklFXvHUY1M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftyjL9R6puP9PjMOdBhoKQsXHzJslnqRWHz9zbHKlncnkE49WyYhH0nS2pNd1M82DFboJfI7jfw33aDvEdoccRPCwiSApl+p+fFum6OUTFr9Tk5E8/TpQzZ89cqekfdsEBBmVDKALGfOhNjVOT776wWZ93n+7z0FhMmlu3cS44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOaE7T3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AC2C4CEF1;
	Tue, 16 Sep 2025 00:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983354;
	bh=csTesimoBYLAqLRqXLvyAxXx9ClFnsAgQklFXvHUY1M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SOaE7T3zdSxtwjz8FzmCnQ3Bb1ffqsx6PKt9mn5nMlfHnjQrDG58bz+9V4t0cCrWr
	 NqF6dDoxhSDWI+PrlkxfXkxyASiXkVa1nbbAHkr3VM5zLLDhn3Q9RrbEL2LrdpPF5r
	 yJS6X4hgVof8VZeH+H2R8Rrn+CpHsThjrvBpis3fDeNzuQvsexh9Jvv+rqCYo+Is/B
	 Yikxl41H6I6a4A2BnzCsovdKaHC4Bz4WhLBTYQ8XPlXfUdrGeLXORwtJfZR9E0q4xn
	 4zPll8RLaLycl1XCieULyjmw1vB+b7w6nTudH5Dw1T3dOGj9dvKJyu8/dwbeTlEvej
	 6Zz3NVOaAerGw==
Date: Mon, 15 Sep 2025 17:42:34 -0700
Subject: [PATCH 03/18] libfuse: add fuse commands for iomap_begin and end
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154566.386924.579122178634923775.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
References: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
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
 include/fuse_common.h   |   71 +++++++++++++++++++++++++++++++++
 include/fuse_kernel.h   |   40 ++++++++++++++++++
 include/fuse_lowlevel.h |   59 +++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |  102 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    3 +
 5 files changed, 275 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 9d53354de78868..12b951039f0a67 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1135,7 +1135,78 @@ bool fuse_get_feature_flag(struct fuse_conn_info *conn, uint64_t flag);
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
+/* pagecache writeback operation */
+#define FUSE_IOMAP_OP_WRITEBACK		(1U << 31)
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
+			  FUSE_IOMAP_OP_UNSHARE | FUSE_IOMAP_OP_WRITEBACK);
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
index cfa71dab28fdde..111aef43e17245 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -663,6 +663,9 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_BEGIN	= 4094,
+	FUSE_IOMAP_END		= 4095,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -1295,4 +1298,41 @@ struct fuse_uring_cmd_req {
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
index a6cce014391aec..e2a81948811554 100644
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
index 649a500614b80e..89fcdb87db7dee 100644
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
@@ -3390,6 +3488,8 @@ static struct {
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
+	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3445,6 +3545,8 @@ static struct {
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
+	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 96a94e43f73909..eb4d2f350ec63c 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -219,6 +219,9 @@ FUSE_3.18 {
 } FUSE_3.17;
 
 FUSE_3.99 {
+	global:
+		fuse_iomap_pure_overwrite;
+		fuse_reply_iomap_begin;
 } FUSE_3.18;
 
 # Local Variables:


