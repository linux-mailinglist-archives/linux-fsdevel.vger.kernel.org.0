Return-Path: <linux-fsdevel+bounces-65504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8FCC05F68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C773B235A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284FB36C236;
	Fri, 24 Oct 2025 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAbGjjQR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257B3191BF;
	Fri, 24 Oct 2025 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303535; cv=none; b=bxJUx4vLSd2gcXd/m3IrxtG3xGTX+dayybqBS5/3EEeO0XQpT3lNFxxfmNs567dQofnFJBmK3q7UYGLOwtsQRvu0PLNRMRUklGHnYm4XmGvgyFV0+rma+wlj1BggtE6TY8Eb5ukeG8rAWHlaTo6dySo89FK6S+/BOMl4s63mkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303535; c=relaxed/simple;
	bh=4DBUpYISpIFS5Tcy2WQb4n+lgh4Zbjunaz48EAgExJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pBzl3lcyGC/0rr0SOcAoNyBIbtmBcXgBXYkEIESY+cAqZLbi1rSGLXtzwZC1b+WBzd5CRcTDVw8DbGm41TE/o6VVuYUDyS2iKk1Xg79yrwkflKYI8ZBwnGx9IGhaq989zAdik5ShKr9nVorQyGLAj7DNqKtw1mg5P/shm6abDao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAbGjjQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8E4C4CEF1;
	Fri, 24 Oct 2025 10:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303535;
	bh=4DBUpYISpIFS5Tcy2WQb4n+lgh4Zbjunaz48EAgExJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cAbGjjQRfcry3g18EvsjRQNBsA4jq15iaFt6nVNu++Ghg1Znp8d2xf4iLMQ7mLzw/
	 b2s5fEWvMV85kGSXKvfVSg3Ua+Emeg7ZciPNszo6/c+qe9wbpD+hqzhHGiGHhiCHO1
	 fv5iJClRK6QLEhwVtg58eoEbjaCwh7793Fq3nTcAdejiftokuy+M9Av33cyjGajQ9t
	 nL9hVaP/6lkr76ayE88WtslLQ0B506eFK+2uXmWgkRTNyJGaWkzNFHYY24hQTl+9oE
	 uq85qqm+nXDLZGCDqYqLfW9XtAqo3R7isSL53bOC7y7FbaSC1RptaI20Spzl7gWdtg
	 OMMHoCFan6jig==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:33 +0200
Subject: [PATCH v3 64/70] selftests/namespaces: twelth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-64-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18059; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4DBUpYISpIFS5Tcy2WQb4n+lgh4Zbjunaz48EAgExJo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jup4df1c/y/GnStio51nTpLaUHj45NQi96Qi8e5Oa
 RZ37QXZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP55MDwv0a6WKTl19PdSl6L
 13e/nWmwbm/AyzffN3w7w747ljVgYg3DP02bD4evTFk3KYohOWYq/0ztKYHfCqxc44RVL0928tu
 zigUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test multi-level namespace resurrection across three user namespace levels.

This test creates a complex namespace hierarchy with three levels of user
namespaces and a network namespace at the deepest level. It verifies that
the resurrection semantics work correctly when SIOCGSKNS is called on a
socket from an inactive namespace tree, and that listns() and
open_by_handle_at() correctly respect visibility rules.

Hierarchy after child processes exit (all with 0 active refcount):

         net_L3A (0)                <- Level 3 network namespace
             |
             +
         userns_L3 (0)              <- Level 3 user namespace
             |
             +
         userns_L2 (0)              <- Level 2 user namespace
             |
             +
         userns_L1 (0)              <- Level 1 user namespace
             |
             x
         init_user_ns

The test verifies:
1. SIOCGSKNS on a socket from inactive net_L3A resurrects the entire chain
2. After resurrection, all namespaces are visible in listns()
3. Resurrected namespaces can be reopened via file handles
4. Closing the netns FD cascades down: the entire ownership chain
   (userns_L3 -> userns_L2 -> userns_L1) becomes inactive again
5. Inactive namespaces disappear from listns() and cannot be reopened
6. Calling SIOCGSKNS again on the same socket resurrects the tree again
7. After second resurrection, namespaces are visible and can be reopened

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 564 +++++++++++++++++++++
 1 file changed, 564 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 706049768d52..ba689a22d82f 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -1257,4 +1257,568 @@ TEST(siocgskns_listns_and_file_handle)
 	free(handle);
 }
 
+/*
+ * Test multi-level namespace resurrection across three user namespace levels.
+ *
+ * This test creates a complex namespace hierarchy with three levels of user
+ * namespaces and a network namespace at the deepest level. It verifies that
+ * the resurrection semantics work correctly when SIOCGSKNS is called on a
+ * socket from an inactive namespace tree, and that listns() and
+ * open_by_handle_at() correctly respect visibility rules.
+ *
+ * Hierarchy after child processes exit (all with 0 active refcount):
+ *
+ *          net_L3A (0)                <- Level 3 network namespace
+ *              |
+ *              +
+ *          userns_L3 (0)              <- Level 3 user namespace
+ *              |
+ *              +
+ *          userns_L2 (0)              <- Level 2 user namespace
+ *              |
+ *              +
+ *          userns_L1 (0)              <- Level 1 user namespace
+ *              |
+ *              x
+ *          init_user_ns
+ *
+ * The test verifies:
+ * 1. SIOCGSKNS on a socket from inactive net_L3A resurrects the entire chain
+ * 2. After resurrection, all namespaces are visible in listns()
+ * 3. Resurrected namespaces can be reopened via file handles
+ * 4. Closing the netns FD cascades down: the entire ownership chain
+ *    (userns_L3 -> userns_L2 -> userns_L1) becomes inactive again
+ * 5. Inactive namespaces disappear from listns() and cannot be reopened
+ * 6. Calling SIOCGSKNS again on the same socket resurrects the tree again
+ * 7. After second resurrection, namespaces are visible and can be reopened
+ */
+TEST(siocgskns_multilevel_resurrection)
+{
+	int ipc_sockets[2];
+	pid_t pid_l1, pid_l2, pid_l3;
+	int status;
+
+	/* Namespace file descriptors to be received from child */
+	int sock_L3A_fd = -1;
+	int netns_L3A_fd = -1;
+	__u64 netns_L3A_id;
+	__u64 userns_L1_id, userns_L2_id, userns_L3_id;
+
+	/* For listns() and file handle testing */
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWNET | CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[256];
+	int ret, i;
+	struct file_handle *handle;
+	struct nsfs_file_handle *nsfs_fh;
+	int reopened_fd;
+
+	/* Allocate file handle for testing */
+	handle = malloc(sizeof(struct file_handle) + sizeof(struct nsfs_file_handle));
+	ASSERT_NE(handle, NULL);
+	handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	handle->handle_type = FILEID_NSFS;
+
+	EXPECT_EQ(socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
+
+	/*
+	 * Fork level 1 child that creates userns_L1
+	 */
+	pid_l1 = fork();
+	ASSERT_GE(pid_l1, 0);
+
+	if (pid_l1 == 0) {
+		/* Level 1 child */
+		int ipc_L2[2];
+		close(ipc_sockets[0]);
+
+		/* Create userns_L1 */
+		if (setup_userns() < 0) {
+			close(ipc_sockets[1]);
+			exit(1);
+		}
+
+		/* Create socketpair for communicating with L2 child */
+		if (socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_L2) < 0) {
+			close(ipc_sockets[1]);
+			exit(1);
+		}
+
+		/*
+		 * Fork level 2 child that creates userns_L2
+		 */
+		pid_l2 = fork();
+		if (pid_l2 < 0) {
+			close(ipc_sockets[1]);
+			close(ipc_L2[0]);
+			close(ipc_L2[1]);
+			exit(1);
+		}
+
+		if (pid_l2 == 0) {
+			/* Level 2 child */
+			int ipc_L3[2];
+			close(ipc_L2[0]);
+
+			/* Create userns_L2 (nested inside userns_L1) */
+			if (setup_userns() < 0) {
+				close(ipc_L2[1]);
+				exit(1);
+			}
+
+			/* Create socketpair for communicating with L3 child */
+			if (socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_L3) < 0) {
+				close(ipc_L2[1]);
+				exit(1);
+			}
+
+			/*
+			 * Fork level 3 child that creates userns_L3 and network namespaces
+			 */
+			pid_l3 = fork();
+			if (pid_l3 < 0) {
+				close(ipc_L2[1]);
+				close(ipc_L3[0]);
+				close(ipc_L3[1]);
+				exit(1);
+			}
+
+			if (pid_l3 == 0) {
+				/* Level 3 child - the deepest level */
+				int sock_fd;
+				close(ipc_L3[0]);
+
+				/* Create userns_L3 (nested inside userns_L2) */
+				if (setup_userns() < 0) {
+					close(ipc_L3[1]);
+					exit(1);
+				}
+
+				/* Create network namespace at level 3 */
+				if (unshare(CLONE_NEWNET) < 0) {
+					close(ipc_L3[1]);
+					exit(1);
+				}
+
+				/* Create socket in net_L3A */
+				sock_fd = socket(AF_INET, SOCK_DGRAM, 0);
+				if (sock_fd < 0) {
+					close(ipc_L3[1]);
+					exit(1);
+				}
+
+				/* Send socket FD to L2 parent */
+				struct msghdr msg = {0};
+				struct iovec iov = {0};
+				char buf[1] = {'X'};
+				char cmsg_buf[CMSG_SPACE(sizeof(int))];
+
+				iov.iov_base = buf;
+				iov.iov_len = 1;
+				msg.msg_iov = &iov;
+				msg.msg_iovlen = 1;
+				msg.msg_control = cmsg_buf;
+				msg.msg_controllen = sizeof(cmsg_buf);
+
+				struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+				cmsg->cmsg_level = SOL_SOCKET;
+				cmsg->cmsg_type = SCM_RIGHTS;
+				cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+				memcpy(CMSG_DATA(cmsg), &sock_fd, sizeof(int));
+
+				if (sendmsg(ipc_L3[1], &msg, 0) < 0) {
+					close(sock_fd);
+					close(ipc_L3[1]);
+					exit(1);
+				}
+
+				close(sock_fd);
+				close(ipc_L3[1]);
+				exit(0);
+			}
+
+			/* Level 2 child - receive from L3 and forward to L1 */
+			close(ipc_L3[1]);
+
+			struct msghdr msg = {0};
+			struct iovec iov = {0};
+			char buf[1];
+			char cmsg_buf[CMSG_SPACE(sizeof(int))];
+			int received_fd;
+
+			iov.iov_base = buf;
+			iov.iov_len = 1;
+			msg.msg_iov = &iov;
+			msg.msg_iovlen = 1;
+			msg.msg_control = cmsg_buf;
+			msg.msg_controllen = sizeof(cmsg_buf);
+
+			ssize_t n = recvmsg(ipc_L3[0], &msg, 0);
+			close(ipc_L3[0]);
+
+			if (n != 1) {
+				close(ipc_L2[1]);
+				waitpid(pid_l3, NULL, 0);
+				exit(1);
+			}
+
+			struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+			if (!cmsg) {
+				close(ipc_L2[1]);
+				waitpid(pid_l3, NULL, 0);
+				exit(1);
+			}
+			memcpy(&received_fd, CMSG_DATA(cmsg), sizeof(int));
+
+			/* Wait for L3 child */
+			waitpid(pid_l3, NULL, 0);
+
+			/* Forward the socket FD to L1 parent */
+			memset(&msg, 0, sizeof(msg));
+			buf[0] = 'Y';
+			iov.iov_base = buf;
+			iov.iov_len = 1;
+			msg.msg_iov = &iov;
+			msg.msg_iovlen = 1;
+			msg.msg_control = cmsg_buf;
+			msg.msg_controllen = sizeof(cmsg_buf);
+
+			cmsg = CMSG_FIRSTHDR(&msg);
+			cmsg->cmsg_level = SOL_SOCKET;
+			cmsg->cmsg_type = SCM_RIGHTS;
+			cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+			memcpy(CMSG_DATA(cmsg), &received_fd, sizeof(int));
+
+			if (sendmsg(ipc_L2[1], &msg, 0) < 0) {
+				close(received_fd);
+				close(ipc_L2[1]);
+				exit(1);
+			}
+
+			close(received_fd);
+			close(ipc_L2[1]);
+			exit(0);
+		}
+
+		/* Level 1 child - receive from L2 and forward to parent */
+		close(ipc_L2[1]);
+
+		struct msghdr msg = {0};
+		struct iovec iov = {0};
+		char buf[1];
+		char cmsg_buf[CMSG_SPACE(sizeof(int))];
+		int received_fd;
+
+		iov.iov_base = buf;
+		iov.iov_len = 1;
+		msg.msg_iov = &iov;
+		msg.msg_iovlen = 1;
+		msg.msg_control = cmsg_buf;
+		msg.msg_controllen = sizeof(cmsg_buf);
+
+		ssize_t n = recvmsg(ipc_L2[0], &msg, 0);
+		close(ipc_L2[0]);
+
+		if (n != 1) {
+			close(ipc_sockets[1]);
+			waitpid(pid_l2, NULL, 0);
+			exit(1);
+		}
+
+		struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+		if (!cmsg) {
+			close(ipc_sockets[1]);
+			waitpid(pid_l2, NULL, 0);
+			exit(1);
+		}
+		memcpy(&received_fd, CMSG_DATA(cmsg), sizeof(int));
+
+		/* Wait for L2 child */
+		waitpid(pid_l2, NULL, 0);
+
+		/* Forward the socket FD to parent */
+		memset(&msg, 0, sizeof(msg));
+		buf[0] = 'Z';
+		iov.iov_base = buf;
+		iov.iov_len = 1;
+		msg.msg_iov = &iov;
+		msg.msg_iovlen = 1;
+		msg.msg_control = cmsg_buf;
+		msg.msg_controllen = sizeof(cmsg_buf);
+
+		cmsg = CMSG_FIRSTHDR(&msg);
+		cmsg->cmsg_level = SOL_SOCKET;
+		cmsg->cmsg_type = SCM_RIGHTS;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+		memcpy(CMSG_DATA(cmsg), &received_fd, sizeof(int));
+
+		if (sendmsg(ipc_sockets[1], &msg, 0) < 0) {
+			close(received_fd);
+			close(ipc_sockets[1]);
+			exit(1);
+		}
+
+		close(received_fd);
+		close(ipc_sockets[1]);
+		exit(0);
+	}
+
+	/* Parent - receive the socket from the deepest level */
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
+
+	if (n != 1) {
+		free(handle);
+		waitpid(pid_l1, NULL, 0);
+		SKIP(return, "Failed to receive socket from child");
+	}
+
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+	if (!cmsg) {
+		free(handle);
+		waitpid(pid_l1, NULL, 0);
+		SKIP(return, "Failed to receive socket from child");
+	}
+	memcpy(&sock_L3A_fd, CMSG_DATA(cmsg), sizeof(int));
+
+	/* Wait for L1 child */
+	waitpid(pid_l1, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/*
+	 * At this point, all child processes have exited. The socket itself
+	 * doesn't keep the namespace active - we need to call SIOCGSKNS which
+	 * will resurrect the entire namespace tree by taking active references.
+	 */
+
+	/* Get network namespace from socket - this resurrects the tree */
+	netns_L3A_fd = ioctl(sock_L3A_fd, SIOCGSKNS);
+	if (netns_L3A_fd < 0) {
+		free(handle);
+		close(sock_L3A_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(netns_L3A_fd, 0);
+	}
+
+	/* Get namespace ID for net_L3A */
+	ret = ioctl(netns_L3A_fd, NS_GET_ID, &netns_L3A_id);
+	if (ret < 0) {
+		free(handle);
+		close(sock_L3A_fd);
+		close(netns_L3A_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "NS_GET_ID not supported");
+		ASSERT_EQ(ret, 0);
+	}
+
+	/* Get owner user namespace chain: userns_L3 -> userns_L2 -> userns_L1 */
+	int userns_L3_fd = ioctl(netns_L3A_fd, NS_GET_USERNS);
+	if (userns_L3_fd < 0) {
+		free(handle);
+		close(sock_L3A_fd);
+		close(netns_L3A_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "NS_GET_USERNS not supported");
+		ASSERT_GE(userns_L3_fd, 0);
+	}
+
+	ret = ioctl(userns_L3_fd, NS_GET_ID, &userns_L3_id);
+	ASSERT_EQ(ret, 0);
+
+	int userns_L2_fd = ioctl(userns_L3_fd, NS_GET_USERNS);
+	ASSERT_GE(userns_L2_fd, 0);
+	ret = ioctl(userns_L2_fd, NS_GET_ID, &userns_L2_id);
+	ASSERT_EQ(ret, 0);
+
+	int userns_L1_fd = ioctl(userns_L2_fd, NS_GET_USERNS);
+	ASSERT_GE(userns_L1_fd, 0);
+	ret = ioctl(userns_L1_fd, NS_GET_ID, &userns_L1_id);
+	ASSERT_EQ(ret, 0);
+
+	close(userns_L1_fd);
+	close(userns_L2_fd);
+	close(userns_L3_fd);
+
+	TH_LOG("Multi-level hierarchy: net_L3A (id=%llu) -> userns_L3 (id=%llu) -> userns_L2 (id=%llu) -> userns_L1 (id=%llu)",
+	       netns_L3A_id, userns_L3_id, userns_L2_id, userns_L1_id);
+
+	/*
+	 * Test 1: Verify net_L3A is visible in listns() after resurrection.
+	 * The entire ownership chain should be resurrected and visible.
+	 */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		free(handle);
+		close(sock_L3A_fd);
+		close(netns_L3A_fd);
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		ASSERT_GE(ret, 0);
+	}
+
+	bool found_netns_L3A = false;
+	bool found_userns_L1 = false;
+	bool found_userns_L2 = false;
+	bool found_userns_L3 = false;
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == netns_L3A_id)
+			found_netns_L3A = true;
+		if (ns_ids[i] == userns_L1_id)
+			found_userns_L1 = true;
+		if (ns_ids[i] == userns_L2_id)
+			found_userns_L2 = true;
+		if (ns_ids[i] == userns_L3_id)
+			found_userns_L3 = true;
+	}
+
+	ASSERT_TRUE(found_netns_L3A);
+	ASSERT_TRUE(found_userns_L1);
+	ASSERT_TRUE(found_userns_L2);
+	ASSERT_TRUE(found_userns_L3);
+	TH_LOG("Resurrection verified: all namespaces in hierarchy visible in listns()");
+
+	/*
+	 * Test 2: Verify net_L3A can be reopened via file handle.
+	 */
+	nsfs_fh = (struct nsfs_file_handle *)handle->f_handle;
+	nsfs_fh->ns_id = netns_L3A_id;
+	nsfs_fh->ns_type = 0;
+	nsfs_fh->ns_inum = 0;
+
+	reopened_fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (reopened_fd < 0) {
+		free(handle);
+		close(sock_L3A_fd);
+		close(netns_L3A_fd);
+		if (errno == EOPNOTSUPP || errno == ENOSYS || errno == EBADF)
+			SKIP(return, "open_by_handle_at with FD_NSFS_ROOT not supported");
+		TH_LOG("open_by_handle_at failed: %s", strerror(errno));
+		ASSERT_GE(reopened_fd, 0);
+	}
+
+	close(reopened_fd);
+	TH_LOG("File handle test passed: net_L3A can be reopened");
+
+	/*
+	 * Test 3: Verify that when we close the netns FD (dropping the last
+	 * active reference), the entire tree becomes inactive and disappears
+	 * from listns(). The cascade goes: net_L3A drops -> userns_L3 drops ->
+	 * userns_L2 drops -> userns_L1 drops.
+	 */
+	close(netns_L3A_fd);
+
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	ASSERT_GE(ret, 0);
+
+	found_netns_L3A = false;
+	found_userns_L1 = false;
+	found_userns_L2 = false;
+	found_userns_L3 = false;
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == netns_L3A_id)
+			found_netns_L3A = true;
+		if (ns_ids[i] == userns_L1_id)
+			found_userns_L1 = true;
+		if (ns_ids[i] == userns_L2_id)
+			found_userns_L2 = true;
+		if (ns_ids[i] == userns_L3_id)
+			found_userns_L3 = true;
+	}
+
+	ASSERT_FALSE(found_netns_L3A);
+	ASSERT_FALSE(found_userns_L1);
+	ASSERT_FALSE(found_userns_L2);
+	ASSERT_FALSE(found_userns_L3);
+	TH_LOG("Cascade test passed: all namespaces disappeared after netns FD closed");
+
+	/*
+	 * Test 4: Verify file handle no longer works for inactive namespace.
+	 */
+	reopened_fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (reopened_fd >= 0) {
+		close(reopened_fd);
+		free(handle);
+		ASSERT_TRUE(false); /* Should have failed */
+	}
+	TH_LOG("Inactive namespace correctly cannot be reopened via file handle");
+
+	/*
+	 * Test 5: Verify that calling SIOCGSKNS again resurrects the tree again.
+	 * The socket is still valid, so we can call SIOCGSKNS on it to resurrect
+	 * the namespace tree once more.
+	 */
+	netns_L3A_fd = ioctl(sock_L3A_fd, SIOCGSKNS);
+	ASSERT_GE(netns_L3A_fd, 0);
+
+	TH_LOG("Called SIOCGSKNS again to resurrect the namespace tree");
+
+	/* Verify the namespace tree is resurrected and visible in listns() */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	ASSERT_GE(ret, 0);
+
+	found_netns_L3A = false;
+	found_userns_L1 = false;
+	found_userns_L2 = false;
+	found_userns_L3 = false;
+
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == netns_L3A_id)
+			found_netns_L3A = true;
+		if (ns_ids[i] == userns_L1_id)
+			found_userns_L1 = true;
+		if (ns_ids[i] == userns_L2_id)
+			found_userns_L2 = true;
+		if (ns_ids[i] == userns_L3_id)
+			found_userns_L3 = true;
+	}
+
+	ASSERT_TRUE(found_netns_L3A);
+	ASSERT_TRUE(found_userns_L1);
+	ASSERT_TRUE(found_userns_L2);
+	ASSERT_TRUE(found_userns_L3);
+	TH_LOG("Second resurrection verified: all namespaces in hierarchy visible in listns() again");
+
+	/* Verify we can reopen via file handle again */
+	reopened_fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (reopened_fd < 0) {
+		free(handle);
+		close(sock_L3A_fd);
+		close(netns_L3A_fd);
+		TH_LOG("open_by_handle_at failed after second resurrection: %s", strerror(errno));
+		ASSERT_GE(reopened_fd, 0);
+	}
+
+	close(reopened_fd);
+	TH_LOG("File handle test passed: net_L3A can be reopened after second resurrection");
+
+	/* Final cleanup */
+	close(sock_L3A_fd);
+	close(netns_L3A_fd);
+	free(handle);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


