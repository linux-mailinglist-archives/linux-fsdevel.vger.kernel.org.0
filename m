Return-Path: <linux-fsdevel+bounces-55347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0796FB0981D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377E71641C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C0C24110F;
	Thu, 17 Jul 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWkrsXpx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A71FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795297; cv=none; b=G5j1DRobHfx1PVFL5hGW4/RBpeiOXU6gZLjrRlqrJpzWVy6du7x4YW9/Sm2ju5nRGpnol7ufpXY8T1f6qN15o0qaSnmgQWFs+APykLyfL+ED/YPwqQ0ojz1OYcu6dUyUciZTY+Sx/MAfCNnN71oVZKsliRtm2IE9PVH6mFp+ZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795297; c=relaxed/simple;
	bh=vsyZFA1v1EbRivCDBUP58TuA7PKVCbWxse1nQ2fHCU8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXqWCeCZ0R3lzV3Ne/jTI/uT25fazX/R06B3Qo7NDCuKq9ZUHdzmi9U1bheIsvDPG/AcfJNt7e6+ZMUNEcd3iYPdf4I1GE4flck7wGT9L7+mn+fFKMBYhjkseCKE2VFV+WvkTE8B6/yi8OXBSWyvS1Hzkc5T1bOy81KkXGdXgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWkrsXpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C6CC4CEE3;
	Thu, 17 Jul 2025 23:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795296;
	bh=vsyZFA1v1EbRivCDBUP58TuA7PKVCbWxse1nQ2fHCU8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TWkrsXpx/sfZog8f01PffI2Xx3Ncs9mf9NpmYNzZv8I+AVoykeiz4ZG4lCoB2A9m3
	 mG2EeKMr9/bNk5h1oD0s76YZK5R0AgjLSQVZWCn0sWeW4g0scBwV06Sg1i7wsFeR+1
	 /LZ2Rl/lqqyE0NtHpwT193jcMxqaGh11d/F4fa/ySEI22oDg3WHbZIIfcnDrR6ue3g
	 9oTV24opneX0yLLbP2n3V22ZOmwXXUnGJmIj4SYPXz0vWGkClLh8dmeSORhL2TY4g2
	 Thh5l2O5fclLzDi1ssSZMilqLfaXGwR9jh4RLYfbtUHCX/8I2AEhPm0+9SKGxERWdl
	 GcvVPxR87RM2w==
Date: Thu, 17 Jul 2025 16:34:56 -0700
Subject: [PATCH 02/14] libfuse: add fuse commands for iomap_begin and end
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459767.714161.12761951834985311641.stgit@frogsfrogsfrogs>
In-Reply-To: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
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
 include/fuse_common.h   |   52 +++++++++++++++++++++++++++++++++
 include/fuse_kernel.h   |   41 ++++++++++++++++++++++++++
 include/fuse_lowlevel.h |   54 ++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   74 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 +
 5 files changed, 223 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 8f87263d78f999..f48724b0d1ea0f 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1147,6 +1147,58 @@ int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
 
 
 
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
+#define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
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
index b1e42d3cf86e81..eb59ff687b2e7d 100644
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
 
@@ -1297,4 +1300,42 @@ struct fuse_uring_cmd_req {
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
index 75e084d09167de..d3de87897c47b8 100644
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
index 392e898a5e8ec1..875d2345461251 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2428,6 +2428,76 @@ static void do_lseek(fuse_req_t req, const fuse_ino_t nodeid, const void *inarg)
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
@@ -3306,6 +3376,8 @@ static struct {
 	[FUSE_RENAME2]     = { do_rename2,      "RENAME2"    },
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
+	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
+	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3360,6 +3432,8 @@ static struct {
 	[FUSE_RENAME2]		= { _do_rename2,	"RENAME2" },
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
+	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
+	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 2d8884d7eae090..2b4c16abdaf519 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -212,6 +212,8 @@ FUSE_3.18 {
 
 		# Not part of public API, for internal test use only
 		fuse_convert_to_conn_want_ext;
+
+		fuse_reply_iomap_begin;
 } FUSE_3.17;
 
 # Local Variables:


