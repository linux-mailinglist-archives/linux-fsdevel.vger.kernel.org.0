Return-Path: <linux-fsdevel+bounces-39526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EDAA15703
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DC716233A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B471DEFE5;
	Fri, 17 Jan 2025 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOvVHr+Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36501A83F8
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139001; cv=none; b=YTnXZeueYafna3sfym4MpAwO9dwYtObuLGy6N9tF6CQvUv98yar3zYb5YfO/P+6LDQUsIqBoIYTDp4aJoH6iCMpHd5FK9cJBEiyRHDBFf9H4JBxD137HxjnUvElijRa3GHettEYaO6TO0JQQuhBs/6E6HTwqn77HrhupNgsACY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139001; c=relaxed/simple;
	bh=2x+uH/OBiPZrbTwSNjvlGUfqz+0cO1RFGukVf7ieGeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul7FfPAGptfytagvCO7f+psaTMXDQm4mVBuuKIxk51gaJzn5B/MS0uB+3mmi9A/uIgE08JZSjxhUgpH44EQH/rv4FuZfJhBmHj+mt7FR7GkOr8lR0fpE8gpLe0fSPhsyokuMggh21aITEA0GnR2fcJCcL/DKYtAilUtzi0Ckr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOvVHr+Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737138999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YdZKkAJTbkV6+q41EVpA6T2mU4du83xKSuI3GcUqqg=;
	b=ZOvVHr+YHGrPMd7BAjPB8B3JS1pv1NSyt/TGojWyxk6cwdFW3NtWOkMbGSEpTgwI6vrjrQ
	ckZW78qhtV+7REbtFjkgR0dRuScq6bBZLJqU+vRL0DP7EQvcEusVEmOoe1Vo8kIYAv0zDI
	OUEfmICiCennnfYqDPrroeMJRc4Z+Ok=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-ybE6WTC3O4Wf5Df-n8Dopw-1; Fri,
 17 Jan 2025 13:36:36 -0500
X-MC-Unique: ybE6WTC3O4Wf5Df-n8Dopw-1
X-Mimecast-MFC-AGG-ID: ybE6WTC3O4Wf5Df-n8Dopw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 408511956083;
	Fri, 17 Jan 2025 18:36:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B685030001BE;
	Fri, 17 Jan 2025 18:36:29 +0000 (UTC)
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
Subject: [RFC PATCH 08/24] crypto/krb5: Add an API to perform requests
Date: Fri, 17 Jan 2025 18:35:17 +0000
Message-ID: <20250117183538.881618-9-dhowells@redhat.com>
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
index 5ff052e2c157..4919e135b2ca 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -117,6 +117,27 @@ struct crypto_aead *crypto_krb5_prepare_encryption(const struct krb5_enctype *kr
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
 
 /*
  * krb5enc.c


