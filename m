Return-Path: <linux-fsdevel+bounces-65899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B2C139E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDEB586A1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D50A2EAB6E;
	Tue, 28 Oct 2025 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFHkyMMg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71ED2D97AA;
	Tue, 28 Oct 2025 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641246; cv=none; b=kZGkduHSlSIDNwM8l3A6DBhK+NlMtmcSs5TRhNiz2niT0ScIemtGbG9um5q+PrbbX9GgJg0+xlgNy6GvMHclFRESg8Oifi4HEktTbiwlOmAodkgdeEle4Fr5+B1HHis5/R4KPLy06DNGgi+HcC6aOwkKA5czWEK6P55+vgL56hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641246; c=relaxed/simple;
	bh=uKu3QHfWqGHnfWV7aYA2McoSNkcMQko2AYCbqlm6Q8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqPaYxONkwYTHB8mC954JhptmkuJ1gtTmg4uCwgHvRMgZTXSWItdPv4gR0QVOc8gw0tNuxURt5UWqNLdfs0C5hqIW38YjYmZ3Cm/2kumC1NI4ZSDGPeuvxumLNL2s5X61OPV47Jc9RlsB/7DxMbf4FyU06fAUlzKcsLvjWACJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFHkyMMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B928FC4CEE7;
	Tue, 28 Oct 2025 08:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641245;
	bh=uKu3QHfWqGHnfWV7aYA2McoSNkcMQko2AYCbqlm6Q8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aFHkyMMgTKQESkf2gakjNcardarkVk6lFrWYftYRkAaPhamURLRUMflK46g+g0T+2
	 cW2CuHnvVTRh/j/31ccrGuVGam+My20RQAu41d4JPlALwHInQbZ0UIt7OmF3R8nO5O
	 vpfE2ZUk8ZaZAMlwwo748AaTGBdGnAGPZ/SSM+mJ253uruVf2yf38W6KINYZFF8Cnu
	 bWO2y2pHK3dH1zE8LkAq9VEBYkPKjUB92aGA0wVtXuQUbu/w3yEUxKDdfM1nC7jLWc
	 oHgPQXuerIU+0KiRPXE3gS7u35uptW0GuiDn9LGA6yNv650dQJBehRa4WTa8vtEfsJ
	 4I9k/UwghieAw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:46:04 +0100
Subject: [PATCH 19/22] selftests/coredump: add debug logging to coredump
 socket protocol tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-19-ca449b7b7aa0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=31685; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uKu3QHfWqGHnfWV7aYA2McoSNkcMQko2AYCbqlm6Q8s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB2SnDHpXeB7m2i3WZPDe3y5/Nlbgpu2SkiEKYkez
 nDylEjoKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIhfAiPDjtzyUgNXFda47VdW
 XDoyK2RSzuqv3NNYluf/39PT8e/NT4Z/VtlHC7w3vN3/5TDbNNN5xyXyu5k9YrhzTbe/3qEkH+v
 PDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

So it's easier to figure out bugs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../coredump/coredump_socket_protocol_test.c       | 485 ++++++++++++++++-----
 1 file changed, 367 insertions(+), 118 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
index cc7364499c55..566545e96d7f 100644
--- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
@@ -101,67 +101,97 @@ TEST_F(coredump, socket_request_kernel)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_request_kernel: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_request_kernel: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_request_kernel: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_request_kernel: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_request_kernel: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_request_kernel: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_request_kernel: PIDFD_COREDUMPED not set in coredump_mask\n");
 			goto out;
+		}
 
 		fd_core_file = creat("/tmp/coredump.file", 0644);
-		if (fd_core_file < 0)
+		if (fd_core_file < 0) {
+			fprintf(stderr, "socket_request_kernel: creat coredump file failed: %m\n");
 			goto out;
+		}
 
-		if (!read_coredump_req(fd_coredump, &req))
+		if (!read_coredump_req(fd_coredump, &req)) {
+			fprintf(stderr, "socket_request_kernel: read_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
 					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
+					COREDUMP_REJECT | COREDUMP_WAIT)) {
+			fprintf(stderr, "socket_request_kernel: check_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_KERNEL | COREDUMP_WAIT, 0))
+				       COREDUMP_KERNEL | COREDUMP_WAIT, 0)) {
+			fprintf(stderr, "socket_request_kernel: send_coredump_ack failed\n");
 			goto out;
+		}
 
-		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
+			fprintf(stderr, "socket_request_kernel: read_marker COREDUMP_MARK_REQACK failed\n");
 			goto out;
+		}
 
 		for (;;) {
 			char buffer[4096];
 			ssize_t bytes_read, bytes_write;
 
 			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-			if (bytes_read < 0)
+			if (bytes_read < 0) {
+				fprintf(stderr, "socket_request_kernel: read from coredump socket failed: %m\n");
 				goto out;
+			}
 
 			if (bytes_read == 0)
 				break;
 
 			bytes_write = write(fd_core_file, buffer, bytes_read);
-			if (bytes_read != bytes_write)
+			if (bytes_read != bytes_write) {
+				fprintf(stderr, "socket_request_kernel: write to core file failed (read=%zd, write=%zd): %m\n",
+					bytes_read, bytes_write);
 				goto out;
+			}
 		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_request_kernel: completed successfully\n");
 out:
 		if (fd_core_file >= 0)
 			close(fd_core_file);
@@ -225,62 +255,89 @@ TEST_F(coredump, socket_request_userspace)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_request_userspace: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_request_userspace: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_request_userspace: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_request_userspace: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_request_userspace: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_request_userspace: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_request_userspace: PIDFD_COREDUMPED not set in coredump_mask\n");
 			goto out;
+		}
 
-		if (!read_coredump_req(fd_coredump, &req))
+		if (!read_coredump_req(fd_coredump, &req)) {
+			fprintf(stderr, "socket_request_userspace: read_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
 					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
+					COREDUMP_REJECT | COREDUMP_WAIT)) {
+			fprintf(stderr, "socket_request_userspace: check_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_USERSPACE | COREDUMP_WAIT, 0))
+				       COREDUMP_USERSPACE | COREDUMP_WAIT, 0)) {
+			fprintf(stderr, "socket_request_userspace: send_coredump_ack failed\n");
 			goto out;
+		}
 
-		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
+			fprintf(stderr, "socket_request_userspace: read_marker COREDUMP_MARK_REQACK failed\n");
 			goto out;
+		}
 
 		for (;;) {
 			char buffer[4096];
 			ssize_t bytes_read;
 
 			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-			if (bytes_read > 0)
+			if (bytes_read > 0) {
+				fprintf(stderr, "socket_request_userspace: unexpected data received (expected no coredump data)\n");
 				goto out;
+			}
 
-			if (bytes_read < 0)
+			if (bytes_read < 0) {
+				fprintf(stderr, "socket_request_userspace: read from coredump socket failed: %m\n");
 				goto out;
+			}
 
 			if (bytes_read == 0)
 				break;
 		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_request_userspace: completed successfully\n");
 out:
 		if (fd_peer_pidfd >= 0)
 			close(fd_peer_pidfd);
@@ -338,62 +395,89 @@ TEST_F(coredump, socket_request_reject)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_request_reject: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_request_reject: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_request_reject: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_request_reject: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_request_reject: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_request_reject: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_request_reject: PIDFD_COREDUMPED not set in coredump_mask\n");
 			goto out;
+		}
 
-		if (!read_coredump_req(fd_coredump, &req))
+		if (!read_coredump_req(fd_coredump, &req)) {
+			fprintf(stderr, "socket_request_reject: read_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
 					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
+					COREDUMP_REJECT | COREDUMP_WAIT)) {
+			fprintf(stderr, "socket_request_reject: check_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_REJECT | COREDUMP_WAIT, 0))
+				       COREDUMP_REJECT | COREDUMP_WAIT, 0)) {
+			fprintf(stderr, "socket_request_reject: send_coredump_ack failed\n");
 			goto out;
+		}
 
-		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
+			fprintf(stderr, "socket_request_reject: read_marker COREDUMP_MARK_REQACK failed\n");
 			goto out;
+		}
 
 		for (;;) {
 			char buffer[4096];
 			ssize_t bytes_read;
 
 			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-			if (bytes_read > 0)
+			if (bytes_read > 0) {
+				fprintf(stderr, "socket_request_reject: unexpected data received (expected no coredump data for REJECT)\n");
 				goto out;
+			}
 
-			if (bytes_read < 0)
+			if (bytes_read < 0) {
+				fprintf(stderr, "socket_request_reject: read from coredump socket failed: %m\n");
 				goto out;
+			}
 
 			if (bytes_read == 0)
 				break;
 		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_request_reject: completed successfully\n");
 out:
 		if (fd_peer_pidfd >= 0)
 			close(fd_peer_pidfd);
@@ -451,47 +535,70 @@ TEST_F(coredump, socket_request_invalid_flag_combination)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: PIDFD_COREDUMPED not set in coredump_mask\n");
 			goto out;
+		}
 
-		if (!read_coredump_req(fd_coredump, &req))
+		if (!read_coredump_req(fd_coredump, &req)) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: read_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
 					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
+					COREDUMP_REJECT | COREDUMP_WAIT)) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: check_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_KERNEL | COREDUMP_REJECT | COREDUMP_WAIT, 0))
+				       COREDUMP_KERNEL | COREDUMP_REJECT | COREDUMP_WAIT, 0)) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: send_coredump_ack failed\n");
 			goto out;
+		}
 
-		if (!read_marker(fd_coredump, COREDUMP_MARK_CONFLICTING))
+		if (!read_marker(fd_coredump, COREDUMP_MARK_CONFLICTING)) {
+			fprintf(stderr, "socket_request_invalid_flag_combination: read_marker COREDUMP_MARK_CONFLICTING failed\n");
 			goto out;
+		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_request_invalid_flag_combination: completed successfully\n");
 out:
 		if (fd_peer_pidfd >= 0)
 			close(fd_peer_pidfd);
@@ -549,46 +656,69 @@ TEST_F(coredump, socket_request_unknown_flag)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_request_unknown_flag: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_request_unknown_flag: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_request_unknown_flag: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_request_unknown_flag: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_request_unknown_flag: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_request_unknown_flag: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_request_unknown_flag: PIDFD_COREDUMPED not set in coredump_mask\n");
 			goto out;
+		}
 
-		if (!read_coredump_req(fd_coredump, &req))
+		if (!read_coredump_req(fd_coredump, &req)) {
+			fprintf(stderr, "socket_request_unknown_flag: read_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
 					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
+					COREDUMP_REJECT | COREDUMP_WAIT)) {
+			fprintf(stderr, "socket_request_unknown_flag: check_coredump_req failed\n");
 			goto out;
+		}
 
-		if (!send_coredump_ack(fd_coredump, &req, (1ULL << 63), 0))
+		if (!send_coredump_ack(fd_coredump, &req, (1ULL << 63), 0)) {
+			fprintf(stderr, "socket_request_unknown_flag: send_coredump_ack failed\n");
 			goto out;
+		}
 
-		if (!read_marker(fd_coredump, COREDUMP_MARK_UNSUPPORTED))
+		if (!read_marker(fd_coredump, COREDUMP_MARK_UNSUPPORTED)) {
+			fprintf(stderr, "socket_request_unknown_flag: read_marker COREDUMP_MARK_UNSUPPORTED failed\n");
 			goto out;
+		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_request_unknown_flag: completed successfully\n");
 out:
 		if (fd_peer_pidfd >= 0)
 			close(fd_peer_pidfd);
@@ -646,48 +776,71 @@ TEST_F(coredump, socket_request_invalid_size_small)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_request_invalid_size_small: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_request_invalid_size_small: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_request_invalid_size_small: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_request_invalid_size_small: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_request_invalid_size_small: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_request_invalid_size_small: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_request_invalid_size_small: PIDFD_COREDUMPED not set in coredump_mask\n");
 			goto out;
+		}
 
-		if (!read_coredump_req(fd_coredump, &req))
+		if (!read_coredump_req(fd_coredump, &req)) {
+			fprintf(stderr, "socket_request_invalid_size_small: read_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
 					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
+					COREDUMP_REJECT | COREDUMP_WAIT)) {
+			fprintf(stderr, "socket_request_invalid_size_small: check_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!send_coredump_ack(fd_coredump, &req,
 				       COREDUMP_REJECT | COREDUMP_WAIT,
-				       COREDUMP_ACK_SIZE_VER0 / 2))
+				       COREDUMP_ACK_SIZE_VER0 / 2)) {
+			fprintf(stderr, "socket_request_invalid_size_small: send_coredump_ack failed\n");
 			goto out;
+		}
 
-		if (!read_marker(fd_coredump, COREDUMP_MARK_MINSIZE))
+		if (!read_marker(fd_coredump, COREDUMP_MARK_MINSIZE)) {
+			fprintf(stderr, "socket_request_invalid_size_small: read_marker COREDUMP_MARK_MINSIZE failed\n");
 			goto out;
+		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_request_invalid_size_small: completed successfully\n");
 out:
 		if (fd_peer_pidfd >= 0)
 			close(fd_peer_pidfd);
@@ -745,48 +898,71 @@ TEST_F(coredump, socket_request_invalid_size_large)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_request_invalid_size_large: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_request_invalid_size_large: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_request_invalid_size_large: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_request_invalid_size_large: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_request_invalid_size_large: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_request_invalid_size_large: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_request_invalid_size_large: PIDFD_COREDUMPED not set in coredump_mask\n");
 			goto out;
+		}
 
-		if (!read_coredump_req(fd_coredump, &req))
+		if (!read_coredump_req(fd_coredump, &req)) {
+			fprintf(stderr, "socket_request_invalid_size_large: read_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
 					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT))
+					COREDUMP_REJECT | COREDUMP_WAIT)) {
+			fprintf(stderr, "socket_request_invalid_size_large: check_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!send_coredump_ack(fd_coredump, &req,
 				       COREDUMP_REJECT | COREDUMP_WAIT,
-				       COREDUMP_ACK_SIZE_VER0 + PAGE_SIZE))
+				       COREDUMP_ACK_SIZE_VER0 + PAGE_SIZE)) {
+			fprintf(stderr, "socket_request_invalid_size_large: send_coredump_ack failed\n");
 			goto out;
+		}
 
-		if (!read_marker(fd_coredump, COREDUMP_MARK_MAXSIZE))
+		if (!read_marker(fd_coredump, COREDUMP_MARK_MAXSIZE)) {
+			fprintf(stderr, "socket_request_invalid_size_large: read_marker COREDUMP_MARK_MAXSIZE failed\n");
 			goto out;
+		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_request_invalid_size_large: completed successfully\n");
 out:
 		if (fd_peer_pidfd >= 0)
 			close(fd_peer_pidfd);
@@ -850,49 +1026,75 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_COREDUMPED not set in coredump_mask\n");
 			goto out;
+		}
 
 		/* Verify coredump_signal is available and correct */
-		if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL))
+		if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP_SIGNAL not set in mask\n");
 			goto out;
+		}
 
-		if (info.coredump_signal != SIGSEGV)
+		if (info.coredump_signal != SIGSEGV) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: coredump_signal=%d, expected SIGSEGV=%d\n",
+				info.coredump_signal, SIGSEGV);
 			goto out;
+		}
 
-		if (!read_coredump_req(fd_coredump, &req))
+		if (!read_coredump_req(fd_coredump, &req)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: read_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_REJECT | COREDUMP_WAIT, 0))
+				       COREDUMP_REJECT | COREDUMP_WAIT, 0)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: send_coredump_ack failed\n");
 			goto out;
+		}
 
-		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: read_marker COREDUMP_MARK_REQACK failed\n");
 			goto out;
+		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_coredump_signal_sigsegv: completed successfully\n");
 out:
 		if (fd_peer_pidfd >= 0)
 			close(fd_peer_pidfd);
@@ -957,49 +1159,75 @@ TEST_F(coredump, socket_coredump_signal_sigabrt)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_COREDUMPED not set in coredump_mask\n");
 			goto out;
+		}
 
 		/* Verify coredump_signal is available and correct */
-		if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL))
+		if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP_SIGNAL not set in mask\n");
 			goto out;
+		}
 
-		if (info.coredump_signal != SIGABRT)
+		if (info.coredump_signal != SIGABRT) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: coredump_signal=%d, expected SIGABRT=%d\n",
+				info.coredump_signal, SIGABRT);
 			goto out;
+		}
 
-		if (!read_coredump_req(fd_coredump, &req))
+		if (!read_coredump_req(fd_coredump, &req)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: read_coredump_req failed\n");
 			goto out;
+		}
 
 		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_REJECT | COREDUMP_WAIT, 0))
+				       COREDUMP_REJECT | COREDUMP_WAIT, 0)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: send_coredump_ack failed\n");
 			goto out;
+		}
 
-		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+		if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: read_marker COREDUMP_MARK_REQACK failed\n");
 			goto out;
+		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_coredump_signal_sigabrt: completed successfully\n");
 out:
 		if (fd_peer_pidfd >= 0)
 			close(fd_peer_pidfd);
@@ -1213,11 +1441,15 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
 		n_conns = 0;
 		close(ipc_sockets[0]);
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 		close(ipc_sockets[1]);
 
 		while (n_conns < NUM_CRASHING_COREDUMPS) {
@@ -1227,28 +1459,45 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
 			if (fd_coredump < 0) {
 				if (errno == EAGAIN || errno == EWOULDBLOCK)
 					continue;
+				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: accept4 failed: %m\n");
 				goto out;
 			}
 			fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-			if (fd_peer_pidfd < 0)
+			if (fd_peer_pidfd < 0) {
+				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: get_peer_pidfd failed\n");
 				goto out;
-			if (!get_pidfd_info(fd_peer_pidfd, &info))
+			}
+			if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: get_pidfd_info failed\n");
 				goto out;
-			if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED))
+			}
+			if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED)) {
+				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: missing PIDFD_INFO_COREDUMP or PIDFD_COREDUMPED\n");
 				goto out;
-			if (!read_coredump_req(fd_coredump, &req))
+			}
+			if (!read_coredump_req(fd_coredump, &req)) {
+				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: read_coredump_req failed\n");
 				goto out;
+			}
 			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
 						COREDUMP_KERNEL | COREDUMP_USERSPACE |
-						COREDUMP_REJECT | COREDUMP_WAIT))
+						COREDUMP_REJECT | COREDUMP_WAIT)) {
+				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: check_coredump_req failed\n");
 				goto out;
-			if (!send_coredump_ack(fd_coredump, &req, COREDUMP_KERNEL | COREDUMP_WAIT, 0))
+			}
+			if (!send_coredump_ack(fd_coredump, &req, COREDUMP_KERNEL | COREDUMP_WAIT, 0)) {
+				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: send_coredump_ack failed\n");
 				goto out;
-			if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK))
+			}
+			if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
+				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: read_marker failed\n");
 				goto out;
+			}
 			fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
-			if (fd_core_file < 0)
+			if (fd_core_file < 0) {
+				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: open_coredump_tmpfile failed: %m\n");
 				goto out;
+			}
 			pid_t worker = fork();
 			if (worker == 0) {
 				close(fd_server);

-- 
2.47.3


