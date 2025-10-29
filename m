Return-Path: <linux-fsdevel+bounces-66218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84177C1A30F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FA51A62971
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40191347BBF;
	Wed, 29 Oct 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4T2WXJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938E338F20;
	Wed, 29 Oct 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740463; cv=none; b=PDJqaFdIxNjK5o5jEZsPx6zMkcIbTKTt686vjwLF41rijzKCyBiDTvaP9hJQ2ayXK+dNp2msKiV5l+mvw1USZADTCY//3UQt1zHB8brSO9dCi9miQkFn606gQv6Odfr+x5KkDLFhS1zShzPVSh/+4DzXhDE8+X4ERfAWxnNZxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740463; c=relaxed/simple;
	bh=m75eXqeDmMvm5b7r1HJsIkrDxEr0RA5dkfPo14u0VyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DXOW01gA/vc5nJBzEXufcHYL+2eZL5Dm9HiNWgOoXHn7QJHoQH8StOOB/P964eJxqKwRISXmQQwJoUh1LJVtQU31fwcWcoXxrEU0Dj/FtR6xYHBM8ynqHh4Watfp0sCarad1dUV/xqIgmjSqhiXNdRqYH+7mxabGHjR3uNZnz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4T2WXJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981A8C116B1;
	Wed, 29 Oct 2025 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740463;
	bh=m75eXqeDmMvm5b7r1HJsIkrDxEr0RA5dkfPo14u0VyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u4T2WXJG5fDPT1OuGF7nqAbnxfh3m1ThgpI8iXmrJzEkEOksPRhiT0bxmqdrVxRh3
	 dJ/CbLWwvvbmsdMLg3GIph8kib2nF3ktnDyjTujyg2gw/0HxxSrTlg7OXgtkXkjtDd
	 e8Ms0DI0ILRFDrqhxDd6y3FKskhbSIRkiUzMHOkNwRkk0iy6fvMd46DAQWCdu4Q3Hm
	 NU8MrfPro0HsX8doXatToimIcbupWurkc7g4RhyGCZgxPsY2KvC/ST2eag+7iLYWvV
	 3VCIfb2SlN8GwRC3CcMIOk0H8Qol263PH4kG+T2zZXP3H/wvez87hWM+zmH1zahaDa
	 EUaZq8eSszBew==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:18 +0100
Subject: [PATCH v4 05/72] nsfs: raise SB_I_NODEV and SB_I_NOEXEC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-5-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=627; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m75eXqeDmMvm5b7r1HJsIkrDxEr0RA5dkfPo14u0VyE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfWcZu7QuNdqYVBzoniT8H3WpXOb53PcWPnoUuW0o
 rkb2uwmdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk/2ZGhnOqW6fn3M07N3OV
 OlOwaGGT1FnDSfeiOHZFqsw17H74146R4ev83WfXKr3aI3nbNufMfr1JBUfuXt1w80LRLoW/J5m
 t/vADAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's zero need for nsfs to allow device nodes or execution.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 0e3fe8fda5bf..6889922d8175 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -589,6 +589,7 @@ static int nsfs_init_fs_context(struct fs_context *fc)
 	struct pseudo_fs_context *ctx = init_pseudo(fc, NSFS_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
+	fc->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
 	ctx->s_d_flags |= DCACHE_DONTCACHE;
 	ctx->ops = &nsfs_ops;
 	ctx->eops = &nsfs_export_operations;

-- 
2.47.3


