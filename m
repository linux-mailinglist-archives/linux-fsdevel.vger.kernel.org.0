Return-Path: <linux-fsdevel+bounces-65183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC304BFD48E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F857568EE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453C38287F;
	Wed, 22 Oct 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTtsET+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18900382865;
	Wed, 22 Oct 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149459; cv=none; b=eXdHnSwRN2LMVRuy5Iq3yyCGOcdhcyU8IPY110DOKj0091wif4Ol/5fWzEzHQt+ZRWTxXmwdQ8HwSFJ9VvXXMAy8z+o8wtX4AFW5EXjKBcC+Vuqso5ORjncFb4jxesxbNSCk3bOMEWSbappDjCTXuT3qEIiM+JC0GPJOijhIWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149459; c=relaxed/simple;
	bh=Gh/yPS1NyhqsBzLO+DmIzxsHN6EXBn9HWj+WnIyz1JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0mQwk0ErjcWfw8NQ3g+Mle8wDhANW/G7SLgleBp4J/3DMtqLhIoebKho9pybp8x19YcgNSVB8TQzYTlIMpKY9lqJ/wkXifoJM8O/gLFRHeRjDzme0VvNEqudFmuvbD/1aEL07wMJlNZIadrO7C8wXjyTuvnQVzBzW2JQRvqYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTtsET+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA2EC4CEE7;
	Wed, 22 Oct 2025 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149458;
	bh=Gh/yPS1NyhqsBzLO+DmIzxsHN6EXBn9HWj+WnIyz1JI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OTtsET+wiMrbHLQTHVyTKNyKffGvyp+8IrYbC4ycd1U7SM2yWIfYM4661F0CJ72ej
	 ev05/DU7TlZrq170dY9mvbo5SGjKNvgy9cRAiGquMc4OC6f4lXNpcrpYbPqz3WQPco
	 AiH0QkQnHtqj9KdJAyavmxWR+ZmAkP/DKciXvwwk0pdYWvqgAFjS955a4THbTQ0A3k
	 PX68bKFwmhvjxZ857SWzYwpgXgBFi1vR4d39U1aJmTXOp+yUc/777Iyu4dukXlSDIJ
	 meXFrhD9vn8e9U0rYJbwB8P6HjGBFnD2oshYOc06Qv5MO03flZDZ4MdJSfp3ZoDGOg
	 6sk8jXnKouHlw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:33 +0200
Subject: [PATCH v2 55/63] selftests/namespaces: fourth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-55-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Gh/yPS1NyhqsBzLO+DmIzxsHN6EXBn9HWj+WnIyz1JI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHi+j/eNPTfPjyVnEvgPaxU/Xz773fP1fqXJp+fec
 +J7d3F+a0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBELn9m+J9U+ME6julV8G3J
 pPmm5/TL5svMTy4pLf63UntPzuvDCZKMDBNfvp20UyDjVTzfT7ET6qdCz2rrPE9dNee5lYjJn3l
 vy9kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test SIOCGSKNS across setns. Create a socket in netns A, switch to netns
B, verify SIOCGSKNS still returns netns A.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 3f46ac0c96df..3aed6e3d60a3 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -257,4 +257,55 @@ TEST(siocgskns_socket_types)
 	close(sock_udp);
 }
 
+/*
+ * Test SIOCGSKNS across setns.
+ * Create a socket in netns A, switch to netns B, verify SIOCGSKNS still
+ * returns netns A.
+ */
+TEST(siocgskns_across_setns)
+{
+	int sock_fd, netns_a_fd, netns_b_fd, result_fd;
+	struct stat st_a;
+
+	/* Get current netns (A) */
+	netns_a_fd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(netns_a_fd, 0);
+	ASSERT_EQ(fstat(netns_a_fd, &st_a), 0);
+
+	/* Create socket in netns A */
+	sock_fd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(sock_fd, 0);
+
+	/* Create new netns (B) */
+	ASSERT_EQ(unshare(CLONE_NEWNET), 0);
+
+	netns_b_fd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(netns_b_fd, 0);
+
+	/* Get netns from socket created in A */
+	result_fd = ioctl(sock_fd, SIOCGSKNS);
+	if (result_fd < 0) {
+		close(sock_fd);
+		setns(netns_a_fd, CLONE_NEWNET);
+		close(netns_a_fd);
+		close(netns_b_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(result_fd, 0);
+	}
+
+	/* Verify it still points to netns A */
+	struct stat st_result_stat;
+	ASSERT_EQ(fstat(result_fd, &st_result_stat), 0);
+	ASSERT_EQ(st_a.st_ino, st_result_stat.st_ino);
+
+	close(result_fd);
+	close(sock_fd);
+	close(netns_b_fd);
+
+	/* Restore original netns */
+	ASSERT_EQ(setns(netns_a_fd, CLONE_NEWNET), 0);
+	close(netns_a_fd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


