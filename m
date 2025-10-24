Return-Path: <linux-fsdevel+bounces-65503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA9CC05F1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E861A66F10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D38136B98B;
	Fri, 24 Oct 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTFrwrW7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8203191BF;
	Fri, 24 Oct 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303530; cv=none; b=rPoz5DY4oVV6ICxCIAInoP+5xRvFsUZ2uQ3oI7hqNbDsYlHhqxTOFJfd4TQ/JufjNb9E6r85uFFkJwsyGnvKbOorhYEAdy8sXf2qxkcYrmfO6nivYR1xhp3uB+gGWtOcp+N77OgT1DdurC1L+qt5WKqQgqgFmOT8dPLoe4OvvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303530; c=relaxed/simple;
	bh=sKXDidGiOR1H5xWVrgVg4FOPuYvFiXWeY9Fffw5SXJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HlgtwCQ5PJoRHtnakKG71C0SUUbHklapUExHZcvT0v5R0y7WXvb9kPAh7+AfxwiiuzzKO2MDRGKKxs0VtGcvP3sX/t1NvErF2Nja0MGebeSus81GX7wbZXttP6x988IfkKbM4Sw/KsNa6AUVFuHowtblDsJwqEQEB6/Mh9yHgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTFrwrW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D70AC113D0;
	Fri, 24 Oct 2025 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303529;
	bh=sKXDidGiOR1H5xWVrgVg4FOPuYvFiXWeY9Fffw5SXJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lTFrwrW70s4sRusxH4re81GW027373cpyzv4mxtLIzsB/7OLmW6vuhk1d3ZD/YhrI
	 InyL+OoOmqf4KMTx0j56/Q5Y58L8m5g6PlMLmrX2mWL/gtedXyyEJY/8Ba/dAoQt9f
	 bHOxIGXXweLr2lsDE1JZvHuBf13jeINfDdS336C4W8FYRi93+HseXsB9fyl1I6FCCH
	 X9mp6O9UC89nZEyyYTRsmyk7Mq6akoBBwpDhMfl67YZBpTWoRPV0Yq3gcfdGrpivLV
	 iiA6rJn/8OHp3rCC3UdIRLUR6a0/AvdDWRdbLPUEg5Hevoqs1sgRIgZcVwJagHobCE
	 UF8gnwdQJ0Rig==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:32 +0200
Subject: [PATCH v3 63/70] selftests/namespaces: eleventh inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-63-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8469; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sKXDidGiOR1H5xWVrgVg4FOPuYvFiXWeY9Fffw5SXJg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jurYt/KAWehyRc8lHh4dBtmdH9+XSrhcTXjl/+tEy
 a/rFgqnOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTAG7yVUaGrTLpT52DE+tv7dw2
 44xLe+ac/83JU69+4zH9uj3B+VnzIYb/dWcLo3b+KpSXn9Fq8ej8stwGfaHeTuXPGYxnf/5lapf
 gAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test combined listns() and file handle operations with socket-kept
netns. Create a netns, keep it alive with a socket, verify it appears in
listns(), then reopen it via file handle obtained from listns() entry.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 283 +++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index a909232dba36..706049768d52 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -974,4 +974,287 @@ TEST(siocgskns_file_handle)
 	free(handle);
 }
 
+/*
+ * Test combined listns() and file handle operations with socket-kept netns.
+ * Create a netns, keep it alive with a socket, verify it appears in listns(),
+ * then reopen it via file handle obtained from listns() entry.
+ */
+TEST(siocgskns_listns_and_file_handle)
+{
+	int sock_fd, netns_fd, userns_fd, reopened_fd;
+	int ipc_sockets[2];
+	pid_t pid;
+	int status;
+	struct stat st;
+	ino_t netns_ino;
+	__u64 netns_id, userns_id;
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
+	bool found_netns = false, found_userns = false;
+	struct file_handle *handle;
+	struct nsfs_file_handle *nsfs_fh;
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
+		/* Child: create new userns and netns with socket */
+		close(ipc_sockets[0]);
+
+		if (setup_userns() < 0) {
+			close(ipc_sockets[1]);
+			exit(1);
+		}
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
+	ASSERT_EQ(fstat(netns_fd, &st), 0);
+	netns_ino = st.st_ino;
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
+	/* Get owner user namespace */
+	userns_fd = ioctl(netns_fd, NS_GET_USERNS);
+	if (userns_fd < 0) {
+		free(handle);
+		close(sock_fd);
+		close(netns_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "NS_GET_USERNS not supported");
+		ASSERT_GE(userns_fd, 0);
+	}
+
+	/* Get owner namespace ID */
+	ret = ioctl(userns_fd, NS_GET_ID, &userns_id);
+	if (ret < 0) {
+		close(userns_fd);
+		free(handle);
+		close(sock_fd);
+		close(netns_fd);
+		ASSERT_EQ(ret, 0);
+	}
+	close(userns_fd);
+
+	TH_LOG("Testing netns %lu (id=%llu) owned by userns id=%llu", netns_ino, netns_id, userns_id);
+
+	/* Verify namespace appears in listns() */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		free(handle);
+		close(sock_fd);
+		close(netns_fd);
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		TH_LOG("listns failed: %s", strerror(errno));
+		ASSERT_GE(ret, 0);
+	}
+
+	found_netns = false;
+	found_userns = false;
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == netns_id)
+			found_netns = true;
+		if (ns_ids[i] == userns_id)
+			found_userns = true;
+	}
+	ASSERT_TRUE(found_netns);
+	ASSERT_TRUE(found_userns);
+	TH_LOG("Found netns %llu in listns() output", netns_id);
+
+	/* Construct file handle from namespace ID */
+	nsfs_fh = (struct nsfs_file_handle *)handle->f_handle;
+	nsfs_fh->ns_id = netns_id;
+	nsfs_fh->ns_type = 0;
+	nsfs_fh->ns_inum = 0;
+
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
+	struct stat reopened_st;
+	ASSERT_EQ(fstat(reopened_fd, &reopened_st), 0);
+	ASSERT_EQ(reopened_st.st_ino, netns_ino);
+
+	TH_LOG("Successfully reopened netns %lu via file handle (socket-kept)", netns_ino);
+
+	close(reopened_fd);
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
+	/* Verify namespace appears in listns() */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		free(handle);
+		close(sock_fd);
+		close(netns_fd);
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		TH_LOG("listns failed: %s", strerror(errno));
+		ASSERT_GE(ret, 0);
+	}
+
+	found_netns = false;
+	found_userns = false;
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == netns_id)
+			found_netns = true;
+		if (ns_ids[i] == userns_id)
+			found_userns = true;
+	}
+	ASSERT_TRUE(found_netns);
+	ASSERT_TRUE(found_userns);
+	TH_LOG("Found netns %llu in listns() output", netns_id);
+
+	close(netns_fd);
+
+	/* Verify namespace appears in listns() */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		free(handle);
+		close(sock_fd);
+		close(netns_fd);
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		TH_LOG("listns failed: %s", strerror(errno));
+		ASSERT_GE(ret, 0);
+	}
+
+	found_netns = false;
+	found_userns = false;
+	for (i = 0; i < ret; i++) {
+		if (ns_ids[i] == netns_id)
+			found_netns = true;
+		if (ns_ids[i] == userns_id)
+			found_userns = true;
+	}
+	ASSERT_FALSE(found_netns);
+	ASSERT_FALSE(found_userns);
+	TH_LOG("Netns %llu correctly disappeared from listns() after socket closed", netns_id);
+
+	close(sock_fd);
+	free(handle);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


