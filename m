Return-Path: <linux-fsdevel+bounces-48406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9322AAE667
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1349AB25DAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB3928C2CB;
	Wed,  7 May 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYyhooju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C728C2A2;
	Wed,  7 May 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634472; cv=none; b=E4o+2gUeSuVBCX5WR1f+yjutiDcnRbznrqnHtqL+4Y0P9apmWyfIruzv0WC+hhx/PIp3BHPfWytr/IvuDM8Ou1MCtAFtpQ3ehj73uhqaDwFGWbmDtBeZaGOXyQ8CrsSir1YRMVKgzsro21J9Y1Pp61VElaMaBDdZONQrDyt06Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634472; c=relaxed/simple;
	bh=WF46UsPN75VDjMGLBPpKqGhF8yXGNp/YIhfAlM9Ro+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDx1d+bXxeRD4UgcZcUbLQxd3+Whne4FCVzjIDWUNiwUVVa3MIxbqLSeLlM1SadYvWt2iVgnHAAAieYquGsB0ZoPJnXx96GLxyv6pPw/RwgZw+58oUON3p9fp546cgg5pdg3pBbRFx7BfnSU/yRrU/TrjN3FJfjo3ZDD5MR0lxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYyhooju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD14C4CEE2;
	Wed,  7 May 2025 16:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634472;
	bh=WF46UsPN75VDjMGLBPpKqGhF8yXGNp/YIhfAlM9Ro+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jYyhoojuZvjc6J0fxC0rspK0cIQ6FIPpH5yY+D1FgzLecppO01eBFvndlyexV1jAX
	 5GaeyH0o7/iWy8teld83G4AIZLQI/DJ3VUyBcCgkZJKcUI5hBqVcxgGnBW9mWjHp/8
	 l3qztuUQW+q4YJMvNMCyvbtsd3uNGBVngHX+0DfVAs0MPRT2pOlY0cNKcM4V+3v5UZ
	 nwm1nl8TUuoc9x5CbJ6tHKUqOWwZGHfgZ5D9ZtmbMLBe+u04SomXtYixaAXCblQAbq
	 49R5ZPPqoE59GoysOvzH90kFWbxQ9v/S++JI2cpjfMogIjkEC2Xws7QlLyEyJqSRSN
	 eqyZi017Ha26g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:43 +0200
Subject: [PATCH v4 10/11] selftests/pidfd: add PIDFD_INFO_COREDUMP
 infrastructure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-work-coredump-socket-v4-10-af0ef317b2d0@kernel.org>
References: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
In-Reply-To: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
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
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WF46UsPN75VDjMGLBPpKqGhF8yXGNp/YIhfAlM9Ro+U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt20NnzthRW3HvJ0rshpTkvlmHnItWXHzoPOlJY4lb
 p+bmPV3dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEQ5mRYVfAzCLFWRdds37s
 35ix58bHqdpe3Dp9y4Jm3ezY2muy1IuRYYpY4+L7JiudPC8fDkzeZJTnv/L9Bo4LyyRyv2/fa7c
 ngQ8A
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


