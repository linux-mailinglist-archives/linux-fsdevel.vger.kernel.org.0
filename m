Return-Path: <linux-fsdevel+bounces-65901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8F1C139F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AAB5E092F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78282F5301;
	Tue, 28 Oct 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3rWGgLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1152F39A6;
	Tue, 28 Oct 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641254; cv=none; b=BvlEJhVFRMubmaI6MMcmhBQ0zS5X++3NZ4iRXz0Nly/av1XzPlmPjIHAT7ujNLhcnC9Nlzz9JUhUDOJ7Y/nVeBVkarDUdrV1MyBemkMGr1VQHKBQibRc3d5lK9i9biIHRoiYK5RU8VTavRmK/s4QXX8bImNzptNX1lVbG40H11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641254; c=relaxed/simple;
	bh=2EQ5HZR4qxn4C2MGMoXLEuLXP+/juEhCZ0nnSio2LFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cc6gFR7x20VcxV/ATD55SAXvBbgxFltFLwkrPg1NVeoKnjUnCVnUZl/8WIIOyH5dzlBIgCiOyDIs8iyXo6qj/6bsDz7UmmFZx1iX2A9S5VVnVIWsRPVktHkKFcyNRR1N2FdMUNzykkkB2sCDEPchAIlCE46RWhbd9mkq+JFRAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3rWGgLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A11CC4CEE7;
	Tue, 28 Oct 2025 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641253;
	bh=2EQ5HZR4qxn4C2MGMoXLEuLXP+/juEhCZ0nnSio2LFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I3rWGgLbYrJJcEC6p+Mn13yJKPPtW29UWj5DtKKHcJSC03fV1PjlVGQ6Qs+BLoAOv
	 LWxQYsn/wO3BNyn8BdVnxPICBIl7l75pHW3EA82SgTO3/T0uBDclEL6Sa8O0AikY3Z
	 +dmr6sSYcwN3ln7b2jezayRxxFwelPTRgBL3hFXGHPVFgkMmXRtfWtghrvL0M/YZnC
	 CEh2nijOUi4u4gokJOLBArY3RfbX6Mya5OOhtANY96/rVWtRGYoFYasMRJyB0UF/Ps
	 UwgdMGm5/IM++pzTpkR4df85IsSxowmYqQ79abQm5q6LXoyWBCZJ5Bq/a5fP2Hq8wU
	 6PZ9dscTNe53A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:46:06 +0100
Subject: [PATCH 21/22] selftests/coredump: add first
 PIDFD_INFO_COREDUMP_SIGNAL test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-21-ca449b7b7aa0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5349; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2EQ5HZR4qxn4C2MGMoXLEuLXP+/juEhCZ0nnSio2LFM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB0K+TH1bObkMhWTd4z/3yt7PJIy/awnd4R9p27jH
 OO/62487ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIUnFGhgdznjU/aL/y97Sa
 ebqk54qlvz+wvnxTvOWN68qwRTn1R88xMly1nCh37WbFuVPLgqevX/8hVVSvyzYmRFZrLZv2i7z
 liRwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Verify that when using simple socket-based coredump (@ pattern),
the coredump_signal field is correctly exposed as SIGSEGV.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/coredump/coredump_socket_test.c      | 146 +++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index da558a0e37aa..9d5507fa75ec 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -430,6 +430,152 @@ TEST_F(coredump, socket_no_listener)
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
 
+/*
+ * Test: PIDFD_INFO_COREDUMP_SIGNAL via simple socket coredump
+ *
+ * Verify that when using simple socket-based coredump (@ pattern),
+ * the coredump_signal field is correctly exposed as SIGSEGV.
+ */
+TEST_F(coredump, socket_coredump_signal_sigsegv)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: create_and_listen_unix_socket failed: %m\n");
+			goto out;
+		}
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: write_nointr to ipc socket failed: %m\n");
+			goto out;
+		}
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: accept4 failed: %m\n");
+			goto out;
+		}
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: get_peer_pidfd failed\n");
+			goto out;
+		}
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: get_pidfd_info failed\n");
+			goto out;
+		}
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP not set in mask\n");
+			goto out;
+		}
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_COREDUMPED not set in coredump_mask\n");
+			goto out;
+		}
+
+		/* Verify coredump_signal is available and correct */
+		if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP_SIGNAL not set in mask\n");
+			goto out;
+		}
+
+		if (info.coredump_signal != SIGSEGV) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: coredump_signal=%d, expected SIGSEGV=%d\n",
+				info.coredump_signal, SIGSEGV);
+			goto out;
+		}
+
+		fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
+		if (fd_core_file < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: open_coredump_tmpfile failed: %m\n");
+			goto out;
+		}
+
+		for (;;) {
+			char buffer[4096];
+			ssize_t bytes_read, bytes_write;
+
+			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+			if (bytes_read < 0) {
+				fprintf(stderr, "socket_coredump_signal_sigsegv: read from coredump socket failed: %m\n");
+				goto out;
+			}
+
+			if (bytes_read == 0)
+				break;
+
+			bytes_write = write(fd_core_file, buffer, bytes_read);
+			if (bytes_read != bytes_write) {
+				fprintf(stderr, "socket_coredump_signal_sigsegv: write to core file failed (read=%zd, write=%zd): %m\n",
+					bytes_read, bytes_write);
+				goto out;
+			}
+		}
+
+		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_coredump_signal_sigsegv: completed successfully\n");
+out:
+		if (fd_core_file >= 0)
+			close(fd_core_file);
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGSEGV);
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
+	ASSERT_EQ(info.coredump_signal, SIGSEGV);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
 TEST_F(coredump, socket_invalid_paths)
 {
 	ASSERT_FALSE(set_core_pattern("@ /tmp/coredump.socket"));

-- 
2.47.3


