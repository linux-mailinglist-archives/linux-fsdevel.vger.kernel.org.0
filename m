Return-Path: <linux-fsdevel+bounces-2578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA6F7E6DC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4087F28178C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CCD34CEC;
	Thu,  9 Nov 2023 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhL5589n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED332C9B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:41:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CADA3C0B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJueesqft+m4fnw2rabT+sxbm0N2b75qxyfYXt7rx+Y=;
	b=bhL5589n3q6KLU7LdQkSjiuskj3TmbKkPPdVNQwsNBTWJgaKkXmCC+YM0sBYxcCe5kXySb
	W7b2dtqJJJMO+/Uk7fUyws4wJQnjtq+84fxA3SoGAnItR4SF4qYjmHwh3DhV2NWwsK0bJc
	4he9KYG4Q6U1BdpNkPmtZD/eJ5Z4Sv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-2jl5538mPfycr6PLYgmTHw-1; Thu, 09 Nov 2023 10:41:15 -0500
X-MC-Unique: 2jl5538mPfycr6PLYgmTHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9936C88D016;
	Thu,  9 Nov 2023 15:41:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B5BCD25C1;
	Thu,  9 Nov 2023 15:41:13 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 38/41] afs: Parse the VolSync record in the reply of a number of RPC ops
Date: Thu,  9 Nov 2023 15:40:01 +0000
Message-ID: <20231109154004.3317227-39-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

A number of fileserver RPC operations return a VolSync record as part of
their reply that gives some information about the state of the volume being
accessed, including:

 (1) A volume Creation timestamp.  For an RW volume, this is the time at
     which the volume was created; if it changes, the RW volume was
     presumably restored from a backup and all cached data should be
     scrubbed as Data Version numbers could regress on the files in the
     volume.

     For an RO volume, this is the time it was last snapshotted from the RW
     volume.  It is expected to advance each time this happens; if it
     regresses, cached data should be scrubbed.

 (2) A volume Update timestamp (Auristor only).  For an RW volume, this is
     updated any time any change is made to a volume or its contents.  If
     it regresses, all cached data must be scrubbed.

     For an RO volume, this is a copy of the RW volume's Update timestamp
     at the point of snapshotting.  It can be used as a version number when
     checking to see if a callback on a RO volume was due to a snapshot.
     If it regresses, all cached data must be scrubbed.

but this is currently not made use of by the in-kernel afs filesystem.

Make the afs filesystem use this by:

 (1) Add a mask to the afs_volsync struct to record what fields are set
     there and add an update time.

 (2) Add an afs_volsync struct to the afs_volume struct and use this to
     track the two timestamps in the afs_volume struct.

 (3) Add a 'pre-op volsync' struct to the afs_operation struct to record
     the state of the volume tracking before the op.

 (4) Add a new counter, cb_scrub, to the afs_volume struct to count events
     that require all data to be scrubbed.  A copy is placed in the
     afs_vnode struct (inode) and if they no longer match, a scrub takes
     place.

 (5) When the result of an operation is being parsed, parse the VolSync
     data too, if it is provided.  Note that the two timestamps are handled
     separately, since they don't work in quite the same way.

     - If the afs_volume tracking is unset, just set it and do nothing
       else.

     - If the result timestamps are the same as the ones in afs_volume, do
       nothing.

     - If the timestamps regress, propose incrementing cb_scrub.

     - If the RW creation timestamp changes, propose incrementing cb_scrub.

     - If any timestamp changes, propose incrementing cb_v_break,
       indicating updates may be required.

     - If an update cb_scrub or cb_v_break is proposed, try to cmpxchg the
       copy of the timestamp in afs_volume from the pre-op version to the
       result version and only update if successful.  This should help
       mitigate the case where a bunch of parallel ops all see the change
       and all try crank the counters.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/afs.h               |   4 ++
 fs/afs/callback.c          |   7 +--
 fs/afs/fs_operation.c      |  15 +++---
 fs/afs/fsclient.c          |   9 +++-
 fs/afs/inode.c             |   4 +-
 fs/afs/internal.h          |  12 +++--
 fs/afs/rotate.c            |   2 +-
 fs/afs/validation.c        | 107 ++++++++++++++++++++++++++++++++++++-
 fs/afs/yfsclient.c         |   6 ++-
 include/trace/events/afs.h |  27 ++++++++++
 10 files changed, 174 insertions(+), 19 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index 81815724db6c..a6328a9ec9b0 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -165,7 +165,11 @@ struct afs_status_cb {
  * AFS volume synchronisation information
  */
 struct afs_volsync {
+	unsigned int		mask;		/* Bitmask of supplied fields */
+#define AFS_VOLSYNC_CREATION	0x01
+#define AFS_VOLSYNC_UPDATE	0x02
 	time64_t		creation;	/* volume creation time */
+	time64_t		update;		/* Volume update time */
 };
 
 /*
diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 535477f88a4f..62332cfa8661 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -81,7 +81,7 @@ void __afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reas
 	clear_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	if (test_and_clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
 		vnode->cb_break++;
-		vnode->cb_v_break = vnode->volume->cb_v_break;
+		vnode->cb_v_break = atomic_read(&vnode->volume->cb_v_break);
 		afs_clear_permits(vnode);
 
 		if (vnode->lock_state == AFS_VNODE_LOCK_WAITING_FOR_CB)
@@ -158,12 +158,13 @@ static void afs_break_one_callback(struct afs_volume *volume,
 	struct super_block *sb;
 	struct afs_vnode *vnode;
 	struct inode *inode;
+	unsigned int cb_v_break;
 
 	if (fid->vnode == 0 && fid->unique == 0) {
 		/* The callback break applies to an entire volume. */
 		write_lock(&volume->cb_v_break_lock);
-		volume->cb_v_break++;
-		trace_afs_cb_break(fid, volume->cb_v_break,
+		cb_v_break = atomic_inc_return(&volume->cb_v_break);
+		trace_afs_cb_break(fid, cb_v_break,
 				   afs_cb_break_for_volume_callback, false);
 		write_unlock(&volume->cb_v_break_lock);
 		return;
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 10137681aa7d..7f1ee13ebce0 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -35,11 +35,14 @@ struct afs_operation *afs_alloc_operation(struct key *key, struct afs_volume *vo
 		key_get(key);
 	}
 
-	op->key		= key;
-	op->volume	= afs_get_volume(volume, afs_volume_trace_get_new_op);
-	op->net		= volume->cell->net;
-	op->cb_v_break	= volume->cb_v_break;
-	op->debug_id	= atomic_inc_return(&afs_operation_debug_counter);
+	op->key			= key;
+	op->volume		= afs_get_volume(volume, afs_volume_trace_get_new_op);
+	op->net			= volume->cell->net;
+	op->cb_v_break		= atomic_read(&volume->cb_v_break);
+	op->pre_volsync.mask	= READ_ONCE(volume->volsync.mask);
+	op->pre_volsync.creation = READ_ONCE(volume->volsync.creation);
+	op->pre_volsync.update	= READ_ONCE(volume->volsync.update);
+	op->debug_id		= atomic_inc_return(&afs_operation_debug_counter);
 	op->nr_iterations = -1;
 	afs_op_set_error(op, -EDESTADDRREQ);
 
@@ -147,7 +150,7 @@ bool afs_begin_vnode_operation(struct afs_operation *op)
 
 	afs_prepare_vnode(op, &op->file[0], 0);
 	afs_prepare_vnode(op, &op->file[1], 1);
-	op->cb_v_break = op->volume->cb_v_break;
+	op->cb_v_break = atomic_read(&op->volume->cb_v_break);
 	_leave(" = true");
 	return true;
 }
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index f1f879ba9cf7..1bd1614688f7 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -165,8 +165,10 @@ static void xdr_decode_AFSVolSync(const __be32 **_bp,
 	bp++; /* spare6 */
 	*_bp = bp;
 
-	if (volsync)
+	if (volsync) {
 		volsync->creation = creation;
+		volsync->mask |= AFS_VOLSYNC_CREATION;
+	}
 }
 
 /*
@@ -1870,7 +1872,10 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		xdr_decode_AFSVolSync(&bp, &op->volsync);
+		/* Unfortunately, prior to OpenAFS-1.6, volsync here is filled
+		 * with rubbish.
+		 */
+		xdr_decode_AFSVolSync(&bp, NULL);
 
 		call->unmarshall++;
 		fallthrough;
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 8dbb09a79c4d..43c71fd50202 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -329,6 +329,8 @@ static void afs_fetch_status_success(struct afs_operation *op)
 	struct afs_vnode *vnode = vp->vnode;
 	int ret;
 
+	afs_update_volume_state(op, vp);
+
 	if (vnode->netfs.inode.i_state & I_NEW) {
 		ret = afs_inode_init_from_status(op, vp, vnode);
 		afs_op_set_error(op, ret);
@@ -542,7 +544,7 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 	BUG_ON(!(inode->i_state & I_NEW));
 
 	vnode = AFS_FS_I(inode);
-	vnode->cb_v_break = as->volume->cb_v_break,
+	vnode->cb_v_break = atomic_read(&as->volume->cb_v_break),
 	afs_set_netfs_context(vnode);
 
 	op = afs_alloc_operation(key, as->volume);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 73f0a456ab98..6561a1946be2 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -631,6 +631,7 @@ struct afs_volume {
 	afs_volid_t		vids[AFS_MAXTYPES]; /* All associated volume IDs */
 	refcount_t		ref;
 	time64_t		update_at;	/* Time at which to next update */
+	struct afs_volsync	volsync;	/* Volume info from server */
 	struct afs_cell		*cell;		/* Cell to which belongs (pins ref) */
 	struct rb_node		cell_node;	/* Link in cell->volumes */
 	struct hlist_node	proc_link;	/* Link in cell->proc_volumes */
@@ -651,7 +652,10 @@ struct afs_volume {
 	rwlock_t		servers_lock;	/* Lock for ->servers */
 	unsigned int		servers_seq;	/* Incremented each time ->servers changes */
 
-	unsigned		cb_v_break;	/* Break-everything counter. */
+	/* Callback management */
+	atomic_t		cb_ro_snapshot;	/* RO volume update-from-snapshot counter */
+	atomic_t		cb_v_break;	/* Volume-break event counter. */
+	atomic_t		cb_scrub;	/* Scrub-all-data event counter. */
 	rwlock_t		cb_v_break_lock;
 
 	afs_voltype_t		type;		/* type of volume */
@@ -845,7 +849,8 @@ struct afs_operation {
 	struct afs_volume	*volume;	/* Volume being accessed */
 	struct afs_vnode_param	file[2];
 	struct afs_vnode_param	*more_files;
-	struct afs_volsync	volsync;
+	struct afs_volsync	pre_volsync;	/* Volsync before op */
+	struct afs_volsync	volsync;	/* Volsync returned by op */
 	struct dentry		*dentry;	/* Dentry to be altered */
 	struct dentry		*dentry_2;	/* Second dentry to be altered */
 	struct timespec64	mtime;		/* Modification time to record */
@@ -1052,7 +1057,7 @@ static inline unsigned int afs_calc_vnode_cb_break(struct afs_vnode *vnode)
 static inline bool afs_cb_is_broken(unsigned int cb_break,
 				    const struct afs_vnode *vnode)
 {
-	return cb_break != (vnode->cb_break + vnode->volume->cb_v_break);
+	return cb_break != (vnode->cb_break + atomic_read(&vnode->volume->cb_v_break));
 }
 
 /*
@@ -1544,6 +1549,7 @@ extern void afs_fs_exit(void);
 /*
  * validation.c
  */
+void afs_update_volume_state(struct afs_operation *op, struct afs_vnode_param *vp);
 bool afs_check_validity(struct afs_vnode *vnode);
 bool afs_pagecache_valid(struct afs_vnode *vnode);
 int afs_validate(struct afs_vnode *vnode, struct key *key);
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 56916558dd1d..f2f7e57a4bdd 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -482,7 +482,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		vnode->cb_server = server;
 		vnode->cb_s_break = server->cb_s_break;
 		vnode->cb_fs_s_break = atomic_read(&server->cell->fs_s_break);
-		vnode->cb_v_break = vnode->volume->cb_v_break;
+		vnode->cb_v_break = atomic_read(&vnode->volume->cb_v_break);
 		clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
 	}
 
diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index 188ccc8e0fcf..f6bdaa121cf6 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -10,6 +10,109 @@
 #include <linux/sched.h>
 #include "internal.h"
 
+/*
+ * Handle a change to the volume creation time in the VolSync record.
+ */
+static void afs_update_volume_creation_time(struct afs_operation *op, struct afs_volume *volume)
+{
+	enum afs_cb_break_reason reason = afs_cb_break_for_vos_release;
+	unsigned int snap;
+	time64_t cur = READ_ONCE(volume->volsync.creation);
+	time64_t old = op->pre_volsync.creation;
+	time64_t new = op->volsync.creation;
+
+	_enter("%llx,%llx,%llx->%llx", volume->vid, cur, old, new);
+
+	if (!(op->volsync.mask & AFS_VOLSYNC_CREATION) ||
+	    !(volume->volsync.mask & AFS_VOLSYNC_CREATION)) {
+		WRITE_ONCE(volume->volsync.creation, new);
+		volume->volsync.mask |= AFS_VOLSYNC_CREATION;
+		return;
+	}
+
+	if (likely(new == cur))
+		return;
+
+	/* If the creation time changes in an unexpected way, we need to scrub
+	 * our caches.  For a RW vol, this will only change if the volume is
+	 * restored from a backup; for a RO/Backup vol, this will advance when
+	 * the volume is updated to a new snapshot (eg. "vos release").
+	 */
+	if (volume->type == AFSVL_RWVOL || new < old)
+		reason = afs_cb_break_for_creation_regress;
+
+	/* Try to advance the creation timestamp from what we had before the
+	 * operation to what we got back from the server.  This should
+	 * hopefully ensure that in a race between multiple operations only one
+	 * of them will do this.
+	 */
+	if (try_cmpxchg(&volume->volsync.creation, &old, new)) {
+		if (reason == afs_cb_break_for_creation_regress)
+			atomic_inc(&volume->cb_scrub);
+		else if (volume->type != AFSVL_RWVOL)
+			snap = atomic_inc_return(&volume->cb_ro_snapshot);
+		trace_afs_cb_v_break(volume->vid, snap, reason);
+	}
+}
+
+/*
+ * Handle a change to the volume update time in the VolSync record.
+ */
+static void afs_update_volume_update_time(struct afs_operation *op, struct afs_volume *volume)
+{
+	enum afs_cb_break_reason reason = afs_cb_break_no_break;
+	time64_t cur = READ_ONCE(volume->volsync.update);
+	time64_t old = op->pre_volsync.update;
+	time64_t new = op->volsync.update;
+
+	_enter("%llx,%llx,%llx->%llx", volume->vid, cur, old, new);
+
+	if (!(op->volsync.mask & AFS_VOLSYNC_UPDATE) ||
+	    !(volume->volsync.mask & AFS_VOLSYNC_UPDATE)) {
+		WRITE_ONCE(volume->volsync.update, new);
+		volume->volsync.mask |= AFS_VOLSYNC_UPDATE;
+		return;
+	}
+
+	if (likely(new == cur))
+		return;
+
+	/* If the volume update time changes in an unexpected way, we need to
+	 * scrub our caches.  For a RW vol, this will advance on every
+	 * modification op; for a RO/Backup vol, this will advance when the
+	 * volume is updated to a new snapshot (eg. "vos release").
+	 */
+	if (new < old)
+		reason = afs_cb_break_for_update_regress;
+
+	/* Try to advance the update timestamp from what we had before the
+	 * operation to what we got back from the server.  This should
+	 * hopefully ensure that in a race between multiple operations only one
+	 * of them will do this.
+	 */
+	if (try_cmpxchg(&volume->volsync.update, &old, new)) {
+		if (reason == afs_cb_break_for_update_regress) {
+			atomic_inc(&volume->cb_scrub);
+			trace_afs_cb_v_break(volume->vid, 0, reason);
+		}
+	}
+}
+
+/*
+ * Update the state of a volume.
+ */
+void afs_update_volume_state(struct afs_operation *op, struct afs_vnode_param *vp)
+{
+	struct afs_volume *volume = op->volume;
+
+	_enter("%llx", op->volume->vid);
+
+	if (op->volsync.mask & AFS_VOLSYNC_CREATION)
+		afs_update_volume_creation_time(op, volume);
+	if (op->volsync.mask & AFS_VOLSYNC_UPDATE)
+		afs_update_volume_update_time(op, volume);
+}
+
 /*
  * mark the data attached to an inode as obsolete due to a write on the server
  * - might also want to ditch all the outstanding writes and dirty pages
@@ -74,7 +177,7 @@ bool afs_check_validity(struct afs_vnode *vnode)
 		cb_break = vnode->cb_break;
 
 		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
-			if (vnode->cb_v_break != vnode->volume->cb_v_break)
+			if (vnode->cb_v_break != atomic_read(&vnode->volume->cb_v_break))
 				need_clear = afs_cb_break_for_v_break;
 			else if (!afs_check_server_good(vnode))
 				need_clear = afs_cb_break_for_s_reinit;
@@ -97,7 +200,7 @@ bool afs_check_validity(struct afs_vnode *vnode)
 
 	write_seqlock(&vnode->cb_lock);
 	if (need_clear == afs_cb_break_no_promise)
-		vnode->cb_v_break = vnode->volume->cb_v_break;
+		vnode->cb_v_break = atomic_read(&vnode->volume->cb_v_break);
 	else if (cb_break == vnode->cb_break)
 		__afs_break_callback(vnode, need_clear);
 	else
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 11571cca86c1..7c013070ef51 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -245,12 +245,16 @@ static void xdr_decode_YFSVolSync(const __be32 **_bp,
 				  struct afs_volsync *volsync)
 {
 	struct yfs_xdr_YFSVolSync *x = (void *)*_bp;
-	u64 creation;
+	u64 creation, update;
 
 	if (volsync) {
 		creation = xdr_to_u64(x->vol_creation_date);
 		do_div(creation, 10 * 1000 * 1000);
 		volsync->creation = creation;
+		update = xdr_to_u64(x->vol_update_date);
+		do_div(update, 10 * 1000 * 1000);
+		volsync->update = update;
+		volsync->mask |= AFS_VOLSYNC_CREATION | AFS_VOLSYNC_UPDATE;
 	}
 
 	*_bp += xdr_size(x);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 63ab23876be8..201dac3be54f 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -440,12 +440,15 @@ enum yfs_cm_operation {
 	EM(afs_cb_break_no_break,		"no-break")		\
 	EM(afs_cb_break_no_promise,		"no-promise")		\
 	EM(afs_cb_break_for_callback,		"break-cb")		\
+	EM(afs_cb_break_for_creation_regress,	"creation-regress")	\
 	EM(afs_cb_break_for_deleted,		"break-del")		\
 	EM(afs_cb_break_for_lapsed,		"break-lapsed")		\
 	EM(afs_cb_break_for_s_reinit,		"s-reinit")		\
 	EM(afs_cb_break_for_unlink,		"break-unlink")		\
+	EM(afs_cb_break_for_update_regress,	"update-regress")	\
 	EM(afs_cb_break_for_v_break,		"break-v")		\
 	EM(afs_cb_break_for_volume_callback,	"break-v-cb")		\
+	EM(afs_cb_break_for_vos_release,	"break-vos-release")	\
 	E_(afs_cb_break_for_zap,		"break-zap")
 
 /*
@@ -1249,6 +1252,30 @@ TRACE_EVENT(afs_get_tree,
 		      __entry->cell, __entry->volume, __entry->vid)
 	    );
 
+TRACE_EVENT(afs_cb_v_break,
+	    TP_PROTO(afs_volid_t vid, unsigned int cb_v_break,
+		     enum afs_cb_break_reason reason),
+
+	    TP_ARGS(vid, cb_v_break, reason),
+
+	    TP_STRUCT__entry(
+		    __field(afs_volid_t,		vid)
+		    __field(unsigned int,		cb_v_break)
+		    __field(enum afs_cb_break_reason,	reason)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->vid	= vid;
+		    __entry->cb_v_break	= cb_v_break;
+		    __entry->reason	= reason;
+			   ),
+
+	    TP_printk("%llx vb=%x %s",
+		      __entry->vid,
+		      __entry->cb_v_break,
+		      __print_symbolic(__entry->reason, afs_cb_break_reasons))
+	    );
+
 TRACE_EVENT(afs_cb_break,
 	    TP_PROTO(struct afs_fid *fid, unsigned int cb_break,
 		     enum afs_cb_break_reason reason, bool skipped),


