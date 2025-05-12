Return-Path: <linux-fsdevel+bounces-48712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E586AB3271
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 10:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC6D188EC39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B17925F7AB;
	Mon, 12 May 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRvNmCkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE125A33D;
	Mon, 12 May 2025 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040173; cv=none; b=llIEpBHU4yhTHeOpLdflcoWNFbILNBt7b81NDzzdi6mLwpE3aa1a+LcOVbDPB+gOZC9eEOTLTTkK/n0U8AdjfiikULWV4JK90XsH2Qv9yoJqnejxHYFrx4xY8Wb6Yv7m5pgv1uKIBxHkPo7Q6Z4R6DSIsTYKQyHYnha4qN+PWBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040173; c=relaxed/simple;
	bh=Km4WnFRvUry5Exd8fNEf7asKYTERy4VYPOic7LtuZb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zn9uH/dFsPd0gyb+lSYngOusQJnBKosoMzBSv7AO/ahwijIbnbIRHQvPyCF7NaOWea7xfnK4oWm672ECk7AP3eec+0fIjbiDbZMnh4j1eMWDhg0fMQcuwLE1FEVMExzuIZ4J0FvP4sfLLQtvSVfw7lOBVG52uJjWXMAl8BEh/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRvNmCkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAFAC4CEE7;
	Mon, 12 May 2025 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747040172;
	bh=Km4WnFRvUry5Exd8fNEf7asKYTERy4VYPOic7LtuZb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tRvNmCkMCaX7DSgimUG1pB0JDYDuKxHOAmTsfvOgTZLezn6YSWB+qMg1XtleVwUwP
	 ceSDhzT13Xk/xTj/PR3VfmleGsHPpVf3c6boaM7LSsifcj/phmALAa1pk3WHEV2hQ7
	 2jxz5sDsmjyRCbMVKBH6R8y87DRvFP9TrbjEemliVPTBFofUnPUbgIlbfRP9TIb8Hu
	 HksRpddUGamHBVZT5iWxFP6XEOOe7H8MwZl09yFDce/sYQ1Du01o6v011DMZUWuuER
	 0ULh6/94mrQH0KzMZoXRLHqnEkx4y8Imys2tswsuntdk9fzGhqWuX6PVl37vIRyIgI
	 hOafWZXvZW4Ww==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 May 2025 10:55:25 +0200
Subject: [PATCH v6 6/9] coredump: show supported coredump modes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-work-coredump-socket-v6-6-c51bc3450727@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Km4WnFRvUry5Exd8fNEf7asKYTERy4VYPOic7LtuZb0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQobm9nWKW7aOeCndrcORrxUfl6b17O6fi2/2Cu/IKvj
 3ntXFnOdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWwIF6cATEQonuG/a8GaoHlT12+ZslI2
 hFVifaWr6uS6cJGVZ/aasQrwncqKZ/hn4aDitNxgc+ReOw2r78ppZ+T7nXoXMDj28zDe7Ny9pJg
 LAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow userspace to discover what coredump modes are supported.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5ea0c93dd5ac..deee52bff6bc 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1254,6 +1254,12 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 
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
@@ -1297,6 +1303,13 @@ static const struct ctl_table coredump_sysctls[] = {
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


