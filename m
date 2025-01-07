Return-Path: <linux-fsdevel+bounces-38566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C21A04275
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256F5166E88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD3B1F2365;
	Tue,  7 Jan 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSiYVFS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA31F190D
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259932; cv=none; b=FCsBgtt6w/A7uK8PO2lqGvDBFTXub3QbAuVLKX10H6sWK+QcS9ZF5aDUUU2zaI8a1Fpsd+/NjEUAtMez7qNBBONINt/iraEzEHZRAZ7ek6nD29bAGOn6/MTWaj+mlw4SBcIVFTJlB5jS2TQT7dUPzK5md8hWbAsR202kSi12MRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259932; c=relaxed/simple;
	bh=Q11pG85zrRGgDAFQxBRfmBBWf01etcXbSgKoKnbYPRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFQih6issudMwf5mEDFjv4MTzoDbgoHFsg+8qfyWl4uhNEKjjHNKMKrSlMVUDsYusGQQ9M78+kekKQxF581YwD37AvSrhbXqPdSvjigt0kbCBPP9PN5kJAQKYcuQEMfQ+hPPGeIvTFQhhdxggBO1R6QfGgDHbuu+Sx2Z4prPiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSiYVFS7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736259927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa/GU7W0ecMxEDBGDWuoSeU5bwFHSdZFnN7p8T+LcWM=;
	b=FSiYVFS73xvyjjcnzdCh8I6j6u4HSG90EYs9RCXzMhEBNtKNUGUVvAbPXU4Bc9U2qAO/wP
	mpuwUM2kGspwZyUjNHFZLUPX0PP/TRFBBkdTHNFnBMREsrMa0TgUl3NH00lTKOu2zR+bmB
	nvDe9PqZ15zAO+HKSLKtB/fiIEQwCG0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-wpEUfdSuP2ydKNF-CerZrw-1; Tue,
 07 Jan 2025 09:25:23 -0500
X-MC-Unique: wpEUfdSuP2ydKNF-CerZrw-1
X-Mimecast-MFC-AGG-ID: wpEUfdSuP2ydKNF-CerZrw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99AB21955F44;
	Tue,  7 Jan 2025 14:25:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DDCD3000707;
	Tue,  7 Jan 2025 14:25:20 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] afs: Make /afs/.<cell> as well /afs/<cell> mountpoints
Date: Tue,  7 Jan 2025 14:25:08 +0000
Message-ID: <20250107142513.527300-2-dhowells@redhat.com>
In-Reply-To: <20250107142513.527300-1-dhowells@redhat.com>
References: <20250107142513.527300-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When a cell is instantiated, automatically create an /afs/.<cell>
mountpoint to match the /afs/<cell> mountpoint to match other AFS clients.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cell.c    | 13 +++++++-----
 fs/afs/dynroot.c | 52 ++++++++++++++++++++++++++++++------------------
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index caa09875f520..1aba6d4d03a9 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -146,18 +146,20 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	cell->name = kmalloc(namelen + 1, GFP_KERNEL);
+	cell->name = kmalloc(1 + namelen + 1, GFP_KERNEL);
 	if (!cell->name) {
 		kfree(cell);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	cell->net = net;
+	cell->name[0] = '.';
+	cell->name++;
 	cell->name_len = namelen;
 	for (i = 0; i < namelen; i++)
 		cell->name[i] = tolower(name[i]);
 	cell->name[i] = 0;
 
+	cell->net = net;
 	refcount_set(&cell->ref, 1);
 	atomic_set(&cell->active, 0);
 	INIT_WORK(&cell->manager, afs_manage_cell_work);
@@ -211,7 +213,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	if (ret == -EINVAL)
 		printk(KERN_ERR "kAFS: bad VL server IP address\n");
 error:
-	kfree(cell->name);
+	kfree(cell->name - 1);
 	kfree(cell);
 	_leave(" = %d", ret);
 	return ERR_PTR(ret);
@@ -502,7 +504,7 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
 	afs_unuse_cell(net, cell->alias_of, afs_cell_trace_unuse_alias);
 	key_put(cell->anonymous_key);
-	kfree(cell->name);
+	kfree(cell->name - 1);
 	kfree(cell);
 
 	afs_dec_cells_outstanding(net);
@@ -710,7 +712,8 @@ static void afs_deactivate_cell(struct afs_net *net, struct afs_cell *cell)
 	afs_proc_cell_remove(cell);
 
 	mutex_lock(&net->proc_cells_lock);
-	hlist_del_rcu(&cell->proc_link);
+	if (!hlist_unhashed(&cell->proc_link))
+		hlist_del_rcu(&cell->proc_link);
 	afs_dynroot_rmdir(net, cell);
 	mutex_unlock(&net->proc_cells_lock);
 
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index c4d2711e20ad..f80a4244b9d2 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -271,7 +271,8 @@ const struct dentry_operations afs_dynroot_dentry_operations = {
 int afs_dynroot_mkdir(struct afs_net *net, struct afs_cell *cell)
 {
 	struct super_block *sb = net->dynroot_sb;
-	struct dentry *root, *subdir;
+	struct dentry *root, *subdir, *dsubdir;
+	char *dotname = cell->name - 1;
 	int ret;
 
 	if (!sb || atomic_read(&sb->s_active) == 0)
@@ -286,34 +287,31 @@ int afs_dynroot_mkdir(struct afs_net *net, struct afs_cell *cell)
 		goto unlock;
 	}
 
-	/* Note that we're retaining an extra ref on the dentry */
+	dsubdir = lookup_one_len(dotname, root, cell->name_len + 1);
+	if (IS_ERR(dsubdir)) {
+		ret = PTR_ERR(dsubdir);
+		dput(subdir);
+		goto unlock;
+	}
+
+	/* Note that we're retaining extra refs on the dentries. */
 	subdir->d_fsdata = (void *)1UL;
+	dsubdir->d_fsdata = (void *)1UL;
 	ret = 0;
 unlock:
 	inode_unlock(root->d_inode);
 	return ret;
 }
 
-/*
- * Remove a manually added cell mount directory.
- * - The caller must hold net->proc_cells_lock
- */
-void afs_dynroot_rmdir(struct afs_net *net, struct afs_cell *cell)
+static void afs_dynroot_rm_one_dir(struct dentry *root, const char *name, size_t name_len)
 {
-	struct super_block *sb = net->dynroot_sb;
-	struct dentry *root, *subdir;
-
-	if (!sb || atomic_read(&sb->s_active) == 0)
-		return;
-
-	root = sb->s_root;
-	inode_lock(root->d_inode);
+	struct dentry *subdir;
 
 	/* Don't want to trigger a lookup call, which will re-add the cell */
-	subdir = try_lookup_one_len(cell->name, root, cell->name_len);
+	subdir = try_lookup_one_len(name, root, name_len);
 	if (IS_ERR_OR_NULL(subdir)) {
 		_debug("lookup %ld", PTR_ERR(subdir));
-		goto no_dentry;
+		return;
 	}
 
 	_debug("rmdir %pd %u", subdir, d_count(subdir));
@@ -324,8 +322,24 @@ void afs_dynroot_rmdir(struct afs_net *net, struct afs_cell *cell)
 		dput(subdir);
 	}
 	dput(subdir);
-no_dentry:
-	inode_unlock(root->d_inode);
+}
+
+/*
+ * Remove a manually added cell mount directory.
+ * - The caller must hold net->proc_cells_lock
+ */
+void afs_dynroot_rmdir(struct afs_net *net, struct afs_cell *cell)
+{
+	struct super_block *sb = net->dynroot_sb;
+	char *dotname = cell->name - 1;
+
+	if (!sb || atomic_read(&sb->s_active) == 0)
+		return;
+
+	inode_lock(sb->s_root->d_inode);
+	afs_dynroot_rm_one_dir(sb->s_root, cell->name, cell->name_len);
+	afs_dynroot_rm_one_dir(sb->s_root, dotname, cell->name_len + 1);
+	inode_unlock(sb->s_root->d_inode);
 	_leave("");
 }
 


