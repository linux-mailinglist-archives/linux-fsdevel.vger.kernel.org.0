Return-Path: <linux-fsdevel+bounces-39535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0927A15736
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6F2188AE6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522761E1043;
	Fri, 17 Jan 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csLGFbuM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820FC1AAA1A
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139054; cv=none; b=PH7UJx3kmuW2ev296oL3rsn1Ju3yI2PIc+Bd2vp2VgCmejYbD32MHc7BJ+gM/6/u9aCSRPO1X11+7ISDgpRL7epPVUJeX3MktP8/86oglrTtN9laB4LxSUji+bqkSa8gkprfi+J0kbkcw/mQyMDFF6X2UnNwOHeUEYKvvcolqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139054; c=relaxed/simple;
	bh=LITk9LPw4m4VLgdKsWzyzVhoNmTiwZTRZ1R8wHA4T7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poYrM2uLi4Z0PdwDBuk6Gcl4liqrh4Jg+eiuRV+ehF0S89oOSdz/rg0yynxcfAJWncmMwaDuQgGM68pN+WzcODdT48NLAS0LBEK6LY84Hy/9efdhRG82BcOdOXKPjsJakZmp5HvL9vaz30DVRfpXYrmPQu31Q4HXoB7UJKdjn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csLGFbuM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zX5bZH8REttuLpjpAizvDpS2sSPaYXZ15PwOCJUl/E=;
	b=csLGFbuMVtLEsWdguFUDEsxTogEscwOwv+CW0M6+hZxHXRl7OTPGe6OuC4PRKrg43ttR4b
	buvaTwbj0sBXOTPN1U+wX7KLtBlSVgZ0e99oWepllQ/e0WRenTOebWBZaPxsZHDslqaVln
	YyhU98plqLt7srZju/Jb85+0yBHaOSo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-Ojt9I7b9ORWCT1sH6cY2SQ-1; Fri,
 17 Jan 2025 13:37:29 -0500
X-MC-Unique: Ojt9I7b9ORWCT1sH6cY2SQ-1
X-Mimecast-MFC-AGG-ID: Ojt9I7b9ORWCT1sH6cY2SQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1B1A19560BA;
	Fri, 17 Jan 2025 18:37:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63BAD1955F22;
	Fri, 17 Jan 2025 18:37:22 +0000 (UTC)
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
Subject: [RFC PATCH 17/24] crypto/krb5: Implement crypto self-testing
Date: Fri, 17 Jan 2025 18:35:26 +0000
Message-ID: <20250117183538.881618-18-dhowells@redhat.com>
In-Reply-To: <20250117183538.881618-1-dhowells@redhat.com>
References: <20250117183538.881618-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Implement self-testing infrastructure to test the pseudo-random function,
key derivation, encryption and checksumming.

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
 crypto/krb5/Kconfig         |   7 +
 crypto/krb5/Makefile        |   4 +
 crypto/krb5/internal.h      |  48 ++++
 crypto/krb5/krb5_api.c      |  11 +
 crypto/krb5/selftest.c      | 544 ++++++++++++++++++++++++++++++++++++
 crypto/krb5/selftest_data.c |  38 +++
 6 files changed, 652 insertions(+)
 create mode 100644 crypto/krb5/selftest.c
 create mode 100644 crypto/krb5/selftest_data.c

diff --git a/crypto/krb5/Kconfig b/crypto/krb5/Kconfig
index 52f0ed2d7820..82d7e3b55878 100644
--- a/crypto/krb5/Kconfig
+++ b/crypto/krb5/Kconfig
@@ -15,3 +15,10 @@ config CRYPTO_KRB5
 	help
 	  Provide a library for provision of Kerberos-5-based crypto.  This is
 	  intended for network filesystems to use.
+
+config CRYPTO_KRB5_SELFTESTS
+	bool "Kerberos 5 crypto selftests"
+	depends on CRYPTO_KRB5
+	help
+	  Turn on some self-testing for the kerberos 5 crypto functions.  These
+	  will be performed on module load or boot, if compiled in.
diff --git a/crypto/krb5/Makefile b/crypto/krb5/Makefile
index 7fd215ec3a85..1ad327227744 100644
--- a/crypto/krb5/Makefile
+++ b/crypto/krb5/Makefile
@@ -10,4 +10,8 @@ krb5-y += \
 	rfc3962_aes.o \
 	rfc8009_aes2.o
 
+krb5-$(CONFIG_CRYPTO_KRB5_SELFTESTS) += \
+	selftest.o \
+	selftest_data.o
+
 obj-$(CONFIG_CRYPTO_KRB5) += krb5.o
diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index 81bf38cf12fc..a40f120b4954 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -114,6 +114,37 @@ struct krb5_crypto_profile {
 	crypto_roundup(crypto_shash_digestsize(TFM))
 #define round16(x) (((x) + 15) & ~15)
 
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
+	u32 usage;
+	const char *name, *plain, *conf, *K0, *Ke, *Ki, *ct;
+};
+
+struct krb5_mic_test {
+	u32 etype;
+	u32 usage;
+	const char *name, *plain, *K0, *Kc, *mic;
+};
+
 /*
  * krb5_api.c
  */
@@ -201,3 +232,20 @@ int authenc_load_encrypt_keys(const struct krb5_enctype *krb5,
 			      const struct krb5_buffer *Ki,
 			      struct krb5_buffer *setkey,
 			      gfp_t gfp);
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
diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index 5b94cc5db461..8c2949ac9c07 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -437,3 +437,14 @@ int crypto_krb5_verify_mic(const struct krb5_enctype *krb5,
 					 _offset, _len);
 }
 EXPORT_SYMBOL(crypto_krb5_verify_mic);
+
+static int __init crypto_krb5_init(void)
+{
+	return krb5_selftest();
+}
+module_init(crypto_krb5_init);
+
+static void __exit crypto_krb5_exit(void)
+{
+}
+module_exit(crypto_krb5_exit);
diff --git a/crypto/krb5/selftest.c b/crypto/krb5/selftest.c
new file mode 100644
index 000000000000..2a81a6315a0d
--- /dev/null
+++ b/crypto/krb5/selftest.c
@@ -0,0 +1,544 @@
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
+#if 0
+static void dump_sg(struct scatterlist *sg, unsigned int limit)
+{
+	unsigned int index = 0, n = 0;
+
+	for (; sg && limit > 0; sg = sg_next(sg)) {
+		unsigned int off = sg->offset, len = umin(sg->length, limit);
+		const void *p = kmap_local_page(sg_page(sg));
+
+		limit -= len;
+		while (len > 0) {
+			unsigned int part = umin(len, 32);
+
+			pr_notice("[%x] %04x: %*phN\n", n, index, part, p + off);
+			index += part;
+			off += part;
+			len -= part;
+		}
+
+		kunmap_local(p);
+		n++;
+	}
+}
+#endif
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
+	struct crypto_aead *ci = NULL;
+	struct krb5_buffer K0 = {}, Ke = {}, Ki = {}, keys = {};
+	struct krb5_buffer conf = {}, plain = {}, ct = {};
+	struct scatterlist sg[1];
+	size_t data_len, data_offset, message_len;
+	int ret;
+
+	if (!krb5)
+		return -EOPNOTSUPP;
+
+	pr_notice("Running %s %s\n", krb5->name, test->name);
+
+	/* Load the test data into binary buffers. */
+	LOAD_BUF(&conf, test->conf);
+	LOAD_BUF(&plain, test->plain);
+	LOAD_BUF(&ct, test->ct);
+
+	if (test->K0) {
+		LOAD_BUF(&K0, test->K0);
+	} else {
+		LOAD_BUF(&Ke, test->Ke);
+		LOAD_BUF(&Ki, test->Ki);
+
+		ret = krb5->profile->load_encrypt_keys(krb5, &Ke, &Ki, &keys, GFP_KERNEL);
+		if (ret < 0)
+			goto out;
+	}
+
+	if (VALID(conf.len != krb5->conf_len) ||
+	    VALID(ct.len != krb5->conf_len + plain.len + krb5->cksum_len))
+		goto out;
+
+	data_len = plain.len;
+	message_len = crypto_krb5_how_much_buffer(krb5, KRB5_ENCRYPT_MODE,
+						  data_len, &data_offset);
+
+	if (CHECK(message_len != ct.len)) {
+		pr_warn("Encrypted length mismatch %zu != %u\n", message_len, ct.len);
+		goto out;
+	}
+	if (CHECK(data_offset != conf.len)) {
+		pr_warn("Data offset mismatch %zu != %u\n", data_offset, conf.len);
+		goto out;
+	}
+
+	memcpy(buf, conf.data, conf.len);
+	memcpy(buf + data_offset, plain.data, plain.len);
+
+	/* Allocate a crypto object and set its key. */
+	if (test->K0)
+		ci = crypto_krb5_prepare_encryption(krb5, &K0, test->usage, GFP_KERNEL);
+	else
+		ci = krb5_prepare_encryption(krb5, &keys, GFP_KERNEL);
+
+	if (IS_ERR(ci)) {
+		ret = PTR_ERR(ci);
+		ci = NULL;
+		pr_err("Couldn't alloc AEAD %s: %d\n", krb5->encrypt_name, ret);
+		goto out;
+	}
+
+	/* Encrypt the message. */
+	sg_init_one(sg, buf, message_len);
+	ret = crypto_krb5_encrypt(krb5, ci, sg, 1, message_len,
+				  data_offset, data_len, true);
+	if (ret < 0) {
+		CHECK(1);
+		pr_warn("Encryption failed %d\n", ret);
+		goto out;
+	}
+	if (ret != message_len) {
+		CHECK(1);
+		pr_warn("Encrypted message wrong size %x != %zx\n", ret, message_len);
+		goto out;
+	}
+
+	if (memcmp(buf, ct.data, ct.len) != 0) {
+		CHECK(1);
+		pr_warn("Ciphertext mismatch\n");
+		pr_warn("BUF %*phN\n", ct.len, buf);
+		pr_warn("CT  %*phN\n", ct.len, ct.data);
+		pr_warn("PT  %*phN%*phN\n", conf.len, conf.data, plain.len, plain.data);
+		ret = -EKEYREJECTED;
+		goto out;
+	}
+
+	/* Decrypt the encrypted message. */
+	data_offset = 0;
+	data_len = message_len;
+	ret = crypto_krb5_decrypt(krb5, ci, sg, 1, &data_offset, &data_len);
+	if (ret < 0) {
+		CHECK(1);
+		pr_warn("Decryption failed %d\n", ret);
+		goto out;
+	}
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
+	clear_buf(&keys);
+	clear_buf(&Ki);
+	clear_buf(&Ke);
+	clear_buf(&K0);
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
+	struct crypto_shash *ci = NULL;
+	struct scatterlist sg[1];
+	struct krb5_buffer K0 = {}, Kc = {}, keys = {}, plain = {}, mic = {};
+	size_t offset, len, message_len;
+	int ret;
+
+	if (!krb5)
+		return -EOPNOTSUPP;
+
+	pr_notice("Running %s %s\n", krb5->name, test->name);
+
+	/* Allocate a crypto object and set its key. */
+	if (test->K0) {
+		LOAD_BUF(&K0, test->K0);
+		ci = crypto_krb5_prepare_checksum(krb5, &K0, test->usage, GFP_KERNEL);
+	} else {
+		LOAD_BUF(&Kc, test->Kc);
+
+		ret = krb5->profile->load_checksum_key(krb5, &Kc, &keys, GFP_KERNEL);
+		if (ret < 0)
+			goto out;
+
+		ci = krb5_prepare_checksum(krb5, &Kc, GFP_KERNEL);
+	}
+	if (IS_ERR(ci)) {
+		ret = PTR_ERR(ci);
+		ci = NULL;
+		pr_err("Couldn't alloc shash %s: %d\n", krb5->cksum_name, ret);
+		goto out;
+	}
+
+	/* Load the test data into binary buffers. */
+	LOAD_BUF(&plain, test->plain);
+	LOAD_BUF(&mic, test->mic);
+
+	len = plain.len;
+	message_len = crypto_krb5_how_much_buffer(krb5, KRB5_CHECKSUM_MODE,
+						  len, &offset);
+
+	if (CHECK(message_len != mic.len + plain.len)) {
+		pr_warn("MIC length mismatch %zu != %u\n",
+			message_len, mic.len + plain.len);
+		goto out;
+	}
+
+	memcpy(buf + offset, plain.data, plain.len);
+
+	/* Generate a MIC generation request. */
+	sg_init_one(sg, buf, 1024);
+
+	ret = crypto_krb5_get_mic(krb5, ci, NULL, sg, 1, 1024,
+				  krb5->cksum_len, plain.len);
+	if (ret < 0) {
+		CHECK(1);
+		pr_warn("Get MIC failed %d\n", ret);
+		goto out;
+	}
+	len = ret;
+
+	if (CHECK(len != plain.len + mic.len)) {
+		pr_warn("MIC length mismatch %zu != %u\n", len, plain.len + mic.len);
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
+	/* Generate a verification request. */
+	offset = 0;
+	ret = crypto_krb5_verify_mic(krb5, ci, NULL, sg, 1, &offset, &len);
+	if (ret < 0) {
+		CHECK(1);
+		pr_warn("Verify MIC failed %d\n", ret);
+		goto out;
+	}
+
+	if (CHECK(offset != mic.len) ||
+	    CHECK(len != plain.len))
+		goto out;
+
+	if (memcmp(buf + offset, plain.data, plain.len) != 0) {
+		CHECK(1);
+		pr_warn("Plaintext mismatch\n");
+		pr_warn("BUF %*phN\n", plain.len, buf + offset);
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
+	clear_buf(&keys);
+	clear_buf(&K0);
+	clear_buf(&Kc);
+	if (ci)
+		crypto_free_shash(ci);
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
index 000000000000..bef5b8b342ae
--- /dev/null
+++ b/crypto/krb5/selftest_data.c
@@ -0,0 +1,38 @@
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
+	{/* END */}
+};
+
+/*
+ * Key derivation tests.
+ */
+const struct krb5_key_test krb5_key_tests[] = {
+	{/* END */}
+};
+
+/*
+ * Encryption tests.
+ */
+const struct krb5_enc_test krb5_enc_tests[] = {
+	{/* END */}
+};
+
+/*
+ * Checksum generation tests.
+ */
+const struct krb5_mic_test krb5_mic_tests[] = {
+	{/* END */}
+};


