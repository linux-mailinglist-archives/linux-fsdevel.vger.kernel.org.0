Return-Path: <linux-fsdevel+bounces-2557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDD27E6DA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C3CB20EBE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D2210F1;
	Thu,  9 Nov 2023 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDAVT1oV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894312230C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0926135BB
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2zA9f9ia2SQ7Ox+GrjuXX78/9x+ajhYh+AqbaMvgmA=;
	b=dDAVT1oVn9NnEMUp5IrHJEm2przSyEzcr26qsjchYiXomoGu73pbEXHXN+4VVRZlfTK+d4
	1IwzPRJ0TyRrOd6PK8tmaVIvvxO3BeSjMbvPpR4xwDASTBktjo4vW+ngrdERhsA6NxZwfc
	w40nqQZwY6zFHwfw81/15Qnkenw7d2Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-iC_HvyHoPy2J9XFdBh28hw-1; Thu,
 09 Nov 2023 10:40:43 -0500
X-MC-Unique: iC_HvyHoPy2J9XFdBh28hw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25A1E2801448;
	Thu,  9 Nov 2023 15:40:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C58D40C6EBC;
	Thu,  9 Nov 2023 15:40:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/41] afs: Wrap most op->error accesses with inline funcs
Date: Thu,  9 Nov 2023 15:39:39 +0000
Message-ID: <20231109154004.3317227-17-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Wrap most op->error accesses with inline funcs which will make it easier
for a subsequent patch to replace op->error with something else.  Two
functions are added to this end:

 (1) afs_op_error() - Get the error code.

 (2) afs_op_set_error() - Set the error code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c          | 38 +++++++++++++++---------------
 fs/afs/file.c         |  4 ++--
 fs/afs/fs_operation.c | 21 ++++++++++-------
 fs/afs/fsclient.c     |  2 +-
 fs/afs/inode.c        |  2 +-
 fs/afs/internal.h     | 20 ++++++++++++----
 fs/afs/rotate.c       | 55 ++++++++++++++++++++++++-------------------
 fs/afs/server.c       |  6 ++---
 fs/afs/write.c        |  6 ++---
 9 files changed, 87 insertions(+), 67 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 5219182e52e1..b40f7ae850a8 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -878,14 +878,14 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	 * lookups contained therein are stored in the reply without aborting
 	 * the whole operation.
 	 */
-	op->error = -ENOTSUPP;
+	afs_op_set_error(op, -ENOTSUPP);
 	if (!cookie->one_only) {
 		op->ops = &afs_inline_bulk_status_operation;
 		afs_begin_vnode_operation(op);
 		afs_wait_for_operation(op);
 	}
 
-	if (op->error == -ENOTSUPP) {
+	if (afs_op_error(op) == -ENOTSUPP) {
 		/* We could try FS.BulkStatus next, but this aborts the entire
 		 * op if any of the lookups fails - so, for the moment, revert
 		 * to FS.FetchStatus for op->file[1].
@@ -895,10 +895,10 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 		afs_begin_vnode_operation(op);
 		afs_wait_for_operation(op);
 	}
-	inode = ERR_PTR(op->error);
+	inode = ERR_PTR(afs_op_error(op));
 
 out_op:
-	if (op->error == 0) {
+	if (!afs_op_error(op)) {
 		inode = &op->file[1].vnode->netfs.inode;
 		op->file[1].vnode = NULL;
 	}
@@ -1273,7 +1273,7 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 
 	_enter("");
 
-	ASSERTCMP(op->error, ==, 0);
+	ASSERTCMP(afs_op_error(op), ==, 0);
 
 	inode = afs_iget(op, vp);
 	if (IS_ERR(inode)) {
@@ -1286,7 +1286,7 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 
 	vnode = AFS_FS_I(inode);
 	set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
-	if (!op->error)
+	if (!afs_op_error(op))
 		afs_cache_permit(vnode, op->key, vnode->cb_break, &vp->scb);
 	d_instantiate(op->dentry, inode);
 }
@@ -1320,7 +1320,7 @@ static void afs_create_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
 
-	if (op->error)
+	if (afs_op_error(op))
 		d_drop(op->dentry);
 }
 
@@ -1480,7 +1480,7 @@ static void afs_dir_remove_link(struct afs_operation *op)
 	struct dentry *dentry = op->dentry;
 	int ret;
 
-	if (op->error != 0 ||
+	if (afs_op_error(op) ||
 	    (op->file[1].scb.have_status && op->file[1].scb.have_error))
 		return;
 	if (d_really_is_positive(dentry))
@@ -1504,10 +1504,10 @@ static void afs_dir_remove_link(struct afs_operation *op)
 
 		ret = afs_validate(vnode, op->key);
 		if (ret != -ESTALE)
-			op->error = ret;
+			afs_op_set_error(op, ret);
 	}
 
-	_debug("nlink %d [val %d]", vnode->netfs.inode.i_nlink, op->error);
+	_debug("nlink %d [val %d]", vnode->netfs.inode.i_nlink, afs_op_error(op));
 }
 
 static void afs_unlink_success(struct afs_operation *op)
@@ -1538,7 +1538,7 @@ static void afs_unlink_edit_dir(struct afs_operation *op)
 static void afs_unlink_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->unlink.need_rehash && op->error < 0 && op->error != -ENOENT)
+	if (op->unlink.need_rehash && afs_op_error(op) < 0 && afs_op_error(op) != -ENOENT)
 		d_rehash(op->dentry);
 }
 
@@ -1579,7 +1579,7 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 	/* Try to make sure we have a callback promise on the victim. */
 	ret = afs_validate(vnode, op->key);
 	if (ret < 0) {
-		op->error = ret;
+		afs_op_set_error(op, ret);
 		goto error;
 	}
 
@@ -1588,7 +1588,7 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 		spin_unlock(&dentry->d_lock);
 		/* Start asynchronous writeout of the inode */
 		write_inode_now(d_inode(dentry), 0);
-		op->error = afs_sillyrename(dvnode, vnode, dentry, op->key);
+		afs_op_set_error(op, afs_sillyrename(dvnode, vnode, dentry, op->key));
 		goto error;
 	}
 	if (!d_unhashed(dentry)) {
@@ -1609,7 +1609,7 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 	/* If there was a conflict with a third party, check the status of the
 	 * unlinked vnode.
 	 */
-	if (op->error == 0 && (op->flags & AFS_OPERATION_DIR_CONFLICT)) {
+	if (afs_op_error(op) == 0 && (op->flags & AFS_OPERATION_DIR_CONFLICT)) {
 		op->file[1].update_ctime = false;
 		op->fetch_status.which = 1;
 		op->ops = &afs_fetch_status_operation;
@@ -1691,7 +1691,7 @@ static void afs_link_success(struct afs_operation *op)
 static void afs_link_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->error)
+	if (afs_op_error(op))
 		d_drop(op->dentry);
 }
 
@@ -1889,7 +1889,7 @@ static void afs_rename_put(struct afs_operation *op)
 	if (op->rename.rehash)
 		d_rehash(op->rename.rehash);
 	dput(op->rename.tmp);
-	if (op->error)
+	if (afs_op_error(op))
 		d_rehash(op->dentry);
 }
 
@@ -1934,7 +1934,7 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		return PTR_ERR(op);
 
 	ret = afs_validate(vnode, op->key);
-	op->error = ret;
+	afs_op_set_error(op, ret);
 	if (ret < 0)
 		goto error;
 
@@ -1971,7 +1971,7 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			op->rename.tmp = d_alloc(new_dentry->d_parent,
 						 &new_dentry->d_name);
 			if (!op->rename.tmp) {
-				op->error = -ENOMEM;
+				afs_op_nomem(op);
 				goto error;
 			}
 
@@ -1979,7 +1979,7 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 					      AFS_FS_I(d_inode(new_dentry)),
 					      new_dentry, op->key);
 			if (ret) {
-				op->error = ret;
+				afs_op_set_error(op, ret);
 				goto error;
 			}
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index d37dd201752b..0c81c39c32f5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -243,7 +243,7 @@ static void afs_fetch_data_notify(struct afs_operation *op)
 {
 	struct afs_read *req = op->fetch.req;
 	struct netfs_io_subrequest *subreq = req->subreq;
-	int error = op->error;
+	int error = afs_op_error(op);
 
 	if (error == -ECONNABORTED)
 		error = afs_abort_to_error(op->ac.abort_code);
@@ -271,7 +271,7 @@ static void afs_fetch_data_success(struct afs_operation *op)
 
 static void afs_fetch_data_put(struct afs_operation *op)
 {
-	op->fetch.req->error = op->error;
+	op->fetch.req->error = afs_op_error(op);
 	afs_put_read(op->fetch.req);
 }
 
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 3e31fae9a149..bfb9a7634bd9 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -40,8 +40,8 @@ struct afs_operation *afs_alloc_operation(struct key *key, struct afs_volume *vo
 	op->net		= volume->cell->net;
 	op->cb_v_break	= volume->cb_v_break;
 	op->debug_id	= atomic_inc_return(&afs_operation_debug_counter);
-	op->error	= -EDESTADDRREQ;
 	op->nr_iterations = -1;
+	afs_op_set_error(op, -EDESTADDRREQ);
 
 	_leave(" = [op=%08x]", op->debug_id);
 	return op;
@@ -71,7 +71,7 @@ static bool afs_get_io_locks(struct afs_operation *op)
 		swap(vnode, vnode2);
 
 	if (mutex_lock_interruptible(&vnode->io_lock) < 0) {
-		op->error = -ERESTARTSYS;
+		afs_op_set_error(op, -ERESTARTSYS);
 		op->flags |= AFS_OPERATION_STOP;
 		_leave(" = f [I 0]");
 		return false;
@@ -80,7 +80,7 @@ static bool afs_get_io_locks(struct afs_operation *op)
 
 	if (vnode2) {
 		if (mutex_lock_interruptible_nested(&vnode2->io_lock, 1) < 0) {
-			op->error = -ERESTARTSYS;
+			afs_op_set_error(op, -ERESTARTSYS);
 			op->flags |= AFS_OPERATION_STOP;
 			mutex_unlock(&vnode->io_lock);
 			op->flags &= ~AFS_OPERATION_LOCK_0;
@@ -159,11 +159,14 @@ static void afs_end_vnode_operation(struct afs_operation *op)
 {
 	_enter("");
 
-	if (op->error == -EDESTADDRREQ ||
-	    op->error == -EADDRNOTAVAIL ||
-	    op->error == -ENETUNREACH ||
-	    op->error == -EHOSTUNREACH)
+	switch (afs_op_error(op)) {
+	case -EDESTADDRREQ:
+	case -EADDRNOTAVAIL:
+	case -ENETUNREACH:
+	case -EHOSTUNREACH:
 		afs_dump_edestaddrreq(op);
+		break;
+	}
 
 	afs_drop_io_locks(op);
 
@@ -209,7 +212,7 @@ void afs_wait_for_operation(struct afs_operation *op)
 
 	afs_end_vnode_operation(op);
 
-	if (op->error == 0 && op->ops->edit_dir) {
+	if (!afs_op_error(op) && op->ops->edit_dir) {
 		_debug("edit_dir");
 		op->ops->edit_dir(op);
 	}
@@ -221,7 +224,7 @@ void afs_wait_for_operation(struct afs_operation *op)
  */
 int afs_put_operation(struct afs_operation *op)
 {
-	int i, ret = op->error;
+	int i, ret = afs_op_error(op);
 
 	_enter("op=%08x,%d", op->debug_id, ret);
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 7d37f63ef0f0..6821ce0f9d63 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1899,7 +1899,7 @@ void afs_fs_inline_bulk_status(struct afs_operation *op)
 	int i;
 
 	if (test_bit(AFS_SERVER_FL_NO_IBULK, &op->server->flags)) {
-		op->error = -ENOTSUPP;
+		afs_op_set_error(op, -ENOTSUPP);
 		return;
 	}
 
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 1c794a1896aa..b3d76faa83c0 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -331,7 +331,7 @@ static void afs_fetch_status_success(struct afs_operation *op)
 
 	if (vnode->netfs.inode.i_state & I_NEW) {
 		ret = afs_inode_init_from_status(op, vp, vnode);
-		op->error = ret;
+		afs_op_set_error(op, ret);
 		if (ret == 0)
 			afs_cache_permit(vnode, op->key, vp->cb_break_before, &vp->scb);
 	} else {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 3739110fc0b5..08026dfd4421 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1139,11 +1139,6 @@ extern bool afs_begin_vnode_operation(struct afs_operation *);
 extern void afs_wait_for_operation(struct afs_operation *);
 extern int afs_do_sync_operation(struct afs_operation *);
 
-static inline void afs_op_nomem(struct afs_operation *op)
-{
-	op->error = -ENOMEM;
-}
-
 static inline void afs_op_set_vnode(struct afs_operation *op, unsigned int n,
 				    struct afs_vnode *vnode)
 {
@@ -1237,6 +1232,21 @@ static inline void __afs_stat(atomic_t *s)
 extern int afs_abort_to_error(u32);
 extern void afs_prioritise_error(struct afs_error *, int, u32);
 
+static inline void afs_op_nomem(struct afs_operation *op)
+{
+	op->error = -ENOMEM;
+}
+
+static inline int afs_op_error(const struct afs_operation *op)
+{
+	return op->error;
+}
+
+static inline int afs_op_set_error(struct afs_operation *op, int error)
+{
+	return op->error = error;
+}
+
 /*
  * mntpt.c
  */
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index beb9fd4e8f44..282f9417f17d 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -51,7 +51,7 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 		 * and have to return an error.
 		 */
 		if (op->flags & AFS_OPERATION_CUR_ONLY) {
-			op->error = -ESTALE;
+			afs_op_set_error(op, -ESTALE);
 			return false;
 		}
 
@@ -93,7 +93,7 @@ static bool afs_sleep_and_retry(struct afs_operation *op)
 	if (!(op->flags & AFS_OPERATION_UNINTR)) {
 		msleep_interruptible(1000);
 		if (signal_pending(current)) {
-			op->error = -ERESTARTSYS;
+			afs_op_set_error(op, -ERESTARTSYS);
 			return false;
 		}
 	} else {
@@ -137,7 +137,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	case 0:
 	default:
 		/* Success or local failure.  Stop. */
-		op->error = error;
+		afs_op_set_error(op, error);
 		op->flags |= AFS_OPERATION_STOP;
 		_leave(" = f [okay/local %d]", error);
 		return false;
@@ -174,11 +174,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 			set_bit(AFS_VOLUME_NEEDS_UPDATE, &op->volume->flags);
 			error = afs_check_volume_status(op->volume, op);
-			if (error < 0)
-				goto failed_set_error;
+			if (error < 0) {
+				afs_op_set_error(op, error);
+				goto failed;
+			}
 
 			if (test_bit(AFS_VOLUME_DELETED, &op->volume->flags)) {
-				op->error = -ENOMEDIUM;
+				afs_op_set_error(op, -ENOMEDIUM);
 				goto failed;
 			}
 
@@ -250,11 +252,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 				clear_bit(AFS_VOLUME_BUSY, &op->volume->flags);
 			}
 			if (op->flags & AFS_OPERATION_NO_VSLEEP) {
-				op->error = -EADV;
+				afs_op_set_error(op, -EADV);
 				goto failed;
 			}
 			if (op->flags & AFS_OPERATION_CUR_ONLY) {
-				op->error = -ESTALE;
+				afs_op_set_error(op, -ESTALE);
 				goto failed;
 			}
 			goto busy;
@@ -274,7 +276,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 			 * lock we need to maintain.
 			 */
 			if (op->flags & AFS_OPERATION_NO_VSLEEP) {
-				op->error = -EBUSY;
+				afs_op_set_error(op, -EBUSY);
 				goto failed;
 			}
 			if (!test_and_set_bit(AFS_VOLUME_BUSY, &op->volume->flags)) {
@@ -303,7 +305,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 			 * honour, just in case someone sets up a loop.
 			 */
 			if (op->flags & AFS_OPERATION_VMOVED) {
-				op->error = -EREMOTEIO;
+				afs_op_set_error(op, -EREMOTEIO);
 				goto failed;
 			}
 			op->flags |= AFS_OPERATION_VMOVED;
@@ -311,8 +313,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 			set_bit(AFS_VOLUME_WAIT, &op->volume->flags);
 			set_bit(AFS_VOLUME_NEEDS_UPDATE, &op->volume->flags);
 			error = afs_check_volume_status(op->volume, op);
-			if (error < 0)
-				goto failed_set_error;
+			if (error < 0) {
+				afs_op_set_error(op, error);
+				goto failed;
+			}
 
 			/* If the server list didn't change, then the VLDB is
 			 * out of sync with the fileservers.  This is hopefully
@@ -342,7 +346,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 			 * Translate locally and return ENOSPC.
 			 * No replicas to failover to.
 			 */
-			op->error = -ENOSPC;
+			afs_op_set_error(op, -ENOSPC);
 			goto failed_but_online;
 
 		case VOVERQUOTA:
@@ -351,7 +355,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 			 * Translate locally and return EDQUOT.
 			 * No replicas to failover to.
 			 */
-			op->error = -EDQUOT;
+			afs_op_set_error(op, -EDQUOT);
 			goto failed_but_online;
 
 		default:
@@ -364,7 +368,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 	case -ETIMEDOUT:
 	case -ETIME:
-		if (op->error != -EDESTADDRREQ)
+		if (afs_op_error(op) != -EDESTADDRREQ)
 			goto iterate_address;
 		fallthrough;
 	case -ERFKILL:
@@ -383,7 +387,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		fallthrough;
 	case -ECONNRESET:
 		_debug("call reset");
-		op->error = error;
+		afs_op_set_error(op, error);
 		goto failed;
 	}
 
@@ -399,8 +403,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 	 * volume may have moved or even have been deleted.
 	 */
 	error = afs_check_volume_status(op->volume, op);
-	if (error < 0)
-		goto failed_set_error;
+	if (error < 0) {
+		afs_op_set_error(op, error);
+		goto failed;
+	}
 
 	if (!afs_start_fs_iteration(op, vnode))
 		goto failed;
@@ -411,8 +417,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 	_debug("pick [%lx]", op->untried);
 
 	error = afs_wait_for_fs_probes(op->server_list, op->untried);
-	if (error < 0)
-		goto failed_set_error;
+	if (error < 0) {
+		afs_op_set_error(op, error);
+		goto failed;
+	}
 
 	/* Pick the untried server with the lowest RTT.  If we have outstanding
 	 * callbacks, we stick with the server we're already using if we can.
@@ -513,7 +521,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 			op->flags &= ~AFS_OPERATION_RETRY_SERVER;
 			goto retry_server;
 		case -ERESTARTSYS:
-			goto failed_set_error;
+			afs_op_set_error(op, error);
+			goto failed;
 		case -ETIME:
 		case -EDESTADDRREQ:
 			goto next_server;
@@ -542,13 +551,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 	}
 
 	error = e.error;
-
-failed_set_error:
 	op->error = error;
 failed:
 	op->flags |= AFS_OPERATION_STOP;
 	afs_end_cursor(&op->ac);
-	_leave(" = f [failed %d]", op->error);
+	_leave(" = f [failed %d]", afs_op_error(op));
 	return false;
 }
 
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 831254d8ef9c..a72192566dda 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -628,8 +628,8 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
 			_leave(" = t [intr]");
 			return true;
 		}
-		op->error = PTR_ERR(alist);
-		_leave(" = f [%d]", op->error);
+		afs_op_set_error(op, PTR_ERR(alist));
+		_leave(" = f [%d]", afs_op_error(op));
 		return false;
 	}
 
@@ -683,7 +683,7 @@ bool afs_check_server_record(struct afs_operation *op, struct afs_server *server
 			  (op->flags & AFS_OPERATION_UNINTR) ?
 			  TASK_UNINTERRUPTIBLE : TASK_INTERRUPTIBLE);
 	if (ret == -ERESTARTSYS) {
-		op->error = ret;
+		afs_op_set_error(op, ret);
 		_leave(" = f [intr]");
 		return false;
 	}
diff --git a/fs/afs/write.c b/fs/afs/write.c
index e1c45341719b..953f2c581afa 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -366,7 +366,7 @@ static void afs_store_data_success(struct afs_operation *op)
 
 	op->ctime = op->file[0].scb.status.mtime_client;
 	afs_vnode_commit_status(op, &op->file[0]);
-	if (op->error == 0) {
+	if (!afs_op_error(op)) {
 		if (!op->store.laundering)
 			afs_pages_written_back(vnode, op->store.pos, op->store.size);
 		afs_stat_v(vnode, n_stores);
@@ -428,7 +428,7 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 
 	afs_wait_for_operation(op);
 
-	switch (op->error) {
+	switch (afs_op_error(op)) {
 	case -EACCES:
 	case -EPERM:
 	case -ENOKEY:
@@ -447,7 +447,7 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 	}
 
 	afs_put_wb_key(wbk);
-	_leave(" = %d", op->error);
+	_leave(" = %d", afs_op_error(op));
 	return afs_put_operation(op);
 }
 


