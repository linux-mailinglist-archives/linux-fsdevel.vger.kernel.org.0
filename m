Return-Path: <linux-fsdevel+bounces-37540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 309639F3BA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386487A0578
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68E1F3D55;
	Mon, 16 Dec 2024 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3xQCIx7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25A1F3D2E
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381833; cv=none; b=aQU4bzsqeNfvYakW1dVhQifXCm1EQga+pEqOzIvemeBr3qAH6QLr04ZNaiIgriGju3J/kolOyNiBkcVUjsOdx9ZNchu6QdpYosSjBcWaDQrmqlm33jXihSBx2GKbvROfNWHVmNHdZLv3kMctaQyF718UOjL+gH0VtID+jGpEJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381833; c=relaxed/simple;
	bh=a2afrvpp9V9JKCrlDwt64r66vnQWdcxIj3gIWZS/+lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AddJP8UhiFKCBGjTwrDPagMf24B163j1hajqdIhoGO3zGpgU99f7noMCyHGiD+IEi9jHbXA6BpYf2TbHhpIlLLv2caVimYlQXWk5o15Wip3RDorDd0hj5byLu0eVUC6fYLC7kjtZJob8ti4ff9wk9/CXrD/Qw97sqstfn2vQDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3xQCIx7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+CHA5nvTaynibcl9pvE1SvWwST0jzyWUHGlFvOt4QU=;
	b=E3xQCIx7H4GYm8zFUioni0OgulfY0Ihq3920BJcA3V/B+R/euG2CbJEcGM3NAr4wqG3nw8
	X32/MblBfHU9HagC03kmXTqDP1aXMtiWWekQz9+ibiAj7n8N6vi0+GmBWOZyu7T13Uvvnf
	QPiIzcLKwCtuzUApUby8eeentJIl6Gk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-iJxAfCXnMBKrOywh0pFfFg-1; Mon,
 16 Dec 2024 15:43:43 -0500
X-MC-Unique: iJxAfCXnMBKrOywh0pFfFg-1
X-Mimecast-MFC-AGG-ID: iJxAfCXnMBKrOywh0pFfFg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 081CB19560BD;
	Mon, 16 Dec 2024 20:43:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77B1D30044C1;
	Mon, 16 Dec 2024 20:43:35 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/32] afs: Add more tracepoints to do with tracking validity
Date: Mon, 16 Dec 2024 20:41:07 +0000
Message-ID: <20241216204124.3752367-18-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add wrappers to set and clear the callback promise and to mark a directory
as invalidated, and add tracepoints to track these events:

 (1) afs_cb_promise: Log when a callback promise is set on a vnode.

 (2) afs_vnode_invalid: Log when the server's callback promise for a vnode
     is no longer valid and we need to refetch the vnode metadata.

 (3) afs_dir_invalid: Log when the contents of a directory are marked
     invalid and requiring refetching from the server and the cache
     invalidating.

and two tracepoints to record data version number management:

 (4) afs_set_dv: Log when the DV is recorded on a vnode.

 (5) afs_dv_mismatch: Log when the DV recorded on a vnode plus the expected
     delta for the operation does not match the DV we got back from the
     server.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/callback.c          |   4 +-
 fs/afs/dir.c               |  14 ++-
 fs/afs/dir_edit.c          |  16 ++--
 fs/afs/inode.c             |  23 +++--
 fs/afs/internal.h          |  32 +++++++
 fs/afs/rotate.c            |   4 +-
 fs/afs/validation.c        |  31 ++++---
 include/trace/events/afs.h | 169 +++++++++++++++++++++++++++++++++++--
 8 files changed, 248 insertions(+), 45 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 99b2c8172021..69e1dd55b160 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -41,7 +41,7 @@ static void afs_volume_init_callback(struct afs_volume *volume)
 
 	list_for_each_entry(vnode, &volume->open_mmaps, cb_mmap_link) {
 		if (vnode->cb_v_check != atomic_read(&volume->cb_v_break)) {
-			atomic64_set(&vnode->cb_expires_at, AFS_NO_CB_PROMISE);
+			afs_clear_cb_promise(vnode, afs_cb_promise_clear_vol_init_cb);
 			queue_work(system_unbound_wq, &vnode->cb_work);
 		}
 	}
@@ -79,7 +79,7 @@ void __afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reas
 	_enter("");
 
 	clear_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
-	if (atomic64_xchg(&vnode->cb_expires_at, AFS_NO_CB_PROMISE) != AFS_NO_CB_PROMISE) {
+	if (afs_clear_cb_promise(vnode, afs_cb_promise_clear_cb_break)) {
 		vnode->cb_break++;
 		vnode->cb_v_check = atomic_read(&vnode->volume->cb_v_break);
 		afs_clear_permits(vnode);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 50edd1cae28a..f36a28a8f27b 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -324,8 +324,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 		folio = filemap_get_folio(mapping, i);
 		if (IS_ERR(folio)) {
-			if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
-				afs_stat_v(dvnode, n_inval);
+			afs_invalidate_dir(dvnode, afs_dir_invalid_reclaimed_folio);
 			folio = __filemap_get_folio(mapping,
 						    i, FGP_LOCK | FGP_CREAT,
 						    mapping->gfp_mask);
@@ -1388,8 +1387,8 @@ static void afs_dir_remove_subdir(struct dentry *dentry)
 
 		clear_nlink(&vnode->netfs.inode);
 		set_bit(AFS_VNODE_DELETED, &vnode->flags);
-		atomic64_set(&vnode->cb_expires_at, AFS_NO_CB_PROMISE);
-		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+		afs_clear_cb_promise(vnode, afs_cb_promise_clear_rmdir);
+		afs_invalidate_dir(vnode, afs_dir_invalid_subdir_removed);
 	}
 }
 
@@ -1851,6 +1850,7 @@ static void afs_rename_success(struct afs_operation *op)
 		write_seqlock(&vnode->cb_lock);
 
 		new_dv = vnode->status.data_version + 1;
+		trace_afs_set_dv(vnode, new_dv);
 		vnode->status.data_version = new_dv;
 		inode_set_iversion_raw(&vnode->netfs.inode, new_dv);
 
@@ -2063,8 +2063,7 @@ static bool afs_dir_release_folio(struct folio *folio, gfp_t gfp_flags)
 	folio_detach_private(folio);
 
 	/* The directory will need reloading. */
-	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
-		afs_stat_v(dvnode, n_relpg);
+	afs_invalidate_dir(dvnode, afs_dir_invalid_release_folio);
 	return true;
 }
 
@@ -2081,8 +2080,7 @@ static void afs_dir_invalidate_folio(struct folio *folio, size_t offset,
 	BUG_ON(!folio_test_locked(folio));
 
 	/* The directory will need reloading. */
-	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
-		afs_stat_v(dvnode, n_inval);
+	afs_invalidate_dir(dvnode, afs_dir_invalid_inval_folio);
 
 	/* we clean up only if the entire folio is being invalidated */
 	if (offset == 0 && length == folio_size(folio))
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 13fb236a3f50..5d092c8c0157 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -116,7 +116,7 @@ static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t index)
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				    mapping->gfp_mask);
 	if (IS_ERR(folio)) {
-		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+		afs_invalidate_dir(vnode, afs_dir_invalid_edit_get_block);
 		return NULL;
 	}
 	if (!folio_test_private(folio))
@@ -220,7 +220,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	i_size = i_size_read(&vnode->netfs.inode);
 	if (i_size > AFS_DIR_BLOCK_SIZE * AFS_DIR_MAX_BLOCKS ||
 	    (i_size & (AFS_DIR_BLOCK_SIZE - 1))) {
-		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+		afs_invalidate_dir(vnode, afs_dir_invalid_edit_add_bad_size);
 		return;
 	}
 
@@ -299,7 +299,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	 * succeeded.  Download the directory again.
 	 */
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_create_nospc, 0, 0, 0, 0, name->name);
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	afs_invalidate_dir(vnode, afs_dir_invalid_edit_add_no_slots);
 	goto out_unmap;
 
 new_directory:
@@ -358,7 +358,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	goto out_unmap;
 
 error_too_many_blocks:
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	afs_invalidate_dir(vnode, afs_dir_invalid_edit_add_too_many_blocks);
 error:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_create_error, 0, 0, 0, 0, name->name);
 	goto out_unmap;
@@ -388,7 +388,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	if (i_size < AFS_DIR_BLOCK_SIZE ||
 	    i_size > AFS_DIR_BLOCK_SIZE * AFS_DIR_MAX_BLOCKS ||
 	    (i_size & (AFS_DIR_BLOCK_SIZE - 1))) {
-		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+		afs_invalidate_dir(vnode, afs_dir_invalid_edit_rem_bad_size);
 		return;
 	}
 	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
@@ -440,7 +440,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	/* Didn't find the dirent to clobber.  Download the directory again. */
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_noent,
 			   0, 0, 0, 0, name->name);
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	afs_invalidate_dir(vnode, afs_dir_invalid_edit_rem_wrong_name);
 	goto out_unmap;
 
 found_dirent:
@@ -510,7 +510,7 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 
 	i_size = i_size_read(&vnode->netfs.inode);
 	if (i_size < AFS_DIR_BLOCK_SIZE) {
-		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+		afs_invalidate_dir(vnode, afs_dir_invalid_edit_upd_bad_size);
 		return;
 	}
 	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
@@ -542,7 +542,7 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 	/* Didn't find the dirent to clobber.  Download the directory again. */
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_nodd,
 			   0, 0, 0, 0, "..");
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	afs_invalidate_dir(vnode, afs_dir_invalid_edit_upd_no_dd);
 	goto out;
 
 found_dirent:
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index a95e77670b49..495ecef91679 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -140,15 +140,17 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 	afs_set_netfs_context(vnode);
 
 	vnode->invalid_before	= status->data_version;
+	trace_afs_set_dv(vnode, status->data_version);
 	inode_set_iversion_raw(&vnode->netfs.inode, status->data_version);
 
 	if (!vp->scb.have_cb) {
 		/* it's a symlink we just created (the fileserver
 		 * didn't give us a callback) */
-		atomic64_set(&vnode->cb_expires_at, AFS_NO_CB_PROMISE);
+		afs_clear_cb_promise(vnode, afs_cb_promise_set_new_symlink);
 	} else {
 		vnode->cb_server = op->server;
-		atomic64_set(&vnode->cb_expires_at, vp->scb.callback.expires_at);
+		afs_set_cb_promise(vnode, vp->scb.callback.expires_at,
+				   afs_cb_promise_set_new_inode);
 	}
 
 	write_sequnlock(&vnode->cb_lock);
@@ -207,12 +209,17 @@ static void afs_apply_status(struct afs_operation *op,
 	if (vp->update_ctime)
 		inode_set_ctime_to_ts(inode, op->ctime);
 
-	if (vnode->status.data_version != status->data_version)
+	if (vnode->status.data_version != status->data_version) {
+		trace_afs_set_dv(vnode, status->data_version);
 		data_changed = true;
+	}
 
 	vnode->status = *status;
 
 	if (vp->dv_before + vp->dv_delta != status->data_version) {
+		trace_afs_dv_mismatch(vnode, vp->dv_before, vp->dv_delta,
+				      status->data_version);
+
 		if (vnode->cb_ro_snapshot == atomic_read(&vnode->volume->cb_ro_snapshot) &&
 		    atomic64_read(&vnode->cb_expires_at) != AFS_NO_CB_PROMISE)
 			pr_warn("kAFS: vnode modified {%llx:%llu} %llx->%llx %s (op=%x)\n",
@@ -223,12 +230,10 @@ static void afs_apply_status(struct afs_operation *op,
 				op->debug_id);
 
 		vnode->invalid_before = status->data_version;
-		if (vnode->status.type == AFS_FTYPE_DIR) {
-			if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
-				afs_stat_v(vnode, n_inval);
-		} else {
+		if (vnode->status.type == AFS_FTYPE_DIR)
+			afs_invalidate_dir(vnode, afs_dir_invalid_dv_mismatch);
+		else
 			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
-		}
 		change_size = true;
 		data_changed = true;
 		unexpected_jump = true;
@@ -273,7 +278,7 @@ static void afs_apply_callback(struct afs_operation *op,
 	if (!afs_cb_is_broken(vp->cb_break_before, vnode)) {
 		if (op->volume->type == AFSVL_RWVOL)
 			vnode->cb_server = op->server;
-		atomic64_set(&vnode->cb_expires_at, cb->expires_at);
+		afs_set_cb_promise(vnode, cb->expires_at, afs_cb_promise_set_apply_cb);
 	}
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 07b8f7083e73..20d2f723948d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1713,6 +1713,38 @@ static inline int afs_bad(struct afs_vnode *vnode, enum afs_file_error where)
 	return -EIO;
 }
 
+/*
+ * Set the callback promise on a vnode.
+ */
+static inline void afs_set_cb_promise(struct afs_vnode *vnode, time64_t expires_at,
+				      enum afs_cb_promise_trace trace)
+{
+	atomic64_set(&vnode->cb_expires_at, expires_at);
+	trace_afs_cb_promise(vnode, trace);
+}
+
+/*
+ * Clear the callback promise on a vnode, returning true if it was promised.
+ */
+static inline bool afs_clear_cb_promise(struct afs_vnode *vnode,
+					enum afs_cb_promise_trace trace)
+{
+	trace_afs_cb_promise(vnode, trace);
+	return atomic64_xchg(&vnode->cb_expires_at, AFS_NO_CB_PROMISE) != AFS_NO_CB_PROMISE;
+}
+
+/*
+ * Mark a directory as being invalid.
+ */
+static inline void afs_invalidate_dir(struct afs_vnode *dvnode,
+				      enum afs_dir_invalid_trace trace)
+{
+	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
+		trace_afs_dir_invalid(dvnode, trace);
+		afs_stat_v(dvnode, n_inval);
+	}
+}
+
 /*****************************************************************************/
 /*
  * debug tracing
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index d612983d6f38..a1c24f589d9e 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -99,7 +99,7 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 		write_seqlock(&vnode->cb_lock);
 		ASSERTCMP(cb_server, ==, vnode->cb_server);
 		vnode->cb_server = NULL;
-		if (atomic64_xchg(&vnode->cb_expires_at, AFS_NO_CB_PROMISE) != AFS_NO_CB_PROMISE)
+		if (afs_clear_cb_promise(vnode, afs_cb_promise_clear_rotate_server))
 			vnode->cb_break++;
 		write_sequnlock(&vnode->cb_lock);
 	}
@@ -583,7 +583,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	if (vnode->cb_server != server) {
 		vnode->cb_server = server;
 		vnode->cb_v_check = atomic_read(&vnode->volume->cb_v_break);
-		atomic64_set(&vnode->cb_expires_at, AFS_NO_CB_PROMISE);
+		afs_clear_cb_promise(vnode, afs_cb_promise_clear_server_change);
 	}
 
 retry_server:
diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index bef8af12ebe2..0ba8336c9025 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -120,22 +120,31 @@
 bool afs_check_validity(const struct afs_vnode *vnode)
 {
 	const struct afs_volume *volume = vnode->volume;
+	enum afs_vnode_invalid_trace trace = afs_vnode_valid_trace;
+	time64_t cb_expires_at = atomic64_read(&vnode->cb_expires_at);
 	time64_t deadline = ktime_get_real_seconds() + 10;
 
 	if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
 		return true;
 
-	if (atomic_read(&volume->cb_v_check) != atomic_read(&volume->cb_v_break) ||
-	    atomic64_read(&vnode->cb_expires_at)  <= deadline ||
-	    volume->cb_expires_at <= deadline ||
-	    vnode->cb_ro_snapshot != atomic_read(&volume->cb_ro_snapshot) ||
-	    vnode->cb_scrub	  != atomic_read(&volume->cb_scrub) ||
-	    test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags)) {
-		_debug("inval");
-		return false;
-	}
-
-	return true;
+	if (atomic_read(&volume->cb_v_check) != atomic_read(&volume->cb_v_break))
+		trace = afs_vnode_invalid_trace_cb_v_break;
+	else if (cb_expires_at == AFS_NO_CB_PROMISE)
+		trace = afs_vnode_invalid_trace_no_cb_promise;
+	else if (cb_expires_at <= deadline)
+		trace = afs_vnode_invalid_trace_expired;
+	else if (volume->cb_expires_at <= deadline)
+		trace = afs_vnode_invalid_trace_vol_expired;
+	else if (vnode->cb_ro_snapshot != atomic_read(&volume->cb_ro_snapshot))
+		trace = afs_vnode_invalid_trace_cb_ro_snapshot;
+	else if (vnode->cb_scrub != atomic_read(&volume->cb_scrub))
+		trace = afs_vnode_invalid_trace_cb_scrub;
+	else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
+		trace = afs_vnode_invalid_trace_zap_data;
+	else
+		return true;
+	trace_afs_vnode_invalid(vnode, trace);
+	return false;
 }
 
 /*
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index a0aed1a428a1..7cb5583efb91 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -323,6 +323,43 @@ enum yfs_cm_operation {
 	EM(yfs_CB_TellMeAboutYourself,		"YFSCB.TellMeAboutYourself") \
 	E_(yfs_CB_CallBack,			"YFSCB.CallBack")
 
+#define afs_cb_promise_traces \
+	EM(afs_cb_promise_clear_cb_break,	"CLEAR cb-break") \
+	EM(afs_cb_promise_clear_rmdir,		"CLEAR rmdir") \
+	EM(afs_cb_promise_clear_rotate_server,	"CLEAR rot-srv") \
+	EM(afs_cb_promise_clear_server_change,	"CLEAR srv-chg") \
+	EM(afs_cb_promise_clear_vol_init_cb,	"CLEAR vol-init-cb") \
+	EM(afs_cb_promise_set_apply_cb,		"SET apply-cb") \
+	EM(afs_cb_promise_set_new_inode,	"SET new-inode") \
+	E_(afs_cb_promise_set_new_symlink,	"SET new-symlink")
+
+#define afs_vnode_invalid_traces \
+	EM(afs_vnode_invalid_trace_cb_ro_snapshot, "cb-ro-snapshot") \
+	EM(afs_vnode_invalid_trace_cb_scrub,	"cb-scrub") \
+	EM(afs_vnode_invalid_trace_cb_v_break,	"cb-v-break") \
+	EM(afs_vnode_invalid_trace_expired,	"expired") \
+	EM(afs_vnode_invalid_trace_no_cb_promise, "no-cb-promise") \
+	EM(afs_vnode_invalid_trace_vol_expired,	"vol-expired") \
+	EM(afs_vnode_invalid_trace_zap_data,	"zap-data") \
+	E_(afs_vnode_valid_trace,		"valid")
+
+#define afs_dir_invalid_traces			\
+	EM(afs_dir_invalid_edit_add_bad_size,	"edit-add-bad-size") \
+	EM(afs_dir_invalid_edit_add_no_slots,	"edit-add-no-slots") \
+	EM(afs_dir_invalid_edit_add_too_many_blocks, "edit-add-too-many-blocks") \
+	EM(afs_dir_invalid_edit_get_block,	"edit-get-block") \
+	EM(afs_dir_invalid_edit_rem_bad_size,	"edit-rem-bad-size") \
+	EM(afs_dir_invalid_edit_rem_wrong_name,	"edit-rem-wrong_name") \
+	EM(afs_dir_invalid_edit_upd_bad_size,	"edit-upd-bad-size") \
+	EM(afs_dir_invalid_edit_upd_no_dd,	"edit-upd-no-dotdot") \
+	EM(afs_dir_invalid_dv_mismatch,		"dv-mismatch") \
+	EM(afs_dir_invalid_inval_folio,		"inv-folio") \
+	EM(afs_dir_invalid_iter_stale,		"iter-stale") \
+	EM(afs_dir_invalid_reclaimed_folio,	"reclaimed-folio") \
+	EM(afs_dir_invalid_release_folio,	"rel-folio") \
+	EM(afs_dir_invalid_remote,		"remote") \
+	E_(afs_dir_invalid_subdir_removed,	"subdir-removed")
+
 #define afs_edit_dir_ops				  \
 	EM(afs_edit_dir_create,			"create") \
 	EM(afs_edit_dir_create_error,		"c_fail") \
@@ -487,7 +524,9 @@ enum yfs_cm_operation {
 enum afs_alist_trace		{ afs_alist_traces } __mode(byte);
 enum afs_call_trace		{ afs_call_traces } __mode(byte);
 enum afs_cb_break_reason	{ afs_cb_break_reasons } __mode(byte);
+enum afs_cb_promise_trace	{ afs_cb_promise_traces } __mode(byte);
 enum afs_cell_trace		{ afs_cell_traces } __mode(byte);
+enum afs_dir_invalid_trace	{ afs_dir_invalid_traces} __mode(byte);
 enum afs_edit_dir_op		{ afs_edit_dir_ops } __mode(byte);
 enum afs_edit_dir_reason	{ afs_edit_dir_reasons } __mode(byte);
 enum afs_eproto_cause		{ afs_eproto_causes } __mode(byte);
@@ -498,6 +537,7 @@ enum afs_flock_operation	{ afs_flock_operations } __mode(byte);
 enum afs_io_error		{ afs_io_errors } __mode(byte);
 enum afs_rotate_trace		{ afs_rotate_traces } __mode(byte);
 enum afs_server_trace		{ afs_server_traces } __mode(byte);
+enum afs_vnode_invalid_trace	{ afs_vnode_invalid_traces} __mode(byte);
 enum afs_volume_trace		{ afs_volume_traces } __mode(byte);
 
 #endif /* end __AFS_GENERATE_TRACE_ENUMS_ONCE_ONLY */
@@ -513,8 +553,10 @@ enum afs_volume_trace		{ afs_volume_traces } __mode(byte);
 afs_alist_traces;
 afs_call_traces;
 afs_cb_break_reasons;
+afs_cb_promise_traces;
 afs_cell_traces;
 afs_cm_operations;
+afs_dir_invalid_traces;
 afs_edit_dir_ops;
 afs_edit_dir_reasons;
 afs_eproto_causes;
@@ -526,6 +568,7 @@ afs_fs_operations;
 afs_io_errors;
 afs_rotate_traces;
 afs_server_traces;
+afs_vnode_invalid_traces;
 afs_vl_operations;
 yfs_cm_operations;
 
@@ -670,7 +713,7 @@ TRACE_EVENT(afs_make_fs_call,
 		    }
 			   ),
 
-	    TP_printk("c=%08x %06llx:%06llx:%06x %s",
+	    TP_printk("c=%08x V=%llx i=%llx:%x %s",
 		      __entry->call,
 		      __entry->fid.vid,
 		      __entry->fid.vnode,
@@ -704,7 +747,7 @@ TRACE_EVENT(afs_make_fs_calli,
 		    }
 			   ),
 
-	    TP_printk("c=%08x %06llx:%06llx:%06x %s i=%u",
+	    TP_printk("c=%08x V=%llx i=%llx:%x %s i=%u",
 		      __entry->call,
 		      __entry->fid.vid,
 		      __entry->fid.vnode,
@@ -741,7 +784,7 @@ TRACE_EVENT(afs_make_fs_call1,
 		    __entry->name[__len] = 0;
 			   ),
 
-	    TP_printk("c=%08x %06llx:%06llx:%06x %s \"%s\"",
+	    TP_printk("c=%08x V=%llx i=%llx:%x %s \"%s\"",
 		      __entry->call,
 		      __entry->fid.vid,
 		      __entry->fid.vnode,
@@ -782,7 +825,7 @@ TRACE_EVENT(afs_make_fs_call2,
 		    __entry->name2[__len2] = 0;
 			   ),
 
-	    TP_printk("c=%08x %06llx:%06llx:%06x %s \"%s\" \"%s\"",
+	    TP_printk("c=%08x V=%llx i=%llx:%x %s \"%s\" \"%s\"",
 		      __entry->call,
 		      __entry->fid.vid,
 		      __entry->fid.vnode,
@@ -1002,7 +1045,7 @@ TRACE_EVENT(afs_edit_dir,
 		    __entry->name[__len] = 0;
 			   ),
 
-	    TP_printk("d=%x:%x %s %s %u[%u] f=%x:%x \"%s\"",
+	    TP_printk("di=%x:%x %s %s %u[%u] fi=%x:%x \"%s\"",
 		      __entry->vnode, __entry->unique,
 		      __print_symbolic(__entry->why, afs_edit_dir_reasons),
 		      __print_symbolic(__entry->op, afs_edit_dir_ops),
@@ -1011,6 +1054,122 @@ TRACE_EVENT(afs_edit_dir,
 		      __entry->name)
 	    );
 
+TRACE_EVENT(afs_dir_invalid,
+	    TP_PROTO(const struct afs_vnode *dvnode, enum afs_dir_invalid_trace trace),
+
+	    TP_ARGS(dvnode, trace),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		vnode)
+		    __field(unsigned int,		unique)
+		    __field(enum afs_dir_invalid_trace,	trace)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->vnode	= dvnode->fid.vnode;
+		    __entry->unique	= dvnode->fid.unique;
+		    __entry->trace	= trace;
+			   ),
+
+	    TP_printk("di=%x:%x %s",
+		      __entry->vnode, __entry->unique,
+		      __print_symbolic(__entry->trace, afs_dir_invalid_traces))
+	    );
+
+TRACE_EVENT(afs_cb_promise,
+	    TP_PROTO(const struct afs_vnode *vnode, enum afs_cb_promise_trace trace),
+
+	    TP_ARGS(vnode, trace),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		vnode)
+		    __field(unsigned int,		unique)
+		    __field(enum afs_cb_promise_trace,	trace)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->vnode	= vnode->fid.vnode;
+		    __entry->unique	= vnode->fid.unique;
+		    __entry->trace	= trace;
+			   ),
+
+	    TP_printk("di=%x:%x %s",
+		      __entry->vnode, __entry->unique,
+		      __print_symbolic(__entry->trace, afs_cb_promise_traces))
+	    );
+
+TRACE_EVENT(afs_vnode_invalid,
+	    TP_PROTO(const struct afs_vnode *vnode, enum afs_vnode_invalid_trace trace),
+
+	    TP_ARGS(vnode, trace),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		vnode)
+		    __field(unsigned int,		unique)
+		    __field(enum afs_vnode_invalid_trace, trace)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->vnode	= vnode->fid.vnode;
+		    __entry->unique	= vnode->fid.unique;
+		    __entry->trace	= trace;
+			   ),
+
+	    TP_printk("di=%x:%x %s",
+		      __entry->vnode, __entry->unique,
+		      __print_symbolic(__entry->trace, afs_vnode_invalid_traces))
+	    );
+
+TRACE_EVENT(afs_set_dv,
+	    TP_PROTO(const struct afs_vnode *dvnode, u64 new_dv),
+
+	    TP_ARGS(dvnode, new_dv),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		vnode)
+		    __field(unsigned int,		unique)
+		    __field(u64,			old_dv)
+		    __field(u64,			new_dv)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->vnode	= dvnode->fid.vnode;
+		    __entry->unique	= dvnode->fid.unique;
+		    __entry->old_dv	= dvnode->status.data_version;
+		    __entry->new_dv	= new_dv;
+			   ),
+
+	    TP_printk("di=%x:%x dv=%llx -> dv=%llx",
+		      __entry->vnode, __entry->unique,
+		      __entry->old_dv, __entry->new_dv)
+	    );
+
+TRACE_EVENT(afs_dv_mismatch,
+	    TP_PROTO(const struct afs_vnode *dvnode, u64 before_dv, int delta, u64 new_dv),
+
+	    TP_ARGS(dvnode, before_dv, delta, new_dv),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		vnode)
+		    __field(unsigned int,		unique)
+		    __field(int,			delta)
+		    __field(u64,			before_dv)
+		    __field(u64,			new_dv)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->vnode	= dvnode->fid.vnode;
+		    __entry->unique	= dvnode->fid.unique;
+		    __entry->delta	= delta;
+		    __entry->before_dv	= before_dv;
+		    __entry->new_dv	= new_dv;
+			   ),
+
+	    TP_printk("di=%x:%x xdv=%llx+%d dv=%llx",
+		      __entry->vnode, __entry->unique,
+		      __entry->before_dv, __entry->delta, __entry->new_dv)
+	    );
+
 TRACE_EVENT(afs_protocol_error,
 	    TP_PROTO(struct afs_call *call, enum afs_eproto_cause cause),
 


