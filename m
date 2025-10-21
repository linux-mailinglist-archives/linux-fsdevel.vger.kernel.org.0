Return-Path: <linux-fsdevel+bounces-64854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3612BF61F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E8B19A0EBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65AA333457;
	Tue, 21 Oct 2025 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ1WDaKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83932E692;
	Tue, 21 Oct 2025 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047045; cv=none; b=r8Xd/DkTHtOVa8nLRePv08L4Z/5dDdXo2/W0RopPcD23D7XVtMr9B8UUX4TgBIXvDoGDw4QfOuYeePNysys1z6Qlf03V6ia1uhRiwxzYf4TXlMrF2dBVqnI8VwAPRaEFZM5GvRpx65aWIEsITGgmCz855PBvFI2Uo1JDBTSFoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047045; c=relaxed/simple;
	bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6r2sTwJJxceonevxeoG53Uc8Ih2oUrvwpMNrYbYxPGS+l6DuJJHl0TAnF6EtYUytp0sJct6Iumy0mVLWkZE54fRPQDND6usdHcgAzTZ6wQub9l24iP0KSCQIBdc5w+QOA5dD5giuF+pXPrB8I58bEslHB7C/hYXYLpHlqEnkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ1WDaKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C55BC4CEF5;
	Tue, 21 Oct 2025 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047044;
	bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UQ1WDaKsPDEQbhZFxksWG3cs6XalP+MFAPtfhb1e27i+O56klnEYjmWmz8v+LNfEK
	 lb1u3ORIzea+YbyE2BjPo3Ri8gQc3PlDFVMRfOnrT3UJp1pB846Ww0xbmKuAygaKTh
	 hAQ+4TF0TCuO7HwF3aTUQJyq1J9YMxQK1kCUJpPzj4WOb9IugcS7bjNvekaqoqNpWa
	 tR89Rvp8R1P5HAP9EHqXKmZNnFA/LZNG2fdzqCy8uGIp0+8jYdkK6wgYY0x4Xm9Vfg
	 adVUATW/qL0yqG1lSFuIOUYkXp0ZFxqCY7iG2FBpqyIyO2EkHvnGKJumFPywN0AtDD
	 Yj43n/EdOgnug==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:09 +0200
Subject: [PATCH RFC DRAFT 03/50] nsfs: raise DCACHE_DONTCACHE explicitly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-3-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VMCLQ5Neu+JsCPfFhnjTC4pvJzkr6RMBoSrPUgoYfJM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3yz8UNP+eY1LUL1iY67rCNVCw7o3c9QiCl3cGhsv
 Ju9c2t4RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET2lDAyrBLTWhs5/fCpWX7M
 a/nysnr+fSv/6vltg33EEtWkvx0icxj+aexvenF7bsxSP5MrDrGdrcEPeoTe1UgbSOpfXu966X8
 lEwA=
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


