Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E661766E2D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 16:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjAQPxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 10:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjAQPw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:52:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE91F222E7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 07:52:11 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-268-eD-OPVowPHOo76euoQg45A-1; Tue, 17 Jan 2023 15:52:09 +0000
X-MC-Unique: eD-OPVowPHOo76euoQg45A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Jan
 2023 15:52:08 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Tue, 17 Jan 2023 15:52:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Amy Parker' <apark0006@student.cerritos.edu>,
        "willy@infradead.org" <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dax: use switch statement over chained ifs
Thread-Topic: [PATCH] dax: use switch statement over chained ifs
Thread-Index: AQHZKhj2H8rtmpwLA0eRPGwdtTlpaa6iwgdQ
Date:   Tue, 17 Jan 2023 15:52:08 +0000
Message-ID: <11f5a5ab96e143689c07531c9e5e704a@AcuMS.aculab.com>
References: <CAPOgqxF_xEgKspetRJ=wq1_qSG3h8mkyXC58TXkUvx0agzEm_A@mail.gmail.com>
In-Reply-To: <CAPOgqxF_xEgKspetRJ=wq1_qSG3h8mkyXC58TXkUvx0agzEm_A@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogQW15IFBhcmtlcg0KPiBTZW50OiAxNyBKYW51YXJ5IDIwMjMgMDI6MTENCj4gDQo+IFRo
aXMgcGF0Y2ggdXNlcyBhIHN3aXRjaCBzdGF0ZW1lbnQgZm9yIHBlX29yZGVyLCB3aGljaCBpbXBy
b3Zlcw0KPiByZWFkYWJpbGl0eSBhbmQgb24gc29tZSBwbGF0Zm9ybXMgbWF5IG1pbm9ybHkgaW1w
cm92ZSBwZXJmb3JtYW5jZS4gSXQNCj4gYWxzbywgdG8gaW1wcm92ZSByZWFkYWJpbGl0eSwgcmVj
b2duaXplcyB0aGF0IGBQQUdFX1NISUZUIC0gUEFHRV9TSElGVCcgaXMNCj4gYSBjb25zdGFudCwg
YW5kIHVzZXMgMCBpbiBpdHMgcGxhY2UgaW5zdGVhZC4NCg0KVGhlIGNvbXBpbGVyIGlzIHByZXR0
eSBtdWNoIGd1YXJhbnRlZWQgdG8gZG8gdGhhdCBhbnl3YXkuDQpUaGUgJ2NoYWluZWQgaWZzJyBj
YW4gZ2VuZXJhdGUgYmV0dGVyIGNvZGUgYmVjYXVzZSB0aGUNCmNvbW1vbiBjYXNlIGNhbiBiZSBw
dXQgZmlyc3QuDQpUaGUgY29tcGlsZXIgd2lsbCBiYXNlIGl0cyAnY2hhaW5lZCBpZnMnIChqdW1w
IHRhYmxlcw0KY2FuJ3QgYmUgdXNlZCBkdWUgdG8gY3B1ICdmZWF0dXJlcycgLSBhbmQgd291bGQg
YmUgc2xvd2VyDQphbnl3YXkgd2l0aCBvbmx5IGEgZmV3IGxhYmVscykgb24gbWluaW1pc2luZyB0
aGUgbnVtYmVyDQpvZiBjb25kaXRpb25hbHMuDQoNCihOZXZlciBtaW5kIGFueSBvZiB0aGUgb3Ro
ZXIgcHJvYmxlbXMuKQ0KDQoJRGF2aWQNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW15IFBhcmtl
ciA8YXBhcmswMDA2QHN0dWRlbnQuY2Vycml0b3MuZWR1Pg0KPiAtLS0NCj4gIGZzL2RheC5jIHwg
MTMgKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9kYXguYyBiL2ZzL2RheC5jDQo+IGlu
ZGV4IGM0OGEzYTkzYWIyOS4uZThiZWVkNjAxMzg0IDEwMDY0NA0KPiAtLS0gYS9mcy9kYXguYw0K
PiArKysgYi9mcy9kYXguYw0KPiBAQCAtMzIsMTMgKzMyLDE2IEBADQo+IA0KPiAgc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBpbnQgcGVfb3JkZXIoZW51bSBwYWdlX2VudHJ5X3NpemUgcGVfc2l6ZSkN
Cj4gIHsNCj4gLSAgICBpZiAocGVfc2l6ZSA9PSBQRV9TSVpFX1BURSkNCj4gLSAgICAgICAgcmV0
dXJuIFBBR0VfU0hJRlQgLSBQQUdFX1NISUZUOw0KPiAtICAgIGlmIChwZV9zaXplID09IFBFX1NJ
WkVfUE1EKQ0KPiArICAgIHN3aXRjaCAocGVfc2l6ZSkgew0KPiArICAgIGNhc2UgUEVfU0laRV9Q
VEU6DQo+ICsgICAgICAgIHJldHVybiAwOw0KPiArICAgIGNhc2UgUEVfU0laRV9QTUQ6DQo+ICAg
ICAgICAgIHJldHVybiBQTURfU0hJRlQgLSBQQUdFX1NISUZUOw0KPiAtICAgIGlmIChwZV9zaXpl
ID09IFBFX1NJWkVfUFVEKQ0KPiArICAgIGNhc2UgUEVfU0laRV9QVUQ6DQo+ICAgICAgICAgIHJl
dHVybiBQVURfU0hJRlQgLSBQQUdFX1NISUZUOw0KPiAtICAgIHJldHVybiB+MDsNCj4gKyAgICBk
ZWZhdWx0Og0KPiArICAgICAgICByZXR1cm4gfjA7DQo+ICsgICAgfQ0KPiAgfQ0KPiANCj4gIC8q
IFdlIGNob29zZSA0MDk2IGVudHJpZXMgLSBzYW1lIGFzIHBlci16b25lIHBhZ2Ugd2FpdCB0YWJs
ZXMgKi8NCj4gLS0NCj4gMi4zOS4wDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

