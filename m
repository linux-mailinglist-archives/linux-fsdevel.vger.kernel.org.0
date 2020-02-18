Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670641628A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBROiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 09:38:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53228 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgBROiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:38:11 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j43yF-0000fF-7e; Tue, 18 Feb 2020 14:35:31 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 25/25] selftests: add simple fsid mapping selftests
Date:   Tue, 18 Feb 2020 15:34:11 +0100
Message-Id: <20200218143411.2389182-26-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Verify that fsid mappings cannot be written when if mappings have been
  written already.
- Set up an id mapping and an fsid mapping, create a file and compare ids in
  child and parent user namespace.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
patch added
---
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/user_namespace/Makefile |  11 +
 .../selftests/user_namespace/test_fsid_map.c  | 511 ++++++++++++++++++
 3 files changed, 523 insertions(+)
 create mode 100644 tools/testing/selftests/user_namespace/Makefile
 create mode 100644 tools/testing/selftests/user_namespace/test_fsid_map.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 63430e2664c2..49dcd21d2be7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -60,6 +60,7 @@ endif
 TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += user
+TARGETS += user_namespace
 TARGETS += vm
 TARGETS += x86
 TARGETS += zram
diff --git a/tools/testing/selftests/user_namespace/Makefile b/tools/testing/selftests/user_namespace/Makefile
new file mode 100644
index 000000000000..3f89896f3285
--- /dev/null
+++ b/tools/testing/selftests/user_namespace/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wall
+
+all:
+
+TEST_GEN_PROGS += test_fsid_map
+
+include ../lib.mk
+
+$(OUTPUT)/test_fsid_map: test_fsid_map.c ../clone3/clone3_selftests.h
+
diff --git a/tools/testing/selftests/user_namespace/test_fsid_map.c b/tools/testing/selftests/user_namespace/test_fsid_map.c
new file mode 100644
index 000000000000..e278f137ff55
--- /dev/null
+++ b/tools/testing/selftests/user_namespace/test_fsid_map.c
@@ -0,0 +1,511 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <grp.h>
+#include <inttypes.h>
+#include <libgen.h>
+#include <stdbool.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/sched.h>
+#include <sys/fsuid.h>
+#include <sys/mount.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "../clone3/clone3_selftests.h"
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
+static int setid_userns_root(void)
+{
+	if (setuid(0))
+		return -1;
+	if (setgid(0))
+		return -1;
+
+	setfsuid(0);
+	setfsgid(0);
+
+	if (setfsuid(0))
+		return -1;
+
+	if (setfsgid(0))
+		return -1;
+
+	return 0;
+}
+
+enum idmap_type {
+	UID_MAP,
+	GID_MAP,
+	FSUID_MAP,
+	FSGID_MAP,
+};
+
+static ssize_t read_nointr(int fd, void *buf, size_t count)
+{
+	ssize_t ret;
+again:
+	ret = read(fd, buf, count);
+	if (ret < 0 && errno == EINTR)
+		goto again;
+
+	return ret;
+}
+
+static ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+again:
+	ret = write(fd, buf, count);
+	if (ret < 0 && errno == EINTR)
+		goto again;
+
+	return ret;
+}
+
+static int write_id_mapping(enum idmap_type type, pid_t pid, const char *buf,
+			    size_t buf_size)
+{
+	int fd;
+	int ret;
+	char path[4096];
+
+	switch (type) {
+	case UID_MAP:
+		ret = snprintf(path, sizeof(path), "/proc/%d/uid_map", pid);
+		break;
+	case GID_MAP:
+		ret = snprintf(path, sizeof(path), "/proc/%d/gid_map", pid);
+		break;
+	case FSUID_MAP:
+		ret = snprintf(path, sizeof(path), "/proc/%d/fsuid_map", pid);
+		break;
+	case FSGID_MAP:
+		ret = snprintf(path, sizeof(path), "/proc/%d/fsgid_map", pid);
+		break;
+	default:
+		return -1;
+	}
+	if (ret < 0 || ret >= sizeof(path))
+		return -E2BIG;
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -1;
+
+	ret = write_nointr(fd, buf, buf_size);
+	close(fd);
+	if (ret != buf_size)
+		return -1;
+
+	return 0;
+}
+
+const char id_map[] = "0 100000 100000";
+#define id_map_size (sizeof(id_map) - 1)
+
+const char fsid_map[] = "0 300000 100000";
+#define fsid_map_size (sizeof(fsid_map) - 1)
+
+int unix_send_fds_iov(int fd, int *sendfds, int num_sendfds, struct iovec *iov,
+		      size_t iovlen)
+{
+	char *cmsgbuf = NULL;
+	int ret;
+	struct msghdr msg;
+	struct cmsghdr *cmsg = NULL;
+	size_t cmsgbufsize = CMSG_SPACE(num_sendfds * sizeof(int));
+
+	memset(&msg, 0, sizeof(msg));
+
+	cmsgbuf = malloc(cmsgbufsize);
+	if (!cmsgbuf) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	msg.msg_control = cmsgbuf;
+	msg.msg_controllen = cmsgbufsize;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(num_sendfds * sizeof(int));
+
+	msg.msg_controllen = cmsg->cmsg_len;
+
+	memcpy(CMSG_DATA(cmsg), sendfds, num_sendfds * sizeof(int));
+
+	msg.msg_iov = iov;
+	msg.msg_iovlen = iovlen;
+
+again:
+	ret = sendmsg(fd, &msg, MSG_NOSIGNAL);
+	if (ret < 0)
+		if (errno == EINTR)
+			goto again;
+
+	free(cmsgbuf);
+	return ret;
+}
+
+static int unix_send_fds(int fd, int *sendfds, int num_sendfds, void *data,
+			 size_t size)
+{
+	char buf[1] = {0};
+	struct iovec iov = {
+		.iov_base = data ? data : buf,
+		.iov_len = data ? size : sizeof(buf),
+	};
+	return unix_send_fds_iov(fd, sendfds, num_sendfds, &iov, 1);
+}
+
+static int unix_recv_fds_iov(int fd, int *recvfds, int num_recvfds,
+			     struct iovec *iov, size_t iovlen)
+{
+	char *cmsgbuf = NULL;
+	int ret;
+	struct msghdr msg;
+	struct cmsghdr *cmsg = NULL;
+	size_t cmsgbufsize = CMSG_SPACE(sizeof(struct ucred)) +
+			     CMSG_SPACE(num_recvfds * sizeof(int));
+
+	memset(&msg, 0, sizeof(msg));
+
+	cmsgbuf = malloc(cmsgbufsize);
+	if (!cmsgbuf) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	msg.msg_control = cmsgbuf;
+	msg.msg_controllen = cmsgbufsize;
+
+	msg.msg_iov = iov;
+	msg.msg_iovlen = iovlen;
+
+again:
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0) {
+		if (errno == EINTR)
+			goto again;
+
+		goto out;
+	}
+	if (ret == 0)
+		goto out;
+
+	/*
+	 * If SO_PASSCRED is set we will always get a ucred message.
+	 */
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_type != SCM_RIGHTS)
+			continue;
+
+		memset(recvfds, -1, num_recvfds * sizeof(int));
+		if (cmsg &&
+		    cmsg->cmsg_len == CMSG_LEN(num_recvfds * sizeof(int)) &&
+		    cmsg->cmsg_level == SOL_SOCKET)
+			memcpy(recvfds, CMSG_DATA(cmsg), num_recvfds * sizeof(int));
+		break;
+	}
+
+out:
+	free(cmsgbuf);
+	return ret;
+}
+
+static int unix_recv_fds(int fd, int *recvfds, int num_recvfds, void *data,
+			 size_t size)
+{
+	char buf[1] = {0};
+	struct iovec iov = {
+		.iov_base = data ? data : buf,
+		.iov_len = data ? size : sizeof(buf),
+	};
+	return unix_recv_fds_iov(fd, recvfds, num_recvfds, &iov, 1);
+}
+
+static bool has_expected_owner(int fd, uid_t uid, gid_t gid)
+{
+	int ret;
+	struct stat s;
+	ret = fstat(fd, &s);
+	return !ret && s.st_uid == uid && s.st_gid == gid;
+}
+
+static int make_file_cmp_owner(uid_t uid, gid_t gid)
+{
+	char template[] = P_tmpdir "/.fsid_map_test_XXXXXX";
+	int fd;
+
+	fd = mkstemp(template);
+	if (fd < 0)
+		return -1;
+	unlink(template);
+
+	if (!has_expected_owner(fd, uid, gid)) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+static void test_id_maps_imply_fsid_maps(void)
+{
+	int fret = EXIT_FAILURE;
+	ssize_t ret;
+	int fd = -EBADF;
+	pid_t pid;
+	int ipc[2];
+	struct clone_args args = {
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
+	};
+
+	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc);
+	if (ret < 0)
+		ksft_exit_fail_msg("socketpair() failed\n");
+
+	pid = sys_clone3(&args, sizeof(args));
+	if (pid < 0) {
+		close(ipc[0]);
+		close(ipc[1]);
+		ksft_exit_fail_msg("clone3() failed\n");
+	}
+
+	if (pid == 0) {
+		int fd;
+		char buf;
+
+		close(ipc[1]);
+
+		ret = read_nointr(ipc[0], &buf, 1);
+		if (ret != 1)
+			ksft_exit_fail_msg("read_nointr() failed\n");
+
+		if (setid_userns_root())
+			ksft_exit_fail_msg("setid_userns_root() failed\n");
+
+		fd = make_file_cmp_owner(0, 0);
+		if (fd < 0)
+			ksft_exit_fail_msg("make_file_cmp_owner() failed\n");
+
+		if (unix_send_fds(ipc[0], &fd, 1, NULL, 0) < 0)
+			ksft_exit_fail_msg("unix_send_fds() failed\n");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	close(ipc[0]);
+
+	ret = write_id_mapping(UID_MAP, pid, id_map, id_map_size);
+	if (ret) {
+		ksft_exit_fail_msg("unix_send_fds() failed\n");
+		goto kill_child;
+	}
+
+	/* Must fail since a uid mapping has already been written. */
+	ret = write_id_mapping(FSUID_MAP, pid, fsid_map, fsid_map_size);
+	if (ret == 0) {
+		ksft_exit_fail_msg("unix_send_fds() succeeded\n");
+		goto kill_child;
+	}
+
+	ret = write_id_mapping(GID_MAP, pid, id_map, id_map_size);
+	if (ret) {
+		ksft_exit_fail_msg("unix_send_fds() failed\n");
+		goto kill_child;
+	}
+
+	/* Must fail since a gid mapping has already been written. */
+	ret = write_id_mapping(FSGID_MAP, pid, fsid_map, fsid_map_size);
+	if (ret == 0) {
+		ksft_exit_fail_msg("unix_send_fds() failed\n");
+		goto kill_child;
+	}
+
+	ret = write_nointr(ipc[1], "1", 1);
+	if (ret != 1) {
+		ksft_exit_fail_msg("write_nointr() failed\n");
+		goto kill_child;
+	}
+
+	if (unix_recv_fds(ipc[1], &fd, 1, NULL, 0) < 0) {
+		ksft_exit_fail_msg("unix_recv_fds() failed\n");
+		goto kill_child;
+	}
+
+	if (!has_expected_owner(fd, 100000, 100000)) {
+		ksft_exit_fail_msg("has_expected_owner() failed\n");
+		goto kill_child;
+	}
+
+	fret = EXIT_SUCCESS;
+
+wait_child:
+	ret = wait_for_pid(pid);
+	if (ret)
+		ksft_exit_fail_msg("wait_for_pid() failed\n");
+
+        if (fret == EXIT_SUCCESS)
+		return;
+	exit(fret);
+
+kill_child:
+	kill(pid, SIGKILL);
+	exit(EXIT_FAILURE);
+	goto wait_child;
+}
+
+static void test_fsid_maps_basic(void)
+{
+	int fret = EXIT_FAILURE;
+	ssize_t ret;
+	int fd = -EBADF;
+	pid_t pid;
+	int ipc[2];
+	struct clone_args args = {
+		.flags = CLONE_NEWUSER,
+		.exit_signal = SIGCHLD,
+	};
+
+	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc);
+	if (ret < 0)
+		ksft_exit_fail_msg("socketpair() failed\n");
+
+	pid = sys_clone3(&args, sizeof(args));
+	if (pid < 0) {
+		close(ipc[0]);
+		close(ipc[1]);
+		ksft_exit_fail_msg("clone3() failed\n");
+	}
+
+	if (pid == 0) {
+		int fd;
+		char buf;
+
+		close(ipc[1]);
+
+		ret = read_nointr(ipc[0], &buf, 1);
+		if (ret != 1)
+			ksft_exit_fail_msg("read_nointr() failed\n");
+
+		if (setid_userns_root())
+			ksft_exit_fail_msg("setid_userns_root() failed\n");
+
+		fd = make_file_cmp_owner(0, 0);
+		if (fd < 0)
+			ksft_exit_fail_msg("make_file_cmp_owner() failed\n");
+
+		if (unix_send_fds(ipc[0], &fd, 1, NULL, 0) < 0)
+			ksft_exit_fail_msg("unix_send_fds() failed\n");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	close(ipc[0]);
+
+	/* Must fail since a uid mapping has already been written. */
+	ret = write_id_mapping(FSUID_MAP, pid, fsid_map, fsid_map_size);
+	if (ret) {
+		ksft_exit_fail_msg("unix_send_fds() failed\n");
+		goto kill_child;
+	}
+
+	ret = write_id_mapping(UID_MAP, pid, id_map, id_map_size);
+	if (ret) {
+		ksft_exit_fail_msg("unix_send_fds() failed\n");
+		goto kill_child;
+	}
+
+	/* Must fail since a gid mapping has already been written. */
+	ret = write_id_mapping(FSGID_MAP, pid, fsid_map, fsid_map_size);
+	if (ret) {
+		ksft_exit_fail_msg("unix_send_fds() failed\n");
+		goto kill_child;
+	}
+
+	ret = write_id_mapping(GID_MAP, pid, id_map, id_map_size);
+	if (ret) {
+		ksft_exit_fail_msg("unix_send_fds() failed\n");
+		goto kill_child;
+	}
+
+	ret = write_nointr(ipc[1], "1", 1);
+	if (ret != 1) {
+		ksft_exit_fail_msg("write_nointr() failed\n");
+		goto kill_child;
+	}
+
+	if (unix_recv_fds(ipc[1], &fd, 1, NULL, 0) < 0) {
+		ksft_exit_fail_msg("unix_recv_fds() failed\n");
+		goto kill_child;
+	}
+
+	if (!has_expected_owner(fd, 300000, 300000)) {
+		ksft_exit_fail_msg("has_expected_owner() failed\n");
+		goto kill_child;
+	}
+
+	fret = EXIT_SUCCESS;
+
+wait_child:
+	ret = wait_for_pid(pid);
+	if (ret)
+		ksft_exit_fail_msg("wait_for_pid() failed\n");
+
+        if (fret == EXIT_SUCCESS)
+		return;
+	exit(fret);
+
+kill_child:
+	kill(pid, SIGKILL);
+	exit(EXIT_FAILURE);
+	goto wait_child;
+}
+
+int main(int argc, char *argv[])
+{
+	if (getuid())
+		ksft_exit_skip("fsid mapping tests require root\n");
+
+	if (access("/proc/self/fsuid_map", F_OK))
+		ksft_exit_skip("fsid mappings not supported by this kernel\n");
+
+	test_clone3_supported();
+
+	test_id_maps_imply_fsid_maps();
+	test_fsid_maps_basic();
+
+	exit(EXIT_SUCCESS);
+}
-- 
2.25.0

