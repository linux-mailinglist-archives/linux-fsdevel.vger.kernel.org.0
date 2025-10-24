Return-Path: <linux-fsdevel+bounces-65465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A9C05C86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BA33B72C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7E33439B;
	Fri, 24 Oct 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayxzcpm7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212C332EC8;
	Fri, 24 Oct 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303308; cv=none; b=LelOAjx9FQmMDKOMPUakgRG+nXXtBt2zcsSm1J55y56PqHn9NDE1giqJSUAxrrpdnDSvHwtoKE79VHpuDi0G6kGH/4ZlWsaOiFtlNR1N+dieHxZ8oK9UW+IgSVBCJuEB3XZ3bPr9EJWrwgEYZOdQdRxsWCrL2zCD+t6OGLm6Ctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303308; c=relaxed/simple;
	bh=9GvGWgJa/IpvNzb6FhYrFg2g1xbeoNS/+Dh15oRdkuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iu7t0veP01K3530L6ecBLVggN8d6GPMgAsSnmTgp15+Jc7O3kUyO/ZXwWGpXK7m+4mHNZOdSanM3FBfMv4vrpHp9loKUtk0uz6nhiwzB8XNToCrj1iZYuoICQTlEDJgdLSWtOwptt2xaYfd4i/Nns+ChxNqGhjlWYaWNyLwHUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayxzcpm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528E8C4CEF5;
	Fri, 24 Oct 2025 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303307;
	bh=9GvGWgJa/IpvNzb6FhYrFg2g1xbeoNS/+Dh15oRdkuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ayxzcpm7Wc6z+pnimAVbPi0ui32yxRSOK9cv0nkCK78kwX9ZC4GhuVQDag/1aaBk5
	 KY/aaLW3JxUqxyUP+2rtloEuRp/8PZiXjf5M5qMJK4x1R2pKddh7lxbo+OpR7yfHGq
	 0JbWuMdM+Zwlht7+ldWjbFcTsc1BDM8CAly92iUMD1P/REg+WYFhhCM+CC72nGr+0v
	 pIftxMPElRJM4f7C8wr52GZmHnjRHmfLcJJPPiiMNXNc1+zV9qJKIvfFG2mT+OJO7I
	 8vC4u9NMlJdpXe0/a3yaO9erKQZNEQmCDjBslyuN3S5lyJGIzIaFdbbCM/mTuCi8dT
	 hnxnww1OA3ylA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:54 +0200
Subject: [PATCH v3 25/70] selftests/namespaces: fifth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-25-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9GvGWgJa/IpvNzb6FhYrFg2g1xbeoNS/+Dh15oRdkuU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmqt331aVyFv/7PzW1qarq4I7DH0TjdP2fjOzzF6M
 /PFhcJcHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZvZmR4cOss3MdxQ70TnC/
 5uxsed5sVnK+UI/u+fSYnQx16+fVljMyzPL38QkrKduntmobQ8fS1rsp1fmCzb9aj1hHSnwLuXW
 KFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test PID namespace active ref tracking

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 396066e641da..f4e92b772f70 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -366,4 +366,86 @@ TEST(userns_active_ref_lifecycle)
 	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
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
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_GT(ret, 0);
+	handle = (struct file_handle *)buf;
+
+	/* Namespace should be inactive after all processes exit */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_LT(fd, 0);
+	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


