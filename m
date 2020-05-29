Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3464A1E8AE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgE2WDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:03:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24984 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728486AbgE2WD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdqrWaxRCFuPanDq8kaSrijov1l0/UqCUiZFDxF/o80=;
        b=CWySHzL83SeJY4WOpBVxQ9o7/R2pOCf2yak7BWuTNGuENRzzYrUaajTfslIhRvgqktHvec
        mal9V+Mq5NBsFu8gjKGM5kD7KHjH//6cl+LQD3pHPjbHegl7JVbb5as1izm/kCqkAHM0nf
        jxPdcIpEp9dQ3SfAxh8XVO4EYTbBf94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-Rgeb9_x5NSuUsq5bbq9VTQ-1; Fri, 29 May 2020 18:03:24 -0400
X-MC-Unique: Rgeb9_x5NSuUsq5bbq9VTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BA62460;
        Fri, 29 May 2020 22:03:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 385727A8D9;
        Fri, 29 May 2020 22:03:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 27/27] afs: Adjust the fileserver rotation algorithm to
 reprobe/retry more quickly
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:03:18 +0100
Message-ID: <159078979838.679399.11549530849526926884.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust the fileserver rotation algorithm so that if we've tried all the
addresses on a server (cumulatively over multiple operations) until we've
run out of untried addresses, immediately reprobe all that server's
interfaces and retry the op at least once before we move onto the next
server.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fs_probe.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/internal.h |   24 ++++++++++++++----------
 fs/afs/rotate.c   |   29 +++++++++++++++++++++++++++--
 3 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index c41cf3b2ab89..b34f74b0f319 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -338,6 +338,18 @@ static void afs_dispatch_fs_probe(struct afs_net *net, struct afs_server *server
 	afs_put_server(net, server, afs_server_trace_put_probe);
 }
 
+/*
+ * Probe a server immediately without waiting for its due time to come
+ * round.  This is used when all of the addresses have been tried.
+ */
+void afs_probe_fileserver(struct afs_net *net, struct afs_server *server)
+{
+	write_seqlock(&net->fs_lock);
+	if (!list_empty(&server->probe_link))
+		return afs_dispatch_fs_probe(net, server, true);
+	write_sequnlock(&net->fs_lock);
+}
+
 /*
  * Probe dispatcher to regularly dispatch probes to keep NAT alive.
  */
@@ -411,3 +423,38 @@ void afs_fs_probe_dispatcher(struct work_struct *work)
 		_leave(" [quiesce]");
 	}
 }
+
+/*
+ * Wait for a probe on a particular fileserver to complete for 2s.
+ */
+int afs_wait_for_one_fs_probe(struct afs_server *server, bool is_intr)
+{
+	struct wait_queue_entry wait;
+	unsigned long timo = 2 * HZ;
+
+	if (atomic_read(&server->probe_outstanding) == 0)
+		goto dont_wait;
+
+	init_wait_entry(&wait, 0);
+	for (;;) {
+		prepare_to_wait_event(&server->probe_wq, &wait,
+				      is_intr ? TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
+		if (timo == 0 ||
+		    server->probe.responded ||
+		    atomic_read(&server->probe_outstanding) == 0 ||
+		    (is_intr && signal_pending(current)))
+			break;
+		timo = schedule_timeout(timo);
+	}
+
+	finish_wait(&server->probe_wq, &wait);
+
+dont_wait:
+	if (server->probe.responded)
+		return 0;
+	if (is_intr && signal_pending(current))
+		return -ERESTARTSYS;
+	if (timo == 0)
+		return -ETIME;
+	return -EDESTADDRREQ;
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index af0b7fca87db..e1621b0670cc 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -826,16 +826,18 @@ struct afs_operation {
 	unsigned short		nr_iterations;	/* Number of server iterations */
 
 	unsigned int		flags;
-#define AFS_OPERATION_STOP	0x0001		/* Set to cease iteration */
-#define AFS_OPERATION_VBUSY	0x0002		/* Set if seen VBUSY */
-#define AFS_OPERATION_VMOVED	0x0004		/* Set if seen VMOVED */
-#define AFS_OPERATION_VNOVOL	0x0008		/* Set if seen VNOVOL */
-#define AFS_OPERATION_CUR_ONLY	0x0010		/* Set if current server only (file lock held) */
-#define AFS_OPERATION_NO_VSLEEP	0x0020		/* Set to prevent sleep on VBUSY, VOFFLINE, ... */
-#define AFS_OPERATION_UNINTR	0x0040		/* Set if op is uninterruptible */
-#define AFS_OPERATION_DOWNGRADE	0x0080		/* Set to retry with downgraded opcode */
-#define AFS_OPERATION_LOCK_0	0x0100		/* Set if have io_lock on file[0] */
-#define AFS_OPERATION_LOCK_1	0x0200		/* Set if have io_lock on file[1] */
+#define AFS_OPERATION_STOP		0x0001	/* Set to cease iteration */
+#define AFS_OPERATION_VBUSY		0x0002	/* Set if seen VBUSY */
+#define AFS_OPERATION_VMOVED		0x0004	/* Set if seen VMOVED */
+#define AFS_OPERATION_VNOVOL		0x0008	/* Set if seen VNOVOL */
+#define AFS_OPERATION_CUR_ONLY		0x0010	/* Set if current server only (file lock held) */
+#define AFS_OPERATION_NO_VSLEEP		0x0020	/* Set to prevent sleep on VBUSY, VOFFLINE, ... */
+#define AFS_OPERATION_UNINTR		0x0040	/* Set if op is uninterruptible */
+#define AFS_OPERATION_DOWNGRADE		0x0080	/* Set to retry with downgraded opcode */
+#define AFS_OPERATION_LOCK_0		0x0100	/* Set if have io_lock on file[0] */
+#define AFS_OPERATION_LOCK_1		0x0200	/* Set if have io_lock on file[1] */
+#define AFS_OPERATION_TRIED_ALL		0x0400	/* Set if we've tried all the fileservers */
+#define AFS_OPERATION_RETRY_SERVER	0x0800	/* Set if we should retry the current server */
 };
 
 /*
@@ -1055,7 +1057,9 @@ static inline void afs_op_set_fid(struct afs_operation *op, unsigned int n,
 extern void afs_fileserver_probe_result(struct afs_call *);
 extern void afs_fs_probe_fileserver(struct afs_net *, struct afs_server *, struct key *, bool);
 extern int afs_wait_for_fs_probes(struct afs_server_list *, unsigned long);
+extern void afs_probe_fileserver(struct afs_net *, struct afs_server *);
 extern void afs_fs_probe_dispatcher(struct work_struct *);
+extern int afs_wait_for_one_fs_probe(struct afs_server *, bool);
 
 /*
  * inode.c
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index d1590fb382b6..bfa82f613c93 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -367,6 +367,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 	_debug("USING SERVER: %pU", &server->uuid);
 
+	op->flags |= AFS_OPERATION_RETRY_SERVER;
 	op->server = server;
 	if (vnode->cb_server != server) {
 		vnode->cb_server = server;
@@ -381,6 +382,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	afs_get_addrlist(alist);
 	read_unlock(&server->fs_lock);
 
+retry_server:
 	memset(&op->ac, 0, sizeof(op->ac));
 
 	if (!op->ac.alist)
@@ -396,13 +398,36 @@ bool afs_select_fileserver(struct afs_operation *op)
 	 * address on which it will respond to us.
 	 */
 	if (!afs_iterate_addresses(&op->ac))
-		goto next_server;
+		goto out_of_addresses;
 
-	_debug("address [%u] %u/%u", op->index, op->ac.index, op->ac.alist->nr_addrs);
+	_debug("address [%u] %u/%u %pISp",
+	       op->index, op->ac.index, op->ac.alist->nr_addrs,
+	       &op->ac.alist->addrs[op->ac.index].transport);
 
 	_leave(" = t");
 	return true;
 
+out_of_addresses:
+	/* We've now had a failure to respond on all of a server's addresses -
+	 * immediately probe them again and consider retrying the server.
+	 */
+	afs_probe_fileserver(op->net, op->server);
+	if (op->flags & AFS_OPERATION_RETRY_SERVER) {
+		alist = op->ac.alist;
+		error = afs_wait_for_one_fs_probe(
+			op->server, !(op->flags & AFS_OPERATION_UNINTR));
+		switch (error) {
+		case 0:
+			op->flags &= ~AFS_OPERATION_RETRY_SERVER;
+			goto retry_server;
+		case -ERESTARTSYS:
+			goto failed_set_error;
+		case -ETIME:
+		case -EDESTADDRREQ:
+			goto next_server;
+		}
+	}
+
 next_server:
 	_debug("next");
 	afs_end_cursor(&op->ac);


