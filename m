Return-Path: <linux-fsdevel+bounces-78169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGr1AkTmnGlxMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:44:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC5C17FDA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53E3930AA049
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D137FF4A;
	Mon, 23 Feb 2026 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0ce6X5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB437BE9E;
	Mon, 23 Feb 2026 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890030; cv=none; b=tH5U/cuf7jmANgRWfE9bdF9kGisKEYwHwxYbAeWIFLpE7JIxN82cqg8ks/7WtfPWqkWHWVrvuWRmh4BbabkCQ2aGmZMwyTwVVYsYg5tORCA62e1bTK+EPf70deOdvh8QiyQvmTKwfejU4DcayecUUohZFTDRaxjNSYfRsuiHheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890030; c=relaxed/simple;
	bh=mkFuK9hS4Ggbi5battVXcPpDstiKZ6ProlDdmdk2Ivc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIb002p0zaqNocimtB3Kw8o7qvfbuPqtJmRc+UckWzYybR3Ht/2sNdbl/Rq3IRmBoOmJGum7pmM6kFFq0CDC1N5g4g6SPiwL0iDzD35hs+D+ybACuRM32GK4ZIi87ohIj4iXe36S80xfaTf0sxJZ9LpRsxYjRxtnJGO/vYEDf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0ce6X5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85155C19424;
	Mon, 23 Feb 2026 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890030;
	bh=mkFuK9hS4Ggbi5battVXcPpDstiKZ6ProlDdmdk2Ivc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=t0ce6X5ix+dUVkSa3gtJCXDJ7nB4+1oIriYSriCsC6hVqCsukqm1uAhhXF26DqmCl
	 yHb5ZwpbOTNpXc943ek3EQp5LZa6uQv8nX9ZHmMRfYWOYjJq8+kA/CJsIpDDNaUm9n
	 2nbWh72FIMYWOA//22rzpbsMaMJf+FPTQvSvzNoAscuFpXrHj86zYQcmNVM0Ibpw1E
	 h4wyTBGPZW26ZSPW30Szr5+i22nLApq+LfWXjay5vnBEqaz+u3X4Wt2dWfsOefXFPj
	 M6hFW13ZP3DwgePby8FRaiIZc1t+yTARAbQT9GAIKmZ+691d6NJEmMmvsLG4pCihsH
	 FJf5nDAZ8rbpw==
Date: Mon, 23 Feb 2026 15:40:30 -0800
Subject: [PATCH 17/19] fuse2fs: enable atomic writes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744786.3943178.3790964243258836932.stgit@frogsfrogsfrogs>
In-Reply-To: <177188744403.3943178.7675407203918355137.stgit@frogsfrogsfrogs>
References: <177188744403.3943178.7675407203918355137.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78169-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BC5C17FDA9
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Advertise the single-fsblock atomic write capability that iomap can do.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 2 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 62ab8f618015e9..77207bae19e544 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -285,6 +285,9 @@ struct fuse4fs {
 	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
 	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
 				      int inuse);
+#ifdef STATX_WRITE_ATOMIC
+	unsigned int awu_min, awu_max;
+#endif
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -910,10 +913,22 @@ static inline bool fuse4fs_can_iomap(const struct fuse4fs *ff)
 {
 	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
 }
+
+static inline bool fuse4fs_iomap_supports_hw_atomic(const struct fuse4fs *ff)
+{
+	return fuse4fs_iomap_enabled(ff) &&
+	       (ff->iomap_cap & FUSE_IOMAP_SUPPORT_ATOMIC) &&
+#ifdef STATX_WRITE_ATOMIC
+		ff->awu_min > 0 && ff->awu_min > 0;
+#else
+		0;
+#endif
+}
 #else
 # define fuse4fs_iomap_enabled(...)	(0)
 # define fuse4fs_discover_iomap(...)	((void)0)
 # define fuse4fs_can_iomap(...)		(false)
+# define fuse4fs_iomap_supports_hw_atomic(...)	(0)
 #endif
 
 static inline void fuse4fs_dump_extents(struct fuse4fs *ff, ext2_ino_t ino,
@@ -2115,8 +2130,12 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 
 	fstat->iflags = 0;
 #ifdef HAVE_FUSE_IOMAP
-	if (fuse4fs_iomap_enabled(ff))
+	if (fuse4fs_iomap_enabled(ff)) {
 		fstat->iflags |= FUSE_IFLAG_IOMAP | FUSE_IFLAG_EXCLUSIVE;
+
+		if (fuse4fs_iomap_supports_hw_atomic(ff))
+			fstat->iflags |= FUSE_IFLAG_ATOMIC;
+	}
 #endif
 
 	return 0;
@@ -2294,6 +2313,15 @@ static int fuse4fs_statx(struct fuse4fs *ff, ext2_ino_t ino, int statx_mask,
 
 	fuse4fs_statx_directio(ff, stx);
 
+#ifdef STATX_WRITE_ATOMIC
+	if (fuse4fs_iomap_supports_hw_atomic(ff)) {
+		stx->stx_mask |= STATX_WRITE_ATOMIC;
+		stx->stx_atomic_write_unit_min = ff->awu_min;
+		stx->stx_atomic_write_unit_max = ff->awu_max;
+		stx->stx_atomic_write_segments_max = 1;
+	}
+#endif
+
 	return 0;
 }
 
@@ -6680,6 +6708,9 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 		}
 	}
 
+	if (opflags & FUSE_IOMAP_OP_ATOMIC)
+		read.flags |= FUSE_IOMAP_F_ATOMIC_BIO;
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
@@ -6844,6 +6875,38 @@ static int fuse4fs_set_bdev_blocksize(struct fuse4fs *ff, int fd)
 	return -EIO;
 }
 
+#ifdef STATX_WRITE_ATOMIC
+static void fuse4fs_configure_atomic_write(struct fuse4fs *ff, int bdev_fd)
+{
+	struct statx devx;
+	unsigned int awu_min, awu_max;
+	int ret;
+
+	if (!ext2fs_has_feature_extents(ff->fs->super))
+		return;
+
+	ret = statx(bdev_fd, "", AT_EMPTY_PATH, STATX_WRITE_ATOMIC, &devx);
+	if (ret)
+		return;
+	if (!(devx.stx_mask & STATX_WRITE_ATOMIC))
+		return;
+
+	awu_min = max(ff->fs->blocksize, devx.stx_atomic_write_unit_min);
+	awu_max = min(ff->fs->blocksize, devx.stx_atomic_write_unit_max);
+	if (awu_min > awu_max)
+		return;
+
+	log_printf(ff, "%s awu_min: %u, awu_max: %u\n",
+		   _("Supports (experimental) DIO atomic writes"),
+		   awu_min, awu_max);
+
+	ff->awu_min = awu_min;
+	ff->awu_max = awu_max;
+}
+#else
+# define fuse4fs_configure_atomic_write(...)	((void)0)
+#endif
+
 static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 {
 	errcode_t err;
@@ -6868,6 +6931,8 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
 		   __func__, fd, ff->iomap_dev);
 
+	fuse4fs_configure_atomic_write(ff, fd);
+
 	ff->iomap_dev = ret;
 	return 0;
 }
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f6f0eb9f54c7bf..6266c1de163694 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -279,6 +279,9 @@ struct fuse2fs {
 	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
 	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
 				      int inuse);
+#ifdef STATX_WRITE_ATOMIC
+	unsigned int awu_min, awu_max;
+#endif
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -749,10 +752,22 @@ static inline bool fuse2fs_can_iomap(const struct fuse2fs *ff)
 {
 	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
 }
+
+static inline bool fuse2fs_iomap_supports_hw_atomic(const struct fuse2fs *ff)
+{
+	return fuse2fs_iomap_enabled(ff) &&
+	       (ff->iomap_cap & FUSE_IOMAP_SUPPORT_ATOMIC) &&
+#ifdef STATX_WRITE_ATOMIC
+		ff->awu_min > 0 && ff->awu_min > 0;
+#else
+		0;
+#endif
+}
 #else
 # define fuse2fs_iomap_enabled(...)	(0)
 # define fuse2fs_discover_iomap(...)	((void)0)
 # define fuse2fs_can_iomap(...)		(false)
+# define fuse2fs_iomap_supports_hw_atomic(...)	(0)
 #endif
 
 static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
@@ -1986,14 +2001,19 @@ static int op_getattr(const char *path, struct stat *statbuf,
 static int op_getattr_iflags(const char *path, struct stat *statbuf,
 			     unsigned int *iflags, struct fuse_file_info *fi)
 {
+	struct fuse2fs *ff = fuse2fs_get();
 	int ret = op_getattr(path, statbuf, fi);
 
 	if (ret)
 		return ret;
 
-	if (fuse_fs_can_enable_iomap(statbuf))
+	if (fuse_fs_can_enable_iomap(statbuf)) {
 		*iflags |= FUSE_IFLAG_IOMAP | FUSE_IFLAG_EXCLUSIVE;
 
+		if (fuse2fs_iomap_supports_hw_atomic(ff))
+			*iflags |= FUSE_IFLAG_ATOMIC;
+	}
+
 	return 0;
 }
 #endif
@@ -2102,6 +2122,16 @@ static int fuse2fs_statx(struct fuse2fs *ff, ext2_ino_t ino, int statx_mask,
 
 	fuse2fs_statx_directio(ff, stx);
 
+#ifdef STATX_WRITE_ATOMIC
+	if (fuse_fs_can_enable_iomapx(stx) &&
+	    fuse2fs_iomap_supports_hw_atomic(ff)) {
+		stx->stx_mask |= STATX_WRITE_ATOMIC;
+		stx->stx_atomic_write_unit_min = ff->awu_min;
+		stx->stx_atomic_write_unit_max = ff->awu_max;
+		stx->stx_atomic_write_segments_max = 1;
+	}
+#endif
+
 	return 0;
 }
 
@@ -6211,6 +6241,9 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		}
 	}
 
+	if (opflags & FUSE_IOMAP_OP_ATOMIC)
+		read->flags |= FUSE_IOMAP_F_ATOMIC_BIO;
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -6372,6 +6405,38 @@ static int fuse2fs_set_bdev_blocksize(struct fuse2fs *ff, int fd)
 	return -EIO;
 }
 
+#ifdef STATX_WRITE_ATOMIC
+static void fuse2fs_configure_atomic_write(struct fuse2fs *ff, int bdev_fd)
+{
+	struct statx devx;
+	unsigned int awu_min, awu_max;
+	int ret;
+
+	if (!ext2fs_has_feature_extents(ff->fs->super))
+		return;
+
+	ret = statx(bdev_fd, "", AT_EMPTY_PATH, STATX_WRITE_ATOMIC, &devx);
+	if (ret)
+		return;
+	if (!(devx.stx_mask & STATX_WRITE_ATOMIC))
+		return;
+
+	awu_min = max(ff->fs->blocksize, devx.stx_atomic_write_unit_min);
+	awu_max = min(ff->fs->blocksize, devx.stx_atomic_write_unit_max);
+	if (awu_min > awu_max)
+		return;
+
+	log_printf(ff, "%s awu_min: %u, awu_max: %u\n",
+		   _("Supports (experimental) DIO atomic writes"),
+		   awu_min, awu_max);
+
+	ff->awu_min = awu_min;
+	ff->awu_max = awu_max;
+}
+#else
+# define fuse2fs_configure_atomic_write(...)	((void)0)
+#endif
+
 static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 {
 	errcode_t err;
@@ -6396,6 +6461,8 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
 		   __func__, fd, ff->iomap_dev);
 
+	fuse2fs_configure_atomic_write(ff, fd);
+
 	ff->iomap_dev = ret;
 	return 0;
 }


