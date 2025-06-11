Return-Path: <linux-fsdevel+bounces-51242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54CFAD4D8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DD53A7FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD423C8A4;
	Wed, 11 Jun 2025 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UcWLoUN5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2523AB8A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628481; cv=none; b=AWdWEyiEu71KGsJp6IHTw2EL68tV3TM7a/p8Zt+6IwVrdFonq2+1e8hqNajisCZv2Ay9feiplZhZVhsb+PmgOD4Hxalp9DysxNkI0YemdmiAZnu0ahR3lezzG43tW1qBVRIMSIE1HtLi4E/TfYzq00eYTM8VcJuylomFbh1VVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628481; c=relaxed/simple;
	bh=vjR53GcrnwaHocuG+ba3UyUCik6w3MX+xAi0hVGeSyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAm7q0vVFYnqJIZRhqPZIcIWzpxFqDcJt/HXYvGJBHw8M3z0V7XN2Vcs4fSbZ9F0n4ZkaaanjGqQbK+WL0qjqLVKO+gtYw9USikirp8kcQMYA+a+Tviyfzs/+/YAjlKmoX/0he9pp+cGZ0GIcx/xHZJMKmoHrkF925va+eiE9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UcWLoUN5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bGmsRkd9ox5B3nw6nNYsi00XXSnxpcHiVY8ob6gOcRc=; b=UcWLoUN5AtgNUC+KS7k5Mww7pu
	pKCI+BtNmVXswFwfD1EjcpHtRuG+6BUauBykj69b0O8stmFjQiUqqiN/+rvyG3tQLR8+T0fHLojGs
	MUFqxfODO0HyUOQmaNFBuRdkta6qsha2cVZFQCeTIxlKDsNvqbc+QI5Ahds4rctYx6DHufrG0fMuk
	X9r9gLdMb2toJZPgomCHHghns82bS0GZHHTCEnZYUIX2cplZbSpcHp/pto2zIU9gQcVZonQB95KpO
	i7vNWyAcnHh6n46mVJfV2DClmdNrSp+lUBeUA8e2wQgWcSNPG+INMtZ3vdjB4RbN9If5k05KBr5g9
	sO1NiRYQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIA-0000000HTwD-0uBE;
	Wed, 11 Jun 2025 07:54:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 04/21] switch procfs from d_set_d_op() to d_splice_alias_ops()
Date: Wed, 11 Jun 2025 08:54:20 +0100
Message-ID: <20250611075437.4166635-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/base.c        | 9 +++------
 fs/proc/generic.c     | 8 ++++----
 fs/proc/internal.h    | 3 +--
 fs/proc/namespaces.c  | 3 +--
 fs/proc/proc_sysctl.c | 7 +++----
 5 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c667702dc69b..e93149a01341 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2704,8 +2704,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
 		inode->i_fop = p->fop;
 	ei->op = p->op;
 	pid_update_inode(task, inode);
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 static struct dentry *proc_pident_lookup(struct inode *dir, 
@@ -3501,8 +3500,7 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
 	set_nlink(inode, nlink_tgid);
 	pid_update_inode(task, inode);
 
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
@@ -3804,8 +3802,7 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
 	set_nlink(inode, nlink_tid);
 	pid_update_inode(task, inode);
 
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, unsigned int flags)
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 38ce45ce0eb6..5635453cd476 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -255,10 +255,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
 		if (de->flags & PROC_ENTRY_FORCE_LOOKUP)
-			d_set_d_op(dentry, &proc_net_dentry_ops);
-		else
-			d_set_d_op(dentry, &proc_misc_dentry_ops);
-		return d_splice_alias(inode, dentry);
+			return d_splice_alias_ops(inode, dentry,
+						  &proc_net_dentry_ops);
+		return d_splice_alias_ops(inode, dentry,
+					  &proc_misc_dentry_ops);
 	}
 	read_unlock(&proc_subdir_lock);
 	return ERR_PTR(-ENOENT);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a4054916f6da..520c4742101d 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -413,7 +413,6 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
 static inline struct dentry *proc_splice_unmountable(struct inode *inode,
 		struct dentry *dentry, const struct dentry_operations *d_ops)
 {
-	d_set_d_op(dentry, d_ops);
 	dont_mount(dentry);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, d_ops);
 }
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index c610224faf10..4403a2e20c16 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -111,8 +111,7 @@ static struct dentry *proc_ns_instantiate(struct dentry *dentry,
 	ei->ns_ops = ns_ops;
 	pid_update_inode(task, inode);
 
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return d_splice_alias_ops(inode, dentry, &pid_dentry_operations);
 }
 
 static int proc_ns_dir_readdir(struct file *file, struct dir_context *ctx)
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index cc9d74a06ff0..7a8bffc03dc8 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -540,9 +540,8 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 			goto out;
 	}
 
-	d_set_d_op(dentry, &proc_sys_dentry_operations);
 	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
-	err = d_splice_alias(inode, dentry);
+	err = d_splice_alias_ops(inode, dentry, &proc_sys_dentry_operations);
 
 out:
 	if (h)
@@ -699,9 +698,9 @@ static bool proc_sys_fill_cache(struct file *file,
 			return false;
 		if (d_in_lookup(child)) {
 			struct dentry *res;
-			d_set_d_op(child, &proc_sys_dentry_operations);
 			inode = proc_sys_make_inode(dir->d_sb, head, table);
-			res = d_splice_alias(inode, child);
+			res = d_splice_alias_ops(inode, child,
+						 &proc_sys_dentry_operations);
 			d_lookup_done(child);
 			if (unlikely(res)) {
 				dput(child);
-- 
2.39.5


