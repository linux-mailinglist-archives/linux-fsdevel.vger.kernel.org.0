Return-Path: <linux-fsdevel+bounces-49246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E366BAB9AFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016C05046C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31C8242922;
	Fri, 16 May 2025 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+oRi4VG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8A239E6C;
	Fri, 16 May 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394778; cv=none; b=R228hxsp7EamMIyUDzLTYB8inImv/IdsaTLaA3TBTLXl98c9hoerie4lXmLqeN3Giz2fkLmP5ks2zoHXtkdBOOcO6zXF/rhrguIlFcxTYpnH19tCpmugPqZ/ES2F9NOO12M50J0umH/7HDL1mRks8KL4XPUOxlNHaDtp3PBb8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394778; c=relaxed/simple;
	bh=Ii80ZxJgXHUTdBEM8Pc8vb2Z1/i3PEc4YOr90pWXMkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FhpeVdH1Kd1L1i+aiH6ZTAnpEMiGnXKI4eLLo+4KDpwOZgfM64XZOfBRbSQqQRfHJxb9o7MaIH5uehYKWEdfvbiLoivj0H1WUGjCiLZxsEwl7NWJBycYxy3AWKxlr4SZEthRuPh7LvQA5/1KRYlsNDyDOA0mv5EeeAmbE9xYcAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+oRi4VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001A7C4CEEB;
	Fri, 16 May 2025 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747394777;
	bh=Ii80ZxJgXHUTdBEM8Pc8vb2Z1/i3PEc4YOr90pWXMkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G+oRi4VGSnKZbLkeRauM6bHc9FKkjYD17GUAxoWWJQDc02OlLQU2ssBv3UUEgkmrM
	 yJUV23OLaaVUOyjXhrIT9U7SO0dNA2S3pAAuwNF7zy0JP01vvqyiUUyGWBnqV14Ale
	 4Cj9Ln7TkSfhvZRZ7QKERWWwwx3O0YqQ7m02FT75FU7Up+uNv4Aup0UtAiG1Qzd2hS
	 BfmN94tnT+RGODuiayiKwM4LjgldINIg+/Q0yR2VGDIrYjLjaimqfVfDaAzqtDc+xj
	 udVF/VhOcadna5gy+q51BGzJFnkotJrj20JpN5o2fDmQUtYXYbn/Xr+TVXdZzSdxty
	 KsEPHJhXVcDkA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 May 2025 13:25:33 +0200
Subject: [PATCH v8 6/9] coredump: show supported coredump modes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-work-coredump-socket-v8-6-664f3caf2516@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ii80ZxJgXHUTdBEM8Pc8vb2Z1/i3PEc4YOr90pWXMkI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoK2yN+6Ms+3TiB72NRS3ngqrfl8YJyMzQvD1bKfpD/
 Anho4lfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyr5jhf7SQ9/bVMdvL2E98
 Zb0rG6j7SHX5wzuaWY/65l5j+/n9ADvDP1UZr2zBmr1PP1z6wP5IhuGfZ4yvkXL5oa1z1kWdz7K
 J4AcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow userspace to discover what coredump modes are supported.

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 48064b1d6305..7b9a659683fc 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1227,6 +1227,12 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 
 static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
 static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
+static char core_modes[] = {
+	"file\npipe"
+#ifdef CONFIG_UNIX
+	"\nsocket"
+#endif
+};
 
 static const struct ctl_table coredump_sysctls[] = {
 	{
@@ -1270,6 +1276,13 @@ static const struct ctl_table coredump_sysctls[] = {
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


