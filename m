Return-Path: <linux-fsdevel+bounces-15234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BB88ACAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24112A1F0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414F613FD73;
	Mon, 25 Mar 2024 17:18:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD713E8AF;
	Mon, 25 Mar 2024 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387102; cv=none; b=XY8ihBW1ConnV1OyZWOo0+hFXz6n8FYYW8VvsI1lq/mp8OC6GIlfOBpFVZuLv4RGocrRDutLO7ulsxUiv7WQu8jK0u47JVvRXYdEzCxoBHkC1b3vxd3liudQ9XIypemKYP00fXYufodDjMOZdVtk47GONfncEZgonhX796B3bLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387102; c=relaxed/simple;
	bh=7Plp+Vb3OYVdjH+L6Wf/KDH9AYjXaHPGBZf5tgminbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NkheQ3/e3/haj+jDnk0Leu2dtjh4Ma58ZoDWOZK30F/yVhY6SgIAdfcKD4OGv4EpKL5YVu8B6JK9e91vfRrrRVrwulqhTzqRJQYNvO+W25TGgVR9Fbt/Ebh5Z1TYFRx+4n5dQE/Yl9PWL1XlIsgOM8gNJipLd8K2pspiGAVIC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3KPG62YZz6J9xf;
	Tue, 26 Mar 2024 01:17:22 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 075D4140DAF;
	Tue, 26 Mar 2024 01:18:17 +0800 (CST)
Received: from frapeml500005.china.huawei.com (7.182.85.13) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 18:18:16 +0100
Received: from frapeml500005.china.huawei.com ([7.182.85.13]) by
 frapeml500005.china.huawei.com ([7.182.85.13]) with mapi id 15.01.2507.035;
 Mon, 25 Mar 2024 18:18:16 +0100
From: Roberto Sassu <roberto.sassu@huawei.com>
To: Christian Brauner <brauner@kernel.org>
CC: Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>, LKML
	<linux-kernel@vger.kernel.org>, linux-fsdevel
	<linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, "Paulo
 Alcantara" <pc@manguebit.com>, Christian Brauner <christian@brauner.io>,
	"Mimi Zohar" <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: RE: kernel crash in mknod
Thread-Topic: kernel crash in mknod
Thread-Index: AQHafag2XY/u/k17xEe65QyoT7TnEbFGUTAAgADHHcCAAXhhAIAAIPoA
Date: Mon, 25 Mar 2024 17:18:16 +0000
Message-ID: <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
In-Reply-To: <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBGcm9tOiBDaHJpc3RpYW4gQnJhdW5lciBbbWFpbHRvOmJyYXVuZXJAa2VybmVsLm9yZ10NCj4g
U2VudDogTW9uZGF5LCBNYXJjaCAyNSwgMjAyNCA1OjA2IFBNDQo+IE9uIFN1biwgTWFyIDI0LCAy
MDI0IGF0IDA0OjUwOjI0UE0gKzAwMDAsIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4gPiBGcm9t
OiBBbCBWaXJvIFttYWlsdG86dmlyb0BmdHAubGludXgub3JnLnVrXSBPbiBCZWhhbGYgT2YgQWwg
Vmlybw0KPiA+ID4gU2VudDogU3VuZGF5LCBNYXJjaCAyNCwgMjAyNCA2OjQ3IEFNDQo+ID4gPiBP
biBTdW4sIE1hciAyNCwgMjAyNCBhdCAxMjowMDoxNUFNIC0wNTAwLCBTdGV2ZSBGcmVuY2ggd3Jv
dGU6DQo+ID4gPiA+IEFueW9uZSBlbHNlIHNlZWluZyB0aGlzIGtlcm5lbCBjcmFzaCBpbiBkb19t
a25vZGF0IChJIHNlZSBpdCB3aXRoIGENCj4gPiA+ID4gc2ltcGxlICJta2ZpZm8iIG9uIHNtYjMg
bW91bnQpLiAgSSBzdGFydGVkIHNlZWluZyB0aGlzIGluIDYuOS1yYyAoZGlkDQo+ID4gPiA+IG5v
dCBzZWUgaXQgaW4gNi44KS4gICBJIGRpZCBub3Qgc2VlIGl0IHdpdGggdGhlIDMvMTIvMjMgbWFp
bmxpbmUNCj4gPiA+ID4gKGVhcmx5IGluIHRoZSA2LjktcmMgbWVyZ2UgV2luZG93KSBidXQgSSBk
byBzZWUgaXQgaW4gdGhlIDMvMjIgYnVpbGQNCj4gPiA+ID4gc28gaXQgbG9va3MgbGlrZSB0aGUg
cmVncmVzc2lvbiB3YXMgaW50cm9kdWNlZCBieToNCj4gPiA+DQo+ID4gPiAJRldJVywgc3VjY2Vz
c2Z1bCAtPm1rbm9kKCkgaXMgYWxsb3dlZCB0byByZXR1cm4gMCBhbmQgdW5oYXNoDQo+ID4gPiBk
ZW50cnksIHJhdGhlciB0aGFuIGJvdGhlcmluZyB3aXRoIGxvb2t1cHMuICBTbyBjb21taXQgaW4g
cXVlc3Rpb24NCj4gPiA+IGlzIGJvZ3VzIC0gbGFjayBvZiBlcnJvciBkb2VzICpOT1QqIG1lYW4g
dGhhdCB5b3UgaGF2ZSBzdHJ1Y3QgaW5vZGUNCj4gPiA+IGV4aXN0aW5nLCBsZXQgYWxvbmUgYXR0
YWNoZWQgdG8gZGVudHJ5LiAgVGhhdCBraW5kIG9mIGJlaGF2aW91cg0KPiA+ID4gdXNlZCB0byBi
ZSBjb21tb24gZm9yIG5ldHdvcmsgZmlsZXN5c3RlbXMgbW9yZSB0aGFuIGp1c3QgZm9yIC0+bWtu
b2QoKSwNCj4gPiA+IHRoZSB0aGVvcnkgYmVpbmcgImlmIHNvbWVib2R5IHdhbnRzIHRvIGxvb2sg
YXQgaXQsIHRoZXkgY2FuIGJsb29keQ0KPiA+ID4gd2VsbCBwYXkgdGhlIGNvc3Qgb2YgbG9va3Vw
IGFmdGVyIGRjYWNoZSBtaXNzIi4NCj4gPiA+DQo+ID4gPiBTYWlkIHRoYXQsIHRoZSBsYW5ndWFn
ZSBpbiBEL2YvdmZzLnJzdCBpcyB2YWd1ZSBhcyBoZWxsIGFuZCBpcyB2ZXJ5IGVhc3kNCj4gPiA+
IHRvIG1pc3JlYWQgaW4gZGlyZWN0aW9uIG9mICJ5b3UgbXVzdCBpbnN0YW50aWF0ZSIuDQo+ID4g
Pg0KPiA+ID4gVGhhbmtmdWxseSwgdGhlcmUncyBubyBjb3VudGVycGFydCB3aXRoIG1rZGlyIC0g
KnRoZXJlKiBpdCdzIG5vdCBqdXN0DQo+ID4gPiBwb3NzaWJsZSwgaXQncyBpbmV2aXRhYmxlIGlu
IHNvbWUgY2FzZXMgZm9yIGUuZy4gbmZzLg0KPiA+ID4NCj4gPiA+IFdoYXQgdGhlIGhlbGwgaXMg
dGhhdCBob29rIGRvaW5nIGluIG5vbi1TX0lGUkVHIGNhc2VzLCBhbnl3YXk/ICBNb3ZlIGl0DQo+
ID4gPiB1cCBhbmQgYmUgZG9uZSB3aXRoIGl0Li4uDQo+ID4NCj4gPiBIaSBBbA0KPiA+DQo+ID4g
dGhhbmtzIGZvciB0aGUgcGF0Y2guIEluZGVlZCwgaXQgd2FzIGxpa2UgdGhhdCBiZWZvcmUsIHdo
ZW4gaW5zdGVhZCBvZg0KPiA+IGFuIExTTSBob29rIHRoZXJlIHdhcyBhbiBJTUEgY2FsbC4NCj4g
DQo+IENvdWxkIHlvdSBwbGVhc2Ugc3RhcnQgYWRkaW5nIGxvcmUgbGlua3MgaW50byB5b3VyIGNv
bW1pdCBtZXNzYWdlcyBmb3INCj4gYWxsIG1lc3NhZ2VzIHRoYXQgYXJlIHNlbnQgdG8gYSBtYWls
aW5nIGxpc3Q/IEl0IHJlYWxseSBtYWtlcyB0cmFja2luZw0KPiBkb3duIHRoZSBvcmlnaW5hbCB0
aHJlYWQgYSBsb3QgZWFzaWVyLg0KDQpTdXJlLCB3aWxsIGRvIG5leHQgdGltZS4NCg0KPiA+IEhv
d2V2ZXIsIEkgdGhvdWdodCwgc2luY2Ugd2Ugd2VyZSBwcm9tb3RpbmcgaXQgYXMgYW4gTFNNIGhv
b2ssDQo+ID4gd2Ugc2hvdWxkIGJlIGFzIGdlbmVyaWMgcG9zc2libGUsIGFuZCBzdXBwb3J0IG1v
cmUgdXNhZ2VzIHRoYW4NCj4gPiB3aGF0IHdhcyBuZWVkZWQgZm9yIElNQS4NCj4gDQo+IEknbSBh
IGJpdCBjb25mdXNlZCBub3cgd2h5IHRoaXMgaXMgdGFraW5nIGEgZGVudHJ5LiBOb3RoaW5nIGlu
IElNQSBvcg0KPiBFVk0gY2FyZXMgYWJvdXQgdGhlIGRlbnRyeSBmb3IgdGhlc2UgaG9va3Mgc28g
aXQgcmVhbGx5IHNob3VsZCBoYXZlIHRha2UNCj4gYW4gaW5vZGUgaW4gdGhlIGZpcnN0IHBsYWNl
Pw0KDQpVaG0sIHlvdSBhcmUgcmlnaHQuIERvZXMgdGhhdCBtZWFuIHRoYXQgaW5zdGVhZCBvZiB3
aGF0IEFsIHByb3Bvc2VkLA0Kd2UgY2FuIGNoYW5nZSB0aGUgcGFyYW1ldGVyIG9mIHNlY3VyaXR5
X3BhdGhfcG9zdF9ta25vZCgpIGZyb20NCmRlbnRyeSB0byBpbm9kZT8NCg0KPiBBbmQgb25lIG1p
bm9yIG90aGVyIHF1ZXN0aW9uIEkganVzdCByZWFsaXplZC4gV2h5IGFyZSBzb21lIG9mIHRoZSBu
ZXcNCj4gaG9va3MgY2FsbGVkIHNlY3VyaXR5X3BhdGhfcG9zdF9ta25vZCgpIHdoZW4gdGhleSBh
cmVuJ3QgYWN0dWFsbHkgdGFraW5nDQo+IGEgcGF0aCBpbiBjb250cmFzdCB0byBzYXkNCj4gc2Vj
dXJpdHlfcGF0aF97Y2hvd24sY2htb2QsbWtub2QsY2hyb290LHRydW5jYXRlfSgpIHRoYXQgZG8u
DQoNCkkgd291bGQgYWdyZWUgdG8gYW55IGNoYW5nZSB0aGF0IG1ha2VzIHRoaXMgbW9yZSBjb25z
aXN0ZW50LCBhcyBsb25nIGFzDQpJTUEgaGFzIGFjY2VzcyB0byB0aGUgbmV3IGlub2RlLg0KDQpS
b2JlcnRvDQo=

