Return-Path: <linux-fsdevel+bounces-66281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB0AC1A6D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D06F8567769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A96350A2E;
	Wed, 29 Oct 2025 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQUp/2E/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A0366FC6;
	Wed, 29 Oct 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740784; cv=none; b=ElcK5ccUY+nU2+SScidqXM1zKRQrUlRP7Elajf3O3z0nNzvpbW3846jFNyHitZPqsxWKYEx5YRguRZwL9NXtF3P65JzpXz6ZxO6E0H1Bx8oc9Z/0R7OMuDGXHF9ZPXHKiAkha/SO6jbvaGOmeH7W1Ki/tztRSGh9s4XnlSXY4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740784; c=relaxed/simple;
	bh=+kgGWvLMBNpy0C4YEMZXDEKTpLYegwzhaVcMRXxEJRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h8ziLOTTwnRynP9tqNU7BzJXorCAl1kXyJQcpEZCDpyiEwWxsRkodZdFaXGFnKbo1aoa3bWjr05ZQDNKm4sBji0pklyLwmg6X50j09vwUwcJHNx+vYd/5uqqFprF7Ba/lHi7y3du6p6f2Yg6+mHzKAVt5HnCunzUHnYqNl5/WKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQUp/2E/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111A1C116B1;
	Wed, 29 Oct 2025 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740783;
	bh=+kgGWvLMBNpy0C4YEMZXDEKTpLYegwzhaVcMRXxEJRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OQUp/2E/skhKtrrpwAxfyaR97EtkNnKHr7qlgoqsjjd88QqnwOSxO/QxsMsWmD3K9
	 b4hTCKFlqojHUUroxy7/74va3SV9SK5q0vC3W5J5NSnRaPYz2s6yCVP9Afr/ETG8KR
	 JKPCi0p2GH7mDhKJvYhwf6TOyobe8nl9CRKnb1MxcfOc6SXbnORJfh7pjt/QoNVuSZ
	 SId/ZU+LHmOk48XlULgsBYI2f0g954eoVwvF5enK5kdTdYvYsHulEtoJwwgquqt+Dj
	 PpM3NJlzSjXXTzwAm2fgvsjpMyxkfkWVbwBRdyiAq7WqqGvu5GGSWrX0PLimbAwgDv
	 gNl0TL5qUvPhw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:21 +0100
Subject: [PATCH v4 68/72] selftests/namespace: second threaded active
 reference count test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-68-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3834; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+kgGWvLMBNpy0C4YEMZXDEKTpLYegwzhaVcMRXxEJRg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysU1wYr2WrHFzesEcTYcfCkrND6ff4uWazLDG1/rfa
 +ODu1ILO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayahkjw8IrrD3/bn0Qcrjo
 2ZvJek9NM4zNspFLWGJbqRj3wtgdXxkZNgY9uPLLZ6p94Upxlx/+hSFzYoIthBSmcfNsOmodcGE
 1LwA=
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


