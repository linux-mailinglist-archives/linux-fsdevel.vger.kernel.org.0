Return-Path: <linux-fsdevel+bounces-43578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93A7A58FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421FF3AB893
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34882226CE7;
	Mon, 10 Mar 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5+fOkdT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861C28DD0
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599757; cv=none; b=CBD9yuuh7ZXD9HyEGZEoxK12Nj4twARNpuLvaGAbcSgU3v2AQhwepXeyrdDhXOENirEejUC9IVMfUia7hP3XGdeIu5jU3SFTRA2Nt3G9nA36w1/u3jED5J+uSK+deN8tSfOWd10ZYiynRMd+uBqr3OT9rRNk0XgW6w+DvMppykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599757; c=relaxed/simple;
	bh=cMHhv9RM3hj6/WlIbDmZi9TLJJamLvV8bOb7PkRKpSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WH7nw9LCMa2kWlAifW5IuuJgGFbPskZ8Xm9Uqh6la+EhJ7BoP0EpGZq/fM3kF0o3Xw9BF3jAIuowJ40GqqGq1tNak3UEeDsdpMbjuuYIGAMqrKxxP0wqtaS0SyNyeA4euULt4k8r1NVB67g35+Ebwm/SKFMD5FJDDNsyue/xeec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5+fOkdT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cMm0ywOLdFMT2qA3Az8Ii5/2TjzODIInteU1TsWfBo=;
	b=I5+fOkdTxUAstjMItJINTQXEYOrgvO1w+oopREfHCPOYUdSTz1rE8Jf7FD2pJb8yo80ldC
	sehMZ5XNCbPlAguI/AHX0wE4kENjk482/s39oaxEmjcuzpTSaLWr2xeBTbfg8AULG/lsTu
	4ohLBX7pB2b34vum9/bKfFSV8sxhNuM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-fuCyYHiwOHSkSoMt5MbXDA-1; Mon,
 10 Mar 2025 05:42:29 -0400
X-MC-Unique: fuCyYHiwOHSkSoMt5MbXDA-1
X-Mimecast-MFC-AGG-ID: fuCyYHiwOHSkSoMt5MbXDA_1741599748
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3091B1801A00;
	Mon, 10 Mar 2025 09:42:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47B681800366;
	Mon, 10 Mar 2025 09:42:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] afs: Change dynroot to create contents on demand
Date: Mon, 10 Mar 2025 09:41:56 +0000
Message-ID: <20250310094206.801057-4-dhowells@redhat.com>
In-Reply-To: <20250310094206.801057-1-dhowells@redhat.com>
References: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Change the AFS dynamic root to do things differently:

 (1) Rather than having the creation of cell records create inodes and
     dentries for cell mountpoints, create them on demand during lookup.

     This simplifies cell management and locking as we no longer have to
     create these objects in advance *and* on speculative lookup by the
     user for a cell that isn't precreated.

 (2) Rather than using the libfs dentry-based readdir (the dentries now no
     longer exist until accessed from (1)), have readdir generate the
     contents by reading the list of cells.  The @cell symlinks get pushed
     in positions 2 and 3 if rootcell has been configured.

 (3) Make the @cell symlink dentries persist for the life of the superblock
     or until reclaimed, but make cell mountpoints disappear immediately if
     unused.

     It's not perfect as someone doing an "ls -l /afs" may create a whole
     bunch of dentries which will be garbage collected immediately.  But
     any dentry that gets automounted will be pinned by the mount, so it
     shouldn't be too bad.

 (4) Allocate the inode numbers for the cell mountpoints from an IDR to
     prevent duplicates appearing in the event it cycles round.  The number
     allocated from the IDR is doubled to provide two inode numbers - one
     for the normal cell name (RO) and one for the dotted cell name (RW).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-8-dhowells@redhat.com/ # v1
---
 fs/afs/cell.c              |   9 +-
 fs/afs/dynroot.c           | 482 +++++++++++++++----------------------
 fs/afs/internal.h          |   8 +-
 fs/afs/main.c              |   3 +
 fs/afs/super.c             |   8 +-
 include/trace/events/afs.h |   2 +
 6 files changed, 213 insertions(+), 299 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 96a6781f3653..c2e44cd2eb96 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -204,7 +204,13 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->dns_status = vllist->status;
 	smp_store_release(&cell->dns_lookup_count, 1); /* vs source/status */
 	atomic_inc(&net->cells_outstanding);
+	ret = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
+			       2, INT_MAX / 2, GFP_KERNEL);
+	if (ret < 0)
+		goto error;
+	cell->dynroot_ino = ret;
 	cell->debug_id = atomic_inc_return(&cell_debug_id);
+
 	trace_afs_cell(cell->debug_id, 1, 0, afs_cell_trace_alloc);
 
 	_leave(" = %p", cell);
@@ -513,6 +519,7 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
 	afs_unuse_cell(net, cell->alias_of, afs_cell_trace_unuse_alias);
 	key_put(cell->anonymous_key);
+	idr_remove(&net->cells_dyn_ino, cell->dynroot_ino);
 	kfree(cell->name - 1);
 	kfree(cell);
 
@@ -706,7 +713,6 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
 	if (cell->proc_link.next)
 		cell->proc_link.next->pprev = &cell->proc_link.next;
 
-	afs_dynroot_mkdir(net, cell);
 	mutex_unlock(&net->proc_cells_lock);
 	return 0;
 }
@@ -723,7 +729,6 @@ static void afs_deactivate_cell(struct afs_net *net, struct afs_cell *cell)
 	mutex_lock(&net->proc_cells_lock);
 	if (!hlist_unhashed(&cell->proc_link))
 		hlist_del_rcu(&cell->proc_link);
-	afs_dynroot_rmdir(net, cell);
 	mutex_unlock(&net->proc_cells_lock);
 
 	_leave("");
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 0b4cc291c65e..eb20e231d7ac 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -10,16 +10,19 @@
 #include <linux/dns_resolver.h>
 #include "internal.h"
 
-static atomic_t afs_autocell_ino;
+#define AFS_MIN_DYNROOT_CELL_INO 4 /* Allow for ., .., @cell, .@cell */
+#define AFS_MAX_DYNROOT_CELL_INO ((unsigned int)INT_MAX)
+
+static struct dentry *afs_lookup_atcell(struct inode *dir, struct dentry *dentry, ino_t ino);
 
 /*
  * iget5() comparator for inode created by autocell operations
- *
- * These pseudo inodes don't match anything.
  */
 static int afs_iget5_pseudo_test(struct inode *inode, void *opaque)
 {
-	return 0;
+	struct afs_fid *fid = opaque;
+
+	return inode->i_ino == fid->vnode;
 }
 
 /*
@@ -39,28 +42,16 @@ static int afs_iget5_pseudo_set(struct inode *inode, void *opaque)
 }
 
 /*
- * Create an inode for a dynamic root directory or an autocell dynamic
- * automount dir.
+ * Create an inode for an autocell dynamic automount dir.
  */
-struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
+static struct inode *afs_iget_pseudo_dir(struct super_block *sb, ino_t ino)
 {
-	struct afs_super_info *as = AFS_FS_S(sb);
 	struct afs_vnode *vnode;
 	struct inode *inode;
-	struct afs_fid fid = {};
+	struct afs_fid fid = { .vnode = ino, .unique = 1, };
 
 	_enter("");
 
-	if (as->volume)
-		fid.vid = as->volume->vid;
-	if (root) {
-		fid.vnode = 1;
-		fid.unique = 1;
-	} else {
-		fid.vnode = atomic_inc_return(&afs_autocell_ino);
-		fid.unique = 0;
-	}
-
 	inode = iget5_locked(sb, fid.vnode,
 			     afs_iget5_pseudo_test, afs_iget5_pseudo_set, &fid);
 	if (!inode) {
@@ -73,112 +64,70 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 
 	vnode = AFS_FS_I(inode);
 
-	/* there shouldn't be an existing inode */
-	BUG_ON(!(inode->i_state & I_NEW));
-
-	netfs_inode_init(&vnode->netfs, NULL, false);
-	inode->i_size		= 0;
-	inode->i_mode		= S_IFDIR | S_IRUGO | S_IXUGO;
-	if (root) {
-		inode->i_op	= &afs_dynroot_inode_operations;
-		inode->i_fop	= &simple_dir_operations;
-	} else {
-		inode->i_op	= &afs_autocell_inode_operations;
-	}
-	set_nlink(inode, 2);
-	inode->i_uid		= GLOBAL_ROOT_UID;
-	inode->i_gid		= GLOBAL_ROOT_GID;
-	simple_inode_init_ts(inode);
-	inode->i_blocks		= 0;
-	inode->i_generation	= 0;
-
-	set_bit(AFS_VNODE_PSEUDODIR, &vnode->flags);
-	if (!root) {
+	if (inode->i_state & I_NEW) {
+		netfs_inode_init(&vnode->netfs, NULL, false);
+		simple_inode_init_ts(inode);
+		set_nlink(inode, 2);
+		inode->i_size		= 0;
+		inode->i_mode		= S_IFDIR | 0555;
+		inode->i_op		= &afs_autocell_inode_operations;
+		inode->i_uid		= GLOBAL_ROOT_UID;
+		inode->i_gid		= GLOBAL_ROOT_GID;
+		inode->i_blocks		= 0;
+		inode->i_generation	= 0;
+		inode->i_flags		|= S_AUTOMOUNT | S_NOATIME;
+
+		set_bit(AFS_VNODE_PSEUDODIR, &vnode->flags);
 		set_bit(AFS_VNODE_MOUNTPOINT, &vnode->flags);
-		inode->i_flags |= S_AUTOMOUNT;
-	}
 
-	inode->i_flags |= S_NOATIME;
-	unlock_new_inode(inode);
+		unlock_new_inode(inode);
+	}
 	_leave(" = %p", inode);
 	return inode;
 }
 
 /*
- * Probe to see if a cell may exist.  This prevents positive dentries from
- * being created unnecessarily.
+ * Try to automount the mountpoint with pseudo directory, if the autocell
+ * option is set.
  */
-static int afs_probe_cell_name(struct dentry *dentry)
+static struct dentry *afs_dynroot_lookup_cell(struct inode *dir, struct dentry *dentry,
+					      unsigned int flags)
 {
-	struct afs_cell *cell;
+	struct afs_cell *cell = NULL;
 	struct afs_net *net = afs_d2net(dentry);
+	struct inode *inode = NULL;
 	const char *name = dentry->d_name.name;
 	size_t len = dentry->d_name.len;
-	char *result = NULL;
-	int ret;
+	bool dotted = false;
+	int ret = -ENOENT;
 
 	/* Names prefixed with a dot are R/W mounts. */
 	if (name[0] == '.') {
-		if (len == 1)
-			return -EINVAL;
 		name++;
 		len--;
+		dotted = true;
 	}
 
-	cell = afs_find_cell(net, name, len, afs_cell_trace_use_probe);
-	if (!IS_ERR(cell)) {
-		afs_unuse_cell(net, cell, afs_cell_trace_unuse_probe);
-		return 0;
-	}
-
-	ret = dns_query(net->net, "afsdb", name, len, "srv=1",
-			&result, NULL, false);
-	if (ret == -ENODATA || ret == -ENOKEY || ret == 0)
-		ret = -ENOENT;
-	if (ret > 0 && ret >= sizeof(struct dns_server_list_v1_header)) {
-		struct dns_server_list_v1_header *v1 = (void *)result;
-
-		if (v1->hdr.zero == 0 &&
-		    v1->hdr.content == DNS_PAYLOAD_IS_SERVER_LIST &&
-		    v1->hdr.version == 1 &&
-		    (v1->status != DNS_LOOKUP_GOOD &&
-		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD))
-			return -ENOENT;
-
+	cell = afs_lookup_cell(net, name, len, NULL, false);
+	if (IS_ERR(cell)) {
+		ret = PTR_ERR(cell);
+		goto out_no_cell;
 	}
 
-	kfree(result);
-	return ret;
-}
-
-/*
- * Try to auto mount the mountpoint with pseudo directory, if the autocell
- * operation is setted.
- */
-static struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
-{
-	struct afs_vnode *vnode = AFS_FS_I(dir);
-	struct inode *inode;
-	int ret = -ENOENT;
-
-	_enter("%p{%pd}, {%llx:%llu}",
-	       dentry, dentry, vnode->fid.vid, vnode->fid.vnode);
-
-	ret = afs_probe_cell_name(dentry);
-	if (ret < 0)
-		goto out;
-
-	inode = afs_iget_pseudo_dir(dir->i_sb, false);
+	inode = afs_iget_pseudo_dir(dir->i_sb, cell->dynroot_ino * 2 + dotted);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto out;
 	}
 
-	_leave("= %p", inode);
-	return inode;
+	dentry->d_fsdata = cell;
+	return d_splice_alias(inode, dentry);
 
 out:
-	_leave("= %d", ret);
+	afs_unuse_cell(cell->net, cell, afs_cell_trace_unuse_lookup_dynroot);
+out_no_cell:
+	if (!inode)
+		return d_splice_alias(inode, dentry);
 	return ret == -ENOENT ? NULL : ERR_PTR(ret);
 }
 
@@ -190,8 +139,6 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 {
 	_enter("%pd", dentry);
 
-	ASSERTCMP(d_inode(dentry), ==, NULL);
-
 	if (flags & LOOKUP_CREATE)
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -200,98 +147,49 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
-	return d_splice_alias(afs_try_auto_mntpt(dentry, dir), dentry);
+	if (dentry->d_name.len == 5 &&
+	    memcmp(dentry->d_name.name, "@cell", 5) == 0)
+		return afs_lookup_atcell(dir, dentry, 2);
+
+	if (dentry->d_name.len == 6 &&
+	    memcmp(dentry->d_name.name, ".@cell", 6) == 0)
+		return afs_lookup_atcell(dir, dentry, 3);
+
+	return afs_dynroot_lookup_cell(dir, dentry, flags);
 }
 
 const struct inode_operations afs_dynroot_inode_operations = {
 	.lookup		= afs_dynroot_lookup,
 };
 
-const struct dentry_operations afs_dynroot_dentry_operations = {
-	.d_delete	= always_delete_dentry,
-	.d_release	= afs_d_release,
-	.d_automount	= afs_d_automount,
-};
-
-/*
- * Create a manually added cell mount directory.
- * - The caller must hold net->proc_cells_lock
- */
-int afs_dynroot_mkdir(struct afs_net *net, struct afs_cell *cell)
-{
-	struct super_block *sb = net->dynroot_sb;
-	struct dentry *root, *subdir, *dsubdir;
-	char *dotname = cell->name - 1;
-	int ret;
-
-	if (!sb || atomic_read(&sb->s_active) == 0)
-		return 0;
-
-	/* Let the ->lookup op do the creation */
-	root = sb->s_root;
-	inode_lock(root->d_inode);
-	subdir = lookup_one_len(cell->name, root, cell->name_len);
-	if (IS_ERR(subdir)) {
-		ret = PTR_ERR(subdir);
-		goto unlock;
-	}
-
-	dsubdir = lookup_one_len(dotname, root, cell->name_len + 1);
-	if (IS_ERR(dsubdir)) {
-		ret = PTR_ERR(dsubdir);
-		dput(subdir);
-		goto unlock;
-	}
-
-	/* Note that we're retaining extra refs on the dentries. */
-	subdir->d_fsdata = (void *)1UL;
-	dsubdir->d_fsdata = (void *)1UL;
-	ret = 0;
-unlock:
-	inode_unlock(root->d_inode);
-	return ret;
-}
-
-static void afs_dynroot_rm_one_dir(struct dentry *root, const char *name, size_t name_len)
+static void afs_dynroot_d_release(struct dentry *dentry)
 {
-	struct dentry *subdir;
-
-	/* Don't want to trigger a lookup call, which will re-add the cell */
-	subdir = try_lookup_one_len(name, root, name_len);
-	if (IS_ERR_OR_NULL(subdir)) {
-		_debug("lookup %ld", PTR_ERR(subdir));
-		return;
-	}
-
-	_debug("rmdir %pd %u", subdir, d_count(subdir));
+	struct afs_cell *cell = dentry->d_fsdata;
 
-	if (subdir->d_fsdata) {
-		_debug("unpin %u", d_count(subdir));
-		subdir->d_fsdata = NULL;
-		dput(subdir);
-	}
-	dput(subdir);
+	afs_unuse_cell(cell->net, cell, afs_cell_trace_unuse_dynroot_mntpt);
 }
 
 /*
- * Remove a manually added cell mount directory.
- * - The caller must hold net->proc_cells_lock
+ * Keep @cell symlink dentries around, but only keep cell autodirs when they're
+ * being used.
  */
-void afs_dynroot_rmdir(struct afs_net *net, struct afs_cell *cell)
+static int afs_dynroot_delete_dentry(const struct dentry *dentry)
 {
-	struct super_block *sb = net->dynroot_sb;
-	char *dotname = cell->name - 1;
-
-	if (!sb || atomic_read(&sb->s_active) == 0)
-		return;
+	const struct qstr *name = &dentry->d_name;
 
-	inode_lock(sb->s_root->d_inode);
-	afs_dynroot_rm_one_dir(sb->s_root, cell->name, cell->name_len);
-	afs_dynroot_rm_one_dir(sb->s_root, dotname, cell->name_len + 1);
-	inode_unlock(sb->s_root->d_inode);
-	_leave("");
+	if (name->len == 5 && memcmp(name->name, "@cell", 5) == 0)
+		return 0;
+	if (name->len == 6 && memcmp(name->name, ".@cell", 6) == 0)
+		return 0;
+	return 1;
 }
 
+const struct dentry_operations afs_dynroot_dentry_operations = {
+	.d_delete	= afs_dynroot_delete_dentry,
+	.d_release	= afs_dynroot_d_release,
+	.d_automount	= afs_d_automount,
+};
+
 static void afs_atcell_delayed_put_cell(void *arg)
 {
 	struct afs_cell *cell = arg;
@@ -344,149 +242,163 @@ static const struct inode_operations afs_atcell_inode_operations = {
 };
 
 /*
- * Look up @cell or .@cell in a dynroot directory.  This is a substitution for
- * the local cell name for the net namespace.
+ * Create an inode for the @cell or .@cell symlinks.
  */
-static struct dentry *afs_dynroot_create_symlink(struct dentry *root, const char *name)
+static struct dentry *afs_lookup_atcell(struct inode *dir, struct dentry *dentry, ino_t ino)
 {
 	struct afs_vnode *vnode;
-	struct afs_fid fid = { .vnode = 2, .unique = 1, };
-	struct dentry *dentry;
 	struct inode *inode;
+	struct afs_fid fid = { .vnode = ino, .unique = 1, };
 
-	if (name[0] == '.')
-		fid.vnode = 3;
-
-	dentry = d_alloc_name(root, name);
-	if (!dentry)
-		return ERR_PTR(-ENOMEM);
-
-	inode = iget5_locked(dentry->d_sb, fid.vnode,
+	inode = iget5_locked(dir->i_sb, fid.vnode,
 			     afs_iget5_pseudo_test, afs_iget5_pseudo_set, &fid);
-	if (!inode) {
-		dput(dentry);
+	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	vnode = AFS_FS_I(inode);
 
-	/* there shouldn't be an existing inode */
-	if (WARN_ON_ONCE(!(inode->i_state & I_NEW))) {
-		iput(inode);
-		dput(dentry);
-		return ERR_PTR(-EIO);
+	if (inode->i_state & I_NEW) {
+		netfs_inode_init(&vnode->netfs, NULL, false);
+		simple_inode_init_ts(inode);
+		set_nlink(inode, 1);
+		inode->i_size		= 0;
+		inode->i_mode		= S_IFLNK | 0555;
+		inode->i_op		= &afs_atcell_inode_operations;
+		inode->i_uid		= GLOBAL_ROOT_UID;
+		inode->i_gid		= GLOBAL_ROOT_GID;
+		inode->i_blocks		= 0;
+		inode->i_generation	= 0;
+		inode->i_flags		|= S_NOATIME;
+
+		unlock_new_inode(inode);
 	}
-
-	netfs_inode_init(&vnode->netfs, NULL, false);
-	simple_inode_init_ts(inode);
-	set_nlink(inode, 1);
-	inode->i_size		= 0;
-	inode->i_mode		= S_IFLNK | 0555;
-	inode->i_op		= &afs_atcell_inode_operations;
-	inode->i_uid		= GLOBAL_ROOT_UID;
-	inode->i_gid		= GLOBAL_ROOT_GID;
-	inode->i_blocks		= 0;
-	inode->i_generation	= 0;
-	inode->i_flags		|= S_NOATIME;
-
-	unlock_new_inode(inode);
-	d_splice_alias(inode, dentry);
-	return dentry;
+	return d_splice_alias(inode, dentry);
 }
 
 /*
- * Create @cell and .@cell symlinks.
+ * Transcribe the cell database into readdir content under the RCU read lock.
+ * Each cell produces two entries, one prefixed with a dot and one not.
  */
-static int afs_dynroot_symlink(struct afs_net *net)
+static int afs_dynroot_readdir_cells(struct afs_net *net, struct dir_context *ctx)
 {
-	struct super_block *sb = net->dynroot_sb;
-	struct dentry *root, *symlink, *dsymlink;
-	int ret;
-
-	/* Let the ->lookup op do the creation */
-	root = sb->s_root;
-	inode_lock(root->d_inode);
-	symlink = afs_dynroot_create_symlink(root, "@cell");
-	if (IS_ERR(symlink)) {
-		ret = PTR_ERR(symlink);
-		goto unlock;
-	}
+	const struct afs_cell *cell;
+	loff_t newpos;
+
+	_enter("%llu", ctx->pos);
+
+	for (;;) {
+		unsigned int ix = ctx->pos >> 1;
+
+		cell = idr_get_next(&net->cells_dyn_ino, &ix);
+		if (!cell)
+			return 0;
+		if (READ_ONCE(cell->state) == AFS_CELL_FAILED ||
+		    READ_ONCE(cell->state) == AFS_CELL_REMOVED) {
+			ctx->pos += 2;
+			ctx->pos &= ~1;
+			continue;
+		}
 
-	dsymlink = afs_dynroot_create_symlink(root, ".@cell");
-	if (IS_ERR(dsymlink)) {
-		ret = PTR_ERR(dsymlink);
-		dput(symlink);
-		goto unlock;
-	}
+		newpos = ix << 1;
+		if (newpos > ctx->pos)
+			ctx->pos = newpos;
 
-	/* Note that we're retaining extra refs on the dentries. */
-	symlink->d_fsdata = (void *)1UL;
-	dsymlink->d_fsdata = (void *)1UL;
-	ret = 0;
-unlock:
-	inode_unlock(root->d_inode);
-	return ret;
+		_debug("pos %llu -> cell %u", ctx->pos, cell->dynroot_ino);
+
+		if ((ctx->pos & 1) == 0) {
+			if (!dir_emit(ctx, cell->name, cell->name_len,
+				      cell->dynroot_ino, DT_DIR))
+				return 0;
+			ctx->pos++;
+		}
+		if ((ctx->pos & 1) == 1) {
+			if (!dir_emit(ctx, cell->name - 1, cell->name_len + 1,
+				      cell->dynroot_ino + 1, DT_DIR))
+				return 0;
+			ctx->pos++;
+		}
+	}
+	return 0;
 }
 
 /*
- * Populate a newly created dynamic root with cell names.
+ * Read the AFS dynamic root directory.  This produces a list of cellnames,
+ * dotted and undotted, along with @cell and .@cell links if configured.
  */
-int afs_dynroot_populate(struct super_block *sb)
+static int afs_dynroot_readdir(struct file *file, struct dir_context *ctx)
 {
-	struct afs_cell *cell;
-	struct afs_net *net = afs_sb2net(sb);
-	int ret;
+	struct afs_net *net = afs_d2net(file->f_path.dentry);
+	int ret = 0;
 
-	mutex_lock(&net->proc_cells_lock);
-
-	net->dynroot_sb = sb;
-	ret = afs_dynroot_symlink(net);
-	if (ret < 0)
-		goto error;
+	if (!dir_emit_dots(file, ctx))
+		return 0;
 
-	hlist_for_each_entry(cell, &net->proc_cells, proc_link) {
-		ret = afs_dynroot_mkdir(net, cell);
-		if (ret < 0)
-			goto error;
+	if (ctx->pos == 2) {
+		if (rcu_access_pointer(net->ws_cell) &&
+		    !dir_emit(ctx, "@cell", 5, 2, DT_LNK))
+			return 0;
+		ctx->pos = 3;
+	}
+	if (ctx->pos == 3) {
+		if (rcu_access_pointer(net->ws_cell) &&
+		    !dir_emit(ctx, ".@cell", 6, 3, DT_LNK))
+			return 0;
+		ctx->pos = 4;
 	}
 
-	ret = 0;
-out:
-	mutex_unlock(&net->proc_cells_lock);
+	if ((unsigned long long)ctx->pos <= AFS_MAX_DYNROOT_CELL_INO) {
+		rcu_read_lock();
+		ret = afs_dynroot_readdir_cells(net, ctx);
+		rcu_read_unlock();
+	}
 	return ret;
-
-error:
-	net->dynroot_sb = NULL;
-	goto out;
 }
 
+static const struct file_operations afs_dynroot_file_operations = {
+	.llseek		= generic_file_llseek,
+	.read		= generic_read_dir,
+	.iterate_shared	= afs_dynroot_readdir,
+	.fsync		= noop_fsync,
+};
+
 /*
- * When a dynamic root that's in the process of being destroyed, depopulate it
- * of pinned directories.
+ * Create an inode for a dynamic root directory.
  */
-void afs_dynroot_depopulate(struct super_block *sb)
+struct inode *afs_dynroot_iget_root(struct super_block *sb)
 {
-	struct afs_net *net = afs_sb2net(sb);
-	struct dentry *root = sb->s_root, *subdir;
-
-	/* Prevent more subdirs from being created */
-	mutex_lock(&net->proc_cells_lock);
-	if (net->dynroot_sb == sb)
-		net->dynroot_sb = NULL;
-	mutex_unlock(&net->proc_cells_lock);
-
-	if (root) {
-		struct hlist_node *n;
-		inode_lock(root->d_inode);
-
-		/* Remove all the pins for dirs created for manually added cells */
-		hlist_for_each_entry_safe(subdir, n, &root->d_children, d_sib) {
-			if (subdir->d_fsdata) {
-				subdir->d_fsdata = NULL;
-				dput(subdir);
-			}
-		}
+	struct afs_super_info *as = AFS_FS_S(sb);
+	struct afs_vnode *vnode;
+	struct inode *inode;
+	struct afs_fid fid = { .vid = 0, .vnode = 1, .unique = 1,};
+
+	if (as->volume)
+		fid.vid = as->volume->vid;
 
-		inode_unlock(root->d_inode);
+	inode = iget5_locked(sb, fid.vnode,
+			     afs_iget5_pseudo_test, afs_iget5_pseudo_set, &fid);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	vnode = AFS_FS_I(inode);
+
+	/* there shouldn't be an existing inode */
+	if (inode->i_state & I_NEW) {
+		netfs_inode_init(&vnode->netfs, NULL, false);
+		simple_inode_init_ts(inode);
+		set_nlink(inode, 2);
+		inode->i_size		= 0;
+		inode->i_mode		= S_IFDIR | 0555;
+		inode->i_op		= &afs_dynroot_inode_operations;
+		inode->i_fop		= &afs_dynroot_file_operations;
+		inode->i_uid		= GLOBAL_ROOT_UID;
+		inode->i_gid		= GLOBAL_ROOT_GID;
+		inode->i_blocks		= 0;
+		inode->i_generation	= 0;
+		inode->i_flags		|= S_NOATIME;
+
+		set_bit(AFS_VNODE_PSEUDODIR, &vnode->flags);
+		unlock_new_inode(inode);
 	}
+	_leave(" = %p", inode);
+	return inode;
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0e00e061f0d9..47e98a78f59f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -287,6 +287,7 @@ struct afs_net {
 
 	/* Cell database */
 	struct rb_root		cells;
+	struct idr		cells_dyn_ino;	/* cell->dynroot_ino mapping */
 	struct afs_cell __rcu	*ws_cell;
 	struct work_struct	cells_manager;
 	struct timer_list	cells_timer;
@@ -398,6 +399,7 @@ struct afs_cell {
 	enum dns_lookup_status	dns_status:8;	/* Latest status of data from lookup */
 	unsigned int		dns_lookup_count; /* Counter of DNS lookups */
 	unsigned int		debug_id;
+	unsigned int		dynroot_ino;	/* Inode numbers for dynroot (a pair) */
 
 	/* The volumes belonging to this cell */
 	struct rw_semaphore	vs_lock;	/* Lock for server->volumes */
@@ -1110,10 +1112,7 @@ extern int afs_silly_iput(struct dentry *, struct inode *);
 extern const struct inode_operations afs_dynroot_inode_operations;
 extern const struct dentry_operations afs_dynroot_dentry_operations;
 
-extern int afs_dynroot_mkdir(struct afs_net *, struct afs_cell *);
-extern void afs_dynroot_rmdir(struct afs_net *, struct afs_cell *);
-extern int afs_dynroot_populate(struct super_block *);
-extern void afs_dynroot_depopulate(struct super_block *);
+struct inode *afs_dynroot_iget_root(struct super_block *sb);
 
 /*
  * file.c
@@ -1226,7 +1225,6 @@ int afs_readlink(struct dentry *dentry, char __user *buffer, int buflen);
 extern void afs_vnode_commit_status(struct afs_operation *, struct afs_vnode_param *);
 extern int afs_fetch_status(struct afs_vnode *, struct key *, bool, afs_access_t *);
 extern int afs_ilookup5_test_by_fid(struct inode *, void *);
-extern struct inode *afs_iget_pseudo_dir(struct super_block *, bool);
 extern struct inode *afs_iget(struct afs_operation *, struct afs_vnode_param *);
 extern struct inode *afs_root_iget(struct super_block *, struct key *);
 extern int afs_getattr(struct mnt_idmap *idmap, const struct path *,
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 1ae0067f772d..a7c7dc268302 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -76,6 +76,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 	mutex_init(&net->socket_mutex);
 
 	net->cells = RB_ROOT;
+	idr_init(&net->cells_dyn_ino);
 	init_rwsem(&net->cells_lock);
 	INIT_WORK(&net->cells_manager, afs_manage_cells);
 	timer_setup(&net->cells_timer, afs_cells_timer, 0);
@@ -137,6 +138,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 error_proc:
 	afs_put_sysnames(net->sysnames);
 error_sysnames:
+	idr_destroy(&net->cells_dyn_ino);
 	net->live = false;
 	return ret;
 }
@@ -155,6 +157,7 @@ static void __net_exit afs_net_exit(struct net *net_ns)
 	afs_close_socket(net);
 	afs_proc_cleanup(net);
 	afs_put_sysnames(net->sysnames);
+	idr_destroy(&net->cells_dyn_ino);
 	kfree_rcu(rcu_access_pointer(net->address_prefs), rcu);
 }
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 2f18aa8e2806..dfc109f48ad5 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -466,7 +466,7 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 
 	/* allocate the root inode and dentry */
 	if (as->dyn_root) {
-		inode = afs_iget_pseudo_dir(sb, true);
+		inode = afs_dynroot_iget_root(sb);
 	} else {
 		sprintf(sb->s_id, "%llu", as->volume->vid);
 		afs_activate_volume(as->volume);
@@ -483,9 +483,6 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 
 	if (as->dyn_root) {
 		sb->s_d_op = &afs_dynroot_dentry_operations;
-		ret = afs_dynroot_populate(sb);
-		if (ret < 0)
-			goto error;
 	} else {
 		sb->s_d_op = &afs_fs_dentry_operations;
 		rcu_assign_pointer(as->volume->sb, sb);
@@ -534,9 +531,6 @@ static void afs_kill_super(struct super_block *sb)
 {
 	struct afs_super_info *as = AFS_FS_S(sb);
 
-	if (as->dyn_root)
-		afs_dynroot_depopulate(sb);
-
 	/* Clear the callback interests (which will do ilookup5) before
 	 * deactivating the superblock.
 	 */
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 958a2460330c..c19132605f41 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -190,8 +190,10 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_unuse_alias,		"UNU alias ") \
 	EM(afs_cell_trace_unuse_check_alias,	"UNU chk-al") \
 	EM(afs_cell_trace_unuse_delete,		"UNU delete") \
+	EM(afs_cell_trace_unuse_dynroot_mntpt,	"UNU dyn-mp") \
 	EM(afs_cell_trace_unuse_fc,		"UNU fc    ") \
 	EM(afs_cell_trace_unuse_lookup,		"UNU lookup") \
+	EM(afs_cell_trace_unuse_lookup_dynroot,	"UNU lu-dyn") \
 	EM(afs_cell_trace_unuse_mntpt,		"UNU mntpt ") \
 	EM(afs_cell_trace_unuse_no_pin,		"UNU no-pin") \
 	EM(afs_cell_trace_unuse_parse,		"UNU parse ") \


