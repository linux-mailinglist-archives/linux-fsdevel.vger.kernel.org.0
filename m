Return-Path: <linux-fsdevel+bounces-65181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56DBFD3E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC5D6568A97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8966380F59;
	Wed, 22 Oct 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4Zi7+HU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED2A359F8B;
	Wed, 22 Oct 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149448; cv=none; b=HJOpZJRwQGodBjZmepzZQE6PL9SYB2M0yaoyAHmJFUMT3bvbeijB4znbJcpOEGya5vNLEXRl/6uurrgvBg1QFy4VgU02vkn3aj9+ViUY3VhFj+eYugzMEIHfm5w0IjK0OdBlR8/bG4mWD7vo+URE2+gqBsOkNRssF+prIltz+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149448; c=relaxed/simple;
	bh=M5JYL/ItXnif2Vw7+GSIT6vFRcZ0KyLdqVkykps56SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbWv9gTzoyeC1MIWw3bgJO1vE51Utn5zjTQIRKEtRRWniPrDsn8xtTtNQpFyawsFPKUICmQ2/4tO7hwkcWQ4B2/Xy+iAqtJQDsV7a6AYRrOE2lnDggWvN9AsWzPXctFEEEK6mo7aQJo9/lAafBB7dQ5isqggQB3ekKiABh6x1vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4Zi7+HU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D80DC4CEF7;
	Wed, 22 Oct 2025 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149447;
	bh=M5JYL/ItXnif2Vw7+GSIT6vFRcZ0KyLdqVkykps56SU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z4Zi7+HUkhTnZ2cGIpIl7U4sr67DnfiQEBRzTV2iwZ9d/FhE+lD87TzlRIaDWOEpX
	 yxK/TydkHNg5XJPqYp2F+sI6nzVNZRvz7ZMBq9znfC4HMJ0K/Rz0r1kHHzDQBz+Ghr
	 NsvppqEZCtbT/GKVq9zpsOkdGJ8oimsuqfOgeZQOXr0d/+FSRS1tbhfiA2Wzc6Z3Gu
	 4jJ3SRatJOXIhgB61n138FebEnYwhn91qUb2DZm86Rr9jmQoA2uPZ00w2ACNKnxl4R
	 b74nS8+luv0+4iEUMC69efP74EYdIy9fxqA5rmAdyqZj1XV93Td00I9Fes8+ru/aw7
	 LD+4gg7sboFng==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:31 +0200
Subject: [PATCH v2 53/63] selftests/namespaces: second inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-53-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHi+wUroGKdm/4Ra+4Dc/wveKN/PP69V8fCMn9sbg
 RV9LkFbO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyewYjw1GpPap3di5nmH/4
 8NlmxdmrOAwt+kOm17IbdCnyTaqslmBk+H+p3GvRI+aGeVb/lhx8F+v2Qlfv4dSjUVm/Tk0+12r
 pzgcA
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


