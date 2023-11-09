Return-Path: <linux-fsdevel+bounces-2562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAE47E6DAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A592816BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B5D225D9;
	Thu,  9 Nov 2023 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtSgY7Fr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5A224F9
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:41:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDB73846
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8D9VkJg6b/enlx8z9zaZN6ks+F+lLYWLAw/rY1T2N20=;
	b=TtSgY7FrXVocW+f+YCMHuNdGMYUgs8tT8fwqL1AN5IfNf+p8Hux8xsHCescIipKyg9NeMs
	NO8B9iUCd/1kTxYlaL3LwC/xRxsyZrw3TtNtUq3rGX3/44DVWK7Q1TEpgerZVkx3W8wbor
	yVH4D4mQZj0UdTy0b/nCw9FkwT6TbFE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-_9SDPqWGNxSKPunkOv9hRA-1; Thu, 09 Nov 2023 10:40:56 -0500
X-MC-Unique: _9SDPqWGNxSKPunkOv9hRA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95D4C862CB3;
	Thu,  9 Nov 2023 15:40:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A1716492BF6;
	Thu,  9 Nov 2023 15:40:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/41] afs: Rename some fields
Date: Thu,  9 Nov 2023 15:39:43 +0000
Message-ID: <20231109154004.3317227-21-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Rename the ->index and ->untried fields of the afs_vl_cursor and
afs_operation struct to ->server_index and ->untried_servers to avoid
confusion with address iteration fields when those get folded in.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/internal.h  |  8 ++++----
 fs/afs/rotate.c    | 36 ++++++++++++++++++------------------
 fs/afs/vl_rotate.c | 32 ++++++++++++++++----------------
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index d5a26cea2358..b3353fe63250 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -746,11 +746,11 @@ struct afs_vl_cursor {
 	struct afs_vlserver_list *server_list;	/* Current server list (pins ref) */
 	struct afs_vlserver	*server;	/* Server on which this resides */
 	struct key		*key;		/* Key for the server */
-	unsigned long		untried;	/* Bitmask of untried servers */
+	unsigned long		untried_servers; /* Bitmask of untried servers */
 	struct afs_error	cumul_error;	/* Cumulative error */
 	s32			call_abort_code;
-	short			index;		/* Current server */
 	short			call_error;	/* Error from single call */
+	short			server_index;	/* Current server */
 	unsigned short		flags;
 #define AFS_VL_CURSOR_STOP	0x0001		/* Set to cease iteration */
 #define AFS_VL_CURSOR_RETRY	0x0002		/* Set to do a retry */
@@ -863,8 +863,8 @@ struct afs_operation {
 	struct afs_server_list	*server_list;	/* Current server list (pins ref) */
 	struct afs_server	*server;	/* Server we're using (ref pinned by server_list) */
 	struct afs_call		*call;
-	unsigned long		untried;	/* Bitmask of untried servers */
-	short			index;		/* Current server */
+	unsigned long		untried_servers; /* Bitmask of untried servers */
+	short			server_index;	/* Current server */
 	short			nr_iterations;	/* Number of server iterations */
 	bool			call_responded;	/* T if the current address responded */
 
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 1767c6e67184..fdf5e45e6a0a 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -32,8 +32,8 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 					  lockdep_is_held(&op->volume->servers_lock)));
 	read_unlock(&op->volume->servers_lock);
 
-	op->untried = (1UL << op->server_list->nr_servers) - 1;
-	op->index = READ_ONCE(op->server_list->preferred);
+	op->untried_servers = (1UL << op->server_list->nr_servers) - 1;
+	op->server_index = READ_ONCE(op->server_list->preferred);
 
 	cb_server = vnode->cb_server;
 	if (cb_server) {
@@ -41,7 +41,7 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 		for (i = 0; i < op->server_list->nr_servers; i++) {
 			server = op->server_list->servers[i].server;
 			if (server == cb_server) {
-				op->index = i;
+				op->server_index = i;
 				goto found_interest;
 			}
 		}
@@ -120,7 +120,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 	_enter("OP=%x+%x,%llx,%lx[%d],%lx[%d],%d,%d",
 	       op->debug_id, op->nr_iterations, op->volume->vid,
-	       op->untried, op->index,
+	       op->untried_servers, op->server_index,
 	       op->ac.tried, op->ac.index,
 	       error, abort_code);
 
@@ -172,7 +172,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 			}
 
 			write_lock(&op->volume->servers_lock);
-			op->server_list->vnovol_mask |= 1 << op->index;
+			op->server_list->vnovol_mask |= 1 << op->server_index;
 			write_unlock(&op->volume->servers_lock);
 
 			set_bit(AFS_VOLUME_NEEDS_UPDATE, &op->volume->flags);
@@ -417,9 +417,9 @@ bool afs_select_fileserver(struct afs_operation *op)
 	_debug("__ VOL %llx __", op->volume->vid);
 
 pick_server:
-	_debug("pick [%lx]", op->untried);
+	_debug("pick [%lx]", op->untried_servers);
 
-	error = afs_wait_for_fs_probes(op->server_list, op->untried);
+	error = afs_wait_for_fs_probes(op->server_list, op->untried_servers);
 	if (error < 0) {
 		afs_op_set_error(op, error);
 		goto failed;
@@ -429,40 +429,40 @@ bool afs_select_fileserver(struct afs_operation *op)
 	 * callbacks, we stick with the server we're already using if we can.
 	 */
 	if (op->server) {
-		_debug("server %u", op->index);
-		if (test_bit(op->index, &op->untried))
+		_debug("server %u", op->server_index);
+		if (test_bit(op->server_index, &op->untried_servers))
 			goto selected_server;
 		op->server = NULL;
 		_debug("no server");
 	}
 
-	op->index = -1;
+	op->server_index = -1;
 	rtt = UINT_MAX;
 	for (i = 0; i < op->server_list->nr_servers; i++) {
 		struct afs_server *s = op->server_list->servers[i].server;
 
-		if (!test_bit(i, &op->untried) ||
+		if (!test_bit(i, &op->untried_servers) ||
 		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
 		if (s->probe.rtt <= rtt) {
-			op->index = i;
+			op->server_index = i;
 			rtt = s->probe.rtt;
 		}
 	}
 
-	if (op->index == -1)
+	if (op->server_index == -1)
 		goto no_more_servers;
 
 selected_server:
-	_debug("use %d", op->index);
-	__clear_bit(op->index, &op->untried);
+	_debug("use %d", op->server_index);
+	__clear_bit(op->server_index, &op->untried_servers);
 
 	/* We're starting on a different fileserver from the list.  We need to
 	 * check it, create a callback intercept, find its address list and
 	 * probe its capabilities before we use it.
 	 */
 	ASSERTCMP(op->ac.alist, ==, NULL);
-	server = op->server_list->servers[op->index].server;
+	server = op->server_list->servers[op->server_index].server;
 
 	if (!afs_check_server_record(op, server))
 		goto failed;
@@ -504,7 +504,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		goto out_of_addresses;
 
 	_debug("address [%u] %u/%u %pISp",
-	       op->index, op->ac.index, op->ac.alist->nr_addrs,
+	       op->server_index, op->ac.index, op->ac.alist->nr_addrs,
 	       rxrpc_kernel_remote_addr(op->ac.alist->addrs[op->ac.index].peer));
 
 	op->call_responded = false;
@@ -579,7 +579,7 @@ void afs_dump_edestaddrreq(const struct afs_operation *op)
 		  op->file[0].cb_break_before,
 		  op->file[1].cb_break_before, op->flags, op->cumul_error.error);
 	pr_notice("OP: ut=%lx ix=%d ni=%u\n",
-		  op->untried, op->index, op->nr_iterations);
+		  op->untried_servers, op->server_index, op->nr_iterations);
 	pr_notice("OP: call  er=%d ac=%d r=%u\n",
 		  op->call_error, op->call_abort_code, op->call_responded);
 
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index e8fbbeb551bb..f895eb94129e 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -78,8 +78,8 @@ static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
 	if (!vc->server_list->nr_servers)
 		return false;
 
-	vc->untried = (1UL << vc->server_list->nr_servers) - 1;
-	vc->index = -1;
+	vc->untried_servers = (1UL << vc->server_list->nr_servers) - 1;
+	vc->server_index = -1;
 	return true;
 }
 
@@ -98,7 +98,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	vc->nr_iterations++;
 
 	_enter("%lx[%d],%lx[%d],%d,%d",
-	       vc->untried, vc->index,
+	       vc->untried_servers, vc->server_index,
 	       vc->ac.tried, vc->ac.index,
 	       error, abort_code);
 
@@ -131,7 +131,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 			/* The server went weird. */
 			afs_prioritise_error(&vc->cumul_error, -EREMOTEIO, abort_code);
 			//write_lock(&vc->cell->vl_servers_lock);
-			//vc->server_list->weird_mask |= 1 << vc->index;
+			//vc->server_list->weird_mask |= 1 << vc->server_index;
 			//write_unlock(&vc->cell->vl_servers_lock);
 			goto next_server;
 
@@ -184,46 +184,46 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	}
 
 pick_server:
-	_debug("pick [%lx]", vc->untried);
+	_debug("pick [%lx]", vc->untried_servers);
 
-	error = afs_wait_for_vl_probes(vc->server_list, vc->untried);
+	error = afs_wait_for_vl_probes(vc->server_list, vc->untried_servers);
 	if (error < 0) {
 		afs_prioritise_error(&vc->cumul_error, error, 0);
 		goto failed;
 	}
 
 	/* Pick the untried server with the lowest RTT. */
-	vc->index = vc->server_list->preferred;
-	if (test_bit(vc->index, &vc->untried))
+	vc->server_index = vc->server_list->preferred;
+	if (test_bit(vc->server_index, &vc->untried_servers))
 		goto selected_server;
 
-	vc->index = -1;
+	vc->server_index = -1;
 	rtt = UINT_MAX;
 	for (i = 0; i < vc->server_list->nr_servers; i++) {
 		struct afs_vlserver *s = vc->server_list->servers[i].server;
 
-		if (!test_bit(i, &vc->untried) ||
+		if (!test_bit(i, &vc->untried_servers) ||
 		    !test_bit(AFS_VLSERVER_FL_RESPONDING, &s->flags))
 			continue;
 		if (s->probe.rtt <= rtt) {
-			vc->index = i;
+			vc->server_index = i;
 			rtt = s->probe.rtt;
 		}
 	}
 
-	if (vc->index == -1)
+	if (vc->server_index == -1)
 		goto no_more_servers;
 
 selected_server:
-	_debug("use %d", vc->index);
-	__clear_bit(vc->index, &vc->untried);
+	_debug("use %d", vc->server_index);
+	__clear_bit(vc->server_index, &vc->untried_servers);
 
 	/* We're starting on a different vlserver from the list.  We need to
 	 * check it, find its address list and probe its capabilities before we
 	 * use it.
 	 */
 	ASSERTCMP(vc->ac.alist, ==, NULL);
-	vlserver = vc->server_list->servers[vc->index].server;
+	vlserver = vc->server_list->servers[vc->server_index].server;
 	vc->server = vlserver;
 
 	_debug("USING VLSERVER: %s", vlserver->name);
@@ -299,7 +299,7 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 	pr_notice("DNS: src=%u st=%u lc=%x\n",
 		  cell->dns_source, cell->dns_status, cell->dns_lookup_count);
 	pr_notice("VC: ut=%lx ix=%u ni=%hu fl=%hx err=%hd\n",
-		  vc->untried, vc->index, vc->nr_iterations, vc->flags,
+		  vc->untried_servers, vc->server_index, vc->nr_iterations, vc->flags,
 		  vc->cumul_error.error);
 	pr_notice("VC: call  er=%d ac=%d r=%u\n",
 		  vc->call_error, vc->call_abort_code, vc->call_responded);


