Return-Path: <linux-fsdevel+bounces-66275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC56C1A594
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E923A34BE48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17DA3559C8;
	Wed, 29 Oct 2025 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQsU51mc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011AF3644B5;
	Wed, 29 Oct 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740753; cv=none; b=shf2hrchkZewQ0l8mafWw0EmgXjMM8WX41fPxL/9C6geBOpYU4RzjD/SwcY5DPIT/tf64R+6s271/XZEvVuHNhzF+HQccecdt1g8EyypNQ757d8WdzGrs/vCd22hMFwTKtSGRdXMFe10QXq82Uemymjp6pcl7SWxn3LMCRDQK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740753; c=relaxed/simple;
	bh=VBORRP+h0KErK54FHs98ti+2CEgWK2XfNgSQLs2e/YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6eA9T4nRamIyLmv5INmG7NFyDGdvVhYqfj2y7MBsyRNGeJj1i9T61JtJ+Tir9hkmYJplDppi26ZBFmHpWgMIg+WDmcPhESK9wmU658Ym8H9xxNAx6t0nqo4RVrTLU1zLzOlHc+7HHymyehtaEnjFmt6OjrM5Y/7UQccst591gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQsU51mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20458C4CEF7;
	Wed, 29 Oct 2025 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740752;
	bh=VBORRP+h0KErK54FHs98ti+2CEgWK2XfNgSQLs2e/YU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MQsU51mco5xw2bbprqKOhjMfNwKaSRjphx62ODPWOhRpSR3pGu93IShpeUyqqmvPm
	 D8OW8WeDvX9ffQ1zBXbniy/YGhbnBE5HNjoPyfunGYuN/7gjspb6ZymgGHDPJzjZgv
	 R8FbTj9BgYZ4yShACYBpovOvNQFWWANO/G8ylR3/+UwEgdvLyrev30ubwSEQYA2YJR
	 X/Aw+Cm3fu8so0pRjtEdJUWzKXzG85hxte0qYdB8APHoJIDUSdhKAW0C1Uoq07WUkl
	 Kj1qTGguMhM83MmcWxdqDod3eEB1ZHZXsxUTNCE7T0hUml1I0vk0iUZ1mNwWGBklM2
	 cWdEaf4uM0Rsw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:15 +0100
Subject: [PATCH v4 62/72] selftests/namespaces: eigth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-62-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VBORRP+h0KErK54FHs98ti+2CEgWK2XfNgSQLs2e/YU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfXvujBz9603cz7/9mKXunvHdC7vS+erRrdUlud94
 zmyrMqlpqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiJ48w/LNViJTL/mbaXa16
 jut6yoGq35l6x9SPTF/1590aa6Mt0q0Mf3gyM84bLr3Fs2FqXZLhWf+IkHd8V/7UJghY+ecEneW
 yZwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test IPv6 sockets also work with SIOCGSKNS.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 60028eeecde0..47c1524a8648 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -542,4 +542,38 @@ TEST(siocgskns_netns_lifecycle)
 	close(sock_fd);
 }
 
+/*
+ * Test IPv6 sockets also work with SIOCGSKNS.
+ */
+TEST(siocgskns_ipv6)
+{
+	int sock_fd, netns_fd, current_netns_fd;
+	struct stat st1, st2;
+
+	/* Create an IPv6 TCP socket */
+	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	ASSERT_GE(sock_fd, 0);
+
+	/* Use SIOCGSKNS */
+	netns_fd = ioctl(sock_fd, SIOCGSKNS);
+	if (netns_fd < 0) {
+		close(sock_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(netns_fd, 0);
+	}
+
+	/* Verify it matches current namespace */
+	current_netns_fd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(current_netns_fd, 0);
+
+	ASSERT_EQ(fstat(netns_fd, &st1), 0);
+	ASSERT_EQ(fstat(current_netns_fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+
+	close(sock_fd);
+	close(netns_fd);
+	close(current_netns_fd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


