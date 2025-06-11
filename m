Return-Path: <linux-fsdevel+bounces-51245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B30AD4D91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C0E17C127
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D89B244696;
	Wed, 11 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kyQd20Ns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91E23A9BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628482; cv=none; b=n0n6H1UVqEi7PGV6nsLCZsbXPKmZsONFyjjWsiOlvtG1KoS7qq2XaFjgc/p0Xs5gLJi7RpLOR2b/Ak5YMRA9ZL3w8knr64aqbA3Ksr80GrgV0VI4ILJqIMfuUZbATgVM6heJQBPe8HWeE0OV1rimVQivYJzGRbiSiZlSNNqFvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628482; c=relaxed/simple;
	bh=r/biboKGlUEzwiuQninFUhRFaWnz9yYAncSPNOrOJN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFapx5UIwym6En5wgX39OP9gQqTnZwzIM+d1B5USk/tP+vk8bJRq/S5C/AcCb/l6asVvKVpGYp0uMpQqGAHsjkvYix4lky1gxQj/5lJ84r93GcuaVdrKbiv9iGYjYEgbzYavXg5Kiq7+3vVv+yMAis3xKGt60Nnf2clO/Ea9CVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kyQd20Ns; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eGuHKV66GHDzbn5KzWo9JSpvRfIZMi71uUnitURmidY=; b=kyQd20NsVM6jOuyHCMRVKzpzRy
	a46TfW8V+LKz1Q6Oe1NVEDmgxJ4/IIe3akiZ7Fs3DKSr+cP7m+gtEfuUlNj35ovO2Yvdm1HYtwIs8
	BwMzD4OfrFGlq4snS6lVyc/+4Y6GVpcmU30esWWVGRUw+FZJiZnv4WbksGbQVD4r4Y0LdufZ1KZKO
	gulrBQmWZLLJDkqv455KWxQbTVWbPwxYcIFwnwoyzYA3CdW3VynvYqjUWkHWsm80+bzCDzMAsPa6o
	GcCc8ObDJ+ztRBdqtZOKOTk5YbuSNeBSEmlYbKecxaBbEcGAGD237pX777+rmsuv4m87T2fABUrsk
	Na6sXVKQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIA-0000000HTvz-0A3N;
	Wed, 11 Jun 2025 07:54:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 02/21] procfs: kill ->proc_dops
Date: Wed, 11 Jun 2025 08:54:18 +0100
Message-ID: <20250611075437.4166635-2-viro@zeniv.linux.org.uk>
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

It has two possible values - one for "forced lookup" entries, another
for the normal ones.  We'd be better off with that as an explicit
flag anyway and in addition to that it opens some fun possibilities
with ->d_op and ->d_flags handling.

[moved PROC_ENTRY_FORCE_LOOKUP to include/linux/proc_fs.h, switched it
to an unused bit - there was a conflict]

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/generic.c       | 8 +++++---
 fs/proc/internal.h      | 3 +--
 include/linux/proc_fs.h | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index a3e22803cddf..38ce45ce0eb6 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -254,7 +254,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
-		d_set_d_op(dentry, de->proc_dops);
+		if (de->flags & PROC_ENTRY_FORCE_LOOKUP)
+			d_set_d_op(dentry, &proc_net_dentry_ops);
+		else
+			d_set_d_op(dentry, &proc_misc_dentry_ops);
 		return d_splice_alias(inode, dentry);
 	}
 	read_unlock(&proc_subdir_lock);
@@ -448,9 +451,8 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	INIT_LIST_HEAD(&ent->pde_openers);
 	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
 
-	ent->proc_dops = &proc_misc_dentry_ops;
 	/* Revalidate everything under /proc/${pid}/net */
-	if ((*parent)->proc_dops == &proc_net_dentry_ops)
+	if ((*parent)->flags & PROC_ENTRY_FORCE_LOOKUP)
 		pde_force_lookup(ent);
 
 out:
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 96122e91c645..a4054916f6da 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -44,7 +44,6 @@ struct proc_dir_entry {
 		const struct proc_ops *proc_ops;
 		const struct file_operations *proc_dir_ops;
 	};
-	const struct dentry_operations *proc_dops;
 	union {
 		const struct seq_operations *seq_ops;
 		int (*single_show)(struct seq_file *, void *);
@@ -403,7 +402,7 @@ extern const struct dentry_operations proc_net_dentry_ops;
 static inline void pde_force_lookup(struct proc_dir_entry *pde)
 {
 	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
-	pde->proc_dops = &proc_net_dentry_ops;
+	pde->flags |= PROC_ENTRY_FORCE_LOOKUP;
 }
 
 /*
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index ea62201c74c4..de1d24f19f76 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -27,6 +27,8 @@ enum {
 
 	PROC_ENTRY_proc_read_iter	= 1U << 1,
 	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
+
+	PROC_ENTRY_FORCE_LOOKUP		= 1U << 7,
 };
 
 struct proc_ops {
-- 
2.39.5


