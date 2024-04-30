Return-Path: <linux-fsdevel+bounces-18228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5678B6876
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCAE1F224E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3111733;
	Tue, 30 Apr 2024 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B42x1HlQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BB10A3F;
	Tue, 30 Apr 2024 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447431; cv=none; b=e8AYN504F3LILUChksp5NnMx6fM8CWUFPf9YryUbAnyN1RbwfgbE4IF66ljxqifoPP/GaPPOL8JQmRyOiW0dW9GhxuUjOlD2QKwaA+TLBxY18fMFIRkXXRZ7s54NyxjBLJJFY2RbQEOgjCbHvc2Qp3+io1SFAAZYPVkY78/G618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447431; c=relaxed/simple;
	bh=f/q/8Pg1yqf8nV7BNiKy+M1eRlvHGlS24IF9opJVzts=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXwvtrH8n9Q+EkQcRA8HxtOAvI2QblVusjX1lqwBLEMG+dHgDUSDb5K/ZhUJvP+BhvzFyh9/CN4YGXKs5sirJRQQBh76K6Bw3wh0DiVY5ZXToz+DMKkLnOAaVTbwWfSA3zkLCR3jV6uTSu9t/5tqEO15zyydSrbnLARKHYJwm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B42x1HlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E2AC116B1;
	Tue, 30 Apr 2024 03:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447431;
	bh=f/q/8Pg1yqf8nV7BNiKy+M1eRlvHGlS24IF9opJVzts=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=B42x1HlQcvH5t9zmfiZFGbMVaFUjgrhVj6Alx7u1Ua/nI0ZbyKe2/M33LAgTqW+NV
	 0NLLmgvzSWIB7rlgCFsoSGMSrpKVtVgfznLexvKKdrC7yA8MCM4anaOMfrboVJPd+q
	 r899N8t7/UWFYfryL1YiAMYviOHgzci6WmcD1G0ydlEr9iLcJ/jVXA3kHNTauT0BHV
	 ig0zZBIScYQEcHA5W8tVvmRtaAl6aVstduLqF9+iFRgl5j9xb7AHKebeTO4D7GJvtX
	 OlPXbWlfzPqDha7oFgh9THUAaA6siJl151oYEffVm4qQjrJq/tk6YJWWkXCpR/dTT/
	 g3CiZbSutdKCg==
Date: Mon, 29 Apr 2024 20:23:50 -0700
Subject: [PATCH 17/18] fsverity: remove system-wide workqueue
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679874.955480.9289584578124891569.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Now that we've made the verity workqueue per-superblock, we don't need
the systemwide workqueue.  Get rid of the old implementation.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/fsverity_private.h |    2 --
 fs/verity/init.c             |    1 -
 fs/verity/verify.c           |   21 +--------------------
 3 files changed, 1 insertion(+), 23 deletions(-)


diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 20208425e56fc..b6273615f76af 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -155,8 +155,6 @@ static inline void fsverity_init_signature(void)
 
 /* verify.c */
 
-void __init fsverity_init_workqueue(void);
-
 int fsverity_read_merkle_tree_block(struct inode *inode,
 				    const struct merkle_tree_params *params,
 				    int level, u64 pos, unsigned long ra_bytes,
diff --git a/fs/verity/init.c b/fs/verity/init.c
index 3769d2dc9e3b4..4663696c6996c 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -66,7 +66,6 @@ static int __init fsverity_init(void)
 {
 	fsverity_check_hash_algs();
 	fsverity_init_info_cache();
-	fsverity_init_workqueue();
 	fsverity_init_sysctl();
 	fsverity_init_signature();
 	fsverity_init_bpf();
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index e1fab60303d6d..a30eac895338e 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -10,8 +10,6 @@
 #include <crypto/hash.h>
 #include <linux/bio.h>
 
-static struct workqueue_struct *fsverity_read_workqueue;
-
 /*
  * Returns true if the hash @block with index @hblock_idx in the merkle tree
  * for @inode has already been verified.
@@ -375,27 +373,10 @@ EXPORT_SYMBOL_GPL(fsverity_init_wq);
 void fsverity_enqueue_verify_work(struct super_block *sb,
 				  struct work_struct *work)
 {
-	queue_work(sb->s_verity_wq ?: fsverity_read_workqueue, work);
+	queue_work(sb->s_verity_wq, work);
 }
 EXPORT_SYMBOL_GPL(fsverity_enqueue_verify_work);
 
-void __init fsverity_init_workqueue(void)
-{
-	/*
-	 * Use a high-priority workqueue to prioritize verification work, which
-	 * blocks reads from completing, over regular application tasks.
-	 *
-	 * For performance reasons, don't use an unbound workqueue.  Using an
-	 * unbound workqueue for crypto operations causes excessive scheduler
-	 * latency on ARM64.
-	 */
-	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
-						  WQ_HIGHPRI,
-						  num_online_cpus());
-	if (!fsverity_read_workqueue)
-		panic("failed to allocate fsverity_read_queue");
-}
-
 /**
  * fsverity_read_merkle_tree_block() - read Merkle tree block
  * @inode: inode to which this Merkle tree block belongs


