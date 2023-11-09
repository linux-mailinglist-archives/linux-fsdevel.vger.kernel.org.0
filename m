Return-Path: <linux-fsdevel+bounces-2544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BD87E6D91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817FF2810F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1E420B14;
	Thu,  9 Nov 2023 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl7YEqAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D2208D8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539E6358C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwRdN9r8m/J8OsPVvLUXF8vAvTPiY2k6pt1MGY6dBcU=;
	b=Cl7YEqATGt7EKz/dvvQhetEGMWT4lYVipn2SNXitiPtn7vdmA7VY688+ZZN/JvcG8AblgL
	BsypmnYj7uOJUzq/56KGHPnrYg1Lwhxsj8QCTSpoyfNc3WUXADPklODWeYNfz36AmxprXI
	eTG4JwiGWfDxHkInOJDccurPsMYAD0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-7fC5TsCzO-qeexNDnZzwrg-1; Thu, 09 Nov 2023 10:40:15 -0500
X-MC-Unique: 7fC5TsCzO-qeexNDnZzwrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DE04828AC1;
	Thu,  9 Nov 2023 15:40:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5797D1C060AE;
	Thu,  9 Nov 2023 15:40:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/41] rxrpc: Fix some minor issues with bundle tracing
Date: Thu,  9 Nov 2023 15:39:26 +0000
Message-ID: <20231109154004.3317227-4-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Fix some superficial issues with the tracing of rxrpc_bundle structs,
including:

 (1) Set the debug_id when the bundle is allocated rather than when it is
     set up so that the "NEW" trace line displays the correct bundle ID.

 (2) Show the refcount when emitting the "FREE" traceline.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/conn_client.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 981ca5b98bcb..1d95f8bc769f 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -73,6 +73,7 @@ static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
 static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 					       gfp_t gfp)
 {
+	static atomic_t rxrpc_bundle_id;
 	struct rxrpc_bundle *bundle;
 
 	bundle = kzalloc(sizeof(*bundle), gfp);
@@ -85,6 +86,7 @@ static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 		bundle->upgrade		= test_bit(RXRPC_CALL_UPGRADE, &call->flags);
 		bundle->service_id	= call->dest_srx.srx_service;
 		bundle->security_level	= call->security_level;
+		bundle->debug_id	= atomic_inc_return(&rxrpc_bundle_id);
 		refcount_set(&bundle->ref, 1);
 		atomic_set(&bundle->active, 1);
 		INIT_LIST_HEAD(&bundle->waiting_calls);
@@ -105,7 +107,8 @@ struct rxrpc_bundle *rxrpc_get_bundle(struct rxrpc_bundle *bundle,
 
 static void rxrpc_free_bundle(struct rxrpc_bundle *bundle)
 {
-	trace_rxrpc_bundle(bundle->debug_id, 1, rxrpc_bundle_free);
+	trace_rxrpc_bundle(bundle->debug_id, refcount_read(&bundle->ref),
+			   rxrpc_bundle_free);
 	rxrpc_put_peer(bundle->peer, rxrpc_peer_put_bundle);
 	key_put(bundle->key);
 	kfree(bundle);
@@ -239,7 +242,6 @@ static bool rxrpc_may_reuse_conn(struct rxrpc_connection *conn)
  */
 int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
 {
-	static atomic_t rxrpc_bundle_id;
 	struct rxrpc_bundle *bundle, *candidate;
 	struct rxrpc_local *local = call->local;
 	struct rb_node *p, **pp, *parent;
@@ -306,7 +308,6 @@ int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
 	}
 
 	_debug("new bundle");
-	candidate->debug_id = atomic_inc_return(&rxrpc_bundle_id);
 	rb_link_node(&candidate->local_node, parent, pp);
 	rb_insert_color(&candidate->local_node, &local->client_bundles);
 	call->bundle = rxrpc_get_bundle(candidate, rxrpc_bundle_get_client_call);


