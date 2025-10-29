Return-Path: <linux-fsdevel+bounces-66238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42852C1A498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F012560EE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A623596F9;
	Wed, 29 Oct 2025 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnw1aMB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA4310624;
	Wed, 29 Oct 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740566; cv=none; b=omEqrFqggUoE2gjRplVFXnPl2ylX5D1DE90Y2s9061OGNDjf+PIx4Jh7zbWuBeiOa0StW6uVuEuOYCHhbwP+JBGB4PhoY3WV+9BJVse7gCT5FzhfbcX9+TzmMs4LFpT0vcsRFfIxqsJz00cm4You5fAABx5y1Dn1qaARqFlwhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740566; c=relaxed/simple;
	bh=aUj6NRVDEfXAvY88G+wOpYmY1IAUvRXs+4FwCz1W+QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/U0XpyapGBmoyqD4U+xpQ8PrTd5DZF42YFvL+s+7SKuOZw+UdUfwjF/dw7lqKgEQuIGxJ1ZR/OaL/POl2dSY+U0GLNkXQ1JKSvRf66TofvwjNmaL8YkL6FOPZHmDp64mYO+wfFKs/eVEpTkOWaVc0W8NlAtOsIqz9mAvOcr0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnw1aMB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1471CC4CEFD;
	Wed, 29 Oct 2025 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740565;
	bh=aUj6NRVDEfXAvY88G+wOpYmY1IAUvRXs+4FwCz1W+QY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jnw1aMB2/mFYOeS4oJ7GrQyGWmVZBCpi/0ToK43HUjZMLS3fWTnMTDCOwA7yRosiC
	 2rga7pe3YBN5aG0HYr264QwmwGInYFeMLwL6ewlDX5Z2MQpqhd6aE4y/+WpTOSeHfx
	 hp3EL+ygd6CMjN5hN/RleS7csNqh0oifawdtxGDNEPlCX2LRM0OmIpWXIazuHBQObm
	 beMMkXnegQ+gc+1mmzT6lX3VZDxmXVinM8hzm/bytSrKnOwdXwtW2/RKFGAnLotXjz
	 8C5TgXL33PqrZpoFQLV3iZG4uD5wN/9LdIbMEJSE7L+9ftLofCHfSEHkYwfm++XJtZ
	 xJ3rCi2djX46g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:38 +0100
Subject: [PATCH v4 25/72] selftests/namespaces: third active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-25-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3551; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aUj6NRVDEfXAvY88G+wOpYmY1IAUvRXs+4FwCz1W+QY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfW+Wf21aMLcuFV1TJZp4Zq9bszFGZe/PIqPW7jMQ
 t8xdcq2jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8fMHwz+qY5PIH8hK36kVc
 gi6fnhcccSP464xly9Zbvohv3egSv47hN/vb8I9H0wpNd4s5cf21tfpoEnVdhI/5nHbiVZ46vSJ
 /dgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that a namespace remains active while a process is using it,
even after the creating process exits.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 124 +++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 7cade298c754..c2e34de7a3a9 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -152,4 +152,128 @@ TEST(ns_inactive_after_exit)
 	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
 }
 
+/*
+ * Test that a namespace remains active while a process is using it,
+ * even after the creating process exits.
+ */
+TEST(ns_active_with_multiple_processes)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int pipefd[2];
+	int syncpipe[2];
+	pid_t pid1, pid2;
+	int status;
+	char buf[sizeof(*handle) + MAX_HANDLE_SZ];
+	char sync_byte;
+
+	/* Create pipes for communication */
+	ASSERT_EQ(pipe(pipefd), 0);
+	ASSERT_EQ(pipe(syncpipe), 0);
+
+	pid1 = fork();
+	ASSERT_GE(pid1, 0);
+
+	if (pid1 == 0) {
+		/* First child - creates namespace */
+		close(pipefd[0]);
+		close(syncpipe[1]);
+
+		/* Create new network namespace */
+		ret = unshare(CLONE_NEWNET);
+		if (ret < 0) {
+			close(pipefd[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+
+		/* Open and get handle */
+		fd = open("/proc/self/ns/net", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+
+		handle = (struct file_handle *)buf;
+		handle->handle_bytes = MAX_HANDLE_SZ;
+		ret = name_to_handle_at(fd, "", handle, &mount_id, AT_EMPTY_PATH);
+		close(fd);
+
+		if (ret < 0) {
+			close(pipefd[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+
+		/* Send handle to parent */
+		write(pipefd[1], buf, sizeof(*handle) + handle->handle_bytes);
+		close(pipefd[1]);
+
+		/* Wait for signal before exiting */
+		read(syncpipe[0], &sync_byte, 1);
+		close(syncpipe[0]);
+		exit(0);
+	}
+
+	/* Parent reads handle */
+	close(pipefd[1]);
+	ret = read(pipefd[0], buf, sizeof(buf));
+	close(pipefd[0]);
+	ASSERT_GT(ret, 0);
+
+	handle = (struct file_handle *)buf;
+
+	/* Create second child that will keep namespace active */
+	pid2 = fork();
+	ASSERT_GE(pid2, 0);
+
+	if (pid2 == 0) {
+		/* Second child - reopens the namespace */
+		close(syncpipe[0]);
+		close(syncpipe[1]);
+
+		/* Open the namespace via handle */
+		fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+		if (fd < 0) {
+			exit(1);
+		}
+
+		/* Join the namespace */
+		ret = setns(fd, CLONE_NEWNET);
+		close(fd);
+		if (ret < 0) {
+			exit(1);
+		}
+
+		/* Sleep to keep namespace active */
+		sleep(1);
+		exit(0);
+	}
+
+	/* Let second child enter the namespace */
+	usleep(100000); /* 100ms */
+
+	/* Signal first child to exit */
+	close(syncpipe[0]);
+	sync_byte = 'X';
+	write(syncpipe[1], &sync_byte, 1);
+	close(syncpipe[1]);
+
+	/* Wait for first child */
+	waitpid(pid1, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	/* Namespace should still be active because second child is using it */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_GE(fd, 0);
+	close(fd);
+
+	/* Wait for second child */
+	waitpid(pid2, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


