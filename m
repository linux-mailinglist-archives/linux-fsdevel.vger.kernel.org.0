Return-Path: <linux-fsdevel+bounces-58490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC3B2EA05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6651BC6756
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC81EDA26;
	Thu, 21 Aug 2025 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEhM7Hhw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362381B87F2
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738318; cv=none; b=E4TqXe4eO0oSj7XoPx1ma6uWuS5wC3jFlbvLqvFncBMiXMQnGm+fkumJKQFH+tFxKkkXzyahw0sDc+/4HfU+RLaPOV2+oUka+Wg0vywZQ5IfuzjiqHggACv05KfGnmLtBNOBthpyk8h/6rExkLCelLdIocLngM6aUKh3vk4qMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738318; c=relaxed/simple;
	bh=inazI3//gvGgnbgQ9xD66otBS7q1w1NYzPG2lIMdygY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSpsRxeakw7oaRlXmiHxcJ6orO9ZYuhoBVFsObTX7QxbDIZrw8CldZC5vXvM4U4kW8NBst0hE1rM0828L5JgIcpqx+a99/GlvLelTUClT09F0rWjOv+jtcf7tLojs/6v6YhgOAvotKaXywRMZm1RZkQP3M3q8W0tfMUXrEYgslY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEhM7Hhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4071C4CEE7;
	Thu, 21 Aug 2025 01:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738316;
	bh=inazI3//gvGgnbgQ9xD66otBS7q1w1NYzPG2lIMdygY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jEhM7HhwXhYmDqjte3R/nJBED/WRh5Wiay5qMEYfqxsGEK93CuzBu94nJpMsoAlnT
	 s3YnhvgfzYWeR8TkJzanTqXw0PV8wYVcl6Ivh35SLHzSGLd4k/3S6Kbq12DCNh0M7R
	 4L+9W+PNo/QEdpOn+lIe/silkkqF9uyA9f15J56K9aeAS/+T24ADDOnloGMq/rhPaB
	 oDukMJsMS5fjmCEnr9f0Dr1geYkNZMMQJ1wSKrXAmgmH83Khowv8YwFTyktXDrYCxS
	 nhrQPN9tRISSGFqSQ6yRVjVnG+9wx4C+0/5rF9alGFhDMouMy6q5FyPakwY/BOaeT4
	 wIVPSfrMzymtw==
Date: Wed, 20 Aug 2025 18:05:16 -0700
Subject: [PATCH 15/21] libfuse: add lower level iomap_config implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711565.19163.17209614916402171532.stgit@frogsfrogsfrogs>
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
index f9cc3702411680..8e585cc7483643 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1238,6 +1238,37 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
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
index dbd2ce1fbbe6ed..46960711691d99 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
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
@@ -1358,4 +1360,33 @@ struct fuse_iomap_ioend_in {
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
index 2931a57ec4079b..1b2a6c00d0f9dc 100644
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
index ab10204c8042d9..60627ec35cd367 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2694,6 +2694,86 @@ static void do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
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
@@ -3579,6 +3659,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
+	[FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
 	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
@@ -3637,6 +3718,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
+	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
 	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 5275a17ba1ed51..f886d268c8a99f 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -232,6 +232,7 @@ FUSE_3.99 {
 		fuse_fs_can_enable_iomap;
 		fuse_fs_can_enable_iomapx;
 		fuse_lowlevel_discover_iomap;
+		fuse_reply_iomap_config;
 } FUSE_3.18;
 
 # Local Variables:


