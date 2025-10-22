Return-Path: <linux-fsdevel+bounces-65150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367EBFD200
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D4D3AF917
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42CE3557F5;
	Wed, 22 Oct 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnHPE4jF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129D355054;
	Wed, 22 Oct 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149283; cv=none; b=QyhhnXuJbz/kWfU8TbtBspSL4Lh9290xvbfQ3M1/i31V7cqDWJ2WG3OQMksVlMFL8FKR9+2d00ZnlzwRluvxZydBb4hsUiZpIyzHGeuqdIgaNGropcbaq1JJvLczlAbqp7p1cLlUhuVT8ux1n7isUChtO9IeCU3poST6VRvTrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149283; c=relaxed/simple;
	bh=RDvCp753eytqBU6RSu1QM6e320xY8EyidsVLpCI0zLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ck2tFpbFhPkgESr8HGLGrW4UgMz36slXkjaJ7SvbTzHxEGnjcRvgWiDEmKfqejRiJr9gzOUffeRTcXz7+9PJmnZKCY7FPTt04hZj3WplpC1Ei1HHabtK0MNRnTjFZfWNOTlhwT92QpzpF8vHquXR5RP5ceoyY6LVzfYnQ/VjWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnHPE4jF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758ECC4CEF7;
	Wed, 22 Oct 2025 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149283;
	bh=RDvCp753eytqBU6RSu1QM6e320xY8EyidsVLpCI0zLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tnHPE4jFZvB5N7V43VxXppjBy+8iiRcTHfhpTfa3gt7aiiTyPz3/m8072r4L+Fae5
	 KFNOKs4jWOvGw/dHWFN3xj6yxE/rIezvHqTTS9JDtbE1/oetgZVnyLbffs8DLfHeX0
	 s8VeU6EUBHea2hIDvmd/+AOxWv2q66xyZ7/yDjFqxQjemYDfYbTnWlWmh5aEHCMmzu
	 0G0cqLEQmUGeokCpenHazvCjstsggu7NuwlXfB/d283mEF/lQ01oQrnnyOhu4QstCL
	 juYs3ViMEZuVINCXL4kCAkd/alBnHWolydB0SjqNkO/S+XiT59WnyL4Z9uSHQHo6G3
	 8j4/zTcp4ErsA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:00 +0200
Subject: [PATCH v2 22/63] selftests/namespaces: third active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-22-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3662; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RDvCp753eytqBU6RSu1QM6e320xY8EyidsVLpCI0zLo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHj6O6+2nMc5/pjx8/QXFznK1t1t4bZlyn8nv8xRv
 kt6vpxCRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERWv2dkeJvVFtfTKSEp9l1A
 dp56b0or7zF+gZeLlGfV921sTK3PY2SYfXvXtF8HZ38T5Kj7cOzW+nOcx15/X5i67Kth1gKTjhA
 1BgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that a namespace remains active while a process is using it,
even after the creating process exits.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index f628b4a4a927..63233f22517a 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -160,4 +160,132 @@ TEST(ns_inactive_after_exit)
 	}
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
+	if (fd < 0) {
+		/* If this fails, second child might not have entered namespace yet */
+		TH_LOG("Warning: Could not reopen namespace (errno=%d)", errno);
+	} else {
+		close(fd);
+	}
+
+	/* Wait for second child */
+	waitpid(pid2, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


