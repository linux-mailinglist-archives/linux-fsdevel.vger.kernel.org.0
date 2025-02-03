Return-Path: <linux-fsdevel+bounces-40610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0945EA25CA4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2275B166479
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806FA208995;
	Mon,  3 Feb 2025 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQG6+F8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2720E030
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592745; cv=none; b=JTCu4gJtkW209BWt9JGaUEyeQkdH0+SKBPmPNzMwmBY0VFnXWdXOgn/WEVZ+IjQ1eCyXRkSRXOp0XCtDkb7gL1n6Wi6DhVEgW57YorIBFtQzj+L59G+6UJhT8dEbRoT/EFjbivBkierLJymy3I2QM7blmdoktq7i12obYWwigoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592745; c=relaxed/simple;
	bh=3a6eQwdUV1M2ekxy0Jpnj2KxKkCtY+J7Dx2AR1djhIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBJ7bZOt/4rTWEVZEGWpl3sLr/Mvw6os2Wudmh4BeUdxgqIvhuVDiyq/LUGVRtvWCi8qNZg4ZesKxzd4Hk4Dqkibc9FZlQ9gsywNxDvqzgZJLsQPS7gI+5QRNL+JYT01nJPO3sVSIrzU3ggTq8z9jXrfSBfb03hR1T82e/Aaukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQG6+F8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPmxKIbcYUP5lCdeHponl13TBBB6tlvh7yvXa25xTeI=;
	b=TQG6+F8B++BDX24ceNTfluFRFhbdxzzKT/ihyp8whsqYx0mbpKn/bpgVZ1K7y20SAT+COM
	ubLut/TQ/vcGb2cdiNq/BscFtcaQEdE+CImX03c9FWPhVM0Lk04wq04SjpWE1wyA4JNCuR
	O2JiO5JYiWuBeB1O/RCAZK6+r9KPDig=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-jdnZKotENXO8gl6xvjB7Ag-1; Mon,
 03 Feb 2025 09:25:39 -0500
X-MC-Unique: jdnZKotENXO8gl6xvjB7Ag-1
X-Mimecast-MFC-AGG-ID: jdnZKotENXO8gl6xvjB7Ag
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01DCD1956051;
	Mon,  3 Feb 2025 14:25:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7185B30001BE;
	Mon,  3 Feb 2025 14:25:32 +0000 (UTC)
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
Subject: [PATCH net 17/24] crypto/krb5: Implement crypto self-testing
Date: Mon,  3 Feb 2025 14:23:33 +0000
Message-ID: <20250203142343.248839-18-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Implement self-testing infrastructure to test the pseudo-random function,
key derivation, encryption and checksumming.

Add the testing data from rfc8009 to test AES + HMAC-SHA2.

Add the testing data from rfc6803 to test Camellia.  Note some encryption
test vectors here are incomplete, lacking the key usage number needed to
derive Ke and Ki, and there are errata for this:

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
 crypto/krb5/Kconfig         |   7 +
 crypto/krb5/Makefile        |   4 +
 crypto/krb5/internal.h      |  48 ++++
 crypto/krb5/krb5_api.c      |  11 +
 crypto/krb5/selftest.c      | 544 ++++++++++++++++++++++++++++++++++++
 crypto/krb5/selftest_data.c | 291 +++++++++++++++++++
 6 files changed, 905 insertions(+)
 create mode 100644 crypto/krb5/selftest.c
 create mode 100644 crypto/krb5/selftest_data.c

diff --git a/crypto/krb5/Kconfig b/crypto/krb5/Kconfig
index 5b339690905c..4d0476e13f3c 100644
--- a/crypto/krb5/Kconfig
+++ b/crypto/krb5/Kconfig
@@ -17,3 +17,10 @@ config CRYPTO_KRB5
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
index 7cbe5e5ded19..d38890c0b247 100644
--- a/crypto/krb5/Makefile
+++ b/crypto/krb5/Makefile
@@ -11,4 +11,8 @@ krb5-y += \
 	rfc6803_camellia.o \
 	rfc8009_aes2.o
 
+krb5-$(CONFIG_CRYPTO_KRB5_SELFTESTS) += \
+	selftest.o \
+	selftest_data.o
+
 obj-$(CONFIG_CRYPTO_KRB5) += krb5.o
diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index 8679140ef90d..a59084ffafe8 100644
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
@@ -197,3 +228,20 @@ extern const struct krb5_enctype krb5_camellia256_cts_cmac;
  */
 extern const struct krb5_enctype krb5_aes128_cts_hmac_sha256_128;
 extern const struct krb5_enctype krb5_aes256_cts_hmac_sha384_192;
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
index 02e21c8f4d14..23026d4206c8 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -439,3 +439,14 @@ int crypto_krb5_verify_mic(const struct krb5_enctype *krb5,
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
index 000000000000..24447ee8bf07
--- /dev/null
+++ b/crypto/krb5/selftest_data.c
@@ -0,0 +1,291 @@
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
+		.Ke	= "9B197DD1E8C5609D6E67C3E37C62C72E",
+		.Ki	= "9FDA0E56AB2D85E1569A688696C26A6C",
+		.ct	= "EF85FB890BB8472F4DAB20394DCA781DAD877EDA39D50C870C0D5A0A8E48C718",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc plain<block",
+		.plain	= "000102030405",
+		.conf	= "7BCA285E2FD4130FB55B1A5C83BC5B24",
+		.Ke	= "9B197DD1E8C5609D6E67C3E37C62C72E",
+		.Ki	= "9FDA0E56AB2D85E1569A688696C26A6C",
+		.ct	= "84D7F30754ED987BAB0BF3506BEB09CFB55402CEF7E6877CE99E247E52D16ED4421DFDF8976C",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc plain==block",
+		.plain	= "000102030405060708090A0B0C0D0E0F",
+		.conf	= "56AB21713FF62C0A1457200F6FA9948F",
+		.Ke	= "9B197DD1E8C5609D6E67C3E37C62C72E",
+		.Ki	= "9FDA0E56AB2D85E1569A688696C26A6C",
+		.ct	= "3517D640F50DDC8AD3628722B3569D2AE07493FA8263254080EA65C1008E8FC295FB4852E7D83E1E7C48C37EEBE6B0D3",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc plain>block",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.conf	= "A7A4E29A4728CE10664FB64E49AD3FAC",
+		.Ke	= "9B197DD1E8C5609D6E67C3E37C62C72E",
+		.Ki	= "9FDA0E56AB2D85E1569A688696C26A6C",
+		.ct	= "720F73B18D9859CD6CCB4346115CD336C70F58EDC0C4437C5573544C31C813BCE1E6D072C186B39A413C2F92CA9B8334A287FFCBFC",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc no plain",
+		.plain	= "",
+		.conf	= "F764E9FA15C276478B2C7D0C4E5F58E4",
+		.Ke	= "56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49",
+		.Ki	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
+		.ct	= "41F53FA5BFE7026D91FAF9BE959195A058707273A96A40F0A01960621AC612748B9BBFBE7EB4CE3C",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc plain<block",
+		.plain	= "000102030405",
+		.conf	= "B80D3251C1F6471494256FFE712D0B9A",
+		.Ke	= "56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49",
+		.Ki	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
+		.ct	= "4ED7B37C2BCAC8F74F23C1CF07E62BC7B75FB3F637B9F559C7F664F69EAB7B6092237526EA0D1F61CB20D69D10F2",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc plain==block",
+		.plain	= "000102030405060708090A0B0C0D0E0F",
+		.conf	= "53BF8A0D105265D4E276428624CE5E63",
+		.Ke	= "56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49",
+		.Ki	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
+		.ct	= "BC47FFEC7998EB91E8115CF8D19DAC4BBBE2E163E87DD37F49BECA92027764F68CF51F14D798C2273F35DF574D1F932E40C4FF255B36A266",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc plain>block",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.conf	= "763E65367E864F02F55153C7E3B58AF1",
+		.Ke	= "56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49",
+		.Ki	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
+		.ct	= "40013E2DF58E8751957D2878BCD2D6FE101CCFD556CB1EAE79DB3C3EE86429F2B2A602AC86FEF6ECB647D6295FAE077A1FEB517508D2C16B4192E01F62",
+	},
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
+		.Kc	= "B31A018A48F54776F403E9A396325DC3",
+		.mic	= "D78367186643D67B411CBA9139FC1DEE",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "mic",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.Kc	= "EF5718BE86CC84963D8BBB5031E9F5C4BA41F28FAF69E73D",
+		.mic	= "45EE791567EEFCA37F4AC1E0222DE80D43C3BFA06699672A",
+	},
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
+	{/* END */}
+};


