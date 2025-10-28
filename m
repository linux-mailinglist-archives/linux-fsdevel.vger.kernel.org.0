Return-Path: <linux-fsdevel+bounces-65892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BFC13990
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EAAD34F76B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950FE2E54CC;
	Tue, 28 Oct 2025 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGHBIng/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E792DC788;
	Tue, 28 Oct 2025 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641214; cv=none; b=MNbpMsb9kEe6gxKTvFKuuekZbicKMi/F5ktSuzRuWXdfu/lvo9m5gP6KGBVdtDRQwWizpLQRDzRy5aCHh+0L87N1F2mD8RagFOoH4FGkAQcwuDzDIGFoyjF7YfMKabRnSbMlGcnkMljNzHOXBx44boe3zdb4EClaAu8BRC8nHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641214; c=relaxed/simple;
	bh=FwnhSeUpMJ1tAdcg19JI78pH/nDPUL5EgJwp1VH7TuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uidHVddt2XEm8pM7+3hiAhpCn4rMsdoOhPtEjGM+k6J6u1w7I+wcBHrAS5s8T4VtKZEi2mYVnU9/MaSf3E4ddvD608Oma1qevinS2yl2XNFvpsMH++Hqs5PuyWfZQWvTCN2koQfWhMqvh5RiShHqDtFB1loRRj7DOyBTnjzAMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGHBIng/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABF3C4CEE7;
	Tue, 28 Oct 2025 08:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641214;
	bh=FwnhSeUpMJ1tAdcg19JI78pH/nDPUL5EgJwp1VH7TuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oGHBIng/5HNz/DCg0bWmDJN/xaWWqH1H+MPJigI/HhZeMuQlLHdBwStlKjePkBi/K
	 G4Ir1a44yomFy+XbJqVSd+qlfWJJgwhsurxgwfcUik7GIkwlIC54G4rV/U8JQb7pAB
	 pS9RvisBNCQzFnmTiAWoR7dJyIb6KRdNxmQ9JeTmRzwveyqN7gOAFtiW8ZBtaZ1AkK
	 /clTlHNWA8EbZogfLWZj6CEApIwCtf4vAvUh4ejUzVXirZZtqEkPVYCEaTY1bKyedL
	 i2dE5R/IWad3P9Og1BZIll6GBlqzxudIHWRhObdCDOs9aOW/28kn4Dpgn1CAcTuJtP
	 H1jl39rtLVwtg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:57 +0100
Subject: [PATCH 12/22] selftests/coredump: split out common helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-12-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=11051; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FwnhSeUpMJ1tAdcg19JI78pH/nDPUL5EgJwp1VH7TuI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB0yuD1jtunC0Ba5tes2npGd75Ui+9dtjXjn9PuTr
 R8sustV1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR7+OMDCccpAwj+F7Ubp5+
 6Gly7b8idYWws/bd8w2a3wnUf6m88pmRYVMh695vsbeZWlWWaNR63U/73HKone1A76Q1OnxmKcy
 67AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

into separate files.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_test.h   |  59 ++++
 .../selftests/coredump/coredump_test_helpers.c     | 340 +++++++++++++++++++++
 2 files changed, 399 insertions(+)

diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
new file mode 100644
index 000000000000..ed47f01fa53c
--- /dev/null
+++ b/tools/testing/selftests/coredump/coredump_test.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __COREDUMP_TEST_H
+#define __COREDUMP_TEST_H
+
+#include <stdbool.h>
+#include <sys/types.h>
+#include <linux/coredump.h>
+
+#include "../kselftest_harness.h"
+#include "../pidfd/pidfd.h"
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE 4096
+#endif
+
+#define NUM_THREAD_SPAWN 128
+
+/* Coredump fixture */
+FIXTURE(coredump)
+{
+	char original_core_pattern[256];
+	pid_t pid_coredump_server;
+	int fd_tmpfs_detached;
+};
+
+/* Shared helper function declarations */
+void *do_nothing(void *arg);
+void crashing_child(void);
+int create_detached_tmpfs(void);
+int create_and_listen_unix_socket(const char *path);
+bool set_core_pattern(const char *pattern);
+int get_peer_pidfd(int fd);
+bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
+
+/* Inline helper that uses harness types */
+static inline void wait_and_check_coredump_server(pid_t pid_coredump_server,
+						   struct __test_metadata *const _metadata,
+						   FIXTURE_DATA(coredump) *self)
+{
+	int status;
+	waitpid(pid_coredump_server, &status, 0);
+	self->pid_coredump_server = -ESRCH;
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+}
+
+/* Protocol helper function declarations */
+ssize_t recv_marker(int fd);
+bool read_marker(int fd, enum coredump_mark mark);
+bool read_coredump_req(int fd, struct coredump_req *req);
+bool send_coredump_ack(int fd, const struct coredump_req *req,
+		       __u64 mask, size_t size_ack);
+bool check_coredump_req(const struct coredump_req *req, size_t min_size,
+			__u64 required_mask);
+int open_coredump_tmpfile(int fd_tmpfs_detached);
+void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file);
+
+#endif /* __COREDUMP_TEST_H */
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
new file mode 100644
index 000000000000..7512a8ef73d3
--- /dev/null
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/coredump.h>
+#include <linux/fs.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/epoll.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../filesystems/wrappers.h"
+#include "../pidfd/pidfd.h"
+
+/* Forward declarations to avoid including harness header */
+struct __test_metadata;
+
+/* Match the fixture definition from coredump_test.h */
+struct _fixture_coredump_data {
+	char original_core_pattern[256];
+	pid_t pid_coredump_server;
+	int fd_tmpfs_detached;
+};
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE 4096
+#endif
+
+#define NUM_THREAD_SPAWN 128
+
+void *do_nothing(void *arg)
+{
+	(void)arg;
+	while (1)
+		pause();
+
+	return NULL;
+}
+
+void crashing_child(void)
+{
+	pthread_t thread;
+	int i;
+
+	for (i = 0; i < NUM_THREAD_SPAWN; ++i)
+		pthread_create(&thread, NULL, do_nothing, NULL);
+
+	/* crash on purpose */
+	i = *(int *)NULL;
+}
+
+int create_detached_tmpfs(void)
+{
+	int fd_context, fd_tmpfs;
+
+	fd_context = sys_fsopen("tmpfs", 0);
+	if (fd_context < 0)
+		return -1;
+
+	if (sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0) < 0)
+		return -1;
+
+	fd_tmpfs = sys_fsmount(fd_context, 0, 0);
+	close(fd_context);
+	return fd_tmpfs;
+}
+
+int create_and_listen_unix_socket(const char *path)
+{
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	assert(strlen(path) < sizeof(addr.sun_path) - 1);
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+	size_t addr_len =
+		offsetof(struct sockaddr_un, sun_path) + strlen(path) + 1;
+	int fd, ret;
+
+	fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		goto out;
+
+	ret = bind(fd, (const struct sockaddr *)&addr, addr_len);
+	if (ret < 0)
+		goto out;
+
+	ret = listen(fd, 128);
+	if (ret < 0)
+		goto out;
+
+	return fd;
+
+out:
+	if (fd >= 0)
+		close(fd);
+	return -1;
+}
+
+bool set_core_pattern(const char *pattern)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open("/proc/sys/kernel/core_pattern", O_WRONLY | O_CLOEXEC);
+	if (fd < 0)
+		return false;
+
+	ret = write(fd, pattern, strlen(pattern));
+	close(fd);
+	if (ret < 0)
+		return false;
+
+	fprintf(stderr, "Set core_pattern to '%s' | %zu == %zu\n", pattern, ret, strlen(pattern));
+	return ret == strlen(pattern);
+}
+
+int get_peer_pidfd(int fd)
+{
+	int fd_peer_pidfd;
+	socklen_t fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
+	int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd,
+			     &fd_peer_pidfd_len);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
+		return -1;
+	}
+	return fd_peer_pidfd;
+}
+
+bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
+{
+	memset(info, 0, sizeof(*info));
+	info->mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;
+	return ioctl(fd_peer_pidfd, PIDFD_GET_INFO, info) == 0;
+}
+
+/* Protocol helper functions */
+
+ssize_t recv_marker(int fd)
+{
+	enum coredump_mark mark = COREDUMP_MARK_REQACK;
+	ssize_t ret;
+
+	ret = recv(fd, &mark, sizeof(mark), MSG_WAITALL);
+	if (ret != sizeof(mark))
+		return -1;
+
+	switch (mark) {
+	case COREDUMP_MARK_REQACK:
+		fprintf(stderr, "Received marker: ReqAck\n");
+		return COREDUMP_MARK_REQACK;
+	case COREDUMP_MARK_MINSIZE:
+		fprintf(stderr, "Received marker: MinSize\n");
+		return COREDUMP_MARK_MINSIZE;
+	case COREDUMP_MARK_MAXSIZE:
+		fprintf(stderr, "Received marker: MaxSize\n");
+		return COREDUMP_MARK_MAXSIZE;
+	case COREDUMP_MARK_UNSUPPORTED:
+		fprintf(stderr, "Received marker: Unsupported\n");
+		return COREDUMP_MARK_UNSUPPORTED;
+	case COREDUMP_MARK_CONFLICTING:
+		fprintf(stderr, "Received marker: Conflicting\n");
+		return COREDUMP_MARK_CONFLICTING;
+	default:
+		fprintf(stderr, "Received unknown marker: %u\n", mark);
+		break;
+	}
+	return -1;
+}
+
+bool read_marker(int fd, enum coredump_mark mark)
+{
+	ssize_t ret;
+
+	ret = recv_marker(fd);
+	if (ret < 0)
+		return false;
+	return ret == mark;
+}
+
+bool read_coredump_req(int fd, struct coredump_req *req)
+{
+	ssize_t ret;
+	size_t field_size, user_size, ack_size, kernel_size, remaining_size;
+
+	memset(req, 0, sizeof(*req));
+	field_size = sizeof(req->size);
+
+	/* Peek the size of the coredump request. */
+	ret = recv(fd, req, field_size, MSG_PEEK | MSG_WAITALL);
+	if (ret != field_size)
+		return false;
+	kernel_size = req->size;
+
+	if (kernel_size < COREDUMP_ACK_SIZE_VER0)
+		return false;
+	if (kernel_size >= PAGE_SIZE)
+		return false;
+
+	/* Use the minimum of user and kernel size to read the full request. */
+	user_size = sizeof(struct coredump_req);
+	ack_size = user_size < kernel_size ? user_size : kernel_size;
+	ret = recv(fd, req, ack_size, MSG_WAITALL);
+	if (ret != ack_size)
+		return false;
+
+	fprintf(stderr, "Read coredump request with size %u and mask 0x%llx\n",
+		req->size, (unsigned long long)req->mask);
+
+	if (user_size > kernel_size)
+		remaining_size = user_size - kernel_size;
+	else
+		remaining_size = kernel_size - user_size;
+
+	if (PAGE_SIZE <= remaining_size)
+		return false;
+
+	/*
+	 * Discard any additional data if the kernel's request was larger than
+	 * what we knew about or cared about.
+	 */
+	if (remaining_size) {
+		char buffer[PAGE_SIZE];
+
+		ret = recv(fd, buffer, sizeof(buffer), MSG_WAITALL);
+		if (ret != remaining_size)
+			return false;
+		fprintf(stderr, "Discarded %zu bytes of data after coredump request\n", remaining_size);
+	}
+
+	return true;
+}
+
+bool send_coredump_ack(int fd, const struct coredump_req *req,
+		       __u64 mask, size_t size_ack)
+{
+	ssize_t ret;
+	/*
+	 * Wrap struct coredump_ack in a larger struct so we can
+	 * simulate sending to much data to the kernel.
+	 */
+	struct large_ack_for_size_testing {
+		struct coredump_ack ack;
+		char buffer[PAGE_SIZE];
+	} large_ack = {};
+
+	if (!size_ack)
+		size_ack = sizeof(struct coredump_ack) < req->size_ack ?
+				   sizeof(struct coredump_ack) :
+				   req->size_ack;
+	large_ack.ack.mask = mask;
+	large_ack.ack.size = size_ack;
+	ret = send(fd, &large_ack, size_ack, MSG_NOSIGNAL);
+	if (ret != size_ack)
+		return false;
+
+	fprintf(stderr, "Sent coredump ack with size %zu and mask 0x%llx\n",
+		size_ack, (unsigned long long)mask);
+	return true;
+}
+
+bool check_coredump_req(const struct coredump_req *req, size_t min_size,
+			__u64 required_mask)
+{
+	if (req->size < min_size)
+		return false;
+	if ((req->mask & required_mask) != required_mask)
+		return false;
+	if (req->mask & ~required_mask)
+		return false;
+	return true;
+}
+
+int open_coredump_tmpfile(int fd_tmpfs_detached)
+{
+	return openat(fd_tmpfs_detached, ".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
+}
+
+void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file)
+{
+	int epfd = -1;
+	int exit_code = EXIT_FAILURE;
+	struct epoll_event ev;
+
+	epfd = epoll_create1(0);
+	if (epfd < 0)
+		goto out;
+
+	ev.events = EPOLLIN | EPOLLRDHUP | EPOLLET;
+	ev.data.fd = fd_coredump;
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd_coredump, &ev) < 0)
+		goto out;
+
+	for (;;) {
+		struct epoll_event events[1];
+		int n = epoll_wait(epfd, events, 1, -1);
+		if (n < 0)
+			break;
+
+		if (events[0].events & (EPOLLIN | EPOLLRDHUP)) {
+			for (;;) {
+				char buffer[4096];
+				ssize_t bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+				if (bytes_read < 0) {
+					if (errno == EAGAIN || errno == EWOULDBLOCK)
+						break;
+					goto out;
+				}
+				if (bytes_read == 0)
+					goto done;
+				ssize_t bytes_write = write(fd_core_file, buffer, bytes_read);
+				if (bytes_write != bytes_read)
+					goto out;
+			}
+		}
+	}
+
+done:
+	exit_code = EXIT_SUCCESS;
+out:
+	if (epfd >= 0)
+		close(epfd);
+	if (fd_core_file >= 0)
+		close(fd_core_file);
+	if (fd_peer_pidfd >= 0)
+		close(fd_peer_pidfd);
+	if (fd_coredump >= 0)
+		close(fd_coredump);
+	_exit(exit_code);
+}

-- 
2.47.3


