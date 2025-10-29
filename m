Return-Path: <linux-fsdevel+bounces-66103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B0C17C8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD0B1A63EE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F742D8DDD;
	Wed, 29 Oct 2025 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxBLDORg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80A3A1CD;
	Wed, 29 Oct 2025 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700279; cv=none; b=UjRmjWQrO+y8fDWk4lgLgJATSOA1VA0V2L39QowzPSO/Wob2vy4GjE+4KUty5HQri4OR4n6xy1ePtJkZg00cdimMjtDKhCHxbrsODxzE+8Bnwhn7FFr2kUzkmRzJpbCBBN/RlqIcCF4UisEJU3SahfXXfPLXACHn7Qc0aFMRnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700279; c=relaxed/simple;
	bh=fz+Dj4wGAsp8GLzDalPxwxBr+Jnze9nyEoSeNRogeto=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFENn5CvISPOVFc7EN7X1mqn+lpe8lK0vquEO2TLitWytMWHjYuqP0mHbI6RRLsLos4/4STMgKboQeAfqzZtkE+181wWI4meZqlFztD4bjJQyRqi8oDnKnlvp46qG5ioBjL9Q4uMJd2PYNfDWDEF/jcHlKDPjKc0do6NnY0Q3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxBLDORg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72159C4CEE7;
	Wed, 29 Oct 2025 01:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700278;
	bh=fz+Dj4wGAsp8GLzDalPxwxBr+Jnze9nyEoSeNRogeto=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SxBLDORgRCpyeS9Vi2Gf4BavfOnVC6npjqt3455cto9H9ZotANH2naU6De5/oZyOY
	 pOuOYmqX3tAay78Cevzdm2UIK5bWQhCiGhfIq+vtPd2FRv7jMtYsHkXqDxb48OpZcK
	 Z1v93W1BFtvfYlOvLmdmr3mVDW//EPUd91Lrg+rjV0/6UcLXkEJS4dSC6Wjs5wuKds
	 PkFsUISBoTPuVUeE7rNZUvgGWGrfkic64aGvi/Lh9oMPJZtl6Sn5IEJ8kGm41p58pA
	 BXlWcJTqL1G01Y2swSn1UWsaA7MPyA3xjUaVZsPU183qXImo2Aw6vYv1FpALDe36Ll
	 qGOOMH7HVP53Q==
Date: Tue, 28 Oct 2025 18:11:18 -0700
Subject: [PATCH 11/17] fuse2fs: try to create loop device when ext4 device is
 a regular file
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817763.1429568.8736454863803437440.stgit@frogsfrogsfrogs>
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

If the filesystem device is a regular file, try to create a loop device
for it so that we can take advantage of iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 configure         |   40 +++++++++++++++++++
 configure.ac      |   23 +++++++++++
 fuse4fs/fuse4fs.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 lib/config.h.in   |    3 +
 misc/fuse2fs.c    |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 286 insertions(+), 3 deletions(-)


diff --git a/configure b/configure
index 4137f942efaef5..876f4965759e16 100755
--- a/configure
+++ b/configure
@@ -14293,6 +14293,46 @@ printf "%s\n" "#define HAVE_FUSE_IOMAP 1" >>confdefs.h
 
 fi
 
+if test -n "$have_fuse_iomap"; then
+	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_loopdev.h in libfuse" >&5
+printf %s "checking for fuse_loopdev.h in libfuse... " >&6; }
+	cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+	#define _GNU_SOURCE
+	#define _FILE_OFFSET_BITS	64
+	#define FUSE_USE_VERSION	399
+	#include <fuse_loopdev.h>
+
+int
+main (void)
+{
+
+
+  ;
+  return 0;
+}
+
+_ACEOF
+if ac_fn_c_try_link "$LINENO"
+then :
+  have_fuse_loopdev=yes
+	   { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+printf "%s\n" "yes" >&6; }
+else $as_nop
+  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.beam \
+    conftest$ac_exeext conftest.$ac_ext
+fi
+if test -n "$have_fuse_loopdev"
+then
+
+printf "%s\n" "#define HAVE_FUSE_LOOPDEV 1" >>confdefs.h
+
+fi
+
 have_fuse_lowlevel=
 if test -n "$FUSE_USE_VERSION"
 then
diff --git a/configure.ac b/configure.ac
index a1057c07b8c056..d559ed08f98f04 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1429,6 +1429,29 @@ then
 	AC_DEFINE(HAVE_FUSE_IOMAP, 1, [Define to 1 if fuse supports iomap])
 fi
 
+dnl
+dnl Check if fuse library has fuse_loopdev.h, which it only gained after adding
+dnl iomap support.
+dnl
+if test -n "$have_fuse_iomap"; then
+	AC_MSG_CHECKING(for fuse_loopdev.h in libfuse)
+	AC_LINK_IFELSE(
+	[	AC_LANG_PROGRAM([[
+	#define _GNU_SOURCE
+	#define _FILE_OFFSET_BITS	64
+	#define FUSE_USE_VERSION	399
+	#include <fuse_loopdev.h>
+		]], [[
+		]])
+	], have_fuse_loopdev=yes
+	   AC_MSG_RESULT(yes),
+	   AC_MSG_RESULT(no))
+fi
+if test -n "$have_fuse_loopdev"
+then
+	AC_DEFINE(HAVE_FUSE_LOOPDEV, 1, [Define to 1 if fuse supports loopdev operations])
+fi
+
 dnl
 dnl Check if the FUSE lowlevel library is supported
 dnl
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 10ad29236264a1..af5de5bbf12749 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -27,6 +27,9 @@
 #include <unistd.h>
 #include <ctype.h>
 #include <assert.h>
+#ifdef HAVE_FUSE_LOOPDEV
+# include <fuse_loopdev.h>
+#endif
 #define FUSE_DARWIN_ENABLE_EXTENSIONS 0
 #ifdef __SET_FOB_FOR_FUSE
 # error Do not set magic value __SET_FOB_FOR_FUSE!!!!
@@ -250,6 +253,10 @@ struct fuse4fs {
 	pthread_mutex_t bfl;
 	char *device;
 	char *shortdev;
+#ifdef HAVE_FUSE_LOOPDEV
+	char *loop_device;
+	int loop_fd;
+#endif
 
 	/* options set by fuse_opt_parse must be of type int */
 	int ro;
@@ -273,6 +280,7 @@ struct fuse4fs {
 	enum fuse4fs_feature_toggle iomap_want;
 	enum fuse4fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
+	uint64_t iomap_cap;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -885,8 +893,23 @@ static inline int fuse4fs_iomap_enabled(const struct fuse4fs *ff)
 {
 	return ff->iomap_state >= IOMAP_ENABLED;
 }
+
+static inline void fuse4fs_discover_iomap(struct fuse4fs *ff)
+{
+	if (ff->iomap_want == FT_DISABLE)
+		return;
+
+	ff->iomap_cap = fuse_lowlevel_discover_iomap(-1);
+}
+
+static inline bool fuse4fs_can_iomap(const struct fuse4fs *ff)
+{
+	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
+}
 #else
 # define fuse4fs_iomap_enabled(...)	(0)
+# define fuse4fs_discover_iomap(...)	((void)0)
+# define fuse4fs_can_iomap(...)		(false)
 #endif
 
 static inline void fuse4fs_dump_extents(struct fuse4fs *ff, ext2_ino_t ino,
@@ -1381,6 +1404,72 @@ static void fuse4fs_release_lockfile(struct fuse4fs *ff)
 	free(ff->lockfile);
 }
 
+#ifdef HAVE_FUSE_LOOPDEV
+static int fuse4fs_try_losetup(struct fuse4fs *ff, int flags)
+{
+	bool rw = flags & EXT2_FLAG_RW;
+	int dev_fd;
+	int ret;
+
+	/* Only transform a regular file into a loopdev for iomap */
+	if (!fuse4fs_can_iomap(ff))
+		return 0;
+
+	/* open the actual target device, see if it's a regular file */
+	dev_fd = open(ff->device, rw ? O_RDWR : O_RDONLY);
+	if (dev_fd < 0) {
+		err_printf(ff, "%s: %s\n", _("while opening fs"),
+			   error_message(errno));
+		return -1;
+	}
+
+	ret = fuse_loopdev_setup(dev_fd, rw ? O_RDWR : O_RDONLY, ff->device, 5,
+			   &ff->loop_fd, &ff->loop_device);
+	if (ret && errno == EBUSY) {
+		/*
+		 * If the setup function returned EBUSY, there is already a
+		 * loop device backed by this file.  Report that the file is
+		 * already in use.
+		 */
+		err_printf(ff, "%s: %s\n", _("while opening fs loopdev"),
+				   error_message(errno));
+		close(dev_fd);
+		return -1;
+	}
+
+	close(dev_fd);
+	return 0;
+}
+
+static void fuse4fs_detach_losetup(struct fuse4fs *ff)
+{
+	if (ff->loop_fd >= 0)
+		close(ff->loop_fd);
+	ff->loop_fd = -1;
+}
+
+static void fuse4fs_undo_losetup(struct fuse4fs *ff)
+{
+	fuse4fs_detach_losetup(ff);
+	free(ff->loop_device);
+	ff->loop_device = NULL;
+}
+
+static inline const char *fuse4fs_device(const struct fuse4fs *ff)
+{
+	/*
+	 * If we created a loop device for the file passed in, open that.
+	 * Otherwise open the path the user gave us.
+	 */
+	return ff->loop_device ? ff->loop_device : ff->device;
+}
+#else
+# define fuse4fs_try_losetup(...)	(0)
+# define fuse4fs_detach_losetup(...)	((void)0)
+# define fuse4fs_undo_losetup(...)	((void)0)
+# define fuse4fs_device(ff)		((ff)->device)
+#endif
+
 static void fuse4fs_unmount(struct fuse4fs *ff)
 {
 	char uuid[UUID_STR_SIZE];
@@ -1403,6 +1492,8 @@ static void fuse4fs_unmount(struct fuse4fs *ff)
 				   uuid);
 	}
 
+	fuse4fs_undo_losetup(ff);
+
 	if (ff->lockfile)
 		fuse4fs_release_lockfile(ff);
 }
@@ -1415,6 +1506,8 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 		    EXT2_FLAG_EXCLUSIVE | EXT2_FLAG_WRITE_FULL_SUPER;
 	errcode_t err;
 
+	fuse4fs_discover_iomap(ff);
+
 	if (ff->lockfile) {
 		err = fuse4fs_acquire_lockfile(ff);
 		if (err)
@@ -1427,6 +1520,12 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
+	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+
+	err = fuse4fs_try_losetup(ff, flags);
+	if (err)
+		return err;
+
 	/*
 	 * If the filesystem is stored on a block device, the _EXCLUSIVE flag
 	 * causes libext2fs to try to open the block device with O_EXCL.  If
@@ -1458,7 +1557,7 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 	 */
 	deadline = init_deadline(FUSE4FS_OPEN_TIMEOUT);
 	do {
-		err = ext2fs_open2(ff->device, options, flags, 0, 0,
+		err = ext2fs_open2(fuse4fs_device(ff), options, flags, 0, 0,
 				   unix_io_manager, &ff->fs);
 		if ((err == EPERM || err == EACCES) &&
 		    (!ff->ro || (flags & EXT2_FLAG_RW))) {
@@ -1473,6 +1572,11 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 			flags &= ~EXT2_FLAG_RW;
 			ff->ro = 1;
 
+			fuse4fs_undo_losetup(ff);
+			err = fuse4fs_try_losetup(ff, flags);
+			if (err)
+				return err;
+
 			/* Force the loop to run once more */
 			err = -1;
 		}
@@ -1904,6 +2008,8 @@ static void op_init(void *userdata, struct fuse_conn_info *conn)
 	fuse4fs_iomap_enable(conn, ff);
 	conn->time_gran = 1;
 
+	fuse4fs_detach_losetup(ff);
+
 	if (ff->opstate == F4OP_WRITABLE)
 		fuse4fs_read_bitmaps(ff);
 
@@ -7419,6 +7525,9 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+#endif
+#ifdef HAVE_FUSE_LOOPDEV
+		.loop_fd = -1,
 #endif
 	};
 	errcode_t err;
diff --git a/lib/config.h.in b/lib/config.h.in
index 55e515020af422..667f7e3e29e7d5 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -79,6 +79,9 @@
 /* Define to 1 if fuse supports iomap */
 #undef HAVE_FUSE_IOMAP
 
+/* Define to 1 if fuse supports loopdev operations */
+#undef HAVE_FUSE_LOOPDEV
+
 /* Define to 1 if you have the Mac OS X function
    CFLocaleCopyPreferredLanguages in the CoreFoundation framework. */
 #undef HAVE_CFLOCALECOPYPREFERREDLANGUAGES
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7e74603f5f4eee..24e160185a0c97 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -25,6 +25,9 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 #include <ctype.h>
+#ifdef HAVE_FUSE_LOOPDEV
+# include <fuse_loopdev.h>
+#endif
 #define FUSE_DARWIN_ENABLE_EXTENSIONS 0
 #ifdef __SET_FOB_FOR_FUSE
 # error Do not set magic value __SET_FOB_FOR_FUSE!!!!
@@ -244,6 +247,10 @@ struct fuse2fs {
 	pthread_mutex_t bfl;
 	char *device;
 	char *shortdev;
+#ifdef HAVE_FUSE_LOOPDEV
+	char *loop_device;
+	int loop_fd;
+#endif
 
 	/* options set by fuse_opt_parse must be of type int */
 	int ro;
@@ -267,6 +274,7 @@ struct fuse2fs {
 	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
+	uint64_t iomap_cap;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -724,9 +732,23 @@ static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
 {
 	return ff->iomap_state >= IOMAP_ENABLED;
 }
+
+static inline void fuse2fs_discover_iomap(struct fuse2fs *ff)
+{
+	if (ff->iomap_want == FT_DISABLE)
+		return;
+
+	ff->iomap_cap = fuse_lowlevel_discover_iomap(-1);
+}
+
+static inline bool fuse2fs_can_iomap(const struct fuse2fs *ff)
+{
+	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
+}
 #else
 # define fuse2fs_iomap_enabled(...)	(0)
-# define fuse2fs_iomap_enabled(...)	(0)
+# define fuse2fs_discover_iomap(...)	((void)0)
+# define fuse2fs_can_iomap(...)		(false)
 #endif
 
 static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
@@ -1200,6 +1222,72 @@ static void fuse2fs_release_lockfile(struct fuse2fs *ff)
 	free(ff->lockfile);
 }
 
+#ifdef HAVE_FUSE_LOOPDEV
+static int fuse2fs_try_losetup(struct fuse2fs *ff, int flags)
+{
+	bool rw = flags & EXT2_FLAG_RW;
+	int dev_fd;
+	int ret;
+
+	/* Only transform a regular file into a loopdev for iomap */
+	if (!fuse2fs_can_iomap(ff))
+		return 0;
+
+	/* open the actual target device, see if it's a regular file */
+	dev_fd = open(ff->device, rw ? O_RDWR : O_RDONLY);
+	if (dev_fd < 0) {
+		err_printf(ff, "%s: %s\n", _("while opening fs"),
+			   error_message(errno));
+		return -1;
+	}
+
+	ret = fuse_loopdev_setup(dev_fd, rw ? O_RDWR : O_RDONLY, ff->device, 5,
+			   &ff->loop_fd, &ff->loop_device);
+	if (ret && errno == EBUSY) {
+		/*
+		 * If the setup function returned EBUSY, there is already a
+		 * loop device backed by this file.  Report that the file is
+		 * already in use.
+		 */
+		err_printf(ff, "%s: %s\n", _("while opening fs loopdev"),
+				   error_message(errno));
+		close(dev_fd);
+		return -1;
+	}
+
+	close(dev_fd);
+	return 0;
+}
+
+static void fuse2fs_detach_losetup(struct fuse2fs *ff)
+{
+	if (ff->loop_fd >= 0)
+		close(ff->loop_fd);
+	ff->loop_fd = -1;
+}
+
+static void fuse2fs_undo_losetup(struct fuse2fs *ff)
+{
+	fuse2fs_detach_losetup(ff);
+	free(ff->loop_device);
+	ff->loop_device = NULL;
+}
+
+static inline const char *fuse2fs_device(const struct fuse2fs *ff)
+{
+	/*
+	 * If we created a loop device for the file passed in, open that.
+	 * Otherwise open the path the user gave us.
+	 */
+	return ff->loop_device ? ff->loop_device : ff->device;
+}
+#else
+# define fuse2fs_try_losetup(...)	(0)
+# define fuse2fs_detach_losetup(...)	((void)0)
+# define fuse2fs_undo_losetup(...)	((void)0)
+# define fuse2fs_device(ff)		((ff)->device)
+#endif
+
 static void fuse2fs_unmount(struct fuse2fs *ff)
 {
 	char uuid[UUID_STR_SIZE];
@@ -1217,6 +1305,8 @@ static void fuse2fs_unmount(struct fuse2fs *ff)
 				   uuid);
 	}
 
+	fuse2fs_undo_losetup(ff);
+
 	if (ff->lockfile)
 		fuse2fs_release_lockfile(ff);
 }
@@ -1229,6 +1319,8 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 		    EXT2_FLAG_EXCLUSIVE | EXT2_FLAG_WRITE_FULL_SUPER;
 	errcode_t err;
 
+	fuse2fs_discover_iomap(ff);
+
 	if (ff->lockfile) {
 		err = fuse2fs_acquire_lockfile(ff);
 		if (err)
@@ -1241,6 +1333,12 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
+	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+
+	err = fuse2fs_try_losetup(ff, flags);
+	if (err)
+		return err;
+
 	/*
 	 * If the filesystem is stored on a block device, the _EXCLUSIVE flag
 	 * causes libext2fs to try to open the block device with O_EXCL.  If
@@ -1272,7 +1370,7 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 	 */
 	deadline = init_deadline(FUSE2FS_OPEN_TIMEOUT);
 	do {
-		err = ext2fs_open2(ff->device, options, flags, 0, 0,
+		err = ext2fs_open2(fuse2fs_device(ff), options, flags, 0, 0,
 				   unix_io_manager, &ff->fs);
 		if ((err == EPERM || err == EACCES) &&
 		    (!ff->ro || (flags & EXT2_FLAG_RW))) {
@@ -1287,6 +1385,11 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 			flags &= ~EXT2_FLAG_RW;
 			ff->ro = 1;
 
+			fuse2fs_undo_losetup(ff);
+			err = fuse2fs_try_losetup(ff, flags);
+			if (err)
+				return err;
+
 			/* Force the loop to run once more */
 			err = -1;
 		}
@@ -1730,6 +1833,8 @@ static void *op_init(struct fuse_conn_info *conn,
 		cfg->debug = 1;
 	cfg->nullpath_ok = 1;
 
+	fuse2fs_detach_losetup(ff);
+
 	if (ff->opstate == F2OP_WRITABLE)
 		fuse2fs_read_bitmaps(ff);
 
@@ -6827,6 +6932,9 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+#endif
+#ifdef HAVE_FUSE_LOOPDEV
+		.loop_fd = -1,
 #endif
 	};
 	errcode_t err;


