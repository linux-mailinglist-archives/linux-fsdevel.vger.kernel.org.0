Return-Path: <linux-fsdevel+bounces-28953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6DE971DBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 17:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A17285338
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C962E634;
	Mon,  9 Sep 2024 15:14:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E9225A8
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894845; cv=none; b=DQKkAHYDfbmUsMXa5q0v3kbpt/Uwu267iCFkUx+FTLtuefs+BuWM6fxuoq0rih5urI246lRx7xgm4f7ZvnAdUU3U9aEbX0jK3ltgrWuzjTWdcfXaKesUoJy49yaKWVoacwqvLqU8MXAuixKLS4A44nzsjj9hGbeGwSDv/G3lS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894845; c=relaxed/simple;
	bh=XmP0PjANDMrMb3MHyTBE97jrGff9pDqKYpeDiy9iG2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=WNo4hOf/rdpsakZSek7D3hiPNMBnNr9NF4/vCyteao7z0zhs9m0KbMO/jYko7Ck24JbcA3VzLf2mewXOt+vU0CZLZ5DtqeaWNKQzJvyVzSl9NNYiGRhTtYdCjyCNfFilteXSATgXXhPQP6LK8PBaUeQl2aoDOrskEVcyIbRNssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-287-3ocwK0khPpqnP4okqJFlfw-1; Mon, 09 Sep 2024 16:13:58 +0100
X-MC-Unique: 3ocwK0khPpqnP4okqJFlfw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 9 Sep
 2024 16:13:04 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 9 Sep 2024 16:13:04 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexey Dobriyan' <adobriyan@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] proc: fold kmalloc() + strcpy() into kmemdup()
Thread-Topic: [PATCH] proc: fold kmalloc() + strcpy() into kmemdup()
Thread-Index: AQHbAdFMLjDoegEZekykqXkTuc49UrJPkVWA
Date: Mon, 9 Sep 2024 15:13:04 +0000
Message-ID: <fd47776572944caf8f720e7d429b5e05@AcuMS.aculab.com>
References: <90af27c1-0b86-47a6-a6c8-61a58b8aa747@p183>
In-Reply-To: <90af27c1-0b86-47a6-a6c8-61a58b8aa747@p183>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDA4IFNlcHRlbWJlciAyMDI0IDEwOjI4DQo+
IA0KPiBzdHJjcHkoKSB3aWxsIHJlY2FsY3VsYXRlIHN0cmluZyBsZW5ndGggc2Vjb25kIHRpbWUg
d2hpY2ggaXMNCj4gdW5uZWNlc3NhcnkgaW4gdGhpcyBjYXNlLg0KDQpUaGVyZSBpcyBhbHNvIGRl
ZmluaXRlbHkgc2NvcGUgZm9yIHRoZSBzdHJpbmcgYmVpbmcgY2hhbmdlZC4NCk1heWJlIHlvdSBj
YW4gcHJvdmUgaXQgZG9lc24ndCBoYXBwZW4/DQoNCldoaWNoIGFsc28gbWVhbnMgdGhlIGNvZGUg
d291bGQgYmUgYmV0dGVyIGV4cGxpY2l0bHkgd3JpdGluZw0KdGhlIHRlcm1pbmF0aW5nICdcMCcg
cmF0aGVyIHRoYW4gcmVseWluZyBvbiB0aGUgb25lIGZyb20gdGhlDQppbnB1dCBidWZmZXIuDQoN
CglEYXZpZA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4ZXkgRG9icml5YW4gPGFkb2JyaXlh
bkBnbWFpbC5jb20+DQo+IC0tLQ0KPiANCj4gIGZzL3Byb2MvZ2VuZXJpYy5jIHwgICAgNCArKy0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gLS0tIGEvZnMvcHJvYy9nZW5lcmljLmMNCj4gKysrIGIvZnMvcHJvYy9nZW5lcmljLmMNCj4g
QEAgLTQ2NCw5ICs0NjQsOSBAQCBzdHJ1Y3QgcHJvY19kaXJfZW50cnkgKnByb2Nfc3ltbGluayhj
b25zdCBjaGFyICpuYW1lLA0KPiAgCQkJICAoU19JRkxOSyB8IFNfSVJVR08gfCBTX0lXVUdPIHwg
U19JWFVHTyksMSk7DQo+IA0KPiAgCWlmIChlbnQpIHsNCj4gLQkJZW50LT5kYXRhID0ga21hbGxv
YygoZW50LT5zaXplPXN0cmxlbihkZXN0KSkrMSwgR0ZQX0tFUk5FTCk7DQo+ICsJCWVudC0+c2l6
ZSA9IHN0cmxlbihkZXN0KTsNCj4gKwkJZW50LT5kYXRhID0ga21lbWR1cChkZXN0LCBlbnQtPnNp
emUgKyAxLCBHRlBfS0VSTkVMKTsNCj4gIAkJaWYgKGVudC0+ZGF0YSkgew0KPiAtCQkJc3RyY3B5
KChjaGFyKillbnQtPmRhdGEsZGVzdCk7DQo+ICAJCQllbnQtPnByb2NfaW9wcyA9ICZwcm9jX2xp
bmtfaW5vZGVfb3BlcmF0aW9uczsNCj4gIAkJCWVudCA9IHByb2NfcmVnaXN0ZXIocGFyZW50LCBl
bnQpOw0KPiAgCQl9IGVsc2Ugew0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


