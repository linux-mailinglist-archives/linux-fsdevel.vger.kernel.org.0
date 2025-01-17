Return-Path: <linux-fsdevel+bounces-39531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3654A15723
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529563A1384
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E21DFE2B;
	Fri, 17 Jan 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKwIJiMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046131DFE04
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139033; cv=none; b=sH3vuvAU/8+biAyzyLiAJ70zNieNsJicSX8fDJfyA5g2gdPKx1wOqJ+1odHjfFGUlIwnIQ1NKF65BVgywDnQucN0hXj+2g8kgpldu/k/9p5Z/VZwme2SBJ4amqfwd3W3VGER4KCdWFVHQK3lP3KfF6lwez6orTYMQ9JkWmlLTE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139033; c=relaxed/simple;
	bh=qWBVQfocHWo7FLuUVj+jEYQYNWdZozR/UkwHGAl3+io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTwvgR9z9OvwQHxNTBMEv+SoWzjEuu+jDLCTpb4l8W9eQj5l/Ju1JvwkctADiAllH6l6qvDVEiIFXmlRTV+I6626cUMtTEoUhxs5wWYtYiBB58CYAdcrc8s6Pd24Wy3vvv4zzZMyfEMLaiwUjFC72vbXiu3wauBODkP2PWTZx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKwIJiMk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEljsrdCVp7At0dij6jLls1b5eINNokiYSX0rLBMyp0=;
	b=RKwIJiMkiOH55ytn1/Kk+0rEZEIu1mh+APT5+6v8lVAeuxgYoL2x8Xei2xeXphBmu2p3Qz
	6HyDen+BaWeU8TJ3bdkiT9Me1xps8gVRTpJXc0cVrRBR+pF8WmpCro5LTH0sCt/BBE9bxx
	3BxdTtSwWEVaDS2QloXTzh4Y2dCXSgg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-t1_Sto6qNY-MQjtRudTJMA-1; Fri,
 17 Jan 2025 13:37:05 -0500
X-MC-Unique: t1_Sto6qNY-MQjtRudTJMA-1
X-Mimecast-MFC-AGG-ID: t1_Sto6qNY-MQjtRudTJMA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB226195609E;
	Fri, 17 Jan 2025 18:37:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 039A030001BE;
	Fri, 17 Jan 2025 18:36:58 +0000 (UTC)
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
Subject: [RFC PATCH 13/24] crypto/krb5: Implement the Kerberos5 rfc3961 get_mic and verify_mic
Date: Fri, 17 Jan 2025 18:35:22 +0000
Message-ID: <20250117183538.881618-14-dhowells@redhat.com>
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

Add functions that sign and verify a message according to rfc3961 sec 5.4,
using Kc to generate a checksum and insert it into the MIC field in the
skbuff in the sign phase then checksum the data and compare it to the MIC
in the verify phase.

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
 crypto/krb5/internal.h           |  10 +++
 crypto/krb5/rfc3961_simplified.c | 130 +++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index 4533fb342953..eaaa9c13c8b3 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -169,3 +169,13 @@ int krb5_aead_decrypt(const struct krb5_enctype *krb5,
 		      struct crypto_aead *aead,
 		      struct scatterlist *sg, unsigned int nr_sg,
 		      size_t *_offset, size_t *_len);
+ssize_t rfc3961_get_mic(const struct krb5_enctype *krb5,
+			struct crypto_shash *shash,
+			const struct krb5_buffer *metadata,
+			struct scatterlist *sg, unsigned int nr_sg, size_t sg_len,
+			size_t data_offset, size_t data_len);
+int rfc3961_verify_mic(const struct krb5_enctype *krb5,
+		       struct crypto_shash *shash,
+		       const struct krb5_buffer *metadata,
+		       struct scatterlist *sg, unsigned int nr_sg,
+		       size_t *_offset, size_t *_len);
diff --git a/crypto/krb5/rfc3961_simplified.c b/crypto/krb5/rfc3961_simplified.c
index 55f295f3ac5f..59f0e7c823f7 100644
--- a/crypto/krb5/rfc3961_simplified.c
+++ b/crypto/krb5/rfc3961_simplified.c
@@ -647,6 +647,134 @@ int krb5_aead_decrypt(const struct krb5_enctype *krb5,
 	return ret;
 }
 
+/*
+ * Generate a checksum over some metadata and part of an skbuff and insert the
+ * MIC into the skbuff immediately prior to the data.
+ */
+ssize_t rfc3961_get_mic(const struct krb5_enctype *krb5,
+			struct crypto_shash *shash,
+			const struct krb5_buffer *metadata,
+			struct scatterlist *sg, unsigned int nr_sg, size_t sg_len,
+			size_t data_offset, size_t data_len)
+{
+	struct shash_desc *desc;
+	ssize_t ret, done;
+	size_t bsize;
+	void *buffer, *digest;
+
+	if (WARN_ON(data_offset != krb5->cksum_len))
+		return -EMSGSIZE;
+
+	bsize = krb5_shash_size(shash) +
+		krb5_digest_size(shash);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	/* Calculate the MIC with key Kc and store it into the skb */
+	desc = buffer;
+	desc->tfm = shash;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	if (metadata) {
+		ret = crypto_shash_update(desc, metadata->data, metadata->len);
+		if (ret < 0)
+			goto error;
+	}
+
+	ret = crypto_shash_update_sg(desc, sg, data_offset, data_len);
+	if (ret < 0)
+		goto error;
+
+	digest = buffer + krb5_shash_size(shash);
+	ret = crypto_shash_final(desc, digest);
+	if (ret < 0)
+		goto error;
+
+	ret = -EFAULT;
+	done = sg_pcopy_from_buffer(sg, nr_sg, digest, krb5->cksum_len,
+				    data_offset - krb5->cksum_len);
+	if (done != krb5->cksum_len)
+		goto error;
+
+	ret = krb5->cksum_len + data_len;
+
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
+/*
+ * Check the MIC on a region of an skbuff.  The offset and length are updated
+ * to reflect the actual content of the secure region.
+ */
+int rfc3961_verify_mic(const struct krb5_enctype *krb5,
+		       struct crypto_shash *shash,
+		       const struct krb5_buffer *metadata,
+		       struct scatterlist *sg, unsigned int nr_sg,
+		       size_t *_offset, size_t *_len)
+{
+	struct shash_desc *desc;
+	ssize_t done;
+	size_t bsize, data_offset, data_len, offset = *_offset, len = *_len;
+	void *buffer = NULL;
+	int ret;
+	u8 *cksum, *cksum2;
+
+	if (len < krb5->cksum_len)
+		return -EPROTO;
+	data_offset = offset + krb5->cksum_len;
+	data_len = len - krb5->cksum_len;
+
+	bsize = krb5_shash_size(shash) +
+		krb5_digest_size(shash) * 2;
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	cksum = buffer +
+		krb5_shash_size(shash);
+	cksum2 = buffer +
+		krb5_shash_size(shash) +
+		krb5_digest_size(shash);
+
+	/* Calculate the MIC */
+	desc = buffer;
+	desc->tfm = shash;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	if (metadata) {
+		ret = crypto_shash_update(desc, metadata->data, metadata->len);
+		if (ret < 0)
+			goto error;
+	}
+
+	crypto_shash_update_sg(desc, sg, data_offset, data_len);
+	crypto_shash_final(desc, cksum);
+
+	ret = -EFAULT;
+	done = sg_pcopy_to_buffer(sg, nr_sg, cksum2, krb5->cksum_len, offset);
+	if (done != krb5->cksum_len)
+		goto error;
+
+	if (memcmp(cksum, cksum2, krb5->cksum_len) != 0) {
+		ret = -EBADMSG;
+		goto error;
+	}
+
+	*_offset += krb5->cksum_len;
+	*_len -= krb5->cksum_len;
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
@@ -658,4 +786,6 @@ const struct krb5_crypto_profile rfc3961_simplified_profile = {
 	.load_checksum_key	= rfc3961_load_checksum_key,
 	.encrypt		= krb5_aead_encrypt,
 	.decrypt		= krb5_aead_decrypt,
+	.get_mic		= rfc3961_get_mic,
+	.verify_mic		= rfc3961_verify_mic,
 };


