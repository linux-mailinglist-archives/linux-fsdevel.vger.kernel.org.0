Return-Path: <linux-fsdevel+bounces-66270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40992C1A744
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D946795A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350053546F1;
	Wed, 29 Oct 2025 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE/Lj65z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E43358DE;
	Wed, 29 Oct 2025 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740727; cv=none; b=l9juPqISyvnx5P8YOwMJKllyJBeD/+ZaHMZ/i0G4eJnn1tYveyJWhz4it5Bwo3h26R3m6OoutNl3xLQhAm03jFkbnhiBYg+Qp0JJ3E6ZR3h9QQZXzI2wfCcj3eax/wPwj/Uu86crgGfD798/x1Dc5z2SA3c5ygVvrd3HxXINOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740727; c=relaxed/simple;
	bh=Jefh0E5wrR69nQhrRe8vhHFWAuKaAVI3adTXCV7rO88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrAZEO72pHyTm+ckEmLZuSx3ANoee97Vl3w5qb2sy0nwHAyZYHLXRK2i9wWvWaIGxqZQ9bRF0QobtcCq3XlvkrBRYhhhrMfWos7h499WVh1Ca8NEvSSOfDMX+NrXaZHoHP5vzauS11rK0Z4Q5wZMCJn4raspdYiTWgE/yPjDgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE/Lj65z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91713C4CEF7;
	Wed, 29 Oct 2025 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740727;
	bh=Jefh0E5wrR69nQhrRe8vhHFWAuKaAVI3adTXCV7rO88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GE/Lj65ztKvWlnc+X7dEWnm7yHQsmO+0JxrznbPQ8lb99PB4x7d4O5RJ6kr2hdSIO
	 dqL+8DDxsOPYtMc0xOJPSYdc5IZIn6+kseZDgz76KouC48o3m0r4NKsBFHt4SpCoVK
	 g0cFqfFZpfOc2djmMbJWAmreo45n/So1h1y91Mhtaan68SUzfpSvs28ODGlMiWmgD5
	 cG34ozS9XQHgJhpXb4o7+n5X5I+4ODK7THWSfMC/T57u+bpv0vLGileHsY37LqdT4w
	 GnyVbmVtorCIfdtg57cYw6jZix02VSOQbFtPfVoIeJgev3vikT4KnYWQqkL7kTmwl9
	 Vsp/wNVl0KLDg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:10 +0100
Subject: [PATCH v4 57/72] selftests/namespaces: third inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-57-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2704; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Jefh0E5wrR69nQhrRe8vhHFWAuKaAVI3adTXCV7rO88=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfXL31oj/FXzmp/3n98v17cLnHwz88oLrTtTTv8y2
 pMy3Z3td0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEaq8xMqzf7X7pktSFpa9W
 RsQ+O7OIXV5sA+/Er89qHs/LrVlf7PyY4Z/dBq85nKeedD/+0jHBrIptA9eXJy87H6g8KJLg2/h
 39UlmAA==
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


