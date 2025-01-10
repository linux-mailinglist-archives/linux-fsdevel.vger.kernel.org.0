Return-Path: <linux-fsdevel+bounces-38767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE69A0844E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB648188C2A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 01:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF2A7DA82;
	Fri, 10 Jan 2025 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+R/GQUF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B708A3D0D5
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471029; cv=none; b=tXNdKGPlXfWKn3SRXOnsgpbAYh+NxCZGjQ3HkEKyTeMybpkHZkbcjbDnncQqCu53Yhi3tk4O4rhBxTeOCqCME2BDyJHVOkDA8IOA0FwnExDsMJu9xTcUrYadOU0zPjVhGrgHJzi0u9yrpE9RC5wKAVSmk+ovIfo3KgLtuXsioIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471029; c=relaxed/simple;
	bh=RPfM5LjZZOFsG8gjcXyCo990DO+P/1q0PB0O1n/leyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK2dsV2RIfgGAVlb6SNdmd2zyD0ygzlKGWovGfhpcpKy8hOw21j9EVGJRYLowvVGCRXcXTHBcQgDl/6QS9GXf8NVkwOnQ99pJQUbsDoZ0MqH2/F2h66so3cX9XTn9ZGXWq8SGfZ034WtRlKwb5WD/diV34/99hVxiDOHZRANt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+R/GQUF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736471022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hh0cMxiexoevL5t0JC/q8EfOKA+/qJFwx3hcexeI9o=;
	b=C+R/GQUFWua7ixdtAACmi/KuGVnqAi74M9lGVh4av/s1pOD1fytpBpg6saaJ6cPP8dmQoS
	yKAcOyzn9apZ4NXpVX3CPbvDi7p3iy/J9QY4h5O1jHm/ceKWkycrJYs4AFsqZ2hjSZxqkA
	CFE8LRqvBAH5GUf+w98sQFl3jXvo0Z8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-RvW84z04NkOqZBC__2EiBA-1; Thu,
 09 Jan 2025 20:03:37 -0500
X-MC-Unique: RvW84z04NkOqZBC__2EiBA-1
X-Mimecast-MFC-AGG-ID: RvW84z04NkOqZBC__2EiBA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 602C919560B4;
	Fri, 10 Jan 2025 01:03:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 599C630001BE;
	Fri, 10 Jan 2025 01:03:28 +0000 (UTC)
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
Subject: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through AEAD API
Date: Fri, 10 Jan 2025 01:03:04 +0000
Message-ID: <20250110010313.1471063-3-dhowells@redhat.com>
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

Use the AEAD crypto API to provide Kerberos 5 crypto, plus some
supplementary library functions that lie outside of the AEAD API.

The crypto algorithms only perform the actual crypto operations; they do
not do any laying out of the message and nor do they insert any metadata or
padding.  Everything is done by dead-reckoning as the AEAD API does not
provide a useful way to pass the extra parameters required.

When setting the key on a crypto algorithm, setkey takes a composite
structure consisting of an indication of the mode of transformation to be
applied to the message (checksum only or full encryption); the usage type
to be used in deriving the keys; an indicator indicating what key is being
presented (K0 or Kc/Ke+Ki); and the material for those key(s).  Based on
this, the setkey code allocates and keys the appropriate ciphers and
hashes.

When dispatching a request, both checksumming (MIC) and encryption use the
encrypt and decrypt methods.  A source message, prelaid out with
confounders or other metadata inserted is provided in the source buffer.
The cryptolen indicates the amount of source message data, not including
the trailer after the data (which includes the integrity checksum) and not
including any associated data.

Associated data is only used by checksumming encrypt/decrypt.  The
associated data is added to the checksum hash before the data in the
message, but does not occupy any part of the output message.

Authentication tags are not used at all and should cause EINVAL if used (a
later patch does that).

For the moment, the kerberos encryption algorithms use separate hash and
cipher algorithms internally, but should really use dual hash+cipher and
cipher+hash algorithms if possible to avoid doing these in series.  Offload
off this may be possible through something like the Intel QAT.

To help with managing the layout, a number of functions are also provided:

 (1) crypto_krb5_find_enctype() - Find the definition of an encoding type
     by protocol number.  This provides the name of the algorithm along
     with a host of parameter values, such as key sizes, block size, etc..

     Note that the enctype wraps the aead_alg struct so that the crypto
     routines can use container_of() to find it.

 (2) crypto_krb5_how_much_buffer() - Determine how much bufferage is needed
     for a certain amount of data.

 (3) crypto_krb5_how_much_data() - Determine how much data will fit into a
     certain amount of buffer.

 (4) crypto_krb5_where_is_the_data() - Determine where in a decrypted
     message the data is and how much data there is.  This may, in future,
     need to access the contents of the decrypted message to access
     metadata.

 (5) crypto_krb5_confound_buffer() - Insert the confounder in the buffer at
     the appropriate place - or generate one randomly.  This may, in
     future, be combined with something that inserts padding and metadata.

And to help with key derivation:

 (6) crypto_krb5_calc_PRFplus() - Calculate the PRF+ function.

This patch includes the following features:

 (1) The PRF+ function from RFC4402 used in deriving keys.

 (2) The RFC3961 simplified crypto profile for Kerberos 5 rfc3961 with the
     pseudo-random function, PRF(), from section 5.3 and the key derivation
     function, DK() from section 5.1.

 (3) Message encryption and decryption according to RFC3961 sec 5.3.

 (4) Message checksumming and verification according to RFC3961 sec 5.4.

 (5) The aes128-cts-hmac-sha1-96 and aes256-cts-hmac-sha1-96 enctypes from
     RFC3962, using the RFC3961 kerberos 5 simplified crypto scheme.

 (6) The aes128-cts-hmac-sha256-128 and aes256-cts-hmac-sha384-192 enctypes
     from RFC8009 (which override the rfc3961 kerberos 5 simplified crypto
     scheme).

 (7) The camellia128-cts-cmac and camellia256-cts-cmac enctypes from
     RFC6803.

     Note that the test vectors in rfc6803 for encryption are incomplete,
     lacking the key usage number needed to derive Ke and Ki, and there are
     errata for this:

	https://www.rfc-editor.org/errata_search.php?rfc=6803

 (8) Functions to find out about the layout of the crypto section.  One
     calculates, for a given size of data, how big a buffer will be
     required to hold it and where the data will be within it.  The other
     calculates, for an amount of buffer, what's the maximum size of data
     that will fit therein, and where it will start.

 (9) Self-testing infrastructure to test the pseudo-random function, key
     derivation, encryption and checksumming.

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
 crypto/Kconfig                   |   1 +
 crypto/Makefile                  |   2 +
 crypto/krb5/Kconfig              |  24 +
 crypto/krb5/Makefile             |  17 +
 crypto/krb5/internal.h           | 162 ++++++
 crypto/krb5/kdf.c                | 334 +++++++++++++
 crypto/krb5/krb5_aead.c          | 456 +++++++++++++++++
 crypto/krb5/rfc3961_simplified.c | 815 +++++++++++++++++++++++++++++++
 crypto/krb5/rfc6803_camellia.c   | 190 +++++++
 crypto/krb5/rfc8009_aes2.c       | 394 +++++++++++++++
 crypto/krb5/selftest.c           | 533 ++++++++++++++++++++
 crypto/krb5/selftest_data.c      | 370 ++++++++++++++
 include/crypto/krb5.h            | 101 +++-
 13 files changed, 3397 insertions(+), 2 deletions(-)
 create mode 100644 crypto/krb5/Kconfig
 create mode 100644 crypto/krb5/Makefile
 create mode 100644 crypto/krb5/internal.h
 create mode 100644 crypto/krb5/kdf.c
 create mode 100644 crypto/krb5/krb5_aead.c
 create mode 100644 crypto/krb5/rfc3961_simplified.c
 create mode 100644 crypto/krb5/rfc6803_camellia.c
 create mode 100644 crypto/krb5/rfc8009_aes2.c
 create mode 100644 crypto/krb5/selftest.c
 create mode 100644 crypto/krb5/selftest_data.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 6b0bfbccac08..7f1a60065dc1 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1477,5 +1477,6 @@ endif
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"
+source "crypto/krb5/Kconfig"
 
 endif	# if CRYPTO
diff --git a/crypto/Makefile b/crypto/Makefile
index 77abca715445..2d1463581d10 100644
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
index 000000000000..0f8df83ff4fd
--- /dev/null
+++ b/crypto/krb5/Kconfig
@@ -0,0 +1,24 @@
+config CRYPTO_KRB5
+	tristate "Kerberos 5 crypto"
+	select CRYPTO_MANAGER
+	select CRYPTO_SKCIPHER
+	select CRYPTO_HASH_INFO
+	select CRYPTO_HMAC
+	select CRYPTO_CMAC
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_CBC
+	select CRYPTO_CTS
+	select CRYPTO_AES
+	select CRYPTO_CAMELLIA
+	help
+	  Provide a library for provision of Kerberos-5-based crypto.  This is
+	  intended for network filesystems to use.
+
+config CRYPTO_KRB5_SELFTESTS
+	bool "Kerberos 5 crypto selftests"
+	depends on CRYPTO_KRB5
+	help
+	  Turn on some self-testing for the kerberos 5 crypto functions.  These
+	  will be performed on module load or boot, if compiled in.
diff --git a/crypto/krb5/Makefile b/crypto/krb5/Makefile
new file mode 100644
index 000000000000..65cb211aebeb
--- /dev/null
+++ b/crypto/krb5/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for asymmetric cryptographic keys
+#
+
+krb5-y += \
+	kdf.o \
+	krb5_aead.o \
+	rfc3961_simplified.o \
+	rfc6803_camellia.o \
+	rfc8009_aes2.o
+
+krb5-$(CONFIG_CRYPTO_KRB5_SELFTESTS) += \
+	selftest.o \
+	selftest_data.o
+
+obj-$(CONFIG_CRYPTO_KRB5) += krb5.o
diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
new file mode 100644
index 000000000000..6ae7ff7008a8
--- /dev/null
+++ b/crypto/krb5/internal.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Kerberos5 crypto internals
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/scatterlist.h>
+#include <crypto/krb5.h>
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+#include <crypto/internal/aead.h>
+
+/*
+ * Checksum, encryption and integrity keyed algorithms for Kerberos encryption
+ * or checksumming.
+ */
+struct krb5_ctx {
+	struct crypto_sync_skcipher	*Ke; /* Encryption key (fully encrypted) */
+	union {
+		struct crypto_shash	*Ki; /* Integrity key (fully encrypted) */
+		struct crypto_shash	*Kc; /* Checksum key (checksummed only) */
+	};
+};
+
+static inline struct krb5_ctx *crypto_krb5_ctx(struct crypto_aead *tfm)
+{
+	return crypto_aead_ctx(tfm);
+}
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
+};
+
+/*
+ * Crypto size/alignment rounding convenience macros.
+ */
+#define crypto_roundup(X) ((unsigned int)round_up((X), CRYPTO_MINALIGN))
+
+#define krb5_shash_size(TFM) \
+	crypto_roundup(sizeof(struct shash_desc) + crypto_shash_descsize(TFM))
+#define krb5_skcipher_size(TFM) \
+	crypto_roundup(sizeof(struct skcipher_request) + crypto_skcipher_reqsize(TFM))
+#define krb5_digest_size(TFM) \
+	crypto_roundup(crypto_shash_digestsize(TFM))
+#define krb5_sync_skcipher_size(TFM) \
+	krb5_skcipher_size(&(TFM)->base)
+#define krb5_sync_skcipher_ivsize(TFM) \
+	crypto_roundup(crypto_sync_skcipher_ivsize(TFM))
+#define round16(x) (((x) + 15) & ~15)
+
+/*
+ * Self-testing data.
+ */
+struct krb5_prf_test {
+	u32 etype;
+	const char *name, *key, *octet, *prf;
+};
+
+struct krb5_key_test_one {
+	u32 use;
+	const char *key;
+};
+
+struct krb5_key_test {
+	u32 etype;
+	const char *name, *key;
+	struct krb5_key_test_one Kc, Ke, Ki;
+};
+
+struct krb5_enc_test {
+	u32 etype;
+	const char *name, *plain, *conf, *key, *ct;
+};
+
+struct krb5_mic_test {
+	u32 etype;
+	const char *name, *plain, *key, *mic;
+};
+
+/*
+ * kdf.c
+ */
+int krb5_setkey(struct crypto_aead *aead, const u8 *key, unsigned int keylen);
+int krb5_derive_Kc(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp);
+int krb5_derive_Ke(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp);
+int krb5_derive_Ki(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp);
+
+/*
+ * rfc3961_simplified.c
+ */
+extern const struct krb5_crypto_profile rfc3961_simplified_profile;
+
+size_t sg_count(struct scatterlist *sg, int *_nents);
+int crypto_shash_update_sg(struct shash_desc *desc, struct scatterlist *sg,
+			   size_t offset, size_t len);
+int rfc3961_get_mic(struct aead_request *req);
+int rfc3961_verify_mic(struct aead_request *req);
+int rfc3961_aead_encrypt(struct aead_request *req);
+int rfc3961_aead_decrypt(struct aead_request *req);
+
+/*
+ * rfc6803_camellia.c
+ */
+extern const struct krb5_crypto_profile rfc6803_crypto_profile;
+
+/*
+ * rfc8009_aes2.c
+ */
+extern const struct krb5_crypto_profile rfc8009_crypto_profile;
+
+int rfc8009_aead_encrypt(struct aead_request *req);
+int rfc8009_aead_decrypt(struct aead_request *req);
+
+/*
+ * selftest.c
+ */
+#ifdef CONFIG_CRYPTO_KRB5_SELFTESTS
+int krb5_selftest(void);
+#else
+static inline int krb5_selftest(void) { return 0; }
+#endif
+
+/*
+ * selftest_data.c
+ */
+extern const struct krb5_prf_test krb5_prf_tests[];
+extern const struct krb5_key_test krb5_key_tests[];
+extern const struct krb5_enc_test krb5_enc_tests[];
+extern const struct krb5_mic_test krb5_mic_tests[];
diff --git a/crypto/krb5/kdf.c b/crypto/krb5/kdf.c
new file mode 100644
index 000000000000..b29e69f3d7f0
--- /dev/null
+++ b/crypto/krb5/kdf.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Kerberos key derivation.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <crypto/skcipher.h>
+#include <crypto/hash.h>
+#include "internal.h"
+
+/**
+ * crypto_krb5_calc_PRFplus - Calculate PRF+ [RFC4402]
+ * @krb5: The encryption type to use
+ * @K: The protocol key for the pseudo-random function
+ * @L: The length of the output
+ * @S: The input octet string
+ * @result: Result buffer, sized to krb5->prf_len
+ * @gfp: Allocation restrictions
+ *
+ * Calculate the kerberos pseudo-random function, PRF+() by the following
+ * method:
+ *
+ *      PRF+(K, L, S) = truncate(L, T1 || T2 || .. || Tn)
+ *      Tn = PRF(K, n || S)
+ *      [rfc4402 sec 2]
+ */
+int crypto_krb5_calc_PRFplus(const struct krb5_enctype *krb5,
+			     const struct krb5_buffer *K,
+			     unsigned int L,
+			     const struct krb5_buffer *S,
+			     struct krb5_buffer *result,
+			     gfp_t gfp)
+{
+	struct krb5_buffer T_series, Tn, n_S;
+	void *buffer;
+	int ret, n = 1;
+
+	Tn.len = krb5->prf_len;
+	T_series.len = 0;
+	n_S.len = 4 + S->len;
+
+	buffer = kzalloc(round16(L + Tn.len) + round16(n_S.len), gfp);
+	if (!buffer)
+		return -ENOMEM;
+
+	T_series.data = buffer;
+	n_S.data = buffer + round16(L + Tn.len);
+	memcpy(n_S.data + 4, S->data, S->len);
+
+	while (T_series.len < L) {
+		*(__be32 *)(n_S.data) = htonl(n);
+		Tn.data = T_series.data + Tn.len * (n - 1);
+		ret = krb5->profile->calc_PRF(krb5, K, &n_S, &Tn, gfp);
+		if (ret < 0)
+			goto err;
+		T_series.len += Tn.len;
+		n++;
+	}
+
+	/* Truncate to L */
+	memcpy(result->data, T_series.data, L);
+	ret = 0;
+
+err:
+	kfree_sensitive(buffer);
+	return ret;
+}
+EXPORT_SYMBOL(crypto_krb5_calc_PRFplus);
+
+/**
+ * krb5_derive_Kc - Derive key Kc and install into a hash
+ * @krb5: The encryption type to use
+ * @TK: The base key
+ * @usage: The key usage number
+ * @key: Prepped (temporary) buffer to store the key into
+ * @gfp: Allocation restrictions
+ *
+ * Derive the Kerberos Kc checksumming key.  The key is stored into the
+ * prepared buffer.
+ */
+int krb5_derive_Kc(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp)
+{
+	u8 buf[5] __aligned(CRYPTO_MINALIGN);
+	struct krb5_buffer usage_constant = { .len = 5, .data = buf };
+
+	*(__be32 *)buf = cpu_to_be32(usage);
+	buf[4] = KEY_USAGE_SEED_CHECKSUM;
+
+	key->len = krb5->Kc_len;
+	return krb5->profile->calc_Kc(krb5, TK, &usage_constant, key, gfp);
+}
+
+static int krb5_get_Kc(const struct krb5_enctype *krb5, const struct krb5_buffer *key,
+		       struct krb5_ctx *ctx, gfp_t gfp)
+{
+	struct crypto_shash *shash;
+
+	shash = crypto_alloc_shash(krb5->cksum_name, 0, 0);
+	if (IS_ERR(shash))
+		return (PTR_ERR(shash) == -ENOENT) ? -ENOPKG : PTR_ERR(shash);
+	ctx->Kc = shash;
+	return crypto_shash_setkey(shash, key->data, key->len);
+}
+
+/**
+ * krb5_derive_Ke - Derive key Ke and install into an skcipher
+ * @krb5: The encryption type to use
+ * @TK: The base key
+ * @usage: The key usage number
+ * @key: Prepped (temporary) buffer to store the key into
+ * @gfp: Allocation restrictions
+ *
+ * Derive the Kerberos Ke encryption key.  The key is stored into the prepared
+ * buffer.
+ */
+int krb5_derive_Ke(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp)
+{
+	u8 buf[5] __aligned(CRYPTO_MINALIGN);
+	struct krb5_buffer usage_constant = { .len = 5, .data = buf };
+
+	*(__be32 *)buf = cpu_to_be32(usage);
+	buf[4] = KEY_USAGE_SEED_ENCRYPTION;
+
+	key->len = krb5->Ke_len;
+	return krb5->profile->calc_Ke(krb5, TK, &usage_constant, key, gfp);
+}
+
+static int krb5_get_Ke(const struct krb5_enctype *krb5, const struct krb5_buffer *key,
+		       struct krb5_ctx *ctx, gfp_t gfp)
+{
+	struct crypto_sync_skcipher *ci;
+
+	ci = crypto_alloc_sync_skcipher(krb5->encrypt_name, 0, 0);
+	if (IS_ERR(ci))
+		return (PTR_ERR(ci) == -ENOENT) ? -ENOPKG : PTR_ERR(ci);
+	ctx->Ke = ci;
+	return crypto_sync_skcipher_setkey(ci, key->data, key->len);
+}
+
+/**
+ * krb5_derive_Ki - Derive key Ki and install into a hash
+ * @krb5: The encryption type to use
+ * @TK: The base key
+ * @usage: The key usage number
+ * @key: Prepped (temporary) buffer to store the key into
+ * @gfp: Allocation restrictions
+ *
+ * Derive the Kerberos Ki integrity checksum key.  The key is stored into the
+ * prepared buffer.
+ */
+int krb5_derive_Ki(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp)
+{
+	u8 buf[5] __aligned(CRYPTO_MINALIGN);
+	struct krb5_buffer usage_constant = { .len = 5, .data = buf };
+
+	*(__be32 *)buf = cpu_to_be32(usage);
+	buf[4] = KEY_USAGE_SEED_INTEGRITY;
+
+	key->len = krb5->Ki_len;
+	return krb5->profile->calc_Ki(krb5, TK, &usage_constant, key, gfp);
+}
+
+static int krb5_get_Ki(const struct krb5_enctype *krb5, const struct krb5_buffer *key,
+		       struct krb5_ctx *ctx, gfp_t gfp)
+{
+	struct crypto_shash *shash;
+
+	shash = crypto_alloc_shash(krb5->cksum_name, 0, 0);
+	if (IS_ERR(shash))
+		return (PTR_ERR(shash) == -ENOENT) ? -ENOPKG : PTR_ERR(shash);
+	ctx->Ki = shash;
+	return crypto_shash_setkey(shash, key->data, key->len);
+}
+
+/**
+ * krb5_setkey - Use the key material to derive keys
+ * @aead: The crypto algorithm context to configure
+ * @key: Compound of the key material and config parameters
+ * @keylen: Length of @key buffer
+ *
+ * Use the key material and configuration parameters to derive the appropriate
+ * keys for encrypting and/or checksumming.  The key material must be in one of
+ * the following formats:
+ *
+ * Checksummed mode:
+ *
+ *	KRB5_CHECKSUM_MODE (__be32) || usage (__be32) || transport key data (TK)
+ *	KRB5_CHECKSUM_MODE_KC (__be32) || usage (__be32) || Kc
+ *
+ * Full encryption mode:
+ *
+ *	KRB5_ENCRYPT_MODE (__be32) || usage (__be32) || transport key data (TK)
+ *	KRB5_ENCRYPT_MODE_KEKI (__be32) || usage (__be32) || Ke || Ki
+ */
+int krb5_setkey(struct crypto_aead *aead, const u8 *key, unsigned int keylen)
+{
+	const struct krb5_enctype *krb5 = crypto_krb5_enctype(aead);
+	struct krb5_buffer TK, keybuf = {}, Kn;
+	struct krb5_ctx *ctx = crypto_krb5_ctx(aead);
+	enum krb5_crypto_mode mode;
+	gfp_t gfp = GFP_NOFS; // TODO: The crypto API should provide this.
+	u32 usage;
+	int ret;
+
+	pr_debug("setkey %x %*phN\n", keylen, keylen, key);
+
+	if (keylen < 12)
+		return -EINVAL;
+
+	switch (mode) {
+	case KRB5_CHECKSUM_MODE:
+	case KRB5_ENCRYPT_MODE:
+		keybuf.data = kzalloc(krb5->key_bytes, gfp);
+		if (!keybuf.data)
+			return -ENOMEM;
+		break;
+	default:
+		break;
+	}
+
+	mode = get_unaligned_be32((__be32 *)key);
+	key += 4;
+	usage = get_unaligned_be32((__be32 *)key);
+	key += 4;
+	keylen -= 8;
+
+	switch (mode) {
+	case KRB5_CHECKSUM_MODE:
+		if (keylen != krb5->key_len)
+			return -EINVAL;
+		TK.data = (u8 *)key;
+		TK.len = keylen;
+		ret = krb5_derive_Kc(krb5, &TK, usage, &keybuf, gfp);
+		if (ret < 0)
+			goto err;
+		ret = krb5_get_Kc(krb5, &keybuf, ctx, gfp);
+		if (ret < 0)
+			goto err;
+		break;
+
+	case KRB5_CHECKSUM_MODE_KC:
+		if (keylen != krb5->Kc_len)
+			return -EINVAL;
+		Kn.data = (u8 *)key;
+		Kn.len = keylen;
+		ret = krb5_get_Kc(krb5, &Kn, ctx, gfp);
+		if (ret < 0)
+			goto err;
+		break;
+
+	case KRB5_ENCRYPT_MODE:
+		if (keylen != krb5->key_len)
+			return -EINVAL;
+		TK.data = (u8 *)key;
+		TK.len = keylen;
+		ret = krb5_derive_Ke(krb5, &TK, usage, &keybuf, gfp);
+		if (ret < 0) {
+			pr_err("get_Ke failed %d\n", ret);
+			goto err;
+		}
+		ret = krb5_get_Ke(krb5, &keybuf, ctx, gfp);
+		if (ret < 0) {
+			pr_err("get_Ke failed %d\n", ret);
+			goto err;
+		}
+		ret = krb5_derive_Ki(krb5, &TK, usage, &keybuf, gfp);
+		if (ret < 0) {
+			pr_err("get_Ki failed %d\n", ret);
+			goto err;
+		}
+		ret = krb5_get_Ki(krb5, &keybuf, ctx, gfp);
+		if (ret < 0) {
+			pr_err("get_Ki failed %d\n", ret);
+			goto err;
+		}
+		break;
+
+	case KRB5_ENCRYPT_MODE_KEKI:
+		if (keylen != krb5->Ke_len + krb5->Ki_len)
+			return -EINVAL;
+		Kn.data = (u8 *)key;
+		Kn.len = krb5->Ke_len;
+		ret = krb5_get_Ke(krb5, &Kn, ctx, gfp);
+		if (ret < 0) {
+			pr_err("get_Ke failed %d\n", ret);
+			goto err;
+		}
+		Kn.data = (u8 *)key + krb5->Ke_len;
+		Kn.len = krb5->Ki_len;
+		ret = krb5_get_Ki(krb5, &Kn, ctx, gfp);
+		if (ret < 0) {
+			pr_err("get_Ki failed %d\n", ret);
+			goto err;
+		}
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ctx->Ke && crypto_sync_skcipher_blocksize(ctx->Ke) != krb5->block_len) {
+		pr_notice("skcipher inconsistent with krb5 table %u!=%u\n",
+			  crypto_sync_skcipher_blocksize(ctx->Ke), krb5->block_len);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (ctx->Ki && crypto_shash_digestsize(ctx->Ki) < krb5->cksum_len) {
+		pr_notice("hash inconsistent with krb5 table %u!=%u\n",
+			  crypto_shash_digestsize(ctx->Ki), krb5->cksum_len);
+		ret = -EINVAL;
+		goto err;
+	}
+
+out:
+	kfree(keybuf.data);
+	return ret;
+
+err:
+	if (ctx->Ke)
+		crypto_free_sync_skcipher(ctx->Ke);
+	if (ctx->Ki)
+		crypto_free_shash(ctx->Ki);
+	goto out;
+}
diff --git a/crypto/krb5/krb5_aead.c b/crypto/krb5/krb5_aead.c
new file mode 100644
index 000000000000..2c8b3921e976
--- /dev/null
+++ b/crypto/krb5/krb5_aead.c
@@ -0,0 +1,456 @@
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
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/scatterlist.h>
+#include "internal.h"
+
+#include <crypto/algapi.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
+
+/**
+ * crypto_krb5_how_much_buffer - Work out how much buffer is required for an amount of data
+ * @krb5: The encoding to use.
+ * @mode: The mode in which to operated (checksum/encrypt)
+ * @data_size: How much data we want to allow for
+ * @_offset: Where to place the offset into the buffer
+ *
+ * Calculate how much buffer space is required to wrap a given amount of data.
+ * This allows for a confounder, padding and checksum as appropriate.  The
+ * amount of buffer required is returned and the offset into the buffer at
+ * which the data will start is placed in *_offset.
+ */
+size_t crypto_krb5_how_much_buffer(const struct krb5_enctype *krb5,
+				   enum krb5_crypto_mode mode,
+				   size_t data_size, size_t *_offset)
+{
+	switch (mode) {
+	case KRB5_CHECKSUM_MODE:
+	case KRB5_CHECKSUM_MODE_KC:
+		*_offset = krb5->cksum_len;
+		return krb5->cksum_len + data_size;
+
+	case KRB5_ENCRYPT_MODE:
+	case KRB5_ENCRYPT_MODE_KEKI:
+		*_offset = krb5->conf_len;
+		return krb5->conf_len + data_size + krb5->cksum_len;
+
+	default:
+		WARN_ON(1);
+		*_offset = 0;
+		return 0;
+	}
+}
+EXPORT_SYMBOL(crypto_krb5_how_much_buffer);
+
+/**
+ * crypto_krb5_how_much_data - Work out how much data can fit in an amount of buffer
+ * @krb5: The encoding to use.
+ * @mode: The mode in which to operated (checksum/encrypt)
+ * @_buffer_size: How much buffer we want to allow for (may be reduced)
+ * @_offset: Where to place the offset into the buffer
+ *
+ * Calculate how much data can be fitted into given amount of buffer.  This
+ * allows for a confounder, padding and checksum as appropriate.  The amount of
+ * data that will fit is returned, the amount of buffer required is shrunk to
+ * allow for alignment and the offset into the buffer at which the data will
+ * start is placed in *_offset.
+ */
+size_t crypto_krb5_how_much_data(const struct krb5_enctype *krb5,
+				 enum krb5_crypto_mode mode,
+				 size_t *_buffer_size, size_t *_offset)
+{
+	size_t buffer_size = *_buffer_size, data_size;
+
+	switch (mode) {
+	case KRB5_CHECKSUM_MODE:
+		if (WARN_ON(buffer_size < krb5->cksum_len + 1))
+			goto bad;
+		*_offset = krb5->cksum_len;
+		return buffer_size - krb5->cksum_len;
+
+	case KRB5_ENCRYPT_MODE:
+		if (WARN_ON(buffer_size < krb5->conf_len + 1 + krb5->cksum_len))
+			goto bad;
+		data_size = buffer_size - krb5->cksum_len;
+		*_offset = krb5->conf_len;
+		return data_size - krb5->conf_len;
+
+	default:
+		WARN_ON(1);
+		goto bad;
+	}
+
+bad:
+	*_offset = 0;
+	return 0;
+}
+EXPORT_SYMBOL(crypto_krb5_how_much_data);
+
+/**
+ * crypto_krb5_where_is_the_data - Find the data in a decrypted message
+ * @krb5: The encoding to use.
+ * @mode: Mode of operation
+ * @_offset: Offset of the secure blob in the buffer; updated to data offset.
+ * @_len: The length of the secure blob; updated to data length.
+ *
+ * Find the offset and size of the data in a secure message so that this
+ * information can be used in the metadata buffer which will get added to the
+ * digest by crypto_krb5_verify_mic().
+ */
+void crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
+				   enum krb5_crypto_mode mode,
+				   size_t *_offset, size_t *_len)
+{
+	switch (mode) {
+	case KRB5_CHECKSUM_MODE:
+	case KRB5_CHECKSUM_MODE_KC:
+		*_offset += krb5->cksum_len;
+		*_len -= krb5->cksum_len;
+		return;
+	case KRB5_ENCRYPT_MODE:
+	case KRB5_ENCRYPT_MODE_KEKI:
+		*_offset += krb5->conf_len;
+		*_len -= krb5->conf_len + krb5->cksum_len;
+		return;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+}
+EXPORT_SYMBOL(crypto_krb5_where_is_the_data);
+
+/*
+ * crypto_krb5_confound_buffer - Insert confounder
+ * @krb5: The encoding type
+ * @sg: The buffer holding the message
+ * @nr_sg: Number of segments in @sg
+ * @confounder: The confounder to insert (or NULL for random confounder)
+ * @conf_len: Length of @confounder content (if not NULL)
+ * @msg_offset: Offset in buffer of start of message
+ *
+ * Insert an appropriately-sized confounder into a buffer at the correct place
+ * with respect to the start of the message.
+ */
+int crypto_krb5_confound_buffer(const struct krb5_enctype *krb5,
+				struct scatterlist *sg, unsigned int nr_sg,
+				const u8 *confounder, size_t conf_len,
+				size_t msg_offset)
+{
+	size_t done;
+	void *buffer = NULL;
+
+	if (!confounder) {
+		buffer = kmalloc(krb5->conf_len, GFP_NOFS);
+		if (!buffer)
+			return -ENOMEM;
+		get_random_bytes(buffer, krb5->conf_len);
+		confounder = buffer;
+	} else {
+		if (WARN_ON(conf_len != krb5->conf_len))
+			return -EFAULT;
+	}
+
+	done = sg_pcopy_from_buffer(sg, nr_sg, confounder, krb5->conf_len,
+				    msg_offset);
+	kfree(buffer);
+	return (done == krb5->conf_len) ? 0 : -EFAULT;
+}
+EXPORT_SYMBOL(crypto_krb5_confound_buffer);
+
+/*
+ * Table of supported Kerberos-V encryption types and their parameters.
+ */
+static struct krb5_enctype krb5_enctypes[] = {
+	{
+		.etype			= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+		.ctype			= KRB5_CKSUMTYPE_HMAC_SHA1_96_AES128,
+		.name			= "aes128-cts-hmac-sha1-96",
+		.encrypt_name		= "cts(cbc(aes))",
+		.cksum_name		= "hmac(sha1)",
+		.hash_name		= "sha1",
+		.key_bytes		= 16,
+		.key_len		= 16,
+		.Kc_len			= 16,
+		.Ke_len			= 16,
+		.Ki_len			= 16,
+		.block_len		= 16,
+		.conf_len		= 16,
+		.cksum_len		= 12,
+		.hash_len		= 20,
+		.prf_len		= 16,
+		.keyed_cksum		= true,
+		.random_to_key		= NULL, /* Identity */
+		.profile		= &rfc3961_simplified_profile,
+
+		.aead.setkey		= krb5_setkey,
+		.aead.setauthsize	= NULL,
+		.aead.encrypt		= rfc3961_aead_encrypt,
+		.aead.decrypt		= rfc3961_aead_decrypt,
+		.aead.ivsize		= 0,
+		.aead.maxauthsize	= 0,
+		.aead.chunksize		= 16,
+
+		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
+		.aead.base.cra_blocksize	= 1,
+		.aead.base.cra_ctxsize		= sizeof(struct krb5_ctx),
+		.aead.base.cra_alignmask	= 0,
+		.aead.base.cra_priority		= 100,
+		.aead.base.cra_name		= "krb5-aes128-cts-hmac-sha1-96",
+		.aead.base.cra_driver_name	= "krb5-aes128-cts-hmac-sha1-96-generic",
+		.aead.base.cra_module		= THIS_MODULE,
+	}, {
+		.etype			= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA1_96,
+		.ctype			= KRB5_CKSUMTYPE_HMAC_SHA1_96_AES256,
+		.name			= "aes256-cts-hmac-sha1-96",
+		.encrypt_name		= "cts(cbc(aes))",
+		.cksum_name		= "hmac(sha1)",
+		.hash_name		= "sha1",
+		.key_bytes		= 32,
+		.key_len		= 32,
+		.Kc_len			= 32,
+		.Ke_len			= 32,
+		.Ki_len			= 32,
+		.block_len		= 16,
+		.conf_len		= 16,
+		.cksum_len		= 12,
+		.hash_len		= 20,
+		.prf_len		= 16,
+		.keyed_cksum		= true,
+		.random_to_key		= NULL, /* Identity */
+		.profile		= &rfc3961_simplified_profile,
+
+		.aead.setkey		= krb5_setkey,
+		.aead.setauthsize	= NULL,
+		.aead.encrypt		= rfc3961_aead_encrypt,
+		.aead.decrypt		= rfc3961_aead_decrypt,
+		.aead.ivsize		= 0,
+		.aead.maxauthsize	= 0,
+		.aead.chunksize		= 16,
+
+		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
+		.aead.base.cra_blocksize	= 1,
+		.aead.base.cra_ctxsize		= sizeof(struct krb5_ctx),
+		.aead.base.cra_alignmask	= 0,
+		.aead.base.cra_priority		= 100,
+		.aead.base.cra_name		= "krb5-aes256-cts-hmac-sha1-96",
+		.aead.base.cra_driver_name	= "krb5-aes256-cts-hmac-sha1-96-generic",
+		.aead.base.cra_module		= THIS_MODULE,
+	}, {
+		.etype			= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.ctype			= KRB5_CKSUMTYPE_CMAC_CAMELLIA128,
+		.name			= "camellia128-cts-cmac",
+		.encrypt_name		= "cts(cbc(camellia))",
+		.cksum_name		= "cmac(camellia)",
+		.hash_name		= NULL,
+		.key_bytes		= 16,
+		.key_len		= 16,
+		.Kc_len			= 16,
+		.Ke_len			= 16,
+		.Ki_len			= 16,
+		.block_len		= 16,
+		.conf_len		= 16,
+		.cksum_len		= 16,
+		.hash_len		= 16,
+		.prf_len		= 16,
+		.keyed_cksum		= true,
+		.random_to_key		= NULL, /* Identity */
+		.profile		= &rfc6803_crypto_profile,
+
+		.aead.setkey		= krb5_setkey,
+		.aead.setauthsize	= NULL,
+		.aead.encrypt		= rfc3961_aead_encrypt,
+		.aead.decrypt		= rfc3961_aead_decrypt,
+		.aead.ivsize		= 0,
+		.aead.maxauthsize	= 0,
+		.aead.chunksize		= 16,
+
+		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
+		.aead.base.cra_blocksize	= 1,
+		.aead.base.cra_ctxsize		= sizeof(struct krb5_ctx),
+		.aead.base.cra_alignmask	= 0,
+		.aead.base.cra_priority		= 100,
+		.aead.base.cra_name		= "krb5-camellia128-cts-cmac",
+		.aead.base.cra_driver_name	= "krb5-camellia128-cts-cmac-generic",
+		.aead.base.cra_module		= THIS_MODULE,
+	}, {
+		.etype			= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.ctype			= KRB5_CKSUMTYPE_CMAC_CAMELLIA256,
+		.name			= "camellia256-cts-cmac",
+		.encrypt_name		= "cts(cbc(camellia))",
+		.cksum_name		= "cmac(camellia)",
+		.hash_name		= NULL,
+		.key_bytes		= 32,
+		.key_len		= 32,
+		.Kc_len			= 32,
+		.Ke_len			= 32,
+		.Ki_len			= 32,
+		.block_len		= 16,
+		.conf_len		= 16,
+		.cksum_len		= 16,
+		.hash_len		= 16,
+		.prf_len		= 16,
+		.keyed_cksum		= true,
+		.random_to_key		= NULL, /* Identity */
+		.profile		= &rfc6803_crypto_profile,
+
+		.aead.setkey		= krb5_setkey,
+		.aead.setauthsize	= NULL,
+		.aead.encrypt		= rfc3961_aead_encrypt,
+		.aead.decrypt		= rfc3961_aead_decrypt,
+		.aead.ivsize		= 0,
+		.aead.maxauthsize	= 0,
+		.aead.chunksize		= 16,
+
+		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
+		.aead.base.cra_blocksize	= 1,
+		.aead.base.cra_ctxsize		= sizeof(struct krb5_ctx),
+		.aead.base.cra_alignmask	= 0,
+		.aead.base.cra_priority		= 100,
+		.aead.base.cra_name		= "krb5-camellia256-cts-cmac",
+		.aead.base.cra_driver_name	= "krb5-camellia256-cts-cmac-generic",
+		.aead.base.cra_module		= THIS_MODULE,
+	}, {
+		.etype			= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.ctype			= KRB5_CKSUMTYPE_HMAC_SHA256_128_AES128,
+		.name			= "aes128-cts-hmac-sha256-128",
+		.encrypt_name		= "cts(cbc(aes))",
+		.cksum_name		= "hmac(sha256)",
+		.hash_name		= "sha256",
+		.key_bytes		= 16,
+		.key_len		= 16,
+		.Kc_len			= 16,
+		.Ke_len			= 16,
+		.Ki_len			= 16,
+		.block_len		= 16,
+		.conf_len		= 16,
+		.cksum_len		= 16,
+		.hash_len		= 20,
+		.prf_len		= 32,
+		.keyed_cksum		= true,
+		.random_to_key		= NULL, /* Identity */
+		.profile		= &rfc8009_crypto_profile,
+
+		.aead.setkey		= krb5_setkey,
+		.aead.setauthsize	= NULL,
+		.aead.encrypt		= rfc8009_aead_encrypt,
+		.aead.decrypt		= rfc8009_aead_decrypt,
+		.aead.ivsize		= 0,
+		.aead.maxauthsize	= 0,
+		.aead.chunksize		= 16,
+
+		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
+		.aead.base.cra_blocksize	= 1,
+		.aead.base.cra_ctxsize		= sizeof(struct krb5_ctx),
+		.aead.base.cra_alignmask	= 0,
+		.aead.base.cra_priority		= 100,
+		.aead.base.cra_name		= "krb5-aes128-cts-hmac-sha256-128",
+		.aead.base.cra_driver_name	= "krb5-aes128-cts-hmac-sha256-128generic",
+		.aead.base.cra_module		= THIS_MODULE,
+	}, {
+		.etype			= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.ctype			= KRB5_CKSUMTYPE_HMAC_SHA384_192_AES256,
+		.name			= "aes256-cts-hmac-sha384-192",
+		.encrypt_name		= "cts(cbc(aes))",
+		.cksum_name		= "hmac(sha384)",
+		.hash_name		= "sha384",
+		.key_bytes		= 32,
+		.key_len		= 32,
+		.Kc_len			= 24,
+		.Ke_len			= 32,
+		.Ki_len			= 24,
+		.block_len		= 16,
+		.conf_len		= 16,
+		.cksum_len		= 24,
+		.hash_len		= 20,
+		.prf_len		= 48,
+		.keyed_cksum		= true,
+		.random_to_key		= NULL, /* Identity */
+		.profile		= &rfc8009_crypto_profile,
+
+		.aead.setkey		= krb5_setkey,
+		.aead.setauthsize	= NULL,
+		.aead.encrypt		= rfc8009_aead_encrypt,
+		.aead.decrypt		= rfc8009_aead_decrypt,
+		.aead.ivsize		= 0,
+		.aead.maxauthsize	= 0,
+		.aead.chunksize		= 16,
+
+		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
+		.aead.base.cra_blocksize	= 1,
+		.aead.base.cra_ctxsize		= sizeof(struct krb5_ctx),
+		.aead.base.cra_alignmask	= 0,
+		.aead.base.cra_priority		= 100,
+		.aead.base.cra_name		= "krb5-aes256-cts-hmac-sha384-192",
+		.aead.base.cra_driver_name	= "krb5-aes256-cts-hmac-sha384-192-generic",
+		.aead.base.cra_module		= THIS_MODULE,
+	},
+};
+
+/**
+ * crypto_krb5_find_enctype - Find the handler for a Kerberos5 encryption type
+ * @enctype: The standard Kerberos encryption type number
+ *
+ * Look up a Kerberos encryption type by number.  If successful, returns a
+ * pointer to the type description; returns NULL otherwise.
+ */
+const struct krb5_enctype *crypto_krb5_find_enctype(u32 enctype)
+{
+	const struct krb5_enctype *krb5;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(krb5_enctypes); i++) {
+		krb5 = &krb5_enctypes[i];
+		if (krb5->etype == enctype)
+			return krb5;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(crypto_krb5_find_enctype);
+
+static int __init krb5_module_init(void)
+{
+	int i, ret, count = ARRAY_SIZE(krb5_enctypes);
+
+	for (i = 0; i < count; i++) {
+		ret = crypto_register_aead(&krb5_enctypes[i].aead);
+		if (ret)
+			goto err;
+	}
+
+	ret = krb5_selftest();
+	if (ret < 0)
+		goto err;
+	return 0;
+
+err:
+	for (--i; i >= 0; --i)
+		crypto_unregister_aead(&krb5_enctypes[i].aead);
+	return ret;
+}
+
+static void __exit krb5_module_exit(void)
+{
+	for (int i = 0; i < ARRAY_SIZE(krb5_enctypes); i++)
+		crypto_unregister_aead(&krb5_enctypes[i].aead);
+}
+
+subsys_initcall(krb5_module_init);
+module_exit(krb5_module_exit);
+
+MODULE_DESCRIPTION("Kerberos 5 crypto");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("krb5");
diff --git a/crypto/krb5/rfc3961_simplified.c b/crypto/krb5/rfc3961_simplified.c
new file mode 100644
index 000000000000..d5f0837bd424
--- /dev/null
+++ b/crypto/krb5/rfc3961_simplified.c
@@ -0,0 +1,815 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* rfc3961 Kerberos 5 simplified crypto profile.
+ *
+ * Parts borrowed from net/sunrpc/auth_gss/.
+ */
+/*
+ * COPYRIGHT (c) 2008
+ * The Regents of the University of Michigan
+ * ALL RIGHTS RESERVED
+ *
+ * Permission is granted to use, copy, create derivative works
+ * and redistribute this software and such derivative works
+ * for any purpose, so long as the name of The University of
+ * Michigan is not used in any advertising or publicity
+ * pertaining to the use of distribution of this software
+ * without specific, written prior authorization.  If the
+ * above copyright notice or any other identification of the
+ * University of Michigan is included in any copy of any
+ * portion of this software, then the disclaimer below must
+ * also be included.
+ *
+ * THIS SOFTWARE IS PROVIDED AS IS, WITHOUT REPRESENTATION
+ * FROM THE UNIVERSITY OF MICHIGAN AS TO ITS FITNESS FOR ANY
+ * PURPOSE, AND WITHOUT WARRANTY BY THE UNIVERSITY OF
+ * MICHIGAN OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING
+ * WITHOUT LIMITATION THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
+ * REGENTS OF THE UNIVERSITY OF MICHIGAN SHALL NOT BE LIABLE
+ * FOR ANY DAMAGES, INCLUDING SPECIAL, INDIRECT, INCIDENTAL, OR
+ * CONSEQUENTIAL DAMAGES, WITH RESPECT TO ANY CLAIM ARISING
+ * OUT OF OR IN CONNECTION WITH THE USE OF THE SOFTWARE, EVEN
+ * IF IT HAS BEEN OR IS HEREAFTER ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGES.
+ */
+
+/*
+ * Copyright (C) 1998 by the FundsXpress, INC.
+ *
+ * All rights reserved.
+ *
+ * Export of this software from the United States of America may require
+ * a specific license from the United States Government.  It is the
+ * responsibility of any person or organization contemplating export to
+ * obtain such a license before exporting.
+ *
+ * WITHIN THAT CONSTRAINT, permission to use, copy, modify, and
+ * distribute this software and its documentation for any purpose and
+ * without fee is hereby granted, provided that the above copyright
+ * notice appear in all copies and that both that copyright notice and
+ * this permission notice appear in supporting documentation, and that
+ * the name of FundsXpress. not be used in advertising or publicity pertaining
+ * to distribution of the software without specific, written prior
+ * permission.  FundsXpress makes no representations about the suitability of
+ * this software for any purpose.  It is provided "as is" without express
+ * or implied warranty.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+/*
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/random.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/lcm.h>
+#include <crypto/skcipher.h>
+#include <crypto/hash.h>
+#include "internal.h"
+
+size_t sg_count(struct scatterlist *sg, int *_nents)
+{
+	size_t total = 0;
+	int nents = 0;
+
+	for (; sg; sg = sg_next(sg)) {
+		nents++;
+		total += sg->length;
+	}
+
+	*_nents = nents;
+	return total;
+}
+
+int crypto_shash_update_sg(struct shash_desc *desc, struct scatterlist *sg,
+			   size_t offset, size_t len)
+{
+	do {
+		int ret;
+
+		if (offset < sg->length) {
+			struct page *page = sg_page(sg);
+			void *p = kmap_local_page(page);
+			void *q = p + sg->offset + offset;
+			size_t seg = min_t(size_t, len, sg->length - offset);
+
+			ret = crypto_shash_update(desc, q, seg);
+			kunmap_local(p);
+			if (ret < 0)
+				return ret;
+			len -= seg;
+			offset = 0;
+		} else {
+			offset -= sg->length;
+		}
+	} while (len > 0 && (sg = sg_next(sg)));
+	return 0;
+}
+
+/* Maximum blocksize for the supported crypto algorithms */
+#define KRB5_MAX_BLOCKSIZE  (16)
+
+static int rfc3961_do_encrypt(struct crypto_sync_skcipher *tfm, void *iv,
+			      const struct krb5_buffer *in, struct krb5_buffer *out)
+{
+	struct scatterlist sg[1];
+	u8 local_iv[KRB5_MAX_BLOCKSIZE] __aligned(KRB5_MAX_BLOCKSIZE) = {0};
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	int ret;
+
+	if (WARN_ON(in->len != out->len))
+		return -EINVAL;
+	if (out->len % crypto_sync_skcipher_blocksize(tfm) != 0)
+		return -EINVAL;
+
+	if (crypto_sync_skcipher_ivsize(tfm) > KRB5_MAX_BLOCKSIZE)
+		return -EINVAL;
+
+	if (iv)
+		memcpy(local_iv, iv, crypto_sync_skcipher_ivsize(tfm));
+
+	memcpy(out->data, in->data, out->len);
+	sg_init_one(sg, out->data, out->len);
+
+	skcipher_request_set_sync_tfm(req, tfm);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
+	skcipher_request_set_crypt(req, sg, sg, out->len, local_iv);
+
+	ret = crypto_skcipher_encrypt(req);
+	skcipher_request_zero(req);
+	return ret;
+}
+
+/*
+ * Calculate an unkeyed basic hash.
+ */
+static int rfc3961_calc_H(const struct krb5_enctype *krb5,
+			  const struct krb5_buffer *data,
+			  struct krb5_buffer *digest,
+			  gfp_t gfp)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	size_t desc_size;
+	int ret = -ENOMEM;
+
+	tfm = crypto_alloc_shash(krb5->hash_name, 0, 0);
+	if (IS_ERR(tfm))
+		return (PTR_ERR(tfm) == -ENOENT) ? -ENOPKG : PTR_ERR(tfm);
+
+	desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
+
+	desc = kzalloc(desc_size, gfp);
+	if (!desc)
+		goto error_tfm;
+
+	digest->len = crypto_shash_digestsize(tfm);
+	digest->data = kzalloc(digest->len, gfp);
+	if (!digest->data)
+		goto error_desc;
+
+	desc->tfm = tfm;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error_digest;
+
+	ret = crypto_shash_finup(desc, data->data, data->len, digest->data);
+	if (ret < 0)
+		goto error_digest;
+
+	goto error_desc;
+
+error_digest:
+	kfree_sensitive(digest->data);
+error_desc:
+	kfree_sensitive(desc);
+error_tfm:
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+/*
+ * This is the n-fold function as described in rfc3961, sec 5.1
+ * Taken from MIT Kerberos and modified.
+ */
+static void rfc3961_nfold(const struct krb5_buffer *source, struct krb5_buffer *result)
+{
+	const u8 *in = source->data;
+	u8 *out = result->data;
+	unsigned long ulcm;
+	unsigned int inbits, outbits;
+	int byte, i, msbit;
+
+	/* the code below is more readable if I make these bytes instead of bits */
+	inbits = source->len;
+	outbits = result->len;
+
+	/* first compute lcm(n,k) */
+	ulcm = lcm(inbits, outbits);
+
+	/* now do the real work */
+	memset(out, 0, outbits);
+	byte = 0;
+
+	/* this will end up cycling through k lcm(k,n)/k times, which
+	 * is correct.
+	 */
+	for (i = ulcm-1; i >= 0; i--) {
+		/* compute the msbit in k which gets added into this byte */
+		msbit = (
+			/* first, start with the msbit in the first,
+			 * unrotated byte
+			 */
+			((inbits << 3) - 1) +
+			/* then, for each byte, shift to the right
+			 * for each repetition
+			 */
+			(((inbits << 3) + 13) * (i/inbits)) +
+			/* last, pick out the correct byte within
+			 * that shifted repetition
+			 */
+			((inbits - (i % inbits)) << 3)
+			 ) % (inbits << 3);
+
+		/* pull out the byte value itself */
+		byte += (((in[((inbits - 1) - (msbit >> 3)) % inbits] << 8) |
+			  (in[((inbits)     - (msbit >> 3)) % inbits]))
+			 >> ((msbit & 7) + 1)) & 0xff;
+
+		/* do the addition */
+		byte += out[i % outbits];
+		out[i % outbits] = byte & 0xff;
+
+		/* keep around the carry bit, if any */
+		byte >>= 8;
+	}
+
+	/* if there's a carry bit left over, add it back in */
+	if (byte) {
+		for (i = outbits - 1; i >= 0; i--) {
+			/* do the addition */
+			byte += out[i];
+			out[i] = byte & 0xff;
+
+			/* keep around the carry bit, if any */
+			byte >>= 8;
+		}
+	}
+}
+
+/*
+ * Calculate a derived key, DK(Base Key, Well-Known Constant)
+ *
+ * DK(Key, Constant) = random-to-key(DR(Key, Constant))
+ * DR(Key, Constant) = k-truncate(E(Key, Constant, initial-cipher-state))
+ * K1 = E(Key, n-fold(Constant), initial-cipher-state)
+ * K2 = E(Key, K1, initial-cipher-state)
+ * K3 = E(Key, K2, initial-cipher-state)
+ * K4 = ...
+ * DR(Key, Constant) = k-truncate(K1 | K2 | K3 | K4 ...)
+ * [rfc3961 sec 5.1]
+ */
+static int rfc3961_calc_DK(const struct krb5_enctype *krb5,
+			   const struct krb5_buffer *inkey,
+			   const struct krb5_buffer *in_constant,
+			   struct krb5_buffer *result,
+			   gfp_t gfp)
+{
+	unsigned int blocksize, keybytes, keylength, n;
+	struct krb5_buffer inblock, outblock, rawkey;
+	struct crypto_sync_skcipher *cipher;
+	int ret = -EINVAL;
+
+	blocksize = krb5->block_len;
+	keybytes = krb5->key_bytes;
+	keylength = krb5->key_len;
+
+	if (inkey->len != keylength || result->len != keylength)
+		return -EINVAL;
+	if (!krb5->random_to_key && result->len != keybytes)
+		ret = -EINVAL;
+
+	cipher = crypto_alloc_sync_skcipher(krb5->encrypt_name, 0, 0);
+	if (IS_ERR(cipher)) {
+		ret = (PTR_ERR(cipher) == -ENOENT) ? -ENOPKG : PTR_ERR(cipher);
+		goto err_return;
+	}
+	ret = crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len);
+	if (ret < 0)
+		goto err_free_cipher;
+
+	ret = -ENOMEM;
+	inblock.data = kzalloc(blocksize * 2 + keybytes, gfp);
+	if (!inblock.data)
+		goto err_free_cipher;
+
+	inblock.len	= blocksize;
+	outblock.data	= inblock.data + blocksize;
+	outblock.len	= blocksize;
+	rawkey.data	= outblock.data + blocksize;
+	rawkey.len	= keybytes;
+
+	/* initialize the input block */
+
+	if (in_constant->len == inblock.len)
+		memcpy(inblock.data, in_constant->data, inblock.len);
+	else
+		rfc3961_nfold(in_constant, &inblock);
+
+	/* loop encrypting the blocks until enough key bytes are generated */
+	n = 0;
+	while (n < rawkey.len) {
+		rfc3961_do_encrypt(cipher, NULL, &inblock, &outblock);
+
+		if (keybytes - n <= outblock.len) {
+			memcpy(rawkey.data + n, outblock.data, keybytes - n);
+			break;
+		}
+
+		memcpy(rawkey.data + n, outblock.data, outblock.len);
+		memcpy(inblock.data, outblock.data, outblock.len);
+		n += outblock.len;
+	}
+
+	/* postprocess the key */
+	if (!krb5->random_to_key) {
+		/* Identity random-to-key function. */
+		memcpy(result->data, rawkey.data, rawkey.len);
+		ret = 0;
+	} else {
+		ret = krb5->random_to_key(krb5, &rawkey, result);
+	}
+
+	kfree_sensitive(inblock.data);
+err_free_cipher:
+	crypto_free_sync_skcipher(cipher);
+err_return:
+	return ret;
+}
+
+/*
+ * Calculate single encryption, E()
+ *
+ *	E(Key, octets)
+ */
+static int rfc3961_calc_E(const struct krb5_enctype *krb5,
+			  const struct krb5_buffer *key,
+			  const struct krb5_buffer *in_data,
+			  struct krb5_buffer *result,
+			  gfp_t gfp)
+{
+	struct crypto_sync_skcipher *cipher;
+	int ret;
+
+	cipher = crypto_alloc_sync_skcipher(krb5->encrypt_name, 0, 0);
+	if (IS_ERR(cipher)) {
+		ret = (PTR_ERR(cipher) == -ENOENT) ? -ENOPKG : PTR_ERR(cipher);
+		goto err;
+	}
+
+	ret = crypto_sync_skcipher_setkey(cipher, key->data, key->len);
+	if (ret < 0)
+		goto err_free;
+
+	ret = rfc3961_do_encrypt(cipher, NULL, in_data, result);
+
+err_free:
+	crypto_free_sync_skcipher(cipher);
+err:
+	return ret;
+}
+
+/*
+ * Calculate the pseudo-random function, PRF().
+ *
+ *      tmp1 = H(octet-string)
+ *      tmp2 = truncate tmp1 to multiple of m
+ *      PRF = E(DK(protocol-key, prfconstant), tmp2, initial-cipher-state)
+ *
+ *      The "prfconstant" used in the PRF operation is the three-octet string
+ *      "prf".
+ *      [rfc3961 sec 5.3]
+ */
+static int rfc3961_calc_PRF(const struct krb5_enctype *krb5,
+			    const struct krb5_buffer *protocol_key,
+			    const struct krb5_buffer *octet_string,
+			    struct krb5_buffer *result,
+			    gfp_t gfp)
+{
+	static const struct krb5_buffer prfconstant = { 3, "prf" };
+	struct krb5_buffer derived_key;
+	struct krb5_buffer tmp1, tmp2;
+	unsigned int m = krb5->block_len;
+	void *buffer;
+	int ret;
+
+	if (result->len != krb5->prf_len)
+		return -EINVAL;
+
+	tmp1.len = krb5->hash_len;
+	derived_key.len = krb5->key_bytes;
+	buffer = kzalloc(round16(tmp1.len) + round16(derived_key.len), gfp);
+	if (!buffer)
+		return -ENOMEM;
+
+	tmp1.data = buffer;
+	derived_key.data = buffer + round16(tmp1.len);
+
+	ret = rfc3961_calc_H(krb5, octet_string, &tmp1, gfp);
+	if (ret < 0)
+		goto err;
+
+	tmp2.len = tmp1.len & ~(m - 1);
+	tmp2.data = tmp1.data;
+
+	ret = rfc3961_calc_DK(krb5, protocol_key, &prfconstant, &derived_key, gfp);
+	if (ret < 0)
+		goto err;
+
+	ret = rfc3961_calc_E(krb5, &derived_key, &tmp2, result, gfp);
+
+err:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
+/*
+ * Apply encryption and checksumming functions to part of a message.  The
+ * caller is responsible for laying out the message and inserting a confounder.
+ *
+ * req->cryptlen indicates the size of the area in the source to be encrypted,
+ * and must include any metadata prior to the data area, such as the
+ * confounder.  Space for post-data metadata, such as the checksum, only needs
+ * to exist in the destination.
+ */
+static int rfc3961_encrypt(struct aead_request *req)
+{
+	struct skcipher_request	*ci;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct krb5_enctype *krb5 = crypto_krb5_enctype(tfm);
+	struct scatterlist *src = req->src, *dst = req->dst;
+	struct shash_desc *desc;
+	struct krb5_ctx *ctx = crypto_krb5_ctx(tfm);
+	size_t bsize, enc_len = req->cryptlen;
+	size_t src_len, dst_len, done;
+	void *buffer;
+	int ret, nr_src, nr_dst;
+	u8 *cksum, *iv;
+
+	src_len = sg_count(src, &nr_src);
+	dst_len = sg_count(dst, &nr_dst);
+
+	if (WARN_ON(enc_len < krb5->conf_len) ||
+	    WARN_ON(src_len < enc_len) ||
+	    WARN_ON(dst_len < enc_len + krb5->cksum_len))
+		return -EINVAL;
+
+	/* The message is laid out thusly:
+	 *
+	 *	Confounder||Data||Padding||Integrity
+	 *
+	 * The Padding may or may not be present, but the Integrity checksum
+	 * must be right at the end of the message so that we can find it.  The
+	 * Confounder, Data and Padding are encrypted; the Integrity checksum
+	 * is not.  The Integrity checksum is over the plaintext.
+	 */
+	enc_len	= req->cryptlen;
+
+	bsize = krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki) +
+		krb5_sync_skcipher_size(ctx->Ke) +
+		krb5_sync_skcipher_ivsize(ctx->Ke);
+	bsize = umax(umax(bsize, krb5->conf_len), krb5->block_len);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	/* Calculate the checksum using key Ki */
+	cksum = buffer + krb5_shash_size(ctx->Ki);
+
+	desc = buffer;
+	desc->tfm = ctx->Ki;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+	ret = crypto_shash_update_sg(desc, src, 0, enc_len);
+	if (ret < 0)
+		goto error;
+	ret = crypto_shash_final(desc, cksum);
+	if (ret < 0)
+		goto error;
+
+	/* Append the checksum into the buffer. */
+	ret = -EFAULT;
+	done = sg_pcopy_from_buffer(dst, nr_dst, cksum, krb5->cksum_len, enc_len);
+	if (done != krb5->cksum_len)
+		goto error;
+
+	/* Encrypt the secure region with key Ke. */
+	ci = buffer +
+		krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki);
+	iv = buffer +
+		krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki) +
+		krb5_sync_skcipher_size(ctx->Ke);
+
+	skcipher_request_set_sync_tfm(ci, ctx->Ke);
+	skcipher_request_set_callback(ci, 0, NULL, NULL);
+	skcipher_request_set_crypt(ci, src, dst, enc_len, iv);
+	ret = crypto_skcipher_encrypt(ci);
+	if (ret < 0)
+		goto error;
+
+	ret = 0;
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
+/*
+ * Apply decryption and checksumming functions to part of an skbuff.  The
+ * offset and length are updated to reflect the actual content of the encrypted
+ * region.
+ *
+ * The associated data must contain a krb5_assoc_data struct.  At the
+ * conclusion, the output associated data is updated with the size of the
+ * encrypted data.  The associated data must be in its own scatterlist element
+ * in both chains so that we can skip over it.
+ */
+static int rfc3961_decrypt(struct aead_request *req)
+{
+	struct skcipher_request	*ci;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct krb5_enctype *krb5 = crypto_krb5_enctype(tfm);
+	struct scatterlist *src = req->src, *dst = req->dst;
+	struct shash_desc *desc;
+	struct krb5_ctx *ctx = crypto_krb5_ctx(tfm);
+	size_t bsize, src_len, dst_len, enc_len, msg_len = req->cryptlen, done;
+	void *buffer;
+	int ret, nr_src, nr_dst;
+	u8 *cksum, *cksum2, *iv;
+
+	src_len = sg_count(src, &nr_src);
+	dst_len = sg_count(dst, &nr_dst);
+
+	if (WARN_ON(msg_len < krb5->conf_len + krb5->cksum_len) ||
+	    WARN_ON(src_len < msg_len) ||
+	    WARN_ON(dst_len < msg_len - krb5->cksum_len))
+		return -EINVAL;
+
+	/* The integrity checksum is right up against the end. */
+	enc_len = msg_len - krb5->cksum_len;
+
+	bsize = krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki) * 2 +
+		krb5_sync_skcipher_size(ctx->Ke) +
+		krb5_sync_skcipher_ivsize(ctx->Ke);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	cksum = buffer +
+		krb5_shash_size(ctx->Ki);
+	cksum2 = buffer +
+		krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki);
+	ci = buffer +
+		krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki) * 2;
+	iv = buffer +
+		krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki) * 2 +
+		krb5_sync_skcipher_size(ctx->Ke);
+
+	/* Decrypt the secure region with key Ke. */
+	skcipher_request_set_sync_tfm(ci, ctx->Ke);
+	skcipher_request_set_callback(ci, 0, NULL, NULL);
+	skcipher_request_set_crypt(ci, src, dst, enc_len, iv);
+	ret = crypto_skcipher_decrypt(ci);
+	if (ret < 0)
+		goto error;
+
+	/* Calculate the checksum using key Ki */
+	desc = buffer;
+	desc->tfm = ctx->Ki;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_update_sg(desc, src, 0, enc_len);
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_final(desc, cksum);
+	if (ret < 0)
+		goto error;
+
+	/* Get the checksum from the buffer. */
+	ret = -EFAULT;
+	done = sg_pcopy_to_buffer(src, nr_src, cksum2, krb5->cksum_len, enc_len);
+	if (done != krb5->cksum_len)
+		goto error;
+
+	ret = -EPROTO;
+	if (memcmp(cksum, cksum2, krb5->cksum_len) != 0)
+		goto error;
+
+	ret = 0;
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
+/*
+ * Generate a checksum over some metadata and part of a message and insert the
+ * MIC into the message immediately prior to the data.
+ *
+ * Any metadata to be added to the hash must be in assoc data.
+ */
+int rfc3961_get_mic(struct aead_request *req)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct krb5_enctype *krb5 = crypto_krb5_enctype(tfm);
+	struct scatterlist *src = req->src, *dst = req->dst;
+	struct shash_desc *desc;
+	struct krb5_ctx *ctx = crypto_krb5_ctx(tfm);
+	size_t meta_len = req->assoclen, msg_len = req->cryptlen;
+	size_t src_len, dst_len, data_len, bsize, done;
+	void *buffer, *digest;
+	int ret, nr_src, nr_dst;
+
+	src_len = sg_count(src, &nr_src);
+	dst_len = sg_count(dst, &nr_dst);
+
+	if (WARN_ON(msg_len < krb5->cksum_len) ||
+	    WARN_ON(src_len < msg_len) ||
+	    WARN_ON(dst_len < src_len))
+		return -EINVAL;
+
+	/* The message is laid out thusly:
+	 *
+	 *	Checksum||Data
+	 *
+	 * The Checksum must be right at the beginning of the message so that
+	 * we can find it.
+	 */
+	data_len = msg_len - krb5->cksum_len;
+
+	bsize = krb5_shash_size(ctx->Kc) +
+		krb5_digest_size(ctx->Kc);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	/* Calculate the MIC with key Kc and store it into the skb */
+	desc = buffer;
+	desc->tfm = ctx->Kc;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	if (meta_len) {
+		ret = crypto_shash_update_sg(desc, src, 0, meta_len);
+		if (ret < 0)
+			goto error;
+	}
+
+	ret = crypto_shash_update_sg(desc, src, meta_len + krb5->cksum_len, data_len);
+	if (ret < 0)
+		goto error;
+
+	digest = buffer + krb5_shash_size(ctx->Kc);
+	ret = crypto_shash_final(desc, digest);
+	if (ret < 0)
+		goto error;
+
+	ret = -EFAULT;
+	done = sg_pcopy_from_buffer(dst, nr_dst, digest, krb5->cksum_len, meta_len);
+	if (done != krb5->cksum_len)
+		goto error;
+
+	ret = 0;
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
+/*
+ * Check the MIC on a message.
+ *
+ * Any metadata to be added to the hash must be in assoc data.
+ *
+ * [!] NOTE: This produces nothing in the destination buffer.
+ */
+int rfc3961_verify_mic(struct aead_request *req)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct krb5_enctype *krb5 = crypto_krb5_enctype(tfm);
+	struct scatterlist *src = req->src, *dst = req->dst;
+	struct shash_desc *desc;
+	struct krb5_ctx *ctx = crypto_krb5_ctx(tfm);
+	size_t meta_len = req->assoclen, msg_len = req->cryptlen;
+	size_t src_len, dst_len, data_len, bsize, done;
+	void *buffer, *cksum, *cksum2;
+	int ret, nr_src, nr_dst;
+
+	src_len = sg_count(src, &nr_src);
+	dst_len = sg_count(dst, &nr_dst);
+
+	if (WARN_ON(msg_len < krb5->cksum_len) ||
+	    WARN_ON(src_len < msg_len) ||
+	    WARN_ON(dst_len < src_len))
+		return -EINVAL;
+
+	/* The message is laid out thusly:
+	 *
+	 *	Checksum||Data
+	 *
+	 * The Checksum must be right at the beginning of the message so that
+	 * we can find it.
+	 */
+	data_len = msg_len - krb5->cksum_len;
+
+	bsize = krb5_shash_size(ctx->Kc) +
+		krb5_digest_size(ctx->Kc) * 2;
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	cksum = buffer +
+		krb5_shash_size(ctx->Kc);
+	cksum2 = buffer +
+		krb5_shash_size(ctx->Kc) +
+		krb5_digest_size(ctx->Kc);
+
+	/* Calculate the MIC */
+	desc = buffer;
+	desc->tfm = ctx->Kc;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	if (meta_len) {
+		ret = crypto_shash_update_sg(desc, src, 0, meta_len);
+		if (ret < 0)
+			goto error;
+	}
+
+	ret = crypto_shash_update_sg(desc, src, meta_len + krb5->cksum_len, data_len);
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_final(desc, cksum);
+	if (ret < 0)
+		goto error;
+
+	ret = -EFAULT;
+	done = sg_pcopy_to_buffer(src, nr_src, cksum2, krb5->cksum_len, meta_len);
+	if (done != krb5->cksum_len)
+		goto error;
+
+	if (memcmp(cksum, cksum2, krb5->cksum_len) != 0) {
+		ret = -EPROTO;
+		goto error;
+	}
+
+	ret = 0;
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
+int rfc3961_aead_encrypt(struct aead_request *req)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct krb5_ctx *ctx = crypto_krb5_ctx(tfm);
+
+	if (ctx->Ke)
+		return rfc3961_encrypt(req);
+	return rfc3961_get_mic(req);
+}
+
+int rfc3961_aead_decrypt(struct aead_request *req)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct krb5_ctx *ctx = crypto_krb5_ctx(tfm);
+
+	if (ctx->Ke)
+		return rfc3961_decrypt(req);
+	return rfc3961_verify_mic(req);
+}
+
+const struct krb5_crypto_profile rfc3961_simplified_profile = {
+	.calc_PRF	= rfc3961_calc_PRF,
+	.calc_Kc	= rfc3961_calc_DK,
+	.calc_Ke	= rfc3961_calc_DK,
+	.calc_Ki	= rfc3961_calc_DK,
+};
diff --git a/crypto/krb5/rfc6803_camellia.c b/crypto/krb5/rfc6803_camellia.c
new file mode 100644
index 000000000000..206224ab05ec
--- /dev/null
+++ b/crypto/krb5/rfc6803_camellia.c
@@ -0,0 +1,190 @@
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
+	if (ret < 0) {
+		pr_err("setkey %s failed %d %u\n", krb5->cksum_name, ret, key->len);
+		goto error_shash;
+	}
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
+	if (WARN_ON(p - (u8 *)data.data != data.len)) {
+		pr_err("len check\n");
+		goto error;
+	}
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
+		if (ret < 0) {
+			pr_err("shash_init\n");
+			goto error;
+		}
+		ret = crypto_shash_finup(desc, data.data, data.len, K.data);
+		if (ret < 0) {
+			pr_err("shash_finup\n");
+			goto error;
+		}
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
+const struct krb5_crypto_profile rfc6803_crypto_profile = {
+	.calc_PRF	= rfc6803_calc_PRF,
+	.calc_Kc	= rfc6803_calc_KDF_FEEDBACK_CMAC,
+	.calc_Ke	= rfc6803_calc_KDF_FEEDBACK_CMAC,
+	.calc_Ki	= rfc6803_calc_KDF_FEEDBACK_CMAC,
+};
diff --git a/crypto/krb5/rfc8009_aes2.c b/crypto/krb5/rfc8009_aes2.c
new file mode 100644
index 000000000000..60b43479e108
--- /dev/null
+++ b/crypto/krb5/rfc8009_aes2.c
@@ -0,0 +1,394 @@
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
+#include <linux/random.h>
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
+ * Apply encryption and checksumming functions to part of a message.  The
+ * caller is responsible for laying out the message and inserting a confounder.
+ *
+ * req->cryptlen indicates the size of the area in the source to be encrypted,
+ * and must include any metadata prior to the data area, such as the
+ * confounder.  Space for post-data metadata, such as the checksum, only needs
+ * to exist in the destination.
+ */
+static int rfc8009_encrypt(struct aead_request *req)
+{
+	struct skcipher_request	*ci;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct krb5_enctype *krb5 = crypto_krb5_enctype(tfm);
+	struct scatterlist *src = req->src, *dst = req->dst;
+	struct shash_desc *desc;
+	struct krb5_ctx *ctx = crypto_krb5_ctx(tfm);
+	size_t bsize, enc_len = req->cryptlen, msg_len;
+	size_t src_len, dst_len, done;
+	void *buffer;
+	int ret, nr_src, nr_dst;
+	u8 *cksum, *iv;
+
+	src_len = sg_count(src, &nr_src);
+	dst_len = sg_count(dst, &nr_dst);
+
+	if (WARN_ON(enc_len < krb5->conf_len) ||
+	    WARN_ON(src_len < enc_len) ||
+	    WARN_ON(dst_len < enc_len + krb5->cksum_len))
+		return -EINVAL;
+
+	/* The message is laid out thusly:
+	 *
+	 *	Confounder||Data||Padding||Integrity
+	 *
+	 * The Padding may or may not be present, but the Integrity checksum
+	 * must be right at the end of the message so that we can find it.  The
+	 * Confounder, Data and Padding are encrypted; the Integrity checksum
+	 * is not.  The Integrity checksum is over the ciphertext.
+	 */
+	msg_len	= src_len;
+	enc_len	= msg_len - krb5->cksum_len;
+
+	bsize = krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki) +
+		krb5_sync_skcipher_size(ctx->Ke) +
+		krb5_sync_skcipher_ivsize(ctx->Ke);
+	bsize = umax(umax(bsize, krb5->conf_len), krb5->block_len);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	/* Encrypt the secure region with key Ke. */
+	ci = buffer +
+		krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki);
+	iv = buffer +
+		krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki) +
+		krb5_sync_skcipher_size(ctx->Ke);
+
+	skcipher_request_set_sync_tfm(ci, ctx->Ke);
+	skcipher_request_set_callback(ci, 0, NULL, NULL);
+	skcipher_request_set_crypt(ci, src, dst, enc_len, iv);
+	ret = crypto_skcipher_encrypt(ci);
+	if (ret < 0)
+		goto error;
+
+	/* Calculate the checksum using key Ki */
+	cksum = buffer + krb5_shash_size(ctx->Ki);
+
+	desc = buffer;
+	desc->tfm = ctx->Ki;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	memset(iv, 0, crypto_sync_skcipher_ivsize(ctx->Ke));
+	ret = crypto_shash_update(desc, iv, crypto_sync_skcipher_ivsize(ctx->Ke));
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_update_sg(desc, src, 0, enc_len);
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_final(desc, cksum);
+	if (ret < 0)
+		goto error;
+
+	/* Append the checksum into the buffer. */
+	ret = -EFAULT;
+	sg_zero_buffer(dst, nr_dst, 3, enc_len);
+	done = sg_pcopy_from_buffer(dst, nr_dst, cksum, krb5->cksum_len, enc_len);
+	if (done != krb5->cksum_len)
+		goto error;
+
+	ret = 0;
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
+/*
+ * Apply decryption and checksumming functions to part of an skbuff.  The
+ * offset and length are updated to reflect the actual content of the encrypted
+ * region.
+ *
+ * The associated data must contain a krb5_assoc_data struct.  At the
+ * conclusion, the output associated data is updated with the size of the
+ * encrypted data.  The associated data must be in its own scatterlist element
+ * in both chains so that we can skip over it.
+ */
+static int rfc8009_decrypt(struct aead_request *req)
+{
+	struct skcipher_request	*ci;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct krb5_enctype *krb5 = crypto_krb5_enctype(tfm);
+	struct scatterlist *src = req->src, *dst = req->dst;
+	struct shash_desc *desc;
+	struct krb5_ctx *ctx = crypto_krb5_ctx(tfm);
+	size_t bsize, src_len, dst_len, enc_len, msg_len = req->cryptlen, done;
+	void *buffer;
+	int ret, nr_src, nr_dst;
+	u8 *cksum, *cksum2, *iv;
+
+	src_len = sg_count(src, &nr_src);
+	dst_len = sg_count(dst, &nr_dst);
+
+	if (WARN_ON(msg_len < krb5->conf_len + krb5->cksum_len) ||
+	    WARN_ON(src_len < msg_len) ||
+	    WARN_ON(dst_len < msg_len - krb5->cksum_len))
+		return -EINVAL;
+
+	/* The integrity checksum is right up against the end. */
+	enc_len = msg_len - krb5->cksum_len;
+
+	bsize = krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki) * 2 +
+		krb5_sync_skcipher_size(ctx->Ke) +
+		krb5_sync_skcipher_ivsize(ctx->Ke);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	cksum = buffer +
+		krb5_shash_size(ctx->Ki);
+	cksum2 = buffer +
+		krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki);
+	ci = buffer +
+		krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki) * 2;
+	iv = buffer +
+		krb5_shash_size(ctx->Ki) +
+		krb5_digest_size(ctx->Ki) * 2 +
+		krb5_sync_skcipher_size(ctx->Ke);
+
+	/* Calculate the checksum using key Ki */
+	desc = buffer;
+	desc->tfm = ctx->Ki;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_update(desc, iv, crypto_sync_skcipher_ivsize(ctx->Ke));
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_update_sg(desc, src, 0, enc_len);
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_final(desc, cksum);
+	if (ret < 0)
+		goto error;
+
+	/* Get the checksum from the buffer. */
+	ret = -EFAULT;
+	done = sg_pcopy_to_buffer(src, nr_src, cksum2, krb5->cksum_len, enc_len);
+	if (done != krb5->cksum_len)
+		goto error;
+
+	ret = -EPROTO;
+	if (memcmp(cksum, cksum2, krb5->cksum_len) != 0)
+		goto error;
+
+	/* Decrypt the secure region with key Ke. */
+	skcipher_request_set_sync_tfm(ci, ctx->Ke);
+	skcipher_request_set_callback(ci, 0, NULL, NULL);
+	skcipher_request_set_crypt(ci, src, dst, enc_len, iv);
+	ret = crypto_skcipher_decrypt(ci);
+	if (ret < 0)
+		goto error;
+
+	ret = 0;
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
+int rfc8009_aead_encrypt(struct aead_request *req)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct krb5_ctx *ctx = crypto_krb5_ctx(tfm);
+
+	if (ctx->Ke)
+		return rfc8009_encrypt(req);
+	return rfc3961_get_mic(req);
+}
+
+int rfc8009_aead_decrypt(struct aead_request *req)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct krb5_ctx *ctx = crypto_krb5_ctx(tfm);
+
+	if (ctx->Ke)
+		return rfc8009_decrypt(req);
+	return rfc3961_verify_mic(req);
+}
+
+const struct krb5_crypto_profile rfc8009_crypto_profile = {
+	.calc_PRF	= rfc8009_calc_PRF,
+	.calc_Kc	= rfc8009_calc_Ki,
+	.calc_Ke	= rfc8009_calc_Ke,
+	.calc_Ki	= rfc8009_calc_Ki,
+};
diff --git a/crypto/krb5/selftest.c b/crypto/krb5/selftest.c
new file mode 100644
index 000000000000..b22bd8d00d1c
--- /dev/null
+++ b/crypto/krb5/selftest.c
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Kerberos library self-testing
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/slab.h>
+#include <crypto/skcipher.h>
+#include <crypto/hash.h>
+#include "internal.h"
+
+#define VALID(X) \
+	({								\
+		bool __x = (X);						\
+		if (__x) {						\
+			pr_warn("!!! TESTINVAL %s:%u\n", __FILE__, __LINE__); \
+			ret = -EBADMSG;					\
+		}							\
+		__x;							\
+	})
+
+#define CHECK(X) \
+	({								\
+		bool __x = (X);						\
+		if (__x) {						\
+			pr_warn("!!! TESTFAIL %s:%u\n", __FILE__, __LINE__); \
+			ret = -EBADMSG;					\
+		}							\
+		__x;							\
+	})
+
+enum which_key {
+	TEST_KC, TEST_KE, TEST_KI,
+};
+
+static int prep_buf(struct krb5_buffer *buf)
+{
+	buf->data = kmalloc(buf->len, GFP_KERNEL);
+	if (!buf->data)
+		return -ENOMEM;
+	return 0;
+}
+
+#define PREP_BUF(BUF, LEN)					\
+	do {							\
+		(BUF)->len = (LEN);				\
+		ret = prep_buf((BUF));				\
+		if (ret < 0)					\
+			goto out;				\
+	} while (0)
+
+static int load_buf(struct krb5_buffer *buf, const char *from)
+{
+	size_t len = strlen(from);
+	int ret;
+
+	if (len > 1 && from[0] == '\'') {
+		PREP_BUF(buf, len - 1);
+		memcpy(buf->data, from + 1, len - 1);
+		ret = 0;
+		goto out;
+	}
+
+	if (VALID(len & 1))
+		return -EINVAL;
+
+	PREP_BUF(buf, len / 2);
+	ret = hex2bin(buf->data, from, buf->len);
+	if (ret < 0) {
+		VALID(1);
+		goto out;
+	}
+out:
+	return ret;
+}
+
+#define LOAD_BUF(BUF, FROM) do { ret = load_buf(BUF, FROM); if (ret < 0) goto out; } while (0)
+
+static void clear_buf(struct krb5_buffer *buf)
+{
+	kfree(buf->data);
+	buf->len = 0;
+	buf->data = NULL;
+}
+
+/*
+ * Perform a pseudo-random function check.
+ */
+static int krb5_test_one_prf(const struct krb5_prf_test *test)
+{
+	const struct krb5_enctype *krb5 = crypto_krb5_find_enctype(test->etype);
+	struct krb5_buffer key = {}, octet = {}, result = {}, prf = {};
+	int ret;
+
+	if (!krb5)
+		return -EOPNOTSUPP;
+
+	pr_notice("Running %s %s\n", krb5->name, test->name);
+
+	LOAD_BUF(&key,   test->key);
+	LOAD_BUF(&octet, test->octet);
+	LOAD_BUF(&prf,   test->prf);
+	PREP_BUF(&result, krb5->prf_len);
+
+	if (VALID(result.len != prf.len)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = krb5->profile->calc_PRF(krb5, &key, &octet, &result, GFP_KERNEL);
+	if (ret < 0) {
+		CHECK(1);
+		pr_warn("PRF calculation failed %d\n", ret);
+		goto out;
+	}
+
+	if (memcmp(result.data, prf.data, result.len) != 0) {
+		CHECK(1);
+		ret = -EKEYREJECTED;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	clear_buf(&result);
+	clear_buf(&octet);
+	clear_buf(&key);
+	return ret;
+}
+
+/*
+ * Perform a key derivation check.
+ */
+static int krb5_test_key(const struct krb5_enctype *krb5,
+			 const struct krb5_buffer *base_key,
+			 const struct krb5_key_test_one *test,
+			 enum which_key which)
+{
+	struct krb5_buffer key = {}, result = {};
+	int ret;
+
+	LOAD_BUF(&key,   test->key);
+	PREP_BUF(&result, key.len);
+
+	switch (which) {
+	case TEST_KC:
+		ret = krb5_derive_Kc(krb5, base_key, test->use, &result, GFP_KERNEL);
+		break;
+	case TEST_KE:
+		ret = krb5_derive_Ke(krb5, base_key, test->use, &result, GFP_KERNEL);
+		break;
+	case TEST_KI:
+		ret = krb5_derive_Ki(krb5, base_key, test->use, &result, GFP_KERNEL);
+		break;
+	default:
+		VALID(1);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (ret < 0) {
+		CHECK(1);
+		pr_warn("Key derivation failed %d\n", ret);
+		goto out;
+	}
+
+	if (memcmp(result.data, key.data, result.len) != 0) {
+		CHECK(1);
+		ret = -EKEYREJECTED;
+		goto out;
+	}
+
+out:
+	clear_buf(&key);
+	clear_buf(&result);
+	return ret;
+}
+
+static int krb5_test_one_key(const struct krb5_key_test *test)
+{
+	const struct krb5_enctype *krb5 = crypto_krb5_find_enctype(test->etype);
+	struct krb5_buffer base_key = {};
+	int ret;
+
+	if (!krb5)
+		return -EOPNOTSUPP;
+
+	pr_notice("Running %s %s\n", krb5->name, test->name);
+
+	LOAD_BUF(&base_key, test->key);
+
+	ret = krb5_test_key(krb5, &base_key, &test->Kc, TEST_KC);
+	if (ret < 0)
+		goto out;
+	ret = krb5_test_key(krb5, &base_key, &test->Ke, TEST_KE);
+	if (ret < 0)
+		goto out;
+	ret = krb5_test_key(krb5, &base_key, &test->Ki, TEST_KI);
+	if (ret < 0)
+		goto out;
+
+out:
+	clear_buf(&base_key);
+	return ret;
+}
+
+/*
+ * Perform an encryption test.
+ */
+static int krb5_test_one_enc(const struct krb5_enc_test *test, void *buf)
+{
+	const struct krb5_enctype *krb5 = crypto_krb5_find_enctype(test->etype);
+	struct aead_request *req = NULL;
+	struct crypto_aead *ci = NULL;
+	struct krb5_buffer key = {}, conf = {}, plain = {}, ct = {};
+	struct scatterlist sg[1];
+	size_t reqsize, data_len, data_offset, message_len;
+	int ret;
+
+	if (!krb5)
+		return -EOPNOTSUPP;
+
+	pr_notice("Running %s %s\n", krb5->name, test->name);
+
+	/* Load the test data into binary buffers. */
+	LOAD_BUF(&key, test->key);
+	LOAD_BUF(&conf, test->conf);
+	LOAD_BUF(&plain, test->plain);
+	LOAD_BUF(&ct, test->ct);
+
+	if (VALID(conf.len != krb5->conf_len) ||
+	    VALID(ct.len != krb5->conf_len + plain.len + krb5->cksum_len))
+		return ret;
+
+	data_len = plain.len;
+	message_len = crypto_krb5_how_much_buffer(krb5, KRB5_ENCRYPT_MODE,
+						  data_len, &data_offset);
+
+	if (CHECK(message_len != ct.len)) {
+		pr_warn("Encrypted length mismatch %zu != %u\n", message_len, ct.len);
+		goto out;
+	}
+
+	memcpy(buf + data_offset, plain.data, plain.len);
+
+	sg_init_one(sg, buf, message_len);
+	ret = crypto_krb5_confound_buffer(krb5, sg, 1, conf.data, conf.len, 0);
+	if (ret < 0) {
+		pr_err("Couldn't confound buffer %s: %d\n", krb5->aead.base.cra_name, ret);
+		goto out;
+	}
+
+	/* Allocate a crypto object and set its key. */
+	ci = crypto_alloc_aead(krb5->aead.base.cra_name, 0, 0);
+	if (IS_ERR(ci)) {
+		ret = (PTR_ERR(ci) == -ENOENT) ? -ENOPKG : PTR_ERR(ci);
+		ci = NULL;
+		pr_err("Couldn't alloc AEAD %s: %d\n", krb5->aead.base.cra_name, ret);
+		goto out;
+	}
+
+	ret = crypto_aead_setkey(ci, key.data, key.len);
+	if (ret < 0) {
+		pr_err("Couldn't set AEAD key %s: %d\n", krb5->aead.base.cra_name, ret);
+		goto out;
+	}
+
+	/* Generate an encryption request. */
+	reqsize = crypto_roundup(sizeof(*req) + crypto_aead_reqsize(ci));
+	req = kzalloc(reqsize, GFP_KERNEL);
+	if (!req)
+		goto out;
+
+	aead_request_set_tfm(req, ci);
+
+	sg_init_one(sg, buf, message_len);
+	aead_request_set_crypt(req, sg, sg, data_offset + data_len, NULL);
+
+	ret = crypto_aead_encrypt(req);
+	if (ret < 0) {
+		CHECK(1);
+		pr_warn("Encryption failed %d\n", ret);
+		goto out;
+	}
+
+	if (memcmp(buf, ct.data, ct.len) != 0) {
+		CHECK(1);
+		pr_warn("Ciphertext mismatch\n");
+		pr_warn("BUF %*phN\n", ct.len, buf);
+		pr_warn("CT  %*phN\n", ct.len, ct.data);
+		ret = -EKEYREJECTED;
+		goto out;
+	}
+
+	/* Generate a decryption request. */
+	memset(req, 0, reqsize);
+	aead_request_set_tfm(req, ci);
+
+	sg_init_one(sg, buf, message_len);
+	aead_request_set_crypt(req, sg, sg, message_len, NULL);
+
+	ret = crypto_aead_decrypt(req);
+	if (ret < 0) {
+		CHECK(1);
+		pr_warn("Decryption failed %d\n", ret);
+		goto out;
+	}
+
+	data_offset = 0;
+	data_len = message_len;
+	crypto_krb5_where_is_the_data(krb5, KRB5_ENCRYPT_MODE,
+				      &data_offset, &data_len);
+
+	if (CHECK(data_offset != conf.len) ||
+	    CHECK(data_len != plain.len))
+		goto out;
+
+	if (memcmp(buf, conf.data, conf.len) != 0) {
+		CHECK(1);
+		pr_warn("Confounder mismatch\n");
+		pr_warn("ENC %*phN\n", conf.len, buf);
+		pr_warn("DEC %*phN\n", conf.len, conf.data);
+		ret = -EKEYREJECTED;
+		goto out;
+	}
+
+	if (memcmp(buf + conf.len, plain.data, plain.len) != 0) {
+		CHECK(1);
+		pr_warn("Plaintext mismatch\n");
+		pr_warn("BUF %*phN\n", plain.len, buf + conf.len);
+		pr_warn("PT  %*phN\n", plain.len, plain.data);
+		ret = -EKEYREJECTED;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	clear_buf(&ct);
+	clear_buf(&plain);
+	clear_buf(&conf);
+	clear_buf(&key);
+	aead_request_free(req);
+	if (ci)
+		crypto_free_aead(ci);
+	return ret;
+}
+
+/*
+ * Perform a checksum test.
+ */
+static int krb5_test_one_mic(const struct krb5_mic_test *test, void *buf)
+{
+	const struct krb5_enctype *krb5 = crypto_krb5_find_enctype(test->etype);
+	struct aead_request *req = NULL;
+	struct crypto_aead *ci = NULL;
+	struct krb5_buffer key = {}, plain = {}, mic = {};
+	struct scatterlist sg[2];
+	size_t reqsize, data_len, data_offset, message_len;
+	int ret;
+
+	if (!krb5)
+		return -EOPNOTSUPP;
+
+	pr_notice("Running %s %s\n", krb5->name, test->name);
+
+	/* Load the test data into binary buffers. */
+	LOAD_BUF(&key, test->key);
+	LOAD_BUF(&plain, test->plain);
+	LOAD_BUF(&mic, test->mic);
+
+	if (VALID(mic.len != krb5->cksum_len))
+		return ret;
+
+	data_len = plain.len;
+	message_len = crypto_krb5_how_much_buffer(krb5, KRB5_CHECKSUM_MODE,
+						  data_len, &data_offset);
+
+	if (CHECK(message_len != mic.len + plain.len)) {
+		pr_warn("MIC length mismatch %zu != %u\n",
+			message_len, mic.len + plain.len);
+		goto out;
+	}
+
+	memcpy(buf + data_offset, plain.data, plain.len);
+
+	/* Allocate a crypto object and set its key. */
+	ci = crypto_alloc_aead(krb5->aead.base.cra_name, 0, 0);
+	if (IS_ERR(ci)) {
+		ret = (PTR_ERR(ci) == -ENOENT) ? -ENOPKG : PTR_ERR(ci);
+		ci = NULL;
+		pr_err("Couldn't alloc AEAD %s: %d\n", krb5->aead.base.cra_name, ret);
+		goto out;
+	}
+
+	ret = crypto_aead_setkey(ci, key.data, key.len);
+	if (ret < 0) {
+		pr_err("Couldn't set AEAD key %s: %d\n", krb5->aead.base.cra_name, ret);
+		goto out;
+	}
+
+	/* Generate an encryption request. */
+	reqsize = sizeof(*req) + crypto_aead_reqsize(ci);
+	req = kzalloc(reqsize, GFP_KERNEL);
+	if (!req)
+		goto out;
+
+	aead_request_set_tfm(req, ci);
+
+	sg_init_one(sg, buf, 1024);
+	aead_request_set_crypt(req, sg, sg, data_offset + data_len, NULL);
+
+	ret = crypto_aead_encrypt(req);
+	if (ret < 0) {
+		CHECK(1);
+		pr_warn("Get MIC failed %d\n", ret);
+		goto out;
+	}
+
+	if (memcmp(buf, mic.data, mic.len) != 0) {
+		CHECK(1);
+		pr_warn("MIC mismatch\n");
+		pr_warn("BUF %*phN\n", mic.len, buf);
+		pr_warn("MIC %*phN\n", mic.len, mic.data);
+		ret = -EKEYREJECTED;
+		goto out;
+	}
+
+	/* Generate a decryption request. */
+	memset(req, 0, reqsize);
+
+	aead_request_set_tfm(req, ci);
+
+	sg_init_one(sg, buf, message_len);
+	aead_request_set_crypt(req, sg, sg, message_len, NULL);
+
+	ret = crypto_aead_decrypt(req);
+	if (ret < 0) {
+		CHECK(1);
+		pr_warn("Verify MIC failed %d\n", ret);
+		goto out;
+	}
+
+	data_offset = 0;
+	data_len = message_len;
+	crypto_krb5_where_is_the_data(krb5, KRB5_CHECKSUM_MODE,
+				      &data_offset, &data_len);
+
+	if (CHECK(data_offset != mic.len) ||
+	    CHECK(data_len != plain.len))
+		goto out;
+
+	if (memcmp(buf + data_offset, plain.data, plain.len) != 0) {
+		CHECK(1);
+		pr_warn("Plaintext mismatch\n");
+		pr_warn("BUF %*phN\n", plain.len, buf + data_offset);
+		pr_warn("PT  %*phN\n", plain.len, plain.data);
+		ret = -EKEYREJECTED;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	clear_buf(&mic);
+	clear_buf(&plain);
+	clear_buf(&key);
+	aead_request_free(req);
+	if (ci)
+		crypto_free_aead(ci);
+	return ret;
+}
+
+int krb5_selftest(void)
+{
+	void *buf;
+	int ret = 0, i;
+
+	buf = kmalloc(4096, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pr_notice("\n");
+	pr_notice("Running selftests\n");
+
+	for (i = 0; krb5_prf_tests[i].name; i++) {
+		ret = krb5_test_one_prf(&krb5_prf_tests[i]);
+		if (ret < 0) {
+			if (ret != -EOPNOTSUPP)
+				goto out;
+			pr_notice("Skipping %s\n", krb5_prf_tests[i].name);
+		}
+	}
+
+	for (i = 0; krb5_key_tests[i].name; i++) {
+		ret = krb5_test_one_key(&krb5_key_tests[i]);
+		if (ret < 0) {
+			if (ret != -EOPNOTSUPP)
+				goto out;
+			pr_notice("Skipping %s\n", krb5_key_tests[i].name);
+		}
+	}
+
+	for (i = 0; krb5_enc_tests[i].name; i++) {
+		memset(buf, 0x5a, 4096);
+		ret = krb5_test_one_enc(&krb5_enc_tests[i], buf);
+		if (ret < 0) {
+			if (ret != -EOPNOTSUPP)
+				goto out;
+			pr_notice("Skipping %s\n", krb5_enc_tests[i].name);
+		}
+	}
+
+	for (i = 0; krb5_mic_tests[i].name; i++) {
+		memset(buf, 0x5a, 4096);
+		ret = krb5_test_one_mic(&krb5_mic_tests[i], buf);
+		if (ret < 0) {
+			if (ret != -EOPNOTSUPP)
+				goto out;
+			pr_notice("Skipping %s\n", krb5_mic_tests[i].name);
+		}
+	}
+
+	ret = 0;
+out:
+	pr_notice("Selftests %s\n", ret == 0 ? "succeeded" : "failed");
+	kfree(buf);
+	return ret;
+}
diff --git a/crypto/krb5/selftest_data.c b/crypto/krb5/selftest_data.c
new file mode 100644
index 000000000000..7c35b1d7f4a2
--- /dev/null
+++ b/crypto/krb5/selftest_data.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Data for Kerberos library self-testing
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "internal.h"
+
+/*
+ * Pseudo-random function tests.
+ */
+const struct krb5_prf_test krb5_prf_tests[] = {
+	/* rfc8009 Appendix A */
+	{
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "prf",
+		.key	= "3705D96080C17728A0E800EAB6E0D23C",
+		.octet	= "74657374",
+		.prf	= "9D188616F63852FE86915BB840B4A886FF3E6BB0F819B49B893393D393854295",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "prf",
+		.key	= "6D404D37FAF79F9DF0D33568D320669800EB4836472EA8A026D16B7182460C52",
+		.octet	= "74657374",
+		.prf	=
+		"9801F69A368C2BF675E59521E177D9A07F67EFE1CFDE8D3C8D6F6A0256E3B17D"
+		"B3C1B62AD1B8553360D17367EB1514D2",
+	},
+	{/* END */}
+};
+
+/*
+ * Key derivation tests.
+ */
+const struct krb5_key_test krb5_key_tests[] = {
+	/* rfc8009 Appendix A */
+	{
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "key",
+		.key	= "3705D96080C17728A0E800EAB6E0D23C",
+		.Kc.use	= 0x00000002,
+		.Kc.key	= "B31A018A48F54776F403E9A396325DC3",
+		.Ke.use	= 0x00000002,
+		.Ke.key	= "9B197DD1E8C5609D6E67C3E37C62C72E",
+		.Ki.use	= 0x00000002,
+		.Ki.key	= "9FDA0E56AB2D85E1569A688696C26A6C",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "key",
+		.key	= "6D404D37FAF79F9DF0D33568D320669800EB4836472EA8A026D16B7182460C52",
+		.Kc.use	= 0x00000002,
+		.Kc.key	= "EF5718BE86CC84963D8BBB5031E9F5C4BA41F28FAF69E73D",
+		.Ke.use	= 0x00000002,
+		.Ke.key	= "56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49",
+		.Ki.use	= 0x00000002,
+		.Ki.key	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
+	},
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
+	{/* END */}
+};
+
+/*
+ * Encryption tests.
+ */
+const struct krb5_enc_test krb5_enc_tests[] = {
+	/* rfc8009 Appendix A */
+	{
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc no plain",
+		.plain	= "",
+		.conf	= "7E5895EAF2672435BAD817F545A37148",
+		.key	=
+		"00000003" // KRB5_ENCRYPT_MODE_KEKI
+		"00000000" // Usage
+		"9B197DD1E8C5609D6E67C3E37C62C72E" // Ke
+		"9FDA0E56AB2D85E1569A688696C26A6C", // Ki
+		.ct	=
+		"EF85FB890BB8472F4DAB20394DCA781DAD877EDA39D50C870C0D5A0A8E48C718",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc plain<block",
+		.plain	= "000102030405",
+		.conf	= "7BCA285E2FD4130FB55B1A5C83BC5B24",
+		.key	=
+		"00000003" // KRB5_ENCRYPT_MODE_KEKI
+		"00000000" // Usage
+		"9B197DD1E8C5609D6E67C3E37C62C72E" // Ke
+		"9FDA0E56AB2D85E1569A688696C26A6C", // Ki
+		.ct	=
+		"84D7F30754ED987BAB0BF3506BEB09CFB55402CEF7E6877CE99E247E52D16ED4"
+		"421DFDF8976C",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc plain==block",
+		.plain	= "000102030405060708090A0B0C0D0E0F",
+		.conf	= "56AB21713FF62C0A1457200F6FA9948F",
+		.key	=
+		"00000003" // KRB5_ENCRYPT_MODE_KEKI
+		"00000000" // Usage
+		"9B197DD1E8C5609D6E67C3E37C62C72E" // Ke
+		"9FDA0E56AB2D85E1569A688696C26A6C", // Ki
+		.ct	=
+		"3517D640F50DDC8AD3628722B3569D2AE07493FA8263254080EA65C1008E8FC2"
+		"95FB4852E7D83E1E7C48C37EEBE6B0D3",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc plain>block",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.conf	= "A7A4E29A4728CE10664FB64E49AD3FAC",
+		.key	=
+		"00000003" // KRB5_ENCRYPT_MODE_KEKI
+		"00000000" // Usage
+		"9B197DD1E8C5609D6E67C3E37C62C72E" // Ke
+		"9FDA0E56AB2D85E1569A688696C26A6C", // Ki
+		.ct	=
+		"720F73B18D9859CD6CCB4346115CD336C70F58EDC0C4437C5573544C31C813BC"
+		"E1E6D072C186B39A413C2F92CA9B8334A287FFCBFC",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc no plain",
+		.plain	= "",
+		.conf	= "F764E9FA15C276478B2C7D0C4E5F58E4",
+		.key	=
+		"00000003" // KRB5_ENCRYPT_MODE_KEKI
+		"00000000" // Usage
+		"56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49" // Ke
+		"69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F", // Ki
+		.ct	=
+		"41F53FA5BFE7026D91FAF9BE959195A058707273A96A40F0A01960621AC61274"
+		"8B9BBFBE7EB4CE3C",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc plain<block",
+		.plain	= "000102030405",
+		.conf	= "B80D3251C1F6471494256FFE712D0B9A",
+		.key	=
+		"00000003" // KRB5_ENCRYPT_MODE_KEKI
+		"00000000" // Usage
+		"56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49" // Ke
+		"69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F", // Ki
+		.ct	=
+		"4ED7B37C2BCAC8F74F23C1CF07E62BC7B75FB3F637B9F559C7F664F69EAB7B60"
+		"92237526EA0D1F61CB20D69D10F2",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc plain==block",
+		.plain	= "000102030405060708090A0B0C0D0E0F",
+		.conf	= "53BF8A0D105265D4E276428624CE5E63",
+		.key	=
+		"00000003" // KRB5_ENCRYPT_MODE_KEKI
+		"00000000" // Usage
+		"56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49" // Ke
+		"69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F", // Ki
+		.ct	=
+		"BC47FFEC7998EB91E8115CF8D19DAC4BBBE2E163E87DD37F49BECA92027764F6"
+		"8CF51F14D798C2273F35DF574D1F932E40C4FF255B36A266",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc plain>block",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.conf	= "763E65367E864F02F55153C7E3B58AF1",
+		.key	=
+		"00000003" // KRB5_ENCRYPT_MODE_KEKI
+		"00000000" // Usage
+		"56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49" // Ke
+		"69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F", // Ki
+		.ct	=
+		"40013E2DF58E8751957D2878BCD2D6FE101CCFD556CB1EAE79DB3C3EE86429F2"
+		"B2A602AC86FEF6ECB647D6295FAE077A1FEB517508D2C16B4192E01F62",
+	},
+	/* rfc6803 sec 10 */
+	{
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "enc no plain",
+		.plain	= "",
+		.conf	= "B69822A19A6B09C0EBC8557D1F1B6C0A",
+		.key	=
+		"00000001" // KRB5_ENCRYPT_MODE
+		"00000000" // Usage
+		"1DC46A8D763F4F93742BCBA3387576C3", // K0
+		.ct	= "C466F1871069921EDB7C6FDE244A52DB0BA10EDC197BDB8006658CA3CCCE6EB8",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "enc 1 plain",
+		.plain	= "'1",
+		.conf	= "6F2FC3C2A166FD8898967A83DE9596D9",
+		.key	=
+		"00000001" // KRB5_ENCRYPT_MODE
+		"00000001" // Usage
+		"5027BC231D0F3A9D23333F1CA6FDBE7C", // K0
+		.ct	= "842D21FD950311C0DD464A3F4BE8D6DA88A56D559C9B47D3F9A85067AF661559B8",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "enc 9 plain",
+		.plain	= "'9 bytesss",
+		.conf	= "A5B4A71E077AEEF93C8763C18FDB1F10",
+		.key	=
+		"00000001" // KRB5_ENCRYPT_MODE
+		"00000002" // Usage
+		"A1BB61E805F9BA6DDE8FDBDDC05CDEA0", // K0
+		.ct	= "619FF072E36286FF0A28DEB3A352EC0D0EDF5C5160D663C901758CCF9D1ED33D71DB8F23AABF8348A0",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "enc 13 plain",
+		.plain	= "'13 bytes byte",
+		.conf	= "19FEE40D810C524B5B22F01874C693DA",
+		.key	=
+		"00000001" // KRB5_ENCRYPT_MODE
+		"00000003" // Usage
+		"2CA27A5FAF5532244506434E1CEF6676", // K0
+		.ct	= "B8ECA3167AE6315512E59F98A7C500205E5F63FF3BB389AF1C41A21D640D8615C9ED3FBEB05AB6ACB67689B5EA",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "enc 30 plain",
+		.plain	= "'30 bytes bytes bytes bytes byt",
+		.conf	= "CA7A7AB4BE192DABD603506DB19C39E2",
+		.key	=
+		"00000001" // KRB5_ENCRYPT_MODE
+		"00000004" // Usage
+		"7824F8C16F83FF354C6BF7515B973F43", // K0
+		.ct	= "A26A3905A4FFD5816B7B1E27380D08090C8EC1F304496E1ABDCD2BDCD1DFFC660989E117A713DDBB57A4146C1587CBA4356665591D2240282F5842B105A5",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "enc no plain",
+		.plain	= "",
+		.conf	= "3CBBD2B45917941067F96599BB98926C",
+		.key	=
+		"00000001" // KRB5_ENCRYPT_MODE
+		"00000000" // Usage
+		"B61C86CC4E5D2757545AD423399FB7031ECAB913CBB900BD7A3C6DD8BF92015B", // K0
+		.ct	= "03886D03310B47A6D8F06D7B94D1DD837ECCE315EF652AFF620859D94A259266",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "enc 1 plain",
+		.plain	= "'1",
+		.conf	= "DEF487FCEBE6DE6346D4DA4521BBA2D2",
+		.key	=
+		"00000001" // KRB5_ENCRYPT_MODE
+		"00000001" // Usage
+		"1B97FE0A190E2021EB30753E1B6E1E77B0754B1D684610355864104963463833", // K0
+		.ct	= "2C9C1570133C99BF6A34BC1B0212002FD194338749DB4135497A347CFCD9D18A12",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "enc 9 plain",
+		.plain	= "'9 bytesss",
+		.conf	= "AD4FF904D34E555384B14100FC465F88",
+		.key	=
+		"00000001" // KRB5_ENCRYPT_MODE
+		"00000002" // Usage
+		"32164C5B434D1D1538E4CFD9BE8040FE8C4AC7ACC4B93D3314D2133668147A05", // K0
+		.ct	=
+		"9C6DE75F812DE7ED0D28B2963557A115640998275B0AF5152709913FF52A2A9C"
+		"8E63B872F92E64C839",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "enc 13 plain",
+		.plain	= "'13 bytes byte",
+		.conf	= "CF9BCA6DF1144E0C0AF9B8F34C90D514",
+		.key	=
+		"00000001" // KRB5_ENCRYPT_MODE
+		"00000003" // Usage
+		"B038B132CD8E06612267FAB7170066D88AECCBA0B744BFC60DC89BCA182D0715", // K0
+		.ct	=
+		"EEEC85A9813CDC536772AB9B42DEFC5706F726E975DDE05A87EB5406EA324CA18"
+		"5C9986B42AABE794B84821BEE",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "enc 30 plain",
+		.plain	= "'30 bytes bytes bytes bytes byt",
+		.conf	= "644DEF38DA35007275878D216855E228",
+		.key	=
+		"00000001" // KRB5_ENCRYPT_MODE
+		"00000004" // Usage
+		"CCFCD349BF4C6677E86E4B02B8EAB924A546AC731CF9BF6989B996E7D6BFBBA7", // K0
+		.ct	=
+		"0E44680985855F2D1F1812529CA83BFD8E349DE6FD9ADA0BAAA048D68E265FEB"
+		"F34AD1255A344999AD37146887A6C6845731AC7F46376A0504CD06571474",
+	},
+	{/* END */}
+};
+
+/*
+ * Checksum generation tests.
+ */
+const struct krb5_mic_test krb5_mic_tests[] = {
+	/* rfc8009 Appendix A */
+	{
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "mic",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.key	=
+		"00000002" // KRB5_ENCRYPT_MODE_KC
+		"00000000" // Usage
+		"B31A018A48F54776F403E9A396325DC3", // Kc
+		.mic	= "D78367186643D67B411CBA9139FC1DEE",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "mic",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.key	=
+		"00000002" // KRB5_ENCRYPT_MODE_KC
+		"00000000" // Usage
+		"EF5718BE86CC84963D8BBB5031E9F5C4BA41F28FAF69E73D", // Kc
+		.mic	= "45EE791567EEFCA37F4AC1E0222DE80D43C3BFA06699672A",
+	},
+	/* rfc6803 sec 10 */
+	{
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "mic abc",
+		.plain	= "'abcdefghijk",
+		.key	=
+		"00000000" // KRB5_ENCRYPT_MODE
+		"00000007" // Usage
+		"1DC46A8D763F4F93742BCBA3387576C3", // K0
+		.mic	= "1178E6C5C47A8C1AE0C4B9C7D4EB7B6B",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.name	= "mic ABC",
+		.plain	= "'ABCDEFGHIJKLMNOPQRSTUVWXYZ",
+		.key	=
+		"00000000" // KRB5_ENCRYPT_MODE
+		"00000008" // Usage
+		"5027BC231D0F3A9D23333F1CA6FDBE7C", // K0
+		.mic	= "D1B34F7004A731F23A0C00BF6C3F753A",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "mic 123",
+		.plain	= "'123456789",
+		.key	=
+		"00000000" // KRB5_ENCRYPT_MODE
+		"00000009" // Usage
+		"B61C86CC4E5D2757545AD423399FB7031ECAB913CBB900BD7A3C6DD8BF92015B", // K0
+		.mic	= "87A12CFD2B96214810F01C826E7744B1",
+	}, {
+		.etype	= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.name	= "mic !@#",
+		.plain	= "'!@#$%^&*()!@#$%^&*()!@#$%^&*()",
+		.key	=
+		"00000000" // KRB5_ENCRYPT_MODE
+		"0000000a" // Usage
+		"32164C5B434D1D1538E4CFD9BE8040FE8C4AC7ACC4B93D3314D2133668147A05", // K0
+		.mic	= "3FA0B42355E52B189187294AA252AB64",
+	},
+	{/* END */}
+};
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index 05e80fad2b38..359aba2076de 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -8,8 +8,12 @@
 #ifndef _CRYPTO_KRB5_H
 #define _CRYPTO_KRB5_H
 
-/* per Kerberos v5 protocol spec crypto types from the wire.
- * these get mapped to linux kernel crypto routines.
+#include <linux/crypto.h>
+#include <crypto/aead.h>
+
+/*
+ * Per Kerberos v5 protocol spec crypto types from the wire.  These get mapped
+ * to linux kernel crypto routines.
  */
 #define KRB5_ENCTYPE_NULL			0x0000
 #define KRB5_ENCTYPE_DES_CBC_CRC		0x0001	/* DES cbc mode with CRC-32 */
@@ -23,8 +27,12 @@
 #define KRB5_ENCTYPE_DES3_CBC_SHA1		0x0010
 #define KRB5_ENCTYPE_AES128_CTS_HMAC_SHA1_96	0x0011
 #define KRB5_ENCTYPE_AES256_CTS_HMAC_SHA1_96	0x0012
+#define KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128	0x0013
+#define KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192	0x0014
 #define KRB5_ENCTYPE_ARCFOUR_HMAC		0x0017
 #define KRB5_ENCTYPE_ARCFOUR_HMAC_EXP		0x0018
+#define KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC	0x0019
+#define KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC	0x001a
 #define KRB5_ENCTYPE_UNKNOWN			0x01ff
 
 #define KRB5_CKSUMTYPE_CRC32			0x0001
@@ -37,6 +45,10 @@
 #define KRB5_CKSUMTYPE_HMAC_SHA1_DES3		0x000c
 #define KRB5_CKSUMTYPE_HMAC_SHA1_96_AES128	0x000f
 #define KRB5_CKSUMTYPE_HMAC_SHA1_96_AES256	0x0010
+#define KRB5_CKSUMTYPE_CMAC_CAMELLIA128		0x0011
+#define KRB5_CKSUMTYPE_CMAC_CAMELLIA256		0x0012
+#define KRB5_CKSUMTYPE_HMAC_SHA256_128_AES128	0x0013
+#define KRB5_CKSUMTYPE_HMAC_SHA384_192_AES256	0x0014
 #define KRB5_CKSUMTYPE_HMAC_MD5_ARCFOUR		-138 /* Microsoft md5 hmac cksumtype */
 
 /*
@@ -47,4 +59,89 @@
 #define KEY_USAGE_SEED_ENCRYPTION       (0xAA)
 #define KEY_USAGE_SEED_INTEGRITY        (0x55)
 
+/*
+ * Mode of operation.
+ */
+enum krb5_crypto_mode {
+	KRB5_CHECKSUM_MODE,	/* Checksum only */
+	KRB5_ENCRYPT_MODE,	/* Fully encrypted, possibly with integrity checksum */
+	KRB5_CHECKSUM_MODE_KC,	/* Checksum only, keys Kc supplied directly */
+	KRB5_ENCRYPT_MODE_KEKI,	/* Fully encrypted, keys Ke and Ki supplied directly */
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
+	struct aead_alg	aead;		/* AEAD API */
+	int		etype;		/* Encryption (key) type */
+	int		ctype;		/* Checksum type */
+	const char	*name;		/* "Friendly" name */
+	const char	*encrypt_name;	/* Crypto encrypt name */
+	const char	*cksum_name;	/* Crypto checksum name */
+	const char	*hash_name;	/* Crypto hash name */
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
+/**
+ * crypto_krb5_enctype - Find the encoding type definition from the algorithm
+ * @tfm: The algorithm to query
+ */
+static inline struct krb5_enctype *crypto_krb5_enctype(const struct crypto_aead *tfm)
+{
+	struct aead_alg *alg = crypto_aead_alg((struct crypto_aead *)tfm);
+
+	return container_of(alg, struct krb5_enctype, aead);
+}
+
+/*
+ * krb5_aead.c
+ */
+const struct krb5_enctype *crypto_krb5_find_enctype(u32 enctype);
+
+size_t crypto_krb5_how_much_buffer(const struct krb5_enctype *krb5,
+				   enum krb5_crypto_mode mode,
+				   size_t data_size, size_t *_offset);
+size_t crypto_krb5_how_much_data(const struct krb5_enctype *krb5,
+				 enum krb5_crypto_mode mode,
+				 size_t *_buffer_size, size_t *_offset);
+void crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
+				   enum krb5_crypto_mode mode,
+				   size_t *_offset, size_t *_len);
+int crypto_krb5_confound_buffer(const struct krb5_enctype *krb5,
+				struct scatterlist *sg, unsigned int nr_sg,
+				const u8 *confounder, size_t conf_len,
+				size_t msg_offset);
+
+/*
+ * kdf.c
+ */
+int crypto_krb5_calc_PRFplus(const struct krb5_enctype *krb5,
+			     const struct krb5_buffer *K,
+			     unsigned int L,
+			     const struct krb5_buffer *S,
+			     struct krb5_buffer *result,
+			     gfp_t gfp);
+
 #endif /* _CRYPTO_KRB5_H */


