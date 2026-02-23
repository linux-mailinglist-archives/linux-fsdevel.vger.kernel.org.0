Return-Path: <linux-fsdevel+bounces-78163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJFQKe/lnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:42:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876717FCD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92BA930B32C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362337FF47;
	Mon, 23 Feb 2026 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfsxBxQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB837E317;
	Mon, 23 Feb 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889937; cv=none; b=q7xJgpUvM8H/3RElS1Fan6RH3vUQEzS7HvpxBmskhUUlSr6tFM3Nuz7cXzfTt3FfkqfFApxNUDKr3joNfK9J38H11i/6Oa9XbDL1WsCyAt8v+NdFy3M15KKWWQCUjNLu0C8wGO11+05NLuOXvYJ+rin/IJiPObbvC6ZFmfbKxRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889937; c=relaxed/simple;
	bh=+F47y4QIJMIaUdNxcI7EwrgTI/a9T7B823GyL2lOIIE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ee6wVrKSHeXPjHQV3pnBi3FaKN6VH5mQFLUmXy/0VBLIDVXKsQ5RBK0lilIkx43qSLu3RPJXhmnGYiLUIXdb2U1PXfvWMr3INfl6d+R7dAE0SBykg2UjjyFucbgZldE00YZETUBmsEwq/jj49uRdok4T5zA8yydYxMmaYA3nK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfsxBxQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD07BC116C6;
	Mon, 23 Feb 2026 23:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889936;
	bh=+F47y4QIJMIaUdNxcI7EwrgTI/a9T7B823GyL2lOIIE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gfsxBxQ1j11W1kHn4wrNQimV3uQ9z/9f12xmfUCWYXGmedNNw6gEI2K7NzVa8XrHm
	 RhLZR7yx4au0PIbBp5T0wEvF7wApN4HrwkT3HS+TMM3YmCPf8xLYlFOcD4S2pkJpJY
	 FDP/OZqJO4YqBNLd5bvCl+9K4sBNbaHGavjihoj9xz3NiXg0z16VvewH9n00wFw1r2
	 obdMdReN79VdrD1xCJfU/p01HAuDy6E5KGtIXUGyfslmTx3F1iCcdctbV51teSVPua
	 5mRT4pASO86T8mEivRpPN6VlCTaiatQXkD0/DzcL96xk8/oOscRgKiEdAKEGWrJnU4
	 Pl37/dN2OsQIQ==
Date: Mon, 23 Feb 2026 15:38:56 -0800
Subject: [PATCH 11/19] fuse2fs: try to create loop device when ext4 device is
 a regular file
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744678.3943178.6508834857660203722.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78163-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0876717FCD3
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

If the filesystem device is a regular file, try to create a loop device
for it so that we can take advantage of iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 configure         |   41 +++++++++++++++++++
 configure.ac      |   23 +++++++++++
 fuse4fs/fuse4fs.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 lib/config.h.in   |    3 +
 misc/fuse2fs.c    |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 287 insertions(+), 3 deletions(-)


diff --git a/configure b/configure
index 03b17d07771117..5db59894242aab 100755
--- a/configure
+++ b/configure
@@ -14661,6 +14661,47 @@ printf "%s\n" "#define HAVE_FUSE_IOMAP 1" >>confdefs.h
 
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
+else case e in #(
+  e) { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; } ;;
+esac
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
index 6ccb1fdc444adc..f1bffa88b80fa4 100644
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
index b95ff73b7d9d8e..58a67252b7b613 100644
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
@@ -1910,6 +2014,8 @@ static void op_init(void *userdata, struct fuse_conn_info *conn)
 	fuse4fs_iomap_enable(conn, ff);
 	conn->time_gran = 1;
 
+	fuse4fs_detach_losetup(ff);
+
 	if (ff->opstate == F4OP_WRITABLE)
 		fuse4fs_read_bitmaps(ff);
 
@@ -7439,6 +7545,9 @@ int main(int argc, char *argv[])
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
index 41598dcc1d7c5a..7e045b65131522 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -82,6 +82,9 @@
 /* Define to 1 if fuse supports iomap */
 #undef HAVE_FUSE_IOMAP
 
+/* Define to 1 if fuse supports loopdev operations */
+#undef HAVE_FUSE_LOOPDEV
+
 /* Define to 1 if you have the Mac OS X function
    CFLocaleCopyPreferredLanguages in the CoreFoundation framework. */
 #undef HAVE_CFLOCALECOPYPREFERREDLANGUAGES
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5731da1cbae7e5..8079ace3d30e3f 100644
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
@@ -1736,6 +1839,8 @@ static void *op_init(struct fuse_conn_info *conn,
 		cfg->debug = 1;
 	cfg->nullpath_ok = 1;
 
+	fuse2fs_detach_losetup(ff);
+
 	if (ff->opstate == F2OP_WRITABLE)
 		fuse2fs_read_bitmaps(ff);
 
@@ -6844,6 +6949,9 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+#endif
+#ifdef HAVE_FUSE_LOOPDEV
+		.loop_fd = -1,
 #endif
 	};
 	errcode_t err;


