Return-Path: <linux-fsdevel+bounces-49018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94688AB78BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 00:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE82086576B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 22:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878AD231A51;
	Wed, 14 May 2025 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUdZ7K0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740E2153D8;
	Wed, 14 May 2025 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260280; cv=none; b=dhwMPkH54szJuhLOHTDfAf3KnTKEnWSWtznrCdZ0vCtvWztH50RQvSOzF1Eyh7xpWvReIA3JTVYXb5SsOnCrfq7bTdehpLDnVGCi3DXoDzI0M/GyHRVs6QROYykYQODpdJthwIzU37PajcWYi6x52wF4JoItB3HIsyLpsvZTp3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260280; c=relaxed/simple;
	bh=WF46UsPN75VDjMGLBPpKqGhF8yXGNp/YIhfAlM9Ro+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IG9u3ra5NFGEVdrBHRcHQtpmnHG4ef4xR5e3rfXCp/TO7WkVLWGAIf2YSBSAqz9CAMokQM27dt/FvOY7jX1bw7cWdQfD47TSvt24gsUYy9FlhqVS5Mg0hojgjPpO+u/g++QjcKCA1PmNUNN03lmnsqKl4DMnyBP/gLLeElwCqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUdZ7K0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B48C4CEE3;
	Wed, 14 May 2025 22:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747260279;
	bh=WF46UsPN75VDjMGLBPpKqGhF8yXGNp/YIhfAlM9Ro+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PUdZ7K0j17nsI5ayN7DSVjltWpYjm6oTU1mp9NUMsiQ9ampYAeKPhPeTt5brHKqQh
	 b1YCx1yrkI4VntLHgZSntgzZxTZm/caerNwwEbZfo3cmjqmUAAc+WZtu2wrI3aEliM
	 ri/vW74f+MTIsZTTIZ9s9SYep4C/tnT4eUj+KgBI15odyyFD3ZMQTMMsWqMdoD3TBE
	 BQo0NsjZUHoei2FKsRI6FKvdPXAoQNC2wdOgDR1y60rz7ozbuM8mS24iiXkbAH+g6f
	 SGDX5xFhxlvhWX7rj2wfQa8CG5G5AJztoexZMQcmzdeXHoign0VYTe4epLf9WTRdY2
	 WYn7RL2x4q9UA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 15 May 2025 00:03:41 +0200
Subject: [PATCH v7 8/9] selftests/pidfd: add PIDFD_INFO_COREDUMP
 infrastructure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-work-coredump-socket-v7-8-0a1329496c31@kernel.org>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WF46UsPN75VDjMGLBPpKqGhF8yXGNp/YIhfAlM9Ro+U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoCntKiHV/2tWx+UDRFq9PT75FCXS2rnSs5PT8MNHWi
 tPMcK1VRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQKixkZ1mqXeZYdZTVnDI+1
 0p/xf7HU1aasrZ6W2dVuX6avPCwby/DPxi1xptY83v/HVkpxXs2729aYl3PifPG23QrbV8S9cGr
 hAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add PIDFD_INFO_COREDUMP infrastructure so we can use it in tests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 55bcf81a2b9a..887c74007086 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -131,6 +131,26 @@
 #define PIDFD_INFO_EXIT			(1UL << 3) /* Always returned if available, even if not requested */
 #endif
 
+#ifndef PIDFD_INFO_COREDUMP
+#define PIDFD_INFO_COREDUMP	(1UL << 4)
+#endif
+
+#ifndef PIDFD_COREDUMPED
+#define PIDFD_COREDUMPED	(1U << 0) /* Did crash and... */
+#endif
+
+#ifndef PIDFD_COREDUMP_SKIP
+#define PIDFD_COREDUMP_SKIP	(1U << 1) /* coredumping generation was skipped. */
+#endif
+
+#ifndef PIDFD_COREDUMP_USER
+#define PIDFD_COREDUMP_USER	(1U << 2) /* coredump was done as the user. */
+#endif
+
+#ifndef PIDFD_COREDUMP_ROOT
+#define PIDFD_COREDUMP_ROOT	(1U << 3) /* coredump was done as root. */
+#endif
+
 #ifndef PIDFD_THREAD
 #define PIDFD_THREAD O_EXCL
 #endif
@@ -150,6 +170,9 @@ struct pidfd_info {
 	__u32 fsuid;
 	__u32 fsgid;
 	__s32 exit_code;
+	__u32 coredump_mask;
+	__u32 __spare1;
+	__u64 coredump_cookie;
 };
 
 /*

-- 
2.47.2


