Return-Path: <linux-fsdevel+bounces-55357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C865B0982B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE9916A794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD123ABB7;
	Thu, 17 Jul 2025 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na1k0mEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2D1FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795453; cv=none; b=Ig1SIrBOhu5tsYw1LJ9Ajr6cgjW/pWBpWUwNfr4BrrtWH9QIUie5Fw6wRSUNJhXGjC3462WFo9CRvW8ewzEwUnmbDDx7mXAymaF8EnJjGG7pKo7flLu5xti3aq2Z6p70mcmB/R2+Kqk2YidMAqtHkPCJOO3jZqOZpxfF7t7m1wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795453; c=relaxed/simple;
	bh=0kVIuLKMAQfLvxN7QZm1riN+SXZHAM6vjpnkThUOR4M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S16z2hcP+inmM+8lTaTaHJ3TzRhi4NHlflmtsFJCbiP5uB8/tyOCBaiv6KU2ugyNeMDD3cFEEHsyc0rWtIfveErDPkwDS/deHbTrH81RwHITPaVfL5IfUTLtl0Yh/03x47MDTR2g71V5zT4tPTNmNMfcsQi4YMhWjcV9k3F/zac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na1k0mEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390FCC4CEE3;
	Thu, 17 Jul 2025 23:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795453;
	bh=0kVIuLKMAQfLvxN7QZm1riN+SXZHAM6vjpnkThUOR4M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=na1k0mEcjrLCeqSHu6D4D/8HMy0mfIM9xTVwN/ljOoP2UEpXeSdIe78+o7MT0h8Wd
	 db6Ff9LzjCbmv90l9piUG4nMPp5i1ri026E56qFxHmQsOJfHiJuxNgxTCnI6drcU7i
	 RM4fSSjpbfAiRCNTHOX+LLdc5uGR0N4o6XPPwRUKG0CfT9fwTFjzeCtFCVbECcHONN
	 KZDebZ8vy4aMQD9fl5D1DEhuZZ1D/Sv3LUFcpBJN9X3wOBvSqQkAFX7AV0oGc6xCE0
	 TFm0hJ78M+TheFzsv8cQ4hjdAaRYzxQuJ1d+PsmmAeMoq0fRB6ymiAuYLQ4yYt417+
	 UoADXOnQFG3JA==
Date: Thu, 17 Jul 2025 16:37:32 -0700
Subject: [PATCH 12/14] libfuse: add lower level iomap_config implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459947.714161.13615605815262170032.stgit@frogsfrogsfrogs>
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

Add FUSE_IOMAP_CONFIG helpers to the low level fuse library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |   31 ++++++++++++++++++++++++++
 include/fuse_kernel.h   |   30 ++++++++++++++++++++++++++
 include/fuse_lowlevel.h |   25 +++++++++++++++++++++
 lib/fuse_lowlevel.c     |   55 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 5 files changed, 142 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 8bc21677b6e5c7..98cb8f656efd13 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1227,6 +1227,37 @@ struct fuse_iomap {
 /* use iomap for buffered io */
 #define FUSE_IFLAG_IOMAP_FILEIO		(1U << 2)
 
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
 #endif /* FUSE_USE_VERSION >= 318 */
 
 /* ----------------------------------------------------------- *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 7a1226d6bc2c0a..3c704f03434693 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
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
@@ -1376,4 +1378,32 @@ struct fuse_iomap_ioend_in {
 	uint32_t reserved1;	/* zero */
 };
 
+struct fuse_iomap_config_in {
+	uint64_t flags;		/* zero for now */
+	int64_t maxbytes;	/* max supported file size */
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
index a529a112998d6e..fd7df5c2c11e16 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1387,6 +1387,19 @@ struct fuse_lowlevel_ops {
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
+	 * @param flags currently zero
+	 * @param maxbytes maximum supported file size
+	 */
+	void (*iomap_config) (fuse_req_t req, uint32_t flags, int64_t maxbytes);
 #endif /* FUSE_USE_VERSION >= 318 */
 };
 
@@ -1856,6 +1869,18 @@ int fuse_reply_lseek(fuse_req_t req, off_t off);
  */
 int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_iomap *read_iomap,
 			   const struct fuse_iomap *write_iomap);
+
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
+int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg);
 #endif /* FUSE_USE_VERSION >= 318 */
 
 /* ----------------------------------------------------------- *
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 0c7d5cc99945ee..ed9464d592c8a1 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2583,6 +2583,59 @@ static void do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_iomap_ioend(req, nodeid, inarg, NULL);
 }
 
+int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg)
+{
+	struct fuse_iomap_config_out arg = {
+		.flags = cfg->flags,
+	};
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
+	return send_reply_ok(req, &arg, sizeof(arg));
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
+		req->se->op.iomap_config(req, arg->flags, arg->maxbytes);
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
@@ -3474,6 +3527,7 @@ static struct {
 	[FUSE_RENAME2]     = { do_rename2,      "RENAME2"    },
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
+	[FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
 	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
@@ -3531,6 +3585,7 @@ static struct {
 	[FUSE_RENAME2]		= { _do_rename2,	"RENAME2" },
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
+	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
 	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 606fdc6127462e..9cb46d8a7afdd2 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -220,6 +220,7 @@ FUSE_3.18 {
 		fuse_reply_entry_iflags;
 		fuse_add_direntry_plus_iflags;
 		fuse_discover_iomap;
+		fuse_reply_iomap_config;
 } FUSE_3.17;
 
 # Local Variables:


