Return-Path: <linux-fsdevel+bounces-65182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9C7BFD461
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2EA7568CCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBF4381E7B;
	Wed, 22 Oct 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWI/SeLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B92381E61;
	Wed, 22 Oct 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149453; cv=none; b=CFJOARXS4D4aGHdnm+VMYZJ3QxB1yW/VtiEIKr/mYIanx7giEpige1ySyWBsIc5BvPm26OBHPcnnQgGFsVd9iKvhuWewBjfjlDUHBh0sg2OQMKnNhVwzDc9C7bEdYXUqL1iDv2kuNhIFBJD9DzBQJpuXLCE8CQalEAt8wWLbC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149453; c=relaxed/simple;
	bh=1BIiJuH8iVaCzmqGXRHvJojCs6tQ4qxTFg36CiNtCEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qKIeIcUF48ki+nQA5sUT4/EJUP1EQy+kQEPYf4y5LkaIzx82p7qvagXEkVt4p1GqZmHpG/Gn0Py05Qr3bSF5ItWxxdnm0ezeTdIrCECVs4cRp8K526iU3CHSw7SubUpO6irjmMymA6eyznkVHwQbWcVZHpczpkMaGhC+NRpkKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWI/SeLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDF1C4CEE7;
	Wed, 22 Oct 2025 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149453;
	bh=1BIiJuH8iVaCzmqGXRHvJojCs6tQ4qxTFg36CiNtCEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sWI/SeLO8WHcXknT6WwQ+WwdSYxz519zxSiNun1JKcSSlM4fMBWEsMHgZocFRFNfL
	 /C+h/hKPrSkKOoBK4whrx/CrsUMNJf7BpvhCHFyzHOfe83cTeE7tctLhfMmDouHwq9
	 ENypwJQHoR5WgsEyb5lTm779zLLOptX+iliqsA8iD8NOXCV1/IHGDlEWoXn2GPNr9y
	 DG/pdJ/Y4XUuU192fYMyWllsOoxfACxlG073CMN9iwnUcy77EW8E2lUQJ8CYx68lPA
	 fWRCQWvfPJCAVCmIvCmSHI01edXgDNXjmh4vs11TqLfPlG4c4bRjrqVPby+tqV00tj
	 ezoRFQwANkgXw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:32 +0200
Subject: [PATCH v2 54/63] selftests/namespaces: third inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-54-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2308; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1BIiJuH8iVaCzmqGXRHvJojCs6tQ4qxTFg36CiNtCEM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHj+IjNoPcM68/D5l+oS687N5yg6nhkou1r0zqXt7
 6MPf/l3vKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi1ksYfrO+/58brtF43LE3
 1j/NSvz97UetLLpP5to3SrbEHNh4NpDhfyDDmoLzf+QkecM7ErxSX+14Gpds5rxo+ekL7h7GJos
 4mAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test SIOCGSKNS with different socket types (TCP, UDP, RAW).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 0ad5e39b7e16..3f46ac0c96df 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -195,4 +195,66 @@ TEST(siocgskns_keeps_netns_active)
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


