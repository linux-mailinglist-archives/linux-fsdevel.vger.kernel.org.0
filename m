Return-Path: <linux-fsdevel+bounces-65499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F17C06001
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A5445833B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D1368F27;
	Fri, 24 Oct 2025 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEF6+UgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1731283B;
	Fri, 24 Oct 2025 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303510; cv=none; b=Ce1tUpZY0AUVoLro9Ja00uF7b+NsbyVSxOxygvffSMgoyBLVL1vbQyeu8lbXBagh1cHfcCeA3061HSO6tt1SotulTPjSjAlDV1fRQwlfbRkV/n2k1F4MgAjYLGOylzOl5jFeFomWc9jgOSLQ3gOoyUpVHm1woEYWudRFFCbedQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303510; c=relaxed/simple;
	bh=0F9mhX2Gl3SVx+//eDdT9Tj87KVi2B6yYobSD3BfDnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+eFVIhaQBf92wZSxZgQAL3NN+/07Zh17IjKrU2i03MEbkQLI7QAs3wvCekIGdJ/TVg+REXNWRbV5AmNc00c0hTwGMxnLz5IIIOiSkM7D8RoyqDO816lAH+jSgXLye/+xJDR6kMZTeE8Tu9fB0mJ8ddWigRVXtRU1CQhxUv/lBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEF6+UgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F21C4CEFF;
	Fri, 24 Oct 2025 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303509;
	bh=0F9mhX2Gl3SVx+//eDdT9Tj87KVi2B6yYobSD3BfDnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IEF6+UgImUHAMjJgAitaBvd5OziaZdCqrfvP98/19wMazlvfUTqkz6UQU832nMbPh
	 JlyhuZd2tETtISi72czGm9CPTocRiDEZ41LnZEQxIdO3PKghV26q85rFcN+0J6pnza
	 iLqHIU8x76ElFWF61clouBwOk2v6VnHp8QvpBvcm9hUa9dAiP6xLuXGz3lh/mzanOQ
	 OuGXvqVtm8Ttcg8/xDmmoNLhwDjfJBIlv1eyV3/h27vhFWRSqtrdjKlC2U9PpS9RdT
	 ofmYGVdRGrEtEkHW59ZgrBP8kxaeW00Kt1XHcsB9l445vMsaiYIcYdAw6JtSMsqerg
	 OrR6N1hLruk7w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:28 +0200
Subject: [PATCH v3 59/70] selftests/namespaces: seventh inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-59-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4066; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0F9mhX2Gl3SVx+//eDdT9Tj87KVi2B6yYobSD3BfDnA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmqf5c3O9r02/2cqS1FOCcNOfw/jL8e9Fm631469/
 Z23f8fOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlUqTL8U2fVZtM9lynxfdrX
 tGXTjgq/ZUnIzpm7qeNM30bTS05BDowM82Md5Kwr8gO1SxmnWDh/msqpZPzMalvQV+0VXeXOk9U
 YAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test socket keeps netns active after creating process exits. Verify that
as long as the socket FD exists, the namespace remains active.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 141 +++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 231830daf5dc..60028eeecde0 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -401,4 +401,145 @@ TEST(siocgskns_multiple_sockets)
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


