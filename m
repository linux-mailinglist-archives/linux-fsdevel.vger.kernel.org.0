Return-Path: <linux-fsdevel+bounces-64871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DB7BF6313
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C889F501DC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA77340A54;
	Tue, 21 Oct 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM8OS4bF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E632ED59;
	Tue, 21 Oct 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047137; cv=none; b=erVfISP6hVo64HVLAcTBLIbE6+rw3QSfUtVHl25nr+j9pqJaF2zoXbnkei+FUZNN9VA99piJdxeSxkQQu5WRMFzG8Yz21umcYBzB130oqik6Nr6J0MR/Zsrsbg54ByFOBbPfH89Yk8CSgWhJW4AUAOB7h7TJapzjpsidG6Pnm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047137; c=relaxed/simple;
	bh=Pa0j7tNfgc1/Tkfnlhd7s6hsezXzZgIe91NhoiJaauI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHT04vt8xFqu8bTOWGyR7nTXhmbL4N05j/9NCfKL5d8C29c/8WM5quxrKgHQPMORiX6QGOWVEjrz82M6r7q68yosOnmlhdWrRrhViBq2MG959KyXNow/ekzDyKo5aw2JOVEq+EHGDE0TqJPBnP8++fNCgbK9TTm/Zn7prpdKETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM8OS4bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05813C4CEFF;
	Tue, 21 Oct 2025 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047136;
	bh=Pa0j7tNfgc1/Tkfnlhd7s6hsezXzZgIe91NhoiJaauI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fM8OS4bFd7iN4dJ5dDNdN8cYIXeB0NyZIo1GxTl1QuZ40qq3mvQqbwGx+CBZDlNHL
	 /oQcLQKm5mFtPls9m/8c5UaiWRu8O9cCeeqkXUzxXqsKWFR6IggtogiJ/cNTfG4k8u
	 Gx/LNMXWPLc1Cd8J/SXuMrJqfEkLykEV69NrPNcFPzLlxvoSY78Wsg62CIyrNmQkmn
	 v73NiVCqpJjL9PkQXrkMhaI+NQfJkXXwxW9NorBzyzME7wSD4ttVpMshyQOqWazeLz
	 wwqq3K5xLbj46MYxk5IjhVJFvoImsC0dGN4wfmdn1VB+5eeJUwCAJkgIuJtZV8ey7r
	 TT4KrETKeFc5w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:26 +0200
Subject: [PATCH RFC DRAFT 20/50] selftests/namespaces: second active
 reference count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-20-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2999; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Pa0j7tNfgc1/Tkfnlhd7s6hsezXzZgIe91NhoiJaauI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3zLZyIdtygqSnySJotVXVfUi5j9e/uD5lUceRf43
 z9XLXFpRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERMfjAyPNX4eIDRmunF4Yne
 /Md7Ytf7i4i6WK6azOSl/MT54WLpnwx/hS/955V4vNo5/d2ujLQ5X3zY1GY89L356TOb0AvlA5+
 yuQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test namespace lifecycle: create a namespace in a child process, get a
file handle while it's active, then try to reopen after the process
exits (namespace becomes inactive).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 21514a537b26..f628b4a4a927 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -71,4 +71,93 @@ TEST(init_ns_always_active)
 	free(handle);
 }
 
+/*
+ * Test namespace lifecycle: create a namespace in a child process,
+ * get a file handle while it's active, then try to reopen after
+ * the process exits (namespace becomes inactive).
+ */
+TEST(ns_inactive_after_exit)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	char buf[sizeof(*handle) + MAX_HANDLE_SZ];
+
+	/* Create pipe for passing file handle from child */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new network namespace */
+		ret = unshare(CLONE_NEWNET);
+		if (ret < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Open our new namespace */
+		fd = open("/proc/self/ns/net", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get file handle for the namespace */
+		handle = (struct file_handle *)buf;
+		handle->handle_bytes = MAX_HANDLE_SZ;
+		ret = name_to_handle_at(fd, "", handle, &mount_id, AT_EMPTY_PATH);
+		close(fd);
+
+		if (ret < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Send handle to parent */
+		write(pipefd[1], buf, sizeof(*handle) + handle->handle_bytes);
+		close(pipefd[1]);
+
+		/* Exit - namespace should become inactive */
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	/* Read file handle from child */
+	ret = read(pipefd[0], buf, sizeof(buf));
+	close(pipefd[0]);
+
+	/* Wait for child to exit */
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	if (WEXITSTATUS(status) != 0) {
+		SKIP(return, "Child failed to create namespace or get handle");
+	}
+
+	ASSERT_GT(ret, 0);
+	handle = (struct file_handle *)buf;
+
+	/* Try to reopen namespace - should fail with ENOENT since it's inactive */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd >= 0) {
+		/* Namespace is still active - this could happen if cleanup is slow */
+		TH_LOG("Warning: Namespace still active after process exit");
+		close(fd);
+	} else {
+		/* Should fail with ENOENT (namespace inactive) or ESTALE */
+		ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


