Return-Path: <linux-fsdevel+bounces-40599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07660A25C58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B6F163C29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D41520ADE9;
	Mon,  3 Feb 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYYyge4q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13120ADEB
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592680; cv=none; b=e9dBmfCTltSVVfN/jbEYrVzDQCpCEJrvGBz2wJOEwT3qXc2LbkMLsCV1gNojvJ0VidsqnA2hu9W3vgJLOspO/Zax3tyiETXnicXTxU0kdnM8/xGHVxWA2FFBTRi7HEXP2A4/Y3Gqlruq3CLKwTlZO/EozjuyQ7E+peLIhojAJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592680; c=relaxed/simple;
	bh=NAm+B+s9fZAfLpPq9nhNS89dlrfuoXH06+P+pBdHAFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nk3yiVmyS6FNe0hRPJlxGgFTusNNw+zbWo9I6UrTT8Tvj7E/rvffnm502wypgKa8h/cyFdzoA8JEV8bmDSs5Cgtp7OBzNBxdJzTnvFCHVDg7nkkT73/aD1Wf7wU8je550zniaxJ0ZldijVvPepBn7Bsln1m1mxb0Lhcc72TNkmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYYyge4q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Rsu10jn1c1zzLZ08M9X5FwwxLwWztccS+1yJOn6V1o=;
	b=hYYyge4qsn2dugbdpMGLxqzJEmW+oPX/tar46Pg17Bfib4uPpfjvM2eRPiL+qFv0jTGNCk
	ywfbMcD7+8kyC1vjIbWI59aWAKhhcM8KJIbafl1N73bRd0M7sCNrxXkpe/ExbFveABptEf
	HOy3Nb246VRLuRTxCLRFyH5wUcijd98=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-TbfA4cuLNxu1wq26NGy81g-1; Mon,
 03 Feb 2025 09:24:34 -0500
X-MC-Unique: TbfA4cuLNxu1wq26NGy81g-1
X-Mimecast-MFC-AGG-ID: TbfA4cuLNxu1wq26NGy81g
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4CB31956080;
	Mon,  3 Feb 2025 14:24:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E680180097D;
	Mon,  3 Feb 2025 14:24:27 +0000 (UTC)
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
Subject: [PATCH net 06/24] crypto/krb5: Add an API to query the layout of the crypto section
Date: Mon,  3 Feb 2025 14:23:22 +0000
Message-ID: <20250203142343.248839-7-dhowells@redhat.com>
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

Provide some functions to allow the called to find out about the layout of
the crypto section:

 (1) Calculate, for a given size of data, how big a buffer will be
     required to hold it and where the data will be within it.

 (2) Calculate, for an amount of buffer, what's the maximum size of data
     that will fit therein, and where it will start.

 (3) Determine where the data will be in a received message.

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
 crypto/krb5/krb5_api.c | 108 +++++++++++++++++++++++++++++++++++++++++
 include/crypto/krb5.h  |   9 ++++
 2 files changed, 117 insertions(+)

diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index 5c1cd5d07fc3..f6d1bc813daa 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -40,3 +40,111 @@ const struct krb5_enctype *crypto_krb5_find_enctype(u32 enctype)
 	return NULL;
 }
 EXPORT_SYMBOL(crypto_krb5_find_enctype);
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
+		*_offset = krb5->cksum_len;
+		return krb5->cksum_len + data_size;
+
+	case KRB5_ENCRYPT_MODE:
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
+		*_offset += krb5->cksum_len;
+		*_len -= krb5->cksum_len;
+		return;
+	case KRB5_ENCRYPT_MODE:
+		*_offset += krb5->conf_len;
+		*_len -= krb5->conf_len + krb5->cksum_len;
+		return;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+}
+EXPORT_SYMBOL(crypto_krb5_where_is_the_data);
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index 8fa6715ab35b..b414141b8b42 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -101,5 +101,14 @@ struct krb5_enctype {
  * krb5_api.c
  */
 const struct krb5_enctype *crypto_krb5_find_enctype(u32 enctype);
+size_t crypto_krb5_how_much_buffer(const struct krb5_enctype *krb5,
+				   enum krb5_crypto_mode mode,
+				   size_t data_size, size_t *_offset);
+size_t crypto_krb5_how_much_data(const struct krb5_enctype *krb5,
+				 enum krb5_crypto_mode mode,
+				 size_t *_buffer_size, size_t *_offset);
+void crypto_krb5_where_is_the_data(const struct krb5_enctype *krb5,
+				   enum krb5_crypto_mode mode,
+				   size_t *_offset, size_t *_len);
 
 #endif /* _CRYPTO_KRB5_H */


