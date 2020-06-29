Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF920DE1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 23:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgF2UWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:22:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23147 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732563AbgF2TZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:33 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-10-CAqVtc7cNsK1P-8WmJmePQ-1; Mon, 29 Jun 2020 09:21:23 +0100
X-MC-Unique: CAqVtc7cNsK1P-8WmJmePQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 29 Jun 2020 09:21:22 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 29 Jun 2020 09:21:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Iurii Zaikin" <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Thread-Topic: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Thread-Index: AQHWSlL8Fz5PlOyONku9ShNOCTqEYajsST7AgABSmoCAAqgYcA==
Date:   Mon, 29 Jun 2020 08:21:22 +0000
Message-ID: <fcd951e164a3407295971e3a4236b418@AcuMS.aculab.com>
References: <20200624162901.1814136-1-hch@lst.de>
 <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de>
 <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com>
 <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
In-Reply-To: <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjcgSnVuZSAyMDIwIDE3OjMzDQo+IE9uIFNh
dCwgSnVuIDI3LCAyMDIwIGF0IDM6NDkgQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1
bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEp1c3Qga2VlcCB0aGUgZXhpc3RpbmcgInNldF9m
cygpIi4gSXQncyBub3QgaGFybWZ1bCBpZiBpdCdzIG9ubHkgdXNlZA0KPiA+ID4gb2NjYXNpb25h
bGx5LiBXZSBzaG91bGQgcmVuYW1lIGl0IG9uY2UgaXQncyByYXJlIGVub3VnaCwgdGhvdWdoLg0K
PiA+DQo+ID4gQW0gSSByaWdodCBpbiB0aGlua2luZyB0aGF0IGl0IGp1c3Qgc2V0cyBhIGZsYWcg
aW4gJ2N1cnJlbnQnID8NCj4gDQo+IEJhc2ljYWxseSwgeWVzLiBUaGF0J3Mgd2hhdCBpdCBoYXMg
YWx3YXlzIGRvbmUuDQoNCkkgY291bGQgY2hlY2ssIGJ1dCBJIHN1c3BlY3QgaXQgc2V0cyB3aGF0
IFRBU0tfU0laRSB1c2VzIHRvIH4wdQ0Kc28gdGhhdCBhY2Nlc3Nfb2soKSBjYW4ndCBmYWlsLg0K
DQo+IFdlbGwgImFsd2F5cyIgaXMgbm90IHRydWUgLSBpdCB1c2VkIHRvIHNldCB0aGUgJWZzIHNl
Z21lbnQgcmVnaXN0ZXINCj4gb3JpZ2luYWxseSAodGh1cyB0aGUgbmFtZSksIGJ1dCBfY29uY2Vw
dHVhbGx5XyBpdCBzZXRzIGEgZmxhZyBmb3INCj4gInNob3VsZCB1c2VyIGFjY2Vzc2VzIGJlIGtl
cm5lbCBhY2Nlc3NlcyBpbnN0ZWFkIi4NCj4gDQo+IE9uIHg4NiAtIGFuZCBtb3N0IG90aGVyIGFy
Y2hpdGVjdHVyZXMgd2hlcmUgdXNlciBzcGFjZSBhbmQga2VybmVsDQo+IHNwYWNlIGFyZSBpbiB0
aGUgc2FtZSBhZGRyZXNzIHNwYWNlIGFuZCBhY2Nlc3NlZCB3aXRoIHRoZSBzYW1lDQo+IGluc3Ry
dWN0aW9ucywgdGhhdCBoYXMgdGhlbiBiZWVuIGltcGxlbWVudGVkIGFzIGp1c3QgYSAid2hhdCBp
cyB0aGUNCj4gbGltaXQgZm9yIGFuIGFjY2VzcyIuDQo+IA0KPiBPbiBvdGhlciBhcmNoaXRlY3R1
cmVzIC0gYXJjaGl0ZWN0dXJlcyB0aGF0IG5lZWQgZGlmZmVyZW50IGFjY2Vzcw0KPiBtZXRob2Rz
IChvciBkaWZmZXJlbnQgZmxhZ3MgdG8gdGhlIGxvYWQvc3RvcmUgaW5zdHJ1Y3Rpb24pIC0gaXQn
cyBhbg0KPiBhY3R1YWwgZmxhZyB0aGF0IGNoYW5nZXMgd2hpY2ggYWNjZXNzIG1ldGhvZCB5b3Ug
dXNlLg0KPiANCj4gPiBBbHRob3VnaCBJIGRvbid0IHJlbWVtYmVyIGFjY2Vzc19vaygpIGRvaW5n
IGEgc3VpdGFibGUgY2hlY2sNCj4gPiAod291bGQgbmVlZCB0byBiZSAoYWRkcmVzcyAtIGJhc2Up
IDwgbGltaXQpLg0KPiANCj4gU28gYWdhaW4sIG9uIHRoZSBhcmNoaXRlY3R1cmVzIHdpdGggYSB1
bmlmaWVkIGFkZHJlc3Mgc3BhY2UsDQo+IGFjY2Vzc19vaygpIGlzIGV4YWN0bHkgdGhhdCAiYWRk
cmVzcyArIGFjY2Vzc19zaXplIDw9IGxpbWl0IiwgYWx0aG91Z2gNCj4gb2Z0ZW4gZG9uZSB3aXRo
IHNvbWUgaW5saW5lIGFzbSBqdXN0IHRvIGdldCB0aGUgb3ZlcmZsb3cgY2FzZSBkb25lDQo+IGVm
ZmljaWVudGx5Lg0KDQpJIHJlYWxpc2VkIGFmdGVyd2FyZHMgdGhhdCB0aGUgJ2tlcm5lbCBhZGRy
ZXNzIGlzIGFjdHVhbGx5IHVzZXInDQpjaGVjayBpc24ndCByZWFsbHkgZG9uZSBvbiBhcmNoaXRl
Y3R1cmVzIGxpa2UgeDg2IHVudGlsIHN0YWMvY2xhYy4NCg0KSSBoYWQgYW5vdGhlciB0aG91Z2h0
Lg0KV2hpbGUgc2V0dGluZyB1cCBhIGZ1bGwtYmxvd24gc2NhdHRlci1nYXRoZXIgJ2l0ZXInIHN0
cnVjdHVyZSBmb3INCmZ1bmN0aW9ucyBsaWtlIFtnc11ldHNvY2tvcHQsIGlvY3RsIGFuZCBmY250
bCBpcyBPVFQgYW5kIHByb2JhYmx5DQptZWFzdXJhYmx5IGV4cGVuc2l2ZSBhIGxpZ2h0d2VpZ2h0
ICdidWZmZXInIHN0cnVjdHVyZSB0aGF0IGp1c3QNCmNvbnRhaW5lZCBhZGRyZXNzLCBsZW5ndGgg
YW5kIHVzZXIva2VybmVsIGZsYWcgY291bGQgYmUgdXNlZC4NCg0KQWx0aG91Z2ggdGhlIHVzZXMg
d291bGQgbmVlZCBhbiBleHRyYSBsZXZlbCBvZiBpbmRpcmVjdGlvbiB0aGlzDQp3b3VsZCBiZSBv
ZmZzZXQgYnkgcmVkdWNpbmcgdGhlIG51bWJlciBvZiBwYXJhbWV0ZXJzIHBhc3NlZA0KdGhyb3Vn
aCBhbGwgdGhlIGxheWVycy4NCg0KLi4uDQo+IEkgdGhvdWdodCB0aGVyZSB3YXMganVzdCBvbmUg
dmVyeSBzcGVjaWZpYyBjYXNlIG9mICJvaCwgaW4gY2VydGFpbg0KPiBjYXNlcyBvZiBzZXRzb2Nr
b3B0IHdlIGRvbid0IGtub3cgd2hhdCBzaXplIHRoaXMgYWRkcmVzcyBpcyBhbmQgb3B0bGVuDQo+
IGlzIGlnbm9yZWQiLCBzbyB3ZSBoYXZlIHRvIGp1c3QgcGFzcyB0aGUgcG9pbnRlciBkb3duIHRv
IHRoZSBwcm90b2NvbCwNCj4gd2hpY2ggaXMgdGhlIHBvaW50IHRoYXQga25vd3MgaG93IG11Y2gg
b2YgYW4gYWRkcmVzcyBpdCB3YW50cy4uDQoNCkkgY2FuJ3QgaGVscCBmZWVsaW5nIHRoYXQgdXNl
cnNwYWNlIHBhc3NlcyBhIHN1aXRhYmxlIGxlbmd0aCBidXQNCnRoZSBrZXJuZWwgZG9lc24ndCB2
ZXJpZnkgaXQuDQoNCkl0IGlzIHdvcnNlIHRoYW4gdGhhdCwgb25lIG9mIHRoZSBTQ1RQIGdldHNv
Y2tvcHQoKSBjYWxscyBoYXMgdG8gcmV0dXJuDQphIGxlbmd0aCB0aGF0IGlzIHNob3J0ZXIgdGhh
biB0aGUgYnVmZmVyIGl0IHdyb3RlLg0KDQpTbyBhbnkgYnVmZmVyIGRlc2NyaXB0b3IgbGVuZ3Ro
IHdvdWxkIGhhdmUgdG8gYmUgYWR2aXNvcnkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

