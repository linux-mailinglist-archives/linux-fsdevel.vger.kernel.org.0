Return-Path: <linux-fsdevel+bounces-66240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD4C1A4AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62349580DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63235A120;
	Wed, 29 Oct 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcTr1YOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248CC283124;
	Wed, 29 Oct 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740576; cv=none; b=s75F9MXVGiCLB+L68dntyFHW/SiHPV3YE2q+tQ42FAM62ZbuJnB2TWx4m02PVDZVTk83TJzXIgx9w5L8Qb0hFzO2iGZDN1w9ibcJR55n5dmzMiAexflOR8I2OEYP1qex+999ON1nAOlY7abMc0+06DFeisZNzRg9fL5DLpJUmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740576; c=relaxed/simple;
	bh=9GvGWgJa/IpvNzb6FhYrFg2g1xbeoNS/+Dh15oRdkuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfpcY8lP+2njJpY3J45AqcKVCu6s2eUwOGvyAvl9eZ3n9Ljv85jUHECl92iA3F5q0QNUXEh0OYcA2EiDNG6C34rDlgeWMcCL1XE3hCTGBkxO3S9FGHJ59Sdq6VmimZOrq8rvOU8OtHnBPhsDNr7xJQYlHbkyY3HIRb80bjiXst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcTr1YOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00362C4CEFD;
	Wed, 29 Oct 2025 12:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740575;
	bh=9GvGWgJa/IpvNzb6FhYrFg2g1xbeoNS/+Dh15oRdkuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KcTr1YOJeFBS7wVRIDRzzut5Bb3GTA0vh7YIWTEcMGonTOgOgNWfyILHOX7q6TmAc
	 jzF70xcKFeRw2rmAdgQMJDjcJ5f0tOwQUIbYu+olvMonx053ka94OoYIgopN5YM/cI
	 IZ86UxvY3aSCZTMbZtAkjcIcjoUFyUZDmYv1uLj6p2A17iChMUDgQmJz01/RnCLlqf
	 XxZFBCvtWGzSMYdJejevswgb5M2uO+sWSoV12HTFk71jD3GwfXtvZiNVfOSeNt5TQm
	 bZS2WT98YT8gWl6JZD+S+rxq0JOQxtGJPs2Rq0AiX/yNmw09w//eJETCEjwwgL+Z3K
	 OphDjvAEaCVGA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:40 +0100
Subject: [PATCH v4 27/72] selftests/namespaces: fifth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-27-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9GvGWgJa/IpvNzb6FhYrFg2g1xbeoNS/+Dh15oRdkuU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfUW/O7h4E7OnRoqzPnd/fEfQ/8Pdzdf/Pvug7GDo
 sN3ps1fOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyTYeR4YUlR3dmuXB8z4f1
 c04Umisl/w62YBJe4PrI2LrAefqLbIb/NQdNfomsPr8v4eaG+uwnxRdsttruKnL1NOab5T8vdl8
 JCwA=
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


