Return-Path: <linux-fsdevel+bounces-40604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D37DAA25C70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D53E165CDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27F20C019;
	Mon,  3 Feb 2025 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJwTYAqW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AB20C005
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592709; cv=none; b=MrwO/Tg2WjWUIkKac4WX1ylX4marGHtH8jpSanOJU27FtWzZsJh/F8fN23gf9RLdAEhk8m3nvtt7XHkrti8yjKAYpYcasDeF/mm4ISPGX6IUdh0PX1o/96Nr90xHONpm6BLU0jok+HujvGtpu3ufj5nI+jqa9ey8tFO2WnCfYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592709; c=relaxed/simple;
	bh=Qw/Sma+CBBokNwJ0XijE0D2DNFyH4az78phn7M0GCXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbJ42kIwngVUHY2h3w3PVPHCY34zUCQSof9Q98eenZZHvr9YMxuHMo4gjXWXQyko/rv4IQtPekD0o2eDqUe4Cg3lToKFCce6y+OWM5DTKBYGF9iNi+yCZIQIHcyk9wzPznY7kBjFI1vMxHyoygzBEOZ3uauCx0oxBugc2tcdzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJwTYAqW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6pDzmRKHgDrFf04t/zNh/YCtB/xUtKLgvRfSe5z6dI=;
	b=dJwTYAqWFSp2K5SSxvvsXY1CFPoGfFh0nbdUBhzEkSDZpWRTOC5Ztin06iX11MBzfFg65U
	z26saf64V7Q96X0gd7jcSlevvqvV85URpDh8qkUtvwNaLEb5uGXXpNdGASDbK7GqRw4DQy
	vqqPVucQtOEZZuHClpNF7EraAQlQDc0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-U_kxBLLXNHqOdlHeOQVvcw-1; Mon,
 03 Feb 2025 09:25:03 -0500
X-MC-Unique: U_kxBLLXNHqOdlHeOQVvcw-1
X-Mimecast-MFC-AGG-ID: U_kxBLLXNHqOdlHeOQVvcw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E173919560B4;
	Mon,  3 Feb 2025 14:25:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D746180097D;
	Mon,  3 Feb 2025 14:24:57 +0000 (UTC)
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
Subject: [PATCH net 11/24] crypto/krb5: Provide RFC3961 setkey packaging functions
Date: Mon,  3 Feb 2025 14:23:27 +0000
Message-ID: <20250203142343.248839-12-dhowells@redhat.com>
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
 crypto/krb5/internal.h           |  20 +++++
 crypto/krb5/rfc3961_simplified.c | 122 ++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index 7d60977dc0c5..ae00588619a8 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -136,3 +136,23 @@ int krb5_derive_Ki(const struct krb5_enctype *krb5, const struct krb5_buffer *TK
  * rfc3961_simplified.c
  */
 extern const struct krb5_crypto_profile rfc3961_simplified_profile;
+
+int authenc_derive_encrypt_keys(const struct krb5_enctype *krb5,
+				const struct krb5_buffer *TK,
+				unsigned int usage,
+				struct krb5_buffer *setkey,
+				gfp_t gfp);
+int authenc_load_encrypt_keys(const struct krb5_enctype *krb5,
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
index 75eafba059c7..335c5bb6904f 100644
--- a/crypto/krb5/rfc3961_simplified.c
+++ b/crypto/krb5/rfc3961_simplified.c
@@ -68,6 +68,8 @@
 
 #include <linux/slab.h>
 #include <linux/lcm.h>
+#include <linux/rtnetlink.h>
+#include <crypto/authenc.h>
 #include <crypto/skcipher.h>
 #include <crypto/hash.h>
 #include "internal.h"
@@ -399,9 +401,121 @@ static int rfc3961_calc_PRF(const struct krb5_enctype *krb5,
 	return ret;
 }
 
+/*
+ * Derive the Ke and Ki keys and package them into a key parameter that can be
+ * given to the setkey of a authenc AEAD crypto object.
+ */
+int authenc_derive_encrypt_keys(const struct krb5_enctype *krb5,
+				const struct krb5_buffer *TK,
+				unsigned int usage,
+				struct krb5_buffer *setkey,
+				gfp_t gfp)
+{
+	struct crypto_authenc_key_param *param;
+	struct krb5_buffer Ke, Ki;
+	struct rtattr *rta;
+	int ret;
+
+	Ke.len  = krb5->Ke_len;
+	Ki.len  = krb5->Ki_len;
+	setkey->len = RTA_LENGTH(sizeof(*param)) + Ke.len + Ki.len;
+	setkey->data = kzalloc(setkey->len, GFP_KERNEL);
+	if (!setkey->data)
+		return -ENOMEM;
+
+	rta = setkey->data;
+	rta->rta_type = CRYPTO_AUTHENC_KEYA_PARAM;
+	rta->rta_len = RTA_LENGTH(sizeof(*param));
+	param = RTA_DATA(rta);
+	param->enckeylen = htonl(Ke.len);
+
+	Ki.data = (void *)(param + 1);
+	Ke.data = Ki.data + Ki.len;
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
+ * to the setkey of an authenc AEAD crypto object.
+ */
+int authenc_load_encrypt_keys(const struct krb5_enctype *krb5,
+			      const struct krb5_buffer *Ke,
+			      const struct krb5_buffer *Ki,
+			      struct krb5_buffer *setkey,
+			      gfp_t gfp)
+{
+	struct crypto_authenc_key_param *param;
+	struct rtattr *rta;
+
+	setkey->len = RTA_LENGTH(sizeof(*param)) + Ke->len + Ki->len;
+	setkey->data = kzalloc(setkey->len, GFP_KERNEL);
+	if (!setkey->data)
+		return -ENOMEM;
+
+	rta = setkey->data;
+	rta->rta_type = CRYPTO_AUTHENC_KEYA_PARAM;
+	rta->rta_len = RTA_LENGTH(sizeof(*param));
+	param = RTA_DATA(rta);
+	param->enckeylen = htonl(Ke->len);
+	memcpy((void *)(param + 1), Ki->data, Ki->len);
+	memcpy((void *)(param + 1) + Ki->len, Ke->data, Ke->len);
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
+	.derive_encrypt_keys	= authenc_derive_encrypt_keys,
+	.load_encrypt_keys	= authenc_load_encrypt_keys,
+	.derive_checksum_key	= rfc3961_derive_checksum_key,
+	.load_checksum_key	= rfc3961_load_checksum_key,
 };


