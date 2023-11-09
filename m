Return-Path: <linux-fsdevel+bounces-2542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A37E6D8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40206B20FB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8072033C;
	Thu,  9 Nov 2023 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbQKuI/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4AC1E51F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D72126
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIRKJKYk5lqpZVgcQZO8u+r3e8JqejlZWV7XzM09Qts=;
	b=IbQKuI/sQhOBBzxhYnbrsZS72ERjgb8OT6eSxGP4a6eexC/kTJzda1TDUH/av3Jc++RVNx
	wuxvJnRsh0S1vUokdDJuBLgSzkq93vRWFSp1pahLZhBBNWpaE72YHfGKRUtJub+usfZQ8J
	sRQVygqBx2bWGgJDjjVh7qe9scTQSBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-GZkSwq0xMsm6V_CGrnWy9Q-1; Thu, 09 Nov 2023 10:40:12 -0500
X-MC-Unique: GZkSwq0xMsm6V_CGrnWy9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1F25101A529;
	Thu,  9 Nov 2023 15:40:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EBEF51C060AE;
	Thu,  9 Nov 2023 15:40:10 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/41] rxrpc: Fix RTT determination to use PING ACKs as a source
Date: Thu,  9 Nov 2023 15:39:24 +0000
Message-ID: <20231109154004.3317227-2-dhowells@redhat.com>
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

Fix RTT determination to use a PING ACK that is in marked as being in
response to a DATA packet as the response from which RTT can be calculated
from in lieu of a REQUESTED ACK.  The server may send the latter instead of
the former.

Fixes: 4700c4d80b7b ("rxrpc: Fix loss of RTT samples due to interposed ACK")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 030d64f282f3..fc0d404f3b91 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -806,6 +806,10 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
 					 rxrpc_rtt_rx_ping_response);
 		break;
+	case RXRPC_ACK_PING:
+		if (acked_serial == 0)
+			break;
+		fallthrough;
 	case RXRPC_ACK_REQUESTED:
 		rxrpc_complete_rtt_probe(call, skb->tstamp, acked_serial, ack_serial,
 					 rxrpc_rtt_rx_requested_ack);


