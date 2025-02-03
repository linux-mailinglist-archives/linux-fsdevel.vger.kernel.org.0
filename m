Return-Path: <linux-fsdevel+bounces-40595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840CA25C44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D061162DE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E8209F32;
	Mon,  3 Feb 2025 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmDqne8v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F5209F2A
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592653; cv=none; b=aVyc7dMfZkVPlr39b+gWoClywDY3Jg893gXVH1uoU06mIimh0/6rzWU4bipnKhl7Raq5ilV0iV6FQhYnR3N05zZ2+0F+4uBbczKmStDqvyqxZfR3MUsXYKhCzJ2oD4qnVD+ZnBuWdaQam8HqihZY8lQaxXvQM4EvonKJ4ACuZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592653; c=relaxed/simple;
	bh=qNxiEM8uhm37LF6NV4e1P/LFD4rW9d8EaIDk6n6HhMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJ9FIvKmX90AHKzAkkcu/hXSRloU0cqAeTw4l3hll+jVyLv4MHzCBYwBhIJopWYlOZRJB0RKaMb288Mcl1UlzNr6/j498H8sZQYGlLE1WWEAZp6u/KuYvLF8i+MqxHwefGD9rseSgGubxvvF3DXsztyypvx78LvEscvMj2ZzQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmDqne8v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7M0ZoKPUZ8W8gEwptp3YkannA7+5FXUbNwOx+ls5hvw=;
	b=JmDqne8vvSX/1egerctFE5SElC3B9dCavR265N0EAirljbPwpBlBy/ElaB3h5g8RToutzo
	LlHP1fqGAXCRzGOsJh6m5RfQ4h+VV8V9OJp++LGrW+/U9Uz5Sumt0NWxAbzg13QxsnRqDd
	bwHWwbEx5M7D0WXY2PqbVpHnfGwH3eo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-7bjX7N9TMm6pxhCLgPZSpA-1; Mon,
 03 Feb 2025 09:24:07 -0500
X-MC-Unique: 7bjX7N9TMm6pxhCLgPZSpA-1
X-Mimecast-MFC-AGG-ID: 7bjX7N9TMm6pxhCLgPZSpA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECBF71800266;
	Mon,  3 Feb 2025 14:24:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AFDB19560AD;
	Mon,  3 Feb 2025 14:24:00 +0000 (UTC)
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
Subject: [PATCH net 02/24] crypto/krb5: Add some constants out of sunrpc headers
Date: Mon,  3 Feb 2025 14:23:18 +0000
Message-ID: <20250203142343.248839-3-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add some constants from the sunrpc headers.

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
 include/crypto/krb5.h | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 include/crypto/krb5.h

diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
new file mode 100644
index 000000000000..44a6342471d7
--- /dev/null
+++ b/include/crypto/krb5.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Kerberos 5 crypto
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _CRYPTO_KRB5_H
+#define _CRYPTO_KRB5_H
+
+/*
+ * Per Kerberos v5 protocol spec crypto types from the wire.  These get mapped
+ * to linux kernel crypto routines.
+ */
+#define KRB5_ENCTYPE_NULL			0x0000
+#define KRB5_ENCTYPE_DES_CBC_CRC		0x0001	/* DES cbc mode with CRC-32 */
+#define KRB5_ENCTYPE_DES_CBC_MD4		0x0002	/* DES cbc mode with RSA-MD4 */
+#define KRB5_ENCTYPE_DES_CBC_MD5		0x0003	/* DES cbc mode with RSA-MD5 */
+#define KRB5_ENCTYPE_DES_CBC_RAW		0x0004	/* DES cbc mode raw */
+/* XXX deprecated? */
+#define KRB5_ENCTYPE_DES3_CBC_SHA		0x0005	/* DES-3 cbc mode with NIST-SHA */
+#define KRB5_ENCTYPE_DES3_CBC_RAW		0x0006	/* DES-3 cbc mode raw */
+#define KRB5_ENCTYPE_DES_HMAC_SHA1		0x0008
+#define KRB5_ENCTYPE_DES3_CBC_SHA1		0x0010
+#define KRB5_ENCTYPE_AES128_CTS_HMAC_SHA1_96	0x0011
+#define KRB5_ENCTYPE_AES256_CTS_HMAC_SHA1_96	0x0012
+#define KRB5_ENCTYPE_ARCFOUR_HMAC		0x0017
+#define KRB5_ENCTYPE_ARCFOUR_HMAC_EXP		0x0018
+#define KRB5_ENCTYPE_UNKNOWN			0x01ff
+
+#define KRB5_CKSUMTYPE_CRC32			0x0001
+#define KRB5_CKSUMTYPE_RSA_MD4			0x0002
+#define KRB5_CKSUMTYPE_RSA_MD4_DES		0x0003
+#define KRB5_CKSUMTYPE_DESCBC			0x0004
+#define KRB5_CKSUMTYPE_RSA_MD5			0x0007
+#define KRB5_CKSUMTYPE_RSA_MD5_DES		0x0008
+#define KRB5_CKSUMTYPE_NIST_SHA			0x0009
+#define KRB5_CKSUMTYPE_HMAC_SHA1_DES3		0x000c
+#define KRB5_CKSUMTYPE_HMAC_SHA1_96_AES128	0x000f
+#define KRB5_CKSUMTYPE_HMAC_SHA1_96_AES256	0x0010
+#define KRB5_CKSUMTYPE_HMAC_MD5_ARCFOUR		-138 /* Microsoft md5 hmac cksumtype */
+
+/*
+ * Constants used for key derivation
+ */
+/* from rfc3961 */
+#define KEY_USAGE_SEED_CHECKSUM         (0x99)
+#define KEY_USAGE_SEED_ENCRYPTION       (0xAA)
+#define KEY_USAGE_SEED_INTEGRITY        (0x55)
+
+#endif /* _CRYPTO_KRB5_H */


