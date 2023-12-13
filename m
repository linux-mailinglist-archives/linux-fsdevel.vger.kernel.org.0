Return-Path: <linux-fsdevel+bounces-5884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A9811394
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492E71C21166
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01E2EB09;
	Wed, 13 Dec 2023 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlIHtiLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC32183
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uxlhhzYOJGE/EnjwXuTD2EVqz5vY7VT/PkRDYqehTo=;
	b=PlIHtiLdgP85EbPc+NouqUcNCV9UU9Io8EcwdJsSWOUULMKv+TtKsYYQcR/RUlX1UQT/fy
	NI9ANSFkL6Jm2+24B+Ia6MpYNvjNXkyCLNuUY8DPHd90LBfZSiKWBVMcAz/JwCKVwbmZIx
	rdFQ6QAJG13wo5UJkPRi/pY7wrEmMsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-uz8qfnuzN8GJS4LAl_yvKg-1; Wed, 13 Dec 2023 08:50:49 -0500
X-MC-Unique: uz8qfnuzN8GJS4LAl_yvKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9371C185A785;
	Wed, 13 Dec 2023 13:50:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C77C740C6EBA;
	Wed, 13 Dec 2023 13:50:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/40] afs: Dispatch vlserver probes in priority order
Date: Wed, 13 Dec 2023 13:49:49 +0000
Message-ID: <20231213135003.367397-28-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

When probing all the addresses for a volume location server, dispatch them
in order of descending priority to try and get back highest priority one
first.

Also add a tracepoint to show the transmission and completion of the
probes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/internal.h          |  1 +
 fs/afs/vl_list.c           |  2 ++
 fs/afs/vl_probe.c          | 20 ++++++++++++++++++--
 include/trace/events/afs.h | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9a1e151e77e7..88db04220773 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -447,6 +447,7 @@ struct afs_vlserver {
 	rwlock_t		lock;		/* Lock on addresses */
 	refcount_t		ref;
 	unsigned int		rtt;		/* Server's current RTT in uS */
+	unsigned int		debug_id;
 
 	/* Probe state */
 	wait_queue_head_t	probe_wq;
diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index 5c4cd71caccf..9b1c20daac53 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -13,6 +13,7 @@ struct afs_vlserver *afs_alloc_vlserver(const char *name, size_t name_len,
 					unsigned short port)
 {
 	struct afs_vlserver *vlserver;
+	static atomic_t debug_ids;
 
 	vlserver = kzalloc(struct_size(vlserver, name, name_len + 1),
 			   GFP_KERNEL);
@@ -21,6 +22,7 @@ struct afs_vlserver *afs_alloc_vlserver(const char *name, size_t name_len,
 		rwlock_init(&vlserver->lock);
 		init_waitqueue_head(&vlserver->probe_wq);
 		spin_lock_init(&vlserver->probe_lock);
+		vlserver->debug_id = atomic_inc_return(&debug_ids);
 		vlserver->rtt = UINT_MAX;
 		vlserver->name_len = name_len;
 		vlserver->service_id = VL_SERVICE;
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index f868ae5d40e5..b128dc3d8af7 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -131,6 +131,7 @@ void afs_vlserver_probe_result(struct afs_call *call)
 out:
 	spin_unlock(&server->probe_lock);
 
+	trace_afs_vl_probe(server, false, alist, index, call->error, call->abort_code, rtt_us);
 	_debug("probe [%u][%u] %pISpc rtt=%d ret=%d",
 	       server_index, index, rxrpc_kernel_remote_addr(addr->peer),
 	       rtt_us, ret);
@@ -150,8 +151,10 @@ static bool afs_do_probe_vlserver(struct afs_net *net,
 {
 	struct afs_addr_list *alist;
 	struct afs_call *call;
-	unsigned int index;
+	unsigned long unprobed;
+	unsigned int index, i;
 	bool in_progress = false;
+	int best_prio;
 
 	_enter("%s", server->name);
 
@@ -165,7 +168,20 @@ static bool afs_do_probe_vlserver(struct afs_net *net,
 	memset(&server->probe, 0, sizeof(server->probe));
 	server->probe.rtt = UINT_MAX;
 
-	for (index = 0; index < alist->nr_addrs; index++) {
+	unprobed = (1UL << alist->nr_addrs) - 1;
+	while (unprobed) {
+		best_prio = -1;
+		index = 0;
+		for (i = 0; i < alist->nr_addrs; i++) {
+			if (test_bit(i, &unprobed) &&
+			    alist->addrs[i].prio > best_prio) {
+				index = i;
+				best_prio = alist->addrs[i].prio;
+			}
+		}
+		__clear_bit(index, &unprobed);
+
+		trace_afs_vl_probe(server, true, alist, index, 0, 0, 0);
 		call = afs_vl_get_capabilities(net, alist, index, key, server,
 					       server_index);
 		if (!IS_ERR(call)) {
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 81eb87fbcfa7..f1815b3dafb0 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1420,6 +1420,40 @@ TRACE_EVENT(afs_fs_probe,
 		      &__entry->srx.transport)
 	    );
 
+TRACE_EVENT(afs_vl_probe,
+	    TP_PROTO(struct afs_vlserver *server, bool tx, struct afs_addr_list *alist,
+		     unsigned int addr_index, int error, s32 abort_code, unsigned int rtt_us),
+
+	    TP_ARGS(server, tx, alist, addr_index, error, abort_code, rtt_us),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		server)
+		    __field(bool,			tx)
+		    __field(unsigned short,		flags)
+		    __field(u16,			addr_index)
+		    __field(short,			error)
+		    __field(s32,			abort_code)
+		    __field(unsigned int,		rtt_us)
+		    __field_struct(struct sockaddr_rxrpc, srx)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->server = server->debug_id;
+		    __entry->tx = tx;
+		    __entry->addr_index = addr_index;
+		    __entry->error = error;
+		    __entry->abort_code = abort_code;
+		    __entry->rtt_us = rtt_us;
+		    memcpy(&__entry->srx, rxrpc_kernel_remote_srx(alist->addrs[addr_index].peer),
+			   sizeof(__entry->srx));
+			   ),
+
+	    TP_printk("vl=%08x %s ax=%u e=%d ac=%d rtt=%d %pISpc",
+		      __entry->server, __entry->tx ? "tx" : "rx", __entry->addr_index,
+		      __entry->error, __entry->abort_code, __entry->rtt_us,
+		      &__entry->srx.transport)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */


