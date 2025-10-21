Return-Path: <linux-fsdevel+bounces-64880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 266FFBF63A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 910D3341162
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6D345723;
	Tue, 21 Oct 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXI7Piad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9A334C3B;
	Tue, 21 Oct 2025 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047185; cv=none; b=AX3l9iREQZ+3LA71AcLSWgNgKMps7gwZZowMLJ1tVFs6Jpka+3FWrhs5OfII6ewal1saFBIOL9LQ/iTkaXz+XHz1/b7ek6+OEfurUVgROtVs3jsYQ9waOBICmxSH6p4pMci+GvE8sH3ZTpuAKkrezjfainVG4+Yl24kEEfmKxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047185; c=relaxed/simple;
	bh=H4jWaPD3RLb43DWhIT3tk1IDFLr01dcU/60jks3O+nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m77DLl+rnFNK6i/5yiqzK9l3uXhIvlkkuFHAfSk8A7p+GjKN6B7dnFIOt7JAgGLDp6++T5XxhBK1+lQQYdt6gby2Jm2U0lYAssSPOYfqQr9r1ugd90wxg0CVZqCy4u/wua05EuepsJEoBRTJwbINCBdeifbMQYre7T5sY+6zaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXI7Piad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409A1C4CEF5;
	Tue, 21 Oct 2025 11:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047185;
	bh=H4jWaPD3RLb43DWhIT3tk1IDFLr01dcU/60jks3O+nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gXI7PiadrMkoPHhhut2K7rBcSSSz/LBr8vskKm9bgshZtEiQn3l9TmGeX3YZs2/ke
	 y7jmxxZc7ftLsyUYi7lqxYz82AxI6x3ueytBrTANqwf8SfpQP0mwu9sgqpUExS0hNn
	 of/4JD4u+FxJfk965g1Mg2MOrMjHu85jT4PNs4WIiO3pKeDOQYbA3ih7D9SSV87fes
	 8cXDsmCMTdXKcAKZv0I4q+BmVGxAe2vPfmhmz6rFPKNkyjAciCViHSJ5ydx4+ukJ8k
	 /kxQ3oxmA2NTMM+iRwEcT4Gs0DIEBUVX0nXGZzvUlsrzlHJHyQka7tfE7q7a9Rx2US
	 fA5Gl7n4itOCw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:35 +0200
Subject: [PATCH RFC DRAFT 29/50] selftests/namespaces: eleventh active
 reference count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-29-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5721; i=brauner@kernel.org;
 h=from:subject:message-id; bh=H4jWaPD3RLb43DWhIT3tk1IDFLr01dcU/60jks3O+nc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3zHHRSikcVhUhmhEv2FaXoSj1SW6IcJJUHVXkss0
 +1mzynoKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEjxIkaGZZ2TuFasfigV++fF
 3czbPbc/T3uv6iJnNu/lwaONO32EkxgZFl3JqNMy5WVKO8nhHzRLYoJontyaJU6TO3LiTzWc2KT
 GBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that different namespace types with same owner all contribute
active references to the owning user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 178 +++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 15d001df981c..3c2f99b25067 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -1353,4 +1353,182 @@ TEST(ns_multiple_children_same_parent)
 	}
 }
 
+/*
+ * Test that different namespace types with same owner all contribute
+ * active references to the owning user namespace.
+ */
+TEST(ns_different_types_same_owner)
+{
+	struct file_handle *u_handle, *n_handle, *ut_handle;
+	int ret, pipefd[2];
+	pid_t pid;
+	int status;
+	__u64 u_id, n_id, ut_id;
+	char u_buf[sizeof(*u_handle) + MAX_HANDLE_SZ];
+	char n_buf[sizeof(*n_handle) + MAX_HANDLE_SZ];
+	char ut_buf[sizeof(*ut_handle) + MAX_HANDLE_SZ];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+
+		/* Create user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int u_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (u_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(u_fd, NS_GET_ID, &u_id) < 0) {
+			close(u_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(u_fd);
+
+		/* Create network namespace (owned by user namespace) */
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int n_fd = open("/proc/self/ns/net", O_RDONLY);
+		if (n_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(n_fd, NS_GET_ID, &n_id) < 0) {
+			close(n_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(n_fd);
+
+		/* Create UTS namespace (also owned by user namespace) */
+		if (unshare(CLONE_NEWUTS) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int ut_fd = open("/proc/self/ns/uts", O_RDONLY);
+		if (ut_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(ut_fd, NS_GET_ID, &ut_id) < 0) {
+			close(ut_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(ut_fd);
+
+		/* Send all namespace IDs */
+		write(pipefd[1], &u_id, sizeof(u_id));
+		write(pipefd[1], &n_id, sizeof(n_id));
+		write(pipefd[1], &ut_id, sizeof(ut_id));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	close(pipefd[1]);
+
+	/* Read all three namespace IDs - fixed size, no parsing needed */
+	ret = read(pipefd[0], &u_id, sizeof(u_id));
+	if (ret != sizeof(u_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read user namespace ID");
+	}
+
+	ret = read(pipefd[0], &n_id, sizeof(n_id));
+	if (ret != sizeof(n_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read network namespace ID");
+	}
+
+	ret = read(pipefd[0], &ut_id, sizeof(ut_id));
+	close(pipefd[0]);
+	if (ret != sizeof(ut_id)) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read UTS namespace ID");
+	}
+
+	/* Construct file handles from namespace IDs */
+	u_handle = (struct file_handle *)u_buf;
+	u_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	u_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *u_fh = (struct nsfs_file_handle *)u_handle->f_handle;
+	u_fh->ns_id = u_id;
+	u_fh->ns_type = 0;
+	u_fh->ns_inum = 0;
+
+	n_handle = (struct file_handle *)n_buf;
+	n_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	n_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *n_fh = (struct nsfs_file_handle *)n_handle->f_handle;
+	n_fh->ns_id = n_id;
+	n_fh->ns_type = 0;
+	n_fh->ns_inum = 0;
+
+	ut_handle = (struct file_handle *)ut_buf;
+	ut_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	ut_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *ut_fh = (struct nsfs_file_handle *)ut_handle->f_handle;
+	ut_fh->ns_id = ut_id;
+	ut_fh->ns_type = 0;
+	ut_fh->ns_inum = 0;
+
+	/* Open both non-user namespaces before process exits */
+	int n_fd = open_by_handle_at(FD_NSFS_ROOT, n_handle, O_RDONLY);
+	int ut_fd = open_by_handle_at(FD_NSFS_ROOT, ut_handle, O_RDONLY);
+
+	if (n_fd < 0 || ut_fd < 0) {
+		if (n_fd >= 0) close(n_fd);
+		if (ut_fd >= 0) close(ut_fd);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to open namespaces");
+	}
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) != 0) {
+		close(n_fd);
+		close(ut_fd);
+		SKIP(return, "Child failed");
+	}
+
+	/*
+	 * Both network and UTS namespaces are active.
+	 * User namespace should be active (gets 2 active refs).
+	 */
+	TH_LOG("Both net and uts active - user namespace should be active");
+	int u_fd = open_by_handle_at(FD_NSFS_ROOT, u_handle, O_RDONLY);
+	ASSERT_GE(u_fd, 0);
+	close(u_fd);
+
+	/* Close network namespace - user namespace should STILL be active */
+	TH_LOG("Closing network ns - user ns should still be active (uts still active)");
+	close(n_fd);
+	u_fd = open_by_handle_at(FD_NSFS_ROOT, u_handle, O_RDONLY);
+	ASSERT_GE(u_fd, 0);
+	close(u_fd);
+
+	/* Close UTS namespace - user namespace should become inactive */
+	TH_LOG("Closing uts ns - user ns should become inactive");
+	close(ut_fd);
+	u_fd = open_by_handle_at(FD_NSFS_ROOT, u_handle, O_RDONLY);
+	if (u_fd >= 0) {
+		close(u_fd);
+		TH_LOG("Warning: User namespace still active after all owned namespaces inactive");
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


