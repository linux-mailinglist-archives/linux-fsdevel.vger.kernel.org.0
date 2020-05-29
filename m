Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48DB1E8A9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgE2WAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:00:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35590 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728478AbgE2WAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qimBB2xmnVi59x1tHnARNr6p8KEvNKSB6KsXrdB5h9k=;
        b=DxF3I5wQRlyOHrdxaX2JWDcPaYDQ/Euv3byZlgqgrKg6l3IM+aKmb+yY8VYWfwxTpNNuHH
        pRN8TM7DcPVfamptf4Bva1vQXiBNyg/SSCvo22INxWyXCETtZmtnqdbKGLIkjxvMyaUiM9
        FiYXzaxZh5TYYCWv46FgtWktHbBZDyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-z5C1OxfoPjWP-lWmOADs5A-1; Fri, 29 May 2020 18:00:45 -0400
X-MC-Unique: z5C1OxfoPjWP-lWmOADs5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45F171005510;
        Fri, 29 May 2020 22:00:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C3F05C1D0;
        Fri, 29 May 2020 22:00:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/27] afs: Use the serverUnique field in the UVLDB record to
 reduce rpc ops
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Jeffrey Altman <jaltman@auristor.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:00:42 +0100
Message-ID: <159078964223.679399.3725226162754750915.stgit@warthog.procyon.org.uk>
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

The U-version VLDB volume record retrieved by the VL.GetEntryByNameU rpc op
carries a change counter (the serverUnique field) for each fileserver
listed in the record as backing that volume.  This is incremented whenever
the registration details for a fileserver change (such as its address
list).  Note that the same value will be seen in all UVLDB records that
refer to that fileserver.

This should be checked before calling the VL server to re-query the address
list for a fileserver.  If it's the same, there's no point doing the query.

Reported-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h    |    5 +++--
 fs/afs/server.c      |   26 ++++++++++++++------------
 fs/afs/server_list.c |    3 ++-
 fs/afs/vlclient.c    |    1 +
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 80255513e230..ee17c868ad2c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -471,6 +471,7 @@ struct afs_vldb_entry {
 #define AFS_VLDB_QUERY_ERROR	4		/* - VL server returned error */
 
 	uuid_t			fs_server[AFS_NMAXNSERVERS];
+	u32			addr_version[AFS_NMAXNSERVERS]; /* Registration change counters */
 	u8			fs_mask[AFS_NMAXNSERVERS];
 #define AFS_VOL_VTM_RW	0x01 /* R/W version of the volume is available (on this server) */
 #define AFS_VOL_VTM_RO	0x02 /* R/O version of the volume is available (on this server) */
@@ -498,7 +499,6 @@ struct afs_server {
 	struct hlist_node	proc_link;	/* Link in net->fs_proc */
 	struct afs_server	*gc_next;	/* Next server in manager's list */
 	time64_t		put_time;	/* Time at which last put */
-	time64_t		update_at;	/* Time at which to next update the record */
 	unsigned long		flags;
 #define AFS_SERVER_FL_NOT_READY	1		/* The record is not ready for use */
 #define AFS_SERVER_FL_NOT_FOUND	2		/* VL server says no such server */
@@ -511,6 +511,7 @@ struct afs_server {
 #define AFS_SERVER_FL_IS_YFS	9		/* Server is YFS not AFS */
 #define AFS_SERVER_FL_NO_RM2	10		/* Fileserver doesn't support YFS.RemoveFile2 */
 #define AFS_SERVER_FL_HAVE_EPOCH 11		/* ->epoch is valid */
+#define AFS_SERVER_FL_NEEDS_UPDATE 12		/* Fileserver address list is out of date */
 	atomic_t		usage;
 	u32			addr_version;	/* Address list version */
 	u32			cm_epoch;	/* Server RxRPC epoch */
@@ -1241,7 +1242,7 @@ extern spinlock_t afs_server_peer_lock;
 extern struct afs_server *afs_find_server(struct afs_net *,
 					  const struct sockaddr_rxrpc *);
 extern struct afs_server *afs_find_server_by_uuid(struct afs_net *, const uuid_t *);
-extern struct afs_server *afs_lookup_server(struct afs_cell *, struct key *, const uuid_t *);
+extern struct afs_server *afs_lookup_server(struct afs_cell *, struct key *, const uuid_t *, u32);
 extern struct afs_server *afs_get_server(struct afs_server *, enum afs_server_trace);
 extern void afs_put_server(struct afs_net *, struct afs_server *, enum afs_server_trace);
 extern void afs_manage_servers(struct work_struct *);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 11b90ac7ea30..9e50ccde5d37 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -12,7 +12,6 @@
 #include "protocol_yfs.h"
 
 static unsigned afs_server_gc_delay = 10;	/* Server record timeout in seconds */
-static unsigned afs_server_update_delay = 30;	/* Time till VLDB recheck in secs */
 static atomic_t afs_server_debug_id;
 
 static void afs_inc_servers_outstanding(struct afs_net *net)
@@ -218,7 +217,6 @@ static struct afs_server *afs_alloc_server(struct afs_net *net,
 	RCU_INIT_POINTER(server->addresses, alist);
 	server->addr_version = alist->version;
 	server->uuid = *uuid;
-	server->update_at = ktime_get_real_seconds() + afs_server_update_delay;
 	rwlock_init(&server->fs_lock);
 	INIT_HLIST_HEAD(&server->cb_volumes);
 	rwlock_init(&server->cb_break_lock);
@@ -264,7 +262,7 @@ static struct afs_addr_list *afs_vl_lookup_addrs(struct afs_cell *cell,
  * Get or create a fileserver record.
  */
 struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
-				     const uuid_t *uuid)
+				     const uuid_t *uuid, u32 addr_version)
 {
 	struct afs_addr_list *alist;
 	struct afs_server *server, *candidate;
@@ -272,8 +270,11 @@ struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 	_enter("%p,%pU", cell->net, uuid);
 
 	server = afs_find_server_by_uuid(cell->net, uuid);
-	if (server)
+	if (server) {
+		if (server->addr_version != addr_version)
+			set_bit(AFS_SERVER_FL_NEEDS_UPDATE, &server->flags);
 		return server;
+	}
 
 	alist = afs_vl_lookup_addrs(cell, key, uuid);
 	if (IS_ERR(alist))
@@ -558,7 +559,6 @@ static noinline bool afs_update_server_record(struct afs_fs_cursor *fc, struct a
 		write_unlock(&server->fs_lock);
 	}
 
-	server->update_at = ktime_get_real_seconds() + afs_server_update_delay;
 	afs_put_addrlist(discard);
 	_leave(" = t");
 	return true;
@@ -569,8 +569,6 @@ static noinline bool afs_update_server_record(struct afs_fs_cursor *fc, struct a
  */
 bool afs_check_server_record(struct afs_fs_cursor *fc, struct afs_server *server)
 {
-	time64_t now = ktime_get_real_seconds();
-	long diff;
 	bool success;
 	int ret, retries = 0;
 
@@ -579,13 +577,16 @@ bool afs_check_server_record(struct afs_fs_cursor *fc, struct afs_server *server
 	ASSERT(server);
 
 retry:
-	diff = READ_ONCE(server->update_at) - now;
-	if (diff > 0) {
-		_leave(" = t [not now %ld]", diff);
-		return true;
-	}
+	if (test_bit(AFS_SERVER_FL_UPDATING, &server->flags))
+		goto wait;
+	if (test_bit(AFS_SERVER_FL_NEEDS_UPDATE, &server->flags))
+		goto update;
+	_leave(" = t [good]");
+	return true;
 
+update:
 	if (!test_and_set_bit_lock(AFS_SERVER_FL_UPDATING, &server->flags)) {
+		clear_bit(AFS_SERVER_FL_NEEDS_UPDATE, &server->flags);
 		success = afs_update_server_record(fc, server);
 		clear_bit_unlock(AFS_SERVER_FL_UPDATING, &server->flags);
 		wake_up_bit(&server->flags, AFS_SERVER_FL_UPDATING);
@@ -593,6 +594,7 @@ bool afs_check_server_record(struct afs_fs_cursor *fc, struct afs_server *server
 		return success;
 	}
 
+wait:
 	ret = wait_on_bit(&server->flags, AFS_SERVER_FL_UPDATING,
 			  (fc->flags & AFS_FS_CURSOR_INTR) ?
 			  TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index 888d91d195d9..f567732df5cc 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -51,7 +51,8 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 		if (!(vldb->fs_mask[i] & type_mask))
 			continue;
 
-		server = afs_lookup_server(cell, key, &vldb->fs_server[i]);
+		server = afs_lookup_server(cell, key, &vldb->fs_server[i],
+					   vldb->addr_version[i]);
 		if (IS_ERR(server)) {
 			ret = PTR_ERR(server);
 			if (ret == -ENOENT ||
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index 516e9a3bb5b4..972dc5512f33 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -82,6 +82,7 @@ static int afs_deliver_vl_get_entry_by_name_u(struct afs_call *call)
 		for (j = 0; j < 6; j++)
 			uuid->node[j] = (u8)ntohl(xdr->node[j]);
 
+		entry->addr_version[n] = ntohl(uvldb->serverUnique[i]);
 		entry->nr_servers++;
 	}
 


