Return-Path: <linux-fsdevel+bounces-7297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C64823805
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D21AB24AF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC521105;
	Wed,  3 Jan 2024 22:23:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232071F60B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403LQ0dc024548
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:23:56 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vdffy8b5n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:23:56 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:23:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 42D4F3DF9EB4B; Wed,  3 Jan 2024 14:21:13 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 16/29] selftests/bpf: add BPF token-enabled tests
Date: Wed, 3 Jan 2024 14:20:21 -0800
Message-ID: <20240103222034.2582628-17-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103222034.2582628-1-andrii@kernel.org>
References: <20240103222034.2582628-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: w-aQGNC6vS917dreG_mxal6IzoWUOLOQ
X-Proofpoint-GUID: w-aQGNC6vS917dreG_mxal6IzoWUOLOQ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

Add a selftest that attempts to conceptually replicate intended BPF
token use cases inside user namespaced container.

Child process is forked. It is then put into its own userns and mountns.
Child creates BPF FS context object. This ensures child userns is
captured as the owning userns for this instance of BPF FS. Given setting
delegation mount options is privileged operation, we ensure that child
cannot set them.

This context is passed back to privileged parent process through Unix
socket, where parent sets up delegation options, creates, and mounts it
as a detached mount. This mount FD is passed back to the child to be
used for BPF token creation, which allows otherwise privileged BPF
operations to succeed inside userns.

We validate that all of token-enabled privileged commands (BPF_BTF_LOAD,
BPF_MAP_CREATE, and BPF_PROG_LOAD) work as intended. They should only
succeed inside the userns if a) BPF token is provided with proper
allowed sets of commands and types; and b) namespaces CAP_BPF and other
privileges are set. Lacking a) or b) should lead to -EPERM failures.

Based on suggested workflow by Christian Brauner ([0]).

  [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@=
brauner/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 683 ++++++++++++++++++
 1 file changed, 683 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing=
/selftests/bpf/prog_tests/token.c
new file mode 100644
index 000000000000..5394a0c880a9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -0,0 +1,683 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "cap_helpers.h"
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <unistd.h>
+#include <linux/filter.h>
+#include <linux/unistd.h>
+#include <linux/mount.h>
+#include <sys/socket.h>
+#include <sys/syscall.h>
+#include <sys/un.h>
+
+static inline int sys_mount(const char *dev_name, const char *dir_name,
+			    const char *type, unsigned long flags,
+			    const void *data)
+{
+	return syscall(__NR_mount, dev_name, dir_name, type, flags, data);
+}
+
+static inline int sys_fsopen(const char *fsname, unsigned flags)
+{
+	return syscall(__NR_fsopen, fsname, flags);
+}
+
+static inline int sys_fspick(int dfd, const char *path, unsigned flags)
+{
+	return syscall(__NR_fspick, dfd, path, flags);
+}
+
+static inline int sys_fsconfig(int fs_fd, unsigned cmd, const char *key, c=
onst void *val, int aux)
+{
+	return syscall(__NR_fsconfig, fs_fd, cmd, key, val, aux);
+}
+
+static inline int sys_fsmount(int fs_fd, unsigned flags, unsigned ms_flags)
+{
+	return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
+}
+
+static int drop_priv_caps(__u64 *old_caps)
+{
+	return cap_disable_effective((1ULL << CAP_BPF) |
+				     (1ULL << CAP_PERFMON) |
+				     (1ULL << CAP_NET_ADMIN) |
+				     (1ULL << CAP_SYS_ADMIN), old_caps);
+}
+
+static int restore_priv_caps(__u64 old_caps)
+{
+	return cap_enable_effective(old_caps, NULL);
+}
+
+static int set_delegate_mask(int fs_fd, const char *key, __u64 mask)
+{
+	char buf[32];
+	int err;
+
+	snprintf(buf, sizeof(buf), "0x%llx", (unsigned long long)mask);
+	err =3D sys_fsconfig(fs_fd, FSCONFIG_SET_STRING, key,
+			   mask =3D=3D ~0ULL ? "any" : buf, 0);
+	if (err < 0)
+		err =3D -errno;
+	return err;
+}
+
+#define zclose(fd) do { if (fd >=3D 0) close(fd); fd =3D -1; } while (0)
+
+struct bpffs_opts {
+	__u64 cmds;
+	__u64 maps;
+	__u64 progs;
+	__u64 attachs;
+};
+
+static int create_bpffs_fd(void)
+{
+	int fs_fd;
+
+	/* create VFS context */
+	fs_fd =3D sys_fsopen("bpf", 0);
+	ASSERT_GE(fs_fd, 0, "fs_fd");
+
+	return fs_fd;
+}
+
+static int materialize_bpffs_fd(int fs_fd, struct bpffs_opts *opts)
+{
+	int mnt_fd, err;
+
+	/* set up token delegation mount options */
+	err =3D set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds);
+	if (!ASSERT_OK(err, "fs_cfg_cmds"))
+		return err;
+	err =3D set_delegate_mask(fs_fd, "delegate_maps", opts->maps);
+	if (!ASSERT_OK(err, "fs_cfg_maps"))
+		return err;
+	err =3D set_delegate_mask(fs_fd, "delegate_progs", opts->progs);
+	if (!ASSERT_OK(err, "fs_cfg_progs"))
+		return err;
+	err =3D set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs);
+	if (!ASSERT_OK(err, "fs_cfg_attachs"))
+		return err;
+
+	/* instantiate FS object */
+	err =3D sys_fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	if (err < 0)
+		return -errno;
+
+	/* create O_PATH fd for detached mount */
+	mnt_fd =3D sys_fsmount(fs_fd, 0, 0);
+	if (err < 0)
+		return -errno;
+
+	return mnt_fd;
+}
+
+/* send FD over Unix domain (AF_UNIX) socket */
+static int sendfd(int sockfd, int fd)
+{
+	struct msghdr msg =3D {};
+	struct cmsghdr *cmsg;
+	int fds[1] =3D { fd }, err;
+	char iobuf[1];
+	struct iovec io =3D {
+		.iov_base =3D iobuf,
+		.iov_len =3D sizeof(iobuf),
+	};
+	union {
+		char buf[CMSG_SPACE(sizeof(fds))];
+		struct cmsghdr align;
+	} u;
+
+	msg.msg_iov =3D &io;
+	msg.msg_iovlen =3D 1;
+	msg.msg_control =3D u.buf;
+	msg.msg_controllen =3D sizeof(u.buf);
+	cmsg =3D CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level =3D SOL_SOCKET;
+	cmsg->cmsg_type =3D SCM_RIGHTS;
+	cmsg->cmsg_len =3D CMSG_LEN(sizeof(fds));
+	memcpy(CMSG_DATA(cmsg), fds, sizeof(fds));
+
+	err =3D sendmsg(sockfd, &msg, 0);
+	if (err < 0)
+		err =3D -errno;
+	if (!ASSERT_EQ(err, 1, "sendmsg"))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* receive FD over Unix domain (AF_UNIX) socket */
+static int recvfd(int sockfd, int *fd)
+{
+	struct msghdr msg =3D {};
+	struct cmsghdr *cmsg;
+	int fds[1], err;
+	char iobuf[1];
+	struct iovec io =3D {
+		.iov_base =3D iobuf,
+		.iov_len =3D sizeof(iobuf),
+	};
+	union {
+		char buf[CMSG_SPACE(sizeof(fds))];
+		struct cmsghdr align;
+	} u;
+
+	msg.msg_iov =3D &io;
+	msg.msg_iovlen =3D 1;
+	msg.msg_control =3D u.buf;
+	msg.msg_controllen =3D sizeof(u.buf);
+
+	err =3D recvmsg(sockfd, &msg, 0);
+	if (err < 0)
+		err =3D -errno;
+	if (!ASSERT_EQ(err, 1, "recvmsg"))
+		return -EINVAL;
+
+	cmsg =3D CMSG_FIRSTHDR(&msg);
+	if (!ASSERT_OK_PTR(cmsg, "cmsg_null") ||
+	    !ASSERT_EQ(cmsg->cmsg_len, CMSG_LEN(sizeof(fds)), "cmsg_len") ||
+	    !ASSERT_EQ(cmsg->cmsg_level, SOL_SOCKET, "cmsg_level") ||
+	    !ASSERT_EQ(cmsg->cmsg_type, SCM_RIGHTS, "cmsg_type"))
+		return -EINVAL;
+
+	memcpy(fds, CMSG_DATA(cmsg), sizeof(fds));
+	*fd =3D fds[0];
+
+	return 0;
+}
+
+static ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret =3D write(fd, buf, count);
+	} while (ret < 0 && errno =3D=3D EINTR);
+
+	return ret;
+}
+
+static int write_file(const char *path, const void *buf, size_t count)
+{
+	int fd;
+	ssize_t ret;
+
+	fd =3D open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
+	if (fd < 0)
+		return -1;
+
+	ret =3D write_nointr(fd, buf, count);
+	close(fd);
+	if (ret < 0 || (size_t)ret !=3D count)
+		return -1;
+
+	return 0;
+}
+
+static int create_and_enter_userns(void)
+{
+	uid_t uid;
+	gid_t gid;
+	char map[100];
+
+	uid =3D getuid();
+	gid =3D getgid();
+
+	if (unshare(CLONE_NEWUSER))
+		return -1;
+
+	if (write_file("/proc/self/setgroups", "deny", sizeof("deny") - 1) &&
+	    errno !=3D ENOENT)
+		return -1;
+
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map, strlen(map)))
+		return -1;
+
+
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map, strlen(map)))
+		return -1;
+
+	if (setgid(0))
+		return -1;
+
+	if (setuid(0))
+		return -1;
+
+	return 0;
+}
+
+typedef int (*child_callback_fn)(int);
+
+static void child(int sock_fd, struct bpffs_opts *opts, child_callback_fn =
callback)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int mnt_fd =3D -1, fs_fd =3D -1, err =3D 0, bpffs_fd =3D -1;
+
+	/* setup userns with root mappings */
+	err =3D create_and_enter_userns();
+	if (!ASSERT_OK(err, "create_and_enter_userns"))
+		goto cleanup;
+
+	/* setup mountns to allow creating BPF FS (fsopen("bpf")) from unpriv pro=
cess */
+	err =3D unshare(CLONE_NEWNS);
+	if (!ASSERT_OK(err, "create_mountns"))
+		goto cleanup;
+
+	err =3D sys_mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	if (!ASSERT_OK(err, "remount_root"))
+		goto cleanup;
+
+	fs_fd =3D create_bpffs_fd();
+	if (!ASSERT_GE(fs_fd, 0, "create_bpffs_fd")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+
+	/* ensure unprivileged child cannot set delegation options */
+	err =3D set_delegate_mask(fs_fd, "delegate_cmds", 0x1);
+	ASSERT_EQ(err, -EPERM, "delegate_cmd_eperm");
+	err =3D set_delegate_mask(fs_fd, "delegate_maps", 0x1);
+	ASSERT_EQ(err, -EPERM, "delegate_maps_eperm");
+	err =3D set_delegate_mask(fs_fd, "delegate_progs", 0x1);
+	ASSERT_EQ(err, -EPERM, "delegate_progs_eperm");
+	err =3D set_delegate_mask(fs_fd, "delegate_attachs", 0x1);
+	ASSERT_EQ(err, -EPERM, "delegate_attachs_eperm");
+
+	/* pass BPF FS context object to parent */
+	err =3D sendfd(sock_fd, fs_fd);
+	if (!ASSERT_OK(err, "send_fs_fd"))
+		goto cleanup;
+	zclose(fs_fd);
+
+	/* avoid mucking around with mount namespaces and mounting at
+	 * well-known path, just get detach-mounted BPF FS fd back from parent
+	 */
+	err =3D recvfd(sock_fd, &mnt_fd);
+	if (!ASSERT_OK(err, "recv_mnt_fd"))
+		goto cleanup;
+
+	/* try to fspick() BPF FS and try to add some delegation options */
+	fs_fd =3D sys_fspick(mnt_fd, "", FSPICK_EMPTY_PATH);
+	if (!ASSERT_GE(fs_fd, 0, "bpffs_fspick")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+
+	/* ensure unprivileged child cannot reconfigure to set delegation options=
 */
+	err =3D set_delegate_mask(fs_fd, "delegate_cmds", ~0ULL);
+	if (!ASSERT_EQ(err, -EPERM, "delegate_cmd_eperm_reconfig")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+	err =3D set_delegate_mask(fs_fd, "delegate_maps", ~0ULL);
+	if (!ASSERT_EQ(err, -EPERM, "delegate_maps_eperm_reconfig")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+	err =3D set_delegate_mask(fs_fd, "delegate_progs", ~0ULL);
+	if (!ASSERT_EQ(err, -EPERM, "delegate_progs_eperm_reconfig")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+	err =3D set_delegate_mask(fs_fd, "delegate_attachs", ~0ULL);
+	if (!ASSERT_EQ(err, -EPERM, "delegate_attachs_eperm_reconfig")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+	zclose(fs_fd);
+
+	bpffs_fd =3D openat(mnt_fd, ".", 0, O_RDWR);
+	if (!ASSERT_GE(bpffs_fd, 0, "bpffs_open")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+
+	/* do custom test logic with customly set up BPF FS instance */
+	err =3D callback(bpffs_fd);
+	if (!ASSERT_OK(err, "test_callback"))
+		goto cleanup;
+
+	err =3D 0;
+cleanup:
+	zclose(sock_fd);
+	zclose(mnt_fd);
+	zclose(fs_fd);
+	zclose(bpffs_fd);
+
+	exit(-err);
+}
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret =3D waitpid(pid, &status, 0);
+	if (ret =3D=3D -1) {
+		if (errno =3D=3D EINTR)
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
+static void parent(int child_pid, struct bpffs_opts *bpffs_opts, int sock_=
fd)
+{
+	int fs_fd =3D -1, mnt_fd =3D -1, err;
+
+	err =3D recvfd(sock_fd, &fs_fd);
+	if (!ASSERT_OK(err, "recv_bpffs_fd"))
+		goto cleanup;
+
+	mnt_fd =3D materialize_bpffs_fd(fs_fd, bpffs_opts);
+	if (!ASSERT_GE(mnt_fd, 0, "materialize_bpffs_fd")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+	zclose(fs_fd);
+
+	/* pass BPF FS context object to parent */
+	err =3D sendfd(sock_fd, mnt_fd);
+	if (!ASSERT_OK(err, "send_mnt_fd"))
+		goto cleanup;
+	zclose(mnt_fd);
+
+	err =3D wait_for_pid(child_pid);
+	ASSERT_OK(err, "waitpid_child");
+
+cleanup:
+	zclose(sock_fd);
+	zclose(fs_fd);
+	zclose(mnt_fd);
+
+	if (child_pid > 0)
+		(void)kill(child_pid, SIGKILL);
+}
+
+static void subtest_userns(struct bpffs_opts *bpffs_opts, child_callback_f=
n cb)
+{
+	int sock_fds[2] =3D { -1, -1 };
+	int child_pid =3D 0, err;
+
+	err =3D socketpair(AF_UNIX, SOCK_STREAM, 0, sock_fds);
+	if (!ASSERT_OK(err, "socketpair"))
+		goto cleanup;
+
+	child_pid =3D fork();
+	if (!ASSERT_GE(child_pid, 0, "fork"))
+		goto cleanup;
+
+	if (child_pid =3D=3D 0) {
+		zclose(sock_fds[0]);
+		return child(sock_fds[1], bpffs_opts, cb);
+
+	} else {
+		zclose(sock_fds[1]);
+		return parent(child_pid, bpffs_opts, sock_fds[0]);
+	}
+
+cleanup:
+	zclose(sock_fds[0]);
+	zclose(sock_fds[1]);
+	if (child_pid > 0)
+		(void)kill(child_pid, SIGKILL);
+}
+
+static int userns_map_create(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int err, token_fd =3D -1, map_fd =3D -1;
+	__u64 old_caps =3D 0;
+
+	/* create BPF token from BPF FS mount */
+	token_fd =3D bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "token_create")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+
+	/* while inside non-init userns, we need both a BPF token *and*
+	 * CAP_BPF inside current userns to create privileged map; let's test
+	 * that neither BPF token alone nor namespaced CAP_BPF is sufficient
+	 */
+	err =3D drop_priv_caps(&old_caps);
+	if (!ASSERT_OK(err, "drop_caps"))
+		goto cleanup;
+
+	/* no token, no CAP_BPF -> fail */
+	map_opts.map_flags =3D 0;
+	map_opts.token_fd =3D 0;
+	map_fd =3D bpf_map_create(BPF_MAP_TYPE_STACK, "wo_token_wo_bpf", 0, 8, 1,=
 &map_opts);
+	if (!ASSERT_LT(map_fd, 0, "stack_map_wo_token_wo_cap_bpf_should_fail")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+
+	/* token without CAP_BPF -> fail */
+	map_opts.map_flags =3D BPF_F_TOKEN_FD;
+	map_opts.token_fd =3D token_fd;
+	map_fd =3D bpf_map_create(BPF_MAP_TYPE_STACK, "w_token_wo_bpf", 0, 8, 1, =
&map_opts);
+	if (!ASSERT_LT(map_fd, 0, "stack_map_w_token_wo_cap_bpf_should_fail")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+
+	/* get back effective local CAP_BPF (and CAP_SYS_ADMIN) */
+	err =3D restore_priv_caps(old_caps);
+	if (!ASSERT_OK(err, "restore_caps"))
+		goto cleanup;
+
+	/* CAP_BPF without token -> fail */
+	map_opts.map_flags =3D 0;
+	map_opts.token_fd =3D 0;
+	map_fd =3D bpf_map_create(BPF_MAP_TYPE_STACK, "wo_token_w_bpf", 0, 8, 1, =
&map_opts);
+	if (!ASSERT_LT(map_fd, 0, "stack_map_wo_token_w_cap_bpf_should_fail")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+
+	/* finally, namespaced CAP_BPF + token -> success */
+	map_opts.map_flags =3D BPF_F_TOKEN_FD;
+	map_opts.token_fd =3D token_fd;
+	map_fd =3D bpf_map_create(BPF_MAP_TYPE_STACK, "w_token_w_bpf", 0, 8, 1, &=
map_opts);
+	if (!ASSERT_GT(map_fd, 0, "stack_map_w_token_w_cap_bpf")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+
+cleanup:
+	zclose(token_fd);
+	zclose(map_fd);
+	return err;
+}
+
+static int userns_btf_load(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_btf_load_opts, btf_opts);
+	int err, token_fd =3D -1, btf_fd =3D -1;
+	const void *raw_btf_data;
+	struct btf *btf =3D NULL;
+	__u32 raw_btf_size;
+	__u64 old_caps =3D 0;
+
+	/* create BPF token from BPF FS mount */
+	token_fd =3D bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "token_create")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+
+	/* while inside non-init userns, we need both a BPF token *and*
+	 * CAP_BPF inside current userns to create privileged map; let's test
+	 * that neither BPF token alone nor namespaced CAP_BPF is sufficient
+	 */
+	err =3D drop_priv_caps(&old_caps);
+	if (!ASSERT_OK(err, "drop_caps"))
+		goto cleanup;
+
+	/* setup a trivial BTF data to load to the kernel */
+	btf =3D btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "empty_btf"))
+		goto cleanup;
+
+	ASSERT_GT(btf__add_int(btf, "int", 4, 0), 0, "int_type");
+
+	raw_btf_data =3D btf__raw_data(btf, &raw_btf_size);
+	if (!ASSERT_OK_PTR(raw_btf_data, "raw_btf_data"))
+		goto cleanup;
+
+	/* no token + no CAP_BPF -> failure */
+	btf_opts.btf_flags =3D 0;
+	btf_opts.token_fd =3D 0;
+	btf_fd =3D bpf_btf_load(raw_btf_data, raw_btf_size, &btf_opts);
+	if (!ASSERT_LT(btf_fd, 0, "no_token_no_cap_should_fail"))
+		goto cleanup;
+
+	/* token + no CAP_BPF -> failure */
+	btf_opts.btf_flags =3D BPF_F_TOKEN_FD;
+	btf_opts.token_fd =3D token_fd;
+	btf_fd =3D bpf_btf_load(raw_btf_data, raw_btf_size, &btf_opts);
+	if (!ASSERT_LT(btf_fd, 0, "token_no_cap_should_fail"))
+		goto cleanup;
+
+	/* get back effective local CAP_BPF (and CAP_SYS_ADMIN) */
+	err =3D restore_priv_caps(old_caps);
+	if (!ASSERT_OK(err, "restore_caps"))
+		goto cleanup;
+
+	/* token + CAP_BPF -> success */
+	btf_opts.btf_flags =3D BPF_F_TOKEN_FD;
+	btf_opts.token_fd =3D token_fd;
+	btf_fd =3D bpf_btf_load(raw_btf_data, raw_btf_size, &btf_opts);
+	if (!ASSERT_GT(btf_fd, 0, "token_and_cap_success"))
+		goto cleanup;
+
+	err =3D 0;
+cleanup:
+	btf__free(btf);
+	zclose(btf_fd);
+	zclose(token_fd);
+	return err;
+}
+
+static int userns_prog_load(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	int err, token_fd =3D -1, prog_fd =3D -1;
+	struct bpf_insn insns[] =3D {
+		/* bpf_jiffies64() requires CAP_BPF */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		/* bpf_get_current_task() requires CAP_PERFMON */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_current_task),
+		/* r0 =3D 0; exit; */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	size_t insn_cnt =3D ARRAY_SIZE(insns);
+	__u64 old_caps =3D 0;
+
+	/* create BPF token from BPF FS mount */
+	token_fd =3D bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "token_create")) {
+		err =3D -EINVAL;
+		goto cleanup;
+	}
+
+	/* validate we can successfully load BPF program with token; this
+	 * being XDP program (CAP_NET_ADMIN) using bpf_jiffies64() (CAP_BPF)
+	 * and bpf_get_current_task() (CAP_PERFMON) helpers validates we have
+	 * BPF token wired properly in a bunch of places in the kernel
+	 */
+	prog_opts.prog_flags =3D BPF_F_TOKEN_FD;
+	prog_opts.token_fd =3D token_fd;
+	prog_opts.expected_attach_type =3D BPF_XDP;
+	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_GT(prog_fd, 0, "prog_fd")) {
+		err =3D -EPERM;
+		goto cleanup;
+	}
+
+	/* no token + caps -> failure */
+	prog_opts.prog_flags =3D 0;
+	prog_opts.token_fd =3D 0;
+	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_EQ(prog_fd, -EPERM, "prog_fd_eperm")) {
+		err =3D -EPERM;
+		goto cleanup;
+	}
+
+	err =3D drop_priv_caps(&old_caps);
+	if (!ASSERT_OK(err, "drop_caps"))
+		goto cleanup;
+
+	/* no caps + token -> failure */
+	prog_opts.prog_flags =3D BPF_F_TOKEN_FD;
+	prog_opts.token_fd =3D token_fd;
+	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_EQ(prog_fd, -EPERM, "prog_fd_eperm")) {
+		err =3D -EPERM;
+		goto cleanup;
+	}
+
+	/* no caps + no token -> definitely a failure */
+	prog_opts.prog_flags =3D 0;
+	prog_opts.token_fd =3D 0;
+	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_EQ(prog_fd, -EPERM, "prog_fd_eperm")) {
+		err =3D -EPERM;
+		goto cleanup;
+	}
+
+	err =3D 0;
+cleanup:
+	zclose(prog_fd);
+	zclose(token_fd);
+	return err;
+}
+
+void test_token(void)
+{
+	if (test__start_subtest("map_token")) {
+		struct bpffs_opts opts =3D {
+			.cmds =3D 1ULL << BPF_MAP_CREATE,
+			.maps =3D 1ULL << BPF_MAP_TYPE_STACK,
+		};
+
+		subtest_userns(&opts, userns_map_create);
+	}
+	if (test__start_subtest("btf_token")) {
+		struct bpffs_opts opts =3D {
+			.cmds =3D 1ULL << BPF_BTF_LOAD,
+		};
+
+		subtest_userns(&opts, userns_btf_load);
+	}
+	if (test__start_subtest("prog_token")) {
+		struct bpffs_opts opts =3D {
+			.cmds =3D 1ULL << BPF_PROG_LOAD,
+			.progs =3D 1ULL << BPF_PROG_TYPE_XDP,
+			.attachs =3D 1ULL << BPF_XDP,
+		};
+
+		subtest_userns(&opts, userns_prog_load);
+	}
+}
--=20
2.34.1


