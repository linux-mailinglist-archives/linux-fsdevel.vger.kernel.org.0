Return-Path: <linux-fsdevel+bounces-58719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F299EB30A1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67F87BB8DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6A2581;
	Fri, 22 Aug 2025 00:11:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EA1537E9;
	Fri, 22 Aug 2025 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821486; cv=none; b=HZcy1yP7Dyw81U42y2nmSShcfuKkQ92cMgbKCvcWDPke/RHVfaPDZLeYfJhAWRuqQahzJwuEwMH+L6fWzjn4JK+i211S4vx/lZsoi/Q/RQw2qeG1u7nMV9VCHBp5J/U4dChouaEMg5yrmlJHe1lFimxIw0E7Tr7rrrsmpSsuaOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821486; c=relaxed/simple;
	bh=YO4vYvbZq/SXdjaSJEeIzUMiMaZxEX3ks9vFUBdy8aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRU+ehvDoQtAcbjM+THaCnTzMDNA4Gi1x3LmxrtBynqdaTeq224phI43jlDU6Lh+Opr/o1ZIkf16oNwe5wuUoVXrgiyTG0uY9m0xPnnZIpKBKZmv1z+ojSIS5b4cPcb3QocJhHUe4KmZN9ipW2dPzN9uMhy+iwdG+5TVsaDcXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFND-006nbH-Fh;
	Fri, 22 Aug 2025 00:11:17 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/16] nfsd: move name lookup out of nfsd4_list_rec_dir()
Date: Fri, 22 Aug 2025 10:00:30 +1000
Message-ID: <20250822000818.1086550-13-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250822000818.1086550-1-neil@brown.name>
References: <20250822000818.1086550-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd4_list_rec_dir() is called with two different callbacks.
One of the callbacks uses vfs_rmdir() to move the directory.
The other doesn't use the dentry at all, just the name.

As only one callback needs the dentry, this patch moves the lookup into
that function.  This prepares of changes to how directory operations
are locked.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4recover.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 93b2a3e764db..f65cf7ecea6d 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -254,7 +254,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	nfs4_reset_creds(original_cred);
 }
 
-typedef int (recdir_func)(struct dentry *, struct dentry *, struct nfsd_net *);
+typedef int (recdir_func)(struct dentry *, char *, struct nfsd_net *);
 
 struct name_list {
 	char name[HEXDIR_LEN];
@@ -308,24 +308,14 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net *nn)
 	}
 
 	status = iterate_dir(nn->rec_file, &ctx.ctx);
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
 	list_for_each_entry_safe(entry, tmp, &ctx.names, list) {
-		if (!status) {
-			struct dentry *dentry;
-			dentry = lookup_one(&nop_mnt_idmap,
-					    &QSTR(entry->name), dir);
-			if (IS_ERR(dentry)) {
-				status = PTR_ERR(dentry);
-				break;
-			}
-			status = f(dir, dentry, nn);
-			dput(dentry);
-		}
+		if (!status)
+			status = f(dir, entry->name, nn);
+
 		list_del(&entry->list);
 		kfree(entry);
 	}
-	inode_unlock(d_inode(dir));
 	nfs4_reset_creds(original_cred);
 
 	list_for_each_entry_safe(entry, tmp, &ctx.names, list) {
@@ -423,18 +413,19 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
 }
 
 static int
-purge_old(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
+purge_old(struct dentry *parent, char *cname, struct nfsd_net *nn)
 {
 	int status;
+	struct dentry *child;
 	struct xdr_netobj name;
 
-	if (child->d_name.len != HEXDIR_LEN - 1) {
+	if (strlen(cname) != HEXDIR_LEN - 1) {
 		printk("%s: illegal name %pd in recovery directory\n",
 				__func__, child);
 		/* Keep trying; maybe the others are OK: */
 		return 0;
 	}
-	name.data = kmemdup_nul(child->d_name.name, child->d_name.len, GFP_KERNEL);
+	name.data = kstrdup(cname, GFP_KERNEL);
 	if (!name.data) {
 		dprintk("%s: failed to allocate memory for name.data!\n",
 			__func__);
@@ -444,10 +435,17 @@ purge_old(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
 	if (nfs4_has_reclaimed_state(name, nn))
 		goto out_free;
 
-	status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
-	if (status)
-		printk("failed to remove client recovery directory %pd\n",
-				child);
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	child = lookup_one(&nop_mnt_idmap, &QSTR(cname), parent);
+	if (!IS_ERR(child)) {
+		status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
+		if (status)
+			printk("failed to remove client recovery directory %pd\n",
+			       child);
+		dput(child);
+	}
+	inode_unlock(d_inode(parent));
+
 out_free:
 	kfree(name.data);
 out:
@@ -478,18 +476,18 @@ nfsd4_recdir_purge_old(struct nfsd_net *nn)
 }
 
 static int
-load_recdir(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
+load_recdir(struct dentry *parent, char *cname, struct nfsd_net *nn)
 {
 	struct xdr_netobj name;
 	struct xdr_netobj princhash = { .len = 0, .data = NULL };
 
-	if (child->d_name.len != HEXDIR_LEN - 1) {
-		printk("%s: illegal name %pd in recovery directory\n",
-				__func__, child);
+	if (strlen(cname) != HEXDIR_LEN - 1) {
+		printk("%s: illegal name %s in recovery directory\n",
+				__func__, cname);
 		/* Keep trying; maybe the others are OK: */
 		return 0;
 	}
-	name.data = kmemdup_nul(child->d_name.name, child->d_name.len, GFP_KERNEL);
+	name.data = kstrdup(cname, GFP_KERNEL);
 	if (!name.data) {
 		dprintk("%s: failed to allocate memory for name.data!\n",
 			__func__);
-- 
2.50.0.107.gf914562f5916.dirty


