Return-Path: <linux-fsdevel+bounces-39534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF9A15730
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84ED3AAD78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25B91E04BE;
	Fri, 17 Jan 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJc/Z8iY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A71A9B24
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139047; cv=none; b=W4FwxU1DMWdJV9y/k6hs0TXd+GWAO1iLQnXOSt0EtwZiV6A9LTvzVFdcoV3xXW4ma4k9++rVrwIk0LBv1SHmgAINvwS2dOefhMlH3tmbgrjUFNXh2slrTdDGxkfLN6SdlQCtR58+W75FffgIyZ2i5knhkJtk1/tO+m1LzGZA47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139047; c=relaxed/simple;
	bh=+f+N2pDYteNRJ9CHlE2evYMjJyUFUhqqJzdKAVSUOsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3NC84wgBZS7PAwfebd+Abl7Le7PJ5HiYPdz5/gCti1eaIm2mEKnUH/Ix4WuPAgomqq0DvHXlmKnLLgFHkvYnr71trytGv20yDO89UZFP3blwfXLNlHRT8cYSvJVjSaBQBWlONqYrmy7k0eFo+JuKbOMDKW/MevMU6MYz6tsqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJc/Z8iY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dyoQf0QIlekvhILl2AaZHPikE1EBHsF2ovW/aa5GPZs=;
	b=UJc/Z8iYQTOtM8wzGOETxW7x2RIr5KaLRyJTJ6ISjfGM0y87Gd0Qgp/yDf3mslh3OcdW+V
	jZj3bEIq9sar1i42AbNayrEmsvunLx/3o2GoojSMq7QkM8IOgnHesakYJ055ZvRj3HlFgs
	vBK4+trPG+3UAQFzrfjHWeA35YUlCjU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-aY_J-KHCPbGQEkvsmKi1rg-1; Fri,
 17 Jan 2025 13:37:23 -0500
X-MC-Unique: aY_J-KHCPbGQEkvsmKi1rg-1
X-Mimecast-MFC-AGG-ID: aY_J-KHCPbGQEkvsmKi1rg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4F8B19560BB;
	Fri, 17 Jan 2025 18:37:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 893AD19560BF;
	Fri, 17 Jan 2025 18:37:16 +0000 (UTC)
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
Subject: [RFC PATCH 16/24] crypto/krb5: Implement the AES encrypt/decrypt from rfc8009
Date: Fri, 17 Jan 2025 18:35:25 +0000
Message-ID: <20250117183538.881618-17-dhowells@redhat.com>
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

Implement encryption and decryption functions for AES + HMAC-SHA2 as
described in rfc8009 sec 5.

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
 crypto/krb5/rfc8009_aes2.c | 139 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 2 deletions(-)

diff --git a/crypto/krb5/rfc8009_aes2.c b/crypto/krb5/rfc8009_aes2.c
index d7225187ce8b..bcf84284abff 100644
--- a/crypto/krb5/rfc8009_aes2.c
+++ b/crypto/krb5/rfc8009_aes2.c
@@ -234,6 +234,141 @@ int authenc_load_encrypt_keys(const struct krb5_enctype *krb5,
 	return 0;
 }
 
+/*
+ * Apply encryption and checksumming functions to a message.  Unlike for
+ * RFC3961, for RFC8009, we have to chuck the starting IV into the hash first.
+ */
+static ssize_t rfc8009_encrypt(const struct krb5_enctype *krb5,
+			       struct crypto_aead *aead,
+			       struct scatterlist *sg, unsigned int nr_sg, size_t sg_len,
+			       size_t data_offset, size_t data_len,
+			       bool preconfounded)
+{
+	struct aead_request *req;
+	struct scatterlist bsg[2];
+	ssize_t ret, done;
+	size_t bsize, base_len, secure_offset, secure_len, pad_len, cksum_offset;
+	void *buffer;
+	u8 *iv, *ad;
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
+		krb5_aead_ivsize(aead) * 2;
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	req = buffer;
+	iv = buffer + krb5_aead_size(aead);
+	ad = buffer + krb5_aead_size(aead) + krb5_aead_ivsize(aead);
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
+	/* We need to include the starting IV in the hash. */
+	sg_init_table(bsg, 2);
+	sg_set_buf(&bsg[0], ad, krb5_aead_ivsize(aead));
+	sg_chain(bsg, 2, sg);
+
+	/* Hash and encrypt the message. */
+	aead_request_set_tfm(req, aead);
+	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_ad(req, krb5_aead_ivsize(aead));
+	aead_request_set_crypt(req, bsg, bsg, secure_len, iv);
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
+ * Apply decryption and checksumming functions to a message.  Unlike for
+ * RFC3961, for RFC8009, we have to chuck the starting IV into the hash first.
+ *
+ * The offset and length are updated to reflect the actual content of the
+ * encrypted region.
+ */
+static int rfc8009_decrypt(const struct krb5_enctype *krb5,
+			   struct crypto_aead *aead,
+			   struct scatterlist *sg, unsigned int nr_sg,
+			   size_t *_offset, size_t *_len)
+{
+	struct aead_request *req;
+	struct scatterlist bsg[2];
+	size_t bsize;
+	void *buffer;
+	int ret;
+	u8 *iv, *ad;
+
+	if (WARN_ON(*_offset != 0))
+		return -EINVAL; /* Can't set offset on aead */
+
+	if (*_len < krb5->conf_len + krb5->cksum_len)
+		return -EPROTO;
+
+	bsize = krb5_aead_size(aead) +
+		krb5_aead_ivsize(aead) * 2;
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	req = buffer;
+	iv = buffer + krb5_aead_size(aead);
+	ad = buffer + krb5_aead_size(aead) + krb5_aead_ivsize(aead);
+
+	/* We need to include the starting IV in the hash. */
+	sg_init_table(bsg, 2);
+	sg_set_buf(&bsg[0], ad, krb5_aead_ivsize(aead));
+	sg_chain(bsg, 2, sg);
+
+	/* Decrypt the message and verify its checksum. */
+	aead_request_set_tfm(req, aead);
+	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_ad(req, krb5_aead_ivsize(aead));
+	aead_request_set_crypt(req, bsg, bsg, *_len, iv);
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
 static const struct krb5_crypto_profile rfc8009_crypto_profile = {
 	.calc_PRF		= rfc8009_calc_PRF,
 	.calc_Kc		= rfc8009_calc_Ki,
@@ -243,8 +378,8 @@ static const struct krb5_crypto_profile rfc8009_crypto_profile = {
 	.load_encrypt_keys	= authenc_load_encrypt_keys,
 	.derive_checksum_key	= rfc3961_derive_checksum_key,
 	.load_checksum_key	= rfc3961_load_checksum_key,
-	.encrypt		= NULL, //rfc8009_encrypt,
-	.decrypt		= NULL, //rfc8009_decrypt,
+	.encrypt		= rfc8009_encrypt,
+	.decrypt		= rfc8009_decrypt,
 	.get_mic		= rfc3961_get_mic,
 	.verify_mic		= rfc3961_verify_mic,
 };


