Return-Path: <linux-fsdevel+bounces-65506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D3C05F53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625251C266DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259036CA96;
	Fri, 24 Oct 2025 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS9VuFq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2D3191D8;
	Fri, 24 Oct 2025 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303545; cv=none; b=dr8a01HWFsDPqa4vQHtM4Mzu0ZcqKvExu2hJWZTOtjZUd8dWaKIm/eQU6njgBBMRWsUJZZMEr1S/Fxg367ugDxZgghGpJHd2n5OCIsKeBJ8xSGX+AhQLrOtjs9el2K1+J2Qw4ouVbqRkVqyXmLKVxguSw+VZzd5DhhTXkF4gmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303545; c=relaxed/simple;
	bh=+kgGWvLMBNpy0C4YEMZXDEKTpLYegwzhaVcMRXxEJRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iu4VX79tSepGEm0/sD2Tp4SEqfBIZvcYgPciUt+KkNwyF7xpo1bTuhgEYSXA3ygmZmRzprLXrXq8b6OVz2Kp+OTxmuEtTcdGhdSon4YYysl/1JTznJ+doK9mijXCU9m690ePXovtxZDcFJG+KsSuBUrpxpp6PfNdJSlyTLD18rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS9VuFq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17CAC4CEFF;
	Fri, 24 Oct 2025 10:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303545;
	bh=+kgGWvLMBNpy0C4YEMZXDEKTpLYegwzhaVcMRXxEJRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OS9VuFq+p15knQbrnvWBwJblwGdno3oU59XB0mMm6SUD48391bR0SpVaxLCk/u2Wf
	 impzdD4YedlLes45Ec6LF4lUDYYr4jiuipgpOjLG4hhnaqwW42Fr7UfnMnVnk7onw2
	 GGRWo5mLghvuiRmf/sPL7jgf56HsF2QDiCUwM+nh0NZNxds5dPp08VMhiN15np/fBF
	 /Bz3eIQ9kQ+yFjmNlnhxckedjjnpZkVn5tfzqKkg2nkJov0psm/0vnsSNlh6rVOXeT
	 KVwC4w7JG3THen32DAd8iO5tYbBI0pNJ0BFWuVwZu8pgyDMdBjv9czwH1RIZOIHNtj
	 hRvH89Cyp9vPg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:35 +0200
Subject: [PATCH v3 66/70] selftests/namespace: second threaded active
 reference count test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-66-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3834; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+kgGWvLMBNpy0C4YEMZXDEKTpLYegwzhaVcMRXxEJRg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8juoI73luXFt+yfSE8Ydd6umC5iXqJSYn1gWyvOnIc
 a4UUHnYUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBGlVEaGWc6uJ2I7p7xKUV6h
 vt9m1QKl6qlGt/PynOQ/JqfzvLwfyPDPcq9q/em0WYfnRWl9n3fQzECb07ax7sVFla+G0rfTdvO
 yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that a namespace remains active while a thread holds an fd to it.
Even after the thread exits, the namespace should remain active as long
as another thread holds a file descriptor to it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 0c6c4869bb16..24dc8ef106b9 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -2251,4 +2251,103 @@ TEST(thread_ns_inactive_after_exit)
 	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
 }
 
+/*
+ * Test that a namespace remains active while a thread holds an fd to it.
+ * Even after the thread exits, the namespace should remain active as long as
+ * another thread holds a file descriptor to it.
+ */
+TEST(thread_ns_fd_keeps_active)
+{
+	pthread_t thread;
+	struct thread_ns_info info;
+	struct file_handle *handle;
+	int pipefd[2];
+	int syncpipe[2];
+	int ret;
+	char sync_byte;
+	char buf[sizeof(*handle) + MAX_HANDLE_SZ];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	ASSERT_EQ(pipe(syncpipe), 0);
+
+	info.pipefd = pipefd[1];
+	info.syncfd_read = syncpipe[0];
+	info.syncfd_write = -1;
+	info.exit_code = -1;
+
+	/* Create thread that will create a namespace */
+	ret = pthread_create(&thread, NULL, thread_create_namespace, &info);
+	ASSERT_EQ(ret, 0);
+
+	/* Read namespace ID from thread */
+	__u64 ns_id;
+	ret = read(pipefd[0], &ns_id, sizeof(ns_id));
+	if (ret != sizeof(ns_id)) {
+		sync_byte = 'X';
+		write(syncpipe[1], &sync_byte, 1);
+		pthread_join(thread, NULL);
+		close(pipefd[0]);
+		close(pipefd[1]);
+		close(syncpipe[0]);
+		close(syncpipe[1]);
+		SKIP(return, "Failed to read namespace ID from thread");
+	}
+
+	TH_LOG("Thread created namespace with ID %llu", (unsigned long long)ns_id);
+
+	/* Construct file handle */
+	handle = (struct file_handle *)buf;
+	handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *fh = (struct nsfs_file_handle *)handle->f_handle;
+	fh->ns_id = ns_id;
+	fh->ns_type = 0;
+	fh->ns_inum = 0;
+
+	/* Open namespace while thread is alive */
+	TH_LOG("Opening namespace while thread is alive");
+	int nsfd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_GE(nsfd, 0);
+
+	/* Signal thread to exit */
+	TH_LOG("Signaling thread to exit");
+	sync_byte = 'X';
+	write(syncpipe[1], &sync_byte, 1);
+	close(syncpipe[1]);
+
+	/* Wait for thread to exit */
+	pthread_join(thread, NULL);
+	close(pipefd[0]);
+	close(pipefd[1]);
+	close(syncpipe[0]);
+
+	if (info.exit_code != 0) {
+		close(nsfd);
+		SKIP(return, "Thread failed to create namespace");
+	}
+
+	TH_LOG("Thread exited, but main thread holds fd - namespace should remain active");
+
+	/* Namespace should still be active because we hold an fd */
+	int nsfd2 = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_GE(nsfd2, 0);
+
+	/* Verify it's the same namespace */
+	struct stat st1, st2;
+	ASSERT_EQ(fstat(nsfd, &st1), 0);
+	ASSERT_EQ(fstat(nsfd2, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+	close(nsfd2);
+
+	TH_LOG("Closing fd - namespace should become inactive");
+	close(nsfd);
+
+	/* Now namespace should be inactive */
+	nsfd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_LT(nsfd, 0);
+	/* Should fail with ENOENT (inactive) or ESTALE (gone) */
+	TH_LOG("Namespace inactive as expected: %s (errno=%d)", strerror(errno), errno);
+	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


