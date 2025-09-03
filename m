Return-Path: <linux-fsdevel+bounces-60110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C477B41405
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC50541F7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E76F2DAFA4;
	Wed,  3 Sep 2025 04:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JsOb5SqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C12DC355
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875355; cv=none; b=AvJCpfe0ub0Nv5u5GlrqGbivP//Ve5NZwED5Bs13xKHq+c3PngUB8Yrlqfq5NTPMUX+K7GMSYGeNDbW74gexIf3Gh9OZvPzmkxcKpa3OE+o/yQLsko0pkt5Tco/V2XBmO9HWERzjcwBujLH5TpsDn36XMO/AX/PIazm3uWQppRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875355; c=relaxed/simple;
	bh=QrwkdN+yTq59hjNL8Eq+LMnOQOaHOAWHiMLrHdlg4Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URyNGKLzDY4oLFzK5QBJPOhgYba8bl5DdWk32J4rslxyZjJgs8nt6aN92VGwWzZrsS2ugQ+G2ueru0xPOjgcOAk+aI8y2nwcjT/lupoGKVBWqpBKCRpiRHCCbQSVu+dt5UX9r5iaJlRMPmcnWbfjp+560zljasMKb+EM72FTYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JsOb5SqA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZK/voTyIPwq6ntFRzRp08u4HaUCGaNAKZG3KGb5A8TY=; b=JsOb5SqAZsgEUyNwCbR+ce58jA
	kdKgCQiQUXxBiu6UmUBdH/orxgfX67ZqaX1oNkHbAmFlq3uD6XnaCR8hDEG534JF1ZypYu+iGiKVB
	NevRSWP6IZgB4E0n5nlJRFU01i4e5PEfX9FUv0kD87eeEh5wKZug/gqFotLn4ejpJ3REkITXiF1Zl
	x6tulzsLwjxfr31ZJYhr2AAJpiWaz+MOVU9PcYPphOGRyFDfLncbq9avm+HXm37WarXSu43LyyQ42
	UH2eSDyvamy+Xi5RztLJMPoebzLnWgQZfZZ1IHmndOJb+EZahZ824CC/DEsEtxWoG9EkBPDGVsoCh
	svNxRaWQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXE-0000000ApJz-20UK;
	Wed, 03 Sep 2025 04:55:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 60/63] setup_mnt(): primitive for connecting a mount to filesystem
Date: Wed,  3 Sep 2025 05:55:28 +0100
Message-ID: <20250903045537.2579614-67-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Take the identical logics in vfs_create_mount() and clone_mnt() into
a new helper that takes an empty struct mount and attaches it to
given dentry (sub)tree.

Should be called once in the lifetime of every mount, prior to making
it visible in any data structures.

After that point ->mnt_root and ->mnt_sb never change; ->mnt_root
is a counting reference to dentry and ->mnt_sb - an active reference
to superblock.

Mount remains associated with that dentry tree all the way until
the call of cleanup_mnt(), when the refcount eventually drops
to zero.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d8df1046e2f9..c769fc4051e0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1196,6 +1196,21 @@ static void commit_tree(struct mount *mnt)
 	touch_mnt_namespace(n);
 }
 
+static void setup_mnt(struct mount *m, struct dentry *root)
+{
+	struct super_block *s = root->d_sb;
+
+	atomic_inc(&s->s_active);
+	m->mnt.mnt_sb = s;
+	m->mnt.mnt_root = dget(root);
+	m->mnt_mountpoint = m->mnt.mnt_root;
+	m->mnt_parent = m;
+
+	lock_mount_hash();
+	list_add_tail(&m->mnt_instance, &s->s_mounts);
+	unlock_mount_hash();
+}
+
 /**
  * vfs_create_mount - Create a mount for a configured superblock
  * @fc: The configuration context with the superblock attached
@@ -1219,15 +1234,8 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	if (fc->sb_flags & SB_KERNMOUNT)
 		mnt->mnt.mnt_flags = MNT_INTERNAL;
 
-	atomic_inc(&fc->root->d_sb->s_active);
-	mnt->mnt.mnt_sb		= fc->root->d_sb;
-	mnt->mnt.mnt_root	= dget(fc->root);
-	mnt->mnt_mountpoint	= mnt->mnt.mnt_root;
-	mnt->mnt_parent		= mnt;
+	setup_mnt(mnt, fc->root);
 
-	lock_mount_hash();
-	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
-	unlock_mount_hash();
 	return &mnt->mnt;
 }
 EXPORT_SYMBOL(vfs_create_mount);
@@ -1285,7 +1293,6 @@ EXPORT_SYMBOL_GPL(vfs_kern_mount);
 static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 					int flag)
 {
-	struct super_block *sb = old->mnt.mnt_sb;
 	struct mount *mnt;
 	int err;
 
@@ -1310,16 +1317,9 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	if (mnt->mnt_group_id)
 		set_mnt_shared(mnt);
 
-	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
 
-	mnt->mnt.mnt_sb = sb;
-	mnt->mnt.mnt_root = dget(root);
-	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
-	mnt->mnt_parent = mnt;
-	lock_mount_hash();
-	list_add_tail(&mnt->mnt_instance, &sb->s_mounts);
-	unlock_mount_hash();
+	setup_mnt(mnt, root);
 
 	if (flag & CL_PRIVATE)	// we are done with it
 		return mnt;
-- 
2.47.2


