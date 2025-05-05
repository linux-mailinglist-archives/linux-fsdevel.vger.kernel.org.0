Return-Path: <linux-fsdevel+bounces-48059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B15CAA91C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68611898B10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCD0211715;
	Mon,  5 May 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMIRbq7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A8202C44;
	Mon,  5 May 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443662; cv=none; b=bi7afv6jPcfuEAGdl2eagCu9fc3GpH620+8iVZmeAqGaAWEGdsCtOIKtoZNAcj4tWAF26LaSahJ/Lp/ow7az5U+GdvgSk5teHfRLF3FxGOmLDvTbQpuJn665i5291bPprCGWjRqsPY523PnagPEzcEJWcKj5ebbcgi/0j/8HUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443662; c=relaxed/simple;
	bh=JDoGvjfCNvj7yWywk2edcAkOb6wyjmCSvk4ij427g0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q8U+NCsSHlUnGjM8QByJk6mMX2evxRZwqJZ0Q8y5LSo+aoLwDQM6+p7Nt3hgiLfSkA+oINefrVf97WFI3X2ff6A8c9L3Z9gX7YLlLVkwNnayr7gGNsl6PIiWObCJ/fIImARavnOm9mdGo61cGohglFq8DdHiPQKWDIdwiIN2uKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMIRbq7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA65C4CEEF;
	Mon,  5 May 2025 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746443662;
	bh=JDoGvjfCNvj7yWywk2edcAkOb6wyjmCSvk4ij427g0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DMIRbq7UbBsvDtQpOME71heg3tTAC1x9fshiLpU5tXxSt4onj/kFGIECIlt/n2Ivo
	 OzXmqqvQ+FPJ+9nQAXlZLlIPDGDrGhPSq/GlYCisrxJFYQaT5+osH/nNpBmthkeuty
	 pPlYa6t1isQ+u8Gj6fFDllr5CyaM7TsgPX1GdsVl49tp54wyL3kNQ74IxsWxJWzuny
	 60Oz4OAR1jH49q6Vg2Cr2IfOpl/383X2qrXJXgqxK+cwTwFrauQ4l6ss7Yy0bXE+at
	 c0Be7r9gAg+YaI8XpOVJQJTYdDYbyKX3UqRipyDSQ3cxwZKiwjymISyyMD6h93WH9Y
	 /AMFQuD6DjNKA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 05 May 2025 13:13:44 +0200
Subject: [PATCH RFC v3 06/10] coredump: show supported coredump modes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-work-coredump-socket-v3-6-e1832f0e1eae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JDoGvjfCNvj7yWywk2edcAkOb6wyjmCSvk4ij427g0g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIzM0TXnloDmv7tsUetp3Ps45km/9T8MubsKQ9sF395
 fzWm67nOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSWs7I8GOJTu/MlTf+aV9g
 dXhrJnhMbu78G9vu6shOYaiafmhRVCrDP0PRSRfezLntfW/C6tP5QptuLZQIf/ky2YOvR+yZCc+
 KR7wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow userspace to discover what coredump modes are supported.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index d3f12ba0f150..37dc5aa3806f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1203,6 +1203,12 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 
 static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
 static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
+static char core_modes[] = {
+	"file\npipe"
+#ifdef CONFIG_UNIX
+	"\nlinuxafsk/coredump.socket"
+#endif
+};
 
 static const struct ctl_table coredump_sysctls[] = {
 	{
@@ -1246,6 +1252,13 @@ static const struct ctl_table coredump_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "core_modes",
+		.data		= core_modes,
+		.maxlen		= sizeof(core_modes) - 1,
+		.mode		= 0444,
+		.proc_handler	= proc_dostring,
+	},
 };
 
 static int __init init_fs_coredump_sysctls(void)

-- 
2.47.2


