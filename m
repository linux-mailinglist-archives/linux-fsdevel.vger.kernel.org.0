Return-Path: <linux-fsdevel+bounces-16296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B545689AB94
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56391C20C2B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF139879;
	Sat,  6 Apr 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="dJLqEx9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2A38FA8
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712416555; cv=none; b=liz/lrElmd/JeNhIde5LkCOLvTRjXxmXLM8hYBbti8Du0Lan2slFFP2mpG1L3BZveUADpKJQ3WTpFyiCy6WePZcdqic5ovUoxUwLb927Tgq9SPCJmtb+gUZ1lJeBNaiCEvxDdBZYxdDijS5LfHKY9dvljleRL0AXl7kK0eIPcGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712416555; c=relaxed/simple;
	bh=10TFyj1pApPqV2DjLttRO6Z0p7DgkJowPZG4e5yUIlk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ji8Q6reBlr89gX4itFk+4ZCeaXI/pqbW91NDP6XyjT+8VAEFzgjvwORAwWntXvv2QcRrMwsXExK3XSClmWa61b3NWDCwOupNBrfeGbIttGhJOm3Iaqz/bdTXZ4viCsx7ydRoV2j/svuzNJAKKWk90QT4yBfJxETZJF5dp4e4JDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=dJLqEx9S; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1712416541;
	bh=10TFyj1pApPqV2DjLttRO6Z0p7DgkJowPZG4e5yUIlk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=dJLqEx9SbP9aYzrUKrvh4bsy7as8uGx3nwsOQF9WFftKSCCySoL3OAbxQyNPbDZhG
	 kWbRNKLiwjMA/n4ylr9CG/oqqv9/N/0dgOl6ao730Zt8kAWQtmROao7hfNsxfpV3AC
	 uUBHf2dok42rundW/OvfbJbknEDP/aVs9LzgaIiA=
X-QQ-mid: bizesmtpip1t1712416539tjrefol
X-QQ-Originating-IP: H6okyuGxmXkKoiv33kv+qIKE10pz+idArnr0qsz1Lhw=
Received: from [IPV6:240e:381:70b1:9300:118d:6 ( [255.221.170.3])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 06 Apr 2024 23:15:38 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: 3M0okmaRx3jJQJgOBJs3ToT/lCfB6P6iIdSq/RO9EF8KDzy4u7hoIuAg343Vv
	hc1fZvC2Hajt5VJLLMmOwDcqTTqRQXH+DeOFa+Ptbo2ZJx6f76FHVDOLgA3B4mEYY+uf/8t
	kv6R421d9UNBFV/bPbABVbnn46HraNyFQcNHUy7wty0K5XZf0e4B1zLp4WDEDbjPiQtctgO
	aOxgFoKykN24fgJJWOAQivG2DAKyDwL0KB08uQcywSObHIEJMLuY1DSAaVn1yAqGsj8NODw
	ixowh1q/cCdar0tdANcu+sTC0EjahN1hMkJ5UoMFssnUuWhkzMf5G2ACmdm6YUF+Tev2OhE
	TFHWNUd8neffuYjcYqxAexuHAoab00hjGtnouNeNLjBQpwd1532Xr45Nvx0dA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2461703699242088425
Message-ID: <D445FB6AD28AA2B6+fe6a70b0-56bf-4283-ab4d-8c12fb5d377f@bupt.moe>
Date: Sat, 6 Apr 2024 23:15:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: HAN Yuwei <hrx@bupt.moe>
Subject: Re: Questions about Unicode Normalization Form
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-fsdevel@vger.kernel.org
References: <AD5CD726D505B53F+46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
 <ccfe804c63cbc975b567aa79fb37002d50196215.camel@HansenPartnership.com>
Content-Language: en-US
In-Reply-To: <ccfe804c63cbc975b567aa79fb37002d50196215.camel@HansenPartnership.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tiuqHzZ8Y3nMym0w4rkxwCUu"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tiuqHzZ8Y3nMym0w4rkxwCUu
Content-Type: multipart/mixed; boundary="------------vk4nhcyr4m5D0UJ05bzRrsfx";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-fsdevel@vger.kernel.org
Message-ID: <fe6a70b0-56bf-4283-ab4d-8c12fb5d377f@bupt.moe>
Subject: Re: Questions about Unicode Normalization Form
References: <AD5CD726D505B53F+46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
 <ccfe804c63cbc975b567aa79fb37002d50196215.camel@HansenPartnership.com>
In-Reply-To: <ccfe804c63cbc975b567aa79fb37002d50196215.camel@HansenPartnership.com>

--------------vk4nhcyr4m5D0UJ05bzRrsfx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

5ZyoIDIwMjQvNC82IDIxOjI2LCBKYW1lcyBCb3R0b21sZXkg5YaZ6YGTOg0KPiBPbiBTYXQs
IDIwMjQtMDQtMDYgYXQgMTc6NTQgKzA4MDAsIEhBTiBZdXdlaSB3cm90ZToNCj4+IEhpLCBh
bGwuDQo+Pg0KPj4gSSBoYXZlIGVuY291bnRlcmVkIHNvbWVvbmUgZWxzZSdzIFVuaWNvZGUg
Tm9ybWFsaXphdGlvbiBGb3JtKE5GKQ0KPj4gcHJvYmxlbSB0b2RheS4gQW5kIEkgd29uZGVy
IGhvdyBMaW51eCBwcm9jZXNzIGZpbGVuYW1lcyBpbiBVbmljb2RlLg0KPj4NCj4+IEFmdGVy
IHNvbWUgc2VhcmNoIEkgZm91bmQgdGhhdCBldmVyeWJvZHkgc2VlbXMgbGlrZSBwcm9jZXNz
ZWQgaXQgb24NCj4+IHVzZXIgaW5wdXQgbGV2ZWwsIGFuZCBub3RoaW5nIGlzIG1lbnRpb25l
ZCBhYm91dCBob3cgdmZzIG9yIHNwZWNpZmljDQo+PiBmaWxlc3lzdGVtIHRyZWF0ZWQgdGhp
cyBwcm9ibGVtLiBaRlMgdHJlYXRlZCBpdCB3aXRoIGEgb3B0aW9uDQo+PiAibm9ybWFsaXph
dGlvbiIgZXhwbGljaXRseS4gV2luZG93cyAob3IgTlRGUz8pIHNheXMgIlRoZXJlIGlzIG5v
IG5lZWQNCj4+IHRvIHBlcmZvcm0gYW55IFVuaWNvZGUgbm9ybWFsaXphdGlvbiBvbiBwYXRo
IGFuZCBmaWxlIG5hbWUgc3RyaW5ncyIuDQo+Pg0KPj4gVW5pY29kZSBoYXZlIGEgZGVkaWNh
dGVkIEZBUSBhYm91dCB0aGlzOg0KPj4gaHR0cHM6Ly91bmljb2RlLm9yZy9mYXEvbm9ybWFs
aXphdGlvbi5odG1sDQo+Pg0KPj4gSXMgdGhlcmUgYW55IGNvbmNsdXNpb24gb3IgZGlzY3Vz
c2lvbiBJIG1pc3NlZD8NCj4gVGhpcyBxdWVzdGlvbiBpcyB3YXkgdG8gYnJvYWQgdG8gYW5z
d2VyLiAgV2h5IGRvbid0IHlvdSBsb29rIGluDQo+DQo+IGZzL3VuaWNvZGUNCg0KU29ycnks
IEkgYW0gbm90IHZlcnkgZmFtaWxpYXIgd2l0aCBVbmljb2RlIG5vciBrZXJuZWwuIENvcnJl
Y3QgbWUgaWYgd3JvbmcuDQoNCkFzIHRvIHdoYXQgSSBoYXZlIHJlYWQsIGtlcm5lbCBzZWVt
cyBsaWtlIHVzaW5nIE5GRCB3aGVuIHByb2Nlc3NpbmcgYWxsIA0KVVRGLTggcmVsYXRlZCBz
dHJpbmcuDQpJZiBmcyBpcyB1c2luZyB0aGVzZSBoZWxwZXIgZnVuY3Rpb24sIHRoZW4gSSBj
YW4gYmUgc3VyZSBrZXJuZWwgaXMgDQphcHBseWluZyBORkQgdG8gZXZlcnkgVVRGLTggZmls
ZW5hbWVzLg0KQnV0IEkgY2FuJ3QgZmluZCBhbnkgcmVmZXJlbmNlcyB0byB0aGVzZSBoZWxw
ZXIgZnVuY3Rpb24gb24gR2l0aHViIA0KbWlycm9yLCBob3cgYXJlIHRoZXkgdXNlZCBieSBm
cyBjb2RlPw0KDQo+IGFuZCBzZWUgd2hlcmUgdGhlIGhlbHBlcnMgYXJlIHVzZWQgYW5kIHRo
ZW4gYXNrIGEgbW9yZSBzcGVjaWZpYw0KPiBxdWVzdGlvbi4NCj4NCj4gSmFtZXMNCj4NCg==


--------------vk4nhcyr4m5D0UJ05bzRrsfx--

--------------tiuqHzZ8Y3nMym0w4rkxwCUu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZhFnGAAKCRBLkKfpYfpB
U+xiAPsHGT94mUZ5sSW2Q5blrFfwqjjM5FZ0SpsUlxM59kskJAD/QYWpp2zJPd7R
IGyVnX355kwZ2N/T5YjahchIQ6xqxgI=
=6t4m
-----END PGP SIGNATURE-----

--------------tiuqHzZ8Y3nMym0w4rkxwCUu--

