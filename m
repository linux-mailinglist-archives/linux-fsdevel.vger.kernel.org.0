Return-Path: <linux-fsdevel+bounces-59582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154BFB3AE3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27565E06D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18C2D838B;
	Thu, 28 Aug 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Q4tgZOSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DFA2F49FF
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422498; cv=none; b=TPCQ9lbrtTlIE4iW+Dv9eHQRGPdNMqg/MRm4GVvta3y01MzteMsT1nV8xZO7oQOw8XeZI2vMkAz76lLPeNPckXIHGyTENwjzmmYDz7dzWhO1nuVVUIrRc6paXCeUhse8t2m6NAVpc0+UuY5fg5P3hDohE+ziEDN1AqDwTWxiO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422498; c=relaxed/simple;
	bh=L3WQcBruLjYcxBt1colmtn2pz/6aajmQz1I/MpOcQXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAEPwJco+8ny13/s6Hy05g3eR9lYiVlcElIWycD44tEA9NWFndSZHT6o+x4zHC26AlpAemgKvTUjG2U2TXcWEBEr6ceGVhyQB0ZQsfDxiTeaOBoyik3jXsaEJ+lwnxnI70sDwNBYhhTkc+E5UbLXZc/C9yhR98xkGWoU/YhcI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Q4tgZOSj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yZh8RrybHdzU6w426GRA1eYTqhhpbz1n17MfYJTMDD0=; b=Q4tgZOSjQZvB03202xbwGdnrm8
	plJfnp30siCh3RxVyRxhe9n7+sDW+jqoIjd6qP9ZJQfhb92Ywm8VVcsAsJHshRVxTjpyeEpamLhAk
	ZfxZHH/Tg3Suam0K1IYg1ts94DuxcqYR3kK1E/sJ2ZRSfOA3JbegkzJZnT3ssEZ4PhBt/PU6VF6Kk
	z+Z4Q1P+9JxJPyw7aSdZCmI9eXJRnvNd3u08LP2vVG2DXxPXHRhsK06sZzwijaH4r9au3k+oD5rIt
	B5wTPckuVeAeM91WxSaAPrZI6DQfF31TeGRKpZBuDfxk24lE4cyoHGPtAZlPZK0jDmsNsqiZ5pLWA
	LjtsDzVw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj5-0000000F2As-0VFK;
	Thu, 28 Aug 2025 23:08:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 59/63] setup_mnt(): primitive for connecting a mount to filesystem
Date: Fri, 29 Aug 2025 00:08:02 +0100
Message-ID: <20250828230806.3582485-59-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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
index 9e16231d4561..5af609ff43bc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1195,6 +1195,21 @@ static void commit_tree(struct mount *mnt)
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
@@ -1218,15 +1233,8 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
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
@@ -1284,7 +1292,6 @@ EXPORT_SYMBOL_GPL(vfs_kern_mount);
 static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 					int flag)
 {
-	struct super_block *sb = old->mnt.mnt_sb;
 	struct mount *mnt;
 	int err;
 
@@ -1309,16 +1316,9 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
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


