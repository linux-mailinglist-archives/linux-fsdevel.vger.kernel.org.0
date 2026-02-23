Return-Path: <linux-fsdevel+bounces-78155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oND6DODknGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:38:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C64217FA96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C0EE304C48E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E9D37F8DF;
	Mon, 23 Feb 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo0JootQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394037F8A7;
	Mon, 23 Feb 2026 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889810; cv=none; b=dEJc4dAJVVR/d9LGi5KRg6RqXvLab+PKetBE1Swnf1dkgNxz+PhWQbe15XoaVFd2ExqlGk7lq34G7vKBY6DOpJYugn1ndMG1rj5/Xd5Zdqr/rEj/M6cy9H90+dJ6osmjEh1oiiIYdL1YyUF+PE69KzCzlZSh/uXK0Ot7ih6YViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889810; c=relaxed/simple;
	bh=e0x5jqNEq6qd7ewbxbutijHudDqaYzd6qshJY9UyHQs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgK9pmx/XSey+LJG13iSNeSnk7XhWqlhUx0vZpySLFbG9uN5PYBZHStKwmRRutVbqqLFn2jNN4js39018pB7bOgDwLkk740VxXyAWczcNWSdZURHMIqxPi7FJvuS6LhN8QNA0j6/x39HFkgFtx8lQ4CalL11918DX1QMhRMDMPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo0JootQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE19C116C6;
	Mon, 23 Feb 2026 23:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889809;
	bh=e0x5jqNEq6qd7ewbxbutijHudDqaYzd6qshJY9UyHQs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Oo0JootQoTdTDr83fSgYVi+2pMJKOuowZz6pw9KySKxGTovLum8+4LYfR3wtUPrt5
	 X+Yo6f8UaPVz58EGiea/U+Ydgf7BvPalF90MxTNeNj0QEDoP/KchW15LbEkzIe2/x8
	 S10rCCt972KCyA2ildvqGi+UqIeg3KsuBx8t1Oa3g4hRjlJ+P8IKWAqHkjLybRGLuI
	 CPSpiCzF+ZwjzGnZbIP0Nl/xq9dATXbSQ2RnJuXtet6CEvw+yj/3GupmpgtuxsAfy9
	 kLSVFQ/5p+tl9GrlYVyV6zOL2DIJCPUWMGtL3TuoqMebC3PP2GD4wrwQn/xIhriJtn
	 H/Mpu1dpH9kkg==
Date: Mon, 23 Feb 2026 15:36:49 -0800
Subject: [PATCH 03/19] fuse2fs: implement iomap configuration
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744535.3943178.12083104100284059440.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78155-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C64217FA96
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Upload the filesystem geometry to the kernel when asked.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   96 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 misc/fuse2fs.c    |   96 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 186 insertions(+), 6 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index d5476eb0ab90a4..617ef259133cba 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -196,6 +196,10 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 # define FL_ZERO_RANGE_FLAG (0)
 #endif
 
+#ifndef NSEC_PER_SEC
+# define NSEC_PER_SEC	(1000000000L)
+#endif
+
 errcode_t ext2fs_check_ext3_journal(ext2_filsys fs);
 errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
 
@@ -967,9 +971,9 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
 	get_now(&now);
 
-	datime = atime.tv_sec + ((double)atime.tv_nsec / 1000000000);
-	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / 1000000000);
-	dnow = now.tv_sec + ((double)now.tv_nsec / 1000000000);
+	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
+	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
+	dnow = now.tv_sec + ((double)now.tv_nsec / NSEC_PER_SEC);
 
 	/*
 	 * If atime is newer than mtime and atime hasn't been updated in thirty
@@ -6240,6 +6244,91 @@ static void op_iomap_end(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 
 	fuse_reply_err(req, 0);
 }
+
+/*
+ * Maximal extent format file size.
+ * Resulting logical blkno at s_maxbytes must fit in our on-disk
+ * extent format containers, within a sector_t, and within i_blocks
+ * in the vfs.  ext4 inode has 48 bits of i_block in fsblock units,
+ * so that won't be a limiting factor.
+ *
+ * However there is other limiting factor. We do store extents in the form
+ * of starting block and length, hence the resulting length of the extent
+ * covering maximum file size must fit into on-disk format containers as
+ * well. Given that length is always by 1 unit bigger than max unit (because
+ * we count 0 as well) we have to lower the s_maxbytes by one fs block.
+ *
+ * Note, this does *not* consider any metadata overhead for vfs i_blocks.
+ */
+static off_t fuse4fs_max_size(struct fuse4fs *ff, off_t upper_limit)
+{
+	off_t res;
+
+	if (!ext2fs_has_feature_huge_file(ff->fs->super)) {
+		upper_limit = (1LL << 32) - 1;
+
+		/* total blocks in file system block size */
+		upper_limit >>= (ff->blocklog - 9);
+		upper_limit <<= ff->blocklog;
+	}
+
+	/*
+	 * 32-bit extent-start container, ee_block. We lower the maxbytes
+	 * by one fs block, so ee_len can cover the extent of maximum file
+	 * size
+	 */
+	res = (1LL << 32) - 1;
+	res <<= ff->blocklog;
+
+	/* Sanity check against vm- & vfs- imposed limits */
+	if (res > upper_limit)
+		res = upper_limit;
+
+	return res;
+}
+
+static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
+{
+	struct fuse_iomap_config cfg = { };
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+
+	dbg_printf(ff, "%s: flags=0x%llx maxbytes=0x%llx\n", __func__,
+		   (unsigned long long)flags,
+		   (unsigned long long)maxbytes);
+	fs = fuse4fs_start(ff);
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_UUID;
+	memcpy(cfg.s_uuid, fs->super->s_uuid, sizeof(cfg.s_uuid));
+	cfg.s_uuid_len = sizeof(fs->super->s_uuid);
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_BLOCKSIZE;
+	cfg.s_blocksize = FUSE4FS_FSB_TO_B(ff, 1);
+
+	/*
+	 * If there inode is large enough to house i_[acm]time_extra then we
+	 * can turn on nanosecond timestamps; i_crtime was the next field added
+	 * after i_atime_extra.
+	 */
+	cfg.flags |= FUSE_IOMAP_CONFIG_TIME;
+	if (fs->super->s_inode_size >=
+	    offsetof(struct ext2_inode_large, i_crtime)) {
+		cfg.s_time_gran = 1;
+		cfg.s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
+	} else {
+		cfg.s_time_gran = NSEC_PER_SEC;
+		cfg.s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
+	}
+	cfg.s_time_min = EXT4_TIMESTAMP_MIN;
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
+	cfg.s_maxbytes = fuse4fs_max_size(ff, maxbytes);
+
+	fuse4fs_finish(ff, 0);
+	fuse_reply_iomap_config(req, &cfg);
+}
 #endif /* HAVE_FUSE_IOMAP */
 
 static struct fuse_lowlevel_ops fs_ops = {
@@ -6288,6 +6377,7 @@ static struct fuse_lowlevel_ops fs_ops = {
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
+	.iomap_config = op_iomap_config,
 #endif /* HAVE_FUSE_IOMAP */
 };
 
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fafd99aa64e911..45ac61ff02957b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -190,6 +190,10 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 # define FL_ZERO_RANGE_FLAG (0)
 #endif
 
+#ifndef NSEC_PER_SEC
+# define NSEC_PER_SEC	(1000000000L)
+#endif
+
 errcode_t ext2fs_check_ext3_journal(ext2_filsys fs);
 errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
 
@@ -805,9 +809,9 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
 	get_now(&now);
 
-	datime = atime.tv_sec + ((double)atime.tv_nsec / 1000000000);
-	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / 1000000000);
-	dnow = now.tv_sec + ((double)now.tv_nsec / 1000000000);
+	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
+	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
+	dnow = now.tv_sec + ((double)now.tv_nsec / NSEC_PER_SEC);
 
 	/*
 	 * If atime is newer than mtime and atime hasn't been updated in thirty
@@ -5684,6 +5688,91 @@ static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
 
 	return 0;
 }
+
+/*
+ * Maximal extent format file size.
+ * Resulting logical blkno at s_maxbytes must fit in our on-disk
+ * extent format containers, within a sector_t, and within i_blocks
+ * in the vfs.  ext4 inode has 48 bits of i_block in fsblock units,
+ * so that won't be a limiting factor.
+ *
+ * However there is other limiting factor. We do store extents in the form
+ * of starting block and length, hence the resulting length of the extent
+ * covering maximum file size must fit into on-disk format containers as
+ * well. Given that length is always by 1 unit bigger than max unit (because
+ * we count 0 as well) we have to lower the s_maxbytes by one fs block.
+ *
+ * Note, this does *not* consider any metadata overhead for vfs i_blocks.
+ */
+static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
+{
+	off_t res;
+
+	if (!ext2fs_has_feature_huge_file(ff->fs->super)) {
+		upper_limit = (1LL << 32) - 1;
+
+		/* total blocks in file system block size */
+		upper_limit >>= (ff->blocklog - 9);
+		upper_limit <<= ff->blocklog;
+	}
+
+	/*
+	 * 32-bit extent-start container, ee_block. We lower the maxbytes
+	 * by one fs block, so ee_len can cover the extent of maximum file
+	 * size
+	 */
+	res = (1LL << 32) - 1;
+	res <<= ff->blocklog;
+
+	/* Sanity check against vm- & vfs- imposed limits */
+	if (res > upper_limit)
+		res = upper_limit;
+
+	return res;
+}
+
+static int op_iomap_config(uint64_t flags, off_t maxbytes,
+			   struct fuse_iomap_config *cfg)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	ext2_filsys fs;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+
+	dbg_printf(ff, "%s: flags=0x%llx maxbytes=0x%llx\n", __func__,
+		   (unsigned long long)flags,
+		   (unsigned long long)maxbytes);
+	fs = fuse2fs_start(ff);
+
+	cfg->flags |= FUSE_IOMAP_CONFIG_UUID;
+	memcpy(cfg->s_uuid, fs->super->s_uuid, sizeof(cfg->s_uuid));
+	cfg->s_uuid_len = sizeof(fs->super->s_uuid);
+
+	cfg->flags |= FUSE_IOMAP_CONFIG_BLOCKSIZE;
+	cfg->s_blocksize = FUSE2FS_FSB_TO_B(ff, 1);
+
+	/*
+	 * If there inode is large enough to house i_[acm]time_extra then we
+	 * can turn on nanosecond timestamps; i_crtime was the next field added
+	 * after i_atime_extra.
+	 */
+	cfg->flags |= FUSE_IOMAP_CONFIG_TIME;
+	if (fs->super->s_inode_size >=
+	    offsetof(struct ext2_inode_large, i_crtime)) {
+		cfg->s_time_gran = 1;
+		cfg->s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
+	} else {
+		cfg->s_time_gran = NSEC_PER_SEC;
+		cfg->s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
+	}
+	cfg->s_time_min = EXT4_TIMESTAMP_MIN;
+
+	cfg->flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
+	cfg->s_maxbytes = fuse2fs_max_size(ff, maxbytes);
+
+	fuse2fs_finish(ff, 0);
+	return 0;
+}
 #endif /* HAVE_FUSE_IOMAP */
 
 static struct fuse_operations fs_ops = {
@@ -5730,6 +5819,7 @@ static struct fuse_operations fs_ops = {
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
+	.iomap_config = op_iomap_config,
 #endif /* HAVE_FUSE_IOMAP */
 };
 


