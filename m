Return-Path: <linux-fsdevel+bounces-39537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34842A1573D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548BE160FD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0E11A76AC;
	Fri, 17 Jan 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iq8G/G9j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A41E2845
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139066; cv=none; b=Y8pROaekBrT+jEsVmL/kCD7BixFaC/O0uWK44e3KhKqqvoKiJnwhPH7erRfnKF0IW4yq8EmcoHALjX3pG8+6TQshRMwCkTkqciDAflKDeTjZDUwV/HYaZhSBEgz9r41x0UwImS81XSejBGSRDS4Ypev540vlpbKoTlGBMEr3utA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139066; c=relaxed/simple;
	bh=8+663rEO7usJbCPURbsFXevkm4/XrF/a2s1g0LyEsNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+zdAvvO94XC9U/sZ3I4n7VH5jpQ+VZXg2JQWHQOeg9pLy2AakNwAPmrdwAGX2OAmNDcRI4g5yc+SU9im/47aYAL1QYcxKUpgpVFlA8tlsYMWCdjTEJY5VLctTXNwkcQFO0RzmbW9aoZAmN68gKbxcMv/sE0EvVmJOxfkER7YIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iq8G/G9j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4en6bLmxDNkPIJDvfFac6/6XbNgj/D5eYuzYpBOuN/s=;
	b=iq8G/G9jQWO9I7bAjd2vWzqSQkY9PCab1WxbO9UWMbXqZAzxaar/Q4WOMvkEHgIKx9R1j5
	PYWZ4aD0k64Lm1Vf4Oy+j2i+3It/ekv7dUSnoLllnfhoX4xiFUBRyKJj29HFhJ3KDhEr0Q
	2ph9QGgSCGvcXrC7b7vch+vSOiHu6D4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-u1MEZneaPZCpgh7THTKqYA-1; Fri,
 17 Jan 2025 13:37:40 -0500
X-MC-Unique: u1MEZneaPZCpgh7THTKqYA-1
X-Mimecast-MFC-AGG-ID: u1MEZneaPZCpgh7THTKqYA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D38F1955D5D;
	Fri, 17 Jan 2025 18:37:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4914195608A;
	Fri, 17 Jan 2025 18:37:33 +0000 (UTC)
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
Subject: [RFC PATCH 19/24] crypto/krb5: Implement the Camellia enctypes from rfc6803
Date: Fri, 17 Jan 2025 18:35:28 +0000
Message-ID: <20250117183538.881618-20-dhowells@redhat.com>
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

Implement the camellia128-cts-cmac and camellia256-cts-cmac enctypes from
rfc6803.

Note that the test vectors in rfc6803 for encryption are incomplete,
lacking the key usage number needed to derive Ke and Ki, and there are
errata for this:

	https://www.rfc-editor.org/errata_search.php?rfc=6803

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
 crypto/krb5/Kconfig            |   2 +
 crypto/krb5/Makefile           |   1 +
 crypto/krb5/internal.h         |   6 +
 crypto/krb5/krb5_api.c         |   2 +
 crypto/krb5/rfc6803_camellia.c | 237 +++++++++++++++++++++++++++++++++
 crypto/krb5/selftest_data.c    | 135 +++++++++++++++++++
 include/crypto/krb5.h          |   4 +
 7 files changed, 387 insertions(+)
 create mode 100644 crypto/krb5/rfc6803_camellia.c

diff --git a/crypto/krb5/Kconfig b/crypto/krb5/Kconfig
index 82d7e3b55878..4d0476e13f3c 100644
--- a/crypto/krb5/Kconfig
+++ b/crypto/krb5/Kconfig
@@ -6,12 +6,14 @@ config CRYPTO_KRB5
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH_INFO
 	select CRYPTO_HMAC
+	select CRYPTO_CMAC
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_CBC
 	select CRYPTO_CTS
 	select CRYPTO_AES
+	select CRYPTO_CAMELLIA
 	help
 	  Provide a library for provision of Kerberos-5-based crypto.  This is
 	  intended for network filesystems to use.
diff --git a/crypto/krb5/Makefile b/crypto/krb5/Makefile
index 1ad327227744..d38890c0b247 100644
--- a/crypto/krb5/Makefile
+++ b/crypto/krb5/Makefile
@@ -8,6 +8,7 @@ krb5-y += \
 	krb5_api.o \
 	rfc3961_simplified.o \
 	rfc3962_aes.o \
+	rfc6803_camellia.o \
 	rfc8009_aes2.o
 
 krb5-$(CONFIG_CRYPTO_KRB5_SELFTESTS) += \
diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index a40f120b4954..0a7ecd800416 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -217,6 +217,12 @@ int rfc3961_verify_mic(const struct krb5_enctype *krb5,
 extern const struct krb5_enctype krb5_aes128_cts_hmac_sha1_96;
 extern const struct krb5_enctype krb5_aes256_cts_hmac_sha1_96;
 
+/*
+ * rfc6803_camellia.c
+ */
+extern const struct krb5_enctype krb5_camellia128_cts_cmac;
+extern const struct krb5_enctype krb5_camellia256_cts_cmac;
+
 /*
  * rfc8009_aes2.c
  */
diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index 8c2949ac9c07..23026d4206c8 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -21,6 +21,8 @@ static const struct krb5_enctype *const krb5_supported_enctypes[] = {
 	&krb5_aes256_cts_hmac_sha1_96,
 	&krb5_aes128_cts_hmac_sha256_128,
 	&krb5_aes256_cts_hmac_sha384_192,
+	&krb5_camellia128_cts_cmac,
+	&krb5_camellia256_cts_cmac,
 };
 
 /**
diff --git a/crypto/krb5/rfc6803_camellia.c b/crypto/krb5/rfc6803_camellia.c
new file mode 100644
index 000000000000..c2895d2d60ed
--- /dev/null
+++ b/crypto/krb5/rfc6803_camellia.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* rfc6803 Camellia Encryption for Kerberos 5
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * Calculate the key derivation function KDF-FEEDBACK_CMAC(key, constant)
+ *
+ *	n = ceiling(k / 128)
+ *	K(0) = zeros
+ *	K(i) = CMAC(key, K(i-1) | i | constant | 0x00 | k)
+ *	DR(key, constant) = k-truncate(K(1) | K(2) | ... | K(n))
+ *	KDF-FEEDBACK-CMAC(key, constant) = random-to-key(DR(key, constant))
+ *
+ *	[rfc6803 sec 3]
+ */
+static int rfc6803_calc_KDF_FEEDBACK_CMAC(const struct krb5_enctype *krb5,
+					  const struct krb5_buffer *key,
+					  const struct krb5_buffer *constant,
+					  struct krb5_buffer *result,
+					  gfp_t gfp)
+{
+	struct crypto_shash *shash;
+	struct krb5_buffer K, data;
+	struct shash_desc *desc;
+	__be32 tmp;
+	size_t bsize, offset, seg;
+	void *buffer;
+	u32 i = 0, k = result->len * 8;
+	u8 *p;
+	int ret = -ENOMEM;
+
+	shash = crypto_alloc_shash(krb5->cksum_name, 0, 0);
+	if (IS_ERR(shash))
+		return (PTR_ERR(shash) == -ENOENT) ? -ENOPKG : PTR_ERR(shash);
+	ret = crypto_shash_setkey(shash, key->data, key->len);
+	if (ret < 0)
+		goto error_shash;
+
+	ret = -ENOMEM;
+	K.len = crypto_shash_digestsize(shash);
+	data.len = K.len + 4 + constant->len + 1 + 4;
+	bsize = krb5_shash_size(shash) +
+		krb5_digest_size(shash) +
+		crypto_roundup(K.len) +
+		crypto_roundup(data.len);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		goto error_shash;
+
+	desc = buffer;
+	desc->tfm = shash;
+
+	K.data = buffer +
+		krb5_shash_size(shash) +
+		krb5_digest_size(shash);
+	data.data = buffer +
+		krb5_shash_size(shash) +
+		krb5_digest_size(shash) +
+		crypto_roundup(K.len);
+
+	p = data.data + K.len + 4;
+	memcpy(p, constant->data, constant->len);
+	p += constant->len;
+	*p++ = 0x00;
+	tmp = htonl(k);
+	memcpy(p, &tmp, 4);
+	p += 4;
+
+	ret = -EINVAL;
+	if (WARN_ON(p - (u8 *)data.data != data.len))
+		goto error;
+
+	offset = 0;
+	do {
+		i++;
+		p = data.data;
+		memcpy(p, K.data, K.len);
+		p += K.len;
+		*(__be32 *)p = htonl(i);
+
+		ret = crypto_shash_init(desc);
+		if (ret < 0)
+			goto error;
+		ret = crypto_shash_finup(desc, data.data, data.len, K.data);
+		if (ret < 0)
+			goto error;
+
+		seg = min_t(size_t, result->len - offset, K.len);
+		memcpy(result->data + offset, K.data, seg);
+		offset += seg;
+	} while (offset < result->len);
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
+ *	Kp = KDF-FEEDBACK-CMAC(protocol-key, "prf")
+ *	PRF = CMAC(Kp, octet-string)
+ *      [rfc6803 sec 6]
+ */
+static int rfc6803_calc_PRF(const struct krb5_enctype *krb5,
+			    const struct krb5_buffer *protocol_key,
+			    const struct krb5_buffer *octet_string,
+			    struct krb5_buffer *result,
+			    gfp_t gfp)
+{
+	static const struct krb5_buffer prfconstant = { 3, "prf" };
+	struct crypto_shash *shash;
+	struct krb5_buffer Kp;
+	struct shash_desc *desc;
+	size_t bsize;
+	void *buffer;
+	int ret;
+
+	Kp.len = krb5->prf_len;
+
+	shash = crypto_alloc_shash(krb5->cksum_name, 0, 0);
+	if (IS_ERR(shash))
+		return (PTR_ERR(shash) == -ENOENT) ? -ENOPKG : PTR_ERR(shash);
+
+	ret = -EINVAL;
+	if (result->len != crypto_shash_digestsize(shash))
+		goto out_shash;
+
+	ret = -ENOMEM;
+	bsize = krb5_shash_size(shash) +
+		krb5_digest_size(shash) +
+		crypto_roundup(Kp.len);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		goto out_shash;
+
+	Kp.data = buffer +
+		krb5_shash_size(shash) +
+		krb5_digest_size(shash);
+
+	ret = rfc6803_calc_KDF_FEEDBACK_CMAC(krb5, protocol_key, &prfconstant,
+					     &Kp, gfp);
+	if (ret < 0)
+		goto out;
+
+	ret = crypto_shash_setkey(shash, Kp.data, Kp.len);
+	if (ret < 0)
+		goto out;
+
+	desc = buffer;
+	desc->tfm = shash;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto out;
+
+	ret = crypto_shash_finup(desc, octet_string->data, octet_string->len, result->data);
+	if (ret < 0)
+		goto out;
+
+out:
+	kfree_sensitive(buffer);
+out_shash:
+	crypto_free_shash(shash);
+	return ret;
+}
+
+
+static const struct krb5_crypto_profile rfc6803_crypto_profile = {
+	.calc_PRF		= rfc6803_calc_PRF,
+	.calc_Kc		= rfc6803_calc_KDF_FEEDBACK_CMAC,
+	.calc_Ke		= rfc6803_calc_KDF_FEEDBACK_CMAC,
+	.calc_Ki		= rfc6803_calc_KDF_FEEDBACK_CMAC,
+	.derive_encrypt_keys	= krb5enc_derive_encrypt_keys,
+	.load_encrypt_keys	= krb5enc_load_encrypt_keys,
+	.derive_checksum_key	= rfc3961_derive_checksum_key,
+	.load_checksum_key	= rfc3961_load_checksum_key,
+	.encrypt		= krb5_aead_encrypt,
+	.decrypt		= krb5_aead_decrypt,
+	.get_mic		= rfc3961_get_mic,
+	.verify_mic		= rfc3961_verify_mic,
+};
+
+const struct krb5_enctype krb5_camellia128_cts_cmac = {
+	.etype		= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+	.ctype		= KRB5_CKSUMTYPE_CMAC_CAMELLIA128,
+	.name		= "camellia128-cts-cmac",
+	.encrypt_name	= "krb5enc(cmac(camellia),cts(cbc(camellia)))",
+	.cksum_name	= "cmac(camellia)",
+	.hash_name	= NULL,
+	.derivation_enc	= "cts(cbc(camellia))",
+	.key_bytes	= 16,
+	.key_len	= 16,
+	.Kc_len		= 16,
+	.Ke_len		= 16,
+	.Ki_len		= 16,
+	.block_len	= 16,
+	.conf_len	= 16,
+	.cksum_len	= 16,
+	.hash_len	= 16,
+	.prf_len	= 16,
+	.keyed_cksum	= true,
+	.random_to_key	= NULL, /* Identity */
+	.profile	= &rfc6803_crypto_profile,
+};
+
+const struct krb5_enctype krb5_camellia256_cts_cmac = {
+	.etype		= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+	.ctype		= KRB5_CKSUMTYPE_CMAC_CAMELLIA256,
+	.name		= "camellia256-cts-cmac",
+	.encrypt_name	= "krb5enc(cmac(camellia),cts(cbc(camellia)))",
+	.cksum_name	= "cmac(camellia)",
+	.hash_name	= NULL,
+	.derivation_enc	= "cts(cbc(camellia))",
+	.key_bytes	= 32,
+	.key_len	= 32,
+	.Kc_len		= 32,
+	.Ke_len		= 32,
+	.Ki_len		= 32,
+	.block_len	= 16,
+	.conf_len	= 16,
+	.cksum_len	= 16,
+	.hash_len	= 16,
+	.prf_len	= 16,
+	.keyed_cksum	= true,
+	.random_to_key	= NULL, /* Identity */
+	.profile	= &rfc6803_crypto_profile,
+};
diff --git a/crypto/krb5/selftest_data.c b/crypto/krb5/selftest_data.c
index 3a5563d57280..24447ee8bf07 100644
--- a/crypto/krb5/selftest_data.c
+++ b/crypto/krb5/selftest_data.c
@@ -58,6 +58,29 @@ const struct krb5_key_test krb5_key_tests[] = {
 		.Ki.use	= 0x00000002,
 		.Ki.key	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
 	},
+	/* rfc6803 sec 10 */
+	{
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "key",
+		.key	= "57D0297298FFD9D35DE5A47FB4BDE24B",
+		.Kc.use	= 0x00000002,
+		.Kc.key	= "D155775A209D05F02B38D42A389E5A56",
+		.Ke.use	= 0x00000002,
+		.Ke.key	= "64DF83F85A532F17577D8C37035796AB",
+		.Ki.use	= 0x00000002,
+		.Ki.key	= "3E4FBDF30FB8259C425CB6C96F1F4635",
+	},
+	{
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "key",
+		.key	= "B9D6828B2056B7BE656D88A123B1FAC68214AC2B727ECF5F69AFE0C4DF2A6D2C",
+		.Kc.use	= 0x00000002,
+		.Kc.key	= "E467F9A9552BC7D3155A6220AF9C19220EEED4FF78B0D1E6A1544991461A9E50",
+		.Ke.use	= 0x00000002,
+		.Ke.key	= "412AEFC362A7285FC3966C6A5181E7605AE675235B6D549FBFC9AB6630A4C604",
+		.Ki.use	= 0x00000002,
+		.Ki.key	= "FA624FA0E523993FA388AEFDC67E67EBCD8C08E8A0246B1D73B0D1DD9FC582B0",
+	},
 	{/* END */}
 };
 
@@ -131,6 +154,88 @@ const struct krb5_enc_test krb5_enc_tests[] = {
 		.Ki	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
 		.ct	= "40013E2DF58E8751957D2878BCD2D6FE101CCFD556CB1EAE79DB3C3EE86429F2B2A602AC86FEF6ECB647D6295FAE077A1FEB517508D2C16B4192E01F62",
 	},
+	/* rfc6803 sec 10 */
+	{
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "enc no plain",
+		.plain	= "",
+		.conf	= "B69822A19A6B09C0EBC8557D1F1B6C0A",
+		.K0	= "1DC46A8D763F4F93742BCBA3387576C3",
+		.usage	= 0,
+		.ct	= "C466F1871069921EDB7C6FDE244A52DB0BA10EDC197BDB8006658CA3CCCE6EB8",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "enc 1 plain",
+		.plain	= "'1",
+		.conf	= "6F2FC3C2A166FD8898967A83DE9596D9",
+		.K0	= "5027BC231D0F3A9D23333F1CA6FDBE7C",
+		.usage	= 1,
+		.ct	= "842D21FD950311C0DD464A3F4BE8D6DA88A56D559C9B47D3F9A85067AF661559B8",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "enc 9 plain",
+		.plain	= "'9 bytesss",
+		.conf	= "A5B4A71E077AEEF93C8763C18FDB1F10",
+		.K0	= "A1BB61E805F9BA6DDE8FDBDDC05CDEA0",
+		.usage	= 2,
+		.ct	= "619FF072E36286FF0A28DEB3A352EC0D0EDF5C5160D663C901758CCF9D1ED33D71DB8F23AABF8348A0",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "enc 13 plain",
+		.plain	= "'13 bytes byte",
+		.conf	= "19FEE40D810C524B5B22F01874C693DA",
+		.K0	= "2CA27A5FAF5532244506434E1CEF6676",
+		.usage	= 3,
+		.ct	= "B8ECA3167AE6315512E59F98A7C500205E5F63FF3BB389AF1C41A21D640D8615C9ED3FBEB05AB6ACB67689B5EA",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "enc 30 plain",
+		.plain	= "'30 bytes bytes bytes bytes byt",
+		.conf	= "CA7A7AB4BE192DABD603506DB19C39E2",
+		.K0	= "7824F8C16F83FF354C6BF7515B973F43",
+		.usage	= 4,
+		.ct	= "A26A3905A4FFD5816B7B1E27380D08090C8EC1F304496E1ABDCD2BDCD1DFFC660989E117A713DDBB57A4146C1587CBA4356665591D2240282F5842B105A5",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "enc no plain",
+		.plain	= "",
+		.conf	= "3CBBD2B45917941067F96599BB98926C",
+		.K0	= "B61C86CC4E5D2757545AD423399FB7031ECAB913CBB900BD7A3C6DD8BF92015B",
+		.usage	= 0,
+		.ct	= "03886D03310B47A6D8F06D7B94D1DD837ECCE315EF652AFF620859D94A259266",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "enc 1 plain",
+		.plain	= "'1",
+		.conf	= "DEF487FCEBE6DE6346D4DA4521BBA2D2",
+		.K0	= "1B97FE0A190E2021EB30753E1B6E1E77B0754B1D684610355864104963463833",
+		.usage	= 1,
+		.ct	= "2C9C1570133C99BF6A34BC1B0212002FD194338749DB4135497A347CFCD9D18A12",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "enc 9 plain",
+		.plain	= "'9 bytesss",
+		.conf	= "AD4FF904D34E555384B14100FC465F88",
+		.K0	= "32164C5B434D1D1538E4CFD9BE8040FE8C4AC7ACC4B93D3314D2133668147A05",
+		.usage	= 2,
+		.ct	= "9C6DE75F812DE7ED0D28B2963557A115640998275B0AF5152709913FF52A2A9C8E63B872F92E64C839",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "enc 13 plain",
+		.plain	= "'13 bytes byte",
+		.conf	= "CF9BCA6DF1144E0C0AF9B8F34C90D514",
+		.K0	= "B038B132CD8E06612267FAB7170066D88AECCBA0B744BFC60DC89BCA182D0715",
+		.usage	= 3,
+		.ct	= "EEEC85A9813CDC536772AB9B42DEFC5706F726E975DDE05A87EB5406EA324CA185C9986B42AABE794B84821BEE",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "enc 30 plain",
+		.plain	= "'30 bytes bytes bytes bytes byt",
+		.conf	= "644DEF38DA35007275878D216855E228",
+		.K0	= "CCFCD349BF4C6677E86E4B02B8EAB924A546AC731CF9BF6989B996E7D6BFBBA7",
+		.usage	= 4,
+		.ct	= "0E44680985855F2D1F1812529CA83BFD8E349DE6FD9ADA0BAAA048D68E265FEBF34AD1255A344999AD37146887A6C6845731AC7F46376A0504CD06571474",
+	},
 	{/* END */}
 };
 
@@ -152,5 +257,35 @@ const struct krb5_mic_test krb5_mic_tests[] = {
 		.Kc	= "EF5718BE86CC84963D8BBB5031E9F5C4BA41F28FAF69E73D",
 		.mic	= "45EE791567EEFCA37F4AC1E0222DE80D43C3BFA06699672A",
 	},
+	/* rfc6803 sec 10 */
+	{
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "mic abc",
+		.plain	= "'abcdefghijk",
+		.K0	= "1DC46A8D763F4F93742BCBA3387576C3",
+		.usage	= 7,
+		.mic	= "1178E6C5C47A8C1AE0C4B9C7D4EB7B6B",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "mic ABC",
+		.plain	= "'ABCDEFGHIJKLMNOPQRSTUVWXYZ",
+		.K0	= "5027BC231D0F3A9D23333F1CA6FDBE7C",
+		.usage	= 8,
+		.mic	= "D1B34F7004A731F23A0C00BF6C3F753A",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "mic 123",
+		.plain	= "'123456789",
+		.K0	= "B61C86CC4E5D2757545AD423399FB7031ECAB913CBB900BD7A3C6DD8BF92015B",
+		.usage	= 9,
+		.mic	= "87A12CFD2B96214810F01C826E7744B1",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "mic !@#",
+		.plain	= "'!@#$%^&*()!@#$%^&*()!@#$%^&*()",
+		.K0	= "32164C5B434D1D1538E4CFD9BE8040FE8C4AC7ACC4B93D3314D2133668147A05",
+		.usage	= 10,
+		.mic	= "3FA0B42355E52B189187294AA252AB64",
+	},
 	{/* END */}
 };
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index 6921785688bf..b337494ccb31 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -35,6 +35,8 @@ struct scatterlist;
 #define KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192	0x0014
 #define KRB5_ENCTYPE_ARCFOUR_HMAC		0x0017
 #define KRB5_ENCTYPE_ARCFOUR_HMAC_EXP		0x0018
+#define KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC	0x0019
+#define KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC	0x001a
 #define KRB5_ENCTYPE_UNKNOWN			0x01ff
 
 #define KRB5_CKSUMTYPE_CRC32			0x0001
@@ -47,6 +49,8 @@ struct scatterlist;
 #define KRB5_CKSUMTYPE_HMAC_SHA1_DES3		0x000c
 #define KRB5_CKSUMTYPE_HMAC_SHA1_96_AES128	0x000f
 #define KRB5_CKSUMTYPE_HMAC_SHA1_96_AES256	0x0010
+#define KRB5_CKSUMTYPE_CMAC_CAMELLIA128		0x0011
+#define KRB5_CKSUMTYPE_CMAC_CAMELLIA256		0x0012
 #define KRB5_CKSUMTYPE_HMAC_SHA256_128_AES128	0x0013
 #define KRB5_CKSUMTYPE_HMAC_SHA384_192_AES256	0x0014
 #define KRB5_CKSUMTYPE_HMAC_MD5_ARCFOUR		-138 /* Microsoft md5 hmac cksumtype */


