Return-Path: <linux-fsdevel+bounces-66076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A83C17BC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F34984F221C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ED12D7DE1;
	Wed, 29 Oct 2025 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH/mrRMw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25B283682;
	Wed, 29 Oct 2025 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699856; cv=none; b=LTx1wxUPSKIesHVH2OhdpYuo8d7i5stoCsMiDBLVh4RVlj5j6O/vUpEHfaOWzIOps7e7zkgbC8zWNN8ztxMKw9JnlMWPNIpzsiv9JAtHjIWAx8W4oHbvI30YVimTLT77i1EeWMf/kLkf1R1uUmwzJ+mmDAOi5/1Y8x1mUSylmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699856; c=relaxed/simple;
	bh=KUq1EEhXa622Nwi+Cw9tyupwbr6f7CajK/pq6lF3LH8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgd+KFlodGFlxuWdDWgXaBenIJxdS1pCQCwcO98aLEpYL3ku2+47AtacHEVmk2c1xCwFlQ5xDr011vdSQLkrzVwnxGh+W5715Eh7S1cc2CWW9L0knr9YvsUm3nisQDnPfvRkrQDfssVm4VgjtEcGqFfUxS6V+K7YlxCUyOhcq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH/mrRMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACCAC4CEE7;
	Wed, 29 Oct 2025 01:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699856;
	bh=KUq1EEhXa622Nwi+Cw9tyupwbr6f7CajK/pq6lF3LH8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hH/mrRMwzOw+gKB5L3utsmVvXHnenYfF1w2nBk5qsdhbNZUtwvEui+leamWL9SpBa
	 2kq97RchKu+vd1Zjg8lw2+OKRj3bUX4nanBg/ehm+wXyvUCb4FycdkzPqrXnJ3bhT0
	 MD5uA3Sy3dEbAapoOhmWzydvTelh+4kV0GfoWy/BEW3XcV3iEmNB3KTYypYHg5L+N5
	 3SCyQ/I93PGHJFnLOTEVEQE7J5Z4oLEGhbJ+4qLZ6VgYukR0g1TmxTM2E0T+4bfGwy
	 6e1KH01UQqBoc2jcN8dJ0J+APFe9cVdu32FB4/jRE5vaxOpVQa0DoUP3tFl9Ad7DHt
	 D0MiCoLOBQ4XA==
Date: Tue, 28 Oct 2025 18:04:15 -0700
Subject: [PATCH 19/22] libfuse: create a helper to transform an open regular
 file into an open loopdev
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813877.1427432.9532989557586119853.stgit@frogsfrogsfrogs>
In-Reply-To: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
References: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a helper function to configure a loop device for an open regular
file fd, and then return an open fd to the loop device.  This will
enable the use of fuse+iomap file servers with filesystem image files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_loopdev.h |   27 +++
 include/meson.build    |    4 
 lib/fuse_loopdev.c     |  403 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript |    1 
 lib/meson.build        |    3 
 meson.build            |   11 +
 6 files changed, 448 insertions(+), 1 deletion(-)
 create mode 100644 include/fuse_loopdev.h
 create mode 100644 lib/fuse_loopdev.c


diff --git a/include/fuse_loopdev.h b/include/fuse_loopdev.h
new file mode 100644
index 00000000000000..f09a7dc014df25
--- /dev/null
+++ b/include/fuse_loopdev.h
@@ -0,0 +1,27 @@
+/*  FUSE: Filesystem in Userspace
+  Copyright (C) 2025 Oracle.
+  Author: Darrick J. Wong <djwong@kernel.org>
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file LGPL2.txt.
+*/
+#ifndef FUSE_LOOPDEV_H_
+#define FUSE_LOOPDEV_H_
+
+/**
+ * If possible, set up a loop device for the given file fd.  Return the opened
+ * loop device fd and the path to the loop device.  The loop device will be
+ * removed when the last close() occurs.
+ *
+ * @param file_fd an open file
+ * @param open_flags O_* flags that were used to open file_fd
+ * @param path path to the open file
+ * @param timeout spend this much time waiting to lock the file
+ * @param loop_fd set to an open fd to the new loop device or -1 if inappropriate
+ * @param loop_dev (optional) set to a pointer to the path to the loop device
+ * @return 0 for success, or -1 on error
+ */
+int fuse_loopdev_setup(int file_fd, int open_flags, const char *path,
+		       unsigned int timeout, int *loop_fd, char **loop_dev);
+
+#endif /* FUSE_LOOPDEV_H_ */
diff --git a/include/meson.build b/include/meson.build
index bf671977a5a6a9..0b1e3a9d4fcb43 100644
--- a/include/meson.build
+++ b/include/meson.build
@@ -1,4 +1,8 @@
 libfuse_headers = [ 'fuse.h', 'fuse_common.h', 'fuse_lowlevel.h',
 	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h' ]
 
+if private_cfg.get('FUSE_LOOPDEV_ENABLED')
+  libfuse_headers += [ 'fuse_loopdev.h' ]
+endif
+
 install_headers(libfuse_headers, subdir: 'fuse3')
diff --git a/lib/fuse_loopdev.c b/lib/fuse_loopdev.c
new file mode 100644
index 00000000000000..56b906431a8b48
--- /dev/null
+++ b/lib/fuse_loopdev.c
@@ -0,0 +1,403 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2025 Oracle.
+  Author: Darrick J. Wong <djwong@kernel.org>
+
+  Library functions for handling loopback devices on linux.
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file LGPL2.txt
+*/
+
+#define _GNU_SOURCE
+#include "fuse_config.h"
+#include "fuse_loopdev.h"
+
+#ifdef FUSE_LOOPDEV_ENABLED
+#include <stdint.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <dirent.h>
+#include <signal.h>
+#include <time.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/file.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <linux/loop.h>
+
+#include "fuse_log.h"
+
+#define _PATH_LOOPCTL		"/dev/loop-control"
+#define _PATH_SYS_BLOCK		"/sys/block"
+
+#ifdef STATX_SUBVOL
+# define STATX_SUBVOL_FLAG	STATX_SUBVOL
+#else
+# define STATX_SUBVOL_FLAG	0
+#endif
+
+static int lock_file(int fd, const char *path)
+{
+	int ret;
+
+	ret = flock(fd, LOCK_EX);
+	if (ret) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static double gettime_monotonic(void)
+{
+#ifdef CLOCK_MONOTONIC
+	struct timespec ts;
+#endif
+	struct timeval tv;
+	static double fake_ret = 0;
+	int ret;
+
+#ifdef CLOCK_MONOTONIC
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts);
+	if (ret == 0)
+		return ts.tv_sec + (ts.tv_nsec / 1000000000.0);
+#endif
+	ret = gettimeofday(&tv, NULL);
+	if (ret == 0)
+		return tv.tv_sec + (tv.tv_usec / 1000000.0);
+
+	fake_ret += 1.0;
+	return fake_ret;
+}
+
+static int lock_file_timeout(int fd, const char *path, unsigned int timeout)
+{
+	double deadline, now;
+	int ret;
+
+	now = gettime_monotonic();
+	deadline = now + timeout;
+
+	/* Use a tight sleeping loop here to avoid signal handlers */
+	while (now <= deadline) {
+		ret = flock(fd, LOCK_EX | LOCK_NB);
+		if (ret == 0)
+			return 0;
+		if (errno != EWOULDBLOCK) {
+			fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path,
+				 strerror(errno));
+			return -1;
+		}
+
+		/* sleep 0.1s before trying again */
+		usleep(100000);
+
+		now = gettime_monotonic();
+	}
+
+	fuse_log(FUSE_LOG_DEBUG, "%s: could not lock file\n", path);
+	errno = EWOULDBLOCK;
+	return -1;
+}
+
+static int unlock_file(int fd, const char *path)
+{
+	int ret;
+
+	ret = flock(fd, LOCK_UN);
+	if (ret) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int want_loopdev(int file_fd, const char *path)
+{
+	struct stat statbuf;
+	int ret;
+
+	ret = fstat(file_fd, &statbuf);
+	if (ret < 0) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: fstat failed: %s\n",
+			 path, strerror(errno));
+		return -1;
+	}
+
+	/*
+	 * Keep quiet about block devices, the client can probably still read
+	 * and write that.
+	 */
+	if (S_ISBLK(statbuf.st_mode))
+		return 0;
+
+	ret = S_ISREG(statbuf.st_mode) && statbuf.st_size >= 512;
+	if (!ret)
+		fuse_log(FUSE_LOG_DEBUG,
+			 "%s: file not compatible with loop device\n", path);
+	return ret;
+}
+
+static int same_backing_file(int dir_fd, const char *name,
+			     const struct statx *file_stat)
+{
+	struct statx backing_stat;
+	char backing_name[NAME_MAX + 18 + 1];
+	char path[PATH_MAX + 1];
+	ssize_t bytes;
+	int fd;
+	int ret;
+
+	snprintf(backing_name, sizeof(backing_name), "%s/loop/backing_file",
+			name);
+
+	fd = openat(dir_fd, backing_name, O_RDONLY);
+	if (fd < 0) {
+		/* unconfigured loop devices don't have backing_file attr */
+		if (errno == ENOENT)
+			return 0;
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", backing_name,
+			 strerror(errno));
+		return -1;
+	}
+
+	bytes = pread(fd, path, sizeof(path) - 1, 0);
+	if (bytes < 0) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", backing_name,
+			 strerror(errno));
+		ret = -1;
+		goto out_backing;
+	} else if (bytes == 0) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: no path in backing file?\n",
+			 backing_name);
+		ret = -1;
+		goto out_backing;
+	}
+
+	if (path[bytes - 1] == '\n')
+		path[bytes - 1] = 0;
+
+	ret = statx(AT_FDCWD, path, 0, STATX_BASIC_STATS | STATX_SUBVOL_FLAG,
+			&backing_stat);
+	if (ret) {
+		/*
+		 * backing file deleted, assume nobody's doing procfd
+		 * shenanigans
+		 */
+		if (errno == ENOENT) {
+			ret = 0;
+			goto out_backing;
+		}
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(errno));
+		goto out_backing;
+	}
+
+	/* different devices */
+	if (backing_stat.stx_dev_major != file_stat->stx_dev_major)
+		goto out_backing;
+	if (backing_stat.stx_dev_minor != file_stat->stx_dev_minor)
+		goto out_backing;
+
+	/* different inode number */
+	if (backing_stat.stx_ino != file_stat->stx_ino)
+		goto out_backing;
+
+#ifdef STATX_SUBVOL
+	/* different subvol (or subvol state) */
+	if ((backing_stat.stx_mask ^ file_stat->stx_mask) & STATX_SUBVOL)
+		goto out_backing;
+
+	if ((backing_stat.stx_mask & STATX_SUBVOL) &&
+	    backing_stat.stx_subvol != file_stat->stx_subvol)
+		goto out_backing;
+#endif
+
+	ret = 1;
+
+out_backing:
+	close(fd);
+	return ret;
+}
+
+static int has_existing_loopdev(int file_fd, const char *path)
+{
+	struct statx file_stat;
+	DIR *dir;
+	struct dirent *d;
+	int blockfd;
+	int ret;
+
+	ret = statx(file_fd, "", AT_EMPTY_PATH,
+		    STATX_BASIC_STATS | STATX_SUBVOL_FLAG, &file_stat);
+	if (ret) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", path, strerror(errno));
+		return -1;
+	}
+
+	dir = opendir(_PATH_SYS_BLOCK);
+	if (!dir) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", _PATH_SYS_BLOCK,
+			 strerror(errno));
+		return -1;
+	}
+
+	blockfd = dirfd(dir);
+
+	while ((d = readdir(dir)) != NULL) {
+		if (strcmp(d->d_name, ".") == 0
+		    || strcmp(d->d_name, "..") == 0
+		    || strncmp(d->d_name, "loop", 4) != 0)
+			continue;
+
+		ret = same_backing_file(blockfd, d->d_name, &file_stat);
+		if (ret != 0)
+			break;
+	}
+
+	closedir(dir);
+	return ret;
+}
+
+static int open_loopdev(int file_fd, int open_flags, char *loopdev,
+			size_t loopdev_sz)
+{
+	struct loop_config lc = {
+		.info.lo_flags = LO_FLAGS_DIRECT_IO | LO_FLAGS_AUTOCLEAR,
+	};
+	int ctl_fd = -1;
+	int loop_fd = -1;
+	int loopno;
+	int ret;
+
+	if ((open_flags & O_ACCMODE) == O_RDONLY)
+		lc.info.lo_flags |= LO_FLAGS_READ_ONLY;
+
+	ctl_fd = open(_PATH_LOOPCTL, O_RDONLY);
+	if (ctl_fd < 0) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", _PATH_LOOPCTL,
+			 strerror(errno));
+		return -1;
+	}
+
+	ret = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
+	if (ret < 0) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", _PATH_LOOPCTL,
+			 strerror(errno));
+		goto out_ctl;
+	}
+	loopno = ret;
+	snprintf(loopdev, loopdev_sz, "/dev/loop%d", loopno);
+
+	loop_fd = open(loopdev, open_flags);
+	if (loop_fd < 0) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", loopdev, strerror(errno));
+		ret = -1;
+		goto out_ctl;
+	}
+
+	lc.fd = file_fd;
+
+	ret = ioctl(loop_fd, LOOP_CONFIGURE, &lc);
+	if (ret < 0) {
+		fuse_log(FUSE_LOG_DEBUG, "%s: %s\n", loopdev, strerror(errno));
+		goto out_loop;
+	}
+
+	close(ctl_fd);
+	return loop_fd;
+
+out_loop:
+	ioctl(ctl_fd, LOOP_CTL_REMOVE, loopno);
+	close(loop_fd);
+out_ctl:
+	close(ctl_fd);
+	return ret;
+}
+
+int fuse_loopdev_setup(int file_fd, int open_flags, const char *path,
+		       unsigned int timeout, int *loop_fd, char **loop_dev)
+{
+	char loopdev[PATH_MAX];
+	int loopfd = -1;
+	int ret;
+
+	*loop_fd = -1;
+	if (loop_dev)
+		*loop_dev = NULL;
+
+	if (timeout)
+		ret = lock_file_timeout(file_fd, path, timeout);
+	else
+		ret = lock_file(file_fd, path);
+	if (ret)
+		return ret;
+
+	ret = want_loopdev(file_fd, path);
+	if (ret <= 0)
+		goto out_unlock;
+
+	ret = has_existing_loopdev(file_fd, path);
+	if (ret < 0)
+		goto out_unlock;
+	if (ret == 1) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "%s: attached to another loop device\n", path);
+		ret = -1;
+		errno = EBUSY;
+		goto out_unlock;
+	}
+
+	loopfd = open_loopdev(file_fd, open_flags, loopdev, sizeof(loopdev));
+	if (loopfd < 0)
+		goto out_unlock;
+
+	ret = unlock_file(file_fd, path);
+	if (ret)
+		goto out_loop;
+
+	if (loop_dev) {
+		char *ldev = strdup(loopdev);
+		if (!ldev)
+			goto out_loop;
+
+		*loop_fd = loopfd;
+		*loop_dev = ldev;
+	} else {
+		*loop_fd = loopfd;
+	}
+
+	return 0;
+
+out_loop:
+	close(loopfd);
+out_unlock:
+	unlock_file(file_fd, path);
+	return ret;
+}
+#else
+#include <stdlib.h>
+
+#include "util.h"
+
+int fuse_loopdev_setup(int file_fd FUSE_VAR_UNUSED,
+		       int open_flags FUSE_VAR_UNUSED,
+		       const char *path FUSE_VAR_UNUSED,
+		       unsigned int timeout FUSE_VAR_UNUSED,
+		       int *loop_fd, char **loop_dev)
+{
+	*loop_fd = -1;
+	if (loop_dev)
+		*loop_dev = NULL;
+	return 0;
+}
+#endif /* FUSE_LOOPDEV_ENABLED */
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index a275b53c6f9f1a..32dc681bf518d0 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -236,6 +236,7 @@ FUSE_3.99 {
 		fuse_reply_iomap_config;
 		fuse_lowlevel_iomap_device_invalidate;
 		fuse_fs_iomap_device_invalidate;
+		fuse_loopdev_setup;
 } FUSE_3.18;
 
 # Local Variables:
diff --git a/lib/meson.build b/lib/meson.build
index 8efe71abfabc9e..608777693ae4d9 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -2,7 +2,8 @@ libfuse_sources = ['fuse.c', 'fuse_i.h', 'fuse_loop.c', 'fuse_loop_mt.c',
                    'fuse_lowlevel.c', 'fuse_misc.h', 'fuse_opt.c',
                    'fuse_signals.c', 'buffer.c', 'cuse_lowlevel.c',
                    'helper.c', 'modules/subdir.c', 'mount_util.c',
-                   'fuse_log.c', 'compat.c', 'util.c', 'util.h' ]
+                   'fuse_log.c', 'compat.c', 'util.c', 'util.h',
+                   'fuse_loopdev.c' ]
 
 if host_machine.system().startswith('linux')
    libfuse_sources += [ 'mount.c' ]
diff --git a/meson.build b/meson.build
index 8359a489c351b9..73aee98c775a2a 100644
--- a/meson.build
+++ b/meson.build
@@ -153,7 +153,18 @@ private_cfg.set('HAVE_STRUCT_STAT_ST_ATIMESPEC',
     cc.has_member('struct stat', 'st_atimespec',
                   prefix: include_default + '#include <sys/stat.h>',
                   args: args_default))
+private_cfg.set('HAVE_STRUCT_LOOP_CONFIG_INFO',
+    cc.has_member('struct loop_config', 'info',
+                  prefix: include_default + '#include <linux/loop.h>',
+                  args: args_default))
+private_cfg.set('HAVE_STATX_BASIC_STATS',
+    cc.has_member('struct statx', 'stx_ino',
+                  prefix: include_default + '#include <sys/stat.h>',
+                  args: args_default))
 
+private_cfg.set('FUSE_LOOPDEV_ENABLED', \
+    private_cfg.get('HAVE_STRUCT_LOOP_CONFIG_INFO') and \
+    private_cfg.get('HAVE_STATX_BASIC_STATS'))
 private_cfg.set('USDT_ENABLED', get_option('enable-usdt'))
 
 # Check for liburing with SQE128 support


