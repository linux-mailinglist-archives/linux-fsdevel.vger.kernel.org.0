Return-Path: <linux-fsdevel+bounces-66277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC17AC1A6C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBC31A61FD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7059935029F;
	Wed, 29 Oct 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/k0rXqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79A3655EC;
	Wed, 29 Oct 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740763; cv=none; b=laok10rra9biEi/tJnYUZl0s7jqngroGbTNGgkl1RPM1aBHLLI//4OU97VCSq93gM5qFVhtquuIyMPd2p4AzF61FgZ+iZ6RTLlspLLurxBf9SO/nQCjcDsh/ATm8oYsTKeH3mKob1xn0X+LUhFZ27Kskw6F7yELOMU7NHwP86Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740763; c=relaxed/simple;
	bh=cg2+/WFjpG13y8cnkuocp9/qhpt17gumOqmPdMg4wzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCL9D872p4pEqPVeDLjUxSPj9jkx/YDlTzPyOXghUnP1p7eKOUBWYEkoIiXavp10hO+8NKmFJLwJuMLs3MOtxxr+imdtZPf/IIubhfnM/QiUp6k5Zsb6kFuwHNfwcKHNNJgaBRMMhi76ImGKMJ4BuImsVYtKBD5mBFQIVjz1Gr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/k0rXqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16CDC4CEF7;
	Wed, 29 Oct 2025 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740763;
	bh=cg2+/WFjpG13y8cnkuocp9/qhpt17gumOqmPdMg4wzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r/k0rXqh1C6WxpJE1Q1EHoV8QTrqIBujqTX2bRbBwiVM3MsEv8+UwYtl6jOEn//2/
	 M8T1WwtBUS/SfM6YcLGXspNmCkQ0YEg6nkPD6PDR9eWs5L13YA/3nUwUj9JvdaMlGM
	 INUiR8kEGCoG6mX5ql9N8hSZRdgBL+EKMa/Wg9YtJZCIRv8kwqciFi/iZogCDKJ9fx
	 QNcLyaTf8zB+v3s1/DTyqDiFQls1sgVuPuyQRa0lUt4OAfM+nCEAjEAHzmEBLehZBl
	 jGU7ZAKSfzPVHTKNNWRWLz4EgjLRG4uYW+pNgV5DP3TgcihAOfWKxons6fdrFbQsMI
	 GD/XXVQCg4x/A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:17 +0100
Subject: [PATCH v4 64/72] selftests/namespaces: tenth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-64-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6550; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cg2+/WFjpG13y8cnkuocp9/qhpt17gumOqmPdMg4wzY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysU0I+pqz+O7K9g1iLa2Z7+X4zdsYHa5ypG/ysHo44
 emDn3FWHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpfc/IcLNJoNfpi93ZPIO6
 Jd+nM3NHFTnNCP189p03V8WSqnlpTowML1wFdpuEat4WvHxxk/vsP1yeAkWHD/sfPVpz/Lz+03m
 2rAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that socket-kept netns can be reopened via file handle.
Verify that a network namespace kept alive by a socket FD can be
reopened using file handles even after the creating process exits.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 195 +++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 98f6a0e1b9dd..a909232dba36 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -779,4 +779,199 @@ TEST(siocgskns_listns_visibility)
 	TH_LOG("Netns %llu correctly disappeared from listns() after socket closed", netns_id);
 }
 
+/*
+ * Test that socket-kept netns can be reopened via file handle.
+ * Verify that a network namespace kept alive by a socket FD can be
+ * reopened using file handles even after the creating process exits.
+ */
+TEST(siocgskns_file_handle)
+{
+	int sock_fd, netns_fd, reopened_fd;
+	int ipc_sockets[2];
+	pid_t pid;
+	int status;
+	struct stat st1, st2;
+	ino_t netns_ino;
+	__u64 netns_id;
+	struct file_handle *handle;
+	struct nsfs_file_handle *nsfs_fh;
+	int ret;
+
+	/* Allocate file_handle structure for nsfs */
+	handle = malloc(sizeof(struct file_handle) + sizeof(struct nsfs_file_handle));
+	ASSERT_NE(handle, NULL);
+	handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	handle->handle_type = FILEID_NSFS;
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
+		free(handle);
+		close(sock_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(netns_fd, 0);
+	}
+
+	ASSERT_EQ(fstat(netns_fd, &st1), 0);
+	netns_ino = st1.st_ino;
+
+	/* Get namespace ID */
+	ret = ioctl(netns_fd, NS_GET_ID, &netns_id);
+	if (ret < 0) {
+		free(handle);
+		close(sock_fd);
+		close(netns_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "NS_GET_ID not supported");
+		ASSERT_EQ(ret, 0);
+	}
+
+	/* Construct file handle from namespace ID */
+	nsfs_fh = (struct nsfs_file_handle *)handle->f_handle;
+	nsfs_fh->ns_id = netns_id;
+	nsfs_fh->ns_type = 0;  /* Type field not needed for reopening */
+	nsfs_fh->ns_inum = 0;  /* Inum field not needed for reopening */
+
+	TH_LOG("Constructed file handle for netns %lu (id=%llu)", netns_ino, netns_id);
+
+	/* Reopen namespace using file handle (while socket still keeps it alive) */
+	reopened_fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (reopened_fd < 0) {
+		free(handle);
+		close(sock_fd);
+		if (errno == EOPNOTSUPP || errno == ENOSYS || errno == EBADF)
+			SKIP(return, "open_by_handle_at with FD_NSFS_ROOT not supported");
+		TH_LOG("open_by_handle_at failed: %s", strerror(errno));
+		ASSERT_GE(reopened_fd, 0);
+	}
+
+	/* Verify it's the same namespace */
+	ASSERT_EQ(fstat(reopened_fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_dev, st2.st_dev);
+
+	TH_LOG("Successfully reopened netns %lu via file handle", netns_ino);
+
+	close(reopened_fd);
+
+	/* Close the netns FD */
+	close(netns_fd);
+
+	/* Try to reopen via file handle - should fail since namespace is now inactive */
+	reopened_fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_LT(reopened_fd, 0);
+	TH_LOG("Correctly failed to reopen inactive netns: %s", strerror(errno));
+
+	/* Get network namespace from socket */
+	netns_fd = ioctl(sock_fd, SIOCGSKNS);
+	if (netns_fd < 0) {
+		free(handle);
+		close(sock_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(netns_fd, 0);
+	}
+
+	/* Reopen namespace using file handle (while socket still keeps it alive) */
+	reopened_fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (reopened_fd < 0) {
+		free(handle);
+		close(sock_fd);
+		if (errno == EOPNOTSUPP || errno == ENOSYS || errno == EBADF)
+			SKIP(return, "open_by_handle_at with FD_NSFS_ROOT not supported");
+		TH_LOG("open_by_handle_at failed: %s", strerror(errno));
+		ASSERT_GE(reopened_fd, 0);
+	}
+
+	/* Verify it's the same namespace */
+	ASSERT_EQ(fstat(reopened_fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_dev, st2.st_dev);
+
+	TH_LOG("Successfully reopened netns %lu via file handle", netns_ino);
+
+	/* Close socket - namespace should become inactive */
+	close(sock_fd);
+	free(handle);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


