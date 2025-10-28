Return-Path: <linux-fsdevel+bounces-65855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D443BC12735
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7628D5E15E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3920243954;
	Tue, 28 Oct 2025 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KSdnFP3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6021B9E2;
	Tue, 28 Oct 2025 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612389; cv=none; b=Ccf/zLepulAevPNmfNWsjWuLKDHH+gTGxptYTom+OzKkror3xmy1vPVjBkO2Ez0wwCZMVVTS3ZGf/fUCBAI0STDUUgWVAGg/8v5ybzf7lSJpeIHZ+vGSoPZYem4lavdPMy0r/A9OfqyGa4stZEYqSPxPyc48v+rKvPLt7IaMmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612389; c=relaxed/simple;
	bh=ucxyEiSixCkFp4vnrdVek/gGWBQjJAc6YDDrn5D9f+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbCjvQnDvMFaufXHnnTd6u7xofUqDRERRx6TQzN1KsOyIQpOCGXt2FgSuIdLiGTxo/N4FnZnhxmUmIbf6Woyxf+qatMbrQ4kbxtVeF1R78qbA6J+AU7P9tH8pPSlqRm4c1AYTouwL2h9y7o7JVOFhH+UMjj+k8Qgfxqa1rHhwyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KSdnFP3U; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nhVZHCo/8A/9+8ahzyAjs/jwjY1fv4im71qjOl+I68U=; b=KSdnFP3Uf3Gc2L4P8+gVMs6NaY
	8h5KjzipOzsvfCYyKmYQWnr1215L9QiltbKbSAfCPYdtlxMvACmdkXsIgY0pjbW9IlTCw7R5euqlf
	g4OjTenHpmrfytwtkD3r6u1UwgCJ5oZSi9cPTgRBCQE1gyYExNmDo7jRg3oVBxODuZVblG2gX8XBd
	ycgKmhaVVXcLZm3EiuzHfXap48uE3rSIXV1wfdda5TIC/DQ33D1NhmBAYzICXl85XUA5Wg4ACHEud
	WW48GlAeR1l8HYwngXSXiHsEkgHl1SZtGhWagy+xkzsAjw6/nrvDLptr4d60gllKfhf1mfy78zba7
	IJmWfHYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqv-00000001ens-15Pf;
	Tue, 28 Oct 2025 00:46:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
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
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v2 46/50] convert rust_binderfs
Date: Tue, 28 Oct 2025 00:46:05 +0000
Message-ID: <20251028004614.393374-47-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Parallel to binderfs stuff:
	* use simple_start_creating()/simple_done_creating()/d_make_persistent()
instead of manual inode_lock()/lookup_noperm()/d_instanitate()/inode_unlock().
	* allocate inode first - simpler cleanup that way.
	* use simple_recursive_removal() instead of open-coding it.
	* switch to kill_anon_super()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binder/rust_binderfs.c | 121 +++++++------------------
 1 file changed, 33 insertions(+), 88 deletions(-)

diff --git a/drivers/android/binder/rust_binderfs.c b/drivers/android/binder/rust_binderfs.c
index 6b497146b698..c69026df775c 100644
--- a/drivers/android/binder/rust_binderfs.c
+++ b/drivers/android/binder/rust_binderfs.c
@@ -178,28 +178,17 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	}
 
 	root = sb->s_root;
-	inode_lock(d_inode(root));
-
-	/* look it up */
-	dentry = lookup_noperm(&QSTR(req->name), root);
+	dentry = simple_start_creating(root, req->name);
 	if (IS_ERR(dentry)) {
-		inode_unlock(d_inode(root));
 		ret = PTR_ERR(dentry);
 		goto err;
 	}
 
-	if (d_really_is_positive(dentry)) {
-		/* already exists */
-		dput(dentry);
-		inode_unlock(d_inode(root));
-		ret = -EEXIST;
-		goto err;
-	}
-
 	inode->i_private = device;
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
+
 	fsnotify_create(root->d_inode, dentry);
-	inode_unlock(d_inode(root));
+	simple_done_creating(dentry);
 
 	return 0;
 
@@ -472,37 +461,9 @@ static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
 	return ret;
 }
 
-static struct dentry *binderfs_create_dentry(struct dentry *parent,
-					     const char *name)
-{
-	struct dentry *dentry;
-
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry))
-		return dentry;
-
-	/* Return error if the file/dir already exists. */
-	if (d_really_is_positive(dentry)) {
-		dput(dentry);
-		return ERR_PTR(-EEXIST);
-	}
-
-	return dentry;
-}
-
 void rust_binderfs_remove_file(struct dentry *dentry)
 {
-	struct inode *parent_inode;
-
-	parent_inode = d_inode(dentry->d_parent);
-	inode_lock(parent_inode);
-	if (simple_positive(dentry)) {
-		dget(dentry);
-		simple_unlink(parent_inode, dentry);
-		d_delete(dentry);
-		dput(dentry);
-	}
-	inode_unlock(parent_inode);
+	simple_recursive_removal(dentry, NULL);
 }
 
 static struct dentry *rust_binderfs_create_file(struct dentry *parent, const char *name,
@@ -510,31 +471,23 @@ static struct dentry *rust_binderfs_create_file(struct dentry *parent, const cha
 						void *data)
 {
 	struct dentry *dentry;
-	struct inode *new_inode, *parent_inode;
-	struct super_block *sb;
-
-	parent_inode = d_inode(parent);
-	inode_lock(parent_inode);
-
-	dentry = binderfs_create_dentry(parent, name);
-	if (IS_ERR(dentry))
-		goto out;
-
-	sb = parent_inode->i_sb;
-	new_inode = binderfs_make_inode(sb, S_IFREG | 0444);
-	if (!new_inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	struct inode *new_inode;
 
+	new_inode = binderfs_make_inode(parent->d_sb, S_IFREG | 0444);
+	if (!new_inode)
+		return ERR_PTR(-ENOMEM);
 	new_inode->i_fop = fops;
 	new_inode->i_private = data;
-	d_instantiate(dentry, new_inode);
-	fsnotify_create(parent_inode, dentry);
 
-out:
-	inode_unlock(parent_inode);
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry)) {
+		iput(new_inode);
+		return dentry;
+	}
+
+	d_make_persistent(dentry, new_inode);
+	fsnotify_create(parent->d_inode, dentry);
+	simple_done_creating(dentry);
 	return dentry;
 }
 
@@ -556,34 +509,26 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
 					  const char *name)
 {
 	struct dentry *dentry;
-	struct inode *new_inode, *parent_inode;
-	struct super_block *sb;
-
-	parent_inode = d_inode(parent);
-	inode_lock(parent_inode);
-
-	dentry = binderfs_create_dentry(parent, name);
-	if (IS_ERR(dentry))
-		goto out;
+	struct inode *new_inode;
 
-	sb = parent_inode->i_sb;
-	new_inode = binderfs_make_inode(sb, S_IFDIR | 0755);
-	if (!new_inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	new_inode = binderfs_make_inode(parent->d_sb, S_IFDIR | 0755);
+	if (!new_inode)
+		return ERR_PTR(-ENOMEM);
 
 	new_inode->i_fop = &simple_dir_operations;
 	new_inode->i_op = &simple_dir_inode_operations;
 
-	set_nlink(new_inode, 2);
-	d_instantiate(dentry, new_inode);
-	inc_nlink(parent_inode);
-	fsnotify_mkdir(parent_inode, dentry);
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry)) {
+		iput(new_inode);
+		return dentry;
+	}
 
-out:
-	inode_unlock(parent_inode);
+	inc_nlink(parent->d_inode);
+	set_nlink(new_inode, 2);
+	d_make_persistent(dentry, new_inode);
+	fsnotify_mkdir(parent->d_inode, dentry);
+	simple_done_creating(dentry);
 	return dentry;
 }
 
@@ -802,7 +747,7 @@ static void binderfs_kill_super(struct super_block *sb)
 	 * During inode eviction struct binderfs_info is needed.
 	 * So first wipe the super_block then free struct binderfs_info.
 	 */
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 
 	if (info && info->ipc_ns)
 		put_ipc_ns(info->ipc_ns);
-- 
2.47.3


