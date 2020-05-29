Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4641E8AB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgE2WBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:01:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55036 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728624AbgE2WBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+rb9rrdYIahXVRWyEkfWi76z3dO7iGrg2agpUGegNU=;
        b=GgRmj9t3w8ioP3Wba4mdOrJ7/jjePn23EYZTxrzHOrfktO2+eXv+V/F187jeez7UX5c9CO
        iPYRoPwRUUIaaUe5NSKsW9EP+g+wn2vhzA0kHLpaMdk4/heuABQZY+SyyV8eOMqcimvVtE
        gQaDFH21tIJjkdJxDJPKF7vlYLb2Icw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-yKbLLOH3PxWajYR-0bu9gw-1; Fri, 29 May 2020 18:01:50 -0400
X-MC-Unique: yKbLLOH3PxWajYR-0bu9gw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D4F018A8220;
        Fri, 29 May 2020 22:01:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2337FA1048;
        Fri, 29 May 2020 22:01:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/27] afs: Don't get epoch from a server because it may be
 ambiguous
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Jeffrey Altman <jaltman@auristor.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:01:47 +0100
Message-ID: <159078970733.679399.1214323890532227368.stgit@warthog.procyon.org.uk>
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

Don't get the epoch from a server, particularly one that we're looking up
by UUID, as UUIDs may be ambiguous and may map to more than one server - so
we can't draw any conclusions from it.

Reported-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c |   49 ++-----------------------------------------------
 fs/afs/internal.h  |    7 -------
 2 files changed, 2 insertions(+), 54 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index ed0fb34d77dd..954030ae7a0f 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -118,8 +118,6 @@ bool afs_cm_incoming_call(struct afs_call *call)
 {
 	_enter("{%u, CB.OP %u}", call->service_id, call->operation_ID);
 
-	call->epoch = rxrpc_kernel_get_epoch(call->net->socket, call->rxcall);
-
 	switch (call->operation_ID) {
 	case CBCallBack:
 		call->type = &afs_SRXCBCallBack;
@@ -149,49 +147,6 @@ bool afs_cm_incoming_call(struct afs_call *call)
 	}
 }
 
-/*
- * Record a probe to the cache manager from a server.
- */
-static int afs_record_cm_probe(struct afs_call *call, struct afs_server *server)
-{
-	_enter("");
-
-	if (test_bit(AFS_SERVER_FL_HAVE_EPOCH, &server->flags) &&
-	    !afs_is_probing_server(server)) {
-		if (server->cm_epoch == call->epoch)
-			return 0;
-
-		if (!server->probe.said_rebooted) {
-			pr_notice("kAFS: FS rebooted %pU\n", &server->uuid);
-			server->probe.said_rebooted = true;
-		}
-	}
-
-	spin_lock(&server->probe_lock);
-
-	if (!test_and_set_bit(AFS_SERVER_FL_HAVE_EPOCH, &server->flags)) {
-		server->cm_epoch = call->epoch;
-		server->probe.cm_epoch = call->epoch;
-		goto out;
-	}
-
-	if (server->probe.cm_probed &&
-	    call->epoch != server->probe.cm_epoch &&
-	    !server->probe.said_inconsistent) {
-		pr_notice("kAFS: FS endpoints inconsistent %pU\n",
-			  &server->uuid);
-		server->probe.said_inconsistent = true;
-	}
-
-	if (!server->probe.cm_probed || call->epoch == server->cm_epoch)
-		server->probe.cm_epoch = server->cm_epoch;
-
-out:
-	server->probe.cm_probed = true;
-	spin_unlock(&server->probe_lock);
-	return 0;
-}
-
 /*
  * Find the server record by peer address and record a probe to the cache
  * manager from a server.
@@ -210,7 +165,7 @@ static int afs_find_cm_server_by_peer(struct afs_call *call)
 	}
 
 	call->server = server;
-	return afs_record_cm_probe(call, server);
+	return 0;
 }
 
 /*
@@ -231,7 +186,7 @@ static int afs_find_cm_server_by_uuid(struct afs_call *call,
 	}
 
 	call->server = server;
-	return afs_record_cm_probe(call, server);
+	return 0;
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 4b8ac049fc17..9f024c1bd650 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -124,7 +124,6 @@ struct afs_call {
 	spinlock_t		state_lock;
 	int			error;		/* error code */
 	u32			abort_code;	/* Remote abort ID or 0 */
-	u32			epoch;
 	unsigned int		max_lifespan;	/* Maximum lifespan to set if not 0 */
 	unsigned		request_size;	/* size of request data */
 	unsigned		reply_max;	/* maximum size of reply */
@@ -491,12 +490,10 @@ struct afs_server {
 #define AFS_SERVER_FL_MAY_HAVE_CB 8		/* May have callbacks on this fileserver */
 #define AFS_SERVER_FL_IS_YFS	9		/* Server is YFS not AFS */
 #define AFS_SERVER_FL_NO_RM2	10		/* Fileserver doesn't support YFS.RemoveFile2 */
-#define AFS_SERVER_FL_HAVE_EPOCH 11		/* ->epoch is valid */
 #define AFS_SERVER_FL_NEEDS_UPDATE 12		/* Fileserver address list is out of date */
 	atomic_t		ref;		/* Object refcount */
 	atomic_t		active;		/* Active user count */
 	u32			addr_version;	/* Address list version */
-	u32			cm_epoch;	/* Server RxRPC epoch */
 	unsigned int		debug_id;	/* Debugging ID for traces */
 
 	/* file service access */
@@ -515,15 +512,11 @@ struct afs_server {
 	struct {
 		unsigned int	rtt;		/* RTT as ktime/64 */
 		u32		abort_code;
-		u32		cm_epoch;
 		short		error;
 		bool		responded:1;
 		bool		is_yfs:1;
 		bool		not_yfs:1;
 		bool		local_failure:1;
-		bool		cm_probed:1;
-		bool		said_rebooted:1;
-		bool		said_inconsistent:1;
 	} probe;
 };
 


