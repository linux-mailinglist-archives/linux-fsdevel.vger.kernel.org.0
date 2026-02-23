Return-Path: <linux-fsdevel+bounces-78182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFATHWnmnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:44:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D052017FDF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6068630DC0E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCD837FF69;
	Mon, 23 Feb 2026 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqkoebRs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6037B41C;
	Mon, 23 Feb 2026 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890219; cv=none; b=DbFhArxZpA1IdnGOjTP2J/Q8gj2Ollhu95ER5N74ER+KYsSqW3CzovsCdzc0jnd5BaVvEUzJ4HwA1ECE2k9PWvBhQBclmBwN/w1X5L5RTf0rMp6kP8lftnOEyMmcnJOJlPq3zC+Z6aSZKFu6kui7RTTXPWz8vLNus6AwpiAvHQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890219; c=relaxed/simple;
	bh=pCfpQMTId0VsMv9QqbJoHDXd8kNYV36i0EXzrGV2A4A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VA4TEWknzAkJKc7kYvhqorOoyiL9MA+kafmJK8VvCDoKu2Menb//+UCJBbocF38qC5jzncdOyT30iOSO8nKj4EpsJ1M1le7OuejOnN8KUL5rAAkAnejG5kGaZ7ojKU+Knbe7uUh1WaCYcTyep6YsImSIMYcvrTMX4U4zU0/Up2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqkoebRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB0DC116C6;
	Mon, 23 Feb 2026 23:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890218;
	bh=pCfpQMTId0VsMv9QqbJoHDXd8kNYV36i0EXzrGV2A4A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bqkoebRswiNSpV7c8fUaGycB2M5Pcfkp59wizV7WWzq+QIM5+poQZh3F7+eMg0RRt
	 V2wptHcKn/hu0RHNgQX1tlCNn579UBSIaJte8gaNuqZt/LZnWWYEtSWsLOZ5d3XgJT
	 xY4378RVK0p4s7dbpH4he00s37ufqGPZxeHgXH4n64eIdCy0yLZZxeYnVkqn16ub9o
	 tvosvlr8AS2rc03on8R1TOB/FpcRXOmSMC0e7T/xc94mOz0KxGKsBhM4sDYBZ1DkTC
	 bhr/0/CovYHkKRuzEfhtK3kAUtT3hFDxKf7+YYqwC93ZhDacOwHipfnCU2k68CFukv
	 tSMnqGL9/Ujrg==
Date: Mon, 23 Feb 2026 15:43:38 -0800
Subject: [PATCH 09/10] fuse2fs: set sync, immutable,
 and append at file load time
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745342.3944028.16772034955439357128.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
References: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78182-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: D052017FDF4
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Convey these three inode flags to the kernel when we're loading a file.
This way the kernel can advertise and enforce those flags so that the
fuse server doesn't have to.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   16 ++++++++++++++++
 misc/fuse2fs.c    |   53 ++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 15 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 3d48eb79948ad3..8ba904ec2fc9d9 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -2162,6 +2162,22 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
 
 	fstat->iflags = 0;
+
+#ifdef FUSE_IFLAG_SYNC
+	if (inodep->i_flags & EXT2_SYNC_FL)
+		fstat->iflags |= FUSE_IFLAG_SYNC;
+#endif
+
+#ifdef FUSE_IFLAG_IMMUTABLE
+	if (inodep->i_flags & EXT2_IMMUTABLE_FL)
+		fstat->iflags |= FUSE_IFLAG_IMMUTABLE;
+#endif
+
+#ifdef FUSE_IFLAG_APPEND
+	if (inodep->i_flags & EXT2_APPEND_FL)
+		fstat->iflags |= FUSE_IFLAG_APPEND;
+#endif
+
 #ifdef HAVE_FUSE_IOMAP
 	if (fuse4fs_iomap_enabled(ff)) {
 		fstat->iflags |= FUSE_IFLAG_IOMAP | FUSE_IFLAG_EXCLUSIVE;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f7c759ed86c7fb..58ea8e1f2f1e51 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1947,7 +1947,7 @@ static void *op_init(struct fuse_conn_info *conn,
 }
 
 static int fuse2fs_stat(struct fuse2fs *ff, ext2_ino_t ino,
-			struct stat *statbuf)
+			struct stat *statbuf, unsigned int *iflags)
 {
 	struct ext2_inode_large inode;
 	ext2_filsys fs = ff->fs;
@@ -2004,6 +2004,7 @@ static int fuse2fs_stat(struct fuse2fs *ff, ext2_ino_t ino,
 			statbuf->st_rdev = inode.i_block[1];
 	}
 
+	*iflags = inode.i_flags;
 	return ret;
 }
 
@@ -2038,22 +2039,31 @@ static int __fuse2fs_file_ino(struct fuse2fs *ff, const char *path,
 # define fuse2fs_file_ino(ff, path, fp, inop) \
 	__fuse2fs_file_ino((ff), (path), (fp), (inop), __func__, __LINE__)
 
+static int fuse2fs_getattr(struct fuse2fs *ff, const char *path,
+			   struct stat *statbuf, struct fuse_file_info *fi,
+			   unsigned int *iflags)
+{
+	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	fuse2fs_start(ff);
+	ret = fuse2fs_file_ino(ff, path, fi, &ino);
+	if (ret)
+		goto out;
+	ret = fuse2fs_stat(ff, ino, statbuf, iflags);
+out:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+
 static int op_getattr(const char *path, struct stat *statbuf,
 		      struct fuse_file_info *fi)
 {
 	struct fuse2fs *ff = fuse2fs_get();
-	ext2_ino_t ino;
-	int ret = 0;
+	unsigned int dontcare;
 
-	FUSE2FS_CHECK_CONTEXT(ff);
-	fuse2fs_start(ff);
-	ret = fuse2fs_file_ino(ff, path, fi, &ino);
-	if (ret)
-		goto out;
-	ret = fuse2fs_stat(ff, ino, statbuf);
-out:
-	fuse2fs_finish(ff, ret);
-	return ret;
+	return fuse2fs_getattr(ff, path, statbuf, fi, &dontcare);
 }
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
@@ -2061,11 +2071,21 @@ static int op_getattr_iflags(const char *path, struct stat *statbuf,
 			     unsigned int *iflags, struct fuse_file_info *fi)
 {
 	struct fuse2fs *ff = fuse2fs_get();
-	int ret = op_getattr(path, statbuf, fi);
+	unsigned int i_flags;
+	int ret = fuse2fs_getattr(ff, path, statbuf, fi, &i_flags);
 
 	if (ret)
 		return ret;
 
+	if (i_flags & EXT2_SYNC_FL)
+		*iflags |= FUSE_IFLAG_SYNC;
+
+	if (i_flags & EXT2_IMMUTABLE_FL)
+		*iflags |= FUSE_IFLAG_IMMUTABLE;
+
+	if (i_flags & EXT2_APPEND_FL)
+		*iflags |= FUSE_IFLAG_APPEND;
+
 	if (fuse_fs_can_enable_iomap(statbuf)) {
 		*iflags |= FUSE_IFLAG_IOMAP | FUSE_IFLAG_EXCLUSIVE;
 
@@ -3835,12 +3855,13 @@ static int fuse2fs_punch_posteof(struct fuse2fs *ff, ext2_ino_t ino,
 static int fuse2fs_file_uses_iomap(struct fuse2fs *ff, ext2_ino_t ino)
 {
 	struct stat statbuf;
+	unsigned int dontcare;
 	int ret;
 
 	if (!fuse2fs_iomap_enabled(ff))
 		return 0;
 
-	ret = fuse2fs_stat(ff, ino, &statbuf);
+	ret = fuse2fs_stat(ff, ino, &statbuf, &dontcare);
 	if (ret)
 		return ret;
 
@@ -4749,7 +4770,9 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 			(unsigned long long)i->dirpos);
 
 	if (i->flags == FUSE_READDIR_PLUS) {
-		ret = fuse2fs_stat(i->ff, dirent->inode, &stat);
+		unsigned int dontcare;
+
+		ret = fuse2fs_stat(i->ff, dirent->inode, &stat, &dontcare);
 		if (ret)
 			return DIRENT_ABORT;
 	}


