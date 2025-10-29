Return-Path: <linux-fsdevel+bounces-66274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1B4C1A69C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAC81AA21F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF81364487;
	Wed, 29 Oct 2025 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mlm8us7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E02363B9D;
	Wed, 29 Oct 2025 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740747; cv=none; b=MDXSXs/fKL6S52dZqD1yMukCGfFZGvA3cccVYi8GoLvw8SGLd/FKcLmesphsENHpz+kRJYttH0VMf3RfSWbgvtod3qNN5WMfKH+ktfGzj2GsT2MkY8UJe3Eo87+CUOpHcwd/FmGVg2mB7+/ITrqwN12m7BYcMvYvHXSh7JxWCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740747; c=relaxed/simple;
	bh=0F9mhX2Gl3SVx+//eDdT9Tj87KVi2B6yYobSD3BfDnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbIbS/5Qle05qmJ7YyM45erAs8p/4qKvcFrq+A571MdDJVjGo4wHfD4rHq6PsSvzdB0drFhaP0jXzXfDSOix8XBXI8E6KtOEqovDBHNA+KcMs6WVYxgwuTczzZmbh0fBy5uff3rIt0ZwRTJhv4os/I8e7+Q7ToqtujnchnInThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mlm8us7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139F4C4CEFF;
	Wed, 29 Oct 2025 12:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740747;
	bh=0F9mhX2Gl3SVx+//eDdT9Tj87KVi2B6yYobSD3BfDnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mlm8us7aJOvLjIz6PyycbLhZioGMgblsBESGqQtaxcQIvdKX14OtyPZPDAwsqe5sE
	 O5EmJ8oBz8AebyW5gh9xRJGYSJiaaHDwCJREVaXH5217jx7WHSMlZECJz18uygL+GO
	 LtbKPocR0FtFwiMlElHCnZ3eFNqXTY440djTAMh9SkqlT/eZ8sMMsRgFfzhLQ3pAX8
	 dbb23MOX5lrRU6iHfkVY2/3LlY5E1doM+PTabKIopPCevmHabFwtJ+SOLfmGRkBatE
	 8g1BgQUW4TQ1u0CmtsDkaaBOfSqoaTrVzskk+d98dBvzvDhhn1lIkKB2axzXnV3O5E
	 dbCNSFQN0EPng==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:14 +0100
Subject: [PATCH v4 61/72] selftests/namespaces: seventh inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-61-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4066; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0F9mhX2Gl3SVx+//eDdT9Tj87KVi2B6yYobSD3BfDnA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfX/+/VeyEKvI3ylf+3v3wFCq3wVVLhU5kesmfD0f
 WRzrV11RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERWbWRkmNmgNy9OVz+4PTWw
 2sn//PbXr76+WzNfQzTtrZTa552rzjL897pbbHhf1rUo53C/rZZw1M8zjb/WWTypXH/Moe/MOe9
 uPgA=
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


