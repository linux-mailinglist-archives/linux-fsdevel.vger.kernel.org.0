Return-Path: <linux-fsdevel+bounces-49636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A25AC0120
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2391BC455F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A7420EB;
	Thu, 22 May 2025 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qE45JYzR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172A28FD;
	Thu, 22 May 2025 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872667; cv=none; b=A2XwWaX150+Y+aeAcwbZUSxnjsBh8cnnh3UVqBSZ0xfKT7uxgvb3hKJ1rcXdQstRp6WbZznb6sW3ruZaeBgu4uVXvtlhMBcplKy1e3wZbWKKq/VcOtwtNAZjPja2UG+76ctsJ7Mg3HOt+As8+LzAxqB3ahjlKqjpSR1OAk51Ghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872667; c=relaxed/simple;
	bh=fbix1Fh6oIGsDkQpagJl5cvejO7qmsDp/bE8xPH9dCY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3XitmUagAZ9A0Hm1glv1PFxib+cuWod22+AV78QiOqPggh82tcWJV4LZbJxaostfXrfyUmls04MuItF/FQgxBGou0mKGY9aM+eVmq04mFhOjvAiZklWdBF3CaA4QAxuF7r6dD9UFiNS2xOfhoZtOCZxVWnWhuD7MPUz4zDGjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qE45JYzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EB7C4CEE4;
	Thu, 22 May 2025 00:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872666;
	bh=fbix1Fh6oIGsDkQpagJl5cvejO7qmsDp/bE8xPH9dCY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qE45JYzREWrHdOCCTQt6uHKScdZxVk9pDzjhRkMf6THp7TgmtXYV3QQWO55Fa99c4
	 FK15mqkiaD5XRWwd0XoPGkugx3TGCDuKYuNh01RUNDkeG71pg9YW9WQgivFaw56Hl0
	 E/6CzIgeAmITDI1rKtfR7USZxdb+z4z5S9jqWAVARiEze24LtkPF8gAoQrnpyqwFQM
	 QPgGppiW04faatdU2CEENSO9ZMIegZhIrf+428BbsDFFqZj7R6LXCMLEC24iLx1R5Z
	 nv8IJ0IffUM2g1waaiePDUaPz2BM8XwTJKfl+jkPv2puErhHWQUrtTBPEOvZU0+YXO
	 YHNXOSNxVBKAQ==
Date: Wed, 21 May 2025 17:11:06 -0700
Subject: [PATCH 01/16] fuse2fs: implement bare minimum iomap for file mapping
 reporting
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198450.1484996.9790899706535168778.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
References: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add enough of an iomap implementation that we can do FIEMAP and
SEEK_DATA and SEEK_HOLE.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 configure       |   47 ++++++
 configure.ac    |   32 ++++
 lib/config.h.in |    3 
 misc/fuse2fs.c  |  453 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 530 insertions(+), 5 deletions(-)


diff --git a/configure b/configure
index 1f7dbe24ee1ab1..c8b63dd448dca8 100755
--- a/configure
+++ b/configure
@@ -14545,6 +14545,53 @@ elif test -n "$FUSE_LIB"
 then
 	FUSE_USE_VERSION=29
 fi
+
+if test "$FUSE_LIB" = "-lfuse3"
+then
+{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for iomap_begin in libfuse" >&5
+printf %s "checking for iomap_begin in libfuse... " >&6; }
+cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+#define _GNU_SOURCE
+#define _FILE_OFFSET_BITS	64
+#define FUSE_USE_VERSION 318
+#include <fuse.h>
+
+int
+main (void)
+{
+
+struct fuse_operations fs_ops = {
+	.iomap_begin = NULL,
+	.iomap_end = NULL,
+};
+struct fuse_iomap narf = { };
+
+  ;
+  return 0;
+}
+
+_ACEOF
+if ac_fn_c_try_link "$LINENO"
+then :
+  have_fuse_iomap=yes
+   { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+printf "%s\n" "yes" >&6; }
+else $as_nop
+  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.beam \
+    conftest$ac_exeext conftest.$ac_ext
+if test "$have_fuse_iomap" = yes; then
+  FUSE_USE_VERSION=318
+
+printf "%s\n" "#define HAVE_FUSE_IOMAP 1" >>confdefs.h
+
+fi
+fi
+
 if test -n "$FUSE_USE_VERSION"
 then
 
diff --git a/configure.ac b/configure.ac
index c7f193b4ed06bf..8b12ef3ee542e3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1429,6 +1429,38 @@ elif test -n "$FUSE_LIB"
 then
 	FUSE_USE_VERSION=29
 fi
+
+if test "$FUSE_LIB" = "-lfuse3"
+then
+dnl
+dnl see if fuse3 supports iomap
+dnl
+AC_MSG_CHECKING(for iomap_begin in libfuse)
+AC_LINK_IFELSE(
+[	AC_LANG_PROGRAM([[
+#define _GNU_SOURCE
+#define _FILE_OFFSET_BITS	64
+#define FUSE_USE_VERSION 318
+#include <fuse.h>
+	]], [[
+struct fuse_operations fs_ops = {
+	.iomap_begin = NULL,
+	.iomap_end = NULL,
+};
+struct fuse_iomap narf = { };
+	]])
+], have_fuse_iomap=yes
+   AC_MSG_RESULT(yes),
+   AC_MSG_RESULT(no))
+if test "$have_fuse_iomap" = yes; then
+  FUSE_USE_VERSION=318
+  AC_DEFINE(HAVE_FUSE_IOMAP, 1, [Define to 1 if fuse supports iomap])
+fi
+fi
+
+dnl
+dnl set FUSE_USE_VERSION now that we've done all the feature tests
+dnl
 if test -n "$FUSE_USE_VERSION"
 then
 	AC_DEFINE_UNQUOTED(FUSE_USE_VERSION, $FUSE_USE_VERSION,
diff --git a/lib/config.h.in b/lib/config.h.in
index 6cd9751baab9d1..850c5fa573bcf0 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -73,6 +73,9 @@
 /* Define to 1 if PR_SET_IO_FLUSHER is present */
 #undef HAVE_PR_SET_IO_FLUSHER
 
+/* Define to 1 if fuse supports iomap */
+#undef HAVE_FUSE_IOMAP
+
 /* Define to 1 if you have the Mac OS X function
    CFLocaleCopyPreferredLanguages in the CoreFoundation framework. */
 #undef HAVE_CFLOCALECOPYPREFERREDLANGUAGES
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 769bb5babd2738..f9eed078d91152 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -79,6 +79,8 @@
 #define P_(singular, plural, n) ((n) == 1 ? (singular) : (plural))
 #endif
 
+#define min(x, y)	((x) < (y) ? (y) : (x))
+
 #define dbg_printf(fuse2fs, format, ...) \
 	while ((fuse2fs)->debug) { \
 		printf("FUSE2FS (%s): " format, (fuse2fs)->shortdev, ##__VA_ARGS__); \
@@ -144,6 +146,14 @@ struct fuse2fs_file_handle {
 	int open_flags;
 };
 
+#ifdef HAVE_FUSE_IOMAP
+enum fuse2fs_iomap_state {
+	IOMAP_DISABLED,
+	IOMAP_UNKNOWN,
+	IOMAP_ENABLED,
+};
+#endif
+
 /* Main program context */
 #define FUSE2FS_MAGIC		(0xEF53DEADUL)
 struct fuse2fs {
@@ -167,6 +177,9 @@ struct fuse2fs {
 	uint8_t writable;
 
 	int blocklog;
+#ifdef HAVE_FUSE_IOMAP
+	enum fuse2fs_iomap_state iomap_state;
+#endif
 	unsigned int blockmask;
 	int retcode;
 	unsigned long offset;
@@ -694,7 +707,7 @@ static errcode_t open_fs(struct fuse2fs *ff, int libext2_flags)
 {
 	char options[128];
 	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_RW |
-		    libext2_flags;
+		    EXT2_FLAG_WRITE_FULL_SUPER | libext2_flags;
 	errcode_t err;
 
 	snprintf(options, sizeof(options) - 1, "offset=%lu", ff->offset);
@@ -945,6 +958,38 @@ static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
 }
 #endif
 
+#ifdef HAVE_FUSE_IOMAP
+static errcode_t confirm_iomap(struct fuse_conn_info *conn, struct fuse2fs *ff)
+{
+	int is_bdev;
+	errcode_t err;
+
+	switch (ff->iomap_state) {
+	case IOMAP_UNKNOWN:
+		ff->iomap_state = IOMAP_DISABLED;
+		/* fallthrough */;
+	case IOMAP_DISABLED:
+		return 0;
+	case IOMAP_ENABLED:
+		break;
+	}
+
+	err = fs_on_bdev(ff, &is_bdev);
+	if (err)
+		return err;
+
+	/* iomap only works with block devices */
+	if (!is_bdev) {
+		fuse_unset_feature_flag(conn, FUSE_CAP_IOMAP);
+		ff->iomap_state = IOMAP_DISABLED;
+	}
+
+	return 0;
+}
+#else
+# define confirm_iomap(...)	(0)
+#endif
+
 static void *op_init(struct fuse_conn_info *conn
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, struct fuse_config *cfg EXT2FS_ATTR((unused))
@@ -972,6 +1017,12 @@ static void *op_init(struct fuse_conn_info *conn
 #ifdef FUSE_CAP_NO_EXPORT_SUPPORT
 	fuse_set_feature_flag(conn, FUSE_CAP_NO_EXPORT_SUPPORT);
 #endif
+#ifdef HAVE_FUSE_IOMAP
+	if (ff->iomap_state != IOMAP_DISABLED &&
+	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
+		ff->iomap_state = IOMAP_ENABLED;
+#endif
+
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
 	cfg->use_ino = 1;
@@ -989,6 +1040,10 @@ static void *op_init(struct fuse_conn_info *conn
 			goto mount_fail;
 		fs = ff->fs;
 
+		err = confirm_iomap(conn, ff);
+		if (err)
+			goto mount_fail;
+
 		if (ff->cache_size) {
 			err = config_fs_cache(ff);
 			if (err)
@@ -1014,6 +1069,10 @@ static void *op_init(struct fuse_conn_info *conn
 		err = mount_fs(ff);
 		if (err)
 			goto mount_fail;
+	} else {
+		err = confirm_iomap(conn, ff);
+		if (err)
+			goto mount_fail;
 	}
 
 	/* Clear the valid flag so that an unclean shutdown forces a fsck */
@@ -4575,6 +4634,384 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 # endif /* SUPPORT_FALLOCATE */
 #endif /* FUSE 29 */
 
+#ifdef HAVE_FUSE_IOMAP
+static void handle_iomap_hole(struct fuse2fs *ff, struct fuse_iomap *iomap,
+			      off_t pos, uint64_t count)
+{
+	iomap->dev = FUSE_IOMAP_DEV_FUSEBLK;
+	iomap->addr = FUSE_IOMAP_NULL_ADDR;
+	iomap->offset = pos;
+	iomap->length = count;
+	iomap->type = FUSE_IOMAP_TYPE_HOLE;
+}
+
+#define DEBUG_IOMAP
+#ifdef DEBUG_IOMAP
+# define __DUMP_EXTENT(ff, func, tag, startoff, err, extent) \
+	do { \
+		dbg_printf((ff), \
+ "%s: %s startoff 0x%llx err %ld lblk 0x%llx pblk 0x%llx len 0x%x flags 0x%x\n", \
+			   (func), (tag), (startoff), (err), (extent)->e_lblk, \
+			   (extent)->e_pblk, (extent)->e_len, \
+			   (extent)->e_flags & EXT2_EXTENT_FLAGS_UNINIT); \
+	} while(0)
+# define DUMP_EXTENT(ff, tag, startoff, err, extent) \
+	__DUMP_EXTENT((ff), __func__, (tag), (startoff), (err), (extent))
+#else
+# define __DUMP_EXTENT(...)	((void)0)
+# define DUMP_EXTENT(...)	((void)0)
+#endif
+
+static inline errcode_t __get_mapping_at(struct fuse2fs *ff,
+					 ext2_extent_handle_t handle,
+					 blk64_t startoff,
+					 struct ext2fs_extent *bmap,
+					 const char *func)
+{
+	errcode_t err;
+
+	/*
+	 * Find the file mapping at startoff.  We don't check the return value
+	 * of _goto because _get will error out if _goto failed.  There's a
+	 * subtlety to the outcome of _goto when startoff falls in a sparse
+	 * hole however:
+	 *
+	 * Most of the time, _goto points the cursor at the mapping whose lblk
+	 * is just to the left of startoff.  The mapping may or may not overlap
+	 * startoff; this is ok.  In other words, the tree lookup behaves as if
+	 * we asked it to use a less than or equals comparison.
+	 *
+	 * However, if startoff is to the left of the first mapping in the
+	 * extent tree, _goto points the cursor at that first mapping because
+	 * it doesn't know how to deal with this situation.  In this case,
+	 * the tree lookup behaves as if we asked it to use a greater than
+	 * or equals comparison.
+	 *
+	 * Note: If _get() returns 'no current node', that means that there
+	 * aren't any mappings at all.
+	 */
+	ext2fs_extent_goto(handle, startoff);
+	err = ext2fs_extent_get(handle, EXT2_EXTENT_CURRENT, bmap);
+	__DUMP_EXTENT(ff, func, "lookup", startoff, err, bmap);
+	if (err == EXT2_ET_NO_CURRENT_NODE)
+		err = EXT2_ET_EXTENT_NOT_FOUND;
+	return err;
+}
+
+static inline errcode_t __get_next_mapping(struct fuse2fs *ff,
+					   ext2_extent_handle_t handle,
+					   blk64_t startoff,
+					   struct ext2fs_extent *bmap,
+					   const char *func)
+{
+	struct ext2fs_extent newex, errex;
+	errcode_t err;
+
+	err = ext2fs_extent_get(handle, EXT2_EXTENT_NEXT_LEAF, &newex);
+	DUMP_EXTENT(ff, "NEXT", startoff, err, &newex);
+	if (err == EXT2_ET_EXTENT_NO_NEXT)
+		return EXT2_ET_EXTENT_NOT_FOUND;
+	if (err)
+		return err;
+
+	/*
+	 * Try to get the next leaf mapping.  There's a weird and longstanding
+	 * "feature" of EXT2_EXTENT_NEXT_LEAF where walking off the end of the
+	 * mapping recordset causes it to wrap around to the beginning of the
+	 * extent map and we end up with a mapping to the left of the one that
+	 * was passed in.
+	 *
+	 * However, a corrupt extent tree could also have such a record.  The
+	 * only way to be sure is to retrieve the mapping for the extreme right
+	 * edge of the tree and compare it to the mapping that the caller gave
+	 * us.  If they match, then we've hit the end.  If not, something is
+	 * corrupt in the ondisk metadata.
+	 */
+	if (newex.e_lblk <= bmap->e_lblk + bmap->e_len) {
+		err = __get_mapping_at(ff, handle, ~0U, &errex, func);
+		if (err)
+			return err;
+
+		if (memcmp(bmap, &errex, sizeof(errex)) != 0)
+			return EXT2_ET_INODE_CORRUPTED;
+
+		return EXT2_ET_EXTENT_NOT_FOUND;
+	}
+
+	*bmap = newex;
+	return 0;
+}
+
+#define get_mapping_at(ff, handle, startoff, bmap) \
+	__get_mapping_at((ff), (handle), (startoff), (bmap), __func__)
+#define get_next_mapping(ff, handle, startoff, bmap) \
+	__get_next_mapping((ff), (handle), (startoff), (bmap), __func__)
+
+static errcode_t extent_iomap_begin(struct fuse2fs *ff, uint64_t ino,
+				    struct ext2_inode_large *inode,
+				    off_t pos, uint64_t count,
+				    uint32_t opflags, struct fuse_iomap *iomap)
+{
+	ext2_extent_handle_t handle;
+	struct ext2fs_extent extent;
+	ext2_filsys fs = ff->fs;
+	const blk64_t startoff = FUSE2FS_B_TO_FSBT(ff, pos);
+	errcode_t err;
+	int ret = 0;
+
+	err = ext2fs_extent_open2(fs, ino, EXT2_INODE(inode), &handle);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = get_mapping_at(ff, handle, startoff, &extent);
+	if (err == EXT2_ET_EXTENT_NOT_FOUND) {
+		/* No mappings at all; the whole range is a hole. */
+		handle_iomap_hole(ff, iomap, pos, count);
+		goto out_handle;
+	}
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_handle;
+	}
+
+	if (startoff < extent.e_lblk) {
+		/*
+		 * Mapping starts to the right of the current position.
+		 * Synthesize a hole going to that next extent.
+		 */
+		handle_iomap_hole(ff, iomap, FUSE2FS_FSB_TO_B(ff, startoff),
+				FUSE2FS_FSB_TO_B(ff, extent.e_lblk - startoff));
+		goto out_handle;
+	}
+
+	if (startoff >= extent.e_lblk + extent.e_len) {
+		/*
+		 * Mapping ends to the left of the current position.  Try to
+		 * find the next mapping.  If there is no next mapping, the
+		 * whole range is in a hole.
+		 */
+		err = get_next_mapping(ff, handle, startoff, &extent);
+		if (err == EXT2_ET_EXTENT_NOT_FOUND) {
+			handle_iomap_hole(ff, iomap, pos, count);
+			goto out_handle;
+		}
+
+		/*
+		 * If the new mapping starts to the right of startoff, there's
+		 * a hole from startoff to the start of the new mapping.
+		 */
+		if (startoff < extent.e_lblk) {
+			handle_iomap_hole(ff, iomap,
+				FUSE2FS_FSB_TO_B(ff, startoff),
+				FUSE2FS_FSB_TO_B(ff, extent.e_lblk - startoff));
+			goto out_handle;
+		}
+
+		/*
+		 * The new mapping starts at startoff.  Something weird
+		 * happened in the extent tree lookup, but we found a valid
+		 * mapping so we'll run with it.
+		 */
+	}
+
+	/* Mapping overlaps startoff, report this. */
+	iomap->dev = FUSE_IOMAP_DEV_FUSEBLK;
+	iomap->addr = FUSE2FS_FSB_TO_B(ff, extent.e_pblk);
+	iomap->offset = FUSE2FS_FSB_TO_B(ff, extent.e_lblk);
+	iomap->length = FUSE2FS_FSB_TO_B(ff, extent.e_len);
+	if (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT)
+		iomap->type = FUSE_IOMAP_TYPE_UNWRITTEN;
+	else
+		iomap->type = FUSE_IOMAP_TYPE_MAPPED;
+
+out_handle:
+	ext2fs_extent_free(handle);
+	return ret;
+}
+
+static int indirect_iomap_begin(struct fuse2fs *ff, uint64_t ino,
+				struct ext2_inode_large *inode, off_t pos,
+				uint64_t count, uint32_t opflags,
+				struct fuse_iomap *iomap)
+{
+	ext2_filsys fs = ff->fs;
+	blk64_t startoff = FUSE2FS_B_TO_FSBT(ff, pos);
+	uint64_t real_count = min(count, 131072);
+	const blk64_t endoff = FUSE2FS_B_TO_FSB(ff, pos + real_count);
+	blk64_t startblock;
+	errcode_t err;
+
+	err = ext2fs_bmap2(fs, ino, EXT2_INODE(inode), NULL, 0, startoff, NULL,
+			   &startblock);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	iomap->dev = FUSE_IOMAP_DEV_FUSEBLK;
+	iomap->offset = pos;
+	iomap->flags |= FUSE_IOMAP_F_MERGED;
+	if (startblock) {
+		iomap->addr = FUSE2FS_FSB_TO_B(ff, startblock);
+		iomap->type = FUSE_IOMAP_TYPE_MAPPED;
+	} else {
+		iomap->addr = FUSE_IOMAP_NULL_ADDR;
+		iomap->type = FUSE_IOMAP_TYPE_HOLE;
+	}
+	iomap->length = fs->blocksize;
+
+	/* See how long the mapping goes for. */
+	for (startoff++; startoff < endoff; startoff++) {
+		blk64_t prev_startblock = startblock;
+
+		err = ext2fs_bmap2(fs, ino, EXT2_INODE(inode), NULL, 0,
+				   startoff, NULL, &startblock);
+		if (err)
+			break;
+
+		if (iomap->type == FUSE_IOMAP_TYPE_MAPPED) {
+			if (startblock == prev_startblock + 1)
+				iomap->length += fs->blocksize;
+			else
+				break;
+		} else {
+			if (startblock != 0)
+				break;
+		}
+	}
+
+	return 0;
+}
+
+static int inline_iomap_begin(struct fuse2fs *ff, off_t pos, uint64_t count,
+			      struct fuse_iomap *iomap)
+{
+	iomap->dev = FUSE_IOMAP_DEV_FUSEBLK;
+	iomap->addr = FUSE_IOMAP_NULL_ADDR;
+	iomap->offset = pos;
+	iomap->length = count;
+	iomap->type = FUSE_IOMAP_TYPE_INLINE;
+
+	return 0;
+}
+
+static int fuse_iomap_begin_report(struct fuse2fs *ff, ext2_ino_t ino,
+				   struct ext2_inode_large *inode,
+				   off_t pos, uint64_t count, uint32_t opflags,
+				   struct fuse_iomap *read_iomap)
+{
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return inline_iomap_begin(ff, pos, count, read_iomap);
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return extent_iomap_begin(ff, ino, inode, pos, count, opflags,
+					 read_iomap);
+
+	return indirect_iomap_begin(ff, ino, inode, pos, count, opflags,
+				    read_iomap);
+}
+
+static int fuse_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
+				 struct ext2_inode_large *inode, off_t pos,
+				 uint64_t count, uint32_t opflags,
+				 struct fuse_iomap *read_iomap)
+{
+	return -ENOSYS;
+}
+
+static int fuse_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
+				  struct ext2_inode_large *inode, off_t pos,
+				  uint64_t count, uint32_t opflags,
+				  struct fuse_iomap *read_iomap)
+{
+	return -ENOSYS;
+}
+
+static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
+			  off_t pos, uint64_t count, uint32_t opflags,
+			  struct fuse_iomap *read_iomap,
+			  struct fuse_iomap *write_iomap)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct ext2_inode_large inode;
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	fs = ff->fs;
+
+	pthread_mutex_lock(&ff->bfl);
+
+	dbg_printf(ff,
+ "%s: path=%s nodeid=%llu attr_ino=%llu pos=0x%llx count=0x%llx opflags=0x%x\n",
+		   __func__, path,
+		   (unsigned long long)nodeid,
+		   (unsigned long long)attr_ino,
+		   (unsigned long long)pos,
+		   (unsigned long long)count,
+		   opflags);
+
+	err = fuse2fs_read_inode(fs, attr_ino, &inode);
+	if (err) {
+		ret = translate_error(fs, attr_ino, err);
+		goto out_unlock;
+	}
+
+	if (opflags & FUSE_IOMAP_OP_REPORT)
+		ret = fuse_iomap_begin_report(ff, attr_ino, &inode, pos, count,
+					      opflags, read_iomap);
+	else if (opflags & (FUSE_IOMAP_OP_WRITE | FUSE_IOMAP_OP_ZERO))
+		ret = fuse_iomap_begin_write(ff, attr_ino, &inode, pos, count,
+					     opflags, read_iomap);
+	else
+		ret = fuse_iomap_begin_read(ff, attr_ino, &inode, pos, count,
+					    opflags, read_iomap);
+	if (ret)
+		goto out_unlock;
+
+	dbg_printf(ff, "%s: nodeid=%llu attr_ino=%llu pos=0x%llx -> addr=0x%llx offset=0x%llx length=0x%llx type=%u\n",
+		   __func__,
+		   (unsigned long long)nodeid,
+		   (unsigned long long)attr_ino,
+		   (unsigned long long)pos,
+		   (unsigned long long)read_iomap->addr,
+		   (unsigned long long)read_iomap->offset,
+		   (unsigned long long)read_iomap->length,
+		   read_iomap->type);
+
+out_unlock:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
+	pthread_mutex_unlock(&ff->bfl);
+	return ret;
+}
+
+static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
+			off_t pos, uint64_t count, uint32_t opflags,
+			ssize_t written, const struct fuse_iomap *iomap)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+
+	pthread_mutex_lock(&ff->bfl);
+	dbg_printf(ff,
+ "%s: path=%s nodeid=%llu attr_ino=%llu pos=0x%llx count=0x%llx opflags=0x%x written=0x%zx mapflags 0x%x\n",
+		   __func__, path,
+		   (unsigned long long)nodeid,
+		   (unsigned long long)attr_ino,
+		   (unsigned long long)pos,
+		   (unsigned long long)count,
+		   opflags,
+		   written,
+		   iomap->flags);
+	pthread_mutex_unlock(&ff->bfl);
+
+	return 0;
+}
+#endif /* HAVE_FUSE_IOMAP */
+
 static struct fuse_operations fs_ops = {
 	.init = op_init,
 	.destroy = op_destroy,
@@ -4635,6 +5072,10 @@ static struct fuse_operations fs_ops = {
 	.fallocate = op_fallocate,
 # endif
 #endif
+#ifdef HAVE_FUSE_IOMAP
+	.iomap_begin = op_iomap_begin,
+	.iomap_end = op_iomap_end,
+#endif /* HAVE_FUSE_IOMAP */
 };
 
 static int get_random_bytes(void *p, size_t sz)
@@ -4840,7 +5281,12 @@ static void fuse2fs_com_err_proc(const char *whoami, errcode_t code,
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
-	struct fuse2fs fctx;
+	struct fuse2fs fctx = {
+		.magic = FUSE2FS_MAGIC,
+#ifdef HAVE_FUSE_IOMAP
+		.iomap_state = IOMAP_UNKNOWN,
+#endif
+	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
 	char *logfile;
@@ -4849,9 +5295,6 @@ int main(int argc, char *argv[])
 	int is_bdev;
 	int ret = 0;
 
-	memset(&fctx, 0, sizeof(fctx));
-	fctx.magic = FUSE2FS_MAGIC;
-
 	fuse_opt_parse(&args, &fctx, fuse2fs_opts, fuse2fs_opt_proc);
 	if (fctx.device == NULL) {
 		fprintf(stderr, "Missing ext4 device/image\n");


