Return-Path: <linux-fsdevel+bounces-65149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2806ABFD1C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD1C3AECEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3844E355026;
	Wed, 22 Oct 2025 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQjDMdbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23426E6F6;
	Wed, 22 Oct 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149278; cv=none; b=lziqkH6qiAqekurSdaAOXYYxhnD92SRlmvpM+awZvFmJlIxzTvaLWA/2/0R+g9HWYF9sJOgdoAyOOxws2iawzirzObS/8HbLecRyUZ+L37ssSCXj37/LX/dlhivmnmZt2ylJZfdYb04m2Phwslx/oKcNPoiRHFwwTeBOFJeYaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149278; c=relaxed/simple;
	bh=Pa0j7tNfgc1/Tkfnlhd7s6hsezXzZgIe91NhoiJaauI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Upefj+kqBaPpaNf4jhLOjDcd0d62K9eNIBeiueDobP5LrsLNr613Iy2U2+ojS72JrdVGyzx2LG1VW9mpeLiAxTR5Z5IMBrD5fWhl9LOwUh7BhPt45vDMwLL551Py/PFaL/ejV50JNV1XuXTAW+o8UWboQqeoiK3MArm7v/4VRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQjDMdbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F379C4CEE7;
	Wed, 22 Oct 2025 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149278;
	bh=Pa0j7tNfgc1/Tkfnlhd7s6hsezXzZgIe91NhoiJaauI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QQjDMdbzEwKGXJiY+cHxrNTjn6KaXW673nKh0n8PGNiubJx5CGidkTXnktMaL3HWN
	 TQjNNUDkl2FSz1uH5DicBVBYg81ueSlK0Lb2zI1e/00aSdU3obmHY/KX+SCUyqMXHN
	 lN0+8y535zn9yVGc7BhkvPhEKklTC5Mon5mf8dKcPoUMupwI6RJtH4koIqetm/7OJN
	 l3nLphdwsOBMn0WGOYP6l7E91EUhNkRrStj//XSGbjHS7QZVRz/wuQfr9TyhB78s83
	 gfiPALHZOaUBaK+RDj6q8tMpbb2v+ffOSfKO05fRYWoHJFxehLP3tF1XTIDf5cLnBo
	 KTxWJqWN5tIwQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:59 +0200
Subject: [PATCH v2 21/63] selftests/namespaces: second active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-21-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2999; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Pa0j7tNfgc1/Tkfnlhd7s6hsezXzZgIe91NhoiJaauI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHjqf/ipcFKW1pEjW4J2NslVzjE0mqFcc2NO+Oml5
 5e6xnWGd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEKZ3hn61MVEdpaGXtPPOp
 Kh6VnRdU7oTXP9KTTnn36Zz/Zm+2akaGY36yHxKUJm/WnewmPvF9SHKz1fVM3f2nLk6c/Kpsd2w
 rBwA=
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


