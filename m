Return-Path: <linux-fsdevel+bounces-65151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F56BFD263
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089073A2A19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CFD36CDF2;
	Wed, 22 Oct 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzPJQePA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74793570D4;
	Wed, 22 Oct 2025 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149289; cv=none; b=Wjkq80+endRQZca6sD6/ElPwTO3scN6vnj24EPEYTKgeR2d05EPbspX17NqSsUeY/5gVP8/Q16kqZI48aB9pAHgFxfjTF6oecNdMhp/dqZMEkn7nRN8hD+FtB9fOa3i1ss4rr+I+bjoqD180GZBHrfo+6j0iRXFQhaPWlCCkhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149289; c=relaxed/simple;
	bh=Xovo3cXcUN+Ljmv09mWRu/zdhsZObjVTLb0tW+lNHe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vh+uRkq20H1VpBgwKZns3qgH5EE5B2y8d3WgIxjUcy8xnylte2zyfc9GVH1rPV45Fbx+IWj0FCDnw99vMxyhwi/LfVri9u8nTzbyHaZe4OhAwJJanUKU9F38j+VFfXZRJOJSP8fIyUMUbXwCJDm/MHzQw+x5MameE8yhPl9RPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzPJQePA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CABC4CEE7;
	Wed, 22 Oct 2025 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149288;
	bh=Xovo3cXcUN+Ljmv09mWRu/zdhsZObjVTLb0tW+lNHe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BzPJQePABSnPueXGAVDq9fYA3O9LbAS6qZott+iC9V3L8aJ4uF1B+EutmSHxTaL6j
	 iGwN9fZD/7Wg35uJS4NGFpqbZGzGS2wP5YszC8V9NzBSZvLSkuXgvispr/mjwVfTvy
	 QWWcW5QM+EVV6j7mzycfugYFgXmeHLLpaQ8DcXJtS08tnwALGCL5Jw6gzAyBbg8q+1
	 BtrghHHfJ889rN5/NDMe/2HBVLoRiPWerJKkioPv42HzdoBdJ5K/RLJ3FIi5oCcQw+
	 jyotFPGgqLQkWBdOdi8A42CcuIcPdqjyeMf2QTMF4ElroeKnuvQM0z9MYqQ4a88i1/
	 r6QfA8/Vc78vA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:01 +0200
Subject: [PATCH v2 23/63] selftests/namespaces: fourth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-23-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3057; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Xovo3cXcUN+Ljmv09mWRu/zdhsZObjVTLb0tW+lNHe8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHia+/mr2gOj+dJ/Xe/5HS9eVNyrN/ef1beu46FrB
 Ccx3q0S7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIknZGhj9JL/1DZLJe+ivt
 qdBf1mGzp3rNrvXMXWrKAteOS6dmSzEyfF+oN0le/a4oS4jcz2zTsBLLkJmn3kaUCu3L81OIeuz
 ACQA=
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


