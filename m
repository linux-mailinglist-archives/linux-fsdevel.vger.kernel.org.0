Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD52FB75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 14:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfE3MQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 08:16:17 -0400
Received: from mail-eopbgr740095.outbound.protection.outlook.com ([40.107.74.95]:46816
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbfE3MQR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 08:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAIPxzD2Gy1HkrooD0HNAk2U2BacnneHaupnFe+W8O8=;
 b=R3Iook4xxa4vq5xkKkKniDqaNCqJb95r7gUyVN0oGoHuQBgy4F02D9BQDTGria6K0oB+oYuB41CIAIGP7qGGndD5nCQUDwAPv9GHkM+qR/6fX1LZhxwnXzpXvJoXmL443SD+yMVO3+Zy7VxLExfcjp4JqCa9JT0Op3jdt4M/BY8=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1211.namprd13.prod.outlook.com (10.168.240.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.13; Thu, 30 May 2019 12:16:11 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Thu, 30 May 2019
 12:16:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>
CC:     "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "hch@lst.de" <hch@lst.de>, "dsterba@suse.com" <dsterba@suse.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 03/10] rpc_pipefs: call fsnotify_{unlink,rmdir}() hooks
Thread-Topic: [PATCH v3 03/10] rpc_pipefs: call fsnotify_{unlink,rmdir}()
 hooks
Thread-Index: AQHVE9AgcVusMsIkgEG8FyYXqZdj9qaDLaeAgABtpAA=
Date:   Thu, 30 May 2019 12:16:11 +0000
Message-ID: <a097e2b0c641a868e9023297500cbceef14023ad.camel@hammerspace.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
         <20190526143411.11244-4-amir73il@gmail.com>
         <CAOQ4uxh4q_ArSROkdUxFW9oezEYc4qqJNFS8oOULsVhx6-1Lig@mail.gmail.com>
In-Reply-To: <CAOQ4uxh4q_ArSROkdUxFW9oezEYc4qqJNFS8oOULsVhx6-1Lig@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96053ad7-34ab-4cf5-8a6f-08d6e4f89aac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1211;
x-ms-traffictypediagnostic: DM5PR13MB1211:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR13MB121135C9FFE491F36725B43FB8180@DM5PR13MB1211.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(136003)(346002)(376002)(396003)(199004)(189003)(5660300002)(2201001)(118296001)(305945005)(71190400001)(64756008)(99286004)(256004)(66446008)(66556008)(8936002)(110136005)(229853002)(14444005)(6246003)(68736007)(2906002)(71200400001)(7736002)(7416002)(81166006)(54906003)(81156014)(86362001)(8676002)(6486002)(486006)(3846002)(478600001)(66946007)(2616005)(2501003)(66066001)(446003)(53936002)(186003)(6436002)(76116006)(6116002)(66476007)(53546011)(73956011)(6506007)(476003)(14454004)(316002)(6512007)(76176011)(36756003)(26005)(966005)(102836004)(6306002)(25786009)(4326008)(11346002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1211;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oqgNfj6/SdcokQgDBkaKdYECLm3l9I9W7ok5JoH9cd6jXSlCCi3RK8EGjIVRr+bUAta5OcVveSfDghQSbNx8zUzxAUGvWZrexYd0SqboXd9DroTRCLP3lXEf5Ad0w3Zbybt+oD8C35ynRpite761r+4zeEYEK13UybOWtMjZNT6WvEbDrvQheBuF1B6aPxf0OSsUNZEOtQEvAmqFd21Cjtfa9Z+z7L9jTzQ5HLn7vOweIt3JwfqVhqacar5a/hYwzMXdyciFdO4KSokIPf92V45vzjGOkh9VG68ROJFBoHR3wKOxyz3A9HgwtbP1eeaJCLrVLhOZapu50repgk289vlVk14P5a8a1BpX3tQb5JBgelDDRQTsKDyxDBTTaCWR4RWuep4jbkj23hKBFeNptEaUwoYioURIDusZKDKpRRA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01F50D7CF3B8FB43A38775891161E8F1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96053ad7-34ab-4cf5-8a6f-08d6e4f89aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 12:16:11.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1211
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTMwIGF0IDA4OjQzICswMzAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gSGkgVHJvbmQsQW5uYSxCcnVjZSwNCj4gDQo+IFNlZW1zIHRoYXQgcnBjX3BpcGVmcyBpcyBj
by1tYWludGFpbmVkIGJ5IGNsaWVudCBhbmQgc2VydmVyIHRyZWVzLCBzbw0KPiBub3Qgc3VyZSB3
aG8gaXMgdGhlIGJlc3QgdG8gYXNrIGZvciBhbiBhY2suDQo+IFdlIG5lZWQgdG8gYWRkIHRob3Nl
IGV4cGxpY2l0IGZzbm90aWZ5IGhvb2tzIHRvIG1hdGNoIHRoZSBleGlzdGluZw0KPiBmc25vdGlm
eV9jcmVhdGUvbWtkaXIgaG9va3MsIGJlY2F1c2UNCj4gdGhlIGhvb2sgZW1iZWRkZWQgaW5zaWRl
IGRfZGVsZXRlKCkgaXMgZ29pbmcgYXdheSBbMV0uDQo+IA0KPiBUaGFua3MsDQo+IEFtaXIuDQo+
IA0KPiBbMV0gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZzZGV2ZWwvMjAxOTA1
MjYxNDM0MTEuMTEyNDQtMS1hbWlyNzNpbEBnbWFpbC5jb20vDQo+IA0KPiBPbiBTdW4sIE1heSAy
NiwgMjAxOSBhdCA1OjM0IFBNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+DQo+
IHdyb3RlOg0KPiA+IFRoaXMgd2lsbCBhbGxvdyBnZW5lcmF0aW5nIGZzbm90aWZ5IGRlbGV0ZSBl
dmVudHMgYWZ0ZXIgdGhlDQo+ID4gZnNub3RpZnlfbmFtZXJlbW92ZSgpIGhvb2sgaXMgcmVtb3Zl
ZCBmcm9tIGRfZGVsZXRlKCkuDQo+ID4gDQo+ID4gQ2M6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiBDYzogQW5uYSBTY2h1bWFrZXIgPGFubmEu
c2NodW1ha2VyQG5ldGFwcC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4g
PGFtaXI3M2lsQGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4gPiAgbmV0L3N1bnJwYy9ycGNfcGlwZS5j
IHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9ycGNfcGlwZS5jIGIvbmV0L3N1bnJwYy9ycGNfcGlw
ZS5jDQo+ID4gaW5kZXggOTc5ZDIzNjQ2ZTMzLi45MTdjODVmMTVhMGIgMTAwNjQ0DQo+ID4gLS0t
IGEvbmV0L3N1bnJwYy9ycGNfcGlwZS5jDQo+ID4gKysrIGIvbmV0L3N1bnJwYy9ycGNfcGlwZS5j
DQo+ID4gQEAgLTU5Nyw2ICs1OTcsOCBAQCBzdGF0aWMgaW50IF9fcnBjX3JtZGlyKHN0cnVjdCBp
bm9kZSAqZGlyLA0KPiA+IHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4gPiANCj4gPiAgICAgICAg
IGRnZXQoZGVudHJ5KTsNCj4gPiAgICAgICAgIHJldCA9IHNpbXBsZV9ybWRpcihkaXIsIGRlbnRy
eSk7DQo+ID4gKyAgICAgICBpZiAoIXJldCkNCj4gPiArICAgICAgICAgICAgICAgZnNub3RpZnlf
cm1kaXIoZGlyLCBkZW50cnkpOw0KPiA+ICAgICAgICAgZF9kZWxldGUoZGVudHJ5KTsNCj4gPiAg
ICAgICAgIGRwdXQoZGVudHJ5KTsNCj4gPiAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gQEAgLTYw
OCw2ICs2MTAsOCBAQCBzdGF0aWMgaW50IF9fcnBjX3VubGluayhzdHJ1Y3QgaW5vZGUgKmRpciwN
Cj4gPiBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+ID4gDQo+ID4gICAgICAgICBkZ2V0KGRlbnRy
eSk7DQo+ID4gICAgICAgICByZXQgPSBzaW1wbGVfdW5saW5rKGRpciwgZGVudHJ5KTsNCj4gPiAr
ICAgICAgIGlmICghcmV0KQ0KPiA+ICsgICAgICAgICAgICAgICBmc25vdGlmeV91bmxpbmsoZGly
LCBkZW50cnkpOw0KPiA+ICAgICAgICAgZF9kZWxldGUoZGVudHJ5KTsNCj4gPiAgICAgICAgIGRw
dXQoZGVudHJ5KTsNCj4gPiAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gLS0NCj4gPiAyLjE3LjEN
Cj4gPiANCg0KVGhpcyBsb29rcyBqdXN0IGZpbmUgdG8gbWUuDQoNCkFja2VkLWJ5OiBUcm9uZCBN
eWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQoNCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
