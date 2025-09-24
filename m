Return-Path: <linux-fsdevel+bounces-62580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97EBB99ED8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 14:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE6F3A6908
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6C42FD7BA;
	Wed, 24 Sep 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL9aqO9b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9B1CA84
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718200; cv=none; b=bEj56LXjdRzEnuS4fBfuXCZfWXysx9X6LTJQRu+mXxOP4lS7UX+/J38Zi+jscvglMZcO8huxHDvnvmr8MtWNdPKqqRSQ6QNoYMywzapSmW+6DuFevkllkcmRokEHsYT7XtIPShfZXacw0BYDEq/Xf0UwNQC0M8rTv7bgUbJFOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718200; c=relaxed/simple;
	bh=6jvxNr2Nhc8Mcj5rynftTqJLIdbKzVoi0ak4QIxp120=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=FW6Pph6LR+T4IGx9yXAJ65ZNBKWVyFFes4acpvRK4I/+FRXqhRVP/tV7eH76plFsh5Vsikufnoh1lPNMoQm+9bkm/az9z2Z+hK/ujpPb8M5sJ8xCEM85LU0SLEalH6Qcvc5eoiUrGIuSqon330A3AG59kSeb7xqUvmnFO7XM5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YL9aqO9b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758718196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QBj00N1B8Hi0YSnBJaHs56zyJ7UxRF5copsqkblpAe0=;
	b=YL9aqO9bvIljZyl57T97OETcAXXNfDn069HysUVNaL1kyGmptDIRhSaiPEepZzC6U3k2Tu
	f7ZZKB1Z1YqSJR0sEVDKHMIYwSMYHyv5a+eyGbw5xLXpq/g6tpavoJHlh4cA3ESZVdtQ9j
	RXJcOUamVqyW3uuDjCPZHopBdgbhwyQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-AJ0C59kLNxGM44qhbFciZw-1; Wed,
 24 Sep 2025 08:49:55 -0400
X-MC-Unique: AJ0C59kLNxGM44qhbFciZw-1
X-Mimecast-MFC-AGG-ID: AJ0C59kLNxGM44qhbFciZw_1758718194
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 722E018004D8;
	Wed, 24 Sep 2025 12:49:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6A4C1800578;
	Wed, 24 Sep 2025 12:49:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Dan Carpenter <dan.carpenter@linaro.org>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v4] afs: Add support for RENAME_NOREPLACE and RENAME_EXCHANGE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <740475.1758718189.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Sep 2025 13:49:49 +0100
Message-ID: <740476.1758718189@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add support for RENAME_NOREPLACE and RENAME_EXCHANGE, if the server
supports them.

The default is translated to YFS.Rename_Replace, falling back to
YFS.Rename; RENAME_NOREPLACE is translated to YFS.Rename_NoReplace and
RENAME_EXCHANGE to YFS.Rename_Exchange, both of which fall back to
reporting EINVAL.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Dan Carpenter <dan.carpenter@linaro.org>
cc: linux-afs@lists.infradead.org
---
 Changes
 =3D=3D=3D=3D=3D=3D=3D
 ver #4)
  - Fix a couple of uninitialised variables introduced into the rotation
    algorithm.
 =

 ver #3)
  - Make sillyrename provide the info needed for the advanced rename to
    avoid generic/011 oopsing.
 =

 ver #2)
  - Suppress some debugging output.
  - Return EINVAL rather than EOPNOTSUPP if not supported.

 fs/afs/dir.c               |  223 +++++++++++++++++++++++++++++++--------=
-
 fs/afs/dir_edit.c          |   18 +--
 fs/afs/dir_silly.c         |   11 +
 fs/afs/internal.h          |   15 +-
 fs/afs/misc.c              |    1 =

 fs/afs/protocol_yfs.h      |    3 =

 fs/afs/rotate.c            |   17 ++-
 fs/afs/yfsclient.c         |  249 +++++++++++++++++++++++++++++++++++++++=
++++++
 fs/dcache.c                |    1 =

 include/trace/events/afs.h |    6 +
 10 files changed, 480 insertions(+), 64 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index bfb69e066672..89d36e3e5c79 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1823,7 +1823,8 @@ static int afs_symlink(struct mnt_idmap *idmap, stru=
ct inode *dir,
 =

 static void afs_rename_success(struct afs_operation *op)
 {
-	struct afs_vnode *vnode =3D AFS_FS_I(d_inode(op->dentry));
+	struct afs_vnode *vnode =3D op->more_files[0].vnode;
+	struct afs_vnode *new_vnode =3D op->more_files[1].vnode;
 =

 	_enter("op=3D%08x", op->debug_id);
 =

@@ -1834,22 +1835,40 @@ static void afs_rename_success(struct afs_operatio=
n *op)
 		op->ctime =3D op->file[1].scb.status.mtime_client;
 		afs_vnode_commit_status(op, &op->file[1]);
 	}
+	if (op->more_files[0].scb.have_status)
+		afs_vnode_commit_status(op, &op->more_files[0]);
+	if (op->more_files[1].scb.have_status)
+		afs_vnode_commit_status(op, &op->more_files[1]);
 =

 	/* If we're moving a subdir between dirs, we need to update
 	 * its DV counter too as the ".." will be altered.
 	 */
-	if (S_ISDIR(vnode->netfs.inode.i_mode) &&
-	    op->file[0].vnode !=3D op->file[1].vnode) {
-		u64 new_dv;
+	if (op->file[0].vnode !=3D op->file[1].vnode) {
+		if (S_ISDIR(vnode->netfs.inode.i_mode)) {
+			u64 new_dv;
 =

-		write_seqlock(&vnode->cb_lock);
+			write_seqlock(&vnode->cb_lock);
 =

-		new_dv =3D vnode->status.data_version + 1;
-		trace_afs_set_dv(vnode, new_dv);
-		vnode->status.data_version =3D new_dv;
-		inode_set_iversion_raw(&vnode->netfs.inode, new_dv);
+			new_dv =3D vnode->status.data_version + 1;
+			trace_afs_set_dv(vnode, new_dv);
+			vnode->status.data_version =3D new_dv;
+			inode_set_iversion_raw(&vnode->netfs.inode, new_dv);
 =

-		write_sequnlock(&vnode->cb_lock);
+			write_sequnlock(&vnode->cb_lock);
+		}
+
+		if ((op->rename.rename_flags & RENAME_EXCHANGE) &&
+		    S_ISDIR(new_vnode->netfs.inode.i_mode)) {
+			u64 new_dv;
+
+			write_seqlock(&new_vnode->cb_lock);
+
+			new_dv =3D new_vnode->status.data_version + 1;
+			new_vnode->status.data_version =3D new_dv;
+			inode_set_iversion_raw(&new_vnode->netfs.inode, new_dv);
+
+			write_sequnlock(&new_vnode->cb_lock);
+		}
 	}
 }
 =

@@ -1900,8 +1919,8 @@ static void afs_rename_edit_dir(struct afs_operation=
 *op)
 	if (S_ISDIR(vnode->netfs.inode.i_mode) &&
 	    new_dvnode !=3D orig_dvnode &&
 	    test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
-		afs_edit_dir_update_dotdot(vnode, new_dvnode,
-					   afs_edit_dir_for_rename_sub);
+		afs_edit_dir_update(vnode, &dotdot_name, new_dvnode,
+				    afs_edit_dir_for_rename_sub);
 =

 	new_inode =3D d_inode(new_dentry);
 	if (new_inode) {
@@ -1915,9 +1934,6 @@ static void afs_rename_edit_dir(struct afs_operation=
 *op)
 =

 	/* Now we can update d_fsdata on the dentries to reflect their
 	 * new parent's data_version.
-	 *
-	 * Note that if we ever implement RENAME_EXCHANGE, we'll have
-	 * to update both dentries with opposing dir versions.
 	 */
 	afs_update_dentry_version(op, new_dvp, op->dentry);
 	afs_update_dentry_version(op, new_dvp, op->dentry_2);
@@ -1930,6 +1946,67 @@ static void afs_rename_edit_dir(struct afs_operatio=
n *op)
 		fscache_end_operation(&new_cres);
 }
 =

+static void afs_rename_exchange_edit_dir(struct afs_operation *op)
+{
+	struct afs_vnode_param *orig_dvp =3D &op->file[0];
+	struct afs_vnode_param *new_dvp =3D &op->file[1];
+	struct afs_vnode *orig_dvnode =3D orig_dvp->vnode;
+	struct afs_vnode *new_dvnode =3D new_dvp->vnode;
+	struct afs_vnode *old_vnode =3D op->more_files[0].vnode;
+	struct afs_vnode *new_vnode =3D op->more_files[1].vnode;
+	struct dentry *old_dentry =3D op->dentry;
+	struct dentry *new_dentry =3D op->dentry_2;
+
+	_enter("op=3D%08x", op->debug_id);
+
+	if (new_dvnode =3D=3D orig_dvnode) {
+		down_write(&orig_dvnode->validate_lock);
+		if (test_bit(AFS_VNODE_DIR_VALID, &orig_dvnode->flags) &&
+		    orig_dvnode->status.data_version =3D=3D orig_dvp->dv_before + orig_=
dvp->dv_delta) {
+			afs_edit_dir_update(orig_dvnode, &old_dentry->d_name,
+					    new_vnode, afs_edit_dir_for_rename_0);
+			afs_edit_dir_update(orig_dvnode, &new_dentry->d_name,
+					    old_vnode, afs_edit_dir_for_rename_1);
+		}
+
+		d_exchange(old_dentry, new_dentry);
+		up_write(&orig_dvnode->validate_lock);
+	} else {
+		down_write(&orig_dvnode->validate_lock);
+		if (test_bit(AFS_VNODE_DIR_VALID, &orig_dvnode->flags) &&
+		    orig_dvnode->status.data_version =3D=3D orig_dvp->dv_before + orig_=
dvp->dv_delta)
+			afs_edit_dir_update(orig_dvnode, &old_dentry->d_name,
+					    new_vnode, afs_edit_dir_for_rename_0);
+
+		up_write(&orig_dvnode->validate_lock);
+		down_write(&new_dvnode->validate_lock);
+
+		if (test_bit(AFS_VNODE_DIR_VALID, &new_dvnode->flags) &&
+		    new_dvnode->status.data_version =3D=3D new_dvp->dv_before + new_dvp=
->dv_delta)
+			afs_edit_dir_update(new_dvnode, &new_dentry->d_name,
+					    old_vnode, afs_edit_dir_for_rename_1);
+
+		if (S_ISDIR(old_vnode->netfs.inode.i_mode) &&
+		    test_bit(AFS_VNODE_DIR_VALID, &old_vnode->flags))
+			afs_edit_dir_update(old_vnode, &dotdot_name, new_dvnode,
+					    afs_edit_dir_for_rename_sub);
+
+		if (S_ISDIR(new_vnode->netfs.inode.i_mode) &&
+		    test_bit(AFS_VNODE_DIR_VALID, &new_vnode->flags))
+			afs_edit_dir_update(new_vnode, &dotdot_name, orig_dvnode,
+					    afs_edit_dir_for_rename_sub);
+
+		/* Now we can update d_fsdata on the dentries to reflect their
+		 * new parents' data_version.
+		 */
+		afs_update_dentry_version(op, new_dvp, old_dentry);
+		afs_update_dentry_version(op, orig_dvp, new_dentry);
+
+		d_exchange(old_dentry, new_dentry);
+		up_write(&new_dvnode->validate_lock);
+	}
+}
+
 static void afs_rename_put(struct afs_operation *op)
 {
 	_enter("op=3D%08x", op->debug_id);
@@ -1948,6 +2025,32 @@ static const struct afs_operation_ops afs_rename_op=
eration =3D {
 	.put		=3D afs_rename_put,
 };
 =

+#if 0 /* Autoswitched in yfs_fs_rename_replace(). */
+static const struct afs_operation_ops afs_rename_replace_operation =3D {
+	.issue_afs_rpc	=3D NULL,
+	.issue_yfs_rpc	=3D yfs_fs_rename_replace,
+	.success	=3D afs_rename_success,
+	.edit_dir	=3D afs_rename_edit_dir,
+	.put		=3D afs_rename_put,
+};
+#endif
+
+static const struct afs_operation_ops afs_rename_noreplace_operation =3D =
{
+	.issue_afs_rpc	=3D NULL,
+	.issue_yfs_rpc	=3D yfs_fs_rename_noreplace,
+	.success	=3D afs_rename_success,
+	.edit_dir	=3D afs_rename_edit_dir,
+	.put		=3D afs_rename_put,
+};
+
+static const struct afs_operation_ops afs_rename_exchange_operation =3D {
+	.issue_afs_rpc	=3D NULL,
+	.issue_yfs_rpc	=3D yfs_fs_rename_exchange,
+	.success	=3D afs_rename_success,
+	.edit_dir	=3D afs_rename_exchange_edit_dir,
+	.put		=3D afs_rename_put,
+};
+
 /*
  * rename a file in an AFS filesystem and/or move it between directories
  */
@@ -1956,10 +2059,10 @@ static int afs_rename(struct mnt_idmap *idmap, str=
uct inode *old_dir,
 		      struct dentry *new_dentry, unsigned int flags)
 {
 	struct afs_operation *op;
-	struct afs_vnode *orig_dvnode, *new_dvnode, *vnode;
+	struct afs_vnode *orig_dvnode, *new_dvnode, *vnode, *new_vnode =3D NULL;
 	int ret;
 =

-	if (flags)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
 		return -EINVAL;
 =

 	/* Don't allow silly-rename files be moved around. */
@@ -1969,6 +2072,8 @@ static int afs_rename(struct mnt_idmap *idmap, struc=
t inode *old_dir,
 	vnode =3D AFS_FS_I(d_inode(old_dentry));
 	orig_dvnode =3D AFS_FS_I(old_dir);
 	new_dvnode =3D AFS_FS_I(new_dir);
+	if (d_is_positive(new_dentry))
+		new_vnode =3D AFS_FS_I(d_inode(new_dentry));
 =

 	_enter("{%llx:%llu},{%llx:%llu},{%llx:%llu},{%pd}",
 	       orig_dvnode->fid.vid, orig_dvnode->fid.vnode,
@@ -1989,6 +2094,11 @@ static int afs_rename(struct mnt_idmap *idmap, stru=
ct inode *old_dir,
 	if (ret < 0)
 		goto error;
 =

+	ret =3D -ENOMEM;
+	op->more_files =3D kvcalloc(2, sizeof(struct afs_vnode_param), GFP_KERNE=
L);
+	if (!op->more_files)
+		goto error;
+
 	afs_op_set_vnode(op, 0, orig_dvnode);
 	afs_op_set_vnode(op, 1, new_dvnode); /* May be same as orig_dvnode */
 	op->file[0].dv_delta =3D 1;
@@ -1997,46 +2107,63 @@ static int afs_rename(struct mnt_idmap *idmap, str=
uct inode *old_dir,
 	op->file[1].modification =3D true;
 	op->file[0].update_ctime =3D true;
 	op->file[1].update_ctime =3D true;
+	op->more_files[0].vnode		=3D vnode;
+	op->more_files[0].speculative	=3D true;
+	op->more_files[1].vnode		=3D new_vnode;
+	op->more_files[1].speculative	=3D true;
+	op->nr_files =3D 4;
 =

 	op->dentry		=3D old_dentry;
 	op->dentry_2		=3D new_dentry;
+	op->rename.rename_flags	=3D flags;
 	op->rename.new_negative	=3D d_is_negative(new_dentry);
-	op->ops			=3D &afs_rename_operation;
 =

-	/* For non-directories, check whether the target is busy and if so,
-	 * make a copy of the dentry and then do a silly-rename.  If the
-	 * silly-rename succeeds, the copied dentry is hashed and becomes the
-	 * new target.
-	 */
-	if (d_is_positive(new_dentry) && !d_is_dir(new_dentry)) {
-		/* To prevent any new references to the target during the
-		 * rename, we unhash the dentry in advance.
+	if (flags & RENAME_NOREPLACE) {
+		op->ops		=3D &afs_rename_noreplace_operation;
+	} else if (flags & RENAME_EXCHANGE) {
+		op->ops		=3D &afs_rename_exchange_operation;
+		d_drop(new_dentry);
+	} else {
+		/* If we might displace the target, we might need to do silly
+		 * rename.
 		 */
-		if (!d_unhashed(new_dentry)) {
-			d_drop(new_dentry);
-			op->rename.rehash =3D new_dentry;
-		}
+		op->ops	=3D &afs_rename_operation;
 =

-		if (d_count(new_dentry) > 2) {
-			/* copy the target dentry's name */
-			op->rename.tmp =3D d_alloc(new_dentry->d_parent,
-						 &new_dentry->d_name);
-			if (!op->rename.tmp) {
-				afs_op_nomem(op);
-				goto error;
+		/* For non-directories, check whether the target is busy and if
+		 * so, make a copy of the dentry and then do a silly-rename.
+		 * If the silly-rename succeeds, the copied dentry is hashed
+		 * and becomes the new target.
+		 */
+		if (d_is_positive(new_dentry) && !d_is_dir(new_dentry)) {
+			/* To prevent any new references to the target during
+			 * the rename, we unhash the dentry in advance.
+			 */
+			if (!d_unhashed(new_dentry)) {
+				d_drop(new_dentry);
+				op->rename.rehash =3D new_dentry;
 			}
 =

-			ret =3D afs_sillyrename(new_dvnode,
-					      AFS_FS_I(d_inode(new_dentry)),
-					      new_dentry, op->key);
-			if (ret) {
-				afs_op_set_error(op, ret);
-				goto error;
+			if (d_count(new_dentry) > 2) {
+				/* copy the target dentry's name */
+				op->rename.tmp =3D d_alloc(new_dentry->d_parent,
+							 &new_dentry->d_name);
+				if (!op->rename.tmp) {
+					afs_op_nomem(op);
+					goto error;
+				}
+
+				ret =3D afs_sillyrename(new_dvnode,
+						      AFS_FS_I(d_inode(new_dentry)),
+						      new_dentry, op->key);
+				if (ret) {
+					afs_op_set_error(op, ret);
+					goto error;
+				}
+
+				op->dentry_2 =3D op->rename.tmp;
+				op->rename.rehash =3D NULL;
+				op->rename.new_negative =3D true;
 			}
-
-			op->dentry_2 =3D op->rename.tmp;
-			op->rename.rehash =3D NULL;
-			op->rename.new_negative =3D true;
 		}
 	}
 =

@@ -2052,6 +2179,8 @@ static int afs_rename(struct mnt_idmap *idmap, struc=
t inode *old_dir,
 	d_drop(old_dentry);
 =

 	ret =3D afs_do_sync_operation(op);
+	if (ret =3D=3D -ENOTSUPP)
+		ret =3D -EINVAL;
 out:
 	afs_dir_unuse_cookie(orig_dvnode, ret);
 	if (new_dvnode !=3D orig_dvnode)
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 60a549f1d9c5..4b1342c72089 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -522,11 +522,11 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 }
 =

 /*
- * Edit a subdirectory that has been moved between directories to update =
the
- * ".." entry.
+ * Edit an entry in a directory to update the vnode it refers to.  This i=
s also
+ * used to update the ".." entry in a directory.
  */
-void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode=
 *new_dvnode,
-				enum afs_edit_dir_reason why)
+void afs_edit_dir_update(struct afs_vnode *vnode, const struct qstr *name=
,
+			 struct afs_vnode *new_dvnode, enum afs_edit_dir_reason why)
 {
 	union afs_xdr_dir_block *block;
 	union afs_xdr_dirent *de;
@@ -557,7 +557,7 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnod=
e, struct afs_vnode *new_d
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
 			goto already_invalidated;
 =

-		slot =3D afs_dir_scan_block(block, &dotdot_name, b);
+		slot =3D afs_dir_scan_block(block, name, b);
 		if (slot >=3D 0)
 			goto found_dirent;
 =

@@ -566,7 +566,7 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnod=
e, struct afs_vnode *new_d
 =

 	/* Didn't find the dirent to clobber.  Download the directory again. */
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_nodd,
-			   0, 0, 0, 0, "..");
+			   0, 0, 0, 0, name->name);
 	afs_invalidate_dir(vnode, afs_dir_invalid_edit_upd_no_dd);
 	goto out;
 =

@@ -576,7 +576,7 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnod=
e, struct afs_vnode *new_d
 	de->u.unique =3D htonl(new_dvnode->fid.unique);
 =

 	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_dd, b, slot,
-			   ntohl(de->u.vnode), ntohl(de->u.unique), "..");
+			   ntohl(de->u.vnode), ntohl(de->u.unique), name->name);
 =

 	kunmap_local(block);
 	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
@@ -589,12 +589,12 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vn=
ode, struct afs_vnode *new_d
 already_invalidated:
 	kunmap_local(block);
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_inval,
-			   0, 0, 0, 0, "..");
+			   0, 0, 0, 0, name->name);
 	goto out;
 =

 error:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_error,
-			   0, 0, 0, 0, "..");
+			   0, 0, 0, 0, name->name);
 	goto out;
 }
 =

diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index 0b80eb93fa40..014495d4b868 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -69,6 +69,12 @@ static int afs_do_silly_rename(struct afs_vnode *dvnode=
, struct afs_vnode *vnode
 	if (IS_ERR(op))
 		return PTR_ERR(op);
 =

+	op->more_files =3D kvcalloc(2, sizeof(struct afs_vnode_param), GFP_KERNE=
L);
+	if (!op->more_files) {
+		afs_put_operation(op);
+		return -ENOMEM;
+	}
+
 	afs_op_set_vnode(op, 0, dvnode);
 	afs_op_set_vnode(op, 1, dvnode);
 	op->file[0].dv_delta =3D 1;
@@ -77,6 +83,11 @@ static int afs_do_silly_rename(struct afs_vnode *dvnode=
, struct afs_vnode *vnode
 	op->file[1].modification =3D true;
 	op->file[0].update_ctime =3D true;
 	op->file[1].update_ctime =3D true;
+	op->more_files[0].vnode		=3D AFS_FS_I(d_inode(old));
+	op->more_files[0].speculative	=3D true;
+	op->more_files[1].vnode		=3D AFS_FS_I(d_inode(new));
+	op->more_files[1].speculative	=3D true;
+	op->nr_files =3D 4;
 =

 	op->dentry		=3D old;
 	op->dentry_2		=3D new;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1124ea4000cb..444a3ea4fdf6 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -562,6 +562,7 @@ struct afs_server {
 #define AFS_SERVER_FL_NO_IBULK	17		/* Fileserver doesn't support FS.Inlin=
eBulkStatus */
 #define AFS_SERVER_FL_NO_RM2	18		/* Fileserver doesn't support YFS.Remove=
File2 */
 #define AFS_SERVER_FL_HAS_FS64	19		/* Fileserver supports FS.{Fetch,Store=
}Data64 */
+#define AFS_SERVER_FL_NO_RENAME2 20		/* YFS Fileserver doesn't support en=
hanced rename */
 	refcount_t		ref;		/* Object refcount */
 	atomic_t		active;		/* Active user count */
 	u32			addr_version;	/* Address list version */
@@ -891,9 +892,10 @@ struct afs_operation {
 			bool	need_rehash;
 		} unlink;
 		struct {
-			struct dentry *rehash;
-			struct dentry *tmp;
-			bool	new_negative;
+			struct dentry	*rehash;
+			struct dentry	*tmp;
+			unsigned int	rename_flags;
+			bool		new_negative;
 		} rename;
 		struct {
 			struct netfs_io_subrequest *subreq;
@@ -1100,8 +1102,8 @@ int afs_single_writepages(struct address_space *mapp=
ing,
 extern void afs_edit_dir_add(struct afs_vnode *, struct qstr *, struct af=
s_fid *,
 			     enum afs_edit_dir_reason);
 extern void afs_edit_dir_remove(struct afs_vnode *, struct qstr *, enum a=
fs_edit_dir_reason);
-void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode=
 *new_dvnode,
-				enum afs_edit_dir_reason why);
+void afs_edit_dir_update(struct afs_vnode *vnode, const struct qstr *name=
,
+			 struct afs_vnode *new_dvnode, enum afs_edit_dir_reason why);
 void afs_mkdir_init_dir(struct afs_vnode *dvnode, struct afs_vnode *paren=
t_vnode);
 =

 /*
@@ -1693,6 +1695,9 @@ extern void yfs_fs_remove_dir(struct afs_operation *=
);
 extern void yfs_fs_link(struct afs_operation *);
 extern void yfs_fs_symlink(struct afs_operation *);
 extern void yfs_fs_rename(struct afs_operation *);
+void yfs_fs_rename_replace(struct afs_operation *op);
+void yfs_fs_rename_noreplace(struct afs_operation *op);
+void yfs_fs_rename_exchange(struct afs_operation *op);
 extern void yfs_fs_store_data(struct afs_operation *);
 extern void yfs_fs_setattr(struct afs_operation *);
 extern void yfs_fs_get_volume_status(struct afs_operation *);
diff --git a/fs/afs/misc.c b/fs/afs/misc.c
index 8f2b3a177690..c8a7f266080d 100644
--- a/fs/afs/misc.c
+++ b/fs/afs/misc.c
@@ -131,6 +131,7 @@ int afs_abort_to_error(u32 abort_code)
 	case KRB5_PROG_KEYTYPE_NOSUPP:	return -ENOPKG;
 =

 	case RXGEN_OPCODE:	return -ENOTSUPP;
+	case RX_INVALID_OPERATION:	return -ENOTSUPP;
 =

 	default:		return -EREMOTEIO;
 	}
diff --git a/fs/afs/protocol_yfs.h b/fs/afs/protocol_yfs.h
index e4cd89c44c46..b2f06c1917c2 100644
--- a/fs/afs/protocol_yfs.h
+++ b/fs/afs/protocol_yfs.h
@@ -50,6 +50,9 @@ enum YFS_FS_Operations {
 	YFSREMOVEACL		=3D 64171,
 	YFSREMOVEFILE2		=3D 64173,
 	YFSSTOREOPAQUEACL2	=3D 64174,
+	YFSRENAME_REPLACE	=3D 64176,
+	YFSRENAME_NOREPLACE	=3D 64177,
+	YFSRENAME_EXCHANGE	=3D 64187,
 	YFSINLINEBULKSTATUS	=3D 64536, /* YFS Fetch multiple file statuses with =
errors */
 	YFSFETCHDATA64		=3D 64537, /* YFS Fetch file data */
 	YFSSTOREDATA64		=3D 64538, /* YFS Store file data */
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index a1c24f589d9e..6a4e7da10fc4 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -432,6 +432,16 @@ bool afs_select_fileserver(struct afs_operation *op)
 			afs_op_set_error(op, -EDQUOT);
 			goto failed_but_online;
 =

+		case RX_INVALID_OPERATION:
+		case RXGEN_OPCODE:
+			/* Handle downgrading to an older operation. */
+			afs_op_set_error(op, -ENOTSUPP);
+			if (op->flags & AFS_OPERATION_DOWNGRADE) {
+				op->flags &=3D ~AFS_OPERATION_DOWNGRADE;
+				goto go_again;
+			}
+			goto failed_but_online;
+
 		default:
 			afs_op_accumulate_error(op, error, abort_code);
 		failed_but_online:
@@ -620,12 +630,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 	op->addr_index =3D addr_index;
 	set_bit(addr_index, &op->addr_tried);
 =

-	op->volsync.creation =3D TIME64_MIN;
-	op->volsync.update =3D TIME64_MIN;
-	op->call_responded =3D false;
 	_debug("address [%u] %u/%u %pISp",
 	       op->server_index, addr_index, alist->nr_addrs,
 	       rxrpc_kernel_remote_addr(alist->addrs[op->addr_index].peer));
+go_again:
+	op->volsync.creation =3D TIME64_MIN;
+	op->volsync.update =3D TIME64_MIN;
+	op->call_responded =3D false;
 	_leave(" =3D t");
 	return true;
 =

diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 257af259c04a..febf13a49f0b 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -1042,6 +1042,9 @@ void yfs_fs_rename(struct afs_operation *op)
 =

 	_enter("");
 =

+	if (!test_bit(AFS_SERVER_FL_NO_RENAME2, &op->server->flags))
+		return yfs_fs_rename_replace(op);
+
 	call =3D afs_alloc_flat_call(op->net, &yfs_RXYFSRename,
 				   sizeof(__be32) +
 				   sizeof(struct yfs_xdr_RPCFlags) +
@@ -1070,6 +1073,252 @@ void yfs_fs_rename(struct afs_operation *op)
 	afs_make_op_call(op, call, GFP_NOFS);
 }
 =

+/*
+ * Deliver reply data to a YFS.Rename_NoReplace operation.  This does not
+ * return the status of a displaced target inode as there cannot be one.
+ */
+static int yfs_deliver_fs_rename_1(struct afs_call *call)
+{
+	struct afs_operation *op =3D call->op;
+	struct afs_vnode_param *orig_dvp =3D &op->file[0];
+	struct afs_vnode_param *new_dvp =3D &op->file[1];
+	struct afs_vnode_param *old_vp =3D &op->more_files[0];
+	const __be32 *bp;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	ret =3D afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	bp =3D call->buffer;
+	/* If the two dirs are the same, we have two copies of the same status
+	 * report, so we just decode it twice.
+	 */
+	xdr_decode_YFSFetchStatus(&bp, call, &orig_dvp->scb);
+	xdr_decode_YFSFid(&bp, &old_vp->fid);
+	xdr_decode_YFSFetchStatus(&bp, call, &old_vp->scb);
+	xdr_decode_YFSFetchStatus(&bp, call, &new_dvp->scb);
+	xdr_decode_YFSVolSync(&bp, &op->volsync);
+	_leave(" =3D 0 [done]");
+	return 0;
+}
+
+/*
+ * Deliver reply data to a YFS.Rename_Replace or a YFS.Rename_Exchange
+ * operation.  These return the status of the displaced target inode if t=
here
+ * was one.
+ */
+static int yfs_deliver_fs_rename_2(struct afs_call *call)
+{
+	struct afs_operation *op =3D call->op;
+	struct afs_vnode_param *orig_dvp =3D &op->file[0];
+	struct afs_vnode_param *new_dvp =3D &op->file[1];
+	struct afs_vnode_param *old_vp =3D &op->more_files[0];
+	struct afs_vnode_param *new_vp =3D &op->more_files[1];
+	const __be32 *bp;
+	int ret;
+
+	_enter("{%u}", call->unmarshall);
+
+	ret =3D afs_transfer_reply(call);
+	if (ret < 0)
+		return ret;
+
+	bp =3D call->buffer;
+	/* If the two dirs are the same, we have two copies of the same status
+	 * report, so we just decode it twice.
+	 */
+	xdr_decode_YFSFetchStatus(&bp, call, &orig_dvp->scb);
+	xdr_decode_YFSFid(&bp, &old_vp->fid);
+	xdr_decode_YFSFetchStatus(&bp, call, &old_vp->scb);
+	xdr_decode_YFSFetchStatus(&bp, call, &new_dvp->scb);
+	xdr_decode_YFSFid(&bp, &new_vp->fid);
+	xdr_decode_YFSFetchStatus(&bp, call, &new_vp->scb);
+	xdr_decode_YFSVolSync(&bp, &op->volsync);
+	_leave(" =3D 0 [done]");
+	return 0;
+}
+
+static void yfs_done_fs_rename_replace(struct afs_call *call)
+{
+	if (call->error =3D=3D -ECONNABORTED &&
+	    (call->abort_code =3D=3D RX_INVALID_OPERATION ||
+	     call->abort_code =3D=3D RXGEN_OPCODE)) {
+		set_bit(AFS_SERVER_FL_NO_RENAME2, &call->op->server->flags);
+		call->op->flags |=3D AFS_OPERATION_DOWNGRADE;
+	}
+}
+
+/*
+ * YFS.Rename_Replace operation type
+ */
+static const struct afs_call_type yfs_RXYFSRename_Replace =3D {
+	.name		=3D "FS.Rename_Replace",
+	.op		=3D yfs_FS_Rename_Replace,
+	.deliver	=3D yfs_deliver_fs_rename_2,
+	.done		=3D yfs_done_fs_rename_replace,
+	.destructor	=3D afs_flat_call_destructor,
+};
+
+/*
+ * YFS.Rename_NoReplace operation type
+ */
+static const struct afs_call_type yfs_RXYFSRename_NoReplace =3D {
+	.name		=3D "FS.Rename_NoReplace",
+	.op		=3D yfs_FS_Rename_NoReplace,
+	.deliver	=3D yfs_deliver_fs_rename_1,
+	.destructor	=3D afs_flat_call_destructor,
+};
+
+/*
+ * YFS.Rename_Exchange operation type
+ */
+static const struct afs_call_type yfs_RXYFSRename_Exchange =3D {
+	.name		=3D "FS.Rename_Exchange",
+	.op		=3D yfs_FS_Rename_Exchange,
+	.deliver	=3D yfs_deliver_fs_rename_2,
+	.destructor	=3D afs_flat_call_destructor,
+};
+
+/*
+ * Rename a file or directory, replacing the target if it exists.  The st=
atus
+ * of a displaced target is returned.
+ */
+void yfs_fs_rename_replace(struct afs_operation *op)
+{
+	struct afs_vnode_param *orig_dvp =3D &op->file[0];
+	struct afs_vnode_param *new_dvp =3D &op->file[1];
+	const struct qstr *orig_name =3D &op->dentry->d_name;
+	const struct qstr *new_name =3D &op->dentry_2->d_name;
+	struct afs_call *call;
+	__be32 *bp;
+
+	_enter("");
+
+	call =3D afs_alloc_flat_call(op->net, &yfs_RXYFSRename_Replace,
+				   sizeof(__be32) +
+				   sizeof(struct yfs_xdr_RPCFlags) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(orig_name->len) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(new_name->len),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return afs_op_nomem(op);
+
+	/* Marshall the parameters. */
+	bp =3D call->request;
+	bp =3D xdr_encode_u32(bp, YFSRENAME_REPLACE);
+	bp =3D xdr_encode_u32(bp, 0); /* RPC flags */
+	bp =3D xdr_encode_YFSFid(bp, &orig_dvp->fid);
+	bp =3D xdr_encode_name(bp, orig_name);
+	bp =3D xdr_encode_YFSFid(bp, &new_dvp->fid);
+	bp =3D xdr_encode_name(bp, new_name);
+	yfs_check_req(call, bp);
+
+	call->fid =3D orig_dvp->fid;
+	trace_afs_make_fs_call2(call, &orig_dvp->fid, orig_name, new_name);
+	afs_make_op_call(op, call, GFP_NOFS);
+}
+
+/*
+ * Rename a file or directory, failing if the target dirent exists.
+ */
+void yfs_fs_rename_noreplace(struct afs_operation *op)
+{
+	struct afs_vnode_param *orig_dvp =3D &op->file[0];
+	struct afs_vnode_param *new_dvp =3D &op->file[1];
+	const struct qstr *orig_name =3D &op->dentry->d_name;
+	const struct qstr *new_name =3D &op->dentry_2->d_name;
+	struct afs_call *call;
+	__be32 *bp;
+
+	_enter("");
+
+	call =3D afs_alloc_flat_call(op->net, &yfs_RXYFSRename_NoReplace,
+				   sizeof(__be32) +
+				   sizeof(struct yfs_xdr_RPCFlags) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(orig_name->len) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(new_name->len),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return afs_op_nomem(op);
+
+	/* Marshall the parameters. */
+	bp =3D call->request;
+	bp =3D xdr_encode_u32(bp, YFSRENAME_NOREPLACE);
+	bp =3D xdr_encode_u32(bp, 0); /* RPC flags */
+	bp =3D xdr_encode_YFSFid(bp, &orig_dvp->fid);
+	bp =3D xdr_encode_name(bp, orig_name);
+	bp =3D xdr_encode_YFSFid(bp, &new_dvp->fid);
+	bp =3D xdr_encode_name(bp, new_name);
+	yfs_check_req(call, bp);
+
+	call->fid =3D orig_dvp->fid;
+	trace_afs_make_fs_call2(call, &orig_dvp->fid, orig_name, new_name);
+	afs_make_op_call(op, call, GFP_NOFS);
+}
+
+/*
+ * Exchange a pair of files directories.
+ */
+void yfs_fs_rename_exchange(struct afs_operation *op)
+{
+	struct afs_vnode_param *orig_dvp =3D &op->file[0];
+	struct afs_vnode_param *new_dvp =3D &op->file[1];
+	const struct qstr *orig_name =3D &op->dentry->d_name;
+	const struct qstr *new_name =3D &op->dentry_2->d_name;
+	struct afs_call *call;
+	__be32 *bp;
+
+	_enter("");
+
+	call =3D afs_alloc_flat_call(op->net, &yfs_RXYFSRename_Exchange,
+				   sizeof(__be32) +
+				   sizeof(struct yfs_xdr_RPCFlags) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(orig_name->len) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   xdr_strlen(new_name->len),
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSFid) +
+				   sizeof(struct yfs_xdr_YFSFetchStatus) +
+				   sizeof(struct yfs_xdr_YFSVolSync));
+	if (!call)
+		return afs_op_nomem(op);
+
+	/* Marshall the parameters. */
+	bp =3D call->request;
+	bp =3D xdr_encode_u32(bp, YFSRENAME_EXCHANGE);
+	bp =3D xdr_encode_u32(bp, 0); /* RPC flags */
+	bp =3D xdr_encode_YFSFid(bp, &orig_dvp->fid);
+	bp =3D xdr_encode_name(bp, orig_name);
+	bp =3D xdr_encode_YFSFid(bp, &new_dvp->fid);
+	bp =3D xdr_encode_name(bp, new_name);
+	yfs_check_req(call, bp);
+
+	call->fid =3D orig_dvp->fid;
+	trace_afs_make_fs_call2(call, &orig_dvp->fid, orig_name, new_name);
+	afs_make_op_call(op, call, GFP_NOFS);
+}
+
 /*
  * YFS.StoreData64 operation type.
  */
diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..9e2bd890b728 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2922,6 +2922,7 @@ void d_exchange(struct dentry *dentry1, struct dentr=
y *dentry2)
 =

 	write_sequnlock(&rename_lock);
 }
+EXPORT_SYMBOL(d_exchange);
 =

 /**
  * d_ancestor - search for an ancestor
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 7f83d242c8e9..1b3c48b5591d 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -69,6 +69,9 @@ enum afs_fs_operation {
 	yfs_FS_RemoveACL		=3D 64171,
 	yfs_FS_RemoveFile2		=3D 64173,
 	yfs_FS_StoreOpaqueACL2		=3D 64174,
+	yfs_FS_Rename_Replace		=3D 64176,
+	yfs_FS_Rename_NoReplace		=3D 64177,
+	yfs_FS_Rename_Exchange		=3D 64187,
 	yfs_FS_InlineBulkStatus		=3D 64536, /* YFS Fetch multiple file statuses =
with errors */
 	yfs_FS_FetchData64		=3D 64537, /* YFS Fetch file data */
 	yfs_FS_StoreData64		=3D 64538, /* YFS Store file data */
@@ -300,6 +303,9 @@ enum yfs_cm_operation {
 	EM(yfs_FS_RemoveACL,			"YFS.RemoveACL") \
 	EM(yfs_FS_RemoveFile2,			"YFS.RemoveFile2") \
 	EM(yfs_FS_StoreOpaqueACL2,		"YFS.StoreOpaqueACL2") \
+	EM(yfs_FS_Rename_Replace,		"YFS.Rename_Replace") \
+	EM(yfs_FS_Rename_NoReplace,		"YFS.Rename_NoReplace") \
+	EM(yfs_FS_Rename_Exchange,		"YFS.Rename_Exchange") \
 	EM(yfs_FS_InlineBulkStatus,		"YFS.InlineBulkStatus") \
 	EM(yfs_FS_FetchData64,			"YFS.FetchData64") \
 	EM(yfs_FS_StoreData64,			"YFS.StoreData64") \


