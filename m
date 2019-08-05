Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A99A821A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfHEQZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:25:33 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:44418 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727928AbfHEQZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:25:33 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP;
 Mon,  5 Aug 2019 16:25:25 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 5 Aug 2019 16:08:45 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 5 Aug 2019 16:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj2R/kP8/8QRMztHAUbun/hiVjUmJui2Vqc48eKtlifUcK9aNgEKpaZNH3V/n68UljLYJbt8SNR9Zit/cTGLyFNgNdHvTYoVzcM/wXivKQKbAZmpaBQNyrWMgXOgvwOJGmOZPu3L/gtQ7SNa2XBwjiJkf4vcGhIEtqatcP9elqnCe/sXDyY5MBtm5jkY/2hYLK6GD8FvuJSI30cCGHvEKDrqFGWFTaXPtnCUd0bRmwP6I2tv6QUGeLXWAx6RQ7g/YKhqcQC3BOAgLfrLubOxlOHwE5RUV4uqk4xZGLSd1fWE0S7r4pOuUpOejFYH1HUrGMfaMMp2GvqIOjvQ8ThzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBjGwaatOiV37J0Y7Cbz/jWWfVnb0UB/JbzuErv1B5o=;
 b=FSLcHk8lxhsZ3OdkMPbKkjWMUCKCB4xE3QUc5BMUk3wSPdESv+irGbqmgLfEkeMOau3NOhD+Gi6ax/qdNDVj6YCEmN+jz5sMOSrL0JR8OocDkYQPCa1tcMhuYVz8Zpjm19q/nurQNuctdbpbqsc0bOztuam3+ZKH3HOSF8rVvEztmTrFDspv9exCSxpIqEuk4tdno9Lw6GScX9FO03g6MV11+7YBTQJb6pzscLnjuKLBgPcecaaWqSdokz+QNXwP6ZlGO74uHhQmhtHmmZjRdkalKWaZ7hTtIlQp/PaZ9dqc8d1tSlIG85EfbMyxyEskrarGWRaKFVcusOpOl6HqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from CY4PR1801MB2071.namprd18.prod.outlook.com (10.171.254.163) by
 CY4PR1801MB1992.namprd18.prod.outlook.com (10.171.255.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 16:08:44 +0000
Received: from CY4PR1801MB2071.namprd18.prod.outlook.com
 ([fe80::257a:b502:eda4:e0d5]) by CY4PR1801MB2071.namprd18.prod.outlook.com
 ([fe80::257a:b502:eda4:e0d5%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 16:08:44 +0000
From:   Goldwyn Rodrigues <RGoldwyn@suse.com>
To:     "david@fromorbit.com" <david@fromorbit.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Thread-Topic: [PATCH 10/13] iomap: use a function pointer for dio submits
Thread-Index: AQHVSX3ToXfGcf37hUGaWWpa6tpJG6brqj3ngAES4oA=
Date:   Mon, 5 Aug 2019 16:08:43 +0000
Message-ID: <1565021323.13240.14.camel@suse.com>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
         <20190802220048.16142-11-rgoldwyn@suse.de>
         <20190804234321.GC7689@dread.disaster.area>
In-Reply-To: <20190804234321.GC7689@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RGoldwyn@suse.com; 
x-originating-ip: [75.66.23.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6b7d978-f13d-4e6e-a885-08d719bf308c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR1801MB1992;
x-ms-traffictypediagnostic: CY4PR1801MB1992:
x-microsoft-antispam-prvs: <CY4PR1801MB199284014830CCD12566B586B7DA0@CY4PR1801MB1992.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(6506007)(71190400001)(91956017)(4326008)(229853002)(2906002)(6512007)(76176011)(6486002)(54906003)(305945005)(6436002)(76116006)(80792005)(53936002)(66946007)(66446008)(64756008)(66556008)(66476007)(5640700003)(7736002)(316002)(5660300002)(3846002)(66066001)(26005)(186003)(486006)(102836004)(11346002)(2616005)(476003)(71200400001)(103116003)(256004)(14444005)(446003)(2501003)(6116002)(86362001)(68736007)(36756003)(81166006)(6916009)(81156014)(478600001)(2351001)(1730700003)(14454004)(6246003)(8936002)(25786009)(8676002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1801MB1992;H:CY4PR1801MB2071.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9sV9B5U7pruWyWO4OyfuqmwT42X4Xt5UWtIC+S5TdAypUccH8BDbAEFtkrnHxcsixtqC2gThivv8z/S2y+pQbpoTdh3E+Zy38qz4FUzGdpiPC8mWnjQRDF+v9NJ4+RU+PWKTrvSCfg06GyLEttpwXlAGmcjwcq0u9uhLwb3tvhnmqK/3ehWv5l7HMoKXLi1QZoS+qNIh+CZU067odrZ/5jJ1ZZw5SyBjwGwi4Z+rZqJRcsnJjiwVn2NUTer+I2HPgrtM4Sw6diicxLL5BRArZrcG3SXTZmXKAy7Pbhrz+Vt6zWuUzr/twZBhgrd8tk+QTYcdP1ehU+JeFa6KBnpD0lV+hGSdV7pzdw4f5VkbXMrTg3Vcm/gkilEhqCf8gCAqbyEul9/ML2B+hRd2N3HLAvejb8RXVIJbm2tzfbm5nCo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30D0959B2E9E294A98698ED487730175@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b7d978-f13d-4e6e-a885-08d719bf308c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 16:08:43.9177
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

T24gTW9uLCAyMDE5LTA4LTA1IGF0IDA5OjQzICsxMDAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIEZyaSwgQXVnIDAyLCAyMDE5IGF0IDA1OjAwOjQ1UE0gLTA1MDAsIEdvbGR3eW4gUm9kcmln
dWVzIHdyb3RlOg0KPiA+IEZyb206IEdvbGR3eW4gUm9kcmlndWVzIDxyZ29sZHd5bkBzdXNlLmNv
bT4NCj4gPiANCj4gPiBUaGlzIGhlbHBzIGZpbGVzeXN0ZW1zIHRvIHBlcmZvcm0gdGFza3Mgb24g
dGhlIGJpbyB3aGlsZQ0KPiA+IHN1Ym1pdHRpbmcgZm9yIEkvTy4gU2luY2UgYnRyZnMgcmVxdWly
ZXMgdGhlIHBvc2l0aW9uDQo+ID4gd2UgYXJlIHdvcmtpbmcgb24sIHBhc3MgcG9zIHRvIGlvbWFw
X2Rpb19zdWJtaXRfYmlvKCkNCj4gPiANCj4gPiBUaGUgY29ycmVjdCBwbGFjZSBmb3Igc3VibWl0
X2lvKCkgaXMgbm90IHBhZ2Vfb3BzLiBXb3VsZCBpdA0KPiA+IGJldHRlciB0byByZW5hbWUgdGhl
IHN0cnVjdHVyZSB0byBzb21ldGhpbmcgbGlrZSBpb21hcF9pb19vcHMNCj4gPiBvciBwdXQgaXQg
ZGlyZWN0bHkgdW5kZXIgc3RydWN0IGlvbWFwPw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEdv
bGR3eW4gUm9kcmlndWVzIDxyZ29sZHd5bkBzdXNlLmNvbT4NCj4gPiAtLS0NCj4gPiAgZnMvaW9t
YXAvZGlyZWN0LWlvLmMgIHwgMTYgKysrKysrKysrKystLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4
L2lvbWFwLmggfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZnMvaW9tYXAvZGlyZWN0LWlv
LmMgYi9mcy9pb21hcC9kaXJlY3QtaW8uYw0KPiA+IGluZGV4IDUyNzkwMjljN2EzYy4uYTgwMmU2
NmJmMTFmIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2lvbWFwL2RpcmVjdC1pby5jDQo+ID4gKysrIGIv
ZnMvaW9tYXAvZGlyZWN0LWlvLmMNCj4gPiBAQCAtNTksNyArNTksNyBAQCBpbnQgaW9tYXBfZGlv
X2lvcG9sbChzdHJ1Y3Qga2lvY2IgKmtpb2NiLCBib29sDQo+ID4gc3BpbikNCj4gPiAgRVhQT1JU
X1NZTUJPTF9HUEwoaW9tYXBfZGlvX2lvcG9sbCk7DQo+ID4gIA0KPiA+ICBzdGF0aWMgdm9pZCBp
b21hcF9kaW9fc3VibWl0X2JpbyhzdHJ1Y3QgaW9tYXBfZGlvICpkaW8sIHN0cnVjdA0KPiA+IGlv
bWFwICppb21hcCwNCj4gPiAtCQlzdHJ1Y3QgYmlvICpiaW8pDQo+ID4gKwkJc3RydWN0IGJpbyAq
YmlvLCBsb2ZmX3QgcG9zKQ0KPiA+ICB7DQo+ID4gIAlhdG9taWNfaW5jKCZkaW8tPnJlZik7DQo+
ID4gIA0KPiA+IEBAIC02Nyw3ICs2NywxMyBAQCBzdGF0aWMgdm9pZCBpb21hcF9kaW9fc3VibWl0
X2JpbyhzdHJ1Y3QNCj4gPiBpb21hcF9kaW8gKmRpbywgc3RydWN0IGlvbWFwICppb21hcCwNCj4g
PiAgCQliaW9fc2V0X3BvbGxlZChiaW8sIGRpby0+aW9jYik7DQo+ID4gIA0KPiA+ICAJZGlvLT5z
dWJtaXQubGFzdF9xdWV1ZSA9IGJkZXZfZ2V0X3F1ZXVlKGlvbWFwLT5iZGV2KTsNCj4gPiAtCWRp
by0+c3VibWl0LmNvb2tpZSA9IHN1Ym1pdF9iaW8oYmlvKTsNCj4gPiArCWlmIChpb21hcC0+cGFn
ZV9vcHMgJiYgaW9tYXAtPnBhZ2Vfb3BzLT5zdWJtaXRfaW8pIHsNCj4gPiArCQlpb21hcC0+cGFn
ZV9vcHMtPnN1Ym1pdF9pbyhiaW8sIGZpbGVfaW5vZGUoZGlvLQ0KPiA+ID5pb2NiLT5raV9maWxw
KSwNCj4gPiArCQkJCXBvcyk7DQo+ID4gKwkJZGlvLT5zdWJtaXQuY29va2llID0gQkxLX1FDX1Rf
Tk9ORTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJZGlvLT5zdWJtaXQuY29va2llID0gc3VibWl0
X2JpbyhiaW8pOw0KPiA+ICsJfQ0KPiANCj4gSSBkb24ndCByZWFsbHkgbGlrZSB0aGlzIGF0IGFs
bC4gQXBhcnQgZnJvbSB0aGUgZmFjdCBpdCBkb2Vzbid0IHdvcmsNCj4gd2l0aCBibG9jayBkZXZp
Y2UgcG9sbGluZyAoUldGX0hJUFJJKSwgdGhlIGlvbWFwIGFyY2hpdGVjdHVyZSBpcw0KDQpUaGF0
IGNhbiBiZSBhZGRlZCwgbm8/IFNob3VsZCBiZSByZWxheWVkIHdoZW4gd2UgY2xvbmUgdGhlIGJp
by4NCg0KPiBzdXBwb3NlZCB0byByZXNvbHZlIHRoZSBmaWxlIG9mZnNldCAtPiBibG9jayBkZXZp
Y2UgKyBMQkEgbWFwcGluZw0KPiBjb21wbGV0ZWx5IHVwIGZyb250IGFuZCBzbyBhbGwgdGhhdCBy
ZW1haW5zIHRvIGJlIGRvbmUgaXMgYnVpbGQgYW5kDQo+IHN1Ym1pdCB0aGUgYmlvKHMpIHRvIHRo
ZSBibG9jayBkZXZpY2UuDQo+IA0KPiBXaGF0IEkgc2VlIGhlcmUgaXMgYSBoYWNrIHRvIHdvcmsg
YXJvdW5kIHRoZSBmYWN0IHRoYXQgYnRyZnMgaGFzDQo+IGltcGxlbWVudGVkIGJvdGggZmlsZSBk
YXRhIHRyYW5zZm9ybWF0aW9ucyBhbmQgZGV2aWNlIG1hcHBpbmcgbGF5ZXINCj4gZnVuY3Rpb25h
bGl0eSBhcyBhIGZpbGVzeXN0ZW0gbGF5ZXIgYmV0d2VlbiBmaWxlIGRhdGEgYmlvIGJ1aWxkaW5n
DQo+IGFuZCBkZXZpY2UgYmlvIHN1Ym1pc3Npb24uIEFuZCBhcyB0aGUgYnRyZnMgZmlsZSBkYXRh
IG1hcHBpbmcNCj4gKC0+aW9tYXBfYmVnaW4pIGlzIGNvbXBsZXRlbHkgdW5hd2FyZSB0aGF0IHRo
ZXJlIGlzIGZ1cnRoZXIgYmxvY2sNCj4gbWFwcGluZyB0byBiZSBkb25lIGJlZm9yZSBibG9jayBk
ZXZpY2UgYmlvIHN1Ym1pc3Npb24sIGFueSBnZW5lcmljDQo+IGNvZGUgdGhhdCBidHJmcyB1c2Vz
IHJlcXVpcmVzIHNwZWNpYWwgSU8gc3VibWlzc2lvbiBob29rcyByYXRoZXINCj4gdGhhbiBqdXN0
IGNhbGxpbmcgc3VibWl0X2JpbygpLg0KPiANCj4gSSdtIG5vdCAxMDAlIHN1cmUgd2hhdCB0aGUg
c29sdXRpb24gaGVyZSBpcywgYnV0IHRoZSBvbmUgdGhpbmcgd2UNCj4gbXVzdCByZXNpc3QgaXMg
dHVybmluZyB0aGUgaW9tYXAgY29kZSBpbnRvIGEgbWVzcyBvZiBjdXN0b20gaG9va3MNCj4gdGhh
dCBvbmx5IG9uZSBmaWxlc3lzdGVtIHVzZXMuIFdlJ3ZlIGJlZW4gdGF1Z2h0IHRoaXMgbGVzc29u
IHRpbWUNCj4gYW5kIHRpbWUgYWdhaW4gLSB0aGUgaW9tYXAgaW5mcmFzdHJ1Y3R1cmUgZXhpc3Rz
IGJlY2F1c2Ugc3R1ZmYgbGlrZQ0KPiBidWZmZXJoZWFkcyBhbmQgdGhlIG9sZCBkaXJlY3QgSU8g
Y29kZSBlbmRlZCB1cCBzbyBmdWxsIG9mIHNwZWNpYWwNCj4gY2FzZSBjb2RlIHRoYXQgaXQgb3Nz
aWZpZWQgYW5kIGJlY2FtZSB1bm1vZGlmaWFibGUgYW5kDQo+IHVubWFpbnRhaW5hYmxlLg0KPiAN
Cj4gV2UgZG8gbm90IHdhbnQgdG8gZ28gZG93biB0aGF0IHBhdGggYWdhaW4uIA0KPiANCj4gSU1P
LCB0aGUgaW9tYXAgSU8gbW9kZWwgbmVlZHMgdG8gYmUgcmVzdHJ1Y3R1cmVkIHRvIHN1cHBvcnQg
cG9zdC1JTw0KPiBhbmQgcHJlLUlPIGRhdGEgdmVyaWZpY2F0aW9uL2NhbGN1bGF0aW9uL3RyYW5z
Zm9ybWF0aW9uIG9wZXJhdGlvbnMNCj4gc28gYWxsIHRoZSB3b3JrIHRoYXQgbmVlZHMgdG8gYmUg
ZG9uZSBhdCB0aGUgaW5vZGUvb2Zmc2V0IGNvbnRleHQNCj4gbGV2ZWwgY2FuIGJlIGRvbmUgaW4g
dGhlIGlvbWFwIHBhdGggYmVmb3JlIGJpbyBzdWJtaXNzaW9uL2FmdGVyDQo+IGJpbyBjb21wbGV0
aW9uLiBUaGlzIHdpbGwgYWxsb3cgaW5mcmFzdHJ1Y3R1cmUgbGlrZSBmc2NyeXB0LCBkYXRhDQo+
IGNvbXByZXNzaW9uLCBkYXRhIGNoZWNrc3VtcywgZXRjIHRvIGJlIHN1cG9ydGVkIGdlbmVyaWNh
bGx5LCBub3QNCj4ganVzdCBieSBpbmRpdmlkdWFsIGZpbGVzeXN0ZW1zIHRoYXQgcHJvdmlkZSBh
IC0+c3VibWl0X2lvIGhvb2suDQo+IA0KPiBBcyBmb3IgdGhlIGJ0cmZzIG5lZWRpbmcgdG8gc2xp
Y2UgYW5kIGRpY2UgYmlvcyBmb3IgbXVsdGlwbGUNCj4gZGV2aWNlcz8gIFRoYXQgc2hvdWxkIGJl
IGRvbmUgdmlhIGEgYmxvY2sgZGV2aWNlIC0+bWFrZV9yZXF1ZXN0DQo+IGZ1bmN0aW9uLCBub3Qg
YSBjdXN0b20gaG9vayBpbiB0aGUgaW9tYXAgY29kZS4NCg0KYnRyZnMgZGlmZmVyZW50aWF0ZXMg
dGhlIHdheSBob3cgbWV0YWRhdGEgYW5kIGRhdGEgaXMNCmhhbmRsZWQvcmVwbGljYXRlZC9zdG9y
ZWQuIFdlIHdvdWxkIHN0aWxsIG5lZWQgYW4gZW50cnkgcG9pbnQgaW4gdGhlDQppb21hcCBjb2Rl
IHRvIGhhbmRsZSB0aGUgSS9PIHN1Ym1pc3Npb24uDQoNCj4gDQo+IFRoYXQncyB3aHkgSSBkb24n
dCBsaWtlIHRoaXMgaG9vayAtIEkgdGhpbmsgaGlkaW5nIGRhdGEgb3BlcmF0aW9ucw0KPiBhbmQv
b3IgY3VzdG9tIGJpbyBtYW5pcHVsYXRpb25zIGluIG9wYXF1ZSBmaWxlc3lzdGVtIGNhbGxvdXRz
IGlzDQo+IGNvbXBsZXRlbHkgdGhlIHdyb25nIGFwcHJvYWNoIHRvIGJlIHRha2luZy4gV2UgbmVl
ZCB0byBkbyB0aGVzZQ0KPiB0aGluZ3MgaW4gYSBnZW5lcmljIG1hbm5lciBzbyB0aGF0IGFsbCBm
aWxlc3lzdGVtcyAoYW5kIGJsb2NrDQo+IGRldmljZXMhKSB0aGF0IHVzZSB0aGUgaW9tYXAgaW5m
cmFzdHJ1Y3R1cmUgY2FuIHRha2UgYWR2YW50YWdlIG9mDQo+IHRoZW0sIG5vdCBqdXN0IG9uZSBv
ZiB0aGVtLg0KPiANCj4gUXVpdGUgZnJhbmtseSwgSSBkb24ndCBjYXJlIGlmIGl0IHRha2VzIG1v
cmUgdGltZSBhbmQgd29yayB1cCBmcm9udCwNCj4gSSdtIHRpcmVkIG9mIGV4cGVkaWVudCBoYWNr
cyB0byBtZXJnZSBjb2RlIHF1aWNrbHkgcmVwZWF0ZWRseSBiaXRpbmcNCj4gdXMgb24gdGhlIGFy
c2UgYW5kIHdhc3RpbmcgZmFyIG1vcmUgdGltZSBzb3J0aW5nIG91dCB0aGFuIHdlIHdvdWxkDQo+
IGhhdmUgc3BlbnQgZ2V0dGluZyBpdCByaWdodCBpbiB0aGUgZmlyc3QgcGxhY2UuDQoNClN1cmUu
IEkgYW0gb3BlbiB0byBpZGVhcy4gV2hhdCBhcmUgeW91IHByb3Bvc2luZz8NCg0KLS0gDQpHb2xk
d3lu
