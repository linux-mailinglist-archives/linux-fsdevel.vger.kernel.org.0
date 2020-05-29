Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD811E8ADF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgE2WDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:03:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58434 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728768AbgE2WDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xxEKD1mR96CbnPqNHYYaoh1a7NYGm2UXIRM421KhtUA=;
        b=i9ZgNpApejdUgILrYJiXiGEjfRP3vZWBuufOuTcAXcpg06Qc0sn5dvVtvJM0EqYTP3Z4dl
        70Puwzd9gKPT2Qs4jQayKKSwzgPnBSBsWdF6QKQbOeTUqQN+R2QOvPI9N4a8OxdDUfRHBX
        86fZwbQHaMzWJ3EyPfka6xtcwAH3tWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-ZtITU5KDPaeyiNxky1VWBg-1; Fri, 29 May 2020 18:03:07 -0400
X-MC-Unique: ZtITU5KDPaeyiNxky1VWBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C881461;
        Fri, 29 May 2020 22:03:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 579FF10013D4;
        Fri, 29 May 2020 22:03:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 25/27] afs: Don't use probe running state to make decisions
 outside probe code
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:03:04 +0100
Message-ID: <159078978453.679399.3917802075646491673.stgit@warthog.procyon.org.uk>
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

Don't use the running state for fileserver probes to make decisions about
which server to use as the state is cleared at the start of a probe and
also intermediate values might be misleading.

Instead, add a separate 'latest known' rtt in the afs_server struct and a
flag to indicate if the server is known to be responding and update these
as and when we know what to change them to.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fs_probe.c |   18 ++++++++++++------
 fs/afs/internal.h |    4 +++-
 fs/afs/rotate.c   |    3 ++-
 fs/afs/server.c   |    1 +
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 442b5e7944ff..c41cf3b2ab89 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -42,10 +42,13 @@ static void afs_finished_fs_probe(struct afs_net *net, struct afs_server *server
 	bool responded = server->probe.responded;
 
 	write_seqlock(&net->fs_lock);
-	if (responded)
+	if (responded) {
 		list_add_tail(&server->probe_link, &net->fs_probe_slow);
-	else
+	} else {
+		server->rtt = UINT_MAX;
+		clear_bit(AFS_SERVER_FL_RESPONDING, &server->flags);
 		list_add_tail(&server->probe_link, &net->fs_probe_fast);
+	}
 	write_sequnlock(&net->fs_lock);
 
 	afs_schedule_fs_probe(net, server, !responded);
@@ -161,12 +164,14 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	rtt_us = rxrpc_kernel_get_srtt(call->net->socket, call->rxcall);
 	if (rtt_us < server->probe.rtt) {
 		server->probe.rtt = rtt_us;
+		server->rtt = rtt_us;
 		alist->preferred = index;
 	}
 
 	smp_wmb(); /* Set rtt before responded. */
 	server->probe.responded = true;
 	set_bit(index, &alist->responded);
+	set_bit(AFS_SERVER_FL_RESPONDING, &server->flags);
 out:
 	spin_unlock(&server->probe_lock);
 
@@ -224,7 +229,7 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 {
 	struct wait_queue_entry *waits;
 	struct afs_server *server;
-	unsigned int rtt = UINT_MAX;
+	unsigned int rtt = UINT_MAX, rtt_s;
 	bool have_responders = false;
 	int pref = -1, i;
 
@@ -280,10 +285,11 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 	for (i = 0; i < slist->nr_servers; i++) {
 		if (test_bit(i, &untried)) {
 			server = slist->servers[i].server;
-			if (server->probe.responded &&
-			    server->probe.rtt < rtt) {
+			rtt_s = READ_ONCE(server->rtt);
+			if (test_bit(AFS_SERVER_FL_RESPONDING, &server->flags) &&
+			    rtt_s < rtt) {
 				pref = i;
-				rtt = server->probe.rtt;
+				rtt = rtt_s;
 			}
 
 			remove_wait_queue(&server->probe_wq, &waits[i]);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e0dc14d4d8b9..a4fe5d1a8b53 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -496,6 +496,7 @@ struct afs_server {
 	struct afs_server	*gc_next;	/* Next server in manager's list */
 	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
+#define AFS_SERVER_FL_RESPONDING 0		/* The server is responding */
 #define AFS_SERVER_FL_NOT_READY	1		/* The record is not ready for use */
 #define AFS_SERVER_FL_NOT_FOUND	2		/* VL server says no such server */
 #define AFS_SERVER_FL_VL_FAIL	3		/* Failed to access VL server */
@@ -508,6 +509,7 @@ struct afs_server {
 	atomic_t		ref;		/* Object refcount */
 	atomic_t		active;		/* Active user count */
 	u32			addr_version;	/* Address list version */
+	unsigned int		rtt;		/* Server's current RTT in uS */
 	unsigned int		debug_id;	/* Debugging ID for traces */
 
 	/* file service access */
@@ -522,7 +524,7 @@ struct afs_server {
 	atomic_t		probe_outstanding;
 	spinlock_t		probe_lock;
 	struct {
-		unsigned int	rtt;		/* RTT as ktime/64 */
+		unsigned int	rtt;		/* RTT in uS */
 		u32		abort_code;
 		short		error;
 		bool		responded:1;
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 979979e33a77..d1590fb382b6 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -339,7 +339,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 	for (i = 0; i < op->server_list->nr_servers; i++) {
 		struct afs_server *s = op->server_list->servers[i].server;
 
-		if (!test_bit(i, &op->untried) || !s->probe.responded)
+		if (!test_bit(i, &op->untried) ||
+		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
 		if (s->probe.rtt < rtt) {
 			op->index = i;
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 88593ffcb54e..039e3488511c 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -239,6 +239,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	INIT_LIST_HEAD(&server->probe_link);
 	spin_lock_init(&server->probe_lock);
 	server->cell = cell;
+	server->rtt = UINT_MAX;
 
 	afs_inc_servers_outstanding(net);
 	trace_afs_server(server, 1, 1, afs_server_trace_alloc);


