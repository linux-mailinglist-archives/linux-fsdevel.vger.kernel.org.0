Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809322B3427
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgKOKrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 05:47:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59678 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgKOKqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:46:49 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1keFSB-0000Kt-Fz; Sun, 15 Nov 2020 10:40:15 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 39/39] tests: add vfs/idmapped mounts test suite
Date:   Sun, 15 Nov 2020 11:37:18 +0100
Message-Id: <20201115103718.298186-40-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103718.298186-1-christian.brauner@ubuntu.com>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a whole test suite for idmapped mounts but in order to ensure that
there are no regression for the vfs itself it also includes tests for correct
functionality on non-idmapped mounts. The following tests are currently
available with more to come in the future:

01. create_delete_rename: test that basic file interactions work for idmapped mounts
02. create_delete_rename_userns: test that basic file interactions work for
    idmapped mounts from within user namespaces
03. hardlinks: verify that hardlinks work correctly
04. rename: verity tat rename works correctly
05. create_userns: verify that file creation in user namespaces works from idmapped mounts
06. create_userns_device_node: verify that device node creation fails inside user
    namespace from idmapped mounts.
07. expected_uid_gid: verify that file ownership works correctly on idmapped mounts
08. expected_uid_gid_userns: verify that file ownership works correctly on
    idmapped mounts inside user namespaces
09. expected_fscaps_userns: verify that filesystem capabilities work correctly on
    idmapped mounts and inside user namespaces
10. expected_fscaps_reverse: verify that filesystem capabilities work correctly
    on idmapped mounts and inside user namespaces where we map from unprivileged
    ids to privileged ids
11. setid_binaries: verify that suid and sgid binaries work correctly on idmapped mounts
12. setid_binaries_reverse: verify that suid and sgid binaries work correctly on
    idmapped mounts where we map from unprivileged ids to privileged ids
13. setid_binaries_userns: verify that suid and sgid binaries work correctly on
    idmapped mounts inside user namespaces
14. idmap_mount_tree: verify that idmapping a whole mount tree works correctly
15. idmap_mount_tree_invalid: verify that idmapping a mount tree with a mount of
    a filesystem that doesn't support being idmapped yet fails
16. sticky_bit_unlink: verify that unlinking in sticky directories works correctly
17. sticky_bit_unlink_idmapped: verify that unlinking in sticky directories works
    correctly on idmapped mounts
18. sticky_bit_unlink_idmapped_userns: verify that unlinking in sticky directories works
    correctly on idmapped mounts inside user namespaces
19. sticky_bit_rename_idmapped: verify that renaminging in sticky directories works
    correctly on idmapped mounts
20. sticky_bit_rename_idmapped_userns: verify that renaming in sticky directories works
    correctly on idmapped mounts inside user namespaces
21. follow_symlinks: test that following protected symlinks works correctly
22. follow_symlinks_idmapped: test that following symlinks works correctly on idmapped mounts
23. follow_symlinks_idmapped_userns: test that following symlinks works correctly
    on idmapped mounts inside user namespaces
24. invalid_fd_negative: test that negative fds are rejected when idmapping mounts
25. invalid_fd_large: test that excessively large fds are rejected when idmappings mounts
26. invalid_fd_closed: test that closed fds are rejected when idmapping mounts
27. invalid_fd_initial_userns: test that fds referencing the initial user namespace are rejected
28. attached_mount_inside_current_mount_namespace: test that attached mounts can be idmapped
29. attached_mount_outside_current_mount_namespace: test that attached mounts
    can't be idmapped if we are in a different user namespace
30. detached_mount_inside_current_mount_namespace: test that detached mounts can be idmapped
31. detached_mount_outside_current_mount_namespace: test that detached mounts can
    be idmapped outside of our current user namespace
32. change_idmapping: test that idmapped mounts can't be changed

Output:
 TAP version 13
 1..33
 # Starting 33 tests from 2 test cases.
 #  RUN           core.invalid_fd_negative ...
 #            OK  core.invalid_fd_negative
 ok 1 core.invalid_fd_negative
 #  RUN           core.invalid_fd_large ...
 #            OK  core.invalid_fd_large
 ok 2 core.invalid_fd_large
 #  RUN           core.invalid_fd_closed ...
 #            OK  core.invalid_fd_closed
 ok 3 core.invalid_fd_closed
 #  RUN           core.invalid_fd_initial_userns ...
 #            OK  core.invalid_fd_initial_userns
 ok 4 core.invalid_fd_initial_userns
 #  RUN           core.attached_mount_inside_current_mount_namespace ...
 #            OK  core.attached_mount_inside_current_mount_namespace
 ok 5 core.attached_mount_inside_current_mount_namespace
 #  RUN           core.attached_mount_outside_current_mount_namespace ...
 #            OK  core.attached_mount_outside_current_mount_namespace
 ok 6 core.attached_mount_outside_current_mount_namespace
 #  RUN           core.detached_mount_inside_current_mount_namespace ...
 #            OK  core.detached_mount_inside_current_mount_namespace
 ok 7 core.detached_mount_inside_current_mount_namespace
 #  RUN           core.detached_mount_outside_current_mount_namespace ...
 #            OK  core.detached_mount_outside_current_mount_namespace
 ok 8 core.detached_mount_outside_current_mount_namespace
 #  RUN           core.change_idmapping ...
 #            OK  core.change_idmapping
 ok 9 core.change_idmapping
 #  RUN           core.create_delete_rename ...
 #            OK  core.create_delete_rename
 ok 10 core.create_delete_rename
 #  RUN           core.create_delete_rename_userns ...
 #            OK  core.create_delete_rename_userns
 ok 11 core.create_delete_rename_userns
 #  RUN           core.hardlinks ...
 #            OK  core.hardlinks
 ok 12 core.hardlinks
 #  RUN           core.rename ...
 #            OK  core.rename
 ok 13 core.rename
 #  RUN           core.create_userns ...
 #            OK  core.create_userns
 ok 14 core.create_userns
 #  RUN           core.create_userns_device_node ...
 #            OK  core.create_userns_device_node
 ok 15 core.create_userns_device_node
 #  RUN           core.expected_uid_gid ...
 #            OK  core.expected_uid_gid
 ok 16 core.expected_uid_gid
 #  RUN           core.expected_uid_gid_userns ...
 #            OK  core.expected_uid_gid_userns
 ok 17 core.expected_uid_gid_userns
 #  RUN           core.expected_fscaps_userns ...
 #            OK  core.expected_fscaps_userns
 ok 18 core.expected_fscaps_userns
 #  RUN           core.expected_fscaps_reverse ...
 #            OK  core.expected_fscaps_reverse
 ok 19 core.expected_fscaps_reverse
 #  RUN           core.setid_binaries ...
 #            OK  core.setid_binaries
 ok 20 core.setid_binaries
 #  RUN           core.setid_binaries_reverse ...
 #            OK  core.setid_binaries_reverse
 ok 21 core.setid_binaries_reverse
 #  RUN           core.setid_binaries_userns ...
 #            OK  core.setid_binaries_userns
 ok 22 core.setid_binaries_userns
 #  RUN           core.idmap_mount_tree ...
 #            OK  core.idmap_mount_tree
 ok 23 core.idmap_mount_tree
 #  RUN           core.idmap_mount_tree_invalid ...
 #            OK  core.idmap_mount_tree_invalid
 ok 24 core.idmap_mount_tree_invalid
 #  RUN           core.sticky_bit_unlink ...
 #            OK  core.sticky_bit_unlink
 ok 25 core.sticky_bit_unlink
 #  RUN           core.sticky_bit_unlink_idmapped ...
 #            OK  core.sticky_bit_unlink_idmapped
 ok 26 core.sticky_bit_unlink_idmapped
 #  RUN           core.sticky_bit_unlink_idmapped_userns ...
 #            OK  core.sticky_bit_unlink_idmapped_userns
 ok 27 core.sticky_bit_unlink_idmapped_userns
 #  RUN           core.sticky_bit_rename ...
 #            OK  core.sticky_bit_rename
 ok 28 core.sticky_bit_rename
 #  RUN           core.sticky_bit_rename_idmapped ...
 #            OK  core.sticky_bit_rename_idmapped
 ok 29 core.sticky_bit_rename_idmapped
 #  RUN           core.sticky_bit_rename_idmapped_userns ...
 #            OK  core.sticky_bit_rename_idmapped_userns
 ok 30 core.sticky_bit_rename_idmapped_userns
 #  RUN           core.follow_symlinks ...
 #            OK  core.follow_symlinks
 ok 31 core.follow_symlinks
 #  RUN           core.follow_symlinks_idmapped ...
 #            OK  core.follow_symlinks_idmapped
 ok 32 core.follow_symlinks_idmapped
 #  RUN           core.follow_symlinks_idmapped_userns ...
 #            OK  core.follow_symlinks_idmapped_userns
 ok 33 core.follow_symlinks_idmapped_userns
 # PASSED: 33 / 33 tests passed.
 # Totals: pass:33 fail:0 xfail:0 xpass:0 skip:0 error:0

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch introduced
---
 .../testing/selftests/idmap_mounts/.gitignore |    1 +
 tools/testing/selftests/idmap_mounts/Makefile |    7 +-
 tools/testing/selftests/idmap_mounts/core.c   | 3476 +++++++++++++++++
 .../testing/selftests/idmap_mounts/internal.h |   33 +-
 tools/testing/selftests/idmap_mounts/utils.c  |  136 +
 tools/testing/selftests/idmap_mounts/utils.h  |   17 +
 tools/testing/selftests/idmap_mounts/xattr.c  |  126 +-
 7 files changed, 3664 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/idmap_mounts/core.c
 create mode 100644 tools/testing/selftests/idmap_mounts/utils.c
 create mode 100644 tools/testing/selftests/idmap_mounts/utils.h

diff --git a/tools/testing/selftests/idmap_mounts/.gitignore b/tools/testing/selftests/idmap_mounts/.gitignore
index 18c5e90522ad..03c7198482d2 100644
--- a/tools/testing/selftests/idmap_mounts/.gitignore
+++ b/tools/testing/selftests/idmap_mounts/.gitignore
@@ -1 +1,2 @@
+core
 xattr
diff --git a/tools/testing/selftests/idmap_mounts/Makefile b/tools/testing/selftests/idmap_mounts/Makefile
index 1d495c99d924..67697b788353 100644
--- a/tools/testing/selftests/idmap_mounts/Makefile
+++ b/tools/testing/selftests/idmap_mounts/Makefile
@@ -1,9 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
 CFLAGS = -g -I../../../../usr/include/ -Wall -O2 -pthread
+LDLIBS += -lcap
 
-TEST_GEN_FILES += xattr
+TEST_GEN_FILES = xattr
+TEST_GEN_FILES += core
 
 include ../lib.mk
 
-$(OUTPUT)/xattr: xattr.c internal.h
+$(OUTPUT)/xattr: xattr.c internal.h utils.c utils.h
+$(OUTPUT)/core: core.c internal.h utils.c utils.h
diff --git a/tools/testing/selftests/idmap_mounts/core.c b/tools/testing/selftests/idmap_mounts/core.c
new file mode 100644
index 000000000000..23909a55beb8
--- /dev/null
+++ b/tools/testing/selftests/idmap_mounts/core.c
@@ -0,0 +1,3476 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <grp.h>
+#include <limits.h>
+#include <linux/capability.h>
+#include <sys/capability.h>
+#include <linux/limits.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <sys/fsuid.h>
+#include <sys/sysmacros.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/acl.h>
+#include <sys/xattr.h>
+
+#include "internal.h"
+#include "utils.h"
+#include "../kselftest_harness.h"
+
+#define IMAGE_FILE1 "ext4_1.img"
+#define IMAGE_FILE2 "ext4_2.img"
+#define IMAGE_ROOT_MNT1 "mnt_root_1"
+#define IMAGE_ROOT_MNT2_RELATIVE "mnt_root_2"
+#define IMAGE_ROOT_MNT2 IMAGE_ROOT_MNT1 "/" IMAGE_ROOT_MNT2_RELATIVE
+#define FILESYSTEM_MOUNT1 IMAGE_ROOT_MNT2 "/fs_root_1"
+#define MNT_TARGET1 "mnt_target1"
+#define MNT_TARGET2 "mnt_target2"
+#define FILE1 "file1"
+#define FILE1_RENAME "file1_rename"
+#define FILE2 "file2"
+#define FILE2_RENAME "file2_rename"
+#define DIR1 "dir1"
+#define DIR1_RENAME "dir1_rename"
+#define HARDLINK1 "hardlink1"
+#define SYMLINK1 "symlink1"
+#define SYMLINK_USER1 "symlink_user1"
+#define SYMLINK_USER2 "symlink_user2"
+#define SYMLINK_USER3 "symlink_user3"
+#define CHRDEV1 "chrdev1"
+
+/* Attempt to de-conflict with the selftests tree. */
+#ifndef SKIP
+#define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
+#endif
+
+static bool symlinks_protected(void)
+{
+	int fd;
+	ssize_t ret;
+	char buf[256];
+
+	fd = open("/proc/sys/fs/protected_symlinks", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return false;
+
+	ret = read(fd, buf, sizeof(buf));
+	close(fd);
+	if (ret < sizeof(int))
+		return false;
+
+	return atoi(buf) >= 1;
+}
+
+/**
+ * caps_down - lower all effective caps
+ */
+static bool caps_down(void)
+{
+	cap_t caps = NULL;
+	int ret = -1;
+	bool fret = false;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	ret = cap_clear_flag(caps, CAP_EFFECTIVE);
+	if (ret)
+		goto out;
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+
+out:
+	cap_free(caps);
+	return fret;
+}
+
+/**
+ * expected_uid_gid - check whether file is owned by the provided uid and gid
+ */
+static bool expected_uid_gid(int dfd, const char *path, int flags,
+			     uid_t expected_uid, gid_t expected_gid)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	return st.st_uid == expected_uid && st.st_gid == expected_gid;
+}
+
+/**
+ * is_setid - check whether file is S_ISUID and S_ISGID
+ */
+static bool is_setid(int dfd, const char *path, int flags)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	return (st.st_mode & S_ISUID) || (st.st_mode & S_ISGID);
+}
+
+/**
+ * is_sticky - check whether file is S_ISUID and S_ISGID
+ */
+static bool is_sticky(int dfd, const char *path, int flags)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	return (st.st_mode & S_ISVTX) > 0;
+}
+
+/**
+ * rm_r - recursively remove all files
+ */
+static int rm_r(const char *dirname)
+{
+	DIR *dir;
+	int ret;
+	struct dirent *direntp;
+
+	dir = opendir(dirname);
+	if (!dir)
+		return -1;
+
+	while ((direntp = readdir(dir))) {
+		char buf[PATH_MAX];
+		struct stat st;
+
+		if (!strcmp(direntp->d_name, ".") ||
+		    !strcmp(direntp->d_name, ".."))
+			continue;
+
+		snprintf(buf, sizeof(buf), "%s/%s", dirname, direntp->d_name);
+		ret = lstat(buf, &st);
+		if (ret < 0 && errno != ENOENT)
+			break;
+
+		if (S_ISDIR(st.st_mode))
+			ret = rm_r(buf);
+		else
+			ret = unlink(buf);
+		if (ret < 0 && errno != ENOENT)
+			break;
+	}
+
+	ret = rmdir(dirname);
+	closedir(dir);
+	return ret;
+}
+
+/**
+ * umount_r - recursively umount all mounts
+ */
+static void umount_r(const char *path)
+{
+	DIR *dir;
+	int ret;
+	struct dirent *direntp;
+
+	dir = opendir(path);
+	if (!dir)
+		return;
+
+	while ((direntp = readdir(dir))) {
+		char buf[PATH_MAX];
+		struct stat st;
+
+		if (!strcmp(direntp->d_name, ".") ||
+		    !strcmp(direntp->d_name, ".."))
+			continue;
+
+		snprintf(buf, sizeof(buf), "%s/%s", path, direntp->d_name);
+		umount2(buf, MNT_DETACH);
+
+		ret = lstat(buf, &st);
+		if (ret < 0 && errno != ENOENT)
+			break;
+
+		if (!S_ISDIR(st.st_mode))
+			continue;
+
+		umount_r(buf);
+	}
+
+	umount2(path, MNT_DETACH);
+	closedir(dir);
+}
+
+/**
+ * chown_r - recursively change ownership of all files
+ */
+static int chown_r(const char *dirname, uid_t uid, gid_t gid)
+{
+	DIR *dir;
+	int ret;
+	struct dirent *direntp;
+
+	dir = opendir(dirname);
+	if (!dir)
+		return -1;
+
+	while ((direntp = readdir(dir))) {
+		char buf[PATH_MAX];
+		struct stat st;
+
+		if (!strcmp(direntp->d_name, ".") ||
+		    !strcmp(direntp->d_name, ".."))
+			continue;
+
+		snprintf(buf, sizeof(buf), "%s/%s", dirname, direntp->d_name);
+		ret = lstat(buf, &st);
+		if (ret < 0 && errno != ENOENT)
+			break;
+
+		if (S_ISDIR(st.st_mode))
+			ret = chown_r(buf, uid, gid);
+		else
+			ret = chown(buf, uid, gid);
+		if (ret < 0 && errno != ENOENT)
+			break;
+	}
+
+	ret = chown(dirname, uid, gid);
+	closedir(dir);
+	return ret;
+}
+
+/**
+ * fd_to_fd - transfer data from one fd to another
+ */
+static int fd_to_fd(int from, int to)
+{
+	for (;;) {
+		uint8_t buf[PATH_MAX];
+		uint8_t *p = buf;
+		ssize_t bytes_to_write;
+		ssize_t bytes_read;
+
+		bytes_read = read_nointr(from, buf, sizeof buf);
+		if (bytes_read < 0)
+			return -1;
+		if (bytes_read == 0)
+			break;
+
+		bytes_to_write = (size_t)bytes_read;
+		do {
+			ssize_t bytes_written;
+
+			bytes_written = write_nointr(to, p, bytes_to_write);
+			if (bytes_written < 0)
+				return -1;
+
+			bytes_to_write -= bytes_written;
+			p += bytes_written;
+		} while (bytes_to_write > 0);
+	}
+
+	return 0;
+}
+
+static int sys_execveat(int fd, const char *path, char **argv, char **envp,
+			int flags)
+{
+#ifdef __NR_execveat
+	return syscall(__NR_execveat, fd, path, argv, envp, flags);
+#else
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
+#ifndef VFS_CAP_U32_3
+#define VFS_CAP_U32_3 2
+#endif
+
+#ifndef VFS_CAP_U32
+#define VFS_CAP_U32 VFS_CAP_U32_3
+#endif
+
+#ifndef VFS_CAP_REVISION_1
+#define VFS_CAP_REVISION_1 0x01000000
+#endif
+
+#ifndef VFS_CAP_REVISION_2
+#define VFS_CAP_REVISION_2 0x02000000
+#endif
+
+#ifndef VFS_CAP_REVISION_3
+#define VFS_CAP_REVISION_3 0x03000000
+struct vfs_ns_cap_data {
+	__le32 magic_etc;
+	struct {
+		__le32 permitted;
+		__le32 inheritable;
+	} data[VFS_CAP_U32];
+	__le32 rootid;
+};
+#endif
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+#define cpu_to_le16(w16) le16_to_cpu(w16)
+#define le16_to_cpu(w16) ((u_int16_t)((u_int16_t)(w16) >> 8) | (u_int16_t)((u_int16_t)(w16) << 8))
+#define cpu_to_le32(w32) le32_to_cpu(w32)
+#define le32_to_cpu(w32)                                                                       \
+	((u_int32_t)((u_int32_t)(w32) >> 24) | (u_int32_t)(((u_int32_t)(w32) >> 8) & 0xFF00) | \
+	 (u_int32_t)(((u_int32_t)(w32) << 8) & 0xFF0000) | (u_int32_t)((u_int32_t)(w32) << 24))
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+#define cpu_to_le16(w16) ((u_int16_t)(w16))
+#define le16_to_cpu(w16) ((u_int16_t)(w16))
+#define cpu_to_le32(w32) ((u_int32_t)(w32))
+#define le32_to_cpu(w32) ((u_int32_t)(w32))
+#else
+#error Expected endianess macro to be set
+#endif
+
+/**
+ * expected_dummy_vfs_caps_uid - check vfs caps are stored with the provided uid
+ */
+static bool expected_dummy_vfs_caps_uid(int fd, uid_t expected_uid)
+{
+#define __cap_raised_permitted(x, ns_cap_data)                                 \
+	((ns_cap_data.data[(x) >> 5].permitted) & (1 << ((x)&31)))
+	struct vfs_ns_cap_data ns_xattr = {};
+	ssize_t ret;
+
+	ret = fgetxattr(fd, "security.capability", &ns_xattr, sizeof(ns_xattr));
+	if (ret < 0 || ret == 0)
+		return false;
+
+	if (ns_xattr.magic_etc & VFS_CAP_REVISION_3)
+		return (le32_to_cpu(ns_xattr.rootid) == expected_uid) && (__cap_raised_permitted(CAP_NET_RAW, ns_xattr) > 0);
+
+	return false;
+}
+
+/**
+ * set_dummy_vfs_caps - set dummy vfs caps for the provided uid
+ */
+static int set_dummy_vfs_caps(int fd, int flags, int rootuid)
+{
+#define __raise_cap_permitted(x, ns_cap_data)                                  \
+	ns_cap_data.data[(x) >> 5].permitted |= (1 << ((x)&31))
+
+	struct vfs_ns_cap_data ns_xattr;
+
+	memset(&ns_xattr, 0, sizeof(ns_xattr));
+	__raise_cap_permitted(CAP_NET_RAW, ns_xattr);
+	ns_xattr.magic_etc |= VFS_CAP_REVISION_3 | VFS_CAP_FLAGS_EFFECTIVE;
+	ns_xattr.rootid = cpu_to_le32(rootuid);
+
+	return fsetxattr(fd, "security.capability",
+			 &ns_xattr, sizeof(ns_xattr), flags);
+}
+
+FIXTURE(core)
+{
+	/* fd for the main test directory */
+	int test_dir_fd;
+	/* the absolute path to the main test directory */
+	char test_dir_path[PATH_MAX];
+
+	/* fd for test test filesystem image */
+	int img_fd;
+	/* fd for the mountpoint of the test fs image */
+	int img_mnt_fd;
+
+	/* temporary buffer */
+	char cmdline[3 * PATH_MAX];
+
+	/* open_tree fd for the mountpoint of the test fs image */
+	int target1_mnt_fd_attached;
+
+	/* detached open_tree fd for the mountpoint of the test fs image */
+	int target1_mnt_fd_detached;
+};
+
+FIXTURE_SETUP(core)
+{
+	struct mount_attr attr = {
+		.attr_set	= 0,
+		.attr_clr	= 0,
+		.propagation	= MAKE_PROPAGATION_PRIVATE,
+	};
+
+	self->img_fd = -EBADF;
+	self->img_mnt_fd = -EBADF;
+
+	/* create separate mount namespace with mount propagation turned off */
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(sys_mount_setattr(-1, "/", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	/* create unique test directory */
+	snprintf(self->test_dir_path, sizeof(self->test_dir_path),
+		 "/idmap_mount_core_XXXXXX");
+	ASSERT_NE(mkdtemp(self->test_dir_path), NULL);
+	self->test_dir_fd = open(self->test_dir_path, O_CLOEXEC | O_DIRECTORY);
+	ASSERT_GE(self->test_dir_fd, 0);
+	ASSERT_EQ(fchmod(self->test_dir_fd, 0777), 0);
+
+	/* create filesystem image */
+	self->img_fd = openat(self->test_dir_fd, IMAGE_FILE1, O_CREAT | O_WRONLY, 0600);
+	ASSERT_GE(self->img_fd, 0);
+	ASSERT_EQ(ftruncate(self->img_fd, 1024 * 2048), 0);
+	snprintf(self->cmdline, sizeof(self->cmdline),
+		 "mkfs.ext4 -q %s/" IMAGE_FILE1, self->test_dir_path);
+	ASSERT_EQ(system(self->cmdline), 0);
+
+	/* create mountpoint for image */
+	ASSERT_EQ(mkdirat(self->test_dir_fd, IMAGE_ROOT_MNT1, 0777), 0);
+
+	/* mount image */
+	snprintf(self->cmdline, sizeof(self->cmdline),
+		 "mount -o loop -t ext4 %s/" IMAGE_FILE1 " %s/" IMAGE_ROOT_MNT1,
+		 self->test_dir_path, self->test_dir_path);
+	ASSERT_EQ(system(self->cmdline), 0);
+
+	/* stash fd for the image mountpoint */
+	self->img_mnt_fd = openat(self->test_dir_fd, IMAGE_ROOT_MNT1, O_DIRECTORY | O_CLOEXEC, 0);
+	ASSERT_GE(self->img_mnt_fd, 0);
+
+	/* create mountpoint for bind-mount */
+	ASSERT_EQ(mkdirat(self->test_dir_fd, MNT_TARGET1, 0777), 0);
+
+	/* create new detached mount from image mountpoint */
+	self->target1_mnt_fd_detached = sys_open_tree(self->test_dir_fd,
+						      IMAGE_ROOT_MNT1,
+						      AT_NO_AUTOMOUNT |
+						      AT_SYMLINK_NOFOLLOW |
+						      OPEN_TREE_CLOEXEC |
+						      OPEN_TREE_CLONE);
+	ASSERT_GE(self->target1_mnt_fd_detached, 0);
+
+	/* create attached mount from image mountpoint */
+	self->target1_mnt_fd_attached = sys_open_tree(self->test_dir_fd,
+						      IMAGE_ROOT_MNT1,
+						      AT_NO_AUTOMOUNT |
+						      AT_SYMLINK_NOFOLLOW |
+						      OPEN_TREE_CLOEXEC);
+	ASSERT_GE(self->target1_mnt_fd_attached, 0);
+}
+
+FIXTURE_TEARDOWN(core)
+{
+	EXPECT_EQ(close(self->test_dir_fd), 0);
+	EXPECT_EQ(close(self->img_fd), 0);
+	EXPECT_EQ(close(self->img_mnt_fd), 0);
+	EXPECT_EQ(close(self->target1_mnt_fd_attached), 0);
+	EXPECT_EQ(close(self->target1_mnt_fd_detached), 0);
+	umount_r(self->test_dir_path);
+	rm_r(self->test_dir_path);
+}
+
+/**
+ * Validate that negative fd values are rejected.
+ */
+TEST_F(core, invalid_fd_negative)
+{
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= -EBADF,
+	};
+
+	ASSERT_NE(sys_mount_setattr(-1, "/", 0, &attr, sizeof(attr)), 0) {
+		TH_LOG("failure: created idmapped mount with negative fd");
+	}
+}
+
+/**
+ * Validate that excessively large fd values are rejected.
+ */
+TEST_F(core, invalid_fd_large)
+{
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= INT64_MAX,
+	};
+
+	ASSERT_NE(sys_mount_setattr(-1, "/", 0, &attr, sizeof(attr)), 0) {
+		TH_LOG("failure: created idmapped mount with too large fd value");
+	}
+}
+
+/**
+ * Validate that closed fd values are rejected.
+ */
+TEST_F(core, invalid_fd_closed)
+{
+	int fd;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_GE(close(fd), 0);
+
+	attr.userns_fd = fd;
+	ASSERT_NE(sys_mount_setattr(-1, "/", 0, &attr, sizeof(attr)), 0) {
+		TH_LOG("failure: created idmapped mount with closed fd");
+	}
+}
+
+/**
+ * Validate that the initial user namespace is rejected.
+ */
+TEST_F(core, invalid_fd_initial_userns)
+{
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	attr.userns_fd = open("/proc/1/ns/user", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_NE(sys_mount_setattr(-1, "/", 0, &attr, sizeof(attr)), 0) {
+		TH_LOG("failure: created idmapped mount with initial user namespace");
+	}
+	ASSERT_EQ(errno, EPERM);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that an attached mount in our mount namespace can be idmapped.
+ * (The kernel enforces that the mount's mount namespace and the caller's mount
+ *  namespace match.)
+ */
+TEST_F(core, attached_mount_inside_current_mount_namespace)
+{
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_attached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_attached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that idmapping a mount is rejected if the mount's mount namespace
+ * and our mount namespace don't match.
+ * (The kernel enforces that the mount's mount namespace and the caller's mount
+ *  namespace match.)
+ */
+TEST_F(core, attached_mount_outside_current_mount_namespace)
+{
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_NE(sys_mount_setattr(self->target1_mnt_fd_attached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: managed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_attached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that an attached mount in our mount namespace can be idmapped.
+ */
+TEST_F(core, detached_mount_inside_current_mount_namespace)
+{
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that a detached mount not in our mount namespace can be idmapped.
+ */
+TEST_F(core, detached_mount_outside_current_mount_namespace)
+{
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that currently changing the idmapping of an idmapped mount fails.
+ */
+TEST_F(core, change_idmapping)
+{
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+
+	/* Change idmapping on a detached mount that is already idmapped. */
+	attr.userns_fd	= get_userns_fd(0, 20000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_NE(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("failure: managed to change idmapping of already idmapped mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that basic file operations on idmapped mounts.
+ */
+TEST_F(core, create_delete_rename)
+{
+	int file1_fd = -EBADF, hardlink_target_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create hardlink target */
+	hardlink_target_fd = openat(self->img_mnt_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	ASSERT_GE(hardlink_target_fd, 0);
+	ASSERT_EQ(close(hardlink_target_fd), 0);
+
+	/* create directory for rename test */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0700), 0);
+
+	/* change ownership of all files to uid 0 */
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" IMAGE_ROOT_MNT1,
+		 self->test_dir_path);
+	ASSERT_EQ(chown_r(self->cmdline, 0, 0), 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+
+	/*
+	 * The caller's fsids don't have a mappings in the idmapped mount so
+	 * any file creation must fail.
+	 */
+
+	/* create hardlink */
+	ASSERT_NE(linkat(self->target1_mnt_fd_detached, FILE1, self->target1_mnt_fd_detached, HARDLINK1, 0), 0);
+	ASSERT_EQ(errno, EOVERFLOW);
+
+	/* try to rename a file */
+	ASSERT_NE(renameat2(self->target1_mnt_fd_detached, FILE1,
+			    self->target1_mnt_fd_detached, FILE1_RENAME, 0), 0);
+	ASSERT_EQ(errno, EOVERFLOW);
+
+	/* try to rename a directory */
+	ASSERT_NE(renameat2(self->target1_mnt_fd_detached, DIR1,
+			    self->target1_mnt_fd_detached, DIR1_RENAME, 0), 0);
+	ASSERT_EQ(errno, EOVERFLOW);
+
+	/*
+	 * The caller is privileged over the inode so file deletion must work.
+	 */
+
+	/* remove file */
+	ASSERT_EQ(unlinkat(self->target1_mnt_fd_detached, FILE1, 0), 0);
+
+	/* remove directory */
+	ASSERT_EQ(unlinkat(self->target1_mnt_fd_detached, DIR1, AT_REMOVEDIR), 0);
+
+	/*
+	 * The caller's fsids don't have a mappings in the idmapped mount so
+	 * any file creation must fail.
+	 */
+
+	/* create regular file via open() */
+	file1_fd = openat(self->target1_mnt_fd_detached, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	ASSERT_LT(file1_fd, 0);
+	ASSERT_EQ(errno, EOVERFLOW);
+
+	/* create regular file via mknod */
+	ASSERT_NE(mknodat(self->target1_mnt_fd_detached, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(errno, EOVERFLOW);
+
+	/* create character device */
+	ASSERT_NE(mknodat(self->target1_mnt_fd_detached, CHRDEV1, S_IFCHR | 0644,
+			  makedev(5, 1)), 0);
+	ASSERT_EQ(errno, EOVERFLOW);
+
+	/* create symlink */
+	ASSERT_NE(symlinkat(FILE2, self->target1_mnt_fd_detached, SYMLINK1), 0);
+	ASSERT_EQ(errno, EOVERFLOW);
+
+	/* create directory */
+	ASSERT_NE(mkdirat(self->target1_mnt_fd_detached, DIR1, 0700), 0);
+	ASSERT_EQ(errno, EOVERFLOW);
+}
+
+/**
+ * Validate that basic file operations on idmapped mounts from a user
+ * namespace.
+ */
+TEST_F(core, create_delete_rename_userns)
+{
+	int file1_fd = -EBADF;
+	pid_t pid;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* change ownership of all files to uid 0 */
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" IMAGE_ROOT_MNT1,
+		 self->test_dir_path);
+	ASSERT_EQ(chown_r(self->cmdline, 0, 0), 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* Switch to  user namespace where uid 10000 maps to 0. */
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(0, 0, 0), 0);
+		ASSERT_EQ(setresuid(0, 0, 0), 0);
+
+		/* create regular file via open() */
+		file1_fd = openat(self->target1_mnt_fd_detached,
+				  FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+		ASSERT_GT(file1_fd, 0);
+		ASSERT_EQ(close(file1_fd), 0);
+
+		/* create regular file via mknod */
+		ASSERT_EQ(mknodat(self->target1_mnt_fd_detached,
+				  FILE2, S_IFREG | 0000, 0), 0);
+
+		/* create symlink */
+		ASSERT_EQ(symlinkat(FILE2, self->target1_mnt_fd_detached,
+				    SYMLINK1), 0);
+
+		/* create directory */
+		ASSERT_EQ(mkdirat(self->target1_mnt_fd_detached,
+				  DIR1, 0700), 0);
+
+		/* try to rename a file */
+		ASSERT_EQ(renameat2(self->target1_mnt_fd_detached, FILE1,
+				    self->target1_mnt_fd_detached, FILE1_RENAME,
+				    0), 0);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   FILE1_RENAME, 0, 0, 0), true);
+
+		/* try to rename a file */
+		ASSERT_EQ(renameat2(self->target1_mnt_fd_detached, DIR1,
+				    self->target1_mnt_fd_detached, DIR1_RENAME,
+				    0), 0);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   DIR1_RENAME, 0, 0, 0), true);
+
+		/* remove file */
+		ASSERT_EQ(unlinkat(self->target1_mnt_fd_detached,
+				   FILE1_RENAME, 0), 0);
+
+		/* remove directory */
+		ASSERT_EQ(unlinkat(self->target1_mnt_fd_detached,
+				   DIR1_RENAME, AT_REMOVEDIR), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+TEST_F(core, hardlinks)
+{
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr1 = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	struct mount_attr attr2 = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	file1_fd = openat(self->img_mnt_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+	ASSERT_EQ(close(file1_fd), 0);
+
+	/* Chown all files to an unprivileged user. */
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" IMAGE_ROOT_MNT1,
+		 self->test_dir_path);
+	ASSERT_EQ(chown_r(self->cmdline, 10000, 10000), 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr1.userns_fd	= get_userns_fd(10000, 0, 10000);
+	ASSERT_GE(attr1.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr1, sizeof(attr1)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+
+	/* Create detached mount. */
+	open_tree_fd = sys_open_tree(self->test_dir_fd, IMAGE_ROOT_MNT1,
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr2.userns_fd	= get_userns_fd(10000, 0, 10000);
+	ASSERT_GE(attr2.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH, &attr2, sizeof(attr2)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET2 ")",
+		       open_tree_fd, self->test_dir_path);
+	}
+
+	/* we're crossing a mountpoint so this must fail
+	 *
+	 * Note that this must also fail for non-idmapped mounts but here we're
+	 * interested in making sure we're not introducing an accidental way to
+	 * violate that restriction or that suddenly this becomes possible.
+	 */
+	ASSERT_NE(linkat(self->target1_mnt_fd_detached, FILE1, open_tree_fd, HARDLINK1, 0), 0);
+	ASSERT_EQ(errno, EXDEV);
+
+	ASSERT_EQ(close(attr1.userns_fd), 0);
+	ASSERT_EQ(close(attr2.userns_fd), 0);
+}
+
+TEST_F(core, rename)
+{
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr1 = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	struct mount_attr attr2 = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	file1_fd = openat(self->img_mnt_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+	ASSERT_EQ(close(file1_fd), 0);
+
+	/* Chown all files to an unprivileged user. */
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" IMAGE_ROOT_MNT1,
+		 self->test_dir_path);
+	ASSERT_EQ(chown_r(self->cmdline, 10000, 10000), 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr1.userns_fd	= get_userns_fd(10000, 0, 10000);
+	ASSERT_GE(attr1.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr1, sizeof(attr1)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+
+	/* Create detached mount. */
+	open_tree_fd = sys_open_tree(self->test_dir_fd, IMAGE_ROOT_MNT1,
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr2.userns_fd	= get_userns_fd(10000, 0, 10000);
+	ASSERT_GE(attr2.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH, &attr2, sizeof(attr2)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET2 ")",
+		       open_tree_fd, self->test_dir_path);
+	}
+
+	/* we're crossing a mountpoint so this must fail
+	 *
+	 * Note that this must also fail for non-idmapped mounts but here we're
+	 * interested in making sure we're not introducing an accidental way to
+	 * violate that restriction or that suddenly this becomes possible.
+	 */
+	ASSERT_NE(renameat2(self->target1_mnt_fd_detached, FILE1,
+			    open_tree_fd, FILE1_RENAME, 0), 0);
+
+	ASSERT_EQ(close(attr1.userns_fd), 0);
+	ASSERT_EQ(close(attr2.userns_fd), 0);
+}
+
+/**
+ * Validate that a caller whose fsids map into the idmapped mount within it's
+ * user namespace can create files.
+ */
+TEST_F(core, create_userns)
+{
+	int file1_fd = -EBADF;
+	pid_t pid;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* Switch to user namespace where uid 10000 maps to 0. */
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(0, 0, 0), 0);
+		ASSERT_EQ(setresuid(0, 0, 0), 0);
+
+		/* create regular file via open() */
+		file1_fd = openat(self->target1_mnt_fd_detached,
+				  FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+		ASSERT_GE(file1_fd, 0);
+		ASSERT_EQ(close(file1_fd), 0);
+
+		/* create regular file via mknod */
+		ASSERT_EQ(mknodat(self->target1_mnt_fd_detached,
+				  FILE2, S_IFREG | 0000, 0), 0);
+
+		/* create hardlink */
+		ASSERT_EQ(linkat(self->target1_mnt_fd_detached,
+				 FILE1,
+				 self->target1_mnt_fd_detached,
+				 HARDLINK1, 0), 0);
+
+		/* create symlink */
+		ASSERT_EQ(symlinkat(FILE2, self->target1_mnt_fd_detached,
+				    SYMLINK1), 0);
+
+		/* create directory */
+		ASSERT_EQ(mkdirat(self->target1_mnt_fd_detached,
+				  DIR1, 0700), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that a caller whose fsids map into the idmapped mount within it's
+ * user namespace cannot create any device nodes.
+ */
+TEST_F(core, create_userns_device_node)
+{
+	pid_t pid;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* Switch to user namespace where uid 10000 maps to 0. */
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(0, 0, 0), 0);
+		ASSERT_EQ(setresuid(0, 0, 0), 0);
+
+		/* create character device */
+		ASSERT_NE(mknodat(self->target1_mnt_fd_detached,
+				  CHRDEV1, S_IFCHR | 0644, makedev(5, 1)), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that changing file ownership works correctly on idmapped mounts.
+ */
+TEST_F(core, expected_uid_gid)
+{
+	int file1_fd = -EBADF;
+	uid_t fsuid;
+	gid_t fsgid;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create regular file via open() */
+	file1_fd = openat(self->img_mnt_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(self->img_mnt_fd, FILE2, S_IFREG | 0000, 0), 0);
+
+	/* create character device */
+	ASSERT_EQ(mknodat(self->img_mnt_fd, CHRDEV1, S_IFCHR | 0644,
+			  makedev(5, 1)), 0);
+
+	/* create hardlink */
+	ASSERT_EQ(linkat(self->img_mnt_fd, FILE1, self->img_mnt_fd, HARDLINK1, 0), 0);
+
+	/* create symlink */
+	ASSERT_EQ(symlinkat(FILE2, self->img_mnt_fd, SYMLINK1), 0);
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0700), 0);
+
+	/* retrieve fsids */
+	fsuid = setfsuid(-1);
+	fsgid = setfsgid(-1);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+
+	/*
+	 * Validate that all files created through the image mountpoint are
+	 * owned by the callers fsuid and fsgid.
+	 */
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, FILE1,
+		  0, fsuid, fsgid), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, FILE2,
+		  0, fsuid, fsgid), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, HARDLINK1,
+		  0, fsuid, fsgid), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, CHRDEV1,
+		  0, fsuid, fsgid), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, SYMLINK1,
+		  0, fsuid, fsgid), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, DIR1,
+		  0, fsuid, fsgid), true);
+
+	/*
+	 * Validate that all files are owned by the uid and gid specified in
+	 * the idmapping of the mount they are accessed from.
+	 */
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, FILE1,
+		  0, 10000, 10000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, FILE2,
+		  0, 10000, 10000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, HARDLINK1,
+		  0, 10000, 10000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, CHRDEV1,
+		  0, 10000, 10000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, SYMLINK1,
+		  0, 10000, 10000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, DIR1,
+		  0, 10000, 10000), true);
+
+	/* Change ownership throught original image mountpoint. */
+	ASSERT_EQ(fchownat(self->img_mnt_fd, FILE1, 1000, 1000, 0), 0);
+
+	/* Verify correct ownership through original image mountpoint. */
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, FILE1,
+		  0, 1000, 1000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, HARDLINK1,
+		  0, 1000, 1000), true);
+
+	/* Verify correct ownership through idmapped mountpoint. */
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, FILE1,
+		  0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, HARDLINK1,
+		  0, 11000, 11000), true);
+
+	/* Change ownership throught idmapped mountpoint. */
+	ASSERT_EQ(fchownat(self->target1_mnt_fd_detached, DIR1,
+			   11000, 11000, 0), 0);
+
+	/* Verify correct ownership through original image mountpoint. */
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, DIR1,
+		  0, 1000, 1000), true);
+
+	/* Verify correct ownership through idmapped mountpoint. */
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, DIR1,
+		  0, 11000, 11000), true);
+
+	/* Change ownership throught idmapped mountpoint. */
+	ASSERT_EQ(fchownat(self->target1_mnt_fd_detached, FILE1,
+			   11000, 11000, 0), 0);
+	ASSERT_EQ(fchownat(self->target1_mnt_fd_detached, FILE2,
+			   11000, 11000, 0), 0);
+	ASSERT_EQ(fchownat(self->target1_mnt_fd_detached, CHRDEV1,
+			   11000, 11000, 0), 0);
+	ASSERT_EQ(fchownat(self->target1_mnt_fd_detached, SYMLINK1,
+			   11000, 11000, 0), 0);
+	ASSERT_EQ(fchownat(self->target1_mnt_fd_detached, DIR1,
+			   11000, 11000, 0), 0);
+
+	/*
+	 * Validate that all files are owned by the uid and gid specified in
+	 * the idmapping of the mount they are accessed from.
+	 */
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, FILE1,
+		  0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, FILE2,
+		  0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, HARDLINK1,
+		  0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, CHRDEV1,
+		  0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, SYMLINK1,
+		  0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, DIR1,
+		  0, 11000, 11000), true);
+
+	/*
+	 * Try to change to an id for which we do not have an idmapping from
+	 * the idmapped mountpoint. This must fail.
+	 */
+	ASSERT_NE(fchownat(self->target1_mnt_fd_detached, FILE1,
+			   30000, 30000, 0), 0);
+	ASSERT_NE(fchownat(self->target1_mnt_fd_detached, FILE2,
+			   30000, 30000, 0), 0);
+	ASSERT_NE(fchownat(self->target1_mnt_fd_detached, CHRDEV1,
+			   30000, 30000, 0), 0);
+	ASSERT_NE(fchownat(self->target1_mnt_fd_detached, SYMLINK1,
+			   30000, 30000, 0), 0);
+	ASSERT_NE(fchownat(self->target1_mnt_fd_detached, DIR1,
+			   30000, 30000, 0), 0);
+
+	ASSERT_EQ(close(file1_fd), 0);
+}
+
+/**
+ * Validate that changing file ownership in a user namespace with a matching
+ * idmapping works correctly on idmapped mounts.
+ */
+TEST_F(core, expected_uid_gid_userns)
+{
+	int file1_fd = -EBADF;
+	pid_t pid;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create regular file via open() */
+	file1_fd = openat(self->img_mnt_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(self->img_mnt_fd, FILE2, S_IFREG | 0000, 0), 0);
+
+	/* create character device */
+	ASSERT_EQ(mknodat(self->img_mnt_fd, CHRDEV1, S_IFCHR | 0644,
+			  makedev(5, 1)), 0);
+
+	/* create hardlink */
+	ASSERT_EQ(linkat(self->img_mnt_fd, FILE1, self->img_mnt_fd, HARDLINK1, 0), 0);
+
+	/* create symlink */
+	ASSERT_EQ(symlinkat(FILE2, self->img_mnt_fd, SYMLINK1), 0);
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0700), 0);
+
+	/* change ownership of all files to uid 0 */
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" IMAGE_ROOT_MNT1,
+		 self->test_dir_path);
+	ASSERT_EQ(chown_r(self->cmdline, 0, 0), 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* Switch to  user namespace where uid 10000 maps to 0. */
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(0, 0, 0), 0);
+		ASSERT_EQ(setresuid(0, 0, 0), 0);
+
+		/*
+		 * All files are now owned by uid 0 if accessed through the
+		 * idmapped mountpoint.
+		 */
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   FILE1, 0, 0, 0), true);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   FILE2, 0, 0, 0), true);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   HARDLINK1, 0, 0, 0), true);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   CHRDEV1, 0, 0, 0), true);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   SYMLINK1, 0, 0, 0), true);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   DIR1, 0, 0, 0), true);
+
+		/* Change ownership throught idmapped mountpoint. */
+		ASSERT_EQ(fchownat(self->target1_mnt_fd_detached,
+				   FILE1, 1000, 1000, 0), 0);
+		ASSERT_EQ(fchownat(self->target1_mnt_fd_detached,
+				   FILE2, 1000, 1000, 0), 0);
+		ASSERT_EQ(fchownat(self->target1_mnt_fd_detached,
+				   CHRDEV1, 1000, 1000, 0), 0);
+		ASSERT_EQ(fchownat(self->target1_mnt_fd_detached,
+				   SYMLINK1, 1000, 1000, 0), 0);
+		ASSERT_EQ(fchownat(self->target1_mnt_fd_detached,
+				   DIR1, 1000, 1000, 0), 0);
+
+		/*
+		 * All files are now owned by uid 1000 if accessed through the
+		 * idmapped mountpoint.
+		 */
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   FILE1, 0, 1000, 1000), true);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   FILE2, 0, 1000, 1000), true);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   HARDLINK1, 0, 1000, 1000), true);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   CHRDEV1, 0, 1000, 1000), true);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   SYMLINK1, 0, 1000, 1000), true);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached,
+					   DIR1, 0, 1000, 1000), true);
+
+		/*
+		 * Try to change to an id for which we do not have an idmapping
+		 * from the idmapped mountpoint. This must fail.
+		 */
+		ASSERT_NE(fchownat(self->target1_mnt_fd_detached,
+				   FILE1, 30000, 30000, 0), 0);
+		ASSERT_NE(fchownat(self->target1_mnt_fd_detached,
+				   FILE2, 30000, 30000, 0), 0);
+		ASSERT_NE(fchownat(self->target1_mnt_fd_detached,
+				   CHRDEV1, 30000, 30000, 0), 0);
+		ASSERT_NE(fchownat(self->target1_mnt_fd_detached,
+				   SYMLINK1, 30000, 30000, 0), 0);
+		ASSERT_NE(fchownat(self->target1_mnt_fd_detached,
+				   DIR1, 30000, 30000, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/*
+	 * All files are owned by uid 10000 if accessed through the image
+	 * mountpoint.
+	 */
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd,
+				  FILE1, 0, 1000, 1000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd,
+				   FILE2, 0, 1000, 1000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd,
+				   HARDLINK1, 0, 1000, 1000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd,
+				   CHRDEV1, 0, 1000, 1000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd,
+				   SYMLINK1, 0, 1000, 1000), true);
+
+	ASSERT_EQ(expected_uid_gid(self->img_mnt_fd,
+				   DIR1, 0, 1000, 1000), true);
+
+	ASSERT_EQ(close(file1_fd), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that setting namespaced filesystem capabilities works correctly on
+ * idmapped mounts.
+ */
+TEST_F(core, expected_fscaps_userns)
+{
+	pid_t pid;
+	int file1_fd = -EBADF, file1_fd2 = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	file1_fd = openat(self->img_mnt_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+	ASSERT_EQ(close(file1_fd), 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+
+	file1_fd = openat(self->target1_mnt_fd_detached, FILE1, O_RDWR | O_CLOEXEC, 0);
+	ASSERT_GE(file1_fd, 0);
+
+	/*
+	 * uid 10000 maps to 0 in the mount's user namespace and uid 0 has a
+	 * mapping in our current user namespace and in the superblock's
+	 * namespace so this must succeed.
+	 */
+	ASSERT_EQ(set_dummy_vfs_caps(file1_fd, 0, 10000), 0);
+	ASSERT_EQ(expected_dummy_vfs_caps_uid(file1_fd, 10000), true);
+
+	/*
+	 * uid 0 maps to 10000 in the mount's user namespace but uid 10000
+	 * doesn't have a mapping in our current user namespace so this must
+	 * fails.
+	 */
+	ASSERT_NE(set_dummy_vfs_caps(file1_fd, 0, 0), 0);
+
+	file1_fd2 = openat(self->img_mnt_fd, FILE1, O_RDWR | O_CLOEXEC, 0);
+	ASSERT_GE(file1_fd2, 0);
+	ASSERT_EQ(expected_dummy_vfs_caps_uid(file1_fd2, 0), true);
+
+	ASSERT_EQ(fremovexattr(file1_fd, "security.capability"), 0);
+	ASSERT_EQ(expected_dummy_vfs_caps_uid(file1_fd2, 0), false);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* Switch to a user namespace where uid 10000 maps to 0. */
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(0, 0, 0), 0);
+		ASSERT_EQ(setresuid(0, 0, 0), 0);
+
+		/*
+		 * uid 0 maps to 10000 in the mount's user namespace and uid 10000
+		 * has a mapping in our current user namespace and in the superblock's
+		 * user namespace so this must succeed.
+		 */
+		ASSERT_EQ(set_dummy_vfs_caps(file1_fd, 0, 0), 0);
+		ASSERT_EQ(expected_dummy_vfs_caps_uid(file1_fd, 0), true);
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(expected_dummy_vfs_caps_uid(file1_fd2, 0), true);
+
+	ASSERT_EQ(close(file1_fd), 0);
+	ASSERT_EQ(close(file1_fd2), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that setting filesystem capabilities works correctly on idmapped
+ * mounts where all files on disk are owned by uid and gid 10000.
+ */
+TEST_F(core, expected_fscaps_reverse)
+{
+	int file1_fd = -EBADF, file1_fd2 = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	file1_fd = openat(self->img_mnt_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+	ASSERT_EQ(close(file1_fd), 0);
+
+	/* Chown all files to an unprivileged user. */
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" IMAGE_ROOT_MNT1,
+		 self->test_dir_path);
+	ASSERT_EQ(chown_r(self->cmdline, 10000, 10000), 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - Failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+
+	ASSERT_EQ(sys_move_mount(self->target1_mnt_fd_detached, "",
+				 self->test_dir_fd, MNT_TARGET1,
+				 MOVE_MOUNT_F_EMPTY_PATH), 0) {
+		TH_LOG("%m - Failed to attached detached mount %d(%s/" IMAGE_FILE1 ") to %s/" MNT_TARGET1,
+		       self->target1_mnt_fd_detached, self->test_dir_path,
+		       self->test_dir_path);
+	}
+
+	snprintf(self->cmdline, sizeof(self->cmdline),
+		 "setcap cap_dac_override,cap_sys_tty_config+ep %s/" MNT_TARGET1 "/" FILE1,
+		 self->test_dir_path);
+	ASSERT_EQ(system(self->cmdline), 0);
+
+	file1_fd = openat(self->target1_mnt_fd_detached, FILE1, O_RDWR | O_CLOEXEC, 0);
+	ASSERT_GE(file1_fd, 0);
+	ASSERT_EQ(set_dummy_vfs_caps(file1_fd, 0, 0), 0);
+	ASSERT_EQ(expected_dummy_vfs_caps_uid(file1_fd, 0), true);
+
+	ASSERT_NE(set_dummy_vfs_caps(file1_fd, 0, 10000), 0);
+
+	file1_fd2 = openat(self->img_mnt_fd, FILE1, O_RDWR | O_CLOEXEC, 0);
+	ASSERT_GE(file1_fd2, 0);
+	ASSERT_EQ(expected_dummy_vfs_caps_uid(file1_fd2, 10000), true);
+
+	ASSERT_EQ(fremovexattr(file1_fd, "security.capability"), 0);
+	ASSERT_EQ(expected_dummy_vfs_caps_uid(file1_fd2, 0), false);
+
+	ASSERT_EQ(close(file1_fd), 0);
+	ASSERT_EQ(close(file1_fd2), 0);
+}
+
+/**
+ * Validate that when the IDMAP_MOUNT_TEST_RUN_SETID environment variable is
+ * set to 1 that we are executed with setid privileges and if set to 0 we are
+ * not. If the env variable isn't set the tests are not run.
+ */
+static void __attribute__((constructor)) setuid_rexec(void)
+{
+	const char *expected_euid_str, *expected_egid_str, *rexec;
+
+	rexec = getenv("IDMAP_MOUNT_TEST_RUN_SETID");
+	/* This is a regular test-suite run. */
+	if (!rexec)
+		return;
+
+	expected_euid_str = getenv("EXPECTED_EUID");
+	expected_egid_str = getenv("EXPECTED_EGID");
+
+	if (expected_euid_str && expected_egid_str) {
+		uid_t expected_euid;
+		gid_t expected_egid;
+
+		expected_euid = atoi(expected_euid_str);
+		expected_egid = atoi(expected_egid_str);
+
+		if (strcmp(rexec, "1") == 0) {
+			/* we're expecting to run setid */
+			if ((getuid() != geteuid()) &&
+			    (expected_euid == geteuid()) &&
+			    (getgid() != getegid()) &&
+			    (expected_egid == getegid()))
+				exit(EXIT_SUCCESS);
+		} else if (strcmp(rexec, "0") == 0) {
+			/* we're expecting to not run setid */
+			if ((getuid() == geteuid()) &&
+			    (expected_euid == geteuid()) &&
+			    (getgid() == getegid()) &&
+			    (expected_egid == getegid()))
+				exit(EXIT_SUCCESS);
+		}
+	}
+
+	exit(EXIT_FAILURE);
+}
+
+/**
+ * Validate that setid transitions are handled correctly on idmapped mounts.
+ */
+TEST_F(core, setid_binaries)
+{
+	int file1_fd = -EBADF, exec_fd = -EBADF;
+	pid_t pid;
+
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create a file to be used as setuid binary */
+	file1_fd = openat(self->img_mnt_fd, FILE1, O_CREAT | O_EXCL | O_RDWR | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+
+	/* open our own executable */
+	exec_fd = openat(-EBADF, "/proc/self/exe", O_RDONLY | O_CLOEXEC, 0000);
+	ASSERT_GE(exec_fd, 0);
+
+	/* copy our own executable into the file we created */
+	ASSERT_EQ(fd_to_fd(exec_fd, file1_fd), 0);
+
+	/* Chown all files to an unprivileged user. */
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" IMAGE_ROOT_MNT1,
+		 self->test_dir_path);
+	ASSERT_EQ(chown_r(self->cmdline, 10000, 10000), 0);
+
+	/* chown the file to the uid and gid we want to assume */
+	ASSERT_EQ(fchown(file1_fd, 5000, 5000), 0);
+
+	/* set the setid bits and grant execute permissions to the group */
+	ASSERT_EQ(fchmod(file1_fd, S_IXGRP | S_IEXEC | S_ISUID | S_ISGID), 0);
+
+	/* Verify that the sid bits got raised. */
+	ASSERT_EQ(is_setid(self->img_mnt_fd, FILE1, 0), true);
+
+	ASSERT_EQ(close(exec_fd), 0);
+	ASSERT_EQ(close(file1_fd), 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+
+	/* Verify we run setid binary as uid and gid 5000 from original image mount. */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=5000",
+			"EXPECTED_EGID=5000",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, FILE1, 0, 5000, 5000), true);
+		ASSERT_EQ(sys_execveat(self->img_mnt_fd, FILE1, argv, envp, 0), 0) {
+			TH_LOG("%m - failure: failed to execute setuid binary");
+		}
+
+		exit(EXIT_FAILURE);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/*
+	 * A detached mount will have an anonymous mount namespace attached to
+	 * it. This means that we can't execute setid binaries on a detached
+	 * mount because the mnt_may_suid() helper will fail the check_mount()
+	 * part of its check which compares the caller's mount namespace to the
+	 * detached mount's mount namespace. Since by definition an anonymous
+	 * mount namespace is not equale to any mount namespace currently in
+	 * use this can't work. So attach the mount to the filesystem first
+	 * before performing this check.
+	 */
+	ASSERT_EQ(sys_move_mount(self->target1_mnt_fd_detached, "",
+				 self->test_dir_fd, MNT_TARGET1,
+				 MOVE_MOUNT_F_EMPTY_PATH), 0) {
+		TH_LOG("%m - Failed to attached detached mount %d(%s/" IMAGE_FILE1 ") to %s/" MNT_TARGET1,
+		       self->target1_mnt_fd_detached, self->test_dir_path,
+		       self->test_dir_path);
+	}
+
+	/* Verify we run setid binary as uid and gid 10000 from idmapped mount mount. */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=15000",
+			"EXPECTED_EGID=15000",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, FILE1, 0, 15000, 15000), true);
+		ASSERT_EQ(sys_execveat(self->target1_mnt_fd_detached, FILE1, argv, envp, 0), 0) {
+			TH_LOG("%m - Failed to execute setuid binary");
+		}
+
+		exit(EXIT_FAILURE);
+	}
+
+	ASSERT_GE(wait_for_pid(pid), 0);
+}
+
+/**
+ * Validate that setid transitions are handled correctly on idmapped
+ * mounts where all files on disk are owned by uid and gid 10000.
+ */
+TEST_F(core, setid_binaries_reverse)
+{
+	int file1_fd = -EBADF, exec_fd = -EBADF;
+	pid_t pid;
+
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create a file to be used as setuid binary */
+	file1_fd = openat(self->img_mnt_fd, FILE1,
+			  O_CREAT | O_EXCL | O_RDWR | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+
+	/* open our own executable */
+	exec_fd = openat(-EBADF, "/proc/self/exe", O_RDONLY | O_CLOEXEC, 0000);
+	ASSERT_GE(exec_fd, 0);
+
+	ASSERT_EQ(fd_to_fd(exec_fd, file1_fd), 0);
+	ASSERT_EQ(close(exec_fd), 0);
+	ASSERT_EQ(close(file1_fd), 0);
+
+	/* chown all files to uid and gid 15000 */
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" IMAGE_ROOT_MNT1,
+		 self->test_dir_path);
+	ASSERT_EQ(chown_r(self->cmdline, 15000, 15000), 0);
+
+	/* Set setid bits on the newly chowned binary. */
+	ASSERT_EQ(fchmodat(self->img_mnt_fd, FILE1,
+			   S_IXGRP | S_IEXEC | S_ISUID | S_ISGID, 0), 0);
+
+	/* Verify that the sid bits got raised. */
+	ASSERT_EQ(is_setid(self->img_mnt_fd, FILE1, 0), true);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+
+	/* Attach the mount to the filesystem. */
+	ASSERT_EQ(sys_move_mount(self->target1_mnt_fd_detached, "",
+				 self->test_dir_fd, MNT_TARGET1,
+				 MOVE_MOUNT_F_EMPTY_PATH), 0) {
+		TH_LOG("%m - failure: failed to attached detached mount %d(%s/" IMAGE_FILE1 ") to %s/" MNT_TARGET1,
+		       self->target1_mnt_fd_detached, self->test_dir_path,
+		       self->test_dir_path);
+	}
+
+	/* Verify we run setid binary as uid and gid 5000 from idmapped mount mount. */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=5000",
+			"EXPECTED_EGID=5000",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, FILE1, 0, 5000, 5000), true);
+		ASSERT_EQ(sys_execveat(self->target1_mnt_fd_detached, FILE1, argv, envp, 0), 0) {
+			TH_LOG("%m - Failed to execute setuid binary");
+		}
+
+		exit(EXIT_FAILURE);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* Verify we run setid binary as uid and gid 15000 from original image mount. */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=15000",
+			"EXPECTED_EGID=15000",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		ASSERT_EQ(expected_uid_gid(self->img_mnt_fd, FILE1, 0, 15000, 15000), true);
+		ASSERT_EQ(sys_execveat(self->img_mnt_fd, FILE1, argv, envp, 0), 0) {
+			TH_LOG("%m - Failed to execute setuid binary");
+		}
+
+		exit(EXIT_FAILURE);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/**
+ * Validate that setid transitions are handled correctly on idmapped mounts
+ * running in a user namespace where the uid and gid of the setid binary have
+ * no mapping.
+ */
+TEST_F(core, setid_binaries_userns)
+{
+	int file1_fd = -EBADF, exec_fd = -EBADF;
+	pid_t pid;
+
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create a file to be used as setuid binary */
+	file1_fd = openat(self->img_mnt_fd, FILE1, O_CREAT | O_EXCL | O_RDWR | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+
+	/* open our own executable */
+	exec_fd = openat(-EBADF, "/proc/self/exe", O_RDONLY | O_CLOEXEC, 0000);
+	ASSERT_GE(exec_fd, 0);
+
+	/* copy our own executable into the file we created */
+	ASSERT_EQ(fd_to_fd(exec_fd, file1_fd), 0);
+
+	/* chown the file to the uid and gid we want to assume */
+	ASSERT_EQ(fchown(file1_fd, 5000, 5000), 0);
+
+	/* set the setid bits and grant execute permissions to the group */
+	ASSERT_EQ(fchmod(file1_fd, S_IXGRP | S_IEXEC | S_ISUID | S_ISGID), 0);
+
+	/* Verify that the sid bits got raised. */
+	ASSERT_EQ(is_setid(self->img_mnt_fd, FILE1, 0), true);
+
+	ASSERT_EQ(close(exec_fd), 0);
+	ASSERT_EQ(close(file1_fd), 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(self->target1_mnt_fd_detached, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0) {
+		TH_LOG("%m - failure: failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       self->target1_mnt_fd_detached, self->test_dir_path);
+	}
+
+	/*
+	 * A detached mount will have an anonymous mount namespace attached to
+	 * it. This means that we can't execute setid binaries on a detached
+	 * mount because the mnt_may_suid() helper will fail the check_mount()
+	 * part of its check which compares the caller's mount namespace to the
+	 * detached mount's mount namespace. Since by definition an anonymous
+	 * mount namespace is not equale to any mount namespace currently in
+	 * use this can't work. So attach the mount to the filesystem first
+	 * before performing this check.
+	 */
+	ASSERT_EQ(sys_move_mount(self->target1_mnt_fd_detached, "",
+				 self->test_dir_fd, MNT_TARGET1,
+				 MOVE_MOUNT_F_EMPTY_PATH), 0) {
+		TH_LOG("%m - Failed to attached detached mount %d(%s/" IMAGE_FILE1 ") to %s/" MNT_TARGET1,
+		       self->target1_mnt_fd_detached, self->test_dir_path,
+		       self->test_dir_path);
+	}
+
+	/* Verify we run setid binary as uid and gid 5000 from original image mount. */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		static char *envp[] = {
+			"IDMAP_MOUNT_TEST_RUN_SETID=1",
+			"EXPECTED_EUID=5000",
+			"EXPECTED_EGID=5000",
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		/* Switch to user namespace where uid 10000 maps to 0. */
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(0, 0, 0), 0);
+		ASSERT_EQ(setresuid(0, 0, 0), 0);
+
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, FILE1, 0, 5000, 5000), true);
+		ASSERT_EQ(sys_execveat(self->target1_mnt_fd_detached, FILE1, argv, envp, 0), 0) {
+			TH_LOG("%m - failure: failed to execute setuid binary");
+		}
+
+		exit(EXIT_FAILURE);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	file1_fd = openat(self->img_mnt_fd, FILE1, O_RDWR | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+
+	/* chown the file to the uid and gid we want to assume */
+	ASSERT_EQ(fchown(file1_fd, 30000, 30000), 0);
+
+	/* set the setid bits and grant execute permissions to other users */
+	ASSERT_EQ(fchmod(file1_fd, S_IXOTH | S_IEXEC | S_ISUID | S_ISGID), 0);
+
+	ASSERT_EQ(close(file1_fd), 0);
+
+	/*
+	 * Verify that we can't assume a uid and gid of a setid binary for
+	 * which we have no mapping in our user namespace.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		char expected_euid[100];
+		char expected_egid[100];
+		static char *envp[4] = {
+			NULL,
+			NULL,
+			NULL,
+			NULL,
+		};
+		static char *argv[] = {
+			NULL,
+		};
+
+		/* Switch to user namespace where uid 10000 maps to 0. */
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(0, 0, 0), 0);
+		ASSERT_EQ(setresuid(0, 0, 0), 0);
+
+		envp[0] = "IDMAP_MOUNT_TEST_RUN_SETID=0";
+		snprintf(expected_euid, sizeof(expected_euid), "EXPECTED_EUID=%d", geteuid());
+		envp[1] = expected_euid;
+		snprintf(expected_egid, sizeof(expected_egid), "EXPECTED_egid=%d", getegid());
+		envp[2] = expected_egid;
+		ASSERT_EQ(expected_uid_gid(self->target1_mnt_fd_detached, FILE1, 0, 65534, 65534), true);
+		ASSERT_EQ(sys_execveat(self->target1_mnt_fd_detached, FILE1, argv, envp, 0), 0) {
+			TH_LOG("%m - Failed to execute setuid binary");
+		}
+
+		exit(EXIT_FAILURE);
+	}
+	ASSERT_GE(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that idmapping a whole mount tree works correctly.
+ */
+TEST_F(core, idmap_mount_tree)
+{
+	int img_fd2 = -EBADF, img_mnt_fd2 = -EBADF, file1_fd = -EBADF,
+	    open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create filesystem image */
+	img_fd2 = openat(self->test_dir_fd, IMAGE_FILE2,
+			 O_CREAT | O_WRONLY, 0600);
+	ASSERT_GE(img_fd2, 0);
+	ASSERT_EQ(ftruncate(img_fd2, 1024 * 2048), 0);
+	ASSERT_EQ(close(img_fd2), 0);
+	snprintf(self->cmdline, sizeof(self->cmdline),
+		 "mkfs.ext4 -q %s/" IMAGE_FILE2, self->test_dir_path);
+	ASSERT_EQ(system(self->cmdline), 0);
+
+	/* create mountpoint for image */
+	ASSERT_EQ(mkdirat(self->test_dir_fd, IMAGE_ROOT_MNT2, 0777), 0);
+	snprintf(self->cmdline, sizeof(self->cmdline),
+		 "mount -o loop -t ext4 %s/" IMAGE_FILE2 " %s/" IMAGE_ROOT_MNT2,
+		 self->test_dir_path, self->test_dir_path);
+	ASSERT_EQ(system(self->cmdline), 0);
+	img_mnt_fd2 = openat(self->test_dir_fd, IMAGE_ROOT_MNT2,
+			     O_DIRECTORY | O_CLOEXEC, 0);
+	ASSERT_GE(img_mnt_fd2, 0);
+
+	/* Create files in first filesystem. */
+	file1_fd = openat(self->img_mnt_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+	ASSERT_EQ(close(file1_fd), 0);
+
+	ASSERT_EQ(mknodat(self->img_mnt_fd, FILE2, S_IFREG | 0000, 0), 0);
+
+	ASSERT_EQ(mknodat(self->img_mnt_fd, CHRDEV1, S_IFCHR | 0644,
+			  makedev(5, 1)), 0);
+
+	ASSERT_EQ(linkat(self->img_mnt_fd, FILE1, self->img_mnt_fd, HARDLINK1, 0), 0);
+
+	ASSERT_EQ(symlinkat(FILE2, self->img_mnt_fd, SYMLINK1), 0);
+
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0700), 0);
+
+	/* Chown all files to 1000. */
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" IMAGE_ROOT_MNT1,
+		 self->test_dir_path);
+	ASSERT_EQ(chown_r(self->cmdline, 1000, 1000), 0);
+
+	/* Create files in second filesystem. */
+	file1_fd = openat(img_mnt_fd2, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	ASSERT_GE(file1_fd, 0);
+	ASSERT_EQ(close(file1_fd), 0);
+
+	ASSERT_EQ(mknodat(img_mnt_fd2, FILE2, S_IFREG | 0000, 0), 0);
+
+	ASSERT_EQ(mknodat(img_mnt_fd2, CHRDEV1, S_IFCHR | 0644,
+			  makedev(5, 1)), 0);
+
+	ASSERT_EQ(linkat(img_mnt_fd2, FILE1, img_mnt_fd2, HARDLINK1, 0), 0);
+
+	ASSERT_EQ(symlinkat(FILE2, img_mnt_fd2, SYMLINK1), 0);
+
+	ASSERT_EQ(mkdirat(img_mnt_fd2, DIR1, 0700), 0);
+	ASSERT_EQ(close(img_mnt_fd2), 0);
+
+	/* Chown all files to 1000. */
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" IMAGE_ROOT_MNT2,
+		 self->test_dir_path);
+	ASSERT_EQ(chown_r(self->cmdline, 1000, 1000), 0);
+
+	/* Create detached mount. */
+	open_tree_fd = sys_open_tree(self->test_dir_fd, IMAGE_ROOT_MNT1,
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH | AT_RECURSIVE, &attr,
+				    sizeof(attr)), 0) {
+		TH_LOG("%m - Failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       open_tree_fd, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+
+	/*
+	 * All files created through the original image mountpoint  are owned
+	 * by uid 0.
+	 */
+	ASSERT_EQ(expected_uid_gid(open_tree_fd, FILE1, 0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(open_tree_fd, FILE2, 0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(open_tree_fd, HARDLINK1, 0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(open_tree_fd, CHRDEV1, 0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(open_tree_fd, SYMLINK1, 0, 11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(open_tree_fd, DIR1, 0, 11000, 11000), true);
+
+	/*
+	 * All files created through the original image mountpoint  are owned
+	 * by uid 0.
+	 */
+	ASSERT_EQ(expected_uid_gid(open_tree_fd,
+				   IMAGE_ROOT_MNT2_RELATIVE "/" FILE1, 0, 11000,
+				   11000), true);
+
+	ASSERT_EQ(expected_uid_gid(open_tree_fd,
+				   IMAGE_ROOT_MNT2_RELATIVE "/" FILE2, 0, 11000,
+				   11000), true);
+
+	ASSERT_EQ(expected_uid_gid(open_tree_fd,
+				   IMAGE_ROOT_MNT2_RELATIVE "/" HARDLINK1, 0,
+				   11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(open_tree_fd,
+				   IMAGE_ROOT_MNT2_RELATIVE "/" CHRDEV1, 0,
+				   11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(open_tree_fd,
+				   IMAGE_ROOT_MNT2_RELATIVE "/" SYMLINK1, 0,
+				   11000, 11000), true);
+
+	ASSERT_EQ(expected_uid_gid(open_tree_fd,
+				   IMAGE_ROOT_MNT2_RELATIVE "/" DIR1, 0, 11000,
+				   11000), true);
+
+	ASSERT_EQ(close(open_tree_fd), 0);
+}
+
+/**
+ * Validate that idmapping a mount tree with an unsupported filesystem
+ * somehwere in the tree fails.
+ */
+TEST_F(core, idmap_mount_tree_invalid)
+{
+	int img_fd2 = -EBADF, img_mnt_fd2 = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create filesystem image */
+	img_fd2 = openat(self->test_dir_fd, IMAGE_FILE2,
+			 O_CREAT | O_WRONLY, 0600);
+	ASSERT_GE(img_fd2, 0);
+	ASSERT_EQ(ftruncate(img_fd2, 1024 * 2048), 0);
+	ASSERT_EQ(close(img_fd2), 0);
+	snprintf(self->cmdline, sizeof(self->cmdline),
+		 "mkfs.ext4 -q %s/" IMAGE_FILE2, self->test_dir_path);
+	ASSERT_EQ(system(self->cmdline), 0);
+
+	/* create mountpoint for image */
+	ASSERT_EQ(mkdirat(self->test_dir_fd, IMAGE_ROOT_MNT2, 0777), 0);
+	snprintf(self->cmdline, sizeof(self->cmdline),
+		 "mount -o loop -t ext4 %s/" IMAGE_FILE2 " %s/" IMAGE_ROOT_MNT2,
+		 self->test_dir_path, self->test_dir_path);
+	ASSERT_EQ(system(self->cmdline), 0);
+	img_mnt_fd2 = openat(self->test_dir_fd, IMAGE_ROOT_MNT2,
+			     O_DIRECTORY | O_CLOEXEC, 0);
+	ASSERT_GE(img_mnt_fd2, 0);
+
+	/* create mount of currently unsupported filesystem */
+	ASSERT_EQ(mkdirat(self->test_dir_fd, FILESYSTEM_MOUNT1, 0777), 0);
+	snprintf(self->cmdline, sizeof(self->cmdline), "%s/" FILESYSTEM_MOUNT1, self->test_dir_path);
+	ASSERT_EQ(mount(NULL, self->cmdline, "tmpfs", 0, NULL), 0);
+
+	/* Create detached mount. */
+	open_tree_fd = sys_open_tree(self->test_dir_fd, IMAGE_ROOT_MNT1,
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_NE(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH | AT_RECURSIVE, &attr,
+				    sizeof(attr)), 0) {
+		TH_LOG("Managed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       open_tree_fd, self->test_dir_path);
+	}
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that the sticky bit behaves correctly on regular mounts for unlink
+ * operations.
+ */
+TEST_F(core, sticky_bit_unlink)
+{
+	pid_t pid;
+	int dir_fd = -EBADF;
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0000), 0);
+	dir_fd = openat(self->img_mnt_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dir_fd, 0);
+	ASSERT_EQ(fchown(dir_fd, 0, 0), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(unlinkat(dir_fd, FILE1, 0), 0);
+		ASSERT_EQ(unlinkat(dir_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* set sticky bit */
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_NE(unlinkat(dir_fd, FILE1, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(unlinkat(dir_fd, FILE2, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* change ownership */
+		ASSERT_EQ(fchownat(dir_fd, FILE1, 1000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 1000, 0), true);
+		ASSERT_EQ(fchownat(dir_fd, FILE2, 1000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE2, 0, 1000, 2000), true);
+
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(unlinkat(dir_fd, FILE1, 0), 0);
+		ASSERT_EQ(unlinkat(dir_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* change uid to unprivileged user */
+	ASSERT_EQ(fchown(dir_fd, 1000, -1), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(unlinkat(dir_fd, FILE1, 0), 0);
+		ASSERT_EQ(unlinkat(dir_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(dir_fd), 0);
+}
+
+/**
+ * Validate that the sticky bit behaves correctly on idmapped mounts for unlink
+ * operations.
+ */
+TEST_F(core, sticky_bit_unlink_idmapped)
+{
+	pid_t pid;
+	int dir_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0000), 0);
+	dir_fd = openat(self->img_mnt_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dir_fd, 0);
+	ASSERT_EQ(fchown(dir_fd, 10000, 10000), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 10000, 10000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 12000, 12000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/* Create detached mount. */
+	open_tree_fd = sys_open_tree(self->img_mnt_fd, DIR1,
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH | AT_RECURSIVE, &attr,
+				    sizeof(attr)), 0) {
+		TH_LOG("%m - Failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       open_tree_fd, self->test_dir_path);
+	}
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE2, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* set sticky bit */
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 10000, 10000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 12000, 12000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_NE(unlinkat(open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(unlinkat(open_tree_fd, FILE2, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* change ownership */
+		ASSERT_EQ(fchownat(dir_fd, FILE1, 11000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 11000, 10000), true);
+		ASSERT_EQ(fchownat(dir_fd, FILE2, 11000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE2, 0, 11000, 12000), true);
+
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* change uid to unprivileged user */
+	ASSERT_EQ(fchown(dir_fd, 11000, -1), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 10000, 10000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 12000, 12000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(dir_fd), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that the sticky bit behaves correctly on idmapped mounts for unlink
+ * operations in a user namespace.
+ */
+TEST_F(core, sticky_bit_unlink_idmapped_userns)
+{
+	pid_t pid;
+	int dir_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0000), 0);
+	dir_fd = openat(self->img_mnt_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dir_fd, 0);
+	ASSERT_EQ(fchown(dir_fd, 0, 0), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/* Create detached mount. */
+	open_tree_fd = sys_open_tree(self->img_mnt_fd, DIR1,
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH | AT_RECURSIVE, &attr,
+				    sizeof(attr)), 0) {
+		TH_LOG("%m - Failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       open_tree_fd, self->test_dir_path);
+	}
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* set sticky bit */
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_NE(unlinkat(dir_fd, FILE1, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(unlinkat(dir_fd, FILE2, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		ASSERT_NE(unlinkat(open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(unlinkat(open_tree_fd, FILE2, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* change ownership */
+		ASSERT_EQ(fchownat(dir_fd, FILE1, 1000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 1000, 0), true);
+		ASSERT_EQ(fchownat(dir_fd, FILE2, 1000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE2, 0, 1000, 2000), true);
+
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		/* we don't own the file from the original mount */
+		ASSERT_NE(unlinkat(dir_fd, FILE1, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(unlinkat(dir_fd, FILE2, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		/* we own the file from the idmapped mount */
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* change uid to unprivileged user */
+	ASSERT_EQ(fchown(dir_fd, 1000, -1), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		/* we don't own the directory from the original mount */
+		ASSERT_NE(unlinkat(dir_fd, FILE1, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(unlinkat(dir_fd, FILE2, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		/* we own the file from the idmapped mount */
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(unlinkat(open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(dir_fd), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that the sticky bit behaves correctly on regular mounts for rename
+ * operations.
+ */
+TEST_F(core, sticky_bit_rename)
+{
+	pid_t pid;
+	int dir_fd = -EBADF;
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0000), 0);
+	dir_fd = openat(self->img_mnt_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dir_fd, 0);
+	ASSERT_EQ(fchown(dir_fd, 0, 0), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0), 0);
+		ASSERT_EQ(renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* set sticky bit */
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_NE(renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* change ownership */
+		ASSERT_EQ(fchownat(dir_fd, FILE1, 1000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 1000, 0), true);
+		ASSERT_EQ(fchownat(dir_fd, FILE2, 1000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE2, 0, 1000, 2000), true);
+
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0), 0);
+		ASSERT_EQ(renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* change uid to unprivileged user */
+	ASSERT_EQ(fchown(dir_fd, 1000, -1), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+
+		ASSERT_EQ(renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(dir_fd, FILE1_RENAME, dir_fd, FILE1, 0), 0);
+		ASSERT_EQ(renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(dir_fd, FILE2_RENAME, dir_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(dir_fd), 0);
+}
+
+/**
+ * Validate that the sticky bit behaves correctly on idmapped mounts for rename
+ * operations.
+ */
+TEST_F(core, sticky_bit_rename_idmapped)
+{
+	pid_t pid;
+	int dir_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0000), 0);
+	dir_fd = openat(self->img_mnt_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dir_fd, 0);
+	ASSERT_EQ(fchown(dir_fd, 10000, 10000), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 10000, 10000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 12000, 12000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/* Create detached mount. */
+	open_tree_fd = sys_open_tree(self->img_mnt_fd, DIR1,
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH | AT_RECURSIVE, &attr,
+				    sizeof(attr)), 0) {
+		TH_LOG("%m - Failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       open_tree_fd, self->test_dir_path);
+	}
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* set sticky bit */
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 10000, 10000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 12000, 12000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_NE(renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* change ownership */
+		ASSERT_EQ(fchownat(dir_fd, FILE1, 11000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 11000, 10000), true);
+		ASSERT_EQ(fchownat(dir_fd, FILE2, 11000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE2, 0, 11000, 12000), true);
+
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* change uid to unprivileged user */
+	ASSERT_EQ(fchown(dir_fd, 11000, -1), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 10000, 10000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 12000, 12000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(dir_fd), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that the sticky bit behaves correctly on idmapped mounts for rename
+ * operations in a user namespace.
+ */
+TEST_F(core, sticky_bit_rename_idmapped_userns)
+{
+	pid_t pid;
+	int dir_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0000), 0);
+	dir_fd = openat(self->img_mnt_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dir_fd, 0);
+	ASSERT_EQ(fchown(dir_fd, 0, 0), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE2, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/* Create detached mount. */
+	open_tree_fd = sys_open_tree(self->img_mnt_fd, DIR1,
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH | AT_RECURSIVE, &attr,
+				    sizeof(attr)), 0) {
+		TH_LOG("%m - Failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       open_tree_fd, self->test_dir_path);
+	}
+
+	/*
+	 * The sticky bit is not set so we must be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* set sticky bit */
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set so we must not be able to delete files not
+	 * owned by us.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		ASSERT_NE(renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		ASSERT_NE(renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/*
+	 * The sticky bit is set and we own the files so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* change ownership */
+		ASSERT_EQ(fchownat(dir_fd, FILE1, 1000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 1000, 0), true);
+		ASSERT_EQ(fchownat(dir_fd, FILE2, 1000, -1, 0), 0);
+		ASSERT_EQ(expected_uid_gid(dir_fd, FILE2, 0, 1000, 2000), true);
+
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		/* we don't own the file from the original mount */
+		ASSERT_NE(renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		/* we own the file from the idmapped mount */
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	/* change uid to unprivileged user */
+	ASSERT_EQ(fchown(dir_fd, 1000, -1), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	ASSERT_EQ(fchownat(dir_fd, FILE2, 2000, 2000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE2, 0644, 0), 0);
+
+	/*
+	 * The sticky bit is set and we own the directory so we must be able to
+	 * delete the files now.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		/* we don't own the directory from the original mount */
+		ASSERT_NE(renameat2(dir_fd, FILE1, dir_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+		ASSERT_NE(renameat2(dir_fd, FILE2, dir_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(errno, EPERM);
+
+		/* we own the file from the idmapped mount */
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1, open_tree_fd, FILE1_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE1_RENAME, open_tree_fd, FILE1, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2, open_tree_fd, FILE2_RENAME, 0), 0);
+		ASSERT_EQ(renameat2(open_tree_fd, FILE2_RENAME, open_tree_fd, FILE2, 0), 0);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(dir_fd), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that protected symlinks work correctly.
+ */
+TEST_F(core, follow_symlinks)
+{
+	int dir_fd = -EBADF, fd = -EBADF;
+	pid_t pid;
+
+	if (!symlinks_protected())
+		SKIP(return, "Symlinks are not protected. Skipping test");
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0000), 0);
+	dir_fd = openat(self->img_mnt_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dir_fd, 0);
+	ASSERT_EQ(fchown(dir_fd, 0, 0), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create symlinks */
+	ASSERT_EQ(symlinkat(FILE1, dir_fd, SYMLINK_USER1), 0);
+	ASSERT_EQ(fchownat(dir_fd, SYMLINK_USER1, 0, 0, AT_SYMLINK_NOFOLLOW), 0);
+	ASSERT_EQ(expected_uid_gid(dir_fd, SYMLINK_USER1, AT_SYMLINK_NOFOLLOW, 0, 0), true);
+	ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 0, 0), true);
+
+	ASSERT_EQ(symlinkat(FILE1, dir_fd, SYMLINK_USER2), 0);
+	ASSERT_EQ(fchownat(dir_fd, SYMLINK_USER2, 1000, 1000, AT_SYMLINK_NOFOLLOW), 0);
+	ASSERT_EQ(expected_uid_gid(dir_fd, SYMLINK_USER2, AT_SYMLINK_NOFOLLOW, 1000, 1000), true);
+	ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 0, 0), true);
+
+	ASSERT_EQ(symlinkat(FILE1, dir_fd, SYMLINK_USER3), 0);
+	ASSERT_EQ(fchownat(dir_fd, SYMLINK_USER3, 2000, 2000, AT_SYMLINK_NOFOLLOW), 0);
+	ASSERT_EQ(expected_uid_gid(dir_fd, SYMLINK_USER3, AT_SYMLINK_NOFOLLOW, 2000, 2000), true);
+	ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 0, 0), true);
+
+	/* validate file can be directly read */
+	fd = openat(dir_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(close(fd), 0);
+
+	/* validate file can be read through own symlink */
+	fd = openat(dir_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(close(fd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		/* validate file can be directly read */
+		fd = openat(dir_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through own symlink */
+		fd = openat(dir_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through root symlink */
+		fd = openat(dir_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(dir_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_LT(fd, 0);
+		ASSERT_EQ(errno, EACCES);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(2000, 2000, 2000), 0);
+		ASSERT_EQ(setresuid(2000, 2000, 2000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		/* validate file can be directly read */
+		fd = openat(dir_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through own symlink */
+		fd = openat(dir_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through root symlink */
+		fd = openat(dir_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(dir_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_LT(fd, 0);
+		ASSERT_EQ(errno, EACCES);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+}
+
+/**
+ * Validate that protected symlinks work correctly on idmapped mounts.
+ */
+TEST_F(core, follow_symlinks_idmapped)
+{
+	int dir_fd = -EBADF, fd = -EBADF, open_tree_fd = -EBADF;
+	pid_t pid;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (!symlinks_protected())
+		SKIP(return, "Symlinks are not protected. Skipping test");
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0000), 0);
+	dir_fd = openat(self->img_mnt_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dir_fd, 0);
+	ASSERT_EQ(fchown(dir_fd, 10000, 10000), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 10000, 10000, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create symlinks */
+	ASSERT_EQ(symlinkat(FILE1, dir_fd, SYMLINK_USER1), 0);
+	ASSERT_EQ(fchownat(dir_fd, SYMLINK_USER1, 10000, 10000, AT_SYMLINK_NOFOLLOW), 0);
+	ASSERT_EQ(expected_uid_gid(dir_fd, SYMLINK_USER1, AT_SYMLINK_NOFOLLOW, 10000, 10000), true);
+	ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 10000, 10000), true);
+
+	ASSERT_EQ(symlinkat(FILE1, dir_fd, SYMLINK_USER2), 0);
+	ASSERT_EQ(fchownat(dir_fd, SYMLINK_USER2, 11000, 11000, AT_SYMLINK_NOFOLLOW), 0);
+	ASSERT_EQ(expected_uid_gid(dir_fd, SYMLINK_USER2, AT_SYMLINK_NOFOLLOW, 11000, 11000), true);
+	ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 10000, 10000), true);
+
+	ASSERT_EQ(symlinkat(FILE1, dir_fd, SYMLINK_USER3), 0);
+	ASSERT_EQ(fchownat(dir_fd, SYMLINK_USER3, 12000, 12000, AT_SYMLINK_NOFOLLOW), 0);
+	ASSERT_EQ(expected_uid_gid(dir_fd, SYMLINK_USER3, AT_SYMLINK_NOFOLLOW, 12000, 12000), true);
+	ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 10000, 10000), true);
+
+	/* Create detached mount. */
+	open_tree_fd = sys_open_tree(self->img_mnt_fd, DIR1,
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(10000, 0, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH | AT_RECURSIVE, &attr,
+				    sizeof(attr)), 0) {
+		TH_LOG("%m - Failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       open_tree_fd, self->test_dir_path);
+	}
+
+	/* validate file can be directly read */
+	fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(close(fd), 0);
+
+	/* validate file can be read through own symlink */
+	fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(close(fd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		/* validate file can be directly read */
+		fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through own symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through root symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_LT(fd, 0);
+		ASSERT_EQ(errno, EACCES);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setresgid(2000, 2000, 2000), 0);
+		ASSERT_EQ(setresuid(2000, 2000, 2000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		/* validate file can be directly read */
+		fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through own symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through root symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_LT(fd, 0);
+		ASSERT_EQ(errno, EACCES);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(dir_fd), 0);
+	ASSERT_EQ(close(open_tree_fd), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+/**
+ * Validate that protected symlinks work correctly on idmapped mounts inside a
+ * user namespace.
+ */
+TEST_F(core, follow_symlinks_idmapped_userns)
+{
+	int dir_fd = -EBADF, fd = -EBADF, open_tree_fd = -EBADF;
+	pid_t pid;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (!symlinks_protected())
+		SKIP(return, "Symlinks are not protected. Skipping test");
+
+	/* create directory */
+	ASSERT_EQ(mkdirat(self->img_mnt_fd, DIR1, 0000), 0);
+	dir_fd = openat(self->img_mnt_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dir_fd, 0);
+	ASSERT_EQ(fchown(dir_fd, 0, 0), 0);
+	ASSERT_EQ(fchmod(dir_fd, 0777 | S_ISVTX), 0);
+	/* validate sticky bit is set */
+	ASSERT_EQ(is_sticky(self->img_mnt_fd, DIR1, 0), true);
+
+	/* create regular file via mknod */
+	ASSERT_EQ(mknodat(dir_fd, FILE1, S_IFREG | 0000, 0), 0);
+	ASSERT_EQ(fchownat(dir_fd, FILE1, 0, 0, 0), 0);
+	ASSERT_EQ(fchmodat(dir_fd, FILE1, 0644, 0), 0);
+
+	/* create symlinks */
+	ASSERT_EQ(symlinkat(FILE1, dir_fd, SYMLINK_USER1), 0);
+	ASSERT_EQ(fchownat(dir_fd, SYMLINK_USER1, 0, 0, AT_SYMLINK_NOFOLLOW), 0);
+	ASSERT_EQ(expected_uid_gid(dir_fd, SYMLINK_USER1, AT_SYMLINK_NOFOLLOW, 0, 0), true);
+	ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 0, 0), true);
+
+	ASSERT_EQ(symlinkat(FILE1, dir_fd, SYMLINK_USER2), 0);
+	ASSERT_EQ(fchownat(dir_fd, SYMLINK_USER2, 1000, 1000, AT_SYMLINK_NOFOLLOW), 0);
+	ASSERT_EQ(expected_uid_gid(dir_fd, SYMLINK_USER2, AT_SYMLINK_NOFOLLOW, 1000, 1000), true);
+	ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 0, 0), true);
+
+	ASSERT_EQ(symlinkat(FILE1, dir_fd, SYMLINK_USER3), 0);
+	ASSERT_EQ(fchownat(dir_fd, SYMLINK_USER3, 2000, 2000, AT_SYMLINK_NOFOLLOW), 0);
+	ASSERT_EQ(expected_uid_gid(dir_fd, SYMLINK_USER3, AT_SYMLINK_NOFOLLOW, 2000, 2000), true);
+	ASSERT_EQ(expected_uid_gid(dir_fd, FILE1, 0, 0, 0), true);
+
+	/* Create detached mount. */
+	open_tree_fd = sys_open_tree(self->img_mnt_fd, DIR1,
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH | AT_RECURSIVE, &attr,
+				    sizeof(attr)), 0) {
+		TH_LOG("%m - Failed to idmap mount %d(%s/" MNT_TARGET1 ")",
+		       open_tree_fd, self->test_dir_path);
+	}
+
+	/* validate file can be directly read */
+	fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(close(fd), 0);
+
+	/* validate file can be read through own symlink */
+	fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(close(fd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(1000, 1000, 1000), 0);
+		ASSERT_EQ(setresuid(1000, 1000, 1000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		/* validate file can be directly read */
+		fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through own symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through root symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_LT(fd, 0);
+		ASSERT_EQ(errno, EACCES);
+
+		exit(EXIT_SUCCESS);
+	}
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ASSERT_EQ(setns(attr.userns_fd, CLONE_NEWUSER), 0);
+		ASSERT_EQ(setresgid(2000, 2000, 2000), 0);
+		ASSERT_EQ(setresuid(2000, 2000, 2000), 0);
+		ASSERT_EQ(caps_down(), true);
+
+		/* validate file can be directly read */
+		fd = openat(open_tree_fd, FILE1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through own symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER3, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can be read through root symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER1, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_GE(fd, 0);
+		ASSERT_EQ(close(fd), 0);
+
+		/* validate file can't be read through other users symlink */
+		fd = openat(open_tree_fd, SYMLINK_USER2, O_RDONLY | O_CLOEXEC, 0);
+		ASSERT_LT(fd, 0);
+		ASSERT_EQ(errno, EACCES);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(close(dir_fd), 0);
+	ASSERT_EQ(close(open_tree_fd), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/idmap_mounts/internal.h b/tools/testing/selftests/idmap_mounts/internal.h
index 252803f35d71..a7d648c305cc 100644
--- a/tools/testing/selftests/idmap_mounts/internal.h
+++ b/tools/testing/selftests/idmap_mounts/internal.h
@@ -4,8 +4,16 @@
 #define __IDMAP_INTERNAL_H
 
 #define _GNU_SOURCE
-
-#include "../kselftest_harness.h"
+#include <errno.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/types.h>
+#include <unistd.h>
 
 #ifndef __NR_mount_setattr
 	#if defined __alpha__
@@ -26,6 +34,14 @@
 		#define __NR_mount_setattr 441
 	#endif
 
+struct mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u64 propagation;
+	__u64 userns_fd;
+};
+#endif
+
 #ifndef __NR_open_tree
 	#if defined __alpha__
 		#define __NR_open_tree 538
@@ -66,15 +82,6 @@
 	#endif
 #endif
 
-
-struct mount_attr {
-	__u64 attr_set;
-	__u64 attr_clr;
-	__u64 propagation;
-	__u64 userns;
-};
-#endif
-
 #ifndef MOVE_MOUNT_F_EMPTY_PATH
 #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
 #endif
@@ -95,6 +102,10 @@ struct mount_attr {
 #define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
 #endif
 
+#ifndef MAKE_PROPAGATION_PRIVATE
+#define MAKE_PROPAGATION_PRIVATE 2
+#endif
+
 static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flags,
 				    struct mount_attr *attr, size_t size)
 {
diff --git a/tools/testing/selftests/idmap_mounts/utils.c b/tools/testing/selftests/idmap_mounts/utils.c
new file mode 100644
index 000000000000..34ea3a7f9393
--- /dev/null
+++ b/tools/testing/selftests/idmap_mounts/utils.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <linux/limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "internal.h"
+
+ssize_t read_nointr(int fd, void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = read(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = write(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+static int write_file(const char *path, const void *buf, size_t count)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
+	if (fd < 0)
+		return -1;
+
+	ret = write_nointr(fd, buf, count);
+	close(fd);
+	if (ret < 0 || (size_t)ret != count)
+		return -1;
+
+	return 0;
+}
+
+static int map_ids(pid_t pid, unsigned long nsid, unsigned long hostid,
+		   unsigned long range)
+{
+	char map[100], procfile[256];
+
+	snprintf(procfile, sizeof(procfile), "/proc/%d/setgroups", pid);
+	if (write_file(procfile, "deny", sizeof("deny") - 1) &&
+	    errno != ENOENT)
+		return -1;
+
+	snprintf(procfile, sizeof(procfile), "/proc/%d/uid_map", pid);
+	snprintf(map, sizeof(map), "%lu %lu %lu", nsid, hostid, range);
+	if (write_file(procfile, map, strlen(map)))
+		return -1;
+
+
+	snprintf(procfile, sizeof(procfile), "/proc/%d/gid_map", pid);
+	snprintf(map, sizeof(map), "%lu %lu %lu", nsid, hostid, range);
+	if (write_file(procfile, map, strlen(map)))
+		return -1;
+
+	return 0;
+}
+
+#define __STACK_SIZE (8 * 1024 * 1024)
+pid_t do_clone(int (*fn)(void *), void *arg, int flags)
+{
+	void *stack;
+
+	stack = malloc(__STACK_SIZE);
+	if (!stack)
+		return -ENOMEM;
+
+#ifdef __ia64__
+	return __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#else
+	return clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#endif
+}
+
+static int get_userns_fd_cb(void *data)
+{
+	return kill(getpid(), SIGSTOP);
+}
+
+int get_userns_fd(unsigned long nsid, unsigned long hostid, unsigned long range)
+{
+	int ret;
+	pid_t pid;
+	char path[256];
+
+	pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER | CLONE_NEWNS);
+	if (pid < 0)
+		return -errno;
+
+	ret = map_ids(pid, nsid, hostid, range);
+	if (ret < 0)
+		return ret;
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	ret = open(path, O_RDONLY | O_CLOEXEC);
+	kill(pid, SIGKILL);
+	return ret;
+}
+
+int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
diff --git a/tools/testing/selftests/idmap_mounts/utils.h b/tools/testing/selftests/idmap_mounts/utils.h
new file mode 100644
index 000000000000..1f52997af99d
--- /dev/null
+++ b/tools/testing/selftests/idmap_mounts/utils.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __IDMAP_UTILS_H
+#define __IDMAP_UTILS_H
+
+#define _GNU_SOURCE
+
+#include "../kselftest_harness.h"
+
+extern pid_t do_clone(int (*fn)(void *), void *arg, int flags);
+extern int get_userns_fd(unsigned long nsid, unsigned long hostid,
+			 unsigned long range);
+extern ssize_t read_nointr(int fd, void *buf, size_t count);
+extern int wait_for_pid(pid_t pid);
+extern ssize_t write_nointr(int fd, const void *buf, size_t count);
+
+#endif /* __IDMAP_UTILS_H */
diff --git a/tools/testing/selftests/idmap_mounts/xattr.c b/tools/testing/selftests/idmap_mounts/xattr.c
index 58e88f92f958..0625e3fe53ac 100644
--- a/tools/testing/selftests/idmap_mounts/xattr.c
+++ b/tools/testing/selftests/idmap_mounts/xattr.c
@@ -8,102 +8,9 @@
 #include <linux/limits.h>
 
 #include "internal.h"
+#include "utils.h"
 #include "../kselftest_harness.h"
 
-static ssize_t write_nointr(int fd, const void *buf, size_t count)
-{
-	ssize_t ret;
-
-	do {
-		ret = write(fd, buf, count);
-	} while (ret < 0 && errno == EINTR);
-
-	return ret;
-}
-
-static int write_file(const char *path, const void *buf, size_t count)
-{
-	int fd;
-	ssize_t ret;
-
-	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
-	if (fd < 0)
-		return -1;
-
-	ret = write_nointr(fd, buf, count);
-	close(fd);
-	if (ret < 0 || (size_t)ret != count)
-		return -1;
-
-	return 0;
-}
-
-static int map_ids(pid_t pid, unsigned long nsid, unsigned long hostid,
-		   unsigned long range)
-{
-	char map[100], procfile[256];
-
-	snprintf(procfile, sizeof(procfile), "/proc/%d/setgroups", pid);
-	if (write_file(procfile, "deny", sizeof("deny") - 1) &&
-	    errno != ENOENT)
-		return -1;
-
-	snprintf(procfile, sizeof(procfile), "/proc/%d/uid_map", pid);
-	snprintf(map, sizeof(map), "%lu %lu %lu", nsid, hostid, range);
-	if (write_file(procfile, map, strlen(map)))
-		return -1;
-
-
-	snprintf(procfile, sizeof(procfile), "/proc/%d/gid_map", pid);
-	snprintf(map, sizeof(map), "%lu %lu %lu", nsid, hostid, range);
-	if (write_file(procfile, map, strlen(map)))
-		return -1;
-
-	return 0;
-}
-
-#define __STACK_SIZE (8 * 1024 * 1024)
-static pid_t do_clone(int (*fn)(void *), void *arg, int flags)
-{
-	void *stack;
-
-	stack = malloc(__STACK_SIZE);
-	if (!stack)
-		return -ENOMEM;
-
-#ifdef __ia64__
-	return __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, NULL);
-#else
-	return clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, NULL);
-#endif
-}
-
-static int get_userns_fd_cb(void *data)
-{
-	return kill(getpid(), SIGSTOP);
-}
-
-static int get_userns_fd(unsigned long nsid, unsigned long hostid,
-			 unsigned long range)
-{
-	int ret;
-	pid_t pid;
-	char path[256];
-
-	pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER | CLONE_NEWNS);
-	if (pid < 0)
-		return -errno;
-
-	ret = map_ids(pid, nsid, hostid, range);
-	if (ret < 0)
-		return ret;
-
-	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
-	ret = open(path, O_RDONLY | O_CLOEXEC);
-	kill(pid, SIGKILL);
-	return ret;
-}
-
 struct run_as_data {
 	int userns;
 	int (*f)(void *data);
@@ -132,25 +39,6 @@ static int run_in_cb(void *data)
 	return rad->f(rad->data);
 }
 
-static int wait_for_pid(pid_t pid)
-{
-	int status, ret;
-
-again:
-	ret = waitpid(pid, &status, 0);
-	if (ret == -1) {
-		if (errno == EINTR)
-			goto again;
-
-		return -1;
-	}
-
-	if (!WIFEXITED(status))
-		return -1;
-
-	return WEXITSTATUS(status);
-}
-
 static int run_in(int userns, int (*f)(void *), void *f_data)
 {
 	pid_t pid;
@@ -245,8 +133,8 @@ TEST_F(ext4_xattr, setattr_didnt_work)
 				 MOVE_MOUNT_F_EMPTY_PATH), 0);
 
 	attr.attr_set = MOUNT_ATTR_IDMAP;
-	attr.userns = get_userns_fd(100010, 100020, 5);
-	ASSERT_GE(attr.userns, 0);
+	attr.userns_fd = get_userns_fd(100010, 100020, 5);
+	ASSERT_GE(attr.userns_fd, 0);
 	ret = sys_mount_setattr(mount_fd, "", AT_EMPTY_PATH | AT_RECURSIVE,
 				    &attr, sizeof(attr));
 	ASSERT_EQ(close(mount_fd), 0);
@@ -261,24 +149,24 @@ TEST_F(ext4_xattr, setattr_didnt_work)
 
 	snprintf(ssb.path, sizeof(ssb.path), "/tmp/ext4/source/foo");
 	ssb.uid = 4294967295;
-	EXPECT_EQ(run_in(attr.userns, getacl_should_be_uid, &ssb), 0);
+	EXPECT_EQ(run_in(attr.userns_fd, getacl_should_be_uid, &ssb), 0);
 
 	snprintf(ssb.path, sizeof(ssb.path), "/tmp/ext4/dest/foo");
 	ssb.uid = 100010;
-	EXPECT_EQ(run_in(attr.userns, getacl_should_be_uid, &ssb), 0);
+	EXPECT_EQ(run_in(attr.userns_fd, getacl_should_be_uid, &ssb), 0);
 
 	/*
 	 * now, dir is owned by someone else in the user namespace, but we can
 	 * still read it because of acls
 	 */
 	ASSERT_EQ(chown("/tmp/ext4/source/foo", 100012, 100012), 0);
-	EXPECT_EQ(run_in(attr.userns, ls_path, "/tmp/ext4/dest/foo"), 0);
+	EXPECT_EQ(run_in(attr.userns_fd, ls_path, "/tmp/ext4/dest/foo"), 0);
 
 	/*
 	 * if we delete the acls, the ls should fail because it's 700.
 	 */
 	ASSERT_EQ(system("setfacl --remove-all /tmp/ext4/source/foo"), 0);
-	EXPECT_NE(run_in(attr.userns, ls_path, "/tmp/ext4/dest/foo"), 0);
+	EXPECT_NE(run_in(attr.userns_fd, ls_path, "/tmp/ext4/dest/foo"), 0);
 }
 
 TEST_HARNESS_MAIN
-- 
2.29.2

