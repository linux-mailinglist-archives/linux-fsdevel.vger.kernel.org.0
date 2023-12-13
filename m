Return-Path: <linux-fsdevel+bounces-5881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F11181138E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20AF1C21165
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281942D7BA;
	Wed, 13 Dec 2023 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICtDV/sF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1368010A
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0G9cfB/SMcsuQUP6NSXMvLH/gTThJ4V8NgpcMlTJhZ4=;
	b=ICtDV/sFR5tybF92QFXEFfZUONOzSYpQ5AWU24xS4XH2HEmOJJQlw1TTqk0mJlbgW2lgh3
	TxnEp+1iwbuve67Ns4izlZ4rDLRgw75poN0zaPuMvN+XJwfynsVkug0V1eEpIlQe7P38UM
	B99Htl/+Lob0f5ZtZFV2EDcfTsziwaQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-FYgpMzeqMsCvhG2fnYPSqw-1; Wed, 13 Dec 2023 08:50:48 -0500
X-MC-Unique: FYgpMzeqMsCvhG2fnYPSqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 259D483718B;
	Wed, 13 Dec 2023 13:50:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C96D3C25;
	Wed, 13 Dec 2023 13:50:47 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/40] afs: Dispatch fileserver probes in priority order
Date: Wed, 13 Dec 2023 13:49:48 +0000
Message-ID: <20231213135003.367397-27-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

When probing all the addresses for a fileserver, dispatch them in order of
descending priority to try and get back highest priority one first.

Also add a tracepoint to show the transmission and completion of the
probes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_probe.c          | 25 +++++++++++++++++++++++--
 include/trace/events/afs.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 8008d3ecabab..c5702698b18b 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -102,7 +102,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	struct afs_address *addr = &alist->addrs[call->probe_index];
 	struct afs_server *server = call->server;
 	unsigned int index = call->probe_index;
-	unsigned int rtt_us = 0, cap0;
+	unsigned int rtt_us = -1, cap0;
 	int ret = call->error;
 
 	_enter("%pU,%u", &server->uuid, index);
@@ -182,6 +182,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 out:
 	spin_unlock(&server->probe_lock);
 
+	trace_afs_fs_probe(server, false, alist, index, call->error, call->abort_code, rtt_us);
 	_debug("probe %pU [%u] %pISpc rtt=%d ret=%d",
 	       &server->uuid, index, rxrpc_kernel_remote_addr(alist->addrs[index].peer),
 	       rtt_us, ret);
@@ -207,6 +208,8 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 	afs_get_addrlist(alist, afs_alist_trace_get_probe);
 	read_unlock(&server->fs_lock);
 
+	afs_get_address_preferences(net, alist);
+
 	server->probed_at = jiffies;
 	atomic_set(&server->probe_outstanding, all ? alist->nr_addrs : 1);
 	memset(&server->probe, 0, sizeof(server->probe));
@@ -217,10 +220,28 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 		all = true;
 
 	if (all) {
-		for (index = 0; index < alist->nr_addrs; index++)
+		unsigned long unprobed = (1UL << alist->nr_addrs) - 1;
+		unsigned int i;
+		int best_prio;
+
+		while (unprobed) {
+			best_prio = -1;
+			index = 0;
+			for (i = 0; i < alist->nr_addrs; i++) {
+				if (test_bit(i, &unprobed) &&
+				    alist->addrs[i].prio > best_prio) {
+					index = i;
+					best_prio = alist->addrs[i].prio;
+				}
+			}
+			__clear_bit(index, &unprobed);
+
+			trace_afs_fs_probe(server, true, alist, index, 0, 0, 0);
 			if (!afs_fs_get_capabilities(net, server, alist, index, key))
 				afs_fs_probe_not_done(net, server, alist, index);
+		}
 	} else {
+		trace_afs_fs_probe(server, true, alist, index, 0, 0, 0);
 		if (!afs_fs_get_capabilities(net, server, alist, index, key))
 			afs_fs_probe_not_done(net, server, alist, index);
 	}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 0f68d67f52c8..81eb87fbcfa7 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1387,6 +1387,39 @@ TRACE_EVENT(afs_alist,
 		      __entry->ref)
 	    );
 
+TRACE_EVENT(afs_fs_probe,
+	    TP_PROTO(struct afs_server *server, bool tx, struct afs_addr_list *alist,
+		     unsigned int addr_index, int error, s32 abort_code, unsigned int rtt_us),
+
+	    TP_ARGS(server, tx, alist, addr_index, error, abort_code, rtt_us),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		server)
+		    __field(bool,			tx)
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
+	    TP_printk("s=%08x %s ax=%u e=%d ac=%d rtt=%d %pISpc",
+		      __entry->server, __entry->tx ? "tx" : "rx", __entry->addr_index,
+		      __entry->error, __entry->abort_code, __entry->rtt_us,
+		      &__entry->srx.transport)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */


