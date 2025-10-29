Return-Path: <linux-fsdevel+bounces-66276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D0C1A81E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623FC462C5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032C3655C8;
	Wed, 29 Oct 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKumpihp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD33559FE;
	Wed, 29 Oct 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740758; cv=none; b=FlrWAZGcRU71XjvdCyOsi1Q/yHMkvFtaUWfhoHzQ1/B+iixv3fV5oiNlwdorHTs6CTHTv83BqSd2vOAhy1xE+1qtc15kvlgrlVqZc9nq3lew6743TbE9rqBDbq2S6Ti7Cbd5dqJwnG5KyphWjWxC/2q/tyXqS8EnvFAC6Rm42sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740758; c=relaxed/simple;
	bh=2GRkF4aTvddGMSpKeYnAxQf+2i+z67SQVbcHcw3mqCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gzPRCxouykmUju4zHTlXg/ZvC4W9BQ63jxN5Uf6RZnz8uMnLYMS8C1a82X6HudhGJFScPQNKeikV5N6lo22n1UKyiXWTOECKw9x/tCBxEj3hODTBcGGammzrpm5B7w/aqACXCZ5CEh//Fh9APKsBDLrBSuNs/gCXmY06FVozX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKumpihp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DFAC4CEFF;
	Wed, 29 Oct 2025 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740758;
	bh=2GRkF4aTvddGMSpKeYnAxQf+2i+z67SQVbcHcw3mqCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mKumpihpas/QbwVEtd3uTfPdyRf+1Fmeqr0C/nseeKvZQh4zVbQSofibOUqDKIU9s
	 LtYttIZlx5y9AL9uCEd8u+TYiK318Ry8pmzdtktGruLIrRGQbgiea7vIWcoIyusU6r
	 +nblh6bpqq7/AtUcxiQzy2wYTxUMaRkn9A7+qYvQzwIgVqTVjdNxM7RcKUZX3tTCw8
	 94OI7d4ctNMtfyFCBaJqwTOfKRC34yhgniA6kS51N6giK2YrgKS9OHbbj7g7yEpnDN
	 rYJVPmcAb7KMpVqmCgE589xUlmnKEF0q2BIlLPxGpBW9PC4imsDhLBop0qxOSsvvaD
	 dNX9h4crFIUAw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:16 +0100
Subject: [PATCH v4 63/72] selftests/namespaces: ninth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-63-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=5894; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2GRkF4aTvddGMSpKeYnAxQf+2i+z67SQVbcHcw3mqCk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfXv3Hw2VPvj6SmTq8ulv7OpHtF29xC6rlk992n1s
 lub1c56dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkdiUjw9KK3Mmz/026kx3/
 0a3x+E/x/eefLEjeVJtd0NGzw9R9lQUjQ0v94+Wyn47MiJsyefYfncN+4cc+5sT1JbTlXL+bu/F
 jLTcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that socket-kept netns appears in listns() output.
Verify that a network namespace kept alive by a socket FD appears in
listns() output even after the creating process exits, and that it
disappears when the socket is closed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 203 +++++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 47c1524a8648..98f6a0e1b9dd 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -576,4 +576,207 @@ TEST(siocgskns_ipv6)
 	close(current_netns_fd);
 }
 
+/*
+ * Test that socket-kept netns appears in listns() output.
+ * Verify that a network namespace kept alive by a socket FD appears in
+ * listns() output even after the creating process exits, and that it
+ * disappears when the socket is closed.
+ */
+TEST(siocgskns_listns_visibility)
+{
+	int sock_fd, netns_fd, owner_fd;
+	int ipc_sockets[2];
+	pid_t pid;
+	int status;
+	__u64 netns_id, owner_id;
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWNET,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[256];
+	int ret, i;
+	bool found_netns = false;
+
+	EXPECT_EQ(socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child: create new netns and socket */
+		close(ipc_sockets[0]);
+
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(ipc_sockets[1]);
+			exit(1);
+		}
+
+		sock_fd = socket(AF_INET, SOCK_DGRAM, 0);
+		if (sock_fd < 0) {
+			close(ipc_sockets[1]);
+			exit(1);
+		}
+
+		/* Send socket FD to parent via SCM_RIGHTS */
+		struct msghdr msg = {0};
+		struct iovec iov = {0};
+		char buf[1] = {'X'};
+		char cmsg_buf[CMSG_SPACE(sizeof(int))];
+
+		iov.iov_base = buf;
+		iov.iov_len = 1;
+		msg.msg_iov = &iov;
+		msg.msg_iovlen = 1;
+		msg.msg_control = cmsg_buf;
+		msg.msg_controllen = sizeof(cmsg_buf);
+
+		struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+		cmsg->cmsg_level = SOL_SOCKET;
+		cmsg->cmsg_type = SCM_RIGHTS;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+		memcpy(CMSG_DATA(cmsg), &sock_fd, sizeof(int));
+
+		if (sendmsg(ipc_sockets[1], &msg, 0) < 0) {
+			close(sock_fd);
+			close(ipc_sockets[1]);
+			exit(1);
+		}
+
+		close(sock_fd);
+		close(ipc_sockets[1]);
+		exit(0);
+	}
+
+	/* Parent: receive socket FD */
+	close(ipc_sockets[1]);
+
+	struct msghdr msg = {0};
+	struct iovec iov = {0};
+	char buf[1];
+	char cmsg_buf[CMSG_SPACE(sizeof(int))];
+
+	iov.iov_base = buf;
+	iov.iov_len = 1;
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
+
+	ssize_t n = recvmsg(ipc_sockets[0], &msg, 0);
+	close(ipc_sockets[0]);
+	ASSERT_EQ(n, 1);
+
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+	ASSERT_NE(cmsg, NULL);
+	memcpy(&sock_fd, CMSG_DATA(cmsg), sizeof(int));
+
+	/* Wait for child to exit */
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/* Get network namespace from socket */
+	netns_fd = ioctl(sock_fd, SIOCGSKNS);
+	if (netns_fd < 0) {
+		close(sock_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(netns_fd, 0);
+	}
+
+	/* Get namespace ID */
+	ret = ioctl(netns_fd, NS_GET_ID, &netns_id);
+	if (ret < 0) {
+		close(sock_fd);
+		close(netns_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "NS_GET_ID not supported");
+		ASSERT_EQ(ret, 0);
+	}
+
+	/* Get owner user namespace */
+	owner_fd = ioctl(netns_fd, NS_GET_USERNS);
+	if (owner_fd < 0) {
+		close(sock_fd);
+		close(netns_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "NS_GET_USERNS not supported");
+		ASSERT_GE(owner_fd, 0);
+	}
+
+	/* Get owner namespace ID */
+	ret = ioctl(owner_fd, NS_GET_ID, &owner_id);
+	if (ret < 0) {
+		close(owner_fd);
+		close(sock_fd);
+		close(netns_fd);
+		ASSERT_EQ(ret, 0);
+	}
+	close(owner_fd);
+
+	/* Namespace should appear in listns() output */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		close(sock_fd);
+		close(netns_fd);
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		TH_LOG("listns failed: %s", strerror(errno));
+		ASSERT_GE(ret, 0);
+	}
+
+	/* Search for our network namespace in the list */
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == netns_id) {
+			found_netns = true;
+			break;
+		}
+	}
+
+	ASSERT_TRUE(found_netns);
+	TH_LOG("Found netns %llu in listns() output (kept alive by socket)", netns_id);
+
+	/* Now verify with owner filtering */
+	req.user_ns_id = owner_id;
+	found_netns = false;
+
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	ASSERT_GE(ret, 0);
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == netns_id) {
+			found_netns = true;
+			break;
+		}
+	}
+
+	ASSERT_TRUE(found_netns);
+	TH_LOG("Found netns %llu owned by userns %llu", netns_id, owner_id);
+
+	/* Close socket - namespace should become inactive and disappear from listns() */
+	close(sock_fd);
+	close(netns_fd);
+
+	/* Verify it's no longer in listns() output */
+	req.user_ns_id = 0;
+	found_netns = false;
+
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	ASSERT_GE(ret, 0);
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == netns_id) {
+			found_netns = true;
+			break;
+		}
+	}
+
+	ASSERT_FALSE(found_netns);
+	TH_LOG("Netns %llu correctly disappeared from listns() after socket closed", netns_id);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


