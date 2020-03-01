Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCD3174EBD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCARqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 12:46:15 -0500
Received: from mail-oln040092072056.outbound.protection.outlook.com ([40.92.72.56]:53091
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbgCARqP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 12:46:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2LlEFxXC7+/uQJsV6QTxGtFzhLWl+V7Kbbn8puhd4i2CCFqw2SKhF/Fwa1bkArWjFiUkNtL6+sxh9gFXL7w9UyDn/+8dwKC08uT8cwMSAlfmBYfFwhWeixJq1fX4sqMroGo7uMOi3kaisX8F2znvNFXF6244mQOxz5IejOoA7f1whC9MArcyw5IQvyq0AJkJTa+D/U6Q12ynrqNIKtOiYM+DopIJBM020rq8ica+qJAL6bn1i6RD35cLV+I/Y/rEWUSV+z/ehHMd9FoEn+Su85D/zUKYRKS4tjwTTfkUNCRpTLJx1PwzcMtPjOnzlfN9tCViKVBObgXuwKMgdLwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGNmmx5aMp6IebOw2Pt9d2E1+luLUJT+ByOmh8TgMFQ=;
 b=g6fI8glB7wLvRgn5PaB4v2UUS7Lj4WmZCaFUz8TCfSsJ0D9SkJdAgs2IksC40y/+B35s3asHAKjaplP9ydKzwZdFlpT2a9McijF1usVIY7X0edhtnXe2AdOcGVAnt1soEljCTvnirw3PUPD3VtYgLyYAoD545jWHn8VBZHMeZyiHw9UpgTzpm3w6mLSDZSvO7/u3k4vbUuVjqZD1c2mu5dudgu7pvYvOJp/JDxzWc4l7rlCCJviH7oUKuWwjs6whCPw/s+3CGN5OY0KZQmesrivMs1StrFa5Im3c27XbzU4IMW8kSnvps7mg36SO5fsEjCchxNnRjvza6GHzq4xDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e0a::36) by
 DB5EUR03HT133.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e0a::226)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Sun, 1 Mar
 2020 17:46:08 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com (10.152.20.53) by
 DB5EUR03FT010.mail.protection.outlook.com (10.152.20.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Sun, 1 Mar 2020 17:46:08 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::1956:d274:cab3:b4dd]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::1956:d274:cab3:b4dd%6]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 17:46:08 +0000
Received: from [192.168.1.101] (92.77.140.102) by ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Sun, 1 Mar 2020 17:46:07 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] exec: Fix a deadlock in ptrace
Thread-Topic: [PATCH] exec: Fix a deadlock in ptrace
Thread-Index: AQHV77xesuLGQPzl+kmhVsL8mVFku6gz2HmAgAAMjYCAAB4RgA==
Date:   Sun, 1 Mar 2020 17:46:08 +0000
Message-ID: <AM6PR03MB51701494F43B838E49F624C0E4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
References: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <20200301151333.bsjfdjcjddsza2vn@yavin>
 <20200301155829.iiupfihl6z4jkylh@wittgenstein>
In-Reply-To: <20200301155829.iiupfihl6z4jkylh@wittgenstein>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
x-incomingtopheadermarker: OriginalChecksum:85BCFBDD990CEAED14D30BFC34F3A1E55CFD72DD41B9B34B2C654940033A29CA;UpperCasedChecksum:9252B5B0C9147706B2B1E5246DDC0135B0FAD445CA4334AB434B3460B0C9BE76;SizeAsReceived:8923;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Gg2IX9tn/DHxzFZtvF7uQYL1Dp8ithWg]
x-microsoft-original-message-id: <1a32e955-c2b7-e204-9bf4-066c1170a295@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 5156d780-3bf5-4577-20d0-08d7be086c5b
x-ms-traffictypediagnostic: DB5EUR03HT133:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkqX7+hKoTY3SuWeCDLXIB91YOD/0iv6kzyaT0Jd3Pc4G+WMJM3blI/u2fTxe9iyIjFWr0qxXd7hXwXDJ4L7m/woVTRPuxw6W02UibJsdraFrrlBgYhioPZpZ/0X/du4030LIDxR9IcVIS7YAzXLR5f9BdkhP6qCwWTBGBzPyXAiNSticaK2ti0TtbaU6JQPIx0hmi/T7aWAVhE8Z7VyrfNBC07bgAw0vCX1934isKE=
x-ms-exchange-antispam-messagedata: VhNeIjRWQ6DDvf8adJM8SiEVfbDGSkN4hhVW9zqY3igunx2tDYCQ81jQDcdDmCj2UaJtExMGSIEBZWzk/zHKubaAuuhbEs4gWXM4tFAcoYZw4YB3ITzReT1BlgSMuLKIPdECXFWs+nmnGaoKBf1nLg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <00F2F6D788FEA44A88E2A3913787DD1B@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5156d780-3bf5-4577-20d0-08d7be086c5b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 17:46:08.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT133
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8xLzIwIDQ6NTggUE0sIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBPbiBNb24sIE1h
ciAwMiwgMjAyMCBhdCAwMjoxMzozM0FNICsxMTAwLCBBbGVrc2EgU2FyYWkgd3JvdGU6DQo+PiBP
biAyMDIwLTAzLTAxLCBCZXJuZCBFZGxpbmdlciA8YmVybmQuZWRsaW5nZXJAaG90bWFpbC5kZT4g
d3JvdGU6DQo+Pj4gVGhpcyBmaXhlcyBhIGRlYWRsb2NrIGluIHRoZSB0cmFjZXIgd2hlbiB0cmFj
aW5nIGEgbXVsdGktdGhyZWFkZWQNCj4+PiBhcHBsaWNhdGlvbiB0aGF0IGNhbGxzIGV4ZWN2ZSB3
aGlsZSBtb3JlIHRoYW4gb25lIHRocmVhZCBhcmUgcnVubmluZy4NCj4+Pg0KPj4+IEkgb2JzZXJ2
ZWQgdGhhdCB3aGVuIHJ1bm5pbmcgc3RyYWNlIG9uIHRoZSBnY2MgdGVzdCBzdWl0ZSwgaXQgYWx3
YXlzDQo+Pj4gYmxvY2tzIGFmdGVyIGEgd2hpbGUsIHdoZW4gZXhwZWN0IGNhbGxzIGV4ZWN2ZSwg
YmVjYXVzZSBvdGhlciB0aHJlYWRzDQo+Pj4gaGF2ZSB0byBiZSB0ZXJtaW5hdGVkLiAgVGhleSBz
ZW5kIHB0cmFjZSBldmVudHMsIGJ1dCB0aGUgc3RyYWNlIGlzIG5vDQo+Pj4gbG9uZ2VyIGFibGUg
dG8gcmVzcG9uZCwgc2luY2UgaXQgaXMgYmxvY2tlZCBpbiB2bV9hY2Nlc3MuDQo+Pj4NCj4+PiBU
aGUgZGVhZGxvY2sgaXMgYWx3YXlzIGhhcHBlbmluZyB3aGVuIHN0cmFjZSBuZWVkcyB0byBhY2Nl
c3MgdGhlDQo+Pj4gdHJhY2VlcyBwcm9jZXNzIG1tYXAsIHdoaWxlIGFub3RoZXIgdGhyZWFkIGlu
IHRoZSB0cmFjZWUgc3RhcnRzIHRvDQo+Pj4gZXhlY3ZlIGEgY2hpbGQgcHJvY2VzcywgYnV0IHRo
YXQgY2Fubm90IGNvbnRpbnVlIHVudGlsIHRoZQ0KPj4+IFBUUkFDRV9FVkVOVF9FWElUIGlzIGhh
bmRsZWQgYW5kIHRoZSBXSUZFWElURUQgZXZlbnQgaXMgcmVjZWl2ZWQ6DQo+Pj4NCj4+PiBzdHJh
Y2UgICAgICAgICAgRCAgICAwIDMwNjE0ICAzMDU4NCAweDAwMDAwMDAwDQo+Pj4gQ2FsbCBUcmFj
ZToNCj4+PiBfX3NjaGVkdWxlKzB4M2NlLzB4NmUwDQo+Pj4gc2NoZWR1bGUrMHg1Yy8weGQwDQo+
Pj4gc2NoZWR1bGVfcHJlZW1wdF9kaXNhYmxlZCsweDE1LzB4MjANCj4+PiBfX211dGV4X2xvY2su
aXNyYS4xMysweDFlYy8weDUyMA0KPj4+IF9fbXV0ZXhfbG9ja19raWxsYWJsZV9zbG93cGF0aCsw
eDEzLzB4MjANCj4+PiBtdXRleF9sb2NrX2tpbGxhYmxlKzB4MjgvMHgzMA0KPj4+IG1tX2FjY2Vz
cysweDI3LzB4YTANCj4+PiBwcm9jZXNzX3ZtX3J3X2NvcmUuaXNyYS4zKzB4ZmYvMHg1NTANCj4+
PiBwcm9jZXNzX3ZtX3J3KzB4ZGQvMHhmMA0KPj4+IF9feDY0X3N5c19wcm9jZXNzX3ZtX3JlYWR2
KzB4MzEvMHg0MA0KPj4+IGRvX3N5c2NhbGxfNjQrMHg2NC8weDIyMA0KPj4+IGVudHJ5X1NZU0NB
TExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkNCj4+Pg0KPj4+IGV4cGVjdCAgICAgICAgICBE
ICAgIDAgMzE5MzMgIDMwODc2IDB4ODAwMDQwMDMNCj4+PiBDYWxsIFRyYWNlOg0KPj4+IF9fc2No
ZWR1bGUrMHgzY2UvMHg2ZTANCj4+PiBzY2hlZHVsZSsweDVjLzB4ZDANCj4+PiBmbHVzaF9vbGRf
ZXhlYysweGM0LzB4NzcwDQo+Pj4gbG9hZF9lbGZfYmluYXJ5KzB4MzVhLzB4MTZjMA0KPj4+IHNl
YXJjaF9iaW5hcnlfaGFuZGxlcisweDk3LzB4MWQwDQo+Pj4gX19kb19leGVjdmVfZmlsZS5pc3Jh
LjQwKzB4NWQ0LzB4OGEwDQo+Pj4gX194NjRfc3lzX2V4ZWN2ZSsweDQ5LzB4NjANCj4+PiBkb19z
eXNjYWxsXzY0KzB4NjQvMHgyMjANCj4+PiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUr
MHg0NC8weGE5DQo+Pj4NCj4+PiBUaGUgcHJvcG9zZWQgc29sdXRpb24gaXMgdG8gaGF2ZSBhIHNl
Y29uZCBtdXRleCB0aGF0IGlzDQo+Pj4gdXNlZCBpbiBtbV9hY2Nlc3MsIHNvIGl0IGlzIGFsbG93
ZWQgdG8gY29udGludWUgd2hpbGUgdGhlDQo+Pj4gZHlpbmcgdGhyZWFkcyBhcmUgbm90IHlldCB0
ZXJtaW5hdGVkLg0KPj4+DQo+Pj4gSSBhbHNvIHRvb2sgdGhlIG9wcG9ydHVuaXR5IHRvIGltcHJv
dmUgdGhlIGRvY3VtZW50YXRpb24NCj4+PiBvZiBwcmVwYXJlX2NyZWRzLCB3aGljaCBpcyBvYnZp
b3VzbHkgb3V0IG9mIHN5bmMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBCZXJuZCBFZGxpbmdl
ciA8YmVybmQuZWRsaW5nZXJAaG90bWFpbC5kZT4NCj4+DQo+PiBJIGNhbid0IGNvbW1lbnQgb24g
dGhlIHZhbGlkaXR5IG9mIHRoZSBwYXRjaCwgYnV0IEkgYWxzbyBmb3VuZCBhbmQNCj4+IHJlcG9y
dGVkIHRoaXMgaXNzdWUgaW4gMjAxNlsxXSBhbmQgdGhlIGRpc2N1c3Npb24gcXVpY2tseSB2ZWVy
ZWQgaW50bw0KPj4gdGhlIHByb2JsZW0gYmVpbmcgbW9yZSBjb21wbGljYXRlZCAoYW5kIHVnbGll
cikgdGhhbiBpdCBzZWVtcyBhdCBmaXJzdA0KPj4gZ2xhbmNlLg0KPj4NCj4+IFlvdSBzaG91bGQg
cHJvYmFibHkgYWxzbyBDYyBzdGFibGUsIGdpdmVuIHRoaXMgaGFzIGJlZW4gYSBsb25nLXN0YW5k
aW5nDQo+PiBpc3N1ZSBhbmQgeW91ciBwYXRjaCBkb2Vzbid0IGxvb2sgKHRvbykgaW52YXNpdmUu
DQo+Pg0KPj4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTYwOTIxMTUyOTQ2
LkdBMjQyMTBAZGhjcDIyLnN1c2UuY3ovDQo+IA0KPiBZZWFoLCBJIHJlbWVtYmVyIHlvdSBtZW50
aW9uaW5nIHRoaXMgYSB3aGlsZSBiYWNrLg0KPiANCj4gQmVybmQsIHdlIHJlYWxseSB3YW50IGEg
cmVwcm9kdWNlciBmb3IgdGhpcyBzZW50IGFsb25nc2lkZSB3aXRoIHRoaXMNCj4gcGF0Y2ggYWRk
ZWQgdG86DQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3B0cmFjZS8NCj4gSGF2aW5nIGEgdGVz
dCBmb3IgdGhpcyBidWcgaXJyZXNwZWN0aXZlIG9mIHdoZXRoZXIgb3Igbm90IHdlIGdvIHdpdGgN
Cj4gdGhpcyBhcyBmaXggc2VlbXMgcmVhbGx5IHdvcnRoIGl0Lg0KPiANCg0KSSByYW4gaW50byB0
aGlzIGlzc3VlLCBiZWNhdXNlIEkgd2FudGVkIHRvIGZpeCBhbiBpc3N1ZSBpbiB0aGUgZ2NjIHRl
c3RzdWl0ZSwNCm5hbWVseSB3aHkgaXQgZm9yZ2V0cyB0byByZW1vdmUgc29tZSB0ZW1wIGZpbGVz
LA0Kc28gSSBkaWQgdGhlIGZvbGxvd2luZzoNCg0Kc3RyYWNlIC1mdHQgLW8gdHJhY2UudHh0IG1h
a2UgY2hlY2stZ2NjLWMgLWsgLWo0DQoNCkkgcmVwcm9kdWNlZCB3aXRoIHY0LjIwIGFuZCB2NS41
IGtlcm5lbCwgYW5kIEkgZG9uJ3Qga25vdyB3aHkgYnV0IGl0IGlzDQpub3QgaGFwcGVuaW5nIG9u
IGFsbCBzeXN0ZW1zIEkgdGVzdGVkLCBtYXliZSBpdCBpcyBzb21ldGhpbmcgdGhhdCB0aGUgZXhw
ZWN0IHByb2dyYW0NCmRvZXMsIGJlY2F1c2UsIGFsd2F5cyB3aGVuIEkgdHJ5IHRvIHJlcHJvZHVj
ZSB0aGlzLCB0aGUgZGVhZGxvY2sgd2FzIGFsd2F5cyBpbiAiZXhwZWN0Ii4NCg0KSSB1c2UgZXhw
ZWN0IHZlcnNpb24gNS40NSBvbiB0aGUgY29tcHV0ZXIgd2hlcmUgdGhlIGFib3ZlIHRlc3QgZnJl
ZXplcyBhZnRlcg0KYSBjb3VwbGUgb2YgbWludXRlcy4NCg0KSSB0aGluayB0aGUgaXNzdWUgd2l0
aCBzdHJhY2UgaXMgdGhhdCBpdCBpcyB1c2luZyB2bV9hY2Nlc3MgdG8gZ2V0IHRoZSBwYXJhbWV0
ZXJzDQpvZiBhIHN5c2NhbGwgdGhhdCBpcyBnb2luZyBvbiBpbiBvbmUgdGhyZWFkLCBhbmQgdGhh
dCByYWNlcyB3aXRoIGFub3RoZXIgdGhyZWFkDQp0aGF0IGNhbGxzIGV4ZWN2ZSwgYW5kIGJsb2Nr
cyB0aGUgY3JlZF9ndWFyZF9tdXRleC4NCg0KV2hpbGUgT2xnJ3MgdGVzdCBjYXNlIGhlcmUsIHdp
bGwgY2VydGFpbmx5IG5vdCBiZSBmaXhlZDoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDE2MDkyMzA5NTAzMS5HQTE0OTIzQHJlZGhhdC5jb20vDQoNCmhlIG1lbnRpb25zIHRoZSBh
Y2Nlc3MgdG8gImFueXRoaW5nIGVsc2Ugd2hpY2ggbmVlZHMgLT5jcmVkX2d1YXJkX211dGV4LA0K
c2F5IG9wZW4oL3Byb2MvJHBpZC9tZW0pIiwgSSBkb24ndCBrbm93IGZvciBzdXJlIGhvdyB0aGF0
IGNhbiBiZSBkb25lLCBidXQgaWYNCnRoYXQgaXMgcG9zc2libGUsIGl0IHdvdWxkIHByb2JhYmx5
IHdvcmsgYXMgYSB0ZXN0IGNhc2UuDQoNCldoYXQgZG8geW91IHRoaW5rPw0KDQoNCkJlcm5kLg0K
DQoNCj4gT2xlZyBzZWVtcyB0byBoYXZlIHN1Z2dlc3RlZCB0aGF0IGEgcG90ZW50aWFsIGFsdGVy
bmF0aXZlIGZpeCBpcyB0byB3YWl0DQo+IGluIGRlX3RocmVhZCgpIHVudGlsIGFsbCBvdGhlciB0
aHJlYWRzIGluIHRoZSB0aHJlYWQtZ3JvdXAgaGF2ZSBwYXNzZWQNCj4gZXhpdF9ub3RpeSgpLiBS
aWdodCBub3cgd2Ugb25seSBraWxsIHRoZW0gYnV0IGRvbid0IHdhaXQuIEN1cnJlbnRseQ0KPiBk
ZV90aHJlYWQoKSBvbmx5IHdhaXRzIGZvciB0aGUgdGhyZWFkLWdyb3VwIGxlYWRlciB0byBwYXNz
IGV4aXRfbm90aWZ5KCkNCj4gd2hlbmV2ZXIgYSBub24tdGhyZWFkLWdyb3VwIGxlYWRlciB0aHJl
YWQgZXhlY3MgKGJlY2F1c2UgdGhlIGV4ZWMnaW5nDQo+IHRocmVhZCBiZWNvbWVzIHRoZSBuZXcg
dGhyZWFkLWdyb3VwIGxlYWRlciB3aXRoIHRoZSBzYW1lIHBpZCBhcyB0aGUNCj4gZm9ybWVyIHRo
cmVhZC1ncm91cCBsZWFkZXIpLg0KPiANCj4gQ2hyaXN0aWFuDQo+IA0K
