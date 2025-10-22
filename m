Return-Path: <linux-fsdevel+bounces-65129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD195BFD061
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D54354E4A69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65B2749C4;
	Wed, 22 Oct 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btjigmbW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E549271447;
	Wed, 22 Oct 2025 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149171; cv=none; b=cKoh8dputzKqaAHyP83MSinX6ZdapA0XQwueGN4S73uYbNwulMnYOL6AR8+A+52UX9jzBRvHVEiYPvET5sFzXSQ+hvS1aK7WJbl04+r+ScRqi9SXlxGFxxK9v/lB937uaeLyBjMPdh7eLIh0RnFQm4vpb+endnBR2Av2Yw8Zph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149171; c=relaxed/simple;
	bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxEO2f6J4N7ngG6CdsDufghRcVwRAykKoihgqp6zqsRVGB/3KHSqn71+nuMBeBMmnIblZxtAJP4ly8zneduPh+cRACqCyIYVqcG2uCm0cDQKamlNj5PQ4Ej0eYTWvhMkRJlab3Rij8u2lvg8lr3Xpi1WaTf0os5FTHh0MAbP+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btjigmbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4333C4CEF7;
	Wed, 22 Oct 2025 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149170;
	bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=btjigmbWbbwN/3bEvge/X8OntVZSvuCtouD/CcLCCA5f4WL+TPqM1epg2qMtdO0+j
	 wExyt/vuybMhyQKkgdowgY6goi7WtBSN0BZtw+ih0ARBRXAyJ69Ec5ZKMtadfDh0FX
	 c8BCngOpmPutY3nQCmJvk7SLIGvHOGZGcCR7ITUoEnHbhkNyGV52XDddnIq7I1+OIG
	 8s/jOCpGrCmJcCJrNDDXgFVIx94635duYQtibiKeX8Fql+Cg0MI84RduX3PmJEjZy1
	 bBKgycneTjV0dYFOoMCnUz8E84uYectJXpzN3srHBeXssDYk031Dz8s6uECkHlqYjf
	 ylINKMnwXB8uA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:39 +0200
Subject: [PATCH v2 01/63] libfs: allow to specify s_d_flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-1-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wpu8fA7qXxdZSYnV2Wt9hfd/qe1FdRoJcNk3AI3VvA4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHhy7t4Ds/mVCZO+zND//TxarpLt5DMPsUONswKn7
 hZlX9vs3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARhVZGhpV3F29za+zhfN5x
 9Dov7/Yox+jqW2klgcnlrxZ87vv75hzDP+37zP2Cezj1uyO0tfbv+7LawWvlzJ8Tlnblc8j5LA7
 fww4A
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


