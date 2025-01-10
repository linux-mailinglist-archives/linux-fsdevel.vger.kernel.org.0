Return-Path: <linux-fsdevel+bounces-38771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF65EA08460
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D357A3661
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 01:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6772063D5;
	Fri, 10 Jan 2025 01:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TneRlzrg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA452066DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471047; cv=none; b=dAbJQVCiWmwiiok8/fEwm1hhBfm6TqtvMc+BBlXP8AbCdtjm4eHbZ/sSIHVVkJmjM/SDzs6FQHHs/jKGDVECAWqOC9pjDAxNSs56K8Co/9rbR0izUFvf/LG7eBfwE1kagp4zB1Ppc0QCreSi0J1YiQvwykdyYtCjfTbB6obUCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471047; c=relaxed/simple;
	bh=NDgxNvCoCIk52Ob+AWZHEGqXOXRDfnYGvy3mr9trhnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGSJ3pG5hJ78VdV49TMIwj0DJoNQwoON3H7E3IkBWy/4SN5iSLGMZjt1pWkVPxD9VzVQEma6x2nnwQeryjQMEN+Abkl4JWsrOaL2mKmuTdg6q+JG+POdpTTbTktUL1zVd8eBUfeQljuo48W7LIUcOUUZAr9M9Wy3oE+IbzbR1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TneRlzrg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736471044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5FybuO2e6jAfgFg1N7R8bOgxXmdIKnrYsg9YYFnBvIk=;
	b=TneRlzrgb0suorGw0n1t50T6IlDReS3I7d/ieZLjFruHDRkRK6tniWrIbXFVKfmuh8oU/G
	1fN0oilDAunncBwm7hfs65JoO4Wzv7s8t3AFzpOnDl7B97NiE1mGk9A3pJG1EAN5S13C+S
	t89PjFcsA/vguuBxXJFR381WuvIRXWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-rdoeS7ANPFaGWqNUF-ROkQ-1; Thu,
 09 Jan 2025 20:03:59 -0500
X-MC-Unique: rdoeS7ANPFaGWqNUF-ROkQ-1
X-Mimecast-MFC-AGG-ID: rdoeS7ANPFaGWqNUF-ROkQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5045C19560B3;
	Fri, 10 Jan 2025 01:03:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6019B30001BE;
	Fri, 10 Jan 2025 01:03:53 +0000 (UTC)
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
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/8] rxrpc: rxgk: Provide infrastructure and key derivation
Date: Fri, 10 Jan 2025 01:03:08 +0000
Message-ID: <20250110010313.1471063-7-dhowells@redhat.com>
In-Reply-To: <20250110010313.1471063-1-dhowells@redhat.com>
References: <20250110010313.1471063-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Provide some infrastructure for implementing the RxGK transport security
class:

 (1) A definition of an encoding type, including:

	- Relevant crypto-layer names
	- Lengths of the crypto keys and checksums involved
	- Crypto functions specific to the encoding type
	- Crypto scheme used for that type

 (2) A definition of a crypto scheme, including:

	- Underlying crypto handlers
	- The pseudo-random function, PRF, used in base key derivation
	- Functions for deriving usage keys Kc, Ke and Ki
	- Functions for en/decrypting parts of an sk_buff

 (3) A key context, with the usage keys required for a derivative of a
     transport key for a specific key number.  This includes keys for
     securing packets for transmission, extracting received packets and
     dealing with response packets.

 (3) A function to look up an encoding type by number.

 (4) A function to set up a key context and derive the keys.

 (5) A function to set up the keys required to extract the ticket obtained
     from the GSS negotiation in the server.

 (6) Miscellaneous functions for context handling.

The keys and key derivation functions are described in:

	tools.ietf.org/html/draft-wilkinson-afs3-rxgk-11

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/Kconfig       |  10 ++
 net/rxrpc/Makefile      |   3 +-
 net/rxrpc/ar-internal.h |   3 +
 net/rxrpc/rxgk_common.h |  44 +++++++
 net/rxrpc/rxgk_kdf.c    | 260 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 net/rxrpc/rxgk_common.h
 create mode 100644 net/rxrpc/rxgk_kdf.c

diff --git a/net/rxrpc/Kconfig b/net/rxrpc/Kconfig
index a20986806fea..0a2b38b9b94a 100644
--- a/net/rxrpc/Kconfig
+++ b/net/rxrpc/Kconfig
@@ -67,6 +67,16 @@ config RXKAD
 
 	  See Documentation/networking/rxrpc.rst.
 
+config RXGK
+	bool "RxRPC GSSAPI security"
+	depends on AF_RXRPC
+	depends on CRYPTO_KRB5
+	help
+	  Provide the GSSAPI-based RxGK security class for AFS.  Keys are added
+	  with add_key().
+
+	  See Documentation/networking/rxrpc.rst.
+
 config RXPERF
 	tristate "RxRPC test service"
 	help
diff --git a/net/rxrpc/Makefile b/net/rxrpc/Makefile
index 210b75e3179e..9c8eb1471054 100644
--- a/net/rxrpc/Makefile
+++ b/net/rxrpc/Makefile
@@ -39,6 +39,7 @@ rxrpc-y := \
 rxrpc-$(CONFIG_PROC_FS) += proc.o
 rxrpc-$(CONFIG_RXKAD) += rxkad.o
 rxrpc-$(CONFIG_SYSCTL) += sysctl.o
-
+rxrpc-$(CONFIG_RXGK) += \
+	rxgk_kdf.o
 
 obj-$(CONFIG_RXPERF) += rxperf.o
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 718193df9d2e..2392f2e062c2 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -526,6 +526,9 @@ struct rxrpc_connection {
 			struct rxrpc_crypt csum_iv;	/* packet checksum base */
 			u32	nonce;		/* response re-use preventer */
 		} rxkad;
+		struct {
+			u64	start_time;	/* The start time for TK derivation */
+		} rxgk;
 	};
 	unsigned long		flags;
 	unsigned long		events;
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
new file mode 100644
index 000000000000..84e76fe8e324
--- /dev/null
+++ b/net/rxrpc/rxgk_common.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Common bits for GSSAPI-based RxRPC security.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <crypto/krb5.h>
+#include <crypto/skcipher.h>
+#include <crypto/hash.h>
+
+/*
+ * Per-key number context.  This is replaced when the connection is rekeyed.
+ */
+struct rxgk_context {
+	refcount_t		usage;
+	unsigned int		key_number;	/* Rekeying number (goes in the rx header) */
+	unsigned long		flags;
+#define RXGK_TK_NEEDS_REKEY	0		/* Set if this needs rekeying */
+	unsigned long		expiry;		/* Expiration time of this key */
+	long long		bytes_remaining; /* Remaining Tx lifetime of this key */
+	const struct krb5_enctype *krb5;	/* RxGK encryption type */
+	const struct rxgk_key	*key;
+
+	/* We need up to 7 keys derived from the transport key, but we don't
+	 * actually need the transport key.  Each key is derived by
+	 * DK(TK,constant).
+	 */
+	struct crypto_aead	*tx_crypto;	/* Transmission key */
+	struct crypto_aead	*rx_crypto;	/* Reception key */
+	struct crypto_aead	*resp_crypto;	/* Response key */
+};
+
+/*
+ * rxgk_kdf.c
+ */
+void rxgk_put(struct rxgk_context *gk);
+struct rxgk_context *rxgk_generate_transport_key(struct rxrpc_connection *conn,
+						 const struct rxgk_key *key,
+						 unsigned int key_number,
+						 gfp_t gfp);
+struct crypto_aead *rxgk_set_up_token_cipher(const struct krb5_buffer *server_key,
+					     unsigned int enctype,
+					     gfp_t gfp);
diff --git a/net/rxrpc/rxgk_kdf.c b/net/rxrpc/rxgk_kdf.c
new file mode 100644
index 000000000000..4257d3d0190b
--- /dev/null
+++ b/net/rxrpc/rxgk_kdf.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* RxGK transport key derivation.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/key-type.h>
+#include <linux/slab.h>
+#include <keys/rxrpc-type.h>
+#include "ar-internal.h"
+#include "rxgk_common.h"
+
+/*
+ * Constants used to derive the keys and hmacs actually used for doing stuff.
+ */
+#define RXGK_CLIENT_ENC_PACKET		1026U // 0x402
+#define RXGK_CLIENT_MIC_PACKET		1027U // 0x403
+#define RXGK_SERVER_ENC_PACKET		1028U // 0x404
+#define RXGK_SERVER_MIC_PACKET		1029U // 0x405
+#define RXGK_CLIENT_ENC_RESPONSE	1030U // 0x406
+#define RXGK_SERVER_ENC_TOKEN		1036U // 0x40c
+
+#define round16(x) (((x) + 15) & ~15)
+
+static void rxgk_free(struct rxgk_context *gk)
+{
+	crypto_free_aead(gk->tx_crypto);
+	crypto_free_aead(gk->rx_crypto);
+	crypto_free_aead(gk->resp_crypto);
+	kfree(gk);
+}
+
+void rxgk_put(struct rxgk_context *gk)
+{
+	if (gk && refcount_dec_and_test(&gk->usage))
+		rxgk_free(gk);
+}
+
+/*
+ * Transport key derivation function.
+ *
+ *      TK = random-to-key(PRF+(K0, L,
+ *                         epoch || cid || start_time || key_number))
+ *      [tools.ietf.org/html/draft-wilkinson-afs3-rxgk-11 sec 8.3]
+ */
+static int rxgk_derive_transport_key(struct rxrpc_connection *conn,
+				     struct rxgk_context *gk,
+				     const struct rxgk_key *rxgk,
+				     struct krb5_buffer *TK,
+				     gfp_t gfp)
+{
+	const struct krb5_enctype *krb5 = gk->krb5;
+	struct krb5_buffer conn_info;
+	unsigned int L = krb5->key_bytes;
+	__be32 *info;
+	u8 *buffer;
+	int ret;
+
+	_enter("");
+
+	conn_info.len = sizeof(__be32) * 5;
+
+	buffer = kzalloc(round16(conn_info.len), gfp);
+	if (!buffer)
+		return -ENOMEM;
+
+	conn_info.data = buffer;
+
+	info = (__be32 *)conn_info.data;
+	info[0] = htonl(conn->proto.epoch);
+	info[1] = htonl(conn->proto.cid);
+	info[2] = htonl(conn->rxgk.start_time >> 32);
+	info[3] = htonl(conn->rxgk.start_time >>  0);
+	info[4] = htonl(gk->key_number);
+
+	ret = crypto_krb5_calc_PRFplus(krb5, &rxgk->key, L, &conn_info, TK, gfp);
+	kfree_sensitive(buffer);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Derive a cipher.
+ */
+static int rxgk_derive_cipher(const struct krb5_enctype *krb5,
+			      u32 *params, size_t plen, struct crypto_aead **_ci)
+{
+	struct crypto_aead *ci;
+	int ret;
+
+	ci = crypto_alloc_aead(krb5->aead.base.cra_name, 0, 0);
+	if (IS_ERR(ci))
+		return (PTR_ERR(ci) == -ENOENT) ? -ENOPKG : PTR_ERR(ci);
+
+	ret = crypto_aead_setkey(ci, (void *)params, plen);
+	if (ret < 0) {
+		crypto_free_aead(ci);
+		return ret;
+	}
+
+	*_ci = ci;
+	return 0;
+}
+
+/*
+ * Set up the ciphers for the usage keys.
+ */
+static int rxgk_set_up_ciphers(struct rxrpc_connection *conn,
+			       struct rxgk_context *gk,
+			       const struct rxgk_key *rxgk,
+			       gfp_t gfp)
+{
+	const struct krb5_enctype *krb5 = gk->krb5;
+	struct krb5_buffer TK;
+	__be32 *params, tx_usage, rx_usage;
+	size_t plen = 2 * sizeof(__be32) + krb5->key_bytes;
+	int ret;
+
+	params = kzalloc(plen, gfp);
+	if (!params)
+		return -ENOMEM;
+
+	TK.len = krb5->key_bytes;
+	TK.data = (void *)&params[2];
+
+	ret = rxgk_derive_transport_key(conn, gk, rxgk, &TK, gfp);
+	if (ret < 0)
+		goto out;
+
+	params[0] = htonl(KRB5_ENCRYPT_MODE);
+	params[1] = htonl(RXGK_CLIENT_ENC_RESPONSE);
+	ret = rxgk_derive_cipher(krb5, params, plen, &gk->resp_crypto);
+	if (ret < 0)
+		goto out;
+
+	if (conn->security_level == RXRPC_SECURITY_AUTH) {
+		params[0] = htonl(KRB5_CHECKSUM_MODE);
+		tx_usage  = htonl(RXGK_CLIENT_MIC_PACKET);
+		rx_usage  = htonl(RXGK_SERVER_MIC_PACKET);
+	} else {
+		params[0] = htonl(KRB5_ENCRYPT_MODE);
+		tx_usage  = htonl(RXGK_CLIENT_ENC_PACKET);
+		rx_usage  = htonl(RXGK_SERVER_ENC_PACKET);
+	}
+
+	if (rxrpc_conn_is_service(conn))
+		swap(tx_usage, rx_usage);
+
+	params[1] = tx_usage;
+	ret = rxgk_derive_cipher(krb5, params, plen, &gk->tx_crypto);
+	if (ret < 0)
+		goto out;
+
+	params[1] = rx_usage;
+	ret = rxgk_derive_cipher(krb5, params, plen, &gk->rx_crypto);
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+out:
+	kfree_sensitive(params);
+	return ret;
+}
+
+/*
+ * Derive a transport key for a connection and then derive a bunch of usage
+ * keys from it and set up ciphers using them.
+ */
+struct rxgk_context *rxgk_generate_transport_key(struct rxrpc_connection *conn,
+						 const struct rxgk_key *key,
+						 unsigned int key_number,
+						 gfp_t gfp)
+{
+	struct rxgk_context *gk;
+	unsigned long lifetime;
+	int ret;
+
+	_enter("");
+
+	gk = kzalloc(sizeof(*gk), GFP_KERNEL);
+	if (!gk)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&gk->usage, 1);
+	gk->key		= key;
+	gk->key_number	= key_number;
+
+	gk->krb5 = crypto_krb5_find_enctype(key->enctype);
+	if (!gk->krb5) {
+		ret = -ENOPKG;
+		goto err_tk;
+	}
+
+	ret = rxgk_set_up_ciphers(conn, gk, key, gfp);
+	if (ret)
+		goto err_tk;
+
+	/* Set the remaining number of bytes encrypted with this key that may
+	 * be transmitted before rekeying.  Note that the spec has been
+	 * interpreted differently on this point...
+	 */
+	switch (key->bytelife) {
+	case 0:
+	case 63:
+		gk->bytes_remaining = LLONG_MAX;
+		break;
+	case 1 ... 62:
+		gk->bytes_remaining = 1LL << key->bytelife;
+		break;
+	default:
+		gk->bytes_remaining = key->bytelife;
+		break;
+	}
+
+	/* Set the time after which rekeying must occur */
+	if (key->lifetime) {
+		lifetime = min_t(u64, key->lifetime, INT_MAX / HZ);
+		lifetime *= HZ;
+	} else {
+		lifetime = MAX_JIFFY_OFFSET;
+	}
+	gk->expiry = jiffies + lifetime;
+	return gk;
+
+err_tk:
+	rxgk_put(gk);
+	_leave(" = %d", ret);
+	return ERR_PTR(ret);
+}
+
+/*
+ * Use the server secret key to set up the ciphers that will be used to extract
+ * the token from a response packet.
+ */
+struct crypto_aead *rxgk_set_up_token_cipher(const struct krb5_buffer *server_key,
+					     unsigned int enctype, gfp_t gfp)
+{
+	const struct krb5_enctype *krb5;
+	struct crypto_aead *ci;
+	__be32 *params;
+	size_t plen = 2 * sizeof(__be32) + server_key->len;
+	int ret;
+
+	krb5 = crypto_krb5_find_enctype(enctype);
+	if (!krb5)
+		return ERR_PTR(-ENOPKG);
+
+	params = kzalloc(plen, gfp);
+	if (!params)
+		return ERR_PTR(-ENOMEM);
+
+	params[0] = htonl(KRB5_ENCRYPT_MODE);
+	params[1] = htonl(RXGK_SERVER_ENC_TOKEN);
+	memcpy(&params[2], server_key->data, server_key->len);
+	ret = rxgk_derive_cipher(krb5, params, plen, &ci);
+	kfree_sensitive(params);
+	return ret < 0 ? ERR_PTR(ret) : ci;
+}


