Return-Path: <linux-fsdevel+bounces-78168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLMFCzPmnGlxMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:43:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E117FD69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7088830967DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C237FF4A;
	Mon, 23 Feb 2026 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFTDLNwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E91E9906;
	Mon, 23 Feb 2026 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890015; cv=none; b=AXFYI+HD8gkxa+xQD27OPccfVPfsE0CIn9YxSga3wf1cYZAsPSzTUhdrRIkzs+slG/5bA9ue0H1nmVNsJmuSWm/lhClCjs3JhwHjXzSdnc4qLicaFKM5CvqiIJvd+TplEtB7+CVjkkFoLBrrCVDgWMcO0oeTU5mNSZz1hHGMDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890015; c=relaxed/simple;
	bh=Q3U8rPtW/sgM9nnMEZSMgV6ofowe0t5L8H8yJoRVK9c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNr4Jw1vRiqfdm3LmdmlZF6foCxs5b+vLFJqG/5cI5fC5WFqZNKGDDUANqUUq2I6fwzgFVqy77t2B9bzCFm9MJnQMjxWqO692SxihIG0QfgTqE7d3SlH3qc43j+k92g9ADJ4d/9gCXKNSGQ5rJbOMq7lf6uTlfkkhgUjBHJ6iUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFTDLNwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5637C2BC87;
	Mon, 23 Feb 2026 23:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890014;
	bh=Q3U8rPtW/sgM9nnMEZSMgV6ofowe0t5L8H8yJoRVK9c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sFTDLNwmdVy12G6wOa8iUN0244Z3rKnJ0DfDUDnc6uIaMsce1KbfiG95hGgzstdqN
	 sEhkXF69yroNVH0Hw/vAMCsDceBplE0JvKumIzLFvOj9vvw0UqCEs+4XvO1Aszyx6t
	 xDl79z1vTWSGUktFCk5xCRgfZI6pff9sTyXKEhvP+3cG7wNv5DbJXOga4cE63z/THI
	 pyPV8X/n5w5nYBbdX/JCow7Z03vIIiJ0YFsgAzrlT1L1tiAUwGG2f46nohpKMJVdd9
	 JRkqb1VQvG2v2qwTvQq0GTdSdaMojyVeAKzGHGtaAknoOAkr/Bf8iqiC0rn5IsMNT3
	 SICyGPY5lzosg==
Date: Mon, 23 Feb 2026 15:40:14 -0800
Subject: [PATCH 16/19] fuse2fs: implement statx
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744769.3943178.8350488145026595053.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78168-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: D42E117FD69
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Implement statx.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |  136 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |  131 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 267 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 90b365149910c9..62ab8f618015e9 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -24,6 +24,7 @@
 #include <sys/xattr.h>
 #endif
 #include <sys/ioctl.h>
+#include <sys/sysmacros.h>
 #include <unistd.h>
 #include <ctype.h>
 #include <assert.h>
@@ -2189,6 +2190,138 @@ static void op_getattr(fuse_req_t req, fuse_ino_t fino,
 				       fstat.entry.attr_timeout);
 }
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18) && defined(STATX_BASIC_STATS)
+static inline void fuse4fs_set_statx_attr(struct statx *stx,
+					  uint64_t statx_flag, int set)
+{
+	if (set)
+		stx->stx_attributes |= statx_flag;
+	stx->stx_attributes_mask |= statx_flag;
+}
+
+static void fuse4fs_statx_directio(struct fuse4fs *ff, struct statx *stx)
+{
+	struct statx devx;
+	errcode_t err;
+	int fd;
+
+	err = io_channel_get_fd(ff->fs->io, &fd);
+	if (err)
+		return;
+
+	err = statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &devx);
+	if (err)
+		return;
+	if (!(devx.stx_mask & STATX_DIOALIGN))
+		return;
+
+	stx->stx_mask |= STATX_DIOALIGN;
+	stx->stx_dio_mem_align = devx.stx_dio_mem_align;
+	stx->stx_dio_offset_align = devx.stx_dio_offset_align;
+}
+
+static int fuse4fs_statx(struct fuse4fs *ff, ext2_ino_t ino, int statx_mask,
+			 struct statx *stx)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;;
+	dev_t fakedev = 0;
+	errcode_t err;
+	struct timespec tv;
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	memcpy(&fakedev, fs->super->s_uuid, sizeof(fakedev));
+	stx->stx_mask = STATX_BASIC_STATS;
+	stx->stx_dev_major = major(fakedev);
+	stx->stx_dev_minor = minor(fakedev);
+	stx->stx_ino = ino;
+	stx->stx_mode = inode.i_mode;
+	stx->stx_nlink = inode.i_links_count;
+	stx->stx_uid = inode_uid(inode);
+	stx->stx_gid = inode_gid(inode);
+	stx->stx_size = EXT2_I_SIZE(&inode);
+	stx->stx_blksize = fs->blocksize;
+	stx->stx_blocks = ext2fs_get_stat_i_blocks(fs,
+						EXT2_INODE(&inode));
+	EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
+	stx->stx_atime.tv_sec = tv.tv_sec;
+	stx->stx_atime.tv_nsec = tv.tv_nsec;
+
+	EXT4_INODE_GET_XTIME(i_mtime, &tv, &inode);
+	stx->stx_mtime.tv_sec = tv.tv_sec;
+	stx->stx_mtime.tv_nsec = tv.tv_nsec;
+
+	EXT4_INODE_GET_XTIME(i_ctime, &tv, &inode);
+	stx->stx_ctime.tv_sec = tv.tv_sec;
+	stx->stx_ctime.tv_nsec = tv.tv_nsec;
+
+	if (EXT4_FITS_IN_INODE(&inode, i_crtime)) {
+		stx->stx_mask |= STATX_BTIME;
+		EXT4_INODE_GET_XTIME(i_crtime, &tv, &inode);
+		stx->stx_btime.tv_sec = tv.tv_sec;
+		stx->stx_btime.tv_nsec = tv.tv_nsec;
+	}
+
+	dbg_printf(ff, "%s: ino=%d atime=%lld.%d mtime=%lld.%d ctime=%lld.%d btime=%lld.%d\n",
+		   __func__, ino,
+		   (long long int)stx->stx_atime.tv_sec, stx->stx_atime.tv_nsec,
+		   (long long int)stx->stx_mtime.tv_sec, stx->stx_mtime.tv_nsec,
+		   (long long int)stx->stx_ctime.tv_sec, stx->stx_ctime.tv_nsec,
+		   (long long int)stx->stx_btime.tv_sec, stx->stx_btime.tv_nsec);
+
+	if (LINUX_S_ISCHR(inode.i_mode) ||
+	    LINUX_S_ISBLK(inode.i_mode)) {
+		if (inode.i_block[0]) {
+			stx->stx_rdev_major = major(inode.i_block[0]);
+			stx->stx_rdev_minor = minor(inode.i_block[0]);
+		} else {
+			stx->stx_rdev_major = major(inode.i_block[1]);
+			stx->stx_rdev_minor = minor(inode.i_block[1]);
+		}
+	}
+
+	fuse4fs_set_statx_attr(stx, STATX_ATTR_COMPRESSED,
+			       inode.i_flags & EXT2_COMPR_FL);
+	fuse4fs_set_statx_attr(stx, STATX_ATTR_IMMUTABLE,
+			       inode.i_flags & EXT2_IMMUTABLE_FL);
+	fuse4fs_set_statx_attr(stx, STATX_ATTR_APPEND,
+			       inode.i_flags & EXT2_APPEND_FL);
+	fuse4fs_set_statx_attr(stx, STATX_ATTR_NODUMP,
+			       inode.i_flags & EXT2_NODUMP_FL);
+
+	fuse4fs_statx_directio(ff, stx);
+
+	return 0;
+}
+
+static void op_statx(fuse_req_t req, fuse_ino_t fino, int flags, int mask,
+		     struct fuse_file_info *fi)
+{
+	struct statx stx = { };
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+	fuse4fs_start(ff);
+	ret = fuse4fs_statx(ff, ino, mask, &stx);
+	if (ret)
+		goto out;
+out:
+	fuse4fs_finish(ff, ret);
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_statx(req, 0, &stx, FUSE4FS_ATTR_TIMEOUT);
+}
+#else
+# define op_statx		NULL
+#endif
+
 static void op_readlink(fuse_req_t req, fuse_ino_t fino)
 {
 	struct ext2_inode inode;
@@ -7260,6 +7393,9 @@ static struct fuse_lowlevel_ops fs_ops = {
 #ifdef SUPPORT_FALLOCATE
 	.fallocate = op_fallocate,
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
+	.statx = op_statx,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ffcaf56314bdfd..f6f0eb9f54c7bf 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -23,6 +23,7 @@
 #include <sys/xattr.h>
 #endif
 #include <sys/ioctl.h>
+#include <sys/sysmacros.h>
 #include <unistd.h>
 #include <ctype.h>
 #ifdef HAVE_FUSE_LOOPDEV
@@ -1997,6 +1998,133 @@ static int op_getattr_iflags(const char *path, struct stat *statbuf,
 }
 #endif
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18) && defined(STATX_BASIC_STATS)
+static inline void fuse2fs_set_statx_attr(struct statx *stx,
+					  uint64_t statx_flag, int set)
+{
+	if (set)
+		stx->stx_attributes |= statx_flag;
+	stx->stx_attributes_mask |= statx_flag;
+}
+
+static void fuse2fs_statx_directio(struct fuse2fs *ff, struct statx *stx)
+{
+	struct statx devx;
+	errcode_t err;
+	int fd;
+
+	err = io_channel_get_fd(ff->fs->io, &fd);
+	if (err)
+		return;
+
+	err = statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &devx);
+	if (err)
+		return;
+	if (!(devx.stx_mask & STATX_DIOALIGN))
+		return;
+
+	stx->stx_mask |= STATX_DIOALIGN;
+	stx->stx_dio_mem_align = devx.stx_dio_mem_align;
+	stx->stx_dio_offset_align = devx.stx_dio_offset_align;
+}
+
+static int fuse2fs_statx(struct fuse2fs *ff, ext2_ino_t ino, int statx_mask,
+			 struct statx *stx)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;;
+	dev_t fakedev = 0;
+	errcode_t err;
+	struct timespec tv;
+
+	err = fuse2fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	memcpy(&fakedev, fs->super->s_uuid, sizeof(fakedev));
+	stx->stx_mask = STATX_BASIC_STATS;
+	stx->stx_dev_major = major(fakedev);
+	stx->stx_dev_minor = minor(fakedev);
+	stx->stx_ino = ino;
+	stx->stx_mode = inode.i_mode;
+	stx->stx_nlink = inode.i_links_count;
+	stx->stx_uid = inode_uid(inode);
+	stx->stx_gid = inode_gid(inode);
+	stx->stx_size = EXT2_I_SIZE(&inode);
+	stx->stx_blksize = fs->blocksize;
+	stx->stx_blocks = ext2fs_get_stat_i_blocks(fs,
+						EXT2_INODE(&inode));
+	EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
+	stx->stx_atime.tv_sec = tv.tv_sec;
+	stx->stx_atime.tv_nsec = tv.tv_nsec;
+
+	EXT4_INODE_GET_XTIME(i_mtime, &tv, &inode);
+	stx->stx_mtime.tv_sec = tv.tv_sec;
+	stx->stx_mtime.tv_nsec = tv.tv_nsec;
+
+	EXT4_INODE_GET_XTIME(i_ctime, &tv, &inode);
+	stx->stx_ctime.tv_sec = tv.tv_sec;
+	stx->stx_ctime.tv_nsec = tv.tv_nsec;
+
+	if (EXT4_FITS_IN_INODE(&inode, i_crtime)) {
+		stx->stx_mask |= STATX_BTIME;
+		EXT4_INODE_GET_XTIME(i_crtime, &tv, &inode);
+		stx->stx_btime.tv_sec = tv.tv_sec;
+		stx->stx_btime.tv_nsec = tv.tv_nsec;
+	}
+
+	dbg_printf(ff, "%s: ino=%d atime=%lld.%d mtime=%lld.%d ctime=%lld.%d btime=%lld.%d\n",
+		   __func__, ino,
+		   (long long int)stx->stx_atime.tv_sec, stx->stx_atime.tv_nsec,
+		   (long long int)stx->stx_mtime.tv_sec, stx->stx_mtime.tv_nsec,
+		   (long long int)stx->stx_ctime.tv_sec, stx->stx_ctime.tv_nsec,
+		   (long long int)stx->stx_btime.tv_sec, stx->stx_btime.tv_nsec);
+
+	if (LINUX_S_ISCHR(inode.i_mode) ||
+	    LINUX_S_ISBLK(inode.i_mode)) {
+		if (inode.i_block[0]) {
+			stx->stx_rdev_major = major(inode.i_block[0]);
+			stx->stx_rdev_minor = minor(inode.i_block[0]);
+		} else {
+			stx->stx_rdev_major = major(inode.i_block[1]);
+			stx->stx_rdev_minor = minor(inode.i_block[1]);
+		}
+	}
+
+	fuse2fs_set_statx_attr(stx, STATX_ATTR_COMPRESSED,
+			       inode.i_flags & EXT2_COMPR_FL);
+	fuse2fs_set_statx_attr(stx, STATX_ATTR_IMMUTABLE,
+			       inode.i_flags & EXT2_IMMUTABLE_FL);
+	fuse2fs_set_statx_attr(stx, STATX_ATTR_APPEND,
+			       inode.i_flags & EXT2_APPEND_FL);
+	fuse2fs_set_statx_attr(stx, STATX_ATTR_NODUMP,
+			       inode.i_flags & EXT2_NODUMP_FL);
+
+	fuse2fs_statx_directio(ff, stx);
+
+	return 0;
+}
+
+static int op_statx(const char *path, int statx_flags, int statx_mask,
+		    struct statx *stx, struct fuse_file_info *fi)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	fuse2fs_start(ff);
+	ret = fuse2fs_file_ino(ff, path, fi, &ino);
+	if (ret)
+		goto out;
+	ret = fuse2fs_statx(ff, ino, statx_mask, stx);
+out:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+#else
+# define op_statx		NULL
+#endif
 
 static int op_readlink(const char *path, char *buf, size_t len)
 {
@@ -6784,6 +6912,9 @@ static struct fuse_operations fs_ops = {
 #ifdef SUPPORT_FALLOCATE
 	.fallocate = op_fallocate,
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
+	.statx = op_statx,
+#endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
 	.getattr_iflags = op_getattr_iflags,
 #endif


