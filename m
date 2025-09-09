Return-Path: <linux-fsdevel+bounces-60615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357CB4A0E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 06:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184563AD30B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 04:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D545945;
	Tue,  9 Sep 2025 04:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="bHSMdTOY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MvfrFniY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C02D94B8
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393335; cv=none; b=BMm0gGVAhmI0qssFXZXL1uasJFUOMOdZ4OnvgjutuBICTmJwgt/wx+T0sWUGaO/jDMlDSUWXr9ufHi0no56f9bdzwGet/4h9XeLXsAfGGdLMKeB13qbPzX4qoAv4kKJn8rckSaOOVxkf5eEBZ7/z/KdpYm3japg2jnOXtrzens8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393335; c=relaxed/simple;
	bh=1Ef050/gsA4ooivaljKHxEblpGIuF1Lmn7McJ8exVxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtAcHHcObcqrN/6eRW652V0r3X1ZG5PIGdLZjfakmacdqX2/rHyOCUgnljAl9jW+HGNVC5G1dBdxk1ptQhRtbo64uMCkp+Wgk3jnFsUMCFMPoWpCMD8fdt2Oh9RGJwAd+y3ECCYe9jF3p4o6rp2JUP8eehhOstocIUI3ZHuOb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=bHSMdTOY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MvfrFniY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A56B87A0171;
	Tue,  9 Sep 2025 00:48:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 00:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757393332;
	 x=1757479732; bh=n0lC4lDkAsohhioBJoNWbAKocJubwv9IQwHgpJRwp+4=; b=
	bHSMdTOYEA0Y0wX86jKFpcFOpsFJ+JFY6/vZBbuSRuqB1OSkKVu1jNsbM6ed5Be8
	wC4pOGI/C32zLeiza8xTxTWD6/weKFbgwPXtmvwn6W0lqEFUXcnYIe28lD0vgGeh
	aw5Pt893DUGVWmSZ/dxGjjhzD1WVbE//r1qfUdk1czrBaXxpVAVG0RvU4lP//xhP
	xuuFEfzrSTGbr8JCs1hULc6Y37eKFYL0IpJddKDrpco6COa7Xn7lW59N5u859epc
	4yO5ke6DiG+npva8kt/If29cYWO5a6JS2hOmB75a8lJ3kwa5yzepoAg76HzCU8DZ
	tPUbz0CGQfWq5vussTIJmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757393332; x=1757479732; bh=n
	0lC4lDkAsohhioBJoNWbAKocJubwv9IQwHgpJRwp+4=; b=MvfrFniYJfi6vFEaL
	aBFgHPAicqYP7EEO6uYVIC+vfSjnrR2LkBvlbouOxuYSjRrBZFWwtC0x7TcsK0TE
	HBATBo+N6J13jIL/ZkUjAVnwPlxbmku0ub2zIQSKWoLnD48P4t+0Qc0Jfq/08gs2
	c3Y72hACXCq2Ig6cvQ7P/K4RM6x3v6ThtdEdUbl0QXQycr4m00NHjBDnY7QoEyYF
	naLnjSobjzXM9LjfKlbxElCRTy4GC8RHdcMCVF1Y2c2s7n+UgaJ7BQOFiOVq1rS0
	oBpDiqfeGWz24BeqJB0Xkx2DSBLKGZRyiay97jTrqL7NJcvSFeGmSseKkdxZWGB+
	J0MZg==
X-ME-Sender: <xms:tLG_aH346HRnW4I3cpZor7Dtkmna1EuwDdInJOBQwDPGEAA06LICMA>
    <xme:tLG_aNeRtp2dcOq39nduGNq-5y7x6YnXnjbSRs9cCFvV4zB6cI853jBYKMaTNwEoG
    dh612Rc9ke3vw>
X-ME-Received: <xmr:tLG_aNdGxRCIO24ufzqi5psj85GRdHOeTzZnauoMwKdQc-pm_zy8laCJ5lv6UMAD_N5n5G0HvJQ6ZbrqWOMGR70L50imWfywPathXGyr5Q3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tLG_aIwvHA1CTOOl0yg5VMpLzdDpi8LgH2IAIKWReqXYQ_aR5IGLuw>
    <xmx:tLG_aM90d7NmTw6iq55JAC3oKtjfZB8j_2V4-fI1bFyJgoHgHjEXtA>
    <xmx:tLG_aIiKVzV6uGfNbtPiL_6Z_b70MeUkOSA7TCkX2V6wC7hl-D5Fmg>
    <xmx:tLG_aLGLaVS2V0Q7DrYfuZ0EQqyNR6du-D9jTKML1G_dlAUI_fIwUA>
    <xmx:tLG_aOsIxvEukL2XEo2dtDcx7pl1C-8ST0ve75mcAdEp20CYjCDPJdvC>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 00:48:49 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 6/7] VFS: introduce simple_end_creating() and simple_failed_creating()
Date: Tue,  9 Sep 2025 14:43:20 +1000
Message-ID: <20250909044637.705116-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250909044637.705116-1-neilb@ownmail.net>
References: <20250909044637.705116-1-neilb@ownmail.net>
Reply-To: neil@brown.name
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

These are partners of simple_start_creating().
On failure we don't keep a reference.  On success we do.

We now Use these where simple_start_creating() is used, in debugfs,
tracefs, and rpcpipefs.

This is part of centralising all locking for create/remote/rename
operations.

Also rename start_creating, end_creating, failed_creating in debugfs to
free up these generic names for more generic use.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/debugfs/inode.c    | 43 +++++++++++++++++++++----------------------
 fs/tracefs/inode.c    |  6 ++----
 include/linux/fs.h    | 19 +++++++++++++++++++
 net/sunrpc/rpc_pipe.c | 11 ++++-------
 4 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index c12d649df6a5..1a13739b2cef 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -362,7 +362,8 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(debugfs_lookup);
 
-static struct dentry *start_creating(const char *name, struct dentry *parent)
+static struct dentry *debugfs_start_creating(const char *name,
+					     struct dentry *parent)
 {
 	struct dentry *dentry;
 	int error;
@@ -402,18 +403,16 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	return dentry;
 }
 
-static struct dentry *failed_creating(struct dentry *dentry)
+static struct dentry *debugfs_failed_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	dput(dentry);
+	simple_failed_creating(dentry);
 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 	return ERR_PTR(-ENOMEM);
 }
 
-static struct dentry *end_creating(struct dentry *dentry)
+static struct dentry *debugfs_end_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	return dentry;
+	return simple_end_creating(dentry);
 }
 
 static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
@@ -428,13 +427,13 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
 	BUG_ON(!S_ISREG(mode));
-	dentry = start_creating(name, parent);
+	dentry = debugfs_start_creating(name, parent);
 
 	if (IS_ERR(dentry))
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -442,7 +441,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create file '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	inode->i_mode = mode;
@@ -457,7 +456,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 
 struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
@@ -577,14 +576,14 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_size);
  */
 struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry = debugfs_start_creating(name, parent);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -592,7 +591,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create directory '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -604,7 +603,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_dir);
 
@@ -624,14 +623,14 @@ struct dentry *debugfs_create_automount(const char *name,
 					debugfs_automount_t f,
 					void *data)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry = debugfs_start_creating(name, parent);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -639,7 +638,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	make_empty_dir_inode(inode);
@@ -651,7 +650,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL(debugfs_create_automount);
 
@@ -687,7 +686,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 	if (!link)
 		return ERR_PTR(-ENOMEM);
 
-	dentry = start_creating(name, parent);
+	dentry = debugfs_start_creating(name, parent);
 	if (IS_ERR(dentry)) {
 		kfree(link);
 		return dentry;
@@ -698,13 +697,13 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 		pr_err("out of free dentries, can not create symlink '%s'\n",
 		       name);
 		kfree(link);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
 	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
 
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 0c023941a316..320d7f25024b 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -571,16 +571,14 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 
 struct dentry *tracefs_failed_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	dput(dentry);
+	simple_failed_creating(dentry);
 	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
 	return NULL;
 }
 
 struct dentry *tracefs_end_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	return dentry;
+	return simple_end_creating(dentry);
 }
 
 /* Find the inode that this will use for default */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 73b39e5bb9e4..f2b5456305e2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3656,6 +3656,25 @@ extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int
 extern void simple_release_fs(struct vfsmount **mount, int *count);
 struct dentry *simple_start_creating(struct dentry *, const char *);
 
+/* filesystems which use the dcache as backing store don't
+ * drop the reference after creating an object - they keep it
+ * to be dropped by kill_litter_super().
+ */
+static inline struct dentry *simple_end_creating(struct dentry *dentry)
+{
+	inode_unlock(dentry->d_parent->d_inode);
+	return dentry;
+}
+
+/* On failure, we DO drop the reference because there is no need
+ * keep it.
+ */
+static inline void simple_failed_creating(struct dentry *dentry)
+{
+	inode_unlock(dentry->d_parent->d_inode);
+	dput(dentry);
+}
+
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 0bd1df2ebb47..38c26909235d 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -536,8 +536,7 @@ static int rpc_new_file(struct dentry *parent,
 
 	inode = rpc_get_inode(dir->i_sb, S_IFREG | mode);
 	if (unlikely(!inode)) {
-		dput(dentry);
-		inode_unlock(dir);
+		simple_failed_creating(dentry);
 		return -ENOMEM;
 	}
 	inode->i_ino = iunique(dir->i_sb, 100);
@@ -546,7 +545,7 @@ static int rpc_new_file(struct dentry *parent,
 	rpc_inode_setowner(inode, private);
 	d_instantiate(dentry, inode);
 	fsnotify_create(dir, dentry);
-	inode_unlock(dir);
+	simple_end_creating(dentry);
 	return 0;
 }
 
@@ -572,9 +571,8 @@ static struct dentry *rpc_new_dir(struct dentry *parent,
 	inc_nlink(dir);
 	d_instantiate(dentry, inode);
 	fsnotify_mkdir(dir, dentry);
-	inode_unlock(dir);
 
-	return dentry;
+	return simple_end_creating(dentry);
 }
 
 static int rpc_populate(struct dentry *parent,
@@ -669,9 +667,8 @@ int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 	rpci->pipe = pipe;
 	rpc_inode_setowner(inode, private);
 	d_instantiate(dentry, inode);
-	pipe->dentry = dentry;
 	fsnotify_create(dir, dentry);
-	inode_unlock(dir);
+	pipe->dentry = simple_end_creating(dentry);
 	return 0;
 
 failed:
-- 
2.50.0.107.gf914562f5916.dirty


