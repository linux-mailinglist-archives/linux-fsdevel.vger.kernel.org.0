Return-Path: <linux-fsdevel+bounces-39529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B0A15712
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4083D3AAB54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71301AAA2C;
	Fri, 17 Jan 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLnGsmD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F01DF74B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139020; cv=none; b=UYFwtuIuhQROvtxfZkTrPLgKlNiI6K+dHWnHXYXuaji1Z6+Rv2E8IlO+pH5/Ccj2h+5A2RcDXdgwXga1x2357ebh7JhPo06jX8s81c3NVcmjmHgpEAqsZ8lvTFWyl8RJiL43WJiIS2UfYpvj+UoOa7MyaUL+GKzyVMqAmxb7hUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139020; c=relaxed/simple;
	bh=y4KCaAmgvh/nKdxU2dRaIvTwtEZ2b3iTMe3SxeTpqII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfLNa1BBPea9VATQBNhaMmeb+6rlFVectPfuGKcXlCX2Ipr1VddVr0KsA3JSc0bG4OcaxlrGA7WJ2+jqDhM8ovm8gPD8tTlXhRJEOx0z0hPd6uoavMv1eam/5l91zAEfbOvwa0Jq6wXlhNl1tB4UyOC2zF6j3uKJMRKrv88c+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLnGsmD/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5UkyDyI9CHNVOpmnTeizIjJ7K8ZBSHH0K9Ac53V2uk=;
	b=SLnGsmD/E4ab5xJF2ucWHzMkDQh7bveM0/UKqxConknGdiOpxaSzQTLeA4IN9DGiRYWjhu
	m45E/xwp0fVY7+2sucIip+/5HVde97mKBUMB0kqA72RfVTyPhuI0GxK7qP6URYCUb3H6Qu
	99YFL4jT4OwJR8SWmZwQ25GEy3k7hdA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-WupYk3-1Mc--W_rEyV1kUg-1; Fri,
 17 Jan 2025 13:36:53 -0500
X-MC-Unique: WupYk3-1Mc--W_rEyV1kUg-1
X-Mimecast-MFC-AGG-ID: WupYk3-1Mc--W_rEyV1kUg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D85EF1956083;
	Fri, 17 Jan 2025 18:36:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F5B31955F10;
	Fri, 17 Jan 2025 18:36:47 +0000 (UTC)
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
Subject: [RFC PATCH 11/24] crypto/krb5: Provide RFC3961 setkey packaging functions
Date: Fri, 17 Jan 2025 18:35:20 +0000
Message-ID: <20250117183538.881618-12-dhowells@redhat.com>
In-Reply-To: <20250117183538.881618-1-dhowells@redhat.com>
References: <20250117183538.881618-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Provide functions to derive keys according to RFC3961 (or load the derived
keys for the selftester where only derived keys are available) and to
package them up appropriately for passing to a krb5enc AEAD setkey or a
hash setkey function.

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
 crypto/krb5/internal.h           |  20 ++++++
 crypto/krb5/rfc3961_simplified.c | 116 +++++++++++++++++++++++++++++--
 2 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index 7d60977dc0c5..8418c23d5018 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -136,3 +136,23 @@ int krb5_derive_Ki(const struct krb5_enctype *krb5, const struct krb5_buffer *TK
  * rfc3961_simplified.c
  */
 extern const struct krb5_crypto_profile rfc3961_simplified_profile;
+
+int krb5enc_derive_encrypt_keys(const struct krb5_enctype *krb5,
+				const struct krb5_buffer *TK,
+				unsigned int usage,
+				struct krb5_buffer *setkey,
+				gfp_t gfp);
+int krb5enc_load_encrypt_keys(const struct krb5_enctype *krb5,
+			      const struct krb5_buffer *Ke,
+			      const struct krb5_buffer *Ki,
+			      struct krb5_buffer *setkey,
+			      gfp_t gfp);
+int rfc3961_derive_checksum_key(const struct krb5_enctype *krb5,
+				const struct krb5_buffer *TK,
+				unsigned int usage,
+				struct krb5_buffer *setkey,
+				gfp_t gfp);
+int rfc3961_load_checksum_key(const struct krb5_enctype *krb5,
+			      const struct krb5_buffer *Kc,
+			      struct krb5_buffer *setkey,
+			      gfp_t gfp);
diff --git a/crypto/krb5/rfc3961_simplified.c b/crypto/krb5/rfc3961_simplified.c
index 492ad85cdd56..d25fbd574dde 100644
--- a/crypto/krb5/rfc3961_simplified.c
+++ b/crypto/krb5/rfc3961_simplified.c
@@ -399,9 +399,117 @@ static int rfc3961_calc_PRF(const struct krb5_enctype *krb5,
 	return ret;
 }
 
+/*
+ * Derive the Ke and Ki keys and package them into a key parameter that can be
+ * given to the setkey of a krb5enc AEAD crypto object.
+ */
+int krb5enc_derive_encrypt_keys(const struct krb5_enctype *krb5,
+				const struct krb5_buffer *TK,
+				unsigned int usage,
+				struct krb5_buffer *setkey,
+				gfp_t gfp)
+{
+	struct krb5_buffer Ke, Ki;
+	__be32 *khdr = NULL;
+	int ret;
+
+	Ke.len  = krb5->Ke_len;
+	Ki.len  = krb5->Ki_len;
+	setkey->len = sizeof(__be32) * 3 + krb5->Ke_len + krb5->Ki_len;
+	setkey->data = kzalloc(setkey->len, GFP_KERNEL);
+	if (!setkey->data)
+		return -ENOMEM;
+
+	khdr = setkey->data;
+	Ke.data = setkey->data + 12;
+	Ki.data = setkey->data + 12 + Ke.len;
+
+	khdr[0] = htonl(1); /* Format 1 */
+	khdr[1] = htonl(Ke.len);
+	khdr[2] = htonl(Ki.len);
+
+	ret = krb5_derive_Ke(krb5, TK, usage, &Ke, gfp);
+	if (ret < 0) {
+		pr_err("get_Ke failed %d\n", ret);
+		return ret;
+	}
+	ret = krb5_derive_Ki(krb5, TK, usage, &Ki, gfp);
+	if (ret < 0)
+		pr_err("get_Ki failed %d\n", ret);
+	return ret;
+}
+
+/*
+ * Package predefined Ke and Ki keys and into a key parameter that can be given
+ * to the setkey of a krb5enc AEAD crypto object.
+ */
+int krb5enc_load_encrypt_keys(const struct krb5_enctype *krb5,
+			      const struct krb5_buffer *Ke,
+			      const struct krb5_buffer *Ki,
+			      struct krb5_buffer *setkey,
+			      gfp_t gfp)
+{
+	__be32 *khdr = NULL;
+
+	setkey->len = sizeof(__be32) * 3 + Ke->len + Ki->len;
+	setkey->data = kzalloc(setkey->len, GFP_KERNEL);
+	if (!setkey->data)
+		return -ENOMEM;
+
+	khdr = setkey->data;
+	khdr[0] = htonl(1); /* Format 1 */
+	khdr[1] = htonl(Ke->len);
+	khdr[2] = htonl(Ki->len);
+	memcpy(setkey->data + 12, Ke->data, Ke->len);
+	memcpy(setkey->data + 12 + Ke->len, Ki->data, Ki->len);
+	return 0;
+}
+
+/*
+ * Derive the Kc key for checksum-only mode and package it into a key parameter
+ * that can be given to the setkey of a hash crypto object.
+ */
+int rfc3961_derive_checksum_key(const struct krb5_enctype *krb5,
+				const struct krb5_buffer *TK,
+				unsigned int usage,
+				struct krb5_buffer *setkey,
+				gfp_t gfp)
+{
+	int ret;
+
+	setkey->len = krb5->Kc_len;
+	setkey->data = kzalloc(setkey->len, GFP_KERNEL);
+	if (!setkey->data)
+		return -ENOMEM;
+
+	ret = krb5_derive_Kc(krb5, TK, usage, setkey, gfp);
+	if (ret < 0)
+		pr_err("get_Kc failed %d\n", ret);
+	return ret;
+}
+
+/*
+ * Package a predefined Kc key for checksum-only mode into a key parameter that
+ * can be given to the setkey of a hash crypto object.
+ */
+int rfc3961_load_checksum_key(const struct krb5_enctype *krb5,
+			      const struct krb5_buffer *Kc,
+			      struct krb5_buffer *setkey,
+			      gfp_t gfp)
+{
+	setkey->len = krb5->Kc_len;
+	setkey->data = kmemdup(Kc->data, Kc->len, GFP_KERNEL);
+	if (!setkey->data)
+		return -ENOMEM;
+	return 0;
+}
 const struct krb5_crypto_profile rfc3961_simplified_profile = {
-	.calc_PRF	= rfc3961_calc_PRF,
-	.calc_Kc	= rfc3961_calc_DK,
-	.calc_Ke	= rfc3961_calc_DK,
-	.calc_Ki	= rfc3961_calc_DK,
+	.calc_PRF		= rfc3961_calc_PRF,
+	.calc_Kc		= rfc3961_calc_DK,
+	.calc_Ke		= rfc3961_calc_DK,
+	.calc_Ki		= rfc3961_calc_DK,
+	.derive_encrypt_keys	= krb5enc_derive_encrypt_keys,
+	.load_encrypt_keys	= krb5enc_load_encrypt_keys,
+	.derive_checksum_key	= rfc3961_derive_checksum_key,
+	.load_checksum_key	= rfc3961_load_checksum_key,
 };


