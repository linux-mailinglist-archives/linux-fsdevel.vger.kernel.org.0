Return-Path: <linux-fsdevel+bounces-39525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66232A15702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76E23A8FF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977C1DED70;
	Fri, 17 Jan 2025 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsbaTPdL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D901DE3B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138996; cv=none; b=RhlTlwnLtmb0L1x8Y4h7vvAwHNf3drY5iOy48iS/g4pdtKxny46EqilbgY1Aftw4kwGwx2UhhnkPJ8OhLquIfQ8IZoR2Ea2F2ThN0VV8Az7rfzQ76wX3pxFhkx4UeFy2EcXV0Xw9y6Lo494g5BqHGuconua6dyoLMr3GOO2n3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138996; c=relaxed/simple;
	bh=hcLiEqLusH57asyuk6rtidVVcBWIAiWT1Cye3LilAMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG6Z4BcAIKb3TlyIVuVzSZHFihk3v5FAOjsTuGnLwhY0xf6c9NRNttUCpw9BiA3hugY5Psc0wMsoMR9GNZwazrkdRSGKNUG/HBkv/SVEg3Jfg3l+tUNKnjV7bC6r1GSAHs1APBGtEiqWre0z2SI989hBcR85zwhIRYa5XUuh568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsbaTPdL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737138993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJrSERFzFhA9hkvIgLtITQjORBjrahoI9skBYsLONhE=;
	b=TsbaTPdLCg0wLULc/2oC64ZpoLavGAbYm4VijMEJFdGSZKIpgQkDXu5vdPp+3PhVmYn1S4
	Xdt8N9dxwRHNduNvGgwR2qYnb5HHchIgj9OUsXoWOvC5W+UUHUwgPXLWX6BbgGZOQtI8hf
	89NFYPIFm5OUTT7vp4pCRGRO/rUiPVE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-9Qw9FCpSO2SEOiXpz0l0dg-1; Fri,
 17 Jan 2025 13:36:30 -0500
X-MC-Unique: 9Qw9FCpSO2SEOiXpz0l0dg-1
X-Mimecast-MFC-AGG-ID: 9Qw9FCpSO2SEOiXpz0l0dg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BA791955DD0;
	Fri, 17 Jan 2025 18:36:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEC61195608A;
	Fri, 17 Jan 2025 18:36:23 +0000 (UTC)
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
Subject: [RFC PATCH 07/24] crypto/krb5: Add an API to alloc and prepare a crypto object
Date: Fri, 17 Jan 2025 18:35:16 +0000
Message-ID: <20250117183538.881618-8-dhowells@redhat.com>
In-Reply-To: <20250117183538.881618-1-dhowells@redhat.com>
References: <20250117183538.881618-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add an API by which users of the krb5 crypto library can get an allocated
and keyed crypto object.

For encryption-mode operation, an AEAD object is returned; for
checksum-mode operation, a synchronous hash object is returned.

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
 crypto/krb5/internal.h |  10 +++
 crypto/krb5/krb5_api.c | 144 +++++++++++++++++++++++++++++++++++++++++
 include/crypto/krb5.h  |   7 ++
 3 files changed, 161 insertions(+)

diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index 3ede858be4f7..b542d24e5fa5 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -110,3 +110,13 @@ struct krb5_crypto_profile {
 #define krb5_digest_size(TFM) \
 	crypto_roundup(crypto_shash_digestsize(TFM))
 #define round16(x) (((x) + 15) & ~15)
+
+/*
+ * krb5_api.c
+ */
+struct crypto_aead *krb5_prepare_encryption(const struct krb5_enctype *krb5,
+					    const struct krb5_buffer *keys,
+					    gfp_t gfp);
+struct crypto_shash *krb5_prepare_checksum(const struct krb5_enctype *krb5,
+					   const struct krb5_buffer *Kc,
+					   gfp_t gfp);
diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index f6d1bc813daa..f7f2528b3895 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -148,3 +148,147 @@ void crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
 	}
 }
 EXPORT_SYMBOL(crypto_krb5_where_is_the_data);
+
+/*
+ * Prepare the encryption with derived key data.
+ */
+struct crypto_aead *krb5_prepare_encryption(const struct krb5_enctype *krb5,
+					    const struct krb5_buffer *keys,
+					    gfp_t gfp)
+{
+	struct crypto_aead *ci = NULL;
+	int ret = -ENOMEM;
+
+	ci = crypto_alloc_aead(krb5->encrypt_name, 0, 0);
+	if (IS_ERR(ci)) {
+		ret = PTR_ERR(ci);
+		if (ret == -ENOENT)
+			ret = -ENOPKG;
+		goto err;
+	}
+
+	ret = crypto_aead_setkey(ci, keys->data, keys->len);
+	if (ret < 0) {
+		pr_err("Couldn't set AEAD key %s: %d\n", krb5->encrypt_name, ret);
+		goto err_ci;
+	}
+
+	ret = crypto_aead_setauthsize(ci, krb5->cksum_len);
+	if (ret < 0) {
+		pr_err("Couldn't set AEAD authsize %s: %d\n", krb5->encrypt_name, ret);
+		goto err_ci;
+	}
+
+	return ci;
+err_ci:
+	crypto_free_aead(ci);
+err:
+	return ERR_PTR(ret);
+}
+
+/**
+ * crypto_krb5_prepare_encryption - Prepare AEAD crypto object for encryption-mode
+ * @krb5: The encoding to use.
+ * @TK: The transport key to use.
+ * @usage: The usage constant for key derivation.
+ * @gfp: Allocation flags.
+ *
+ * Allocate a crypto object that does all the necessary crypto, key it and set
+ * its parameters and return the crypto handle to it.  This can then be used to
+ * dispatch encrypt and decrypt operations.
+ */
+struct crypto_aead *crypto_krb5_prepare_encryption(const struct krb5_enctype *krb5,
+						   const struct krb5_buffer *TK,
+						   u32 usage, gfp_t gfp)
+{
+	struct crypto_aead *ci = NULL;
+	struct krb5_buffer keys = {};
+	int ret;
+
+	ret = krb5->profile->derive_encrypt_keys(krb5, TK, usage, &keys, gfp);
+	if (ret < 0)
+		goto err;
+
+	ci = krb5_prepare_encryption(krb5, &keys, gfp);
+	if (IS_ERR(ci)) {
+		ret = PTR_ERR(ci);
+		goto err;
+	}
+
+	kfree(keys.data);
+	return ci;
+err:
+	kfree(keys.data);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(crypto_krb5_prepare_encryption);
+
+/*
+ * Prepare the checksum with derived key data.
+ */
+struct crypto_shash *krb5_prepare_checksum(const struct krb5_enctype *krb5,
+					   const struct krb5_buffer *Kc,
+					   gfp_t gfp)
+{
+	struct crypto_shash *ci = NULL;
+	int ret = -ENOMEM;
+
+	ci = crypto_alloc_shash(krb5->cksum_name, 0, 0);
+	if (IS_ERR(ci)) {
+		ret = PTR_ERR(ci);
+		if (ret == -ENOENT)
+			ret = -ENOPKG;
+		goto err;
+	}
+
+	ret = crypto_shash_setkey(ci, Kc->data, Kc->len);
+	if (ret < 0) {
+		pr_err("Couldn't set shash key %s: %d\n", krb5->cksum_name, ret);
+		goto err_ci;
+	}
+
+	return ci;
+err_ci:
+	crypto_free_shash(ci);
+err:
+	return ERR_PTR(ret);
+}
+
+/**
+ * crypto_krb5_prepare_checksum - Prepare AEAD crypto object for checksum-mode
+ * @krb5: The encoding to use.
+ * @TK: The transport key to use.
+ * @usage: The usage constant for key derivation.
+ * @gfp: Allocation flags.
+ *
+ * Allocate a crypto object that does all the necessary crypto, key it and set
+ * its parameters and return the crypto handle to it.  This can then be used to
+ * dispatch get_mic and verify_mic operations.
+ */
+struct crypto_shash *crypto_krb5_prepare_checksum(const struct krb5_enctype *krb5,
+						  const struct krb5_buffer *TK,
+						  u32 usage, gfp_t gfp)
+{
+	struct crypto_shash *ci = NULL;
+	struct krb5_buffer keys = {};
+	int ret;
+
+	ret = krb5->profile->derive_checksum_key(krb5, TK, usage, &keys, gfp);
+	if (ret < 0) {
+		pr_err("get_Kc failed %d\n", ret);
+		goto err;
+	}
+
+	ci = krb5_prepare_checksum(krb5, &keys, gfp);
+	if (IS_ERR(ci)) {
+		ret = PTR_ERR(ci);
+		goto err;
+	}
+
+	kfree(keys.data);
+	return ci;
+err:
+	kfree(keys.data);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(crypto_krb5_prepare_checksum);
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index e7dfe0b7c60d..5ff052e2c157 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -10,6 +10,7 @@
 
 #include <linux/crypto.h>
 #include <crypto/aead.h>
+#include <crypto/hash.h>
 
 struct crypto_shash;
 struct scatterlist;
@@ -110,6 +111,12 @@ size_t crypto_krb5_how_much_data(const struct krb5_enctype *krb5,
 void crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
 				   enum krb5_crypto_mode mode,
 				   size_t *_offset, size_t *_len);
+struct crypto_aead *crypto_krb5_prepare_encryption(const struct krb5_enctype *krb5,
+						   const struct krb5_buffer *TK,
+						   u32 usage, gfp_t gfp);
+struct crypto_shash *crypto_krb5_prepare_checksum(const struct krb5_enctype *krb5,
+						  const struct krb5_buffer *TK,
+						  u32 usage, gfp_t gfp);
 
 /*
  * krb5enc.c


