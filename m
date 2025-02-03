Return-Path: <linux-fsdevel+bounces-40596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9B8A25C4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C651885F2F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B45208984;
	Mon,  3 Feb 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNnDyaxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00A208977
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592662; cv=none; b=fj/93Go1TFLPsKSSryPl+4juLP3LL0KTaU2EAFtM3B0fjH3ZUdT5OQFRD2Hcuza0T1HXhqS2Q2vlB+DL7vs8WGhkYS9Ntubel09biqiiaVIE1yF0M3S8swvVq3bJB9NcoLh/T8QG2Mo/F+X/rj2WiBGmaoShOR3/C/hipGCqK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592662; c=relaxed/simple;
	bh=0AIFjsM83gvGUFANRxBPYC6SgRaZ48J24J1wxOqWhPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHlJALslCYX+QSwOFFwaSk+QDmd1NYdskuZJ+HpJji8hxrt3EWfp7a2GCj9DuUP7lchZN2IpaaiPdipsEeCASSu0647Nnh/hEK9OL+iHa/yuVmaosa+YlMzb4I6btH7t1LaqN45cxpm27MsRKwdC3MUo8dgbJ8cxCikFEZLVHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNnDyaxS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbrN4/FR3YWUrHwst56zqEWOHRDXB4RaAJ1R9F30v/0=;
	b=NNnDyaxSyWMNwP77HmPExxhtxpvKHAhrs+r6S03QwUUXZNByMlBMeIZLPhFYElPaQl87ca
	nIYzwYdC00rqPagCttSqezt1VO6KpRYWOUtQIkbMloIixsB7twDWpNJu689CyuN9J1wdI9
	PRkzYtulaGyB1s6KoGsK5KCYLtdFE80=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-xdYMv7QKOQOeAINww2oz0g-1; Mon,
 03 Feb 2025 09:24:13 -0500
X-MC-Unique: xdYMv7QKOQOeAINww2oz0g-1
X-Mimecast-MFC-AGG-ID: xdYMv7QKOQOeAINww2oz0g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49C1E1956048;
	Mon,  3 Feb 2025 14:24:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75A1A1800365;
	Mon,  3 Feb 2025 14:24:06 +0000 (UTC)
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
Subject: [PATCH net 03/24] crypto: Add 'krb5enc' hash and cipher AEAD algorithm
Date: Mon,  3 Feb 2025 14:23:19 +0000
Message-ID: <20250203142343.248839-4-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add an AEAD template that does hash-then-cipher (unlike authenc that does
cipher-then-hash).  This is required for a number of Kerberos 5 encoding
types.

[!] Note that the net/sunrpc/auth_gss/ implementation gets a pair of
ciphers, one non-CTS and one CTS, using the former to do all the aligned
blocks and the latter to do the last two blocks if they aren't also
aligned.  It may be necessary to do this here too for performance reasons -
but there are considerations both ways:

 (1) firstly, there is an optimised assembly version of cts(cbc(aes)) on
     x86_64 that should be used instead of having two ciphers;

 (2) secondly, none of the hardware offload drivers seem to offer CTS
     support (Intel QAT does not, for instance).

However, I don't know if it's possible to query the crypto API to find out
whether there's an optimised CTS algorithm available.

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
 crypto/Kconfig           |  12 +
 crypto/Makefile          |   1 +
 crypto/krb5enc.c         | 504 +++++++++++++++++++++++++++++++++++++++
 include/crypto/authenc.h |   2 +
 4 files changed, 519 insertions(+)
 create mode 100644 crypto/krb5enc.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 74ae5f52b784..cbf2dc7ce2a1 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -228,6 +228,18 @@ config CRYPTO_AUTHENC
 
 	  This is required for IPSec ESP (XFRM_ESP).
 
+config CRYPTO_KRB5ENC
+	tristate "Kerberos 5 combined hash+cipher support"
+	select CRYPTO_AEAD
+	select CRYPTO_SKCIPHER
+	select CRYPTO_MANAGER
+	select CRYPTO_HASH
+	select CRYPTO_NULL
+	help
+	  Combined hash and cipher support for Kerberos 5 RFC3961 simplified
+	  profile.  This is required for Kerberos 5-style encryption, used by
+	  sunrpc/NFS and rxrpc/AFS.
+
 config CRYPTO_TEST
 	tristate "Testing module"
 	depends on m || EXPERT
diff --git a/crypto/Makefile b/crypto/Makefile
index f67e853c4690..20c8e3ee9835 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -159,6 +159,7 @@ obj-$(CONFIG_CRYPTO_CRCT10DIF) += crct10dif_generic.o
 CFLAGS_crct10dif_generic.o += -DARCH=$(ARCH)
 obj-$(CONFIG_CRYPTO_CRC64_ROCKSOFT) += crc64_rocksoft_generic.o
 obj-$(CONFIG_CRYPTO_AUTHENC) += authenc.o authencesn.o
+obj-$(CONFIG_CRYPTO_KRB5ENC) += krb5enc.o
 obj-$(CONFIG_CRYPTO_LZO) += lzo.o lzo-rle.o
 obj-$(CONFIG_CRYPTO_LZ4) += lz4.o
 obj-$(CONFIG_CRYPTO_LZ4HC) += lz4hc.o
diff --git a/crypto/krb5enc.c b/crypto/krb5enc.c
new file mode 100644
index 000000000000..d07769bf149e
--- /dev/null
+++ b/crypto/krb5enc.c
@@ -0,0 +1,504 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AEAD wrapper for Kerberos 5 RFC3961 simplified profile.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * Derived from authenc:
+ * Copyright (c) 2007-2015 Herbert Xu <herbert@gondor.apana.org.au>
+ */
+
+#include <crypto/internal/aead.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/authenc.h>
+#include <crypto/scatterwalk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rtnetlink.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+struct krb5enc_instance_ctx {
+	struct crypto_ahash_spawn auth;
+	struct crypto_skcipher_spawn enc;
+	unsigned int reqoff;
+};
+
+struct krb5enc_ctx {
+	struct crypto_ahash *auth;
+	struct crypto_skcipher *enc;
+};
+
+struct krb5enc_request_ctx {
+	struct scatterlist src[2];
+	struct scatterlist dst[2];
+	char tail[];
+};
+
+static void krb5enc_request_complete(struct aead_request *req, int err)
+{
+	if (err != -EINPROGRESS)
+		aead_request_complete(req, err);
+}
+
+/**
+ * crypto_krb5enc_extractkeys - Extract Ke and Ki keys from the key blob.
+ * @keys: Where to put the key sizes and pointers
+ * @key: Encoded key material
+ * @keylen: Amount of key material
+ *
+ * Decode the key blob we're given.  It starts with an rtattr that indicates
+ * the format and the length.  Format CRYPTO_AUTHENC_KEYA_PARAM is:
+ *
+ *	rtattr || __be32 enckeylen || authkey || enckey
+ *
+ * Note that the rtattr is in cpu-endian form, unlike enckeylen.  This must be
+ * handled correctly in static testmgr data.
+ */
+int crypto_krb5enc_extractkeys(struct crypto_authenc_keys *keys, const u8 *key,
+			       unsigned int keylen)
+{
+	struct rtattr *rta = (struct rtattr *)key;
+	struct crypto_authenc_key_param *param;
+
+	if (!RTA_OK(rta, keylen))
+		return -EINVAL;
+	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
+		return -EINVAL;
+
+	/*
+	 * RTA_OK() didn't align the rtattr's payload when validating that it
+	 * fits in the buffer.  Yet, the keys should start on the next 4-byte
+	 * aligned boundary.  To avoid confusion, require that the rtattr
+	 * payload be exactly the param struct, which has a 4-byte aligned size.
+	 */
+	if (RTA_PAYLOAD(rta) != sizeof(*param))
+		return -EINVAL;
+	BUILD_BUG_ON(sizeof(*param) % RTA_ALIGNTO);
+
+	param = RTA_DATA(rta);
+	keys->enckeylen = be32_to_cpu(param->enckeylen);
+
+	key += rta->rta_len;
+	keylen -= rta->rta_len;
+
+	if (keylen < keys->enckeylen)
+		return -EINVAL;
+
+	keys->authkeylen = keylen - keys->enckeylen;
+	keys->authkey = key;
+	keys->enckey = key + keys->authkeylen;
+	return 0;
+}
+EXPORT_SYMBOL(crypto_krb5enc_extractkeys);
+
+static int krb5enc_setkey(struct crypto_aead *krb5enc, const u8 *key,
+			  unsigned int keylen)
+{
+	struct crypto_authenc_keys keys;
+	struct krb5enc_ctx *ctx = crypto_aead_ctx(krb5enc);
+	struct crypto_skcipher *enc = ctx->enc;
+	struct crypto_ahash *auth = ctx->auth;
+	unsigned int flags = crypto_aead_get_flags(krb5enc);
+	int err = -EINVAL;
+
+	if (crypto_krb5enc_extractkeys(&keys, key, keylen) != 0)
+		goto out;
+
+	crypto_ahash_clear_flags(auth, CRYPTO_TFM_REQ_MASK);
+	crypto_ahash_set_flags(auth, flags & CRYPTO_TFM_REQ_MASK);
+	err = crypto_ahash_setkey(auth, keys.authkey, keys.authkeylen);
+	if (err)
+		goto out;
+
+	crypto_skcipher_clear_flags(enc, CRYPTO_TFM_REQ_MASK);
+	crypto_skcipher_set_flags(enc, flags & CRYPTO_TFM_REQ_MASK);
+	err = crypto_skcipher_setkey(enc, keys.enckey, keys.enckeylen);
+out:
+	memzero_explicit(&keys, sizeof(keys));
+	return err;
+}
+
+static void krb5enc_encrypt_done(void *data, int err)
+{
+	struct aead_request *req = data;
+
+	krb5enc_request_complete(req, err);
+}
+
+/*
+ * Start the encryption of the plaintext.  We skip over the associated data as
+ * that only gets included in the hash.
+ */
+static int krb5enc_dispatch_encrypt(struct aead_request *req,
+				    unsigned int flags)
+{
+	struct crypto_aead *krb5enc = crypto_aead_reqtfm(req);
+	struct aead_instance *inst = aead_alg_instance(krb5enc);
+	struct krb5enc_ctx *ctx = crypto_aead_ctx(krb5enc);
+	struct krb5enc_instance_ctx *ictx = aead_instance_ctx(inst);
+	struct krb5enc_request_ctx *areq_ctx = aead_request_ctx(req);
+	struct crypto_skcipher *enc = ctx->enc;
+	struct skcipher_request *skreq = (void *)(areq_ctx->tail +
+						  ictx->reqoff);
+	struct scatterlist *src, *dst;
+
+	src = scatterwalk_ffwd(areq_ctx->src, req->src, req->assoclen);
+	if (req->src == req->dst)
+		dst = src;
+	else
+		dst = scatterwalk_ffwd(areq_ctx->dst, req->dst, req->assoclen);
+
+	skcipher_request_set_tfm(skreq, enc);
+	skcipher_request_set_callback(skreq, aead_request_flags(req),
+				      krb5enc_encrypt_done, req);
+	skcipher_request_set_crypt(skreq, src, dst, req->cryptlen, req->iv);
+
+	return crypto_skcipher_encrypt(skreq);
+}
+
+/*
+ * Insert the hash into the checksum field in the destination buffer directly
+ * after the encrypted region.
+ */
+static void krb5enc_insert_checksum(struct aead_request *req, u8 *hash)
+{
+	struct crypto_aead *krb5enc = crypto_aead_reqtfm(req);
+
+	scatterwalk_map_and_copy(hash, req->dst,
+				 req->assoclen + req->cryptlen,
+				 crypto_aead_authsize(krb5enc), 1);
+}
+
+/*
+ * Upon completion of an asynchronous digest, transfer the hash to the checksum
+ * field.
+ */
+static void krb5enc_encrypt_ahash_done(void *data, int err)
+{
+	struct aead_request *req = data;
+	struct crypto_aead *krb5enc = crypto_aead_reqtfm(req);
+	struct aead_instance *inst = aead_alg_instance(krb5enc);
+	struct krb5enc_instance_ctx *ictx = aead_instance_ctx(inst);
+	struct krb5enc_request_ctx *areq_ctx = aead_request_ctx(req);
+	struct ahash_request *ahreq = (void *)(areq_ctx->tail + ictx->reqoff);
+
+	if (err)
+		return krb5enc_request_complete(req, err);
+
+	krb5enc_insert_checksum(req, ahreq->result);
+
+	err = krb5enc_dispatch_encrypt(req, 0);
+	if (err != -EINPROGRESS)
+		aead_request_complete(req, err);
+}
+
+/*
+ * Start the digest of the plaintext for encryption.  In theory, this could be
+ * run in parallel with the encryption, provided the src and dst buffers don't
+ * overlap.
+ */
+static int krb5enc_dispatch_encrypt_hash(struct aead_request *req)
+{
+	struct crypto_aead *krb5enc = crypto_aead_reqtfm(req);
+	struct aead_instance *inst = aead_alg_instance(krb5enc);
+	struct krb5enc_ctx *ctx = crypto_aead_ctx(krb5enc);
+	struct krb5enc_instance_ctx *ictx = aead_instance_ctx(inst);
+	struct crypto_ahash *auth = ctx->auth;
+	struct krb5enc_request_ctx *areq_ctx = aead_request_ctx(req);
+	struct ahash_request *ahreq = (void *)(areq_ctx->tail + ictx->reqoff);
+	u8 *hash = areq_ctx->tail;
+	int err;
+
+	ahash_request_set_callback(ahreq, aead_request_flags(req),
+				   krb5enc_encrypt_ahash_done, req);
+	ahash_request_set_tfm(ahreq, auth);
+	ahash_request_set_crypt(ahreq, req->src, hash, req->assoclen + req->cryptlen);
+
+	err = crypto_ahash_digest(ahreq);
+	if (err)
+		return err;
+
+	krb5enc_insert_checksum(req, hash);
+	return 0;
+}
+
+/*
+ * Process an encryption operation.  We can perform the cipher and the hash in
+ * parallel, provided the src and dst buffers are separate.
+ */
+static int krb5enc_encrypt(struct aead_request *req)
+{
+	int err;
+
+	err = krb5enc_dispatch_encrypt_hash(req);
+	if (err < 0)
+		return err;
+
+	return krb5enc_dispatch_encrypt(req, aead_request_flags(req));
+}
+
+static int krb5enc_verify_hash(struct aead_request *req)
+{
+	struct crypto_aead *krb5enc = crypto_aead_reqtfm(req);
+	struct aead_instance *inst = aead_alg_instance(krb5enc);
+	struct krb5enc_instance_ctx *ictx = aead_instance_ctx(inst);
+	struct krb5enc_request_ctx *areq_ctx = aead_request_ctx(req);
+	struct ahash_request *ahreq = (void *)(areq_ctx->tail + ictx->reqoff);
+	unsigned int authsize = crypto_aead_authsize(krb5enc);
+	u8 *calc_hash = areq_ctx->tail;
+	u8 *msg_hash  = areq_ctx->tail + authsize;
+
+	scatterwalk_map_and_copy(msg_hash, req->src, ahreq->nbytes, authsize, 0);
+
+	if (crypto_memneq(msg_hash, calc_hash, authsize))
+		return -EBADMSG;
+	return 0;
+}
+
+static void krb5enc_decrypt_hash_done(void *data, int err)
+{
+	struct aead_request *req = data;
+
+	if (err)
+		return krb5enc_request_complete(req, err);
+
+	err = krb5enc_verify_hash(req);
+	krb5enc_request_complete(req, err);
+}
+
+/*
+ * Dispatch the hashing of the plaintext after we've done the decryption.
+ */
+static int krb5enc_dispatch_decrypt_hash(struct aead_request *req)
+{
+	struct crypto_aead *krb5enc = crypto_aead_reqtfm(req);
+	struct aead_instance *inst = aead_alg_instance(krb5enc);
+	struct krb5enc_ctx *ctx = crypto_aead_ctx(krb5enc);
+	struct krb5enc_instance_ctx *ictx = aead_instance_ctx(inst);
+	struct krb5enc_request_ctx *areq_ctx = aead_request_ctx(req);
+	struct ahash_request *ahreq = (void *)(areq_ctx->tail + ictx->reqoff);
+	struct crypto_ahash *auth = ctx->auth;
+	unsigned int authsize = crypto_aead_authsize(krb5enc);
+	u8 *hash = areq_ctx->tail;
+	int err;
+
+	ahash_request_set_tfm(ahreq, auth);
+	ahash_request_set_crypt(ahreq, req->dst, hash,
+				req->assoclen + req->cryptlen - authsize);
+	ahash_request_set_callback(ahreq, aead_request_flags(req),
+				   krb5enc_decrypt_hash_done, req);
+
+	err = crypto_ahash_digest(ahreq);
+	if (err < 0)
+		return err;
+
+	return krb5enc_verify_hash(req);
+}
+
+/*
+ * Dispatch the decryption of the ciphertext.
+ */
+static int krb5enc_dispatch_decrypt(struct aead_request *req)
+{
+	struct crypto_aead *krb5enc = crypto_aead_reqtfm(req);
+	struct aead_instance *inst = aead_alg_instance(krb5enc);
+	struct krb5enc_ctx *ctx = crypto_aead_ctx(krb5enc);
+	struct krb5enc_instance_ctx *ictx = aead_instance_ctx(inst);
+	struct krb5enc_request_ctx *areq_ctx = aead_request_ctx(req);
+	struct skcipher_request *skreq = (void *)(areq_ctx->tail +
+						  ictx->reqoff);
+	unsigned int authsize = crypto_aead_authsize(krb5enc);
+	struct scatterlist *src, *dst;
+
+	src = scatterwalk_ffwd(areq_ctx->src, req->src, req->assoclen);
+	dst = src;
+
+	if (req->src != req->dst)
+		dst = scatterwalk_ffwd(areq_ctx->dst, req->dst, req->assoclen);
+
+	skcipher_request_set_tfm(skreq, ctx->enc);
+	skcipher_request_set_callback(skreq, aead_request_flags(req),
+				      req->base.complete, req->base.data);
+	skcipher_request_set_crypt(skreq, src, dst,
+				   req->cryptlen - authsize, req->iv);
+
+	return crypto_skcipher_decrypt(skreq);
+}
+
+static int krb5enc_decrypt(struct aead_request *req)
+{
+	int err;
+
+	err = krb5enc_dispatch_decrypt(req);
+	if (err < 0)
+		return err;
+
+	return krb5enc_dispatch_decrypt_hash(req);
+}
+
+static int krb5enc_init_tfm(struct crypto_aead *tfm)
+{
+	struct aead_instance *inst = aead_alg_instance(tfm);
+	struct krb5enc_instance_ctx *ictx = aead_instance_ctx(inst);
+	struct krb5enc_ctx *ctx = crypto_aead_ctx(tfm);
+	struct crypto_ahash *auth;
+	struct crypto_skcipher *enc;
+	int err;
+
+	auth = crypto_spawn_ahash(&ictx->auth);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);
+
+	enc = crypto_spawn_skcipher(&ictx->enc);
+	err = PTR_ERR(enc);
+	if (IS_ERR(enc))
+		goto err_free_ahash;
+
+	ctx->auth = auth;
+	ctx->enc = enc;
+
+	crypto_aead_set_reqsize(
+		tfm,
+		sizeof(struct krb5enc_request_ctx) +
+		ictx->reqoff + /* Space for two checksums */
+		umax(sizeof(struct ahash_request) + crypto_ahash_reqsize(auth),
+		     sizeof(struct skcipher_request) + crypto_skcipher_reqsize(enc)));
+
+	return 0;
+
+err_free_ahash:
+	crypto_free_ahash(auth);
+	return err;
+}
+
+static void krb5enc_exit_tfm(struct crypto_aead *tfm)
+{
+	struct krb5enc_ctx *ctx = crypto_aead_ctx(tfm);
+
+	crypto_free_ahash(ctx->auth);
+	crypto_free_skcipher(ctx->enc);
+}
+
+static void krb5enc_free(struct aead_instance *inst)
+{
+	struct krb5enc_instance_ctx *ctx = aead_instance_ctx(inst);
+
+	crypto_drop_skcipher(&ctx->enc);
+	crypto_drop_ahash(&ctx->auth);
+	kfree(inst);
+}
+
+/*
+ * Create an instance of a template for a specific hash and cipher pair.
+ */
+static int krb5enc_create(struct crypto_template *tmpl, struct rtattr **tb)
+{
+	struct krb5enc_instance_ctx *ictx;
+	struct skcipher_alg_common *enc;
+	struct hash_alg_common *auth;
+	struct aead_instance *inst;
+	struct crypto_alg *auth_base;
+	u32 mask;
+	int err;
+
+	err = crypto_check_attr_type(tb, CRYPTO_ALG_TYPE_AEAD, &mask);
+	if (err) {
+		pr_err("attr_type failed\n");
+		return err;
+	}
+
+	inst = kzalloc(sizeof(*inst) + sizeof(*ictx), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+	ictx = aead_instance_ctx(inst);
+
+	err = crypto_grab_ahash(&ictx->auth, aead_crypto_instance(inst),
+				crypto_attr_alg_name(tb[1]), 0, mask);
+	if (err) {
+		pr_err("grab ahash failed\n");
+		goto err_free_inst;
+	}
+	auth = crypto_spawn_ahash_alg(&ictx->auth);
+	auth_base = &auth->base;
+
+	err = crypto_grab_skcipher(&ictx->enc, aead_crypto_instance(inst),
+				   crypto_attr_alg_name(tb[2]), 0, mask);
+	if (err) {
+		pr_err("grab skcipher failed\n");
+		goto err_free_inst;
+	}
+	enc = crypto_spawn_skcipher_alg_common(&ictx->enc);
+
+	ictx->reqoff = 2 * auth->digestsize;
+
+	err = -ENAMETOOLONG;
+	if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
+		     "krb5enc(%s,%s)", auth_base->cra_name,
+		     enc->base.cra_name) >=
+	    CRYPTO_MAX_ALG_NAME)
+		goto err_free_inst;
+
+	if (snprintf(inst->alg.base.cra_driver_name, CRYPTO_MAX_ALG_NAME,
+		     "krb5enc(%s,%s)", auth_base->cra_driver_name,
+		     enc->base.cra_driver_name) >= CRYPTO_MAX_ALG_NAME)
+		goto err_free_inst;
+
+	inst->alg.base.cra_priority = enc->base.cra_priority * 10 +
+				      auth_base->cra_priority;
+	inst->alg.base.cra_blocksize = enc->base.cra_blocksize;
+	inst->alg.base.cra_alignmask = enc->base.cra_alignmask;
+	inst->alg.base.cra_ctxsize = sizeof(struct krb5enc_ctx);
+
+	inst->alg.ivsize = enc->ivsize;
+	inst->alg.chunksize = enc->chunksize;
+	inst->alg.maxauthsize = auth->digestsize;
+
+	inst->alg.init = krb5enc_init_tfm;
+	inst->alg.exit = krb5enc_exit_tfm;
+
+	inst->alg.setkey = krb5enc_setkey;
+	inst->alg.encrypt = krb5enc_encrypt;
+	inst->alg.decrypt = krb5enc_decrypt;
+
+	inst->free = krb5enc_free;
+
+	err = aead_register_instance(tmpl, inst);
+	if (err) {
+		pr_err("ref failed\n");
+		goto err_free_inst;
+	}
+
+	return 0;
+
+err_free_inst:
+	krb5enc_free(inst);
+	return err;
+}
+
+static struct crypto_template crypto_krb5enc_tmpl = {
+	.name = "krb5enc",
+	.create = krb5enc_create,
+	.module = THIS_MODULE,
+};
+
+static int __init crypto_krb5enc_module_init(void)
+{
+	return crypto_register_template(&crypto_krb5enc_tmpl);
+}
+
+static void __exit crypto_krb5enc_module_exit(void)
+{
+	crypto_unregister_template(&crypto_krb5enc_tmpl);
+}
+
+subsys_initcall(crypto_krb5enc_module_init);
+module_exit(crypto_krb5enc_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Simple AEAD wrapper for Kerberos 5 RFC3961");
+MODULE_ALIAS_CRYPTO("krb5enc");
diff --git a/include/crypto/authenc.h b/include/crypto/authenc.h
index 5f92a986083c..15a9caa2354a 100644
--- a/include/crypto/authenc.h
+++ b/include/crypto/authenc.h
@@ -28,5 +28,7 @@ struct crypto_authenc_keys {
 
 int crypto_authenc_extractkeys(struct crypto_authenc_keys *keys, const u8 *key,
 			       unsigned int keylen);
+int crypto_krb5enc_extractkeys(struct crypto_authenc_keys *keys, const u8 *key,
+			       unsigned int keylen);
 
 #endif	/* _CRYPTO_AUTHENC_H */


