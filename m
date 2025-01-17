Return-Path: <linux-fsdevel+bounces-39524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1569A156F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE143A1F24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E09D1DDA3F;
	Fri, 17 Jan 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZtLM3Y5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA71DC9B7
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138990; cv=none; b=g5jhrt89P5wKbJug2BFO1SRKa7bqbtKxvUmb9cK92SH3Lj7xOs5B8yv4Xm9GJr9oiQmJAq5oFrBFrErEb5dRFdZMYFhhxNX0vxn+M4/TGP92gCZPTSp18LNqcmxQDEfnpQ/T2jkFjlgLe7UntNFRheUWBz6zGg09qOlpMHwOLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138990; c=relaxed/simple;
	bh=eFp8ZqcQRTVC7qF60Sf2exc9B5aLtaR1JGWpl3lHq/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZYu1xDApyhaKPWm7pdVW6wnuNp5bs6QWqyErfnm4QuE/8T9aEFnDV+Jw1VBhyWH2BzUv0RoMvYhhjtsW6ZzepUi5WbBZjvon/ZYNsF77Msef4X/mZXrHw6XEjnkGiGCzFNJ24+YomeDsWnrTcHmxsAZNx9wwxARhcOLJ/jEjtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZtLM3Y5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737138988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBykrmXQ+JqjSUNiYCuDnSd7LtC9xGveIE0UhOB9riI=;
	b=RZtLM3Y58ckwFiJfCAGzeQss+xCJ8gMYktsv1bY4kgglQb9jA/XziUPqqYBD5exjy32ZEX
	6VluCA4A/3SluneecQWtbunf4uohW3gUuGnVmy/6VGDAA/pVXj5c66nzyesYZ227gFcVPS
	JNNdsaybs3GB1xNGSCqnaTk4UOSGBdw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-zYjCWUutOaOaUfmJZazgfQ-1; Fri,
 17 Jan 2025 13:36:24 -0500
X-MC-Unique: zYjCWUutOaOaUfmJZazgfQ-1
X-Mimecast-MFC-AGG-ID: zYjCWUutOaOaUfmJZazgfQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E8B019560B3;
	Fri, 17 Jan 2025 18:36:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F37213003E7F;
	Fri, 17 Jan 2025 18:36:17 +0000 (UTC)
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
Subject: [RFC PATCH 06/24] crypto/krb5: Add an API to query the layout of the crypto section
Date: Fri, 17 Jan 2025 18:35:15 +0000
Message-ID: <20250117183538.881618-7-dhowells@redhat.com>
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
index a67a5e1a0a4f..e7dfe0b7c60d 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -101,6 +101,15 @@ struct krb5_enctype {
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
 
 /*
  * krb5enc.c


