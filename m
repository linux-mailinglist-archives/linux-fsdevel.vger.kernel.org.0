Return-Path: <linux-fsdevel+bounces-49016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2713AB78AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 00:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99643A7354
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 22:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF45230993;
	Wed, 14 May 2025 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKrpacmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0242253A8;
	Wed, 14 May 2025 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260269; cv=none; b=Ptm39vCn+WcnmuvBNzyclq8jlhBVjFsoEzxjUlWRC77GFKKMvt/lRImD2z8ZzQN8FL5/sAJxahRTwUWWK4CXS/1t4DWVsCI35V+t/kq8HbNqetBF+ER9d4lcrymFvhzdv5uZaZcuSzBVMtVLzEBUkw+rlE0sSXRnFAZWZxDp5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260269; c=relaxed/simple;
	bh=g1fZL9UHjL0fdEg1HQk9U39MiHvgvwYopqxavC+sk70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLcHVdeh4NF/2eJJYVzPvzoZQbJ5p7vvVbTGrz/LRVn52NOmZ9c0DHvFVbndMFRf2cvw76qsX2aj98N560K1DfffpX9AOYGU89gbii2px6ghabnoj6KWejv6nM33yxo2Pc/yJC40j67VUKnMsamGf6Ym7GYT1bIz/xCStN3Mwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKrpacmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5156CC4CEE3;
	Wed, 14 May 2025 22:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747260269;
	bh=g1fZL9UHjL0fdEg1HQk9U39MiHvgvwYopqxavC+sk70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OKrpacmML91nkBfYMF3/bgtlkVMboBLMScfTioqJiYFHDRym2zTdrxECB8risLyTw
	 b8zfcpLRTMlOLYEZDSOovdavV8aA6CDL5nPD83/ESGredWpNZn5BAxtL5fORYSBExk
	 tIF9DFoH9kzEuHiUJmOy0tZd6dD/lDBAMH0bHZat0RhbT08m6qzGGnMKZFqXLHNujm
	 xu6q72F5r+w0KRDyRYaa7/IeP/jrMcxleAcUu0UBbOcf0pjpkgwcmFjWcUwOlvde4Y
	 4uoUkq6cy9QmLiyPgVGCJLb6R3B/sUM1/eFbHCOqog/m0GshzXx3SDTsS4iDRAy5kF
	 sC7puHjQDgHbw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 15 May 2025 00:03:39 +0200
Subject: [PATCH v7 6/9] coredump: show supported coredump modes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g1fZL9UHjL0fdEg1HQk9U39MiHvgvwYopqxavC+sk70=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoCntUvQ8X3b5k6ZxfRq/CTEtdV0c2iu+Rk1x89VWvR
 mGtWmdGRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEScTzIynBM8lSR8MZI3XP/E
 njeHdz/fZ2p6SeTKYbYQg3PyW+aK8zIyfG5dopHJE3o04am+NadCcO3iP6duZN5f0VLyanVuyrs
 rrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow userspace to discover what coredump modes are supported.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index bfc4a32f737c..6ee38e3da108 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1240,6 +1240,12 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 
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
@@ -1283,6 +1289,13 @@ static const struct ctl_table coredump_sysctls[] = {
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


