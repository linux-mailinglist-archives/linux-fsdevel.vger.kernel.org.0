Return-Path: <linux-fsdevel+bounces-61574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2EB589F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4177A1C58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC271DE2C9;
	Tue, 16 Sep 2025 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT1abNT0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E01A0728
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983526; cv=none; b=srNFQqMkpfamUxFAAIjQLZvSQem2bUBIoIqHv2yQCwVdmLEVB/fsRjhihPh0QCrocP1wAeyNwpgQMzeqrCQIr7y/VIuJhvp0N16wyeNRkdjPiI8lkVamijSKBMZ3yn1AcyPHAml/QpAE3lQ5tzAEYwQYdU+wH9qPbFuERWNlr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983526; c=relaxed/simple;
	bh=2M78hX6nrVXi7dRTkwIyy1kbmKPBpkIM2s4V4t1K6J4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5HIhHJ6PtCv0FKOFV5YgG6jAqSwdU+DggrMxEgxTyk6wDfAXUwyrnEZqBtxFanh10kamV45cI6mNoCdUIB6O1kkB3cQx1su7FJu2ZgIC7mHtuw+8b38ROMzvGkLtF9UcRL8mnCLLdVNIx03Y0+2u+2ZKslO9TLklyZnobMMMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT1abNT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFC0C4CEF1;
	Tue, 16 Sep 2025 00:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983526;
	bh=2M78hX6nrVXi7dRTkwIyy1kbmKPBpkIM2s4V4t1K6J4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XT1abNT0qHXMRuqztmx3k8UGPxLdCkJy+q8ZagBkNs2VHscLP6CNoZXoBT5sAyMfq
	 aFW7GCdXpVPnld2WoczUj0/xeCe4iFMtZkoAElSI7rsQa2tYsOvPnKLmKD2sUhDoFi
	 hdJRmagyYovc2rhCdJFyfIIh5EPMEm+yIIFwK4BJIUSZleTtvgTeC9stS6HW0Bg0cG
	 U62rANHyFKL1VyU+B7V9z+Bg4abrw0xqL3QRsVCB8Mfhxh3uP3PJ4ElOhGAza4bPOJ
	 kaQHKfi/qBJFRG8yQCBY6oeFZyL69DMa4hXTTQY0yTnTUgoZDEQb/SqkNlEH6WMNJU
	 gnm3MfaeQGbLQ==
Date: Mon, 15 Sep 2025 17:45:26 -0700
Subject: [PATCH 14/18] libfuse: add lower level iomap_config implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154761.386924.15205535355104741162.stgit@frogsfrogsfrogs>
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

Add FUSE_IOMAP_CONFIG helpers to the low level fuse library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |   31 ++++++++++++++++++
 include/fuse_kernel.h   |   31 ++++++++++++++++++
 include/fuse_lowlevel.h |   27 +++++++++++++++
 lib/fuse_lowlevel.c     |   82 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 5 files changed, 172 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 86ae8894d81dbb..59b79b44a36e8d 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1233,6 +1233,37 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 /* use iomap for this inode */
 #define FUSE_IFLAG_IOMAP		(1U << 1)
 
+/* Which fields are set in fuse_iomap_config_out? */
+#define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
+#define FUSE_IOMAP_CONFIG_UUID		(1 << 1ULL)
+#define FUSE_IOMAP_CONFIG_BLOCKSIZE	(1 << 2ULL)
+#define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
+#define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
+#define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
+
+struct fuse_iomap_config{
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
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index ea4243d09db53f..4009d0109711d9 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -239,6 +239,7 @@
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
+ *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  */
 
 #ifndef _LINUX_FUSE_H
@@ -666,6 +667,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
@@ -1363,4 +1365,33 @@ struct fuse_iomap_ioend_in {
 	uint32_t reserved1;	/* zero */
 };
 
+struct fuse_iomap_config_in {
+	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
+	int64_t maxbytes;	/* max supported file size */
+	uint64_t padding[6];	/* zero */
+};
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
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index a4117efdee6dea..b79c73d1573c40 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1408,6 +1408,20 @@ struct fuse_lowlevel_ops {
 			     uint64_t attr_ino, off_t pos, size_t written,
 			     uint32_t ioendflags, int error,
 			     uint64_t new_addr);
+
+	/**
+	 * Configure the filesystem geometry for iomap mode
+	 *
+	 * Valid replies:
+	 *   fuse_reply_iomap_config
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param flags FUSE_IOMAP_CONFIG_* flags that can be passed back
+	 * @param maxbytes maximum supported file size
+	 */
+	void (*iomap_config) (fuse_req_t req, uint64_t flags,
+			      uint64_t maxbytes);
 };
 
 /**
@@ -1898,6 +1912,19 @@ void fuse_iomap_pure_overwrite(struct fuse_file_iomap *write,
 int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_file_iomap *read,
 			   const struct fuse_file_iomap *write);
 
+/**
+ * Reply with iomap configuration
+ *
+ * Possible requests:
+ *   iomap_config
+ *
+ * @param req request handle
+ * @param cfg iomap configuration
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_iomap_config(fuse_req_t req,
+			    const struct fuse_iomap_config *cfg);
+
 /* ----------------------------------------------------------- *
  * Notification						       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index a20f7fe3752ac5..26c23527439feb 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2695,6 +2695,86 @@ static void do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_iomap_ioend(req, nodeid, inarg, NULL);
 }
 
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+
+#define FUSE_IOMAP_CONFIG_V1 (FUSE_IOMAP_CONFIG_SID | \
+			      FUSE_IOMAP_CONFIG_UUID | \
+			      FUSE_IOMAP_CONFIG_BLOCKSIZE | \
+			      FUSE_IOMAP_CONFIG_MAX_LINKS | \
+			      FUSE_IOMAP_CONFIG_TIME | \
+			      FUSE_IOMAP_CONFIG_MAXBYTES)
+
+#define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_V1)
+
+static ssize_t iomap_config_reply_size(const struct fuse_iomap_config *cfg)
+{
+	if (cfg->flags & ~FUSE_IOMAP_CONFIG_ALL)
+		return -EINVAL;
+
+	return offsetofend(struct fuse_iomap_config_out, s_maxbytes);
+}
+
+int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg)
+{
+	struct fuse_iomap_config_out arg = {
+		.flags = cfg->flags,
+	};
+	const ssize_t reply_size = iomap_config_reply_size(cfg);
+
+	if (reply_size < 0)
+		fuse_reply_err(req, -reply_size);
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_BLOCKSIZE)
+		arg.s_blocksize = cfg->s_blocksize;
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_SID)
+		memcpy(arg.s_id, cfg->s_id, sizeof(arg.s_id));
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_UUID) {
+		arg.s_uuid_len = cfg->s_uuid_len;
+		if (arg.s_uuid_len > sizeof(arg.s_uuid))
+			arg.s_uuid_len = sizeof(arg.s_uuid);
+		memcpy(arg.s_uuid, cfg->s_uuid, arg.s_uuid_len);
+	}
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_MAX_LINKS)
+		arg.s_max_links = cfg->s_max_links;
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_TIME) {
+		arg.s_time_gran = cfg->s_time_gran;
+		arg.s_time_min = cfg->s_time_min;
+		arg.s_time_max = cfg->s_time_max;
+	}
+
+	if (cfg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
+		arg.s_maxbytes = cfg->s_maxbytes;
+
+	return send_reply_ok(req, &arg, reply_size);
+}
+
+static void _do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
+		      const void *op_in, const void *in_payload)
+{
+	(void)nodeid;
+	(void)in_payload;
+	const struct fuse_iomap_config_in *arg = op_in;
+
+	if (req->se->op.iomap_config)
+		req->se->op.iomap_config(req,
+					 arg->flags & FUSE_IOMAP_CONFIG_ALL,
+					 arg->maxbytes);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
+			    const void *inarg)
+{
+	_do_iomap_config(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3594,6 +3674,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
 	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
@@ -3652,6 +3733,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
 	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 704e8c2908ec4b..6e57e943a60e2d 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -233,6 +233,7 @@ FUSE_3.99 {
 		fuse_fs_can_enable_iomap;
 		fuse_fs_can_enable_iomapx;
 		fuse_lowlevel_discover_iomap;
+		fuse_reply_iomap_config;
 } FUSE_3.18;
 
 # Local Variables:


