Return-Path: <linux-fsdevel+bounces-65133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77849BFD07C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10E9034780D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF568296BA8;
	Wed, 22 Oct 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaPsLC0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04211246764;
	Wed, 22 Oct 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149192; cv=none; b=Llxzg9p/8k0ZWbGDSKHjdKJ1N4m0vzO3AHqN4wzW2bkLXF1VMh5r6sz/5Ef6N4KAYDRtbXSsDFmYIfm8vdA0IgNYoMUyz+b0qmw5YFhIoL3cMmi9XfwP6jF67WoKAVGdkvD1A7OXytXlYF/4u83N4jngPtjbKoKEQrS4QoKypiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149192; c=relaxed/simple;
	bh=KoKI9phRTGMhjpn+9D8BgtjcoxSIgpJa0JnjxzKpEbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwtWnzk5WhD0CnhBFt+vEtDgH9zmanyjPwMgjFE+uAITZeOXzfQz3Xegg0sWgfoxyIvGHZ7GPpHIXN0pYUro50HiYjL4V8wym+7LHUyqNZ6uqRKOzg1HIdSYBVoC6RL8ggbxNt4gziwXI4ZXlU5zBsHZ0sXza7x5tvWHypJ/1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaPsLC0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBCDC4CEF7;
	Wed, 22 Oct 2025 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149191;
	bh=KoKI9phRTGMhjpn+9D8BgtjcoxSIgpJa0JnjxzKpEbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kaPsLC0Kr59/ZM2zoqoz9UqFSqZJd2U5vFpwbLr/UHs1HbGJLizo/7CkWwNa/R+7r
	 jL76e9CrN/WCtzRZSU7Lesna832v9/PteqX0VgdhGGoNgftR8UV4+pz/UKebzcWTK3
	 Dbej41WnhueynxU7K/4n/QVP6WqBFv+uG2+ug2v39KEXYXzYx0xhsOSM7eAx2m3qE8
	 OkcDXc5JRC0BrTHU6MtD6gO9tdj011GVJPFE5UXHPHho+Vyg+uPc33tZNtITXKAQWE
	 2fiYe+GaoCl+YMwpKEpFbTXUMgzOPbgNwzQBAVnKlf2dsyuCNMSOT43mMxVT04hkBM
	 r3q3v/JInDKgQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:43 +0200
Subject: [PATCH v2 05/63] nsfs: raise SB_I_NODEV and SB_I_NOEXEC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-5-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHiSLHZkhtzEN5K6h5MfPMk85ncrf+rCx6KP/omtN
 M99Lb1NqaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiV+oYGVYe4077wdI3/YvT
 ZRnbjKh9oVXKm2W+d09g0DoufvuScTTD/+znec0hTs8+O2wsbdlxvFPslH/ppgWPD7vIOi9e/+2
 uHh8A
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


