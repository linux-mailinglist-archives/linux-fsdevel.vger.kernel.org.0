Return-Path: <linux-fsdevel+bounces-38602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EFBA0494E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 19:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407CF1664A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C71F5403;
	Tue,  7 Jan 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avgGW1Ts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8DF1F4E33
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274919; cv=none; b=e5HNe/cwkr9xWTmYtERV4UYL67FtJd8svXQ2hsDeH+XHH9jfQGUMUc1TEwLVC+u4ogiMsV5m6Fgx+Yt/CYoDgvtvbyYo84YfEdGUjXAunybt56NZMKF29UPMTA2is7msBTYOG2tsaaESejrFfOHbsdyGEIDSmTx8zVU9vLtLTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274919; c=relaxed/simple;
	bh=vRacdDmEkDpCsbaiCLNUCJzPUuy8W4zt0Na19HlwvNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaYQ4CsdrH9iGCmZWQKy6dACjASin20Ecb2P1zV3HTA/nv3DqI8BR0iY/uudZDUUAMZhSksXG4OloFxNlk4xw5FMRnNNlMO1HT+uT3HWqH/07zBPbL+hU3sFNbUECc+h1sSnM44JluvkQ9Rj1XI15USZTareujdq0t52NypKQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avgGW1Ts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736274914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3U8s9dlnuRhzN+hAAFt0ClTwk9PTXQs8oU+1HK2h3NU=;
	b=avgGW1TsmrRBXh9VR5XvtX7WoXYK9hXuNEL+uqlssx6mmD+C2MrkmEiEIO4c1DZR2h3lMZ
	Dy7GbFSE+iD0PMA1kkescBU4fsCgidTHQQ6ll91Oks1ukiZGtaRt8fB7+ayCqVRRpaU228
	MKT7xXvkb7NFMYDgdkbeWSkwX4tLsN8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-4dXgXPleO5GVfISdWt_SOw-1; Tue,
 07 Jan 2025 13:35:09 -0500
X-MC-Unique: 4dXgXPleO5GVfISdWt_SOw-1
X-Mimecast-MFC-AGG-ID: 4dXgXPleO5GVfISdWt_SOw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7711E1955F56;
	Tue,  7 Jan 2025 18:35:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74615195606B;
	Tue,  7 Jan 2025 18:35:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] afs: Make /afs/@cell and /afs/.@cell symlinks
Date: Tue,  7 Jan 2025 18:34:51 +0000
Message-ID: <20250107183454.608451-4-dhowells@redhat.com>
In-Reply-To: <20250107183454.608451-1-dhowells@redhat.com>
References: <20250107183454.608451-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Make /afs/@cell a symlink in the /afs dynamic root to match what other AFS
clients do rather than doing a substitution in the dentry name.  This has
the bonus of being tab-expandable also.

Further, provide a /afs/.@cell symlink to point to the dotted cell share.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

Notes:
    Changes
    =======
    ver #2)
     - Directly create the symlink nodes rather than going through lookup.

 fs/afs/dynroot.c           | 177 +++++++++++++++++++++++++++----------
 include/trace/events/afs.h |   2 +
 2 files changed, 131 insertions(+), 48 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index f80a4244b9d2..d8bf52f77d93 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -185,50 +185,6 @@ struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
 	return ret == -ENOENT ? NULL : ERR_PTR(ret);
 }
 
-/*
- * Look up @cell in a dynroot directory.  This is a substitution for the
- * local cell name for the net namespace.
- */
-static struct dentry *afs_lookup_atcell(struct dentry *dentry)
-{
-	struct afs_cell *cell;
-	struct afs_net *net = afs_d2net(dentry);
-	struct dentry *ret;
-	char *name;
-	int len;
-
-	if (!net->ws_cell)
-		return ERR_PTR(-ENOENT);
-
-	ret = ERR_PTR(-ENOMEM);
-	name = kmalloc(AFS_MAXCELLNAME + 1, GFP_KERNEL);
-	if (!name)
-		goto out_p;
-
-	down_read(&net->cells_lock);
-	cell = net->ws_cell;
-	if (cell) {
-		len = cell->name_len;
-		memcpy(name, cell->name, len + 1);
-	}
-	up_read(&net->cells_lock);
-
-	ret = ERR_PTR(-ENOENT);
-	if (!cell)
-		goto out_n;
-
-	ret = lookup_one_len(name, dentry->d_parent, len);
-
-	/* We don't want to d_add() the @cell dentry here as we don't want to
-	 * the cached dentry to hide changes to the local cell name.
-	 */
-
-out_n:
-	kfree(name);
-out_p:
-	return ret;
-}
-
 /*
  * Look up an entry in a dynroot directory.
  */
@@ -247,10 +203,6 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
-	if (dentry->d_name.len == 5 &&
-	    memcmp(dentry->d_name.name, "@cell", 5) == 0)
-		return afs_lookup_atcell(dentry);
-
 	return d_splice_alias(afs_try_auto_mntpt(dentry, dir), dentry);
 }
 
@@ -343,6 +295,131 @@ void afs_dynroot_rmdir(struct afs_net *net, struct afs_cell *cell)
 	_leave("");
 }
 
+static void afs_atcell_delayed_put_cell(void *arg)
+{
+	struct afs_cell *cell = arg;
+
+	afs_put_cell(cell, afs_cell_trace_put_atcell);
+}
+
+/*
+ * Read @cell or .@cell symlinks.
+ */
+static const char *afs_atcell_get_link(struct dentry *dentry, struct inode *inode,
+				       struct delayed_call *done)
+{
+	struct afs_vnode *vnode = AFS_FS_I(inode);
+	struct afs_cell *cell;
+	struct afs_net *net = afs_i2net(inode);
+	const char *name;
+	bool dotted = vnode->fid.vnode == 3;
+
+	if (!net->ws_cell)
+		return ERR_PTR(-ENOENT);
+
+	down_read(&net->cells_lock);
+
+	cell = net->ws_cell;
+	if (dotted)
+		name = cell->name - 1;
+	else
+		name = cell->name;
+	afs_get_cell(cell, afs_cell_trace_get_atcell);
+	set_delayed_call(done, afs_atcell_delayed_put_cell, cell);
+
+	up_read(&net->cells_lock);
+	return name;
+}
+
+static const struct inode_operations afs_atcell_inode_operations = {
+	.get_link	= afs_atcell_get_link,
+};
+
+/*
+ * Look up @cell or .@cell in a dynroot directory.  This is a substitution for
+ * the local cell name for the net namespace.
+ */
+static struct dentry *afs_dynroot_create_symlink(struct dentry *root, const char *name)
+{
+	struct afs_vnode *vnode;
+	struct afs_fid fid = { .vnode = 2, .unique = 1, };
+	struct dentry *dentry;
+	struct inode *inode;
+
+	if (name[0] == '.')
+		fid.vnode = 3;
+
+	dentry = d_alloc_name(root, name);
+	if (!dentry)
+		return ERR_PTR(-ENOMEM);
+
+	inode = iget5_locked(dentry->d_sb, fid.vnode,
+			     afs_iget5_pseudo_test, afs_iget5_pseudo_set, &fid);
+	if (!inode) {
+		dput(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	vnode = AFS_FS_I(inode);
+
+	/* there shouldn't be an existing inode */
+	if (WARN_ON_ONCE(!(inode->i_state & I_NEW))) {
+		iput(inode);
+		dput(dentry);
+		return ERR_PTR(-EIO);
+	}
+
+	netfs_inode_init(&vnode->netfs, NULL, false);
+	simple_inode_init_ts(inode);
+	set_nlink(inode, 1);
+	inode->i_size		= 0;
+	inode->i_mode		= S_IFLNK | 0555;
+	inode->i_op		= &afs_atcell_inode_operations;
+	inode->i_uid		= GLOBAL_ROOT_UID;
+	inode->i_gid		= GLOBAL_ROOT_GID;
+	inode->i_blocks		= 0;
+	inode->i_generation	= 0;
+	inode->i_flags		|= S_NOATIME;
+
+	unlock_new_inode(inode);
+	d_splice_alias(inode, dentry);
+	return dentry;
+}
+
+/*
+ * Create @cell and .@cell symlinks.
+ */
+static int afs_dynroot_symlink(struct afs_net *net)
+{
+	struct super_block *sb = net->dynroot_sb;
+	struct dentry *root, *symlink, *dsymlink;
+	int ret;
+
+	/* Let the ->lookup op do the creation */
+	root = sb->s_root;
+	inode_lock(root->d_inode);
+	symlink = afs_dynroot_create_symlink(root, "@cell");
+	if (IS_ERR(symlink)) {
+		ret = PTR_ERR(symlink);
+		goto unlock;
+	}
+
+	dsymlink = afs_dynroot_create_symlink(root, ".@cell");
+	if (IS_ERR(dsymlink)) {
+		ret = PTR_ERR(dsymlink);
+		dput(symlink);
+		goto unlock;
+	}
+
+	/* Note that we're retaining extra refs on the dentries. */
+	symlink->d_fsdata = (void *)1UL;
+	dsymlink->d_fsdata = (void *)1UL;
+	ret = 0;
+unlock:
+	inode_unlock(root->d_inode);
+	return ret;
+}
+
 /*
  * Populate a newly created dynamic root with cell names.
  */
@@ -355,6 +432,10 @@ int afs_dynroot_populate(struct super_block *sb)
 	mutex_lock(&net->proc_cells_lock);
 
 	net->dynroot_sb = sb;
+	ret = afs_dynroot_symlink(net);
+	if (ret < 0)
+		goto error;
+
 	hlist_for_each_entry(cell, &net->proc_cells, proc_link) {
 		ret = afs_dynroot_mkdir(net, cell);
 		if (ret < 0)
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index a0aed1a428a1..de0e2301a037 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -168,12 +168,14 @@ enum yfs_cm_operation {
 #define afs_cell_traces \
 	EM(afs_cell_trace_alloc,		"ALLOC     ") \
 	EM(afs_cell_trace_free,			"FREE      ") \
+	EM(afs_cell_trace_get_atcell,		"GET atcell") \
 	EM(afs_cell_trace_get_queue_dns,	"GET q-dns ") \
 	EM(afs_cell_trace_get_queue_manage,	"GET q-mng ") \
 	EM(afs_cell_trace_get_queue_new,	"GET q-new ") \
 	EM(afs_cell_trace_get_vol,		"GET vol   ") \
 	EM(afs_cell_trace_insert,		"INSERT    ") \
 	EM(afs_cell_trace_manage,		"MANAGE    ") \
+	EM(afs_cell_trace_put_atcell,		"PUT atcell") \
 	EM(afs_cell_trace_put_candidate,	"PUT candid") \
 	EM(afs_cell_trace_put_destroy,		"PUT destry") \
 	EM(afs_cell_trace_put_queue_work,	"PUT q-work") \


