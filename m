Return-Path: <linux-fsdevel+bounces-48714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0617AB3276
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C62917AA32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3652641EE;
	Mon, 12 May 2025 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in39wKwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4E25B1C3;
	Mon, 12 May 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040184; cv=none; b=RiClOew/NaCL39/IKcnZ9Jl+mZjFtkdjP5Pdi73KXlH4t2Ku1SsZ5wDOVqqUPYlJsPB3SO/TWKfsmFIWTEjCFbhGzb4iZDy0+gWB/8zePP2FzU4RyKe8N8+5D63W0WHJ31KW4qnyHk+8E0xyTv2dyX40AVdvUpk6X38nETmnkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040184; c=relaxed/simple;
	bh=WF46UsPN75VDjMGLBPpKqGhF8yXGNp/YIhfAlM9Ro+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTuHae7QAO5XkyKQbH/5Q8w4iqMvgbu9RsD+tcVFRzfXy+balbnez50R/BBvdsDJnnBEf4KlwtNhuI78EHman3ZWvv5hEfi7hr9AirYB78pSCUUPK6yE4qfgUP7irYr4EY6X4YIt8Y5iUVeB3ddCGTwS+JQKF4wzjOsHTNW++iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in39wKwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD283C4CEF1;
	Mon, 12 May 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747040183;
	bh=WF46UsPN75VDjMGLBPpKqGhF8yXGNp/YIhfAlM9Ro+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=in39wKwrDT6YPk1FpCSb5ZqpqbNdEksHQ4v5hC0tVyawRIKAkSMQSJvB1AXMvDuja
	 tz74DikcY0DqaqKs2TuCBJXfhFw/4ho6VyZVpGiHkCHULlJyGdimVGDKTrfVugXk/H
	 7CrrN+v6iE9rC4iMlyz5e8Fv/L9crPE7WI+zpoZ2vvIbnaIgNHnqEoZRCEyRGqG0nh
	 QbwoGz0ZW2cQGSxRBsjgUR7lvbLslHQZwl6mk/AhecTQp+aVbMTWtLRYOZY9Ew0BTi
	 uh/pfF61g02L1lPlsyyf/WArEdcA8u5c4FYxZ5B5rhJLtLt8w2Jg9olMIR3/fIrVxq
	 tGvgSMqqes5AA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 May 2025 10:55:27 +0200
Subject: [PATCH v6 8/9] selftests/pidfd: add PIDFD_INFO_COREDUMP
 infrastructure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-work-coredump-socket-v6-8-c51bc3450727@kernel.org>
References: <20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org>
In-Reply-To: <20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQobm8XDXLNzXrq1Z3O2mXA9/cxn61Zf4pU2+9Dwrwed
 y+elGvsKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMjaZkaGnY1iOyOYpAwksvOf
 /b7w71Dl29DLvC/8FhtJRusLtf6+z/BXaqomf4B85rtvE9wz2c95b790XXL591Xl3g1Zwgt12SZ
 zAAA=
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


