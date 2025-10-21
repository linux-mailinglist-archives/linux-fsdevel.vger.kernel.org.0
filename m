Return-Path: <linux-fsdevel+bounces-64856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53234BF6214
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41426502920
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E1E32ED27;
	Tue, 21 Oct 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Own9LxaO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9D32F75B;
	Tue, 21 Oct 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047054; cv=none; b=bO5UVffDHZOhKTZcCoaJe0O9Z00IE4ZeWc1pCY9Gh5anFgBFHf6KL+j8VYd0bCXtXGlS8ax5XvJ85BU+x8W+6ytR1XXlR5W6gqj4LN+IBx8CPcJ1/u2PXj5dWpurDKKjFcfL+cgetYbsjSMi5A620CUbdldlb87peByc6zoghlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047054; c=relaxed/simple;
	bh=KoKI9phRTGMhjpn+9D8BgtjcoxSIgpJa0JnjxzKpEbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxlunTkKWj7gejlTREkqKKRgpysHXuCKc9GynqsvkOEnvXOZ1jWf2fT8aWMRLaZw9tOkMQ2B5YUaCq0zWYvdtNCEXG7NKtAhrkxg0zWGS6gXB2TXyuk05e0eFHMpBYrqmedoNB+dDXz3nFsZeVgiuu5wLBZCiv+Ud64/7+elfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Own9LxaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7EDC4CEFD;
	Tue, 21 Oct 2025 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047054;
	bh=KoKI9phRTGMhjpn+9D8BgtjcoxSIgpJa0JnjxzKpEbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Own9LxaOxCPJgK+rss6yu3LOvggckkZJUzXvDnCFd9hWH67Vx+raWmWFZtSmgOJ4Y
	 ZGuVtQzUuhFJ4EXY6xvatWIsikY5jOSHPP5NLm93LVfUNm7Iy8iUcUmxnOrsrG4Fzw
	 zMeR98rZjXvd1yJhSGKBbZRFg/Q8GSODOQChwoZCN1BXm7DtgWPHa3Qdfitn63phUl
	 2wMoQSM4KlTCtEX4QOYaD8Vx2x2xjilPWa0BwZ6K1IPxZf6RTKxKq3/sw8CuR6JC7J
	 NFPG8cjnR8antjb9CxpWYVFwh/bDQ2RF7JoNfsc7axWrfd62pjNiYbHzwOC18/U6eC
	 PTNI5q22z0ppQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:11 +0200
Subject: [PATCH RFC DRAFT 05/50] nsfs: raise SB_I_NODEV and SB_I_NOEXEC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-5-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=647; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KoKI9phRTGMhjpn+9D8BgtjcoxSIgpJa0JnjxzKpEbY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3xzPUlET+FOWH/IyylvX+3RTf8y6bW6e+rtvsaHH
 KkxGQ/ZO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZioMbw341jYgfDjwwznwqj
 W87blNhiFp4UXpe/KOaV49ozi9/lNjMyLL43J9hgVYzwB/uIN69f7GJ1VVkXc79m466Sjh3bdHR
 nMwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's zero need for nsfs to allow device nodes or execution.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 0e3fe8fda5bf..363be226e357 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -589,6 +589,8 @@ static int nsfs_init_fs_context(struct fs_context *fc)
 	struct pseudo_fs_context *ctx = init_pseudo(fc, NSFS_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
 	ctx->s_d_flags |= DCACHE_DONTCACHE;
 	ctx->ops = &nsfs_ops;
 	ctx->eops = &nsfs_export_operations;

-- 
2.47.3


