Return-Path: <linux-fsdevel+bounces-38567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF72AA04279
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDEA1618B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA81F239B;
	Tue,  7 Jan 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qf+mECIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934171F237A
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259937; cv=none; b=uiHGEigD/DeoXf0to5frCf+nl4flOJ9YSHFCpMAnNW7Hhd/Ab5WY/xM8nFhKzZAuxWRVFQOfytQFh+hlpXJHNu6IS4lSfXk9QqPhe8qx7fDEJL1Oiqlu/9jPwzYvAYc/87zJNVys+jxrVu8mDmvqaHzT+s4DLUvWRA6eou52A4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259937; c=relaxed/simple;
	bh=JzWH9G/CYuXVmbP7m814x8qq6q2ma0tJQW1RlG0Uzu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQoATjd1k02ApNvlcfwdyuXt6zhQDPopXjjJL3i/arlAJe1yFVBGPOMGKXXIywt/0N+oQzP+EfqkS0K2PR2brbsnunCYd3o7/L7IDcG7U1fguY6Fpjwh8ghaInojE/bpXCP5VG1coCfQY70D/5Sizui7ry8Wm2sB/C3g+21lqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qf+mECIf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736259930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cdtBma5hDwVCZWV7QAeFFB8EmGFrVFNy3JmtSkoG34=;
	b=Qf+mECIfex0KzYirqQ/xRQsY/r6iijwLgrKP07XrvqcjPiLumIpztHP5L9Y/Kc8PyXsR8P
	5LN4CeS71gDSlF+hTU9kq8P3PnMOfoibtU8N69xHkkLs0wj3IC+wZKyPpMsexfLpHqcfqO
	X58yhRpILdXBrfWUUnwr46rDcmhbCbo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-Hid6hv1YNQKDUHzGpT--oQ-1; Tue,
 07 Jan 2025 09:25:27 -0500
X-MC-Unique: Hid6hv1YNQKDUHzGpT--oQ-1
X-Mimecast-MFC-AGG-ID: Hid6hv1YNQKDUHzGpT--oQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2174419560BC;
	Tue,  7 Jan 2025 14:25:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30EFE1956053;
	Tue,  7 Jan 2025 14:25:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] afs: Make /afs/@cell and /afs/.@cell symlinks
Date: Tue,  7 Jan 2025 14:25:09 +0000
Message-ID: <20250107142513.527300-3-dhowells@redhat.com>
In-Reply-To: <20250107142513.527300-1-dhowells@redhat.com>
References: <20250107142513.527300-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Make /afs/@cell a symlink in the /afs dynamic root to match what other AFS
clients do rather than doing a substitution in the dentry name.  This has
the bonus of being tab-expandable also.

Further, provide a /afs/.@cell symlink to point to the dotted cell share.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dynroot.c           | 140 +++++++++++++++++++++++++++++--------
 include/trace/events/afs.h |   2 +
 2 files changed, 112 insertions(+), 30 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index f80a4244b9d2..5a53631239f1 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -11,6 +11,8 @@
 #include "internal.h"
 
 static atomic_t afs_autocell_ino;
+static const char afs_atcell[] = "@cell";
+static const char afs_dotatcell[] = ".@cell";
 
 /*
  * iget5() comparator for inode created by autocell operations
@@ -185,48 +187,84 @@ struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
 	return ret == -ENOENT ? NULL : ERR_PTR(ret);
 }
 
+static void afs_atcell_delayed_put_cell(void *arg)
+{
+	struct afs_cell *cell = arg;
+
+	afs_put_cell(cell, afs_cell_trace_put_atcell);
+}
+
 /*
- * Look up @cell in a dynroot directory.  This is a substitution for the
- * local cell name for the net namespace.
+ * Read @cell or .@cell symlinks.
  */
-static struct dentry *afs_lookup_atcell(struct dentry *dentry)
+static const char *afs_atcell_get_link(struct dentry *dentry, struct inode *inode,
+				       struct delayed_call *done)
 {
+	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_cell *cell;
-	struct afs_net *net = afs_d2net(dentry);
-	struct dentry *ret;
-	char *name;
-	int len;
+	struct afs_net *net = afs_i2net(inode);
+	const char *name;
+	bool dotted = vnode->fid.vnode == 3;
 
 	if (!net->ws_cell)
 		return ERR_PTR(-ENOENT);
 
-	ret = ERR_PTR(-ENOMEM);
-	name = kmalloc(AFS_MAXCELLNAME + 1, GFP_KERNEL);
-	if (!name)
-		goto out_p;
-
 	down_read(&net->cells_lock);
+
 	cell = net->ws_cell;
-	if (cell) {
-		len = cell->name_len;
-		memcpy(name, cell->name, len + 1);
-	}
+	if (dotted)
+		name = cell->name - 1;
+	else
+		name = cell->name;
+	afs_get_cell(cell, afs_cell_trace_get_atcell);
+	set_delayed_call(done, afs_atcell_delayed_put_cell, cell);
+
 	up_read(&net->cells_lock);
+	return name;
+}
 
-	ret = ERR_PTR(-ENOENT);
-	if (!cell)
-		goto out_n;
+static const struct inode_operations afs_atcell_inode_operations = {
+	.get_link	= afs_atcell_get_link,
+};
 
-	ret = lookup_one_len(name, dentry->d_parent, len);
+/*
+ * Look up @cell or .@cell in a dynroot directory.  This is a substitution for
+ * the local cell name for the net namespace.
+ */
+static struct dentry *afs_lookup_atcell(struct dentry *dentry, bool dotted)
+{
+	struct afs_vnode *vnode;
+	struct afs_fid fid = { .vnode = 2, .unique = 1, };
+	struct inode *inode;
 
-	/* We don't want to d_add() the @cell dentry here as we don't want to
-	 * the cached dentry to hide changes to the local cell name.
-	 */
+	if (dotted)
+		fid.vnode = 3;
 
-out_n:
-	kfree(name);
-out_p:
-	return ret;
+
+	inode = iget5_locked(dentry->d_sb, fid.vnode,
+			     afs_iget5_pseudo_test, afs_iget5_pseudo_set, &fid);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	vnode = AFS_FS_I(inode);
+
+	/* there shouldn't be an existing inode */
+	BUG_ON(!(inode->i_state & I_NEW));
+
+	netfs_inode_init(&vnode->netfs, NULL, false);
+	simple_inode_init_ts(inode);
+	set_nlink(inode, 1);
+	inode->i_size		= 0;
+	inode->i_mode		= S_IFLNK | S_IRUGO | S_IXUGO;
+	inode->i_op		= &afs_atcell_inode_operations;
+	inode->i_uid		= GLOBAL_ROOT_UID;
+	inode->i_gid		= GLOBAL_ROOT_GID;
+	inode->i_blocks		= 0;
+	inode->i_generation	= 0;
+	inode->i_flags		|= S_NOATIME;
+
+	unlock_new_inode(inode);
+	return d_splice_alias(inode, dentry);
 }
 
 /*
@@ -247,9 +285,13 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
-	if (dentry->d_name.len == 5 &&
-	    memcmp(dentry->d_name.name, "@cell", 5) == 0)
-		return afs_lookup_atcell(dentry);
+	if (dentry->d_name.len == sizeof(afs_atcell) - 1 &&
+	    memcmp(dentry->d_name.name, afs_atcell, sizeof(afs_atcell) - 1) == 0)
+		return afs_lookup_atcell(dentry, false);
+
+	if (dentry->d_name.len == sizeof(afs_dotatcell) - 1 &&
+	    memcmp(dentry->d_name.name, afs_dotatcell, sizeof(afs_dotatcell) - 1) == 0)
+		return afs_lookup_atcell(dentry, true);
 
 	return d_splice_alias(afs_try_auto_mntpt(dentry, dir), dentry);
 }
@@ -343,6 +385,40 @@ void afs_dynroot_rmdir(struct afs_net *net, struct afs_cell *cell)
 	_leave("");
 }
 
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
+	symlink = lookup_one_len(afs_atcell, root, sizeof(afs_atcell) - 1);
+	if (IS_ERR(symlink)) {
+		ret = PTR_ERR(symlink);
+		goto unlock;
+	}
+
+	dsymlink = lookup_one_len(afs_dotatcell, root, sizeof(afs_dotatcell) - 1);
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
@@ -355,6 +431,10 @@ int afs_dynroot_populate(struct super_block *sb)
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


