Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E681E8ADC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgE2WDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:03:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33969 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728740AbgE2WCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwyGMT7Tgk+iyKcwJiB18HEQyrFlhb/jZsnxsruQQe0=;
        b=K8VlJ2/nKK3mxLfBcy6VzbezwWeXZiXisPm3exX868g7GbfrSJlsyYFA+Ag2UeRIOuWa7i
        opCsXsEWPzP6I8lYoGv8C2vx8jgWeTXvE4d7D0wW9PatkP4Ds43YQC81zH+BpN4+zxkJNd
        Rz4OpfI1ZSdOhARG4522h3x7SB1p3SI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-7ccv4z_3OYaj9U1M_Ske-Q-1; Fri, 29 May 2020 18:02:46 -0400
X-MC-Unique: 7ccv4z_3OYaj9U1M_Ske-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 839BF18A8233;
        Fri, 29 May 2020 22:02:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D6815C1B5;
        Fri, 29 May 2020 22:02:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/27] afs: Reorganise volume and server trees to be rooted on
 the cell
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:02:43 +0100
Message-ID: <159078976327.679399.6857337537730584290.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reorganise afs_volume objects such that they're in a tree keyed on volume
ID, rooted at on an afs_cell object rather than being in multiple trees,
each of which is rooted on an afs_server object.

afs_server structs become per-cell and acquire a pointer to the cell.

The process of breaking a callback then starts with finding the server by
its network address, following that to the cell and then looking up each
volume ID in the volume tree.

This is simpler than the afs_vol_interest/afs_cb_interest N:M mapping web
and allows those structs and the code for maintaining them to be simplified
or removed.

It does make a couple of things a bit more tricky, though:

 (1) Operations now start with a volume, not a server, so there can be more
     than one answer as to whether or not the server we'll end up using
     supports the FS.InlineBulkStatus RPC.

 (2) CB RPC operations that specify the server UUID.  There's still a tree
     of servers by UUID on the afs_net struct, but the UUIDs in it aren't
     guaranteed unique.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/callback.c     |  286 +++++++------------------------------------------
 fs/afs/cell.c         |    7 +
 fs/afs/dir.c          |   45 ++++++--
 fs/afs/fs_operation.c |   11 --
 fs/afs/fsclient.c     |   12 +-
 fs/afs/inode.c        |   59 ++++------
 fs/afs/internal.h     |   78 ++++---------
 fs/afs/proc.c         |   15 +--
 fs/afs/rotate.c       |  128 +++-------------------
 fs/afs/rxrpc.c        |    5 -
 fs/afs/security.c     |    8 +
 fs/afs/server.c       |   13 +-
 fs/afs/server_list.c  |   30 -----
 fs/afs/super.c        |    7 -
 fs/afs/vl_alias.c     |   14 +-
 fs/afs/volume.c       |   84 +++++++++++++-
 fs/afs/yfsclient.c    |    2 
 17 files changed, 257 insertions(+), 547 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 282dbac84435..b4cb9bb63f0a 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -20,185 +20,6 @@
 #include <linux/sched.h>
 #include "internal.h"
 
-/*
- * Create volume and callback interests on a server.
- */
-static struct afs_cb_interest *afs_create_interest(struct afs_server *server,
-						   struct afs_vnode *vnode)
-{
-	struct afs_vol_interest *new_vi, *vi;
-	struct afs_cb_interest *new;
-	struct rb_node *parent, **pp;
-
-	new_vi = kzalloc(sizeof(struct afs_vol_interest), GFP_KERNEL);
-	if (!new_vi)
-		return NULL;
-
-	new = kzalloc(sizeof(struct afs_cb_interest), GFP_KERNEL);
-	if (!new) {
-		kfree(new_vi);
-		return NULL;
-	}
-
-	new_vi->usage = 1;
-	new_vi->vid = vnode->volume->vid;
-	INIT_HLIST_HEAD(&new_vi->cb_interests);
-
-	refcount_set(&new->usage, 1);
-	new->sb = vnode->vfs_inode.i_sb;
-	new->server = afs_get_server(server, afs_server_trace_get_new_cbi);
-	INIT_HLIST_NODE(&new->cb_vlink);
-
-	write_seqlock(&server->cb_break_lock);
-
-	pp = &server->cb_volumes.rb_node;
-	while ((parent = *pp)) {
-		vi = rb_entry(parent, struct afs_vol_interest, srv_node);
-		if (vi->vid < new_vi->vid) {
-			pp = &(*pp)->rb_left;
-		} else if (vi->vid > new_vi->vid) {
-			pp = &(*pp)->rb_right;
-		} else {
-			vi->usage++;
-			goto found_vi;
-		}
-	}
-
-	vi = new_vi;
-	new_vi = NULL;
-	rb_link_node_rcu(&vi->srv_node, parent, pp);
-	rb_insert_color(&vi->srv_node, &server->cb_volumes);
-
-found_vi:
-	new->vol_interest = vi;
-	hlist_add_head(&new->cb_vlink, &vi->cb_interests);
-
-	write_sequnlock(&server->cb_break_lock);
-	kfree(new_vi);
-	return new;
-}
-
-/*
- * Set up an interest-in-callbacks record for a volume on a server and
- * register it with the server.
- * - Called with vnode->io_lock held.
- */
-int afs_register_server_cb_interest(struct afs_vnode *vnode,
-				    struct afs_server_list *slist,
-				    unsigned int index)
-{
-	struct afs_server_entry *entry = &slist->servers[index];
-	struct afs_cb_interest *cbi, *vcbi, *new, *old;
-	struct afs_server *server = entry->server;
-
-again:
-	vcbi = rcu_dereference_protected(vnode->cb_interest,
-					 lockdep_is_held(&vnode->io_lock));
-	if (vcbi && likely(vcbi == entry->cb_interest))
-		return 0;
-
-	read_lock(&slist->lock);
-	cbi = afs_get_cb_interest(entry->cb_interest);
-	read_unlock(&slist->lock);
-
-	if (vcbi) {
-		if (vcbi == cbi) {
-			afs_put_cb_interest(afs_v2net(vnode), cbi);
-			return 0;
-		}
-
-		/* Use a new interest in the server list for the same server
-		 * rather than an old one that's still attached to a vnode.
-		 */
-		if (cbi && vcbi->server == cbi->server) {
-			write_seqlock(&vnode->cb_lock);
-			old = rcu_dereference_protected(vnode->cb_interest,
-							lockdep_is_held(&vnode->cb_lock.lock));
-			rcu_assign_pointer(vnode->cb_interest, cbi);
-			write_sequnlock(&vnode->cb_lock);
-			afs_put_cb_interest(afs_v2net(vnode), old);
-			return 0;
-		}
-
-		/* Re-use the one attached to the vnode. */
-		if (!cbi && vcbi->server == server) {
-			write_lock(&slist->lock);
-			if (entry->cb_interest) {
-				write_unlock(&slist->lock);
-				afs_put_cb_interest(afs_v2net(vnode), cbi);
-				goto again;
-			}
-
-			entry->cb_interest = cbi;
-			write_unlock(&slist->lock);
-			return 0;
-		}
-	}
-
-	if (!cbi) {
-		new = afs_create_interest(server, vnode);
-		if (!new)
-			return -ENOMEM;
-
-		write_lock(&slist->lock);
-		if (!entry->cb_interest) {
-			entry->cb_interest = afs_get_cb_interest(new);
-			cbi = new;
-			new = NULL;
-		} else {
-			cbi = afs_get_cb_interest(entry->cb_interest);
-		}
-		write_unlock(&slist->lock);
-		afs_put_cb_interest(afs_v2net(vnode), new);
-	}
-
-	ASSERT(cbi);
-
-	/* Change the server the vnode is using.  This entails scrubbing any
-	 * interest the vnode had in the previous server it was using.
-	 */
-	write_seqlock(&vnode->cb_lock);
-
-	old = rcu_dereference_protected(vnode->cb_interest,
-					lockdep_is_held(&vnode->cb_lock.lock));
-	rcu_assign_pointer(vnode->cb_interest, cbi);
-	vnode->cb_s_break = cbi->server->cb_s_break;
-	vnode->cb_v_break = vnode->volume->cb_v_break;
-	clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
-
-	write_sequnlock(&vnode->cb_lock);
-	afs_put_cb_interest(afs_v2net(vnode), old);
-	return 0;
-}
-
-/*
- * Remove an interest on a server.
- */
-void afs_put_cb_interest(struct afs_net *net, struct afs_cb_interest *cbi)
-{
-	struct afs_vol_interest *vi;
-
-	if (cbi && refcount_dec_and_test(&cbi->usage)) {
-		if (!hlist_unhashed(&cbi->cb_vlink)) {
-			write_seqlock(&cbi->server->cb_break_lock);
-
-			hlist_del_init(&cbi->cb_vlink);
-			vi = cbi->vol_interest;
-			cbi->vol_interest = NULL;
-			if (--vi->usage == 0)
-				rb_erase(&vi->srv_node, &cbi->server->cb_volumes);
-			else
-				vi = NULL;
-
-			write_sequnlock(&cbi->server->cb_break_lock);
-			if (vi)
-				kfree_rcu(vi, rcu);
-			afs_put_server(net, cbi->server, afs_server_trace_put_cbi);
-		}
-		kfree_rcu(cbi, rcu);
-	}
-}
-
 /*
  * allow the fileserver to request callback state (re-)initialisation
  */
@@ -236,12 +57,12 @@ void afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reason
 }
 
 /*
- * Look up a volume interest by volume ID under RCU conditions.
+ * Look up a volume by volume ID under RCU conditions.
  */
-static struct afs_vol_interest *afs_lookup_vol_interest_rcu(struct afs_server *server,
-							    afs_volid_t vid)
+static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
+						afs_volid_t vid)
 {
-	struct afs_vol_interest *vi = NULL;
+	struct afs_volume *volume = NULL;
 	struct rb_node *p;
 	int seq = 0;
 
@@ -250,28 +71,25 @@ static struct afs_vol_interest *afs_lookup_vol_interest_rcu(struct afs_server *s
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
-		read_seqbegin_or_lock(&server->cb_break_lock, &seq);
+		read_seqbegin_or_lock(&cell->volume_lock, &seq);
 
-		p = rcu_dereference_raw(server->cb_volumes.rb_node);
+		p = rcu_dereference_raw(cell->volumes.rb_node);
 		while (p) {
-			vi = rb_entry(p, struct afs_vol_interest, srv_node);
+			volume = rb_entry(p, struct afs_volume, cell_node);
 
-			if (vi->vid < vid)
+			if (volume->vid < vid)
 				p = rcu_dereference_raw(p->rb_left);
-			else if (vi->vid > vid)
+			else if (volume->vid > vid)
 				p = rcu_dereference_raw(p->rb_right);
 			else
 				break;
-			/* We want to repeat the search, this time with the
-			 * lock properly locked.
-			 */
-			vi = NULL;
+			volume = NULL;
 		}
 
-	} while (need_seqretry(&server->cb_break_lock, seq));
+	} while (need_seqretry(&cell->volume_lock, seq));
 
-	done_seqretry(&server->cb_break_lock, seq);
-	return vi;
+	done_seqretry(&cell->volume_lock, seq);
+	return volume;
 }
 
 /*
@@ -280,42 +98,37 @@ static struct afs_vol_interest *afs_lookup_vol_interest_rcu(struct afs_server *s
  *   - the backing file is changed
  *   - a lock is released
  */
-static void afs_break_one_callback(struct afs_server *server,
-				   struct afs_fid *fid,
-				   struct afs_vol_interest *vi)
+static void afs_break_one_callback(struct afs_volume *volume,
+				   struct afs_fid *fid)
 {
-	struct afs_cb_interest *cbi;
+	struct super_block *sb;
 	struct afs_vnode *vnode;
 	struct inode *inode;
 
-	/* Step through all interested superblocks.  There may be more than one
-	 * because of cell aliasing.
-	 */
-	hlist_for_each_entry_rcu(cbi, &vi->cb_interests, cb_vlink) {
-		if (fid->vnode == 0 && fid->unique == 0) {
-			/* The callback break applies to an entire volume. */
-			struct afs_super_info *as = AFS_FS_S(cbi->sb);
-			struct afs_volume *volume = as->volume;
+	if (fid->vnode == 0 && fid->unique == 0) {
+		/* The callback break applies to an entire volume. */
+		write_lock(&volume->cb_v_break_lock);
+		volume->cb_v_break++;
+		trace_afs_cb_break(fid, volume->cb_v_break,
+				   afs_cb_break_for_volume_callback, false);
+		write_unlock(&volume->cb_v_break_lock);
+		return;
+	}
 
-			write_lock(&volume->cb_v_break_lock);
-			volume->cb_v_break++;
-			trace_afs_cb_break(fid, volume->cb_v_break,
-					   afs_cb_break_for_volume_callback, false);
-			write_unlock(&volume->cb_v_break_lock);
-		} else {
-			/* See if we can find a matching inode - even an I_NEW
-			 * inode needs to be marked as it can have its callback
-			 * broken before we finish setting up the local inode.
-			 */
-			inode = find_inode_rcu(cbi->sb, fid->vnode,
-					       afs_ilookup5_test_by_fid, fid);
-			if (inode) {
-				vnode = AFS_FS_I(inode);
-				afs_break_callback(vnode, afs_cb_break_for_callback);
-			} else {
-				trace_afs_cb_miss(fid, afs_cb_break_for_callback);
-			}
-		}
+	/* See if we can find a matching inode - even an I_NEW inode needs to
+	 * be marked as it can have its callback broken before we finish
+	 * setting up the local inode.
+	 */
+	sb = rcu_dereference(volume->sb);
+	if (!sb)
+		return;
+
+	inode = find_inode_rcu(sb, fid->vnode, afs_ilookup5_test_by_fid, fid);
+	if (inode) {
+		vnode = AFS_FS_I(inode);
+		afs_break_callback(vnode, afs_cb_break_for_callback);
+	} else {
+		trace_afs_cb_miss(fid, afs_cb_break_for_callback);
 	}
 }
 
@@ -324,11 +137,11 @@ static void afs_break_some_callbacks(struct afs_server *server,
 				     size_t *_count)
 {
 	struct afs_callback_break *residue = cbb;
-	struct afs_vol_interest *vi;
+	struct afs_volume *volume;
 	afs_volid_t vid = cbb->fid.vid;
 	size_t i;
 
-	vi = afs_lookup_vol_interest_rcu(server, vid);
+	volume = afs_lookup_volume_rcu(server->cell, vid);
 
 	/* TODO: Find all matching volumes if we couldn't match the server and
 	 * break them anyway.
@@ -341,8 +154,8 @@ static void afs_break_some_callbacks(struct afs_server *server,
 			       cbb->fid.vnode,
 			       cbb->fid.unique);
 			--*_count;
-			if (vi)
-				afs_break_one_callback(server, &cbb->fid, vi);
+			if (volume)
+				afs_break_one_callback(volume, &cbb->fid);
 		} else {
 			*residue++ = *cbb;
 		}
@@ -367,16 +180,3 @@ void afs_break_callbacks(struct afs_server *server, size_t count,
 	rcu_read_unlock();
 	return;
 }
-
-/*
- * Clear the callback interests in a server list.
- */
-void afs_clear_callback_interests(struct afs_net *net, struct afs_server_list *slist)
-{
-	int i;
-
-	for (i = 0; i < slist->nr_servers; i++) {
-		afs_put_cb_interest(net, slist->servers[i].cb_interest);
-		slist->servers[i].cb_interest = NULL;
-	}
-}
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 8bfc8a05fd46..005921e3b38d 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -161,8 +161,11 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 
 	atomic_set(&cell->usage, 2);
 	INIT_WORK(&cell->manager, afs_manage_cell);
-	INIT_LIST_HEAD(&cell->proc_volumes);
-	rwlock_init(&cell->proc_lock);
+	cell->volumes = RB_ROOT;
+	INIT_HLIST_HEAD(&cell->proc_volumes);
+	seqlock_init(&cell->volume_lock);
+	cell->fs_servers = RB_ROOT;
+	seqlock_init(&cell->fs_lock);
 	rwlock_init(&cell->vl_servers_lock);
 	cell->flags = (1 << AFS_CELL_FL_CHECK_ALIAS);
 
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 3bc970598851..154bfc82df63 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -702,6 +702,37 @@ static const struct afs_operation_ops afs_fetch_status_operation = {
 	.success	= afs_do_lookup_success,
 };
 
+/*
+ * See if we know that the server we expect to use doesn't support
+ * FS.InlineBulkStatus.
+ */
+static bool afs_server_supports_ibulk(struct afs_vnode *dvnode)
+{
+	struct afs_server_list *slist;
+	struct afs_volume *volume = dvnode->volume;
+	struct afs_server *server;
+	bool ret = true;
+	int i;
+
+	if (!test_bit(AFS_VOLUME_MAYBE_NO_IBULK, &volume->flags))
+		return true;
+
+	rcu_read_lock();
+	slist = rcu_dereference(volume->servers);
+
+	for (i = 0; i < slist->nr_servers; i++) {
+		server = slist->servers[i].server;
+		if (server == dvnode->cb_server) {
+			if (test_bit(AFS_SERVER_FL_NO_IBULK, &server->flags))
+				ret = false;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+	return ret;
+}
+
 /*
  * Do a lookup in a directory.  We make use of bulk lookup to query a slew of
  * files in one go and create inodes for them.  The inode of the file we were
@@ -711,10 +742,8 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 				   struct key *key)
 {
 	struct afs_lookup_cookie *cookie;
-	struct afs_cb_interest *dcbi;
 	struct afs_vnode_param *vp;
 	struct afs_operation *op;
-	struct afs_server *server;
 	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode;
 	struct inode *inode = NULL, *ti;
 	afs_dataversion_t data_version = READ_ONCE(dvnode->status.data_version);
@@ -734,16 +763,8 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	cookie->nr_fids = 2; /* slot 0 is saved for the fid we actually want
 			      * and slot 1 for the directory */
 
-	read_seqlock_excl(&dvnode->cb_lock);
-	dcbi = rcu_dereference_protected(dvnode->cb_interest,
-					 lockdep_is_held(&dvnode->cb_lock.lock));
-	if (dcbi) {
-		server = dcbi->server;
-		if (server &&
-		    test_bit(AFS_SERVER_FL_NO_IBULK, &server->flags))
-			cookie->one_only = true;
-	}
-	read_sequnlock_excl(&dvnode->cb_lock);
+	if (!afs_server_supports_ibulk(dvnode))
+		cookie->one_only = true;
 
 	/* search the directory */
 	ret = afs_dir_iterate(dir, &cookie->ctx, key, &data_version);
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index f57efd9d2db0..2d2dff5688a4 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -143,12 +143,6 @@ bool afs_begin_vnode_operation(struct afs_operation *op)
 		if (!afs_get_io_locks(op))
 			return false;
 
-	read_seqlock_excl(&vnode->cb_lock);
-	op->cbi = afs_get_cb_interest(
-		rcu_dereference_protected(vnode->cb_interest,
-					  lockdep_is_held(&vnode->cb_lock.lock)));
-	read_sequnlock_excl(&vnode->cb_lock);
-
 	afs_prepare_vnode(op, &op->file[0], 0);
 	afs_prepare_vnode(op, &op->file[1], 1);
 	op->cb_v_break = op->volume->cb_v_break;
@@ -183,8 +177,8 @@ void afs_wait_for_operation(struct afs_operation *op)
 	_enter("");
 
 	while (afs_select_fileserver(op)) {
-		op->cb_s_break = op->cbi->server->cb_s_break;
-		if (test_bit(AFS_SERVER_FL_IS_YFS, &op->cbi->server->flags) &&
+		op->cb_s_break = op->server->cb_s_break;
+		if (test_bit(AFS_SERVER_FL_IS_YFS, &op->server->flags) &&
 		    op->ops->issue_yfs_rpc)
 			op->ops->issue_yfs_rpc(op);
 		else
@@ -231,7 +225,6 @@ int afs_put_operation(struct afs_operation *op)
 	}
 
 	afs_end_cursor(&op->ac);
-	afs_put_cb_interest(op->net, op->cbi);
 	afs_put_serverlist(op->net, op->server_list);
 	afs_put_volume(op->net, op->volume, afs_volume_trace_put_put_op);
 	kfree(op);
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 24a880a8d64c..63215c5204a7 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -14,11 +14,6 @@
 #include "afs_fs.h"
 #include "xdr_fs.h"
 
-static inline void afs_use_fs_server(struct afs_call *call, struct afs_cb_interest *cbi)
-{
-	call->cbi = afs_get_cb_interest(cbi);
-}
-
 /*
  * decode an AFSFid block
  */
@@ -1908,8 +1903,11 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 static void afs_done_fs_inline_bulk_status(struct afs_call *call)
 {
 	if (call->error == -ECONNABORTED &&
-	    call->abort_code == RX_INVALID_OPERATION)
+	    call->abort_code == RX_INVALID_OPERATION) {
 		set_bit(AFS_SERVER_FL_NO_IBULK, &call->server->flags);
+		if (call->op)
+			set_bit(AFS_VOLUME_MAYBE_NO_IBULK, &call->op->volume->flags);
+	}
 }
 
 /*
@@ -1934,7 +1932,7 @@ void afs_fs_inline_bulk_status(struct afs_operation *op)
 	__be32 *bp;
 	int i;
 
-	if (test_bit(AFS_SERVER_FL_NO_IBULK, &op->cbi->server->flags)) {
+	if (test_bit(AFS_SERVER_FL_NO_IBULK, &op->server->flags)) {
 		op->error = -ENOTSUPP;
 		return;
 	}
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 94675acb6a3a..7dde703df40c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -71,7 +71,6 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 				      struct afs_vnode_param *vp,
 				      struct afs_vnode *vnode)
 {
-	struct afs_cb_interest *old_cbi = NULL;
 	struct afs_file_status *status = &vp->scb.status;
 	struct inode *inode = AFS_VNODE_TO_I(vnode);
 	struct timespec64 t;
@@ -150,18 +149,11 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 		vnode->cb_expires_at = ktime_get_real_seconds();
 	} else {
 		vnode->cb_expires_at = vp->scb.callback.expires_at;
-		old_cbi = rcu_dereference_protected(vnode->cb_interest,
-						    lockdep_is_held(&vnode->cb_lock.lock));
-		if (op->cbi != old_cbi)
-			rcu_assign_pointer(vnode->cb_interest,
-					   afs_get_cb_interest(op->cbi));
-		else
-			old_cbi = NULL;
+		vnode->cb_server = op->server;
 		set_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
 	}
 
 	write_sequnlock(&vnode->cb_lock);
-	afs_put_cb_interest(afs_v2net(vnode), old_cbi);
 	return 0;
 }
 
@@ -255,18 +247,12 @@ static void afs_apply_status(struct afs_operation *op,
 static void afs_apply_callback(struct afs_operation *op,
 			       struct afs_vnode_param *vp)
 {
-	struct afs_cb_interest *old;
 	struct afs_callback *cb = &vp->scb.callback;
 	struct afs_vnode *vnode = vp->vnode;
 
-	if (!afs_cb_is_broken(vp->cb_break_before, vnode, op->cbi)) {
+	if (!afs_cb_is_broken(vp->cb_break_before, vnode)) {
 		vnode->cb_expires_at	= cb->expires_at;
-		old = rcu_dereference_protected(vnode->cb_interest,
-						lockdep_is_held(&vnode->cb_lock.lock));
-		if (old != op->cbi) {
-			rcu_assign_pointer(vnode->cb_interest, afs_get_cb_interest(op->cbi));
-			afs_put_cb_interest(afs_v2net(vnode), old);
-		}
+		vnode->cb_server	= op->server;
 		set_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
 	}
 }
@@ -569,13 +555,31 @@ void afs_zap_data(struct afs_vnode *vnode)
 		invalidate_inode_pages2(vnode->vfs_inode.i_mapping);
 }
 
+/*
+ * Get the server reinit counter for a vnode's current server.
+ */
+static bool afs_get_s_break_rcu(struct afs_vnode *vnode, unsigned int *_s_break)
+{
+	struct afs_server_list *slist = rcu_dereference(vnode->volume->servers);
+	struct afs_server *server;
+	int i;
+
+	for (i = 0; i < slist->nr_servers; i++) {
+		server = slist->servers[i].server;
+		if (server == vnode->cb_server) {
+			*_s_break = READ_ONCE(server->cb_s_break);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /*
  * Check the validity of a vnode/inode.
  */
 bool afs_check_validity(struct afs_vnode *vnode)
 {
-	struct afs_cb_interest *cbi;
-	struct afs_server *server;
 	struct afs_volume *volume = vnode->volume;
 	enum afs_cb_break_reason need_clear = afs_cb_break_no_break;
 	time64_t now = ktime_get_real_seconds();
@@ -588,11 +592,8 @@ bool afs_check_validity(struct afs_vnode *vnode)
 		cb_v_break = READ_ONCE(volume->cb_v_break);
 		cb_break = vnode->cb_break;
 
-		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
-			cbi = rcu_dereference(vnode->cb_interest);
-			server = rcu_dereference(cbi->server);
-			cb_s_break = READ_ONCE(server->cb_s_break);
-
+		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags) &&
+		    afs_get_s_break_rcu(vnode, &cb_s_break)) {
 			if (vnode->cb_s_break != cb_s_break ||
 			    vnode->cb_v_break != cb_v_break) {
 				vnode->cb_s_break = cb_s_break;
@@ -739,7 +740,6 @@ int afs_drop_inode(struct inode *inode)
  */
 void afs_evict_inode(struct inode *inode)
 {
-	struct afs_cb_interest *cbi;
 	struct afs_vnode *vnode;
 
 	vnode = AFS_FS_I(inode);
@@ -756,15 +756,6 @@ void afs_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 
-	write_seqlock(&vnode->cb_lock);
-	cbi = rcu_dereference_protected(vnode->cb_interest,
-					lockdep_is_held(&vnode->cb_lock.lock));
-	if (cbi) {
-		afs_put_cb_interest(afs_i2net(inode), cbi);
-		rcu_assign_pointer(vnode->cb_interest, NULL);
-	}
-	write_sequnlock(&vnode->cb_lock);
-
 	while (!list_empty(&vnode->wb_keys)) {
 		struct afs_wb_key *wbk = list_entry(vnode->wb_keys.next,
 						    struct afs_wb_key, vnode_link);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e084936066b0..c64c2b47ece7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -103,7 +103,6 @@ struct afs_call {
 	struct afs_net		*net;		/* The network namespace */
 	struct afs_server	*server;	/* The fileserver record if fs op (pins ref) */
 	struct afs_vlserver	*vlserver;	/* The vlserver record if vl op */
-	struct afs_cb_interest	*cbi;		/* Callback interest for server used */
 	void			*request;	/* request data (first part) */
 	struct iov_iter		def_iter;	/* Default buffer/data iterator */
 	struct iov_iter		*iter;		/* Iterator currently in use */
@@ -375,9 +374,14 @@ struct afs_cell {
 	enum dns_lookup_status	dns_status:8;	/* Latest status of data from lookup */
 	unsigned int		dns_lookup_count; /* Counter of DNS lookups */
 
+	/* The volumes belonging to this cell */
+	struct rb_root		volumes;	/* Tree of volumes on this server */
+	struct hlist_head	proc_volumes;	/* procfs volume list */
+	seqlock_t		volume_lock;	/* For volumes */
+
 	/* Active fileserver interaction state. */
-	struct list_head	proc_volumes;	/* procfs volume list */
-	rwlock_t		proc_lock;
+	struct rb_root		fs_servers;	/* afs_server (by server UUID) */
+	seqlock_t		fs_lock;	/* For fs_servers  */
 
 	/* VL server list. */
 	rwlock_t		vl_servers_lock; /* Lock on vl_servers */
@@ -481,7 +485,8 @@ struct afs_server {
 	};
 
 	struct afs_addr_list	__rcu *addresses;
-	struct rb_node		uuid_rb;	/* Link in net->fs_servers */
+	struct afs_cell		*cell;		/* Cell to which belongs (pins ref) */
+	struct rb_node		uuid_rb;	/* Link in cell->fs_servers */
 	struct list_head	probe_link;	/* Link in net->fs_probe_list */
 	struct hlist_node	addr4_link;	/* Link in net->fs_addresses4 */
 	struct hlist_node	addr6_link;	/* Link in net->fs_addresses6 */
@@ -507,9 +512,7 @@ struct afs_server {
 	rwlock_t		fs_lock;	/* access lock */
 
 	/* callback promise management */
-	struct rb_root		cb_volumes;	/* List of volume interests on this server */
 	unsigned		cb_s_break;	/* Break-everything counter. */
-	seqlock_t		cb_break_lock;	/* Volume finding lock */
 
 	/* Probe state */
 	unsigned long		probed_at;	/* Time last probe was dispatched (jiffies) */
@@ -527,37 +530,11 @@ struct afs_server {
 	} probe;
 };
 
-/*
- * Volume collation in the server's callback interest list.
- */
-struct afs_vol_interest {
-	struct rb_node		srv_node;	/* Link in server->cb_volumes */
-	struct hlist_head	cb_interests;	/* List of callback interests on the server */
-	union {
-		struct rcu_head	rcu;
-		afs_volid_t	vid;		/* Volume ID to match */
-	};
-	unsigned int		usage;
-};
-
-/*
- * Interest by a superblock on a server.
- */
-struct afs_cb_interest {
-	struct hlist_node	cb_vlink;	/* Link in vol_interest->cb_interests */
-	struct afs_vol_interest	*vol_interest;
-	struct afs_server	*server;	/* Server on which this interest resides */
-	struct super_block	*sb;		/* Superblock on which inodes reside */
-	struct rcu_head		rcu;
-	refcount_t		usage;
-};
-
 /*
  * Replaceable volume server list.
  */
 struct afs_server_entry {
 	struct afs_server	*server;
-	struct afs_cb_interest	*cb_interest;
 };
 
 struct afs_server_list {
@@ -575,11 +552,16 @@ struct afs_server_list {
  * Live AFS volume management.
  */
 struct afs_volume {
-	afs_volid_t		vid;		/* volume ID */
+	union {
+		struct rcu_head	rcu;
+		afs_volid_t	vid;		/* volume ID */
+	};
 	atomic_t		usage;
 	time64_t		update_at;	/* Time at which to next update */
 	struct afs_cell		*cell;		/* Cell to which belongs (pins ref) */
-	struct list_head	proc_link;	/* Link in cell->vl_proc */
+	struct rb_node		cell_node;	/* Link in cell->volumes */
+	struct hlist_node	proc_link;	/* Link in cell->proc_volumes */
+	struct super_block __rcu *sb;		/* Superblock on which inodes reside */
 	unsigned long		flags;
 #define AFS_VOLUME_NEEDS_UPDATE	0	/* - T if an update needs performing */
 #define AFS_VOLUME_UPDATING	1	/* - T if an update is in progress */
@@ -587,6 +569,7 @@ struct afs_volume {
 #define AFS_VOLUME_DELETED	3	/* - T if volume appears deleted */
 #define AFS_VOLUME_OFFLINE	4	/* - T if volume offline notice given */
 #define AFS_VOLUME_BUSY		5	/* - T if volume busy notice given */
+#define AFS_VOLUME_MAYBE_NO_IBULK 6	/* - T if some servers don't have InlineBulkStatus */
 #ifdef CONFIG_AFS_FSCACHE
 	struct fscache_cookie	*cache;		/* caching cookie */
 #endif
@@ -598,7 +581,6 @@ struct afs_volume {
 	rwlock_t		cb_v_break_lock;
 
 	afs_voltype_t		type;		/* type of volume */
-	short			error;
 	char			type_force;	/* force volume type (suppress R/O -> R/W) */
 	u8			name_len;
 	u8			name[AFS_MAXVOLNAME + 1]; /* NUL-padded volume name */
@@ -659,11 +641,11 @@ struct afs_vnode {
 	afs_lock_type_t		lock_type : 8;
 
 	/* outstanding callback notification on this file */
-	struct afs_cb_interest __rcu *cb_interest; /* Server on which this resides */
+	void			*cb_server;	/* Server with callback/filelock */
 	unsigned int		cb_s_break;	/* Mass break counter on ->server */
 	unsigned int		cb_v_break;	/* Mass break counter on ->volume */
 	unsigned int		cb_break;	/* Break counter on vnode */
-	seqlock_t		cb_lock;	/* Lock for ->cb_interest, ->status, ->cb_*break */
+	seqlock_t		cb_lock;	/* Lock for ->cb_server, ->status, ->cb_*break */
 
 	time64_t		cb_expires_at;	/* time at which callback expires */
 };
@@ -833,7 +815,7 @@ struct afs_operation {
 	/* Fileserver iteration state */
 	struct afs_addr_cursor	ac;
 	struct afs_server_list	*server_list;	/* Current server list (pins ref) */
-	struct afs_cb_interest	*cbi;		/* Server on which this resides (pins ref) */
+	struct afs_server	*server;	/* Server we're using (ref pinned by server_list) */
 	struct afs_call		*call;
 	unsigned long		untried;	/* Bitmask of untried servers */
 	short			index;		/* Current server */
@@ -907,29 +889,15 @@ extern void __afs_break_callback(struct afs_vnode *, enum afs_cb_break_reason);
 extern void afs_break_callback(struct afs_vnode *, enum afs_cb_break_reason);
 extern void afs_break_callbacks(struct afs_server *, size_t, struct afs_callback_break *);
 
-extern int afs_register_server_cb_interest(struct afs_vnode *,
-					   struct afs_server_list *, unsigned int);
-extern void afs_put_cb_interest(struct afs_net *, struct afs_cb_interest *);
-extern void afs_clear_callback_interests(struct afs_net *, struct afs_server_list *);
-
-static inline struct afs_cb_interest *afs_get_cb_interest(struct afs_cb_interest *cbi)
-{
-	if (cbi)
-		refcount_inc(&cbi->usage);
-	return cbi;
-}
-
 static inline unsigned int afs_calc_vnode_cb_break(struct afs_vnode *vnode)
 {
 	return vnode->cb_break + vnode->cb_v_break;
 }
 
 static inline bool afs_cb_is_broken(unsigned int cb_break,
-				    const struct afs_vnode *vnode,
-				    const struct afs_cb_interest *cbi)
+				    const struct afs_vnode *vnode)
 {
-	return !cbi || cb_break != (vnode->cb_break +
-				    vnode->volume->cb_v_break);
+	return cb_break != (vnode->cb_break + vnode->volume->cb_v_break);
 }
 
 /*
@@ -1182,7 +1150,6 @@ static inline void afs_put_sysnames(struct afs_sysnames *sysnames) {}
  * rotate.c
  */
 extern bool afs_select_fileserver(struct afs_operation *);
-extern bool afs_select_current_fileserver(struct afs_operation *);
 extern void afs_dump_edestaddrreq(const struct afs_operation *);
 
 /*
@@ -1212,7 +1179,6 @@ static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *c
 	op->type = call->type;
 	call->op = op;
 	call->key = op->key;
-	call->cbi = afs_get_cb_interest(op->cbi);
 	call->intr = !(op->flags & AFS_OPERATION_UNINTR);
 	afs_make_call(&op->ac, call, gfp);
 }
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 256c3eff8c82..309a7b578255 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -209,11 +209,10 @@ static const char afs_vol_types[3][3] = {
  */
 static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
 {
-	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
-	struct afs_volume *vol = list_entry(v, struct afs_volume, proc_link);
+	struct afs_volume *vol = hlist_entry(v, struct afs_volume, proc_link);
 
 	/* Display header on line 1 */
-	if (v == &cell->proc_volumes) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(m, "USE VID      TY NAME\n");
 		return 0;
 	}
@@ -231,8 +230,8 @@ static void *afs_proc_cell_volumes_start(struct seq_file *m, loff_t *_pos)
 {
 	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
 
-	read_lock(&cell->proc_lock);
-	return seq_list_start_head(&cell->proc_volumes, *_pos);
+	rcu_read_lock();
+	return seq_hlist_start_head_rcu(&cell->proc_volumes, *_pos);
 }
 
 static void *afs_proc_cell_volumes_next(struct seq_file *m, void *v,
@@ -240,15 +239,13 @@ static void *afs_proc_cell_volumes_next(struct seq_file *m, void *v,
 {
 	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
 
-	return seq_list_next(v, &cell->proc_volumes, _pos);
+	return seq_hlist_next_rcu(v, &cell->proc_volumes, _pos);
 }
 
 static void afs_proc_cell_volumes_stop(struct seq_file *m, void *v)
 	__releases(cell->proc_lock)
 {
-	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
-
-	read_unlock(&cell->proc_lock);
+	rcu_read_unlock();
 }
 
 static const struct seq_operations afs_proc_cell_volumes_ops = {
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index e667145335d9..979979e33a77 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -21,7 +21,8 @@
 static bool afs_start_fs_iteration(struct afs_operation *op,
 				   struct afs_vnode *vnode)
 {
-	struct afs_cb_interest *cbi;
+	struct afs_server *server;
+	void *cb_server;
 	int i;
 
 	read_lock(&op->volume->servers_lock);
@@ -31,12 +32,12 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 	op->untried = (1UL << op->server_list->nr_servers) - 1;
 	op->index = READ_ONCE(op->server_list->preferred);
 
-	cbi = rcu_dereference_protected(vnode->cb_interest,
-					lockdep_is_held(&vnode->io_lock));
-	if (cbi) {
+	cb_server = vnode->cb_server;
+	if (cb_server) {
 		/* See if the vnode's preferred record is still available */
 		for (i = 0; i < op->server_list->nr_servers; i++) {
-			if (op->server_list->servers[i].cb_interest == cbi) {
+			server = op->server_list->servers[i].server;
+			if (server == cb_server) {
 				op->index = i;
 				goto found_interest;
 			}
@@ -53,14 +54,11 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 
 		/* Note that the callback promise is effectively broken */
 		write_seqlock(&vnode->cb_lock);
-		ASSERTCMP(cbi, ==, rcu_access_pointer(vnode->cb_interest));
-		rcu_assign_pointer(vnode->cb_interest, NULL);
+		ASSERTCMP(cb_server, ==, vnode->cb_server);
+		vnode->cb_server = NULL;
 		if (test_and_clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags))
 			vnode->cb_break++;
 		write_sequnlock(&vnode->cb_lock);
-
-		afs_put_cb_interest(op->net, cbi);
-		cbi = NULL;
 	}
 
 found_interest:
@@ -301,8 +299,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 restart_from_beginning:
 	_debug("restart");
 	afs_end_cursor(&op->ac);
-	afs_put_cb_interest(op->net, op->cbi);
-	op->cbi = NULL;
+	op->server = NULL;
 	afs_put_serverlist(op->net, op->server_list);
 	op->server_list = NULL;
 start:
@@ -329,13 +326,12 @@ bool afs_select_fileserver(struct afs_operation *op)
 	/* Pick the untried server with the lowest RTT.  If we have outstanding
 	 * callbacks, we stick with the server we're already using if we can.
 	 */
-	if (op->cbi) {
-		_debug("cbi %u", op->index);
+	if (op->server) {
+		_debug("server %u", op->index);
 		if (test_bit(op->index, &op->untried))
 			goto selected_server;
-		afs_put_cb_interest(op->net, op->cbi);
-		op->cbi = NULL;
-		_debug("nocbi");
+		op->server = NULL;
+		_debug("no server");
 	}
 
 	op->index = -1;
@@ -370,19 +366,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 	_debug("USING SERVER: %pU", &server->uuid);
 
-	/* Make sure we've got a callback interest record for this server.  We
-	 * have to link it in before we send the request as we can be sent a
-	 * break request before we've finished decoding the reply and
-	 * installing the vnode.
-	 */
-	error = afs_register_server_cb_interest(vnode, op->server_list,
-						op->index);
-	if (error < 0)
-		goto failed_set_error;
-
-	op->cbi = afs_get_cb_interest(
-		rcu_dereference_protected(vnode->cb_interest,
-					  lockdep_is_held(&vnode->io_lock)));
+	op->server = server;
+	if (vnode->cb_server != server) {
+		vnode->cb_server = server;
+		vnode->cb_s_break = server->cb_s_break;
+		vnode->cb_v_break = vnode->volume->cb_v_break;
+		clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+	}
 
 	read_lock(&server->fs_lock);
 	alist = rcu_dereference_protected(server->addresses,
@@ -444,84 +434,6 @@ bool afs_select_fileserver(struct afs_operation *op)
 	return false;
 }
 
-/*
- * Select the same fileserver we used for a vnode before and only that
- * fileserver.  We use this when we have a lock on that file, which is backed
- * only by the fileserver we obtained it from.
- */
-bool afs_select_current_fileserver(struct afs_operation *op)
-{
-	struct afs_cb_interest *cbi;
-	struct afs_addr_list *alist;
-	int error = op->ac.error;
-
-	_enter("");
-
-	switch (error) {
-	case SHRT_MAX:
-		cbi = op->cbi;
-		if (!cbi) {
-			op->error = -ESTALE;
-			op->flags |= AFS_OPERATION_STOP;
-			return false;
-		}
-
-		read_lock(&cbi->server->fs_lock);
-		alist = rcu_dereference_protected(cbi->server->addresses,
-						  lockdep_is_held(&cbi->server->fs_lock));
-		afs_get_addrlist(alist);
-		read_unlock(&cbi->server->fs_lock);
-		if (!alist) {
-			op->error = -ESTALE;
-			op->flags |= AFS_OPERATION_STOP;
-			return false;
-		}
-
-		memset(&op->ac, 0, sizeof(op->ac));
-		op->ac.alist = alist;
-		op->ac.index = -1;
-		goto iterate_address;
-
-	case 0:
-	default:
-		/* Success or local failure.  Stop. */
-		op->error = error;
-		op->flags |= AFS_OPERATION_STOP;
-		_leave(" = f [okay/local %d]", error);
-		return false;
-
-	case -ECONNABORTED:
-		op->error = afs_abort_to_error(op->ac.abort_code);
-		op->flags |= AFS_OPERATION_STOP;
-		_leave(" = f [abort]");
-		return false;
-
-	case -ERFKILL:
-	case -EADDRNOTAVAIL:
-	case -ENETUNREACH:
-	case -EHOSTUNREACH:
-	case -EHOSTDOWN:
-	case -ECONNREFUSED:
-	case -ETIMEDOUT:
-	case -ETIME:
-		_debug("no conn");
-		op->error = error;
-		goto iterate_address;
-	}
-
-iterate_address:
-	/* Iterate over the current server's address list to try and find an
-	 * address on which it will respond to us.
-	 */
-	if (afs_iterate_addresses(&op->ac)) {
-		_leave(" = t");
-		return true;
-	}
-
-	afs_end_cursor(&op->ac);
-	return false;
-}
-
 /*
  * Dump cursor state in the case of the error being EDESTADDRREQ.
  */
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index bd4d8e5efe59..b7fb5f98f80c 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -184,7 +184,6 @@ void afs_put_call(struct afs_call *call)
 			call->type->destructor(call);
 
 		afs_unuse_server_notime(call->net, call->server, afs_server_trace_put_call);
-		afs_put_cb_interest(call->net, call->cbi);
 		afs_put_addrlist(call->alist);
 		kfree(call->request);
 
@@ -550,9 +549,9 @@ static void afs_deliver_to_call(struct afs_call *call)
 		case 0:
 			afs_queue_call_work(call);
 			if (state == AFS_CALL_CL_PROC_REPLY) {
-				if (call->cbi)
+				if (call->op)
 					set_bit(AFS_SERVER_FL_MAY_HAVE_CB,
-						&call->cbi->server->flags);
+						&call->op->server->flags);
 				goto call_complete;
 			}
 			ASSERTCMP(state, >, AFS_CALL_CL_PROC_REPLY);
diff --git a/fs/afs/security.c b/fs/afs/security.c
index ce9de1e6742b..90d852704328 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -170,8 +170,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 					break;
 				}
 
-				if (afs_cb_is_broken(cb_break, vnode,
-						     rcu_dereference(vnode->cb_interest))) {
+				if (afs_cb_is_broken(cb_break, vnode)) {
 					changed = true;
 					break;
 				}
@@ -201,7 +200,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 		}
 	}
 
-	if (afs_cb_is_broken(cb_break, vnode, rcu_dereference(vnode->cb_interest)))
+	if (afs_cb_is_broken(cb_break, vnode))
 		goto someone_else_changed_it;
 
 	/* We need a ref on any permits list we want to copy as we'll have to
@@ -281,8 +280,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 	rcu_read_lock();
 	spin_lock(&vnode->lock);
 	zap = rcu_access_pointer(vnode->permit_cache);
-	if (!afs_cb_is_broken(cb_break, vnode, rcu_dereference(vnode->cb_interest)) &&
-	    zap == permits)
+	if (!afs_cb_is_broken(cb_break, vnode) && zap == permits)
 		rcu_assign_pointer(vnode->permit_cache, replacement);
 	else
 		zap = replacement;
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 1c1e315094ae..c51039a077cd 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -132,11 +132,12 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 /*
  * Install a server record in the namespace tree
  */
-static struct afs_server *afs_install_server(struct afs_net *net,
+static struct afs_server *afs_install_server(struct afs_cell *cell,
 					     struct afs_server *candidate)
 {
 	const struct afs_addr_list *alist;
 	struct afs_server *server;
+	struct afs_net *net = cell->net;
 	struct rb_node **pp, *p;
 	int diff;
 
@@ -193,11 +194,12 @@ static struct afs_server *afs_install_server(struct afs_net *net,
 /*
  * Allocate a new server record and mark it active.
  */
-static struct afs_server *afs_alloc_server(struct afs_net *net,
+static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 					   const uuid_t *uuid,
 					   struct afs_addr_list *alist)
 {
 	struct afs_server *server;
+	struct afs_net *net = cell->net;
 
 	_enter("");
 
@@ -212,11 +214,10 @@ static struct afs_server *afs_alloc_server(struct afs_net *net,
 	server->addr_version = alist->version;
 	server->uuid = *uuid;
 	rwlock_init(&server->fs_lock);
-	server->cb_volumes = RB_ROOT;
-	seqlock_init(&server->cb_break_lock);
 	init_waitqueue_head(&server->probe_wq);
 	INIT_LIST_HEAD(&server->probe_link);
 	spin_lock_init(&server->probe_lock);
+	server->cell = cell;
 
 	afs_inc_servers_outstanding(net);
 	trace_afs_server(server, 1, 1, afs_server_trace_alloc);
@@ -275,13 +276,13 @@ struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 	if (IS_ERR(alist))
 		return ERR_CAST(alist);
 
-	candidate = afs_alloc_server(cell->net, uuid, alist);
+	candidate = afs_alloc_server(cell, uuid, alist);
 	if (!candidate) {
 		afs_put_addrlist(alist);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	server = afs_install_server(cell->net, candidate);
+	server = afs_install_server(cell, candidate);
 	if (server != candidate) {
 		afs_put_addrlist(alist);
 		kfree(candidate);
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index a35f6951a74a..ed9056703505 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -14,11 +14,9 @@ void afs_put_serverlist(struct afs_net *net, struct afs_server_list *slist)
 	int i;
 
 	if (slist && refcount_dec_and_test(&slist->usage)) {
-		for (i = 0; i < slist->nr_servers; i++) {
-			afs_put_cb_interest(net, slist->servers[i].cb_interest);
+		for (i = 0; i < slist->nr_servers; i++)
 			afs_unuse_server(net, slist->servers[i].server,
 					 afs_server_trace_put_slist);
-		}
 		kfree(slist);
 	}
 }
@@ -127,31 +125,5 @@ bool afs_annotate_server_list(struct afs_server_list *new,
 		}
 	}
 
-	/* Keep the old callback interest records where possible so that we
-	 * maintain callback interception.
-	 */
-	i = 0;
-	j = 0;
-	while (i < old->nr_servers && j < new->nr_servers) {
-		if (new->servers[j].server == old->servers[i].server) {
-			struct afs_cb_interest *cbi = old->servers[i].cb_interest;
-			if (cbi) {
-				new->servers[j].cb_interest = cbi;
-				refcount_inc(&cbi->usage);
-			}
-			i++;
-			j++;
-			continue;
-		}
-
-		if (new->servers[j].server < old->servers[i].server) {
-			j++;
-			continue;
-		}
-
-		i++;
-		continue;
-	}
-
 	return true;
 }
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 45e937dcb80a..c77b11b31233 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -485,6 +485,7 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 			goto error;
 	} else {
 		sb->s_d_op = &afs_fs_dentry_operations;
+		rcu_assign_pointer(as->volume->sb, sb);
 	}
 
 	_leave(" = 0");
@@ -529,7 +530,6 @@ static void afs_destroy_sbi(struct afs_super_info *as)
 static void afs_kill_super(struct super_block *sb)
 {
 	struct afs_super_info *as = AFS_FS_S(sb);
-	struct afs_net *net = afs_net(as->net_ns);
 
 	if (as->dyn_root)
 		afs_dynroot_depopulate(sb);
@@ -538,7 +538,7 @@ static void afs_kill_super(struct super_block *sb)
 	 * deactivating the superblock.
 	 */
 	if (as->volume)
-		afs_clear_callback_interests(net, as->volume->servers);
+		rcu_assign_pointer(as->volume->sb, NULL);
 	kill_anon_super(sb);
 	if (as->volume)
 		afs_deactivate_volume(as->volume);
@@ -688,7 +688,6 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 	vnode->volume		= NULL;
 	vnode->lock_key		= NULL;
 	vnode->permit_cache	= NULL;
-	RCU_INIT_POINTER(vnode->cb_interest, NULL);
 #ifdef CONFIG_AFS_FSCACHE
 	vnode->cache		= NULL;
 #endif
@@ -718,8 +717,6 @@ static void afs_destroy_inode(struct inode *inode)
 
 	_debug("DESTROY INODE %p", inode);
 
-	ASSERTCMP(rcu_access_pointer(vnode->cb_interest), ==, NULL);
-
 	atomic_dec(&afs_count_active_inodes);
 }
 
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 1cf9584bb51d..6c1cf702478e 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -189,13 +189,13 @@ static int afs_query_for_alias_one(struct afs_cell *cell, struct key *key,
 	struct afs_volume *volume, *pvol = NULL;
 	int ret;
 
-	/* Arbitrarily pick the first volume in the list. */
-	read_lock(&p->proc_lock);
-	if (!list_empty(&p->proc_volumes))
-		pvol = afs_get_volume(list_first_entry(&p->proc_volumes,
-						       struct afs_volume, proc_link),
+	/* Arbitrarily pick a volume from the list. */
+	read_seqlock_excl(&p->volume_lock);
+	if (!RB_EMPTY_ROOT(&p->volumes))
+		pvol = afs_get_volume(rb_entry(p->volumes.rb_node,
+					       struct afs_volume, cell_node),
 				      afs_volume_trace_get_query_alias);
-	read_unlock(&p->proc_lock);
+	read_sequnlock_excl(&p->volume_lock);
 	if (!pvol)
 		return 0;
 
@@ -242,7 +242,7 @@ static int afs_query_for_alias(struct afs_cell *cell, struct key *key)
 	hlist_for_each_entry(p, &cell->net->proc_cells, proc_link) {
 		if (p == cell || p->alias_of)
 			continue;
-		if (list_empty(&p->proc_volumes))
+		if (RB_EMPTY_ROOT(&p->volumes))
 			continue;
 		if (p->root_volume)
 			continue; /* Ignore cells that have a root.cell volume. */
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 461774d8a50e..bc1bf24959ac 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -12,6 +12,56 @@
 unsigned __read_mostly afs_volume_gc_delay = 10;
 unsigned __read_mostly afs_volume_record_life = 60 * 60;
 
+/*
+ * Insert a volume into a cell.  If there's an existing volume record, that is
+ * returned instead with a ref held.
+ */
+static struct afs_volume *afs_insert_volume_into_cell(struct afs_cell *cell,
+						      struct afs_volume *volume)
+{
+	struct afs_volume *p;
+	struct rb_node *parent = NULL, **pp;
+
+	write_seqlock(&cell->volume_lock);
+
+	pp = &cell->volumes.rb_node;
+	while (*pp) {
+		parent = *pp;
+		p = rb_entry(parent, struct afs_volume, cell_node);
+		if (p->vid < volume->vid) {
+			pp = &(*pp)->rb_left;
+		} else if (p->vid > volume->vid) {
+			pp = &(*pp)->rb_right;
+		} else {
+			volume = afs_get_volume(p, afs_volume_trace_get_cell_insert);
+			goto found;
+		}
+	}
+
+	rb_link_node_rcu(&volume->cell_node, parent, pp);
+	rb_insert_color(&volume->cell_node, &cell->volumes);
+	hlist_add_head_rcu(&volume->proc_link, &cell->proc_volumes);
+
+found:
+	write_sequnlock(&cell->volume_lock);
+	return volume;
+
+}
+
+static void afs_remove_volume_from_cell(struct afs_volume *volume)
+{
+	struct afs_cell *cell = volume->cell;
+
+	if (!hlist_unhashed(&volume->proc_link)) {
+		trace_afs_volume(volume->vid, atomic_read(&volume->usage),
+				 afs_volume_trace_remove);
+		write_seqlock(&cell->volume_lock);
+		hlist_del_rcu(&volume->proc_link);
+		rb_erase(&volume->cell_node, &cell->volumes);
+		write_sequnlock(&cell->volume_lock);
+	}
+}
+
 /*
  * Allocate a volume record and load it up from a vldb record.
  */
@@ -39,7 +89,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 	volume->name_len	= vldb->name_len;
 
 	atomic_set(&volume->usage, 1);
-	INIT_LIST_HEAD(&volume->proc_link);
+	INIT_HLIST_NODE(&volume->proc_link);
 	rwlock_init(&volume->servers_lock);
 	rwlock_init(&volume->cb_v_break_lock);
 	memcpy(volume->name, vldb->name, vldb->name_len + 1);
@@ -62,6 +112,25 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 	return ERR_PTR(ret);
 }
 
+/*
+ * Look up or allocate a volume record.
+ */
+static struct afs_volume *afs_lookup_volume(struct afs_fs_context *params,
+					    struct afs_vldb_entry *vldb,
+					    unsigned long type_mask)
+{
+	struct afs_volume *candidate, *volume;
+
+	candidate = afs_alloc_volume(params, vldb, type_mask);
+	if (IS_ERR(candidate))
+		return candidate;
+
+	volume = afs_insert_volume_into_cell(params->cell, candidate);
+	if (volume != candidate)
+		afs_put_volume(params->net, candidate, afs_volume_trace_put_cell_dup);
+	return volume;
+}
+
 /*
  * Look up a VLDB record for a volume.
  */
@@ -139,7 +208,7 @@ struct afs_volume *afs_create_volume(struct afs_fs_context *params)
 	}
 
 	type_mask = 1UL << params->type;
-	volume = afs_alloc_volume(params, vldb, type_mask);
+	volume = afs_lookup_volume(params, vldb, type_mask);
 
 error:
 	kfree(vldb);
@@ -157,11 +226,12 @@ static void afs_destroy_volume(struct afs_net *net, struct afs_volume *volume)
 	ASSERTCMP(volume->cache, ==, NULL);
 #endif
 
+	afs_remove_volume_from_cell(volume);
 	afs_put_serverlist(net, volume->servers);
 	afs_put_cell(net, volume->cell);
 	trace_afs_volume(volume->vid, atomic_read(&volume->usage),
 			 afs_volume_trace_free);
-	kfree(volume);
+	kfree_rcu(volume, rcu);
 
 	_leave(" [destroyed]");
 }
@@ -207,10 +277,6 @@ void afs_activate_volume(struct afs_volume *volume)
 					       NULL, 0,
 					       volume, 0, true);
 #endif
-
-	write_lock(&volume->cell->proc_lock);
-	list_add_tail(&volume->proc_link, &volume->cell->proc_volumes);
-	write_unlock(&volume->cell->proc_lock);
 }
 
 /*
@@ -220,10 +286,6 @@ void afs_deactivate_volume(struct afs_volume *volume)
 {
 	_enter("%s", volume->name);
 
-	write_lock(&volume->cell->proc_lock);
-	list_del_init(&volume->proc_link);
-	write_unlock(&volume->cell->proc_lock);
-
 #ifdef CONFIG_AFS_FSCACHE
 	fscache_relinquish_cookie(volume->cache, NULL,
 				  test_bit(AFS_VOLUME_DELETED, &volume->flags));
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index d0cd112a3720..b0a6e40b4da3 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -854,7 +854,7 @@ void yfs_fs_remove_file(struct afs_operation *op)
 
 	_enter("");
 
-	if (!test_bit(AFS_SERVER_FL_NO_RM2, &op->cbi->server->flags))
+	if (!test_bit(AFS_SERVER_FL_NO_RM2, &op->server->flags))
 		return yfs_fs_remove_file2(op);
 
 	call = afs_alloc_flat_call(op->net, &yfs_RXYFSRemoveFile,


