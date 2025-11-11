Return-Path: <linux-fsdevel+bounces-67834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84FBC4BF96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4875A189D16D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A480357A52;
	Tue, 11 Nov 2025 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="srH0KwSE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C48347FEA;
	Tue, 11 Nov 2025 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844135; cv=none; b=tW6FntjHbOeioyg+gJWvHIKEGF9tzqbr4GYmrGOYTObbzNUOs7G9f4MwH7Uvuc83bCYq3PENNf13Y4qgfV3cNhbgknXIUuyMT43BS/sz+3HiTEl8GCXy5XK1xkoQPlxllESA4+jlbueMKbmjSxz5VNMLIxBu6S2KmIOYwghHKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844135; c=relaxed/simple;
	bh=qQDGAzXgYN6NfbzcXi0oWbzU++36rpBDhX5KI8HQOik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfT+FbsJ2canH9hQC7r0qrsgH1LHrPoM4OHfEzTPFrJjlp/+2c4LbU7t5GCtAtrZz8xtS72A310l6st5Htp+WBOJ0huLaMP7AKROsjbae/Uh1CEyH02IjPdXaecUgFsxHPhLxgGcMXTrrCirtYBHUcc5UphO+wcQ7CSVogjnfNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=srH0KwSE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IB7wA0wn9kq4oYSSbdEKk+jzajBsWCKDcw62G4pXAEY=; b=srH0KwSE2XsBNhJ6Pa1lnRKFR+
	AuxixTwC5eVEpKdlKzlXERKEphmWCTV5jwTiid5LIGq8WPQXx/nyCSgJvSuGK1kxcLDwXDC6gIwG9
	XSd596rNfpN2/yiXLm3uTaI5i7gaoUZfFFMcCzrzHsrkZZ7k7sdY5OyeRsQl5GJtsJ8yXp5iyieY6
	IfazwKAfVCOu5sMeIEKWfVm0Wc1O5Z130dot9wAtZrHqcV78om3ILEo+aW213DTBA0WagLtFQvJb5
	NKpNLXJHp2OvoCyCa/zzHIEMnUThF83cBP4/a5DpwKJafTjOVGYVeFg8Sr4JqcUMS77ow8q+VXDBX
	RauEKAtQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHm-0000000Bx06-17qr;
	Tue, 11 Nov 2025 06:55:26 +0000
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
Subject: [PATCH v3 31/50] convert autofs
Date: Tue, 11 Nov 2025 06:55:00 +0000
Message-ID: <20251111065520.2847791-32-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

creation/removal is via normal VFS paths; make ->mkdir() and ->symlink()
use d_make_persistent(); ->rmdir() and ->unlink() - d_make_discardable()
instead of dput() and that's it.

d_make_persistent() works for unhashed just fine...

Note that only persistent dentries are ever hashed there; unusual absense
of ->d_delete() in dentry_operations is due to that - anything that has
refcount reach 0 will be unhashed there, so it won't get to checking
->d_delete anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/autofs/inode.c |  2 +-
 fs/autofs/root.c  | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index f5c16ffba013..eb86f893efbb 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -55,7 +55,7 @@ void autofs_kill_sb(struct super_block *sb)
 	}
 
 	pr_debug("shutting down\n");
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 	if (sbi)
 		kfree_rcu(sbi, rcu);
 }
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 39794633d484..fb6c8215456c 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -594,9 +594,8 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
 	}
 	inode->i_private = cp;
 	inode->i_size = size;
-	d_add(dentry, inode);
 
-	dget(dentry);
+	d_make_persistent(dentry, inode);
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 
@@ -627,7 +626,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count--;
-	dput(dentry);
+	d_make_discardable(dentry);
 
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
@@ -709,7 +708,7 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count--;
-	dput(dentry);
+	d_make_discardable(dentry);
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
 
@@ -739,12 +738,11 @@ static struct dentry *autofs_dir_mkdir(struct mnt_idmap *idmap,
 	inode = autofs_get_inode(dir->i_sb, S_IFDIR | mode);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	d_add(dentry, inode);
 
 	if (sbi->version < 5)
 		autofs_set_leaf_automount_flags(dentry);
 
-	dget(dentry);
+	d_make_persistent(dentry, inode);
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 	inc_nlink(dir);
-- 
2.47.3


