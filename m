Return-Path: <linux-fsdevel+bounces-66269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FB3C1A945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7173A561FD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5434F472;
	Wed, 29 Oct 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ42iSYi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017A329391;
	Wed, 29 Oct 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740722; cv=none; b=JCV2O2lC+BRfIQdjzQf2EAhBphltzoCgLaBvyXAiNmV3RYTc4jc0Old4NUvR/uVzSI5V53XxTJUWgVx2x8Nl03RNYrjXbXh7c+qNAiXY9QEZaGEPDSrOFMtESGnBt27EqcVYdS7f0cxesAQIzMTnrHs3QOGxlozLch21UegjuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740722; c=relaxed/simple;
	bh=M5JYL/ItXnif2Vw7+GSIT6vFRcZ0KyLdqVkykps56SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KEWBdAXAhwS8GTQHATO3V+ABmgWZmXndotZVel6aBAXduTswGmor7e7jq6kts9kzSZ+eMwFy5HvH6EsrxyqEur3kA3ycowb24gYt9bd396qsqUM7U+mL6c1g7MXg0qMR/jEvlBecQnkqIUHLyHskWn+ANTagel2/NnBulKQaE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ42iSYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94822C4CEFD;
	Wed, 29 Oct 2025 12:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740722;
	bh=M5JYL/ItXnif2Vw7+GSIT6vFRcZ0KyLdqVkykps56SU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QJ42iSYiEc0/SyvSVlMLEFslZsDmPFkoufbTXhoF8eA1/9D3aerbubBsP7uwRRQTj
	 ijj4DpmiN1CrJs58YtxNOexc9bBbTbEUOWoXLREV3paCtBOtfU8VsfRKB0yCLW+Hlm
	 ZJ2XEorkEUzezWDkqDi5J4WK+IsdWxWfJWD9pJzP39I+BMb1aHRh4H+VZUuy7yr+62
	 /XJoyPpMMtLtmekHz2DBC8NQjvzoao0P7juPfC9BbzSfoBvfkSm0u4WhSffniub+1L
	 0drIWd5BM7rBQYxNxYjE6tCpo1gyKeD1Adki6AY2cGzEYJq8rxjTSfRY9ZPuLTTeZ2
	 us23UfdlMp5kg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:09 +0100
Subject: [PATCH v4 56/72] selftests/namespaces: second inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-56-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4149; i=brauner@kernel.org;
 h=from:subject:message-id; bh=M5JYL/ItXnif2Vw7+GSIT6vFRcZ0KyLdqVkykps56SU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfUbrJ9/6Vgc76cNQlJ1u7707VtZsk97wYKImLCiF
 d56/5zYO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyUIuR4cCMs8nh2nov4u78
 EtqVHFjQ+3H6761crjE9+5qPL4oM38zIsP5/wvqSpG97G63clD/fk/vrdu1zxHRuhyDLz96hUg+
 42AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that socket file descriptors keep network namespaces active. Create
a network namespace, create a socket in it, then exit the namespace. The
namespace should remain active while the socket FD is held.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 126 +++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 0c9098624cd4..0ad5e39b7e16 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -69,4 +69,130 @@ TEST(siocgskns_basic)
 	close(current_netns_fd);
 }
 
+/*
+ * Test that socket file descriptors keep network namespaces active.
+ * Create a network namespace, create a socket in it, then exit the namespace.
+ * The namespace should remain active while the socket FD is held.
+ */
+TEST(siocgskns_keeps_netns_active)
+{
+	int sock_fd, netns_fd, test_fd;
+	int ipc_sockets[2];
+	pid_t pid;
+	int status;
+	struct stat st;
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
+			TH_LOG("unshare(CLONE_NEWNET) failed: %s", strerror(errno));
+			close(ipc_sockets[1]);
+			exit(1);
+		}
+
+		/* Create a socket in the new network namespace */
+		sock_fd = socket(AF_INET, SOCK_DGRAM, 0);
+		if (sock_fd < 0) {
+			TH_LOG("socket() failed: %s", strerror(errno));
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
+	ASSERT_EQ(cmsg->cmsg_type, SCM_RIGHTS);
+
+	memcpy(&sock_fd, CMSG_DATA(cmsg), sizeof(int));
+
+	/* Wait for child to exit */
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) != 0)
+		SKIP(close(sock_fd); return, "Child failed to create namespace");
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
+	ASSERT_EQ(fstat(netns_fd, &st), 0);
+
+	/*
+	 * Namespace should still be active because socket FD keeps it alive.
+	 * Try to access it via /proc/self/fd/<fd>.
+	 */
+	char path[64];
+	snprintf(path, sizeof(path), "/proc/self/fd/%d", netns_fd);
+	test_fd = open(path, O_RDONLY);
+	ASSERT_GE(test_fd, 0);
+	close(test_fd);
+	close(netns_fd);
+
+	/* Close socket - namespace should become inactive */
+	close(sock_fd);
+
+	/* Try SIOCGSKNS again - should fail since socket is closed */
+	ASSERT_LT(ioctl(sock_fd, SIOCGSKNS), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


