Return-Path: <linux-fsdevel+bounces-62355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AA2B8EE2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 05:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F50F3BE6D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 03:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074BE2D9792;
	Mon, 22 Sep 2025 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HRIQZ+mv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A31E5B95;
	Mon, 22 Sep 2025 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758513149; cv=none; b=ftXIb5JVm4oObAFtvZUXpGhhejvVuzrn6JzRcgNZNVTmDz8gj4zK89Qk8xzu6QXaN9b+wumReopLkd28KywIkUc4CAKQoT/HzMyM0OA0vLbvzWsLhY5nRi+1VViU9okGUlTyokJ0m2mNKOaifC+qKVNurY0zqmIr5JPeoD6gN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758513149; c=relaxed/simple;
	bh=a3OsQPqz/vBcdO71IrFI1O5gAfjMbOy5wWLMX/HC7jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgEiodK/TigfDVnWT+qxdrU3JsNTiyVh0sbM6E8Vwz57etZEp9mPbOwJ2lTkCGmwBeHE2YryP8iPjXS/Y1PUi/iGMpmQRI5SgwwHS9ERAnPBi9nq2JcK7l8UqxdRsnv4DLCjVjfYSf6J+j+RllKKqdkZslVIUAoXEVXKqxsVVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HRIQZ+mv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uvOBcE6UQrpI6WGthIQ2mhhrrb+ib1iPppy0esW2pF8=; b=HRIQZ+mv3XjEr5HE95zUXo4+a6
	NSRxPd0KrHJeiO55wmL8zxyLexKaYOtukTqYDUk4P7Wms504VRDpnu79qCxm9LPPLIvXhPbJDCS9J
	YRDvUR+wf4nDqbVfzd55z89ZBt+992gTBdYH/kADhegMyk3HdwQFQNcaBQPMTq94apRnfURggWfW/
	JHqnvLMVP0BaRB8Hc5glF+yhqEgLGpQ51cjWLVzIBoXc/Te8IX6AprfxOgc+nyojcMBMgjxAohGXS
	cfa+R9tgKpxmrTagksJYExY1jTrB11KyU7eGcwAdbKgV4ytOY8lJPggIhRGBTZNeJw+hKdXevicaO
	50y2/Udw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Xb8-00000007I6X-2KnX;
	Mon, 22 Sep 2025 03:52:18 +0000
Date: Mon, 22 Sep 2025 04:52:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, borntraeger@linux.ibm.com
Subject: Re: [PATCH 31/39] convert selinuxfs
Message-ID: <20250922035218.GP39973@ZenIV>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-31-viro@zeniv.linux.org.uk>
 <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
 <20250921222619.GO39973@ZenIV>
 <CAHC9VhTy2j+hkT24hM1J2GH+12wp63DArRo6BGTvTwGX2k4CnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTy2j+hkT24hM1J2GH+12wp63DArRo6BGTvTwGX2k4CnA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 21, 2025 at 10:50:02PM -0400, Paul Moore wrote:

> Looks good to me, ACK below.  For me personally, it's a bit late to
> take non-bugfix stuff for the upcoming merge window so I would defer
> this for a few weeks, but if you want to take it now that's your call.
> Also your call if you would prefer this to go in with the rest of the
> patchset you've working on, or if you want me to take it via the
> SELinux tree.  Let me know.

Seeing that it's already a 41-commit patchset (rpc_pipe conversion pulled
in, now +1 from this split) with several more in the pipeline (securityfs
conversion, for starters) and it's -rc7...

I think I'll post v2 in the middle of the week, but aim for the next
cycle.  Rebase to -rc1 as soon as it comes, post v3 for review and testing,
then shove it into -next.

Especially since #work.nfsctl is in -next, so hopefully by -rc1 there won't
be any need to put merges in the middle of the series, with conversion of
nfsctl included into the series, bringing with it removal of kill_litter_super()
and (hopefully) "give configfs and apparmorfs private copies of simple_unlink()
and simple_rmdir() doing dput() instead of d_make_discardable(), then make
d_make_discardable() complain about being called on non-persistent dentries".

Speaking of additional patches into that series: AFAICS there's no reason
for selinuxfs to allocate dentry before the inode.  Doing it the other way
round simplifies the things quite a bit, IMO.  Something like this (as followup
to the previous patch):

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 482a2cac9640..7bee2d8bdec5 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1197,6 +1197,25 @@ static struct inode *sel_make_inode(struct super_block *sb, umode_t mode)
 	return ret;
 }
 
+static struct dentry *sel_attach(struct dentry *parent, const char *name,
+				 struct inode *inode)
+{
+	struct dentry *dentry = d_alloc_name(parent, name);
+	if (unlikely(!dentry)) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	d_add(dentry, inode);
+	return dentry;
+}
+
+static int sel_attach_file(struct dentry *parent, const char *name,
+			   struct inode *inode)
+{
+	struct dentry *dentry = sel_attach(parent, name, inode);
+	return PTR_ERR_OR_ZERO(dentry);
+}
+
 static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
@@ -1364,8 +1383,7 @@ static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_
 	*bool_num = num;
 	*bool_pending_names = names;
 
-	for (i = 0; i < num; i++) {
-		struct dentry *dentry;
+	for (i = 0; !ret && i < num; i++) {
 		struct inode *inode;
 		struct inode_security_struct *isec;
 		ssize_t len;
@@ -1376,15 +1394,9 @@ static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_
 			ret = -ENAMETOOLONG;
 			break;
 		}
-		dentry = d_alloc_name(bool_dir, names[i]);
-		if (!dentry) {
-			ret = -ENOMEM;
-			break;
-		}
 
 		inode = sel_make_inode(bool_dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
 		if (!inode) {
-			dput(dentry);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1402,7 +1414,8 @@ static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_
 		isec->initialized = LABEL_INITIALIZED;
 		inode->i_fop = &sel_bool_ops;
 		inode->i_ino = i|SEL_BOOL_INO_OFFSET;
-		d_add(dentry, inode);
+
+		ret = sel_attach_file(bool_dir, names[i], inode);
 	}
 out:
 	free_page((unsigned long)page);
@@ -1587,6 +1600,7 @@ static int sel_make_avc_files(struct dentry *dir)
 	struct super_block *sb = dir->d_sb;
 	struct selinux_fs_info *fsi = sb->s_fs_info;
 	unsigned int i;
+	int err = 0;
 	static const struct tree_descr files[] = {
 		{ "cache_threshold",
 		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
@@ -1596,26 +1610,20 @@ static int sel_make_avc_files(struct dentry *dir)
 #endif
 	};
 
-	for (i = 0; i < ARRAY_SIZE(files); i++) {
+	for (i = 0; !err && i < ARRAY_SIZE(files); i++) {
 		struct inode *inode;
-		struct dentry *dentry;
-
-		dentry = d_alloc_name(dir, files[i].name);
-		if (!dentry)
-			return -ENOMEM;
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
-		if (!inode) {
-			dput(dentry);
+		if (!inode)
 			return -ENOMEM;
-		}
 
 		inode->i_fop = files[i].ops;
 		inode->i_ino = ++fsi->last_ino;
-		d_add(dentry, inode);
+
+		err = sel_attach_file(dir, files[i].name, inode);
 	}
 
-	return 0;
+	return err;
 }
 
 static int sel_make_ss_files(struct dentry *dir)
@@ -1623,30 +1631,25 @@ static int sel_make_ss_files(struct dentry *dir)
 	struct super_block *sb = dir->d_sb;
 	struct selinux_fs_info *fsi = sb->s_fs_info;
 	unsigned int i;
+	int err = 0;
 	static const struct tree_descr files[] = {
 		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
 	};
 
-	for (i = 0; i < ARRAY_SIZE(files); i++) {
+	for (i = 0; !err && i < ARRAY_SIZE(files); i++) {
 		struct inode *inode;
-		struct dentry *dentry;
-
-		dentry = d_alloc_name(dir, files[i].name);
-		if (!dentry)
-			return -ENOMEM;
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
-		if (!inode) {
-			dput(dentry);
+		if (!inode)
 			return -ENOMEM;
-		}
 
 		inode->i_fop = files[i].ops;
 		inode->i_ino = ++fsi->last_ino;
-		d_add(dentry, inode);
+
+		err = sel_attach_file(dir, files[i].name, inode);
 	}
 
-	return 0;
+	return err;
 }
 
 static ssize_t sel_read_initcon(struct file *file, char __user *buf,
@@ -1674,30 +1677,25 @@ static const struct file_operations sel_initcon_ops = {
 static int sel_make_initcon_files(struct dentry *dir)
 {
 	unsigned int i;
+	int err = 0;
 
-	for (i = 1; i <= SECINITSID_NUM; i++) {
-		struct inode *inode;
-		struct dentry *dentry;
+	for (i = 1; !err && i <= SECINITSID_NUM; i++) {
 		const char *s = security_get_initial_sid_context(i);
+		struct inode *inode;
 
 		if (!s)
 			continue;
-		dentry = d_alloc_name(dir, s);
-		if (!dentry)
-			return -ENOMEM;
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-		if (!inode) {
-			dput(dentry);
+		if (!inode)
 			return -ENOMEM;
-		}
 
 		inode->i_fop = &sel_initcon_ops;
 		inode->i_ino = i|SEL_INITCON_INO_OFFSET;
-		d_add(dentry, inode);
+		err = sel_attach_file(dir, s, inode);
 	}
 
-	return 0;
+	return err;
 }
 
 static inline unsigned long sel_class_to_ino(u16 class)
@@ -1779,29 +1777,21 @@ static int sel_make_perm_files(struct selinux_policy *newpolicy,
 	if (rc)
 		return rc;
 
-	for (i = 0; i < nperms; i++) {
+	for (i = 0; !rc && i < nperms; i++) {
 		struct inode *inode;
-		struct dentry *dentry;
 
-		rc = -ENOMEM;
-		dentry = d_alloc_name(dir, perms[i]);
-		if (!dentry)
-			goto out;
-
-		rc = -ENOMEM;
 		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
 		if (!inode) {
-			dput(dentry);
-			goto out;
+			rc = -ENOMEM;
+			break;
 		}
 
 		inode->i_fop = &sel_perm_ops;
 		/* i+1 since perm values are 1-indexed */
 		inode->i_ino = sel_perm_to_ino(classvalue, i + 1);
-		d_add(dentry, inode);
+
+		rc = sel_attach_file(dir, perms[i], inode);
 	}
-	rc = 0;
-out:
 	for (i = 0; i < nperms; i++)
 		kfree(perms[i]);
 	kfree(perms);
@@ -1816,20 +1806,18 @@ static int sel_make_class_dir_entries(struct selinux_policy *newpolicy,
 	struct selinux_fs_info *fsi = sb->s_fs_info;
 	struct dentry *dentry = NULL;
 	struct inode *inode = NULL;
-
-	dentry = d_alloc_name(dir, "index");
-	if (!dentry)
-		return -ENOMEM;
+	int err;
 
 	inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-	if (!inode) {
-		dput(dentry);
+	if (!inode)
 		return -ENOMEM;
-	}
 
 	inode->i_fop = &sel_class_ops;
 	inode->i_ino = sel_class_to_ino(index);
-	d_add(dentry, inode);
+
+	err = sel_attach_file(dir, "index", inode);
+	if (err)
+		return err;
 
 	dentry = sel_make_dir(dir, "perms", &fsi->last_class_ino);
 	if (IS_ERR(dentry))
@@ -1881,58 +1869,47 @@ static int sel_make_policycap(struct dentry *dir)
 {
 	struct super_block *sb = dir->d_sb;
 	unsigned int iter;
-	struct dentry *dentry = NULL;
 	struct inode *inode = NULL;
+	int err = 0;
+
+	for (iter = 0; !err && iter <= POLICYDB_CAP_MAX; iter++) {
+		const char *name;
 
-	for (iter = 0; iter <= POLICYDB_CAP_MAX; iter++) {
 		if (iter < ARRAY_SIZE(selinux_policycap_names))
-			dentry = d_alloc_name(dir,
-					      selinux_policycap_names[iter]);
+			name = selinux_policycap_names[iter];
 		else
-			dentry = d_alloc_name(dir, "unknown");
-
-		if (dentry == NULL)
-			return -ENOMEM;
+			name = "unknown";
 
 		inode = sel_make_inode(sb, S_IFREG | 0444);
-		if (inode == NULL) {
-			dput(dentry);
+		if (!inode)
 			return -ENOMEM;
-		}
 
 		inode->i_fop = &sel_policycap_ops;
 		inode->i_ino = iter | SEL_POLICYCAP_INO_OFFSET;
-		d_add(dentry, inode);
+		err = sel_attach_file(dir, name, inode);
 	}
 
-	return 0;
+	return err;
 }
 
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 			unsigned long *ino)
 {
-	struct dentry *dentry = d_alloc_name(dir, name);
 	struct inode *inode;
 
-	if (!dentry)
-		return ERR_PTR(-ENOMEM);
-
 	inode = sel_make_inode(dir->d_sb, S_IFDIR | S_IRUGO | S_IXUGO);
-	if (!inode) {
-		dput(dentry);
+	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	inode->i_ino = ++(*ino);
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	d_add(dentry, inode);
 	/* bump link count on parent directory, too */
 	inc_nlink(d_inode(dir));
 
-	return dentry;
+	return sel_attach(dir, name, inode);
 }
 
 static int reject_all(struct mnt_idmap *idmap, struct inode *inode, int mask)
@@ -2020,17 +1997,10 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto err;
 	}
 
-	ret = -ENOMEM;
-	dentry = d_alloc_name(sb->s_root, NULL_FILE_NAME);
-	if (!dentry)
-		goto err;
-
 	ret = -ENOMEM;
 	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
-	if (!inode) {
-		dput(dentry);
+	if (!inode)
 		goto err;
-	}
 
 	inode->i_ino = ++fsi->last_ino;
 	isec = selinux_inode(inode);
@@ -2039,7 +2009,9 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	isec->initialized = LABEL_INITIALIZED;
 
 	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, MKDEV(MEM_MAJOR, 3));
-	d_add(dentry, inode);
+	ret = sel_attach_file(sb->s_root, NULL_FILE_NAME, inode);
+	if (ret)
+		goto err;
 
 	dentry = sel_make_dir(sb->s_root, "avc", &fsi->last_ino);
 	if (IS_ERR(dentry)) {

