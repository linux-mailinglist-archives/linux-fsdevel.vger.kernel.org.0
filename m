Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A38124FDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 18:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLRRzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 12:55:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48964 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727130AbfLRRzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576691708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jk7ns5MTns/445e01ST4cOo/+htaVN+sTnQQIw3LJPg=;
        b=SLKqon3l141RNSAA0xqIC9yNCBQoZfBSKw6RBF3P0ssd3RrYYrgpz3qC/jxTBC0Ky3JeKX
        aBQFzaXd/bKK9Qqlmzg8kWVzm0v/+fS9EAVSfsA64/psEchT7otkTB7o1GV/1N80XCCT7X
        VtDoQj24TltcxsFi7oQswzxtOlmGe8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-eR5x0ZNEMt23AIjS31ooFg-1; Wed, 18 Dec 2019 12:55:02 -0500
X-MC-Unique: eR5x0ZNEMt23AIjS31ooFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB6A4DB60;
        Wed, 18 Dec 2019 17:55:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06EF126DEE;
        Wed, 18 Dec 2019 17:54:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] rxrpc: Don't take call->user_mutex in
 rxrpc_new_incoming_call()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Dec 2019 17:54:58 +0000
Message-ID: <157669169826.21991.16708899415880562587.stgit@warthog.procyon.org.uk>
In-Reply-To: <157669169065.21991.15207045893761573624.stgit@warthog.procyon.org.uk>
References: <157669169065.21991.15207045893761573624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Standard kernel mutexes cannot be used in any way from interrupt or softirq
context, so the user_mutex which manages access to a call cannot be a mutex
since on a new call the mutex must start off locked and be unlocked within
the softirq handler to prevent userspace interfering with a call we're
setting up.

Commit a0855d24fc22d49cdc25664fb224caee16998683 ("locking/mutex: Complain
upon mutex API misuse in IRQ contexts") causes big warnings to be splashed
in dmesg for each a new call that comes in from the server.  Whilst it
*seems* like it should be okay, since the accept path uses trylock, there
are issues with PI boosting and marking the wrong task as the owner.

Fix this by not taking the mutex in the softirq path at all.  It's not
obvious that there should be any need for it as the state is set before the
first notification is generated for the new call.

There's also no particular reason why the link-assessing ping should be
triggered inside the mutex.  It's not actually transmitted there anyway,
but rather it has to be deferred to a workqueue.

Further, I don't think that there's any particular reason that the socket
notification needs to be done from within rx->incoming_lock, so the amount
of time that lock is held can be shortened too and the ping prepared before
the new call notification is sent.

Fixes: 540b1c48c37a ("rxrpc: Fix deadlock between call creation and sendmsg/recvmsg")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
cc: Ingo Molnar <mingo@redhat.com>
cc: Will Deacon <will@kernel.org>
cc: Davidlohr Bueso <dave@stgolabs.net>
---

 net/rxrpc/call_accept.c |   20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 3685b1732f65..44fa22b020ef 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -381,18 +381,6 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 	trace_rxrpc_receive(call, rxrpc_receive_incoming,
 			    sp->hdr.serial, sp->hdr.seq);
 
-	/* Lock the call to prevent rxrpc_kernel_send/recv_data() and
-	 * sendmsg()/recvmsg() inconveniently stealing the mutex once the
-	 * notification is generated.
-	 *
-	 * The BUG should never happen because the kernel should be well
-	 * behaved enough not to access the call before the first notification
-	 * event and userspace is prevented from doing so until the state is
-	 * appropriate.
-	 */
-	if (!mutex_trylock(&call->user_mutex))
-		BUG();
-
 	/* Make the call live. */
 	rxrpc_incoming_call(rx, call, skb);
 	conn = call->conn;
@@ -433,6 +421,9 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 		BUG();
 	}
 	spin_unlock(&conn->state_lock);
+	spin_unlock(&rx->incoming_lock);
+
+	rxrpc_send_ping(call, skb);
 
 	if (call->state == RXRPC_CALL_SERVER_ACCEPTING)
 		rxrpc_notify_socket(call);
@@ -444,11 +435,6 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 	 */
 	rxrpc_put_call(call, rxrpc_call_put);
 
-	spin_unlock(&rx->incoming_lock);
-
-	rxrpc_send_ping(call, skb);
-	mutex_unlock(&call->user_mutex);
-
 	_leave(" = %p{%d}", call, call->debug_id);
 	return call;
 

