Return-Path: <linux-fsdevel+bounces-38768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C636EA08451
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4B416729D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 01:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D8C204C35;
	Fri, 10 Jan 2025 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8X4HPcW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B461E25EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471034; cv=none; b=PlXHVBjSuAcpXwSMkoOw3KJ8UMa0O8rMN843BQMRyVe1BkrmQRVSvvE5Km0O5CXab7y23AXN+L1820qdyVotaG3QNdxIiClCX+YsQZwEWN26PyYeclFTQJFSTzKJrQJV/1w/K7dK2diJ8FS+p8PeTDZ4ANthtAmMTpnjR8TwJY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471034; c=relaxed/simple;
	bh=RyQRSs0XcRS5II/f+B+N88e2b+kw8Oildn+CZsT9+ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj5R+w6A+A4zwfIzKitEWDYtE+ZiC26RsiIOEp8POg0HksUwvVdfRfrvVZh5NZyV78RNnhMdFlCp0lA2FuKA26mveoUmpR/Z/S5ZMgAXuowaDr4ECWo62R8HItaCa24cwYqoSfBVX7LAJPvQuAYDIi0TD2IrZ7t/UlwGozMUwF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8X4HPcW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736471029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa1OBjLx4mDzEeT5HD0qu7BJLifxbXY/Qt37I0Y8vQE=;
	b=f8X4HPcWl9M8t7i2gJMGwGbLDHxCEMUFWDo53MN0FoZ2wF23M0cA+3Obea8eibRq4m4wWR
	JlhR4H1knCnqy/e6qFYwpNeH+6fPJNlulmJLumIWGfKiq6J8mt1dkDD59CtXquzQjmvzXI
	VQ9CsSdrMXWgTVt7gecfI/sqdI3jHQE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-mEdFelAqM-yIqWsb8HnyaA-1; Thu,
 09 Jan 2025 20:03:44 -0500
X-MC-Unique: mEdFelAqM-yIqWsb8HnyaA-1
X-Mimecast-MFC-AGG-ID: mEdFelAqM-yIqWsb8HnyaA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 720361956056;
	Fri, 10 Jan 2025 01:03:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2814C1955BE3;
	Fri, 10 Jan 2025 01:03:35 +0000 (UTC)
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
Subject: [RFC PATCH 3/8] crypto/krb5: Test manager data
Date: Fri, 10 Jan 2025 01:03:05 +0000
Message-ID: <20250110010313.1471063-4-dhowells@redhat.com>
In-Reply-To: <20250110010313.1471063-1-dhowells@redhat.com>
References: <20250110010313.1471063-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add Kerberos crypto tests to the test manager database.  This covers:

	camellia128-cts-cmac		samples from RFC6803
	camellia256-cts-cmac		samples from RFC6803
	aes128-cts-hmac-sha256-128	samples from RFC8009
	aes256-cts-hmac-sha384-192	samples from RFC8009

but not:

	aes128-cts-hmac-sha1-96
	aes256-cts-hmac-sha1-96

as the test samples in RFC3962 don't seem to be suitable.

Note that the test manager makes some assumptions about AEAD algorithm type
that would otherwise prevent testing the kerberos algorithms.  The problem
is that the test manager assumes that if there's a difference between the
length of the plain text and the cipher text supplied in the test vector,
then the extra data is the authentication tag - but these aren't applicable
here.

This is worked around by adding a flag in the AEAD algorithm definition
that causes EINVAL be returned unconditionally if anyone tries to set the
auth tag length.

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
 crypto/aead.c           |   2 +
 crypto/krb5/krb5_aead.c |   8 +-
 crypto/testmgr.c        |  24 +++
 crypto/testmgr.h        | 456 ++++++++++++++++++++++++++++++++++++++++
 include/crypto/aead.h   |   2 +
 5 files changed, 491 insertions(+), 1 deletion(-)

diff --git a/crypto/aead.c b/crypto/aead.c
index cade532413bf..fb23557cd09a 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -65,6 +65,8 @@ int crypto_aead_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
 {
 	int err;
 
+	if (crypto_aead_alg(tfm)->no_authtags)
+		return -EINVAL;
 	if ((!authsize && crypto_aead_maxauthsize(tfm)) ||
 	    authsize > crypto_aead_maxauthsize(tfm))
 		return -EINVAL;
diff --git a/crypto/krb5/krb5_aead.c b/crypto/krb5/krb5_aead.c
index 2c8b3921e976..453b16a17ca9 100644
--- a/crypto/krb5/krb5_aead.c
+++ b/crypto/krb5/krb5_aead.c
@@ -201,6 +201,7 @@ static struct krb5_enctype krb5_enctypes[] = {
 		.aead.ivsize		= 0,
 		.aead.maxauthsize	= 0,
 		.aead.chunksize		= 16,
+		.aead.no_authtags	= true,
 
 		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
 		.aead.base.cra_blocksize	= 1,
@@ -238,6 +239,7 @@ static struct krb5_enctype krb5_enctypes[] = {
 		.aead.ivsize		= 0,
 		.aead.maxauthsize	= 0,
 		.aead.chunksize		= 16,
+		.aead.no_authtags	= true,
 
 		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
 		.aead.base.cra_blocksize	= 1,
@@ -275,6 +277,7 @@ static struct krb5_enctype krb5_enctypes[] = {
 		.aead.ivsize		= 0,
 		.aead.maxauthsize	= 0,
 		.aead.chunksize		= 16,
+		.aead.no_authtags	= true,
 
 		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
 		.aead.base.cra_blocksize	= 1,
@@ -312,6 +315,7 @@ static struct krb5_enctype krb5_enctypes[] = {
 		.aead.ivsize		= 0,
 		.aead.maxauthsize	= 0,
 		.aead.chunksize		= 16,
+		.aead.no_authtags	= true,
 
 		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
 		.aead.base.cra_blocksize	= 1,
@@ -349,6 +353,7 @@ static struct krb5_enctype krb5_enctypes[] = {
 		.aead.ivsize		= 0,
 		.aead.maxauthsize	= 0,
 		.aead.chunksize		= 16,
+		.aead.no_authtags	= true,
 
 		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
 		.aead.base.cra_blocksize	= 1,
@@ -356,7 +361,7 @@ static struct krb5_enctype krb5_enctypes[] = {
 		.aead.base.cra_alignmask	= 0,
 		.aead.base.cra_priority		= 100,
 		.aead.base.cra_name		= "krb5-aes128-cts-hmac-sha256-128",
-		.aead.base.cra_driver_name	= "krb5-aes128-cts-hmac-sha256-128generic",
+		.aead.base.cra_driver_name	= "krb5-aes128-cts-hmac-sha256-128-generic",
 		.aead.base.cra_module		= THIS_MODULE,
 	}, {
 		.etype			= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
@@ -386,6 +391,7 @@ static struct krb5_enctype krb5_enctypes[] = {
 		.aead.ivsize		= 0,
 		.aead.maxauthsize	= 0,
 		.aead.chunksize		= 16,
+		.aead.no_authtags	= true,
 
 		.aead.base.cra_flags		= CRYPTO_ALG_ALLOCATES_MEMORY,
 		.aead.base.cra_blocksize	= 1,
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 1f5f48ab18c7..6e4cf8427e4e 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5408,6 +5408,30 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "jitterentropy_rng",
 		.fips_allowed = 1,
 		.test = alg_test_null,
+	}, {
+		.alg = "krb5-aes128-cts-hmac-sha256-128",
+		.test = alg_test_aead,
+		.suite = {
+			.aead = __VECS(krb5_test_aes128_cts_hmac_sha256_128)
+		}
+	}, {
+		.alg = "krb5-aes256-cts-hmac-sha384-192",
+		.test = alg_test_aead,
+		.suite = {
+			.aead = __VECS(krb5_test_aes256_cts_hmac_sha384_192)
+		}
+	}, {
+		.alg = "krb5-camellia128-cts-cmac",
+		.test = alg_test_aead,
+		.suite = {
+			.aead = __VECS(krb5_test_camellia128_cts_cmac)
+		}
+	}, {
+		.alg = "krb5-camellia256-cts-cmac",
+		.test = alg_test_aead,
+		.suite = {
+			.aead = __VECS(krb5_test_camellia256_cts_cmac)
+		}
 	}, {
 		.alg = "kw(aes)",
 		.test = alg_test_skcipher,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 430d33d9ac13..12c550248a15 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -39086,4 +39086,460 @@ static const struct cipher_testvec aes_hctr2_tv_template[] = {
 
 };
 
+static const struct aead_testvec krb5_test_aes128_cts_hmac_sha256_128[] = {
+	/* rfc8009 Appendix A */
+	{
+		/* "enc no plain" */
+		.key	=
+		"\x00\x00\x00\x03" // KRB5_ENCRYPT_MODE_KEKI
+		"\x00\x00\x00\x00" // Usage
+		"\x9B\x19\x7D\xD1\xE8\xC5\x60\x9D\x6E\x67\xC3\xE3\x7C\x62\xC7\x2E" // Ke
+		"\x9F\xDA\x0E\x56\xAB\x2D\x85\xE1\x56\x9A\x68\x86\x96\xC2\x6A\x6C", // Ki
+		.klen	= 4 + 4 + 16 + 16,
+		.ptext	=
+		"\x7E\x58\x95\xEA\xF2\x67\x24\x35\xBA\xD8\x17\xF5\x45\xA3\x71\x48" // Confounder
+		"", // Plain
+		.plen	= 16 + 0,
+		.ctext	=
+		"\xEF\x85\xFB\x89\x0B\xB8\x47\x2F\x4D\xAB\x20\x39\x4D\xCA\x78\x1D"
+		"\xAD\x87\x7E\xDA\x39\xD5\x0C\x87\x0C\x0D\x5A\x0A\x8E\x48\xC7\x18",
+		.clen	= 16 + 0 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		/* "enc plain<block" */
+		.key	=
+		"\x00\x00\x00\x03" // KRB5_ENCRYPT_MODE_KEKI
+		"\x00\x00\x00\x00" // Usage
+		"\x9B\x19\x7D\xD1\xE8\xC5\x60\x9D\x6E\x67\xC3\xE3\x7C\x62\xC7\x2E" // Ke
+		"\x9F\xDA\x0E\x56\xAB\x2D\x85\xE1\x56\x9A\x68\x86\x96\xC2\x6A\x6C", // Ki
+		.klen	= 4 + 4 + 16 + 16,
+		.ptext	=
+		"\x7B\xCA\x28\x5E\x2F\xD4\x13\x0F\xB5\x5B\x1A\x5C\x83\xBC\x5B\x24" // Confounder
+		"\x00\x01\x02\x03\x04\x05", // Plain
+		.plen	= 16 + 6,
+		.ctext	=
+		"\x84\xD7\xF3\x07\x54\xED\x98\x7B\xAB\x0B\xF3\x50\x6B\xEB\x09\xCF"
+		"\xB5\x54\x02\xCE\xF7\xE6\x87\x7C\xE9\x9E\x24\x7E\x52\xD1\x6E\xD4"
+		"\x42\x1D\xFD\xF8\x97\x6C",
+		.clen	= 16 + 6 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		/* "enc plain==block" */
+		.key	=
+		"\x00\x00\x00\x03" // KRB5_ENCRYPT_MODE_KEKI
+		"\x00\x00\x00\x00" // Usage
+		"\x9B\x19\x7D\xD1\xE8\xC5\x60\x9D\x6E\x67\xC3\xE3\x7C\x62\xC7\x2E" // Ke
+		"\x9F\xDA\x0E\x56\xAB\x2D\x85\xE1\x56\x9A\x68\x86\x96\xC2\x6A\x6C", // Ki
+		.klen	= 4 + 4 + 16 + 16,
+		.ptext	=
+		"\x56\xAB\x21\x71\x3F\xF6\x2C\x0A\x14\x57\x20\x0F\x6F\xA9\x94\x8F" // Confounder
+		"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F", // Plain
+		.plen	= 16 + 16,
+		.ctext	=
+		"\x35\x17\xD6\x40\xF5\x0D\xDC\x8A\xD3\x62\x87\x22\xB3\x56\x9D\x2A"
+		"\xE0\x74\x93\xFA\x82\x63\x25\x40\x80\xEA\x65\xC1\x00\x8E\x8F\xC2"
+		"\x95\xFB\x48\x52\xE7\xD8\x3E\x1E\x7C\x48\xC3\x7E\xEB\xE6\xB0\xD3",
+		.clen	= 16 + 16 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		/* "enc plain>block" */
+		.key	=
+		"\x00\x00\x00\x03" // KRB5_ENCRYPT_MODE_KEKI
+		"\x00\x00\x00\x00" // Usage
+		"\x9B\x19\x7D\xD1\xE8\xC5\x60\x9D\x6E\x67\xC3\xE3\x7C\x62\xC7\x2E" // Ke
+		"\x9F\xDA\x0E\x56\xAB\x2D\x85\xE1\x56\x9A\x68\x86\x96\xC2\x6A\x6C", // Ki
+		.klen	= 4 + 4 + 16 + 16,
+		.ptext	=
+		"\xA7\xA4\xE2\x9A\x47\x28\xCE\x10\x66\x4F\xB6\x4E\x49\xAD\x3F\xAC" // Confounder
+		"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
+		"\x10\x11\x12\x13\x14", // Plain
+		.plen	= 16 + 21,
+		.ctext	=
+		"\x72\x0F\x73\xB1\x8D\x98\x59\xCD\x6C\xCB\x43\x46\x11\x5C\xD3\x36"
+		"\xC7\x0F\x58\xED\xC0\xC4\x43\x7C\x55\x73\x54\x4C\x31\xC8\x13\xBC"
+		"\xE1\xE6\xD0\x72\xC1\x86\xB3\x9A\x41\x3C\x2F\x92\xCA\x9B\x83\x34"
+		"\xA2\x87\xFF\xCB\xFC",
+		.clen	= 16 + 21 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "mic"
+		.key	=
+		"\x00\x00\x00\x02" // KR5_ENCRYPT_MODE_KC
+		"\x00\x00\x00\x00" // Usage
+		"\xB3\x1A\x01\x8A\x48\xF5\x47\x76\xF4\x03\xE9\xA3\x96\x32\x5D\xC3", // Kc
+		.klen	= 4 + 4 + 16,
+		.ptext	=
+		"\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55" // MIC
+		"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
+		"\x10\x11\x12\x13\x14",
+		.plen	= 16 + 21,
+		.ctext	=
+		"\xD7\x83\x67\x18\x66\x43\xD6\x7B\x41\x1C\xBA\x91\x39\xFC\x1D\xEE" // MIC
+		"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
+		"\x10\x11\x12\x13\x14",
+		.clen	= 16 + 21,
+		.setauthsize_error = -EINVAL,
+	}
+};
+
+static const struct aead_testvec krb5_test_aes256_cts_hmac_sha384_192[] = {
+	/* rfc8009 Appendix A */
+	{
+		/* "enc no plain" */
+		.key	=
+		"\x00\x00\x00\x03" // KRB5_ENCRYPT_MODE_KEKI
+		"\x00\x00\x00\x00" // Usage
+		"\x56\xAB\x22\xBE\xE6\x3D\x82\xD7\xBC\x52\x27\xF6\x77\x3F\x8E\xA7"
+		"\xA5\xEB\x1C\x82\x51\x60\xC3\x83\x12\x98\x0C\x44\x2E\x5C\x7E\x49" // Ke
+		"\x69\xB1\x65\x14\xE3\xCD\x8E\x56\xB8\x20\x10\xD5\xC7\x30\x12\xB6"
+		"\x22\xC4\xD0\x0F\xFC\x23\xED\x1F", // Ki
+		.klen	= 4 + 4 + 32 + 24,
+		.ptext	=
+		"\xF7\x64\xE9\xFA\x15\xC2\x76\x47\x8B\x2C\x7D\x0C\x4E\x5F\x58\xE4" // Confounder
+		"", // Plain
+		.plen	= 16 + 0,
+		.ctext	=
+		"\x41\xF5\x3F\xA5\xBF\xE7\x02\x6D\x91\xFA\xF9\xBE\x95\x91\x95\xA0"
+		"\x58\x70\x72\x73\xA9\x6A\x40\xF0\xA0\x19\x60\x62\x1A\xC6\x12\x74"
+		"\x8B\x9B\xBF\xBE\x7E\xB4\xCE\x3C",
+		.clen	= 16 + 0 + 24,
+		.setauthsize_error = -EINVAL,
+	}, {
+		/* "enc plain<block" */
+		.key	=
+		"\x00\x00\x00\x03" // KRB5_ENCRYPT_MODE_KEKI
+		"\x00\x00\x00\x00" // Usage
+		"\x56\xAB\x22\xBE\xE6\x3D\x82\xD7\xBC\x52\x27\xF6\x77\x3F\x8E\xA7"
+		"\xA5\xEB\x1C\x82\x51\x60\xC3\x83\x12\x98\x0C\x44\x2E\x5C\x7E\x49" // Ke
+		"\x69\xB1\x65\x14\xE3\xCD\x8E\x56\xB8\x20\x10\xD5\xC7\x30\x12\xB6"
+		"\x22\xC4\xD0\x0F\xFC\x23\xED\x1F", // Ki
+		.klen	= 4 + 4 + 32 + 24,
+		.ptext	=
+		"\xB8\x0D\x32\x51\xC1\xF6\x47\x14\x94\x25\x6F\xFE\x71\x2D\x0B\x9A" // Confounder
+		"\x00\x01\x02\x03\x04\x05", // Plain
+		.plen	= 16 + 0,
+		.ctext	=
+		"\x4E\xD7\xB3\x7C\x2B\xCA\xC8\xF7\x4F\x23\xC1\xCF\x07\xE6\x2B\xC7"
+		"\xB7\x5F\xB3\xF6\x37\xB9\xF5\x59\xC7\xF6\x64\xF6\x9E\xAB\x7B\x60"
+		"\x92\x23\x75\x26\xEA\x0D\x1F\x61\xCB\x20\xD6\x9D\x10\xF2",
+		.clen	= 16 + 0 + 24,
+		.setauthsize_error = -EINVAL,
+	}, {
+		/* "enc plain==block" */
+		.key	=
+		"\x00\x00\x00\x03" // KRB5_ENCRYPT_MODE_KEKI
+		"\x00\x00\x00\x00" // Usage
+		"\x56\xAB\x22\xBE\xE6\x3D\x82\xD7\xBC\x52\x27\xF6\x77\x3F\x8E\xA7"
+		"\xA5\xEB\x1C\x82\x51\x60\xC3\x83\x12\x98\x0C\x44\x2E\x5C\x7E\x49" // Ke
+		"\x69\xB1\x65\x14\xE3\xCD\x8E\x56\xB8\x20\x10\xD5\xC7\x30\x12\xB6"
+		"\x22\xC4\xD0\x0F\xFC\x23\xED\x1F", // Ki
+		.klen	= 4 + 4 + 32 + 24,
+		.ptext	=
+		"\x53\xBF\x8A\x0D\x10\x52\x65\xD4\xE2\x76\x42\x86\x24\xCE\x5E\x63" // Confounder
+		"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F", // Plain
+		.plen	= 16 + 16,
+		.ctext	=
+		"\xBC\x47\xFF\xEC\x79\x98\xEB\x91\xE8\x11\x5C\xF8\xD1\x9D\xAC\x4B"
+		"\xBB\xE2\xE1\x63\xE8\x7D\xD3\x7F\x49\xBE\xCA\x92\x02\x77\x64\xF6"
+		"\x8C\xF5\x1F\x14\xD7\x98\xC2\x27\x3F\x35\xDF\x57\x4D\x1F\x93\x2E"
+		"\x40\xC4\xFF\x25\x5B\x36\xA2\x66",
+		.clen	= 16 + 16 + 24,
+		.setauthsize_error = -EINVAL,
+	}, {
+		/* "enc plain>block" */
+		.key	=
+		"\x00\x00\x00\x03" // KRB5_ENCRYPT_MODE_KEKI
+		"\x00\x00\x00\x00" // Usage
+		"\x56\xAB\x22\xBE\xE6\x3D\x82\xD7\xBC\x52\x27\xF6\x77\x3F\x8E\xA7"
+		"\xA5\xEB\x1C\x82\x51\x60\xC3\x83\x12\x98\x0C\x44\x2E\x5C\x7E\x49" // Ke
+		"\x69\xB1\x65\x14\xE3\xCD\x8E\x56\xB8\x20\x10\xD5\xC7\x30\x12\xB6"
+		"\x22\xC4\xD0\x0F\xFC\x23\xED\x1F", // Ki
+		.klen	= 4 + 4 + 32 + 24,
+		.ptext	=
+		"\x76\x3E\x65\x36\x7E\x86\x4F\x02\xF5\x51\x53\xC7\xE3\xB5\x8A\xF1" // Confounder
+		"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
+		"\x10\x11\x12\x13\x14", // Plain
+		.plen	= 16 + 21,
+		.ctext	=
+		"\x40\x01\x3E\x2D\xF5\x8E\x87\x51\x95\x7D\x28\x78\xBC\xD2\xD6\xFE"
+		"\x10\x1C\xCF\xD5\x56\xCB\x1E\xAE\x79\xDB\x3C\x3E\xE8\x64\x29\xF2"
+		"\xB2\xA6\x02\xAC\x86\xFE\xF6\xEC\xB6\x47\xD6\x29\x5F\xAE\x07\x7A"
+		"\x1F\xEB\x51\x75\x08\xD2\xC1\x6B\x41\x92\xE0\x1F\x62",
+		.clen	= 16 + 21 + 24,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "mic"
+		.key	=
+		"\x00\x00\x00\x02" // KR5_ENCRYPT_MODE_KC
+		"\x00\x00\x00\x00" // Usage
+		"\xEF\x57\x18\xBE\x86\xCC\x84\x96\x3D\x8B\xBB\x50\x31\xE9\xF5\xC4"
+		"\xBA\x41\xF2\x8F\xAF\x69\xE7\x3D", // Kc
+		.klen	= 4 + 4 + 24,
+		.ptext	=
+		"\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55"
+		"\xAA\x55\xAA\x55\xAA\x55\xAA\x55" // MIC
+		"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
+		"\x10\x11\x12\x13\x14",
+		.plen	= 24 + 21,
+		.ctext	=
+		"\x45\xEE\x79\x15\x67\xEE\xFC\xA3\x7F\x4A\xC1\xE0\x22\x2D\xE8\x0D"
+		"\x43\xC3\xBF\xA0\x66\x99\x67\x2A" // MIC
+		"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
+		"\x10\x11\x12\x13\x14",
+		.clen	= 24 + 21,
+		.setauthsize_error = -EINVAL,
+	}
+};
+
+static const struct aead_testvec krb5_test_camellia128_cts_cmac[] = {
+	/* rfc6803 sec 10 */
+	{
+		// "enc no plain"
+		.key	=
+		"\x00\x00\x00\x01" // KRB5_ENCRYPT_MODE
+		"\x00\x00\x00\x00" // Usage
+		"\x1D\xC4\x6A\x8D\x76\x3F\x4F\x93\x74\x2B\xCB\xA3\x38\x75\x76\xC3", // K0
+		.klen	= 4 + 4 + 16,
+		.ptext	=
+		"\xB6\x98\x22\xA1\x9A\x6B\x09\xC0\xEB\xC8\x55\x7D\x1F\x1B\x6C\x0A" // Confounder
+		"", // Plain
+		.plen	= 16 + 0,
+		.ctext	=
+		"\xC4\x66\xF1\x87\x10\x69\x92\x1E\xDB\x7C\x6F\xDE\x24\x4A\x52\xDB"
+		"\x0B\xA1\x0E\xDC\x19\x7B\xDB\x80\x06\x65\x8C\xA3\xCC\xCE\x6E\xB8",
+		.clen	= 16 + 0 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "enc 1 plain",
+		.key	=
+		"\x00\x00\x00\x01" // KRB5_ENCRYPT_MODE
+		"\x00\x00\x00\x01" // Usage
+		"\x50\x27\xBC\x23\x1D\x0F\x3A\x9D\x23\x33\x3F\x1C\xA6\xFD\xBE\x7C", // K0
+		.klen	= 4 + 4 + 16,
+		.ptext	=
+		"\x6F\x2F\xC3\xC2\xA1\x66\xFD\x88\x98\x96\x7A\x83\xDE\x95\x96\xD9" // Confounder
+		"1", // Plain
+		.plen	= 16 + 1,
+		.ctext	=
+		"\x84\x2D\x21\xFD\x95\x03\x11\xC0\xDD\x46\x4A\x3F\x4B\xE8\xD6\xDA"
+		"\x88\xA5\x6D\x55\x9C\x9B\x47\xD3\xF9\xA8\x50\x67\xAF\x66\x15\x59"
+		"\xB8",
+		.clen	= 16 + 1 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "enc 9 plain",
+		.key	=
+		"\x00\x00\x00\x01" // KRB5_ENCRYPT_MODE
+		"\x00\x00\x00\x02" // Usage
+		"\xA1\xBB\x61\xE8\x05\xF9\xBA\x6D\xDE\x8F\xDB\xDD\xC0\x5C\xDE\xA0", // K0
+		.klen	= 4 + 4 + 16,
+		.ptext	=
+		"\xA5\xB4\xA7\x1E\x07\x7A\xEE\xF9\x3C\x87\x63\xC1\x8F\xDB\x1F\x10" // Confounder
+		"9 bytesss", // Plain
+		.plen	= 16 + 9,
+		.ctext	=
+		"\x61\x9F\xF0\x72\xE3\x62\x86\xFF\x0A\x28\xDE\xB3\xA3\x52\xEC\x0D"
+		"\x0E\xDF\x5C\x51\x60\xD6\x63\xC9\x01\x75\x8C\xCF\x9D\x1E\xD3\x3D"
+		"\x71\xDB\x8F\x23\xAA\xBF\x83\x48\xA0",
+		.clen	= 16 + 9 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "enc 13 plain",
+		.key	=
+		"\x00\x00\x00\x01" // KRB5_ENCRYPT_MODE
+		"\x00\x00\x00\x03" // Usage
+		"\x2C\xA2\x7A\x5F\xAF\x55\x32\x24\x45\x06\x43\x4E\x1C\xEF\x66\x76", // K0
+		.klen	= 4 + 4 + 16,
+		.ptext	=
+		"\x19\xFE\xE4\x0D\x81\x0C\x52\x4B\x5B\x22\xF0\x18\x74\xC6\x93\xDA" // Confounder
+		"13 bytes byte", // Plain
+		.plen	= 16 + 13,
+		.ctext	=
+		"\xB8\xEC\xA3\x16\x7A\xE6\x31\x55\x12\xE5\x9F\x98\xA7\xC5\x00\x20"
+		"\x5E\x5F\x63\xFF\x3B\xB3\x89\xAF\x1C\x41\xA2\x1D\x64\x0D\x86\x15"
+		"\xC9\xED\x3F\xBE\xB0\x5A\xB6\xAC\xB6\x76\x89\xB5\xEA",
+		.clen	= 16 + 13 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "enc 30 plain",
+		.key	=
+		"\x00\x00\x00\x01" // KRB5_ENCRYPT_MODE
+		"\x00\x00\x00\x04" // Usage
+		"\x78\x24\xF8\xC1\x6F\x83\xFF\x35\x4C\x6B\xF7\x51\x5B\x97\x3F\x43", // K0
+		.klen	= 4 + 4 + 16,
+		.ptext	=
+		"\xCA\x7A\x7A\xB4\xBE\x19\x2D\xAB\xD6\x03\x50\x6D\xB1\x9C\x39\xE2" // Confounder
+		"30 bytes bytes bytes bytes byt", // Plain
+		.plen	= 16 + 30,
+		.ctext	=
+		"\xA2\x6A\x39\x05\xA4\xFF\xD5\x81\x6B\x7B\x1E\x27\x38\x0D\x08\x09"
+		"\x0C\x8E\xC1\xF3\x04\x49\x6E\x1A\xBD\xCD\x2B\xDC\xD1\xDF\xFC\x66"
+		"\x09\x89\xE1\x17\xA7\x13\xDD\xBB\x57\xA4\x14\x6C\x15\x87\xCB\xA4"
+		"\x35\x66\x65\x59\x1D\x22\x40\x28\x2F\x58\x42\xB1\x05\xA5",
+		.clen	= 16 + 30 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "mic abc"
+		.key	=
+		"\x00\x00\x00\x00" // KR5_ENCRYPT_MODE
+		"\x00\x00\x00\x07" // Usage
+		"\x1D\xC4\x6A\x8D\x76\x3F\x4F\x93\x74\x2B\xCB\xA3\x38\x75\x76\xC3", // K0
+		.klen	= 4 + 4 + 16,
+		.ptext	=
+		"\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55" // MIC
+		"abcdefghijk", // Plain
+		.plen	= 16 + 10,
+		.ctext	=
+		"\x11\x78\xE6\xC5\xC4\x7A\x8C\x1A\xE0\xC4\xB9\xC7\xD4\xEB\x7B\x6B" // MIC
+		"abcdefghijk", // Plain
+		.clen	= 16 + 10,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "mic ABC"
+		.key	=
+		"\x00\x00\x00\x00" // KR5_ENCRYPT_MODE
+		"\x00\x00\x00\x07" // Usage
+		"\x50\x27\xBC\x23\x1D\x0F\x3A\x9D\x23\x33\x3F\x1C\xA6\xFD\xBE\x7C", // K0
+		.klen	= 4 + 4 + 16,
+		.ptext	=
+		"\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55" // MIC
+		"ABCDEFGHIJKLMNOPQRSTUVWXYZ", // Plain
+		.plen	= 16 + 26,
+		.ctext	=
+		"\xD1\xB3\x4F\x70\x04\xA7\x31\xF2\x3A\x0C\x00\xBF\x6C\x3F\x75\x3A" // MIC
+		"ABCDEFGHIJKLMNOPQRSTUVWXYZ", // Plain
+		.clen	= 16 + 26,
+		.setauthsize_error = -EINVAL,
+	}
+};
+
+static const struct aead_testvec krb5_test_camellia256_cts_cmac[] = {
+	/* rfc6803 sec 10 */
+	{
+		// "enc no plain",
+		.key	=
+		"\x00\x00\x00\x01" // KRB5_ENCRYPT_MODE
+		"\x00\x00\x00\x00" // Usage
+		"\xB6\x1C\x86\xCC\x4E\x5D\x27\x57\x54\x5A\xD4\x23\x39\x9F\xB7\x03"
+		"\x1E\xCA\xB9\x13\xCB\xB9\x00\xBD\x7A\x3C\x6D\xD8\xBF\x92\x01\x5B", // K0
+		.klen	= 4 + 4 + 32,
+		.ptext	=
+		"\x3C\xBB\xD2\xB4\x59\x17\x94\x10\x67\xF9\x65\x99\xBB\x98\x92\x6C" // Confounder
+		"", // Plain
+		.plen	= 16 + 1,
+		.ctext	=
+		"\x03\x88\x6D\x03\x31\x0B\x47\xA6\xD8\xF0\x6D\x7B\x94\xD1\xDD\x83"
+		"\x7E\xCC\xE3\x15\xEF\x65\x2A\xFF\x62\x08\x59\xD9\x4A\x25\x92\x66",
+		.clen	= 16 + 0 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "enc 1 plain",
+		.key	=
+		"\x00\x00\x00\x01" // KRB5_ENCRYPT_MODE
+		"\x00\x00\x00\x01" // Usage
+		"\x1B\x97\xFE\x0A\x19\x0E\x20\x21\xEB\x30\x75\x3E\x1B\x6E\x1E\x77"
+		"\xB0\x75\x4B\x1D\x68\x46\x10\x35\x58\x64\x10\x49\x63\x46\x38\x33", // K0
+		.klen	= 4 + 4 + 32,
+		.ptext	=
+		"\xDE\xF4\x87\xFC\xEB\xE6\xDE\x63\x46\xD4\xDA\x45\x21\xBB\xA2\xD2" // Confounder
+		"1", // Plain
+		.plen	= 16 + 1,
+		.ctext	=
+		"\x2C\x9C\x15\x70\x13\x3C\x99\xBF\x6A\x34\xBC\x1B\x02\x12\x00\x2F"
+		"\xD1\x94\x33\x87\x49\xDB\x41\x35\x49\x7A\x34\x7C\xFC\xD9\xD1\x8A"
+		"\x12",
+		.clen	= 16 + 1 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "enc 9 plain",
+		.key	=
+		"\x00\x00\x00\x01" // KRB5_ENCRYPT_MODE
+		"\x00\x00\x00\x02" // Usage
+		"\x32\x16\x4C\x5B\x43\x4D\x1D\x15\x38\xE4\xCF\xD9\xBE\x80\x40\xFE"
+		"\x8C\x4A\xC7\xAC\xC4\xB9\x3D\x33\x14\xD2\x13\x36\x68\x14\x7A\x05", // K0
+		.klen	= 4 + 4 + 32,
+		.ptext	=
+		"\xAD\x4F\xF9\x04\xD3\x4E\x55\x53\x84\xB1\x41\x00\xFC\x46\x5F\x88" // Confounder
+		"9 bytesss", // Plain
+		.plen	= 16 + 9,
+		.ctext	=
+		"\x9C\x6D\xE7\x5F\x81\x2D\xE7\xED\x0D\x28\xB2\x96\x35\x57\xA1\x15"
+		"\x64\x09\x98\x27\x5B\x0A\xF5\x15\x27\x09\x91\x3F\xF5\x2A\x2A\x9C"
+		"\x8E\x63\xB8\x72\xF9\x2E\x64\xC8\x39",
+		.clen	= 16 + 9 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "enc 13 plain",
+		.key	=
+		"\x00\x00\x00\x01" // KRB5_ENCRYPT_MODE
+		"\x00\x00\x00\x03" // Usage
+		"\xB0\x38\xB1\x32\xCD\x8E\x06\x61\x22\x67\xFA\xB7\x17\x00\x66\xD8"
+		"\x8A\xEC\xCB\xA0\xB7\x44\xBF\xC6\x0D\xC8\x9B\xCA\x18\x2D\x07\x15", // K0
+		.klen	= 4 + 4 + 32,
+		.ptext	=
+		"\xCF\x9B\xCA\x6D\xF1\x14\x4E\x0C\x0A\xF9\xB8\xF3\x4C\x90\xD5\x14" // Confounder
+		"13 bytes byte",
+		.plen	= 16 + 1,
+		.ctext	=
+		"\xEE\xEC\x85\xA9\x81\x3C\xDC\x53\x67\x72\xAB\x9B\x42\xDE\xFC\x57"
+		"\x06\xF7\x26\xE9\x75\xDD\xE0\x5A\x87\xEB\x54\x06\xEA\x32\x4C\xA1"
+		"\x85\xC9\x98\x6B\x42\xAA\xBE\x79\x4B\x84\x82\x1B\xEE",
+		.clen	= 16 + 0 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "enc 30 plain",
+		.key	=
+		"\x00\x00\x00\x01" // KRB5_ENCRYPT_MODE
+		"\x00\x00\x00\x04" // Usage
+		"\xCC\xFC\xD3\x49\xBF\x4C\x66\x77\xE8\x6E\x4B\x02\xB8\xEA\xB9\x24"
+		"\xA5\x46\xAC\x73\x1C\xF9\xBF\x69\x89\xB9\x96\xE7\xD6\xBF\xBB\xA7", // K0
+		.klen	= 4 + 4 + 32,
+		.ptext	=
+		"\x64\x4D\xEF\x38\xDA\x35\x00\x72\x75\x87\x8D\x21\x68\x55\xE2\x28" // Confounder
+		"30 bytes bytes bytes bytes byt", // Plain
+		.plen	= 16 + 30,
+		.ctext	=
+		"\x0E\x44\x68\x09\x85\x85\x5F\x2D\x1F\x18\x12\x52\x9C\xA8\x3B\xFD"
+		"\x8E\x34\x9D\xE6\xFD\x9A\xDA\x0B\xAA\xA0\x48\xD6\x8E\x26\x5F\xEB"
+		"\xF3\x4A\xD1\x25\x5A\x34\x49\x99\xAD\x37\x14\x68\x87\xA6\xC6\x84"
+		"\x57\x31\xAC\x7F\x46\x37\x6A\x05\x04\xCD\x06\x57\x14\x74",
+		.clen	= 16 + 30 + 16,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "mic 123"
+		.key	=
+		"\x00\x00\x00\x00" // KR5_ENCRYPT_MODE
+		"\x00\x00\x00\x09" // Usage
+		"\xB6\x1C\x86\xCC\x4E\x5D\x27\x57\x54\x5A\xD4\x23\x39\x9F\xB7\x03"
+		"\x1E\xCA\xB9\x13\xCB\xB9\x00\xBD\x7A\x3C\x6D\xD8\xBF\x92\x01\x5B", // K0
+		.klen	= 4 + 4 + 32,
+		.ptext	=
+		"\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55" // MIC
+		"123456789", // Plain
+		.plen	= 16 + 9,
+		.ctext	=
+		"\x87\xA1\x2C\xFD\x2B\x96\x21\x48\x10\xF0\x1C\x82\x6E\x77\x44\xB1" // MIC
+		"123456789", // Plain
+		.clen	= 16 + 9,
+		.setauthsize_error = -EINVAL,
+	}, {
+		// "mic !@#"
+		.key	=
+		"\x00\x00\x00\x00" // KR5_ENCRYPT_MODE
+		"\x00\x00\x00\x0a" // Usage
+		"\x32\x16\x4C\x5B\x43\x4D\x1D\x15\x38\xE4\xCF\xD9\xBE\x80\x40\xFE"
+		"\x8C\x4A\xC7\xAC\xC4\xB9\x3D\x33\x14\xD2\x13\x36\x68\x14\x7A\x05", // K0
+		.klen	= 4 + 4 + 32,
+		.ptext	=
+		"\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55\xAA\x55" // MIC
+		"!@#$%^&*()!@#$%^&*()!@#$%^&*()", // Plain
+		.plen	= 16 + 30,
+		.ctext	=
+		"\x3F\xA0\xB4\x23\x55\xE5\x2B\x18\x91\x87\x29\x4A\xA2\x52\xAB\x64" // MIC
+		"!@#$%^&*()!@#$%^&*()!@#$%^&*()", // Plain
+		.clen	= 16 + 30,
+		.setauthsize_error = -EINVAL,
+	}
+};
+
 #endif	/* _CRYPTO_TESTMGR_H */
diff --git a/include/crypto/aead.h b/include/crypto/aead.h
index 0e8a41638678..0b0826131883 100644
--- a/include/crypto/aead.h
+++ b/include/crypto/aead.h
@@ -121,6 +121,7 @@ struct aead_request {
  * @decrypt: see struct skcipher_alg
  * @ivsize: see struct skcipher_alg
  * @chunksize: see struct skcipher_alg
+ * @no_authtags: This algo doesn't use authentication tags.
  * @init: Initialize the cryptographic transformation object. This function
  *	  is used to initialize the cryptographic transformation object.
  *	  This function is called only once at the instantiation time, right
@@ -148,6 +149,7 @@ struct aead_alg {
 	unsigned int ivsize;
 	unsigned int maxauthsize;
 	unsigned int chunksize;
+	bool no_authtags;
 
 	struct crypto_alg base;
 };


