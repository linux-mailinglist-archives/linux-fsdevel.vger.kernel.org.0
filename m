Return-Path: <linux-fsdevel+bounces-65494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6886C05ED5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25716584B93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA62358D05;
	Fri, 24 Oct 2025 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew7Zbyny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1983161BA;
	Fri, 24 Oct 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303454; cv=none; b=Qp2S/1YsvI8BlvKHSy0Cz9XXP3uhFjnBIWZ6EIrszQ/2XMSMGTl+vmBm0yteur7gjNiE7/OnC9EB+NTE3ADdld7jDtY/pnuJMoHh0rZM/TiwBV/TOnAZDOhm6bXIcD1Cy2hFOC1qvl2YIknJSXjylrr2pZrXCesM95BWQhLAEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303454; c=relaxed/simple;
	bh=M5JYL/ItXnif2Vw7+GSIT6vFRcZ0KyLdqVkykps56SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJh446vXcxkSW0tm67ydxpc6oqHGmCBPASsV6cV8/Ht5wZOfgmSq6KTSTzqIUoN0j1DIRtbBwkvXLpMph7eO+vp4tEeW5GV+qduLxuiDRJKW2xWhJ2OTmwIEv2q/j6RTrs3n6KzPKODDHRd3TWPsA9xzdXekfkthoOiVw5UWDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew7Zbyny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C606DC116B1;
	Fri, 24 Oct 2025 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303454;
	bh=M5JYL/ItXnif2Vw7+GSIT6vFRcZ0KyLdqVkykps56SU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ew7Zbynye8xWvABfMRcc/O/Duy3HUO61LC0x8VCMkyVJi3inR+S8fKmLnEugrtElC
	 sOPAXgaDN0ty84MNJMOEV9D75EkS7/FFg8wi5T33/jFKnB2lJk522AfiIiL+SXZgYQ
	 TVQs3cTEqBFko9aF+XNbUzjH0y2EdbXj3upvXivfGm7unqdZz3AbSY/6vcre8ug1Wa
	 RB/USoHaHAAe/nEKtcyXun7HNwDVOqJwF1ETDjXKQpH0LC/LDEB9ZTNXtVNdrLZ9Jd
	 GFdV6tGZ9DFJeCJHOlYS5iUXA7S7BaSe0xkIrRzvCXvzzAX1rFPnqLWw2N4x1YSr49
	 W3ZBQGggUU/LQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:23 +0200
Subject: [PATCH v3 54/70] selftests/namespaces: second inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-54-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmp/c/V+uvgOlzqDH/fj1k58HO8hOlXv0YktqiYTH
 J25+EI7OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi5MjIcHn14uu3r83Ne2AY
 tObwaueveg8/nn6xyUvFpmrNV3tN22kMfwWULH7al3R+se/K3KOVunv3c88ZgWs7We74ZqrsZ+n
 hYAcA
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


