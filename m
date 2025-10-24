Return-Path: <linux-fsdevel+bounces-65468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C719AC05CFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F17E1A028C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413133A00A;
	Fri, 24 Oct 2025 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0kdq1PT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442233B958;
	Fri, 24 Oct 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303323; cv=none; b=u2WIKv5LknjO2zJwD6uxEzScjgF7JWudadqf4tCl6ZKJfQkM0FU3uSGDSjdrWOt9pp1FATdDzK3vqbUrI3x4aG/QObsYcV3cH6cTR01HF+GICa9tLIhbWAT8EJRzADZcHl9xHO46yx412MFPppvfy4iUz2Q6Ju/wR/gReuwGqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303323; c=relaxed/simple;
	bh=45ZVAOSQ14PBDoxcUZ9fr0EyfYF6v23SFzJ2GrRGZ3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHtWy1JL4iNJrZwyvsgMazDEbeUtNvyQJUq8l8pTGPkKoMBLXGpUrCoGOeigempUHff9JSLmuhCHlVuMWI1LkWsVvoOtP3LNkBHCIPoEsSy0YmBfgCF+U+KEDoLkCTWXaNwM8HQnVLA9Rcnw8DIZmZroEOJD3IJ6e7InI3cT0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0kdq1PT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47280C4CEF1;
	Fri, 24 Oct 2025 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303322;
	bh=45ZVAOSQ14PBDoxcUZ9fr0EyfYF6v23SFzJ2GrRGZ3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t0kdq1PTU/3GA8UjOfYOduY9T/jA1Gz3i6knpoDad5oajgEUzyil9vgGAh3I7vy1T
	 Ek0ZVCFLNNel9qafhZ46TpPtVicbRzQMvQjm1e6YZgLtBihWjxAsvYOPrkyaiOh+o3
	 sRiQfEhBhwFrrjlbC5HZ3u1CFHjTyJswZCVVDjW9Zlw90lNTdMUqYTuuqSwy8pmZCV
	 yodZFLrIE7Lm1BDgyVEsTmFNEalGSzf6+4bCYVmYOtHQ+685TFJoMLn9qDbOb/elDy
	 t26Cp8aOsRMhZIQWpyK3V3NCOtFKwbqVtTz7bQNam//7FpZcB3B3FwyFbDRbb0z4we
	 u5moWOn9j2eyQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:57 +0200
Subject: [PATCH v3 28/70] selftests/namespaces: eigth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-28-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3400; i=brauner@kernel.org;
 h=from:subject:message-id; bh=45ZVAOSQ14PBDoxcUZ9fr0EyfYF6v23SFzJ2GrRGZ3Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmq1frv1UVJO9nq174UrNpzLmXBi2pOZ9ka/jCe6J
 p6abzGPq6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiL/YzMsxWz3nGo1xvVf+o
 4sLSuCcTi4u6E365c6v4M3t7vl7wYSrDf0cGZeP/r3K2qpobLp9+r0syO1JSR+KwmoR8nnWNdGo
 0BwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that bind mounts keep namespaces in the tree even when inactive

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 60876965dd71..55a741d32b08 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -825,4 +825,121 @@ TEST(ns_parent_always_reachable)
 	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
 }
 
+/*
+ * Test that bind mounts keep namespaces in the tree even when inactive
+ */
+TEST(ns_bind_mount_keeps_in_tree)
+{
+	struct file_handle *handle;
+	int mount_id;
+	int ret;
+	int fd;
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	char buf[sizeof(*handle) + MAX_HANDLE_SZ];
+	char tmpfile[] = "/tmp/ns-test-XXXXXX";
+	int tmpfd;
+
+	/* Create temporary file for bind mount */
+	tmpfd = mkstemp(tmpfile);
+	if (tmpfd < 0) {
+		SKIP(return, "Cannot create temporary file");
+	}
+	close(tmpfd);
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
+		/* Unshare mount namespace and make mounts private to avoid propagation */
+		ret = unshare(CLONE_NEWNS);
+		if (ret < 0) {
+			close(pipefd[1]);
+			unlink(tmpfile);
+			exit(1);
+		}
+		ret = mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL);
+		if (ret < 0) {
+			close(pipefd[1]);
+			unlink(tmpfile);
+			exit(1);
+		}
+
+		/* Create new network namespace */
+		ret = unshare(CLONE_NEWNET);
+		if (ret < 0) {
+			close(pipefd[1]);
+			unlink(tmpfile);
+			exit(1);
+		}
+
+		/* Bind mount the namespace */
+		ret = mount("/proc/self/ns/net", tmpfile, NULL, MS_BIND, NULL);
+		if (ret < 0) {
+			close(pipefd[1]);
+			unlink(tmpfile);
+			exit(1);
+		}
+
+		/* Get file handle */
+		fd = open("/proc/self/ns/net", O_RDONLY);
+		if (fd < 0) {
+			umount(tmpfile);
+			close(pipefd[1]);
+			unlink(tmpfile);
+			exit(1);
+		}
+
+		handle = (struct file_handle *)buf;
+		handle->handle_bytes = MAX_HANDLE_SZ;
+		ret = name_to_handle_at(fd, "", handle, &mount_id, AT_EMPTY_PATH);
+		close(fd);
+
+		if (ret < 0) {
+			umount(tmpfile);
+			close(pipefd[1]);
+			unlink(tmpfile);
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
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_GT(ret, 0);
+	handle = (struct file_handle *)buf;
+
+	/*
+	 * Namespace should be inactive but still in tree due to bind mount.
+	 * Reopening should fail with ENOENT (inactive) not ESTALE (not in tree).
+	 */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_LT(fd, 0);
+	/* Should be ENOENT (inactive) since bind mount keeps it in tree */
+	if (errno != ENOENT && errno != ESTALE) {
+		TH_LOG("Unexpected error: %d", errno);
+	}
+
+	/* Cleanup */
+	umount(tmpfile);
+	unlink(tmpfile);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


