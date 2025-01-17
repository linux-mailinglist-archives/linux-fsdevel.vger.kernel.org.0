Return-Path: <linux-fsdevel+bounces-39532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF7BA15726
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC54168519
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DE71A8F84;
	Fri, 17 Jan 2025 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoVovhxa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5423F1E0091
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139040; cv=none; b=OuhJXMXdvAP10Ck44ZD34/lxDMS0Dw/zoB7GbhI4LMOPEQK03V0BujprJVDDKcp67wfh1Knx+Ov2EzStfuPasfJGtjglrxShhkoZxNHQjaAHEKI/SMEYG+jq1bi8iyc7o4+dzdJQHb3vZsjnO9zHkz7oySNEw2ikmTFWjyX65N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139040; c=relaxed/simple;
	bh=AcjzwFfER9fAVxq3SyROBl1zIyoplV2SVDljZfoZeFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xkj4Fe73IFM/vAscI7/uWz1VszkQPvPiiv/sUUi2i9JNXJwSJ5CMfSMWZxeqbSsETjuxGxw9gwB3fpf5h1DdKIlZVEPcYmFFPyCOlJ/8wGZnLBI8TbuIM5oh9gMHiB05x1cthbvdWyUWNh1udcY8ig4EPI8risamCa0AjtKTOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GoVovhxa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDKG3K16UoaY78bdEX3PXrnLUR+2z6e/POcbWX8aB1Y=;
	b=GoVovhxaYOkhXXcnHXt11JooZYFQpiWaDM4FEms7v8eQ8HAEEZOiOVkhXMntcNIvftgRe0
	D3yYK9E8fcJaGVBabt+553N7HaGum+eJ9lkRRl2WCFCpcbqRLlZp+gnlSgp5iNpevJV1cw
	v27uCciIq4ULSy+P8rEMNR6BvuCs0a8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-xvjxmQz0NB-uC4TtOfOwCw-1; Fri,
 17 Jan 2025 13:37:11 -0500
X-MC-Unique: xvjxmQz0NB-uC4TtOfOwCw-1
X-Mimecast-MFC-AGG-ID: xvjxmQz0NB-uC4TtOfOwCw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60F99195608A;
	Fri, 17 Jan 2025 18:37:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 120C819560BF;
	Fri, 17 Jan 2025 18:37:04 +0000 (UTC)
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
Subject: [RFC PATCH 14/24] crypto/krb5: Implement the AES enctypes from rfc3962
Date: Fri, 17 Jan 2025 18:35:23 +0000
Message-ID: <20250117183538.881618-15-dhowells@redhat.com>
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

Implement the aes128-cts-hmac-sha1-96 and aes256-cts-hmac-sha1-96 enctypes
from rfc3962, using the rfc3961 kerberos 5 simplified crypto scheme.

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
 crypto/krb5/Kconfig       |   1 +
 crypto/krb5/Makefile      |   3 +-
 crypto/krb5/internal.h    |   6 ++
 crypto/krb5/krb5_api.c    |   2 +
 crypto/krb5/rfc3962_aes.c | 115 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 crypto/krb5/rfc3962_aes.c

diff --git a/crypto/krb5/Kconfig b/crypto/krb5/Kconfig
index 079873618abf..2ad874990dc8 100644
--- a/crypto/krb5/Kconfig
+++ b/crypto/krb5/Kconfig
@@ -5,6 +5,7 @@ config CRYPTO_KRB5
 	select CRYPTO_AUTHENC
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH_INFO
+	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_CBC
 	select CRYPTO_CTS
diff --git a/crypto/krb5/Makefile b/crypto/krb5/Makefile
index 8dad8e3bf086..35f21411abf8 100644
--- a/crypto/krb5/Makefile
+++ b/crypto/krb5/Makefile
@@ -6,6 +6,7 @@
 krb5-y += \
 	krb5_kdf.o \
 	krb5_api.o \
-	rfc3961_simplified.o
+	rfc3961_simplified.o \
+	rfc3962_aes.o
 
 obj-$(CONFIG_CRYPTO_KRB5) += krb5.o
diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index eaaa9c13c8b3..267ca978bda5 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -179,3 +179,9 @@ int rfc3961_verify_mic(const struct krb5_enctype *krb5,
 		       const struct krb5_buffer *metadata,
 		       struct scatterlist *sg, unsigned int nr_sg,
 		       size_t *_offset, size_t *_len);
+
+/*
+ * rfc3962_aes.c
+ */
+extern const struct krb5_enctype krb5_aes128_cts_hmac_sha1_96;
+extern const struct krb5_enctype krb5_aes256_cts_hmac_sha1_96;
diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index 8fc3a1b9d4ad..ecc6655953d5 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -17,6 +17,8 @@ MODULE_AUTHOR("Red Hat, Inc.");
 MODULE_LICENSE("GPL");
 
 static const struct krb5_enctype *const krb5_supported_enctypes[] = {
+	&krb5_aes128_cts_hmac_sha1_96,
+	&krb5_aes256_cts_hmac_sha1_96,
 };
 
 /**
diff --git a/crypto/krb5/rfc3962_aes.c b/crypto/krb5/rfc3962_aes.c
new file mode 100644
index 000000000000..5cbf8f4638b9
--- /dev/null
+++ b/crypto/krb5/rfc3962_aes.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* rfc3962 Advanced Encryption Standard (AES) Encryption for Kerberos 5
+ *
+ * Parts borrowed from net/sunrpc/auth_gss/.
+ */
+/*
+ * COPYRIGHT (c) 2008
+ * The Regents of the University of Michigan
+ * ALL RIGHTS RESERVED
+ *
+ * Permission is granted to use, copy, create derivative works
+ * and redistribute this software and such derivative works
+ * for any purpose, so long as the name of The University of
+ * Michigan is not used in any advertising or publicity
+ * pertaining to the use of distribution of this software
+ * without specific, written prior authorization.  If the
+ * above copyright notice or any other identification of the
+ * University of Michigan is included in any copy of any
+ * portion of this software, then the disclaimer below must
+ * also be included.
+ *
+ * THIS SOFTWARE IS PROVIDED AS IS, WITHOUT REPRESENTATION
+ * FROM THE UNIVERSITY OF MICHIGAN AS TO ITS FITNESS FOR ANY
+ * PURPOSE, AND WITHOUT WARRANTY BY THE UNIVERSITY OF
+ * MICHIGAN OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING
+ * WITHOUT LIMITATION THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
+ * REGENTS OF THE UNIVERSITY OF MICHIGAN SHALL NOT BE LIABLE
+ * FOR ANY DAMAGES, INCLUDING SPECIAL, INDIRECT, INCIDENTAL, OR
+ * CONSEQUENTIAL DAMAGES, WITH RESPECT TO ANY CLAIM ARISING
+ * OUT OF OR IN CONNECTION WITH THE USE OF THE SOFTWARE, EVEN
+ * IF IT HAS BEEN OR IS HEREAFTER ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGES.
+ */
+
+/*
+ * Copyright (C) 1998 by the FundsXpress, INC.
+ *
+ * All rights reserved.
+ *
+ * Export of this software from the United States of America may require
+ * a specific license from the United States Government.  It is the
+ * responsibility of any person or organization contemplating export to
+ * obtain such a license before exporting.
+ *
+ * WITHIN THAT CONSTRAINT, permission to use, copy, modify, and
+ * distribute this software and its documentation for any purpose and
+ * without fee is hereby granted, provided that the above copyright
+ * notice appear in all copies and that both that copyright notice and
+ * this permission notice appear in supporting documentation, and that
+ * the name of FundsXpress. not be used in advertising or publicity pertaining
+ * to distribution of the software without specific, written prior
+ * permission.  FundsXpress makes no representations about the suitability of
+ * this software for any purpose.  It is provided "as is" without express
+ * or implied warranty.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+/*
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "internal.h"
+
+const struct krb5_enctype krb5_aes128_cts_hmac_sha1_96 = {
+	.etype		= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+	.ctype		= KRB5_CKSUMTYPE_HMAC_SHA1_96_AES128,
+	.name		= "aes128-cts-hmac-sha1-96",
+	.encrypt_name	= "krb5enc(hmac(sha1),cts(cbc(aes)))",
+	.cksum_name	= "hmac(sha1)",
+	.hash_name	= "sha1",
+	.derivation_enc	= "cts(cbc(aes))",
+	.key_bytes	= 16,
+	.key_len	= 16,
+	.Kc_len		= 16,
+	.Ke_len		= 16,
+	.Ki_len		= 16,
+	.block_len	= 16,
+	.conf_len	= 16,
+	.cksum_len	= 12,
+	.hash_len	= 20,
+	.prf_len	= 16,
+	.keyed_cksum	= true,
+	.random_to_key	= NULL, /* Identity */
+	.profile	= &rfc3961_simplified_profile,
+};
+
+const struct krb5_enctype krb5_aes256_cts_hmac_sha1_96 = {
+	.etype		= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA1_96,
+	.ctype		= KRB5_CKSUMTYPE_HMAC_SHA1_96_AES256,
+	.name		= "aes256-cts-hmac-sha1-96",
+	.encrypt_name	= "krb5enc(hmac(sha1),cts(cbc(aes)))",
+	.cksum_name	= "hmac(sha1)",
+	.hash_name	= "sha1",
+	.derivation_enc	= "cts(cbc(aes))",
+	.key_bytes	= 32,
+	.key_len	= 32,
+	.Kc_len		= 32,
+	.Ke_len		= 32,
+	.Ki_len		= 32,
+	.block_len	= 16,
+	.conf_len	= 16,
+	.cksum_len	= 12,
+	.hash_len	= 20,
+	.prf_len	= 16,
+	.keyed_cksum	= true,
+	.random_to_key	= NULL, /* Identity */
+	.profile	= &rfc3961_simplified_profile,
+};


