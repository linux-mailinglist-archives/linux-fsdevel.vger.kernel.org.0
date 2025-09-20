Return-Path: <linux-fsdevel+bounces-62311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1948DB8C353
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0487BDE72
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BCE2EBDC0;
	Sat, 20 Sep 2025 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ies4AD/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9932F49E5;
	Sat, 20 Sep 2025 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354493; cv=none; b=hYRiZGTFZZoXVvKUCBbK+PNGfq1D4oGqEGegWB9sqnpnQ410QR/Akv92WKZwPqO0sA74o9EQbx5d6E9lhcCNyjOW+YQ3T6ZP0esD4vUoxH7ueIN1nDJVzwE2Ou30vWzGMrwHSIgITQpQCFJ5y93b6ig6bGiYsDfaLlUxDb1UQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354493; c=relaxed/simple;
	bh=McNIUAqXu4qUUnpy/u9z9Zap5mXt5Gi3Tmjpjgu3QB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0LSxJ0NQBljwftLccZQ5W3wwy921WkGJejPQ+VBP/UFLO7FDKnXqYYEZ3tVPB8+vcGJdnoW0n0Ik/XBit8GHndmMZphJlEv1blasw8oOAPAaOcnoNlhKDoYHNVIhiS0Go52jPzp/AE3xGUl5xSVIXjIF9Cg5X/lhngMJmOpfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ies4AD/s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AxXF+ZX7o2qevQIhaj7GgHO9nhvHZfJFLXJ69dxgaxo=; b=Ies4AD/sXBzLiIMnl/ZdC7Ibm2
	W2zIpILtpZKpaSMaPC3m/lcGPJwcT/lgcaPI8Wq88cjONY+ioQ0RVXzan5eukyU+dz2VWKHsevmsq
	FQA8QbUwpVZOqZNx0f8J8g6ACDW7td+o+0um73FBSFXdqeDWCg/p4qAzvQMjgouuUVEqUNNvqg4jj
	EYLRbcSUgaVdmj293jx4PQqTvZH9+WYM7dJHG70LulPeirJnDb1I617r5HBvwF5GzgVKNjgxW3o5w
	U4HrwT9VGp9SZuzokv290LBLe83wLWCw5zltOGXTEzB0gLL96JYIRyaymqy+Q7s6ul5EsE3SYVNiB
	wDxN6HUw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsKH-0000000ExN3-2cBU;
	Sat, 20 Sep 2025 07:48:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	borntraeger@linux.ibm.com
Subject: [PATCH 36/39] hypfs: don't pin dentries twice
Date: Sat, 20 Sep 2025 08:47:55 +0100
Message-ID: <20250920074759.3564072-36-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

hypfs dentries end up with refcount 2 when they are not busy.
Refcount 1 is enough to keep them pinned, and going that way
allows to simplify things nicely:
	* don't need to drop an extra reference before the
call of kill_litter_super() in ->kill_sb(); all we need
there is to reset the cleanup list - everything on it will
be taken out automatically.
	* we can make use of simple_recursive_removal() on
tree rebuilds; just make sure that only children of root
end up in the cleanup list and hypfs_delete_tree() becomes
much simpler

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/s390/hypfs/inode.c | 41 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 96409573c75d..a4dc8e13d999 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -61,33 +61,17 @@ static void hypfs_update_update(struct super_block *sb)
 
 static void hypfs_add_dentry(struct dentry *dentry)
 {
-	dentry->d_fsdata = hypfs_last_dentry;
-	hypfs_last_dentry = dentry;
-}
-
-static void hypfs_remove(struct dentry *dentry)
-{
-	struct dentry *parent;
-
-	parent = dentry->d_parent;
-	inode_lock(d_inode(parent));
-	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(d_inode(parent), dentry);
-		else
-			simple_unlink(d_inode(parent), dentry);
+	if (IS_ROOT(dentry->d_parent)) {
+		dentry->d_fsdata = hypfs_last_dentry;
+		hypfs_last_dentry = dentry;
 	}
-	d_drop(dentry);
-	dput(dentry);
-	inode_unlock(d_inode(parent));
 }
 
-static void hypfs_delete_tree(struct dentry *root)
+static void hypfs_delete_tree(void)
 {
 	while (hypfs_last_dentry) {
-		struct dentry *next_dentry;
-		next_dentry = hypfs_last_dentry->d_fsdata;
-		hypfs_remove(hypfs_last_dentry);
+		struct dentry *next_dentry = hypfs_last_dentry->d_fsdata;
+		simple_recursive_removal(hypfs_last_dentry, NULL);
 		hypfs_last_dentry = next_dentry;
 	}
 }
@@ -184,14 +168,14 @@ static ssize_t hypfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		rc = -EBUSY;
 		goto out;
 	}
-	hypfs_delete_tree(sb->s_root);
+	hypfs_delete_tree();
 	if (machine_is_vm())
 		rc = hypfs_vm_create_files(sb->s_root);
 	else
 		rc = hypfs_diag_create_files(sb->s_root);
 	if (rc) {
 		pr_err("Updating the hypfs tree failed\n");
-		hypfs_delete_tree(sb->s_root);
+		hypfs_delete_tree();
 		goto out;
 	}
 	hypfs_update_update(sb);
@@ -326,13 +310,9 @@ static void hypfs_kill_super(struct super_block *sb)
 {
 	struct hypfs_sb_info *sb_info = sb->s_fs_info;
 
-	if (sb->s_root)
-		hypfs_delete_tree(sb->s_root);
-	if (sb_info && sb_info->update_file)
-		hypfs_remove(sb_info->update_file);
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
+	hypfs_last_dentry = NULL;
 	kill_litter_super(sb);
+	kfree(sb_info);
 }
 
 static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
@@ -367,7 +347,6 @@ static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
 		BUG();
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
-	dget(dentry);
 fail:
 	inode_unlock(d_inode(parent));
 	return dentry;
-- 
2.47.3


