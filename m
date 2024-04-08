Return-Path: <linux-fsdevel+bounces-16335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C307689B5BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 03:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E23B20E68
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 01:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AF115C3;
	Mon,  8 Apr 2024 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="mMU/A3lH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEFECC
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712541479; cv=none; b=gIfaLO9cYDYbvxGhb+V/jesO7K/NFzUMij9RVEbyfLQHYJ/BBJyWSGq+nqaSTgNDEJSbII1gvEtRROZnP6EUep4/PwiykFxOqsYvpHGTkhAE61FIblPoo2iO5OVCOZjdloQcjmaP02ZkKlVt6IzTzOLDU4sNGC+2eon8Bkk8AXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712541479; c=relaxed/simple;
	bh=iPk2aXOoOoH+eumjcMY8ajm0tr8GUHkZluiaLPvhibY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LY4GH848zrPipezu+h4MwNnYQGpbIKGass7u0Uu5U64Tguz73QoCoIN3M47Z9mYoQqgoPbOvA/io3mZcQfvwBsQseBSVp76OqSNEuXR+E2AdxOcyommXVJFQDMON7jBKh+p/m75W1deA0Vb7UyOwW2gFTrUeyP910X3OcCgwHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=mMU/A3lH; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1712541460;
	bh=iPk2aXOoOoH+eumjcMY8ajm0tr8GUHkZluiaLPvhibY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mMU/A3lHNURIghURCcrjhz07k+Lb0vRMcKxtw0IoOGxpn7aSpjgDezdsALtv3+7GN
	 23KgVvHkh4eGp406MIFZE5gVXKbJa5bKFGoa5W4MHxp+x1vfC/wg+K1mqGVmLXwoKc
	 oema7ASugJ0rb/S1QonM/Em+p8o2iI4kJnS0No3U=
X-QQ-mid: bizesmtpip1t1712541458tk0i1mf
X-QQ-Originating-IP: Ew51O3r1XOEmaqKMLyaynwhFADxzBpFncKxIntHZeWs=
Received: from [IPV6:240e:381:70b1:9300:85ec:5 ( [255.61.49.7])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Apr 2024 09:57:37 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: SwXEHodyBCk+YOwDKJdsbIdr/th3YWxIjiw4fPgoynrs9wWdDYsaj9hM0/lh/
	KwM1CZbvX2SAO0TUB3H2khJsEQThxIxS0bgNMTCWtrWRJ7kd5U20Ql7pZs33wUZr71KPbF5
	D6I2gfTquhRaOZlfcHlcOVNJ+BZVsgNzK2fUygvTMHZZb428RrpJfHE6yFxdV+/4JPlxHcT
	p2dyDg7k4jdn4CgATPHMZtN2s8TMtAbiHXTVdIiybfB1usMXNEH+p7Moz8NUWWH1lcEs0UW
	+S1TrEzfDeNFlVBLYzrLed8MUzD5fhejlMveMwWtpadpGCj2CvZn/uxVUS6PydR/1mxxjG4
	Bf+Jv69CFRi51K+bRU9Dmr8ZPvXxy7JWy8ELXHO
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7407910393833527088
Message-ID: <4791CB4C8B66A5E4+6bacac14-9766-4349-9be0-c8b384d4b5c5@bupt.moe>
Date: Mon, 8 Apr 2024 09:57:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Questions about Unicode Normalization Form
To: Theodore Ts'o <tytso@mit.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-fsdevel@vger.kernel.org
References: <AD5CD726D505B53F+46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
 <ccfe804c63cbc975b567aa79fb37002d50196215.camel@HansenPartnership.com>
 <D445FB6AD28AA2B6+fe6a70b0-56bf-4283-ab4d-8c12fb5d377f@bupt.moe>
 <20240408013928.GG13376@mit.edu>
Content-Language: en-US
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <20240408013928.GG13376@mit.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ARf4hj6kDfdXXdWyVOyw2msd"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ARf4hj6kDfdXXdWyVOyw2msd
Content-Type: multipart/mixed; boundary="------------1C1yeCp3YT4a3U3ErZ2UpmsJ";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: Theodore Ts'o <tytso@mit.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-fsdevel@vger.kernel.org
Message-ID: <6bacac14-9766-4349-9be0-c8b384d4b5c5@bupt.moe>
Subject: Re: Questions about Unicode Normalization Form
References: <AD5CD726D505B53F+46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
 <ccfe804c63cbc975b567aa79fb37002d50196215.camel@HansenPartnership.com>
 <D445FB6AD28AA2B6+fe6a70b0-56bf-4283-ab4d-8c12fb5d377f@bupt.moe>
 <20240408013928.GG13376@mit.edu>
In-Reply-To: <20240408013928.GG13376@mit.edu>

--------------1C1yeCp3YT4a3U3ErZ2UpmsJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQrlnKggMjAyNC80LzggOTozOSwgVGhlb2RvcmUgVHMnbyDlhpnpgZM6DQo+IE9uIFNhdCwg
QXByIDA2LCAyMDI0IGF0IDExOjE1OjM2UE0gKzA4MDAsIEhBTiBZdXdlaSB3cm90ZToNCj4+
IFNvcnJ5LCBJIGFtIG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggVW5pY29kZSBub3Iga2VybmVs
LiBDb3JyZWN0IG1lIGlmIHdyb25nLg0KPj4NCj4+IEFzIHRvIHdoYXQgSSBoYXZlIHJlYWQs
IGtlcm5lbCBzZWVtcyBsaWtlIHVzaW5nIE5GRCB3aGVuIHByb2Nlc3NpbmcgYWxsDQo+PiBV
VEYtOCByZWxhdGVkIHN0cmluZy4NCj4+IElmIGZzIGlzIHVzaW5nIHRoZXNlIGhlbHBlciBm
dW5jdGlvbiwgdGhlbiBJIGNhbiBiZSBzdXJlIGtlcm5lbCBpcyBhcHBseWluZw0KPj4gTkZE
IHRvIGV2ZXJ5IFVURi04IGZpbGVuYW1lcy4NCj4+IEJ1dCBJIGNhbid0IGZpbmQgYW55IHJl
ZmVyZW5jZXMgdG8gdGhlc2UgaGVscGVyIGZ1bmN0aW9uIG9uIEdpdGh1YiBtaXJyb3IsDQo+
PiBob3cgYXJlIHRoZXkgdXNlZCBieSBmcyBjb2RlPw0KPiBGb3IgdGhlIG1vc3QgcGFydCwg
dGhlIGtlcm5lbCdzIGZpbGUgc3R5c2VtIGNvZGUgZG9lc24ndCBkbyBhbnl0aGluZw0KPiBz
cGVjaWFsIGZvciBVbmljb2RlLiAgVGhlIGV4Y2VwdGlvbiBpcyB0aGF0IHRoZSBleHQ0IGFu
ZCBmMmZzIGZpbGUNCj4gc3lzdGVtcyBjYW4gaGF2ZSBhbiBvcHRpb25hbCBmZWF0dXJlIHdo
aWNoIGlzIG1vc3RseSBvbmx5IHVzZWQgYnkNCj4gQW5kcm9pZCBzeXN0ZW1zIHRvIHN1cHBv
cnQgY2FzZSBpbnNlbnNpdGl2ZSBsb29rdXBzLiAgVGhpcyBpcyBjYWxsZWQNCj4gdGhlICJj
YXNlZm9sZCIgZmVhdHVyZSwgd2hpY2ggaXMgbm90IGVuYWJsZWQgYnkgZGVmYXVsdCBieSBt
b3N0DQo+IGRlc2t0b3Agb3Igc2VydmVyIHN5c3RlbXMuDQo+DQo+IFRoZSBjYXNlZm9sZCBm
ZWF0dXJlIHdhcyBkZXZlbG9wZWQgYmVjYXVzZSBBbmRyb2lkIGhhcyBhIHJlcXVpcmVtZW50
DQo+IHRvIHN1cHBvcnQgY2FzZS1pbnNlbnNpdGl2ZSBsb29rdXBzLCBhbmQgaXQgaGFkIHRv
IHN1cHBvcnQgVW5pY29kZQ0KPiBjaGFyYWN0ZXIgc2V0cyAoZm9yIGV4YW1wbGUsIFhGUyBo
YXMgc3VwcG9ydCBmb3IgY2FzZSBpbnNlbnNpdGl2ZQ0KPiBsb29rdXBzIGJhY2sgZnJvbSB0
aGUgSXJpeCBkYXlzLCBidXQgaXQgb25seSBzdXBwb3J0cyBBU0NJSSksIGFuZCB0aGUNCj4g
YWx0ZXJuYXRpdmUgdG8gYWRkaW5nIHN1cHBvcnQgaW4gdGhlIGtlcm5lbCBmb3IgY2FzZSBm
b2RsaW5nIHdhcyB0aGlzDQo+IHRlcnJpYmxlIG91dC1vZi10cmVlIGtlcm5lbCBtb2R1bGUg
d2hpY2ggdXNlIGEgZmlsZSBzeXN0ZW0gd3JhcHBpbmcNCj4gdGhhdCB3YXMgZGVhZGxvY2st
cHJvbmUgKHdoaWNoIGlzIHdoeSB0aGUgY2FzZS1mb2xkaW5nIHdyYXBmcyB3b3VsZA0KPiBu
ZXZlciBiZSBhY2NlcHRlZCB1cHN0cmVhbTsgaXQgd2FzIGEgdHJhc2ggZmlyZSkuICBBbnl3
YXksIEkgZ290IHRpcmVkDQo+IG9mIGJlaW5nIGFza2VkIHRvIGRlYnVnIGZpbGUgc3lzdGVt
IGRlYWRsb2NrcyB3aGljaCB3YXMgbm90IHRoZSBWRlMncw0KPiBmYXVsdCwgYnV0IHdhcyBy
YXRoZXIgY2F1c2VkIGJ5IHRoaXMgdGVycmlibGUgd3JhcGZzIGtsdWRnZSB1c2VkIGJ5DQo+
IEFuZHJvaWQsIHNvIEkgaW5zdGlnYXRlZCBwcm9wZXIgY2FzZS1mb2xkaW5nIHN1cHBvcnQg
KGFsYSBXaW5kb3dzIGFuZA0KPiBNYWNPUykgZm9yIHRoZSBmaWxlIHN5c3RlbSB0eXBlcyBj
b21tb25seSB1c2VkIGJ5IEFuZHJvaWQsIG5hbWVseSBleHQ0DQo+IGFuZCBmMmZzLg0KPg0K
PiBTbyAqaWYqIHlvdSBhcmUgdXNpbmcgZXh0NCBvciBmMmZzLCAqYW5kKiB0aGUgZmlsZSBz
eXN0ZW0gaXMgc3BlY2lhbGx5DQo+IGNyZWF0ZWQgd2l0aCB0aGUgZmlsZSBzeXN0ZW0gZmVh
dHVyZSBmbGFnICJjYXNlZm9sZCIsICphbmQqIHRoZQ0KPiBkaXJlY3RvcnkgaGFzIHRoZSBj
YXNlZm9sZCBmbGFnIHNldCwgKnRoZW4qIHRoZSBmaWxlIHN5c3RlbSB3aWxsDQo+IHN1cHBv
cnQgY2FzZS1wcmVzZXJ2aW5nLCBjYXNlLWluc2Vuc2l0aXZlIGxvb2t1cHMuICBBcyBhIHNp
ZGUgZWZmZWN0DQo+IG9mIHVzaW5nIHV0Zjhfc3RyY2FzZWNtcCwgaXQgd2lsbCBhbHNvIGRv
IHN0cmluZyBjb21wYXJpc29ucyB3aGVyZQ0KPiBldmVuIGlmIHlvdSBoYXZlIG5vdCBub3Jt
YWxpemVkIHRoZSBmaWxlIGJhbmVzLCBzbyB0aGF0IHRoZSBmaWxlbmFtZQ0KPiBjb250YWlu
ZWQgc29tZSBVbmljb2RlIGNoYXJhY3Rlciwgc3VjaCBhcyAoZm9yIGV4YW1wbGUpIHRoZSBO
RkMgZm9ybQ0KPiBvZiB0aGUgQW5zdHJvbSBTaWduIGNoYXJhY3RlciAoMDBDNSksIGFuZCB5
b3UgdHJ5IHRvIGxvb2sgaXQgdXAgdXNpbmcNCj4gdGhlIE5GRCBmb3JtIG9mIHRoZSBjaGFy
YWN0ZXIgKDAwNDEgMDMwQSksIHRoZSBsb29rdXAgd2lsbCBzdWNjZWVkLA0KPiBiZWNhdXNl
IHdlIHVzZSB1dGY4X3N0cmNhc2VjbXAoKS4gICBIb3dldmVyLCB0aGlzIGlzICpvbmx5KiBp
ZiBjYXNlDQo+IGZvbGRpbmcgaXMgZW5hYmxlZCwgYW5kIGluIGdlbmVyYWwsIGl0IGlzbid0
Lg0KPg0KPiBBc2lkZSBmcm9tIHRoaXMgZXhjZXB0aW9uICh3aGljaCBhcyBJIHNhaWQsIGlz
IGluIGdlbmVyYWwgb25seSBlbmFibGVkDQo+IGZvciBBbmRyb2lkLCBiZWNhdXNlIG1vc3Qg
b3RoZXIgdXNlIGNhc2VzIHN1Y2ggYXMgZm9yIERlc2t0b3AsIFNlcnZlciwNCj4gZXRjLiBk
b24ndCByZWFsbHkgY2FyZSBhYm91dCBNYWNPUyAvIFdpbmRvd3Mgc3R5bGUgY2FzZSBpbnNl
bnNpdGl2ZQ0KPiBmaWxlbmFtZSBsb29rdXBzKSwgdGhlIExpbnV4IFZGUyBpbiBnZW5lcmFs
IHRyZWF0cyBVVEYtOCBjaGFyYWN0ZXJzIGFzDQo+IG51bGwtdGVybWluYXRlZCBieXRlIHN0
cmVhbXMuICBTbyB0aGUga2VybmVsIGRvZXNuJ3QgdmFsaWRhdGUgdG8gbWFrZQ0KPiBzdXJl
IHRoYXQgYSBmaWxlIG5hbWUgaXMgY29tcG9zZWQgb2YgdmFsaWQgVVRGLTggY29kZSBwb2lu
dHMgKGUuZy4sIHNvDQo+IHdlIGRvbid0IHByb2hpYml0IHRoZSB1c2Ugb2YgS2xpbmdvbiBj
aGFyYWN0ZXJzIHdoaWNoIGFyZSBub3QNCj4gcmVjb2duaXplZCBieSB0aGUgVW5pY29kZSBj
b25zb3J0aXVtKSwgbm9yIGRvZXMgdGhlIGtlcm5lbCBkbyBhbnkga2luZA0KPiBvZiBVbmlj
b2RlIG5vcm1hbGl6YXRpb24uICBTbyBmb3IgZXhhbXBsZSwgaWYgY2FzZWZvbGRpbmcgaXMg
bm90DQo+IGVuYWJsZWQsIDAwNDEgMDMwQSBhbmQgMDBDNSB3aWxsIGJlIGNvbnNpZGVyZWQg
ZGlmZmVyZW50LCBhbmQga2VybmVsDQo+IHdpbGwgbm90IGZvcmNlIHRoZSBORkMgZm9ybSAo
MDBDNSkgdG8gdGhlIE5GRCBmb3JtICgwMDQxIDAzMEEpIG9yIHZpY2UNCj4gdmVyc2EuDQo+
DQo+IE5vdywgYmVjYXVzZSB0aGUga2VybmVsIHRyaWVzIHZlcnkgaGFyZCB0byBiZSBibGlz
c2Z1bGx5IGlnbm9yYW50DQo+IGFib3V0IHRoZSBuaWdodG1hcmUgd2hpY2ggaXMgSTE4Tiwg
aXQgaXMgdXAgdG8gdGhlIHVzZXJzcGFjZSBVbmljb2RlDQo+IGxpYnJhcmllcyB0byBub3Jt
YWxpemUgc3RyaW5ncyBiZWZvcmUgcGFzc2luZyB0aGVtIHRvIHRoZSBrZXJuZWwgLS0tDQo+
IGVpdGhlciBhcyBkYXRhIGluIHRleHQgZmlsZXMsIG9yIGFzIGZpbGUgbmFtZXMuICBJIGFt
IHZlcnkgZ2xhZCB0aGF0IEkNCj4gZG9uJ3Qgd29ycnkgYWJvdXQgd2hldGhlciB0aGUgc3Rh
bmRhcmQgbm9ybWFsaXphdGlvbiBmb3JtIHVzZWQgYnkgdGhlDQo+IHZhcmlvdXMgR05PTUUs
IEtERSwgVW5pY29kZSwgZXRjLiwgdXNlcnNwYWNlIGxpYnJhcmllcyBpcyBORkQsIE5GQywN
Cj4gTkZLRCwgb3IgTkZLQy4gIFRoYXQncyBzb21lb25lIGVsc2UncyBwcm9ibGVtLCBhbmQg
aWYgeW91IGRvbid0IGhhdmUNCj4gY2FzZWZvbGRpbmcgZW5hYmxlZCwgd2Ugd2lsbCBkbyB0
aGUgZmlsZW5hbWUgY29tcGFyaXNvbnMgdXNpbmcgdGhlDQo+IHN0cmNtcCgpIGZ1bmN0aW9u
Lg0KPg0KPiBGdW5kYW1lbnRhbGx5LCB1bmljb2RlIGFuZCBub3JtYWxpemF0aW9uIGlzIGEg
dXNlcnNwYWNlIHByb2JsZW0sIG5vdCBhDQo+IGtlcm5lbCBwcm9ibGVtLCBleGNlcHQgd2hl
biB3ZSBkb24ndCBoYXZlIGEgY2hvaWNlIChzdWNoIGFzIGZvciBjYXNzZQ0KPiBpbnNlbnNp
dGl2ZSBsb29rdXBzKS4gIEFuZCB0aGVyZSB3ZSBzb2x2ZSBqdXN0IHRoZSBzbWFsbGVzdCBw
YXJ0IG9mDQo+IHRoZSBwcm9ibGVtLCBhbmQgbWFrZSBpdCB1c2Vyc3BhY2UncyBwcm9ibGVt
IGZvciBldmVyeXRoaW5nIGVsc2UuDQo+DQo+IENoZWVycywNCj4NCj4gCQkJCQktIFRlZA0K
DQpUaGFua3MgZm9yIHlvdSB0aW1lIGFuZCBwYXRpZW50IGV4cGxhbmF0aW9uLiBJIGhhdmUg
bGVhcm5lZCBhIGxvdCBhYm91dCANCnRoZXNlICJoaXN0b3J5Ii4NCg0KRG8geW91IHRoaW5r
IGl0IGlzIGFwcHJvcHJpYXRlIHRvIGFkZCB0aGVzZSB0byBrZXJuZWwgZG9jdW1lbnRhdGlv
bj8gSWYgDQpzbyBJIGNhbiBjb21wb3NpdGUgYSBwYXRjaCBhYm91dCB0aGlzLg0KDQpIQU4g
WXV3ZWkNCg0K

--------------1C1yeCp3YT4a3U3ErZ2UpmsJ--

--------------ARf4hj6kDfdXXdWyVOyw2msd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZhNPEQAKCRBLkKfpYfpB
U1VFAQCWpYv7+5ROqRt9nTP+2AHWJtqQeiloRidIHaG161f3JwD/bvu8j3lMEyPw
NGKhmWvszzzm09gklrbSeJuEQegIlwg=
=TLBu
-----END PGP SIGNATURE-----

--------------ARf4hj6kDfdXXdWyVOyw2msd--


