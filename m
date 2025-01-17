Return-Path: <linux-fsdevel+bounces-39542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA84A15754
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502F2164F67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0E11E7C3F;
	Fri, 17 Jan 2025 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsBNZh4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D71E573D
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139096; cv=none; b=moIr/vUjuRBC+QSIFfshzocGiuGQDwtaK+isR4W/AqSnFcHhj9LELjLoRJDvX4mnWZdxJUdW5WaleS6uMkXXrNWrQndvkvc5PjspSfnxOLDwkbQCfO0EGLTY3Z+Pw57emKnQlQ51Zw+dtUkJGiyWG/DNBQMfx8pJNNBRYep/0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139096; c=relaxed/simple;
	bh=A8Scky0OSRO1JfZCXbqO5/MUxTXn6pnbjwov6Z5AwNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBOdoQgzHOsz5LcgFzZIZosrkroKxWW5i4En7TLAM9VpJGcNwv/AJc0oR5tuFqFEx7jnLMh+sWUfrXE+2NbWvl2k/aYqQCDfqkqLZQ5e2a3n6qAKWUMEYBUnYK7sRX5SQxWrXnlWcKjbYBLQZYa0qsl3FwBUPPvPJtfP9zGDZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsBNZh4f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUdIHvshqbDI3SKJG7zZrNXQynWh0xsi1VxwXXTYC50=;
	b=EsBNZh4fgP7VkhxA+cg5ZEbsdSvS1QM/orGbC4rkQqDvZndZV8Jeu5hIABLFlU0EwLCs4Z
	Kva+CvYVN0m6nLWRtI3H+eWzfTQ0tq7Jr9Zh3O0HPrC+5JUTipjT1+239C7DKojTSOLDGy
	x103O1ztFkT78XdYeskQ1/CLp8Ea1xI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-dfIR3iOXMUSq95idAxcj6w-1; Fri,
 17 Jan 2025 13:38:10 -0500
X-MC-Unique: dfIR3iOXMUSq95idAxcj6w-1
X-Mimecast-MFC-AGG-ID: dfIR3iOXMUSq95idAxcj6w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C34919560B4;
	Fri, 17 Jan 2025 18:38:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43D7E1955F10;
	Fri, 17 Jan 2025 18:38:04 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: David Howells <dhowells@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 24/24] rxrpc: rxgk: Implement connection rekeying
Date: Fri, 17 Jan 2025 18:35:33 +0000
Message-ID: <20250117183538.881618-25-dhowells@redhat.com>
In-Reply-To: <20250117183538.881618-1-dhowells@redhat.com>
References: <20250117183538.881618-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Implement rekeying of connections with the RxGK security class.  This
involves regenerating the keys with a different key number as part of the
input data after a certain amount of time or a certain amount of bytes
encrypted.  Rekeying may be triggered by either end.

The LSW of the key number is inserted into the security-specific field in
the RX header, and we try and expand it to 32-bits to make it last longer.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |   5 +-
 net/rxrpc/conn_object.c |   1 +
 net/rxrpc/rxgk.c        | 156 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 155 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 736dc6ea20ac..e00f3b0edc98 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -533,11 +533,14 @@ struct rxrpc_connection {
 			u32	nonce;		/* response re-use preventer */
 		} rxkad;
 		struct {
-			struct rxgk_context *keys[1];
+			struct rxgk_context *keys[4]; /* (Re-)keying buffer */
 			u64	start_time;	/* The start time for TK derivation */
 			u8	nonce[20];	/* Response re-use preventer */
+			u32	key_number;	/* Current key number */
 		} rxgk;
 	};
+	rwlock_t		security_use_lock; /* Security use/modification lock */
+
 	unsigned long		flags;
 	unsigned long		events;
 	unsigned long		idle_timestamp;	/* Time at which last became idle */
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 7eba4d7d9a38..56459b00266d 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -72,6 +72,7 @@ struct rxrpc_connection *rxrpc_alloc_connection(struct rxrpc_net *rxnet,
 		skb_queue_head_init(&conn->rx_queue);
 		conn->rxnet = rxnet;
 		conn->security = &rxrpc_no_security;
+		rwlock_init(&conn->security_use_lock);
 		spin_lock_init(&conn->state_lock);
 		conn->debug_id = atomic_inc_return(&rxrpc_debug_id);
 		conn->idle_timestamp = jiffies;
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 9c5c616c40cb..367d65aa7731 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -76,11 +76,153 @@ static void rxgk_describe_server_key(const struct key *key, struct seq_file *m)
 		seq_printf(m, ": %s", krb5->name);
 }
 
+/*
+ * Handle rekeying the connection when we see our limits overrun or when the
+ * far side decided to rekey.
+ *
+ * Returns a ref on the context if successful or -ESTALE if the key is out of
+ * date.
+ */
+static struct rxgk_context *rxgk_rekey(struct rxrpc_connection *conn,
+				       const u16 *specific_key_number)
+{
+	struct rxgk_context *gk, *dead = NULL;
+	unsigned int key_number, current_key, mask = ARRAY_SIZE(conn->rxgk.keys) - 1;
+	bool crank = false;
+
+	_enter("%d", specific_key_number ? *specific_key_number : -1);
+
+	mutex_lock(&conn->security_lock);
+
+	current_key = conn->rxgk.key_number;
+	if (!specific_key_number) {
+		key_number = current_key;
+	} else {
+		if (*specific_key_number == (u16)current_key)
+			key_number = current_key;
+		else if (*specific_key_number == (u16)(current_key - 1))
+			key_number = current_key - 1;
+		else if (*specific_key_number == (u16)(current_key + 1))
+			goto crank_window;
+		else
+			goto bad_key;
+	}
+
+	gk = conn->rxgk.keys[key_number & mask];
+	if (!gk)
+		goto generate_key;
+	if (!specific_key_number &&
+	    test_bit(RXGK_TK_NEEDS_REKEY, &gk->flags))
+		goto crank_window;
+
+grab:
+	refcount_inc(&gk->usage);
+	mutex_unlock(&conn->security_lock);
+	rxgk_put(dead);
+	return gk;
+
+crank_window:
+	if (current_key == UINT_MAX)
+		goto bad_key;
+	if (current_key + 1 == UINT_MAX)
+		set_bit(RXRPC_CONN_DONT_REUSE, &conn->flags);
+
+	key_number = current_key + 1;
+	if (WARN_ON(conn->rxgk.keys[key_number & mask]))
+		goto bad_key;
+	crank = true;
+
+generate_key:
+	gk = conn->rxgk.keys[current_key & mask];
+	gk = rxgk_generate_transport_key(conn, gk->key, key_number, GFP_NOFS);
+	if (IS_ERR(gk)) {
+		mutex_unlock(&conn->security_lock);
+		return gk;
+	}
+
+	write_lock(&conn->security_use_lock);
+	if (crank) {
+		current_key++;
+		conn->rxgk.key_number = current_key;
+		dead = conn->rxgk.keys[(current_key - 2) & mask];
+		conn->rxgk.keys[(current_key - 2) & mask] = NULL;
+	}
+	conn->rxgk.keys[current_key & mask] = gk;
+	write_unlock(&conn->security_use_lock);
+	goto grab;
+
+bad_key:
+	mutex_unlock(&conn->security_lock);
+	return ERR_PTR(-ESTALE);
+}
+
+/*
+ * Get the specified keying context.
+ *
+ * Returns a ref on the context if successful or -ESTALE if the key is out of
+ * date.
+ */
 static struct rxgk_context *rxgk_get_key(struct rxrpc_connection *conn,
-					 u16 *specific_key_number)
+					 const u16 *specific_key_number)
 {
-	refcount_inc(&conn->rxgk.keys[0]->usage);
-	return conn->rxgk.keys[0];
+	struct rxgk_context *gk;
+	unsigned int key_number, current_key, mask = ARRAY_SIZE(conn->rxgk.keys) - 1;
+
+	_enter("{%u},%d",
+	       conn->rxgk.key_number, specific_key_number ? *specific_key_number : -1);
+
+	read_lock(&conn->security_use_lock);
+
+	current_key = conn->rxgk.key_number;
+	if (!specific_key_number) {
+		key_number = current_key;
+	} else {
+		/* Only the bottom 16 bits of the key number are exposed in the
+		 * header, so we try and keep the upper 16 bits in step.  The
+		 * whole 32 bits are used to generate the TK.
+		 */
+		if (*specific_key_number == (u16)current_key)
+			key_number = current_key;
+		else if (*specific_key_number == (u16)(current_key - 1))
+			key_number = current_key - 1;
+		else if (*specific_key_number == (u16)(current_key + 1))
+			goto rekey;
+		else
+			goto bad_key;
+	}
+
+	gk = conn->rxgk.keys[key_number & mask];
+	if (!gk)
+		goto slow_path;
+	if (!specific_key_number &&
+	    key_number < UINT_MAX) {
+		if (time_after(jiffies, gk->expiry) ||
+		    gk->bytes_remaining < 0) {
+			set_bit(RXGK_TK_NEEDS_REKEY, &gk->flags);
+			goto slow_path;
+		}
+
+		if (test_bit(RXGK_TK_NEEDS_REKEY, &gk->flags))
+			goto slow_path;
+	}
+
+	refcount_inc(&gk->usage);
+	read_unlock(&conn->security_use_lock);
+	return gk;
+
+rekey:
+	_debug("rekey");
+	if (current_key == UINT_MAX)
+		goto bad_key;
+	gk = conn->rxgk.keys[current_key & mask];
+	if (gk)
+		set_bit(RXGK_TK_NEEDS_REKEY, &gk->flags);
+slow_path:
+	read_unlock(&conn->security_use_lock);
+	return rxgk_rekey(conn, specific_key_number);
+bad_key:
+	read_unlock(&conn->security_use_lock);
+	return ERR_PTR(-ESTALE);
 }
 
 /*
@@ -92,7 +234,8 @@ static int rxgk_init_connection_security(struct rxrpc_connection *conn,
 	struct rxgk_context *gk;
 	int ret;
 
-	_enter("{%d},{%x}", conn->debug_id, key_serial(conn->key));
+	_enter("{%d,%u},{%x}",
+	       conn->debug_id, conn->rxgk.key_number, key_serial(conn->key));
 
 	conn->security_ix = token->security_index;
 	conn->security_level = token->rxgk->level;
@@ -102,10 +245,11 @@ static int rxgk_init_connection_security(struct rxrpc_connection *conn,
 		do_div(conn->rxgk.start_time, 100);
 	}
 
-	gk = rxgk_generate_transport_key(conn, token->rxgk, 0, GFP_NOFS);
+	gk = rxgk_generate_transport_key(conn, token->rxgk, conn->rxgk.key_number,
+					 GFP_NOFS);
 	if (IS_ERR(gk))
 		return PTR_ERR(gk);
-	conn->rxgk.keys[0] = gk;
+	conn->rxgk.keys[gk->key_number & 3] = gk;
 
 	switch (conn->security_level) {
 	case RXRPC_SECURITY_PLAIN:


