Return-Path: <linux-fsdevel+bounces-65902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C2C13A07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5071AA3706
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1582EACF2;
	Tue, 28 Oct 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm/gXfrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0952DEA9B;
	Tue, 28 Oct 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641258; cv=none; b=C758jUg421mmbMPtUZ99ZqeMhz7rEQJNX4PbNp/PR1LzbHG+oa8rbOU8685up4E1JH1BM83Zwrs3854IwKuyCFRmyHXUrdleUIO+ZRWfL4QydYG0nwdvGmadWFSA+lL+1MnHfwN03QxrB9BpaNv78KWmPSQVg2mgXDwwgwHPV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641258; c=relaxed/simple;
	bh=nQyFS6aYzryiBpUF+lHQ88ZIt5d5g0ycfT79oX64Xz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVu9s6KM5Gpetn7uZr9HTcn5LMrHAa54cQRW8/TAIlDSBqbkxmdIrIqn2ZLeZ3/M5GUtrpUN41twoMK5vaw8161Xm64cmjlpLA8cHH8NGt075s34fEfxj8XR1RphuZGhZNcnTUrJCjpkTjxdFn/sstFxyRXPshPb4W+Sh7Ywbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm/gXfrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B82C4CEFF;
	Tue, 28 Oct 2025 08:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641258;
	bh=nQyFS6aYzryiBpUF+lHQ88ZIt5d5g0ycfT79oX64Xz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pm/gXfrfJikmRMsfDUjOzCgVz8vjRcv33GmeggH2BXHC29XSi9VJ17Qj+36grN2cm
	 Ggn41N0bStBOc3+6pJ8qH2MfdRbEqyxLfJy9fuRL3YWlD9wKWU0LyLaAyzJ+M1hCr4
	 MrH6MDwrf2N7LCg/HW7dKKEzSi3oPiCJg43F38rK7+4vuwr4fTkw0Rwhoyy1AJJfh3
	 BriRFGZaILDpgnEBMhPWojpt2mVvImV5eAcWtRxNEVdkwlDobflOtuuPIeb1Mzqj6Y
	 Z8LkW8Jhok9qEOhp2GzrJBXRn2izTNWOqw9BhNX3sqvTGfBLUoZg2M7OXVMPh4pzvE
	 dT0Nomd5BVbnw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:46:07 +0100
Subject: [PATCH 22/22] selftests/coredump: add second
 PIDFD_INFO_COREDUMP_SIGNAL test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-22-ca449b7b7aa0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5365; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nQyFS6aYzryiBpUF+lHQ88ZIt5d5g0ycfT79oX64Xz8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB0qWTb58EWVZ/t+2H/ga3AwP/SlN8FI9d0L3x1uv
 A8Ut9gqdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkiRQjw2Vr3r0uZRdOrLz+
 NeD2L57a7ou38nbYn5/cq83X/EhYsoqRYe1sSd5ZnMt8tTpPdJlssVSfOVthOYfd048bIr57CN8
 L5QUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Verify that when using simple socket-based coredump (@ pattern),
the coredump_signal field is correctly exposed as SIGABRT.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/coredump/coredump_socket_test.c      | 146 +++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index 9d5507fa75ec..7e26d4a6a15d 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -576,6 +576,152 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
 
+/*
+ * Test: PIDFD_INFO_COREDUMP_SIGNAL via simple socket coredump with SIGABRT
+ *
+ * Verify that when using simple socket-based coredump (@ pattern),
+ * the coredump_signal field is correctly exposed as SIGABRT.
+ */
+TEST_F(coredump, socket_coredump_signal_sigabrt)
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
+			fprintf(stderr, "socket_coredump_signal_sigabrt: create_and_listen_unix_socket failed: %m\n");
+			goto out;
+		}
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: write_nointr to ipc socket failed: %m\n");
+			goto out;
+		}
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: accept4 failed: %m\n");
+			goto out;
+		}
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: get_peer_pidfd failed\n");
+			goto out;
+		}
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: get_pidfd_info failed\n");
+			goto out;
+		}
+
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP not set in mask\n");
+			goto out;
+		}
+
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_COREDUMPED not set in coredump_mask\n");
+			goto out;
+		}
+
+		/* Verify coredump_signal is available and correct */
+		if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP_SIGNAL not set in mask\n");
+			goto out;
+		}
+
+		if (info.coredump_signal != SIGABRT) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: coredump_signal=%d, expected SIGABRT=%d\n",
+				info.coredump_signal, SIGABRT);
+			goto out;
+		}
+
+		fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
+		if (fd_core_file < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: open_coredump_tmpfile failed: %m\n");
+			goto out;
+		}
+
+		for (;;) {
+			char buffer[4096];
+			ssize_t bytes_read, bytes_write;
+
+			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+			if (bytes_read < 0) {
+				fprintf(stderr, "socket_coredump_signal_sigabrt: read from coredump socket failed: %m\n");
+				goto out;
+			}
+
+			if (bytes_read == 0)
+				break;
+
+			bytes_write = write(fd_core_file, buffer, bytes_read);
+			if (bytes_read != bytes_write) {
+				fprintf(stderr, "socket_coredump_signal_sigabrt: write to core file failed (read=%zd, write=%zd): %m\n",
+					bytes_read, bytes_write);
+				goto out;
+			}
+		}
+
+		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_coredump_signal_sigabrt: completed successfully\n");
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
+		abort();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGABRT);
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
+	ASSERT_EQ(info.coredump_signal, SIGABRT);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
 TEST_F(coredump, socket_invalid_paths)
 {
 	ASSERT_FALSE(set_core_pattern("@ /tmp/coredump.socket"));

-- 
2.47.3


