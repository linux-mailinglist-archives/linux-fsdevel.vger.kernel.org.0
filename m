Return-Path: <linux-fsdevel+bounces-49248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14461AB9B02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BAA1BC7799
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D242424467F;
	Fri, 16 May 2025 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJw8vE3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017C237180;
	Fri, 16 May 2025 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394788; cv=none; b=kIuBpMYy/CWUlAaiVC5soaqVUXqktKs/nZoDWmVZfVW5EPvonMHPGt3P/9J457/N3PAZDWvi6W0jh7nNULjcVF0n9ot06tmHryk7DmyU3KaTrHUS079aWGo9yQm4CfB+C2cWA99PPVWJyWgAyHdwx6uWtumkvRHe/k/ZtbB/1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394788; c=relaxed/simple;
	bh=BpKwYMdV1GtmnJFOT8ouIh8HQZHbI95yXB+KWWXUyU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEPxxAeSPc/zhkKsiI2/y/lkjW2ItFV/af3e6gb+UavVarz4aJH9ZEbby9N/780jfyosRxs6sur6FfxRR/m+TsTtMj57LbXA8vkK25+QOaUy3wKgrvPGDCr2+mUsPJFZaTLXbAj8rhT4bA6aC0cGxO6c16qyGit8o9OGTTG+ZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJw8vE3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3389CC4CEEB;
	Fri, 16 May 2025 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747394787;
	bh=BpKwYMdV1GtmnJFOT8ouIh8HQZHbI95yXB+KWWXUyU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IJw8vE3VWBg50EPR2Q062FHQbDBCqMvJfRaQUxdTjooocb5oCN/vcmhkc7lu9cp8t
	 RhTVz7YevfK3iaF+R/UTkmmDtviV3bBpyDTceEl96R7E6BaKVg1L83ykktyBy78Y4H
	 vVc4JPQ6F/0gMSiNHD8hMAUwjx8su6SbpZxgaDctKGhVNRIla9yhMwANn1fgvVxFX9
	 WDCSAzAkK60HW323A0q4J0LWwMJZzNAzI2ILMu2gDgkgACKw8TjGrLc7jadSlkaepW
	 jDTKBdXmvnJYGVTEh3DwIY/3Jb58ZGPkZcoO2vf8+vQEncRRW6B9Cbt0QIv2gfg36i
	 gZvbY+4owQYIQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 May 2025 13:25:35 +0200
Subject: [PATCH v8 8/9] selftests/pidfd: add PIDFD_INFO_COREDUMP
 infrastructure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-work-coredump-socket-v8-8-664f3caf2516@kernel.org>
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <luca.boccassi@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BpKwYMdV1GtmnJFOT8ouIh8HQZHbI95yXB+KWWXUyU4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoK2zz41pg/qKqVrApSFrripTy0SO60SujY1X7BWPeP
 8879y2so5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIFiQw/GWerv/ZcKdZ7hX1R
 uJFH9939K155HWA7sDLTYemseTsEKxgZHusw2gYYihm+/nMkIvv1v8vMUx39HxryNCVFCbm3/NF
 lBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add PIDFD_INFO_COREDUMP infrastructure so we can use it in tests.

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 55bcf81a2b9a..efd74063126e 100644
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


