Return-Path: <linux-fsdevel+bounces-62291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B67B8C263
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C35188DCC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F26C2EAB6C;
	Sat, 20 Sep 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JayErOdQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44AB275870;
	Sat, 20 Sep 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354487; cv=none; b=GkxuhCqstbg8nBXytrENsHxRQ2QeRA80LQoZfMEjCdd4g96MueC2dfR/XhgVCm6lGpLKzO8mQRXoLwX1e+530OLlvf5qrl7spYviHyPYviblw8TUreyLZFbvaSQo72Kae4yGXTm2FpIfM0TJYtMjZLQvRTqxqDsJ1MrzrjO20pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354487; c=relaxed/simple;
	bh=tmbPhYZSDd1UPvxu6/KEJ2Zu2xeZMAO+TJ36jH48FLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFCMKe/s5ySissWQ5OZpft5T5tUON/040a12VtWqvcdWBixAvVEdeArl0xb76TP8ZXKgqAcv5GzU7L7AIdo5TjG4qx/7ZWwp3If5ZzQneF007laUgc06Bn2kdQX4SfzhfGuQkgTBk4BT28Q3kZcFZvyKZIGahyEGzEaGCfo672c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JayErOdQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mdhevqsdWuF/cKTAc0dIZQiRUrUONHeuOHhbEA+hz9E=; b=JayErOdQO97E9P8HOT624tcwlV
	zR8JXRCLGJ/YGzM/Vh9C5VjfvI9cd7nCM4RnGAu6RjeKHfoCfXvj5oBQSOtDyLKTCtQjdynyimT8h
	L9/AyYpzJq/9KmPl1R1y28blWi1Zj+Vt1UiKPY/b6vnV9u+MsMHjatQ0eipe59pqyFMZ4ZfjjXa3g
	tclJ92LsYJjvNW9qDXplpZ9jPIFBYmzZXyKaPFZyhfayHKUMR6fQqtwzJmjMPjxA8Tqafvs+QxgfZ
	pB8Hd6CLqUbf0ATlajREcOgypejOhuBgOeXAh1nSHxfTE6iVKb/JYZBJaEqw1/BWTVOcRacla8XDK
	OnKcOctw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsKA-0000000ExEm-3DMp;
	Sat, 20 Sep 2025 07:48:02 +0000
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
Subject: [PATCH 18/39] convert debugfs
Date: Sat, 20 Sep 2025 08:47:37 +0100
Message-ID: <20250920074759.3564072-18-viro@zeniv.linux.org.uk>
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

similar to tracefs - simulation of normal codepath for creation,
simple_recursive_removal() for removal.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/inode.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index c12d649df6a5..1302995d6816 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -329,7 +329,7 @@ static struct file_system_type debug_fs_type = {
 	.name =		"debugfs",
 	.init_fs_context = debugfs_init_fs_context,
 	.parameters =	debugfs_param_specs,
-	.kill_sb =	kill_litter_super,
+	.kill_sb =	kill_anon_super,
 };
 MODULE_ALIAS_FS("debugfs");
 
@@ -404,16 +404,15 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 
 static struct dentry *failed_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	dput(dentry);
+	simple_done_creating(dentry);
 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 	return ERR_PTR(-ENOMEM);
 }
 
 static struct dentry *end_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	return dentry;
+	simple_done_creating(dentry);
+	return dentry; // borrowed
 }
 
 static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
@@ -455,7 +454,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	DEBUGFS_I(inode)->raw = real_fops;
 	DEBUGFS_I(inode)->aux = (void *)aux;
 
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
 	return end_creating(dentry);
 }
@@ -601,7 +600,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
 	return end_creating(dentry);
@@ -648,7 +647,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	DEBUGFS_I(inode)->automount = f;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
 	return end_creating(dentry);
@@ -703,7 +702,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
 	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	return end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
-- 
2.47.3


