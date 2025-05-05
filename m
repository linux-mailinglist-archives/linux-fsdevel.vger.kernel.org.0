Return-Path: <linux-fsdevel+bounces-48062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD164AA91D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0541774F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE02153C5;
	Mon,  5 May 2025 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SszgRe0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728621505C;
	Mon,  5 May 2025 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443677; cv=none; b=QG6jqaOgUFRdGouYGyUa/d/+M6acHjGValZKnwBi4RIQyprUTKGFBJRTkt2kXS3F1tKatzJFsSakNjiuV7TP6dxx5RjE0hGeUkoX8LjEsyj59D4kmJdS/b+VfC8Ul8INdhmg5uGDzmi19T6YfzsRjTQ9ZTlDerPKLXS3FuTxHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443677; c=relaxed/simple;
	bh=rojmlNBBYZrLt7jghiEYSsqnznF4z3iX/lIAQtk2wM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MU0Rp9QdfHHHI14XOhGMSZZRYsRPBAVuETbmR3woHNQKWMBp4zPv38hYvlKlzCJXXCejd29bu78R+3UzDO1td9YbvsPgi0HHFHZexcUrj/EnyI4tsdbZwZ1lfiEa0uh5D1DEdpCpD1IbRihO+LZ0VrfFhh06kIE4ZtHuIymKmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SszgRe0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E37C4CEF0;
	Mon,  5 May 2025 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746443676;
	bh=rojmlNBBYZrLt7jghiEYSsqnznF4z3iX/lIAQtk2wM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SszgRe0zrZSr2t80U13WkrI0JWgmcYYPbL5sU/R1e12T+bsyZoiQJwHstcyZnQHcW
	 U1uEsNSB4KI65GyeZY8BA2qPnkOnJPxxGLQnt7eP4nj/vX11Z29IIj7WxrBsRBRlW9
	 ufIQR44FIMUcQkC4SYH9Wyel4BfguQPKM1PVMA8RLZKqZSzX46NPBf4ykUw9mGzcFE
	 qXZTrJRxXXWC1mek7gtzRAQBbzuBSuLlkngKJrERJcAJq1C9GOKGHlW12MnZiySJeC
	 DnfIoM7omU6HsKNhmoH4rr7SJoF1eWvFBw+oT1wOUZDwC8b2FIdzUNmIliBzpfMo3P
	 KKb2CJVzTMY/Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 05 May 2025 13:13:47 +0200
Subject: [PATCH RFC v3 09/10] selftests/pidfd: add PIDFD_INFO_COREDUMP
 infrastructure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-work-coredump-socket-v3-9-e1832f0e1eae@kernel.org>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
In-Reply-To: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rojmlNBBYZrLt7jghiEYSsqnznF4z3iX/lIAQtk2wM0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIzM1jZX8cxWGz6MGqA3KuJ68Hp73o0Ph5ojLo+qMi9
 2V+90RdO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSPImRoUEq7PKWdrFwBpmz
 +bu3rzh/+17O7C/lCa9+Bm+SXuFR+I7hr8gLe4PU+ry9f5ucXu1NOGTzdeOt/WFXv7Z+WLTD95n
 pWkYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add PIDFD_INFO_COREDUMP infrastructure so we can use it in tests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 55bcf81a2b9a..6e812c3afca4 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -131,6 +131,26 @@
 #define PIDFD_INFO_EXIT			(1UL << 3) /* Always returned if available, even if not requested */
 #endif
 
+#ifndef PIDFD_INFO_COREDUMP
+#define PIDFD_INFO_COREDUMP		(1UL << 4)
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
@@ -150,6 +170,8 @@ struct pidfd_info {
 	__u32 fsuid;
 	__u32 fsgid;
 	__s32 exit_code;
+	__u32 coredump_mask;
+	__u32 __spare1;
 };
 
 /*

-- 
2.47.2


