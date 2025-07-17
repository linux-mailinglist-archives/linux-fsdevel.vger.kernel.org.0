Return-Path: <linux-fsdevel+bounces-55363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD5B09834
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4CD4A1CC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1492459DA;
	Thu, 17 Jul 2025 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baZC0rSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B328244690
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795547; cv=none; b=pXX3P35MYm2Z+Emk7YR/jbzTvi6sADAtYe0faVGFfVaSV6AaYMz4ioVtkWmaDOMOf4koKkCBiARbP+WQAbug3KlWhrHMihetUYatz4ukT5SdZOn85TGOJnorOjOUFOiWNJ95++i3BImVPjTfL7FM5G+T0Vsho1enONQlYz3grFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795547; c=relaxed/simple;
	bh=Xlly4JGh8YrVwwI+SXeUbfAKl/4ACKoB/uMMsUDlUD0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWVpCNhB+2rsfu9cOCF8Qoh00WDKqpfhRmJOZLYrQS5Y/lgZ5hOsbamawucQld16cFCCRTaSBo/pq87xMWtc/KwFvNJDGrRsopeqmRzMxcfbx/YBzkWVanmmT1hnaqjwKj1Z/aJfC5xqyjGPtJJDbPf86D/WnqzlrhfabPA4bXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baZC0rSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF65C4CEF0;
	Thu, 17 Jul 2025 23:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795546;
	bh=Xlly4JGh8YrVwwI+SXeUbfAKl/4ACKoB/uMMsUDlUD0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=baZC0rSMNCmx8Ir1DFhNXtlRxnqSZzDW1wUBepXXAvp5r9/RGXNd8u+RP8MqgG5pz
	 hlKBeK0uF6c3Z+5JTm1iCoKRhepn5YAX8JGt/bxil0t0CajldPkhL1ko1wBoL4x9yk
	 N1SSoXl3EZ22vnOvkuUPvtmJuV8hcqe+1oI7tvazSbNkwU4MAuDUgsnH9skIkB19kt
	 HdEzN8jwflz0xrcE+ghPzx7HDYtkrfJyD1+1++waQAlzBrVT8ICcrP2t0DVuOYWkA2
	 aof8ysuWtzBLNmndkpzoItZtjCTI2eijpNVQNbBqXNNaCpGtCajmcrYigYoq+M+Dxg
	 39PKYy7IzZYGw==
Date: Thu, 17 Jul 2025 16:39:06 -0700
Subject: [PATCH 3/4] libfuse: add statx support to the lower level library
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279460430.714831.6251867847811735740.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
References: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add statx support to the lower level fuse library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_lowlevel.h |   37 ++++++++++++++++++
 lib/fuse_lowlevel.c     |   97 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 +
 3 files changed, 136 insertions(+)


diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 77685e433e4f7d..f4d62cee22870a 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1416,6 +1416,26 @@ struct fuse_lowlevel_ops {
 	 * @param ino the inode number
 	 */
 	void (*syncfs) (fuse_req_t req, fuse_ino_t ino);
+
+	/**
+	 * Fetch extended stat information about a file
+	 *
+	 * If this request is answered with an error code of ENOSYS, this is
+	 * treated as a permanent failure, i.e. all future statx() requests
+	 * will fail with the same error code without being sent to the
+	 * filesystem process.
+	 *
+	 * Valid replies:
+	 *   fuse_reply_statx
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param statx_flags AT_STATX_* flags
+	 * @param statx_mask desired STATX_* attribute mask
+	 * @param fi file information
+	 */
+	void (*statx) (fuse_req_t req, fuse_ino_t ino, uint32_t statx_flags,
+		       uint32_t statx_mask, struct fuse_file_info *fi);
 #endif /* FUSE_USE_VERSION >= 318 */
 };
 
@@ -1897,6 +1917,23 @@ int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_iomap *read_iomap,
  * @return zero for success, -errno for failure to send reply
  */
 int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg);
+
+struct statx;
+
+/**
+ * Reply with statx attributes
+ *
+ * Possible requests:
+ *   statx
+ *
+ * @param req request handle
+ * @param statx the attributes
+ * @param size the size of the statx structure
+ * @param attr_timeout	validity timeout (in seconds) for the attributes
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_statx(fuse_req_t req, const struct statx *statx, size_t size,
+		     double attr_timeout);
 #endif /* FUSE_USE_VERSION >= 318 */
 
 /* ----------------------------------------------------------- *
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index ec30ebc4cdd074..8eeb6a8547da91 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -144,6 +144,43 @@ static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)
 	ST_CTIM_NSEC_SET(stbuf, attr->ctimensec);
 }
 
+#ifdef STATX_BASIC_STATS
+static int convert_statx(struct fuse_statx *stbuf, const struct statx *stx,
+			 size_t size)
+{
+	if (sizeof(struct statx) != size)
+		return EOPNOTSUPP;
+
+	stbuf->mask = stx->stx_mask & (STATX_BASIC_STATS | STATX_BTIME);
+	stbuf->blksize		= stx->stx_blksize;
+	stbuf->attributes	= stx->stx_attributes;
+	stbuf->nlink		= stx->stx_nlink;
+	stbuf->uid		= stx->stx_uid;
+	stbuf->gid		= stx->stx_gid;
+	stbuf->mode		= stx->stx_mode;
+	stbuf->ino		= stx->stx_ino;
+	stbuf->size		= stx->stx_size;
+	stbuf->blocks		= stx->stx_blocks;
+	stbuf->attributes_mask	= stx->stx_attributes_mask;
+	stbuf->rdev_major	= stx->stx_rdev_major;
+	stbuf->rdev_minor	= stx->stx_rdev_minor;
+	stbuf->dev_major	= stx->stx_dev_major;
+	stbuf->dev_minor	= stx->stx_dev_minor;
+
+	stbuf->atime.tv_sec	= stx->stx_atime.tv_sec;
+	stbuf->btime.tv_sec	= stx->stx_btime.tv_sec;
+	stbuf->ctime.tv_sec	= stx->stx_ctime.tv_sec;
+	stbuf->mtime.tv_sec	= stx->stx_mtime.tv_sec;
+
+	stbuf->atime.tv_nsec	= stx->stx_atime.tv_nsec;
+	stbuf->btime.tv_nsec	= stx->stx_btime.tv_nsec;
+	stbuf->ctime.tv_nsec	= stx->stx_ctime.tv_nsec;
+	stbuf->mtime.tv_nsec	= stx->stx_mtime.tv_nsec;
+
+	return 0;
+}
+#endif
+
 static	size_t iov_length(const struct iovec *iov, size_t count)
 {
 	size_t seg;
@@ -2653,6 +2690,64 @@ static void do_syncfs(fuse_req_t req, const fuse_ino_t nodeid, const void *inarg
 	_do_syncfs(req, nodeid, inarg, NULL);
 }
 
+#ifdef STATX_BASIC_STATS
+int fuse_reply_statx(fuse_req_t req, const struct statx *statx, size_t size,
+		     double attr_timeout)
+{
+	struct fuse_statx_out arg = {
+		.attr_valid = calc_timeout_sec(attr_timeout),
+		.attr_valid_nsec = calc_timeout_nsec(attr_timeout),
+	};
+
+	int err = convert_statx(&arg.stat, statx, size);
+	if (err) {
+		fuse_reply_err(req, err);
+		return err;
+	}
+
+	return send_reply_ok(req, &arg, sizeof(arg));
+}
+
+static void _do_statx(fuse_req_t req, const fuse_ino_t nodeid,
+		      const void *op_in, const void *in_payload)
+{
+	(void)in_payload;
+	const struct fuse_statx_in *arg = op_in;
+	struct fuse_file_info *fip = NULL;
+	struct fuse_file_info fi;
+
+	if (arg->getattr_flags & FUSE_GETATTR_FH) {
+		memset(&fi, 0, sizeof(fi));
+		fi.fh = arg->fh;
+		fip = &fi;
+	}
+
+	if (req->se->op.statx)
+		req->se->op.statx(req, nodeid, arg->sx_flags, arg->sx_mask,
+				  fip);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+#else
+int fuse_reply_statx(fuse_req_t req, const struct statx *statx,
+		     double attr_timeout)
+{
+	fuse_reply_err(req, ENOSYS);
+	return -ENOSYS;
+}
+
+static void _do_statx(fuse_req_t req, const fuse_ino_t nodeid,
+		      const void *op_in, const void *in_payload)
+{
+	fuse_reply_err(req, ENOSYS);
+}
+#endif /* STATX_BASIC_STATS */
+
+static void do_statx(fuse_req_t req, const fuse_ino_t nodeid, const void *inarg)
+{
+	_do_statx(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3627,6 +3722,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_SYNCFS]	   = { do_syncfs,	"SYNCFS"     },
+	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
 	[FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
@@ -3686,6 +3782,7 @@ static struct {
 	[FUSE_COPY_FILE_RANGE]	= { _do_copy_file_range, "COPY_FILE_RANGE" },
 	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
 	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
+	[FUSE_STATX]		= { _do_statx,		"STATX" },
 	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index dc9fa2428b5325..a67b1802770335 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -223,6 +223,8 @@ FUSE_3.18 {
 		fuse_reply_iomap_config;
 		fuse_lowlevel_notify_iomap_upsert;
 		fuse_lowlevel_notify_iomap_inval;
+
+		fuse_reply_statx;
 } FUSE_3.17;
 
 # Local Variables:


