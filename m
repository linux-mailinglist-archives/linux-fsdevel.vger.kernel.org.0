Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729651E8ADB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgE2WDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:03:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728767AbgE2WC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xI9YKh9W57g2cv/4iePFsdmaxAiWLoBNBJ9/boptkdM=;
        b=LJxhMGqbqnMhwo7a0Z+uSeRWjE5XVtzV9zm/UbZftYCKrU5qCj0+qQj3wqkuadCrPguOSL
        rOQ10l9gs1t+0SdWg+IGLzXcNC1SoIuS7hQVX5ol42SGJU+odOkcps5QWS7pox3pV/cKkJ
        JLiZLr6kd+y8Zbdtsok2wfbPOYzECWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-YiNSQ-_eN8GaszSTaOp5dw-1; Fri, 29 May 2020 18:02:54 -0400
X-MC-Unique: YiNSQ-_eN8GaszSTaOp5dw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9153C107ACCA;
        Fri, 29 May 2020 22:02:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 895E95D9D7;
        Fri, 29 May 2020 22:02:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/27] afs: Fix the by-UUID server tree to allow servers with
 the same UUID
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Jeffrey Altman <jaltman@auristor.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:02:50 +0100
Message-ID: <159078977077.679399.159019304395285864.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Whilst it shouldn't happen, it is possible for multiple fileservers to
share a UUID, particularly if an entire cell has been duplicated, UUIDs and
all.  In such a case, it's not necessarily possible to map the effect of
the CB.InitCallBackState3 incoming RPC to a specific server unambiguously
by UUID and thus to a specific cell.

Indeed, there's a problem whereby multiple server records may need to
occupy the same spot in the rb_tree rooted in the afs_net struct.

Fix this by allowing servers to form a list, with the head of the list in
the tree.  When the front entry in the list is removed, the second in the
list just replaces it.  afs_init_callback_state() then just goes down the
line, poking each server in the list.

This means that some servers will be unnecessarily poked, unfortunately.
An alternative would be to route by call parameters.

Reported-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
---

 fs/afs/callback.c |   10 ++++++++-
 fs/afs/internal.h |    4 +++-
 fs/afs/server.c   |   56 +++++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index b4cb9bb63f0a..7d9b23d981bf 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -21,11 +21,17 @@
 #include "internal.h"
 
 /*
- * allow the fileserver to request callback state (re-)initialisation
+ * Allow the fileserver to request callback state (re-)initialisation.
+ * Unfortunately, UUIDs are not guaranteed unique.
  */
 void afs_init_callback_state(struct afs_server *server)
 {
-	server->cb_s_break++;
+	rcu_read_lock();
+	do {
+		server->cb_s_break++;
+		server = rcu_dereference(server->uuid_next);
+	} while (0);
+	rcu_read_unlock();
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c64c2b47ece7..e0dc14d4d8b9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -486,7 +486,9 @@ struct afs_server {
 
 	struct afs_addr_list	__rcu *addresses;
 	struct afs_cell		*cell;		/* Cell to which belongs (pins ref) */
-	struct rb_node		uuid_rb;	/* Link in cell->fs_servers */
+	struct rb_node		uuid_rb;	/* Link in net->fs_servers */
+	struct afs_server __rcu	*uuid_next;	/* Next server with same UUID */
+	struct afs_server	*uuid_prev;	/* Previous server with same UUID */
 	struct list_head	probe_link;	/* Link in net->fs_probe_list */
 	struct hlist_node	addr4_link;	/* Link in net->fs_addresses4 */
 	struct hlist_node	addr6_link;	/* Link in net->fs_addresses6 */
diff --git a/fs/afs/server.c b/fs/afs/server.c
index c51039a077cd..88593ffcb54e 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -130,13 +130,15 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 }
 
 /*
- * Install a server record in the namespace tree
+ * Install a server record in the namespace tree.  If there's a clash, we stick
+ * it into a list anchored on whichever afs_server struct is actually in the
+ * tree.
  */
 static struct afs_server *afs_install_server(struct afs_cell *cell,
 					     struct afs_server *candidate)
 {
 	const struct afs_addr_list *alist;
-	struct afs_server *server;
+	struct afs_server *server, *next;
 	struct afs_net *net = cell->net;
 	struct rb_node **pp, *p;
 	int diff;
@@ -153,12 +155,30 @@ static struct afs_server *afs_install_server(struct afs_cell *cell,
 		_debug("- consider %p", p);
 		server = rb_entry(p, struct afs_server, uuid_rb);
 		diff = memcmp(&candidate->uuid, &server->uuid, sizeof(uuid_t));
-		if (diff < 0)
+		if (diff < 0) {
 			pp = &(*pp)->rb_left;
-		else if (diff > 0)
+		} else if (diff > 0) {
 			pp = &(*pp)->rb_right;
-		else
-			goto exists;
+		} else {
+			if (server->cell == cell)
+				goto exists;
+
+			/* We have the same UUID representing servers in
+			 * different cells.  Append the new server to the list.
+			 */
+			for (;;) {
+				next = rcu_dereference_protected(
+					server->uuid_next,
+					lockdep_is_held(&net->fs_lock.lock));
+				if (!next)
+					break;
+				server = next;
+			}
+			rcu_assign_pointer(server->uuid_next, candidate);
+			candidate->uuid_prev = server;
+			server = candidate;
+			goto added_dup;
+		}
 	}
 
 	server = candidate;
@@ -166,6 +186,7 @@ static struct afs_server *afs_install_server(struct afs_cell *cell,
 	rb_insert_color(&server->uuid_rb, &net->fs_servers);
 	hlist_add_head_rcu(&server->proc_link, &net->fs_proc);
 
+added_dup:
 	write_seqlock(&net->fs_addr_lock);
 	alist = rcu_dereference_protected(server->addresses,
 					  lockdep_is_held(&net->fs_addr_lock.lock));
@@ -453,7 +474,7 @@ static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
  */
 static void afs_gc_servers(struct afs_net *net, struct afs_server *gc_list)
 {
-	struct afs_server *server;
+	struct afs_server *server, *next, *prev;
 	int active;
 
 	while ((server = gc_list)) {
@@ -465,7 +486,26 @@ static void afs_gc_servers(struct afs_net *net, struct afs_server *gc_list)
 		if (active == 0) {
 			trace_afs_server(server, atomic_read(&server->ref),
 					 active, afs_server_trace_gc);
-			rb_erase(&server->uuid_rb, &net->fs_servers);
+			next = rcu_dereference_protected(
+				server->uuid_next, lockdep_is_held(&net->fs_lock.lock));
+			prev = server->uuid_prev;
+			if (!prev) {
+				/* The one at the front is in the tree */
+				if (!next) {
+					rb_erase(&server->uuid_rb, &net->fs_servers);
+				} else {
+					rb_replace_node_rcu(&server->uuid_rb,
+							    &next->uuid_rb,
+							    &net->fs_servers);
+					next->uuid_prev = NULL;
+				}
+			} else {
+				/* This server is not at the front */
+				rcu_assign_pointer(prev->uuid_next, next);
+				if (next)
+					next->uuid_prev = prev;
+			}
+
 			list_del(&server->probe_link);
 			hlist_del_rcu(&server->proc_link);
 			if (!hlist_unhashed(&server->addr4_link))


