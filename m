Return-Path: <linux-fsdevel+bounces-49619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05097AC00FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A91BC400B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E8645;
	Thu, 22 May 2025 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfDchrsv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D4195
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872351; cv=none; b=O+VJqB4VT/iiJJrs7S318cJlzPRz7VGlaCRjrMbPpZ3GCys+0l/N+06CLQsCo/HF36V+Lq0DY8POnsRJjkLUbiDyf4cxjVSE6T0jERYb02w/oCsTmaHBZB5+U1izycx7bPBAq+JDH7hOeCJOtHZdhXlpUe/yKuqTGJY18E7FS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872351; c=relaxed/simple;
	bh=yLZm1qTOEdAA9HvMr0EQpDPEELpw7so8QCOfgmnP7W8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+4g4OmRz0QgI7A9u353f5usVfd+avwoWHr96WYqudKihLC7LP94K1NzUpjDQ1tboyh+AP+L3k0eCAi5KQ1W6KWkEiEVfnLTAihq0GyjyQcJaaWj+oqC31SKcp7OPPn/LVR6tuPNu4pRH3HisUp4StCB/dtGMuherpSsLkJ8RzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfDchrsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5DFC4CEE4;
	Thu, 22 May 2025 00:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872351;
	bh=yLZm1qTOEdAA9HvMr0EQpDPEELpw7so8QCOfgmnP7W8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mfDchrsv+iFaWQs5nxRMCZG1R+i3M+XtPPtMXBrlnb8XoW0M5XGn9sR+OONRREzjk
	 qJLFtl8KqNn1YHqeuGHXVYG4rQiVvLoxWwFBEgyZLoSBI861IfjL0mR3v4MRGMET4Y
	 LNbSCXzfiCJESBBbRqeHcJ/RjTg38/P4L/4rICZrLVZlrYiqpDYcFLxr+9BITnPEj+
	 AReRQa1ON20VFtGZ9+2HOMLOP0BzTp+bSerYPxaGNecKlWZ0cTJW0FfDBNDpcLOIIl
	 JCBMVoD8HBaIyjFFcUWcqsm0pzBN51kGrj7/NhbGxn82fvkBd6oBp1kfCdq/ODvZj/
	 xff+B3DmnCGHA==
Date: Wed, 21 May 2025 17:05:50 -0700
Subject: [PATCH 2/8] libfuse: add fuse commands for iomap_begin and end
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, John@groves.net,
 joannelkoong@gmail.com, miklos@szeredi.hu
Message-ID: <174787196394.1483718.15056337774263190955.stgit@frogsfrogsfrogs>
In-Reply-To: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
References: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
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
 include/fuse_common.h   |   53 ++++++++++++++++++++++++++++++++++
 include/fuse_kernel.h   |   41 ++++++++++++++++++++++++++
 include/fuse_lowlevel.h |   54 ++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   74 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 2394655140dc26..fb9c2f5c3811e3 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1129,6 +1129,59 @@ static inline bool fuse_get_feature_flag(struct fuse_conn_info *conn,
 	return conn->capable_ext & flag ? true : false;
 }
 
+/**
+ * iomap operations.
+ * These APIs are introduced in version 318 (FUSE_MAKE_VERSION(3, 18)).
+ * Using them in earlier versions will result in errors.
+ */
+#if FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 18)
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
+struct fuse_iomap {
+	uint64_t addr;		/* disk offset of mapping, bytes */
+	uint64_t offset;	/* file offset of mapping, bytes */
+	uint64_t length;	/* length of mapping, bytes */
+	uint16_t type;		/* FUSE_IOMAP_TYPE_* */
+	uint16_t flags;		/* FUSE_IOMAP_F_* */
+	uint32_t dev;		/* device cookie */
+};
+#endif /* FUSE_USE_VERSION >= 318 */
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index f519fb2dc08b3f..1b3f6046128bde 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -657,6 +657,9 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_BEGIN	= 4094,
+	FUSE_IOMAP_END		= 4095,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -1287,4 +1290,42 @@ struct fuse_uring_cmd_req {
 	uint8_t padding[6];
 };
 
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
+	uint32_t read_dev;	/* FUSE_IOMAP_DEV_* */
+
+	uint64_t write_addr;	/* disk offset of mapping, bytes */
+	uint16_t write_type;	/* FUSE_IOMAP_TYPE_* */
+	uint16_t write_flags;	/* FUSE_IOMAP_F_* */
+	uint32_t write_dev;	/* device cookie */
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
+	uint32_t map_dev;	/* device cookie */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 138a78436fe6d2..4950aae4f82e0d 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1325,6 +1325,44 @@ struct fuse_lowlevel_ops {
 	void (*tmpfile) (fuse_req_t req, fuse_ino_t parent,
 			mode_t mode, struct fuse_file_info *fi);
 
+#if FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 18)
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
+	 * @param iomap file I/O mapping that failed
+	 */
+	void (*iomap_end) (fuse_req_t req, fuse_ino_t nodeid, uint64_t attr_ino,
+			   off_t pos, uint64_t count, uint32_t opflags,
+			   ssize_t written, const struct fuse_iomap *iomap);
+#endif /* FUSE_USE_VERSION >= 318 */
 };
 
 /**
@@ -1705,6 +1743,22 @@ int fuse_reply_poll(fuse_req_t req, unsigned revents);
  */
 int fuse_reply_lseek(fuse_req_t req, off_t off);
 
+#if FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 18)
+/**
+ * Reply with iomappings for an iomap_begin operation
+ *
+ * Possible requests:
+ *   iomap_begin
+ *
+ * @param req request handle
+ * @param read_iomap mapping for file data reads
+ * @param write_iomap mapping for file data writes
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_iomap *read_iomap,
+			   const struct fuse_iomap *write_iomap);
+#endif /* FUSE_USE_VERSION >= 318 */
+
 /* ----------------------------------------------------------- *
  * Notification						       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 4b03e626dab508..56f4789ddb2d0a 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2421,6 +2421,76 @@ static void do_lseek(fuse_req_t req, const fuse_ino_t nodeid, const void *inarg)
 	_do_lseek(req, nodeid, inarg, NULL);
 }
 
+int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_iomap *read_iomap,
+			   const struct fuse_iomap *write_iomap)
+{
+	struct fuse_iomap_begin_out arg = {
+		.offset = read_iomap->offset,
+		.length = read_iomap->length,
+
+		.read_addr = read_iomap->addr,
+		.read_type = read_iomap->type,
+		.read_flags = read_iomap->flags,
+		.read_dev = read_iomap->dev,
+
+		.write_addr = write_iomap->addr,
+		.write_type = write_iomap->type,
+		.write_flags = write_iomap->flags,
+		.write_dev = write_iomap->dev,
+	};
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
+	struct fuse_iomap iomap = {
+		.addr = arg->map_addr,
+		.offset = arg->pos,
+		.length = arg->map_length,
+		.type = arg->map_type,
+		.flags = arg->map_flags,
+		.dev = arg->map_dev,
+	};
+	(void)in_payload;
+	(void)nodeid;
+
+	if (req->se->op.iomap_end)
+		req->se->op.iomap_end(req, nodeid, arg->attr_ino, arg->pos,
+				      arg->count, arg->opflags, arg->written,
+				      &iomap);
+	else
+		fuse_reply_err(req, 0);
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
@@ -3218,6 +3288,8 @@ static struct {
 	[FUSE_RENAME2]     = { do_rename2,      "RENAME2"    },
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
+	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
+	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3272,6 +3344,8 @@ static struct {
 	[FUSE_RENAME2]		= { _do_rename2,	"RENAME2" },
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
+	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
+	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 


