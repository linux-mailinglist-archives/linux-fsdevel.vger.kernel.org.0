Return-Path: <linux-fsdevel+bounces-64852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC96CBF61D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6561834E868
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496F3314C3;
	Tue, 21 Oct 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjS4sk0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D0330B0E;
	Tue, 21 Oct 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047034; cv=none; b=JtKKBLtTI2/JFgZaMzwZtSVaHjesLmw0s/oggZqAfsDJsnjefeFbBSuWSKWmKoFsgryzRmmVttEfeHpr3Yy+GHaewVu2mNenFhxyyi8T+uDz02uaL+bEhIr6ekYR7LVGbQRoT1yhKg5EhVoIFv0P756bDJB6CpivmoF24hivgG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047034; c=relaxed/simple;
	bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=neybPHJP6he+hV0y5xrBB0naoHYcZcShXNCeBwCas9vSSLVPMkCS6dsiQEaed6pWEjeVFyFJzVQfHEXVtG4M/R3k33V6+ki00hI7n0GDOsyRnDphJnAveEP3XilCgcHZckVo04QTaPGIRTVRw0cHcK3LYZ1jWVvB5YAjvUGDmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjS4sk0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EBCC4CEF5;
	Tue, 21 Oct 2025 11:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047033;
	bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mjS4sk0QTmIkELXAcJU8lcFnUD+afDGY0ZHvhxgZ5z0vJfgrh428582+xA82JXmtK
	 wkoiRI8/il4b94YRi69gbHfUo2eH/8BYM5NOXlDhDg/mxFahhQPFg9PHnZReGGoJeo
	 vZFAVJs6NADVKiiAy2LKhOs9GxpEXqnZqw6wQnViQhBjJyj8hM86obqe17lhclzI2d
	 irG33clADT5LlM6MuY4WgVdvUq2U5A/I/mv3/5DdBIJdWNbDpOp9ZqXrP2ddMuNSXM
	 JbjEPaZ3FkWMvC3nJgZ+YmLdAl5dRC2pR52e76uS3QwXtby5MtWJlKlkBbqGVNs2Zu
	 uNroZlETLDuqw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:07 +0200
Subject: [PATCH RFC DRAFT 01/50] libfs: allow to specify s_d_flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-1-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3wjXZEbEZ/TtM6uIGFxsl5R0anZ+wWStty2/6/2/
 P+jiyZFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOp7GFk2FPN/NznYaB1vobg
 fJPLK6dK6XKcjr8xfZXkkn1zGpS4fjMyHLxiKLp3+4GZp6/u52SW27chIdileu+Jnwc7TsrV3NH
 czAsA
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


