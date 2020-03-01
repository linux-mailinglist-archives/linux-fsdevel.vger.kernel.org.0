Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD3174F0A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 20:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgCATA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 14:00:29 -0500
Received: from mail-db8eur05olkn2048.outbound.protection.outlook.com ([40.92.89.48]:33565
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbgCATA3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 14:00:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErXz1CLTSWmr6CH979PGqCBv3/t3aCFYptdllyI9RXnRNbrmerN8tcp/9+0EOozTWEXtCl54gB6jelpf/20h08n+koBv4SDne6Bmnl+zugkchC6uEozmc6r4G4C4fp50Zwgnmx0KDRxmpFj28GiagIrzor9n4CoTmk6A/tspiNeDwofk+BPZYyr0HxunBI7INlFFF4r3ps5dx68o7qCfDamWRNfJpZyKnTVcjdYk1ROgvPLDkOOb2gD6VsudXoZOuKDJQEI4E5tGZ1oI1IKSy/y6BXbq7eGLozfdqFiAJ/w9zBYHiHptd4waR0xqSXueHDUzpmppP/q3rh35+7Nk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjfw80vTWBspu2fD+JA2L4tqWCiD737cuqITX91FYEM=;
 b=MkH3wbORxVSwXzV5925ldtn8RTeUz4FMmMhyiyusknwVsRva/bHlaoImQvV8apMzVDMemJMG6vGLpjuzcxkcFRQPwXNkxYjy+qiDj7qZ95pcTH52iNzX7fhMBSKbUR05HT+ImhduoZf9ZhSXfYdyUeLYB/YYcNEv0g81MXpApWSKqH1y6ss3IrSSnPc9t00MLkA/Ht30ZSGQGiJj9EdUJc1MBFU/wiUHfvp8fad1gGcLDsaSZUufOvY2QUTBNAqo/g+qOvkGDRcB9CpWJUnT8T69MrCuKWqkcWGZfQNJ96vJxPI4eVJwkx5lCwlPcAnomBZAtKoICQJL336gZb5lhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM6EUR05FT011.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::33) by
 AM6EUR05HT134.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::466)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Sun, 1 Mar
 2020 19:00:24 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com (10.233.240.56) by
 AM6EUR05FT011.mail.protection.outlook.com (10.233.241.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Sun, 1 Mar 2020 19:00:24 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::1956:d274:cab3:b4dd]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::1956:d274:cab3:b4dd%6]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 19:00:24 +0000
Received: from [192.168.1.101] (92.77.140.102) by FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16 via Frontend Transport; Sun, 1 Mar 2020 19:00:23 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] exec: Fix a deadlock in ptrace
Thread-Topic: [PATCH] exec: Fix a deadlock in ptrace
Thread-Index: AQHV77xesuLGQPzl+kmhVsL8mVFku6g0DNyAgAAI2gCAAAIiAA==
Date:   Sun, 1 Mar 2020 19:00:24 +0000
Message-ID: <AM6PR03MB51702321B8A0E6A8C41ED3D5E4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
References: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAG48ez3QHVpMJ9Rb_Q4LEE6uAqQJeS1Myu82U=fgvUfoeiscgw@mail.gmail.com>
 <20200301185244.zkofjus6xtgkx4s3@wittgenstein>
In-Reply-To: <20200301185244.zkofjus6xtgkx4s3@wittgenstein>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To AM6PR03MB5170.eurprd03.prod.outlook.com (2603:10a6:20b:ca::23)
x-incomingtopheadermarker: OriginalChecksum:F1E2DADFB87F3E5722B26F1C8E16E40BA050D73CA5A67A78C902CDC7F799E52B;UpperCasedChecksum:5AC9037D1E48F3828D566279DEE5DFFDA1CD73C61C825375B7693AE6B2BC632A;SizeAsReceived:8943;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [tkmtNNocAgCyma2NjuY0yBEWMx7iLuzJ]
x-microsoft-original-message-id: <1b9ef9e3-f422-b357-43ef-d4481659f324@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: a69af6b2-e90d-4adb-27b6-08d7be12cc77
x-ms-traffictypediagnostic: AM6EUR05HT134:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TAPiAZlN9MbEuKYs6DCa/3ILLU+RrBD7Bt8oKgLzeMZ/8XRY0Bzc1S4tEv3070nQvfdeezqu8J0dkI9SG93miE/BLy3ee4fXGDK+jdeZBh4bNRKhA7WzmQwGwx4K0lqpI8HnnvglJip/YWLM0/tAM9CnnMEIoIjBuhZuKo8HoeIVpcnT4gP1zTLGS48qhjHjsF62Mj/NK2psJCB8YvE2XPPqzsKc2oUWycKreh4KTms=
x-ms-exchange-antispam-messagedata: kGNfkcV/0ffinKf5m0MMgD5UrdapCGSTIxHVJ0t7JJqeKJWam1KghAfNnxDD3vLUwqensYGDv/nQ63lYL0+eLwhtasl/ZyI+JztnAOZzTjxM1dJjKASDC//8wC5Nwrmp/hdiamYTP1q3OEoV6G+YJA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2F6AD92C6805149B9EE0D14384F6A76@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a69af6b2-e90d-4adb-27b6-08d7be12cc77
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 19:00:24.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8xLzIwIDc6NTIgUE0sIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBPbiBTdW4sIE1h
ciAwMSwgMjAyMCBhdCAwNzoyMTowM1BNICswMTAwLCBKYW5uIEhvcm4gd3JvdGU6DQo+PiBPbiBT
dW4sIE1hciAxLCAyMDIwIGF0IDEyOjI3IFBNIEJlcm5kIEVkbGluZ2VyDQo+PiA8YmVybmQuZWRs
aW5nZXJAaG90bWFpbC5kZT4gd3JvdGU6DQo+Pj4gVGhlIHByb3Bvc2VkIHNvbHV0aW9uIGlzIHRv
IGhhdmUgYSBzZWNvbmQgbXV0ZXggdGhhdCBpcw0KPj4+IHVzZWQgaW4gbW1fYWNjZXNzLCBzbyBp
dCBpcyBhbGxvd2VkIHRvIGNvbnRpbnVlIHdoaWxlIHRoZQ0KPj4+IGR5aW5nIHRocmVhZHMgYXJl
IG5vdCB5ZXQgdGVybWluYXRlZC4NCj4+DQo+PiBKdXN0IGZvciBjb250ZXh0OiBXaGVuIEkgcHJv
cG9zZWQgc29tZXRoaW5nIHNpbWlsYXIgYmFjayBpbiAyMDE2LA0KPj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtZnNkZXZlbC8yMDE2MTEwMjE4MTgwNi5HQjExMTJAcmVkaGF0LmNvbS8N
Cj4+IHdhcyB0aGUgcmVzdWx0aW5nIGRpc2N1c3Npb24gdGhyZWFkLiBBdCBsZWFzdCBiYWNrIHRo
ZW4sIEkgbG9va2VkDQo+PiB0aHJvdWdoIHRoZSB2YXJpb3VzIGV4aXN0aW5nIHVzZXJzIG9mIGNy
ZWRfZ3VhcmRfbXV0ZXgsIGFuZCB0aGUgb25seQ0KPj4gcGxhY2VzIHRoYXQgY291bGRuJ3QgYmUg
Y29udmVydGVkIHRvIHRoZSBuZXcgc2Vjb25kIG11dGV4IHdlcmUNCj4+IFBUUkFDRV9BVFRBQ0gg
YW5kIFNFQ0NPTVBfRklMVEVSX0ZMQUdfVFNZTkMuDQo+Pg0KPj4NCj4+IFRoZSBpZGVhbCBzb2x1
dGlvbiB3b3VsZCBJTU8gYmUgc29tZXRoaW5nIGxpa2UgdGhpczogRGVjaWRlIHdoYXQgdGhlDQo+
PiBuZXcgdGFzaydzIGNyZWRlbnRpYWxzIHNob3VsZCBiZSAqYmVmb3JlKiByZWFjaGluZyBkZV90
aHJlYWQoKSwNCj4+IGluc3RhbGwgdGhlbSBpbnRvIGEgc2Vjb25kIGNyZWQqIG9uIHRoZSB0YXNr
ICh0b2dldGhlciB3aXRoIHRoZSBuZXcNCj4+IGR1bXBhYmlsaXR5KSwgZHJvcCB0aGUgY3JlZF9n
dWFyZF9tdXRleCwgYW5kIGxldCBwdHJhY2VfbWF5X2FjY2VzcygpDQo+PiBjaGVjayBhZ2FpbnN0
IGJvdGguIEFmdGVyIHRoYXQsIHNvbWUgZnVydGhlciByZXN0cnVjdHVyaW5nIG1pZ2h0IGV2ZW4N
Cj4gDQo+IEhtLCBzbyBlc3NlbnRpYWxseSBhIHByaXZhdGUgcHRyYWNlX2FjY2Vzc19jcmVkIG1l
bWJlciBpbiB0YXNrX3N0cnVjdD8NCj4gVGhhdCB3b3VsZCBwcmVzdW1hYmx5IGFsc28gaW52b2x2
ZSBhbHRlcmluZyB2YXJpb3VzIExTTSBob29rcyB0byBsb29rIGF0DQo+IHB0cmFjZV9hY2Nlc3Nf
Y3JlZC4NCj4gDQo+IChNaW5vciBzaWRlLW5vdGUsIGRlX3RocmVhZCgpIHRha2VzIGEgc3RydWN0
IHRhc2tfc3RydWN0IGFyZ3VtZW50IGJ1dA0KPiAgb25seSBldmVyIGlzIHBhc3NlZCBjdXJyZW50
LikNCj4gDQo+PiBhbGxvdyB0aGUgY3JlZF9ndWFyZF9tdXRleCB0byBub3QgYmUgaGVsZCBhY3Jv
c3MgYWxsIG9mIHRoZSBWRlMNCj4+IG9wZXJhdGlvbnMgdGhhdCBoYXBwZW4gZWFybHkgb24gaW4g
ZXhlY3ZlLCB3aGljaCBtYXkgYmxvY2sNCj4+IGluZGVmaW5pdGVseS4gQnV0IHRoYXQgd291bGQg
YmUgcHJldHR5IGNvbXBsaWNhdGVkLCBzbyBJIHRoaW5rIHlvdXINCj4+IHByb3Bvc2VkIHNvbHV0
aW9uIG1ha2VzIHNlbnNlIGZvciBub3csIGdpdmVuIHRoYXQgbm9ib2R5IGhhcyBtYW5hZ2VkDQo+
PiB0byBpbXBsZW1lbnQgYW55dGhpbmcgYmV0dGVyIGluIHRoZSBsYXN0IGZldyB5ZWFycy4NCj4g
DQo+IFJlYWRpbmcgdGhyb3VnaCB0aGUgb2xkIHRocmVhZHMgYW5kIGhvdyBvZnRlbiB0aGlzIGlz
c3VlIGNhbWUgdXAsIEkgdGVuZA0KPiB0byBhZ3JlZS4NCj4gDQoNCk9rYXksIGZpbmUuDQoNCkkg
bWFuYWdlZCB0byBjaGFuZ2UgT2xlZydzIHRlc3QgY2FzZSwgaW50byBvbmUgdGhhdCBzaG93cyB3
aGF0IGV4YWN0bHkNCmlzIGNoYW5nZWQgd2l0aCB0aGlzIHBhdGNoOg0KDQoNCiQgY2F0IHQuYw0K
I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDx1bmlzdGQu
aD4NCiNpbmNsdWRlIDxwdGhyZWFkLmg+DQojaW5jbHVkZSA8c3lzL3NpZ25hbC5oPg0KI2luY2x1
ZGUgPHN5cy9wdHJhY2UuaD4NCg0Kdm9pZCAqdGhyZWFkKHZvaWQgKmFyZykNCnsNCglwdHJhY2Uo
UFRSQUNFX1RSQUNFTUUsIDAsMCwwKTsNCglyZXR1cm4gTlVMTDsNCn0NCg0KaW50IG1haW4odm9p
ZCkNCnsNCglpbnQgZiwgcGlkID0gZm9yaygpOw0KCWNoYXIgbW1bNjRdOw0KDQoJaWYgKCFwaWQp
IHsNCgkJcHRocmVhZF90IHB0Ow0KCQlwdGhyZWFkX2NyZWF0ZSgmcHQsIE5VTEwsIHRocmVhZCwg
TlVMTCk7DQoJCXB0aHJlYWRfam9pbihwdCwgTlVMTCk7DQoJCWV4ZWNscCgiZWNobyIsICJlY2hv
IiwgInBhc3NlZCIsIE5VTEwpOw0KCX0NCg0KCXNsZWVwKDEpOw0KCXNwcmludGYobW0sICIvcHJv
Yy8lZC9tZW0iLCBwaWQpOw0KICAgICAgICBwcmludGYoIm9wZW4oJXMpXG4iLCBtbSk7DQoJZiA9
IG9wZW4obW0sIE9fUkRPTkxZKTsNCiAgICAgICAgcHJpbnRmKCJmID0gJWRcbiIsIGYpOw0KCS8v
IHRoaXMgaXMgbm90IGZpeGVkISBwdHJhY2UoUFRSQUNFX0FUVEFDSCwgcGlkLCAwLDApOw0KCWtp
bGwocGlkLCBTSUdDT05UKTsNCglpZiAoZiA+PSAwKQ0KCQljbG9zZShmKTsNCglyZXR1cm4gMDsN
Cn0NCiQgZ2NjIC1wdGhyZWFkIC1XYWxsIHQuYw0KJCAuL2Eub3V0IA0Kb3BlbigvcHJvYy8yODAy
L21lbSkNCmYgPSAzDQokIHBhc3NlZA0KDQpwcmV2aW91c2x5IHRoaXMgZGlkIGJsb2NrLCBob3cg
Y2FuIEkgbWFrZSBhIHRlc3QgY2FzZSBmb3IgdGhpcz8NCkkgYW0gbm90IHNvIGV4cGVyaWVuY2Vk
IGluIHRoaXMgbWF0dGVyLg0KDQoNClRoYW5rcw0KQmVybmQuDQo=
