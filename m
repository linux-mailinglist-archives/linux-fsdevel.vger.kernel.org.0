Return-Path: <linux-fsdevel+bounces-30517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5590298C1BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE431F25464
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168341CB300;
	Tue,  1 Oct 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="N4iRSmCO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A591C6889;
	Tue,  1 Oct 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796969; cv=none; b=iaIcBA35aocpMlE2A5p4AUvjQWFPpwzvnxB+E77Q74CGOUWCY5vzwMPxmVqji2sqFb2923m0o3UO3vembzqBOdb+0b4XOkxnY2kkhXrt0LT0qakcfIJk/vCO5fyA4t+qnkzlxvvmOmb4rIvGNhh2vMYRivqvsdQirLoqRzO8e30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796969; c=relaxed/simple;
	bh=a3ihKYAJstiwcBkSn6UnWh62jrc+i4Tz9f1A6uXv2LY=;
	h=To:Cc:From:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID:MIME-Version; b=ajklAQZpep/YZnsGRpc6r4jp+UO9FFeqofKQeDOUm2RHM0KpZs7IEto73KjYbCvINKecpUcjY/LGxYjKunL60bvYLQdgmi62JIFEMvqjJs1UcDobFWv6xDkrrf88OG+r+/0SK6OW4KEJQ4PRlphrZJE8NKI/NQPZnJ9tsz8yvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=N4iRSmCO; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3143:0:640:c03:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 40962612E8;
	Tue,  1 Oct 2024 18:28:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id iScIT09i70U0-Ce6zD59g;
	Tue, 01 Oct 2024 18:28:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1727796528; bh=a3ihKYAJstiwcBkSn6UnWh62jrc+i4Tz9f1A6uXv2LY=;
	h=Message-ID:References:Date:In-Reply-To:Cc:Subject:From:To;
	b=N4iRSmCOdwLHH2HgIDWLiciNpGAS+Bavmf7HGbAC2Wh0enZ4yaES3iRWJwuKo2hc6
	 oC9/oc4nXKgVjNiYHt8lvS9qc73vXN3lHGVAfXprqrWUfSy/QdkPHHS4darTEKUepC
	 IzpEbuprOZp+feXezEWfDyJ32sGYR/xx+uUmxVrA=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
X-Priority: 3
To: oleg@redhat.com
Cc:
 viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,axboe@kernel.dk,akpm@linux-foundation.org,catalin.marinas@arm.com,revest@chromium.org,kees@kernel.org,palmer@rivosinc.com,charlie@rivosinc.com,bgray@linux.ibm.com,deller@gmx.de,zev@bewilderbeest.net,samuel.holland@sifive.com,linux-fsdevel@vger.kernel.org,ebiederm@xmission.com,luto@kernel.org,josh@joshtriplett.org,
  linux-kernel@vger.kernel.org
From: stsp <stsp2@yandex.ru>
Subject: Re: [PATCH v3] add group restriction bitmap
In-Reply-To: <20241001150258.GD23907@redhat.com>
References: <20240930195958.389922-1-stsp2@yandex.ru>
 <20241001111516.GA23907@redhat.com>
 <02ae38f6-698c-496f-9e96-1376ef9f1332@yandex.ru>
 <20241001130236.GB23907@redhat.com>
 <62362149-c550-490f-bd7a-0fd7a5cd22bc@yandex.ru>
 <20241001150258.GD23907@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Date: Tue, 1 Oct 2024 15:28:44 +0000
Message-ID:
 <e4ii9s.skooc0.3aq6g4-qmf@mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net>
 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Yandex-Filter: 1

DQoNCtCS0YLQvtGA0L3QuNC6LCAxINC+0LrRgtGP0LHRgNGPIDIwMjQg0LMg0L/QvtC70YPRh9C1
0L3QviDQvtGCIE9sZWcgTmVzdGVyb3Y6DQo+IFdlIGNhbid0IHVuZGVyc3RhbmQgZWFjaCBvdGhl
ci4gSSBndWVzcyBJIG1pc3NlZCBzb21ldGhpbmcuLi4NCj4gDQo+IE9uIDEwLzAxLCBzdHNwIHdy
b3RlOg0KPiA+DQo+ID4gMDEuMTAuMjAyNCAxNjowMiwgT2xlZyBOZXN0ZXJvdiDQv9C40YjQtdGC
Og0KPiA+ID5PbiAxMC8wMSwgc3RzcCB3cm90ZToNCj4gPiA+PjAxLjEwLjIwMjQgMTQ6MTUsIE9s
ZWcgTmVzdGVyb3Yg0L/QuNGI0LXRgjoNCj4gPiA+Pj5TdXBwb3NlIHdlIGNoYW5nZSBncm91cHNf
c2VhcmNoKCkNCj4gPiA+Pj4NCj4gPiA+Pj4JLS0tIGEva2VybmVsL2dyb3Vwcy5jDQo+ID4gPj4+
CSsrKyBiL2tlcm5lbC9ncm91cHMuYw0KPiA+ID4+PglAQCAtMTA0LDggKzEwNCwxMSBAQCBpbnQg
Z3JvdXBzX3NlYXJjaChjb25zdCBzdHJ1Y3QgZ3JvdXBfaW5mbyAqZ3JvdXBfaW5mbywga2dpZF90
IGdycCkNCj4gPiA+Pj4JCQkJbGVmdCA9IG1pZCArIDE7DQo+ID4gPj4+CQkJZWxzZSBpZiAoZ2lk
X2x0KGdycCwgZ3JvdXBfaW5mby0+Z2lkW21pZF0pKQ0KPiA+ID4+PgkJCQlyaWdodCA9IG1pZDsN
Cj4gPiA+Pj4JLQkJZWxzZQ0KPiA+ID4+PgktCQkJcmV0dXJuIDE7DQo+ID4gPj4+CSsJCWVsc2Ug
ew0KPiA+ID4+PgkrCQkJYm9vbCByID0gbWlkIDwgQklUU19QRVJfTE9ORyAmJg0KPiA+ID4+Pgkr
CQkJCSB0ZXN0X2JpdChtaWQsICZncm91cF9pbmZvLT5yZXN0cmljdF9iaXRtYXApOw0KPiA+ID4+
PgkrCQkJcmV0dXJuIHIgPyAtMSA6IDE7DQo+ID4gPj4+CSsJCX0NCj4gPiA+Pj4JCX0NCj4gPiA+
Pj4JCXJldHVybiAwOw0KPiA+ID4+PgkgfQ0KPiA+ID4+Pg0KPiA+ID4+PnNvIHRoYXQgaXQgcmV0
dXJucywgc2F5LCAtMSBpZiB0aGUgZm91bmQgZ3JwIGlzIHJlc3RyaWN0ZWQuDQo+ID4gPj4+DQo+
ID4gPj4+VGhlbiBldmVyeXRoaW5nIGVsc2UgY2FuIGJlIGdyZWF0bHkgc2ltcGxpZmllZCwgYWZh
aWNzLi4uDQo+ID4gPj5UaGlzIHdpbGwgbWVhbiB1cGRhdGluZyBhbGwgY2FsbGVycw0KPiA+ID4+
b2YgZ3JvdXBzX3NlYXJjaCgpLCBpbl9ncm91cF9wKCksDQo+ID4gPj5pbl9lZ3JvdXBfcCgpLCB2
ZnN4eF9pbl9ncm91cF9wKCkNCj4gPiA+V2h5PyBJIHRoaW5rIHdpdGggdGhpcyBjaGFuZ2UgeW91
IGRvIG5vdCBuZWVkIHRvIHRvdWNoIGluX2dyb3VwX3AvZXRjIGF0IGFsbC4NCj4gPiA+DQo+ID4g
Pj5pZiBpbl9ncm91cF9wKCkgcmV0dXJucyAtMSBmb3Igbm90IGZvdW5kDQo+ID4gPj5hbmQgMCBm
b3IgZ2lkLA0KPiA+ID5XaXRoIHRoZSB0aGUgY2hhbmdlIGFib3ZlIGluX2dyb3VwX3AoKSByZXR1
cm5zIDAgaWYgbm90IGZvdW5kLCAhMCBvdGhlcndpc2UuDQo+ID4gPkl0IHJldHVybnMgLTEgaWYg
Z3JwICE9IGNyZWQtPmZzZ2lkIGFuZCB0aGUgZm91bmQgZ3JwIGlzIHJlc3RyaWN0ZWQuDQo+ID4N
Cj4gPiBpbl9ncm91cF9wKCkgZG9lc24ndCBjaGVjayBpZiB0aGUNCj4gPiBncm91cCBpcyByZXN0
cmljdGVkIG9yIG5vdC4NCj4gDQo+IEFuZCBpdCBzaG91bGRuJ3QuIEl0IHJldHVybnMgdGhlIHJl
c3VsdCBvZiBncm91cHNfc2VhcmNoKCkgaWYgdGhpcw0KPiBncnAgaXMgc3VwcGxlbWVudGFyeSBv
ciAibm90IGZvdW5kIi4NCj4gDQo+ID4gYWNsX3Blcm1pc3Npb25fY2hlY2soKSBkb2VzLCBidXQN
Cj4gPiBpbiB5b3VyIGV4YW1wbGUgaXQgZG9lc24ndCBhcyB3ZWxsLg0KPiANCj4gQnV0IGl0IGRv
ZXM/Pz8gc2VlIGJlbG93Li4uDQo+IA0KPiA+IEkgdGhpbmsgeW91IG1lYW4gdG8gbW92ZSB0aGUN
Cj4gPiByZXN0cmljdF9iaXRtYXAgY2hlY2sgdXB3YXJkcyB0bw0KPiA+IGluX2dyb3VwX3AoKT8N
Cj4gDQo+IE5vLCBJIG1lYW50IHRvIG1vdmUgdGhlIHJlc3RyaWN0X2JpdG1hcCBjaGVjayB0byBn
cm91cHNfc2VhcmNoKCksIHNlZSB0aGUgcGF0Y2gNCj4gYWJvdmUuDQoNCkFoLCBJIHNlZSBub3ch
DQpTb3JyeS4NCkkgZGlkbid0IGV4cGVjdCB0byBtb3ZlIHRoYXQgY2hlY2sNCnRoYXQgZmFyLCBz
byBJIHRob3VnaHQgeW91IG1lYW4ganVzdA0KbWFrZSBncm91cHNfc2VhcmNoKCkgMC1iYXNlZCBh
bmQNCi0xIGlmIG5vdCBmb3VuZC4uLiBldmVuIGlmIHlvdSBzYWlkDQpvdGhlcndpc2UuDQoNClll
cywgLTEgd2hlbiBmb3VuZCBidXQgcmVzdHJpY3RlZA0KaXMgdGhlIHZlcnkgaW50ZXJlc3Rpbmcg
c2ltcGxpZmljYXRpb24hDQpXaWxsIHNlbmQgYW4gdXBkYXRlLg0KVGhhbmtzLg0KDQo+IA0KPiA+
IEFueXdheSwgc3VwcG9zZSB5b3UgZG9uJ3QgbWVhbiB0aGF0Lg0KPiA+IEluIHRoaXMgY2FzZToN
Cj4gPiAxLiBpbl9ncm91cF9wKCkgYW5kIGluX2Vncm91cF9wKCkNCj4gPiAgIHNob3VsZCBiZSBj
aGFuZ2VkOg0KPiA+IC0gIGludCByZXR2YWwgPSAxOw0KPiA+ICsgaW50IHJldHZhbCA9IC0xOw0K
PiANCj4gV2h5PyAtMSBtZWFucyB0aGF0IHRoZSBncnAgaXMgc3VwcGxlbWVudGFyeSBhbmQgcmVz
dHJpY3RlZC4NCj4gDQo+ID4gVGhlcmUgYXJlIGFsc28gdGhlIGNhbGxlcnMgb2YgZ3JvdXBzX3Nl
YXJjaCgpDQo+ID4gaW4ga2VybmVsL2F1ZGl0c2MuYyBhbmQgdGhleSBzaG91bGQNCj4gPiBiZSB1
cGRhdGVkLg0KPiANCj4gV2h5PyBJIGRvbid0IHRoaW5rIHNvLiBhdWRpdF9maWx0ZXJfcnVsZXMo
KSB1c2VzIHRoZSByZXN1bHQgb2YgZ3JvdXBzX3NlYXJjaCgpDQo+IGFzIGEgYm9vbGVhbi4NCj4g
DQo+ID4gPlNvIGFjbF9wZXJtaXNzaW9uX2NoZWNrKCkgY2FuIHNpbXBseSBkbw0KPiA+ID4NCj4g
PiA+CWlmIChtYXNrICYgKG1vZGUgXiAobW9kZSA+PiAzKSkpIHsNCj4gPiA+CQl2ZnNnaWRfdCB2
ZnNnaWQgPSBpX2dpZF9pbnRvX3Zmc2dpZChpZG1hcCwgaW5vZGUpOw0KPiA+ID4JCWludCB4eHgg
PSB2ZnNnaWRfaW5fZ3JvdXBfcCh2ZnNnaWQpOw0KPiA+ID4NCj4gPiA+CQlpZiAoeHh4KSB7DQo+
ID4gPgkJCWlmIChtYXNrICYgfihtb2RlID4+IDMpKQ0KPiA+ID4JCQkJcmV0dXJuIC1FQUNDRVM7
DQo+ID4gPgkJCWlmICh4eHggPiAwKQ0KPiA+ID4JCQkJcmV0dXJuIDA7DQo+ID4gPgkJCS8qIElm
IHdlIGhpdCByZXN0cmljdF9iaXRtYXAsIHRoZW4gY2hlY2sgT3RoZXJzLiAqLw0KPiA+ID4JCX0N
Cj4gPiA+CX0NCj4gPg0KPiA+IFdlbGwsIGluIG15IGltcGwgaXQgc2hvdWxkIGNoZWNrDQo+ID4g
dGhlIGJpdG1hcCByaWdodCBoZXJlLCBidXQgeW91IHJlbW92ZWQNCj4gPiB0aGF0Lg0KPiANCj4g
Tm8sIEkgZGlkbid0IHJlbW92ZSB0aGUgY2hlY2ssIHRoaXMgY29kZSByZWxpZXMgb24gdGhlIGNo
YW5nZSBpbg0KPiBncm91cHNfc2VhcmNoKCkuIE5vdGUgdGhlICJ4eHggPiAwIiBjaGVjay4NCj4g
DQo+IEkgbXVzdCBoYXZlIG1pc3NlZCBzb21ldGhpbmcgOi8NCj4gDQo+IE9sZWcuDQo+IA0KPg==

