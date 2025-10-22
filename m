Return-Path: <linux-fsdevel+bounces-65152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78006BFD2BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78503B1EAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD83F369966;
	Wed, 22 Oct 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO33dQDZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01629992A;
	Wed, 22 Oct 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149294; cv=none; b=UVJ/1GyMtc8lKBih2Ae9MDNGxB3emr1yr+GlWXzDbiYhALH8x5CPuEJVUXW/u+3DO8K215Ggp40cGt8Aru0yy86M/Ekzu4+U0VWAvIwMFy3c1czo7LjMcoTPz1KVGjtw3kyfXUTGIG4K2aWpd5oQpAcy8yeBh4caJWD5VoyVZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149294; c=relaxed/simple;
	bh=Hpp75xec5mwn0pm6bwe74NHV8CGVz16jvWJi/wNRADw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSVmfkJ4i4hRjY9Sd7cAhOPycNZTktTlOCJ7p2S2h7+rZ71OXtjgioGf3ixMPuxtDSIQDVYA+eZzi3Ky2HOH0jZIbIOENKKFUxszcg/KEBF3jYDaDMGBntGIUNjMYmyUXiD3FyFfhB1gcR4PNVT0o+v5t2PFW0tCqApSpelaWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO33dQDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F22C4CEF7;
	Wed, 22 Oct 2025 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149293;
	bh=Hpp75xec5mwn0pm6bwe74NHV8CGVz16jvWJi/wNRADw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rO33dQDZU+D7JZrRA3L8gPCPs07wyQ1JnOM19SbP/zvOomkZgOWGBFf8q0LbtBh2w
	 ZqVwQjsM2jeOcY0xJ57Sn1MHsr/nFAVq/WAZjorR4hsRWXqIz4fUOLwY4GqsKN6URp
	 ZGxVDt9DWHL3zMaI3PnQjAJRAYXMQWpcsKi4Oah4rgaWcfKsIxDkR5pNTgojx2rOQz
	 ZfMeqAcXdh0fLoG6SVwuxOcz7pxW8EMxjuGtZqED7u7zdH6AkBGlkCLLEce7mjCHko
	 /rBQ8BpCmI/P6SVUNv+X4cxkaWDXm5ZJ1TT3bffjsR8vv5QerLWjYPQaC/8IAWQ7c2
	 FLTyZgmXDi1Ig==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:02 +0200
Subject: [PATCH v2 24/63] selftests/namespaces: fifth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-24-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2525; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Hpp75xec5mwn0pm6bwe74NHV8CGVz16jvWJi/wNRADw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHjaEHE8eK7Khu/rE8IPHJu8/1lCT6rLtEmdpg/6N
 M+qvlks2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARTyGGv8I6vJy+l06dXBs7
 Sbe4O2DO3IKwk+mM3m7z0r9EHjUVX83wV9x66yrtX1Xv2DcJXd1iwbH5zc/SRoV4ddbbuw9cMuX
 cxwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test PID namespace active ref tracking

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index b9836693f5ec..66665bd39e9b 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -385,4 +385,92 @@ TEST(userns_active_ref_lifecycle)
 	}
 }
 
+/*
+ * Test PID namespace active ref tracking
+ */
+TEST(pidns_active_ref_lifecycle)
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
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		/* Create new PID namespace */
+		ret = unshare(CLONE_NEWPID);
+		if (ret < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Fork to actually enter the PID namespace */
+		pid_t child = fork();
+		if (child < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (child == 0) {
+			/* Grandchild - in new PID namespace */
+			fd = open("/proc/self/ns/pid", O_RDONLY);
+			if (fd < 0) {
+				exit(1);
+			}
+
+			handle = (struct file_handle *)buf;
+			handle->handle_bytes = MAX_HANDLE_SZ;
+			ret = name_to_handle_at(fd, "", handle, &mount_id, AT_EMPTY_PATH);
+			close(fd);
+
+			if (ret < 0) {
+				exit(1);
+			}
+
+			/* Send handle to grandparent */
+			write(pipefd[1], buf, sizeof(*handle) + handle->handle_bytes);
+			close(pipefd[1]);
+			exit(0);
+		}
+
+		/* Wait for grandchild */
+		waitpid(child, NULL, 0);
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
+	if (ret <= 0) {
+		SKIP(return, "Child failed to create PID namespace or get handle");
+	}
+
+	handle = (struct file_handle *)buf;
+
+	/* Namespace should be inactive after all processes exit */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	if (fd >= 0) {
+		TH_LOG("Warning: PID namespace still active after process exit");
+		close(fd);
+	} else {
+		ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


