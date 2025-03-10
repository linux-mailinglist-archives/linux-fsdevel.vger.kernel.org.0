Return-Path: <linux-fsdevel+bounces-43580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E1EA58FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FD13A9ABE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA0226D11;
	Mon, 10 Mar 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPnSxMQ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EFC226CEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599761; cv=none; b=Cvg24EOTpi6nNu0p3ZZgehqw8asZiyVTDuvmeA4+10O4wJ+kPfLgBiWIzocDNWsJq7OjanaAu1tkxM20lKUqy+DkobY3iCXOG2pDt9mbg75s9Y8dqYEvl7BwTU5k3mZpwyNCm6jtupziMsjIYoy15SLHAsg3TADDpBinbeWXrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599761; c=relaxed/simple;
	bh=WsSlObPfD4aENaB3Lb+zEttK3URw04/ulYNruPEVpX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5qo0vSmc+GPLmIb7hkpuKRJKePKdFtqL/W6vMbDosCnFJDWRDVlzFrNxAn/Xb6xfmJ8pA7XMZ2hedeZtqT6K2l7OOlfJZs848xi7mVmiqCsEQBDP5vqyIYls8zyzQkqrkttFS3qqR/tu0cOAQ3UmQGcGVRP4n0kQtg2L6YP4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPnSxMQ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cK53t25WsPqUvTA/J/SQdQUAcMOGh2IVjnO7sToojgk=;
	b=WPnSxMQ4gIVYiKyWvZqgf65Niq4+ebwRHOh78grQNoQEINRJKh3nSB7qoccPMy/XFzdNHH
	t/y4G7OkSjnCK2DxdJctGmZ9XQi7OzuiTdHJm4VZ410ztlTINo2MjJTWAmzkOr1YwCdk2k
	WaZayyQ7YaFEu8OdltMU/gk9PVMCv5k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-dtOGABG9NU2i8Da6UDZLgA-1; Mon,
 10 Mar 2025 05:42:35 -0400
X-MC-Unique: dtOGABG9NU2i8Da6UDZLgA-1
X-Mimecast-MFC-AGG-ID: dtOGABG9NU2i8Da6UDZLgA_1741599754
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 024511955BC5;
	Mon, 10 Mar 2025 09:42:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5396F1956096;
	Mon, 10 Mar 2025 09:42:32 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/11] afs: Improve server refcount/active count tracing
Date: Mon, 10 Mar 2025 09:41:58 +0000
Message-ID: <20250310094206.801057-6-dhowells@redhat.com>
In-Reply-To: <20250310094206.801057-1-dhowells@redhat.com>
References: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Improve server refcount/active count tracing to distinguish between simply
getting/putting a ref and using/unusing the server record (which changes
the activity count as well as the refcount).  This makes it a bit easier to
work out what's going on.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-10-dhowells@redhat.com/ # v1
---
 fs/afs/fsclient.c          |  4 ++--
 fs/afs/rxrpc.c             |  2 +-
 fs/afs/server.c            | 11 ++++++-----
 fs/afs/server_list.c       |  4 ++--
 include/trace/events/afs.h | 27 +++++++++++++++------------
 5 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 1d9ecd5418d8..9f46d9aebc33 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1653,7 +1653,7 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net, struct afs_server *server,
 	bp = call->request;
 	*bp++ = htonl(FSGIVEUPALLCALLBACKS);
 
-	call->server = afs_use_server(server, afs_server_trace_give_up_cb);
+	call->server = afs_use_server(server, afs_server_trace_use_give_up_cb);
 	afs_make_call(call, GFP_NOFS);
 	afs_wait_for_call_to_complete(call);
 	ret = call->error;
@@ -1760,7 +1760,7 @@ bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
 		return false;
 
 	call->key	= key;
-	call->server	= afs_use_server(server, afs_server_trace_get_caps);
+	call->server	= afs_use_server(server, afs_server_trace_use_get_caps);
 	call->peer	= rxrpc_kernel_get_peer(estate->addresses->addrs[addr_index].peer);
 	call->probe	= afs_get_endpoint_state(estate, afs_estate_trace_get_getcaps);
 	call->probe_index = addr_index;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 886416ea1d96..de9e10575bdd 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -179,7 +179,7 @@ static void afs_free_call(struct afs_call *call)
 	if (call->type->destructor)
 		call->type->destructor(call);
 
-	afs_unuse_server_notime(call->net, call->server, afs_server_trace_put_call);
+	afs_unuse_server_notime(call->net, call->server, afs_server_trace_unuse_call);
 	kfree(call->request);
 
 	o = atomic_read(&net->nr_outstanding_calls);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 4504e16b458c..923e07c37032 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -33,7 +33,7 @@ struct afs_server *afs_find_server(struct afs_net *net, const struct rxrpc_peer
 
 	do {
 		if (server)
-			afs_unuse_server_notime(net, server, afs_server_trace_put_find_rsq);
+			afs_unuse_server_notime(net, server, afs_server_trace_unuse_find_rsq);
 		server = NULL;
 		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
@@ -49,7 +49,7 @@ struct afs_server *afs_find_server(struct afs_net *net, const struct rxrpc_peer
 		server = NULL;
 		continue;
 	found:
-		server = afs_maybe_use_server(server, afs_server_trace_get_by_addr);
+		server = afs_maybe_use_server(server, afs_server_trace_use_by_addr);
 
 	} while (need_seqretry(&net->fs_addr_lock, seq));
 
@@ -76,7 +76,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 		 * changes.
 		 */
 		if (server)
-			afs_unuse_server(net, server, afs_server_trace_put_uuid_rsq);
+			afs_unuse_server(net, server, afs_server_trace_unuse_uuid_rsq);
 		server = NULL;
 		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_lock, &seq);
@@ -91,7 +91,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 			} else if (diff > 0) {
 				p = p->rb_right;
 			} else {
-				afs_use_server(server, afs_server_trace_get_by_uuid);
+				afs_use_server(server, afs_server_trace_use_by_uuid);
 				break;
 			}
 
@@ -273,7 +273,8 @@ static struct afs_addr_list *afs_vl_lookup_addrs(struct afs_cell *cell,
 }
 
 /*
- * Get or create a fileserver record.
+ * Get or create a fileserver record and return it with an active-use count on
+ * it.
  */
 struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 				     const uuid_t *uuid, u32 addr_version)
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index d20cd902ef94..784236b9b2a9 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -16,7 +16,7 @@ void afs_put_serverlist(struct afs_net *net, struct afs_server_list *slist)
 	if (slist && refcount_dec_and_test(&slist->usage)) {
 		for (i = 0; i < slist->nr_servers; i++)
 			afs_unuse_server(net, slist->servers[i].server,
-					 afs_server_trace_put_slist);
+					 afs_server_trace_unuse_slist);
 		kfree_rcu(slist, rcu);
 	}
 }
@@ -98,7 +98,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 		if (j < slist->nr_servers) {
 			if (slist->servers[j].server == server) {
 				afs_unuse_server(volume->cell->net, server,
-						 afs_server_trace_put_slist_isort);
+						 afs_server_trace_unuse_slist_isort);
 				continue;
 			}
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index cf94bf1e8286..24d99fbc298f 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -132,22 +132,25 @@ enum yfs_cm_operation {
 	EM(afs_server_trace_destroy,		"DESTROY  ") \
 	EM(afs_server_trace_free,		"FREE     ") \
 	EM(afs_server_trace_gc,			"GC       ") \
-	EM(afs_server_trace_get_by_addr,	"GET addr ") \
-	EM(afs_server_trace_get_by_uuid,	"GET uuid ") \
-	EM(afs_server_trace_get_caps,		"GET caps ") \
 	EM(afs_server_trace_get_install,	"GET inst ") \
-	EM(afs_server_trace_get_new_cbi,	"GET cbi  ") \
 	EM(afs_server_trace_get_probe,		"GET probe") \
-	EM(afs_server_trace_give_up_cb,		"giveup-cb") \
 	EM(afs_server_trace_purging,		"PURGE    ") \
-	EM(afs_server_trace_put_call,		"PUT call ") \
 	EM(afs_server_trace_put_cbi,		"PUT cbi  ") \
-	EM(afs_server_trace_put_find_rsq,	"PUT f-rsq") \
 	EM(afs_server_trace_put_probe,		"PUT probe") \
-	EM(afs_server_trace_put_slist,		"PUT slist") \
-	EM(afs_server_trace_put_slist_isort,	"PUT isort") \
-	EM(afs_server_trace_put_uuid_rsq,	"PUT u-req") \
-	E_(afs_server_trace_update,		"UPDATE")
+	EM(afs_server_trace_see_expired,	"SEE expd ") \
+	EM(afs_server_trace_unuse_call,		"UNU call ") \
+	EM(afs_server_trace_unuse_create_fail,	"UNU cfail") \
+	EM(afs_server_trace_unuse_find_rsq,	"UNU f-rsq") \
+	EM(afs_server_trace_unuse_slist,	"UNU slist") \
+	EM(afs_server_trace_unuse_slist_isort,	"UNU isort") \
+	EM(afs_server_trace_unuse_uuid_rsq,	"PUT u-req") \
+	EM(afs_server_trace_update,		"UPDATE   ") \
+	EM(afs_server_trace_use_by_addr,	"USE addr ") \
+	EM(afs_server_trace_use_by_uuid,	"USE uuid ") \
+	EM(afs_server_trace_use_cm_call,	"USE cm-cl") \
+	EM(afs_server_trace_use_get_caps,	"USE gcaps") \
+	EM(afs_server_trace_use_give_up_cb,	"USE gvupc") \
+	E_(afs_server_trace_wait_create,	"WAIT crt ")
 
 #define afs_volume_traces \
 	EM(afs_volume_trace_alloc,		"ALLOC         ") \
@@ -1531,7 +1534,7 @@ TRACE_EVENT(afs_server,
 		    __entry->reason = reason;
 			   ),
 
-	    TP_printk("s=%08x %s u=%d a=%d",
+	    TP_printk("s=%08x %s r=%d a=%d",
 		      __entry->server,
 		      __print_symbolic(__entry->reason, afs_server_traces),
 		      __entry->ref,


