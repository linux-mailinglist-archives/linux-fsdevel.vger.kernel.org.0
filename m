Return-Path: <linux-fsdevel+bounces-65186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9240BFD62F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4723BBAE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A1383386;
	Wed, 22 Oct 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYR59V8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A84383366;
	Wed, 22 Oct 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149475; cv=none; b=seK1aW13T2Te79LnhsLLf6jmxAmjVPBfS/CJVBX2UOx0SDU8ihaPKCJuHz/RyRmA7xaqHezygY+qvdp7NjmIcEn4YpTHeg1aaT78UaAuIKc9Pp2CpZ6t8sxJHp0n/mJtRGZhW53ZKU7DcnTrn3/i2zOc5xlHTSfS3A3PIdIR6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149475; c=relaxed/simple;
	bh=GsTFrZ8P1sWrb+90uv1i8VCB1pEYoHIvAvoNNGUl0r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XhTdOA9Q71zEqrA67LcHeqF5vbX5ZMaOEcKzWQ1pB1owRhZXlVJL+Fk/9EZPvl22nFibBeoScFMLAJSdO4vtsMAnWpUEtjMGr3DiwAeVkFPpIVVULQMWp94dBdQsO9MgCy/vl8Ii60f19pHQInjtSz28P8J4nSwLNusoM5IRH40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYR59V8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2453C4CEE7;
	Wed, 22 Oct 2025 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149474;
	bh=GsTFrZ8P1sWrb+90uv1i8VCB1pEYoHIvAvoNNGUl0r4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MYR59V8uDNaPYb1rZmXgVKZO4afxZivUdkh0g49G2Fgz0HJ0HYNH0o4FjtGuUoU9s
	 UBd0hhEYUSb1lhtgLR76KLfFftrw5kCZ8PP2K7pEsJiX+2VUUvjHRFwt3Wm+aAhN6y
	 nWfm5ytZMEbpNOw/QB703ChW71uLIkhbFFfKFYS9R8l2719fbU1iygSQI094UaG462
	 VDTMcH7b/hQdU23lOKZ7rclgUbmxMdcBTwl29rJGJIVPK/HSm8QYFCv+xI2i8BDfpW
	 +RmXKMMbBzX+Fo5rojMQRjkA0Tr9lP5V2mr0TIJ9LymCPvpk3Tr5QuyHLhvM+eyEfv
	 VgJr11SvzDGMg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:36 +0200
Subject: [PATCH v2 58/63] selftests/namespaces: seventh inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-58-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4066; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GsTFrZ8P1sWrb+90uv1i8VCB1pEYoHIvAvoNNGUl0r4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHi+qsjVvTappvyU/n0hlWkTc5T6fyX9OTLt3TU5m
 +QFd1bd7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI6yZGhq03auc9LoyQeVy7
 z3yLXEfKzmuuTUXucra8kk9OCm/o4WFkmP10jdZEqcWpdUfDQxK/1v3cuuDqwtsMP1POF37t+G5
 8mxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test socket keeps netns active after creating process exits. Verify that
as long as the socket FD exists, the namespace remains active.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 141 +++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index d11b3a9c4cfd..17f2cafb75a7 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -402,4 +402,145 @@ TEST(siocgskns_multiple_sockets)
 	}
 }
 
+/*
+ * Test socket keeps netns active after creating process exits.
+ * Verify that as long as the socket FD exists, the namespace remains active.
+ */
+TEST(siocgskns_netns_lifecycle)
+{
+	int sock_fd, netns_fd;
+	int ipc_sockets[2];
+	int syncpipe[2];
+	pid_t pid;
+	int status;
+	char sync_byte;
+	struct stat st;
+	ino_t netns_ino;
+
+	EXPECT_EQ(socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
+
+	ASSERT_EQ(pipe(syncpipe), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child */
+		close(ipc_sockets[0]);
+		close(syncpipe[1]);
+
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(ipc_sockets[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+
+		sock_fd = socket(AF_INET, SOCK_STREAM, 0);
+		if (sock_fd < 0) {
+			close(ipc_sockets[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+
+		/* Send socket to parent */
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
+			close(syncpipe[0]);
+			exit(1);
+		}
+
+		close(sock_fd);
+		close(ipc_sockets[1]);
+
+		/* Wait for parent signal */
+		read(syncpipe[0], &sync_byte, 1);
+		close(syncpipe[0]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(ipc_sockets[1]);
+	close(syncpipe[0]);
+
+	/* Receive socket FD */
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
+	/* Get netns from socket while child is alive */
+	netns_fd = ioctl(sock_fd, SIOCGSKNS);
+	if (netns_fd < 0) {
+		sync_byte = 'G';
+		write(syncpipe[1], &sync_byte, 1);
+		close(syncpipe[1]);
+		close(sock_fd);
+		waitpid(pid, NULL, 0);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(netns_fd, 0);
+	}
+	ASSERT_EQ(fstat(netns_fd, &st), 0);
+	netns_ino = st.st_ino;
+
+	/* Signal child to exit */
+	sync_byte = 'G';
+	write(syncpipe[1], &sync_byte, 1);
+	close(syncpipe[1]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	/*
+	 * Socket FD should still keep namespace active even after
+	 * the creating process exited.
+	 */
+	int test_fd = ioctl(sock_fd, SIOCGSKNS);
+	ASSERT_GE(test_fd, 0);
+
+	struct stat st_test;
+	ASSERT_EQ(fstat(test_fd, &st_test), 0);
+	ASSERT_EQ(st_test.st_ino, netns_ino);
+
+	close(test_fd);
+	close(netns_fd);
+
+	/* Close socket - namespace should become inactive */
+	close(sock_fd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


