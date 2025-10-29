Return-Path: <linux-fsdevel+bounces-66243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA79C1A4B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2800E582B6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D621368F39;
	Wed, 29 Oct 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N77F5jbX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4892A340D9A;
	Wed, 29 Oct 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740591; cv=none; b=NwHTxnlaHp6rvUJYa+cFbGmbb1iSeyt321/aKDh0/2zszsMapQGkTUG+SMq2obnLLalDba8O12ciPxoCI6/gnXxiD1cx5E+CQZ4tLivuMhBLDyAGOnsVqBFNZj3wZ+XywIROEyVuJbZTSSPY0SU13CtFUY+ikKGjhMWUyoQQkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740591; c=relaxed/simple;
	bh=45ZVAOSQ14PBDoxcUZ9fr0EyfYF6v23SFzJ2GrRGZ3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUXnihvsEOUO6oQ0pOfo7ojSqaBEW+cjNvxWTnFpJUhqXQCiMt1QDLtk2pWvDq9tkYhGXJHQHXDYJDeegtoWnby1z+Vnp6iccXkDkP5beMG7d0NwMg2Fv8aaGuetNExhm8Uto9yued/sYOeehnSOGHnJaGozAy96QjYtfYwTaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N77F5jbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B689C4CEF7;
	Wed, 29 Oct 2025 12:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740591;
	bh=45ZVAOSQ14PBDoxcUZ9fr0EyfYF6v23SFzJ2GrRGZ3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N77F5jbXN4Qq2c4MgUQ+rySw02wGcgWam9bDsw1ipvx/kVleRrLAmXhHHF6xzEwtL
	 n2N4EZacj1qYZgHhp48nvxpAzMAa/y1GB5yS0Edpy4ioPemGO2jIWYpF4UyhC/F2xW
	 ZUqGYoZEkMgUN3LT11j0chJJcgUrN0ocir9HFzQWOM3FytJvODYbehM6Y0ElQhjZJw
	 Csu+TgFP7T0qhPLRh+8L9HFYg+Dm6fyy+bn2kOpc5IVuewb4q7OY8tQNINXRWYTLYs
	 DlHVko0/1+Qau69hcaZkcuwkEkvN+N6sWvm7B5fdSNw9zL3pfg/FB2aGBD1eAhGUoG
	 X85wpYyRqtXfA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:43 +0100
Subject: [PATCH v4 30/72] selftests/namespaces: eigth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-30-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3400; i=brauner@kernel.org;
 h=from:subject:message-id; bh=45ZVAOSQ14PBDoxcUZ9fr0EyfYF6v23SFzJ2GrRGZ3Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfUm8C+6/H6ln9zmFLdNW96s1X8mtiuaOcuI8+3is
 qMRx02iO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS85rhf6b5RMGCJzf2+P/+
 un33xqBZAY2XTwc9YM9qOSP/uXfF5vWMDLce1t6St3cs6Y7IXRwkO7WtevPjmR273yfvMHHq+Cr
 Dyg0A
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


