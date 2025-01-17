Return-Path: <linux-fsdevel+bounces-39533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EACA1572E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443B23AA1CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B81E0496;
	Fri, 17 Jan 2025 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWxtg6ao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13441ACEDC
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139043; cv=none; b=LKLyxhqY5h30UmQLiiSJtHI8xjOgoSqu96jrYNA/aTTrIBwDGhRxMJxD6cz3kBHlL8h+ZxnDPi+JMi4yvAKy+ARBoRU1KLXSOCD2iSKPvFf/MfJrpIcI/NkTyZVU/uuyp5wKaQfjTJbEYRVbOjL65qFPysEy/S1Pawe7YCfusv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139043; c=relaxed/simple;
	bh=PhuI4JJMSci6aHiyWNjJr+cJiGGK9DT9RmI+VkKhPP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKC9PaRiqqIi4B5r4d5HC3yDHSV62OuYKLFrhi4l4vDffLlSwUpKE/uL1vMr6fXd08/Juoku622Fe7jhuJdi20epzHwaJEn43GbQq+ae7/7fN95urVMGUsCvoddDDcVRrlwsvbXPgFzhvEx716lSiQvCH8fXljC1+6q9bIdXS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWxtg6ao; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIWNuwD5cCIThAd/Uz0vknL99+mbD0QatdD+2tFt/VA=;
	b=VWxtg6aoCDD4hS8VIwem/cN6fg3Vb/Q9g1KFmbzkPGo/iBgXBoDiMEZwQQTdFX3AtbrliC
	OODlVu66DK7Ih1SZzx6vJmoKdExaA1nd3g3wdYsHMTYB0IoxAldlLnMnIkwWYUMDEVXG8/
	+7/4Dtf73BxfRPmyWIZUZf3kDYPcBfE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-VIoxbHFQMSOlo6MOrahrZA-1; Fri,
 17 Jan 2025 13:37:17 -0500
X-MC-Unique: VIoxbHFQMSOlo6MOrahrZA-1
X-Mimecast-MFC-AGG-ID: VIoxbHFQMSOlo6MOrahrZA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E97B19560A1;
	Fri, 17 Jan 2025 18:37:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C94C630001BE;
	Fri, 17 Jan 2025 18:37:10 +0000 (UTC)
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
Subject: [RFC PATCH 15/24] crypto/krb5: Implement the AES enctypes from rfc8009
Date: Fri, 17 Jan 2025 18:35:24 +0000
Message-ID: <20250117183538.881618-16-dhowells@redhat.com>
In-Reply-To: <20250117183538.881618-1-dhowells@redhat.com>
References: <20250117183538.881618-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Implement the aes128-cts-hmac-sha256-128 and aes256-cts-hmac-sha384-192
enctypes from rfc8009, overriding the rfc3961 kerberos 5 simplified crypto
scheme.

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
 crypto/krb5/Kconfig        |   2 +
 crypto/krb5/Makefile       |   3 +-
 crypto/krb5/internal.h     |  16 ++
 crypto/krb5/krb5_api.c     |   2 +
 crypto/krb5/rfc8009_aes2.c | 296 +++++++++++++++++++++++++++++++++++++
 include/crypto/krb5.h      |   4 +
 6 files changed, 322 insertions(+), 1 deletion(-)
 create mode 100644 crypto/krb5/rfc8009_aes2.c

diff --git a/crypto/krb5/Kconfig b/crypto/krb5/Kconfig
index 2ad874990dc8..52f0ed2d7820 100644
--- a/crypto/krb5/Kconfig
+++ b/crypto/krb5/Kconfig
@@ -7,6 +7,8 @@ config CRYPTO_KRB5
 	select CRYPTO_HASH_INFO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
 	select CRYPTO_CBC
 	select CRYPTO_CTS
 	select CRYPTO_AES
diff --git a/crypto/krb5/Makefile b/crypto/krb5/Makefile
index 35f21411abf8..7fd215ec3a85 100644
--- a/crypto/krb5/Makefile
+++ b/crypto/krb5/Makefile
@@ -7,6 +7,7 @@ krb5-y += \
 	krb5_kdf.o \
 	krb5_api.o \
 	rfc3961_simplified.o \
-	rfc3962_aes.o
+	rfc3962_aes.o \
+	rfc8009_aes2.o
 
 obj-$(CONFIG_CRYPTO_KRB5) += krb5.o
diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index 267ca978bda5..81bf38cf12fc 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -185,3 +185,19 @@ int rfc3961_verify_mic(const struct krb5_enctype *krb5,
  */
 extern const struct krb5_enctype krb5_aes128_cts_hmac_sha1_96;
 extern const struct krb5_enctype krb5_aes256_cts_hmac_sha1_96;
+
+/*
+ * rfc8009_aes2.c
+ */
+extern const struct krb5_enctype krb5_aes128_cts_hmac_sha256_128;
+extern const struct krb5_enctype krb5_aes256_cts_hmac_sha384_192;
+int authenc_derive_encrypt_keys(const struct krb5_enctype *krb5,
+				const struct krb5_buffer *TK,
+				unsigned int usage,
+				struct krb5_buffer *setkey,
+				gfp_t gfp);
+int authenc_load_encrypt_keys(const struct krb5_enctype *krb5,
+			      const struct krb5_buffer *Ke,
+			      const struct krb5_buffer *Ki,
+			      struct krb5_buffer *setkey,
+			      gfp_t gfp);
diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index ecc6655953d5..5b94cc5db461 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -19,6 +19,8 @@ MODULE_LICENSE("GPL");
 static const struct krb5_enctype *const krb5_supported_enctypes[] = {
 	&krb5_aes128_cts_hmac_sha1_96,
 	&krb5_aes256_cts_hmac_sha1_96,
+	&krb5_aes128_cts_hmac_sha256_128,
+	&krb5_aes256_cts_hmac_sha384_192,
 };
 
 /**
diff --git a/crypto/krb5/rfc8009_aes2.c b/crypto/krb5/rfc8009_aes2.c
new file mode 100644
index 000000000000..d7225187ce8b
--- /dev/null
+++ b/crypto/krb5/rfc8009_aes2.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* rfc8009 AES Encryption with HMAC-SHA2 for Kerberos 5
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/slab.h>
+#include <linux/rtnetlink.h>
+#include <crypto/authenc.h>
+#include "internal.h"
+
+static const struct krb5_buffer rfc8009_no_context = { .len = 0, .data = "" };
+
+/*
+ * Calculate the key derivation function KDF-HMAC-SHA2(key, label, [context,] k)
+ *
+ *	KDF-HMAC-SHA2(key, label, [context,] k) = k-truncate(K1)
+ *
+ *	Using the appropriate one of:
+ *		K1 = HMAC-SHA-256(key, 0x00000001 | label | 0x00 | k)
+ *		K1 = HMAC-SHA-384(key, 0x00000001 | label | 0x00 | k)
+ *		K1 = HMAC-SHA-256(key, 0x00000001 | label | 0x00 | context | k)
+ *		K1 = HMAC-SHA-384(key, 0x00000001 | label | 0x00 | context | k)
+ *	[rfc8009 sec 3]
+ */
+static int rfc8009_calc_KDF_HMAC_SHA2(const struct krb5_enctype *krb5,
+				      const struct krb5_buffer *key,
+				      const struct krb5_buffer *label,
+				      const struct krb5_buffer *context,
+				      unsigned int k,
+				      struct krb5_buffer *result,
+				      gfp_t gfp)
+{
+	struct crypto_shash *shash;
+	struct krb5_buffer K1, data;
+	struct shash_desc *desc;
+	__be32 tmp;
+	size_t bsize;
+	void *buffer;
+	u8 *p;
+	int ret = -ENOMEM;
+
+	if (WARN_ON(result->len != k / 8))
+		return -EINVAL;
+
+	shash = crypto_alloc_shash(krb5->cksum_name, 0, 0);
+	if (IS_ERR(shash))
+		return (PTR_ERR(shash) == -ENOENT) ? -ENOPKG : PTR_ERR(shash);
+	ret = crypto_shash_setkey(shash, key->data, key->len);
+	if (ret < 0)
+		goto error_shash;
+
+	ret = -EINVAL;
+	if (WARN_ON(crypto_shash_digestsize(shash) * 8 < k))
+		goto error_shash;
+
+	ret = -ENOMEM;
+	data.len = 4 + label->len + 1 + context->len + 4;
+	bsize = krb5_shash_size(shash) +
+		krb5_digest_size(shash) +
+		crypto_roundup(data.len);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		goto error_shash;
+
+	desc = buffer;
+	desc->tfm = shash;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	p = data.data = buffer +
+		krb5_shash_size(shash) +
+		krb5_digest_size(shash);
+	*(__be32 *)p = htonl(0x00000001);
+	p += 4;
+	memcpy(p, label->data, label->len);
+	p += label->len;
+	*p++ = 0;
+	memcpy(p, context->data, context->len);
+	p += context->len;
+	tmp = htonl(k);
+	memcpy(p, &tmp, 4);
+	p += 4;
+
+	ret = -EINVAL;
+	if (WARN_ON(p - (u8 *)data.data != data.len))
+		goto error;
+
+	K1.len = crypto_shash_digestsize(shash);
+	K1.data = buffer +
+		krb5_shash_size(shash);
+
+	ret = crypto_shash_finup(desc, data.data, data.len, K1.data);
+	if (ret < 0)
+		goto error;
+
+	memcpy(result->data, K1.data, result->len);
+
+error:
+	kfree_sensitive(buffer);
+error_shash:
+	crypto_free_shash(shash);
+	return ret;
+}
+
+/*
+ * Calculate the pseudo-random function, PRF().
+ *
+ *	PRF = KDF-HMAC-SHA2(input-key, "prf", octet-string, 256)
+ *	PRF = KDF-HMAC-SHA2(input-key, "prf", octet-string, 384)
+ *
+ *      The "prfconstant" used in the PRF operation is the three-octet string
+ *      "prf".
+ *      [rfc8009 sec 5]
+ */
+static int rfc8009_calc_PRF(const struct krb5_enctype *krb5,
+			    const struct krb5_buffer *input_key,
+			    const struct krb5_buffer *octet_string,
+			    struct krb5_buffer *result,
+			    gfp_t gfp)
+{
+	static const struct krb5_buffer prfconstant = { 3, "prf" };
+
+	return rfc8009_calc_KDF_HMAC_SHA2(krb5, input_key, &prfconstant,
+					  octet_string, krb5->prf_len * 8,
+					  result, gfp);
+}
+
+/*
+ * Derive Ke.
+ *	Ke = KDF-HMAC-SHA2(base-key, usage | 0xAA, 128)
+ *	Ke = KDF-HMAC-SHA2(base-key, usage | 0xAA, 256)
+ *      [rfc8009 sec 5]
+ */
+static int rfc8009_calc_Ke(const struct krb5_enctype *krb5,
+			   const struct krb5_buffer *base_key,
+			   const struct krb5_buffer *usage_constant,
+			   struct krb5_buffer *result,
+			   gfp_t gfp)
+{
+	return rfc8009_calc_KDF_HMAC_SHA2(krb5, base_key, usage_constant,
+					  &rfc8009_no_context, krb5->key_bytes * 8,
+					  result, gfp);
+}
+
+/*
+ * Derive Kc/Ki
+ *	Kc = KDF-HMAC-SHA2(base-key, usage | 0x99, 128)
+ *	Ki = KDF-HMAC-SHA2(base-key, usage | 0x55, 128)
+ *	Kc = KDF-HMAC-SHA2(base-key, usage | 0x99, 192)
+ *	Ki = KDF-HMAC-SHA2(base-key, usage | 0x55, 192)
+ *      [rfc8009 sec 5]
+ */
+static int rfc8009_calc_Ki(const struct krb5_enctype *krb5,
+			   const struct krb5_buffer *base_key,
+			   const struct krb5_buffer *usage_constant,
+			   struct krb5_buffer *result,
+			   gfp_t gfp)
+{
+	return rfc8009_calc_KDF_HMAC_SHA2(krb5, base_key, usage_constant,
+					  &rfc8009_no_context, krb5->cksum_len * 8,
+					  result, gfp);
+}
+
+/*
+ * Derive the Ke and Ki keys and package them into a key parameter that can be
+ * given to the setkey of a authenc AEAD crypto object.
+ */
+int authenc_derive_encrypt_keys(const struct krb5_enctype *krb5,
+				const struct krb5_buffer *TK,
+				unsigned int usage,
+				struct krb5_buffer *setkey,
+				gfp_t gfp)
+{
+	struct krb5_buffer Ke, Ki;
+	__be32 *khdr = NULL;
+	int ret;
+
+	Ke.len  = krb5->Ke_len;
+	Ki.len  = krb5->Ki_len;
+	setkey->len = sizeof(__be32) * 3 + krb5->Ke_len + krb5->Ki_len;
+	setkey->data = kzalloc(setkey->len, GFP_KERNEL);
+	if (!setkey->data)
+		return -ENOMEM;
+
+	khdr = setkey->data;
+	Ke.data = setkey->data + 12;
+	Ki.data = setkey->data + 12 + Ke.len;
+
+	khdr[0] = htonl(1); /* Format 1 */
+	khdr[1] = htonl(Ke.len);
+	khdr[2] = htonl(Ki.len);
+
+	ret = krb5_derive_Ke(krb5, TK, usage, &Ke, gfp);
+	if (ret < 0) {
+		pr_err("get_Ke failed %d\n", ret);
+		return ret;
+	}
+	ret = krb5_derive_Ki(krb5, TK, usage, &Ki, gfp);
+	if (ret < 0)
+		pr_err("get_Ki failed %d\n", ret);
+	return ret;
+}
+
+/*
+ * Package predefined Ke and Ki keys and into a key parameter that can be given
+ * to the setkey of an authenc AEAD crypto object.
+ */
+int authenc_load_encrypt_keys(const struct krb5_enctype *krb5,
+			      const struct krb5_buffer *Ke,
+			      const struct krb5_buffer *Ki,
+			      struct krb5_buffer *setkey,
+			      gfp_t gfp)
+{
+	struct crypto_authenc_key_param *param;
+	struct rtattr *rta;
+
+	setkey->len = RTA_LENGTH(sizeof(*param)) + Ke->len + Ki->len;
+	setkey->data = kzalloc(setkey->len, GFP_KERNEL);
+	if (!setkey->data)
+		return -ENOMEM;
+
+	rta = setkey->data;
+	rta->rta_type = CRYPTO_AUTHENC_KEYA_PARAM;
+	rta->rta_len = RTA_LENGTH(sizeof(*param));
+	param = RTA_DATA(rta);
+	param->enckeylen = htonl(Ke->len);
+	memcpy((void *)(param + 1), Ki->data, Ki->len);
+	memcpy((void *)(param + 1) + Ki->len, Ke->data, Ke->len);
+	return 0;
+}
+
+static const struct krb5_crypto_profile rfc8009_crypto_profile = {
+	.calc_PRF		= rfc8009_calc_PRF,
+	.calc_Kc		= rfc8009_calc_Ki,
+	.calc_Ke		= rfc8009_calc_Ke,
+	.calc_Ki		= rfc8009_calc_Ki,
+	.derive_encrypt_keys	= authenc_derive_encrypt_keys,
+	.load_encrypt_keys	= authenc_load_encrypt_keys,
+	.derive_checksum_key	= rfc3961_derive_checksum_key,
+	.load_checksum_key	= rfc3961_load_checksum_key,
+	.encrypt		= NULL, //rfc8009_encrypt,
+	.decrypt		= NULL, //rfc8009_decrypt,
+	.get_mic		= rfc3961_get_mic,
+	.verify_mic		= rfc3961_verify_mic,
+};
+
+const struct krb5_enctype krb5_aes128_cts_hmac_sha256_128 = {
+	.etype		= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+	.ctype		= KRB5_CKSUMTYPE_HMAC_SHA256_128_AES128,
+	.name		= "aes128-cts-hmac-sha256-128",
+	.encrypt_name	= "authenc(hmac(sha256),cts(cbc(aes)))",
+	.cksum_name	= "hmac(sha256)",
+	.hash_name	= "sha256",
+	.derivation_enc	= "cts(cbc(aes))",
+	.key_bytes	= 16,
+	.key_len	= 16,
+	.Kc_len		= 16,
+	.Ke_len		= 16,
+	.Ki_len		= 16,
+	.block_len	= 16,
+	.conf_len	= 16,
+	.cksum_len	= 16,
+	.hash_len	= 20,
+	.prf_len	= 32,
+	.keyed_cksum	= true,
+	.random_to_key	= NULL, /* Identity */
+	.profile	= &rfc8009_crypto_profile,
+};
+
+const struct krb5_enctype krb5_aes256_cts_hmac_sha384_192 = {
+	.etype		= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+	.ctype		= KRB5_CKSUMTYPE_HMAC_SHA384_192_AES256,
+	.name		= "aes256-cts-hmac-sha384-192",
+	.encrypt_name	= "authenc(hmac(sha384),cts(cbc(aes)))",
+	.cksum_name	= "hmac(sha384)",
+	.hash_name	= "sha384",
+	.derivation_enc	= "cts(cbc(aes))",
+	.key_bytes	= 32,
+	.key_len	= 32,
+	.Kc_len		= 24,
+	.Ke_len		= 32,
+	.Ki_len		= 24,
+	.block_len	= 16,
+	.conf_len	= 16,
+	.cksum_len	= 24,
+	.hash_len	= 20,
+	.prf_len	= 48,
+	.keyed_cksum	= true,
+	.random_to_key	= NULL, /* Identity */
+	.profile	= &rfc8009_crypto_profile,
+};
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index a24d9ee53675..6921785688bf 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -31,6 +31,8 @@ struct scatterlist;
 #define KRB5_ENCTYPE_DES3_CBC_SHA1		0x0010
 #define KRB5_ENCTYPE_AES128_CTS_HMAC_SHA1_96	0x0011
 #define KRB5_ENCTYPE_AES256_CTS_HMAC_SHA1_96	0x0012
+#define KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128	0x0013
+#define KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192	0x0014
 #define KRB5_ENCTYPE_ARCFOUR_HMAC		0x0017
 #define KRB5_ENCTYPE_ARCFOUR_HMAC_EXP		0x0018
 #define KRB5_ENCTYPE_UNKNOWN			0x01ff
@@ -45,6 +47,8 @@ struct scatterlist;
 #define KRB5_CKSUMTYPE_HMAC_SHA1_DES3		0x000c
 #define KRB5_CKSUMTYPE_HMAC_SHA1_96_AES128	0x000f
 #define KRB5_CKSUMTYPE_HMAC_SHA1_96_AES256	0x0010
+#define KRB5_CKSUMTYPE_HMAC_SHA256_128_AES128	0x0013
+#define KRB5_CKSUMTYPE_HMAC_SHA384_192_AES256	0x0014
 #define KRB5_CKSUMTYPE_HMAC_MD5_ARCFOUR		-138 /* Microsoft md5 hmac cksumtype */
 
 /*


