Return-Path: <linux-fsdevel+bounces-66214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E19C1A2E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BD0460517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3137340D9A;
	Wed, 29 Oct 2025 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc8vqCxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4333B971;
	Wed, 29 Oct 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740443; cv=none; b=HUBu7dSMg+8lFlF1XECPjETCIyOQqGSgfvfrUh2v3Ynv8fCjQQ+d1x3ehC6qfVLBCSyL8jMWSC6TbYzEv5VGXVEjkIKJjWMzbmaizqmufL6C72M6v9v/ASVtZKYOAHUPj0P/quGdno2vfbQnx97NFrHYq5T54oXaE5woSm17ODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740443; c=relaxed/simple;
	bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1pBrtCGn8AuMBjMqdDDn7CtAEc+L5AK5qgjMRnn32eGjurb8S7TMfMYjxi+3AZbU3wAlfG3J6i8PjauTOmeBPH1Ks93iGCE9lboxRG/KSgYQMY+52/mw2Mdziw+zLPEfEeUmYdOvU7tIVFLd6ijIo/+t5EUEukJeTbA48Rgn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tc8vqCxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4141CC4CEF7;
	Wed, 29 Oct 2025 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740442;
	bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tc8vqCxM3PhDFWtRlgQKuHa3BkNGSFYezyU2mvv/D96l5xM5ui4AdIaBcridhYyAm
	 Z6P5Lj/Ze0AXCz0OCZCiSGE9Pm4/EOKzgZXxVA9lzBpqy9HKPZ6xSYbdi7X63qyvs+
	 QX+oEBIT5tcTeQ0vLXny/3/xMXUPUp1L5anZtajdvMUA6HQYq9zKEtv2wz+rLDC+Na
	 sC0IySlGVOeto2JAaLnkUNll422XIJa+tiIOtB8U3t5SL4CrUyU7J5wKFjquOWVJRK
	 O6wiRWvIoxjZkhFWJUIBo43eHS3IObkSZPEJFXwyCRdvwEOEz5So6ekDj0gB6P6M8x
	 SV74gAQpCLYZQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:14 +0100
Subject: [PATCH v4 01/72] libfs: allow to specify s_d_flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-1-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGkCBougAjDiXYgqCRIZaGzXup9wqsN5vCdWUL+Tr38iLZdOo
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkCBosACgkQkcYbwGV43KL7bwD8D27M
 4wpDwoRBW2EgzGDw0yzYqq9jEb7V+aKU05lMd5kA/3slaCdfVtPZPIIYG0f0rD5Xxz9ylCPgpOG
 xxGgKym4M
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make it possible for pseudo filesystems to specify default dentry flags.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/libfs.c                | 1 +
 include/linux/pseudo_fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index ce8c496a6940..4bb4d8a313e7 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -680,6 +680,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_export_op = ctx->eops;
 	s->s_xattr = ctx->xattr;
 	s->s_time_gran = 1;
+	s->s_d_flags |= ctx->s_d_flags;
 	root = new_inode(s);
 	if (!root)
 		return -ENOMEM;
diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
index 2503f7625d65..a651e60d9410 100644
--- a/include/linux/pseudo_fs.h
+++ b/include/linux/pseudo_fs.h
@@ -9,6 +9,7 @@ struct pseudo_fs_context {
 	const struct xattr_handler * const *xattr;
 	const struct dentry_operations *dops;
 	unsigned long magic;
+	unsigned int s_d_flags;
 };
 
 struct pseudo_fs_context *init_pseudo(struct fs_context *fc,

-- 
2.47.3


