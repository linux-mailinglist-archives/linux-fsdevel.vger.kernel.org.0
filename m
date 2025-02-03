Return-Path: <linux-fsdevel+bounces-40598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A40A25C5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A7C3A3A76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB020ADE0;
	Mon,  3 Feb 2025 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jt5BY6G4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8F20899C
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592676; cv=none; b=qHkxtJZ2cfpjgQUsjdYjHfUloJB4cWFu7jPmL8Dr1kzpjALMZyUIzZMv2ok9ODyEaV7i/AdVR8/JRxf5I+qAdG9YIUMFfGO2A7MHX3a7+szQi8BAtEj5UmCOEHRx9S2Mhv4AlDsevpP8h7wmTCaVjLU/aJ7oIMFmVgWm8EoBUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592676; c=relaxed/simple;
	bh=l03FQKS7BW+6wJDNhHUDJF4Y9judWuJ4jJFqjcRhdOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxDQGkqjLPfWqLPJExQJx9KieGaiWGCmt0Ik+45gB84kXlldpI2RGwC0AFVsPYiOs3KY7u5Cl1MP0d3up7UFGOgnxFHrlx5PVlYqvHqtfivCu9nr0OqNLqIqmL3unboZOB8p3USO/rAKgWXuAWR9xYWLHzVpLweZbOZr/9YKZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jt5BY6G4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KY3hopcJlHfpf9k7S0Jnk1mNxcS6D1gmgUv28Cxu/Aw=;
	b=Jt5BY6G4N9C8OhlRH/gCkzggm02U0AHhD9rEmzQ7byxT6uQSN4iPOBsPXHdZllfU5bs4Ov
	rjJxe9FiOhQ165AwfSiMJMFko0aauU+TUNP7wRpAj/8Cqn8vhmTdPY/d5LzSPrDkg9VXd3
	VxWnkywQg/6lV5ysBMZTJtKakiD1rYU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-GKpMCBqVMOOVmiFKywSZiQ-1; Mon,
 03 Feb 2025 09:24:28 -0500
X-MC-Unique: GKpMCBqVMOOVmiFKywSZiQ-1
X-Mimecast-MFC-AGG-ID: GKpMCBqVMOOVmiFKywSZiQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDC6F19560BA;
	Mon,  3 Feb 2025 14:24:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E65C1800365;
	Mon,  3 Feb 2025 14:24:18 +0000 (UTC)
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
Subject: [PATCH net 05/24] crypto/krb5: Implement Kerberos crypto core
Date: Mon,  3 Feb 2025 14:23:21 +0000
Message-ID: <20250203142343.248839-6-dhowells@redhat.com>
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

Provide core structures, an encoding-type registry and basic module and
config bits for a generic Kerberos crypto library.

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
 crypto/Kconfig         |   1 +
 crypto/Makefile        |   2 +
 crypto/krb5/Kconfig    |  14 ++++++
 crypto/krb5/Makefile   |   9 ++++
 crypto/krb5/internal.h | 112 +++++++++++++++++++++++++++++++++++++++++
 crypto/krb5/krb5_api.c |  42 ++++++++++++++++
 include/crypto/krb5.h  |  54 ++++++++++++++++++++
 7 files changed, 234 insertions(+)
 create mode 100644 crypto/krb5/Kconfig
 create mode 100644 crypto/krb5/Makefile
 create mode 100644 crypto/krb5/internal.h
 create mode 100644 crypto/krb5/krb5_api.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index cbf2dc7ce2a1..91eda4c993b8 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1472,5 +1472,6 @@ endif
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"
+source "crypto/krb5/Kconfig"
 
 endif	# if CRYPTO
diff --git a/crypto/Makefile b/crypto/Makefile
index 20c8e3ee9835..d1e422249af6 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -213,3 +213,5 @@ obj-$(CONFIG_CRYPTO_SIMD) += crypto_simd.o
 # Key derivation function
 #
 obj-$(CONFIG_CRYPTO_KDF800108_CTR) += kdf_sp800108.o
+
+obj-$(CONFIG_CRYPTO_KRB5) += krb5/
diff --git a/crypto/krb5/Kconfig b/crypto/krb5/Kconfig
new file mode 100644
index 000000000000..079873618abf
--- /dev/null
+++ b/crypto/krb5/Kconfig
@@ -0,0 +1,14 @@
+config CRYPTO_KRB5
+	tristate "Kerberos 5 crypto"
+	select CRYPTO_MANAGER
+	select CRYPTO_KRB5ENC
+	select CRYPTO_AUTHENC
+	select CRYPTO_SKCIPHER
+	select CRYPTO_HASH_INFO
+	select CRYPTO_SHA1
+	select CRYPTO_CBC
+	select CRYPTO_CTS
+	select CRYPTO_AES
+	help
+	  Provide a library for provision of Kerberos-5-based crypto.  This is
+	  intended for network filesystems to use.
diff --git a/crypto/krb5/Makefile b/crypto/krb5/Makefile
new file mode 100644
index 000000000000..c450d0754772
--- /dev/null
+++ b/crypto/krb5/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for asymmetric cryptographic keys
+#
+
+krb5-y += \
+	krb5_api.o
+
+obj-$(CONFIG_CRYPTO_KRB5) += krb5.o
diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
new file mode 100644
index 000000000000..3ede858be4f7
--- /dev/null
+++ b/crypto/krb5/internal.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Kerberos5 crypto internals
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <crypto/krb5.h>
+
+/*
+ * Profile used for key derivation and encryption.
+ */
+struct krb5_crypto_profile {
+	 /* Pseudo-random function */
+	int (*calc_PRF)(const struct krb5_enctype *krb5,
+			const struct krb5_buffer *protocol_key,
+			const struct krb5_buffer *octet_string,
+			struct krb5_buffer *result,
+			gfp_t gfp);
+
+	/* Checksum key derivation */
+	int (*calc_Kc)(const struct krb5_enctype *krb5,
+		       const struct krb5_buffer *TK,
+		       const struct krb5_buffer *usage_constant,
+		       struct krb5_buffer *Kc,
+		       gfp_t gfp);
+
+	/* Encryption key derivation */
+	int (*calc_Ke)(const struct krb5_enctype *krb5,
+		       const struct krb5_buffer *TK,
+		       const struct krb5_buffer *usage_constant,
+		       struct krb5_buffer *Ke,
+		       gfp_t gfp);
+
+	 /* Integrity key derivation */
+	int (*calc_Ki)(const struct krb5_enctype *krb5,
+		       const struct krb5_buffer *TK,
+		       const struct krb5_buffer *usage_constant,
+		       struct krb5_buffer *Ki,
+		       gfp_t gfp);
+
+	/* Derive the keys needed for an encryption AEAD object. */
+	int (*derive_encrypt_keys)(const struct krb5_enctype *krb5,
+				   const struct krb5_buffer *TK,
+				   unsigned int usage,
+				   struct krb5_buffer *setkey,
+				   gfp_t gfp);
+
+	/* Directly load the keys needed for an encryption AEAD object. */
+	int (*load_encrypt_keys)(const struct krb5_enctype *krb5,
+				 const struct krb5_buffer *Ke,
+				 const struct krb5_buffer *Ki,
+				 struct krb5_buffer *setkey,
+				 gfp_t gfp);
+
+	/* Derive the key needed for a checksum hash object. */
+	int (*derive_checksum_key)(const struct krb5_enctype *krb5,
+				   const struct krb5_buffer *TK,
+				   unsigned int usage,
+				   struct krb5_buffer *setkey,
+				   gfp_t gfp);
+
+	/* Directly load the keys needed for a checksum hash object. */
+	int (*load_checksum_key)(const struct krb5_enctype *krb5,
+				 const struct krb5_buffer *Kc,
+				 struct krb5_buffer *setkey,
+				 gfp_t gfp);
+
+	/* Encrypt data in-place, inserting confounder and checksum. */
+	ssize_t (*encrypt)(const struct krb5_enctype *krb5,
+			   struct crypto_aead *aead,
+			   struct scatterlist *sg, unsigned int nr_sg,
+			   size_t sg_len,
+			   size_t data_offset, size_t data_len,
+			   bool preconfounded);
+
+	/* Decrypt data in-place, removing confounder and checksum */
+	int (*decrypt)(const struct krb5_enctype *krb5,
+		       struct crypto_aead *aead,
+		       struct scatterlist *sg, unsigned int nr_sg,
+		       size_t *_offset, size_t *_len);
+
+	/* Generate a MIC on part of a packet, inserting the checksum */
+	ssize_t (*get_mic)(const struct krb5_enctype *krb5,
+			   struct crypto_shash *shash,
+			   const struct krb5_buffer *metadata,
+			   struct scatterlist *sg, unsigned int nr_sg,
+			   size_t sg_len,
+			   size_t data_offset, size_t data_len);
+
+	/* Verify the MIC on a piece of data, removing the checksum */
+	int (*verify_mic)(const struct krb5_enctype *krb5,
+			  struct crypto_shash *shash,
+			  const struct krb5_buffer *metadata,
+			  struct scatterlist *sg, unsigned int nr_sg,
+			  size_t *_offset, size_t *_len);
+};
+
+/*
+ * Crypto size/alignment rounding convenience macros.
+ */
+#define crypto_roundup(X) ((unsigned int)round_up((X), CRYPTO_MINALIGN))
+
+#define krb5_aead_size(TFM) \
+	crypto_roundup(sizeof(struct aead_request) + crypto_aead_reqsize(TFM))
+#define krb5_aead_ivsize(TFM) \
+	crypto_roundup(crypto_aead_ivsize(TFM))
+#define krb5_shash_size(TFM) \
+	crypto_roundup(sizeof(struct shash_desc) + crypto_shash_descsize(TFM))
+#define krb5_digest_size(TFM) \
+	crypto_roundup(crypto_shash_digestsize(TFM))
+#define round16(x) (((x) + 15) & ~15)
diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
new file mode 100644
index 000000000000..5c1cd5d07fc3
--- /dev/null
+++ b/crypto/krb5/krb5_api.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Kerberos 5 crypto library.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include "internal.h"
+
+MODULE_DESCRIPTION("Kerberos 5 crypto");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+static const struct krb5_enctype *const krb5_supported_enctypes[] = {
+};
+
+/**
+ * crypto_krb5_find_enctype - Find the handler for a Kerberos5 encryption type
+ * @enctype: The standard Kerberos encryption type number
+ *
+ * Look up a Kerberos encryption type by number.  If successful, returns a
+ * pointer to the type tables; returns NULL otherwise.
+ */
+const struct krb5_enctype *crypto_krb5_find_enctype(u32 enctype)
+{
+	const struct krb5_enctype *krb5;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(krb5_supported_enctypes); i++) {
+		krb5 = krb5_supported_enctypes[i];
+		if (krb5->etype == enctype)
+			return krb5;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(crypto_krb5_find_enctype);
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index 44a6342471d7..8fa6715ab35b 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -8,6 +8,12 @@
 #ifndef _CRYPTO_KRB5_H
 #define _CRYPTO_KRB5_H
 
+#include <linux/crypto.h>
+#include <crypto/aead.h>
+
+struct crypto_shash;
+struct scatterlist;
+
 /*
  * Per Kerberos v5 protocol spec crypto types from the wire.  These get mapped
  * to linux kernel crypto routines.
@@ -48,4 +54,52 @@
 #define KEY_USAGE_SEED_ENCRYPTION       (0xAA)
 #define KEY_USAGE_SEED_INTEGRITY        (0x55)
 
+/*
+ * Mode of operation.
+ */
+enum krb5_crypto_mode {
+	KRB5_CHECKSUM_MODE,	/* Checksum only */
+	KRB5_ENCRYPT_MODE,	/* Fully encrypted, possibly with integrity checksum */
+};
+
+struct krb5_buffer {
+	unsigned int	len;
+	void		*data;
+};
+
+/*
+ * Kerberos encoding type definition.
+ */
+struct krb5_enctype {
+	int		etype;		/* Encryption (key) type */
+	int		ctype;		/* Checksum type */
+	const char	*name;		/* "Friendly" name */
+	const char	*encrypt_name;	/* Crypto encrypt+checksum name */
+	const char	*cksum_name;	/* Crypto checksum name */
+	const char	*hash_name;	/* Crypto hash name */
+	const char	*derivation_enc; /* Cipher used in key derivation */
+	u16		block_len;	/* Length of encryption block */
+	u16		conf_len;	/* Length of confounder (normally == block_len) */
+	u16		cksum_len;	/* Length of checksum */
+	u16		key_bytes;	/* Length of raw key, in bytes */
+	u16		key_len;	/* Length of final key, in bytes */
+	u16		hash_len;	/* Length of hash in bytes */
+	u16		prf_len;	/* Length of PRF() result in bytes */
+	u16		Kc_len;		/* Length of Kc in bytes */
+	u16		Ke_len;		/* Length of Ke in bytes */
+	u16		Ki_len;		/* Length of Ki in bytes */
+	bool		keyed_cksum;	/* T if a keyed cksum */
+
+	const struct krb5_crypto_profile *profile;
+
+	int (*random_to_key)(const struct krb5_enctype *krb5,
+			     const struct krb5_buffer *in,
+			     struct krb5_buffer *out);	/* complete key generation */
+};
+
+/*
+ * krb5_api.c
+ */
+const struct krb5_enctype *crypto_krb5_find_enctype(u32 enctype);
+
 #endif /* _CRYPTO_KRB5_H */


