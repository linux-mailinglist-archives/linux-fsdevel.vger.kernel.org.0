Return-Path: <linux-fsdevel+bounces-64874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D2BF633A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C24418C65BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5FC341AA7;
	Tue, 21 Oct 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CePo0S6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862B33373E;
	Tue, 21 Oct 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047153; cv=none; b=nCP2PXbwstSP1jmZLt/6c4AbMg9HrK7Irnb1iytMkRoCSV7mqFgBwDtHJhcDwfhlL/qYNeAAa+23m8Ck1cmZXJwqa7JoTgWtb7lK16T6RM9GTs/nu9zu1ftlxVu2L6KxSeO/G52fQGg49rZ5Xk8CYo6LIilELF2FuDfbHqcb1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047153; c=relaxed/simple;
	bh=Hpp75xec5mwn0pm6bwe74NHV8CGVz16jvWJi/wNRADw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G8liSgc1lKoGoxtnlq+f++SAMRdCB33GfRjjRvkhNnPCPxcyY9XOAUHOgnAIGHgrhEN+28hMUpa8lGVu/0YCDWTTG4mh062//5GwDOaq4MwnbJ73gNARExGRVlvpv0mp0WC4TTAWryB35+SRsVWk67r7ms/s7M+N46pZPtO5cWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CePo0S6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A8EC4CEFF;
	Tue, 21 Oct 2025 11:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047153;
	bh=Hpp75xec5mwn0pm6bwe74NHV8CGVz16jvWJi/wNRADw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CePo0S6JZfKaro9at7USO6yQYm4UCaRUk+KUzAbSZOOc/VCY08NTdgjgx+sN0sNBI
	 YHk3DjGwidbY6XHQ6qhAHvDfqWR++gWSY1sGFYYEdeGSZqIyNchh+dDOshd5ZRWzX6
	 7Du43RTSHXYyHsjTy0j7y1o8qVZgX36RWTwgK8UQHc0KzoDq+gFm9Uh0SR3CvC+ixp
	 IWEdzV9nX94EGLreEMPuJ/h4T6B8cSRlqTBpcH5+ogNflDhc4VqkEqzKMBf06+zfCk
	 rZzO3jqO9O0/BS27rc0gu4toZXYzrv4UKaHZvGHhAt8qsXnQurP3sKbarbN1fWV2J3
	 wB52OOJC4+/+A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:29 +0200
Subject: [PATCH RFC DRAFT 23/50] selftests/namespaces: fifth active
 reference count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-23-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2525; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Hpp75xec5mwn0pm6bwe74NHV8CGVz16jvWJi/wNRADw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3z7d2Ynu9ln7doXJ1WvvzQMUAwxOtc1jeexr3bJt
 d4Zy4LudZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk8x9GhqvH3zF+2jjrvlTV
 6he7FO4uv7aXY53mrSLjW69azzk+2xLEyLDgDeec+x0b/zp/z6goaFu6XLwgd4vsnsdndz7hkDM
 9P50BAA==
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


