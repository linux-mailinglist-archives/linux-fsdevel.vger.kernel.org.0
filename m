Return-Path: <linux-fsdevel+bounces-52124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6611ADF821
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBCA1BC2366
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20C021CC57;
	Wed, 18 Jun 2025 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggzHkpq0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67A1B78F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280047; cv=none; b=PvNEgZzLO/WFNtvoMEHEMJ/8Rv5R2DUP5tzO+8YUzLJbLNThyzunKzsLZLqLj4zz90LdzmCqT5bDhBlFtnVVS+tBm+CyINJHOSV1vGIg6u7u7fUBgJV7iPuS9URxQh3pw22eJGNrvbeCYo2r71yAxT83UIYZQiiRcF0FBOGJnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280047; c=relaxed/simple;
	bh=pf31ARw6XFTnsyAaZwGz6q3h4BzPLem8Ubp+3SBAklM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ow5R8+kqKaxscriuqqUY4Qzz5cQ4jsa44toZ4pNL8BBOFpEctGRTqB+aR5xGW71CN1QEEcrfaf6JGJhpf204Tl2Ru2pfyqtDG3rtdzbpVAH4E7I2JgeTmlmK6TpofHxdLQxnVeu3Jb8p3pjFdSfNmRkBQxhnQTnosQjRGLg8LGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggzHkpq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6C0C4CEE7;
	Wed, 18 Jun 2025 20:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280046;
	bh=pf31ARw6XFTnsyAaZwGz6q3h4BzPLem8Ubp+3SBAklM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ggzHkpq04ghSfxVYxD7gzwwaiAtYlz0q5sAVJ1sVZJSS4g8H34KwhvH3UkDYbR2XK
	 DAIrQoAZkOVIKIdvHwh9y1jNIUUpXdQ/WQrZTAIBEEdhn6h8E9K9RV0VQlnZzHFX93
	 eGiPW9CMRpyZ6zikJtmtyCpWEtgXXzuUpa7Cu8VOJJRvupwvCuUhFMDSbypBtVg2Wr
	 LAxdnrNFV9QxtT5LlfhS88DQaptTCQK+0Sc8dbHVHsxf8IGTeycpcH+9YSJMpFCcg2
	 HWLq0abp07NpuXovE+GK2rDkPbKpD3Qv5ZkGmgz6jKRpR2djyb9tQhjddPi/MW4fiS
	 xYuFGGm2lPohg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:41 +0200
Subject: [PATCH v2 07/16] pidfs: remove custom inode allocation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-7-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pf31ARw6XFTnsyAaZwGz6q3h4BzPLem8Ubp+3SBAklM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0dGlGYyC73j5nR33xLO2xO5Ju6PYb3RjPmJJjyx+
 9znaDB1lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATIRXjOGf3vEJacoTFq+aE9gV
 L3o49IrWXcO2pWlcPPE5XG+LlnuLM/wVz2/Sr757LYGLofKhyf7fpvo6bL9lFNfmnZ3ygmGCXCU
 jAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We don't need it anymore as persistent information is allocated lazily
and stashed in struct pid.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 72aac4f7b7d5..c49c53d6ae51 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -27,7 +27,6 @@
 
 #define PIDFS_PID_DEAD ERR_PTR(-ESRCH)
 
-static struct kmem_cache *pidfs_cachep __ro_after_init;
 static struct kmem_cache *pidfs_attr_cachep __ro_after_init;
 
 /*
@@ -45,15 +44,6 @@ struct pidfs_attr {
 	struct pidfs_exit_info *exit_info;
 };
 
-struct pidfs_inode {
-	struct inode vfs_inode;
-};
-
-static inline struct pidfs_inode *pidfs_i(struct inode *inode)
-{
-	return container_of(inode, struct pidfs_inode, vfs_inode);
-}
-
 static struct rb_root pidfs_ino_tree = RB_ROOT;
 
 #if BITS_PER_LONG == 32
@@ -686,27 +676,9 @@ static void pidfs_evict_inode(struct inode *inode)
 	put_pid(pid);
 }
 
-static struct inode *pidfs_alloc_inode(struct super_block *sb)
-{
-	struct pidfs_inode *pi;
-
-	pi = alloc_inode_sb(sb, pidfs_cachep, GFP_KERNEL);
-	if (!pi)
-		return NULL;
-
-	return &pi->vfs_inode;
-}
-
-static void pidfs_free_inode(struct inode *inode)
-{
-	kfree(pidfs_i(inode));
-}
-
 static const struct super_operations pidfs_sops = {
-	.alloc_inode	= pidfs_alloc_inode,
 	.drop_inode	= generic_delete_inode,
 	.evict_inode	= pidfs_evict_inode,
-	.free_inode	= pidfs_free_inode,
 	.statfs		= simple_statfs,
 };
 
@@ -1067,19 +1039,8 @@ void pidfs_put_pid(struct pid *pid)
 	dput(pid->stashed);
 }
 
-static void pidfs_inode_init_once(void *data)
-{
-	struct pidfs_inode *pi = data;
-
-	inode_init_once(&pi->vfs_inode);
-}
-
 void __init pidfs_init(void)
 {
-	pidfs_cachep = kmem_cache_create("pidfs_cache", sizeof(struct pidfs_inode), 0,
-					 (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
-					  SLAB_ACCOUNT | SLAB_PANIC),
-					 pidfs_inode_init_once);
 	pidfs_attr_cachep = kmem_cache_create("pidfs_attr_cache", sizeof(struct pidfs_attr), 0,
 					 (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
 					  SLAB_ACCOUNT | SLAB_PANIC), NULL);

-- 
2.47.2


