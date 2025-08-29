Return-Path: <linux-fsdevel+bounces-59611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9473FB3B2EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 08:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C21F568167
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 06:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53637216E32;
	Fri, 29 Aug 2025 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Q2PzK/DR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F78D7404E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 06:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447525; cv=none; b=QKou2K4dMIOkY5iHKZtEq/HmnC0dBuAAxtHaICtbGqkVy+5HHW8ZOmR8iNm3qfWFvamLwHE/N4GEa6cqp/vt0Z9wvPwmu+7MG3d3/OkpKGHa30Vi+Omg1HRH6djQ7/nR0yGdKqyXmPRL+oYaLuHGnnI9cFfhxf1kbKtQVaKKZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447525; c=relaxed/simple;
	bh=QrwkdN+yTq59hjNL8Eq+LMnOQOaHOAWHiMLrHdlg4Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahFvGApyBhJCiv/dLoctgfva/zY70hsoRFO7ShVUhuN/cXpY2LrODdZpvxpGyfMPiYbdzzx5pDjdRcsGA6I/YHjon0ogpEm5xTEK2lIV0hg5zWJegHhkHFJITdCVAMEu7Gz+gHBPFyKPZzSQTQjXolugl+rKbf5EHwf9CVWkBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Q2PzK/DR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZK/voTyIPwq6ntFRzRp08u4HaUCGaNAKZG3KGb5A8TY=; b=Q2PzK/DRfRogcHjcoDF3e8l6H2
	l2YXPpPclQ+WAONzMRKB54ZqVGmDN3SCwtHfGog/41uKLgWKhBjsiVmlBfPOetjlCBC+Qd/YX6cUC
	zzsAFjR+1CfTVBz7m/brN5zEEMp0UY5gp/shkAn/tb8H8zb6jM54NkAMjTFgI+jKK11lit9Oh0fuf
	TD4Np93Xt9gi0PF1I5B7TxssQparaBaaRKq2fYiBs5X402RrmUu1YswhqXfusAFxPsQvbtUB3bQ/O
	7jngVHz53rk5eBUGMS5YLdpXLGRLXWGrueetomASLCUX10XonS6KSiVOqmiHJcpjczk/clm7f7Qzi
	68uA3d0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ursEk-00000002nlD-1EM9;
	Fri, 29 Aug 2025 06:05:22 +0000
Date: Fri, 29 Aug 2025 07:05:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: [60/63] setup_mnt(): primitive for connecting a mount to filesystem
Message-ID: <20250829060522.GB659926@ZenIV>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829060306.GC39973@ZenIV>
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


