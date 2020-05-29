Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31C91E8AC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgE2WC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:02:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728071AbgE2WCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYUG0QHqUZoBm738eIYpzn5pIqCAwJ6uYBkEXmQFfao=;
        b=b6xM7EkB0cAZjP+844ph4MrsshsARYXnaHIU6aitM7dfgR8dyDNw2oh4xW+JuY3mM1V5AD
        0E/3e6xhPT3pZl6zPI7IU6HS1PJQ6wDsmpU/8pKM8yyq/xpjEtD0XE86ByY3L+M3uQYRZh
        +x5SH2JZbNvsLqdGQhdyQdGJzUeu6jE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-QfLeoR4KPamCMuAJ386I_A-1; Fri, 29 May 2020 18:02:18 -0400
X-MC-Unique: QfLeoR4KPamCMuAJ386I_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A64980B723;
        Fri, 29 May 2020 22:02:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCB29A2947;
        Fri, 29 May 2020 22:02:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/27] afs: Detect cell aliases 1 - Cells with root volumes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Jeffrey Altman <jaltman@auristor.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:02:15 +0100
Message-ID: <159078973503.679399.3701716594246594498.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Put in the first phase of cell alias detection.  This part handles alias
detection for cells that have root.cell volumes (which is expected to be
likely).

When a cell becomes newly active, it is probed for its root.cell volume,
and if it has one, this volume is compared against other root.cell volumes
to find out if the list of fileserver UUIDs have any in common - and if
that's the case, do the address lists of those fileservers have any
addresses in common.  If they do, the new cell is adjudged to be an alias
of the old cell and the old cell is used instead.

Comparing is aided by the server list in struct afs_server_list being
sorted in UUID order and the addresses in the fileserver address lists
being sorted in address order.

The cell then retains the afs_volume object for the root.cell volume, even
if it's not mounted for future alias checking.

This necessary because:

 (1) Whilst fileservers have UUIDs that are meant to be globally unique, in
     practice they are not because cells get cloned without changing the
     UUIDs - so afs_server records need to be per cell.

 (2) Sometimes the DNS is used to make cell aliases - but if we don't know
     they're the same, we may end up with multiple superblocks and multiple
     afs_server records for the same thing, impairing our ability to
     deliver callback notifications of third party changes

 (3) The fileserver RPC API doesn't contain the cell name, so it can't tell
     us which cell it's notifying and can't see that a change made to to
     one cell should notify the same client that's also accessed as the
     other cell.

Reported-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/Makefile   |    1 
 fs/afs/cell.c     |    3 +
 fs/afs/internal.h |   17 +++-
 fs/afs/main.c     |    1 
 fs/afs/proc.c     |    5 +
 fs/afs/super.c    |   18 ++++
 fs/afs/vl_alias.c |  235 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/volume.c   |    7 +-
 8 files changed, 279 insertions(+), 8 deletions(-)
 create mode 100644 fs/afs/vl_alias.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index 924f02e9d7e7..75c4e4043d1d 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -31,6 +31,7 @@ kafs-y := \
 	server_list.o \
 	super.o \
 	vlclient.o \
+	vl_alias.o \
 	vl_list.o \
 	vl_probe.o \
 	vl_rotate.o \
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 78ba5f932287..212098514ebf 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -164,6 +164,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	INIT_LIST_HEAD(&cell->proc_volumes);
 	rwlock_init(&cell->proc_lock);
 	rwlock_init(&cell->vl_servers_lock);
+	cell->flags = (1 << AFS_CELL_FL_CHECK_ALIAS);
 
 	/* Provide a VL server list, filling it in if we were given a list of
 	 * addresses to use.
@@ -481,7 +482,9 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 
 	ASSERTCMP(atomic_read(&cell->usage), ==, 0);
 
+	afs_put_volume(cell->net, cell->root_volume);
 	afs_put_vlserverlist(cell->net, rcu_access_pointer(cell->vl_servers));
+	afs_put_cell(cell->net, cell->alias_of);
 	key_put(cell->anonymous_key);
 	kfree(cell);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 3606cfa50832..a3ef97d560ca 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -269,6 +269,7 @@ struct afs_net {
 	struct timer_list	cells_timer;
 	atomic_t		cells_outstanding;
 	seqlock_t		cells_lock;
+	struct mutex		cells_alias_lock;
 
 	struct mutex		proc_cells_lock;
 	struct hlist_head	proc_cells;
@@ -342,8 +343,10 @@ enum afs_cell_state {
  * for authentication and encryption.  The cell name is not typically used in
  * the protocol.
  *
- * There is no easy way to determine if two cells are aliases or one is a
- * subset of another.
+ * Two cells are determined to be aliases if they have an explicit alias (YFS
+ * only), share any VL servers in common or have at least one volume in common.
+ * "In common" means that the address list of the VL servers or the fileservers
+ * share at least one endpoint.
  */
 struct afs_cell {
 	union {
@@ -351,6 +354,8 @@ struct afs_cell {
 		struct rb_node	net_node;	/* Node in net->cells */
 	};
 	struct afs_net		*net;
+	struct afs_cell		*alias_of;	/* The cell this is an alias of */
+	struct afs_volume	*root_volume;	/* The root.cell volume if there is one */
 	struct key		*anonymous_key;	/* anonymous user key for this cell */
 	struct work_struct	manager;	/* Manager for init/deinit/dns */
 	struct hlist_node	proc_link;	/* /proc cell list link */
@@ -363,6 +368,7 @@ struct afs_cell {
 	unsigned long		flags;
 #define AFS_CELL_FL_NO_GC	0		/* The cell was added manually, don't auto-gc */
 #define AFS_CELL_FL_DO_LOOKUP	1		/* DNS lookup requested */
+#define AFS_CELL_FL_CHECK_ALIAS	2		/* Need to check for aliases */
 	enum afs_cell_state	state;
 	short			error;
 	enum dns_record_source	dns_source:8;	/* Latest source of data from lookup */
@@ -584,7 +590,7 @@ struct afs_volume {
 #ifdef CONFIG_AFS_FSCACHE
 	struct fscache_cookie	*cache;		/* caching cookie */
 #endif
-	struct afs_server_list	*servers;	/* List of servers on which volume resides */
+	struct afs_server_list __rcu *servers;	/* List of servers on which volume resides */
 	rwlock_t		servers_lock;	/* Lock for ->servers */
 	unsigned int		servers_seq;	/* Incremented each time ->servers changes */
 
@@ -1376,6 +1382,11 @@ extern struct afs_call *afs_vl_get_capabilities(struct afs_net *, struct afs_add
 extern struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *, const uuid_t *);
 extern char *afs_yfsvl_get_cell_name(struct afs_vl_cursor *);
 
+/*
+ * vl_alias.c
+ */
+extern int afs_cell_detect_alias(struct afs_cell *, struct key *);
+
 /*
  * vl_probe.c
  */
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 56b52f8dbf15..9c79c91e8005 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -82,6 +82,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 	INIT_WORK(&net->cells_manager, afs_manage_cells);
 	timer_setup(&net->cells_timer, afs_cells_timer, 0);
 
+	mutex_init(&net->cells_alias_lock);
 	mutex_init(&net->proc_cells_lock);
 	INIT_HLIST_HEAD(&net->proc_cells);
 
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 1d21465a4108..256c3eff8c82 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -38,7 +38,7 @@ static int afs_proc_cells_show(struct seq_file *m, void *v)
 
 	if (v == SEQ_START_TOKEN) {
 		/* display header on line 1 */
-		seq_puts(m, "USE    TTL SV NAME\n");
+		seq_puts(m, "USE    TTL SV ST NAME\n");
 		return 0;
 	}
 
@@ -46,10 +46,11 @@ static int afs_proc_cells_show(struct seq_file *m, void *v)
 	vllist = rcu_dereference(cell->vl_servers);
 
 	/* display one cell per line on subsequent lines */
-	seq_printf(m, "%3u %6lld %2u %s\n",
+	seq_printf(m, "%3u %6lld %2u %2u %s\n",
 		   atomic_read(&cell->usage),
 		   cell->dns_expiry - ktime_get_real_seconds(),
 		   vllist->nr_servers,
+		   cell->state,
 		   cell->name);
 	return 0;
 }
diff --git a/fs/afs/super.c b/fs/afs/super.c
index c4bb314a22ae..1bb69159956f 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -352,7 +352,9 @@ static int afs_validate_fc(struct fs_context *fc)
 {
 	struct afs_fs_context *ctx = fc->fs_private;
 	struct afs_volume *volume;
+	struct afs_cell *cell;
 	struct key *key;
+	int ret;
 
 	if (!ctx->dyn_root) {
 		if (ctx->no_cell) {
@@ -365,6 +367,7 @@ static int afs_validate_fc(struct fs_context *fc)
 			return -EDESTADDRREQ;
 		}
 
+	reget_key:
 		/* We try to do the mount securely. */
 		key = afs_request_key(ctx->cell);
 		if (IS_ERR(key))
@@ -377,6 +380,21 @@ static int afs_validate_fc(struct fs_context *fc)
 			ctx->volume = NULL;
 		}
 
+		if (test_bit(AFS_CELL_FL_CHECK_ALIAS, &ctx->cell->flags)) {
+			ret = afs_cell_detect_alias(ctx->cell, key);
+			if (ret < 0)
+				return ret;
+			if (ret == 1) {
+				_debug("switch to alias");
+				key_put(ctx->key);
+				ctx->key = NULL;
+				cell = afs_get_cell(ctx->cell->alias_of);
+				afs_put_cell(ctx->net, ctx->cell);
+				ctx->cell = cell;
+				goto reget_key;
+			}
+		}
+
 		volume = afs_create_volume(ctx);
 		if (IS_ERR(volume))
 			return PTR_ERR(volume);
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
new file mode 100644
index 000000000000..d1d91a25fbe0
--- /dev/null
+++ b/fs/afs/vl_alias.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* AFS cell alias detection
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/namei.h>
+#include <keys/rxrpc-type.h>
+#include "internal.h"
+
+/*
+ * Sample a volume.
+ */
+static struct afs_volume *afs_sample_volume(struct afs_cell *cell, struct key *key,
+					    const char *name, unsigned int namelen)
+{
+	struct afs_volume *volume;
+	struct afs_fs_context fc = {
+		.type		= 0, /* Explicitly leave it to the VLDB */
+		.volnamesz	= namelen,
+		.volname	= name,
+		.net		= cell->net,
+		.cell		= cell,
+		.key		= key, /* This might need to be something */
+	};
+
+	volume = afs_create_volume(&fc);
+	_leave(" = %px", volume);
+	return volume;
+}
+
+/*
+ * Compare two addresses.
+ */
+static int afs_compare_addrs(const struct sockaddr_rxrpc *srx_a,
+			     const struct sockaddr_rxrpc *srx_b)
+{
+	short port_a, port_b;
+	int addr_a, addr_b, diff;
+
+	diff = (short)srx_a->transport_type - (short)srx_b->transport_type;
+	if (diff)
+		goto out;
+
+	switch (srx_a->transport_type) {
+	case AF_INET: {
+		const struct sockaddr_in *a = &srx_a->transport.sin;
+		const struct sockaddr_in *b = &srx_b->transport.sin;
+		addr_a = ntohl(a->sin_addr.s_addr);
+		addr_b = ntohl(b->sin_addr.s_addr);
+		diff = addr_a - addr_b;
+		if (diff == 0) {
+			port_a = ntohs(a->sin_port);
+			port_b = ntohs(b->sin_port);
+			diff = port_a - port_b;
+		}
+		break;
+	}
+
+	case AF_INET6: {
+		const struct sockaddr_in6 *a = &srx_a->transport.sin6;
+		const struct sockaddr_in6 *b = &srx_b->transport.sin6;
+		diff = memcmp(&a->sin6_addr, &b->sin6_addr, 16);
+		if (diff == 0) {
+			port_a = ntohs(a->sin6_port);
+			port_b = ntohs(b->sin6_port);
+			diff = port_a - port_b;
+		}
+		break;
+	}
+
+	default:
+		BUG();
+	}
+
+out:
+	return diff;
+}
+
+/*
+ * Compare the address lists of a pair of fileservers.
+ */
+static int afs_compare_fs_alists(const struct afs_server *server_a,
+				 const struct afs_server *server_b)
+{
+	const struct afs_addr_list *la, *lb;
+	int a = 0, b = 0, addr_matches = 0;
+
+	la = rcu_dereference(server_a->addresses);
+	lb = rcu_dereference(server_b->addresses);
+
+	while (a < la->nr_addrs && b < lb->nr_addrs) {
+		const struct sockaddr_rxrpc *srx_a = &la->addrs[a];
+		const struct sockaddr_rxrpc *srx_b = &lb->addrs[b];
+		int diff = afs_compare_addrs(srx_a, srx_b);
+
+		if (diff < 0) {
+			a++;
+		} else if (diff > 0) {
+			b++;
+		} else {
+			addr_matches++;
+			a++;
+			b++;
+		}
+	}
+
+	return addr_matches;
+}
+
+/*
+ * Compare the fileserver lists of two volumes.  The server lists are sorted in
+ * order of ascending UUID.
+ */
+static int afs_compare_volume_slists(const struct afs_volume *vol_a,
+				     const struct afs_volume *vol_b)
+{
+	const struct afs_server_list *la, *lb;
+	int i, a = 0, b = 0, uuid_matches = 0, addr_matches = 0;
+
+	la = rcu_dereference(vol_a->servers);
+	lb = rcu_dereference(vol_b->servers);
+
+	for (i = 0; i < AFS_MAXTYPES; i++)
+		if (la->vids[i] != lb->vids[i])
+			return 0;
+
+	while (a < la->nr_servers && b < lb->nr_servers) {
+		const struct afs_server *server_a = la->servers[a].server;
+		const struct afs_server *server_b = lb->servers[b].server;
+		int diff = memcmp(&server_a->uuid, &server_b->uuid, sizeof(uuid_t));
+
+		if (diff < 0) {
+			a++;
+		} else if (diff > 0) {
+			b++;
+		} else {
+			uuid_matches++;
+			addr_matches += afs_compare_fs_alists(server_a, server_b);
+			a++;
+			b++;
+		}
+	}
+
+	_leave(" = %d [um %d]", addr_matches, uuid_matches);
+	return addr_matches;
+}
+
+/*
+ * Compare root.cell volumes.
+ */
+static int afs_compare_cell_roots(struct afs_cell *cell)
+{
+	struct afs_cell *p;
+
+	_enter("");
+
+	rcu_read_lock();
+
+	hlist_for_each_entry_rcu(p, &cell->net->proc_cells, proc_link) {
+		if (p == cell || p->alias_of)
+			continue;
+		if (!p->root_volume)
+			continue; /* Ignore cells that don't have a root.cell volume. */
+
+		if (afs_compare_volume_slists(cell->root_volume, p->root_volume) != 0)
+			goto is_alias;
+	}
+
+	rcu_read_unlock();
+	_leave(" = 0");
+	return 0;
+
+is_alias:
+	rcu_read_unlock();
+	cell->alias_of = afs_get_cell(p);
+	return 1;
+}
+
+static int afs_do_cell_detect_alias(struct afs_cell *cell, struct key *key)
+{
+	struct afs_volume *root_volume;
+
+	_enter("%s", cell->name);
+
+	/* Try and get the root.cell volume for comparison with other cells */
+	root_volume = afs_sample_volume(cell, key, "root.cell", 9);
+	if (!IS_ERR(root_volume)) {
+		cell->root_volume = root_volume;
+		return afs_compare_cell_roots(cell);
+	}
+
+	if (PTR_ERR(root_volume) != -ENOMEDIUM)
+		return PTR_ERR(root_volume);
+
+	/* Okay, this cell doesn't have an root.cell volume.  We need to
+	 * locate some other random volume and use that to check.
+	 */
+	return -ENOMEDIUM;
+}
+
+/*
+ * Check to see if a new cell is an alias of a cell we already have.  At this
+ * point we have the cell's volume server list.
+ *
+ * Returns 0 if we didn't detect an alias, 1 if we found an alias and an error
+ * if we had problems gathering the data required.  In the case the we did
+ * detect an alias, cell->alias_of is set to point to the assumed master.
+ */
+int afs_cell_detect_alias(struct afs_cell *cell, struct key *key)
+{
+	struct afs_net *net = cell->net;
+	int ret;
+
+	if (mutex_lock_interruptible(&net->cells_alias_lock) < 0)
+		return -ERESTARTSYS;
+
+	if (test_bit(AFS_CELL_FL_CHECK_ALIAS, &cell->flags)) {
+		ret = afs_do_cell_detect_alias(cell, key);
+		if (ret >= 0)
+			clear_bit_unlock(AFS_CELL_FL_CHECK_ALIAS, &cell->flags);
+	} else {
+		ret = cell->alias_of ? 1 : 0;
+	}
+
+	mutex_unlock(&net->cells_alias_lock);
+
+	if (ret == 1)
+		pr_notice("kAFS: Cell %s is an alias of %s\n",
+			  cell->name, cell->alias_of->name);
+	return ret;
+}
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 57d0509f7353..bb8a2e072427 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -51,7 +51,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 	}
 
 	refcount_set(&slist->usage, 1);
-	volume->servers = slist;
+	rcu_assign_pointer(volume->servers, slist);
 	return volume;
 
 error_1:
@@ -256,10 +256,11 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 	write_lock(&volume->servers_lock);
 
 	discard = new;
-	old = volume->servers;
+	old = rcu_dereference_protected(volume->servers,
+					lockdep_is_held(&volume->servers_lock));
 	if (afs_annotate_server_list(new, old)) {
 		new->seq = volume->servers_seq + 1;
-		volume->servers = new;
+		rcu_assign_pointer(volume->servers, new);
 		smp_wmb();
 		volume->servers_seq++;
 		discard = old;


