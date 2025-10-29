Return-Path: <linux-fsdevel+bounces-66217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D82DC1A30C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC9D4638D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075213469F2;
	Wed, 29 Oct 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMTPu2bN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F79F33B95C;
	Wed, 29 Oct 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740458; cv=none; b=bd5BE8WdA1eHlV3fGFJxWELnMlWkoUZ4ZzAReoYH0Eiaw89Y6GpU4Hr98G7qL6wij4xkbzRS0TPKcl+eYUbrpmVlajoMTEY4Qa9viJeEi4S/SJu1/9a+jqQ7YDVCIFnnLtzgIg/Ul4IKunMbBjirbA0A1qgMem9fmYuZ7UykhA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740458; c=relaxed/simple;
	bh=LCe8V3QgmxQPWsHxmkO/HYNSTPj5l9bqGO1onywb9Xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=euRChcNZDrZBxKeZG+v1guKA+zxyhPxIdmiY2rufA2g+q9wZb/JDIWcYMtaAoX8qgfcDOcmifZJxF7L5RM9GfdeZfj1y/kCQxKTpBYKB9afYHbwCX1qfZNByfsx8Z3UhXSmwkmUgBG9WImjliBoUQVrpWgWS0ZCr0ksZG349k9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMTPu2bN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34849C4CEFD;
	Wed, 29 Oct 2025 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740458;
	bh=LCe8V3QgmxQPWsHxmkO/HYNSTPj5l9bqGO1onywb9Xk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mMTPu2bNqJYk3z9tG/iuJ4nYdSDV85gEZL1C6DNu8xzqRyyTznoiiELCZLXzpikh/
	 USruXCAOkEL9wkNrMlQm9nP5WhqDVH1IJQm7GKFLgVUM3mpH5vJxqAotW16jesKMR6
	 xQSFSj+Bilu+P3v2LD5bFf52qrDvbeK4U1bCvVdQV+mcH8GjECbCHqJ9b+LC2Xzc5a
	 hsjYPOlu17x+jJXzkZeT1ojFk1Hgk0SOT4e9dOQ15or4/XVxvEhLl0V5IMtg820l8O
	 UJCGgyvVr2gJp8DXecTQVageti/FrYwjh39sgXWamM25k/DxQTj/KzOTEt+cWH4k4q
	 g4vQR5DNvMmGw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:17 +0100
Subject: [PATCH v4 04/72] pidfs: raise DCACHE_DONTCACHE explicitly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-4-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LCe8V3QgmxQPWsHxmkO/HYNSTPj5l9bqGO1onywb9Xk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfU8WDTDV2jGlxfhfadWtV47U1Eb1s4VEu9kUfBAu
 vOo3cZdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5qMfw3/lKJUvgyUfdkvM1
 1sw4FyB1dEFh2ATte54V4cVGn/kdFBgZ5jxfN/+hyJovLozqNt86I0XPbp2gffbv8lTlBUzaE/6
 aMAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

While pidfs dentries are never hashed and thus retain_dentry() will never
consider them for placing them on the LRU it isn't great to always have
to go and remember that. Raise DCACHE_DONTCACHE explicitly as a visual
marker that dentries aren't kept but freed immediately instead.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 0ef5b47d796a..db236427fc2c 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -1022,6 +1022,7 @@ static int pidfs_init_fs_context(struct fs_context *fc)
 
 	fc->s_iflags |= SB_I_NOEXEC;
 	fc->s_iflags |= SB_I_NODEV;
+	ctx->s_d_flags |= DCACHE_DONTCACHE;
 	ctx->ops = &pidfs_sops;
 	ctx->eops = &pidfs_export_operations;
 	ctx->dops = &pidfs_dentry_operations;

-- 
2.47.3


