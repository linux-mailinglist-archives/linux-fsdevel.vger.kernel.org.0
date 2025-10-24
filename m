Return-Path: <linux-fsdevel+bounces-65497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B462EC05ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644543BB99F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1378316902;
	Fri, 24 Oct 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz9HEOvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD231282A;
	Fri, 24 Oct 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303500; cv=none; b=oI0EQFcK557esJguw+1mRKoFB7Jbifnv0WLOsM3z6oHFdoWw3LeAbTCHNTmy5qqxjmGpwQI8hIXZLVpoHp1emcajGYTuGHoOEsMFixgnFmu06qULKd96xsqAbGMbm9nzPbw9qf0VVOgKb/Nf7Dw69Kk9x6FaQNIOT8hOGDYEk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303500; c=relaxed/simple;
	bh=KWYYGboDUt3swjKDxkebVx+xZOw67uWV/kh+IrzwFAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUR1gCveV4ADEg7DQE01Q9niem8rqj+c1B/MKVxTKRZV+CHwP25fiSQxNsjaGFh3wsr3l8lO+0npePO9q3EufioJPgL5TizUzbVXZiFNLa1CUYYyCoxXxbfvxgCUl3Q8VITD9U26euBskMcxxugv6izrDWpSTvl+MyhI7cxVfpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz9HEOvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3B8C4CEF5;
	Fri, 24 Oct 2025 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303499;
	bh=KWYYGboDUt3swjKDxkebVx+xZOw67uWV/kh+IrzwFAE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gz9HEOvNP4UjtLrocwrPt8BN+4wwQQT6254IgZSkahkgx0QcMzIYlodjNjs6bwGeS
	 4Y7r/PuS68T1GBPy7lpJxbRiTOxHcOW0EYKiO0fmFnObCOa8klxU74GSAP8TzbulTT
	 Y3SLgEmd8YUWgyP1xer8xhd8/3LOVKJ1Jq2EVNBkYNvVLZrdAX8fKQFx1cYkXQBJVH
	 DDTmDbHwoibJ2WbS1mpH+ghMXP5N1sSEUsMmRzYuH2tcv1Nd4hIdDx5FHxwllyf9/u
	 8mGx77clhg7Ezfzzp3eY2RDOKwiUsL4M6JDM2FOdcBtLNt4LZGmm86BDXTMIKqKs+7
	 TlmMZfIn9Cq1Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:26 +0200
Subject: [PATCH v3 57/70] selftests/namespaces: fifth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-57-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KWYYGboDUt3swjKDxkebVx+xZOw67uWV/kh+IrzwFAE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmo3X8M4RWJr04KuI0uW7t9zapLQ4bWsfX4lH8MFD
 y22rmPy7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIyDGGP5wa2U26v6S3Ono8
 4rAxfRF/sKKspPD0PStBlUOK+v8sXjH8lTfg2Lfq/v5jPrMu9qjumzPjcNOUxRnFPTN7so6s73y
 /hBcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test SIOCGSKNS fails on non-socket file descriptors.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 28e45954c4fa..bbfef3c51ac1 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -307,4 +307,30 @@ TEST(siocgskns_across_setns)
 	close(netns_a_fd);
 }
 
+/*
+ * Test SIOCGSKNS fails on non-socket file descriptors.
+ */
+TEST(siocgskns_non_socket)
+{
+	int fd;
+	int pipefd[2];
+
+	/* Test on regular file */
+	fd = open("/dev/null", O_RDONLY);
+	ASSERT_GE(fd, 0);
+
+	ASSERT_LT(ioctl(fd, SIOCGSKNS), 0);
+	ASSERT_TRUE(errno == ENOTTY || errno == EINVAL);
+	close(fd);
+
+	/* Test on pipe */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	ASSERT_LT(ioctl(pipefd[0], SIOCGSKNS), 0);
+	ASSERT_TRUE(errno == ENOTTY || errno == EINVAL);
+
+	close(pipefd[0]);
+	close(pipefd[1]);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


