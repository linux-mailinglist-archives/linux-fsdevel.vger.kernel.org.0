Return-Path: <linux-fsdevel+bounces-50467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50AAACC7DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9A3174AD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428E7231A55;
	Tue,  3 Jun 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS5fRPsh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC92040B6
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957539; cv=none; b=WFH4TAcF6WMXDNjYFcbndRTDOjPLHcaxZlDj/sxqbPksNPdBdzx5m9luIbU90/IVXVNSK0alRh6DIZ7RKBHYeQkV8iPq1rt0li8hpLf0sE54AAe+XBowggZsi1MuZZZucX98CqIUPsA5dRutS+46O/AM5a6K95rgcK5P5Nx1sBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957539; c=relaxed/simple;
	bh=hNHQ+YQT2z3bCK1gf5khMLIXpyce01/IerONFQnYinQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIsiKP8TxulJVJBQlpqBVDRQaMG6sQVF5gGNP5nmgbVqw4H2K6vTtXHTYkQHierNAtg6ID+I1nvU9oYey2GNEtpDa5WEFm1tJ8YLB2pKCrolq8x8cl4S3TiW2U6XSijJg4ssvnvGE7x65ROUjZWN0M9teaC3vVqQluMwa/aycFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS5fRPsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E91AC4CEF0;
	Tue,  3 Jun 2025 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748957536;
	bh=hNHQ+YQT2z3bCK1gf5khMLIXpyce01/IerONFQnYinQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZS5fRPshcjgYbl6xqnB0rkQH1Chbz3XVZ5u3r80xEeY+EHCTuuKf8o7Z2cL0Oq06D
	 rjedQTfpd1EdN7l0g+jZje3P1nLXHW+uEg0FSmwU/3Spb3pmwVWDSoPuqJwAt52XGL
	 qXzo99+fI8HtG/LopsCD7cHO8+XeLln1MSwQmjVqiIWSaCIQsnNNNggOfJ0c0/G9Ro
	 lSxVuiek4tnUVKfzboRNIakaX/o9xqjeae54o6QiNlWsDz9onLgro/jZRtxNnDXjr/
	 RjCK6U7YrOcig3rQ+YGoMw4D5tJSUrXjaeA6m+PrQLix1KMIy9dnqD7keE/J+xsnx1
	 fdF7S2FhIGolg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Jun 2025 15:31:56 +0200
Subject: [PATCH v2 2/5] selftests/coredump: fix build
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-work-coredump-socket-protocol-v2-2-05a5f0c18ecc@kernel.org>
References: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
In-Reply-To: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTY/QzTvWfqZLnE9vJ1r+NHO7zW+ghtCPwcN5MhQl5s/
 5V0+8PXO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZykYGR4V9UC/+F0l1OdZb+
 +2w/ZvNaxTgVaiacN/QNm3TgRfucKkaGeU42J+6JWL3mt/nnt0RTnCWnNPk+7wmbnFVSTCfnKcd
 wAgA=
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


