Return-Path: <linux-fsdevel+bounces-58563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CBBB2EAA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB7C5E02D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9CA2192E1;
	Thu, 21 Aug 2025 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRC6yFqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8920B81B;
	Thu, 21 Aug 2025 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739459; cv=none; b=KxGZExkOsbTdARhI9jNdbNKkkDYliTvbdv4LWQh6CDtGe2YBUJi5U59T9FnVW7XaM5KfDzSeKLaIv5kMkTBXAIYbs/voe0bzgGDPFHj2q+Y+aaeLkA/MYhq85CxeUGSwqIwxpHKD0Cjq+rXxJTAEh0d0BJ6Y1cheyVXUJ0lIHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739459; c=relaxed/simple;
	bh=Jg09vQW2AVBFX+bSpdrR6pI0ApRxyywjbnd4+lgnAv4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmXZG81JV1lOSFtfRpYiD8Ax9kBRmb2+H74/maobn17vcClSGBMOKB1Q7K6rKo9+Ga5Mu9zM8nWVdJLr9VXnTRxd9uBywzG0IEar1OcuZqNKq7q1Qb17kGxAGGhITj0svIqgIpsQTVRL4h452Z47usE4N9KjavMuJe8C75qM700=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRC6yFqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22185C4CEE7;
	Thu, 21 Aug 2025 01:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739459;
	bh=Jg09vQW2AVBFX+bSpdrR6pI0ApRxyywjbnd4+lgnAv4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XRC6yFqdtzoBcHEtVh2/CgaZ3rHOc10Sutl9CYSUF50dp1in6NTJk3raT6URGzyB8
	 kM6yKzwIy4JaabqX/sVsdrfzjibGRIgAFbg8Tc0yKGSPs404z7DuWS1qMB3wCQ89M4
	 ABVRtoXb0fXjOfx9ILhAyYwer0GTppNkvQth6wfq8QDwjWU7M7ELvOid5s3ni8KPqv
	 QTMxOCfwt6pLWKaM0knzRmJMeC9Jtv4qKVMHjA7yj0mUifBUixHyCg3xf6+RlTnPN7
	 07PUCgVmJUJRI6zkX+COMmyHRBSHBuz8DH1ai8qRe+/qJKlMqWT57C7f31ypZRZm7p
	 mQwDtcECm93vA==
Date: Wed, 20 Aug 2025 18:24:18 -0700
Subject: [PATCH 4/6] fuse2fs: enable caching IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714757.23206.14015594018065840662.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714661.23206.877359205706511372.stgit@frogsfrogsfrogs>
References: <175573714661.23206.877359205706511372.stgit@frogsfrogsfrogs>
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
 misc/Makefile.in |    7 ++++-
 misc/fuse2fs.c   |   71 ++++--------------------------------------------------
 misc/fuse4fs.c   |   69 ++--------------------------------------------------
 3 files changed, 13 insertions(+), 134 deletions(-)


diff --git a/misc/Makefile.in b/misc/Makefile.in
index 36694d682d3b59..8a31b7fc42e643 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -891,7 +891,9 @@ fuse2fs.o: $(srcdir)/fuse2fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
- $(top_srcdir)/lib/e2p/e2p.h
+ $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
+ $(top_srcdir)/lib/support/iocache.h
 fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
@@ -901,7 +903,8 @@ fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
- $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
+ $(top_srcdir)/lib/support/iocache.h
 e2fuzz.o: $(srcdir)/e2fuzz.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f5d68cc549ad69..d3ac5f7b6627cd 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -50,6 +50,9 @@
 #include "ext2fs/ext2fs.h"
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fsP.h"
+#include "support/list.h"
+#include "support/cache.h"
+#include "support/iocache.h"
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 # define FUSE_PLATFORM_OPTS	""
 #else
@@ -290,7 +293,6 @@ struct fuse2fs {
 	unsigned int blockmask;
 	unsigned long offset;
 	unsigned int next_generation;
-	unsigned long long cache_size;
 	char *lockfile;
 #ifdef HAVE_CLOCK_MONOTONIC
 	struct timespec lock_start_time;
@@ -1122,7 +1124,7 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 
 	dbg_printf(ff, "opening with flags=0x%x\n", flags);
 
-	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
+	err = ext2fs_open2(ff->device, options, flags, 0, 0, iocache_io_manager,
 			   &ff->fs);
 	if (err == EPERM) {
 		err_printf(ff, "%s.\n",
@@ -1150,25 +1152,6 @@ static inline bool fuse2fs_on_bdev(const struct fuse2fs *ff)
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
@@ -6829,7 +6812,6 @@ enum {
 	FUSE2FS_VERSION,
 	FUSE2FS_HELP,
 	FUSE2FS_HELPFULL,
-	FUSE2FS_CACHE_SIZE,
 	FUSE2FS_DIRSYNC,
 	FUSE2FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
@@ -6879,7 +6861,6 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("nodelalloc",	FUSE2FS_IGNORED),
-	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE2FS_ERRORS_BEHAVIOR),
 #ifdef HAVE_FUSE_IOMAP
@@ -6918,16 +6899,6 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
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
@@ -6984,7 +6955,6 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -o kernel              run this as if it were the kernel, which sets:\n"
 	"                           allow_others,default_permissions,suid,dev\n"
 	"    -o directio            use O_DIRECT to read and write the disk\n"
-	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
 #ifdef HAVE_FUSE_IOMAP
@@ -7028,28 +6998,6 @@ static const char *get_subtype(const char *argv0)
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
@@ -7170,6 +7118,7 @@ int main(int argc, char *argv[])
 		fctx.alloc_all_blocks = 1;
 	}
 
+	iocache_set_backing_manager(unix_io_manager);
 	err = fuse2fs_open(&fctx, EXT2_FLAG_EXCLUSIVE);
 	if (err) {
 		ret = 32;
@@ -7206,16 +7155,6 @@ int main(int argc, char *argv[])
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
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 6f03c6a0933a3d..85d73a9088d237 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -53,6 +53,7 @@
 #include "ext2fs/ext2fsP.h"
 #include "support/list.h"
 #include "support/cache.h"
+#include "support/iocache.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -286,7 +287,6 @@ struct fuse4fs {
 	unsigned int blockmask;
 	unsigned long offset;
 	unsigned int next_generation;
-	unsigned long long cache_size;
 	char *lockfile;
 #ifdef HAVE_CLOCK_MONOTONIC
 	struct timespec lock_start_time;
@@ -1281,7 +1281,7 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
 
 	dbg_printf(ff, "opening with flags=0x%x\n", flags);
 
-	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
+	err = ext2fs_open2(ff->device, options, flags, 0, 0, iocache_io_manager,
 			   &ff->fs);
 	if (err == EPERM) {
 		err_printf(ff, "%s.\n",
@@ -1313,25 +1313,6 @@ static inline bool fuse4fs_on_bdev(const struct fuse4fs *ff)
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
@@ -7113,7 +7094,6 @@ enum {
 	FUSE4FS_VERSION,
 	FUSE4FS_HELP,
 	FUSE4FS_HELPFULL,
-	FUSE4FS_CACHE_SIZE,
 	FUSE4FS_DIRSYNC,
 	FUSE4FS_ERRORS_BEHAVIOR,
 #ifdef HAVE_FUSE_IOMAP
@@ -7163,7 +7143,6 @@ static struct fuse_opt fuse4fs_opts[] = {
 	FUSE_OPT_KEY("user_xattr",	FUSE4FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE4FS_IGNORED),
 	FUSE_OPT_KEY("nodelalloc",	FUSE4FS_IGNORED),
-	FUSE_OPT_KEY("cache_size=%s",	FUSE4FS_CACHE_SIZE),
 	FUSE_OPT_KEY("dirsync",		FUSE4FS_DIRSYNC),
 	FUSE_OPT_KEY("errors=%s",	FUSE4FS_ERRORS_BEHAVIOR),
 #ifdef HAVE_FUSE_IOMAP
@@ -7202,16 +7181,6 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
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
@@ -7268,7 +7237,6 @@ static int fuse4fs_opt_proc(void *data, const char *arg,
 	"    -o kernel              run this as if it were the kernel, which sets:\n"
 	"                           allow_others,default_permissions,suid,dev\n"
 	"    -o directio            use O_DIRECT to read and write the disk\n"
-	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"    -o errors=             behavior when an error is encountered:\n"
 	"                           continue|remount-ro|panic\n"
 #ifdef HAVE_FUSE_IOMAP
@@ -7311,28 +7279,6 @@ static const char *get_subtype(const char *argv0)
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
@@ -7554,6 +7500,7 @@ int main(int argc, char *argv[])
 		fctx.alloc_all_blocks = 1;
 	}
 
+	iocache_set_backing_manager(unix_io_manager);
 	err = fuse4fs_open(&fctx, EXT2_FLAG_EXCLUSIVE);
 	if (err) {
 		ret = 32;
@@ -7603,16 +7550,6 @@ int main(int argc, char *argv[])
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


