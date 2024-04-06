Return-Path: <linux-fsdevel+bounces-16292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF65A89AA3D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DE9282750
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF410249F5;
	Sat,  6 Apr 2024 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="OWlIfRD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999E200DB
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712397458; cv=none; b=ba6phzJjyV77j11DjU4ymIb3rrVgeOuwsWFJn4D9dukwhZjNWVsl3zsDtBeX9fq8YVXRpbegb0xkpzSjmUHmOZPwSgj0+zaXkmRyGc8NRg0+/62ICjfP4X/nc77amSnARrsRtCXz7GUTtsa+CR+3QxFWeNACY1Ljv9xqP9w8kE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712397458; c=relaxed/simple;
	bh=deRQhKKLRPW9moEW0GxF6oOQZaDOo4bUkv48RN6aYJw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DOlhr/Msxh5z7Lv5v0lqjkGFXfl8ci0cTO9Fdc3YTKnDp7H+dxjB92iLyqvFFfkC2v3U2E+vRDGmCOq4cBtAfc768gJDfkXuy028rNkK4VQTDhcusDav+mHGQ9TwdDuiYD6J/AUaMTgv9IT+7MZW1jMH7W0pueoLz4ursAKN7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=OWlIfRD1; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1712397451;
	bh=deRQhKKLRPW9moEW0GxF6oOQZaDOo4bUkv48RN6aYJw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=OWlIfRD1DOwnDUdfG0+ocx9xyJoexiB/9Uw3IfwMTN2EMN9B5F8Vrokr4mneOvWSz
	 XdpkqFZY/qrn4zBO9sF0O2/wRcO84X6O2c9Lp26sBVadgIO/1d6WHyWOeY27qsQecz
	 1E0iHSKEYIAF5T7YPbJxWHP2SuLXft7Y5UUJmL0M=
X-QQ-mid: bizesmtpip2t1712397249tckhooe
X-QQ-Originating-IP: nDk67B4oEqMfze1ft0OZbdCLwKkRxonzRRjEQwDQu2o=
Received: from [IPV6:240e:381:70b1:9300:118d:6 ( [255.221.170.3])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-fsdevel@vger.kernel.org>; Sat, 06 Apr 2024 17:54:08 +0800 (CST)
X-QQ-SSF: 01100000000000E0Z000000A0000000
X-QQ-FEAT: 3VVObL39cqQt0N7tmF8f8EqXFpcRj9dVtCRkcLKC8evYx3Vny8jB2hbBJ05S6
	VnWxD0DXUFMTxcpoTyreVjWTSHzUFnOmo0gIXuPr/GEJDkta8U9t2zaUL77LeEuOsL00mYq
	o7zJyJZZhu6+xlpcuWFrWOfxCUusgPBc7kkSWs5fRUYR2H6Pg5NNrfpo5VEt/rEv+g13YaJ
	+C28bU5/oQxged7HiUJCBWcpTmkCfPO5aHIUv3iQn96/GNURNzczB86yIzQrvErFlsgAgKq
	+In0b7b1d2f7GxbFyj4czNJ2q9jBd4Tz8WSRCSu3ONDW5+oS98tYkRxqpebXsarkSIlewmx
	QTVtPa0llzT2URNwPc2kh8Mbhbky6phM21HqVHj
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8517292636187353533
Message-ID: <AD5CD726D505B53F+46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
Date: Sat, 6 Apr 2024 17:54:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
From: HAN Yuwei <hrx@bupt.moe>
Subject: Questions about Unicode Normalization Form
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6H0h6m5FFMcF12BUBC6UEBKK"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6H0h6m5FFMcF12BUBC6UEBKK
Content-Type: multipart/mixed; boundary="------------WmRDFGLe0w42prJDktGeF07n";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: linux-fsdevel@vger.kernel.org
Message-ID: <46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
Subject: Questions about Unicode Normalization Form

--------------WmRDFGLe0w42prJDktGeF07n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksIGFsbC4NCg0KSSBoYXZlIGVuY291bnRlcmVkIHNvbWVvbmUgZWxzZSdzIFVuaWNvZGUg
Tm9ybWFsaXphdGlvbiBGb3JtKE5GKSBwcm9ibGVtIA0KdG9kYXkuIEFuZCBJIHdvbmRlciBo
b3cgTGludXggcHJvY2VzcyBmaWxlbmFtZXMgaW4gVW5pY29kZS4NCg0KQWZ0ZXIgc29tZSBz
ZWFyY2ggSSBmb3VuZCB0aGF0IGV2ZXJ5Ym9keSBzZWVtcyBsaWtlIHByb2Nlc3NlZCBpdCBv
biB1c2VyIA0KaW5wdXQgbGV2ZWwsIGFuZCBub3RoaW5nIGlzIG1lbnRpb25lZCBhYm91dCBo
b3cgdmZzIG9yIHNwZWNpZmljIA0KZmlsZXN5c3RlbSB0cmVhdGVkIHRoaXMgcHJvYmxlbS4g
WkZTIHRyZWF0ZWQgaXQgd2l0aCBhIG9wdGlvbiANCiJub3JtYWxpemF0aW9uIiBleHBsaWNp
dGx5LiBXaW5kb3dzIChvciBOVEZTPykgc2F5cyAiVGhlcmUgaXMgbm8gbmVlZCB0byANCnBl
cmZvcm0gYW55IFVuaWNvZGUgbm9ybWFsaXphdGlvbiBvbiBwYXRoIGFuZCBmaWxlIG5hbWUg
c3RyaW5ncyIuDQoNClVuaWNvZGUgaGF2ZSBhIGRlZGljYXRlZCBGQVEgYWJvdXQgdGhpczog
DQpodHRwczovL3VuaWNvZGUub3JnL2ZhcS9ub3JtYWxpemF0aW9uLmh0bWwNCg0KSXMgdGhl
cmUgYW55IGNvbmNsdXNpb24gb3IgZGlzY3Vzc2lvbiBJIG1pc3NlZD8NCg0KSEFOIFl1d2Vp
Lg0KDQo=

--------------WmRDFGLe0w42prJDktGeF07n--

--------------6H0h6m5FFMcF12BUBC6UEBKK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZhEbvwAKCRBLkKfpYfpB
U0bHAQDYpclc5XdYahKe8Bb3oNz0D2AFBA6wjufM2VBwt4y6/AEAwD9wLfs/VsMa
c7Ej0HbecQrJzjowTt74LDaydhyw3Ak=
=KZUn
-----END PGP SIGNATURE-----

--------------6H0h6m5FFMcF12BUBC6UEBKK--

