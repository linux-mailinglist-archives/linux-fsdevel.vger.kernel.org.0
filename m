Return-Path: <linux-fsdevel+bounces-38766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCE3A08445
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159203A6527
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 01:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAE11C5F27;
	Fri, 10 Jan 2025 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJPhJYUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101321422AB
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471016; cv=none; b=gQzu7L7amtyUaGdaGQEu7Rn60bXDrmfkBHQtKjurcEqeFaM3E93hLnbQ0XE493LPLgClxh8TZH9qeYBaaMmg8A18ZWaKc0Pdwqgxf/GOYHz+pnCR2i0aH7olVNi5SJexgUQz/mhSIZ4GSDNsIYQJM3nt9TW89iD82t3xMPdYlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471016; c=relaxed/simple;
	bh=MaxCbLX24ue4X68UTRZOsEko64m40xqyXHZD2xlCEk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jne+AQ93TFYugb4GDxyTYGtzeu1cWzR3BRhAr5fcwFH2x5eBliHekon3NM9TkcrY8Hi0QmgqulJ1lPD0ZAJFNaqM2M2P8A32oa5a+MbkTuuPGK0TluhrFWAkIQFhkQ/8PTZthgfOjIKck44/E75UIPIy/5x9Fc+9D2+8iv6S3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJPhJYUe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736471014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUzBwBZc7jiA0yAEpdkGwHRc8LI1eQmwaezuF6/wCmw=;
	b=jJPhJYUe47IZDGHwbNE4EfLOknLUl0qp9KZ6nLhA0SzeK+JKDNF5UpmnxhwyI+uUL1+DAt
	Cj0Pj/psMiO1qqR06qHZtDRfCGtVeDAUI1qZdgodifjFSxYDm3CZRxePdApXWPevgE+ATP
	0b/2Ia5DBUDmVnOSVYtcR0+gWaqI2Z4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-VLgKQHyPNxCrGzeDt1f_mg-1; Thu,
 09 Jan 2025 20:03:29 -0500
X-MC-Unique: VLgKQHyPNxCrGzeDt1f_mg-1
X-Mimecast-MFC-AGG-ID: VLgKQHyPNxCrGzeDt1f_mg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AC3319560A1;
	Fri, 10 Jan 2025 01:03:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35582195E3E0;
	Fri, 10 Jan 2025 01:03:22 +0000 (UTC)
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
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/8] crypto/krb5: Add some constants out of sunrpc headers
Date: Fri, 10 Jan 2025 01:03:03 +0000
Message-ID: <20250110010313.1471063-2-dhowells@redhat.com>
In-Reply-To: <20250110010313.1471063-1-dhowells@redhat.com>
References: <20250110010313.1471063-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
 include/crypto/krb5.h | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 include/crypto/krb5.h

diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
new file mode 100644
index 000000000000..05e80fad2b38
--- /dev/null
+++ b/include/crypto/krb5.h
@@ -0,0 +1,50 @@
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
+/* per Kerberos v5 protocol spec crypto types from the wire.
+ * these get mapped to linux kernel crypto routines.
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


