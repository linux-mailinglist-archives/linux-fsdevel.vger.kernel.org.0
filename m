Return-Path: <linux-fsdevel+bounces-62298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A4B8C29C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32323568306
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A32ECEA9;
	Sat, 20 Sep 2025 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="i+OJ/PxV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F49281375;
	Sat, 20 Sep 2025 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354488; cv=none; b=g53/KAa5DfwLemP9EY+3BEaolrTXpGyy8oyp7bsjywpU36/YznUgCObxRQtlCc65lSsRou/4KgCT4TMEHOiezKBHPlW91iHb8dRA4apKb8yU8bJaIRz4B01dtYk/FnLMAs1f2pja72k8L8um1zP3mGbIwnd/tcvns/DXGDw4pt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354488; c=relaxed/simple;
	bh=AjIrga+xOPOflS5qLphFSMuYpaEzluROEcM9P413l5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKWma3CporMNF91XTfSH8oGNijItVwSuFw6HTgokZjjWr7nEnmqeintcyE0YEdSsNb4tPgc5Ua9Cz5YvSMpGWcFXH849jy7BJSNJs9Jr+aPKdbUScDiPxqfHh+Ldd24W3dcvGk+HsGGGjcqk4i9EzsstXGqBGVAQ2XFlE01QBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=i+OJ/PxV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tT2z+6P9K4+uWY+P9oa4gJTY9OlBzdKJ3vGtwqwrgNU=; b=i+OJ/PxV0i+zEN1UV/pCBBmAu1
	GBYoW/VweRbwndK24Xf7NdzHCcO8A6oPJjshziH/PW6H11pmEc/lvptcl3mCt1cKQ27KmKAnLCN8p
	275aRw1SGU6kXTRihXlSHxM9lKGBXxOVKhxMjhAZdEwseioNCReGQpylOyklWo7FNXwKn/yHkQAwA
	F5b71tfyHPgUOlR8kfiBq9nob9/7I0lmN+Xlz5lWm6Hy9u+5yJGzf6SXo+GuiMOD3/saKK/YDoSnZ
	OCzUqvjdRYCk7wJMOWseq21+of+x4i/FNzLvjiHJjPeUUZnt53NpidpOpqLQaLMZfHRiCFg8J2Vwp
	I1n3Dl/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsKC-0000000ExGi-2cmZ;
	Sat, 20 Sep 2025 07:48:04 +0000
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
Subject: [PATCH 25/39] binderfs: use simple_start_creating()
Date: Sat, 20 Sep 2025 08:47:44 +0100
Message-ID: <20250920074759.3564072-25-viro@zeniv.linux.org.uk>
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

binderfs_binder_device_create() gets simpler, binderfs_create_dentry() simply
goes away...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binderfs.c | 43 +++++---------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 0d9d95a7fb60..41a0f3c26fcf 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -181,24 +181,11 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	}
 
 	root = sb->s_root;
-	inode_lock(d_inode(root));
-
-	/* look it up */
-	dentry = lookup_noperm(&QSTR(name), root);
+	dentry = simple_start_creating(root, name);
 	if (IS_ERR(dentry)) {
-		inode_unlock(d_inode(root));
 		ret = PTR_ERR(dentry);
 		goto err;
 	}
-
-	if (d_really_is_positive(dentry)) {
-		/* already exists */
-		dput(dentry);
-		inode_unlock(d_inode(root));
-		ret = -EEXIST;
-		goto err;
-	}
-
 	inode->i_private = device;
 	d_instantiate(dentry, inode);
 	fsnotify_create(root->d_inode, dentry);
@@ -479,24 +466,6 @@ static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
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
 struct dentry *binderfs_create_file(struct dentry *parent, const char *name,
 				    const struct file_operations *fops,
 				    void *data)
@@ -506,11 +475,10 @@ struct dentry *binderfs_create_file(struct dentry *parent, const char *name,
 	struct super_block *sb;
 
 	parent_inode = d_inode(parent);
-	inode_lock(parent_inode);
 
-	dentry = binderfs_create_dentry(parent, name);
+	dentry = simple_start_creating(parent, name);
 	if (IS_ERR(dentry))
-		goto out;
+		return dentry;
 
 	sb = parent_inode->i_sb;
 	new_inode = binderfs_make_inode(sb, S_IFREG | 0444);
@@ -538,11 +506,10 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
 	struct super_block *sb;
 
 	parent_inode = d_inode(parent);
-	inode_lock(parent_inode);
 
-	dentry = binderfs_create_dentry(parent, name);
+	dentry = simple_start_creating(parent, name);
 	if (IS_ERR(dentry))
-		goto out;
+		return dentry;
 
 	sb = parent_inode->i_sb;
 	new_inode = binderfs_make_inode(sb, S_IFDIR | 0755);
-- 
2.47.3


