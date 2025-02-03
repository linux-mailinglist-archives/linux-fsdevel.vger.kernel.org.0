Return-Path: <linux-fsdevel+bounces-40597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E24A25C50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D481883E25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC88B2080F2;
	Mon,  3 Feb 2025 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHETSeyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF820898C
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592668; cv=none; b=aW3n+VhNN/X33ku0iclv26G5+yjTuT16OolbDYyxqJFrCE9lVdmUIMhTHp6cI2ndA2Dera2/vbP/RCZcFhA75SwH3KR+oQ1k1WBbJ+lxarE42OUNFDetrrtiBkANQ9VSgD6hF5YPiHmMWvLth0X3OCEBo6P+2Z+XcD+TTrko8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592668; c=relaxed/simple;
	bh=vINBCQb66TZvl+j4tloV/ALhWKD65W8YTti58bLEpiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU5tdHE8AJ4T53Cxwz4w8fhT8AmOOp1VXxUWkAWXSUgn0+LsSSs6odT81PqpzXjpKTQt5LdFhs/J//ylyhMQK+n4VXY7Ci+6HgLjPhTdibfDsl+ZFDYSNc25Gh0LbqqPBDWiCmCIclcYndcw85plJyfcJUiIeq4gzh+F7QZgj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHETSeyN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbggNAQYVVpfE1loIMcf4vuDjPrGyAwWqGVMv5BewU4=;
	b=MHETSeyNLNBl10YkjCK8IVJ8wfWxTt+Y1XAH9iPDXNLeKAuI2irf79F+VpiQm/bHJp/yt4
	ch9TeDfcdBoyZYGH8ubojvWgqsoorTie5yLvLOj7lMbiP5Bw3v2QmY+tBxQB9iXy6feAHK
	YORSm7mgA2grWD/pvWOl7C6hdGo+NAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-j9CpUDi4PAWwI0sbiCgacw-1; Mon,
 03 Feb 2025 09:24:20 -0500
X-MC-Unique: j9CpUDi4PAWwI0sbiCgacw-1
X-Mimecast-MFC-AGG-ID: j9CpUDi4PAWwI0sbiCgacw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CEFE1956060;
	Mon,  3 Feb 2025 14:24:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2E0D30001BE;
	Mon,  3 Feb 2025 14:24:12 +0000 (UTC)
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
Subject: [PATCH net 04/24] crypto/krb5: Test manager data
Date: Mon,  3 Feb 2025 14:23:20 +0000
Message-ID: <20250203142343.248839-5-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add Kerberos crypto tests to the test manager database.  This covers:

	camellia128-cts-cmac		samples from RFC6803
	camellia256-cts-cmac		samples from RFC6803
	aes128-cts-hmac-sha256-128	samples from RFC8009
	aes256-cts-hmac-sha384-192	samples from RFC8009

but not:

	aes128-cts-hmac-sha1-96
	aes256-cts-hmac-sha1-96

as the test samples in RFC3962 don't seem to be suitable.

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
 crypto/testmgr.c |  16 +++
 crypto/testmgr.h | 351 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 367 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index e61490ba4095..06cc8c30e733 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4504,6 +4504,12 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "authenc(hmac(sha256),ctr(aes))",
 		.test = alg_test_null,
 		.fips_allowed = 1,
+	}, {
+		.alg = "authenc(hmac(sha256),cts(cbc(aes)))",
+		.test = alg_test_aead,
+		.suite = {
+			.aead = __VECS(krb5_test_aes128_cts_hmac_sha256_128)
+		}
 	}, {
 		.alg = "authenc(hmac(sha256),rfc3686(ctr(aes)))",
 		.test = alg_test_null,
@@ -4524,6 +4530,12 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "authenc(hmac(sha384),ctr(aes))",
 		.test = alg_test_null,
 		.fips_allowed = 1,
+	}, {
+		.alg = "authenc(hmac(sha384),cts(cbc(aes)))",
+		.test = alg_test_aead,
+		.suite = {
+			.aead = __VECS(krb5_test_aes256_cts_hmac_sha384_192)
+		}
 	}, {
 		.alg = "authenc(hmac(sha384),rfc3686(ctr(aes)))",
 		.test = alg_test_null,
@@ -5397,6 +5409,10 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "jitterentropy_rng",
 		.fips_allowed = 1,
 		.test = alg_test_null,
+	}, {
+		.alg = "krb5enc(cmac(camellia),cts(cbc(camellia)))",
+		.test = alg_test_aead,
+		.suite.aead = __VECS(krb5_test_camellia_cts_cmac)
 	}, {
 		.alg = "lrw(aes)",
 		.generic_driver = "lrw(ecb(aes-generic))",
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index d754ab997186..c384b2f7ec5d 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -38894,4 +38894,355 @@ static const struct cipher_testvec aes_hctr2_tv_template[] = {
 
 };
 
+#ifdef __LITTLE_ENDIAN
+#define AUTHENC_KEY_HEADER(enckeylen) \
+	"\x08\x00\x01\x00"	/* LE rtattr */ \
+	enckeylen		/* crypto_authenc_key_param */
+#else
+#define AUTHENC_KEY_HEADER(enckeylen) \
+	"\x00\x08\x00\x01"	/* BE rtattr */ \
+	enckeylen		/* crypto_authenc_key_param */
+#endif
+
+static const struct aead_testvec krb5_test_aes128_cts_hmac_sha256_128[] = {
+	/* rfc8009 Appendix A */
+	{
+		/* "enc no plain" */
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x10")
+		"\x9F\xDA\x0E\x56\xAB\x2D\x85\xE1\x56\x9A\x68\x86\x96\xC2\x6A\x6C" // Ki
+		"\x9B\x19\x7D\xD1\xE8\xC5\x60\x9D\x6E\x67\xC3\xE3\x7C\x62\xC7\x2E", // Ke
+		.klen	= 4 + 4 + 16 + 16,
+		.ptext	=
+		"\x7E\x58\x95\xEA\xF2\x67\x24\x35\xBA\xD8\x17\xF5\x45\xA3\x71\x48" // Confounder
+		"", // Plain
+		.plen	= 16 + 0,
+		.ctext	=
+		"\xEF\x85\xFB\x89\x0B\xB8\x47\x2F\x4D\xAB\x20\x39\x4D\xCA\x78\x1D"
+		"\xAD\x87\x7E\xDA\x39\xD5\x0C\x87\x0C\x0D\x5A\x0A\x8E\x48\xC7\x18",
+		.clen	= 16 + 0 + 16,
+		.assoc	= "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", // IV
+		.alen	= 16,
+	}, {
+		/* "enc plain<block" */
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x10")
+		"\x9F\xDA\x0E\x56\xAB\x2D\x85\xE1\x56\x9A\x68\x86\x96\xC2\x6A\x6C" // Ki
+		"\x9B\x19\x7D\xD1\xE8\xC5\x60\x9D\x6E\x67\xC3\xE3\x7C\x62\xC7\x2E", // Ke
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
+		.assoc	= "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", // IV
+		.alen	= 16,
+	}, {
+		/* "enc plain==block" */
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x10")
+		"\x9F\xDA\x0E\x56\xAB\x2D\x85\xE1\x56\x9A\x68\x86\x96\xC2\x6A\x6C" // Ki
+		"\x9B\x19\x7D\xD1\xE8\xC5\x60\x9D\x6E\x67\xC3\xE3\x7C\x62\xC7\x2E", // Ke
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
+		.assoc	= "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", // IV
+		.alen	= 16,
+	}, {
+		/* "enc plain>block" */
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x10")
+		"\x9F\xDA\x0E\x56\xAB\x2D\x85\xE1\x56\x9A\x68\x86\x96\xC2\x6A\x6C" // Ki
+		"\x9B\x19\x7D\xD1\xE8\xC5\x60\x9D\x6E\x67\xC3\xE3\x7C\x62\xC7\x2E", // Ke
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
+		.assoc	= "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", // IV
+		.alen	= 16,
+	},
+};
+
+static const struct aead_testvec krb5_test_aes256_cts_hmac_sha384_192[] = {
+	/* rfc8009 Appendix A */
+	{
+		/* "enc no plain" */
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x20")
+		"\x69\xB1\x65\x14\xE3\xCD\x8E\x56\xB8\x20\x10\xD5\xC7\x30\x12\xB6"
+		"\x22\xC4\xD0\x0F\xFC\x23\xED\x1F" // Ki
+		"\x56\xAB\x22\xBE\xE6\x3D\x82\xD7\xBC\x52\x27\xF6\x77\x3F\x8E\xA7"
+		"\xA5\xEB\x1C\x82\x51\x60\xC3\x83\x12\x98\x0C\x44\x2E\x5C\x7E\x49", // Ke
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
+		.assoc	= "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", // IV
+		.alen	= 16,
+	}, {
+		/* "enc plain<block" */
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x20")
+		"\x69\xB1\x65\x14\xE3\xCD\x8E\x56\xB8\x20\x10\xD5\xC7\x30\x12\xB6"
+		"\x22\xC4\xD0\x0F\xFC\x23\xED\x1F" // Ki
+		"\x56\xAB\x22\xBE\xE6\x3D\x82\xD7\xBC\x52\x27\xF6\x77\x3F\x8E\xA7"
+		"\xA5\xEB\x1C\x82\x51\x60\xC3\x83\x12\x98\x0C\x44\x2E\x5C\x7E\x49", // Ke
+		.klen	= 4 + 4 + 32 + 24,
+		.ptext	=
+		"\xB8\x0D\x32\x51\xC1\xF6\x47\x14\x94\x25\x6F\xFE\x71\x2D\x0B\x9A" // Confounder
+		"\x00\x01\x02\x03\x04\x05", // Plain
+		.plen	= 16 + 6,
+		.ctext	=
+		"\x4E\xD7\xB3\x7C\x2B\xCA\xC8\xF7\x4F\x23\xC1\xCF\x07\xE6\x2B\xC7"
+		"\xB7\x5F\xB3\xF6\x37\xB9\xF5\x59\xC7\xF6\x64\xF6\x9E\xAB\x7B\x60"
+		"\x92\x23\x75\x26\xEA\x0D\x1F\x61\xCB\x20\xD6\x9D\x10\xF2",
+		.clen	= 16 + 6 + 24,
+		.assoc	= "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", // IV
+		.alen	= 16,
+	}, {
+		/* "enc plain==block" */
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x20")
+		"\x69\xB1\x65\x14\xE3\xCD\x8E\x56\xB8\x20\x10\xD5\xC7\x30\x12\xB6"
+		"\x22\xC4\xD0\x0F\xFC\x23\xED\x1F" // Ki
+		"\x56\xAB\x22\xBE\xE6\x3D\x82\xD7\xBC\x52\x27\xF6\x77\x3F\x8E\xA7"
+		"\xA5\xEB\x1C\x82\x51\x60\xC3\x83\x12\x98\x0C\x44\x2E\x5C\x7E\x49", // Ke
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
+		.assoc	= "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", // IV
+		.alen	= 16,
+	}, {
+		/* "enc plain>block" */
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x20")
+		"\x69\xB1\x65\x14\xE3\xCD\x8E\x56\xB8\x20\x10\xD5\xC7\x30\x12\xB6"
+		"\x22\xC4\xD0\x0F\xFC\x23\xED\x1F" // Ki
+		"\x56\xAB\x22\xBE\xE6\x3D\x82\xD7\xBC\x52\x27\xF6\x77\x3F\x8E\xA7"
+		"\xA5\xEB\x1C\x82\x51\x60\xC3\x83\x12\x98\x0C\x44\x2E\x5C\x7E\x49", // Ke
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
+		.assoc	= "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", // IV
+		.alen	= 16,
+	},
+};
+
+static const struct aead_testvec krb5_test_camellia_cts_cmac[] = {
+	/* rfc6803 sec 10 */
+	{
+		// "enc no plain"
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x10")
+		"\x45\xeb\x66\xe2\xef\xa8\x77\x8f\x7d\xf1\x46\x54\x53\x05\x98\x06" // Ki
+		"\xe9\x9b\x82\xb3\x6c\x4a\xe8\xea\x19\xe9\x5d\xfa\x9e\xde\x88\x2c", // Ke
+		.klen	= 4 + 4 + 16 * 2,
+		.ptext	=
+		"\xB6\x98\x22\xA1\x9A\x6B\x09\xC0\xEB\xC8\x55\x7D\x1F\x1B\x6C\x0A" // Confounder
+		"", // Plain
+		.plen	= 16 + 0,
+		.ctext	=
+		"\xC4\x66\xF1\x87\x10\x69\x92\x1E\xDB\x7C\x6F\xDE\x24\x4A\x52\xDB"
+		"\x0B\xA1\x0E\xDC\x19\x7B\xDB\x80\x06\x65\x8C\xA3\xCC\xCE\x6E\xB8",
+		.clen	= 16 + 0 + 16,
+	}, {
+		// "enc 1 plain",
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x10")
+		"\x13\x5f\xe7\x11\x6f\x53\xc2\xaa\x36\x12\xb7\xea\xe0\xf2\x84\xaa" // Ki
+		"\xa7\xed\xcd\x53\x97\xea\x6d\x12\xb0\xaf\xf4\xcb\x8d\xaa\x57\xad", // Ke
+		.klen	= 4 + 4 + 16 * 2,
+		.ptext	=
+		"\x6F\x2F\xC3\xC2\xA1\x66\xFD\x88\x98\x96\x7A\x83\xDE\x95\x96\xD9" // Confounder
+		"1", // Plain
+		.plen	= 16 + 1,
+		.ctext	=
+		"\x84\x2D\x21\xFD\x95\x03\x11\xC0\xDD\x46\x4A\x3F\x4B\xE8\xD6\xDA"
+		"\x88\xA5\x6D\x55\x9C\x9B\x47\xD3\xF9\xA8\x50\x67\xAF\x66\x15\x59"
+		"\xB8",
+		.clen	= 16 + 1 + 16,
+	}, {
+		// "enc 9 plain",
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x10")
+		"\x10\x2c\x34\xd0\x75\x74\x9f\x77\x8a\x15\xca\xd1\xe9\x7d\xa9\x86" // Ki
+		"\xdd\xe4\x2e\xca\x7c\xd9\x86\x3f\xc3\xce\x89\xcb\xc9\x43\x62\xd7", // Ke
+		.klen	= 4 + 4 + 16 * 2,
+		.ptext	=
+		"\xA5\xB4\xA7\x1E\x07\x7A\xEE\xF9\x3C\x87\x63\xC1\x8F\xDB\x1F\x10" // Confounder
+		"9 bytesss", // Plain
+		.plen	= 16 + 9,
+		.ctext	=
+		"\x61\x9F\xF0\x72\xE3\x62\x86\xFF\x0A\x28\xDE\xB3\xA3\x52\xEC\x0D"
+		"\x0E\xDF\x5C\x51\x60\xD6\x63\xC9\x01\x75\x8C\xCF\x9D\x1E\xD3\x3D"
+		"\x71\xDB\x8F\x23\xAA\xBF\x83\x48\xA0",
+		.clen	= 16 + 9 + 16,
+	}, {
+		// "enc 13 plain",
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x10")
+		"\xb8\xc4\x38\xcc\x1a\x00\x60\xfc\x91\x3a\x8e\x07\x16\x96\xbd\x08" // Ki
+		"\xc3\x11\x3a\x25\x85\x90\xb9\xae\xbf\x72\x1b\x1a\xf6\xb0\xcb\xf8", // Ke
+		.klen	= 4 + 4 + 16 * 2,
+		.ptext	=
+		"\x19\xFE\xE4\x0D\x81\x0C\x52\x4B\x5B\x22\xF0\x18\x74\xC6\x93\xDA" // Confounder
+		"13 bytes byte", // Plain
+		.plen	= 16 + 13,
+		.ctext	=
+		"\xB8\xEC\xA3\x16\x7A\xE6\x31\x55\x12\xE5\x9F\x98\xA7\xC5\x00\x20"
+		"\x5E\x5F\x63\xFF\x3B\xB3\x89\xAF\x1C\x41\xA2\x1D\x64\x0D\x86\x15"
+		"\xC9\xED\x3F\xBE\xB0\x5A\xB6\xAC\xB6\x76\x89\xB5\xEA",
+		.clen	= 16 + 13 + 16,
+	}, {
+		// "enc 30 plain",
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x10")
+		"\x18\xaf\x19\xb0\x23\x74\x44\xfd\x75\x04\xad\x7d\xbd\x48\xad\xd3" // Ki
+		"\x8b\x07\xee\xd3\x01\x49\x91\x6a\xa2\x0d\xb3\xf5\xce\xd8\xaf\xad", // Ke
+		.klen	= 4 + 4 + 16 * 2,
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
+	}, {
+		// "enc no plain",
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x20")
+		"\xa2\xb8\x33\xe9\x43\xbb\x10\xee\x53\xb4\xa1\x9b\xc2\xbb\xc7\xe1"
+		"\x9b\x87\xad\x5d\xe9\x21\x22\xa4\x33\x8b\xe6\xf7\x32\xfd\x8a\x0e" // Ki
+		"\x6c\xcb\x3f\x25\xd8\xae\x57\xf4\xe8\xf6\xca\x47\x4b\xdd\xef\xf1"
+		"\x16\xce\x13\x1b\x3f\x71\x01\x2e\x75\x6d\x6b\x1e\x3f\x70\xa7\xf1", // Ke
+		.klen	= 4 + 4 + 32 * 2,
+		.ptext	=
+		"\x3C\xBB\xD2\xB4\x59\x17\x94\x10\x67\xF9\x65\x99\xBB\x98\x92\x6C" // Confounder
+		"", // Plain
+		.plen	= 16 + 0,
+		.ctext	=
+		"\x03\x88\x6D\x03\x31\x0B\x47\xA6\xD8\xF0\x6D\x7B\x94\xD1\xDD\x83"
+		"\x7E\xCC\xE3\x15\xEF\x65\x2A\xFF\x62\x08\x59\xD9\x4A\x25\x92\x66",
+		.clen	= 16 + 0 + 16,
+	}, {
+		// "enc 1 plain",
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x20")
+		"\x84\x61\x4b\xfa\x98\xf1\x74\x8a\xa4\xaf\x99\x2b\x8c\x26\x28\x0d"
+		"\xc8\x98\x73\x29\xdf\x77\x5c\x1d\xb0\x4a\x43\xf1\x21\xaa\x86\x65" // Ki
+		"\xe9\x31\x73\xaa\x01\xeb\x3c\x24\x62\x31\xda\xfc\x78\x02\xee\x32"
+		"\xaf\x24\x85\x1d\x8c\x73\x87\xd1\x8c\xb9\xb2\xc5\xb7\xf5\x70\xb8", // Ke
+		.klen	= 4 + 4 + 32 * 2,
+		.ptext	=
+		"\xDE\xF4\x87\xFC\xEB\xE6\xDE\x63\x46\xD4\xDA\x45\x21\xBB\xA2\xD2" // Confounder
+		"1", // Plain
+		.plen	= 16 + 1,
+		.ctext	=
+		"\x2C\x9C\x15\x70\x13\x3C\x99\xBF\x6A\x34\xBC\x1B\x02\x12\x00\x2F"
+		"\xD1\x94\x33\x87\x49\xDB\x41\x35\x49\x7A\x34\x7C\xFC\xD9\xD1\x8A"
+		"\x12",
+		.clen	= 16 + 1 + 16,
+	}, {
+		// "enc 9 plain",
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x20")
+		"\x47\xb9\xf5\xba\xd7\x63\x00\x58\x2a\x54\x45\xfa\x0c\x1b\x29\xc3"
+		"\xaa\x83\xec\x63\xb9\x0b\x4a\xb0\x08\x48\xc1\x85\x67\x4f\x44\xa7" // Ki
+		"\xcd\xa2\xd3\x9a\x9b\x24\x3f\xfe\xb5\x6e\x8d\x5f\x4b\xd5\x28\x74"
+		"\x1e\xcb\x52\x0c\x62\x12\x3f\xb0\x40\xb8\x41\x8b\x15\xc7\xd7\x0c", // Ke
+		.klen	= 4 + 4 + 32 * 2,
+		.ptext	=
+		"\xAD\x4F\xF9\x04\xD3\x4E\x55\x53\x84\xB1\x41\x00\xFC\x46\x5F\x88" // Confounder
+		"9 bytesss", // Plain
+		.plen	= 16 + 9,
+		.ctext	=
+		"\x9C\x6D\xE7\x5F\x81\x2D\xE7\xED\x0D\x28\xB2\x96\x35\x57\xA1\x15"
+		"\x64\x09\x98\x27\x5B\x0A\xF5\x15\x27\x09\x91\x3F\xF5\x2A\x2A\x9C"
+		"\x8E\x63\xB8\x72\xF9\x2E\x64\xC8\x39",
+		.clen	= 16 + 9 + 16,
+	}, {
+		// "enc 13 plain",
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x20")
+		"\x15\x2f\x8c\x9d\xc9\x85\x79\x6e\xb1\x94\xed\x14\xc5\x9e\xac\xdd"
+		"\x41\x8a\x33\x32\x36\xb7\x8f\xaf\xa7\xc7\x9b\x04\xe0\xac\xe7\xbf" // Ki
+		"\xcd\x8a\x10\xe2\x79\xda\xdd\xb6\x90\x1e\xc3\x0b\xdf\x98\x73\x25"
+		"\x0f\x6e\xfc\x6a\x77\x36\x7d\x74\xdc\x3e\xe7\xf7\x4b\xc7\x77\x4e", // Ke
+		.klen	= 4 + 4 + 32 * 2,
+		.ptext	=
+		"\xCF\x9B\xCA\x6D\xF1\x14\x4E\x0C\x0A\xF9\xB8\xF3\x4C\x90\xD5\x14" // Confounder
+		"13 bytes byte",
+		.plen	= 16 + 13,
+		.ctext	=
+		"\xEE\xEC\x85\xA9\x81\x3C\xDC\x53\x67\x72\xAB\x9B\x42\xDE\xFC\x57"
+		"\x06\xF7\x26\xE9\x75\xDD\xE0\x5A\x87\xEB\x54\x06\xEA\x32\x4C\xA1"
+		"\x85\xC9\x98\x6B\x42\xAA\xBE\x79\x4B\x84\x82\x1B\xEE",
+		.clen	= 16 + 13 + 16,
+	}, {
+		// "enc 30 plain",
+		.key	=
+		AUTHENC_KEY_HEADER("\x00\x00\x00\x20")
+		"\x04\x8d\xeb\xf7\xb1\x2c\x09\x32\xe8\xb2\x96\x99\x6c\x23\xf8\xb7"
+		"\x9d\x59\xb9\x7e\xa1\x19\xfc\x0c\x15\x6b\xf7\x88\xdc\x8c\x85\xe8" // Ki
+		"\x1d\x51\x47\xf3\x4b\xb0\x01\xa0\x4a\x68\xa7\x13\x46\xe7\x65\x4e"
+		"\x02\x23\xa6\x0d\x90\xbc\x2b\x79\xb4\xd8\x79\x56\xd4\x7c\xd4\x2a", // Ke
+		.klen	= 4 + 4 + 32 * 2,
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
+	},
+};
+
 #endif	/* _CRYPTO_TESTMGR_H */


