Return-Path: <linux-fsdevel+bounces-66093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C32C17C53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEF01897C3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD282D8DDD;
	Wed, 29 Oct 2025 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1XCb3Xh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A41F461A;
	Wed, 29 Oct 2025 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700122; cv=none; b=iOXtBCcW2eI4pzn6ggqA/eIysvfJiIzQeDhuBr29YO3tD469MU4LYamKl217+/O20ZezmPNznWLIBl0j10DD9y13pyufFjUGdKfcOykeodDACbbYVUvjpHqc3Nr/iFbGcSgpy+9nWnwLvA0rOtqDO7b9WiS4j2uVAA5Cgul1UCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700122; c=relaxed/simple;
	bh=43Xo2FKv37PuPpZI/OHAqPmvljqQhOVKAOsYYsqctLo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ljml4cKeC4gfsKgJX8ij65zG+bI/utF5QyvQdVCOe1IS54he1+Rkm28EGnA98ebvZ8f4w1DgLEKelV4G4r75qahSD2cGlAM/7GHl5xjEvpFj8eLdFZEakgLateAZkUvy8+lIaQ9iYWF4rTG+vcbB6FoHlc6OGlZPtPyHztuFZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1XCb3Xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4301C4CEE7;
	Wed, 29 Oct 2025 01:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700121;
	bh=43Xo2FKv37PuPpZI/OHAqPmvljqQhOVKAOsYYsqctLo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C1XCb3Xhu/cFebJH+CGrcQOMGMXDZ/0A6kMfr0lXptULuKQKWy4IVuLOd1F5D0rY0
	 9D65jIlAfOWNbcSEhmdVu8m+lIS3g2CCLkjeI1RLKT2l54jpGkssXUov8EfpkcOhI2
	 ui1Yau+NzYdyJ/1v9OIsfc8pJIGT96CL8qYm5RpUQ8vFxeymH4Gu0AyMpxv6pz+nx8
	 X+cHUz9RldtPX9z6Y3ou0JCWWn3kckvGqYpMhF3Qy0e09fBciyBArBOkR9T4ySt5wK
	 4SVQeQzPUeIVq6tSz6s4UmCwtz1YTU8Y3VAf1U2yzAXvEud2WSdyJ0b1Iyz0ThOht5
	 VeryuWgTZpUIQ==
Date: Tue, 28 Oct 2025 18:08:41 -0700
Subject: [PATCH 01/17] fuse2fs: implement bare minimum iomap for file mapping
 reporting
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817578.1429568.4823802886150306803.stgit@frogsfrogsfrogs>
In-Reply-To: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
References: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
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
 configure         |   48 +++++
 configure.ac      |   31 +++
 fuse4fs/fuse4fs.c |  521 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/config.h.in   |    3 
 misc/fuse2fs.c    |  521 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1122 insertions(+), 2 deletions(-)


diff --git a/configure b/configure
index 7f5fb7c1a62084..4137f942efaef5 100755
--- a/configure
+++ b/configure
@@ -14212,6 +14212,7 @@ printf "%s\n" "yes" >&6; }
 fi
 
 
+have_fuse_iomap=
 if test -n "$FUSE_LIB"
 then
 	FUSE_USE_VERSION=314
@@ -14237,12 +14238,59 @@ See \`config.log' for more details" "$LINENO" 5; }
 fi
 
 done
+
+					{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for iomap_begin in libfuse" >&5
+printf %s "checking for iomap_begin in libfuse... " >&6; }
+	cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+	#define _GNU_SOURCE
+	#define _FILE_OFFSET_BITS	64
+	#define FUSE_USE_VERSION	399
+	#include <fuse.h>
+
+int
+main (void)
+{
+
+	struct fuse_operations fs_ops = {
+		.iomap_begin = NULL,
+		.iomap_end = NULL,
+	};
+	struct fuse_file_iomap narf = { };
+
+  ;
+  return 0;
+}
+
+_ACEOF
+if ac_fn_c_try_link "$LINENO"
+then :
+  have_fuse_iomap=yes
+	   { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+printf "%s\n" "yes" >&6; }
+else $as_nop
+  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.beam \
+    conftest$ac_exeext conftest.$ac_ext
+	if test "$have_fuse_iomap" = yes
+	then
+		FUSE_USE_VERSION=399
+	fi
 fi
 if test -n "$FUSE_USE_VERSION"
 then
 
 printf "%s\n" "#define FUSE_USE_VERSION $FUSE_USE_VERSION" >>confdefs.h
 
+fi
+if test -n "$have_fuse_iomap"
+then
+
+printf "%s\n" "#define HAVE_FUSE_IOMAP 1" >>confdefs.h
+
 fi
 
 have_fuse_lowlevel=
diff --git a/configure.ac b/configure.ac
index 2eb11873ea0e50..a1057c07b8c056 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1382,6 +1382,7 @@ dnl
 dnl Set FUSE_USE_VERSION, which is how fuse servers build against a particular
 dnl libfuse ABI.  Currently we link against the libfuse 3.14 ABI (hence 314)
 dnl
+have_fuse_iomap=
 if test -n "$FUSE_LIB"
 then
 	FUSE_USE_VERSION=314
@@ -1391,12 +1392,42 @@ then
 		[AC_MSG_FAILURE([Cannot build against fuse3 headers])],
 [#define _FILE_OFFSET_BITS	64
 #define FUSE_USE_VERSION	314])
+
+	dnl
+	dnl Check if the fuse library supports iomap, which requires a higher
+	dnl FUSE_USE_VERSION ABI version (3.99)
+	dnl
+	AC_MSG_CHECKING(for iomap_begin in libfuse)
+	AC_LINK_IFELSE(
+	[	AC_LANG_PROGRAM([[
+	#define _GNU_SOURCE
+	#define _FILE_OFFSET_BITS	64
+	#define FUSE_USE_VERSION	399
+	#include <fuse.h>
+		]], [[
+	struct fuse_operations fs_ops = {
+		.iomap_begin = NULL,
+		.iomap_end = NULL,
+	};
+	struct fuse_file_iomap narf = { };
+		]])
+	], have_fuse_iomap=yes
+	   AC_MSG_RESULT(yes),
+	   AC_MSG_RESULT(no))
+	if test "$have_fuse_iomap" = yes
+	then
+		FUSE_USE_VERSION=399
+	fi
 fi
 if test -n "$FUSE_USE_VERSION"
 then
 	AC_DEFINE_UNQUOTED(FUSE_USE_VERSION, $FUSE_USE_VERSION,
 		[Define to the version of FUSE to use])
 fi
+if test -n "$have_fuse_iomap"
+then
+	AC_DEFINE(HAVE_FUSE_IOMAP, 1, [Define to 1 if fuse supports iomap])
+fi
 
 dnl
 dnl Check if the FUSE lowlevel library is supported
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 609e23bd916cc0..9b07efae79c7da 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -143,6 +143,9 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 	return b - m;
 }
 
+#define max(a, b)	((a) > (b) ? (a) : (b))
+#define min(a, b)	((a) < (b) ? (a) : (b))
+
 #define dbg_printf(fuse4fs, format, ...) \
 	while ((fuse4fs)->debug) { \
 		printf("FUSE4FS (%s): tid=%d " format, (fuse4fs)->shortdev, gettid(), ##__VA_ARGS__); \
@@ -221,6 +224,14 @@ enum fuse4fs_opstate {
 	F4OP_SHUTDOWN,
 };
 
+#ifdef HAVE_FUSE_IOMAP
+enum fuse4fs_iomap_state {
+	IOMAP_DISABLED,
+	IOMAP_UNKNOWN,
+	IOMAP_ENABLED,
+};
+#endif
+
 /* Main program context */
 #define FUSE4FS_MAGIC		(0xEF53DEADUL)
 struct fuse4fs {
@@ -248,6 +259,9 @@ struct fuse4fs {
 	int logfd;
 	int blocklog;
 	int oom_score_adj;
+#ifdef HAVE_FUSE_IOMAP
+	enum fuse4fs_iomap_state iomap_state;
+#endif
 	unsigned int blockmask;
 	unsigned long offset;
 	unsigned int next_generation;
@@ -854,6 +868,15 @@ fuse4fs_set_handle(struct fuse_file_info *fp, struct fuse4fs_file_handle *fh)
 	fp->keep_cache = 1;
 }
 
+#ifdef HAVE_FUSE_IOMAP
+static inline int fuse4fs_iomap_enabled(const struct fuse4fs *ff)
+{
+	return ff->iomap_state >= IOMAP_ENABLED;
+}
+#else
+# define fuse4fs_iomap_enabled(...)	(0)
+#endif
+
 static void get_now(struct timespec *now)
 {
 #ifdef CLOCK_REALTIME
@@ -1309,7 +1332,7 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 	char options[128];
 	double deadline;
 	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_RW |
-		    EXT2_FLAG_EXCLUSIVE;
+		    EXT2_FLAG_EXCLUSIVE | EXT2_FLAG_WRITE_FULL_SUPER;
 	errcode_t err;
 
 	if (ff->lockfile) {
@@ -1478,6 +1501,11 @@ static errcode_t fuse4fs_config_cache(struct fuse4fs *ff)
 	return 0;
 }
 
+static inline bool fuse4fs_on_bdev(const struct fuse4fs *ff)
+{
+	return ff->fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE;
+}
+
 static int fuse4fs_mount(struct fuse4fs *ff)
 {
 	struct ext2_inode_large inode;
@@ -1600,6 +1628,15 @@ static void op_destroy(void *userdata)
 				(stats->cache_hits + stats->cache_misses));
 	}
 
+	/*
+	 * If we're mounting in iomap mode, we need to unmount in op_destroy so
+	 * that the block device will be released before umount(2) returns.
+	 */
+	if (ff->iomap_state == IOMAP_ENABLED) {
+		fuse4fs_mmp_cancel(ff);
+		fuse4fs_unmount(ff);
+	}
+
 	fuse4fs_finish(ff, 0);
 }
 
@@ -1736,6 +1773,26 @@ static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
 }
 #endif
 
+#ifdef HAVE_FUSE_IOMAP
+static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
+				 struct fuse4fs *ff)
+{
+	/* Don't let anyone touch iomap until the end of the patchset. */
+	ff->iomap_state = IOMAP_DISABLED;
+	return;
+
+	/* iomap only works with block devices */
+	if (ff->iomap_state != IOMAP_DISABLED && fuse4fs_on_bdev(ff) &&
+	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
+		ff->iomap_state = IOMAP_ENABLED;
+
+	if (ff->iomap_state == IOMAP_UNKNOWN)
+		ff->iomap_state = IOMAP_DISABLED;
+}
+#else
+# define fuse4fs_iomap_enable(...)	((void)0)
+#endif
+
 static void op_init(void *userdata, struct fuse_conn_info *conn)
 {
 	struct fuse4fs *ff = userdata;
@@ -1758,6 +1815,7 @@ static void op_init(void *userdata, struct fuse_conn_info *conn)
 #ifdef FUSE_CAP_NO_EXPORT_SUPPORT
 	fuse_set_feature_flag(conn, FUSE_CAP_NO_EXPORT_SUPPORT);
 #endif
+	fuse4fs_iomap_enable(conn, ff);
 	conn->time_gran = 1;
 
 	if (ff->opstate == F4OP_WRITABLE)
@@ -5698,6 +5756,460 @@ static void op_fallocate(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 }
 #endif /* SUPPORT_FALLOCATE */
 
+#ifdef HAVE_FUSE_IOMAP
+static void fuse4fs_iomap_hole(struct fuse4fs *ff, struct fuse_file_iomap *iomap,
+			       off_t pos, uint64_t count)
+{
+	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->addr = FUSE_IOMAP_NULL_ADDR;
+	iomap->offset = pos;
+	iomap->length = count;
+	iomap->type = FUSE_IOMAP_TYPE_HOLE;
+}
+
+static void fuse4fs_iomap_hole_to_eof(struct fuse4fs *ff,
+				      struct fuse_file_iomap *iomap, off_t pos,
+				      off_t count,
+				      const struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+	uint64_t isize = EXT2_I_SIZE(inode);
+
+	/*
+	 * We have to be careful about handling a hole to the right of the
+	 * entire mapping tree.  First, the mapping must start and end on a
+	 * block boundary because they must be aligned to at least an LBA for
+	 * the block layer; and to the fsblock for smoother operation.
+	 *
+	 * As for the length -- we could return a mapping all the way to
+	 * i_size, but i_size could be less than pos/count if we're zeroing the
+	 * EOF block in anticipation of a truncate operation.  Similarly, we
+	 * don't want to end the mapping at pos+count because we know there's
+	 * nothing mapped byeond here.
+	 */
+	uint64_t startoff = round_down(pos, fs->blocksize);
+	uint64_t eofoff = round_up(max(pos + count, isize), fs->blocksize);
+
+	dbg_printf(ff,
+ "pos=0x%llx count=0x%llx isize=0x%llx startoff=0x%llx eofoff=0x%llx\n",
+		   (unsigned long long)pos,
+		   (unsigned long long)count,
+		   (unsigned long long)isize,
+		   (unsigned long long)startoff,
+		   (unsigned long long)eofoff);
+
+	fuse4fs_iomap_hole(ff, iomap, startoff, eofoff - startoff);
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
+
+# define __DUMP_INFO(ff, func, tag, startoff, err, info) \
+	do { \
+		dbg_printf((ff), \
+ "%s: %s startoff 0x%llx err %ld entry %d/%d/%d level  %d/%d\n", \
+			   (func), (tag), (startoff), (err), \
+			   (info)->curr_entry, (info)->num_entries, \
+			   (info)->max_entries, (info)->curr_level, \
+			   (info)->max_depth); \
+	} while(0)
+# define DUMP_INFO(ff, tag, startoff, err, info) \
+	__DUMP_INFO((ff), __func__, (tag), (startoff), (err), (info))
+#else
+# define __DUMP_EXTENT(...)	((void)0)
+# define DUMP_EXTENT(...)	((void)0)
+# define DUMP_INFO(...)		((void)0)
+#endif
+
+static inline errcode_t __fuse4fs_get_mapping_at(struct fuse4fs *ff,
+						 ext2_extent_handle_t handle,
+						 blk64_t startoff,
+						 struct ext2fs_extent *bmap,
+						 const char *func)
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
+static inline errcode_t __fuse4fs_get_next_mapping(struct fuse4fs *ff,
+						   ext2_extent_handle_t handle,
+						   blk64_t startoff,
+						   struct ext2fs_extent *bmap,
+						   const char *func)
+{
+	struct ext2fs_extent newex;
+	struct ext2_extent_info info;
+	errcode_t err;
+
+	/*
+	 * The extent tree code has this (probably broken) behavior that if
+	 * more than two of the highest levels of the cursor point at the
+	 * rightmost edge of an extent tree block, a _NEXT_LEAF movement fails
+	 * to move the cursor position of any of the lower levels.  IOWs, if
+	 * leaf level N is at the right edge, it will only advance level N-1
+	 * to the right.  If N-1 was at the right edge, the cursor resets to
+	 * record 0 of that level and goes down to the wrong leaf.
+	 *
+	 * Work around this by walking up (towards root level 0) the extent
+	 * tree until we find a level where we're not already at the rightmost
+	 * edge.  The _NEXT_LEAF movement will walk down the tree to find the
+	 * leaves.
+	 */
+	err = ext2fs_extent_get_info(handle, &info);
+	DUMP_INFO(ff, "UP?", startoff, err, &info);
+	if (err)
+		return err;
+
+	while (info.curr_entry == info.num_entries && info.curr_level > 0) {
+		err = ext2fs_extent_get(handle, EXT2_EXTENT_UP, &newex);
+		DUMP_EXTENT(ff, "UP", startoff, err, &newex);
+		if (err)
+			return err;
+		err = ext2fs_extent_get_info(handle, &info);
+		DUMP_INFO(ff, "UP", startoff, err, &info);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * If we're at the root and there are no more entries, there's nothing
+	 * else to be found.
+	 */
+	if (info.curr_level == 0 && info.curr_entry == info.num_entries)
+		return EXT2_ET_EXTENT_NOT_FOUND;
+
+	/* Otherwise grab this next leaf and return it. */
+	err = ext2fs_extent_get(handle, EXT2_EXTENT_NEXT_LEAF, &newex);
+	DUMP_EXTENT(ff, "NEXT", startoff, err, &newex);
+	if (err)
+		return err;
+
+	*bmap = newex;
+	return 0;
+}
+
+#define fuse4fs_get_mapping_at(ff, handle, startoff, bmap) \
+	__fuse4fs_get_mapping_at((ff), (handle), (startoff), (bmap), __func__)
+#define fuse4fs_get_next_mapping(ff, handle, startoff, bmap) \
+	__fuse4fs_get_next_mapping((ff), (handle), (startoff), (bmap), __func__)
+
+static errcode_t fuse4fs_iomap_begin_extent(struct fuse4fs *ff, uint64_t ino,
+					    struct ext2_inode_large *inode,
+					    off_t pos, uint64_t count,
+					    uint32_t opflags,
+					    struct fuse_file_iomap *iomap)
+{
+	ext2_extent_handle_t handle;
+	struct ext2fs_extent extent = { };
+	ext2_filsys fs = ff->fs;
+	const blk64_t startoff = FUSE4FS_B_TO_FSBT(ff, pos);
+	errcode_t err;
+	int ret = 0;
+
+	err = ext2fs_extent_open2(fs, ino, EXT2_INODE(inode), &handle);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = fuse4fs_get_mapping_at(ff, handle, startoff, &extent);
+	if (err == EXT2_ET_EXTENT_NOT_FOUND) {
+		/* No mappings at all; the whole range is a hole. */
+		fuse4fs_iomap_hole_to_eof(ff, iomap, pos, count, inode);
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
+		fuse4fs_iomap_hole(ff, iomap, FUSE4FS_FSB_TO_B(ff, startoff),
+				FUSE4FS_FSB_TO_B(ff, extent.e_lblk - startoff));
+		goto out_handle;
+	}
+
+	if (startoff >= extent.e_lblk + extent.e_len) {
+		/*
+		 * Mapping ends to the left of the current position.  Try to
+		 * find the next mapping.  If there is no next mapping, the
+		 * whole range is in a hole.
+		 */
+		err = fuse4fs_get_next_mapping(ff, handle, startoff, &extent);
+		if (err == EXT2_ET_EXTENT_NOT_FOUND) {
+			fuse4fs_iomap_hole_to_eof(ff, iomap, pos, count, inode);
+			goto out_handle;
+		}
+
+		/*
+		 * If the new mapping starts to the right of startoff, there's
+		 * a hole from startoff to the start of the new mapping.
+		 */
+		if (startoff < extent.e_lblk) {
+			fuse4fs_iomap_hole(ff, iomap,
+				FUSE4FS_FSB_TO_B(ff, startoff),
+				FUSE4FS_FSB_TO_B(ff, extent.e_lblk - startoff));
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
+	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->addr = FUSE4FS_FSB_TO_B(ff, extent.e_pblk);
+	iomap->offset = FUSE4FS_FSB_TO_B(ff, extent.e_lblk);
+	iomap->length = FUSE4FS_FSB_TO_B(ff, extent.e_len);
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
+static int fuse4fs_iomap_begin_indirect(struct fuse4fs *ff, uint64_t ino,
+					struct ext2_inode_large *inode,
+					off_t pos, uint64_t count,
+					uint32_t opflags,
+					struct fuse_file_iomap *iomap)
+{
+	ext2_filsys fs = ff->fs;
+	blk64_t startoff = FUSE4FS_B_TO_FSBT(ff, pos);
+	uint64_t isize = EXT2_I_SIZE(inode);
+	uint64_t real_count = min(count, 131072);
+	const blk64_t endoff = FUSE4FS_B_TO_FSB(ff, pos + real_count);
+	blk64_t startblock;
+	errcode_t err;
+
+	err = ext2fs_bmap2(fs, ino, EXT2_INODE(inode), NULL, 0, startoff, NULL,
+			   &startblock);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->offset = FUSE4FS_FSB_TO_B(ff, startoff);
+	iomap->flags |= FUSE_IOMAP_F_MERGED;
+	if (startblock) {
+		iomap->addr = FUSE4FS_FSB_TO_B(ff, startblock);
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
+			if (startblock == 0)
+				iomap->length += fs->blocksize;
+			else
+				break;
+		}
+	}
+
+	/*
+	 * If this is a hole that goes beyond EOF, report this as a hole to the
+	 * end of the range queried so that FIEMAP doesn't go mad.
+	 */
+	if (iomap->type == FUSE_IOMAP_TYPE_HOLE &&
+	    iomap->offset + iomap->length >= isize)
+		fuse4fs_iomap_hole_to_eof(ff, iomap, pos, count, inode);
+
+	return 0;
+}
+
+static int fuse4fs_iomap_begin_inline(struct fuse4fs *ff, ext2_ino_t ino,
+				      struct ext2_inode_large *inode, off_t pos,
+				      uint64_t count, struct fuse_file_iomap *iomap)
+{
+	uint64_t one_fsb = FUSE4FS_FSB_TO_B(ff, 1);
+
+	if (pos >= one_fsb) {
+		fuse4fs_iomap_hole_to_eof(ff, iomap, pos, count, inode);
+	} else {
+		/* ext4 only supports inline data files up to 1 fsb */
+		iomap->dev = FUSE_IOMAP_DEV_NULL;
+		iomap->addr = FUSE_IOMAP_NULL_ADDR;
+		iomap->offset = 0;
+		iomap->length = one_fsb;
+		iomap->type = FUSE_IOMAP_TYPE_INLINE;
+	}
+
+	return 0;
+}
+
+static int fuse4fs_iomap_begin_report(struct fuse4fs *ff, ext2_ino_t ino,
+				      struct ext2_inode_large *inode,
+				      off_t pos, uint64_t count,
+				      uint32_t opflags,
+				      struct fuse_file_iomap *read)
+{
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return fuse4fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read);
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return fuse4fs_iomap_begin_extent(ff, ino, inode, pos, count,
+						  opflags, read);
+
+	return fuse4fs_iomap_begin_indirect(ff, ino, inode, pos, count,
+					    opflags, read);
+}
+
+static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode, off_t pos,
+				    uint64_t count, uint32_t opflags,
+				    struct fuse_file_iomap *read)
+{
+	return -ENOSYS;
+}
+
+static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,
+				     struct ext2_inode_large *inode, off_t pos,
+				     uint64_t count, uint32_t opflags,
+				     struct fuse_file_iomap *read)
+{
+	return -ENOSYS;
+}
+
+static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
+			   off_t pos, uint64_t count, uint32_t opflags)
+{
+	struct fuse4fs *ff = fuse4fs_get(req);
+	struct ext2_inode_large inode;
+	struct fuse_file_iomap read = { };
+	ext2_filsys fs;
+	ext2_ino_t ino;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+
+	dbg_printf(ff, "%s: ino=%d pos=0x%llx count=0x%llx opflags=0x%x\n",
+		   __func__, ino,
+		   (unsigned long long)pos,
+		   (unsigned long long)count,
+		   opflags);
+
+	fs = fuse4fs_start(ff);
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_unlock;
+	}
+
+	if (opflags & FUSE_IOMAP_OP_REPORT)
+		ret = fuse4fs_iomap_begin_report(ff, ino, &inode, pos, count,
+						 opflags, &read);
+	else if (fuse_iomap_is_write(opflags))
+		ret = fuse4fs_iomap_begin_write(ff, ino, &inode, pos, count,
+						opflags, &read);
+	else
+		ret = fuse4fs_iomap_begin_read(ff, ino, &inode, pos, count,
+					       opflags, &read);
+	if (ret)
+		goto out_unlock;
+
+	dbg_printf(ff,
+ "%s: ino=%d pos=0x%llx -> addr=0x%llx offset=0x%llx length=0x%llx type=%u flags=0x%x\n",
+		   __func__, ino,
+		   (unsigned long long)pos,
+		   (unsigned long long)read.addr,
+		   (unsigned long long)read.offset,
+		   (unsigned long long)read.length,
+		   read.type,
+		   read.flags);
+
+out_unlock:
+	fuse4fs_finish(ff, ret);
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_iomap_begin(req, &read, NULL);
+}
+
+static void op_iomap_end(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
+			 off_t pos, uint64_t count, uint32_t opflags,
+			 ssize_t written, const struct fuse_file_iomap *iomap)
+{
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_ino_t ino;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+
+	dbg_printf(ff,
+ "%s: ino=%d pos=0x%llx count=0x%llx opflags=0x%x written=0x%zx mapflags=0x%x\n",
+		   __func__, ino,
+		   (unsigned long long)pos,
+		   (unsigned long long)count,
+		   opflags,
+		   written,
+		   iomap->flags);
+
+	fuse_reply_err(req, 0);
+}
+#endif /* HAVE_FUSE_IOMAP */
+
 static struct fuse_lowlevel_ops fs_ops = {
 	.lookup = op_lookup,
 	.setattr = op_setattr,
@@ -5741,6 +6253,10 @@ static struct fuse_lowlevel_ops fs_ops = {
 #ifdef SUPPORT_FALLOCATE
 	.fallocate = op_fallocate,
 #endif
+#ifdef HAVE_FUSE_IOMAP
+	.iomap_begin = op_iomap_begin,
+	.iomap_end = op_iomap_end,
+#endif /* HAVE_FUSE_IOMAP */
 };
 
 static int get_random_bytes(void *p, size_t sz)
@@ -6118,6 +6634,9 @@ int main(int argc, char *argv[])
 		.bfl = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER,
 		.oom_score_adj = -500,
 		.opstate = F4OP_WRITABLE,
+#ifdef HAVE_FUSE_IOMAP
+		.iomap_state = IOMAP_UNKNOWN,
+#endif
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
diff --git a/lib/config.h.in b/lib/config.h.in
index c3379758c3c9bc..55e515020af422 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -76,6 +76,9 @@
 /* Define to 1 if fuse supports lowlevel API */
 #undef HAVE_FUSE_LOWLEVEL
 
+/* Define to 1 if fuse supports iomap */
+#undef HAVE_FUSE_IOMAP
+
 /* Define to 1 if you have the Mac OS X function
    CFLocaleCopyPreferredLanguages in the CoreFoundation framework. */
 #undef HAVE_CFLOCALECOPYPREFERREDLANGUAGES
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 45ade06765d6d2..2a61610571760b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -137,6 +137,9 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 	return b - m;
 }
 
+#define max(a, b)	((a) > (b) ? (a) : (b))
+#define min(a, b)	((a) < (b) ? (a) : (b))
+
 #define dbg_printf(fuse2fs, format, ...) \
 	while ((fuse2fs)->debug) { \
 		printf("FUSE2FS (%s): tid=%d " format, (fuse2fs)->shortdev, gettid(), ##__VA_ARGS__); \
@@ -214,6 +217,14 @@ enum fuse2fs_opstate {
 	F2OP_SHUTDOWN,
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
@@ -241,6 +252,9 @@ struct fuse2fs {
 	int logfd;
 	int blocklog;
 	int oom_score_adj;
+#ifdef HAVE_FUSE_IOMAP
+	enum fuse2fs_iomap_state iomap_state;
+#endif
 	unsigned int blockmask;
 	unsigned long offset;
 	unsigned int next_generation;
@@ -692,6 +706,15 @@ fuse2fs_set_handle(struct fuse_file_info *fp, struct fuse2fs_file_handle *fh)
 	fp->fh = (uintptr_t)fh;
 }
 
+#ifdef HAVE_FUSE_IOMAP
+static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
+{
+	return ff->iomap_state >= IOMAP_ENABLED;
+}
+#else
+# define fuse2fs_iomap_enabled(...)	(0)
+#endif
+
 static void get_now(struct timespec *now)
 {
 #ifdef CLOCK_REALTIME
@@ -1121,7 +1144,7 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 	char options[128];
 	double deadline;
 	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_RW |
-		    EXT2_FLAG_EXCLUSIVE;
+		    EXT2_FLAG_EXCLUSIVE | EXT2_FLAG_WRITE_FULL_SUPER;
 	errcode_t err;
 
 	if (ff->lockfile) {
@@ -1286,6 +1309,11 @@ static errcode_t fuse2fs_config_cache(struct fuse2fs *ff)
 	return 0;
 }
 
+static inline bool fuse2fs_on_bdev(const struct fuse2fs *ff)
+{
+	return ff->fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE;
+}
+
 static int fuse2fs_mount(struct fuse2fs *ff)
 {
 	struct ext2_inode_large inode;
@@ -1408,6 +1436,15 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 				(stats->cache_hits + stats->cache_misses));
 	}
 
+	/*
+	 * If we're mounting in iomap mode, we need to unmount in op_destroy so
+	 * that the block device will be released before umount(2) returns.
+	 */
+	if (ff->iomap_state == IOMAP_ENABLED) {
+		fuse2fs_mmp_cancel(ff);
+		fuse2fs_unmount(ff);
+	}
+
 	fuse2fs_finish(ff, 0);
 }
 
@@ -1544,6 +1581,26 @@ static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
 }
 #endif
 
+#ifdef HAVE_FUSE_IOMAP
+static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
+				 struct fuse2fs *ff)
+{
+	/* Don't let anyone touch iomap until the end of the patchset. */
+	ff->iomap_state = IOMAP_DISABLED;
+	return;
+
+	/* iomap only works with block devices */
+	if (ff->iomap_state != IOMAP_DISABLED && fuse2fs_on_bdev(ff) &&
+	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
+		ff->iomap_state = IOMAP_ENABLED;
+
+	if (ff->iomap_state == IOMAP_UNKNOWN)
+		ff->iomap_state = IOMAP_DISABLED;
+}
+#else
+# define fuse2fs_iomap_enable(...)	((void)0)
+#endif
+
 static void *op_init(struct fuse_conn_info *conn,
 		     struct fuse_config *cfg EXT2FS_ATTR((unused)))
 {
@@ -1577,6 +1634,8 @@ static void *op_init(struct fuse_conn_info *conn,
 #ifdef FUSE_CAP_NO_EXPORT_SUPPORT
 	fuse_set_feature_flag(conn, FUSE_CAP_NO_EXPORT_SUPPORT);
 #endif
+	fuse2fs_iomap_enable(conn, ff);
+
 	conn->time_gran = 1;
 	cfg->use_ino = 1;
 	if (ff->debug)
@@ -5142,6 +5201,459 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 }
 #endif /* SUPPORT_FALLOCATE */
 
+#ifdef HAVE_FUSE_IOMAP
+static void fuse2fs_iomap_hole(struct fuse2fs *ff, struct fuse_file_iomap *iomap,
+			       off_t pos, uint64_t count)
+{
+	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->addr = FUSE_IOMAP_NULL_ADDR;
+	iomap->offset = pos;
+	iomap->length = count;
+	iomap->type = FUSE_IOMAP_TYPE_HOLE;
+}
+
+static void fuse2fs_iomap_hole_to_eof(struct fuse2fs *ff,
+				      struct fuse_file_iomap *iomap, off_t pos,
+				      off_t count,
+				      const struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+	uint64_t isize = EXT2_I_SIZE(inode);
+
+	/*
+	 * We have to be careful about handling a hole to the right of the
+	 * entire mapping tree.  First, the mapping must start and end on a
+	 * block boundary because they must be aligned to at least an LBA for
+	 * the block layer; and to the fsblock for smoother operation.
+	 *
+	 * As for the length -- we could return a mapping all the way to
+	 * i_size, but i_size could be less than pos/count if we're zeroing the
+	 * EOF block in anticipation of a truncate operation.  Similarly, we
+	 * don't want to end the mapping at pos+count because we know there's
+	 * nothing mapped byeond here.
+	 */
+	uint64_t startoff = round_down(pos, fs->blocksize);
+	uint64_t eofoff = round_up(max(pos + count, isize), fs->blocksize);
+
+	dbg_printf(ff,
+ "pos=0x%llx count=0x%llx isize=0x%llx startoff=0x%llx eofoff=0x%llx\n",
+		   (unsigned long long)pos,
+		   (unsigned long long)count,
+		   (unsigned long long)isize,
+		   (unsigned long long)startoff,
+		   (unsigned long long)eofoff);
+
+	fuse2fs_iomap_hole(ff, iomap, startoff, eofoff - startoff);
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
+
+# define __DUMP_INFO(ff, func, tag, startoff, err, info) \
+	do { \
+		dbg_printf((ff), \
+ "%s: %s startoff 0x%llx err %ld entry %d/%d/%d level  %d/%d\n", \
+			   (func), (tag), (startoff), (err), \
+			   (info)->curr_entry, (info)->num_entries, \
+			   (info)->max_entries, (info)->curr_level, \
+			   (info)->max_depth); \
+	} while(0)
+# define DUMP_INFO(ff, tag, startoff, err, info) \
+	__DUMP_INFO((ff), __func__, (tag), (startoff), (err), (info))
+#else
+# define __DUMP_EXTENT(...)	((void)0)
+# define DUMP_EXTENT(...)	((void)0)
+# define DUMP_INFO(...)		((void)0)
+#endif
+
+static inline errcode_t __fuse2fs_get_mapping_at(struct fuse2fs *ff,
+						 ext2_extent_handle_t handle,
+						 blk64_t startoff,
+						 struct ext2fs_extent *bmap,
+						 const char *func)
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
+static inline errcode_t __fuse2fs_get_next_mapping(struct fuse2fs *ff,
+						   ext2_extent_handle_t handle,
+						   blk64_t startoff,
+						   struct ext2fs_extent *bmap,
+						   const char *func)
+{
+	struct ext2fs_extent newex;
+	struct ext2_extent_info info;
+	errcode_t err;
+
+	/*
+	 * The extent tree code has this (probably broken) behavior that if
+	 * more than two of the highest levels of the cursor point at the
+	 * rightmost edge of an extent tree block, a _NEXT_LEAF movement fails
+	 * to move the cursor position of any of the lower levels.  IOWs, if
+	 * leaf level N is at the right edge, it will only advance level N-1
+	 * to the right.  If N-1 was at the right edge, the cursor resets to
+	 * record 0 of that level and goes down to the wrong leaf.
+	 *
+	 * Work around this by walking up (towards root level 0) the extent
+	 * tree until we find a level where we're not already at the rightmost
+	 * edge.  The _NEXT_LEAF movement will walk down the tree to find the
+	 * leaves.
+	 */
+	err = ext2fs_extent_get_info(handle, &info);
+	DUMP_INFO(ff, "UP?", startoff, err, &info);
+	if (err)
+		return err;
+
+	while (info.curr_entry == info.num_entries && info.curr_level > 0) {
+		err = ext2fs_extent_get(handle, EXT2_EXTENT_UP, &newex);
+		DUMP_EXTENT(ff, "UP", startoff, err, &newex);
+		if (err)
+			return err;
+		err = ext2fs_extent_get_info(handle, &info);
+		DUMP_INFO(ff, "UP", startoff, err, &info);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * If we're at the root and there are no more entries, there's nothing
+	 * else to be found.
+	 */
+	if (info.curr_level == 0 && info.curr_entry == info.num_entries)
+		return EXT2_ET_EXTENT_NOT_FOUND;
+
+	/* Otherwise grab this next leaf and return it. */
+	err = ext2fs_extent_get(handle, EXT2_EXTENT_NEXT_LEAF, &newex);
+	DUMP_EXTENT(ff, "NEXT", startoff, err, &newex);
+	if (err)
+		return err;
+
+	*bmap = newex;
+	return 0;
+}
+
+#define fuse2fs_get_mapping_at(ff, handle, startoff, bmap) \
+	__fuse2fs_get_mapping_at((ff), (handle), (startoff), (bmap), __func__)
+#define fuse2fs_get_next_mapping(ff, handle, startoff, bmap) \
+	__fuse2fs_get_next_mapping((ff), (handle), (startoff), (bmap), __func__)
+
+static errcode_t fuse2fs_iomap_begin_extent(struct fuse2fs *ff, uint64_t ino,
+					    struct ext2_inode_large *inode,
+					    off_t pos, uint64_t count,
+					    uint32_t opflags,
+					    struct fuse_file_iomap *iomap)
+{
+	ext2_extent_handle_t handle;
+	struct ext2fs_extent extent = { };
+	ext2_filsys fs = ff->fs;
+	const blk64_t startoff = FUSE2FS_B_TO_FSBT(ff, pos);
+	errcode_t err;
+	int ret = 0;
+
+	err = ext2fs_extent_open2(fs, ino, EXT2_INODE(inode), &handle);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = fuse2fs_get_mapping_at(ff, handle, startoff, &extent);
+	if (err == EXT2_ET_EXTENT_NOT_FOUND) {
+		/* No mappings at all; the whole range is a hole. */
+		fuse2fs_iomap_hole_to_eof(ff, iomap, pos, count, inode);
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
+		fuse2fs_iomap_hole(ff, iomap, FUSE2FS_FSB_TO_B(ff, startoff),
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
+		err = fuse2fs_get_next_mapping(ff, handle, startoff, &extent);
+		if (err == EXT2_ET_EXTENT_NOT_FOUND) {
+			fuse2fs_iomap_hole_to_eof(ff, iomap, pos, count, inode);
+			goto out_handle;
+		}
+
+		/*
+		 * If the new mapping starts to the right of startoff, there's
+		 * a hole from startoff to the start of the new mapping.
+		 */
+		if (startoff < extent.e_lblk) {
+			fuse2fs_iomap_hole(ff, iomap,
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
+	iomap->dev = FUSE_IOMAP_DEV_NULL;
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
+static int fuse2fs_iomap_begin_indirect(struct fuse2fs *ff, uint64_t ino,
+					struct ext2_inode_large *inode,
+					off_t pos, uint64_t count,
+					uint32_t opflags,
+					struct fuse_file_iomap *iomap)
+{
+	ext2_filsys fs = ff->fs;
+	blk64_t startoff = FUSE2FS_B_TO_FSBT(ff, pos);
+	uint64_t isize = EXT2_I_SIZE(inode);
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
+	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->offset = FUSE2FS_FSB_TO_B(ff, startoff);
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
+			if (startblock == 0)
+				iomap->length += fs->blocksize;
+			else
+				break;
+		}
+	}
+
+	/*
+	 * If this is a hole that goes beyond EOF, report this as a hole to the
+	 * end of the range queried so that FIEMAP doesn't go mad.
+	 */
+	if (iomap->type == FUSE_IOMAP_TYPE_HOLE &&
+	    iomap->offset + iomap->length >= isize)
+		fuse2fs_iomap_hole_to_eof(ff, iomap, pos, count, inode);
+
+	return 0;
+}
+
+static int fuse2fs_iomap_begin_inline(struct fuse2fs *ff, ext2_ino_t ino,
+				      struct ext2_inode_large *inode, off_t pos,
+				      uint64_t count, struct fuse_file_iomap *iomap)
+{
+	uint64_t one_fsb = FUSE2FS_FSB_TO_B(ff, 1);
+
+	if (pos >= one_fsb) {
+		fuse2fs_iomap_hole_to_eof(ff, iomap, pos, count, inode);
+	} else {
+		/* ext4 only supports inline data files up to 1 fsb */
+		iomap->dev = FUSE_IOMAP_DEV_NULL;
+		iomap->addr = FUSE_IOMAP_NULL_ADDR;
+		iomap->offset = 0;
+		iomap->length = one_fsb;
+		iomap->type = FUSE_IOMAP_TYPE_INLINE;
+	}
+
+	return 0;
+}
+
+static int fuse2fs_iomap_begin_report(struct fuse2fs *ff, ext2_ino_t ino,
+				      struct ext2_inode_large *inode,
+				      off_t pos, uint64_t count,
+				      uint32_t opflags,
+				      struct fuse_file_iomap *read)
+{
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return fuse2fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read);
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return fuse2fs_iomap_begin_extent(ff, ino, inode, pos, count,
+						  opflags, read);
+
+	return fuse2fs_iomap_begin_indirect(ff, ino, inode, pos, count,
+					    opflags, read);
+}
+
+static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
+				    struct ext2_inode_large *inode, off_t pos,
+				    uint64_t count, uint32_t opflags,
+				    struct fuse_file_iomap *read)
+{
+	return -ENOSYS;
+}
+
+static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
+				     struct ext2_inode_large *inode, off_t pos,
+				     uint64_t count, uint32_t opflags,
+				     struct fuse_file_iomap *read)
+{
+	return -ENOSYS;
+}
+
+static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
+			  off_t pos, uint64_t count, uint32_t opflags,
+			  struct fuse_file_iomap *read,
+			  struct fuse_file_iomap *write)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	struct ext2_inode_large inode;
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
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
+	fs = fuse2fs_start(ff);
+	err = fuse2fs_read_inode(fs, attr_ino, &inode);
+	if (err) {
+		ret = translate_error(fs, attr_ino, err);
+		goto out_unlock;
+	}
+
+	if (opflags & FUSE_IOMAP_OP_REPORT)
+		ret = fuse2fs_iomap_begin_report(ff, attr_ino, &inode, pos,
+						 count, opflags, read);
+	else if (fuse_iomap_is_write(opflags))
+		ret = fuse2fs_iomap_begin_write(ff, attr_ino, &inode, pos,
+						count, opflags, read);
+	else
+		ret = fuse2fs_iomap_begin_read(ff, attr_ino, &inode, pos,
+					       count, opflags, read);
+	if (ret)
+		goto out_unlock;
+
+	dbg_printf(ff, "%s: nodeid=%llu attr_ino=%llu pos=0x%llx -> addr=0x%llx offset=0x%llx length=0x%llx type=%u\n",
+		   __func__,
+		   (unsigned long long)nodeid,
+		   (unsigned long long)attr_ino,
+		   (unsigned long long)pos,
+		   (unsigned long long)read->addr,
+		   (unsigned long long)read->offset,
+		   (unsigned long long)read->length,
+		   read->type);
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
+			off_t pos, uint64_t count, uint32_t opflags,
+			ssize_t written, const struct fuse_file_iomap *iomap)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+
+	dbg_printf(ff,
+ "%s: path=%s nodeid=%llu attr_ino=%llu pos=0x%llx count=0x%llx opflags=0x%x written=0x%zx mapflags=0x%x\n",
+		   __func__, path,
+		   (unsigned long long)nodeid,
+		   (unsigned long long)attr_ino,
+		   (unsigned long long)pos,
+		   (unsigned long long)count,
+		   opflags,
+		   written,
+		   iomap->flags);
+
+	return 0;
+}
+#endif /* HAVE_FUSE_IOMAP */
+
 static struct fuse_operations fs_ops = {
 	.init = op_init,
 	.destroy = op_destroy,
@@ -5183,6 +5695,10 @@ static struct fuse_operations fs_ops = {
 #ifdef SUPPORT_FALLOCATE
 	.fallocate = op_fallocate,
 #endif
+#ifdef HAVE_FUSE_IOMAP
+	.iomap_begin = op_iomap_begin,
+	.iomap_end = op_iomap_end,
+#endif /* HAVE_FUSE_IOMAP */
 };
 
 static int get_random_bytes(void *p, size_t sz)
@@ -5469,6 +5985,9 @@ int main(int argc, char *argv[])
 		.bfl = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER,
 		.oom_score_adj = -500,
 		.opstate = F2OP_WRITABLE,
+#ifdef HAVE_FUSE_IOMAP
+		.iomap_state = IOMAP_UNKNOWN,
+#endif
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;


