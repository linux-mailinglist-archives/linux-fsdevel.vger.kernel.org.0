Return-Path: <linux-fsdevel+bounces-67849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62054C4BF8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609463BC040
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49870359711;
	Tue, 11 Nov 2025 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o6m+fY4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA957346E66;
	Tue, 11 Nov 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844138; cv=none; b=ii2I/aCCqDDoPHZ3wY/d5ReT9p3RIxKYPqhmZg+r68iIhpWzddNWZKgrN0futBbOqniZfF8lOrOnqRr3RRzWQaHPVwzC131I7CGHf12cCOb7vvLIJUjac4Uprsyv8SjQAl1Iv3hhryRyExgh+OQHIYb4rSKNg9IUs5Yi4ZsKsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844138; c=relaxed/simple;
	bh=hr2eggLL3gfFkFag7GRXjPM7dMjl1ef+LM0Ik1Xxmb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn8W0eoYmvTEucFl/D5zDXVqn1R4Ul96Az+6N5MRZtF+IAGmEb4/UhM5lvjkElSSErCKxwk0nm56XXAxNWjRCmt+UvZV4Yyq0lAi322TOvY6N02jY+Lly9PNsM0B5N2KwBS2sFa+j3PkNwY/TVFFCwHt0/MYRefXd3kPP6XpPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o6m+fY4R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+re8cgG256R+nyhDcVzLSPRAvzZcH6z0w0ygW9fyGms=; b=o6m+fY4RoDqM5DvPVGc21EmGSo
	q2cwATyLW4MqdbkO6RZ7ftV0mjw0ZeOBE4FRUA1bI4i3cEn78fZwBAcMA7EuKgujl9pmgN1eaLUYy
	9wCIu9gMJF+JbSy1etZCld8jKsUj0EMcXE7Hapo5yC5NF8hbVoeiYav5RAOL2yqXJp+IOBTpR3MAR
	LYuxVtbgRCW189Evth0KJivbYHwXQucpADFe60jOwcFknmBdMvHuB8kPeN/72pMbv5WT3M7o5XKkC
	yu5lJRSNtz39RqQrPRPRJBGSn3QvxsUD69wRn9x0r6edupfjwU9jaK3UP0Ulg6cqK2Js1cjv0vJf6
	D86Fp2HQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHl-0000000Bwzf-2uAe;
	Tue, 11 Nov 2025 06:55:25 +0000
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
Subject: [PATCH v3 26/50] convert devpts
Date: Tue, 11 Nov 2025 06:54:55 +0000
Message-ID: <20251111065520.2847791-27-viro@zeniv.linux.org.uk>
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

Two kinds of objects there - ptmx and everything else (pty).  The former is
created on mount and kept until the fs shutdown; the latter get created
and removed by tty layer (the references are borrowed into tty->driver_data).
The reference to ptmx dentry is also kept, but we only ever use it to
find ptmx inode on remount.

* turn d_add() into d_make_persistent() + dput()  both in mknod_ptmx() and
in devpts_pty_new().

* turn dput() to d_make_discardable() in devpts_pty_kill().

* switch mknod_ptmx() to simple_{start,done}_creating().

* instead of storing in pts_fs_info a reference to ptmx dentry, store a reference
to its inode, seeing that this is what we use it for.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/devpts/inode.c | 57 +++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index fdf22264a8e9..9f3de528c358 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -102,7 +102,7 @@ struct pts_fs_info {
 	struct ida allocated_ptys;
 	struct pts_mount_opts mount_opts;
 	struct super_block *sb;
-	struct dentry *ptmx_dentry;
+	struct inode *ptmx_inode; // borrowed
 };
 
 static inline struct pts_fs_info *DEVPTS_SB(struct super_block *sb)
@@ -259,7 +259,6 @@ static int devpts_parse_param(struct fs_context *fc, struct fs_parameter *param)
 static int mknod_ptmx(struct super_block *sb, struct fs_context *fc)
 {
 	int mode;
-	int rc = -ENOMEM;
 	struct dentry *dentry;
 	struct inode *inode;
 	struct dentry *root = sb->s_root;
@@ -268,18 +267,10 @@ static int mknod_ptmx(struct super_block *sb, struct fs_context *fc)
 	kuid_t ptmx_uid = current_fsuid();
 	kgid_t ptmx_gid = current_fsgid();
 
-	inode_lock(d_inode(root));
-
-	/* If we have already created ptmx node, return */
-	if (fsi->ptmx_dentry) {
-		rc = 0;
-		goto out;
-	}
-
-	dentry = d_alloc_name(root, "ptmx");
-	if (!dentry) {
+	dentry = simple_start_creating(root, "ptmx");
+	if (IS_ERR(dentry)) {
 		pr_err("Unable to alloc dentry for ptmx node\n");
-		goto out;
+		return PTR_ERR(dentry);
 	}
 
 	/*
@@ -287,9 +278,9 @@ static int mknod_ptmx(struct super_block *sb, struct fs_context *fc)
 	 */
 	inode = new_inode(sb);
 	if (!inode) {
+		simple_done_creating(dentry);
 		pr_err("Unable to alloc inode for ptmx node\n");
-		dput(dentry);
-		goto out;
+		return -ENOMEM;
 	}
 
 	inode->i_ino = 2;
@@ -299,23 +290,18 @@ static int mknod_ptmx(struct super_block *sb, struct fs_context *fc)
 	init_special_inode(inode, mode, MKDEV(TTYAUX_MAJOR, 2));
 	inode->i_uid = ptmx_uid;
 	inode->i_gid = ptmx_gid;
+	fsi->ptmx_inode = inode;
 
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
 
-	fsi->ptmx_dentry = dentry;
-	rc = 0;
-out:
-	inode_unlock(d_inode(root));
-	return rc;
+	simple_done_creating(dentry);
+
+	return 0;
 }
 
 static void update_ptmx_mode(struct pts_fs_info *fsi)
 {
-	struct inode *inode;
-	if (fsi->ptmx_dentry) {
-		inode = d_inode(fsi->ptmx_dentry);
-		inode->i_mode = S_IFCHR|fsi->mount_opts.ptmxmode;
-	}
+	fsi->ptmx_inode->i_mode = S_IFCHR|fsi->mount_opts.ptmxmode;
 }
 
 static int devpts_reconfigure(struct fs_context *fc)
@@ -461,7 +447,7 @@ static void devpts_kill_sb(struct super_block *sb)
 	if (fsi)
 		ida_destroy(&fsi->allocated_ptys);
 	kfree(fsi);
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 }
 
 static struct file_system_type devpts_fs_type = {
@@ -534,16 +520,15 @@ struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
 	sprintf(s, "%d", index);
 
 	dentry = d_alloc_name(root, s);
-	if (dentry) {
-		dentry->d_fsdata = priv;
-		d_add(dentry, inode);
-		fsnotify_create(d_inode(root), dentry);
-	} else {
+	if (!dentry) {
 		iput(inode);
-		dentry = ERR_PTR(-ENOMEM);
+		return ERR_PTR(-ENOMEM);
 	}
-
-	return dentry;
+	dentry->d_fsdata = priv;
+	d_make_persistent(dentry, inode);
+	fsnotify_create(d_inode(root), dentry);
+	dput(dentry);
+	return dentry; // borrowed
 }
 
 /**
@@ -573,7 +558,7 @@ void devpts_pty_kill(struct dentry *dentry)
 	drop_nlink(dentry->d_inode);
 	d_drop(dentry);
 	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
-	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
+	d_make_discardable(dentry);
 }
 
 static int __init init_devpts_fs(void)
-- 
2.47.3


