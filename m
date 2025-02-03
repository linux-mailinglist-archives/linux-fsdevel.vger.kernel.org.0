Return-Path: <linux-fsdevel+bounces-40615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B20A25CAC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F9B7A21D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837E12116FB;
	Mon,  3 Feb 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSxaiIpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63320ADDA
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592776; cv=none; b=hyF30csgs8gjaAszkjfz0WtgxulRJjmU9tYiZ9u2b1hFfmGNmNfwQZ0FUbB0FjuINlyYkv3uCUTwyKytIFXFeF9E8i7DtTGOPy1NLaIvJvRhyJiNe778OIbGmIDjvO/XGZZpETSdtZlWiHo3WShRKsDLsQlOijElh/ABGLw2sMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592776; c=relaxed/simple;
	bh=G4R4pFSAjVbbA7vl1tF6rBN6a1HLgkCLWWlMFlS0ygE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQwI8dFkOMlgKmSIc7HnzfRXkK6+3ITijOjHQoOUKwFD0aYFDcUsL+TCWdj32H3dj6RHT4ENnFaO0dkwQK+qxoXjpi3z3ossZ426hXSa2ZN9nmEsma2hiFdcPh9UT/XHdgbS1fgrGnA+KW4yjR52lamjnZS+fzBcPE0Hd2t20ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSxaiIpl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=za+wG2LCZJ3uISyST0/CT/AlTTZsd7CzgRzTNnmEkjc=;
	b=KSxaiIplbXYBnrHB3O/T1hApweuZiHGL5WUkSQhTjb1bfpoB7d/URzXlORUVrIFlZgApDL
	wxmQMQ2OTFwuQ8eY0IaxXsZNuBQG2Mja3tlyoX3dFxcB2EsULrLFrsVysaUW+b/ltNkpSl
	DGPbhTSMwl60XAVBYNLLmWgEi6onbZw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-xxMVa7gXM3OXTruaFzKM5A-1; Mon,
 03 Feb 2025 09:26:08 -0500
X-MC-Unique: xxMVa7gXM3OXTruaFzKM5A-1
X-Mimecast-MFC-AGG-ID: xxMVa7gXM3OXTruaFzKM5A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A692D180035F;
	Mon,  3 Feb 2025 14:26:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F5781956094;
	Mon,  3 Feb 2025 14:26:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 22/24] rxrpc: rxgk: Provide infrastructure and key derivation
Date: Mon,  3 Feb 2025 14:23:38 +0000
Message-ID: <20250203142343.248839-23-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
 net/rxrpc/Kconfig       |  10 ++
 net/rxrpc/Makefile      |   3 +-
 net/rxrpc/ar-internal.h |   3 +
 net/rxrpc/rxgk_common.h |  48 +++++++
 net/rxrpc/rxgk_kdf.c    | 287 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 350 insertions(+), 1 deletion(-)
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
index caf448fe77d4..2b318d88546a 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -546,6 +546,9 @@ struct rxrpc_connection {
 			struct rxrpc_crypt csum_iv;	/* packet checksum base */
 			u32	nonce;		/* response re-use preventer */
 		} rxkad;
+		struct {
+			u64	start_time;	/* The start time for TK derivation */
+		} rxgk;
 	};
 	struct sk_buff		*tx_response;	/* Response packet to be transmitted */
 	unsigned long		flags;
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
new file mode 100644
index 000000000000..da1464e65766
--- /dev/null
+++ b/net/rxrpc/rxgk_common.h
@@ -0,0 +1,48 @@
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
+	struct crypto_aead	*tx_enc;	/* Transmission key */
+	struct crypto_aead	*rx_enc;	/* Reception key */
+	struct crypto_shash	*tx_Kc;		/* Transmission checksum key */
+	struct crypto_shash	*rx_Kc;		/* Reception checksum key */
+	struct crypto_aead	*resp_enc;	/* Response packet enc key */
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
+int rxgk_set_up_token_cipher(const struct krb5_buffer *server_key,
+			     struct crypto_aead **token_key,
+			     unsigned int enctype,
+			     const struct krb5_enctype **_krb5,
+			     gfp_t gfp);
diff --git a/net/rxrpc/rxgk_kdf.c b/net/rxrpc/rxgk_kdf.c
new file mode 100644
index 000000000000..b18a9f16247f
--- /dev/null
+++ b/net/rxrpc/rxgk_kdf.c
@@ -0,0 +1,287 @@
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
+#define round16(x) (((x) + 15) & ~15)
+
+/*
+ * Constants used to derive the keys and hmacs actually used for doing stuff.
+ */
+#define RXGK_CLIENT_ENC_PACKET		1026U // 0x402
+#define RXGK_CLIENT_MIC_PACKET          1027U // 0x403
+#define RXGK_SERVER_ENC_PACKET          1028U // 0x404
+#define RXGK_SERVER_MIC_PACKET          1029U // 0x405
+#define RXGK_CLIENT_ENC_RESPONSE        1030U // 0x406
+#define RXGK_SERVER_ENC_TOKEN           1036U // 0x40c
+
+static void rxgk_free(struct rxgk_context *gk)
+{
+	if (gk->tx_Kc)
+		crypto_free_shash(gk->tx_Kc);
+	if (gk->rx_Kc)
+		crypto_free_shash(gk->rx_Kc);
+	if (gk->tx_enc)
+		crypto_free_aead(gk->tx_enc);
+	if (gk->rx_enc)
+		crypto_free_aead(gk->rx_enc);
+	if (gk->resp_enc)
+		crypto_free_aead(gk->resp_enc);
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
+ * Set up the ciphers for the usage keys.
+ */
+static int rxgk_set_up_ciphers(struct rxrpc_connection *conn,
+			       struct rxgk_context *gk,
+			       const struct rxgk_key *rxgk,
+			       gfp_t gfp)
+{
+	const struct krb5_enctype *krb5 = gk->krb5;
+	struct crypto_shash *shash;
+	struct crypto_aead *aead;
+	struct krb5_buffer TK;
+	bool service = rxrpc_conn_is_service(conn);
+	int ret;
+	u8 *buffer;
+
+	buffer = kzalloc(krb5->key_bytes, gfp);
+	if (!buffer)
+		return -ENOMEM;
+
+	TK.len = krb5->key_bytes;
+	TK.data = buffer;
+
+	ret = rxgk_derive_transport_key(conn, gk, rxgk, &TK, gfp);
+	if (ret < 0)
+		goto out;
+
+	aead = crypto_krb5_prepare_encryption(krb5, &TK, RXGK_CLIENT_ENC_RESPONSE, gfp);
+	if (IS_ERR(aead))
+		goto aead_error;
+	gk->resp_enc = aead;
+
+	if (crypto_aead_blocksize(gk->resp_enc) != krb5->block_len ||
+	    crypto_aead_authsize(gk->resp_enc) != krb5->cksum_len) {
+		pr_notice("algo inconsistent with krb5 table %u!=%u or %u!=%u\n",
+			  crypto_aead_blocksize(gk->resp_enc), krb5->block_len,
+			  crypto_aead_authsize(gk->resp_enc), krb5->cksum_len);
+		return -EINVAL;
+	}
+
+	if (service) {
+		switch (conn->security_level) {
+		case RXRPC_SECURITY_AUTH:
+			shash = crypto_krb5_prepare_checksum(
+				krb5, &TK, RXGK_SERVER_MIC_PACKET, gfp);
+			if (IS_ERR(shash))
+				goto hash_error;
+			gk->tx_Kc = shash;
+			shash = crypto_krb5_prepare_checksum(
+				krb5, &TK, RXGK_CLIENT_MIC_PACKET, gfp);
+			if (IS_ERR(shash))
+				goto hash_error;
+			gk->rx_Kc = shash;
+			break;
+		case RXRPC_SECURITY_ENCRYPT:
+			aead = crypto_krb5_prepare_encryption(
+				krb5, &TK, RXGK_SERVER_ENC_PACKET, gfp);
+			if (IS_ERR(aead))
+				goto aead_error;
+			gk->tx_enc = aead;
+			aead = crypto_krb5_prepare_encryption(
+				krb5, &TK, RXGK_CLIENT_ENC_PACKET, gfp);
+			if (IS_ERR(aead))
+				goto aead_error;
+			gk->rx_enc = aead;
+			break;
+		}
+	} else {
+		switch (conn->security_level) {
+		case RXRPC_SECURITY_AUTH:
+			shash = crypto_krb5_prepare_checksum(
+				krb5, &TK, RXGK_CLIENT_MIC_PACKET, gfp);
+			if (IS_ERR(shash))
+				goto hash_error;
+			gk->tx_Kc = shash;
+			shash = crypto_krb5_prepare_checksum(
+				krb5, &TK, RXGK_SERVER_MIC_PACKET, gfp);
+			if (IS_ERR(shash))
+				goto hash_error;
+			gk->rx_Kc = shash;
+			break;
+		case RXRPC_SECURITY_ENCRYPT:
+			aead = crypto_krb5_prepare_encryption(
+				krb5, &TK, RXGK_CLIENT_ENC_PACKET, gfp);
+			if (IS_ERR(aead))
+				goto aead_error;
+			gk->tx_enc = aead;
+			aead = crypto_krb5_prepare_encryption(
+				krb5, &TK, RXGK_SERVER_ENC_PACKET, gfp);
+			if (IS_ERR(aead))
+				goto aead_error;
+			gk->rx_enc = aead;
+			break;
+		}
+	}
+
+	ret = 0;
+out:
+	kfree_sensitive(buffer);
+	return ret;
+aead_error:
+	ret = PTR_ERR(aead);
+	goto out;
+hash_error:
+	ret = PTR_ERR(shash);
+	goto out;
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
+	int ret = -ENOPKG;
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
+	if (!gk->krb5)
+		goto err_tk;
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
+int rxgk_set_up_token_cipher(const struct krb5_buffer *server_key,
+			     struct crypto_aead **token_aead,
+			     unsigned int enctype,
+			     const struct krb5_enctype **_krb5,
+			     gfp_t gfp)
+{
+	const struct krb5_enctype *krb5;
+	struct crypto_aead *aead;
+
+	krb5 = crypto_krb5_find_enctype(enctype);
+	if (!krb5)
+		return -ENOPKG;
+
+	aead = crypto_krb5_prepare_encryption(krb5, server_key, RXGK_SERVER_ENC_TOKEN, gfp);
+	if (IS_ERR(aead))
+		return PTR_ERR(aead);
+
+	*_krb5 = krb5;
+	*token_aead = aead;
+	return 0;
+}


