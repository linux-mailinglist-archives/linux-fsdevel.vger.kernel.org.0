Return-Path: <linux-fsdevel+bounces-65189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 34370BFD37D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABAA5358094
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217CB384B80;
	Wed, 22 Oct 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZddKlBn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1135A93A;
	Wed, 22 Oct 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149490; cv=none; b=Q7CHPSrnPXf1KltJQPx81lpY2eyCag8aWFLyqgRwLOSE3wGHrJnCqYAF5ZAfjF6o3vCm78F8Xh+pc6ObOeJtnCKGpjEMkdTn9Sz7Dta4S2RQeZoexRuot/C/E6vqpdUYmsg3aA0jnkAE13vVvO54Bu5brlJpJSkyus5LchyLPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149490; c=relaxed/simple;
	bh=No7FiVmWoBp1LOFVcEEf9bBTlBW0Ya8SnK2b2s5KfDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6PhyBEVVyi0uom4V1yEx7bht9xu+ZUFn6fEZfzG2T4VTsOeaa0wDlkyy0eHGDS+kz2O6G/pZZBd0MWzwy83quQw3xN3lOYNfof29k1aRkWGmg3koHayeVkqKR+FtAd9gbByFt/IC0gosmVdQP5E9mS5P46bMU7XZfVEu+H8Oug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZddKlBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B315C4CEE7;
	Wed, 22 Oct 2025 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149490;
	bh=No7FiVmWoBp1LOFVcEEf9bBTlBW0Ya8SnK2b2s5KfDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nZddKlBna4fqY2Z96NW1OaUqRogY36gdzzIAaUyv6P/jceOUpY+um2wnamSO7H3Pv
	 Vh5aAivZx08izL1IWCZsAXLuUmBHGtUna2CpCEROjVmNkmCzGcK6LAFdWpmHJRhH/R
	 qED2Xtzpkq1WjJ3W2Yo5isCxM8LAzfBH12HK+nJyyZmsOGS+u+nQA04tnRZGCBpsxy
	 SYE7XxVeF9TCM+aKmg4evL/Eq5bs1eixxl4OEw168a73tXGb9fCKUQyeyLPI4f7kOb
	 qBD2enf3WIb/l/UAWerlKXarOWJNcYVYCHLtgui+EppY3J1Eb0adK6M6Ack6Zx8QIe
	 Rt3BElwGpE7AA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:39 +0200
Subject: [PATCH v2 61/63] selftests/namespaces: tenth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-61-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6827; i=brauner@kernel.org;
 h=from:subject:message-id; bh=No7FiVmWoBp1LOFVcEEf9bBTlBW0Ya8SnK2b2s5KfDo=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGj5AOegnCkeUijWzfVAEMyJlkANXq7MHw3xv0VPMhSQUgk27
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmj5AOcACgkQkcYbwGV43KKm7QD+KvUq
 LTR/jdn7CU/P8vBUMdgL2KpFtWz6H72ubYzc3+4BAMUpTJ81orfwmq6x9IgTAK5LOkAW8BarmKC
 lpSXSodMN
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that socket-kept netns can be reopened via file handle.
Verify that a network namespace kept alive by a socket FD can be
reopened using file handles even after the creating process exits.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 203 +++++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 7b3133f3898c..0ea5241f2b6f 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -781,4 +781,207 @@ TEST(siocgskns_listns_visibility)
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
+	if (WEXITSTATUS(status) != 0) {
+		free(handle);
+		SKIP(close(sock_fd); return, "Child failed to create namespace");
+	}
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
+	if (reopened_fd >= 0) {
+		/* This might succeed if there's still a reference somewhere */
+		TH_LOG("Warning: reopened netns after socket closed (fd=%d)", reopened_fd);
+		close(reopened_fd);
+	} else {
+		TH_LOG("Correctly failed to reopen inactive netns: %s", strerror(errno));
+	}
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


