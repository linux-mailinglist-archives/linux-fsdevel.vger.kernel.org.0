Return-Path: <linux-fsdevel+bounces-65491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A45C05E7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 363D750819A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13D357726;
	Fri, 24 Oct 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSJq/EQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8A35770C;
	Fri, 24 Oct 2025 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303439; cv=none; b=L5nUk4JN2lAQXG1WBYLjw2V8jGESzoXavuI2YKr3IbrD3oRldrognY9Q6ulru9nCYOViKcYpREn+VE8zFOfZrGKO0wbh+3CsuuDhPFG8ViTAPsHyA19GDGBU9nwpM4bGqFdymGKAE6tbzfx2JgwvC8SNgYyAVYZK3zb5BMio7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303439; c=relaxed/simple;
	bh=jlxGmvG3TRBGBU95oespXIKDq7FaoNyvL6StJ8L+zuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c9mLpfSeBizT5DrBH6k0VElfFTqOF6WkKkPKHgyo62F6q56ke/8YSrQ++qTrnFd9hDjkfUyvOVtjLxrYE4E+GhLbM8ZPkSvBmAa2gh7MA1+a2hsfMZzbpZ74tuI9h4nt0i4BloQtQ056FsOMEwqYZEpHP5wJp/00M2pIjCyNj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSJq/EQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83647C4CEF1;
	Fri, 24 Oct 2025 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303439;
	bh=jlxGmvG3TRBGBU95oespXIKDq7FaoNyvL6StJ8L+zuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bSJq/EQ9DjhEx3MRYq3pOGAC6ltXmTCFdPlaUN28UNpASiS28VRMD849WGQ977mvp
	 s7afflNINQY3HswiChPKwFjEby9ZOgDfGz27YCjtBA4/UD33ZKvOpEGDMpwHXUW0e/
	 cHpBE5q+O0c5OpCCkwjyzJiAH4Ajrlo+3oheQ0rTr9+NFltT3RpH+S9s9NuMEjaF/6
	 rFXffrs1PQBOxssIJ5isXyA3lkPbC739yDvQd7qJ07jrSod5103cXTBT9FxI3Zbc+R
	 Yt/5XyNETikpNDQh8PaqNkd2eLqr37K+1C11cNSklHfHWtwP8ERSmQLPT7IifYWe5v
	 tMqxt5W7eapGw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:20 +0200
Subject: [PATCH v3 51/70] selftests/namespaces: sixth listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-51-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jlxGmvG3TRBGBU95oespXIKDq7FaoNyvL6StJ8L+zuI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmqf99BFtPul0/WsYMfJz8/+XK8yo+LPZrEDTUdcq
 rqm7kh37yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIYi8jw7IJrJvlqu7qRa/4
 GPT/Wl55Tlv2TNV9VqrLSvSmOlSKxjIyTEl4IGiZJVSd+viOfVZ2TtLv6qvP9wqW87uf+rz486a
 PbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that we can see user namespaces we have CAP_SYS_ADMIN inside of.
This is different from seeing namespaces owned by a user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index b990b785dd7f..9aa06ff76333 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -561,4 +561,91 @@ TEST(listns_parent_userns_cap_sys_admin)
 			count);
 }
 
+/*
+ * Test that we can see user namespaces we have CAP_SYS_ADMIN inside of.
+ * This is different from seeing namespaces owned by a user namespace.
+ */
+TEST(listns_cap_sys_admin_inside_userns)
+{
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	bool found_ours;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		__u64 our_userns_id;
+		struct ns_id_req req;
+		__u64 ns_ids[100];
+		ssize_t ret;
+		bool found_ours;
+
+		close(pipefd[0]);
+
+		/* Create user namespace - we have CAP_SYS_ADMIN inside it */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get our user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &our_userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* List all user namespaces globally */
+		req.size = sizeof(req);
+		req.spare = 0;
+		req.ns_id = 0;
+		req.ns_type = CLONE_NEWUSER;
+		req.spare2 = 0;
+		req.user_ns_id = 0;
+
+		ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+
+		/* We should be able to see our own user namespace */
+		found_ours = false;
+		if (ret > 0) {
+			for (ssize_t i = 0; i < ret; i++) {
+				if (ns_ids[i] == our_userns_id) {
+					found_ours = true;
+					break;
+				}
+			}
+		}
+
+		write(pipefd[1], &found_ours, sizeof(found_ours));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+
+	found_ours = false;
+	read(pipefd[0], &found_ours, sizeof(found_ours));
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_TRUE(found_ours);
+	TH_LOG("Process can see user namespace it has CAP_SYS_ADMIN inside of");
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


