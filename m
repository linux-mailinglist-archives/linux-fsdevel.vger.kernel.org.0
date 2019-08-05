Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF38219E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfHEQZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:25:24 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:47289 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727928AbfHEQZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:25:24 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP;
 Mon,  5 Aug 2019 16:25:17 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 5 Aug 2019 16:08:41 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 5 Aug 2019 16:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mmd4B8kM672+m2UNRoPrQzZJwU2X3BXA9o9eQ8lsakjsTIdRxBJ0fEe4IMb6ePrDuFrfymDKG2zVL2E+SHg5nyyyx7VNdykh5QDqO/9mmvTDPHZ3wyljCtQ8QLsxVS2s0fx5LEIc809eJFvSWK45y0hObclmqIutjxP5OOn40Wpef5q3ulabw8kZIBt9uEtmzZOlYeylqKWuCShjRHH8Y5SZvyaHlRQTPcRJwT7NRrqPmxoW+oJiiPGj0FyaYyAlAPhoFMnoQotKMM5PDIrha/aMwWIn8oXy9F23rQo1axiKEK6kHipUMPPppINQuEGsMx5zQWmCYWIAFE0iiLEWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnFF8N/FszDADhsuGsuaAaW/WKF6EGjbBfiOnrGKuwQ=;
 b=nwiOTUsHjD+fEh78S5rEOXWXiAgXD+srL8z8VVSgGdIw4CmBs6Izw8TjonVcVXz/XxHYmU7Qdm5Kdr9hFWHafB3mnyphG/K0spuTHI2Wcrg1WfgI81jnDAQ+crtolcPqOe7fxI9WXEydx/Kqcw+sS07byNm77+OYuz0t8jnF7RUcGC6lAxV8XHEB914o6N7T8iKE5glG1R1JX+szovyxNkVKcbJlPizU7bRm4NWHvUGDymgxSBm3HGv5Kx1ZfvGsJlurv3aOocOENQ1zoYLDfEI2ViloybUcULd+hnAZrlQyLwVdali0Nd40bAs7kzwGPvFsamcvM9rOus3ueCbivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from CY4PR1801MB2071.namprd18.prod.outlook.com (10.171.254.163) by
 CY4PR1801MB1992.namprd18.prod.outlook.com (10.171.255.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 16:08:40 +0000
Received: from CY4PR1801MB2071.namprd18.prod.outlook.com
 ([fe80::257a:b502:eda4:e0d5]) by CY4PR1801MB2071.namprd18.prod.outlook.com
 ([fe80::257a:b502:eda4:e0d5%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 16:08:40 +0000
From:   Goldwyn Rodrigues <RGoldwyn@suse.com>
To:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Thread-Topic: [PATCH 10/13] iomap: use a function pointer for dio submits
Thread-Index: AQHVSX3ToXfGcf37hUGaWWpa6tpJG6bokA6kgAQtDIA=
Date:   Mon, 5 Aug 2019 16:08:40 +0000
Message-ID: <1565021319.13240.13.camel@suse.com>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
         <20190802220048.16142-11-rgoldwyn@suse.de> <20190803002140.GA7129@magnolia>
In-Reply-To: <20190803002140.GA7129@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RGoldwyn@suse.com; 
x-originating-ip: [75.66.23.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9af6914-1985-4233-d2ea-08d719bf2e67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR1801MB1992;
x-ms-traffictypediagnostic: CY4PR1801MB1992:
x-microsoft-antispam-prvs: <CY4PR1801MB19921CBE509CB4E4946FB254B7DA0@CY4PR1801MB1992.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(6506007)(71190400001)(91956017)(4326008)(229853002)(2906002)(6512007)(76176011)(6486002)(54906003)(305945005)(6436002)(76116006)(80792005)(53936002)(66946007)(66446008)(64756008)(66556008)(66476007)(5640700003)(7736002)(316002)(5660300002)(3846002)(66066001)(26005)(186003)(486006)(102836004)(11346002)(2616005)(476003)(71200400001)(103116003)(256004)(446003)(2501003)(6116002)(86362001)(68736007)(36756003)(81166006)(6916009)(81156014)(478600001)(2351001)(14454004)(6246003)(8936002)(25786009)(8676002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1801MB1992;H:CY4PR1801MB2071.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SEes4iroiE2gFjJDBnPJ0xtRjruEYECD75gH04E91C8XZPesTnW5/9VgLd10WFrMJVLKk19+f0ATt3mKBANWUOJiAK/qGExJpIcZR0YvSqaip9IwIGR+apX7UjuTQ6ZR5iS9oKYtAPUhsGP0mSTAEM5Y7Jtm2PqyIW+Ke8sVuAhZyRgkhUJ89dwjUmsQTTdvBsHi6P6JK7G969rsrgGAx1cRDHLUZ0GmS+4qExLH7kSRipkISu0nrI+NZfb3OLjyc/bgixvMdKPPGW1W+XgRJHGO4rSRuusDuNy76xB1XDMDEoSjmDsx6R1Iw/wH5TXH2JtrYTrRSXA9l+XTEwPkDcAOx5hcZ+wxVASK9U5lHYtxVVuedTdiAwkkaF9+CSYQMNDy2owG3/Xz/2sziwgrkrGgbU/KPmtsRo/lu7dmQcY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AF5F7F3A1E0EF40BDC5079D1E964F43@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9af6914-1985-4233-d2ea-08d719bf2e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 16:08:40.3099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGoldwyn@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB1992
X-OriginatorOrg: suse.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTAyIGF0IDE3OjIxIC0wNzAwLCAgRGFycmljayBKLiBXb25nICB3cm90
ZToNCj4gT24gRnJpLCBBdWcgMDIsIDIwMTkgYXQgMDU6MDA6NDVQTSAtMDUwMCwgR29sZHd5biBS
b2RyaWd1ZXMgd3JvdGU6DQo+ID4gRnJvbTogR29sZHd5biBSb2RyaWd1ZXMgPHJnb2xkd3luQHN1
c2UuY29tPg0KPiA+IA0KPiA+IFRoaXMgaGVscHMgZmlsZXN5c3RlbXMgdG8gcGVyZm9ybSB0YXNr
cyBvbiB0aGUgYmlvIHdoaWxlDQo+ID4gc3VibWl0dGluZyBmb3IgSS9PLiBTaW5jZSBidHJmcyBy
ZXF1aXJlcyB0aGUgcG9zaXRpb24NCj4gPiB3ZSBhcmUgd29ya2luZyBvbiwgcGFzcyBwb3MgdG8g
aW9tYXBfZGlvX3N1Ym1pdF9iaW8oKQ0KPiANCj4gV2hhdCAvZG9lcy8gYnRyZnNfc3VibWl0X2Rp
cmVjdCBkbywgYW55d2F5PyAgTG9va3MgbGlrZSBpdCdzIGEgY3VzdG9tDQo+IHN1Ym1pc3Npb24g
ZnVuY3Rpb24gdGhhdCAuLi4gZG9lcyBzb21ldGhpbmcgcmVsYXRlZCB0byBzZXR0aW5nDQo+IGNo
ZWNrc3Vtcz8gIEFuZCwgdWgsIFJBSUQ/DQoNClllcyBhbmQgeWVzLg0KDQo+IA0KPiA+IFRoZSBj
b3JyZWN0IHBsYWNlIGZvciBzdWJtaXRfaW8oKSBpcyBub3QgcGFnZV9vcHMuIFdvdWxkIGl0DQo+
ID4gYmV0dGVyIHRvIHJlbmFtZSB0aGUgc3RydWN0dXJlIHRvIHNvbWV0aGluZyBsaWtlIGlvbWFw
X2lvX29wcw0KPiA+IG9yIHB1dCBpdCBkaXJlY3RseSB1bmRlciBzdHJ1Y3QgaW9tYXA/DQo+IA0K
PiBTZWVpbmcgYXMgdGhlIC0+aW9tYXBfYmVnaW4gaGFuZGxlciBrbm93cyBpZiB0aGUgcmVxdWVz
dGVkIG9wIGlzIGENCj4gYnVmZmVyZWQgd3JpdGUgb3IgYSBkaXJlY3Qgd3JpdGUsIHdoYXQgaWYg
d2UganVzdCBkZWNsYXJlIGEgdW5pb24gb2YNCj4gb3BzPw0KPiANCj4gZS5nLg0KPiANCj4gc3Ry
dWN0IGlvbWFwX3BhZ2Vfb3BzOw0KPiBzdHJ1Y3QgaW9tYXBfZGlyZWN0aW9fb3BzOw0KPiANCj4g
c3RydWN0IGlvbWFwIHsNCj4gCTx1c3VhbCBzdHVmZj4NCj4gCXVuaW9uIHsNCj4gCQljb25zdCBz
dHJ1Y3QgaW9tYXBfcGFnZV9vcHMgKnBhZ2Vfb3BzOw0KPiAJCWNvbnN0IHN0cnVjdCBpb21hcF9k
aXJlY3Rpb19vcHMgKmRpcmVjdGlvX29wczsNCj4gCX07DQo+IH07DQoNClllcywgdGhhdCBsb29r
cyBnb29kLiBUaGFua3MuIEkgd2lsbCBpbmNvcnBvcmF0ZSBpdC4NCg0KPiANCj4gLS1EDQo+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEdvbGR3eW4gUm9kcmlndWVzIDxyZ29sZHd5bkBzdXNlLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZnMvaW9tYXAvZGlyZWN0LWlvLmMgIHwgMTYgKysrKysrKysrKystLS0t
LQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2lvbWFwLmggfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZnMvaW9tYXAvZGlyZWN0LWlvLmMgYi9mcy9pb21hcC9kaXJlY3QtaW8uYw0KPiA+IGluZGV4
IDUyNzkwMjljN2EzYy4uYTgwMmU2NmJmMTFmIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2lvbWFwL2Rp
cmVjdC1pby5jDQo+ID4gKysrIGIvZnMvaW9tYXAvZGlyZWN0LWlvLmMNCj4gPiBAQCAtNTksNyAr
NTksNyBAQCBpbnQgaW9tYXBfZGlvX2lvcG9sbChzdHJ1Y3Qga2lvY2IgKmtpb2NiLCBib29sDQo+
ID4gc3BpbikNCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoaW9tYXBfZGlvX2lvcG9sbCk7DQo+ID4g
IA0KPiA+ICBzdGF0aWMgdm9pZCBpb21hcF9kaW9fc3VibWl0X2JpbyhzdHJ1Y3QgaW9tYXBfZGlv
ICpkaW8sIHN0cnVjdA0KPiA+IGlvbWFwICppb21hcCwNCj4gPiAtCQlzdHJ1Y3QgYmlvICpiaW8p
DQo+ID4gKwkJc3RydWN0IGJpbyAqYmlvLCBsb2ZmX3QgcG9zKQ0KPiA+ICB7DQo+ID4gIAlhdG9t
aWNfaW5jKCZkaW8tPnJlZik7DQo+ID4gIA0KPiA+IEBAIC02Nyw3ICs2NywxMyBAQCBzdGF0aWMg
dm9pZCBpb21hcF9kaW9fc3VibWl0X2JpbyhzdHJ1Y3QNCj4gPiBpb21hcF9kaW8gKmRpbywgc3Ry
dWN0IGlvbWFwICppb21hcCwNCj4gPiAgCQliaW9fc2V0X3BvbGxlZChiaW8sIGRpby0+aW9jYik7
DQo+ID4gIA0KPiA+ICAJZGlvLT5zdWJtaXQubGFzdF9xdWV1ZSA9IGJkZXZfZ2V0X3F1ZXVlKGlv
bWFwLT5iZGV2KTsNCj4gPiAtCWRpby0+c3VibWl0LmNvb2tpZSA9IHN1Ym1pdF9iaW8oYmlvKTsN
Cj4gPiArCWlmIChpb21hcC0+cGFnZV9vcHMgJiYgaW9tYXAtPnBhZ2Vfb3BzLT5zdWJtaXRfaW8p
IHsNCj4gPiArCQlpb21hcC0+cGFnZV9vcHMtPnN1Ym1pdF9pbyhiaW8sIGZpbGVfaW5vZGUoZGlv
LQ0KPiA+ID5pb2NiLT5raV9maWxwKSwNCj4gPiArCQkJCXBvcyk7DQo+ID4gKwkJZGlvLT5zdWJt
aXQuY29va2llID0gQkxLX1FDX1RfTk9ORTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJZGlvLT5z
dWJtaXQuY29va2llID0gc3VibWl0X2JpbyhiaW8pOw0KPiA+ICsJfQ0KPiA+ICB9DQo+ID4gIA0K
PiA+ICBzdGF0aWMgc3NpemVfdCBpb21hcF9kaW9fY29tcGxldGUoc3RydWN0IGlvbWFwX2RpbyAq
ZGlvKQ0KPiA+IEBAIC0xOTUsNyArMjAxLDcgQEAgaW9tYXBfZGlvX3plcm8oc3RydWN0IGlvbWFw
X2RpbyAqZGlvLCBzdHJ1Y3QNCj4gPiBpb21hcCAqaW9tYXAsIGxvZmZfdCBwb3MsDQo+ID4gIAln
ZXRfcGFnZShwYWdlKTsNCj4gPiAgCV9fYmlvX2FkZF9wYWdlKGJpbywgcGFnZSwgbGVuLCAwKTsN
Cj4gPiAgCWJpb19zZXRfb3BfYXR0cnMoYmlvLCBSRVFfT1BfV1JJVEUsIGZsYWdzKTsNCj4gPiAt
CWlvbWFwX2Rpb19zdWJtaXRfYmlvKGRpbywgaW9tYXAsIGJpbyk7DQo+ID4gKwlpb21hcF9kaW9f
c3VibWl0X2JpbyhkaW8sIGlvbWFwLCBiaW8sIHBvcyk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0
YXRpYyBsb2ZmX3QNCj4gPiBAQCAtMzAxLDExICszMDcsMTEgQEAgaW9tYXBfZGlvX2Jpb19hY3Rv
cihzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiA+IGxvZmZfdCBwb3MsIGxvZmZfdCBsZW5ndGgsDQo+
ID4gIAkJaW92X2l0ZXJfYWR2YW5jZShkaW8tPnN1Ym1pdC5pdGVyLCBuKTsNCj4gPiAgDQo+ID4g
IAkJZGlvLT5zaXplICs9IG47DQo+ID4gLQkJcG9zICs9IG47DQo+ID4gIAkJY29waWVkICs9IG47
DQo+ID4gIA0KPiA+ICAJCW5yX3BhZ2VzID0gaW92X2l0ZXJfbnBhZ2VzKCZpdGVyLCBCSU9fTUFY
X1BBR0VTKTsNCj4gPiAtCQlpb21hcF9kaW9fc3VibWl0X2JpbyhkaW8sIGlvbWFwLCBiaW8pOw0K
PiA+ICsJCWlvbWFwX2Rpb19zdWJtaXRfYmlvKGRpbywgaW9tYXAsIGJpbywgcG9zKTsNCj4gPiAr
CQlwb3MgKz0gbjsNCj4gPiAgCX0gd2hpbGUgKG5yX3BhZ2VzKTsNCj4gPiAgDQo+ID4gIAkvKg0K
PiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbWFwLmggYi9pbmNsdWRlL2xpbnV4L2lv
bWFwLmgNCj4gPiBpbmRleCA1YjIwNTVlOGNhOGEuLjY2MTdlNGI2ZmI2ZCAxMDA2NDQNCj4gPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L2lvbWFwLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2lvbWFw
LmgNCj4gPiBAQCAtOTIsNiArOTIsNyBAQCBzdHJ1Y3QgaW9tYXBfcGFnZV9vcHMgew0KPiA+ICAJ
CQlzdHJ1Y3QgaW9tYXAgKmlvbWFwKTsNCj4gPiAgCXZvaWQgKCpwYWdlX2RvbmUpKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIGxvZmZfdCBwb3MsDQo+ID4gdW5zaWduZWQgY29waWVkLA0KPiA+ICAJCQlz
dHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IGlvbWFwICppb21hcCk7DQo+ID4gKwlkaW9fc3VibWl0
X3QgCQkqc3VibWl0X2lvOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgLyoNCj4gPiAtLSANCj4gPiAy
LjE2LjQNCj4gPiANCj4gDQo+IA==
