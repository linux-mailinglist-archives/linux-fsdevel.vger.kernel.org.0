Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372FE3D3B94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhGWNWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 09:22:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:50800 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235349AbhGWNWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:22:00 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-153-fMVfmb49NQeQD202NT_Naw-1; Fri, 23 Jul 2021 15:02:19 +0100
X-MC-Unique: fMVfmb49NQeQD202NT_Naw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 23 Jul 2021 15:02:18 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 23 Jul 2021 15:02:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: RE: [PATCH] lib/string: Bring optimized memcmp from glibc
Thread-Topic: [PATCH] lib/string: Bring optimized memcmp from glibc
Thread-Index: AQHXfmCv+a+OfT5dDki5fiqLlW+tv6tQh2AQ
Date:   Fri, 23 Jul 2021 14:02:18 +0000
Message-ID: <c31eb59df5f8426aaf0009ab15587cee@AcuMS.aculab.com>
References: <20210721135926.602840-1-nborisov@suse.com>
 <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com>
 <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
In-Reply-To: <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjEgSnVseSAyMDIxIDE5OjQ2DQo+IA0KPiBP
biBXZWQsIEp1bCAyMSwgMjAyMSBhdCAxMToxNyBBTSBOaWtvbGF5IEJvcmlzb3YgPG5ib3Jpc292
QHN1c2UuY29tPiB3cm90ZToNCj4gPg0KPiA+IEkgZmluZCBpdCBzb21ld2hhdCBhcmJpdHJhcnkg
dGhhdCB3ZSBjaG9vc2UgdG8gYWxpZ24gdGhlIDJuZCBwb2ludGVyIGFuZA0KPiA+IG5vdCB0aGUg
Zmlyc3QuDQo+IA0KPiBZZWFoLCB0aGF0J3MgYSBiaXQgb2RkLCBidXQgSSBkb24ndCB0aGluayBp
dCBtYXR0ZXJzLg0KPiANCj4gVGhlIGhvcGUgaXMgb2J2aW91c2x5IHRoYXQgdGhleSBhcmUgbXV0
dWFsbHkgYWxpZ25lZCwgYW5kIGluIHRoYXQgY2FzZQ0KPiBpdCBkb2Vzbid0IG1hdHRlciB3aGlj
aCBvbmUgeW91IGFpbSB0byBhbGlnbi4NCj4gDQo+ID4gU28geW91IGFyZSBzYXlpbmcgdGhhdCB0
aGUgY3VycmVudCBtZW1jbXAgY291bGQgaW5kZWVkIHVzZSBpbXByb3ZlbWVudA0KPiA+IGJ1dCB5
b3UgZG9uJ3Qgd2FudCBpdCB0byBiZSBiYXNlZCBvbiB0aGUgZ2xpYmMncyBjb2RlIGR1ZSB0byB0
aGUgdWdseQ0KPiA+IG1pc2FsaWdubWVudCBoYW5kbGluZz8NCj4gDQo+IFllYWguIEkgc3VzcGVj
dCB0aGF0IHRoaXMgKHZlcnkgc2ltcGxlKSBwYXRjaCBnaXZlcyB5b3UgdGhlIHNhbWUNCj4gcGVy
Zm9ybWFuY2UgaW1wcm92ZW1lbnQgdGhhdCB0aGUgZ2xpYmMgY29kZSBkb2VzLg0KPiANCj4gTk9U
RSEgSSdtIG5vdCBzYXlpbmcgdGhpcyBwYXRjaCBpcyBwZXJmZWN0LiBUaGlzIG9uZSBkb2Vzbid0
IGV2ZW4NCj4gX3RyeV8gdG8gZG8gdGhlIG11dHVhbCBhbGlnbm1lbnQsIGJlY2F1c2UgaXQncyBy
ZWFsbHkgc2lsbHkuIEJ1dCBJJ20NCj4gdGhyb3dpbmcgdGhpcyBvdXQgaGVyZSBmb3IgZGlzY3Vz
c2lvbiwgYmVjYXVzZQ0KPiANCj4gIC0gaXQncyByZWFsbHkgc2ltcGxlDQo+IA0KPiAgLSBJIHN1
c3BlY3QgaXQgZ2V0cyB5b3UgOTklIG9mIHRoZSB3YXkgdGhlcmUNCj4gDQo+ICAtIHRoZSBjb2Rl
IGdlbmVyYXRpb24gaXMgYWN0dWFsbHkgcXVpdGUgZ29vZCB3aXRoIGJvdGggZ2NjIGFuZCBjbGFu
Zy4NCj4gVGhpcyBpcyBnY2M6DQo+IA0KPiAgICAgICAgIG1lbWNtcDoNCj4gICAgICAgICAgICAg
ICAgIGptcCAgICAgLkw2MA0KPiAgICAgICAgIC5MNTI6DQo+ICAgICAgICAgICAgICAgICBtb3Zx
ICAgICglcnNpKSwgJXJheA0KPiAgICAgICAgICAgICAgICAgY21wcSAgICAlcmF4LCAoJXJkaSkN
Cj4gICAgICAgICAgICAgICAgIGpuZSAgICAgLkw1Mw0KPiAgICAgICAgICAgICAgICAgYWRkcSAg
ICAkOCwgJXJkaQ0KPiAgICAgICAgICAgICAgICAgYWRkcSAgICAkOCwgJXJzaQ0KPiAgICAgICAg
ICAgICAgICAgc3VicSAgICAkOCwgJXJkeA0KPiAgICAgICAgIC5MNjA6DQo+ICAgICAgICAgICAg
ICAgICBjbXBxICAgICQ3LCAlcmR4DQo+ICAgICAgICAgICAgICAgICBqYSAgICAgIC5MNTINCg0K
SSB3b25kZXIgaG93IGZhc3QgdGhhdCBjYW4gYmUgbWFkZSB0byBydW4uDQpJIHRoaW5rIHRoZSB0
d28gY29uZGl0aW9uYWwgYnJhbmNoZXMgaGF2ZSB0byBydW4gaW4gc2VwYXJhdGUgY2xvY2tzLg0K
U28geW91IG1heSBnZXQgYWxsIDUgYXJpdGhtZXRpYyBvcGVyYXRpb25zIHRvIHJ1biBpbiB0aGUg
c2FtZSAyIGNsb2Nrcy4NCkJ1dCB0aGF0IG1heSBiZSBwdXNoaW5nIHRoaW5ncyBvbiBldmVyeXRo
aW5nIGV4Y2VwdCB0aGUgdmVyeSBsYXRlc3QgY3B1Lg0KVGhlIG1lbW9yeSByZWFkcyBhcmVuJ3Qg
bGltaXRpbmcgYXQgYWxsLCB0aGUgY3B1IGNhbiBkbyB0d28gcGVyIGNsb2NrLg0KU28gZXZlbiB0
aG91Z2ggKElJUkMpIG1pc2FsaWduZWQgb25lcyBjb3N0IGFuIGV4dHJhIGNsb2NrIGl0IGRvZXNu
J3QgbWF0dGVyLg0KDQpUaGF0IGxvb2tzIGxpa2UgYSArZHN0KysgPSAqc3JjKysgbG9vcC4NClRo
ZSBhcnJheSBjb3B5IGRzdFtpXSA9IHNyY1tpXTsgaSsrIHJlcXVpcmVzIG9uZSBsZXNzICdhZGRx
Jw0KcHJvdmlkZWQgdGhlIGNwdSBoYXMgJ3JlZ2lzdGVyICsgcmVnaXN0ZXInIGFkZHJlc3Npbmcu
DQpOb3QgZGVjcmVtZW50aW5nIHRoZSBsZW5ndGggYWxzbyBzYXZlcyBhbiAnYWRkcScuDQpTbyB0
aGUgbG9vcDoNCglmb3IgKGkgPSAwOyBpIDwgbGVuZ3RoIC0gNzsgaSArPSA4KQ0KCQlkc3RbaV0g
PSBzcmNbaV07ICAvKiBIYWNrZWQgdG8gYmUgcmlnaHQgaW4gQyAqLw0KcHJvYmFibHkgb25seSBo
YXMgb25lIGFkZHEgYW5kIG9uZSBjbXBxIHBlciBpdGVyYXRpb24uDQpUaGF0IGlzIG11Y2ggbW9y
ZSBsaWtlbHkgdG8gcnVuIGluIHRoZSAyIGNsb2Nrcy4NCihJZiB5b3UgY2FuIHBlcnN1YWRlIGdj
YyBub3QgdG8gdHJhbnNmb3JtIGl0ISkNCg0KSXQgbWF5IGFsc28gYmUgcG9zc2libGUgdG8gcmVt
b3ZlIHRoZSBjbXBxIGJ5IGFycmFuZ2luZw0KdGhhdCB0aGUgZmxhZ3MgZnJvbSB0aGUgYWRkcSBj
b250YWluIHRoZSByaWdodCBjb25kaXRpb24uDQpUaGF0IG5lZWRzIHNvbWV0aGluZyBsaWtlOg0K
CWRzdCArPSBsZW47IHNyYyArPSBsZW47IGxlbiA9IC1sZW4NCglkbw0KCQlkc3RbbGVuXSA9IHNy
Y1tsZW5dOw0KCXdoaWxlICgobGVuICs9IDgpIDwgMCk7DQpUaGF0IHByb2JhYmx5IGlzbid0IG5l
Y2Vzc2FyeSBmb3IgeDg2LCBidXQgaXMgbGlrZWx5IHRvIGhlbHAgc3BhcmMuDQoNCkZvciBtaXBz
LWxpa2UgY3B1ICh3aXRoICdjb21wYXJlIGFuZCBqdW1wJywgb25seSAncmVnICsgY29uc3RhbnQn
DQphZGRyZXNzaW5nKSB5b3UgcmVhbGx5IHdhbnQgYSBsb29wIGxpa2U6DQoJZHN0X2VuZCA9IGRz
dCArIGxlbmd0aDsNCglkbw0KCQkqZHN0KysgPSAqc3JjKys7DQoJd2hpbGUgKGRzdCA8IGRzdF9l
bmQpOw0KVGhpcyBoYXMgdHdvIGFkZHMgYW5kIGEgY29tcGFyZSBwZXIgaXRlcmF0aW9uLg0KVGhh
dCBtaWdodCBiZSBhIGdvb2QgY29tcHJvbWlzZSBmb3IgYWxpZ25lZCBjb3BpZXMuDQoNCkknbSBu
b3QgYXQgYWxsIHN1cmUgaXMgaXQgZXZlciB3b3J0aCBhbGlnbmluZyBlaXRoZXIgcG9pbnRlcg0K
aWYgbWlzYWxpZ25lZCByZWFkcyBkb24ndCBmYXVsdC4NCk1vc3QgY29tcGFyZXMgKG9mIGFueSBz
aXplKSB3aWxsIGJlIGFsaWduZWQuDQpTbyB5b3UgZ2V0IHRoZSAnaGl0JyBvZiB0aGUgdGVzdCB3
aGVuIGl0IGNhbm5vdCBoZWxwLg0KVGhhdCBhbG1vc3QgY2VydGFpbmx5IGV4Y2VlZHMgYW55IGJl
bmVmaXQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

