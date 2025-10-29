Return-Path: <linux-fsdevel+bounces-66272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8827DC1A693
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744E1587877
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E534F492;
	Wed, 29 Oct 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVaWB+9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75AD33F388;
	Wed, 29 Oct 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740737; cv=none; b=LEPS+yKvG7SCSg63A1bnn5MY1FSF9Md2hoSvDaXB0uJfLjyQi4/UXWGT4ztaU1OB0qZrqJjJCAdUjINCXw7pHGLVV6YHK5sKoNh712fT6LhK3pllbDFNIs5vPeJQ7WtrrEmCY6rtf7sCC1Cwauokk440LItWNmyCNp7fmuPFLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740737; c=relaxed/simple;
	bh=KWYYGboDUt3swjKDxkebVx+xZOw67uWV/kh+IrzwFAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijfSe8vQtUjoQoNl6ren5XPmGxOSEg5Db3mmnJwz9qes386FQlc1w80IY0AeOIxbXuES/wQkh/yVSqiAzOXOJVeZCFlb76dRmB8IUEa7gEw5WcnDyEF6PPiyw+jS7+anLwXiVBNn9GmCX7kKawu/RWxuKnXq61FJ429gTsHN9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVaWB+9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA9DC4CEF7;
	Wed, 29 Oct 2025 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740737;
	bh=KWYYGboDUt3swjKDxkebVx+xZOw67uWV/kh+IrzwFAE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AVaWB+9lgEiya89wxq9QmoGHXnKfVa+Etod4Hrej3a5f2Eg6FStTI1xbIgXRFA9zC
	 PI4r41FIV9BASaM+eRPN8NZw4Up9UJl79JByB5Hs0gKRpfk4WShrDkQ7f6w6HLldKO
	 FmQdbt7uVt95/SJHqCkTIrk4ZraDzXhZFYgVIU8MsZJLlY5ThfNPg71Q/BmJKtVah8
	 DzgBL3es4Es58K/yWJRDK1FLJekz6STMgszsauBgsveIVIXQyBqeFJ12VHqP5yv4az
	 kiB3GKQAnhG9N3Pvyc03IS0J143ZuH37Py6BG3f5udqUHtbsDbs2vFPw/2ejS/2k0s
	 hXQUrDuJa1Icw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:12 +0100
Subject: [PATCH v4 59/72] selftests/namespaces: fifth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-59-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KWYYGboDUt3swjKDxkebVx+xZOw67uWV/kh+IrzwFAE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfW/VN/m4BTSM/f00QkLPtR9/Rzjo2cSfWd9s3HFI
 t8FcdbTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSz8rIsMFt9a8jxyUuv87Y
 Gv3kU8nz3S9Zk++df8F0tluwXY9v5j6Gf2ZGLJtVuwxu+j79X3MnQ4cl5vFLrvKQoopO56fmX9t
 EmAE=
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


