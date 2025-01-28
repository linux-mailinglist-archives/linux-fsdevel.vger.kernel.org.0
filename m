Return-Path: <linux-fsdevel+bounces-40219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FCBA2089F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D52A3A526C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC6F1A01CC;
	Tue, 28 Jan 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A30bnOel"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E621A00F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060457; cv=none; b=MPg0+i1E0Bcg7bKi8cZaLtLLRnRXrFQ7TsB9BhZ5D11Kv7bOtl0tS99qu88OOnZzSSBmnjhvpA919tb13OpOFBV1VMnj+gzGoGnk5w/dxD0/cZsil9vbzxpAttDaVZkWY8f1er+PWwCjmTI3F32gj5Dnasdad8KF+2YsijwWniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060457; c=relaxed/simple;
	bh=GxNn3m7pFY1XpP8XNi22kWt9J2oDrzLmQKuPaEu5Fnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDEDFYRJ5ODa50lGIOAbLKKekDv/Gd3SKCk0S3bNU7fqEkTQRdhj/+M3lGm1lwwOKQMKGKV/IzMCyzvaEQmmboodhWBxmnMw8rj9VSg82T4RYvg+2fR27OR4lNTLvzY7bTBTaE+Rd4g92WSCHKIaHh3LmMJXO8M6y6C0Jil7CT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A30bnOel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A334C4CEE4;
	Tue, 28 Jan 2025 10:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738060455;
	bh=GxNn3m7pFY1XpP8XNi22kWt9J2oDrzLmQKuPaEu5Fnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A30bnOel+fHf3yRBvrU9MdChsL5UxRkttutn/LA16n8cdAtPM+3nMzsVjMooiZ8pG
	 E/gk2bvPKt+kJ8PpXramXitY0m1o8djj82jDs5awN+ODzLtDcmJnl0ACQAgI88tr50
	 Iizjb4kaWPTkB7R387WBJpKcpwh8kbAvX6dlPQ9944dGFfUh40wrD4XnufffMh1ClS
	 dcl3JBFrZTHl2Zz2J2zN5joaCfhSTFVvUnGN4vqsd+TWITyglPmncC/JIaIKOUM7CN
	 vUGMbghpm3Qny1LkPKhgfbqYq6mPkstt40AO2PiM3VyBm+k3MCSzy43EJlF58LLT4+
	 C4ysgGXpASOWA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Jan 2025 11:33:43 +0100
Subject: [PATCH 5/5] fs: allow changing idmappings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-work-mnt_idmap-update-v2-v1-5-c25feb0d2eb3@kernel.org>
References: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>
In-Reply-To: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.com>, Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=4507; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GxNn3m7pFY1XpP8XNi22kWt9J2oDrzLmQKuPaEu5Fnw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2DStb/6b395lh6b+l7t55/Kjvzp2O9P2/bd+O9fyQ
 eZON5XciI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJpL1nZGjvX5wmcEzi3aOv
 fstlJysar3kYmh9x4P6xnLDiSdm7OWYz/M95c+RNwqbPV9x2CGsr1VnYGB++NjE4s/CgRdCba69
 OHOIAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This patchset makes it possible to create a new idmapped mount from an
already idmapped mount and to clear idmappings.

// Create a first idmapped mount
struct mount_attr attr = {
        .attr_set = MOUNT_ATTR_IDMAP
        .userns_fd = fd_userns
};

fd_tree = open_tree(-EBADF, "/", OPEN_TREE_CLONE, &attr, sizeof(attr));
move_mount(fd_tree, "", -EBADF, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

// Create a second idmapped mount from the first idmapped mount
attr.attr_set = MOUNT_ATTR_IDMAP;
attr.userns_fd = fd_userns2;
fd_tree2 = open_tree(-EBADF, "/mnt", OPEN_TREE_CLONE, &attr, sizeof(attr));

// Create a second non-idmapped mount from the first idmapped mount:
memset(&attr, 0, sizeof(attr));
attr.attr_clr = MOUNT_ATTR_IDMAP;
fd_tree2 = open_tree(-EBADF, "/mnt", OPEN_TREE_CLONE, &attr, sizeof(attr));

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 53 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2405f839202b3916bcdc4304599996a55ce5deb7..453edc27b2a46c6b6c9a321af8769f3ee1de147a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -86,6 +86,7 @@ static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
 
 enum mount_kattr_flags_t {
 	MOUNT_KATTR_RECURSE		= (1 << 0),
+	MOUNT_KATTR_IDMAP_REPLACE	= (1 << 1),
 };
 
 struct mount_kattr {
@@ -4519,11 +4520,10 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 		return -EINVAL;
 
 	/*
-	 * Once a mount has been idmapped we don't allow it to change its
-	 * mapping. It makes things simpler and callers can just create
-	 * another bind-mount they can idmap if they want to.
+	 * We only allow an mount to change it's idmapping if it has
+	 * never been accessible to userspace.
 	 */
-	if (is_idmapped_mnt(m))
+	if (!(kattr->kflags & MOUNT_KATTR_IDMAP_REPLACE) && is_idmapped_mnt(m))
 		return -EPERM;
 
 	/* The underlying filesystem doesn't support idmapped mounts yet. */
@@ -4613,18 +4613,16 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 
 static void do_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 {
+	struct mnt_idmap *old_idmap;
+
 	if (!kattr->mnt_idmap)
 		return;
 
-	/*
-	 * Pairs with smp_load_acquire() in mnt_idmap().
-	 *
-	 * Since we only allow a mount to change the idmapping once and
-	 * verified this in can_idmap_mount() we know that the mount has
-	 * @nop_mnt_idmap attached to it. So there's no need to drop any
-	 * references.
-	 */
+	old_idmap = mnt_idmap(&mnt->mnt);
+
+	/* Pairs with smp_load_acquire() in mnt_idmap(). */
 	smp_store_release(&mnt->mnt.mnt_idmap, mnt_idmap_get(kattr->mnt_idmap));
+	mnt_idmap_put(old_idmap);
 }
 
 static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
@@ -4733,13 +4731,23 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 	if (!((attr->attr_set | attr->attr_clr) & MOUNT_ATTR_IDMAP))
 		return 0;
 
-	/*
-	 * We currently do not support clearing an idmapped mount. If this ever
-	 * is a use-case we can revisit this but for now let's keep it simple
-	 * and not allow it.
-	 */
-	if (attr->attr_clr & MOUNT_ATTR_IDMAP)
-		return -EINVAL;
+	if (attr->attr_clr & MOUNT_ATTR_IDMAP) {
+		/*
+		 * We can only remove an idmapping if it's never been
+		 * exposed to userspace.
+		 */
+		if (!(kattr->kflags & MOUNT_KATTR_IDMAP_REPLACE))
+			return -EINVAL;
+
+		/*
+		 * Removal of idmappings is equivalent to setting
+		 * nop_mnt_idmap.
+		 */
+		if (!(attr->attr_set & MOUNT_ATTR_IDMAP)) {
+			kattr->mnt_idmap = &nop_mnt_idmap;
+			return 0;
+		}
+	}
 
 	if (attr->userns_fd > INT_MAX)
 		return -EINVAL;
@@ -4830,8 +4838,10 @@ static int build_mount_kattr(const struct mount_attr *attr, size_t usize,
 
 static void finish_mount_kattr(struct mount_kattr *kattr)
 {
-	put_user_ns(kattr->mnt_userns);
-	kattr->mnt_userns = NULL;
+	if (kattr->mnt_userns) {
+		put_user_ns(kattr->mnt_userns);
+		kattr->mnt_userns = NULL;
+	}
 
 	if (kattr->mnt_idmap)
 		mnt_idmap_put(kattr->mnt_idmap);
@@ -4926,6 +4936,7 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 		int ret;
 		struct mount_kattr kattr = {};
 
+		kattr.kflags = MOUNT_KATTR_IDMAP_REPLACE;
 		if (flags & AT_RECURSIVE)
 			kattr.kflags |= MOUNT_KATTR_RECURSE;
 

-- 
2.45.2


