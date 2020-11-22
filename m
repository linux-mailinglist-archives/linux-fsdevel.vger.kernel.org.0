Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276732BFC50
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 23:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgKVWeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 17:34:44 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:24420 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgKVWeo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 17:34:44 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-137-fQDVZIgbMS2BrZY7UtebNg-1; Sun, 22 Nov 2020 22:34:38 +0000
X-MC-Unique: fQDVZIgbMS2BrZY7UtebNg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 22 Nov 2020 22:34:37 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 22 Nov 2020 22:34:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
CC:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/29] iov_iter: Switch to using a table of operations
Thread-Topic: [PATCH 01/29] iov_iter: Switch to using a table of operations
Thread-Index: AQHWwQTEMI88twW4zUSLxoYAnZFgBanUtsxQ
Date:   Sun, 22 Nov 2020 22:34:37 +0000
Message-ID: <3ba98abf0ddb4f16af7166db201fe9c1@AcuMS.aculab.com>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com>
 <254318.1606051984@warthog.procyon.org.uk>
 <CAHk-=wggLYmTe5jm7nWvywcNNxUd=Vm4eGFYq8MjNZizpOzBLw@mail.gmail.com>
In-Reply-To: <CAHk-=wggLYmTe5jm7nWvywcNNxUd=Vm4eGFYq8MjNZizpOzBLw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjIgTm92ZW1iZXIgMjAyMCAxOToyMg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDAxLzI5XSBpb3ZfaXRlcjogU3dpdGNoIHRvIHVzaW5nIGEgdGFi
bGUgb2Ygb3BlcmF0aW9ucw0KPiANCj4gT24gU3VuLCBOb3YgMjIsIDIwMjAgYXQgNTozMyBBTSBE
YXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEkgZG9u
J3Qga25vdyBlbm91Z2ggYWJvdXQgaG93IHNwZWN0cmUgdjIgd29ya3MgdG8gc2F5IGlmIHRoaXMg
d291bGQgYmUgYQ0KPiA+IHByb2JsZW0gZm9yIHRoZSBvcHMtdGFibGUgYXBwcm9hY2gsIGJ1dCB3
b3VsZG4ndCBpdCBhbHNvIGFmZmVjdCB0aGUgY2hhaW4gb2YNCj4gPiBjb25kaXRpb25hbCBicmFu
Y2hlcyB0aGF0IHdlIGN1cnJlbnRseSB1c2UsIHNpbmNlIGl0J3MgYnJhbmNoLXByZWRpY3Rpb24N
Cj4gPiBiYXNlZD8NCj4gDQo+IE5vLCByZWd1bGFyIGNvbmRpdGlvbmFsIGJyYW5jaGVzIGFyZW4n
dCBhIHByb2JsZW0uIFllcywgdGhleSBtYXkNCj4gbWlzcHJlZGljdCwgYnV0IG91dHNpZGUgb2Yg
YSBmZXcgdmVyeSByYXJlIGNhc2VzIHRoYXQgd2UgaGFuZGxlDQo+IHNwZWNpYWxseSwgdGhhdCdz
IG5vdCBhbiBpc3N1ZS4NCj4gDQo+IFdoeT8gQmVjYXVzZSB0aGV5IGFsd2F5cyBtaXNwcmVkaWN0
IHRvIG9uZSBvciB0aGUgb3RoZXIgc2lkZSwgc28gdGhlDQo+IGNvZGUgZmxvdyBtYXkgYmUgbWlz
LXByZWRpY3RlZCwgYnV0IGl0IGlzIGZhaXJseSBjb250cm9sbGVkLg0KPiANCj4gSW4gY29udHJh
c3QsIGFuIGluZGlyZWN0IGp1bXAgY2FuIG1pc3ByZWRpY3QgdGhlIHRhcmdldCwgYW5kIGJyYW5j
aA0KPiBfYW55d2hlcmVfLCBhbmQgdGhlIGF0dGFjayB2ZWN0b3JzIGNhbiBwb2lzb24gdGhlIEJU
QiAoYnJhbmNoIHRhcmdldA0KPiBidWZmZXIpLCBzbyBvdXIgbWl0aWdhdGlvbiBmb3IgdGhhdCBp
cyB0aGF0IGV2ZXJ5IHNpbmdsZSBpbmRpcmVjdA0KPiBicmFuY2ggaXNuJ3QgcHJlZGljdGVkIGF0
IGFsbCAodXNpbmcgInJldHBvbGluZSIpLg0KPiANCj4gU28gYSBjb25kaXRpb25hbCBicmFuY2gg
dGFrZXMgemVybyBjeWNsZXMgd2hlbiBwcmVkaWN0ZWQgKGFuZCBtb3N0DQo+IHdpbGwgcHJlZGlj
dCBxdWl0ZSB3ZWxsKS4gQW5kIGFzIERhdmlkIExhaWdodCBwb2ludGVkIG91dCBhIGNvbXBpbGVy
DQo+IGNhbiBhbHNvIHR1cm4gYSBzZXJpZXMgb2YgY29uZGl0aW9uYWwgYnJhbmNoZXMgaW50byBh
IHRyZWUsIG1lYW5zIHRoYXQNCj4gTiBjb25kaXRpb25hbCBicmFuY2hlcyBiYXNpY2FsbHkgb25s
eSBuZWVkcyBsb2cyKE4pIGNvbmRpdGlvbmFscw0KPiBleGVjdXRlZC4NCg0KVGhlIGNvbXBpbGVy
IGNhbiBjb252ZXJ0IGEgc3dpdGNoIHN0YXRlbWVudCBpbnRvIGEgYnJhbmNoIHRyZWUuDQpCdXQg
SSBkb24ndCB0aGluayBpdCBjYW4gY29udmVydCB0aGUgJ2lmIGNoYWluJyBpbiB0aGUgY3VycmVu
dCBjb2RlDQp0byBvbmUuDQoNClRoZXJlIGlzIGFsc28gdGhlIHByb2JsZW0gdGhhdCBzb21lIHg4
NiBjcHUgY2FuJ3QgcHJlZGljdCBicmFuY2hlcw0KaWYgdG9vIG1hbnkgaGFwcGVuIGluIHRoZSBz
YW1lIGNhY2hlIGxpbmUgKG9yIHNpbWlsYXIpLg0KDQo+IEluIGNvbnRyYXN0LCB3aXRoIHJldHBv
bGluZSBpbiBwbGFjZSwgYW4gaW5kaXJlY3QgYnJhbmNoIHdpbGwNCj4gYmFzaWNhbGx5IGFsd2F5
cyB0YWtlIHNvbWV0aGluZyBsaWtlIDI1LTMwIGN5Y2xlcywgYmVjYXVzZSBpdCBhbHdheXMNCj4g
bWlzcHJlZGljdHMuDQoNCkkgYWxzbyB3b25kZXIgaWYgYSByZXRwb2xpbmUgYWxzbyB0cmFzaGVz
IHRoZSByZXR1cm4gc3RhY2sgb3B0aW1pc2F0aW9uLg0KKElmIHRoYXQgaXMgZXZlciByZWFsbHkg
YSBzaWduaWZpY2FudCBnYWluIGZvciByZWFsIGZ1bmN0aW9ucy4pDQogDQouLi4NCj4gU28gdGhp
cyBpcyBub3QgaW4gYW55IHdheSAiaW5kaXJlY3QgYnJhbmNoZXMgYXJlIGJhZCIuIEl0J3MgbW9y
ZSBvZiBhDQo+ICJpbmRpcmVjdCBicmFuY2hlcyByZWFsbHkgYXJlbid0IG5lY2Vzc2FyaWx5IGJl
dHRlciB0aGFuIGEgY291cGxlIG9mDQo+IGNvbmRpdGlvbmFscywgYW5kIF9tYXlfIGJlIG11Y2gg
d29yc2UiLg0KDQpFdmVuIHdpdGhvdXQgcmV0cG9saW5lcywgdGhlIGp1bXAgdGFibGUgaXMgbGlr
ZWx5IHRvIGEgZGF0YS1jYWNoZQ0KbWlzcyAoYW5kIG1heWJlIGEgVExCIG1pc3MpIHVubGVzcyB5
b3UgYXJlIHJ1bm5pbmcgaG90LWNhY2hlLg0KVGhhdCBpcyBwcm9iYWJseSBhbiBleHRyYSBjYWNo
ZSBtaXNzIG9uIHRvcCBvZiB0aGUgSS1jYWNoZSBvbmVzLg0KRXZlbiB3b3JzZSBpZiB5b3UgZW5k
IHVwIHdpdGggdGhlIGp1bXAgdGFibGUgbmVhciB0aGUgY29kZQ0Kc2luY2UgdGhlIGRhdGEgY2Fj
aGUgbGluZSBhbmQgVExCIG1pZ2h0IG5ldmVyIGJlIHNoYXJlZC4NCg0KU28gYSB2ZXJ5IHNob3J0
IHN3aXRjaCBzdGF0ZW1lbnQgaXMgbGlrZWx5IHRvIGJlIGJldHRlciBhcw0KY29uZGl0aW9uYWwg
anVtcHMgYW55d2F5Lg0KDQo+IEZvciBleGFtcGxlLCBsb29rIGF0IHRoaXMgZ2NjIGJ1Z3ppbGxh
Og0KPiANCj4gICAgIGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lk
PTg2OTUyDQo+IA0KPiB3aGljaCBiYXNpY2FsbHkgaXMgYWJvdXQgdGhlIGNvbXBpbGVyIGdlbmVy
YXRpbmcgYSBqdW1wIHRhYmxlIChpcyBhDQo+IHNpbmdsZSBpbmRpcmVjdCBicmFuY2gpIHZzIGEg
c2VyaWVzIG9mIGNvbmRpdGlvbmFsIGJyYW5jaGVzLiBXaXRoDQo+IHJldHBvbGluZSwgdGhlIGNy
b3NzLW92ZXIgcG9pbnQgaXMgYmFzaWNhbGx5IHdoZW4geW91IG5lZWQgdG8gaGF2ZQ0KPiBvdmVy
IDEwIGNvbmRpdGlvbmFsIGJyYW5jaGVzIC0gYW5kIGJlY2F1c2Ugb2YgdGhlIGxvZzIoTikgYmVo
YXZpb3IsDQo+IHRoYXQncyBhcm91bmQgYSB0aG91c2FuZCBjYXNlcyENCg0KVGhhdCB3YXMgYSBo
b3QtY2FjaGUgdGVzdC4NCkNvbGQtY2FjaGUgaXMgbGlrZWx5IHRvIGZhdm91ciB0aGUgcmV0cG9s
aW5lIGEgbGl0dGxlIHNvb25lci4NCihBbmQgdGhlIHJldHBvbGluZSAocHJvYmJhbHkpIHdvbid0
IGJlIChtdWNoKSB3b3JzZSB0aGFuIHRoZQ0KbWlkLXByZWRpY3RlZCBpbmRpcmVjdCBqdW1wLg0K
DQpJIGRvIHdvbmRlciBob3cgbXVjaCBvZiB0aGUga2VybmVsIGFjdHVhbGx5IHJ1bnMgaG90LWNh
Y2hlPw0KRXhjZXB0IGZvciBwYXJ0cyB0aGF0IGV4cGxpY2l0bHkgcnVuIHRoaW5ncyBpbiBidXJz
dHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

