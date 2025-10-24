Return-Path: <linux-fsdevel+bounces-65495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0394C05E4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF5A1C25B2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D83590DB;
	Fri, 24 Oct 2025 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G44AQ0rv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7473590B4;
	Fri, 24 Oct 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303459; cv=none; b=RpGMEqgvsg+UmnFdj/AMLvG7NjdsViIZbgjFVfWP+tqpPk3DSDkcD8AtnNhFXDza1NpahSm7DnOHa/ZEAi2hAf49Q1G8kuoaP//04Lo8nf3LyVkI/VTsdiF0GY0Kn7DkAit0dxyU/XXkzyHR82mf4IHsw5Y5Xx3RWlAmx+kq9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303459; c=relaxed/simple;
	bh=Jefh0E5wrR69nQhrRe8vhHFWAuKaAVI3adTXCV7rO88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P5Z3GfmG6yDpSJpYydjJjPz3eZxTdD4WKkA0UNTpVWBeWOxuXV8IhK5iuly3wrX5YK1Px8JSmfj/HateyXdSIBQPLAKVt47V2b38nKR+IUhiRLtpie77MhZH+ytMiKKaVR6HnDFEsawWDmjHtPGz9Rn8huncQ7pZnTAtRSgQY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G44AQ0rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9918C4CEF1;
	Fri, 24 Oct 2025 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303459;
	bh=Jefh0E5wrR69nQhrRe8vhHFWAuKaAVI3adTXCV7rO88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G44AQ0rvIRzBP+W6LESmvu3KMQo/1PVUQOZb99S29fFu7dnfDvrpbNnvI2Q5ywGlZ
	 Vu4MUqTwZ5BR0ye/iWdyu21Og/5oe7upd46WoSbNSUANmNF/yl0xbb1co96KYk6CDo
	 mR17NBQqNMv3MY+CUJTkfM+KJVn4FZNzhpuql18e9dLN7a+5Ua+g7gjtyk3q+m3rE2
	 16PIWX1Px3tl0RxoVYKxYTaAzQWtZW8jIHWb13q38Ebg6LCjhRpxr8tqWmrBiwGKgo
	 DqnzHM06GXlWo7YC25IWkZ1Ub8YSa4o6PvGHZxZBjJIgWT/WI1rW9AmQiwL7A8pH1c
	 V1x8fjTiFul5A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:24 +0200
Subject: [PATCH v3 55/70] selftests/namespaces: third inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-55-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2704; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Jefh0E5wrR69nQhrRe8vhHFWAuKaAVI3adTXCV7rO88=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmrfU2Cd+na9HytbkErTxMp7+2/697u/c9o6T2j9Y
 193+b43HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZ0cfIcOHPXPV0lUCv+YqW
 aXsNEmyTKoK+lvoldC/viSk8q1Zgx/C/XOum++fkZ9+uaMr+k/d4enivjvPaTkfVmFMWjUsehp3
 hBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test SIOCGSKNS with different socket types (TCP, UDP, RAW).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 65 +++++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 0ad5e39b7e16..02798e59fc11 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -163,8 +163,7 @@ TEST(siocgskns_keeps_netns_active)
 	/* Wait for child to exit */
 	waitpid(pid, &status, 0);
 	ASSERT_TRUE(WIFEXITED(status));
-	if (WEXITSTATUS(status) != 0)
-		SKIP(close(sock_fd); return, "Child failed to create namespace");
+	ASSERT_EQ(WEXITSTATUS(status), 0);
 
 	/* Get network namespace from socket */
 	netns_fd = ioctl(sock_fd, SIOCGSKNS);
@@ -195,4 +194,66 @@ TEST(siocgskns_keeps_netns_active)
 	ASSERT_LT(ioctl(sock_fd, SIOCGSKNS), 0);
 }
 
+/*
+ * Test SIOCGSKNS with different socket types (TCP, UDP, RAW).
+ */
+TEST(siocgskns_socket_types)
+{
+	int sock_tcp, sock_udp, sock_raw;
+	int netns_tcp, netns_udp, netns_raw;
+	struct stat st_tcp, st_udp, st_raw;
+
+	/* TCP socket */
+	sock_tcp = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(sock_tcp, 0);
+
+	/* UDP socket */
+	sock_udp = socket(AF_INET, SOCK_DGRAM, 0);
+	ASSERT_GE(sock_udp, 0);
+
+	/* RAW socket (may require privileges) */
+	sock_raw = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);
+	if (sock_raw < 0 && (errno == EPERM || errno == EACCES)) {
+		sock_raw = -1; /* Skip raw socket test */
+	}
+
+	/* Test SIOCGSKNS on TCP */
+	netns_tcp = ioctl(sock_tcp, SIOCGSKNS);
+	if (netns_tcp < 0) {
+		close(sock_tcp);
+		close(sock_udp);
+		if (sock_raw >= 0) close(sock_raw);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(netns_tcp, 0);
+	}
+
+	/* Test SIOCGSKNS on UDP */
+	netns_udp = ioctl(sock_udp, SIOCGSKNS);
+	ASSERT_GE(netns_udp, 0);
+
+	/* Test SIOCGSKNS on RAW (if available) */
+	if (sock_raw >= 0) {
+		netns_raw = ioctl(sock_raw, SIOCGSKNS);
+		ASSERT_GE(netns_raw, 0);
+	}
+
+	/* Verify all return the same network namespace */
+	ASSERT_EQ(fstat(netns_tcp, &st_tcp), 0);
+	ASSERT_EQ(fstat(netns_udp, &st_udp), 0);
+	ASSERT_EQ(st_tcp.st_ino, st_udp.st_ino);
+
+	if (sock_raw >= 0) {
+		ASSERT_EQ(fstat(netns_raw, &st_raw), 0);
+		ASSERT_EQ(st_tcp.st_ino, st_raw.st_ino);
+		close(netns_raw);
+		close(sock_raw);
+	}
+
+	close(netns_tcp);
+	close(netns_udp);
+	close(sock_tcp);
+	close(sock_udp);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


