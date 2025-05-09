Return-Path: <linux-fsdevel+bounces-48560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B41AB10B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A913BA00E10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F128F537;
	Fri,  9 May 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhzX0J59"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E028F52D;
	Fri,  9 May 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786393; cv=none; b=H0+5yWdIpz4CIe4SkbSI3JK50cUmY0mODJeOhNVHWzzve3Edn9Fgz85GgNxGlI43geZT68ZVQn/y7HzfF5JyvWqPo6l57Pl81c8NX1rLE2rs8qe7QFuQH/ij2XqGmLRoibL6FMGo2Bk4hWThbI1V4O6Nk7AJinx5vUgXOeIcnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786393; c=relaxed/simple;
	bh=WF46UsPN75VDjMGLBPpKqGhF8yXGNp/YIhfAlM9Ro+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qwo+xC9p5Q0eSjRh1V2EWgi//9q2kPS67I+82Ssxs8Wt+jAw8eOA6xNSoqHOgzE6dIFXTngPPa4WBW6wtQxe1OT4nDPSFyj5BHKwMrHM8QoMbL/AxNoZ7Xx32tpn9KDxUWV3ycyhK8mlMKt/8qa3/XMucSuM5eWUpAmtHCxmUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhzX0J59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28852C4CEE4;
	Fri,  9 May 2025 10:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746786392;
	bh=WF46UsPN75VDjMGLBPpKqGhF8yXGNp/YIhfAlM9Ro+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HhzX0J59OWpC18HzeymavGMmDQGNlaD/7TtlK11wypa63GJ/XkyH57b2HqDpo7z+4
	 DxvOGNswnlXqf2vFh2RcG08aMGLMF6gVE13l8PhZUuQwFdpH9U3lI6MZKJJZkdjaUn
	 8rSncXyy6B1bQ4VD9KSox0Ch+vJv4JFh3WhNKkpd4HB4rBMnF4eUoWOs8bBoLE2M4n
	 1wGDnQLJsM2BcUnuDw//hG0vKHTpfM2AlAJPXaaUt0JS/cC9ePDIFLnKxBZ3nKjaHU
	 TlEhH/PRrydIq1ivhgjvIgU9c/WBKsuv6w0Ua6YMOqOqHIaoS3sM4mUL3jK7wdNamn
	 xxmrWW/SiVUeg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 09 May 2025 12:25:40 +0200
Subject: [PATCH v5 8/9] selftests/pidfd: add PIDFD_INFO_COREDUMP
 infrastructure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-work-coredump-socket-v5-8-23c5b14df1bc@kernel.org>
References: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
In-Reply-To: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTI3tAqjv+WYBK0ZX5Fxrd5Wo0NatwaxWGF9+PNDH5si
 OlsuXW8o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJHLjH8M4y4eE6aXcFvxonY
 jwrMRXUdFX9cQ2rjtjl7zdx64GKOLMNf0f8Ch31PRtvx80xI29O+JvGF5otNBcvPXJsWUHz5zo4
 4JgA=
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


