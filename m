Return-Path: <linux-fsdevel+bounces-39536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4AAA15738
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D668164E69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470B1E25F6;
	Fri, 17 Jan 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYPn7jHp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACED1E1C30
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139061; cv=none; b=mIdBFiMCS26FFNGAk2aChuOjeKj7CGitS1JM4SQjkhlZ+zHY7gwqghGXKVGfBT2z3R8rsekGuqmD1kU2ws3qSYz60MALfpmbprGq0Quhoq0CCynRpMSfgN42SdCgpZ2KQUsH0GFeLz7gAtj3TwTQ3AoYJb9TLPOXW2ZH30Gbjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139061; c=relaxed/simple;
	bh=DW8gs/FmfaKrxYjTmtKI5dLcNNiDw7rD2WlteA520IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2w+BfGJpgZgUzaFQfAPqNsTg3iEh7G1cKmjbWnQkUjN1e6i9Wlou/8jC3Dp0O2O23SZi3uRogWnKfLyMI1NdKLheTkZjN6Zv+xRZ09DjOZ23EE7uMwYVX2nsf3aqIlLdp+cBnSYdfK1dQ6ZYuHZYQP456tQbIgGrziCpR4SHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYPn7jHp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBET+l48IhSB6hIKcE96xgtOINeWTlZLOIuxLZkHR+0=;
	b=cYPn7jHp7tEqwbUduHMLcBvAz+oa3hKN0xRmBgM/HNjsF+T1v21PPAh7TdDlwhkulVmpxo
	LDNHokdfqzsZ/1RXC5cuUccGICmSZwyyRl2KG022M2F3OjSm53GXcAmv804rl0g1Npk5Hf
	C5rck6v9FDaEKxUf+E2/SDVCk6Lgc5E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-HG6bVX9fN9ymPTiTwhJMdg-1; Fri,
 17 Jan 2025 13:37:34 -0500
X-MC-Unique: HG6bVX9fN9ymPTiTwhJMdg-1
X-Mimecast-MFC-AGG-ID: HG6bVX9fN9ymPTiTwhJMdg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F78819560BA;
	Fri, 17 Jan 2025 18:37:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1950D195608A;
	Fri, 17 Jan 2025 18:37:27 +0000 (UTC)
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
Subject: [RFC PATCH 18/24] crypto/krb5: Add the AES self-testing data from rfc8009
Date: Fri, 17 Jan 2025 18:35:27 +0000
Message-ID: <20250117183538.881618-19-dhowells@redhat.com>
In-Reply-To: <20250117183538.881618-1-dhowells@redhat.com>
References: <20250117183538.881618-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add the self-testing data from rfc8009 to test AES + HMAC-SHA2.

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
 crypto/krb5/selftest_data.c | 118 ++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/crypto/krb5/selftest_data.c b/crypto/krb5/selftest_data.c
index bef5b8b342ae..3a5563d57280 100644
--- a/crypto/krb5/selftest_data.c
+++ b/crypto/krb5/selftest_data.c
@@ -13,6 +13,22 @@
  * Pseudo-random function tests.
  */
 const struct krb5_prf_test krb5_prf_tests[] = {
+	/* rfc8009 Appendix A */
+	{
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "prf",
+		.key	= "3705D96080C17728A0E800EAB6E0D23C",
+		.octet	= "74657374",
+		.prf	= "9D188616F63852FE86915BB840B4A886FF3E6BB0F819B49B893393D393854295",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "prf",
+		.key	= "6D404D37FAF79F9DF0D33568D320669800EB4836472EA8A026D16B7182460C52",
+		.octet	= "74657374",
+		.prf	=
+		"9801F69A368C2BF675E59521E177D9A07F67EFE1CFDE8D3C8D6F6A0256E3B17D"
+		"B3C1B62AD1B8553360D17367EB1514D2",
+	},
 	{/* END */}
 };
 
@@ -20,6 +36,28 @@ const struct krb5_prf_test krb5_prf_tests[] = {
  * Key derivation tests.
  */
 const struct krb5_key_test krb5_key_tests[] = {
+	/* rfc8009 Appendix A */
+	{
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "key",
+		.key	= "3705D96080C17728A0E800EAB6E0D23C",
+		.Kc.use	= 0x00000002,
+		.Kc.key	= "B31A018A48F54776F403E9A396325DC3",
+		.Ke.use	= 0x00000002,
+		.Ke.key	= "9B197DD1E8C5609D6E67C3E37C62C72E",
+		.Ki.use	= 0x00000002,
+		.Ki.key	= "9FDA0E56AB2D85E1569A688696C26A6C",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "key",
+		.key	= "6D404D37FAF79F9DF0D33568D320669800EB4836472EA8A026D16B7182460C52",
+		.Kc.use	= 0x00000002,
+		.Kc.key	= "EF5718BE86CC84963D8BBB5031E9F5C4BA41F28FAF69E73D",
+		.Ke.use	= 0x00000002,
+		.Ke.key	= "56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49",
+		.Ki.use	= 0x00000002,
+		.Ki.key	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
+	},
 	{/* END */}
 };
 
@@ -27,6 +65,72 @@ const struct krb5_key_test krb5_key_tests[] = {
  * Encryption tests.
  */
 const struct krb5_enc_test krb5_enc_tests[] = {
+	/* rfc8009 Appendix A */
+	{
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc no plain",
+		.plain	= "",
+		.conf	= "7E5895EAF2672435BAD817F545A37148",
+		.Ke	= "9B197DD1E8C5609D6E67C3E37C62C72E",
+		.Ki	= "9FDA0E56AB2D85E1569A688696C26A6C",
+		.ct	= "EF85FB890BB8472F4DAB20394DCA781DAD877EDA39D50C870C0D5A0A8E48C718",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc plain<block",
+		.plain	= "000102030405",
+		.conf	= "7BCA285E2FD4130FB55B1A5C83BC5B24",
+		.Ke	= "9B197DD1E8C5609D6E67C3E37C62C72E",
+		.Ki	= "9FDA0E56AB2D85E1569A688696C26A6C",
+		.ct	= "84D7F30754ED987BAB0BF3506BEB09CFB55402CEF7E6877CE99E247E52D16ED4421DFDF8976C",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc plain==block",
+		.plain	= "000102030405060708090A0B0C0D0E0F",
+		.conf	= "56AB21713FF62C0A1457200F6FA9948F",
+		.Ke	= "9B197DD1E8C5609D6E67C3E37C62C72E",
+		.Ki	= "9FDA0E56AB2D85E1569A688696C26A6C",
+		.ct	= "3517D640F50DDC8AD3628722B3569D2AE07493FA8263254080EA65C1008E8FC295FB4852E7D83E1E7C48C37EEBE6B0D3",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "enc plain>block",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.conf	= "A7A4E29A4728CE10664FB64E49AD3FAC",
+		.Ke	= "9B197DD1E8C5609D6E67C3E37C62C72E",
+		.Ki	= "9FDA0E56AB2D85E1569A688696C26A6C",
+		.ct	= "720F73B18D9859CD6CCB4346115CD336C70F58EDC0C4437C5573544C31C813BCE1E6D072C186B39A413C2F92CA9B8334A287FFCBFC",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc no plain",
+		.plain	= "",
+		.conf	= "F764E9FA15C276478B2C7D0C4E5F58E4",
+		.Ke	= "56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49",
+		.Ki	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
+		.ct	= "41F53FA5BFE7026D91FAF9BE959195A058707273A96A40F0A01960621AC612748B9BBFBE7EB4CE3C",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc plain<block",
+		.plain	= "000102030405",
+		.conf	= "B80D3251C1F6471494256FFE712D0B9A",
+		.Ke	= "56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49",
+		.Ki	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
+		.ct	= "4ED7B37C2BCAC8F74F23C1CF07E62BC7B75FB3F637B9F559C7F664F69EAB7B6092237526EA0D1F61CB20D69D10F2",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc plain==block",
+		.plain	= "000102030405060708090A0B0C0D0E0F",
+		.conf	= "53BF8A0D105265D4E276428624CE5E63",
+		.Ke	= "56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49",
+		.Ki	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
+		.ct	= "BC47FFEC7998EB91E8115CF8D19DAC4BBBE2E163E87DD37F49BECA92027764F68CF51F14D798C2273F35DF574D1F932E40C4FF255B36A266",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "enc plain>block",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.conf	= "763E65367E864F02F55153C7E3B58AF1",
+		.Ke	= "56AB22BEE63D82D7BC5227F6773F8EA7A5EB1C825160C38312980C442E5C7E49",
+		.Ki	= "69B16514E3CD8E56B82010D5C73012B622C4D00FFC23ED1F",
+		.ct	= "40013E2DF58E8751957D2878BCD2D6FE101CCFD556CB1EAE79DB3C3EE86429F2B2A602AC86FEF6ECB647D6295FAE077A1FEB517508D2C16B4192E01F62",
+	},
 	{/* END */}
 };
 
@@ -34,5 +138,19 @@ const struct krb5_enc_test krb5_enc_tests[] = {
  * Checksum generation tests.
  */
 const struct krb5_mic_test krb5_mic_tests[] = {
+	/* rfc8009 Appendix A */
+	{
+		.etype	= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.name	= "mic",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.Kc	= "B31A018A48F54776F403E9A396325DC3",
+		.mic	= "D78367186643D67B411CBA9139FC1DEE",
+	}, {
+		.etype	= KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.name	= "mic",
+		.plain	= "000102030405060708090A0B0C0D0E0F1011121314",
+		.Kc	= "EF5718BE86CC84963D8BBB5031E9F5C4BA41F28FAF69E73D",
+		.mic	= "45EE791567EEFCA37F4AC1E0222DE80D43C3BFA06699672A",
+	},
 	{/* END */}
 };


