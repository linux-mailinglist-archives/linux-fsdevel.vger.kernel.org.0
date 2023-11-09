Return-Path: <linux-fsdevel+bounces-2543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42887E6D90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00ED01C20B73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C1208CD;
	Thu,  9 Nov 2023 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxbGeHrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6320332
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7A35AB
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyBoCbElMBWTxv8fACt2i5x96KxhIHRnkO6so+DaPzc=;
	b=AxbGeHrDyFhwxqLXlJqGJjPvwkX0dNy0bRU+K0E6dJKeMs3u3VpaER0VKI+Dwk1liJRu1R
	qjeFOjqdl8CgBPWDj8A/xYLFE2pfwEuzuf1vVS6tXvuO5TFC5/t5NFKbUTDgZFzn8bMBtz
	uZf3PKVPRxZnSg26/cklRxwhEac2kwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-XzmQuWuwO7OKmcbrwpdI4Q-1; Thu, 09 Nov 2023 10:40:14 -0500
X-MC-Unique: XzmQuWuwO7OKmcbrwpdI4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B26E8185A782;
	Thu,  9 Nov 2023 15:40:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 605AB492BE7;
	Thu,  9 Nov 2023 15:40:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 02/41] rxrpc: Fix two connection reaping bugs
Date: Thu,  9 Nov 2023 15:39:25 +0000
Message-ID: <20231109154004.3317227-3-dhowells@redhat.com>
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

Fix two connection reaping bugs:

 (1) rxrpc_connection_expiry is in units of seconds, so
     rxrpc_disconnect_call() needs to multiply it by HZ when adding it to
     jiffies.

 (2) rxrpc_client_conn_reap_timeout() should set RXRPC_CLIENT_REAP_TIMER if
     local->kill_all_client_conns is clear, not if it is set (in which case
     we don't need the timer).  Without this, old client connections don't
     get cleaned up until the local endpoint is cleaned up.

Fixes: 5040011d073d ("rxrpc: Make the local endpoint hold a ref on a connected call")
Fixes: 0d6bf319bc5a ("rxrpc: Move the client conn cache management to the I/O thread")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/conn_object.c  | 2 +-
 net/rxrpc/local_object.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index ac85d4644a3c..df8a271948a1 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -212,7 +212,7 @@ void rxrpc_disconnect_call(struct rxrpc_call *call)
 		conn->idle_timestamp = jiffies;
 		if (atomic_dec_and_test(&conn->active))
 			rxrpc_set_service_reap_timer(conn->rxnet,
-						     jiffies + rxrpc_connection_expiry);
+						     jiffies + rxrpc_connection_expiry * HZ);
 	}
 
 	rxrpc_put_call(call, rxrpc_call_put_io_thread);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 7d910aee4f8c..c553a30e9c83 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -87,7 +87,7 @@ static void rxrpc_client_conn_reap_timeout(struct timer_list *timer)
 	struct rxrpc_local *local =
 		container_of(timer, struct rxrpc_local, client_conn_reap_timer);
 
-	if (local->kill_all_client_conns &&
+	if (!local->kill_all_client_conns &&
 	    test_and_set_bit(RXRPC_CLIENT_CONN_REAP_TIMER, &local->client_conn_flags))
 		rxrpc_wake_up_io_thread(local);
 }


