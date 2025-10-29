Return-Path: <linux-fsdevel+bounces-66237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E4C1A519
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D65846217B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADEC3590BF;
	Wed, 29 Oct 2025 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnDRftP+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2689346E41;
	Wed, 29 Oct 2025 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740561; cv=none; b=FwZE+WWvwEM8iXP5/D9VuIStRzGNALQrgw/Dckdqqr1yfval9KkbD2eGOTcRWmL6uJNxnDXgHPYERaLVfpCHzoXRstXfi151IBJ9dFk7SEoXDOVUr/VwpwDp0Uw1++VGQmgJBg8jhurcsrYo4886pb2vfWbHGzJ5jFpMEz3CSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740561; c=relaxed/simple;
	bh=VPZa5Pr6JMy6E6vudTcQn3gJk3UQIlVxfxrLDEyUgG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mu8OP18UW13qgXMcTPjRe6QFKxr6wqAzZBNgtOTtmMB3Yhz1u54HfNidBGCfMyBb/2/49gsUHWdLmYwQ6CLHnZm1ej/Lh86LE+ibiDB6NQy8Yh9/fHAbPz5PqSZLYoCs3bq5c7xgBA3Or4p9/W3MDjj8NFmfQsaT3yV8FKqBFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnDRftP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB566C4CEF7;
	Wed, 29 Oct 2025 12:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740560;
	bh=VPZa5Pr6JMy6E6vudTcQn3gJk3UQIlVxfxrLDEyUgG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QnDRftP+/72UgrstFsgXBNah7BFFUeC+Y9KZSTnzzYL602mk+D1G4MUQtbmI+1FFa
	 uhRM+SXY5Aczu/9Ko73zIQHm9/v+JZissHn/CHnSjpwAwlz+hCX5tqZLclTslpT8LB
	 5drpEi09q1c3TnH8PtxzxQ4vWMlkD8hTwFGTHOYdSoEyQ8b+RFpUBqchmdk1qSPDeY
	 nXwAp7rpIW0FjmB+ut3VeTj2kXorlGqS/BWmjXY5jro/xaeNnCHtbR88K9Atm9MKDJ
	 0TXClGdm7nqOqywNmyA67ez8xsNRdA777nMMwYl+wjWDrVDROq1GpTkM3Cg+freZn8
	 kunQaQ3/qhCyw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:37 +0100
Subject: [PATCH v4 24/72] selftests/namespaces: second active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-24-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VPZa5Pr6JMy6E6vudTcQn3gJk3UQIlVxfxrLDEyUgG4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfXOsWKwFvXqeMrMwzHBZfHvQNMnJtJmLH5Tpr5We
 bNPY8KmjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksV2Vk+Ka+/MQ71Rpx9ZXX
 g64KsxYukNDYy2+2fGeL8vNbOn/PqzP8s3Wfq35vE//t2PkZBYITmGq+b+TQy+Wf/cI1cJvUvWc
 BnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test namespace lifecycle: create a namespace in a child process, get a
file handle while it's active, then try to reopen after the process
exits (namespace becomes inactive).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 21514a537b26..7cade298c754 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -71,4 +71,85 @@ TEST(init_ns_always_active)
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
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_GT(ret, 0);
+	handle = (struct file_handle *)buf;
+
+	/* Try to reopen namespace - should fail with ENOENT since it's inactive */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_LT(fd, 0);
+	/* Should fail with ENOENT (namespace inactive) or ESTALE */
+	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


