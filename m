Return-Path: <linux-fsdevel+bounces-50219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FECAC8CA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227E69E76B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3AC223DF9;
	Fri, 30 May 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEXxtDWr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4A227E80
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603434; cv=none; b=BoqLCo2+t738i7QcepykcHFrnbw3oPdpyezgnxJvlxmhmoyqR0eMeeqrMZIhymeMEKuOwbp3uF4Y74Puk6ZkOt+QjpP1P8BrgEt6f8vX/pRVWgPqfMJPuaN0+Tnz8RWwOcdc4xX35wUCUKVrjXDLyGx+B61KWK4qxVmEUqukqYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603434; c=relaxed/simple;
	bh=hNHQ+YQT2z3bCK1gf5khMLIXpyce01/IerONFQnYinQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qpHbiM0jPqPSK8+lsduDgvwWqBfa3Gz2P9LpYvV7YVHwqabtsnPIGKo/H5V/o80GnWP3+eOMfk/g6JwF/GmzJkQ7dicGjwYJuUgqq3KDgEO0XF/FODCw5zFx/2qE31hhpLjHDWKMpwfFxbB4x/3P0jvGF9uq8ZTeTJBxjedcymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEXxtDWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BE3C4CEE9;
	Fri, 30 May 2025 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748603433;
	bh=hNHQ+YQT2z3bCK1gf5khMLIXpyce01/IerONFQnYinQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OEXxtDWra+dw6yeUEO7KdQJB1L5JlSgzNViBVWoFFeqBEmYbUbL16c8U0R21o2A+6
	 ckmpcFzbh5RikpZRYbKFd/Bc4Pl6XL4S3GiI4M9zBeQcIXpZeRByuirOFIUa0KW84L
	 oQIoN0hgQruNcQfJom8wgSBBGcjuoBWLLaoN1p+YeAX3vb7/GsOfnJWrB5ZDe0hIfq
	 guwkzwzTaOLPE4tjyBBql1m1/5CdIGSDIj0oBQqLWOEghU2PFg/rWabh8Ni3HotyXM
	 s9a07ej+2Z2ctXti3dVCwTFGEchLk6pVNOej9NeJs5yT2H4+S+lKV3a27qtK7WAtRE
	 GZZQcB/zSAVVQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 May 2025 13:10:00 +0200
Subject: [PATCH 2/5] selftests/coredump: fix build
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-work-coredump-socket-protocol-v1-2-20bde1cd4faa@kernel.org>
References: <20250530-work-coredump-socket-protocol-v1-0-20bde1cd4faa@kernel.org>
In-Reply-To: <20250530-work-coredump-socket-protocol-v1-0-20bde1cd4faa@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Jan Kara <jack@suse.cz>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=3434; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hNHQ+YQT2z3bCK1gf5khMLIXpyce01/IerONFQnYinQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRYTlJQ8m3iSrXQPD5FX32J7Z9JdwpDH1d/myt4XpcrY
 YJJGtfnjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImkPmD4X7Pgud8sjwbh3kSz
 MnbzMxItUZ6i3Ok5W2evE+Q/WxX9geF/fqZt/a8jHdnnp73uEcw39J3duSqh++Lk4/xMHyx51rm
 yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Fix various warnings in the selftest build.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/Makefile         |  2 +-
 tools/testing/selftests/coredump/stackdump_test.c | 17 +++++------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/coredump/Makefile b/tools/testing/selftests/coredump/Makefile
index ed210037b29d..bc287a85b825 100644
--- a/tools/testing/selftests/coredump/Makefile
+++ b/tools/testing/selftests/coredump/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS = $(KHDR_INCLUDES)
+CFLAGS = -Wall -O0 $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := stackdump_test
 TEST_FILES := stackdump
diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index 9984413be9f0..aa366e6f13a7 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -24,6 +24,8 @@ static void *do_nothing(void *)
 {
 	while (1)
 		pause();
+
+	return NULL;
 }
 
 static void crashing_child(void)
@@ -46,9 +48,7 @@ FIXTURE(coredump)
 
 FIXTURE_SETUP(coredump)
 {
-	char buf[PATH_MAX];
 	FILE *file;
-	char *dir;
 	int ret;
 
 	self->pid_coredump_server = -ESRCH;
@@ -106,7 +106,6 @@ FIXTURE_TEARDOWN(coredump)
 
 TEST_F_TIMEOUT(coredump, stackdump, 120)
 {
-	struct sigaction action = {};
 	unsigned long long stack;
 	char *test_dir, *line;
 	size_t line_length;
@@ -171,11 +170,10 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
 
 TEST_F(coredump, socket)
 {
-	int fd, pidfd, ret, status;
+	int pidfd, ret, status;
 	FILE *file;
 	pid_t pid, pid_coredump_server;
 	struct stat st;
-	char core_file[PATH_MAX];
 	struct pidfd_info info = {};
 	int ipc_sockets[2];
 	char c;
@@ -356,11 +354,10 @@ TEST_F(coredump, socket)
 
 TEST_F(coredump, socket_detect_userspace_client)
 {
-	int fd, pidfd, ret, status;
+	int pidfd, ret, status;
 	FILE *file;
 	pid_t pid, pid_coredump_server;
 	struct stat st;
-	char core_file[PATH_MAX];
 	struct pidfd_info info = {};
 	int ipc_sockets[2];
 	char c;
@@ -384,7 +381,7 @@ TEST_F(coredump, socket_detect_userspace_client)
 	pid_coredump_server = fork();
 	ASSERT_GE(pid_coredump_server, 0);
 	if (pid_coredump_server == 0) {
-		int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
+		int fd_server, fd_coredump, fd_peer_pidfd;
 		socklen_t fd_peer_pidfd_len;
 
 		close(ipc_sockets[0]);
@@ -464,7 +461,6 @@ TEST_F(coredump, socket_detect_userspace_client)
 		close(fd_coredump);
 		close(fd_server);
 		close(fd_peer_pidfd);
-		close(fd_core_file);
 		_exit(EXIT_SUCCESS);
 	}
 	self->pid_coredump_server = pid_coredump_server;
@@ -488,7 +484,6 @@ TEST_F(coredump, socket_detect_userspace_client)
 		if (ret < 0)
 			_exit(EXIT_FAILURE);
 
-		(void *)write(fd_socket, &(char){ 0 }, 1);
 		close(fd_socket);
 		_exit(EXIT_SUCCESS);
 	}
@@ -519,7 +514,6 @@ TEST_F(coredump, socket_enoent)
 	int pidfd, ret, status;
 	FILE *file;
 	pid_t pid;
-	char core_file[PATH_MAX];
 
 	file = fopen("/proc/sys/kernel/core_pattern", "w");
 	ASSERT_NE(file, NULL);
@@ -569,7 +563,6 @@ TEST_F(coredump, socket_no_listener)
 	ASSERT_GE(pid_coredump_server, 0);
 	if (pid_coredump_server == 0) {
 		int fd_server;
-		socklen_t fd_peer_pidfd_len;
 
 		close(ipc_sockets[0]);
 

-- 
2.47.2


