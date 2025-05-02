Return-Path: <linux-fsdevel+bounces-47917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C51EAA7269
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394121B62CCD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8653F255F57;
	Fri,  2 May 2025 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsoFxfiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA809255F49;
	Fri,  2 May 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189782; cv=none; b=iLBcmUa5pxlMahySDYM6ec1xH1Q6DYL99JqvomHCRNpR6uZJO5A0Oy8nW5Rdnff418jm1l4Pigb3g3jodOpKn7PizbNE4thkQr0IFbNV0h2aIk1nwS5WUnG+MbBdbwu6ncCuxI9vhMXtqUM/6zu87uF5czp+6kem3x2qRRpCcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189782; c=relaxed/simple;
	bh=NhE2hFgc61WAQVF5mM6Mii0VL7txusY2shDJ6wbW/tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ya59JTsMLGMd/grg6DHVwJGRZysSFBLBcpry10fhbpb2PcwcJxKlD2rLJukDCWkgevU5TtoYBZVq8U7mWCTSeSgE6I9iz3EQJ5mIYRIcKodKxQOgvPIc2L1yCLbaCcidzWGqZK2J3HM7OyPw26alJxmfufNhRZBhK0CRLT/Rvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsoFxfiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871FDC4CEEB;
	Fri,  2 May 2025 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746189782;
	bh=NhE2hFgc61WAQVF5mM6Mii0VL7txusY2shDJ6wbW/tk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MsoFxfiD42mggzSTl5WY9oKWthZvSFgeqnws7iz29iGLCej5NHo4tWo9LL9kQmEG8
	 CMbc5E/vJftCUtxKv1WC2CPbrS5Jzm9NzR+6inZQA04j4DWyO2w0J0AF4pPMQ1gUaZ
	 7hdJqB2K7Rin4c9hPHok7+Bjs9DBz8CEMZGrzKUl3XLJ9gYjhLN6DwNdUwwUr7lxVv
	 7voIIymRURBbqsiA3bxjhH809irT+b8LTarhXwwUb7bWHiRZFoEjsMSVh83w+SfaMn
	 6cUGJMrMMeDu5B0AZb+6I7MwVv0KHFBdCkJrBZALXoYwwPAWR8QHSnqlUTAHW/6HzF
	 ioKLLlo0CFsTA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 May 2025 14:42:35 +0200
Subject: [PATCH RFC v2 4/6] coredump: show supported coredump modes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-work-coredump-socket-v2-4-43259042ffc7@kernel.org>
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
In-Reply-To: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
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
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NhE2hFgc61WAQVF5mM6Mii0VL7txusY2shDJ6wbW/tk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSI7D0gs/VbQOHn/2/vSUyRLmD99DBG01VBRj+aYdn3y
 25nnme+7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI3J+MDDeL2udn7b7y2V28
 8vDRFak5F3bzph+dp2xTzhdzff+6ahaGf5rtp/U3NWpaax8rktG2uLj/UfAvY6eAw59mnl/p/jJ
 yOTcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow userspace to discover what coredump modes are supported.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 9a6cba233db9..1c7428c23878 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1217,6 +1217,13 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 
 static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
 static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
+static char core_modes[] = {
+#ifdef CONFIG_UNIX
+	"file\npipe\nunix"
+#else
+	"file\npipe"
+#endif
+};
 
 static const struct ctl_table coredump_sysctls[] = {
 	{
@@ -1260,6 +1267,13 @@ static const struct ctl_table coredump_sysctls[] = {
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


