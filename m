Return-Path: <linux-fsdevel+bounces-52129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF8ADF822
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1098D3B4632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B8F21D58C;
	Wed, 18 Jun 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgVurtU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200E721B182
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280060; cv=none; b=qjL4kgF2xbVc8gbViCnZU8Pk2u3kLV3DtgWqGRPsKJGEqS8xc+1GEAXD4K5C01d/jOoEwgKxMsjkFOpsH2qa+LGN15Tvp+O2fpHKJhLobg4LXzl0683s2ELW/o9m4kbcw/cSYPjnlJGhVtdTWkHPsQykC4xF+gxFZsP5m4cgixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280060; c=relaxed/simple;
	bh=9iPGGoXUy9OIHUEtN4CaxyDeSqA3T3BC9ymDPO7aOLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YkNt1RmdopNb/L0ihONHCLF9Z6zoMJ3idPfOgbv+Iar0M3esRidnCgcXMLsQkocX29ofamR5VKKyEPlIbwy6WLNlfn/hp7ZlegP0uqUWmIiV8t6KynprpzLnSSUPJlXWospxzUoGenZnKnDU4uUHWPE6RLD5a8EGfmA8fuOoox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgVurtU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA57C4CEEF;
	Wed, 18 Jun 2025 20:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280059;
	bh=9iPGGoXUy9OIHUEtN4CaxyDeSqA3T3BC9ymDPO7aOLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rgVurtU8Va+d/FA3a6EnJRmVp/T7hueg2OsAjB1uGeWASdcnLm2itI/9BxXopfLs0
	 Z/laB5vRZNAgC8ns4q0L6dD6Ui6fc0OYhgE8msDjBBd3GSuB/C5rUWq2ifzdfNKLtS
	 WGDyDFRwgvubVnHZrlEO4b9sqO8gho45BTZrO9J3aOtSXs991YY6twZk+Ff3WZ1onp
	 TY9eYFk3iswSvq35wcfOumnBcvUV8WKEvo/DRbaT6h3ocmvXeWp8gevpUc52WwQ0dM
	 bcrRT/VBF84UgAOKv7uf4PSkpot72xzaXZJN04h+9JPdI0ptkQPHrDsaEuN+5S8sql
	 gTiUtttVjp9BQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:46 +0200
Subject: [PATCH v2 12/16] pidfs: support xattrs on pidfds
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-12-98f3456fd552@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5767; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9iPGGoXUy9OIHUEtN4CaxyDeSqA3T3BC9ymDPO7aOLc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0fumSx+VKY4wGje5FKr3ILFz5a9KHtku9veU70iJ
 Gf956NmHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5eYXhn0VzE+f3J9+5M/h4
 nl13ZFgroMLZtO9dnJZVnXR51PlZoQz/VNosf69fkdp70MJiW7Kr5RPZZxe2Bj1dItd9fbL121m
 tzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we have a way to persist information for pidfs dentries we can
start supporting extended attributes on pidfds. This will allow
userspace to attach meta information to tasks.

One natural extension would be to introduce a custom pidfs.* extended
attribute space and allow for the inheritance of extended attributes
across fork() and exec().

The first simple scheme will allow privileged userspace to set trusted
extended attributes on pidfs inodes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index df5bc69ea1c0..15d99854d243 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -21,6 +21,7 @@
 #include <linux/utsname.h>
 #include <net/net_namespace.h>
 #include <linux/coredump.h>
+#include <linux/xattr.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -28,6 +29,7 @@
 #define PIDFS_PID_DEAD ERR_PTR(-ESRCH)
 
 static struct kmem_cache *pidfs_attr_cachep __ro_after_init;
+static struct kmem_cache *pidfs_xattr_cachep __ro_after_init;
 
 /*
  * Stashes information that userspace needs to access even after the
@@ -40,6 +42,7 @@ struct pidfs_exit_info {
 };
 
 struct pidfs_attr {
+	struct simple_xattrs *xattrs;
 	struct pidfs_exit_info __pei;
 	struct pidfs_exit_info *exit_info;
 };
@@ -138,14 +141,27 @@ void pidfs_remove_pid(struct pid *pid)
 
 void pidfs_free_pid(struct pid *pid)
 {
+	struct pidfs_attr *attr __free(kfree) = no_free_ptr(pid->attr);
+	struct simple_xattrs *xattrs __free(kfree) = NULL;
+
 	/*
 	 * Any dentry must've been wiped from the pid by now.
 	 * Otherwise there's a reference count bug.
 	 */
 	VFS_WARN_ON_ONCE(pid->stashed);
 
-	if (!IS_ERR(pid->attr))
-		kfree(pid->attr);
+	if (IS_ERR(attr))
+		return;
+
+	/*
+	 * Any dentry must've been wiped from the pid by now. Otherwise
+	 * there's a reference count bug.
+	 */
+	VFS_WARN_ON_ONCE(pid->stashed);
+
+	xattrs = attr->xattrs;
+	if (xattrs)
+		simple_xattrs_free(attr->xattrs, NULL);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -663,9 +679,24 @@ static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
 }
 
+static ssize_t pidfs_listxattr(struct dentry *dentry, char *buf, size_t size)
+{
+	struct inode *inode = d_inode(dentry);
+	struct pid *pid = inode->i_private;
+	struct pidfs_attr *attr = pid->attr;
+	struct simple_xattrs *xattrs;
+
+	xattrs = READ_ONCE(attr->xattrs);
+	if (!xattrs)
+		return 0;
+
+	return simple_xattr_list(inode, xattrs, buf, size);
+}
+
 static const struct inode_operations pidfs_inode_operations = {
-	.getattr = pidfs_getattr,
-	.setattr = pidfs_setattr,
+	.getattr	= pidfs_getattr,
+	.setattr	= pidfs_setattr,
+	.listxattr	= pidfs_listxattr,
 };
 
 static void pidfs_evict_inode(struct inode *inode)
@@ -905,6 +936,67 @@ static const struct stashed_operations pidfs_stashed_ops = {
 	.put_data	= pidfs_put_data,
 };
 
+static int pidfs_xattr_get(const struct xattr_handler *handler,
+			   struct dentry *unused, struct inode *inode,
+			   const char *suffix, void *value, size_t size)
+{
+	struct pid *pid = inode->i_private;
+	struct pidfs_attr *attr = pid->attr;
+	const char *name;
+	struct simple_xattrs *xattrs;
+
+	xattrs = READ_ONCE(attr->xattrs);
+	if (!xattrs)
+		return 0;
+
+	name = xattr_full_name(handler, suffix);
+	return simple_xattr_get(xattrs, name, value, size);
+}
+
+static int pidfs_xattr_set(const struct xattr_handler *handler,
+			   struct mnt_idmap *idmap, struct dentry *unused,
+			   struct inode *inode, const char *suffix,
+			   const void *value, size_t size, int flags)
+{
+	struct pid *pid = inode->i_private;
+	struct pidfs_attr *attr = pid->attr;
+	const char *name;
+	struct simple_xattrs *xattrs;
+	struct simple_xattr *old_xattr;
+
+	/* Ensure we're the only one to set @attr->xattrs. */
+	WARN_ON_ONCE(!inode_is_locked(inode));
+
+	xattrs = READ_ONCE(attr->xattrs);
+	if (!xattrs) {
+		xattrs = kmem_cache_zalloc(pidfs_xattr_cachep, GFP_KERNEL);
+		if (!xattrs)
+			return -ENOMEM;
+
+		simple_xattrs_init(xattrs);
+		smp_store_release(&pid->attr->xattrs, xattrs);
+	}
+
+	name = xattr_full_name(handler, suffix);
+	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
+	if (IS_ERR(old_xattr))
+		return PTR_ERR(old_xattr);
+
+	simple_xattr_free(old_xattr);
+	return 0;
+}
+
+static const struct xattr_handler pidfs_trusted_xattr_handler = {
+	.prefix = XATTR_TRUSTED_PREFIX,
+	.get	= pidfs_xattr_get,
+	.set	= pidfs_xattr_set,
+};
+
+static const struct xattr_handler *const pidfs_xattr_handlers[] = {
+	&pidfs_trusted_xattr_handler,
+	NULL
+};
+
 static int pidfs_init_fs_context(struct fs_context *fc)
 {
 	struct pseudo_fs_context *ctx;
@@ -918,6 +1010,7 @@ static int pidfs_init_fs_context(struct fs_context *fc)
 	ctx->ops = &pidfs_sops;
 	ctx->eops = &pidfs_export_operations;
 	ctx->dops = &pidfs_dentry_operations;
+	ctx->xattr = pidfs_xattr_handlers;
 	fc->s_fs_info = (void *)&pidfs_stashed_ops;
 	return 0;
 }
@@ -960,6 +1053,11 @@ void __init pidfs_init(void)
 	pidfs_attr_cachep = kmem_cache_create("pidfs_attr_cache", sizeof(struct pidfs_attr), 0,
 					 (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
 					  SLAB_ACCOUNT | SLAB_PANIC), NULL);
+
+	pidfs_xattr_cachep = kmem_cache_create("pidfs_xattr_cache",
+					       sizeof(struct simple_xattrs), 0,
+					       SLAB_PANIC, NULL);
+
 	pidfs_mnt = kern_mount(&pidfs_type);
 	if (IS_ERR(pidfs_mnt))
 		panic("Failed to mount pidfs pseudo filesystem");

-- 
2.47.2


