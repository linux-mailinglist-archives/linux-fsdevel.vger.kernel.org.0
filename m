Return-Path: <linux-fsdevel+bounces-65464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DD8C05C68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AC73B9B78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0302D330B14;
	Fri, 24 Oct 2025 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuNYvFMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E2D32E754;
	Fri, 24 Oct 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303305; cv=none; b=iu1gTZD//UUJ1Vke2v7wg5yMpmKgt6c2byar0Ipz9mLbUwzoMoii2blFu94no7QyxdqIgTD3eff+8vx2sSnByb9fpGQPvW+Yw3147BvC+etVan7WLjfCrZSdjaulMulPSzOdIwF/t6MFKjpZjmBy/rDiKUflhfTZ+56C5fsS4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303305; c=relaxed/simple;
	bh=e8EI0iOiQx8fHK9+00tBtoOgGlNpcvVChJMa2f3XulI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDWg/56xG1qJmkReZHQVZgFySeuMyt1ig7h8Yr33+35Yszf3RjovvTY3D5Lo/okYNC0nCtK+fWyXhKusyfp7VfWT1NeW1IFm1+sI35YhfjJtewUTdI3v+8xjy/GTHVSABlkKq9GYgI1krWIzZBNqptGrkUPEl5Ar3S7r1qykFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuNYvFMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDEAC4CEF1;
	Fri, 24 Oct 2025 10:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303302;
	bh=e8EI0iOiQx8fHK9+00tBtoOgGlNpcvVChJMa2f3XulI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GuNYvFMMrJM8GbW/at+LnYDJ7urdsLsMZO7sPszrT6Bxquoh0A/ncnRHOuZhgYQRh
	 70pmzizJDAR9PFzWvhPgKfDTUuLs5J8zL0p5RF1axQeOfh6DZypX5Vki0GnsYhnvuY
	 yxCz9xyfNAyL47VwzOoUcQYbMRZFhRUIpYw082Mz9H992r/ST+9WhJDJpRRVFlnWuX
	 i+Mhq5um5r9R/6dN77RNfiqozBsTBUk9GdEe7kpvBNHnAdr4N1tFD4F9RNSJPlxrY6
	 u+SEOC6j9TNxWScleJaHtPWHrBUL6MUrNGv+XTogsZl25n2u8iTj2dcu0fA7Xt2FrZ
	 VZJMTdl/hXjhw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:53 +0200
Subject: [PATCH v3 24/70] selftests/namespaces: fourth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-24-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2891; i=brauner@kernel.org;
 h=from:subject:message-id; bh=e8EI0iOiQx8fHK9+00tBtoOgGlNpcvVChJMa2f3XulI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmpV+1v3a07+otvqu9YG9z53bpXmPqN86yP34ePdC
 yKkwy7O7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIph0M/yyN4/5MiODp2Lnn
 96I09bYnH3UvLV5UP+ugRcbHAt5VjlsZGZZZdjk5CX0/danxcP/f2RlH5//MO7j5XLHouuuWxf+
 6trICAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test user namespace active ref tracking via credential lifecycle.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index c2e34de7a3a9..396066e641da 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -276,4 +276,94 @@ TEST(ns_active_with_multiple_processes)
 	ASSERT_TRUE(WIFEXITED(status));
 }
 
+/*
+ * Test user namespace active ref tracking via credential lifecycle
+ */
+TEST(userns_active_ref_lifecycle)
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
+		/* Create new user namespace */
+		ret = unshare(CLONE_NEWUSER);
+		if (ret < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Set up uid/gid mappings */
+		int uid_map_fd = open("/proc/self/uid_map", O_WRONLY);
+		int gid_map_fd = open("/proc/self/gid_map", O_WRONLY);
+		int setgroups_fd = open("/proc/self/setgroups", O_WRONLY);
+
+		if (uid_map_fd >= 0 && gid_map_fd >= 0 && setgroups_fd >= 0) {
+			write(setgroups_fd, "deny", 4);
+			close(setgroups_fd);
+
+			char mapping[64];
+			snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
+			write(uid_map_fd, mapping, strlen(mapping));
+			close(uid_map_fd);
+
+			snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
+			write(gid_map_fd, mapping, strlen(mapping));
+			close(gid_map_fd);
+		}
+
+		/* Get file handle */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
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
+			exit(1);
+		}
+
+		/* Send handle to parent */
+		write(pipefd[1], buf, sizeof(*handle) + handle->handle_bytes);
+		close(pipefd[1]);
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
+	/* Namespace should be inactive after all tasks exit */
+	fd = open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
+	ASSERT_LT(fd, 0);
+	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


