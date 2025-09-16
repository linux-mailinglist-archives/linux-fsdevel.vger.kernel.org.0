Return-Path: <linux-fsdevel+bounces-61658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE25B58ACA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA916A000
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CEC1DE89A;
	Tue, 16 Sep 2025 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gctufBgh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8920322;
	Tue, 16 Sep 2025 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984873; cv=none; b=OBhoqra4tMSaDOKRXcjiLmOWIAimbKsmOjVsFcTOXWIVplkJwyFrbTpiZ9uwexYYsi3lc5mrP9WytlyIdXS7G8gfTIK7eFsDaSJjEfjO7ZqrjixPQoY7Vev/OtBfBWeh+8LNQI/1Rj7611DUvYS2FDDyWre0pmXu6Dv99mi1td4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984873; c=relaxed/simple;
	bh=Gw5g6QkuIorge0vm5vNjO8qp/7r3+nykJ/a0hKvAs/k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlwImuhh9O6/ogPJlb7Ol3fS+J2jTnLlPhDuDOiN4it/fSYO5J67KjJ7Ogu2f/JdsDnwPWqum8M3VIzzxgdVvKaAIjjn2YgEl5J22w4u1f1oW6+JG4hvaCapxelTPFBJn6XgK8GHS8gAI09/rO3fZ//XUTK8vNhUf7dYqReUcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gctufBgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A49C4CEF1;
	Tue, 16 Sep 2025 01:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984873;
	bh=Gw5g6QkuIorge0vm5vNjO8qp/7r3+nykJ/a0hKvAs/k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gctufBghLsFEk7w4RZVjBa64Ap72pWfXANDkkn4ebwzFjD8M3wgameUfujNRQtTHN
	 1T38micwACfMFDiup/YDWxKZUt5mp+mmstCAffKRKxVlU+DZmy6+QdJYetB0flte1E
	 9MgmdzHujK5DbJjpH0nzQpqT5kroBxpsy27s9yP7LdRFS8P+Ne+NPAeSJwDp0uVkfh
	 goBoG3olaapREjnYdfIC7sim6A2DBYR8t3vzZJuhX64XldHGrF/NiSkGzf4G5LPzsK
	 CAxmBo+M26CHZpHB9RrjDB0AvwgeKg6jn2ppjJIT4jG2eCyF9Pnnc/NlRds85GkLbY
	 DjOkoWLWPqgCA==
Date: Mon, 15 Sep 2025 18:07:52 -0700
Subject: [PATCH 4/6] fuse2fs: enable caching IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162924.391868.14731860694935521443.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162827.391868.5088762964182041258.stgit@frogsfrogsfrogs>
References: <175798162827.391868.5088762964182041258.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Enable the new dynamic iocache I/O manager in the fuse server, and turn
off all the other cache control.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/Makefile.in  |    3 +-
 fuse4fs/fuse4fs.1.in |    6 ----
 fuse4fs/fuse4fs.c    |   71 +++----------------------------------------------
 misc/Makefile.in     |    4 ++-
 misc/fuse2fs.1.in    |    6 ----
 misc/fuse2fs.c       |   73 ++++----------------------------------------------
 6 files changed, 15 insertions(+), 148 deletions(-)


diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index 9f3547c271638f..0a558da23ced81 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -147,7 +147,8 @@ fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
- $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
+ $(top_srcdir)/lib/support/iocache.h
 journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
  $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
diff --git a/fuse4fs/fuse4fs.1.in b/fuse4fs/fuse4fs.1.in
index 119cbcc903d8af..7ab197465c9713 100644
--- a/fuse4fs/fuse4fs.1.in
+++ b/fuse4fs/fuse4fs.1.in
@@ -48,12 +48,6 @@ .SS "fuse4fs options:"
 \fB-o\fR acl
 enable file access control lists
 .TP
-\fB-o\fR cache_size
-Set the disk cache size to this quantity.
-The quantity may contain the suffixes k, m, or g.
-By default, the size is 32MB.
-The size may not be larger than 2GB.
-.TP
 \fB-o\fR direct
 Use O_DIRECT to access the block device.
 .TP
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index c4397fc365ced7..2dd7c0f6759de5 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -53,6 +53,7 @@
 #include "ext2fs/ext2fsP.h"
 #include "support/list.h"
 #include "support/cache.h"
+#include "support/iocache.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -290,7 +291,6 @@ struct fuse4fs {
 	unsigned int blockmask;
 	unsigned long offset;
 	unsigned int next_generation;
-	unsigned long long cache_size;
 	char *lockfile;
 #ifdef HAVE_CLOCK_MONOTONIC
 	struct timespec lock_start_time;
@@ -1289,7 +1289,8 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
 
 	dbg_printf(ff, "opening with flags=0x%x\n", flags);
 
-	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
+	iocache_set_backing_manager(unix_io_manager);
+	err = ext2fs_open2(ff->device, options, flags, 0, 0, iocache_io_manager,
 			   &ff->fs);
 	if (err == EPERM) {
 		err_printf(ff, "%s.\n",
@@ -1298,7 +1299,7 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
 		ff->ro = 1;
 		ff->norecovery = 1;
 		err = ext2fs_open2(ff->device, options, flags, 0, 0,
-				   unix_io_manager, &ff->fs);
+				   iocache_io_manager, &ff->fs);
 	}
 	if (err) {
 		err_printf(ff, "%s.\n", error_message(err));
@@ -1321,25 +1322,6 @@ static inline bool fuse4fs_on_bdev(const struct fuse4fs *ff)
 	return ff->fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE;
 }
 
-static errcode_t fuse4fs_config_cache(struct fuse4fs *ff)
-{
-	char buf[128];
-	errcode_t err;
-
-	snprintf(buf, sizeof(buf), "cache_blocks=%llu",
-		 FUSE4FS_B_TO_FSBT(ff, ff->cache_size));
-	err = io_channel_set_options(ff->fs->io, buf);
-	if (err) {
-		err_printf(ff, "%s %lluk: %s\n",
-			   _("cannot set disk cache size to"),
-			   ff->cache_size >> 10,
-			   error_message(err));
-		return err;
-	}
-
-	return 0;
-}
-
 static errcode_t fuse4fs_check_support(struct fuse4fs *ff)
 {
 	ext2_filsys fs = ff->fs;
@@ -7193,7 +7175,6 @@ enum {
 	FUSE4FS_VERSION,
 	FUSE4FS_HELP,
 	FUSE4FS_HELPFULL,
-	FUSE4FS_CACHE_SIZE,
 	FUSE4FS_DIRSYNC,
 	FUSE4FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
@@ -7243,7 +7224,6 @@ static struct fuse_opt fuse4fs_opts[] = {
 	FUSE_OPT_KEY("user_xattr",	FUSE4FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE4FS_IGNORED),
 	FUSE_OPT_KEY("nodelalloc",	FUSE4FS_IGNORED),
-	FUSE_OPT_KEY("cache_size=%s",	FUSE4FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE4FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE4FS_ERRORS_BEHAVIOR),
 #ifdef HAVE_FUSE_IOMAP
@@ -7282,16 +7262,6 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 			return 0;
 		}
 		return 1;
-	case FUSE4FS_CACHE_SIZE:
-		ff->cache_size = parse_num_blocks2(arg + 11, -1);
-		if (ff->cache_size < 1 || ff->cache_size > INT32_MAX) {
-			fprintf(stderr, "%s: %s\n", arg,
- _("cache size must be between 1 block and 2GB."));
-			return -1;
-		}
-
-		/* do not pass through to libfuse */
-		return 0;
 	case FUSE4FS_ERRORS_BEHAVIOR:
 		if (strcmp(arg + 7, "continue") == 0)
 			ff->errors_behavior = EXT2_ERRORS_CONTINUE;
@@ -7348,7 +7318,6 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 	"    -o kernel              run this as if it were the kernel, which sets:\n"
 	"                           allow_others,default_permissions,suid,dev\n"
 	"    -o directio            use O_DIRECT to read and write the disk\n"
-	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
 #ifdef HAVE_FUSE_IOMAP
@@ -7391,28 +7360,6 @@ static const char *get_subtype(const char *argv0)
 	return "ext4";
 }
 
-/* Figure out a reasonable default size for the disk cache */
-static unsigned long long default_cache_size(void)
-{
-	long pages = 0, pagesize = 0;
-	unsigned long long max_cache;
-	unsigned long long ret = 32ULL << 20; /* 32 MB */
-
-#ifdef _SC_PHYS_PAGES
-	pages = sysconf(_SC_PHYS_PAGES);
-#endif
-#ifdef _SC_PAGESIZE
-	pagesize = sysconf(_SC_PAGESIZE);
-#endif
-	if (pages > 0 && pagesize > 0) {
-		max_cache = (unsigned long long)pagesize * pages / 20;
-
-		if (max_cache > 0 && ret > max_cache)
-			ret = max_cache;
-	}
-	return ret;
-}
-
 #ifdef HAVE_FUSE_IOMAP
 static inline bool fuse4fs_discover_iomap(struct fuse4fs *ff)
 {
@@ -7687,16 +7634,6 @@ int main(int argc, char *argv[])
 		fctx.translate_inums = 0;
 	}
 
-	if (!fctx.cache_size)
-		fctx.cache_size = default_cache_size();
-	if (fctx.cache_size) {
-		err = fuse4fs_config_cache(&fctx);
-		if (err) {
-			ret = 32;
-			goto out;
-		}
-	}
-
 	err = fuse4fs_check_support(&fctx);
 	if (err) {
 		ret = 32;
diff --git a/misc/Makefile.in b/misc/Makefile.in
index ec964688acd623..8a3adc70fb736e 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -880,7 +880,9 @@ fuse2fs.o: $(srcdir)/fuse2fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
- $(top_srcdir)/lib/e2p/e2p.h
+ $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
+ $(top_srcdir)/lib/support/iocache.h
 e2fuzz.o: $(srcdir)/e2fuzz.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
index 0c0934f03c9543..21917bdda31a12 100644
--- a/misc/fuse2fs.1.in
+++ b/misc/fuse2fs.1.in
@@ -48,12 +48,6 @@ .SS "fuse2fs options:"
 \fB-o\fR acl
 enable file access control lists
 .TP
-\fB-o\fR cache_size
-Set the disk cache size to this quantity.
-The quantity may contain the suffixes k, m, or g.
-By default, the size is 32MB.
-The size may not be larger than 2GB.
-.TP
 \fB-o\fR direct
 Use O_DIRECT to access the block device.
 .TP
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5e4680ca023282..8bd7cedc9f1ca8 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -50,6 +50,9 @@
 #include "ext2fs/ext2fs.h"
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fsP.h"
+#include "support/list.h"
+#include "support/cache.h"
+#include "support/iocache.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -283,7 +286,6 @@ struct fuse2fs {
 	unsigned int blockmask;
 	unsigned long offset;
 	unsigned int next_generation;
-	unsigned long long cache_size;
 	char *lockfile;
 #ifdef HAVE_CLOCK_MONOTONIC
 	struct timespec lock_start_time;
@@ -1119,7 +1121,8 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 
 	dbg_printf(ff, "opening with flags=0x%x\n", flags);
 
-	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
+	iocache_set_backing_manager(unix_io_manager);
+	err = ext2fs_open2(ff->device, options, flags, 0, 0, iocache_io_manager,
 			   &ff->fs);
 	if (err == EPERM) {
 		err_printf(ff, "%s.\n",
@@ -1128,7 +1131,7 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 		ff->ro = 1;
 		ff->norecovery = 1;
 		err = ext2fs_open2(ff->device, options, flags, 0, 0,
-				   unix_io_manager, &ff->fs);
+				   iocache_io_manager, &ff->fs);
 	}
 	if (err) {
 		err_printf(ff, "%s.\n", error_message(err));
@@ -1147,25 +1150,6 @@ static inline bool fuse2fs_on_bdev(const struct fuse2fs *ff)
 	return ff->fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE;
 }
 
-static errcode_t fuse2fs_config_cache(struct fuse2fs *ff)
-{
-	char buf[128];
-	errcode_t err;
-
-	snprintf(buf, sizeof(buf), "cache_blocks=%llu",
-		 FUSE2FS_B_TO_FSBT(ff, ff->cache_size));
-	err = io_channel_set_options(ff->fs->io, buf);
-	if (err) {
-		err_printf(ff, "%s %lluk: %s\n",
-			   _("cannot set disk cache size to"),
-			   ff->cache_size >> 10,
-			   error_message(err));
-		return err;
-	}
-
-	return 0;
-}
-
 static errcode_t fuse2fs_check_support(struct fuse2fs *ff)
 {
 	ext2_filsys fs = ff->fs;
@@ -6750,7 +6734,6 @@ enum {
 	FUSE2FS_VERSION,
 	FUSE2FS_HELP,
 	FUSE2FS_HELPFULL,
-	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
 	FUSE2FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
@@ -6800,7 +6783,6 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("nodelalloc",	FUSE2FS_IGNORED),
-	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE2FS_ERRORS_BEHAVIOR),
 #ifdef HAVE_FUSE_IOMAP
@@ -6839,16 +6821,6 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 			return 0;
 		}
 		return 1;
-	case FUSE2FS_CACHE_SIZE:
-		ff->cache_size = parse_num_blocks2(arg + 11, -1);
-		if (ff->cache_size < 1 || ff->cache_size > INT32_MAX) {
-			fprintf(stderr, "%s: %s\n", arg,
- _("cache size must be between 1 block and 2GB."));
-			return -1;
-		}
-
-		/* do not pass through to libfuse */
-		return 0;
 	case FUSE2FS_ERRORS_BEHAVIOR:
 		if (strcmp(arg + 7, "continue") == 0)
 			ff->errors_behavior = EXT2_ERRORS_CONTINUE;
@@ -6905,7 +6877,6 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -o kernel              run this as if it were the kernel, which sets:\n"
 	"                           allow_others,default_permissions,suid,dev\n"
 	"    -o directio            use O_DIRECT to read and write the disk\n"
-	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
 #ifdef HAVE_FUSE_IOMAP
@@ -6949,28 +6920,6 @@ static const char *get_subtype(const char *argv0)
 	return "ext4";
 }
 
-/* Figure out a reasonable default size for the disk cache */
-static unsigned long long default_cache_size(void)
-{
-	long pages = 0, pagesize = 0;
-	unsigned long long max_cache;
-	unsigned long long ret = 32ULL << 20; /* 32 MB */
-
-#ifdef _SC_PHYS_PAGES
-	pages = sysconf(_SC_PHYS_PAGES);
-#endif
-#ifdef _SC_PAGESIZE
-	pagesize = sysconf(_SC_PAGESIZE);
-#endif
-	if (pages > 0 && pagesize > 0) {
-		max_cache = (unsigned long long)pagesize * pages / 20;
-
-		if (max_cache > 0 && ret > max_cache)
-			ret = max_cache;
-	}
-	return ret;
-}
-
 #ifdef HAVE_FUSE_IOMAP
 static inline bool fuse2fs_discover_iomap(struct fuse2fs *ff)
 {
@@ -7130,16 +7079,6 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
-	if (!fctx.cache_size)
-		fctx.cache_size = default_cache_size();
-	if (fctx.cache_size) {
-		err = fuse2fs_config_cache(&fctx);
-		if (err) {
-			ret = 32;
-			goto out;
-		}
-	}
-
 	err = fuse2fs_check_support(&fctx);
 	if (err) {
 		ret = 32;


