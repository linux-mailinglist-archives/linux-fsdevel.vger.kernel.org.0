Return-Path: <linux-fsdevel+bounces-6206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1884C814FBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 19:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557BFB22831
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084F3EA71;
	Fri, 15 Dec 2023 18:29:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191630139
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-102-dwHkrF_VMcKZTSA8qp3ypQ-1; Fri, 15 Dec 2023 18:27:37 +0000
X-MC-Unique: dwHkrF_VMcKZTSA8qp3ypQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Dec
 2023 18:27:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 15 Dec 2023 18:27:22 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'NeilBrown' <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>
CC: Chuck Lever <chuck.lever@oracle.com>, Christian Brauner
	<brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, Oleg Nesterov
	<oleg@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Thread-Topic: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Thread-Index: AQHaLVs+Da4cBTiba0eOmEq6cWLvM7Cqq/GA
Date: Fri, 15 Dec 2023 18:27:22 +0000
Message-ID: <ac74bdb82e114d71b26864fe51f6433b@AcuMS.aculab.com>
References: <20231208033006.5546-1-neilb@suse.de>,
 <20231208033006.5546-2-neilb@suse.de>,
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>,
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>,
 <20231211191117.GD1674809@ZenIV>,
 <170233343177.12910.2316815312951521227@noble.neil.brown.name>,
 <20231211231330.GE1674809@ZenIV>, <20231211232135.GF1674809@ZenIV>
 <170242728484.12910.12134295135043081177@noble.neil.brown.name>
In-Reply-To: <170242728484.12910.12134295135043081177@noble.neil.brown.name>
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

Li4uDQo+ID4gUFM6IHB1dCBpdCB0aGF0IHdheSAtIEkgY2FuIGJ1eSAibmZzZCBpcyBkb2luZyB0
aGF0IG9ubHkgdG8gcmVndWxhcg0KPiA+IGZpbGVzIGFuZCBub3Qgb24gYW4gYXJiaXRyYXJ5IGZp
bGVzeXN0ZW0sIGF0IHRoYXQ7IGhhdmluZyB0aGUgdGhyZWFkDQo+ID4gd2FpdCBvbiB0aGF0IHN1
Y2tlciBpcyBub3QgZ29pbmcgdG8gY2F1c2UgdG9vIG11Y2ggdHJvdWJsZSI7IEkgZG8gKm5vdCoN
Cj4gPiBidXkgdHVybmluZyBpdCBpbnRvIGEgdGhpbmcgdXNhYmxlIG91dHNpZGUgb2YgYSB2ZXJ5
IG5hcnJvdyBzZXQgb2YNCj4gPiBjaXJjdW1zdGFuY2VzLg0KPiA+DQo+IA0KPiBDYW4geW91IHNh
eSBtb3JlIGFib3V0ICJub3Qgb24gYW4gYXJiaXRyYXJ5IGZpbGVzeXN0ZW0iID8NCj4gSSBndWVz
cyB5b3UgbWVhbnMgdGhhdCBwcm9jZnMgYW5kL29yIHN5c2ZzIG1pZ2h0IGJlIHByb2JsZW1hdGlj
IGFzIG1heQ0KPiBzaW1pbGFyIHZpcnR1YWwgZmlsZXN5c3RlbXMgKG5mc2QgbWF5YmUpLg0KDQpD
YW4gbmZzIGV4cG9ydCBhbiBleHQ0IGZzIHRoYXQgaXMgb24gYSBsb29wYmFjayBtb3VudCBvbiBh
IGZpbGUNCnRoYXQgaXMgcmVtb3RlbHkgbmZzIChvciBvdGhlcikgbW91bnRlZD8NCg0KQXMgc29v
biBhcyB5b3UgZ2V0IGxvb3BzIGxpa2UgdGhhdCB5b3UgbWlnaHQgZmluZCB0aGF0IGZwdXQoKSBz
dGFydHMNCmJlaW5nIHByb2JsZW1hdGljLg0KDQpJJ20gYWxzbyBzdXJlIEkgcmVtZW1iZXIgdGhh
dCBuZnMgd2Fzbid0IHN1cHBvc2VkIHRvIHJlc3BvbmQgdG8gYSB3cml0ZQ0KdW50aWwgaXQgaGFk
IGlzc3VlZCB0aGUgYWN0dWFsIGRpc2sgd3JpdGUgLSBidXQgbWF5YmUgbm8gb25lIGRvIHRoYXQN
CmFueSBtb3JlIGJlY2F1c2UgaXQgcmVhbGx5IGlzIHRvbyBzbG93Lg0KKEVzcGVjaWFsbHkgaWYg
dGhlICdkaXNrJyBpcyBhIFVTQiBzdGljay4pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


