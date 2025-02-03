Return-Path: <linux-fsdevel+bounces-40601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58805A25C6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23203A7C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F120AF93;
	Mon,  3 Feb 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXwraF8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F23209F25
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592690; cv=none; b=nZKojLPwEAOnNNpKTPFza0xbDpQWUdYFLkT6Hecau3gvFOxYFTW7X7KfOuPt2v9KCzG+iKs6t6hq9Il5jA/KMvo2tqDfH7+1UPjPXF25aFuyBmNaO8LtOYJTyvc4cXRPZ8WflDQHpfdr4YBCZuS+7msnOOZsachZeXkT6SKe3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592690; c=relaxed/simple;
	bh=lAb1KwoCbtKTk5DtqINTYMd45VAo13/aRc26WkMIqS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX6eeIG0gwbNYMBfdXxT5+byii56pfkXSh/3cOBKDRRdEdPtZcrBE7/2BLoYQVDm0eCVKqu7WwLP5uQC6mVH5hg39DRQNKc5BwKgGxOh4pZCddai6EBXzFgVBkN/atWsqIqUD6WEIiGA75SY9TUPImDJKuyvv5k2UTFcjtvxh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXwraF8B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwkCLqec+OqX38stnAwGVsgBUOrv6ycr3Ha44iRhq6w=;
	b=SXwraF8B0U1/eQ6Hx3vbT3BPiZD41IYiqUPArEgKRjDb1xFSh1NvmV5cUKLWUk4AYEjUy7
	QCqiZPg0s3/NLo2EWkWi+wijJP5roJYns73cSZOAhBQtr9es2L/jsnnuC4qh+VB0706WIr
	YjhJrc1BpQQW/TaiAGPZWNV0l1sPI/M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-mIeDjAtAPKetmLV-4_5Eqw-1; Mon,
 03 Feb 2025 09:24:46 -0500
X-MC-Unique: mIeDjAtAPKetmLV-4_5Eqw-1
X-Mimecast-MFC-AGG-ID: mIeDjAtAPKetmLV-4_5Eqw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 014981955DCC;
	Mon,  3 Feb 2025 14:24:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB7771800352;
	Mon,  3 Feb 2025 14:24:39 +0000 (UTC)
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
Subject: [PATCH net 08/24] crypto/krb5: Add an API to perform requests
Date: Mon,  3 Feb 2025 14:23:24 +0000
Message-ID: <20250203142343.248839-9-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add an API by which users of the krb5 crypto library can perform crypto
requests, such as encrypt, decrypt, get_mic and verify_mic.  These
functions take the previously prepared crypto objects to work on.

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
 crypto/krb5/krb5_api.c | 141 +++++++++++++++++++++++++++++++++++++++++
 include/crypto/krb5.h  |  21 ++++++
 2 files changed, 162 insertions(+)

diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index f7f2528b3895..8fc3a1b9d4ad 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -292,3 +292,144 @@ struct crypto_shash *crypto_krb5_prepare_checksum(const struct krb5_enctype *krb
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(crypto_krb5_prepare_checksum);
+
+/**
+ * crypto_krb5_encrypt - Apply Kerberos encryption and integrity.
+ * @krb5: The encoding to use.
+ * @aead: The keyed crypto object to use.
+ * @sg: Scatterlist defining the crypto buffer.
+ * @nr_sg: The number of elements in @sg.
+ * @sg_len: The size of the buffer.
+ * @data_offset: The offset of the data in the @sg buffer.
+ * @data_len: The length of the data.
+ * @preconfounded: True if the confounder is already inserted.
+ *
+ * Using the specified Kerberos encoding, insert a confounder and padding as
+ * needed, encrypt this and the data in place and insert an integrity checksum
+ * into the buffer.
+ *
+ * The buffer must include space for the confounder, the checksum and any
+ * padding required.  The caller can preinsert the confounder into the buffer
+ * (for testing, for example).
+ *
+ * The resulting secured blob may be less than the size of the buffer.
+ *
+ * Returns the size of the secure blob if successful, -ENOMEM on an allocation
+ * failure, -EFAULT if there is insufficient space, -EMSGSIZE if the confounder
+ * is too short or the data is misaligned.  Other errors may also be returned
+ * from the crypto layer.
+ */
+ssize_t crypto_krb5_encrypt(const struct krb5_enctype *krb5,
+			    struct crypto_aead *aead,
+			    struct scatterlist *sg, unsigned int nr_sg,
+			    size_t sg_len,
+			    size_t data_offset, size_t data_len,
+			    bool preconfounded)
+{
+	if (WARN_ON(data_offset > sg_len ||
+		    data_len > sg_len ||
+		    data_offset > sg_len - data_len))
+		return -EMSGSIZE;
+	return krb5->profile->encrypt(krb5, aead, sg, nr_sg, sg_len,
+				      data_offset, data_len, preconfounded);
+}
+EXPORT_SYMBOL(crypto_krb5_encrypt);
+
+/**
+ * crypto_krb5_decrypt - Validate and remove Kerberos encryption and integrity.
+ * @krb5: The encoding to use.
+ * @aead: The keyed crypto object to use.
+ * @sg: Scatterlist defining the crypto buffer.
+ * @nr_sg: The number of elements in @sg.
+ * @_offset: Offset of the secure blob in the buffer; updated to data offset.
+ * @_len: The length of the secure blob; updated to data length.
+ *
+ * Using the specified Kerberos encoding, check and remove the integrity
+ * checksum and decrypt the secure region, stripping off the confounder.
+ *
+ * If successful, @_offset and @_len are updated to outline the region in which
+ * the data plus the trailing padding are stored.  The caller is responsible
+ * for working out how much padding there is and removing it.
+ *
+ * Returns the 0 if successful, -ENOMEM on an allocation failure; sets
+ * *_error_code and returns -EPROTO if the data cannot be parsed, or -EBADMSG
+ * if the integrity checksum doesn't match).  Other errors may also be returned
+ * from the crypto layer.
+ */
+int crypto_krb5_decrypt(const struct krb5_enctype *krb5,
+			struct crypto_aead *aead,
+			struct scatterlist *sg, unsigned int nr_sg,
+			size_t *_offset, size_t *_len)
+{
+	return krb5->profile->decrypt(krb5, aead, sg, nr_sg, _offset, _len);
+}
+EXPORT_SYMBOL(crypto_krb5_decrypt);
+
+/**
+ * crypto_krb5_get_mic - Apply Kerberos integrity checksum.
+ * @krb5: The encoding to use.
+ * @shash: The keyed hash to use.
+ * @metadata: Metadata to add into the hash before adding the data.
+ * @sg: Scatterlist defining the crypto buffer.
+ * @nr_sg: The number of elements in @sg.
+ * @sg_len: The size of the buffer.
+ * @data_offset: The offset of the data in the @sg buffer.
+ * @data_len: The length of the data.
+ *
+ * Using the specified Kerberos encoding, calculate and insert an integrity
+ * checksum into the buffer.
+ *
+ * The buffer must include space for the checksum at the front.
+ *
+ * Returns the size of the secure blob if successful, -ENOMEM on an allocation
+ * failure, -EFAULT if there is insufficient space, -EMSGSIZE if the gap for
+ * the checksum is too short.  Other errors may also be returned from the
+ * crypto layer.
+ */
+ssize_t crypto_krb5_get_mic(const struct krb5_enctype *krb5,
+			    struct crypto_shash *shash,
+			    const struct krb5_buffer *metadata,
+			    struct scatterlist *sg, unsigned int nr_sg,
+			    size_t sg_len,
+			    size_t data_offset, size_t data_len)
+{
+	if (WARN_ON(data_offset > sg_len ||
+		    data_len > sg_len ||
+		    data_offset > sg_len - data_len))
+		return -EMSGSIZE;
+	return krb5->profile->get_mic(krb5, shash, metadata, sg, nr_sg, sg_len,
+				      data_offset, data_len);
+}
+EXPORT_SYMBOL(crypto_krb5_get_mic);
+
+/**
+ * crypto_krb5_verify_mic - Validate and remove Kerberos integrity checksum.
+ * @krb5: The encoding to use.
+ * @shash: The keyed hash to use.
+ * @metadata: Metadata to add into the hash before adding the data.
+ * @sg: Scatterlist defining the crypto buffer.
+ * @nr_sg: The number of elements in @sg.
+ * @_offset: Offset of the secure blob in the buffer; updated to data offset.
+ * @_len: The length of the secure blob; updated to data length.
+ *
+ * Using the specified Kerberos encoding, check and remove the integrity
+ * checksum.
+ *
+ * If successful, @_offset and @_len are updated to outline the region in which
+ * the data is stored.
+ *
+ * Returns the 0 if successful, -ENOMEM on an allocation failure; sets
+ * *_error_code and returns -EPROTO if the data cannot be parsed, or -EBADMSG
+ * if the checksum doesn't match).  Other errors may also be returned from the
+ * crypto layer.
+ */
+int crypto_krb5_verify_mic(const struct krb5_enctype *krb5,
+			   struct crypto_shash *shash,
+			   const struct krb5_buffer *metadata,
+			   struct scatterlist *sg, unsigned int nr_sg,
+			   size_t *_offset, size_t *_len)
+{
+	return krb5->profile->verify_mic(krb5, shash, metadata, sg, nr_sg,
+					 _offset, _len);
+}
+EXPORT_SYMBOL(crypto_krb5_verify_mic);
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index 94af2c558fa1..81739e9828d3 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -117,5 +117,26 @@ struct crypto_aead *crypto_krb5_prepare_encryption(const struct krb5_enctype *kr
 struct crypto_shash *crypto_krb5_prepare_checksum(const struct krb5_enctype *krb5,
 						  const struct krb5_buffer *TK,
 						  u32 usage, gfp_t gfp);
+ssize_t crypto_krb5_encrypt(const struct krb5_enctype *krb5,
+			    struct crypto_aead *aead,
+			    struct scatterlist *sg, unsigned int nr_sg,
+			    size_t sg_len,
+			    size_t data_offset, size_t data_len,
+			    bool preconfounded);
+int crypto_krb5_decrypt(const struct krb5_enctype *krb5,
+			struct crypto_aead *aead,
+			struct scatterlist *sg, unsigned int nr_sg,
+			size_t *_offset, size_t *_len);
+ssize_t crypto_krb5_get_mic(const struct krb5_enctype *krb5,
+			    struct crypto_shash *shash,
+			    const struct krb5_buffer *metadata,
+			    struct scatterlist *sg, unsigned int nr_sg,
+			    size_t sg_len,
+			    size_t data_offset, size_t data_len);
+int crypto_krb5_verify_mic(const struct krb5_enctype *krb5,
+			   struct crypto_shash *shash,
+			   const struct krb5_buffer *metadata,
+			   struct scatterlist *sg, unsigned int nr_sg,
+			   size_t *_offset, size_t *_len);
 
 #endif /* _CRYPTO_KRB5_H */


