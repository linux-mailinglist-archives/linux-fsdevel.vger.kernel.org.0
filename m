Return-Path: <linux-fsdevel+bounces-43577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F5A58FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A758188FE15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB31225A5B;
	Mon, 10 Mar 2025 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtnJusDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72623225A37
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599752; cv=none; b=mTVrKMC3EKuew9W6Umt1GUwzUkBSUDGaU9GtL1cZiTg0HFGVTHvEhQKM5sza7bkRUOQOQro26cXA8VXVO0HAoF5QLSqfk+lQhAedk72LMlKxLcANUX9zvXc8e2YRhZB/7F7zxJqZ49hYv7lYAkHIfCQoeRzfFy7SJpUkDlSKUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599752; c=relaxed/simple;
	bh=0Kixhs+Wzb2xkgum3kaWfJly4Y7xnsiWnM4rZnsGe50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjV52Fw2VOjm2fxCi4A6PcAAqbnps3E8yVHEhr5HgJYKNYjG1zXfGNlFfm7ULVP8w6YrjaUeEgY4Aoxt4dLpo+AFJyeDvR2WXNFvg3df9UfrtONTZeDISLS0CUYXBH9cOHJ1z/17T+wSQkh0tu7foEBW52EKDgB3/qXene54Ghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JtnJusDV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ms7KYDawzWvNN1tWImlyZ0pX/itnGIeBBJQ2IqDFAKk=;
	b=JtnJusDV7cJRUHJNkZxjxkRaYTMucLv4CXgfl9EwSLOVHIZ1J11MAXUmjeSPPOdHASr7++
	szGEpNvMnJTyFgv7EbGqpAIYl0OPDZFwKlvODpjOk5DCJeuJ+qnBAEfJAZ52ftjLVgsAj7
	ycWZLLUXpvUNn6MysWiiQKijP3yUgNs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-VHgX47lnNCGefziFaqYZ0Q-1; Mon,
 10 Mar 2025 05:42:26 -0400
X-MC-Unique: VHgX47lnNCGefziFaqYZ0Q-1
X-Mimecast-MFC-AGG-ID: VHgX47lnNCGefziFaqYZ0Q_1741599745
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1650119560A1;
	Mon, 10 Mar 2025 09:42:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A1AD3000197;
	Mon, 10 Mar 2025 09:42:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/11] afs: Remove the "autocell" mount option
Date: Mon, 10 Mar 2025 09:41:55 +0000
Message-ID: <20250310094206.801057-3-dhowells@redhat.com>
In-Reply-To: <20250310094206.801057-1-dhowells@redhat.com>
References: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Remove the "autocell" mount option.  It was an attempt to do automounting
of arbitrary cells based on what the user looked up but within the root
directory of a mounted volume.  This isn't really the right thing to do,
and using the "dyn" mount option to get the dynamic root is the right way
to do it.  The kafs-client package uses "-o dyn" when mounting /afs, so it
should be safe to drop "-o autocell".

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-7-dhowells@redhat.com/ # v1
---
 fs/afs/dir.c      | 5 ++---
 fs/afs/dynroot.c  | 5 +----
 fs/afs/internal.h | 2 --
 fs/afs/super.c    | 5 -----
 4 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 02cbf38e1a77..9f62b8938350 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1004,9 +1004,8 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry);
 	if (inode == ERR_PTR(-ENOENT))
-		inode = afs_try_auto_mntpt(dentry, dir);
-
-	if (!IS_ERR_OR_NULL(inode))
+		inode = NULL;
+	else if (!IS_ERR_OR_NULL(inode))
 		fid = AFS_FS_I(inode)->fid;
 
 	_debug("splice %p", dentry->d_inode);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 008698d706ca..0b4cc291c65e 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -155,7 +155,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
  * Try to auto mount the mountpoint with pseudo directory, if the autocell
  * operation is setted.
  */
-struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
+static struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
 {
 	struct afs_vnode *vnode = AFS_FS_I(dir);
 	struct inode *inode;
@@ -164,9 +164,6 @@ struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
 	_enter("%p{%pd}, {%llx:%llu}",
 	       dentry, dentry, vnode->fid.vid, vnode->fid.vnode);
 
-	if (!test_bit(AFS_VNODE_AUTOCELL, &vnode->flags))
-		goto out;
-
 	ret = afs_probe_cell_name(dentry);
 	if (ret < 0)
 		goto out;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index df30bd62da79..0e00e061f0d9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -700,7 +700,6 @@ struct afs_vnode {
 #define AFS_VNODE_ZAP_DATA	3		/* set if vnode's data should be invalidated */
 #define AFS_VNODE_DELETED	4		/* set if vnode deleted on server */
 #define AFS_VNODE_MOUNTPOINT	5		/* set if vnode is a mountpoint symlink */
-#define AFS_VNODE_AUTOCELL	6		/* set if Vnode is an auto mount point */
 #define AFS_VNODE_PSEUDODIR	7 		/* set if Vnode is a pseudo directory */
 #define AFS_VNODE_NEW_CONTENT	8		/* Set if file has new content (create/trunc-0) */
 #define AFS_VNODE_SILLY_DELETED	9		/* Set if file has been silly-deleted */
@@ -1111,7 +1110,6 @@ extern int afs_silly_iput(struct dentry *, struct inode *);
 extern const struct inode_operations afs_dynroot_inode_operations;
 extern const struct dentry_operations afs_dynroot_dentry_operations;
 
-extern struct inode *afs_try_auto_mntpt(struct dentry *, struct inode *);
 extern int afs_dynroot_mkdir(struct afs_net *, struct afs_cell *);
 extern void afs_dynroot_rmdir(struct afs_net *, struct afs_cell *);
 extern int afs_dynroot_populate(struct super_block *);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index a9bee610674e..2f18aa8e2806 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -194,8 +194,6 @@ static int afs_show_options(struct seq_file *m, struct dentry *root)
 
 	if (as->dyn_root)
 		seq_puts(m, ",dyn");
-	if (test_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(d_inode(root))->flags))
-		seq_puts(m, ",autocell");
 	switch (as->flock_mode) {
 	case afs_flock_mode_unset:	break;
 	case afs_flock_mode_local:	p = "local";	break;
@@ -478,9 +476,6 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (ctx->autocell || as->dyn_root)
-		set_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(inode)->flags);
-
 	ret = -ENOMEM;
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)


