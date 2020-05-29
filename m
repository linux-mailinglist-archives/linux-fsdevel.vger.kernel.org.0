Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5938F1E8AA9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgE2WBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:01:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54072 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728526AbgE2WBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fH6vfFjKBYbc/l2OkRzK7wI7NILRpeBI/oKNJsAi5KQ=;
        b=iFVgmBgT0si07VzheyoVBXpW31ta3GhQzk4gFbIo760g2isRZpQAH6XZPof9s6MQptqoUr
        iz5/UHYv+rL/Xkob0eyRxmfN6EA45eRx3V/N1WP5dAkXOxjbzxN74hbBltJ30XbHqsDkA4
        Co1ag3MACCIaPVavnVoSGP0rw28saD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-edruaMWYMo6RauRq383wYw-1; Fri, 29 May 2020 18:01:13 -0400
X-MC-Unique: edruaMWYMo6RauRq383wYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F64C1005510;
        Fri, 29 May 2020 22:01:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5E4810013D4;
        Fri, 29 May 2020 22:01:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/27] afs: Make callback processing more efficient.
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:01:10 +0100
Message-ID: <159078967097.679399.13471090664845334315.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

afs_vol_interest objects represent the volume IDs currently being accessed
from a fileserver.  These hold lists of afs_cb_interest objects that
repesent the superblocks using that volume ID on that server.

When a callback notification from the server telling of a modification by
another client arrives, the volume ID specified in the notification is
looked up in the server's afs_vol_interest list.  Through the
afs_cb_interest list, the relevant superblocks can be iterated over and the
specific inode looked up and marked in each one.

Make the following efficiency improvements:

 (1) Hold rcu_read_lock() over the entire processing rather than locking it
     each time.

 (2) Do all the callbacks for each vid together rather than individually.
     Each volume then only needs to be looked up once.

 (3) afs_vol_interest objects are now stored in an rb_tree rather than a
     flat list to reduce the lookup step count.

 (4) afs_vol_interest lookup is now done with RCU, but because it's in an
     rb_tree which may rotate under us, a seqlock is used so that if it
     changes during the walk, we repeat the walk with a lock held.

With this and the preceding patch which adds RCU-based lookups in the inode
cache, target volumes/vnodes can be taken without the need to take any
locks, except on the target itself.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/callback.c |  150 ++++++++++++++++++++++++++++++++++-------------------
 fs/afs/internal.h |    6 +-
 fs/afs/server.c   |    4 +
 3 files changed, 100 insertions(+), 60 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 0dcbd40732d1..b16781e1683e 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -28,7 +28,7 @@ static struct afs_cb_interest *afs_create_interest(struct afs_server *server,
 {
 	struct afs_vol_interest *new_vi, *vi;
 	struct afs_cb_interest *new;
-	struct hlist_node **pp;
+	struct rb_node *parent, **pp;
 
 	new_vi = kzalloc(sizeof(struct afs_vol_interest), GFP_KERNEL);
 	if (!new_vi)
@@ -42,7 +42,6 @@ static struct afs_cb_interest *afs_create_interest(struct afs_server *server,
 
 	new_vi->usage = 1;
 	new_vi->vid = vnode->volume->vid;
-	INIT_HLIST_NODE(&new_vi->srv_link);
 	INIT_HLIST_HEAD(&new_vi->cb_interests);
 
 	refcount_set(&new->usage, 1);
@@ -51,31 +50,31 @@ static struct afs_cb_interest *afs_create_interest(struct afs_server *server,
 	new->server = afs_get_server(server, afs_server_trace_get_new_cbi);
 	INIT_HLIST_NODE(&new->cb_vlink);
 
-	write_lock(&server->cb_break_lock);
+	write_seqlock(&server->cb_break_lock);
 
-	for (pp = &server->cb_volumes.first; *pp; pp = &(*pp)->next) {
-		vi = hlist_entry(*pp, struct afs_vol_interest, srv_link);
-		if (vi->vid < new_vi->vid)
-			continue;
-		if (vi->vid > new_vi->vid)
-			break;
-		vi->usage++;
-		goto found_vi;
+	pp = &server->cb_volumes.rb_node;
+	while ((parent = *pp)) {
+		vi = rb_entry(parent, struct afs_vol_interest, srv_node);
+		if (vi->vid < new_vi->vid) {
+			pp = &(*pp)->rb_left;
+		} else if (vi->vid > new_vi->vid) {
+			pp = &(*pp)->rb_right;
+		} else {
+			vi->usage++;
+			goto found_vi;
+		}
 	}
 
-	new_vi->srv_link.pprev = pp;
-	new_vi->srv_link.next = *pp;
-	if (*pp)
-		(*pp)->pprev = &new_vi->srv_link.next;
-	*pp = &new_vi->srv_link;
 	vi = new_vi;
 	new_vi = NULL;
-found_vi:
+	rb_link_node_rcu(&vi->srv_node, parent, pp);
+	rb_insert_color(&vi->srv_node, &server->cb_volumes);
 
+found_vi:
 	new->vol_interest = vi;
 	hlist_add_head(&new->cb_vlink, &vi->cb_interests);
 
-	write_unlock(&server->cb_break_lock);
+	write_sequnlock(&server->cb_break_lock);
 	kfree(new_vi);
 	return new;
 }
@@ -182,17 +181,17 @@ void afs_put_cb_interest(struct afs_net *net, struct afs_cb_interest *cbi)
 
 	if (cbi && refcount_dec_and_test(&cbi->usage)) {
 		if (!hlist_unhashed(&cbi->cb_vlink)) {
-			write_lock(&cbi->server->cb_break_lock);
+			write_seqlock(&cbi->server->cb_break_lock);
 
 			hlist_del_init(&cbi->cb_vlink);
 			vi = cbi->vol_interest;
 			cbi->vol_interest = NULL;
 			if (--vi->usage == 0)
-				hlist_del(&vi->srv_link);
+				rb_erase(&vi->srv_node, &cbi->server->cb_volumes);
 			else
 				vi = NULL;
 
-			write_unlock(&cbi->server->cb_break_lock);
+			write_sequnlock(&cbi->server->cb_break_lock);
 			if (vi)
 				kfree_rcu(vi, rcu);
 			afs_put_server(net, cbi->server, afs_server_trace_put_cbi);
@@ -237,6 +236,45 @@ void afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reason
 	write_sequnlock(&vnode->cb_lock);
 }
 
+/*
+ * Look up a volume interest by volume ID under RCU conditions.
+ */
+static struct afs_vol_interest *afs_lookup_vol_interest_rcu(struct afs_server *server,
+							    afs_volid_t vid)
+{
+	struct afs_vol_interest *vi = NULL;
+	struct rb_node *p;
+	int seq = 0;
+
+	do {
+		/* Unfortunately, rbtree walking doesn't give reliable results
+		 * under just the RCU read lock, so we have to check for
+		 * changes.
+		 */
+		read_seqbegin_or_lock(&server->cb_break_lock, &seq);
+
+		p = rcu_dereference_raw(server->cb_volumes.rb_node);
+		while (p) {
+			vi = rb_entry(p, struct afs_vol_interest, srv_node);
+
+			if (vi->vid < vid)
+				p = rcu_dereference_raw(p->rb_left);
+			else if (vi->vid > vid)
+				p = rcu_dereference_raw(p->rb_right);
+			else
+				break;
+			/* We want to repeat the search, this time with the
+			 * lock properly locked.
+			 */
+			vi = NULL;
+		}
+
+	} while (need_seqretry(&server->cb_break_lock, seq));
+
+	done_seqretry(&server->cb_break_lock, seq);
+	return vi;
+}
+
 /*
  * allow the fileserver to explicitly break one callback
  * - happens when
@@ -244,37 +282,18 @@ void afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reason
  *   - a lock is released
  */
 static void afs_break_one_callback(struct afs_server *server,
-				   struct afs_fid *fid)
+				   struct afs_fid *fid,
+				   struct afs_vol_interest *vi)
 {
-	struct afs_vol_interest *vi;
 	struct afs_cb_interest *cbi;
 	struct afs_iget_data data;
 	struct afs_vnode *vnode;
 	struct inode *inode;
 
-	rcu_read_lock();
-	read_lock(&server->cb_break_lock);
-	hlist_for_each_entry(vi, &server->cb_volumes, srv_link) {
-		if (vi->vid < fid->vid)
-			continue;
-		if (vi->vid > fid->vid) {
-			vi = NULL;
-			break;
-		}
-		//atomic_inc(&vi->usage);
-		break;
-	}
-
-	/* TODO: Find all matching volumes if we couldn't match the server and
-	 * break them anyway.
-	 */
-	if (!vi)
-		goto out;
-
 	/* Step through all interested superblocks.  There may be more than one
 	 * because of cell aliasing.
 	 */
-	hlist_for_each_entry(cbi, &vi->cb_interests, cb_vlink) {
+	hlist_for_each_entry_rcu(cbi, &vi->cb_interests, cb_vlink) {
 		if (fid->vnode == 0 && fid->unique == 0) {
 			/* The callback break applies to an entire volume. */
 			struct afs_super_info *as = AFS_FS_S(cbi->sb);
@@ -303,10 +322,36 @@ static void afs_break_one_callback(struct afs_server *server,
 			}
 		}
 	}
+}
 
-out:
-	read_unlock(&server->cb_break_lock);
-	rcu_read_unlock();
+static void afs_break_some_callbacks(struct afs_server *server,
+				     struct afs_callback_break *cbb,
+				     size_t *_count)
+{
+	struct afs_callback_break *residue = cbb;
+	struct afs_vol_interest *vi;
+	afs_volid_t vid = cbb->fid.vid;
+	size_t i;
+
+	vi = afs_lookup_vol_interest_rcu(server, vid);
+
+	/* TODO: Find all matching volumes if we couldn't match the server and
+	 * break them anyway.
+	 */
+
+	for (i = *_count; i > 0; cbb++, i--) {
+		if (cbb->fid.vid == vid) {
+			_debug("- Fid { vl=%08llx n=%llu u=%u }",
+			       cbb->fid.vid,
+			       cbb->fid.vnode,
+			       cbb->fid.unique);
+			--*_count;
+			if (vi)
+				afs_break_one_callback(server, &cbb->fid, vi);
+		} else {
+			*residue++ = *cbb;
+		}
+	}
 }
 
 /*
@@ -319,17 +364,12 @@ void afs_break_callbacks(struct afs_server *server, size_t count,
 
 	ASSERT(server != NULL);
 
-	/* TODO: Sort the callback break list by volume ID */
+	rcu_read_lock();
 
-	for (; count > 0; callbacks++, count--) {
-		_debug("- Fid { vl=%08llx n=%llu u=%u }",
-		       callbacks->fid.vid,
-		       callbacks->fid.vnode,
-		       callbacks->fid.unique);
-		afs_break_one_callback(server, &callbacks->fid);
-	}
+	while (count > 0)
+		afs_break_some_callbacks(server, callbacks, &count);
 
-	_leave("");
+	rcu_read_unlock();
 	return;
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 61320a632e15..b6665fc5d355 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -524,9 +524,9 @@ struct afs_server {
 	rwlock_t		fs_lock;	/* access lock */
 
 	/* callback promise management */
-	struct hlist_head	cb_volumes;	/* List of volume interests on this server */
+	struct rb_root		cb_volumes;	/* List of volume interests on this server */
 	unsigned		cb_s_break;	/* Break-everything counter. */
-	rwlock_t		cb_break_lock;	/* Volume finding lock */
+	seqlock_t		cb_break_lock;	/* Volume finding lock */
 
 	/* Probe state */
 	unsigned long		probed_at;	/* Time last probe was dispatched (jiffies) */
@@ -552,7 +552,7 @@ struct afs_server {
  * Volume collation in the server's callback interest list.
  */
 struct afs_vol_interest {
-	struct hlist_node	srv_link;	/* Link in server->cb_volumes */
+	struct rb_node		srv_node;	/* Link in server->cb_volumes */
 	struct hlist_head	cb_interests;	/* List of callback interests on the server */
 	union {
 		struct rcu_head	rcu;
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 3f707b5ecb62..5ed90f419c54 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -212,8 +212,8 @@ static struct afs_server *afs_alloc_server(struct afs_net *net,
 	server->addr_version = alist->version;
 	server->uuid = *uuid;
 	rwlock_init(&server->fs_lock);
-	INIT_HLIST_HEAD(&server->cb_volumes);
-	rwlock_init(&server->cb_break_lock);
+	server->cb_volumes = RB_ROOT;
+	seqlock_init(&server->cb_break_lock);
 	init_waitqueue_head(&server->probe_wq);
 	INIT_LIST_HEAD(&server->probe_link);
 	spin_lock_init(&server->probe_lock);


