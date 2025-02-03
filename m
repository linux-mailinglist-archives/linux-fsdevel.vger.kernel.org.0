Return-Path: <linux-fsdevel+bounces-40594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A740A25C42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE0218853AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27064209689;
	Mon,  3 Feb 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilbg5w3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0252080EC
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592648; cv=none; b=thja5UtaTyiowKNTTLtY4v3mp4n00HKDoNtqKeJFis8pYyRjxmpSbjRP9d6FDvoDoHiip95x8BWmbi8FMX2ny8C8YNudlW93lcCP7QTSufCcIxP/sGml6U8fH7qBmn/0oKk/SxHXd7thEmqg14wCuzXhMXfsNaaX7REjBNOKWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592648; c=relaxed/simple;
	bh=t94SvhYlIVXCphu1PLVFKZjQoFJDH4Nteo+nWiax5tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5CkyvTlmItgkZKGvaIf0LZJqL1tJ0HP64Ju5B2jhQHphAgaQjx2QYsRQ+KIR9zpb6I0PTYTkhcaG+0IcSprgUSEnNwfHyMptU7dRGka470r7ryT41rjIwPGPBIZPxKbslOGsxKuZ9uuhebfxaXT7L5ztlspllfus0MHcTdgyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilbg5w3z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGM+tm2JDP7RQOystM+1FlseTGxyrbUDV8REbBvgdWs=;
	b=ilbg5w3zDuIEuY1g2S9XRSDQ2xdmE2BxPzgppWDCSvqhHvsFsr8fhfSc48egLuWV3ndY+X
	RzVWK/9VxPvMXMFv2MFvGHuRr7OHCJu/cXeFF7W+7uBcYoEabUB4mp+IQf9XanLhYb6XL1
	GAFe5seo7XWzL/sXv5xvFpDMz5/qosg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-cXT9xPvbOvCaewQbkR6nAw-1; Mon,
 03 Feb 2025 09:24:01 -0500
X-MC-Unique: cXT9xPvbOvCaewQbkR6nAw-1
X-Mimecast-MFC-AGG-ID: cXT9xPvbOvCaewQbkR6nAw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B52C419560BB;
	Mon,  3 Feb 2025 14:23:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B636518008C0;
	Mon,  3 Feb 2025 14:23:53 +0000 (UTC)
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
Subject: [PATCH net 01/24] crypto/krb5: Add API Documentation
Date: Mon,  3 Feb 2025 14:23:17 +0000
Message-ID: <20250203142343.248839-2-dhowells@redhat.com>
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

Add API documentation for the kerberos crypto library.

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
 Documentation/crypto/index.rst |   1 +
 Documentation/crypto/krb5.rst  | 262 +++++++++++++++++++++++++++++++++
 2 files changed, 263 insertions(+)
 create mode 100644 Documentation/crypto/krb5.rst

diff --git a/Documentation/crypto/index.rst b/Documentation/crypto/index.rst
index 92eec78b5713..100b47d049c0 100644
--- a/Documentation/crypto/index.rst
+++ b/Documentation/crypto/index.rst
@@ -26,3 +26,4 @@ for cryptographic use cases, as well as programming examples.
    api-samples
    descore-readme
    device_drivers/index
+   krb5
diff --git a/Documentation/crypto/krb5.rst b/Documentation/crypto/krb5.rst
new file mode 100644
index 000000000000..beffa0133446
--- /dev/null
+++ b/Documentation/crypto/krb5.rst
@@ -0,0 +1,262 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Kerberos V Cryptography API
+===========================
+
+.. Contents:
+
+  - Overview.
+    - Small Buffer.
+  - Encoding Type.
+  - Key Derivation.
+    - PRF+ Calculation.
+    - Kc, Ke And Ki Derivation.
+  - Crypto Functions.
+    - Preparation Functions.
+    - Encryption Mode.
+    - Checksum Mode.
+  - The krb5enc AEAD algorithm
+
+Overview
+========
+
+This API provides Kerberos 5-style cryptography for key derivation, encryption
+and checksumming for use in network filesystems and can be used to implement
+the low-level crypto that's needed for GSSAPI.
+
+The following crypto types are supported::
+
+	KRB5_ENCTYPE_AES128_CTS_HMAC_SHA1_96
+	KRB5_ENCTYPE_AES256_CTS_HMAC_SHA1_96
+	KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128
+	KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192
+	KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC
+	KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC
+
+	KRB5_CKSUMTYPE_HMAC_SHA1_96_AES128
+	KRB5_CKSUMTYPE_HMAC_SHA1_96_AES256
+	KRB5_CKSUMTYPE_CMAC_CAMELLIA128
+	KRB5_CKSUMTYPE_CMAC_CAMELLIA256
+	KRB5_CKSUMTYPE_HMAC_SHA256_128_AES128
+	KRB5_CKSUMTYPE_HMAC_SHA384_192_AES256
+
+The API can be included by::
+
+	#include <crypto/krb5.h>
+
+Small Buffer
+------------
+
+To pass small pieces of data about, such as keys, a buffer structure is
+defined, giving a pointer to the data and the size of that data::
+
+	struct krb5_buffer {
+		unsigned int	len;
+		void		*data;
+	};
+
+Encoding Type
+=============
+
+The encoding type is defined by the following structure::
+
+	struct krb5_enctype {
+		int		etype;
+		int		ctype;
+		const char	*name;
+		u16		key_bytes;
+		u16		key_len;
+		u16		Kc_len;
+		u16		Ke_len;
+		u16		Ki_len;
+		u16		prf_len;
+		u16		block_len;
+		u16		conf_len;
+		u16		cksum_len;
+		...
+	};
+
+The fields of interest to the user of the API are as follows:
+
+  * ``etype`` and ``ctype`` indicate the protocol number for this encoding
+    type for encryption and checksumming respectively.  They hold
+    ``KRB5_ENCTYPE_*`` and ``KRB5_CKSUMTYPE_*`` constants.
+
+  * ``name`` is the formal name of the encoding.
+
+  * ``key_len`` and ``key_bytes`` are the input key length and the derived key
+    length.  (I think they only differ for DES, which isn't supported here).
+
+  * ``Kc_len``, ``Ke_len`` and ``Ki_len`` are the sizes of the derived Kc, Ke
+    and Ki keys.  Kc is used for in checksum mode; Ke and Ki are used in
+    encryption mode.
+
+  * ``prf_len`` is the size of the result from the PRF+ function calculation.
+
+  * ``block_len``, ``conf_len`` and ``cksum_len`` are the encryption block
+    length, confounder length and checksum length respectively.  All three are
+    used in encryption mode, but only the checksum length is used in checksum
+    mode.
+
+The encoding type is looked up by number using the following function::
+
+	const struct krb5_enctype *crypto_krb5_find_enctype(u32 enctype);
+
+Key Derivation
+==============
+
+Once the application has selected an encryption type, the keys that will be
+used to do the actual crypto can be derived from the transport key.
+
+PRF+ Calculation
+----------------
+
+To aid in key derivation, a function to calculate the Kerberos GSSAPI
+mechanism's PRF+ is provided::
+
+	int crypto_krb5_calc_PRFplus(const struct krb5_enctype *krb5,
+				     const struct krb5_buffer *K,
+				     unsigned int L,
+				     const struct krb5_buffer *S,
+				     struct krb5_buffer *result,
+				     gfp_t gfp);
+
+This can be used to derive the transport key from a source key plus additional
+data to limit its use.
+
+Crypto Functions
+================
+
+Once the keys have been derived, crypto can be performed on the data.  The
+caller must leave gaps in the buffer for the storage of the confounder (if
+needed) and the checksum when preparing a message for transmission.  An enum
+and a pair of functions are provided to aid in this::
+
+	enum krb5_crypto_mode {
+		KRB5_CHECKSUM_MODE,
+		KRB5_ENCRYPT_MODE,
+	};
+
+	size_t crypto_krb5_how_much_buffer(const struct krb5_enctype *krb5,
+					   enum krb5_crypto_mode mode,
+					   size_t data_size, size_t *_offset);
+
+	size_t crypto_krb5_how_much_data(const struct krb5_enctype *krb5,
+					 enum krb5_crypto_mode mode,
+					 size_t *_buffer_size, size_t *_offset);
+
+All these functions take the encoding type and an indication the mode of crypto
+(checksum-only or full encryption).
+
+The first function returns how big the buffer will need to be to house a given
+amount of data; the second function returns how much data will fit in a buffer
+of a particular size, and adjusts down the size of the required buffer
+accordingly.  In both cases, the offset of the data within the buffer is also
+returned.
+
+When a message has been received, the location and size of the data with the
+message can be determined by calling::
+
+	void crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
+					   enum krb5_crypto_mode mode,
+					   size_t *_offset, size_t *_len);
+
+The caller provides the offset and length of the message to the function, which
+then alters those values to indicate the region containing the data (plus any
+padding).  It is up to the caller to determine how much padding there is.
+
+Preparation Functions
+---------------------
+
+Two functions are provided to allocated and prepare a crypto object for use by
+the action functions::
+
+	struct crypto_aead *
+	crypto_krb5_prepare_encryption(const struct krb5_enctype *krb5,
+				       const struct krb5_buffer *TK,
+				       u32 usage, gfp_t gfp);
+	struct crypto_shash *
+	crypto_krb5_prepare_checksum(const struct krb5_enctype *krb5,
+				     const struct krb5_buffer *TK,
+				     u32 usage, gfp_t gfp);
+
+Both of these functions take the encoding type, the transport key and the usage
+value used to derive the appropriate subkey(s).  They create an appropriate
+crypto object, an AEAD template for encryption and a synchronous hash for
+checksumming, set the key(s) on it and configure it.  The caller is expected to
+pass these handles to the action functions below.
+
+Encryption Mode
+---------------
+
+A pair of functions are provided to encrypt and decrypt a message::
+
+	ssize_t crypto_krb5_encrypt(const struct krb5_enctype *krb5,
+				    struct crypto_aead *aead,
+				    struct scatterlist *sg, unsigned int nr_sg,
+				    size_t sg_len,
+				    size_t data_offset, size_t data_len,
+				    bool preconfounded);
+	int crypto_krb5_decrypt(const struct krb5_enctype *krb5,
+				struct crypto_aead *aead,
+				struct scatterlist *sg, unsigned int nr_sg,
+				size_t *_offset, size_t *_len);
+
+In both cases, the input and output buffers are indicated by the same
+scatterlist.
+
+For the encryption function, the output buffer may be larger than is needed
+(the amount of output generated is returned) and the location and size of the
+data are indicated (which must match the encoding).  If no confounder is set,
+the function will insert one.
+
+For the decryption function, the offset and length of the message in buffer are
+supplied and these are shrunk to fit the data.  The decryption function will
+verify any checksums within the message and give an error if they don't match.
+
+Checksum Mode
+-------------
+
+A pair of function are provided to generate the checksum on a message and to
+verify that checksum::
+
+	ssize_t crypto_krb5_get_mic(const struct krb5_enctype *krb5,
+				    struct crypto_shash *shash,
+				    const struct krb5_buffer *metadata,
+				    struct scatterlist *sg, unsigned int nr_sg,
+				    size_t sg_len,
+				    size_t data_offset, size_t data_len);
+	int crypto_krb5_verify_mic(const struct krb5_enctype *krb5,
+				   struct crypto_shash *shash,
+				   const struct krb5_buffer *metadata,
+				   struct scatterlist *sg, unsigned int nr_sg,
+				   size_t *_offset, size_t *_len);
+
+In both cases, the input and output buffers are indicated by the same
+scatterlist.  Additional metadata can be passed in which will get added to the
+hash before the data.
+
+For the get_mic function, the output buffer may be larger than is needed (the
+amount of output generated is returned) and the location and size of the data
+are indicated (which must match the encoding).
+
+For the verification function, the offset and length of the message in buffer
+are supplied and these are shrunk to fit the data.  An error will be returned
+if the checksums don't match.
+
+The krb5enc AEAD algorithm
+==========================
+
+A template AEAD crypto algorithm, called "krb5enc", is provided that hashes the
+plaintext before encrypting it (the reverse of authenc).  The handle returned
+by ``crypto_krb5_prepare_encryption()`` may be one of these, but there's no
+requirement for the user of this API to interact with it directly.
+
+For reference, its key format begins with a BE32 of the format number.  Only
+format 1 is provided and that continues with a BE32 of the Ke key length
+followed by a BE32 of the Ki key length, followed by the bytes from the Ke key
+and then the Ki key.
+
+Using specifically ordered words means that the static test data doesn't
+require byteswapping.


