Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6891E29DDF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733175AbgJ2Afq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:35:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60742 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbgJ2Afk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:40 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvug-0008Ep-5s; Thu, 29 Oct 2020 00:35:34 +0000
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
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
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
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 13/34] selftests: add idmapped mounts xattr selftest
Date:   Thu, 29 Oct 2020 01:32:31 +0100
Message-Id: <20201029003252.2128653-14-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tycho Andersen <tycho@tycho.pizza>

Add some tests for setting extended attributes on idmapped mounts.

Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 .../testing/selftests/idmap_mounts/.gitignore |   1 +
 tools/testing/selftests/idmap_mounts/Makefile |   8 +
 tools/testing/selftests/idmap_mounts/config   |   1 +
 tools/testing/selftests/idmap_mounts/xattr.c  | 389 ++++++++++++++++++
 4 files changed, 399 insertions(+)
 create mode 100644 tools/testing/selftests/idmap_mounts/.gitignore
 create mode 100644 tools/testing/selftests/idmap_mounts/Makefile
 create mode 100644 tools/testing/selftests/idmap_mounts/config
 create mode 100644 tools/testing/selftests/idmap_mounts/xattr.c

diff --git a/tools/testing/selftests/idmap_mounts/.gitignore b/tools/testing/selftests/idmap_mounts/.gitignore
new file mode 100644
index 000000000000..18c5e90522ad
--- /dev/null
+++ b/tools/testing/selftests/idmap_mounts/.gitignore
@@ -0,0 +1 @@
+xattr
diff --git a/tools/testing/selftests/idmap_mounts/Makefile b/tools/testing/selftests/idmap_mounts/Makefile
new file mode 100644
index 000000000000..ce0549b09b2a
--- /dev/null
+++ b/tools/testing/selftests/idmap_mounts/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for mount selftests.
+CFLAGS = -g -I../../../../usr/include/ -Wall -O2 -pthread
+
+TEST_GEN_FILES += xattr
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/idmap_mounts/config b/tools/testing/selftests/idmap_mounts/config
new file mode 100644
index 000000000000..80730abc534b
--- /dev/null
+++ b/tools/testing/selftests/idmap_mounts/config
@@ -0,0 +1 @@
+CONFIG_IDMAP_MOUNTS=y
diff --git a/tools/testing/selftests/idmap_mounts/xattr.c b/tools/testing/selftests/idmap_mounts/xattr.c
new file mode 100644
index 000000000000..a3d70294ce43
--- /dev/null
+++ b/tools/testing/selftests/idmap_mounts/xattr.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <linux/limits.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef __NR_mount_setattr
+	#if defined __alpha__
+		#define __NR_mount_setattr 551
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_mount_setattr 4441
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_mount_setattr 6441
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_mount_setattr 5441
+		#endif
+	#elif defined __ia64__
+		#define __NR_mount_setattr (441 + 1024)
+	#else
+		#define __NR_mount_setattr 441
+	#endif
+
+#ifndef __NR_open_tree
+	#if defined __alpha__
+		#define __NR_open_tree 538
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_open_tree 4428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_open_tree 6428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_open_tree 5428
+		#endif
+	#elif defined __ia64__
+		#define __NR_open_tree (428 + 1024)
+	#else
+		#define __NR_open_tree 428
+	#endif
+#endif
+
+#ifndef __NR_move_mount
+	#if defined __alpha__
+		#define __NR_move_mount 539
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_move_mount 4429
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_move_mount 6429
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_move_mount 5429
+		#endif
+	#elif defined __ia64__
+		#define __NR_move_mount (428 + 1024)
+	#else
+		#define __NR_move_mount 429
+	#endif
+#endif
+
+
+struct mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u64 propagation;
+	__u32 userns;
+};
+#endif
+
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
+#endif
+
+#ifndef MOUNT_ATTR_SHIFT
+#define MOUNT_ATTR_SHIFT 0x00100000
+#endif
+
+#ifndef OPEN_TREE_CLONE
+#define OPEN_TREE_CLONE 1
+#endif
+
+#ifndef OPEN_TREE_CLOEXEC
+#define OPEN_TREE_CLOEXEC O_CLOEXEC
+#endif
+
+#ifndef AT_RECURSIVE
+#define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
+#endif
+
+static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flags,
+				    struct mount_attr *attr, size_t size)
+{
+	return syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
+}
+
+static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
+{
+	return syscall(__NR_open_tree, dfd, filename, flags);
+}
+
+static inline int sys_move_mount(int from_dfd, const char *from_pathname, int to_dfd,
+				 const char *to_pathname, unsigned int flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
+}
+
+
+static ssize_t write_nointr(int fd, const void *buf, size_t count)
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
+static pid_t do_clone(int (*fn)(void *), void *arg, int flags)
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
+static int get_userns_fd(unsigned long nsid, unsigned long hostid,
+			 unsigned long range)
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
+struct run_as_data {
+	int userns;
+	int (*f)(void *data);
+	void *data;
+};
+
+static int run_in_cb(void *data)
+{
+	struct run_as_data *rad = data;
+
+	if (setns(rad->userns, CLONE_NEWUSER) < 0) {
+		perror("setns");
+		return 1;
+	}
+
+	if (setuid(100010)) {
+		perror("setuid");
+		return 1;
+	}
+
+	if (setgid(100010)) {
+		perror("setgid");
+		return 1;
+	}
+
+	return rad->f(rad->data);
+}
+
+static int wait_for_pid(pid_t pid)
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
+
+static int run_in(int userns, int (*f)(void *), void *f_data)
+{
+	pid_t pid;
+	struct run_as_data data;
+
+	data.userns = userns;
+	data.f = f;
+	data.data = f_data;
+	pid = do_clone(run_in_cb, &data, 0);
+	if (pid < 0)
+		return -errno;
+
+	return wait_for_pid(pid);
+}
+
+FIXTURE(ext4_xattr) {};
+
+FIXTURE_SETUP(ext4_xattr)
+{
+	int fd;
+
+	fd = open("/tmp/idmap_mounts.ext4", O_CREAT | O_WRONLY, 0600);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(ftruncate(fd, 640 * 1024), 0);
+	ASSERT_EQ(close(fd), 0);
+	ASSERT_EQ(system("mkfs.ext4 /tmp/idmap_mounts.ext4"), 0);
+	ASSERT_EQ(mkdir("/tmp/ext4", 0777), 0);
+	ASSERT_EQ(system("mount -o loop -t ext4 /tmp/idmap_mounts.ext4 /tmp/ext4"), 0);
+}
+
+FIXTURE_TEARDOWN(ext4_xattr)
+{
+	umount("/tmp/ext4/dest");
+	umount("/tmp/ext4");
+	rmdir("/tmp/ext4");
+	unlink("/tmp/idmap_mounts.ext4");
+}
+
+struct getacl_should_be_data {
+	char path[256];
+	uid_t uid;
+};
+
+static int getacl_should_be_uid(void *data)
+{
+	struct getacl_should_be_data *ssb = data;
+	char cmd[512];
+	int ret;
+
+	snprintf(cmd, sizeof(cmd), "getfacl %s | grep user:%u:rwx", ssb->path, ssb->uid);
+	ret = system(cmd);
+	if (ret < 0) {
+		perror("system");
+		return -1;
+	}
+	if (!WIFEXITED(ret))
+		return -1;
+	return WEXITSTATUS(ret);
+}
+
+static int ls_path(void *data)
+{
+	char cmd[PATH_MAX];
+	char *path = data;
+	int ret;
+
+	snprintf(cmd, sizeof(cmd), "ls %s", path);
+	ret = system(cmd);
+	if (ret < 0) {
+		perror("system");
+		return -1;
+	}
+	if (!WIFEXITED(ret))
+		return -1;
+	return WEXITSTATUS(ret);
+}
+
+TEST_F(ext4_xattr, setattr_didnt_work)
+{
+	int mount_fd, ret;
+	struct mount_attr attr = {};
+	struct getacl_should_be_data ssb;
+
+	ASSERT_EQ(mkdir("/tmp/ext4/source", 0777), 0);
+	ASSERT_EQ(mkdir("/tmp/ext4/dest", 0777), 0);
+
+	mount_fd = sys_open_tree(-EBADF, "/tmp/ext4/source",
+				 OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC | AT_EMPTY_PATH);
+	ASSERT_GE(mount_fd, 0);
+
+	ASSERT_EQ(sys_move_mount(mount_fd, "", -EBADF, "/tmp/ext4/dest",
+				 MOVE_MOUNT_F_EMPTY_PATH), 0);
+
+	attr.attr_set = MOUNT_ATTR_SHIFT;
+	attr.userns = get_userns_fd(100010, 100020, 5);
+	ASSERT_GE(attr.userns, 0);
+	ret = sys_mount_setattr(mount_fd, "", AT_EMPTY_PATH | AT_RECURSIVE,
+				    &attr, sizeof(attr));
+	ASSERT_EQ(close(mount_fd), 0);
+	ASSERT_EQ(ret, 0);
+
+	ASSERT_EQ(mkdir("/tmp/ext4/source/foo", 0700), 0);
+	ASSERT_EQ(chown("/tmp/ext4/source/foo", 100010, 100010), 0);
+
+	ASSERT_EQ(system("setfacl -m u:100010:rwx /tmp/ext4/source/foo"), 0);
+	EXPECT_EQ(system("getfacl /tmp/ext4/source/foo | grep user:100010:rwx"), 0);
+	EXPECT_EQ(system("getfacl /tmp/ext4/dest/foo | grep user:100020:rwx"), 0);
+
+	snprintf(ssb.path, sizeof(ssb.path), "/tmp/ext4/source/foo");
+	ssb.uid = 4294967295;
+	EXPECT_EQ(run_in(attr.userns, getacl_should_be_uid, &ssb), 0);
+
+	snprintf(ssb.path, sizeof(ssb.path), "/tmp/ext4/dest/foo");
+	ssb.uid = 100010;
+	EXPECT_EQ(run_in(attr.userns, getacl_should_be_uid, &ssb), 0);
+
+	/*
+	 * now, dir is owned by someone else in the user namespace, but we can
+	 * still read it because of acls
+	 */
+	ASSERT_EQ(chown("/tmp/ext4/source/foo", 100012, 100012), 0);
+	EXPECT_EQ(run_in(attr.userns, ls_path, "/tmp/ext4/dest/foo"), 0);
+
+	/*
+	 * if we delete the acls, the ls should fail because it's 700.
+	 */
+	ASSERT_EQ(system("setfacl --remove-all /tmp/ext4/source/foo"), 0);
+	EXPECT_NE(run_in(attr.userns, ls_path, "/tmp/ext4/dest/foo"), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.29.0

