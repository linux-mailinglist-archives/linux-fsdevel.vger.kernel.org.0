Return-Path: <linux-fsdevel+bounces-61596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC0AB58A25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01331B2506A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B81DD0EF;
	Tue, 16 Sep 2025 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFEyfTWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3719E99F;
	Tue, 16 Sep 2025 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983918; cv=none; b=e7Tx+UfcE8vmYyl0z4F9u8c1SuJd45X09TxqYBETKgtgn79zuK2KYcpy0YBteQhJPynnbWD+j7ROAmFHSROCz19Kx3aFlsZ/T/KJDstLRJ1i/S5PQ0x7iyMeuXFxO9LKjyfaHuL6vZghV9pBDCBznp3B8iCvyJUnlkki0d93ezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983918; c=relaxed/simple;
	bh=AVBaxyLbqxYPiRtWKpXmbTCznFXh59S1UkV91WiMPwk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXj3Sb///6iEAy+Ny3V351y+3RHlnv+iK7Zcw2g6tDsRwe0CaSecJH5A8rtbeQmS7GNh5HVcqbNH/NYXcG3+Y0G1KdMRnWQ1/ZspCAPm3Mv/67QEUE2C6EXKcugWR5ODaF1Ad7DX1NyWeN0MA5J5XQ5HgK3SB/kl5TcnreHa9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFEyfTWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18EBC4CEF1;
	Tue, 16 Sep 2025 00:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983917;
	bh=AVBaxyLbqxYPiRtWKpXmbTCznFXh59S1UkV91WiMPwk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eFEyfTWBkyv4KKTU8mmPKi5WN8zn4rLgcuKlVxVZpoMY94gfjVknYWEqa+wR0BoSn
	 qxt/A/aD5893SCsqqz+DpE7sqoT6J79eHKm1nSzMHmpBZ88zSPdJm+d+fDPLjuEqUn
	 vWbfUN3RcJhpCN7vRpUZX+D3GIsdYw1X/7dQ1sx02cf7Kqr84QGES2W91Tm1czNG7E
	 w29e8vNCsTZ/oF5NApXNEu3tct0eTD3mIaCHpkWDEvIW833Uy9xC8fSYJ73dwbHBGL
	 R1X/OOUqY6ZxUHqqLGylt58E7ZnZFlFYwp/lf9wuwDnayFRxfCjqHCfR4pCr63oCEb
	 a8/9ScGk/XAIg==
Date: Mon, 15 Sep 2025 17:51:57 -0700
Subject: [PATCH 05/21] fuse4fs: convert to low level API
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: amir73il@gmail.com, miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160865.389252.17956142778624394742.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Convert fuse4fs to the lowlevel fuse API.  Amir supplied the auto
translation; I ported and cleaned it up by hand, and did the QA work to
make sure it still runs correctly.

Co-developed-by: Claude claude-4-sonnet
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c | 2012 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 1072 insertions(+), 940 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index a4eeb86201db0c..8b65dd1b419eaa 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -41,7 +41,7 @@
 # define __SET_FOB_FOR_FUSE
 # define _FILE_OFFSET_BITS 64
 #endif /* _FILE_OFFSET_BITS */
-#include <fuse.h>
+#include <fuse_lowlevel.h>
 #ifdef __SET_FOB_FOR_FUSE
 # undef _FILE_OFFSET_BITS
 #endif /* __SET_FOB_FOR_FUSE */
@@ -116,6 +116,8 @@
 #endif
 #endif /* !defined(ENODATA) */
 
+#define FUSE4FS_ATTR_TIMEOUT	(0.0)
+
 static inline uint64_t round_up(uint64_t b, unsigned int align)
 {
 	unsigned int m;
@@ -254,16 +256,18 @@ struct fuse4fs {
 	/* options set by fuse_opt_parse must be of type int */
 	int timing;
 #endif
+	struct fuse_session *fuse;
 };
 
-#define FUSE4FS_CHECK_HANDLE(ff, fh) \
+#define FUSE4FS_CHECK_HANDLE(req, fh) \
 	do { \
 		if ((fh) == NULL || (fh)->magic != FUSE4FS_FILE_MAGIC) { \
 			fprintf(stderr, \
 				"FUSE4FS: Corrupt in-memory file handle at %s:%d!\n", \
 				__func__, __LINE__); \
 			fflush(stderr); \
-			return -EUCLEAN; \
+			fuse_reply_err(req, EUCLEAN); \
+			return; \
 		} \
 	} while (0)
 
@@ -275,19 +279,52 @@ struct fuse4fs {
 				__func__, __LINE__); \
 			fflush(stderr); \
 			retcode; \
+			return; \
 		} \
 		if ((ff)->opstate == F4OP_SHUTDOWN) { \
 			shutcode; \
+			return; \
 		} \
 	} while (0)
 
-#define FUSE4FS_CHECK_CONTEXT(ff) \
-	__FUSE4FS_CHECK_CONTEXT((ff), return -EUCLEAN, return -EIO)
+#define FUSE4FS_CHECK_CONTEXT(req) \
+	__FUSE4FS_CHECK_CONTEXT(fuse4fs_get(req), \
+				fuse_reply_err((req), EUCLEAN), \
+				fuse_reply_err((req), EIO))
 #define FUSE4FS_CHECK_CONTEXT_RETURN(ff) \
 	__FUSE4FS_CHECK_CONTEXT((ff), return, return)
 #define FUSE4FS_CHECK_CONTEXT_ABORT(ff) \
 	__FUSE4FS_CHECK_CONTEXT((ff), abort(), abort())
 
+static inline void fuse4fs_ino_from_fuse(ext2_ino_t *inop, fuse_ino_t fino)
+{
+	if (fino == FUSE_ROOT_ID)
+		*inop = EXT2_ROOT_INO;
+	else
+		*inop = fino;
+}
+
+static inline void fuse4fs_ino_to_fuse(fuse_ino_t *finop, ext2_ino_t ino)
+{
+	if (ino == EXT2_ROOT_INO)
+		*finop = FUSE_ROOT_ID;
+	else
+		*finop = ino;
+}
+
+#define FUSE4FS_CONVERT_FINO(req, ext2_inop, fuse_ino) \
+	do { \
+		if ((fuse_ino) > UINT32_MAX) { \
+			fprintf(stderr, \
+				"FUSE4FS: Bogus inode number 0x%llx at %s:%d!\n", \
+				(unsigned long long)(fuse_ino), __func__, __LINE__); \
+			fflush(stderr); \
+			fuse_reply_err((req), EIO); \
+			return; \
+		} \
+		fuse4fs_ino_from_fuse(ext2_inop, fuse_ino); \
+	} while (0)
+
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			     const char *func, int line);
 #define translate_error(fs, ino, err) __translate_error((fs), (ino), (err), \
@@ -454,11 +491,9 @@ static inline errcode_t fuse4fs_write_inode(ext2_filsys fs, ext2_ino_t ino,
 				       sizeof(*inode));
 }
 
-static inline struct fuse4fs *fuse4fs_get(void)
+static inline struct fuse4fs *fuse4fs_get(fuse_req_t req)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-
-	return ctxt->private_data;
+	return (struct fuse4fs *)fuse_req_userdata(req);
 }
 
 static inline struct fuse4fs_file_handle *
@@ -471,6 +506,7 @@ static inline void
 fuse4fs_set_handle(struct fuse_file_info *fp, struct fuse4fs_file_handle *fh)
 {
 	fp->fh = (uintptr_t)fh;
+	fp->keep_cache = 1;
 }
 
 #ifdef HAVE_CLOCK_MONOTONIC
@@ -731,7 +767,7 @@ static int fuse4fs_is_writeable(const struct fuse4fs *ff)
 }
 
 static inline int fuse4fs_is_superuser(struct fuse4fs *ff,
-				       const struct fuse_context *ctxt)
+				       const struct fuse_ctx *ctxt)
 {
 	if (ff->fakeroot)
 		return 1;
@@ -739,7 +775,7 @@ static inline int fuse4fs_is_superuser(struct fuse4fs *ff,
 }
 
 static inline int fuse4fs_want_check_owner(struct fuse4fs *ff,
-					   const struct fuse_context *ctxt)
+					   const struct fuse_ctx *ctxt)
 {
 	/*
 	 * The kernel is responsible for access control, so we allow anything
@@ -782,9 +818,9 @@ static int fuse4fs_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
-static int fuse4fs_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
+static int fuse4fs_inum_access(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
+			       ext2_ino_t ino, int mask)
 {
-	struct fuse_context *ctxt = fuse_get_context();
 	ext2_filsys fs = ff->fs;
 	struct ext2_inode inode;
 	mode_t perms;
@@ -1118,9 +1154,9 @@ static int fuse4fs_mount(struct fuse4fs *ff)
 	return 0;
 }
 
-static void op_destroy(void *p EXT2FS_ATTR((unused)))
+static void op_destroy(void *userdata)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs *ff = userdata;
 	ext2_filsys fs;
 	errcode_t err;
 
@@ -1302,24 +1338,13 @@ static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
 }
 #endif
 
-static void *op_init(struct fuse_conn_info *conn,
-		     struct fuse_config *cfg EXT2FS_ATTR((unused)))
+static void op_init(void *userdata, struct fuse_conn_info *conn)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs *ff = userdata;
 	ext2_filsys fs;
 
 	FUSE4FS_CHECK_CONTEXT_ABORT(ff);
 
-	/*
-	 * Configure logging a second time, because libfuse might have
-	 * redirected std{out,err} as part of daemonization.  If this fails,
-	 * give up and move on.
-	 */
-	fuse4fs_setup_logging(ff);
-	if (ff->logfd >= 0)
-		close(ff->logfd);
-	ff->logfd = -1;
-
 	fs = ff->fs;
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
 #ifdef FUSE_CAP_IOCTL_DIR
@@ -1336,10 +1361,6 @@ static void *op_init(struct fuse_conn_info *conn,
 	fuse_set_feature_flag(conn, FUSE_CAP_NO_EXPORT_SUPPORT);
 #endif
 	conn->time_gran = 1;
-	cfg->use_ino = 1;
-	if (ff->debug)
-		cfg->debug = 1;
-	cfg->nullpath_ok = 1;
 
 	if (ff->kernel) {
 		char uuid[UUID_STR_SIZE];
@@ -1364,132 +1385,151 @@ static void *op_init(struct fuse_conn_info *conn,
 	 */
 	conn->want = conn->want_ext & 0xFFFFFFFF;
 #endif
-	return ff;
 }
 
-static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
+struct fuse4fs_stat {
+	struct fuse_entry_param	entry;
+};
+
+static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
+			      struct ext2_inode_large *inodep,
+			      struct fuse4fs_stat *fstat)
 {
 	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
+	struct fuse_entry_param *entry = &fstat->entry;
+	struct stat *statbuf = &entry->attr;
 	dev_t fakedev = 0;
 	errcode_t err;
-	int ret = 0;
 	struct timespec tv;
 
-	err = fuse4fs_read_inode(fs, ino, &inode);
-	if (err)
-		return translate_error(fs, ino, err);
+	memset(fstat, 0, sizeof(*fstat));
+
+	if (!inodep) {
+		err = fuse4fs_read_inode(fs, ino, &inode);
+		if (err)
+			return translate_error(fs, ino, err);
+		inodep = &inode;
+	}
 
 	memcpy(&fakedev, fs->super->s_uuid, sizeof(fakedev));
 	statbuf->st_dev = fakedev;
 	statbuf->st_ino = ino;
-	statbuf->st_mode = inode.i_mode;
-	statbuf->st_nlink = inode.i_links_count;
-	statbuf->st_uid = inode_uid(inode);
-	statbuf->st_gid = inode_gid(inode);
-	statbuf->st_size = EXT2_I_SIZE(&inode);
+	statbuf->st_mode = inodep->i_mode;
+	statbuf->st_nlink = inodep->i_links_count;
+	statbuf->st_uid = inode_uid(*inodep);
+	statbuf->st_gid = inode_gid(*inodep);
+	statbuf->st_size = EXT2_I_SIZE(inodep);
 	statbuf->st_blksize = fs->blocksize;
 	statbuf->st_blocks = ext2fs_get_stat_i_blocks(fs,
-						EXT2_INODE(&inode));
-	EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
+						EXT2_INODE(inodep));
+	EXT4_INODE_GET_XTIME(i_atime, &tv, inodep);
 #if HAVE_STRUCT_STAT_ST_ATIM
 	statbuf->st_atim = tv;
 #else
 	statbuf->st_atime = tv.tv_sec;
 #endif
-	EXT4_INODE_GET_XTIME(i_mtime, &tv, &inode);
+	EXT4_INODE_GET_XTIME(i_mtime, &tv, inodep);
 #if HAVE_STRUCT_STAT_ST_ATIM
 	statbuf->st_mtim = tv;
 #else
 	statbuf->st_mtime = tv.tv_sec;
 #endif
-	EXT4_INODE_GET_XTIME(i_ctime, &tv, &inode);
+	EXT4_INODE_GET_XTIME(i_ctime, &tv, inodep);
 #if HAVE_STRUCT_STAT_ST_ATIM
 	statbuf->st_ctim = tv;
 #else
 	statbuf->st_ctime = tv.tv_sec;
 #endif
-	if (LINUX_S_ISCHR(inode.i_mode) ||
-	    LINUX_S_ISBLK(inode.i_mode)) {
-		if (inode.i_block[0])
-			statbuf->st_rdev = inode.i_block[0];
+	if (LINUX_S_ISCHR(inodep->i_mode) ||
+	    LINUX_S_ISBLK(inodep->i_mode)) {
+		if (inodep->i_block[0])
+			statbuf->st_rdev = inodep->i_block[0];
 		else
-			statbuf->st_rdev = inode.i_block[1];
+			statbuf->st_rdev = inodep->i_block[1];
 	}
 
-	return ret;
-}
-
-static int __fuse4fs_file_ino(struct fuse4fs *ff, const char *path,
-			      struct fuse_file_info *fp EXT2FS_ATTR((unused)),
-			      ext2_ino_t *inop,
-			      const char *func,
-			      int line)
-{
-	ext2_filsys fs = ff->fs;
-	errcode_t err;
-
-	if (fp) {
-		struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
-
-		if (fh->ino == 0)
-			return -ESTALE;
-
-		*inop = fh->ino;
-		dbg_printf(ff, "%s: get ino=%d\n", func, fh->ino);
-		return 0;
-	}
-
-	dbg_printf(ff, "%s: get path=%s\n", func, path);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, inop);
-	if (err)
-		return __translate_error(fs, 0, err, func, line);
+	fuse4fs_ino_to_fuse(&entry->ino, ino);
+	entry->generation = inodep->i_generation;
+	entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
+	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
 
 	return 0;
 }
 
-# define fuse4fs_file_ino(ff, path, fp, inop) \
-	__fuse4fs_file_ino((ff), (path), (fp), (inop), __func__, __LINE__)
-
-static int op_getattr(const char *path, struct stat *statbuf,
-		      struct fuse_file_info *fi)
+static void op_lookup(fuse_req_t req, fuse_ino_t fino, const char *name)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs_stat fstat;
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
-	ext2_ino_t ino;
+	ext2_ino_t parent, child;
+	errcode_t err;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &parent, fino);
+	dbg_printf(ff, "%s: parent=%d name='%s'\n", __func__, parent, name);
 	fs = fuse4fs_start(ff);
-	ret = fuse4fs_file_ino(ff, path, fi, &ino);
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, parent, name, &child);
+	if (err || child == 0) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+
+	ret = fuse4fs_stat_inode(ff, child, NULL, &fstat);
 	if (ret)
 		goto out;
-	ret = stat_inode(fs, ino, statbuf);
+
 out:
 	fuse4fs_finish(ff, ret);
-	return ret;
+
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_entry(req, &fstat.entry);
 }
 
-static int op_readlink(const char *path, char *buf, size_t len)
+static void op_getattr(fuse_req_t req, fuse_ino_t fino,
+		       struct fuse_file_info *fi EXT2FS_ATTR((unused)))
 {
-	struct fuse4fs *ff = fuse4fs_get();
-	ext2_filsys fs;
-	errcode_t err;
+	struct fuse4fs_stat fstat;
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_ino_t ino;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+	fuse4fs_start(ff);
+	ret = fuse4fs_stat_inode(ff, ino, NULL, &fstat);
+	fuse4fs_finish(ff, ret);
+
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_attr(req, &fstat.entry.attr,
+				fstat.entry.attr_timeout);
+}
+
+static void op_readlink(fuse_req_t req, fuse_ino_t fino)
+{
 	struct ext2_inode inode;
+	char buf[PATH_MAX + 1];
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+	ext2_file_t file;
+	errcode_t err;
+	ext2_ino_t ino;
+	size_t len = PATH_MAX;
 	unsigned int got;
-	ext2_file_t file;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	dbg_printf(ff, "%s: path=%s\n", __func__, path);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
 	fs = fuse4fs_start(ff);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err || ino == 0) {
-		ret = translate_error(fs, 0, err);
-		goto out;
-	}
 
-	err = ext2fs_read_inode(fs, ino, &inode);
+	err = ext2fs_read_inode(fs, fino, &inode);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out;
@@ -1500,7 +1540,6 @@ static int op_readlink(const char *path, char *buf, size_t len)
 		goto out;
 	}
 
-	len--;
 	if (inode.i_size < len)
 		len = inode.i_size;
 	if (ext2fs_is_fast_symlink(&inode))
@@ -1538,7 +1577,11 @@ static int op_readlink(const char *path, char *buf, size_t len)
 
 out:
 	fuse4fs_finish(ff, ret);
-	return ret;
+
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_readlink(req, buf);
 }
 
 static int fuse4fs_getxattr(struct fuse4fs *ff, ext2_ino_t ino,
@@ -1644,11 +1687,12 @@ static inline void fuse4fs_set_gid(struct ext2_inode_large *inode, gid_t gid)
 	ext2fs_set_i_gid_high(*inode, gid >> 16);
 }
 
-static int fuse4fs_new_child_gid(struct fuse4fs *ff, ext2_ino_t parent,
-				 gid_t *gid, int *parent_sgid)
+static int fuse4fs_new_child_gid(struct fuse4fs *ff,
+				 const struct fuse_ctx *ctxt,
+				 ext2_ino_t parent, gid_t *gid,
+				 int *parent_sgid)
 {
 	struct ext2_inode_large inode;
-	struct fuse_context *ctxt = fuse_get_context();
 	errcode_t err;
 
 	err = fuse4fs_read_inode(ff->fs, parent, &inode);
@@ -1724,36 +1768,44 @@ static void fuse4fs_set_extra_isize(struct fuse4fs *ff, ext2_ino_t ino,
 	inode->i_extra_isize = extra;
 }
 
-static int op_mknod(const char *path, mode_t mode, dev_t dev)
+static void fuse4fs_reply_entry(fuse_req_t req, ext2_ino_t ino,
+				struct ext2_inode_large *inode, int ret)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs_stat fstat;
+	struct fuse4fs *ff = fuse4fs_get(req);
+
+	if (ret) {
+		fuse_reply_err(req, -ret);
+		return;
+	}
+
+	/* Get stat info for the new entry */
+	ret = fuse4fs_stat_inode(ff, ino, inode, &fstat);
+	if (ret) {
+		fuse_reply_err(req, -ret);
+		return;
+	}
+
+	fuse_reply_entry(req, &fstat.entry);
+}
+
+static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
+		     mode_t mode, dev_t dev)
+{
+	struct ext2_inode_large inode;
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
-	char *temp_path;
 	errcode_t err;
-	char *node_name, a;
 	int filetype;
-	struct ext2_inode_large inode;
 	gid_t gid;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	dbg_printf(ff, "%s: path=%s mode=0%o dev=0x%x\n", __func__, path, mode,
-		   (unsigned int)dev);
-	temp_path = strdup(path);
-	if (!temp_path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	node_name = strrchr(temp_path, '/');
-	if (!node_name) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	node_name++;
-	a = *node_name;
-	*node_name = 0;
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &parent, fino);
+	dbg_printf(ff, "%s: parent=%d name='%s' mode=0%o dev=0x%x\n",
+		   __func__, parent, name, mode, (unsigned int)dev);
 
 	fs = fuse4fs_start(ff);
 	if (!fuse4fs_can_allocate(ff, 2)) {
@@ -1761,33 +1813,14 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
-			   &parent);
-	if (err) {
-		ret = translate_error(fs, 0, err);
-		goto out2;
-	}
-
-	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
-	*node_name = a;
+	/* On a low level server, mknod handles all non-directory types */
+	filetype = ext2_file_type(mode);
 
-	if (LINUX_S_ISCHR(mode))
-		filetype = EXT2_FT_CHRDEV;
-	else if (LINUX_S_ISBLK(mode))
-		filetype = EXT2_FT_BLKDEV;
-	else if (LINUX_S_ISFIFO(mode))
-		filetype = EXT2_FT_FIFO;
-	else if (LINUX_S_ISSOCK(mode))
-		filetype = EXT2_FT_SOCK;
-	else {
-		ret = -EINVAL;
-		goto out2;
-	}
-
-	err = fuse4fs_new_child_gid(ff, parent, &gid, NULL);
+	err = fuse4fs_new_child_gid(ff, ctxt, parent, &gid, NULL);
 	if (err)
 		goto out2;
 
@@ -1797,9 +1830,9 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 		goto out2;
 	}
 
-	dbg_printf(ff, "%s: create ino=%d/name=%s in dir=%d\n", __func__, child,
-		   node_name, parent);
-	err = ext2fs_link(fs, parent, node_name, child,
+	dbg_printf(ff, "%s: create ino=%d name='%s' in dir=%d\n", __func__,
+		   child, name, parent);
+	err = ext2fs_link(fs, parent, name, child,
 			  filetype | EXT2FS_LINK_EXPAND);
 	if (err) {
 		ret = translate_error(fs, parent, err);
@@ -1848,42 +1881,28 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 
 out2:
 	fuse4fs_finish(ff, ret);
-out:
-	free(temp_path);
-	return ret;
+	fuse4fs_reply_entry(req, child, &inode, ret);
 }
 
-static int op_mkdir(const char *path, mode_t mode)
+static void op_mkdir(fuse_req_t req, fuse_ino_t fino, const char *name,
+		     mode_t mode)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse4fs *ff = fuse4fs_get();
+	struct ext2_inode_large inode;
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
-	char *temp_path;
 	errcode_t err;
-	char *node_name, a;
-	struct ext2_inode_large inode;
 	char *block;
 	blk64_t blk;
 	int ret = 0;
 	gid_t gid;
 	int parent_sgid;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	dbg_printf(ff, "%s: path=%s mode=0%o\n", __func__, path, mode);
-	temp_path = strdup(path);
-	if (!temp_path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	node_name = strrchr(temp_path, '/');
-	if (!node_name) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	node_name++;
-	a = *node_name;
-	*node_name = 0;
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &parent, fino);
+	dbg_printf(ff, "%s: parent=%d name='%s' mode=0%o\n",
+		   __func__, parent, name, mode);
 
 	fs = fuse4fs_start(ff);
 	if (!fuse4fs_can_allocate(ff, 1)) {
@@ -1891,25 +1910,15 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
-			   &parent);
-	if (err) {
-		ret = translate_error(fs, 0, err);
-		goto out2;
-	}
-
-	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
-	err = fuse4fs_new_child_gid(ff, parent, &gid, &parent_sgid);
+	err = fuse4fs_new_child_gid(ff, ctxt, parent, &gid, &parent_sgid);
 	if (err)
 		goto out2;
 
-	*node_name = a;
-
-	err = ext2fs_mkdir2(fs, parent, 0, 0, EXT2FS_LINK_EXPAND,
-			    node_name, NULL);
+	err = ext2fs_mkdir2(fs, parent, 0, 0, EXT2FS_LINK_EXPAND, name, NULL);
 	if (err) {
 		ret = translate_error(fs, parent, err);
 		goto out2;
@@ -1920,14 +1929,13 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 
 	/* Still have to update the uid/gid of the dir */
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
-			   &child);
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, parent, name, &child);
 	if (err) {
 		ret = translate_error(fs, 0, err);
 		goto out2;
 	}
-	dbg_printf(ff, "%s: created ino=%d/path=%s in dir=%d\n", __func__, child,
-		   node_name, parent);
+	dbg_printf(ff, "%s: created ino=%d name='%s' in dir=%d\n",
+		   __func__, child, name, parent);
 
 	err = fuse4fs_read_inode(fs, child, &inode);
 	if (err) {
@@ -1983,55 +1991,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	ext2fs_free_mem(&block);
 out2:
 	fuse4fs_finish(ff, ret);
-out:
-	free(temp_path);
-	return ret;
-}
-
-static int fuse4fs_unlink(struct fuse4fs *ff, const char *path,
-			  ext2_ino_t *parent)
-{
-	ext2_filsys fs = ff->fs;
-	errcode_t err;
-	ext2_ino_t dir;
-	char *filename = strdup(path);
-	char *base_name;
-	int ret;
-
-	base_name = strrchr(filename, '/');
-	if (base_name) {
-		*base_name++ = '\0';
-		err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, filename,
-				   &dir);
-		if (err) {
-			free(filename);
-			return translate_error(fs, 0, err);
-		}
-	} else {
-		dir = EXT2_ROOT_INO;
-		base_name = filename;
-	}
-
-	ret = fuse4fs_inum_access(ff, dir, W_OK);
-	if (ret) {
-		free(filename);
-		return ret;
-	}
-
-	dbg_printf(ff, "%s: unlinking name=%s from dir=%d\n", __func__,
-		   base_name, dir);
-	err = ext2fs_unlink(fs, dir, base_name, 0, 0);
-	free(filename);
-	if (err)
-		return translate_error(fs, dir, err);
-
-	ret = update_mtime(fs, dir, NULL);
-	if (ret)
-		return ret;
-
-	if (parent)
-		*parent = dir;
-	return 0;
+	fuse4fs_reply_entry(req, child, &inode, ret);
 }
 
 static int fuse4fs_remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
@@ -2140,49 +2100,78 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 	return 0;
 }
 
-static int __op_unlink(struct fuse4fs *ff, const char *path)
+static int fuse4fs_unlink(struct fuse4fs *ff, ext2_ino_t parent,
+			  const char *name, ext2_ino_t child)
 {
 	ext2_filsys fs = ff->fs;
-	ext2_ino_t parent, ino;
 	errcode_t err;
 	int ret = 0;
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
+	err = ext2fs_unlink(fs, parent, name, child, 0);
+	if (err) {
+		ret = translate_error(fs, parent, err);
+		goto out;
+	}
+
+	ret = update_mtime(fs, parent, NULL);
+	if (ret)
+		goto out;
+out:
+	return ret;
+}
+
+static int fuse4fs_rmfile(struct fuse4fs *ff, ext2_ino_t parent,
+			  const char *name, ext2_ino_t child)
+{
+	int ret;
+
+	ret = fuse4fs_unlink(ff, parent, name, child);
+	if (ret)
+		return ret;
+
+	return fuse4fs_remove_inode(ff, child);
+}
+
+static void op_unlink(fuse_req_t req, fuse_ino_t fino, const char *name)
+{
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+	ext2_ino_t parent, child;
+	errcode_t err;
+	int ret;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &parent, fino);
+	fs = fuse4fs_start(ff);
+
+	/* Get the inode number for the file */
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, parent, name, &child);
 	if (err) {
 		ret = translate_error(fs, 0, err);
 		goto out;
 	}
 
-	ret = fuse4fs_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, child, W_OK);
 	if (ret)
 		goto out;
 
-	ret = fuse4fs_unlink(ff, path, &parent);
+	ret = fuse4fs_inum_access(ff, ctxt, parent, W_OK);
 	if (ret)
 		goto out;
 
-	ret = fuse4fs_remove_inode(ff, ino);
+	dbg_printf(ff, "%s: unlink parent=%d name='%s' child=%d\n",
+		   __func__, parent, name, child);
+	ret = fuse4fs_rmfile(ff, parent, name, child);
 	if (ret)
 		goto out;
 
 	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
 	if (ret)
 		goto out;
-
 out:
-	return ret;
-}
-
-static int op_unlink(const char *path)
-{
-	struct fuse4fs *ff = fuse4fs_get();
-	int ret;
-
-	FUSE4FS_CHECK_CONTEXT(ff);
-	fuse4fs_start(ff);
-	ret = __op_unlink(ff, path);
 	fuse4fs_finish(ff, ret);
-	return ret;
+	fuse_reply_err(req, -ret);
 }
 
 struct rd_struct {
@@ -2213,51 +2202,36 @@ static int rmdir_proc(ext2_ino_t dir EXT2FS_ATTR((unused)),
 	return 0;
 }
 
-static int __op_rmdir(struct fuse4fs *ff, const char *path)
+static int fuse4fs_rmdir(struct fuse4fs *ff, ext2_ino_t parent,
+			 const char *name, ext2_ino_t child)
 {
 	ext2_filsys fs = ff->fs;
-	ext2_ino_t parent, child;
 	errcode_t err;
 	struct ext2_inode_large inode;
-	struct rd_struct rds;
+	struct rd_struct rds = {
+		.parent = 0,
+		.empty = 1,
+	};
 	int ret = 0;
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &child);
-	if (err) {
-		ret = translate_error(fs, 0, err);
-		goto out;
-	}
-	dbg_printf(ff, "%s: rmdir path=%s ino=%d\n", __func__, path, child);
-
-	ret = fuse4fs_inum_access(ff, child, W_OK);
-	if (ret)
-		goto out;
-
-	rds.parent = 0;
-	rds.empty = 1;
-
 	err = ext2fs_dir_iterate2(fs, child, 0, 0, rmdir_proc, &rds);
 	if (err) {
 		ret = translate_error(fs, child, err);
 		goto out;
 	}
 
-	/* the kernel checks parent permissions before emptiness */
+	/* Make sure we found a dotdot entry */
 	if (rds.parent == 0) {
 		ret = translate_error(fs, child, EXT2_ET_FILESYSTEM_CORRUPTED);
 		goto out;
 	}
 
-	ret = fuse4fs_inum_access(ff, rds.parent, W_OK);
-	if (ret)
-		goto out;
-
 	if (rds.empty == 0) {
 		ret = -ENOTEMPTY;
 		goto out;
 	}
 
-	ret = fuse4fs_unlink(ff, path, &parent);
+	ret = fuse4fs_unlink(ff, parent, name, child);
 	if (ret)
 		goto out;
 	/* Directories have to be "removed" twice. */
@@ -2288,78 +2262,85 @@ static int __op_rmdir(struct fuse4fs *ff, const char *path)
 		}
 	}
 
-	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
-	if (ret)
-		goto out;
-
 out:
 	return ret;
 }
 
-static int op_rmdir(const char *path)
+static void op_rmdir(fuse_req_t req, fuse_ino_t fino, const char *name)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+	ext2_ino_t parent, child;
+	errcode_t err;
 	int ret;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	fuse4fs_start(ff);
-	ret = __op_rmdir(ff, path);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &parent, fino);
+	fs = fuse4fs_start(ff);
+
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, parent, name, &child);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+
+	ret = fuse4fs_inum_access(ff, ctxt, parent, W_OK);
+	if (ret)
+		goto out;
+
+	ret = fuse4fs_inum_access(ff, ctxt, child, W_OK);
+	if (ret)
+		goto out;
+
+	dbg_printf(ff, "%s: unlink parent=%d name='%s' child=%d\n",
+		   __func__, parent, name, child);
+	ret = fuse4fs_rmdir(ff, parent, name, child);
+	if (ret)
+		goto out;
+
+	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
+	if (ret)
+		goto out;
+
+out:
 	fuse4fs_finish(ff, ret);
-	return ret;
+	fuse_reply_err(req, -ret);
 }
 
-static int op_symlink(const char *src, const char *dest)
+static void op_symlink(fuse_req_t req, const char *target, fuse_ino_t fino,
+		       const char *name)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse4fs *ff = fuse4fs_get();
-	ext2_filsys fs;
-	ext2_ino_t parent, child;
-	char *temp_path;
-	errcode_t err;
-	char *node_name, a;
 	struct ext2_inode_large inode;
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+	ext2_ino_t parent, child;
+	errcode_t err;
 	gid_t gid;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	dbg_printf(ff, "%s: symlink %s to %s\n", __func__, src, dest);
-	temp_path = strdup(dest);
-	if (!temp_path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	node_name = strrchr(temp_path, '/');
-	if (!node_name) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	node_name++;
-	a = *node_name;
-	*node_name = 0;
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &parent, fino);
+	dbg_printf(ff, "%s: symlink dir=%d name='%s' target='%s'\n",
+		   __func__, parent, name, target);
 
 	fs = fuse4fs_start(ff);
-	if (!fs_can_allocate(ff, 1)) {
+	if (!fuse4fs_can_allocate(ff, 1)) {
 		ret = -ENOSPC;
 		goto out2;
 	}
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
-			   &parent);
-	*node_name = a;
-	if (err) {
-		ret = translate_error(fs, 0, err);
-		goto out2;
-	}
 
-	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
-	err = fuse4fs_new_child_gid(ff, parent, &gid, NULL);
+	err = fuse4fs_new_child_gid(ff, ctxt, parent, &gid, NULL);
 	if (err)
 		goto out2;
 
 	/* Create symlink */
-	err = ext2fs_symlink(fs, parent, 0, node_name, src);
+	err = ext2fs_symlink(fs, parent, 0, name, target);
 	if (err == EXT2_ET_DIR_NO_SPACE) {
 		err = ext2fs_expand_dir(fs, parent);
 		if (err) {
@@ -2367,7 +2348,7 @@ static int op_symlink(const char *src, const char *dest)
 			goto out2;
 		}
 
-		err = ext2fs_symlink(fs, parent, 0, node_name, src);
+		err = ext2fs_symlink(fs, parent, 0, name, target);
 	}
 	if (err) {
 		ret = translate_error(fs, parent, err);
@@ -2380,14 +2361,13 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 
 	/* Still have to update the uid/gid of the symlink */
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
-			   &child);
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, parent, name, &child);
 	if (err) {
 		ret = translate_error(fs, 0, err);
 		goto out2;
 	}
-	dbg_printf(ff, "%s: symlinking ino=%d/name=%s to dir=%d\n", __func__,
-		   child, node_name, parent);
+	dbg_printf(ff, "%s: symlinking dir=%d name='%s' child=%d\n",
+		   __func__, parent, name, child);
 
 	err = fuse4fs_read_inode(fs, child, &inode);
 	if (err) {
@@ -2413,9 +2393,7 @@ static int op_symlink(const char *src, const char *dest)
 
 out2:
 	fuse4fs_finish(ff, ret);
-out:
-	free(temp_path);
-	return ret;
+	fuse4fs_reply_entry(req, child, &inode, ret);
 }
 
 struct update_dotdot {
@@ -2441,39 +2419,43 @@ static int update_dotdot_helper(ext2_ino_t dir EXT2FS_ATTR((unused)),
 	return 0;
 }
 
-static int op_rename(const char *from, const char *to,
-		     unsigned int flags EXT2FS_ATTR((unused)))
+static void op_rename(fuse_req_t req, fuse_ino_t from_parent, const char *from,
+		      fuse_ino_t to_parent, const char *to, unsigned int flags)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t from_ino, to_ino, to_dir_ino, from_dir_ino;
-	char *temp_to = NULL, *temp_from = NULL;
-	char *cp, a;
 	struct ext2_inode inode;
 	struct update_dotdot ud;
 	int flushed = 0;
 	int ret = 0;
 
 	/* renameat2 is not supported */
-	if (flags)
-		return -ENOSYS;
+	if (flags) {
+		fuse_reply_err(req, ENOSYS);
+		return;
+	}
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &from_dir_ino, from_parent);
+	FUSE4FS_CONVERT_FINO(req, &to_dir_ino, to_parent);
+	dbg_printf(ff, "%s: renaming dir=%d name='%s' to dir=%d name='%s'\n",
+		   __func__, from_dir_ino, from, to_dir_ino, to);
 	fs = fuse4fs_start(ff);
 	if (!fuse4fs_can_allocate(ff, 5)) {
 		ret = -ENOSPC;
 		goto out;
 	}
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, from, &from_ino);
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, from_dir_ino, from, &from_ino);
 	if (err || from_ino == 0) {
 		ret = translate_error(fs, 0, err);
 		goto out;
 	}
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, to, &to_ino);
+	err = ext2fs_namei(fs, EXT2_ROOT_INO, to_dir_ino, to, &to_ino);
 	if (err && err != EXT2_ET_FILE_NOT_FOUND) {
 		ret = translate_error(fs, 0, err);
 		goto out;
@@ -2482,136 +2464,80 @@ static int op_rename(const char *from, const char *to,
 	if (err == EXT2_ET_FILE_NOT_FOUND)
 		to_ino = 0;
 
+	dbg_printf(ff,
+ "%s: renaming dir=%d name='%s' child=%d to dir=%d name='%s' child=%d\n",
+		   __func__, from_dir_ino, from, from_ino, to_dir_ino, to,
+		   to_ino);
+
 	/* Already the same file? */
 	if (to_ino != 0 && to_ino == from_ino) {
 		ret = 0;
 		goto out;
 	}
 
-	ret = fuse4fs_inum_access(ff, from_ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, from_ino, W_OK);
 	if (ret)
 		goto out;
 
 	if (to_ino) {
-		ret = fuse4fs_inum_access(ff, to_ino, W_OK);
+		ret = fuse4fs_inum_access(ff, ctxt, to_ino, W_OK);
 		if (ret)
 			goto out;
 	}
 
-	temp_to = strdup(to);
-	if (!temp_to) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	temp_from = strdup(from);
-	if (!temp_from) {
-		ret = -ENOMEM;
-		goto out2;
-	}
-
-	/* Find parent dir of the source and check write access */
-	cp = strrchr(temp_from, '/');
-	if (!cp) {
-		ret = -EINVAL;
-		goto out2;
-	}
-
-	a = *(cp + 1);
-	*(cp + 1) = 0;
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_from,
-			   &from_dir_ino);
-	*(cp + 1) = a;
-	if (err) {
-		ret = translate_error(fs, 0, err);
-		goto out2;
-	}
-	if (from_dir_ino == 0) {
-		ret = -ENOENT;
-		goto out2;
-	}
-
-	ret = fuse4fs_inum_access(ff, from_dir_ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, from_dir_ino, W_OK);
 	if (ret)
-		goto out2;
-
-	/* Find parent dir of the destination and check write access */
-	cp = strrchr(temp_to, '/');
-	if (!cp) {
-		ret = -EINVAL;
-		goto out2;
-	}
-
-	a = *(cp + 1);
-	*(cp + 1) = 0;
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_to,
-			   &to_dir_ino);
-	*(cp + 1) = a;
-	if (err) {
-		ret = translate_error(fs, 0, err);
-		goto out2;
-	}
-	if (to_dir_ino == 0) {
-		ret = -ENOENT;
-		goto out2;
-	}
+		goto out;
 
-	ret = fuse4fs_inum_access(ff, to_dir_ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, to_dir_ino, W_OK);
 	if (ret)
-		goto out2;
+		goto out;
 
 	/* If the target exists, unlink it first */
 	if (to_ino != 0) {
 		err = ext2fs_read_inode(fs, to_ino, &inode);
 		if (err) {
 			ret = translate_error(fs, to_ino, err);
-			goto out2;
+			goto out;
 		}
 
-		dbg_printf(ff, "%s: unlinking %s ino=%d\n", __func__,
-			   LINUX_S_ISDIR(inode.i_mode) ? "dir" : "file",
-			   to_ino);
+		dbg_printf(ff, "%s: unlink dir=%d name='%s' child=%d\n",
+			   __func__, to_dir_ino, to, to_ino);
 		if (LINUX_S_ISDIR(inode.i_mode))
-			ret = __op_rmdir(ff, to);
+			ret = fuse4fs_rmdir(ff, to_dir_ino, to, to_ino);
 		else
-			ret = __op_unlink(ff, to);
+			ret = fuse4fs_rmfile(ff, to_dir_ino, to, to_ino);
 		if (ret)
-			goto out2;
+			goto out;
 	}
 
 	/* Get ready to do the move */
 	err = ext2fs_read_inode(fs, from_ino, &inode);
 	if (err) {
 		ret = translate_error(fs, from_ino, err);
-		goto out2;
+		goto out;
 	}
 
 	/* Link in the new file */
-	dbg_printf(ff, "%s: linking ino=%d/path=%s to dir=%d\n", __func__,
-		   from_ino, cp + 1, to_dir_ino);
-	err = ext2fs_link(fs, to_dir_ino, cp + 1, from_ino,
+	dbg_printf(ff, "%s: link dir=%d name='%s' child=%d\n",
+		   __func__, to_dir_ino, to, from_ino);
+	err = ext2fs_link(fs, to_dir_ino, to, from_ino,
 			  ext2_file_type(inode.i_mode) | EXT2FS_LINK_EXPAND);
 	if (err) {
 		ret = translate_error(fs, to_dir_ino, err);
-		goto out2;
+		goto out;
 	}
 
 	/* Update '..' pointer if dir */
-	err = ext2fs_read_inode(fs, from_ino, &inode);
-	if (err) {
-		ret = translate_error(fs, from_ino, err);
-		goto out2;
-	}
-
 	if (LINUX_S_ISDIR(inode.i_mode)) {
 		ud.new_dotdot = to_dir_ino;
-		dbg_printf(ff, "%s: updating .. entry for dir=%d\n", __func__,
-			   to_dir_ino);
+		dbg_printf(ff, "%s: updating .. entry for child=%d parent=%d\n",
+			   __func__, from_ino, to_dir_ino);
 		err = ext2fs_dir_iterate2(fs, from_ino, 0, NULL,
 					  update_dotdot_helper, &ud);
 		if (err) {
 			ret = translate_error(fs, from_ino, err);
-			goto out2;
+			goto out;
 		}
 
 		/* Decrease from_dir_ino's links_count */
@@ -2620,87 +2546,76 @@ static int op_rename(const char *from, const char *to,
 		err = ext2fs_read_inode(fs, from_dir_ino, &inode);
 		if (err) {
 			ret = translate_error(fs, from_dir_ino, err);
-			goto out2;
+			goto out;
 		}
 		inode.i_links_count--;
 		err = ext2fs_write_inode(fs, from_dir_ino, &inode);
 		if (err) {
 			ret = translate_error(fs, from_dir_ino, err);
-			goto out2;
+			goto out;
 		}
 
 		/* Increase to_dir_ino's links_count */
 		err = ext2fs_read_inode(fs, to_dir_ino, &inode);
 		if (err) {
 			ret = translate_error(fs, to_dir_ino, err);
-			goto out2;
+			goto out;
 		}
 		inode.i_links_count++;
 		err = ext2fs_write_inode(fs, to_dir_ino, &inode);
 		if (err) {
 			ret = translate_error(fs, to_dir_ino, err);
-			goto out2;
+			goto out;
 		}
 	}
 
 	/* Update timestamps */
 	ret = update_ctime(fs, from_ino, NULL);
 	if (ret)
-		goto out2;
+		goto out;
 
 	ret = update_mtime(fs, to_dir_ino, NULL);
 	if (ret)
-		goto out2;
+		goto out;
 
 	/* Remove the old file */
-	ret = fuse4fs_unlink(ff, from, NULL);
+	dbg_printf(ff, "%s: unlink dir=%d name='%s' child=%d\n",
+		   __func__, from_dir_ino, from, from_ino);
+	ret = fuse4fs_unlink(ff, from_dir_ino, from, from_ino);
 	if (ret)
-		goto out2;
+		goto out;
 
 	ret = fuse4fs_dirsync_flush(ff, from_dir_ino, &flushed);
 	if (ret)
-		goto out2;
+		goto out;
 
 	if (from_dir_ino != to_dir_ino && !flushed) {
 		ret = fuse4fs_dirsync_flush(ff, to_dir_ino, NULL);
 		if (ret)
-			goto out2;
+			goto out;
 	}
 
-out2:
-	free(temp_from);
-	free(temp_to);
 out:
 	fuse4fs_finish(ff, ret);
-	return ret;
+	fuse_reply_err(req, -ret);
 }
 
-static int op_link(const char *src, const char *dest)
+static void op_link(fuse_req_t req, fuse_ino_t child_fino,
+		    fuse_ino_t parent_fino, const char *name)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct ext2_inode_large inode;
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
-	char *temp_path;
 	errcode_t err;
-	char *node_name, a;
-	ext2_ino_t parent, ino;
-	struct ext2_inode_large inode;
+	ext2_ino_t parent, child;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	dbg_printf(ff, "%s: src=%s dest=%s\n", __func__, src, dest);
-	temp_path = strdup(dest);
-	if (!temp_path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	node_name = strrchr(temp_path, '/');
-	if (!node_name) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	node_name++;
-	a = *node_name;
-	*node_name = 0;
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &parent, parent_fino);
+	FUSE4FS_CONVERT_FINO(req, &child, child_fino);
+	dbg_printf(ff, "%s: link dir=%d name='%s' child=%d\n",
+		   __func__, parent, name, child);
 
 	fs = fuse4fs_start(ff);
 	if (!fuse4fs_can_allocate(ff, 2)) {
@@ -2708,48 +2623,32 @@ static int op_link(const char *src, const char *dest)
 		goto out2;
 	}
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
-			   &parent);
-	*node_name = a;
-	if (err) {
-		err = -ENOENT;
-		goto out2;
-	}
-
-	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, src, &ino);
-	if (err || ino == 0) {
-		ret = translate_error(fs, 0, err);
-		goto out2;
-	}
-
-	err = fuse4fs_read_inode(fs, ino, &inode);
+	err = fuse4fs_read_inode(fs, child, &inode);
 	if (err) {
-		ret = translate_error(fs, ino, err);
+		ret = translate_error(fs, child, err);
 		goto out2;
 	}
 
-	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	ret = fuse4fs_iflags_access(ff, child, EXT2_INODE(&inode), W_OK);
 	if (ret)
 		goto out2;
 
 	inode.i_links_count++;
-	ret = update_ctime(fs, ino, &inode);
+	ret = update_ctime(fs, child, &inode);
 	if (ret)
 		goto out2;
 
-	err = fuse4fs_write_inode(fs, ino, &inode);
+	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
-		ret = translate_error(fs, ino, err);
+		ret = translate_error(fs, child, err);
 		goto out2;
 	}
 
-	dbg_printf(ff, "%s: linking ino=%d/name=%s to dir=%d\n", __func__, ino,
-		   node_name, parent);
-	err = ext2fs_link(fs, parent, node_name, ino,
+	err = ext2fs_link(fs, parent, name, child,
 			  ext2_file_type(inode.i_mode) | EXT2FS_LINK_EXPAND);
 	if (err) {
 		ret = translate_error(fs, parent, err);
@@ -2766,13 +2665,12 @@ static int op_link(const char *src, const char *dest)
 
 out2:
 	fuse4fs_finish(ff, ret);
-out:
-	free(temp_path);
-	return ret;
+	fuse4fs_reply_entry(req, child, &inode, ret);
 }
 
 /* Obtain group ids of the process that sent us a command(?) */
-static int fuse4fs_get_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
+static int fuse4fs_get_groups(struct fuse4fs *ff, fuse_req_t req, gid_t **gids,
+			      size_t *nr_gids)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
@@ -2785,7 +2683,7 @@ static int fuse4fs_get_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
 		if (err)
 			return translate_error(fs, 0, err);
 
-		ret = fuse_getgroups(nr, array);
+		ret = fuse_req_getgroups(req, nr, array);
 		if (ret < 0) {
 			/*
 			 * If there's an error, we failed to find the group
@@ -2817,10 +2715,10 @@ static int fuse4fs_get_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
  * that initiated the fuse request?  Returns 1 for yes, 0 for no, or a negative
  * errno.
  */
-static int fuse4fs_in_file_group(struct fuse_context *ctxt,
+static int fuse4fs_in_file_group(struct fuse4fs *ff, fuse_req_t req,
 				 const struct ext2_inode_large *inode)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
 	gid_t *gids = NULL;
 	size_t i, nr_gids = 0;
 	gid_t gid = inode_gid(*inode);
@@ -2830,7 +2728,7 @@ static int fuse4fs_in_file_group(struct fuse_context *ctxt,
 	if (ctxt->gid == gid)
 		return 1;
 
-	ret = fuse4fs_get_groups(ff, &gids, &nr_gids);
+	ret = fuse4fs_get_groups(ff, req, &gids, &nr_gids);
 	if (ret == -ENOENT) {
 		/* magic return code for "could not get caller group info" */
 		return 0;
@@ -2850,37 +2748,21 @@ static int fuse4fs_in_file_group(struct fuse_context *ctxt,
 	return ret;
 }
 
-static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
+static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
+			 mode_t mode, struct ext2_inode_large *inode)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse4fs *ff = fuse4fs_get();
-	ext2_filsys fs;
-	errcode_t err;
-	ext2_ino_t ino;
-	struct ext2_inode_large inode;
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	fs = fuse4fs_start(ff);
-	ret = fuse4fs_file_ino(ff, path, fi, &ino);
-	if (ret)
-		goto out;
-	dbg_printf(ff, "%s: path=%s mode=0%o ino=%d\n", __func__, path, mode, ino);
-
-	err = fuse4fs_read_inode(fs, ino, &inode);
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out;
-	}
+	dbg_printf(ff, "%s: ino=%d mode=0%o\n", __func__, ino, mode);
 
-	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(inode), W_OK);
 	if (ret)
-		goto out;
+		return ret;
 
-	if (fuse4fs_want_check_owner(ff, ctxt) && ctxt->uid != inode_uid(inode)) {
-		ret = -EPERM;
-		goto out;
-	}
+	if (fuse4fs_want_check_owner(ff, ctxt) &&
+	    ctxt->uid != inode_uid(*inode))
+		return -EPERM;
 
 	/*
 	 * XXX: We should really check that the inode gid is not in /any/
@@ -2888,100 +2770,60 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 	 * group.
 	 */
 	if (!fuse4fs_is_superuser(ff, ctxt)) {
-		ret = fuse4fs_in_file_group(ctxt, &inode);
+		ret = fuse4fs_in_file_group(ff, req, inode);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		if (!ret)
 			mode &= ~S_ISGID;
 	}
 
-	inode.i_mode &= ~0xFFF;
-	inode.i_mode |= mode & 0xFFF;
+	inode->i_mode &= ~0xFFF;
+	inode->i_mode |= mode & 0xFFF;
 
-	dbg_printf(ff, "%s: path=%s new_mode=0%o ino=%d\n", __func__,
-		   path, inode.i_mode, ino);
+	dbg_printf(ff, "%s: ino=%d new_mode=0%o\n",
+		   __func__, ino, inode->i_mode);
 
-	ret = update_ctime(fs, ino, &inode);
-	if (ret)
-		goto out;
-
-	err = fuse4fs_write_inode(fs, ino, &inode);
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out;
-	}
-
-out:
-	fuse4fs_finish(ff, ret);
-	return ret;
+	return 0;
 }
 
-static int op_chown(const char *path, uid_t owner, gid_t group,
-		    struct fuse_file_info *fi)
+static int fuse4fs_chown(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
+			 ext2_ino_t ino, const int to_set,
+			 const struct stat *attr,
+			 struct ext2_inode_large *inode)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse4fs *ff = fuse4fs_get();
-	ext2_filsys fs;
-	errcode_t err;
-	ext2_ino_t ino;
-	struct ext2_inode_large inode;
+	uid_t owner = (to_set & FUSE_SET_ATTR_UID) ? attr->st_uid : (uid_t)~0;
+	gid_t group = (to_set & FUSE_SET_ATTR_GID) ? attr->st_gid : (gid_t)~0;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	fs = fuse4fs_start(ff);
-	ret = fuse4fs_file_ino(ff, path, fi, &ino);
-	if (ret)
-		goto out;
-	dbg_printf(ff, "%s: path=%s owner=%d group=%d ino=%d\n", __func__,
-		   path, owner, group, ino);
-
-	err = fuse4fs_read_inode(fs, ino, &inode);
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out;
-	}
+	dbg_printf(ff, "%s: ino=%d owner=%d group=%d\n",
+		   __func__, ino, owner, group);
 
-	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
+	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(inode), W_OK);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* FUSE seems to feed us ~0 to mean "don't change" */
 	if (owner != (uid_t) ~0) {
 		/* Only root gets to change UID. */
 		if (fuse4fs_want_check_owner(ff, ctxt) &&
-		    !(inode_uid(inode) == ctxt->uid && owner == ctxt->uid)) {
-			ret = -EPERM;
-			goto out;
-		}
-		fuse4fs_set_uid(&inode, owner);
+		    !(inode_uid(*inode) == ctxt->uid && owner == ctxt->uid))
+			return -EPERM;
+
+		fuse4fs_set_uid(inode, owner);
 	}
 
 	if (group != (gid_t) ~0) {
 		/* Only root or the owner get to change GID. */
 		if (fuse4fs_want_check_owner(ff, ctxt) &&
-		    inode_uid(inode) != ctxt->uid) {
-			ret = -EPERM;
-			goto out;
-		}
+		    inode_uid(*inode) != ctxt->uid)
+			return -EPERM;
 
 		/* XXX: We /should/ check group membership but FUSE */
-		fuse4fs_set_gid(&inode, group);
+		fuse4fs_set_gid(inode, group);
 	}
 
-	ret = update_ctime(fs, ino, &inode);
-	if (ret)
-		goto out;
-
-	err = fuse4fs_write_inode(fs, ino, &inode);
-	if (err) {
-		ret = translate_error(fs, ino, err);
-		goto out;
-	}
-
-out:
-	fuse4fs_finish(ff, ret);
-	return ret;
+	return 0;
 }
 
 static int fuse4fs_punch_posteof(struct fuse4fs *ff, ext2_ino_t ino,
@@ -3056,32 +2898,6 @@ static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
 	return 0;
 }
 
-static int op_truncate(const char *path, off_t len, struct fuse_file_info *fi)
-{
-	struct fuse4fs *ff = fuse4fs_get();
-	ext2_ino_t ino;
-	int ret = 0;
-
-	FUSE4FS_CHECK_CONTEXT(ff);
-	fuse4fs_start(ff);
-	ret = fuse4fs_file_ino(ff, path, fi, &ino);
-	if (ret)
-		goto out;
-	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, ino, (intmax_t) len);
-
-	ret = fuse4fs_inum_access(ff, ino, W_OK);
-	if (ret)
-		goto out;
-
-	ret = fuse4fs_truncate(ff, ino, len);
-	if (ret)
-		goto out;
-
-out:
-	fuse4fs_finish(ff, ret);
-	return ret;
-}
-
 #ifdef __linux__
 static void detect_linux_executable_open(int kernel_flags, int *access_check,
 				  int *e2fs_open_flags)
@@ -3103,19 +2919,20 @@ static void detect_linux_executable_open(int kernel_flags, int *access_check,
 }
 #endif /* __linux__ */
 
-static int __op_open(struct fuse4fs *ff, const char *path,
-		     struct fuse_file_info *fp)
+static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
+			     ext2_ino_t ino, struct fuse_file_info *fp)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct fuse4fs_file_handle *file;
 	int check = 0, ret = 0;
 
-	dbg_printf(ff, "%s: path=%s oflags=0o%o\n", __func__, path, fp->flags);
+	dbg_printf(ff, "%s: ino=%d oflags=0o%o\n", __func__, ino, fp->flags);
 	err = ext2fs_get_mem(sizeof(*file), &file);
 	if (err)
 		return translate_error(fs, 0, err);
 	file->magic = FUSE4FS_FILE_MAGIC;
+	file->ino = ino;
 
 	file->open_flags = 0;
 	switch (fp->flags & O_ACCMODE) {
@@ -3144,14 +2961,7 @@ static int __op_open(struct fuse4fs *ff, const char *path,
 	if (fp->flags & O_CREAT)
 		file->open_flags |= EXT2_FILE_CREATE;
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &file->ino);
-	if (err || file->ino == 0) {
-		ret = translate_error(fs, 0, err);
-		goto out;
-	}
-	dbg_printf(ff, "%s: ino=%d\n", __func__, file->ino);
-
-	ret = fuse4fs_inum_access(ff, file->ino, check);
+	ret = fuse4fs_inum_access(ff, ctxt, file->ino, check);
 	if (ret) {
 		/*
 		 * In a regular (Linux) fs driver, the kernel will open
@@ -3163,7 +2973,7 @@ static int __op_open(struct fuse4fs *ff, const char *path,
 		 * also employ undocumented hacks (see above).
 		 */
 		if (check == R_OK) {
-			ret = fuse4fs_inum_access(ff, file->ino, X_OK);
+			ret = fuse4fs_inum_access(ff, ctxt, file->ino, X_OK);
 			if (ret)
 				goto out;
 			check = X_OK;
@@ -3186,34 +2996,48 @@ static int __op_open(struct fuse4fs *ff, const char *path,
 	return ret;
 }
 
-static int op_open(const char *path, struct fuse_file_info *fp)
+static void op_open(fuse_req_t req, fuse_ino_t fino, struct fuse_file_info *fp)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_ino_t ino;
 	int ret;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
 	fuse4fs_start(ff);
-	ret = __op_open(ff, path, fp);
+	ret = fuse4fs_open_file(ff, ctxt, ino, fp);
 	fuse4fs_finish(ff, ret);
-	return ret;
+
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_open(req, fp);
 }
 
-static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
-		   size_t len, off_t offset,
-		   struct fuse_file_info *fp)
+static void op_read(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
+		    size_t len, off_t offset, struct fuse_file_info *fp)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs *ff = fuse4fs_get(req);
 	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
+	char *buf;
 	ext2_filsys fs;
 	ext2_file_t efp;
 	errcode_t err;
 	unsigned int got = 0;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	FUSE4FS_CHECK_HANDLE(ff, fh);
+	buf = calloc(len, sizeof(char));
+	if (!buf) {
+		fuse_reply_err(req, errno);
+		return;
+	}
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CHECK_HANDLE(req, fh);
 	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
 		   (unsigned long long)offset, len);
+
 	fs = fuse4fs_start(ff);
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
@@ -3249,14 +3073,18 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	}
 out:
 	fuse4fs_finish(ff, ret);
-	return got ? (int) got : ret;
+	if (got)
+		fuse_reply_buf(req, buf, got);
+	else
+		fuse_reply_err(req, -ret);
+	ext2fs_free_mem(&buf);
 }
 
-static int op_write(const char *path EXT2FS_ATTR((unused)),
-		    const char *buf, size_t len, off_t offset,
-		    struct fuse_file_info *fp)
+static void op_write(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
+		     const char *buf, size_t len, off_t offset,
+		     struct fuse_file_info *fp)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs *ff = fuse4fs_get(req);
 	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
 	ext2_filsys fs;
 	ext2_file_t efp;
@@ -3264,8 +3092,8 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	unsigned int got = 0;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	FUSE4FS_CHECK_HANDLE(ff, fh);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CHECK_HANDLE(req, fh);
 	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
 		   (unsigned long long) offset, len);
 	fs = fuse4fs_start(ff);
@@ -3319,20 +3147,23 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 
 out:
 	fuse4fs_finish(ff, ret);
-	return got ? (int) got : ret;
+	if (got)
+		fuse_reply_write(req, got);
+	else
+		fuse_reply_err(req, -ret);
 }
 
-static int op_release(const char *path EXT2FS_ATTR((unused)),
-		      struct fuse_file_info *fp)
+static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
+		       struct fuse_file_info *fp)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs *ff = fuse4fs_get(req);
 	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
 	ext2_filsys fs;
 	errcode_t err;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	FUSE4FS_CHECK_HANDLE(ff, fh);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CHECK_HANDLE(req, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	fs = fuse4fs_start(ff);
 
@@ -3349,21 +3180,21 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 
 	ext2fs_free_mem(&fh);
 
-	return ret;
+	fuse_reply_err(req, -ret);
 }
 
-static int op_fsync(const char *path EXT2FS_ATTR((unused)),
-		    int datasync EXT2FS_ATTR((unused)),
-		    struct fuse_file_info *fp)
+static void op_fsync(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
+		     int datasync EXT2FS_ATTR((unused)),
+		     struct fuse_file_info *fp)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs *ff = fuse4fs_get(req);
 	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
 	ext2_filsys fs;
 	errcode_t err;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	FUSE4FS_CHECK_HANDLE(ff, fh);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CHECK_HANDLE(req, fh);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	fs = fuse4fs_start(ff);
 	/* For now, flush everything, even if it's slow */
@@ -3374,22 +3205,24 @@ static int op_fsync(const char *path EXT2FS_ATTR((unused)),
 	}
 	fuse4fs_finish(ff, ret);
 
-	return ret;
+	fuse_reply_err(req, -ret);
 }
 
-static int op_statfs(const char *path EXT2FS_ATTR((unused)),
-		     struct statvfs *buf)
+static void op_statfs(fuse_req_t req, fuse_ino_t fino)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct statvfs buf;
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
 	uint64_t fsid, *f;
+	ext2_ino_t ino;
 	blk64_t overhead, reserved, free;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	dbg_printf(ff, "%s: path=%s\n", __func__, path);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
 	fs = fuse4fs_start(ff);
-	buf->f_bsize = fs->blocksize;
-	buf->f_frsize = 0;
+	buf.f_bsize = fs->blocksize;
+	buf.f_frsize = 0;
 
 	if (ff->minixdf)
 		overhead = 0;
@@ -3402,27 +3235,27 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 		reserved = ext2fs_blocks_count(fs->super) / 10;
 	free = ext2fs_free_blocks_count(fs->super);
 
-	buf->f_blocks = ext2fs_blocks_count(fs->super) - overhead;
-	buf->f_bfree = free;
+	buf.f_blocks = ext2fs_blocks_count(fs->super) - overhead;
+	buf.f_bfree = free;
 	if (free < reserved)
-		buf->f_bavail = 0;
+		buf.f_bavail = 0;
 	else
-		buf->f_bavail = free - reserved;
-	buf->f_files = fs->super->s_inodes_count;
-	buf->f_ffree = fs->super->s_free_inodes_count;
-	buf->f_favail = fs->super->s_free_inodes_count;
+		buf.f_bavail = free - reserved;
+	buf.f_files = fs->super->s_inodes_count;
+	buf.f_ffree = fs->super->s_free_inodes_count;
+	buf.f_favail = fs->super->s_free_inodes_count;
 	f = (uint64_t *)fs->super->s_uuid;
 	fsid = *f;
 	f++;
 	fsid ^= *f;
-	buf->f_fsid = fsid;
-	buf->f_flag = 0;
+	buf.f_fsid = fsid;
+	buf.f_flag = 0;
 	if (ff->opstate != F4OP_WRITABLE)
-		buf->f_flag |= ST_RDONLY;
-	buf->f_namemax = EXT2_NAME_LEN;
+		buf.f_flag |= ST_RDONLY;
+	buf.f_namemax = EXT2_NAME_LEN;
 	fuse4fs_finish(ff, 0);
 
-	return 0;
+	fuse_reply_statfs(req, &buf);
 }
 
 static const char *valid_xattr_prefixes[] = {
@@ -3446,35 +3279,33 @@ static int validate_xattr_name(const char *name)
 	return 0;
 }
 
-static int op_getxattr(const char *path, const char *key, char *value,
-		       size_t len)
+static void op_getxattr(fuse_req_t req, fuse_ino_t fino, const char *key,
+			size_t len)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
-	void *ptr;
+	void *ptr = NULL;
 	size_t plen;
 	ext2_ino_t ino;
-	errcode_t err;
 	int ret = 0;
 
-	if (!validate_xattr_name(key))
-		return -ENODATA;
+	if (!validate_xattr_name(key)) {
+		fuse_reply_err(req, ENODATA);
+		return;
+	}
 
-	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
 	fs = fuse4fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
 	}
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err || ino == 0) {
-		ret = translate_error(fs, 0, err);
-		goto out;
-	}
-	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
+	dbg_printf(ff, "%s: ino=%d name='%s'\n", __func__, ino, key);
 
-	ret = fuse4fs_inum_access(ff, ino, R_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, ino, R_OK);
 	if (ret)
 		goto out;
 
@@ -3483,19 +3314,26 @@ static int op_getxattr(const char *path, const char *key, char *value,
 		goto out;
 
 	if (!len) {
+		/* Just tell us the length */
 		ret = plen;
 	} else if (len < plen) {
+		/* Caller's buffer wasn't big enough */
 		ret = -ERANGE;
 	} else {
-		memcpy(value, ptr, plen);
+		/* We have data */
 		ret = plen;
 	}
 
+out:
+	fuse4fs_finish(ff, ret);
+
+	if (ret < 0)
+		fuse_reply_err(req, -ret);
+	else if (!len)
+		fuse_reply_xattr(req, ret);
+	else
+		fuse_reply_buf(req, ptr, ret);
 	ext2fs_free_mem(&ptr);
-out:
-	fuse4fs_finish(ff, ret);
-
-	return ret;
 }
 
 static int count_buffer_space(char *name, char *value EXT2FS_ATTR((unused)),
@@ -3520,31 +3358,30 @@ static int copy_names(char *name, char *value EXT2FS_ATTR((unused)),
 	return 0;
 }
 
-static int op_listxattr(const char *path, char *names, size_t len)
+static void op_listxattr(fuse_req_t req, fuse_ino_t fino, size_t len)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
+	char *names = NULL;
+	char *next_name;
 	unsigned int bufsz;
 	ext2_ino_t ino;
 	errcode_t err;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
 	fs = fuse4fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
 	}
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err || ino == 0) {
-		ret = translate_error(fs, ino, err);
-		goto out;
-	}
 	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
 
-	ret = fuse4fs_inum_access(ff, ino, R_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, ino, R_OK);
 	if (ret)
 		goto out;
 
@@ -3569,21 +3406,28 @@ static int op_listxattr(const char *path, char *names, size_t len)
 	}
 
 	if (len == 0) {
-		ret = bufsz;
+		/* Just tell us the length */
 		goto out2;
 	} else if (len < bufsz) {
+		/* Caller's buffer wasn't big enough */
 		ret = -ERANGE;
 		goto out2;
 	}
 
 	/* Copy names out */
-	memset(names, 0, len);
-	err = ext2fs_xattrs_iterate(h, copy_names, &names);
+	names = calloc(len, sizeof(char));
+	if (!names) {
+		ret = translate_error(fs, ino, errno);
+		goto out2;
+	}
+	next_name = names;
+
+	err = ext2fs_xattrs_iterate(h, copy_names, &next_name);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out2;
 	}
-	ret = bufsz;
+
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (err && !ret)
@@ -3591,41 +3435,47 @@ static int op_listxattr(const char *path, char *names, size_t len)
 out:
 	fuse4fs_finish(ff, ret);
 
-	return ret;
+	if (ret < 0)
+		fuse_reply_err(req, -ret);
+	else if (names)
+		fuse_reply_buf(req, names, bufsz);
+	else
+		fuse_reply_xattr(req, bufsz);
+	free(names);
 }
 
-static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
-		       const char *key, const char *value,
-		       size_t len, int flags)
+static void op_setxattr(fuse_req_t req, fuse_ino_t fino, const char *key,
+			const char *value, size_t len, int flags)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
 	ext2_ino_t ino;
 	errcode_t err;
 	int ret = 0;
 
-	if (flags & ~(XATTR_CREATE | XATTR_REPLACE))
-		return -EOPNOTSUPP;
+	if (flags & ~(XATTR_CREATE | XATTR_REPLACE)) {
+		fuse_reply_err(req, EOPNOTSUPP);
+		return;
+	}
 
-	if (!validate_xattr_name(key))
-		return -EINVAL;
+	if (!validate_xattr_name(key)) {
+		fuse_reply_err(req, EINVAL);
+		return;
+	}
 
-	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
 	fs = fuse4fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
 		goto out;
 	}
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err || ino == 0) {
-		ret = translate_error(fs, 0, err);
-		goto out;
-	}
-	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
+	dbg_printf(ff, "%s: ino=%d name='%s'\n", __func__, ino, key);
 
-	ret = fuse4fs_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, ino, W_OK);
 	if (ret == -EACCES) {
 		ret = -EPERM;
 		goto out;
@@ -3682,13 +3532,13 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		ret = translate_error(fs, ino, err);
 out:
 	fuse4fs_finish(ff, ret);
-
-	return ret;
+	fuse_reply_err(req, -ret);
 }
 
-static int op_removexattr(const char *path, const char *key)
+static void op_removexattr(fuse_req_t req, fuse_ino_t fino, const char *key)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
 	void *buf;
@@ -3701,13 +3551,18 @@ static int op_removexattr(const char *path, const char *key)
 	 * Once in a while libfuse gives us a no-name xattr to delete as part
 	 * of clearing ACLs.  Just pretend we cleared them.
 	 */
-	if (key[0] == 0)
-		return 0;
+	if (key[0] == 0) {
+		fuse_reply_err(req, 0);
+		return;
+	}
 
-	if (!validate_xattr_name(key))
-		return -ENODATA;
+	if (!validate_xattr_name(key)) {
+		fuse_reply_err(req, ENODATA);
+		return;
+	}
 
-	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
 	fs = fuse4fs_start(ff);
 	if (!ext2fs_has_feature_xattr(fs->super)) {
 		ret = -ENOTSUP;
@@ -3719,14 +3574,9 @@ static int op_removexattr(const char *path, const char *key)
 		goto out;
 	}
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err || ino == 0) {
-		ret = translate_error(fs, 0, err);
-		goto out;
-	}
 	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
-	ret = fuse4fs_inum_access(ff, ino, W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, ino, W_OK);
 	if (ret)
 		goto out;
 
@@ -3776,24 +3626,26 @@ static int op_removexattr(const char *path, const char *key)
 		ret = translate_error(fs, ino, err);
 out:
 	fuse4fs_finish(ff, ret);
-
-	return ret;
+	fuse_reply_err(req, -ret);
 }
 
 struct readdir_iter {
 	void *buf;
-	ext2_filsys fs;
-	fuse_fill_dir_t func;
+	size_t bufsz;
+	size_t bufused;
 
+	ext2_filsys fs;
 	struct fuse4fs *ff;
-	enum fuse_readdir_flags flags;
+	fuse_req_t req;
+
+	bool readdirplus;
 	unsigned int nr;
 	off_t startpos;
 	off_t dirpos;
 };
 
 static inline mode_t dirent_fmode(ext2_filsys fs,
-				   const struct ext2_dir_entry *dirent)
+				  const struct ext2_dir_entry *dirent)
 {
 	if (!ext2fs_has_feature_filetype(fs->super))
 		return 0;
@@ -3827,10 +3679,15 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 {
 	struct readdir_iter *i = data;
 	char namebuf[EXT2_NAME_LEN + 1];
-	struct stat stat = {
-		.st_ino = dirent->inode,
-		.st_mode = dirent_fmode(i->fs, dirent),
+	struct fuse4fs_stat fstat = {
+		.entry = {
+			.attr = {
+				.st_ino = dirent->inode,
+				.st_mode = dirent_fmode(i->fs, dirent),
+			},
+		},
 	};
+	size_t entrysize;
 	int ret;
 
 	i->dirpos++;
@@ -3838,48 +3695,67 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 		return 0;
 
 	dbg_printf(i->ff, "READDIR%s ino=%d %u offset=0x%llx\n",
-			i->flags == FUSE_READDIR_PLUS ? "PLUS" : "",
+			i->readdirplus ? "PLUS" : "",
 			dir,
 			i->nr++,
 			(unsigned long long)i->dirpos);
 
-	if (i->flags == FUSE_READDIR_PLUS) {
-		ret = stat_inode(i->fs, dirent->inode, &stat);
+	if (i->readdirplus) {
+		ret = fuse4fs_stat_inode(i->ff, dirent->inode, NULL, &fstat);
 		if (ret)
 			return DIRENT_ABORT;
 	}
 
 	memcpy(namebuf, dirent->name, dirent->name_len & 0xFF);
 	namebuf[dirent->name_len & 0xFF] = 0;
-	ret = i->func(i->buf, namebuf, &stat, i->dirpos , 0);
-	if (ret)
+
+	if (i->readdirplus) {
+		entrysize = fuse_add_direntry_plus(i->req, i->buf + i->bufused,
+						   i->bufsz - i->bufused,
+						   namebuf, &fstat.entry,
+						   i->dirpos);
+	} else {
+		entrysize = fuse_add_direntry(i->req, i->buf + i->bufused,
+					      i->bufsz - i->bufused, namebuf,
+					      &fstat.entry.attr, i->dirpos);
+	}
+	if (entrysize > i->bufsz - i->bufused) {
+		/* Buffer is full */
 		return DIRENT_ABORT;
+	}
 
+	i->bufused += entrysize;
 	return 0;
 }
 
-static int op_readdir(const char *path EXT2FS_ATTR((unused)), void *buf,
-		      fuse_fill_dir_t fill_func, off_t offset,
-		      struct fuse_file_info *fp, enum fuse_readdir_flags flags)
+static void __op_readdir(fuse_req_t req, fuse_ino_t fino, size_t size,
+			 off_t offset, bool plus, struct fuse_file_info *fp)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs *ff = fuse4fs_get(req);
 	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
 	errcode_t err;
 	struct readdir_iter i = {
 		.ff = ff,
+		.req = req,
 		.dirpos = 0,
 		.startpos = offset,
-		.flags = flags,
+		.readdirplus = plus,
+		.bufsz = size,
 	};
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	FUSE4FS_CHECK_HANDLE(ff, fh);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CHECK_HANDLE(req, fh);
 	dbg_printf(ff, "%s: ino=%d offset=0x%llx\n", __func__, fh->ino,
 			(unsigned long long)offset);
+
+	err = ext2fs_get_mem(size, &i.buf);
+	if (err) {
+		ret = translate_error(i.fs, fh->ino, err);
+		goto out;
+	}
+
 	i.fs = fuse4fs_start(ff);
-	i.buf = buf;
-	i.func = fill_func;
 	err = ext2fs_dir_iterate2(i.fs, fh->ino, 0, NULL, op_readdir_iter, &i);
 	if (err) {
 		ret = translate_error(i.fs, fh->ino, err);
@@ -3893,64 +3769,66 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)), void *buf,
 	}
 out:
 	fuse4fs_finish(ff, ret);
-	return ret;
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_buf(req, i.buf, i.bufused);
+
+	ext2fs_free_mem(&i.buf);
+}
+
+static void op_readdir(fuse_req_t req, fuse_ino_t fino, size_t size,
+		       off_t offset, struct fuse_file_info *fp)
+{
+	__op_readdir(req, fino, size, offset, false, fp);
+}
+
+static void op_readdirplus(fuse_req_t req, fuse_ino_t fino, size_t size,
+			   off_t offset, struct fuse_file_info *fp)
+{
+	__op_readdir(req, fino, size, offset, true, fp);
 }
 
-static int op_access(const char *path, int mask)
+static void op_access(fuse_req_t req, fuse_ino_t fino, int mask)
 {
-	struct fuse4fs *ff = fuse4fs_get();
-	ext2_filsys fs;
-	errcode_t err;
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_ino_t ino;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	dbg_printf(ff, "%s: path=%s mask=0x%x\n", __func__, path, mask);
-	fs = fuse4fs_start(ff);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err || ino == 0) {
-		ret = translate_error(fs, 0, err);
-		goto out;
-	}
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+	dbg_printf(ff, "%s: ino=%d mask=0x%x\n",
+		   __func__, ino, mask);
+	fuse4fs_start(ff);
 
-	ret = fuse4fs_inum_access(ff, ino, mask);
+	ret = fuse4fs_inum_access(ff, ctxt, ino, mask);
 	if (ret)
 		goto out;
 
 out:
 	fuse4fs_finish(ff, ret);
-	return ret;
+	fuse_reply_err(req, -ret);
 }
 
-static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
+static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
+		      mode_t mode, struct fuse_file_info *fp)
 {
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fuse4fs *ff = fuse4fs_get();
+	struct ext2_inode_large inode;
+	struct fuse4fs_stat fstat;
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
 	ext2_ino_t parent, child;
-	char *temp_path;
 	errcode_t err;
-	char *node_name, a;
 	int filetype;
-	struct ext2_inode_large inode;
 	gid_t gid;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	dbg_printf(ff, "%s: path=%s mode=0%o\n", __func__, path, mode);
-	temp_path = strdup(path);
-	if (!temp_path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	node_name = strrchr(temp_path, '/');
-	if (!node_name) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	node_name++;
-	a = *node_name;
-	*node_name = 0;
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &parent, fino);
+	dbg_printf(ff, "%s: parent=%d name='%s' mode=0%o\n",
+		   __func__, parent, name, mode);
 
 	fs = fuse4fs_start(ff);
 	if (!fuse4fs_can_allocate(ff, 1)) {
@@ -3958,23 +3836,14 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 	}
 
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
-			   &parent);
-	if (err) {
-		ret = translate_error(fs, 0, err);
-		goto out2;
-	}
-
-	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
+	ret = fuse4fs_inum_access(ff, ctxt, parent, A_OK | W_OK);
 	if (ret)
 		goto out2;
 
-	err = fuse4fs_new_child_gid(ff, parent, &gid, NULL);
+	err = fuse4fs_new_child_gid(ff, ctxt, parent, &gid, NULL);
 	if (err)
 		goto out2;
 
-	*node_name = a;
-
 	filetype = ext2_file_type(mode);
 
 	err = ext2fs_new_inode(fs, parent, mode, 0, &child);
@@ -3983,9 +3852,9 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 	}
 
-	dbg_printf(ff, "%s: creating ino=%d/name=%s in dir=%d\n", __func__, child,
-		   node_name, parent);
-	err = ext2fs_link(fs, parent, node_name, child,
+	dbg_printf(ff, "%s: creating dir=%d name='%s' child=%d\n",
+		   __func__, parent, name, child);
+	err = ext2fs_link(fs, parent, name, child,
 			  filetype | EXT2FS_LINK_EXPAND);
 	if (err) {
 		ret = translate_error(fs, parent, err);
@@ -4037,7 +3906,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		goto out2;
 
 	fp->flags &= ~O_TRUNC;
-	ret = __op_open(ff, path, fp);
+	ret = fuse4fs_open_file(ff, ctxt, child, fp);
 	if (ret)
 		goto out2;
 
@@ -4045,44 +3914,152 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	if (ret)
 		goto out2;
 
+	ret = fuse4fs_stat_inode(ff, child, NULL, &fstat);
+	if (ret)
+		goto out2;
+
 out2:
 	fuse4fs_finish(ff, ret);
-out:
-	free(temp_path);
-	return ret;
+
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_create(req, &fstat.entry, fp);
+}
+
+enum fuse4fs_time_action {
+	TA_NOW,		/* set to current time */
+	TA_OMIT,	/* do not set timestamp */
+	TA_THIS,	/* set to specific timestamp */
+};
+
+static inline const char *
+fuse4fs_time_action_string(enum fuse4fs_time_action act)
+{
+	switch (act) {
+	case TA_NOW:
+		return "now";
+	case TA_OMIT:
+		return "omit";
+	case TA_THIS:
+		return "specific";
+	}
+	return NULL; /* shut up gcc */
 }
 
-static int op_utimens(const char *path, const struct timespec ctv[2],
-		      struct fuse_file_info *fi)
+static int fuse4fs_utimens(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
+			   ext2_ino_t ino, const int to_set,
+			   const struct stat *attr,
+			   struct ext2_inode_large *inode)
 {
-	struct fuse4fs *ff = fuse4fs_get();
-	struct timespec tv[2];
-	ext2_filsys fs;
-	errcode_t err;
-	ext2_ino_t ino;
-	struct ext2_inode_large inode;
+	enum fuse4fs_time_action aact = TA_OMIT;
+	enum fuse4fs_time_action mact = TA_OMIT;
+	struct timespec atime = { };
+	struct timespec mtime = { };
+	struct timespec now = { };
 	int access = W_OK;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	fs = fuse4fs_start(ff);
-	ret = fuse4fs_file_ino(ff, path, fi, &ino);
-	if (ret)
-		goto out;
-	dbg_printf(ff, "%s: ino=%d atime=%lld.%ld mtime=%lld.%ld\n", __func__,
-			ino,
-			(long long int)ctv[0].tv_sec, ctv[0].tv_nsec,
-			(long long int)ctv[1].tv_sec, ctv[1].tv_nsec);
+	if (to_set & (FUSE_SET_ATTR_ATIME_NOW | FUSE_SET_ATTR_MTIME_NOW))
+		get_now(&now);
+
+	if (to_set & FUSE_SET_ATTR_ATIME_NOW) {
+		atime = now;
+		aact = TA_NOW;
+	} else if (to_set & FUSE_SET_ATTR_ATIME) {
+#if HAVE_STRUCT_STAT_ST_ATIM
+		atime = attr->st_atim;
+#else
+		atime.tv_sec = attr->st_atime;
+#endif
+		aact = TA_THIS;
+	}
+
+	if (to_set & FUSE_SET_ATTR_MTIME_NOW) {
+		mtime = now;
+		mact = TA_NOW;
+	} else if (to_set & FUSE_SET_ATTR_MTIME) {
+#if HAVE_STRUCT_STAT_ST_ATIM
+		mtime = attr->st_mtim;
+#else
+		mtime.tv_sec = attr->st_mtime;
+#endif
+		mact = TA_THIS;
+	}
+
+	dbg_printf(ff, "%s: ino=%d atime=%s:%lld.%ld mtime=%s:%lld.%ld\n",
+		   __func__, ino, fuse4fs_time_action_string(aact),
+		   (long long int)atime.tv_sec, atime.tv_nsec,
+		   fuse4fs_time_action_string(mact),
+		   (long long int)mtime.tv_sec, mtime.tv_nsec);
 
 	/*
 	 * ext4 allows timestamp updates of append-only files but only if we're
 	 * setting to current time
 	 */
-	if (ctv[0].tv_nsec == UTIME_NOW && ctv[1].tv_nsec == UTIME_NOW)
+	if (aact == TA_NOW && mact == TA_NOW)
 		access |= A_OK;
-	ret = fuse4fs_inum_access(ff, ino, access);
+	ret = fuse4fs_inum_access(ff, ctxt, ino, access);
 	if (ret)
+		return ret;
+
+	if (aact != TA_OMIT)
+		EXT4_INODE_SET_XTIME(i_atime, &atime, inode);
+	if (mact != TA_OMIT)
+		EXT4_INODE_SET_XTIME(i_mtime, &mtime, inode);
+
+	return 0;
+}
+
+static int fuse4fs_setsize(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
+			   ext2_ino_t ino, off_t new_size,
+			   struct ext2_inode_large *inode)
+{
+	errcode_t err;
+	int ret;
+
+	/* Write inode because truncate makes its own copy */
+	err = fuse4fs_write_inode(ff->fs, ino, inode);
+	if (err)
+		return translate_error(ff->fs, ino, err);
+
+	ret = fuse4fs_inum_access(ff, ctxt, ino, W_OK);
+	if (ret)
+		return ret;
+
+	ret = fuse4fs_truncate(ff, ino, new_size);
+	if (ret)
+		return ret;
+
+	/* Re-read inode after truncate */
+	err = fuse4fs_read_inode(ff->fs, ino, inode);
+	if (err)
+		return translate_error(ff->fs, ino, err);
+
+	return 0;
+}
+
+static void op_setattr(fuse_req_t req, fuse_ino_t fino, struct stat *attr,
+		       int to_set, struct fuse_file_info *fi EXT2FS_ATTR((unused)))
+{
+	struct ext2_inode_large inode;
+	struct fuse4fs_stat fstat;
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+	ext2_ino_t ino;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+	dbg_printf(ff, "%s: ino=%d to_set=0x%x\n", __func__, ino, to_set);
+	fs = fuse4fs_start(ff);
+
+	if (!fuse4fs_is_writeable(ff)) {
+		ret = -EROFS;
 		goto out;
+	}
 
 	err = fuse4fs_read_inode(fs, ino, &inode);
 	if (err) {
@@ -4090,20 +4067,35 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 		goto out;
 	}
 
-	tv[0] = ctv[0];
-	tv[1] = ctv[1];
-#ifdef UTIME_NOW
-	if (tv[0].tv_nsec == UTIME_NOW)
-		get_now(tv);
-	if (tv[1].tv_nsec == UTIME_NOW)
-		get_now(tv + 1);
-#endif /* UTIME_NOW */
-#ifdef UTIME_OMIT
-	if (tv[0].tv_nsec != UTIME_OMIT)
-		EXT4_INODE_SET_XTIME(i_atime, &tv[0], &inode);
-	if (tv[1].tv_nsec != UTIME_OMIT)
-		EXT4_INODE_SET_XTIME(i_mtime, &tv[1], &inode);
-#endif /* UTIME_OMIT */
+	/* Handle mode change using helper */
+	if (to_set & FUSE_SET_ATTR_MODE) {
+		ret = fuse4fs_chmod(ff, req, ino, attr->st_mode, &inode);
+		if (ret)
+			goto out;
+	}
+
+	/* Handle owner/group change using helper */
+	if (to_set & (FUSE_SET_ATTR_UID | FUSE_SET_ATTR_GID)) {
+		ret = fuse4fs_chown(ff, ctxt, ino, to_set, attr, &inode);
+		if (ret)
+			goto out;
+	}
+
+	/* Handle size change using helper */
+	if (to_set & FUSE_SET_ATTR_SIZE) {
+		ret = fuse4fs_setsize(ff, ctxt, ino, attr->st_size, &inode);
+		if (ret)
+			goto out;
+	}
+
+	/* Handle time changes using helper */
+	if (to_set & (FUSE_SET_ATTR_ATIME | FUSE_SET_ATTR_MTIME)) {
+		ret = fuse4fs_utimens(ff, ctxt, ino, to_set, attr, &inode);
+		if (ret)
+			goto out;
+	}
+
+	/* Update ctime for any attribute change */
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)
 		goto out;
@@ -4114,9 +4106,17 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 		goto out;
 	}
 
+	/* Get updated stat info to return */
+	ret = fuse4fs_stat_inode(ff, ino, &inode, &fstat);
+
 out:
 	fuse4fs_finish(ff, ret);
-	return ret;
+
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_attr(req, &fstat.entry.attr,
+				fstat.entry.attr_timeout);
 }
 
 #define FUSE4FS_MODIFIABLE_IFLAGS \
@@ -4135,32 +4135,38 @@ static inline int set_iflags(struct ext2_inode_large *inode, __u32 iflags)
 
 #ifdef SUPPORT_I_FLAGS
 static int ioctl_getflags(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
-			  void *data)
+			  __u32 *outdata, size_t *outsize)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode;
 
+	if (*outsize < sizeof(__u32))
+		return -EFAULT;
+
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse4fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	*(__u32 *)data = inode.i_flags & EXT2_FL_USER_VISIBLE;
+	*outdata = inode.i_flags & EXT2_FL_USER_VISIBLE;
+	*outsize = sizeof(__u32);
 	return 0;
 }
 
-static int ioctl_setflags(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
-			  void *data)
+static int ioctl_setflags(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
+			  struct fuse4fs_file_handle *fh, const __u32 *indata,
+			  size_t insize)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode;
 	int ret;
-	__u32 flags = *(__u32 *)data;
-	struct fuse_context *ctxt = fuse_get_context();
 
-	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	if (insize < sizeof(__u32))
+		return -EFAULT;
+
+	dbg_printf(ff, "%s: ino=%d iflags=0x%x\n", __func__, fh->ino, *indata);
 	err = fuse4fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -4168,7 +4174,7 @@ static int ioctl_setflags(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
-	ret = set_iflags(&inode, flags);
+	ret = set_iflags(&inode, *indata);
 	if (ret)
 		return ret;
 
@@ -4184,32 +4190,38 @@ static int ioctl_setflags(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 }
 
 static int ioctl_getversion(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
-			    void *data)
+			    __u32 *outdata, size_t *outsize)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode;
 
+	if (*outsize < sizeof(__u32))
+		return -EFAULT;
+
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse4fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	*(__u32 *)data = inode.i_generation;
+	*outdata = inode.i_generation;
+	*outsize = sizeof(__u32);
 	return 0;
 }
 
-static int ioctl_setversion(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
-			    void *data)
+static int ioctl_setversion(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
+			    struct fuse4fs_file_handle *fh, const __u32 *indata,
+			    size_t insize)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode;
 	int ret;
-	__u32 generation = *(__u32 *)data;
-	struct fuse_context *ctxt = fuse_get_context();
 
-	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	if (insize < sizeof(__u32))
+		return -EFAULT;
+
+	dbg_printf(ff, "%s: ino=%d generation=%d\n", __func__, fh->ino, *indata);
 	err = fuse4fs_read_inode(fs, fh->ino, &inode);
 	if (err)
 		return translate_error(fs, fh->ino, err);
@@ -4217,7 +4229,7 @@ static int ioctl_setversion(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
-	inode.i_generation = generation;
+	inode.i_generation = *indata;
 
 	ret = update_ctime(fs, fh->ino, &inode);
 	if (ret)
@@ -4254,14 +4266,16 @@ static __u32 iflags_to_fsxflags(__u32 iflags)
 }
 
 static int ioctl_fsgetxattr(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
-			    void *data)
+			    struct fsxattr *fsx, size_t *outsize)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode;
-	struct fsxattr *fsx = data;
 	unsigned int inode_size;
 
+	if (*outsize < sizeof(struct fsxattr))
+		return -EFAULT;
+
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse4fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4272,6 +4286,7 @@ static int ioctl_fsgetxattr(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	if (ext2fs_inode_includes(inode_size, i_projid))
 		fsx->fsx_projid = inode_projid(inode);
 	fsx->fsx_xflags = iflags_to_fsxflags(inode.i_flags);
+	*outsize = sizeof(struct fsxattr);
 	return 0;
 }
 
@@ -4323,17 +4338,19 @@ static inline int set_xflags(struct ext2_inode_large *inode, __u32 xflags)
 	return 0;
 }
 
-static int ioctl_fssetxattr(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
-			    void *data)
+static int ioctl_fssetxattr(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
+			    struct fuse4fs_file_handle *fh,
+			    const struct fsxattr *fsx, size_t insize)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
 	struct ext2_inode_large inode;
 	int ret;
-	struct fuse_context *ctxt = fuse_get_context();
-	struct fsxattr *fsx = data;
 	unsigned int inode_size;
 
+	if (insize < sizeof(struct fsxattr))
+		return -EFAULT;
+
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	err = fuse4fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4364,17 +4381,24 @@ static int ioctl_fssetxattr(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 
 #ifdef FITRIM
 static int ioctl_fitrim(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
-			void *data)
+			const struct fstrim_range *fr_in, size_t insize,
+			struct fstrim_range *fr, size_t *outsize)
 {
 	ext2_filsys fs = ff->fs;
-	struct fstrim_range *fr = data;
 	blk64_t start, end, max_blocks, b, cleared, minlen;
 	blk64_t max_blks = ext2fs_blocks_count(fs->super);
 	errcode_t err = 0;
 
+	if (insize < sizeof(struct fstrim_range))
+		return -EFAULT;
+
+	if (*outsize < sizeof(struct fstrim_range))
+		return -EFAULT;
+
 	if (!fuse4fs_is_writeable(ff))
 		return -EROFS;
 
+	memcpy(fr, fr_in, sizeof(*fr));
 	start = FUSE4FS_B_TO_FSBT(ff, fr->start);
 	if (fr->len == -1ULL)
 		end = -1ULL;
@@ -4453,6 +4477,7 @@ static int ioctl_fitrim(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 
 out:
 	fr->len = FUSE4FS_FSB_TO_B(ff, cleared);
+	*outsize = sizeof(struct fstrim_range);
 	dbg_printf(ff, "%s: len=%llu err=%ld\n", __func__, fr->len, err);
 	return err;
 }
@@ -4462,10 +4487,10 @@ static int ioctl_fitrim(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 # define EXT4_IOC_SHUTDOWN	_IOR('X', 125, __u32)
 #endif
 
-static int ioctl_shutdown(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
-			  void *data)
+static int ioctl_shutdown(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
+			  struct fuse4fs_file_handle *fh, const void *indata,
+			  size_t insize)
 {
-	struct fuse_context *ctxt = fuse_get_context();
 	ext2_filsys fs = ff->fs;
 
 	if (!fuse4fs_is_superuser(ff, ctxt))
@@ -4485,49 +4510,61 @@ static int ioctl_shutdown(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	return 0;
 }
 
-static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
-		    unsigned int cmd,
-		    void *arg EXT2FS_ATTR((unused)),
-		    struct fuse_file_info *fp,
-		    unsigned int flags EXT2FS_ATTR((unused)), void *data)
+static void op_ioctl(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
+		     unsigned int cmd,
+		     void *arg EXT2FS_ATTR((unused)),
+		     struct fuse_file_info *fp,
+		     unsigned int flags EXT2FS_ATTR((unused)),
+		     const void *indata, size_t insize,
+		     size_t outsize)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
 	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
+	void *outdata = NULL;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	FUSE4FS_CHECK_HANDLE(ff, fh);
+	if (outsize > 0) {
+		outdata = calloc(outsize, sizeof(char));
+		if (!outdata) {
+			fuse_reply_err(req, errno);
+			return;
+		}
+	}
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CHECK_HANDLE(req, fh);
 	fuse4fs_start(ff);
 	switch ((unsigned long) cmd) {
 #ifdef SUPPORT_I_FLAGS
 	case EXT2_IOC_GETFLAGS:
-		ret = ioctl_getflags(ff, fh, data);
+		ret = ioctl_getflags(ff, fh, outdata, &outsize);
 		break;
 	case EXT2_IOC_SETFLAGS:
-		ret = ioctl_setflags(ff, fh, data);
+		ret = ioctl_setflags(ff, ctxt, fh, indata, insize);
 		break;
 	case EXT2_IOC_GETVERSION:
-		ret = ioctl_getversion(ff, fh, data);
+		ret = ioctl_getversion(ff, fh, outdata, &outsize);
 		break;
 	case EXT2_IOC_SETVERSION:
-		ret = ioctl_setversion(ff, fh, data);
+		ret = ioctl_setversion(ff, ctxt, fh, indata, insize);
 		break;
 #endif
 #ifdef FS_IOC_FSGETXATTR
 	case FS_IOC_FSGETXATTR:
-		ret = ioctl_fsgetxattr(ff, fh, data);
+		ret = ioctl_fsgetxattr(ff, fh, outdata, &outsize);
 		break;
 	case FS_IOC_FSSETXATTR:
-		ret = ioctl_fssetxattr(ff, fh, data);
+		ret = ioctl_fssetxattr(ff, ctxt, fh, indata, insize);
 		break;
 #endif
 #ifdef FITRIM
 	case FITRIM:
-		ret = ioctl_fitrim(ff, fh, data);
+		ret = ioctl_fitrim(ff, fh, indata, insize, outdata, &outsize);
 		break;
 #endif
 	case EXT4_IOC_SHUTDOWN:
-		ret = ioctl_shutdown(ff, fh, data);
+		ret = ioctl_shutdown(ff, ctxt, fh, indata, insize);
 		break;
 	default:
 		dbg_printf(ff, "%s: Unknown ioctl %d\n", __func__, cmd);
@@ -4535,28 +4572,29 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 	}
 	fuse4fs_finish(ff, ret);
 
-	return ret;
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_ioctl(req, 0, outdata, outsize);
+	free(outdata);
 }
 
-static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
-		   uint64_t *idx)
+static void op_bmap(fuse_req_t req, fuse_ino_t fino,
+		    size_t blocksize EXT2FS_ATTR((unused)), uint64_t idx)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
 	ext2_ino_t ino;
+	blk64_t blkno;
 	errcode_t err;
 	int ret = 0;
 
-	FUSE4FS_CHECK_CONTEXT(ff);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
 	fs = fuse4fs_start(ff);
-	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err) {
-		ret = translate_error(fs, 0, err);
-		goto out;
-	}
-	dbg_printf(ff, "%s: ino=%d blk=%"PRIu64"\n", __func__, ino, *idx);
+	dbg_printf(ff, "%s: ino=%d blk=%"PRIu64"\n", __func__, ino, idx);
 
-	err = ext2fs_bmap2(fs, ino, NULL, NULL, 0, *idx, 0, (blk64_t *)idx);
+	err = ext2fs_bmap2(fs, ino, NULL, NULL, 0, idx, 0, &blkno);
 	if (err) {
 		ret = translate_error(fs, ino, err);
 		goto out;
@@ -4564,7 +4602,10 @@ static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 
 out:
 	fuse4fs_finish(ff, ret);
-	return ret;
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_bmap(req, blkno);
 }
 
 #ifdef SUPPORT_FALLOCATE
@@ -4807,20 +4848,22 @@ static int fuse4fs_zero_range(struct fuse4fs *ff,
 	return ret;
 }
 
-static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
-			off_t offset, off_t len,
-			struct fuse_file_info *fp)
+static void op_fallocate(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
+			 int mode, off_t offset, off_t len,
+			 struct fuse_file_info *fp)
 {
-	struct fuse4fs *ff = fuse4fs_get();
+	struct fuse4fs *ff = fuse4fs_get(req);
 	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
 	int ret;
 
 	/* Catch unknown flags */
-	if (mode & ~(FL_ZERO_RANGE_FLAG | FL_PUNCH_HOLE_FLAG | FL_KEEP_SIZE_FLAG))
-		return -EOPNOTSUPP;
+	if (mode & ~(FL_ZERO_RANGE_FLAG | FL_PUNCH_HOLE_FLAG | FL_KEEP_SIZE_FLAG)) {
+		fuse_reply_err(req, EOPNOTSUPP);
+		return;
+	}
 
-	FUSE4FS_CHECK_CONTEXT(ff);
-	FUSE4FS_CHECK_HANDLE(ff, fh);
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CHECK_HANDLE(req, fh);
 	fuse4fs_start(ff);
 	if (!fuse4fs_is_writeable(ff)) {
 		ret = -EROFS;
@@ -4840,12 +4883,13 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 		ret = fuse4fs_allocate_range(ff, fh, mode, offset, len);
 out:
 	fuse4fs_finish(ff, ret);
-
-	return ret;
+	fuse_reply_err(req, -ret);
 }
 #endif /* SUPPORT_FALLOCATE */
 
-static struct fuse_operations fs_ops = {
+static struct fuse_lowlevel_ops fs_ops = {
+	.lookup = op_lookup,
+	.setattr = op_setattr,
 	.init = op_init,
 	.destroy = op_destroy,
 	.getattr = op_getattr,
@@ -4857,9 +4901,6 @@ static struct fuse_operations fs_ops = {
 	.symlink = op_symlink,
 	.rename = op_rename,
 	.link = op_link,
-	.chmod = op_chmod,
-	.chown = op_chown,
-	.truncate = op_truncate,
 	.open = op_open,
 	.read = op_read,
 	.write = op_write,
@@ -4872,11 +4913,11 @@ static struct fuse_operations fs_ops = {
 	.removexattr = op_removexattr,
 	.opendir = op_open,
 	.readdir = op_readdir,
+	.readdirplus = op_readdirplus,
 	.releasedir = op_release,
 	.fsyncdir = op_fsync,
 	.access = op_access,
 	.create = op_create,
-	.utimens = op_utimens,
 	.bmap = op_bmap,
 #ifdef SUPERFLUOUS
 	.lock = op_lock,
@@ -5025,8 +5066,8 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE4FS_HELPFULL) {
-			fuse_opt_add_arg(outargs, "-h");
-			fuse_main(outargs->argc, outargs->argv, &fs_ops, NULL);
+			printf("FUSE options:\n");
+			fuse_cmdline_help();
 		} else {
 			fprintf(stderr, "Try --helpfull to get a list of "
 				"all flags, including the FUSE options.\n");
@@ -5036,8 +5077,7 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 	case FUSE4FS_VERSION:
 		fprintf(stderr, "fuse4fs %s (%s)\n", E2FSPROGS_VERSION,
 			E2FSPROGS_DATE);
-		fuse_opt_add_arg(outargs, "--version");
-		fuse_main(outargs->argc, outargs->argv, &fs_ops, NULL);
+		fprintf(stderr, "FUSE library version %s\n", fuse_pkgversion());
 		exit(0);
 	}
 	return 1;
@@ -5106,6 +5146,107 @@ static void fuse4fs_com_err_proc(const char *whoami, errcode_t code,
 	fflush(stderr);
 }
 
+static int fuse4fs_main(struct fuse_args *args, struct fuse4fs *ff)
+{
+	struct fuse_cmdline_opts opts;
+	struct fuse_session *se;
+	struct fuse_loop_config *loop_config = NULL;
+	int ret;
+
+	if (fuse_parse_cmdline(args, &opts) != 0) {
+		ret = 1;
+		goto out;
+	}
+
+	if (ff->debug)
+		opts.debug = true;
+
+	if (opts.show_help) {
+		fuse_cmdline_help();
+		ret = 0;
+		goto out_free_opts;
+	}
+
+	if (opts.show_version) {
+		printf("FUSE library version %s\n", fuse_pkgversion());
+		ret = 0;
+		goto out_free_opts;
+	}
+
+	if (!opts.mountpoint) {
+		fprintf(stderr, "error: no mountpoint specified\n");
+		ret = 2;
+		goto out_free_opts;
+	}
+
+	se = fuse_session_new(args, &fs_ops, sizeof(fs_ops), ff);
+	if (se == NULL) {
+		ret = 3;
+		goto out_free_opts;
+	}
+	ff->fuse = se;
+
+	if (fuse_session_mount(se, opts.mountpoint) != 0) {
+		ret = 4;
+		goto out_destroy_session;
+	}
+
+	if (fuse_daemonize(opts.foreground) != 0) {
+		ret = 5;
+		goto out_unmount;
+	}
+
+	/*
+	 * Configure logging a second time, because libfuse might have
+	 * redirected std{out,err} as part of daemonization.  If this fails,
+	 * give up and move on.
+	 */
+	fuse4fs_setup_logging(ff);
+	if (ff->logfd >= 0)
+		close(ff->logfd);
+	ff->logfd = -1;
+
+	if (fuse_set_signal_handlers(se) != 0) {
+		ret = 6;
+		goto out_unmount;
+	}
+
+	loop_config = fuse_loop_cfg_create();
+	if (loop_config == NULL) {
+		ret = 7;
+		goto out_remove_signal_handlers;
+	}
+
+	/*
+	 * Since there's a Big Kernel Lock around all the libext2fs code, we
+	 * only need to start four threads -- one to decode a request, another
+	 * to do the filesystem work, a third to transmit the reply, and a
+	 * fourth to handle fuse notifications.
+	 */
+	fuse_loop_cfg_set_clone_fd(loop_config, opts.clone_fd);
+	fuse_loop_cfg_set_idle_threads(loop_config, opts.max_idle_threads);
+	fuse_loop_cfg_set_max_threads(loop_config, 4);
+
+	if (fuse_session_loop_mt(se, loop_config) != 0) {
+		ret = 8;
+		goto out_loopcfg;
+	}
+
+out_loopcfg:
+	fuse_loop_cfg_destroy(loop_config);
+out_remove_signal_handlers:
+	fuse_remove_signal_handlers(se);
+out_unmount:
+	fuse_session_unmount(se);
+out_destroy_session:
+	ff->fuse = NULL;
+	fuse_session_destroy(se);
+out_free_opts:
+	free(opts.mountpoint);
+out:
+	return ret;
+}
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -5247,8 +5388,7 @@ int main(int argc, char *argv[])
 	get_random_bytes(&fctx.next_generation, sizeof(unsigned int));
 
 	/* Set up default fuse parameters */
-	snprintf(extra_args, BUFSIZ, "-okernel_cache,subtype=%s,"
-		 "fsname=%s,attr_timeout=0",
+	snprintf(extra_args, BUFSIZ, "-osubtype=%s,fsname=%s",
 		 get_subtype(argv[0]),
 		 fctx.device);
 	if (fctx.no_default_opts == 0)
@@ -5276,14 +5416,6 @@ int main(int argc, char *argv[])
  "-oallow_other,default_permissions,suid,dev");
 	}
 
-	/*
-	 * Since there's a Big Kernel Lock around all the libext2fs code, we
-	 * only need to start four threads -- one to decode a request, another
-	 * to do the filesystem work, a third to transmit the reply, and a
-	 * fourth to handle fuse notifications.
-	 */
-	fuse_opt_insert_arg(&args, 1, "-omax_threads=4");
-
 	if (fctx.debug) {
 		int	i;
 
@@ -5295,7 +5427,7 @@ int main(int argc, char *argv[])
 	}
 
 	pthread_mutex_init(&fctx.bfl, NULL);
-	ret = fuse_main(args.argc, args.argv, &fs_ops, &fctx);
+	ret = fuse4fs_main(&args, &fctx);
 	pthread_mutex_destroy(&fctx.bfl);
 
 	switch(ret) {


