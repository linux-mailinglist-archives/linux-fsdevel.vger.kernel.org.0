Return-Path: <linux-fsdevel+bounces-58502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3610B2EA19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4788AA01429
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BE31F4289;
	Thu, 21 Aug 2025 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB2Q0NXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEF75FEE6;
	Thu, 21 Aug 2025 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738504; cv=none; b=H77LWw7o6c91+uv2Vavawedn5BN29utCAJN9rIn1aS9BIH32Y9EKmTedaLBO4oIYf4vnuBoehjc4hYsbICk6YI88DrpPyLzcvYCSvwE5VxegxTjjNUe/mwOV7JyQgAGMfbRzKdId8CdQqqQZZynLBUjbzJFUmFW1nR0U0ABYaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738504; c=relaxed/simple;
	bh=LJ65lM0FFqVkE6d6DpsWcc7obBnUk3YEjNMnVRqX79s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEA9Kkyk3usdZMjkrhr/DdDQPyRyDcYLO16k92ZPCJewldAD2cxbjokdCicT95MMLiuLeByic633DKVIbiETbnFJnW4K7X4bVdvBF6/gXxa4c1eH1nLJydq6peI5RoffUUI9kktOcxAeS7t73NhzUMkfN7SdbJc9Hc05N2qYZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB2Q0NXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C600C4CEE7;
	Thu, 21 Aug 2025 01:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738504;
	bh=LJ65lM0FFqVkE6d6DpsWcc7obBnUk3YEjNMnVRqX79s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hB2Q0NXVL5hvRT9VZBdCivnvUANj56hktg4pmk9zYfyN/MrOUQ0sNPSNMX+K32F0b
	 iMIik1bVLZVnBX+jL+UmraWX4BrFHvd0Rw51ht/3RBunqRKNDor0a5C0+0gVJdxg6c
	 70zfBoWtQ3ypSpE6nZ8nUBS/gEI6d/WWCOmLLSQCqpXPB+x6QtmP3gNa4zLYooH9LT
	 l2x0dgnI09fTmyGILZ647cDxiXoALUD0dOHG70InuW7ISxwt5obV63EGMpr9muIm0n
	 CXlXnE1clb+Yp5qeGHLkF3g4H48yh+aF0Og/9G+osalKEE7rycOuqvisG6t3MEtMFk
	 ogtuK/pfQcxqQ==
Date: Wed, 20 Aug 2025 18:08:23 -0700
Subject: [PATCH 02/20] fuse4fs: drop fuse 2.x support code
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: amir73il@gmail.com, John@groves.net, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 amir73il@gmail.com, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573712845.20753.8259223701587604696.stgit@frogsfrogsfrogs>
In-Reply-To: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
References: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

We only enable fuse4fs if libfuse is from the 3.xx series and the
lowlevel libfuse API is present.  Drop support for 2.x.  This part is
cribbed from Amir who used an LLM aided conversion.

Note: I actually check for the lowlevel ops in configure.ac because
there are some fuse3 forks <cough>Windows<cough> that do not provide
that API.

Co-developed-by: Claude claude-4-sonnet
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse4fs.c |  219 ++++++--------------------------------------------------
 1 file changed, 24 insertions(+), 195 deletions(-)


diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 1b8240e56562d6..e6e5729936f6a1 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -48,15 +48,6 @@
 #include "ext2fs/ext2fs.h"
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fsP.h"
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-# define FUSE_PLATFORM_OPTS	""
-#else
-# ifdef __linux__
-#  define FUSE_PLATFORM_OPTS	",use_ino,big_writes"
-# else
-#  define FUSE_PLATFORM_OPTS	",use_ino"
-# endif
-#endif
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -171,11 +162,9 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 		break; \
 	}
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
-# ifdef _IOR
-#  ifdef _IOW
-#   define SUPPORT_I_FLAGS
-#  endif
+#ifdef _IOR
+# ifdef _IOW
+#  define SUPPORT_I_FLAGS
 # endif
 #endif
 
@@ -1292,11 +1281,8 @@ static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
 }
 #endif
 
-static void *op_init(struct fuse_conn_info *conn
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_config *cfg EXT2FS_ATTR((unused))
-#endif
-			)
+static void *op_init(struct fuse_conn_info *conn,
+		     struct fuse_config *cfg EXT2FS_ATTR((unused)))
 {
 	struct fuse4fs *ff = fuse4fs_get();
 	ext2_filsys fs;
@@ -1328,13 +1314,11 @@ static void *op_init(struct fuse_conn_info *conn
 #ifdef FUSE_CAP_NO_EXPORT_SUPPORT
 	fuse_set_feature_flag(conn, FUSE_CAP_NO_EXPORT_SUPPORT);
 #endif
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
 	cfg->use_ino = 1;
 	if (ff->debug)
 		cfg->debug = 1;
 	cfg->nullpath_ok = 1;
-#endif
 
 	if (ff->kernel) {
 		char uuid[UUID_STR_SIZE];
@@ -1412,9 +1396,7 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 }
 
 static int __fuse4fs_file_ino(struct fuse4fs *ff, const char *path,
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			      struct fuse_file_info *fp EXT2FS_ATTR((unused)),
-#endif
 			      ext2_ino_t *inop,
 			      const char *func,
 			      int line)
@@ -1422,7 +1404,6 @@ static int __fuse4fs_file_ino(struct fuse4fs *ff, const char *path,
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	if (fp) {
 		struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
 
@@ -1433,7 +1414,7 @@ static int __fuse4fs_file_ino(struct fuse4fs *ff, const char *path,
 		dbg_printf(ff, "%s: get ino=%d\n", func, fh->ino);
 		return 0;
 	}
-#endif
+
 	dbg_printf(ff, "%s: get path=%s\n", func, path);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, inop);
 	if (err)
@@ -1442,19 +1423,11 @@ static int __fuse4fs_file_ino(struct fuse4fs *ff, const char *path,
 	return 0;
 }
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 # define fuse4fs_file_ino(ff, path, fp, inop) \
 	__fuse4fs_file_ino((ff), (path), (fp), (inop), __func__, __LINE__)
-#else
-# define fuse4fs_file_ino(ff, path, fp, inop) \
-	__fuse4fs_file_ino((ff), (path), NULL, (inop), __func__, __LINE__)
-#endif
 
-static int op_getattr(const char *path, struct stat *statbuf
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi
-#endif
-			)
+static int op_getattr(const char *path, struct stat *statbuf,
+		      struct fuse_file_info *fi)
 {
 	struct fuse4fs *ff = fuse4fs_get();
 	ext2_filsys fs;
@@ -2439,11 +2412,8 @@ static int update_dotdot_helper(ext2_ino_t dir EXT2FS_ATTR((unused)),
 	return 0;
 }
 
-static int op_rename(const char *from, const char *to
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, unsigned int flags EXT2FS_ATTR((unused))
-#endif
-			)
+static int op_rename(const char *from, const char *to,
+		     unsigned int flags EXT2FS_ATTR((unused)))
 {
 	struct fuse4fs *ff = fuse4fs_get();
 	ext2_filsys fs;
@@ -2456,11 +2426,9 @@ static int op_rename(const char *from, const char *to
 	int flushed = 0;
 	int ret = 0;
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	/* renameat2 is not supported */
 	if (flags)
 		return -ENOSYS;
-#endif
 
 	FUSE4FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
@@ -2774,7 +2742,6 @@ static int op_link(const char *src, const char *dest)
 	return ret;
 }
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 /* Obtain group ids of the process that sent us a command(?) */
 static int get_req_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
 {
@@ -2849,19 +2816,8 @@ static int in_file_group(struct fuse_context *ctxt,
 	ext2fs_free_mem(&gids);
 	return ret;
 }
-#else
-static int in_file_group(struct fuse_context *ctxt,
-			 const struct ext2_inode_large *inode)
-{
-	return ctxt->gid == inode_gid(*inode);
-}
-#endif
 
-static int op_chmod(const char *path, mode_t mode
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi
-#endif
-			)
+static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse4fs *ff = fuse4fs_get();
@@ -2928,11 +2884,8 @@ static int op_chmod(const char *path, mode_t mode
 	return ret;
 }
 
-static int op_chown(const char *path, uid_t owner, gid_t group
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi
-#endif
-			)
+static int op_chown(const char *path, uid_t owner, gid_t group,
+		    struct fuse_file_info *fi)
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse4fs *ff = fuse4fs_get();
@@ -3070,11 +3023,7 @@ static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
 	return 0;
 }
 
-static int op_truncate(const char *path, off_t len
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi
-#endif
-			)
+static int op_truncate(const char *path, off_t len, struct fuse_file_info *fi)
 {
 	struct fuse4fs *ff = fuse4fs_get();
 	ext2_ino_t ino;
@@ -3802,9 +3751,7 @@ struct readdir_iter {
 	fuse_fill_dir_t func;
 
 	struct fuse4fs *ff;
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	enum fuse_readdir_flags flags;
-#endif
 	unsigned int nr;
 	off_t startpos;
 	off_t dirpos;
@@ -3856,44 +3803,29 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 		return 0;
 
 	dbg_printf(i->ff, "READDIR%s ino=%d %u offset=0x%llx\n",
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			i->flags == FUSE_READDIR_PLUS ? "PLUS" : "",
-#else
-			"",
-#endif
 			dir,
 			i->nr++,
 			(unsigned long long)i->dirpos);
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	if (i->flags == FUSE_READDIR_PLUS) {
 		ret = stat_inode(i->fs, dirent->inode, &stat);
 		if (ret)
 			return DIRENT_ABORT;
 	}
-#endif
 
 	memcpy(namebuf, dirent->name, dirent->name_len & 0xFF);
 	namebuf[dirent->name_len & 0xFF] = 0;
-	ret = i->func(i->buf, namebuf, &stat, i->dirpos
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, 0
-#endif
-			);
+	ret = i->func(i->buf, namebuf, &stat, i->dirpos , 0);
 	if (ret)
 		return DIRENT_ABORT;
 
 	return 0;
 }
 
-static int op_readdir(const char *path EXT2FS_ATTR((unused)),
-		      void *buf, fuse_fill_dir_t fill_func,
-		      off_t offset,
-		      struct fuse_file_info *fp
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, enum fuse_readdir_flags flags
-#endif
-			)
+static int op_readdir(const char *path EXT2FS_ATTR((unused)), void *buf,
+		      fuse_fill_dir_t fill_func, off_t offset,
+		      struct fuse_file_info *fp, enum fuse_readdir_flags flags)
 {
 	struct fuse4fs *ff = fuse4fs_get();
 	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
@@ -3902,9 +3834,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		.ff = ff,
 		.dirpos = 0,
 		.startpos = offset,
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 		.flags = flags,
-#endif
 	};
 	int ret = 0;
 
@@ -4087,82 +4017,8 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	return ret;
 }
 
-#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 0)
-static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
-			off_t len, struct fuse_file_info *fp)
-{
-	struct fuse4fs *ff = fuse4fs_get();
-	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
-	ext2_filsys fs;
-	ext2_file_t efp;
-	errcode_t err;
-	int ret = 0;
-
-	FUSE4FS_CHECK_CONTEXT(ff);
-	FUSE4FS_CHECK_HANDLE(ff, fh);
-	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino,
-		   (intmax_t) len);
-	fs = fuse4fs_start(ff);
-	if (!fuse4fs_is_writeable(ff)) {
-		ret = -EROFS;
-		goto out;
-	}
-
-	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
-	if (err) {
-		ret = translate_error(fs, fh->ino, err);
-		goto out;
-	}
-
-	err = ext2fs_file_set_size2(efp, len);
-	if (err) {
-		ret = translate_error(fs, fh->ino, err);
-		goto out2;
-	}
-
-out2:
-	err = ext2fs_file_close(efp);
-	if (ret)
-		goto out;
-	if (err) {
-		ret = translate_error(fs, fh->ino, err);
-		goto out;
-	}
-
-	ret = update_mtime(fs, fh->ino, NULL);
-	if (ret)
-		goto out;
-
-out:
-	fuse4fs_finish(ff, ret);
-	return ret;
-}
-
-static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
-		       struct stat *statbuf,
-		       struct fuse_file_info *fp)
-{
-	struct fuse4fs *ff = fuse4fs_get();
-	ext2_filsys fs;
-	struct fuse4fs_file_handle *fh = fuse4fs_get_handle(fp);
-	int ret = 0;
-
-	FUSE4FS_CHECK_CONTEXT(ff);
-	FUSE4FS_CHECK_HANDLE(ff, fh);
-	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	fs = fuse4fs_start(ff);
-	ret = stat_inode(fs, fh->ino, statbuf);
-	fuse4fs_finish(ff, ret);
-
-	return ret;
-}
-#endif /* FUSE_VERSION < FUSE_MAKE_VERSION(3, 0) */
-
-static int op_utimens(const char *path, const struct timespec ctv[2]
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi
-#endif
-			)
+static int op_utimens(const char *path, const struct timespec ctv[2],
+		      struct fuse_file_info *fi)
 {
 	struct fuse4fs *ff = fuse4fs_get();
 	struct timespec tv[2];
@@ -4560,13 +4416,8 @@ static int ioctl_shutdown(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
 	return 0;
 }
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
 static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 		    unsigned int cmd,
-#else
-		    int cmd,
-#endif
 		    void *arg EXT2FS_ATTR((unused)),
 		    struct fuse_file_info *fp,
 		    unsigned int flags EXT2FS_ATTR((unused)), void *data)
@@ -4617,7 +4468,6 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 
 	return ret;
 }
-#endif /* FUSE 28 */
 
 static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 		   uint64_t *idx)
@@ -4648,8 +4498,7 @@ static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 	return ret;
 }
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)
-# ifdef SUPPORT_FALLOCATE
+#ifdef SUPPORT_FALLOCATE
 static int fuse4fs_allocate_range(struct fuse4fs *ff,
 				  struct fuse4fs_file_handle *fh, int mode,
 				  off_t offset, off_t len)
@@ -4925,8 +4774,7 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 
 	return ret;
 }
-# endif /* SUPPORT_FALLOCATE */
-#endif /* FUSE 29 */
+#endif /* SUPPORT_FALLOCATE */
 
 static struct fuse_operations fs_ops = {
 	.init = op_init,
@@ -4959,34 +4807,15 @@ static struct fuse_operations fs_ops = {
 	.fsyncdir = op_fsync,
 	.access = op_access,
 	.create = op_create,
-#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 0)
-	.ftruncate = op_ftruncate,
-	.fgetattr = op_fgetattr,
-#endif
 	.utimens = op_utimens,
-#if (FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)) && (FUSE_VERSION < FUSE_MAKE_VERSION(3, 0))
-# if defined(UTIME_NOW) || defined(UTIME_OMIT)
-	.flag_utime_omit_ok = 1,
-# endif
-#endif
 	.bmap = op_bmap,
 #ifdef SUPERFLUOUS
 	.lock = op_lock,
 	.poll = op_poll,
 #endif
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
 	.ioctl = op_ioctl,
-#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 0)
-	.flag_nullpath_ok = 1,
-#endif
-#endif
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)
-#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 0)
-	.flag_nopath = 1,
-#endif
-# ifdef SUPPORT_FALLOCATE
+#ifdef SUPPORT_FALLOCATE
 	.fallocate = op_fallocate,
-# endif
 #endif
 };
 
@@ -5347,7 +5176,7 @@ int main(int argc, char *argv[])
 
 	/* Set up default fuse parameters */
 	snprintf(extra_args, BUFSIZ, "-okernel_cache,subtype=%s,"
-		 "fsname=%s,attr_timeout=0" FUSE_PLATFORM_OPTS,
+		 "fsname=%s,attr_timeout=0",
 		 get_subtype(argv[0]),
 		 fctx.device);
 	if (fctx.no_default_opts == 0)


