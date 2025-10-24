Return-Path: <linux-fsdevel+bounces-65443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5277BC05B27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B96189D631
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49F3311959;
	Fri, 24 Oct 2025 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJXVDo6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19077313536;
	Fri, 24 Oct 2025 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303197; cv=none; b=XRNhUGcLleX8ZaLyt19X8NO6IcAcP2Fr45EeaF4TQ0tnVNszqPxBR+NqaZkNz4bTg5YwaIjJa1J03yDHPPmJckrvijI90xeHbA9h/zShA0PQYuobaDdRTZaQKKanmbdihUGhMb4p26igWBvWh40ptx26t5YDkMrJYbZJCu0MTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303197; c=relaxed/simple;
	bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GWuiaxSL2c3HCLpry2A6/y5vRYZNifGcZ3LcWMu4CWpV2W5wpLS+oV7u/a75lfOcVqJpKb+0X/HMVscQiTSOiZdOO+B7dsMaNH9URFvAeYNVTMjDv8M4av5U54XpZYvWBp4Ip5Ec3Yo885/gZKKns+ZwSUvuWUWQyAYtvYhe7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJXVDo6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F45C4CEF5;
	Fri, 24 Oct 2025 10:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303196;
	bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NJXVDo6ifCMqXV3ZT+yOB+nXERgroeLT3Q3pckKV6NCQ05eOFRL1rzzpTN7p2m2IS
	 18r2xTd61k57/SLZMfjkg7NCHRCcUeXwJCpkaYbj0ksg7PV8sgTJp+smcL4iaC0VO6
	 772335U69i3d3QgSQqopoSJTvwPAEX31GDDd9/sKcf/FgNEc/cVdUf52TYcf44nAcR
	 yngvJTBWx92wRVG0U+uc4D2MjIFIhXWJlFPIXGUZ6K7YcymK9WOe6yqW0TtIW/HB4X
	 M2sQrzHq1KkzSZha3eKi0/ygCidCvzqWK1Zmpp/gARckXo57LCBT/PgCS+YvS/ZBc/
	 216bj1wcRlkRg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:32 +0200
Subject: [PATCH v3 03/70] nsfs: raise DCACHE_DONTCACHE explicitly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-3-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmqpvd1x0tv61LQQXnXO+/yfTr8IDk8tZZt+Uo5zT
 tsjwxdeHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNh+8fIsOLsDNY1AfmbT/cL
 C8Wwa12a8+zF5DyPXpUDbmu/1jFtzGf475Ln7T77kuwUu2fbc3Yob/iQyrxg9q3MnvD63uXiLv3
 u3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

While nsfs dentries are never hashed and thus retain_dentry() will never
consider them for placing them on the LRU it isn't great to always have
to go and remember that. Raise DCACHE_DONTCACHE explicitly as a visual
marker that dentries aren't kept but freed immediately instead.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 4e77eba0c8fc..0e3fe8fda5bf 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -589,6 +589,7 @@ static int nsfs_init_fs_context(struct fs_context *fc)
 	struct pseudo_fs_context *ctx = init_pseudo(fc, NSFS_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
+	ctx->s_d_flags |= DCACHE_DONTCACHE;
 	ctx->ops = &nsfs_ops;
 	ctx->eops = &nsfs_export_operations;
 	ctx->dops = &ns_dentry_operations;

-- 
2.47.3


