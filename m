Return-Path: <linux-fsdevel+bounces-40605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDD5A25C81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B82165B69
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265820C476;
	Mon,  3 Feb 2025 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbxQsexH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8A20C472
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592717; cv=none; b=tyBvdBXzw4ntX0KVa+u6hiBM3Uja/uyd4DzCtrtlFYrCHaagMjVx3djxcGhFlzAsimZxy94ng0X6bv8cdNsNwnmw3KTgii5eG6JkLAsdv6kAS8V0y5N1jvKFQTgJO7bpvyI/WVfdHnt7teHmiVMkS1XcT6mpAZfimwkJ+P1nS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592717; c=relaxed/simple;
	bh=YMPYI0U/T8zZTyy8tIM0AfnCzKVTG18+TfgeuyInGaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awUhe2w5B/udoJaq47EOezDhf2g7O6x7OH0zUscw60WWHXD7lUo4DXtALgWHIsH3MaaWykkxOBT2v98y3PwpSeYZu821MM+0SftB5VXJTRjJwqOcl4yMQT+VE2qtU31ZjxQnRQKCuk768PL5pxHbR/tsz0Ctyh+tTQuO05ddUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbxQsexH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owl9k2sZF1YUWZcF1nZxtMegqmOBO7S87ikvrlKpyXw=;
	b=IbxQsexHD4b2/sV0dQtmigIf7g5M+inUJQMkMoz5hveaSovgjuGuLuNNwKVf83DEcZZ1bM
	c7Q3S9Xnr/fL0UC1YxXUUjp0jzYDmj8hpf5D1tBoBIWYNircuevZTKPQwg9Oz4kCjUERqN
	UmsoLVzYkKzKEFQH256RMpYNQbj6stI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-NbxOoexoNEGiJkWDpY_4yw-1; Mon,
 03 Feb 2025 09:25:09 -0500
X-MC-Unique: NbxOoexoNEGiJkWDpY_4yw-1
X-Mimecast-MFC-AGG-ID: NbxOoexoNEGiJkWDpY_4yw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 947711801F1F;
	Mon,  3 Feb 2025 14:25:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D68D1956094;
	Mon,  3 Feb 2025 14:25:03 +0000 (UTC)
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
Subject: [PATCH net 12/24] crypto/krb5: Implement the Kerberos5 rfc3961 encrypt and decrypt functions
Date: Mon,  3 Feb 2025 14:23:28 +0000
Message-ID: <20250203142343.248839-13-dhowells@redhat.com>
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

Add functions that encrypt and decrypt a message according to rfc3961 sec
5.3, using Ki to checksum the data to be secured and Ke to encrypt it
during the encryption phase, then decrypting with Ke and verifying the
checksum with Ki in the decryption phase.

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
 crypto/krb5/internal.h           |  13 +++
 crypto/krb5/rfc3961_simplified.c | 146 +++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index ae00588619a8..c8deb112b604 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -7,6 +7,8 @@
 
 #include <linux/scatterlist.h>
 #include <crypto/krb5.h>
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
 
 /*
  * Profile used for key derivation and encryption.
@@ -137,6 +139,8 @@ int krb5_derive_Ki(const struct krb5_enctype *krb5, const struct krb5_buffer *TK
  */
 extern const struct krb5_crypto_profile rfc3961_simplified_profile;
 
+int crypto_shash_update_sg(struct shash_desc *desc, struct scatterlist *sg,
+			   size_t offset, size_t len);
 int authenc_derive_encrypt_keys(const struct krb5_enctype *krb5,
 				const struct krb5_buffer *TK,
 				unsigned int usage,
@@ -156,3 +160,12 @@ int rfc3961_load_checksum_key(const struct krb5_enctype *krb5,
 			      const struct krb5_buffer *Kc,
 			      struct krb5_buffer *setkey,
 			      gfp_t gfp);
+ssize_t krb5_aead_encrypt(const struct krb5_enctype *krb5,
+			  struct crypto_aead *aead,
+			  struct scatterlist *sg, unsigned int nr_sg, size_t sg_len,
+			  size_t data_offset, size_t data_len,
+			  bool preconfounded);
+int krb5_aead_decrypt(const struct krb5_enctype *krb5,
+		      struct crypto_aead *aead,
+		      struct scatterlist *sg, unsigned int nr_sg,
+		      size_t *_offset, size_t *_len);
diff --git a/crypto/krb5/rfc3961_simplified.c b/crypto/krb5/rfc3961_simplified.c
index 335c5bb6904f..58323ce5838a 100644
--- a/crypto/krb5/rfc3961_simplified.c
+++ b/crypto/krb5/rfc3961_simplified.c
@@ -66,7 +66,10 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/random.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
+#include <linux/highmem.h>
 #include <linux/lcm.h>
 #include <linux/rtnetlink.h>
 #include <crypto/authenc.h>
@@ -77,6 +80,31 @@
 /* Maximum blocksize for the supported crypto algorithms */
 #define KRB5_MAX_BLOCKSIZE  (16)
 
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
 static int rfc3961_do_encrypt(struct crypto_sync_skcipher *tfm, void *iv,
 			      const struct krb5_buffer *in, struct krb5_buffer *out)
 {
@@ -509,6 +537,122 @@ int rfc3961_load_checksum_key(const struct krb5_enctype *krb5,
 		return -ENOMEM;
 	return 0;
 }
+
+/*
+ * Apply encryption and checksumming functions to part of a scatterlist.
+ */
+ssize_t krb5_aead_encrypt(const struct krb5_enctype *krb5,
+			  struct crypto_aead *aead,
+			  struct scatterlist *sg, unsigned int nr_sg, size_t sg_len,
+			  size_t data_offset, size_t data_len,
+			  bool preconfounded)
+{
+	struct aead_request *req;
+	ssize_t ret, done;
+	size_t bsize, base_len, secure_offset, secure_len, pad_len, cksum_offset;
+	void *buffer;
+	u8 *iv;
+
+	if (WARN_ON(data_offset != krb5->conf_len))
+		return -EINVAL; /* Data is in wrong place */
+
+	secure_offset	= 0;
+	base_len	= krb5->conf_len + data_len;
+	pad_len		= 0;
+	secure_len	= base_len + pad_len;
+	cksum_offset	= secure_len;
+	if (WARN_ON(cksum_offset + krb5->cksum_len > sg_len))
+		return -EFAULT;
+
+	bsize = krb5_aead_size(aead) +
+		krb5_aead_ivsize(aead);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	/* Insert the confounder into the buffer */
+	ret = -EFAULT;
+	if (!preconfounded) {
+		get_random_bytes(buffer, krb5->conf_len);
+		done = sg_pcopy_from_buffer(sg, nr_sg, buffer, krb5->conf_len,
+					    secure_offset);
+		if (done != krb5->conf_len)
+			goto error;
+	}
+
+	/* We may need to pad out to the crypto blocksize. */
+	if (pad_len) {
+		done = sg_zero_buffer(sg, nr_sg, pad_len, data_offset + data_len);
+		if (done != pad_len)
+			goto error;
+	}
+
+	/* Hash and encrypt the message. */
+	req = buffer;
+	iv = buffer + krb5_aead_size(aead);
+
+	aead_request_set_tfm(req, aead);
+	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_crypt(req, sg, sg, secure_len, iv);
+	ret = crypto_aead_encrypt(req);
+	if (ret < 0)
+		goto error;
+
+	ret = secure_len + krb5->cksum_len;
+
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
+/*
+ * Apply decryption and checksumming functions to a message.  The offset and
+ * length are updated to reflect the actual content of the encrypted region.
+ */
+int krb5_aead_decrypt(const struct krb5_enctype *krb5,
+		      struct crypto_aead *aead,
+		      struct scatterlist *sg, unsigned int nr_sg,
+		      size_t *_offset, size_t *_len)
+{
+	struct aead_request *req;
+	size_t bsize;
+	void *buffer;
+	int ret;
+	u8 *iv;
+
+	if (WARN_ON(*_offset != 0))
+		return -EINVAL; /* Can't set offset on aead */
+
+	if (*_len < krb5->conf_len + krb5->cksum_len)
+		return -EPROTO;
+
+	bsize = krb5_aead_size(aead) +
+		krb5_aead_ivsize(aead);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	/* Decrypt the message and verify its checksum. */
+	req = buffer;
+	iv = buffer + krb5_aead_size(aead);
+
+	aead_request_set_tfm(req, aead);
+	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_crypt(req, sg, sg, *_len, iv);
+	ret = crypto_aead_decrypt(req);
+	if (ret < 0)
+		goto error;
+
+	/* Adjust the boundaries of the data. */
+	*_offset += krb5->conf_len;
+	*_len -= krb5->conf_len + krb5->cksum_len;
+	ret = 0;
+
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
 const struct krb5_crypto_profile rfc3961_simplified_profile = {
 	.calc_PRF		= rfc3961_calc_PRF,
 	.calc_Kc		= rfc3961_calc_DK,
@@ -518,4 +662,6 @@ const struct krb5_crypto_profile rfc3961_simplified_profile = {
 	.load_encrypt_keys	= authenc_load_encrypt_keys,
 	.derive_checksum_key	= rfc3961_derive_checksum_key,
 	.load_checksum_key	= rfc3961_load_checksum_key,
+	.encrypt		= krb5_aead_encrypt,
+	.decrypt		= krb5_aead_decrypt,
 };


