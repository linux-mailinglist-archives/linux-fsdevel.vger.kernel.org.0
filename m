Return-Path: <linux-fsdevel+bounces-65897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D5C139DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6C564458
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D42E8B61;
	Tue, 28 Oct 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmZouf0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A72E7F3F;
	Tue, 28 Oct 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641237; cv=none; b=i2GqlZk3kROD3Vcdt1ozO4lW07CPICb4v6Dee6PlTcbAnWWVsCx7y7grBrGLdRfpylWQ+nLKdXtjiFPB1BKKA0UeVLwKg8R6igBtmV26dcrmxUypRHKK0KwoAfcqfPPP17X9EqGq3SW0OBs6kGK9Pl69PpRLBnbJuT8PCSGpg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641237; c=relaxed/simple;
	bh=Ee/5VC+eO+oJ1PEBoNfOcUfeEeUQgTRrQThR619JMlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUnP+Rkx1xeyqhQBO+49siOmcRT5jd/A/1WouDRHYMhZRsnrlj5ea49SqQ+gjZQCUqPKl4hXgmEMcL2NPm11q5ExbcZ4abh2+ZQXcKRkrNcELuOiZt/GUWYj97VoPNOkf0fzOHwA7yhPu8rSvywYIGxD+FXRbHp0v0/WV2F+Ong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmZouf0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45002C4CEFF;
	Tue, 28 Oct 2025 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641237;
	bh=Ee/5VC+eO+oJ1PEBoNfOcUfeEeUQgTRrQThR619JMlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MmZouf0NmYXxDYINcZZgbWXVN1krmfTSPaSvhWBXFFGVot+GtgOP5HGsYEMTvB94n
	 lZQ27Gg5gjw58n/QMT2VeQZOdyo8t7aozbLdajGBnwwan05oicNgsg7pTLLZ8y/FEI
	 f2I8dmGJ6L3iC93xQwJIqXq7iiQ5bOJpKJE1Hv0F680RpeJ+iINLvO/IhGxl1a975+
	 nmyzriJhLlpR5kDvcfZDBXkC3H6zjjsoPiOJy/NfvzCMNctcqzlGqwLz9Tnxzz2iCR
	 GUP7QeQBq99lkNke1Ueh/9a5mWWYjf2LCMfY2gkOjF2Tz0s+vZW01IOl7TPK/sq38o
	 b7fT0+gS5ruIQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:46:02 +0100
Subject: [PATCH 17/22] selftests/coredump: add debug logging to test
 helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-17-ca449b7b7aa0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4675; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ee/5VC+eO+oJ1PEBoNfOcUfeEeUQgTRrQThR619JMlQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB2acfB59dl6ja6rgeu/qSSt8ngkMvtXsku4wDeXx
 Ck/X0lqdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEqY/hf1lATsrBhb84DS/m
 rjaXyBCZfOb6lFmf2WdWPL/24W5kUynDP33ndA8nlvIy/3vLVJTnqgjFHJjcf9XedupT92zpNL3
 pTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

so we can easily figure out why something failed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/coredump/coredump_test_helpers.c     | 55 +++++++++++++++++-----
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 116c797090a1..65deb3cfbe1b 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -131,17 +131,26 @@ int get_peer_pidfd(int fd)
 	int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd,
 			     &fd_peer_pidfd_len);
 	if (ret < 0) {
-		fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
+		fprintf(stderr, "get_peer_pidfd: getsockopt(SO_PEERPIDFD) failed: %m\n");
 		return -1;
 	}
+	fprintf(stderr, "get_peer_pidfd: successfully retrieved pidfd %d\n", fd_peer_pidfd);
 	return fd_peer_pidfd;
 }
 
 bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
 {
+	int ret;
 	memset(info, 0, sizeof(*info));
 	info->mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;
-	return ioctl(fd_peer_pidfd, PIDFD_GET_INFO, info) == 0;
+	ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, info);
+	if (ret < 0) {
+		fprintf(stderr, "get_pidfd_info: ioctl(PIDFD_GET_INFO) failed: %m\n");
+		return false;
+	}
+	fprintf(stderr, "get_pidfd_info: mask=0x%llx, coredump_mask=0x%x, coredump_signal=%d\n",
+		(unsigned long long)info->mask, info->coredump_mask, info->coredump_signal);
+	return true;
 }
 
 /* Protocol helper functions */
@@ -198,14 +207,23 @@ bool read_coredump_req(int fd, struct coredump_req *req)
 
 	/* Peek the size of the coredump request. */
 	ret = recv(fd, req, field_size, MSG_PEEK | MSG_WAITALL);
-	if (ret != field_size)
+	if (ret != field_size) {
+		fprintf(stderr, "read_coredump_req: peek failed (got %zd, expected %zu): %m\n",
+			ret, field_size);
 		return false;
+	}
 	kernel_size = req->size;
 
-	if (kernel_size < COREDUMP_ACK_SIZE_VER0)
+	if (kernel_size < COREDUMP_ACK_SIZE_VER0) {
+		fprintf(stderr, "read_coredump_req: kernel_size %zu < min %d\n",
+			kernel_size, COREDUMP_ACK_SIZE_VER0);
 		return false;
-	if (kernel_size >= PAGE_SIZE)
+	}
+	if (kernel_size >= PAGE_SIZE) {
+		fprintf(stderr, "read_coredump_req: kernel_size %zu >= PAGE_SIZE %d\n",
+			kernel_size, PAGE_SIZE);
 		return false;
+	}
 
 	/* Use the minimum of user and kernel size to read the full request. */
 	user_size = sizeof(struct coredump_req);
@@ -295,25 +313,35 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
 
 	/* Set socket to non-blocking mode for edge-triggered epoll */
 	flags = fcntl(fd_coredump, F_GETFL, 0);
-	if (flags < 0)
+	if (flags < 0) {
+		fprintf(stderr, "Worker: fcntl(F_GETFL) failed: %m\n");
 		goto out;
-	if (fcntl(fd_coredump, F_SETFL, flags | O_NONBLOCK) < 0)
+	}
+	if (fcntl(fd_coredump, F_SETFL, flags | O_NONBLOCK) < 0) {
+		fprintf(stderr, "Worker: fcntl(F_SETFL, O_NONBLOCK) failed: %m\n");
 		goto out;
+	}
 
 	epfd = epoll_create1(0);
-	if (epfd < 0)
+	if (epfd < 0) {
+		fprintf(stderr, "Worker: epoll_create1() failed: %m\n");
 		goto out;
+	}
 
 	ev.events = EPOLLIN | EPOLLRDHUP | EPOLLET;
 	ev.data.fd = fd_coredump;
-	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd_coredump, &ev) < 0)
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd_coredump, &ev) < 0) {
+		fprintf(stderr, "Worker: epoll_ctl(EPOLL_CTL_ADD) failed: %m\n");
 		goto out;
+	}
 
 	for (;;) {
 		struct epoll_event events[1];
 		int n = epoll_wait(epfd, events, 1, -1);
-		if (n < 0)
+		if (n < 0) {
+			fprintf(stderr, "Worker: epoll_wait() failed: %m\n");
 			break;
+		}
 
 		if (events[0].events & (EPOLLIN | EPOLLRDHUP)) {
 			for (;;) {
@@ -322,19 +350,24 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
 				if (bytes_read < 0) {
 					if (errno == EAGAIN || errno == EWOULDBLOCK)
 						break;
+					fprintf(stderr, "Worker: read() failed: %m\n");
 					goto out;
 				}
 				if (bytes_read == 0)
 					goto done;
 				ssize_t bytes_write = write(fd_core_file, buffer, bytes_read);
-				if (bytes_write != bytes_read)
+				if (bytes_write != bytes_read) {
+					fprintf(stderr, "Worker: write() failed (read=%zd, write=%zd): %m\n",
+						bytes_read, bytes_write);
 					goto out;
+				}
 			}
 		}
 	}
 
 done:
 	exit_code = EXIT_SUCCESS;
+	fprintf(stderr, "Worker: completed successfully\n");
 out:
 	if (epfd >= 0)
 		close(epfd);

-- 
2.47.3


