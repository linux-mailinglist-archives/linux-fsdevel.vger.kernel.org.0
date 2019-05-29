Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5928C2E5B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfE2UDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 16:03:40 -0400
Received: from mail-eopbgr740114.outbound.protection.outlook.com ([40.107.74.114]:40592
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbfE2UDj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 16:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YjS93J2xlk+IXHNi1JIaxcCmeNcnYGrf/ylZE+6ExM=;
 b=df0cqEjRV2N69EBsFYYjJ0lazMFh7vTSjkKlzRvdIzrxvjYTAuOFvkd86bnOWxMKb2LgBEN4fJfdbsBVqK1tSd2y301WAc9eP9RtsJpUX4sKPrCLb9Ntd1mZhoYQmNagOm8EMWpPyEz5TAutpPX++a08M+X5ktT4qwTDt2xWN8M=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1692.namprd13.prod.outlook.com (10.171.154.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.10; Wed, 29 May 2019 20:02:54 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Wed, 29 May 2019
 20:02:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "lhenriques@suse.com" <lhenriques@suse.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>
Subject: Re: [PATCH v3 12/13] nfs: copy_file_range needs to strip setuid bits
 and update timestamps
Thread-Topic: [PATCH v3 12/13] nfs: copy_file_range needs to strip setuid bits
 and update timestamps
Thread-Index: AQHVFkYYUMuuKw0nwEa91tegO8xUy6aCfqYAgAAHy4A=
Date:   Wed, 29 May 2019 20:02:54 +0000
Message-ID: <c32af433639b451419d36382a05edabfcb742294.camel@hammerspace.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
         <20190529174318.22424-13-amir73il@gmail.com>
         <CAOQ4uxgYM_eM==uqGQuKiGb+f08qs53=E+DONMMzW=N-Ab5YZA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgYM_eM==uqGQuKiGb+f08qs53=E+DONMMzW=N-Ab5YZA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01a10649-b262-46d0-e7ab-08d6e470a332
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1692;
x-ms-traffictypediagnostic: DM5PR13MB1692:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR13MB16924BEB67DD40998208C65BB81F0@DM5PR13MB1692.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(396003)(376002)(366004)(136003)(199004)(189003)(256004)(118296001)(14444005)(66476007)(66556008)(7416002)(64756008)(966005)(6246003)(66946007)(53936002)(3846002)(71190400001)(7736002)(66446008)(73956011)(6116002)(71200400001)(305945005)(2201001)(15650500001)(66066001)(2501003)(478600001)(5660300002)(4326008)(186003)(76116006)(8676002)(316002)(2906002)(486006)(8936002)(76176011)(81156014)(6512007)(68736007)(476003)(6306002)(110136005)(99286004)(6436002)(54906003)(25786009)(6486002)(81166006)(229853002)(36756003)(14454004)(11346002)(86362001)(53546011)(446003)(102836004)(6506007)(2616005)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1692;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O20Iyf00wXneJ1EMSsZM7mJiQec3NghHQ1ILSgFs382Svvh3i6lxeuQzhFMwAnFVkoeYjwpNLCKgfndZccbZsjm5QhksTsHD9SGYmFuJfsotngwhtmuKdOkWtvQ6KK2XlGHAXfqokDachmI2R9fJ0ZMN/R9yOBua97mOJP4lhk/HfFP5Dnu1NoNF7znPoLWTb0bo4pc29E5iZtY3eXNWgMDbdFd0hmknkJjerxfYiZMYwInNo+ND5/KLus5VeoEn+qu4A0wqx1thfG5vxETOoeE8Kay2jzF12GeNQQ0VwOYriaxo9sFL4ki3GQysQDePEvHCV29h1Bcs8uMFAvJfcny59RgXzZrENoXvXONVmGMcyCs47yYY+iRMpyvdV6H/rjeQTnX+puPNzQhvsjoRaRUW8iC2tohc/b0rPm3B3yo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <005480E3B17E7241ABE3D1CD6DA0576F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a10649-b262-46d0-e7ab-08d6e470a332
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 20:02:54.4095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1692
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTI5IGF0IDIyOjM0ICswMzAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gSGkgT2xnYSxBbm5hLFRyb25kDQo+IA0KPiBDb3VsZCB3ZSBnZXQgYW4gQUNLIG9uIHRoaXMg
cGF0Y2guDQo+IEl0IGlzIGEgcHJlcmVxdWlzaXRlIGZvciBtZXJnaW5nIHRoZSBjcm9zcy1kZXZp
Y2UgY29weV9maWxlX3JhbmdlDQo+IHdvcmsuDQo+IA0KPiBJdCBkZXBlbmRzIG9uIGEgbmV3IGhl
bHBlciBpbnRyb2R1Y2VkIGhlcmU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZz
ZGV2ZWwvQ0FPUTR1eGpiY1NXWDFoVWN1WGJuOGhGSDNRWUIrNWJBQzlaMXlDd0pkUj1ULUdHdENn
QG1haWwuZ21haWwuY29tL1QvI20xNTY5ODc4YzQxZjM5ZmFjM2FhZGIzODMyYTMwNjU5YzMyM2I1
ODJhDQo+IA0KPiBUaGFua3MsDQo+IEFtaXIsDQo+IA0KPiBPbiBXZWQsIE1heSAyOSwgMjAxOSBh
dCA4OjQzIFBNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+DQo+IHdyb3RlOg0K
PiA+IExpa2UgLT53cml0ZV9pdGVyKCksIHdlIHVwZGF0ZSBtdGltZSBhbmQgc3RyaXAgc2V0dWlk
IG9mIGRzdCBmaWxlDQo+ID4gYmVmb3JlDQo+ID4gY29weSBhbmQgbGlrZSAtPnJlYWRfaXRlcigp
LCB3ZSB1cGRhdGUgYXRpbWUgb2Ygc3JjIGZpbGUgYWZ0ZXINCj4gPiBjb3B5Lg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+DQo+ID4g
LS0tDQo+ID4gIGZzL25mcy9uZnM0MnByb2MuYyB8IDkgKysrKysrLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2ZzL25mcy9uZnM0MnByb2MuYyBiL2ZzL25mcy9uZnM0MnByb2MuYw0KPiA+IGluZGV4
IDUxOTZiZmE3ODk0ZC4uYzM3YThlNTExNmM2IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9uZnM0
MnByb2MuYw0KPiA+ICsrKyBiL2ZzL25mcy9uZnM0MnByb2MuYw0KPiA+IEBAIC0zNDUsMTAgKzM0
NSwxMyBAQCBzc2l6ZV90IG5mczQyX3Byb2NfY29weShzdHJ1Y3QgZmlsZSAqc3JjLA0KPiA+IGxv
ZmZfdCBwb3Nfc3JjLA0KPiA+IA0KPiA+ICAgICAgICAgZG8gew0KPiA+ICAgICAgICAgICAgICAg
ICBpbm9kZV9sb2NrKGZpbGVfaW5vZGUoZHN0KSk7DQo+ID4gLSAgICAgICAgICAgICAgIGVyciA9
IF9uZnM0Ml9wcm9jX2NvcHkoc3JjLCBzcmNfbG9jaywNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRzdCwgZHN0X2xvY2ssDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmYXJncywgJnJlcyk7DQo+ID4gKyAgICAgICAgICAgICAgIGVyciA9IGZpbGVfbW9k
aWZpZWQoZHN0KTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKCFlcnIpDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZXJyID0gX25mczQyX3Byb2NfY29weShzcmMsIHNyY19sb2NrLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHN0LCBkc3Rf
bG9jaywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZhcmdzLCAmcmVzKTsNCj4gPiAgICAgICAgICAgICAgICAgaW5vZGVfdW5sb2NrKGZpbGVfaW5v
ZGUoZHN0KSk7DQo+ID4gKyAgICAgICAgICAgICAgIGZpbGVfYWNjZXNzZWQoc3JjKTsNCj4gPiAN
Cj4gPiAgICAgICAgICAgICAgICAgaWYgKGVyciA+PSAwKQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4gDQoNClBsZWFzZSBkcm9wIHRo
aXMgcGF0Y2guIEluIHRoZSBORlMgcHJvdG9jb2wsIHRoZSBjbGllbnQgaXMgbm90IGV4cGVjdGVk
DQp0byBtZXNzIHdpdGggYXRpbWUgb3IgbXRpbWUgb3RoZXIgdGhhbiB3aGVuIHRoZSB1c2VyIGV4
cGxpY2l0bHkgc2V0cyBpdA0KdGhyb3VnaCBhIGNhbGwgdG8gdXRpbWVuc2F0KCkgb3Igc2ltaWxh
ci4gVGhlIHNlcnZlciB0YWtlcyBjYXJlIG9mIGFueQ0KYS9tdGltZSB1cGRhdGVzIGFzIGFuZCB3
aGVuIHRoZSBmaWxlIGlzIHJlYWQvd3JpdHRlbiB0by4gDQoNCkRpdHRvIGZvciBzdWlkL3NnaWQg
Y2xlYXJpbmcuDQoNCk1vdHRvOiAiTm8gZmlsZV9hY2Nlc3NlZCgpIG9yIGZpbGVfcmVtb3ZlX3By
aXZzKCkgY2FsbHMsIHBsZWFzZS4gV2UncmUNCk5GUy4iDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0
DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
