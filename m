Return-Path: <linux-fsdevel+bounces-64873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B4BF632B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 677C43542CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1489734164E;
	Tue, 21 Oct 2025 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCGgY8/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEA244693;
	Tue, 21 Oct 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047148; cv=none; b=muuz55KE3TIh3AE6XhK10NBx8jZA5KGYvYbu2o8NJwqIwSPJiEWDOvTusUB8JSBmGnlWyRK0jdXPw1oK54mAc/jWVsRq5G+zKDmGjELTIEOaPCzLE8cZ41JSbdStasn5n7O9ws1n5Amzu0qbdx0TBnFex7p29RX+u2lY1ibWITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047148; c=relaxed/simple;
	bh=Xovo3cXcUN+Ljmv09mWRu/zdhsZObjVTLb0tW+lNHe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyUbTNlZzAugpLYugobDnIbYyEm1EH6l9lSRO5yaQhHhOGiIQsu56X7UILjLAhXZZMZWlIqdvWahmZFTuq6qbaD/cgxs7JGyOO9Md0xiDnZ+Yz/ZiklELcf/Hh8BV63HyyGdcm8M8Lcxdw+rsIwZ2E2Kd3eKhnY5/ozqyBn+eaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCGgY8/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899B6C4CEF1;
	Tue, 21 Oct 2025 11:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047147;
	bh=Xovo3cXcUN+Ljmv09mWRu/zdhsZObjVTLb0tW+lNHe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aCGgY8/21CRlRoI57qcuePamgNkBMjzG5z3Ns1tTuSFLdzQdi6wHazMo024U7s8mT
	 aU57aHwJxJ3pMlH6jbyUO78ADeRVPFKr3wIznIKcjBDDb5ajvx3AsIQvwM7gnPxumm
	 2yw7aHxly5hkLTpGio/5OtH60isS1i5o+esHXAftL8LUb9e1m5qCL6wJigNYqQDQdR
	 LQucohfjOwpkLU/d6ZKfNY5ieVeREs8l96m/FIThZP9OIg/PQ09QpvyREpNrso89lP
	 QbAJ6ktw6s10WHXGDZEpxSIe9R/a/RobytZ5eXqMDVU6dc8UOcV857i1iMOtlODkuE
	 1Dqe0HY3rdWKA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:28 +0200
Subject: [PATCH RFC DRAFT 22/50] selftests/namespaces: fourth active
 reference count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-22-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3057; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Xovo3cXcUN+Ljmv09mWRu/zdhsZObjVTLb0tW+lNHe8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3yr/+0EO9OEUJl9yzU2m2st1VzDs6rGJfpZ/o9P8
 hxTg+/v6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI93yG/37vbb+0KactCXx4
 Njzz633mFXxBzyJmXvnndOx36Ws1r30M/3OZCtr2bm79k2SXev2ddGxc3MLC5mfWnPdkZm246iS
 0gA0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test user namespace active ref tracking via credential lifecycle.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 97 ++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 63233f22517a..b9836693f5ec 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -288,4 +288,101 @@ TEST(ns_active_with_multiple_processes)
 	ASSERT_TRUE(WIFEXITED(status));
 }
 
+/*
+ * Test user namespace active ref tracking via credential lifecycle
+ */
+TEST(userns_active_ref_lifecycle)
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
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new user namespace */
+		ret = unshare(CLONE_NEWUSER);
+		if (ret < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Set up uid/gid mappings */
+		int uid_map_fd = open("/proc/self/uid_map", O_WRONLY);
+		int gid_map_fd = open("/proc/self/gid_map", O_WRONLY);
+		int setgroups_fd = open("/proc/self/setgroups", O_WRONLY);
+
+		if (uid_map_fd >= 0 && gid_map_fd >= 0 && setgroups_fd >= 0) {
+			write(setgroups_fd, "deny", 4);
+			close(setgroups_fd);
+
+			char mapping[64];
+			snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
+			write(uid_map_fd, mapping, strlen(mapping));
+			close(uid_map_fd);
+
+			snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
+			write(gid_map_fd, mapping, strlen(mapping));
+			close(gid_map_fd);
+		}
+
+		/* Get file handle */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
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
+			exit(1);
+		}
+
+		/* Send handle to parent */
+		write(pipefd[1], buf, sizeof(*handle) + handle->handle_bytes);
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+	ret = read(pipefd[0], buf, sizeof(buf));
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	if (WEXITSTATUS(status) != 0) {
+		SKIP(return, "Child failed to create user namespace");
+	}
+
+	ASSERT_GT(ret, 0);
+	handle = (struct file_handle *)buf;
+
+	/* Namespace should be inactive after all tasks exit */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd >= 0) {
+		TH_LOG("Warning: User namespace still active after process exit");
+		close(fd);
+	} else {
+		ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


