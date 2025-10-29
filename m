Return-Path: <linux-fsdevel+bounces-66244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA72C1A474
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B05518948C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641D836A5F3;
	Wed, 29 Oct 2025 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbHebF0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06D735BDD9;
	Wed, 29 Oct 2025 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740596; cv=none; b=MJe2YDZUevMOFVsV1oq41ATIhKscTj6z6eNxLpjF2NVrHe/9oH60czd3CKDjhUZF310l9nFnLijuGQZwegxTGd1BpcJpXwNEtGVswDYwNKQhBVsF800ZjnfVS5KUf4OGSHkUykVPYf3IgY0Ih+Q85tL92StD0IO/NT4Rtn4yRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740596; c=relaxed/simple;
	bh=15Kss0/E0G/yMSjq65yfXbMGd9pstwgOgfvTnyiPCqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnkzcIrG6H+SU9+My8DXXNUg4oAWLQ3Vqya4V850R/R8DXQ3rR8WNVXOOBjfKimpQ7DPA9ucoB20041QuOY9oaB7glPqkI02yi8986FEuRZxl0kEeDZlTGYvio6LHdJS8G/+yHCj7eCwzUTt48qkEkdOqbUgMyQj/3rfT7IoQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbHebF0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89688C4CEFF;
	Wed, 29 Oct 2025 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740596;
	bh=15Kss0/E0G/yMSjq65yfXbMGd9pstwgOgfvTnyiPCqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IbHebF0UFdNEZTtSD4Gt6VcVwUlvU9ulSfjP/NL0q4+kY6REkANBWUVx0/Km8AD2V
	 sR1tcxR3PeZxnse+r2QMFnrO/13dR6zuD087mvaYy811XlRczvZwKI6D0kPt/kLcG/
	 HxWuLy1WG/f+23ANF8A66t0TwlEcSPzhZ70wnFz5i06X09gph1FVkhgxe38SgHmcWX
	 NCcO1zMm/S2o6/HdnhWRRrEW6fYDMfGIdn/d3M7spDUhIx5Vv1D3i7Cgl8eHhTD1OW
	 wcKUoyHKw+3MpY03LH4fL5gKObL4gDNFfZoL01TWX33aue/rkYQMumuY+uS+9Gk3Xi
	 fXOK3vTs0FBSw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:44 +0100
Subject: [PATCH v4 31/72] selftests/namespaces: ninth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-31-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5204; i=brauner@kernel.org;
 h=from:subject:message-id; bh=15Kss0/E0G/yMSjq65yfXbMGd9pstwgOgfvTnyiPCqg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfUqz160PblIpGGV0dZHJ3U0l92/pH74zqxNsizH1
 vGt29yq0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRueWMDLsUJVxsUkU+7uK0
 K36gLaL+5RPDitXTm+cfdbgkkvB6vQrDf8eQoKsN1Ysuz8rcWP7hS0oF41eF2fvnyCqtPcAoznU
 +gwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test multi-level hierarchy (3+ levels deep).
Grandparent → Parent → Child
When child is active, both parent AND grandparent should be active.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 164 +++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 55a741d32b08..88189398aa35 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -942,4 +942,168 @@ TEST(ns_bind_mount_keeps_in_tree)
 	unlink(tmpfile);
 }
 
+/*
+ * Test multi-level hierarchy (3+ levels deep).
+ * Grandparent → Parent → Child
+ * When child is active, both parent AND grandparent should be active.
+ */
+TEST(ns_multilevel_hierarchy)
+{
+	struct file_handle *gp_handle, *p_handle, *c_handle;
+	int ret, pipefd[2];
+	pid_t pid;
+	int status;
+	__u64 gp_id, p_id, c_id;
+	char gp_buf[sizeof(*gp_handle) + MAX_HANDLE_SZ];
+	char p_buf[sizeof(*p_handle) + MAX_HANDLE_SZ];
+	char c_buf[sizeof(*c_handle) + MAX_HANDLE_SZ];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+
+		/* Create grandparent user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int gp_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (gp_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(gp_fd, NS_GET_ID, &gp_id) < 0) {
+			close(gp_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(gp_fd);
+
+		/* Create parent user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int p_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (p_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(p_fd, NS_GET_ID, &p_id) < 0) {
+			close(p_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(p_fd);
+
+		/* Create child user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int c_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (c_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(c_fd, NS_GET_ID, &c_id) < 0) {
+			close(c_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(c_fd);
+
+		/* Send all three namespace IDs */
+		write(pipefd[1], &gp_id, sizeof(gp_id));
+		write(pipefd[1], &p_id, sizeof(p_id));
+		write(pipefd[1], &c_id, sizeof(c_id));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	close(pipefd[1]);
+
+	/* Read all three namespace IDs - fixed size, no parsing needed */
+	ret = read(pipefd[0], &gp_id, sizeof(gp_id));
+	if (ret != sizeof(gp_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read grandparent namespace ID from child");
+	}
+
+	ret = read(pipefd[0], &p_id, sizeof(p_id));
+	if (ret != sizeof(p_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read parent namespace ID from child");
+	}
+
+	ret = read(pipefd[0], &c_id, sizeof(c_id));
+	close(pipefd[0]);
+	if (ret != sizeof(c_id)) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read child namespace ID from child");
+	}
+
+	/* Construct file handles from namespace IDs */
+	gp_handle = (struct file_handle *)gp_buf;
+	gp_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	gp_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *gp_fh = (struct nsfs_file_handle *)gp_handle->f_handle;
+	gp_fh->ns_id = gp_id;
+	gp_fh->ns_type = 0;
+	gp_fh->ns_inum = 0;
+
+	p_handle = (struct file_handle *)p_buf;
+	p_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	p_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *p_fh = (struct nsfs_file_handle *)p_handle->f_handle;
+	p_fh->ns_id = p_id;
+	p_fh->ns_type = 0;
+	p_fh->ns_inum = 0;
+
+	c_handle = (struct file_handle *)c_buf;
+	c_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	c_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *c_fh = (struct nsfs_file_handle *)c_handle->f_handle;
+	c_fh->ns_id = c_id;
+	c_fh->ns_type = 0;
+	c_fh->ns_inum = 0;
+
+	/* Open child before process exits */
+	int c_fd = open_by_handle_at(FD_NSFS_ROOT, c_handle, O_RDONLY);
+	if (c_fd < 0) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to open child namespace");
+	}
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/*
+	 * With 3-level hierarchy and child active:
+	 * - Child is active (we hold fd)
+	 * - Parent should be active (propagated from child)
+	 * - Grandparent should be active (propagated from parent)
+	 */
+	TH_LOG("Testing parent active when child is active");
+	int p_fd = open_by_handle_at(FD_NSFS_ROOT, p_handle, O_RDONLY);
+	ASSERT_GE(p_fd, 0);
+
+	TH_LOG("Testing grandparent active when child is active");
+	int gp_fd = open_by_handle_at(FD_NSFS_ROOT, gp_handle, O_RDONLY);
+	ASSERT_GE(gp_fd, 0);
+
+	close(c_fd);
+	close(p_fd);
+	close(gp_fd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


