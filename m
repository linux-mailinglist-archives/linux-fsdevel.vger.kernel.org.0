Return-Path: <linux-fsdevel+bounces-78115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB4QKETinGnrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:27:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B2C17F5DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B5743092B81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AA537F8A0;
	Mon, 23 Feb 2026 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwuRSb2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D19537D132;
	Mon, 23 Feb 2026 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889185; cv=none; b=Biq9qE6z1WwC765LMp4Jlgj7vtpRa6p1mPmJNAwOxUoZa+eXcFhIdb1KNMaGVA9TTdzuxm5pyXYKmqXM0u9+VxONQRp9HEay3mUI+WWhQ/h3AzG7Qa5sj86UedobdLOWH3a8/YhnD/+neD/mwcDDXAaF33o8ZzMxQa37Z52lcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889185; c=relaxed/simple;
	bh=Ex8VomKkYt/5JMs1LSnwZ7rM+rorotb5uyQ5XEXl+/o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcSYErudi5o80uvJCvguZwDHwsmkESa+RNWx2O+3uodd1Aboa7pL2qbUHM8obtdM6dqenllG2VCGaFsQL2cOzi/IG5E48V1joC/ppFgtWpwvfF9cRK3J5UJsmW7ZCDyG3VwAIvagtgjHF3DOuK0oD6vKConhsekkrOuzEbxVnQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwuRSb2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4683C19421;
	Mon, 23 Feb 2026 23:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889184;
	bh=Ex8VomKkYt/5JMs1LSnwZ7rM+rorotb5uyQ5XEXl+/o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EwuRSb2vWm7LS2lmGg3mhDdu3vLIN0KWisLVsEK9jGVZbqeFwnl62osh1R7I4X2Yy
	 HtYpWNEq3o7mT5ChE3wuiPy+KLGxu1grC6rzyBYR7kQMEwz5sBVoTXhjXAM7uLn2Hi
	 MKRO5OKm6ZqC5tQxUJ1itZ2Km7X5LTPbABDgUBVS8OasdpxUKGDpSvvnrk48s/KX82
	 m6qNZ5QuP/1PPwcD4cWRiP4aKL/8xwfIx65WOsBvE28uQOANHN4D+Rcaz3+EmT/lJs
	 zcJ93GTyv6GmjJf9pMnuWX8/18jwXrfjFnS7CIFBXVOA2Q+90eo8DCjPzQr88LPqCM
	 OIXwbRYi+YXYw==
Date: Mon, 23 Feb 2026 15:26:24 -0800
Subject: [PATCH 04/25] libfuse: add fuse commands for iomap_begin and end
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740008.3940670.8413582077942515094.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78115-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61B2C17F5DA
X-Rspamd-Action: no action

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
index 9d53354de78868..58726ce43b1014 100644
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
+	uint64_t offset;	/* file offset of mapping, bytes */
+	uint64_t length;	/* length of mapping, bytes */
+	uint64_t addr;		/* disk offset of mapping, bytes */
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
index 354a6da01c2ecc..b3750bb6275620 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -670,6 +670,9 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_IOMAP_BEGIN	= 4094,
+	FUSE_IOMAP_END		= 4095,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -1313,4 +1316,41 @@ struct fuse_uring_cmd_req {
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
index ee0bd8d71d95e4..f01fb06d6737ba 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1357,6 +1357,43 @@ struct fuse_lowlevel_ops {
 	 * @param ino the inode number
 	 */
 	void (*syncfs)(fuse_req_t req, fuse_ino_t ino);
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
@@ -1751,6 +1788,28 @@ int fuse_reply_lseek(fuse_req_t req, off_t off);
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
index 237c02c6dce7d5..ccfae61390290b 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2620,6 +2620,104 @@ static void do_syncfs(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_syncfs(req, nodeid, inarg, NULL);
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
@@ -3606,6 +3704,8 @@ static struct {
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_SYNCFS]	   = { do_syncfs,      "SYNCFS"      },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
+	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3663,6 +3763,8 @@ static struct {
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
+	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 826d9fee00a8ee..e346ce29a7f7a3 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -230,6 +230,9 @@ FUSE_3.19 {
 } FUSE_3.18;
 
 FUSE_3.99 {
+	global:
+		fuse_iomap_pure_overwrite;
+		fuse_reply_iomap_begin;
 } FUSE_3.19;
 
 # Local Variables:


