Return-Path: <linux-fsdevel+bounces-65501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218DAC05F23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CF83BDDA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FEF36A5EE;
	Fri, 24 Oct 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlgs5ul2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09946318142;
	Fri, 24 Oct 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303520; cv=none; b=X9U9keIh+acJBzDGFt59q0BkuYHbaM1OfLpFIuw+Bd6hJm9vD/tT8BgeI14XBo4vIOq5U/IsZTAm7ChMe3LJZI3e+m7Co19ZmqsokEtBBMR71y5K4S8ezVychSiv8TAuEb6BpT23VXbgVljW+5hf5NhFUHzB1UlKOX/TzolDy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303520; c=relaxed/simple;
	bh=2GRkF4aTvddGMSpKeYnAxQf+2i+z67SQVbcHcw3mqCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=buWxFCbOuhGz1UvUYbCmD4koDJc7X1hvNqlKwvCLcGZHGUKaJ96C14/N2I0HrSiLAf35Uz3uuKrMS//Aw7KTueb6C/aTky2bKl48ip9wTnwKk8zXt8R6QJMDGJD1LolQ0TmAkZeYrvaFl4ynG3HQPvnfo/hsrJXB74IGiXqC+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlgs5ul2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0D2C4CEF5;
	Fri, 24 Oct 2025 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303519;
	bh=2GRkF4aTvddGMSpKeYnAxQf+2i+z67SQVbcHcw3mqCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dlgs5ul21HqMAKH0vzw3669fuZ2kyoxwus8rZOBODOyp0ZYU26c61rXzj+1iUcvCS
	 T/XWXBWCWAiPP+ET/40hezlm3pTRZU5uQUexTRTWaCHKJNdGNnDmuNBDE3WFJ2DXPs
	 brAlgHPNTMdVhM8wJqm46eiQDZ7xJv7aICoHrieTRqhGdhdoKrUTOLjuu5MRn/sE+r
	 BpetiXzKh30mkFn6Vq9LsHQG+T2/82hwV0nmx8sr8rMhu15TsRArogh8MmV+ovcGse
	 n8iEPAfOJL3U1EVsitGUnSk+87j9gR99kc1afAOcfQOAzOW3G4PSrU5MDEfNTT2WdU
	 NQ/nyLnNTOswg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:30 +0200
Subject: [PATCH v3 61/70] selftests/namespaces: ninth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-61-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5894; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2GRkF4aTvddGMSpKeYnAxQf+2i+z67SQVbcHcw3mqCk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmpf/246m7z+lg5H+4bNxy+8PHd4uU+lfeW9HS/3V
 4nuTngzvaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi0tWMDM8Z4296n3+wY63b
 rPUlrnNXT2pXDf/u4C/MuOLAzjmtE08w/I81/7uvZnZPhmTOQt0nCgvTj0aKFN9nuxp4iGcKe/I
 5YSYA
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


