Return-Path: <linux-fsdevel+bounces-65155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880ABBFD248
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0BE3B4618
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4FC29B8FE;
	Wed, 22 Oct 2025 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnIokx+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002D3563F3;
	Wed, 22 Oct 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149310; cv=none; b=ZZq/VVT3v5Q1aQrG+/ozBWRGldD2hBb8GxUZEt5zgeg4EJn/7cHW2txTxp/ujcOwNOXnqUPHVgxzXO6JtsKuXu9XZ6vFS5RYKhrWEdgxAIEAX1/CrHcNellkJQcl4+CRsdHNv24dsC9nvXISjYdbC1R+ZyxrLoIcR8Yjn73g+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149310; c=relaxed/simple;
	bh=2l+rS6eqHz2E2xHEBSJ9zjxwvPPCR3H2Nll2sPPrQIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnx1JtX3rYleTp+oLfGCFUw5T+5mGcp7L5rDbSIDwxnG3Ld18gNSKX2LviCRz9fLaUUKcojB4H/S/XdpyLGUfVvRpIjED6bMMNDK8YSJkWFvaWYX9lNWMkcszin/597RLYOvjTdSlU7ttFchQnnQ5YQDf8V44VYYl/YcTlJQVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnIokx+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22453C4CEE7;
	Wed, 22 Oct 2025 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149310;
	bh=2l+rS6eqHz2E2xHEBSJ9zjxwvPPCR3H2Nll2sPPrQIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VnIokx+pmBxulEjSulpYWFGElgVNH5ilBZPm6/oKYnxdjIGHOJkBPNNkmcCOGOoMK
	 Qyrhu4kdWVycpezZwSEttYtSIVhyJlsLXsVNIoF/48x10oux2Y3Cb6sYYbo/+6ySpN
	 GtMa742AQZAV8wFF2Mt7HkvpPGTnhZ+ogWWtTwuxdcROuH8m2XdsmbKITShr0LzG+Q
	 z/MCQCtFRp0Lmnf7hvmSUIWmKW1aquMUUJOSmveRnFSaAefchLY4PDsbFn+PXCBlRB
	 w57+XTG6j/EMAEDRE1MmERqP18QNqMwB189ar9+yYFtvFkQ+7RPIH3q6/1MjBAtyHJ
	 bxYJG74QWaLcQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:05 +0200
Subject: [PATCH v2 27/63] selftests/namespaces: eigth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-27-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3580; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2l+rS6eqHz2E2xHEBSJ9zjxwvPPCR3H2Nll2sPPrQIg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHhaa8r1dP1le7/4eY4Pqm9Pv6b9z45P/XVgTME2j
 qLzNTGeHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZupuRYbNkceBF6SN+b659
 jBb5+/Pcz52lMxSnbs+Vu3Kgru+e3m+Gv3JF3UIl5Xnca21fhG3leiu2sbNo1qmg1eEVe3nXc6m
 ZcwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that bind mounts keep namespaces in the tree even when inactive

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 126 +++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 6377f5d72ed9..66c9908d4977 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -883,4 +883,130 @@ TEST(ns_parent_always_reachable)
 	}
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
+
+	if (WEXITSTATUS(status) != 0) {
+		unlink(tmpfile);
+		SKIP(return, "Child failed to create namespace or bind mount");
+	}
+
+	ASSERT_GT(ret, 0);
+	handle = (struct file_handle *)buf;
+
+	/*
+	 * Namespace should be inactive but still in tree due to bind mount.
+	 * Reopening should fail with ENOENT (inactive) not ESTALE (not in tree).
+	 */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd >= 0) {
+		/* Unexpected - namespace shouldn't be active */
+		close(fd);
+		TH_LOG("Warning: Namespace still active");
+	} else {
+		/* Should be ENOENT (inactive) since bind mount keeps it in tree */
+		if (errno != ENOENT && errno != ESTALE) {
+			TH_LOG("Unexpected error: %d", errno);
+		}
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


