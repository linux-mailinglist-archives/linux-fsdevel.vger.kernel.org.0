Return-Path: <linux-fsdevel+bounces-65898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00552C139F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BF11AA5EED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041EB2E92C3;
	Tue, 28 Oct 2025 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzrUJVB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537432D97AA;
	Tue, 28 Oct 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641241; cv=none; b=Bmryflh2ZvwlRJglbhF1hU9xm0op0GftPZyN8rhpjp0fhTUoLqXjzOYIAtk/fztt8nP8+TMxP4ZQRXxlDDyMbLNnnkcza4b3vc+SwIwNNYx7EVPlo/hy+RbrWYeS6uM2EDAjRuxrIs0ocWGGzTfkx4J2Fz29Vaw3Y/Y2eLe/j9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641241; c=relaxed/simple;
	bh=W4SO4YgiNboWrYou0wEK2OcL63i4VEU6YP08vXBx5ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQbdhfC7eUQWNUZ2NKs+Xg07dgV+hI/6MurZJ22JsyPjqruBzLXBMXoeQ1xxtzJXNIywck+RtIqZknbWEbd8VLsUQDCI4N/H5eeB8umQkrXkNW7AyEM3Nesahj1sAz7x3VZgAugwQuDQ4zlR1O+R7s5+aF3KQXEiCjwwcSopQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzrUJVB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73142C4CEE7;
	Tue, 28 Oct 2025 08:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641241;
	bh=W4SO4YgiNboWrYou0wEK2OcL63i4VEU6YP08vXBx5ss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jzrUJVB9eB/ktS4ejdQ4NWg3X2JVvyxyez+v7RkKMxZxlr+ub+eN1zD0CkYrWx7pP
	 Nq3p8GLF4QR6JMK++/qNZmqVvJ1A0MaWB1Ojq933NQawLo9M9ib9HnJ4MIKS1pMUeL
	 L+CxCnlMJt4W8X2UrEdn6K9/PPdQeYng9oprY05HbuCTw8IRep0kQJ80wi8T41lCX+
	 va2v4fY6UfvSBKwV0IyygkCg1N3U498ggYUTvKcNairSSuWcvpiNkzOebrahC949Jk
	 vG1U+Yt2UZHgm+pZfZTMBPv30tnXa9FLCzIs9uo7d5KqqjqaM+XulOz9lWETTsPBS2
	 H2d+6gyip+WnA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:46:03 +0100
Subject: [PATCH 18/22] selftests/coredump: add debug logging to coredump
 socket tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-18-ca449b7b7aa0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6475; i=brauner@kernel.org;
 h=from:subject:message-id; bh=W4SO4YgiNboWrYou0wEK2OcL63i4VEU6YP08vXBx5ss=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB36XOiS7T+380PE1DMbri7bnentXV2wccuxsxsXS
 yfeFH9b31HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRDhZGhl9yfM7H73F+uLBf
 pNJfcOKDu0u1n69QYDkQwLDngtJkTk6G/9kif+9Z/RFfffO85YXdjcIndfWOr0/+XFM/00Pj8yV
 WEx4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

So it's easier to figure out bugs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/coredump/coredump_socket_test.c      | 93 +++++++++++++++++-----
 1 file changed, 71 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index 5103d9f13003..0a37d0456672 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -98,52 +98,74 @@ TEST_F(coredump, socket)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket test: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket test: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket test: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket test: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket test: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket test: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED))
+		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "socket test: PIDFD_COREDUMPED not set in coredump_mask\n");
 			goto out;
+		}
 
 		fd_core_file = creat("/tmp/coredump.file", 0644);
-		if (fd_core_file < 0)
+		if (fd_core_file < 0) {
+			fprintf(stderr, "socket test: creat coredump file failed: %m\n");
 			goto out;
+		}
 
 		for (;;) {
 			char buffer[4096];
 			ssize_t bytes_read, bytes_write;
 
 			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
-			if (bytes_read < 0)
+			if (bytes_read < 0) {
+				fprintf(stderr, "socket test: read from coredump socket failed: %m\n");
 				goto out;
+			}
 
 			if (bytes_read == 0)
 				break;
 
 			bytes_write = write(fd_core_file, buffer, bytes_read);
-			if (bytes_read != bytes_write)
+			if (bytes_read != bytes_write) {
+				fprintf(stderr, "socket test: write to core file failed (read=%zd, write=%zd): %m\n",
+					bytes_read, bytes_write);
 				goto out;
+			}
 		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket test: completed successfully\n");
 out:
 		if (fd_core_file >= 0)
 			close(fd_core_file);
@@ -208,32 +230,47 @@ TEST_F(coredump, socket_detect_userspace_client)
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_detect_userspace_client: create_and_listen_unix_socket failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_detect_userspace_client: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_detect_userspace_client: accept4 failed: %m\n");
 			goto out;
+		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_detect_userspace_client: get_peer_pidfd failed\n");
 			goto out;
+		}
 
-		if (!get_pidfd_info(fd_peer_pidfd, &info))
+		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+			fprintf(stderr, "socket_detect_userspace_client: get_pidfd_info failed\n");
 			goto out;
+		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP))
+		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
+			fprintf(stderr, "socket_detect_userspace_client: PIDFD_INFO_COREDUMP not set in mask\n");
 			goto out;
+		}
 
-		if (info.coredump_mask & PIDFD_COREDUMPED)
+		if (info.coredump_mask & PIDFD_COREDUMPED) {
+			fprintf(stderr, "socket_detect_userspace_client: PIDFD_COREDUMPED incorrectly set (should be userspace client)\n");
 			goto out;
+		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_detect_userspace_client: completed successfully\n");
 out:
 		if (fd_peer_pidfd >= 0)
 			close(fd_peer_pidfd);
@@ -263,15 +300,20 @@ TEST_F(coredump, socket_detect_userspace_client)
 			sizeof("/tmp/coredump.socket");
 
 		fd_socket = socket(AF_UNIX, SOCK_STREAM, 0);
-		if (fd_socket < 0)
+		if (fd_socket < 0) {
+			fprintf(stderr, "socket_detect_userspace_client (client): socket failed: %m\n");
 			_exit(EXIT_FAILURE);
+		}
 
 		ret = connect(fd_socket, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
-		if (ret < 0)
+		if (ret < 0) {
+			fprintf(stderr, "socket_detect_userspace_client (client): connect failed: %m\n");
 			_exit(EXIT_FAILURE);
+		}
 
 		close(fd_socket);
 		pause();
+		fprintf(stderr, "socket_detect_userspace_client (client): completed successfully\n");
 		_exit(EXIT_SUCCESS);
 	}
 
@@ -342,17 +384,24 @@ TEST_F(coredump, socket_no_listener)
 		close(ipc_sockets[0]);
 
 		fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
-		if (fd_server < 0)
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_no_listener: socket failed: %m\n");
 			goto out;
+		}
 
 		ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
-		if (ret < 0)
+		if (ret < 0) {
+			fprintf(stderr, "socket_no_listener: bind failed: %m\n");
 			goto out;
+		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_no_listener: write_nointr to ipc socket failed: %m\n");
 			goto out;
+		}
 
 		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_no_listener: completed successfully\n");
 out:
 		if (fd_server >= 0)
 			close(fd_server);

-- 
2.47.3


