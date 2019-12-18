Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB0B124FDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 18:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLRRzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 12:55:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56059 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727138AbfLRRy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576691697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x/mlg4GGa2aCtPbSlBatjfyqFvuYzfdyE66T7sANnY0=;
        b=bxtG3SUi71oMqF3J0YApbtu0tH2bo+ZRuiVeqPS1oepo1EwgFetObL1MxLyUGfrs11ebVp
        h1abA5PF/Hs/tai2aH9ZnnzGAI15x1+BWTZkgk4vszDboTTXw//Ikb2x1LHgRfd4DtjRtz
        woNk9evu/wqev7AglJkpeRbDi4hG5wI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-cGKh1adtPNKbKudn6dcr4A-1; Wed, 18 Dec 2019 12:54:54 -0500
X-MC-Unique: cGKh1adtPNKbKudn6dcr4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D69D18557C2;
        Wed, 18 Dec 2019 17:54:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 793127C82A;
        Wed, 18 Dec 2019 17:54:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/2] rxrpc: Unlock new call in rxrpc_new_incoming_call()
 rather than the caller
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Dec 2019 17:54:50 +0000
Message-ID: <157669169065.21991.15207045893761573624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the unlock and the ping transmission for a new incoming call into
rxrpc_new_incoming_call() rather than doing it in the caller.  This makes
it clearer to see what's going on.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
cc: Ingo Molnar <mingo@redhat.com>
cc: Will Deacon <will@kernel.org>
cc: Davidlohr Bueso <dave@stgolabs.net>
---

 net/rxrpc/call_accept.c |   36 ++++++++++++++++++++++++++++--------
 net/rxrpc/input.c       |   18 ------------------
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 135bf5cd8dd5..3685b1732f65 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -239,6 +239,22 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 	kfree(b);
 }
 
+/*
+ * Ping the other end to fill our RTT cache and to retrieve the rwind
+ * and MTU parameters.
+ */
+static void rxrpc_send_ping(struct rxrpc_call *call, struct sk_buff *skb)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	ktime_t now = skb->tstamp;
+
+	if (call->peer->rtt_usage < 3 ||
+	    ktime_before(ktime_add_ms(call->peer->rtt_last_req, 1000), now))
+		rxrpc_propose_ACK(call, RXRPC_ACK_PING, sp->hdr.serial,
+				  true, true,
+				  rxrpc_propose_ack_ping_for_params);
+}
+
 /*
  * Allocate a new incoming call from the prealloc pool, along with a connection
  * and a peer as necessary.
@@ -346,9 +362,7 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 				  sp->hdr.seq, RX_INVALID_OPERATION, ESHUTDOWN);
 		skb->mark = RXRPC_SKB_MARK_REJECT_ABORT;
 		skb->priority = RX_INVALID_OPERATION;
-		_leave(" = NULL [close]");
-		call = NULL;
-		goto out;
+		goto no_call;
 	}
 
 	/* The peer, connection and call may all have sprung into existence due
@@ -361,9 +375,7 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 	call = rxrpc_alloc_incoming_call(rx, local, peer, conn, skb);
 	if (!call) {
 		skb->mark = RXRPC_SKB_MARK_REJECT_BUSY;
-		_leave(" = NULL [busy]");
-		call = NULL;
-		goto out;
+		goto no_call;
 	}
 
 	trace_rxrpc_receive(call, rxrpc_receive_incoming,
@@ -432,10 +444,18 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 	 */
 	rxrpc_put_call(call, rxrpc_call_put);
 
-	_leave(" = %p{%d}", call, call->debug_id);
-out:
 	spin_unlock(&rx->incoming_lock);
+
+	rxrpc_send_ping(call, skb);
+	mutex_unlock(&call->user_mutex);
+
+	_leave(" = %p{%d}", call, call->debug_id);
 	return call;
+
+no_call:
+	spin_unlock(&rx->incoming_lock);
+	_leave(" = NULL [%u]", skb->mark);
+	return NULL;
 }
 
 /*
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 157be1ff8697..86bd133b4fa0 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -192,22 +192,6 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	goto out_no_clear_ca;
 }
 
-/*
- * Ping the other end to fill our RTT cache and to retrieve the rwind
- * and MTU parameters.
- */
-static void rxrpc_send_ping(struct rxrpc_call *call, struct sk_buff *skb)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	ktime_t now = skb->tstamp;
-
-	if (call->peer->rtt_usage < 3 ||
-	    ktime_before(ktime_add_ms(call->peer->rtt_last_req, 1000), now))
-		rxrpc_propose_ACK(call, RXRPC_ACK_PING, sp->hdr.serial,
-				  true, true,
-				  rxrpc_propose_ack_ping_for_params);
-}
-
 /*
  * Apply a hard ACK by advancing the Tx window.
  */
@@ -1396,8 +1380,6 @@ int rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 		call = rxrpc_new_incoming_call(local, rx, skb);
 		if (!call)
 			goto reject_packet;
-		rxrpc_send_ping(call, skb);
-		mutex_unlock(&call->user_mutex);
 	}
 
 	/* Process a call packet; this either discards or passes on the ref

