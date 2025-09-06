Return-Path: <linux-fsdevel+bounces-60412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D91B46957
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 07:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0A756890B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 05:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37FD26C391;
	Sat,  6 Sep 2025 05:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jj0LzbHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60CD161302
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757137811; cv=none; b=L9F2+7bnM/6uty+RvbacSvF7OOd79u7F5vs6qu410Pzf6GbKWaZT2AZLu+uuNl5KsmTbWpBOrRgthQyvxCE6qW+muBCmyaHN2pJVqu4cf56PcVq2jtypcbL5Mfb0GgccITTY7SJNB76l68Lh8XzKXLP7q6ib17GKX/DYvtPP2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757137811; c=relaxed/simple;
	bh=HCVU1X3QQXC0RNrP0YRQDyDjQBXb5UQQDGjF3EIy3QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReOOnufwkrjYrAXXg6IHhdFtuxbWusolnSqeoQQ7Djlt2aw4E+kuP1of32/TKKmPeynS11b6HjEVRgXD4sNv9ZJyocQKaKsdS2hmdzHR9bBYEg4r6zYeofT3bExC3L+dMi7Djae11F0n82UNiJMUUEgmrTb/57SgsAJig6SJeCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jj0LzbHC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q7Q9VGhGlFem0R9lrlvrLXpy2Ba74xc4b5lU6ZRizP4=; b=jj0LzbHCQyv3HNXKmmlMfacCbl
	KrroJbxm7s1NyMnWM3YqHX5eZGAowma63YV6sOqq1p5aqRbAmFSwENqw/itEXCo8PGPveChHV7VK6
	ktUeyiUAH0vT6V+4fuxgA1vkkq4DOBcAimlvb2M0kstZfAHwcO7ft3oOKZlvCfsT8FgNB+6OZkjJ2
	Um5u05k77U3veMlQ8cm+T+Pc8gniM3iDkqSTL9uaxQo/4rZNt0lb/AejG0KevAhhAxwOrsvmvZ+BI
	v9lozN0FFzJ294tkvftaUFdx6bpAENoJ+wQG6bFPRXSKm0ha7RugVqx9L5PfpHQcRTeJosXlsPLBS
	7dpRQy4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuloL-0000000FbWZ-2gHf;
	Sat, 06 Sep 2025 05:50:05 +0000
Date: Sat, 6 Sep 2025 06:50:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs/proc: Don't look root inode when creating "self"
 and "thread-self"
Message-ID: <20250906055005.GS39973@ZenIV>
References: <20250906050015.3158851-1-neilb@ownmail.net>
 <20250906050015.3158851-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906050015.3158851-2-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Sep 06, 2025 at 02:57:05PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> proc_setup_self() and proc_setup_thread_self() are only called from
> proc_fill_super() which is before the filesystem is "live".  So there is
> no need to lock the root directory when adding "self" and "thread-self".
> 
> The locking rules are expected to change, so this locking will become
> anachronistic if we don't remove it.

Please, leave that one alone.  FWIW, in tree-in-dcache branch (will push
tomorrow or on Sunday, once I sort the fucking #work.f_path out) there's
this:

commit fcac614cd72f0dfc45168817a139653877649507
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Feb 26 01:55:36 2024 -0500

    procfs: make /self and /thread_self dentries persistent
    
    ... and there's no need to remember those pointers anywhere - ->kill_sb()
    no longer needs to bother since kill_anon_super() will take care of
    them anyway and proc_pid_readdir() only wants the inumbers, which
    we had in a couple of static variables all along.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c667702dc69b..2d6a541ede27 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3585,14 +3585,12 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	if (pos == TGID_OFFSET - 2) {
-		struct inode *inode = d_inode(fs_info->proc_self);
-		if (!dir_emit(ctx, "self", 4, inode->i_ino, DT_LNK))
+		if (!dir_emit(ctx, "self", 4, self_inum, DT_LNK))
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
 	if (pos == TGID_OFFSET - 1) {
-		struct inode *inode = d_inode(fs_info->proc_thread_self);
-		if (!dir_emit(ctx, "thread-self", 11, inode->i_ino, DT_LNK))
+		if (!dir_emit(ctx, "thread-self", 11, thread_self_inum, DT_LNK))
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 96122e91c645..dadc621556d9 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -369,6 +369,7 @@ static inline void proc_tty_init(void) {}
 extern struct proc_dir_entry proc_root;
 
 extern void proc_self_init(void);
+extern unsigned self_inum, thread_self_inum;
 
 /*
  * task_[no]mmu.c
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 06a297a27ba3..923ae40f19b9 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -261,17 +261,11 @@ static void proc_kill_sb(struct super_block *sb)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
-	if (!fs_info) {
-		kill_anon_super(sb);
-		return;
-	}
-
-	dput(fs_info->proc_self);
-	dput(fs_info->proc_thread_self);
-
 	kill_anon_super(sb);
-	put_pid_ns(fs_info->pid_ns);
-	kfree_rcu(fs_info, rcu);
+	if (fs_info) {
+		put_pid_ns(fs_info->pid_ns);
+		kfree(fs_info);
+	}
 }
 
 static struct file_system_type proc_fs_type = {
diff --git a/fs/proc/self.c b/fs/proc/self.c
index b46fbfd22681..62d2c0cfe35c 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -31,12 +31,11 @@ static const struct inode_operations proc_self_inode_operations = {
 	.get_link	= proc_self_get_link,
 };
 
-static unsigned self_inum __ro_after_init;
+unsigned self_inum __ro_after_init;
 
 int proc_setup_self(struct super_block *s)
 {
 	struct inode *root_inode = d_inode(s->s_root);
-	struct proc_fs_info *fs_info = proc_sb_info(s);
 	struct dentry *self;
 	int ret = -ENOMEM;
 
@@ -51,18 +50,15 @@ int proc_setup_self(struct super_block *s)
 			inode->i_uid = GLOBAL_ROOT_UID;
 			inode->i_gid = GLOBAL_ROOT_GID;
 			inode->i_op = &proc_self_inode_operations;
-			d_add(self, inode);
+			d_make_persistent(self, inode);
 			ret = 0;
-		} else {
-			dput(self);
 		}
+		dput(self);
 	}
 	inode_unlock(root_inode);
 
 	if (ret)
 		pr_err("proc_fill_super: can't allocate /proc/self\n");
-	else
-		fs_info->proc_self = self;
 
 	return ret;
 }
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index 0e5050d6ab64..d6113dbe58e0 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -31,12 +31,11 @@ static const struct inode_operations proc_thread_self_inode_operations = {
 	.get_link	= proc_thread_self_get_link,
 };
 
-static unsigned thread_self_inum __ro_after_init;
+unsigned thread_self_inum __ro_after_init;
 
 int proc_setup_thread_self(struct super_block *s)
 {
 	struct inode *root_inode = d_inode(s->s_root);
-	struct proc_fs_info *fs_info = proc_sb_info(s);
 	struct dentry *thread_self;
 	int ret = -ENOMEM;
 
@@ -51,19 +50,15 @@ int proc_setup_thread_self(struct super_block *s)
 			inode->i_uid = GLOBAL_ROOT_UID;
 			inode->i_gid = GLOBAL_ROOT_GID;
 			inode->i_op = &proc_thread_self_inode_operations;
-			d_add(thread_self, inode);
+			d_make_persistent(thread_self, inode);
 			ret = 0;
-		} else {
-			dput(thread_self);
 		}
+		dput(thread_self);
 	}
 	inode_unlock(root_inode);
 
 	if (ret)
 		pr_err("proc_fill_super: can't allocate /proc/thread-self\n");
-	else
-		fs_info->proc_thread_self = thread_self;
-
 	return ret;
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index ea62201c74c4..de0edb431eac 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -63,8 +63,6 @@ enum proc_pidonly {
 
 struct proc_fs_info {
 	struct pid_namespace *pid_ns;
-	struct dentry *proc_self;        /* For /proc/self */
-	struct dentry *proc_thread_self; /* For /proc/thread-self */
 	kgid_t pid_gid;
 	enum proc_hidepid hide_pid;
 	enum proc_pidonly pidonly;

