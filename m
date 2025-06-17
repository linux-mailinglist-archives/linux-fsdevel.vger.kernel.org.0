Return-Path: <linux-fsdevel+bounces-51937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C39EADD2FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ED13A22E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C72ED877;
	Tue, 17 Jun 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp1PK9zb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9A2ED17D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175135; cv=none; b=RcjrZty3mlZ0TzvJOiJsWrZq0+3iWG0wARzmdjbKFUbpNRtabrBSdJqfhZQMwhkW3z+PRGyCtWTUatWPtmIAQPkbajoBAmak7lj4ij+lEmYzZwVXiZZIUKrGerGELXyAK0ji2cDbUR/BnJg2rR8TI6IqBii9C7AA43XstQ+wDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175135; c=relaxed/simple;
	bh=+LOp6S8WwxkKvDOmo1omx2+xseXk0Bs5gCUaKppoAtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KnMTVaDPIpzJ15R86/BewoBxD2P4DFRdn2CKdYGZ5AbgzvbtKWIS9CPcXR4vJ/NPBECBAMpGYuWnDqfSaiTX6DocN2tQ1SL888AvfkTqn+HNl4pu9TDaxgvTDhql9AqTkei5i0vhJqXs8lu/AW+1YX4sKoJu7RQqyvmCpvDCIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp1PK9zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B686EC4CEE7;
	Tue, 17 Jun 2025 15:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750175134;
	bh=+LOp6S8WwxkKvDOmo1omx2+xseXk0Bs5gCUaKppoAtw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dp1PK9zbDYjtb0Rr578joOF1SqJ1m/VwK2ZTxJUvzfxLqBT8NAN/tgMQMpsdHLzo3
	 5AqPhxpAz61UMfWL6n2/KWHxKg/7mfKv1B90TJgD51GR3/398LIeRg9Z501jE7xY4s
	 SQVsfA7hKS2awjl5EwG7J9UthC3WnCfdw8UlsY8ifGoN9Vi8ImciHAnrKH/TZNWxV8
	 knUILk4ROoBMhNKQsDDbLCgsD/HKw7dIsFQQlAGk71G+pAgkxyYx/qFXZnKOUigX7F
	 ExLzmSuA/94SgdHCnqpqtinfSBnPzQRzTBZIrUvtE01CIs+fNSLkxl9j+fWDTZFvMZ
	 1k0v612Jxx1OA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Jun 2025 17:45:14 +0200
Subject: [PATCH RFC 4/7] pidfs: support xattrs on pidfds
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-work-pidfs-xattr-v1-4-d9466a20da2e@kernel.org>
References: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4898; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+LOp6S8WwxkKvDOmo1omx2+xseXk0Bs5gCUaKppoAtw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9k48LT3Z7MzXyTwuVs2vNtwvvOL27uxS5uXp16962
 XW/YPAy6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIP2dGhqUNBvOPy6avDp/O
 XO5vHa37Yi/vtk9eL5+v+XjFfvLmtW0M/7Qq4o8JXHyuwzH92wdRwc53Xl5ef8TW3pH9Lz310np
 zHzYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 1343bfc60e3f..b1968f628417 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -21,6 +21,7 @@
 #include <linux/utsname.h>
 #include <net/net_namespace.h>
 #include <linux/coredump.h>
+#include <linux/xattr.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -40,6 +41,7 @@
 #define PIDFS_PID_DEAD ERR_PTR(-ESRCH)
 
 static struct kmem_cache *pidfs_cachep __ro_after_init;
+static struct kmem_cache *pidfs_attrs_cachep __ro_after_init;
 
 /*
  * Stashes information that userspace needs to access even after the
@@ -51,9 +53,14 @@ struct pidfs_exit_info {
 	__u32 coredump_mask;
 };
 
+struct pidfs_attrs {
+	struct simple_xattrs xattrs;
+};
+
 struct pidfs_inode {
 	struct pidfs_exit_info __pei;
 	struct pidfs_exit_info *exit_info;
+	struct pidfs_attrs *attrs;
 	struct inode vfs_inode;
 };
 
@@ -672,15 +679,34 @@ static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
 }
 
+static ssize_t pidfs_listxattr(struct dentry *dentry, char *buf, size_t size)
+{
+	struct inode *inode = d_inode(dentry);
+	struct pidfs_attrs *attrs;
+
+	attrs = READ_ONCE(pidfs_i(inode)->attrs);
+	if (!attrs)
+		return -ENODATA;
+
+	return simple_xattr_list(inode, &attrs->xattrs, buf, size);
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
 {
 	struct pid *pid = inode->i_private;
+	struct pidfs_attrs *attrs;
 
+	attrs = READ_ONCE(pidfs_i(inode)->attrs);
+	if (attrs) {
+		simple_xattrs_free(&attrs->xattrs, NULL);
+		kmem_cache_free(pidfs_attrs_cachep, attrs);
+	}
 	clear_inode(inode);
 	put_pid(pid);
 }
@@ -695,6 +721,7 @@ static struct inode *pidfs_alloc_inode(struct super_block *sb)
 
 	memset(&pi->__pei, 0, sizeof(pi->__pei));
 	pi->exit_info = NULL;
+	pi->attrs = NULL;
 
 	return &pi->vfs_inode;
 }
@@ -951,6 +978,63 @@ static const struct stashed_operations pidfs_stashed_ops = {
 	.put_data	= pidfs_put_data,
 };
 
+static int pidfs_xattr_get(const struct xattr_handler *handler,
+			   struct dentry *unused, struct inode *inode,
+			   const char *suffix, void *value, size_t size)
+{
+	const char *name;
+	struct pidfs_attrs *attrs;
+
+	attrs = READ_ONCE(pidfs_i(inode)->attrs);
+	if (!attrs)
+		return -ENODATA;
+
+	name = xattr_full_name(handler, suffix);
+	return simple_xattr_get(&attrs->xattrs, name, value, size);
+}
+
+static int pidfs_xattr_set(const struct xattr_handler *handler,
+			   struct mnt_idmap *idmap, struct dentry *unused,
+			   struct inode *inode, const char *suffix,
+			   const void *value, size_t size, int flags)
+{
+	const char *name;
+	struct pidfs_attrs *attrs;
+	struct simple_xattr *old_xattr;
+
+	/* Make sure we're the only one here. */
+	WARN_ON_ONCE(!inode_is_locked(inode));
+
+	attrs = READ_ONCE(pidfs_i(inode)->attrs);
+	if (!attrs) {
+		attrs = kmem_cache_zalloc(pidfs_attrs_cachep, GFP_KERNEL);
+		if (!attrs)
+			return -ENOMEM;
+
+		simple_xattrs_init(&attrs->xattrs);
+		smp_store_release(&pidfs_i(inode)->attrs, attrs);
+	}
+
+	name = xattr_full_name(handler, suffix);
+	old_xattr = simple_xattr_set(&attrs->xattrs, name, value, size, flags);
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
@@ -964,6 +1048,7 @@ static int pidfs_init_fs_context(struct fs_context *fc)
 	ctx->ops = &pidfs_sops;
 	ctx->eops = &pidfs_export_operations;
 	ctx->dops = &pidfs_dentry_operations;
+	ctx->xattr = pidfs_xattr_handlers;
 	fc->s_fs_info = (void *)&pidfs_stashed_ops;
 	return 0;
 }
@@ -1073,6 +1158,11 @@ void __init pidfs_init(void)
 					 (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
 					  SLAB_ACCOUNT | SLAB_PANIC),
 					 pidfs_inode_init_once);
+
+	pidfs_attrs_cachep = kmem_cache_create("pidfs_attrs_cache",
+					       sizeof(struct pidfs_attrs), 0,
+					       SLAB_PANIC, NULL);
+
 	pidfs_mnt = kern_mount(&pidfs_type);
 	if (IS_ERR(pidfs_mnt))
 		panic("Failed to mount pidfs pseudo filesystem");

-- 
2.47.2


